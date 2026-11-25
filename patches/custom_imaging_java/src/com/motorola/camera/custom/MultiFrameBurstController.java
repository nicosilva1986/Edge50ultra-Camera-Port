// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Bounded ZSL RAW ring and burst plan for OV50H binned 4088x3068 RAW10/RAW16.
 *
 * <p>The ring keeps at most 6 frames (8 for super-resolution) and at most
 * 320 MiB (420 MiB for super-resolution). {@code offer} drops the oldest
 * slot's byte[] before reuse. {@code planBurst} always returns a plan and
 * does not throw: an empty ring, an abort, a thermal cutoff, or no sharp
 * anchor sets {@code fallbackReason} and {@code singleRaw}.
 *
 * <p>Smali must copy RAW bytes off the camera callback, then call
 * {@code offer} / {@code noteMetadata}. {@code useSingleFrame} is the
 * CaptureBurstRequestCallable fallback: submit the first request only.
 */
public final class MultiFrameBurstController {
    public static final int MODE_HDR_PLUS = 1;
    public static final int MODE_AEB = 2;
    public static final int MODE_SUPER_RES = 3;
    public static final int MODE_FOCUS_STACK = 4;
    public static final int MODE_SYNTHETIC_ND = 5;

    public static final int OV50H_BINNED_WIDTH = 4088;
    public static final int OV50H_BINNED_HEIGHT = 3068;
    public static final int MAX_FRAMES_STANDARD = 6;
    public static final int MAX_FRAMES_SR = 8;
    public static final long BYTE_CAP_STANDARD = 320L * 1024L * 1024L;
    public static final long BYTE_CAP_SR = 420L * 1024L * 1024L;
    public static final float ANCHOR_MAX_MOTION_PX = 0.75f;
    public static final float MAX_FOCUS_SPREAD_DIOPTERS = 0.15f;
    public static final int LENS_STATE_MOVING = 1;

    private static final class Slot {
        int sessionGeneration;
        String cameraId;
        long timestampNs;
        long exposureNs;
        int iso;
        float focalLengthPx;
        float gyroExcursionRad;
        float focusDistance;
        int afState;
        int lensState;
        long seqId;
        byte[] raw;
        boolean saturated;
        boolean exposureValid;
    }

    public static final class Plan {
        public final int captureMode;
        public final int frameCount;
        public final float[] evOffsets;
        public final float[] focusDistances;
        public final long anchorSeqId;
        public final String fallbackReason;
        public final boolean singleRaw;

        Plan(int captureMode, int frameCount, float[] evOffsets, float[] focusDistances,
                long anchorSeqId, String fallbackReason, boolean singleRaw) {
            this.captureMode = captureMode;
            this.frameCount = frameCount;
            this.evOffsets = evOffsets;
            this.focusDistances = focusDistances;
            this.anchorSeqId = anchorSeqId;
            this.fallbackReason = fallbackReason;
            this.singleRaw = singleRaw;
        }
    }

    private static final Slot[] slots = new Slot[MAX_FRAMES_SR];
    private static final Slot[] pending = new Slot[MAX_FRAMES_SR];
    private static int count;
    private static int pendingCount;
    private static long retained;
    private static int maxFrames = MAX_FRAMES_STANDARD;
    private static long byteCap = BYTE_CAP_STANDARD;
    private static boolean aborted;
    private static String abortReason;
    private static boolean singleFrame;
    private static int plannedFrames = -1;
    private static int activeSessionGeneration;
    private static String activeCameraId;
    private static boolean lastMergeMotionRejected;
    private static float lastMergeFocusSpread = Float.NaN;
    private static float lastMergeGapMs = Float.NaN;

    private MultiFrameBurstController() {}

    public static synchronized int beginSession(String cameraId) {
        activeSessionGeneration++;
        if (activeSessionGeneration <= 0) activeSessionGeneration = 1;
        activeCameraId = cameraId;
        while (count > 0) evictOldest();
        pendingCount = 0;
        for (int i = 0; i < pending.length; i++) pending[i] = null;
        lastMergeMotionRejected = false;
        lastMergeFocusSpread = Float.NaN;
        lastMergeGapMs = Float.NaN;
        return activeSessionGeneration;
    }

    public static synchronized int currentSessionGeneration() {
        return activeSessionGeneration;
    }

    public static synchronized String activeCameraId() {
        return activeCameraId;
    }

    /**
     * Caps the RAW {@code ImageReader} maxImages for Camera2 ids {@code "0"}
     * (OV50H) and {@code "3"} (macro). Other ids keep {@code stockMax}.
     * Values below 1 become 1 so {@code newImageReader} is not asked for an
     * empty queue. This does not raise a smaller stock queue up to 6.
     */
    public static int boundRawMaxImages(String cameraId, String physicalId, int stockMax) {
        return boundRawMaxImages(cameraId, physicalId, null, stockMax);
    }

    /** Same cap, checking the stream id and both id slots passed into checkCreateRawStream. */
    public static int boundRawMaxImages(String cameraId, String secondId, String thirdId, int stockMax) {
        int safe = stockMax < 1 ? 1 : stockMax;
        if (!isBoundedZslCamera(cameraId) && !isBoundedZslCamera(secondId)
                && !isBoundedZslCamera(thirdId)) {
            return safe;
        }
        if (safe > MAX_FRAMES_STANDARD) return MAX_FRAMES_STANDARD;
        return safe;
    }

    /** RAW16 is 2 bytes per pixel. RAW10 is packed 5 bytes per 4 pixels. */
    public static int estimateRawBytes(boolean raw16) {
        long pixels = (long) OV50H_BINNED_WIDTH * (long) OV50H_BINNED_HEIGHT;
        long bytes = raw16 ? pixels * 2L : (pixels * 5L) / 4L;
        if (bytes > Integer.MAX_VALUE) return Integer.MAX_VALUE;
        return (int) bytes;
    }

    public static synchronized void reset() {
        for (int i = 0; i < count; i++) releaseRaw(slots[i]);
        for (int i = 0; i < slots.length; i++) slots[i] = null;
        for (int i = 0; i < pending.length; i++) pending[i] = null;
        count = 0;
        pendingCount = 0;
        retained = 0L;
        aborted = false;
        abortReason = null;
        singleFrame = false;
        plannedFrames = -1;
        maxFrames = MAX_FRAMES_STANDARD;
        byteCap = BYTE_CAP_STANDARD;
        activeSessionGeneration = 0;
        activeCameraId = null;
        lastMergeMotionRejected = false;
        lastMergeFocusSpread = Float.NaN;
        lastMergeGapMs = Float.NaN;
    }

    public static synchronized void configure(int captureMode) {
        if (captureMode == MODE_SUPER_RES) {
            maxFrames = MAX_FRAMES_SR;
            byteCap = BYTE_CAP_SR;
        } else {
            maxFrames = MAX_FRAMES_STANDARD;
            byteCap = BYTE_CAP_STANDARD;
        }
        while (count > maxFrames) evictOldest();
    }

    public static synchronized void abort(String reason) {
        aborted = true;
        if (reason == null || reason.length() == 0) abortReason = "aborted";
        else abortReason = reason;
        while (count > 0) evictOldest();
        pendingCount = 0;
        for (int i = 0; i < pending.length; i++) pending[i] = null;
    }

    /**
     * Stores {@code raw} as the newest frame for {@code seqId}. A repeated
     * seqId refreshes that frame and moves it to the newest slot. Returns
     * false when aborted, {@code raw} is null, or the buffer cannot fit in
     * the byte cap even after eviction.
     */
    public static synchronized boolean offer(long timestampNs, long exposureNs, int iso,
            float focalLengthPx, float gyroExcursionRad, long seqId, byte[] raw,
            boolean saturated, boolean exposureValid) {
        return offerInternal(activeSessionGeneration, null, timestampNs, exposureNs, iso,
                focalLengthPx, gyroExcursionRad, seqId, raw, saturated, exposureValid,
                Float.NaN, 0, 0, true);
    }

    /** Session-strict ZSL RAW ingest joined only by {@code (sessionGeneration, cameraId, timestampNs)}. */
    public static synchronized boolean offerSessionFrame(int sessionGeneration, String cameraId,
            long timestampNs, long exposureNs, int iso, float focalLengthPx,
            float gyroExcursionRad, long seqId, byte[] raw, boolean saturated,
            boolean exposureValid) {
        if (sessionGeneration != activeSessionGeneration) return false;
        if (activeCameraId != null && !activeCameraId.equals(cameraId)) return false;
        if (timestampNs <= 0L) return false;
        return offerInternal(sessionGeneration, cameraId, timestampNs, exposureNs, iso,
                focalLengthPx, gyroExcursionRad, seqId, raw, saturated, exposureValid,
                Float.NaN, 0, 0, false);
    }

    private static boolean offerInternal(int sessionGeneration, String cameraId, long timestampNs,
            long exposureNs, int iso, float focalLengthPx, float gyroExcursionRad, long seqId,
            byte[] raw, boolean saturated, boolean exposureValid, float focusDistance,
            int afState, int lensState, boolean allowSeqReplace) {
        if (aborted || raw == null) return false;
        long need = raw.length;
        if (need > byteCap) return false;
        int existing = allowSeqReplace
                ? findSeq(seqId)
                : findSessionTimestamp(sessionGeneration, cameraId, timestampNs);
        if (existing >= 0) removeAt(existing);
        while (count > 0 && (count >= maxFrames || retained + need > byteCap)) {
            evictOldest();
        }
        if (count >= maxFrames || retained + need > byteCap) return false;
        Slot slot = new Slot();
        fill(slot, sessionGeneration, cameraId, timestampNs, exposureNs, iso, focalLengthPx,
                gyroExcursionRad, seqId, saturated, exposureValid, focusDistance, afState, lensState);
        slot.raw = raw;
        slots[count] = slot;
        count++;
        retained += need;
        overlayPending(slot, !allowSeqReplace);
        return true;
    }

    /** Capture-result metadata. Matches an existing timestamp or seqId, else waits for offer. */
    public static synchronized void noteMetadata(long timestampNs, long exposureNs, int iso,
            float focalLengthPx, float gyroExcursionRad, long seqId, boolean saturated,
            boolean exposureValid) {
        noteMetadataInternal(activeSessionGeneration, null, timestampNs, exposureNs, iso,
                focalLengthPx, gyroExcursionRad, seqId, saturated, exposureValid,
                Float.NaN, 0, 0, true);
    }

    /** Session-strict CaptureResult join on {@code (sessionGeneration, cameraId, timestampNs)}. */
    public static synchronized void noteSessionMetadata(int sessionGeneration, String cameraId,
            long timestampNs, long exposureNs, int iso, float focalLengthPx,
            float gyroExcursionRad, long seqId, boolean saturated, boolean exposureValid,
            float focusDistance, int afState, int lensState) {
        if (sessionGeneration != activeSessionGeneration) return;
        if (activeCameraId != null && !activeCameraId.equals(cameraId)) return;
        if (timestampNs <= 0L) return;
        noteMetadataInternal(sessionGeneration, cameraId, timestampNs, exposureNs, iso,
                focalLengthPx, gyroExcursionRad, seqId, saturated, exposureValid,
                focusDistance, afState, lensState, false);
    }

    private static void noteMetadataInternal(int sessionGeneration, String cameraId, long timestampNs,
            long exposureNs, int iso, float focalLengthPx, float gyroExcursionRad, long seqId,
            boolean saturated, boolean exposureValid, float focusDistance, int afState,
            int lensState, boolean allowSeqFallback) {
        for (int i = 0; i < count; i++) {
            Slot slot = slots[i];
            boolean match = allowSeqFallback
                    ? (slot.timestampNs == timestampNs || slot.seqId == seqId)
                    : (slot.sessionGeneration == sessionGeneration
                            && sameCamera(slot.cameraId, cameraId)
                            && slot.timestampNs == timestampNs);
            if (match) {
                float gyro = gyroExcursionRad < 0f ? slot.gyroExcursionRad : gyroExcursionRad;
                fill(slot, sessionGeneration, cameraId, timestampNs, exposureNs, iso, focalLengthPx,
                        gyro, seqId, saturated, exposureValid, focusDistance, afState, lensState);
                return;
            }
        }
        if (pendingCount == pending.length) {
            for (int i = 1; i < pendingCount; i++) pending[i - 1] = pending[i];
            pendingCount--;
            pending[pendingCount] = null;
        }
        Slot meta = new Slot();
        fill(meta, sessionGeneration, cameraId, timestampNs, exposureNs, iso, focalLengthPx,
                gyroExcursionRad, seqId, saturated, exposureValid, focusDistance, afState, lensState);
        pending[pendingCount] = meta;
        pendingCount++;
    }

    public static synchronized int size() {
        return count;
    }

    public static synchronized long retainedBytes() {
        return retained;
    }

    /** Read-only snapshot entry from the ZSL RAW ring for downstream merge. */
    public static final class BurstFrameSnapshot {
        public final long timestampNs;
        public final long exposureNs;
        public final int iso;
        public final float focalLengthPx;
        public final float gyroExcursionRad;
        public final float focusDistance;
        public final int afState;
        public final int lensState;
        public final int sessionGeneration;
        public final String cameraId;
        public final byte[] raw;

        BurstFrameSnapshot(long timestampNs, long exposureNs, int iso,
                float focalLengthPx, float gyroExcursionRad, float focusDistance,
                int afState, int lensState, int sessionGeneration, String cameraId, byte[] raw) {
            this.timestampNs = timestampNs;
            this.exposureNs = exposureNs;
            this.iso = iso;
            this.focalLengthPx = focalLengthPx;
            this.gyroExcursionRad = gyroExcursionRad;
            this.focusDistance = focusDistance;
            this.afState = afState;
            this.lensState = lensState;
            this.sessionGeneration = sessionGeneration;
            this.cameraId = cameraId;
            this.raw = raw;
        }
    }

    /** Returns up to {@code maxFramesOut} buffered frames matching the byte length bounds cleanly. */
    public static synchronized BurstFrameSnapshot[] snapshotMatchingFrames(
            int minBytes, int maxBytes, int maxFramesOut) {
        return snapshotMatchingFrames(null, activeSessionGeneration, minBytes, maxBytes, maxFramesOut, false);
    }

    /** Session- and camera-scoped snapshot preserving join identity. */
    public static synchronized BurstFrameSnapshot[] snapshotSessionFrames(
            String cameraId, int minBytes, int maxBytes, int maxFramesOut) {
        return snapshotMatchingFrames(cameraId, activeSessionGeneration, minBytes, maxBytes, maxFramesOut, true);
    }

    private static BurstFrameSnapshot[] snapshotMatchingFrames(
            String cameraId, int sessionGeneration, int minBytes, int maxBytes,
            int maxFramesOut, boolean strictSession) {
        if (count == 0 || maxFramesOut <= 0) return new BurstFrameSnapshot[0];
        java.util.ArrayList<BurstFrameSnapshot> list = new java.util.ArrayList<>(Math.min(count, maxFramesOut));
        for (int i = count - 1; i >= 0 && list.size() < maxFramesOut; i--) {
            Slot s = slots[i];
            if (s == null || s.raw == null || s.saturated) continue;
            if (strictSession) {
                if (s.sessionGeneration != sessionGeneration) continue;
                if (cameraId != null && !cameraId.equals(s.cameraId)) continue;
            }
            if (s.raw.length < minBytes || s.raw.length > maxBytes) continue;
            list.add(new BurstFrameSnapshot(
                    s.timestampNs, s.exposureNs, s.iso, s.focalLengthPx, s.gyroExcursionRad,
                    s.focusDistance, s.afState, s.lensState, s.sessionGeneration, s.cameraId, s.raw));
        }
        java.util.Collections.reverse(list);
        return list.toArray(new BurstFrameSnapshot[0]);
    }

    /** Computes focus spread (diopters) across finite buffered focus readings. */
    public static float computeFocusSpreadDiopters(BurstFrameSnapshot[] frames, float anchorFocusDistance) {
        float minD = Float.POSITIVE_INFINITY;
        float maxD = Float.NEGATIVE_INFINITY;
        int valid = 0;
        if (Float.isFinite(anchorFocusDistance) && anchorFocusDistance >= 0f) {
            minD = anchorFocusDistance;
            maxD = anchorFocusDistance;
            valid = 1;
        }
        if (frames != null) {
            for (BurstFrameSnapshot f : frames) {
                if (f != null && Float.isFinite(f.focusDistance) && f.focusDistance >= 0f) {
                    if (f.focusDistance < minD) minD = f.focusDistance;
                    if (f.focusDistance > maxD) maxD = f.focusDistance;
                    valid++;
                }
            }
        }
        return valid >= 2 ? (maxD - minD) : Float.NaN;
    }

    public static boolean hasFocusDriftOrMotion(BurstFrameSnapshot[] frames, float anchorFocusDistance,
                                                int anchorLensState, float anchorMotionPx,
                                                boolean allowFocusStack) {
        if (Float.isFinite(anchorMotionPx) && anchorMotionPx >= ANCHOR_MAX_MOTION_PX) {
            return true;
        }
        if (allowFocusStack) {
            return false;
        }
        if (anchorLensState == LENS_STATE_MOVING) {
            return true;
        }
        if (frames != null) {
            for (BurstFrameSnapshot f : frames) {
                if (f != null && f.lensState == LENS_STATE_MOVING) {
                    return true;
                }
            }
        }
        float spread = computeFocusSpreadDiopters(frames, anchorFocusDistance);
        return Float.isFinite(spread) && spread > MAX_FOCUS_SPREAD_DIOPTERS;
    }

    public static synchronized void recordMergeDiagnostics(boolean motionRejected, float focusSpreadD, float gapMs) {
        lastMergeMotionRejected = motionRejected;
        lastMergeFocusSpread = focusSpreadD;
        lastMergeGapMs = gapMs;
    }

    public static synchronized boolean wasLastMergeMotionRejected() {
        return lastMergeMotionRejected;
    }

    public static synchronized float latestMergeFocusSpread() {
        return lastMergeFocusSpread;
    }

    public static synchronized float latestMergeGapMs() {
        return lastMergeGapMs;
    }

    public static synchronized long oldestSeqId() {
        if (count == 0) return -1L;
        return slots[0].seqId;
    }

    public static synchronized String seqIds() {
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < count; i++) {
            if (i > 0) out.append(',');
            out.append(slots[i].seqId);
        }
        return out.toString();
    }

    public static synchronized boolean useSingleFrame() {
        return singleFrame;
    }

    public static synchronized int plannedFrameCount() {
        return plannedFrames;
    }

    public static synchronized Plan planBurst(int captureMode, float luxIdx, float evCompRange,
            int thermalLevel, boolean isFrontCamera, boolean isMacroCamera) {
        int base = baseCount(captureMode, luxIdx, isFrontCamera);
        if (base < 0) {
            return finish(captureMode, 1, zeros(1), new float[0], selectAnchor(), "mode");
        }
        configure(captureMode);
        if (thermalLevel >= 4) {
            return finish(captureMode, 1, zeros(1), new float[0], selectAnchor(), "thermal-cutoff");
        }
        if (aborted) {
            String reason = abortReason == null ? "aborted" : abortReason;
            return finish(captureMode, 1, zeros(1), new float[0], -1L, reason);
        }
        if (count == 0) {
            return finish(captureMode, 1, zeros(1), new float[0], -1L, "empty");
        }
        long anchor = selectAnchor();
        if (anchor < 0L) {
            return finish(captureMode, 1, zeros(1), new float[0], -1L, "no-anchor");
        }
        int frames = thermalLevel >= 2 ? stepped(captureMode, base) : base;
        float[] ev = exposureOffsets(captureMode, frames, evCompRange);
        float[] focus = focusFor(captureMode, frames, isMacroCamera);
        return finish(captureMode, frames, ev, focus, anchor, null);
    }

    private static Plan finish(int mode, int frames, float[] ev, float[] focus, long anchor,
            String reason) {
        singleFrame = reason != null;
        plannedFrames = frames;
        return new Plan(mode, frames, ev, focus, anchor, reason, reason != null);
    }

    private static int baseCount(int mode, float luxIdx, boolean front) {
        if (mode == MODE_HDR_PLUS) {
            int hdr = luxIdx >= 300f ? 6 : luxIdx >= 150f ? 5 : 4;
            if (front && hdr > 4) hdr = 4;
            return hdr;
        }
        if (mode == MODE_AEB) return 3;
        if (mode == MODE_SUPER_RES) return (!front && luxIdx >= 200f) ? 8 : 6;
        if (mode == MODE_FOCUS_STACK) return 5;
        if (mode == MODE_SYNTHETIC_ND) return 6;
        return -1;
    }

    private static int stepped(int mode, int base) {
        int floor = 1;
        if (mode == MODE_AEB) floor = 3;
        else if (mode == MODE_HDR_PLUS) floor = 4;
        else if (mode == MODE_SUPER_RES) floor = 6;
        else if (mode == MODE_FOCUS_STACK) floor = 3;
        else if (mode == MODE_SYNTHETIC_ND) floor = 4;
        int next = base - 2;
        return next < floor ? floor : next;
    }

    private static float[] exposureOffsets(int mode, int frames, float evCompRange) {
        float[] ev = new float[frames];
        if (mode == MODE_AEB && frames == 3) {
            ev[0] = -2f;
            ev[1] = 0f;
            ev[2] = 2f;
            return ev;
        }
        if (mode == MODE_HDR_PLUS && frames > 1 && evCompRange > 0f) {
            float span = (float) (frames - 1);
            for (int i = 0; i < frames; i++) {
                ev[i] = ((i / span) - 0.5f) * evCompRange;
            }
        }
        return ev;
    }

    private static float[] focusFor(int mode, int frames, boolean macro) {
        if (mode != MODE_FOCUS_STACK || frames <= 0) return new float[0];
        float[] full = macro
                ? new float[] {2f, 4f, 6f, 8f, 10f}
                : new float[] {0.5f, 1f, 2f, 4f, 8f};
        if (frames == full.length) {
            float[] copy = new float[full.length];
            for (int i = 0; i < full.length; i++) copy[i] = full[i];
            return copy;
        }
        float[] out = new float[frames];
        if (frames == 1) {
            out[0] = full[0];
            return out;
        }
        int last = full.length - 1;
        int denom = frames - 1;
        for (int i = 0; i < frames; i++) {
            int idx = (i * last + denom / 2) / denom;
            if (idx > last) idx = last;
            out[i] = full[idx];
        }
        return out;
    }

    private static float[] zeros(int n) {
        return new float[n];
    }

    private static long selectAnchor() {
        long bestSeq = -1L;
        float bestMotion = Float.POSITIVE_INFINITY;
        long bestTs = Long.MIN_VALUE;
        for (int i = 0; i < count; i++) {
            Slot slot = slots[i];
            if (slot == null || slot.saturated || !slot.exposureValid) continue;
            if (slot.exposureNs <= 0L || slot.iso <= 0) continue;
            if (slot.focalLengthPx <= 0f || slot.gyroExcursionRad < 0f) continue;
            float motion = slot.gyroExcursionRad * slot.focalLengthPx;
            if (!(motion < ANCHOR_MAX_MOTION_PX)) continue;
            if (motion < bestMotion || (motion == bestMotion && slot.timestampNs > bestTs)) {
                bestMotion = motion;
                bestTs = slot.timestampNs;
                bestSeq = slot.seqId;
            }
        }
        return bestSeq;
    }

    private static void fill(Slot slot, int sessionGeneration, String cameraId, long timestampNs,
            long exposureNs, int iso, float focalLengthPx, float gyroExcursionRad, long seqId,
            boolean saturated, boolean exposureValid, float focusDistance, int afState, int lensState) {
        slot.sessionGeneration = sessionGeneration;
        slot.cameraId = cameraId;
        slot.timestampNs = timestampNs;
        slot.exposureNs = exposureNs;
        slot.iso = iso;
        slot.focalLengthPx = focalLengthPx;
        slot.gyroExcursionRad = gyroExcursionRad;
        slot.focusDistance = focusDistance;
        slot.afState = afState;
        slot.lensState = lensState;
        slot.seqId = seqId;
        slot.saturated = saturated;
        slot.exposureValid = exposureValid;
    }

    private static void overlayPending(Slot slot, boolean strictSession) {
        for (int i = 0; i < pendingCount; i++) {
            Slot meta = pending[i];
            boolean match = strictSession
                    ? (meta.sessionGeneration == slot.sessionGeneration
                            && sameCamera(meta.cameraId, slot.cameraId)
                            && meta.timestampNs == slot.timestampNs)
                    : (meta.timestampNs == slot.timestampNs || meta.seqId == slot.seqId);
            if (!match) continue;
            if (!slot.exposureValid && meta.exposureValid) {
                byte[] kept = slot.raw;
                float gyro = meta.gyroExcursionRad < 0f ? slot.gyroExcursionRad : meta.gyroExcursionRad;
                fill(slot, meta.sessionGeneration, meta.cameraId, meta.timestampNs, meta.exposureNs,
                        meta.iso, meta.focalLengthPx, gyro, meta.seqId, meta.saturated, true,
                        meta.focusDistance, meta.afState, meta.lensState);
                slot.raw = kept;
            }
            for (int j = i + 1; j < pendingCount; j++) pending[j - 1] = pending[j];
            pendingCount--;
            pending[pendingCount] = null;
            return;
        }
    }

    private static int findSessionTimestamp(int sessionGeneration, String cameraId, long timestampNs) {
        for (int i = 0; i < count; i++) {
            Slot s = slots[i];
            if (s.sessionGeneration == sessionGeneration
                    && sameCamera(s.cameraId, cameraId)
                    && s.timestampNs == timestampNs) {
                return i;
            }
        }
        return -1;
    }

    private static boolean sameCamera(String a, String b) {
        return a == null ? b == null : a.equals(b);
    }

    private static int findSeq(long seqId) {
        for (int i = 0; i < count; i++) {
            if (slots[i].seqId == seqId) return i;
        }
        return -1;
    }

    private static void removeAt(int index) {
        releaseRaw(slots[index]);
        for (int i = index + 1; i < count; i++) slots[i - 1] = slots[i];
        count--;
        slots[count] = null;
    }

    private static void evictOldest() {
        if (count == 0) return;
        removeAt(0);
    }

    private static boolean isBoundedZslCamera(String cameraId) {
        return "0".equals(cameraId) || "3".equals(cameraId);
    }

    private static void releaseRaw(Slot slot) {
        if (slot != null && slot.raw != null) {
            retained -= slot.raw.length;
            slot.raw = null;
        }
    }
}
