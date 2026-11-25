// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Bitrate, HDR10, high-speed range, and thermal decisions for the video encoder.
 * Integer fps scale is {@code max(1, upperFps / 30)}, so 31–59 fps stays on the
 * 30 fps rate and 60–89 fps doubles it. Caps sit under the pineapple XML limits
 * (AVC 105 Mbps, HEVC 73.5 Mbps).
 */
public final class VideoConfigHelper {
    public static final int HEVC_MAX_BITRATE = 70_000_000;
    public static final int AVC_MAX_BITRATE = 100_000_000;
    public static final int EDGE_OFF = 0;
    public static final int NR_FAST = 1;
    public static final int NR_HIGH_QUALITY = 2;
    public static final int AWB_LOCK_HOLD_FRAMES = 3;

    private static final Object AWB_LOCK = new Object();
    private static String lastVideoPhysicalId;
    private static int awbHoldFramesRemaining;
    private static boolean awbUnlockPending;
    private static volatile int latestAeUpperFps;

    private VideoConfigHelper() {}

    public static int resolveVideoEdgeMode() {
        return EDGE_OFF;
    }

    public static int resolveVideoNoiseReductionMode(int upperFps) {
        // Camera2 allows NR_HIGH_QUALITY (2) to drop frame rate below target at >= 60 fps.
        return upperFps >= 60 ? NR_FAST : NR_HIGH_QUALITY;
    }

    /**
     * Chooses the tightest supported AE FPS range matching {@code targetUpperFps}.
     * Fixed {@code [target, target]} beats variable ranges unless {@code allowVariableLowLight} is requested.
     */
    public static int[] resolveVideoAeRange(int targetUpperFps, int[][] availableRanges,
                                            boolean allowVariableLowLight) {
        if (targetUpperFps <= 0 || availableRanges == null) {
            return null;
        }
        int[] exact = null;
        int[] bestVariable = null;
        for (int i = 0; i < availableRanges.length; i++) {
            int[] range = availableRanges[i];
            if (range == null || range.length < 2 || range[0] <= 0 || range[0] > range[1]) continue;
            if (range[1] != targetUpperFps) continue;
            if (range[0] == targetUpperFps) {
                exact = new int[] { targetUpperFps, targetUpperFps };
            } else if (bestVariable == null || range[0] > bestVariable[0]) {
                bestVariable = new int[] { range[0], range[1] };
            }
        }
        if (allowVariableLowLight) {
            return bestVariable != null ? bestVariable : exact;
        }
        return exact != null ? exact : bestVariable;
    }

    /**
     * Enables HAL OIS only on single-camera streams where it is supported and not explicitly forced OFF (0).
     */
    public static boolean shouldSetVideoOis(int[] availableModes, Integer currentMode, boolean isDualCapture) {
        if (isDualCapture || availableModes == null) {
            return false;
        }
        if (currentMode != null && currentMode.intValue() == 0) {
            return false;
        }
        for (int mode : availableModes) {
            if (mode == 1) {
                return true;
            }
        }
        return false;
    }

    public static void resetAwbSwitchTracker() {
        synchronized (AWB_LOCK) {
            lastVideoPhysicalId = null;
            awbHoldFramesRemaining = 0;
            awbUnlockPending = false;
        }
    }

    public static void onVideoFramePhysicalCamera(String activePhysicalId) {
        if (activePhysicalId == null || activePhysicalId.isEmpty()) {
            return;
        }
        synchronized (AWB_LOCK) {
            if (lastVideoPhysicalId == null) {
                lastVideoPhysicalId = activePhysicalId;
                return;
            }
            if (!lastVideoPhysicalId.equals(activePhysicalId)) {
                lastVideoPhysicalId = activePhysicalId;
                awbHoldFramesRemaining = AWB_LOCK_HOLD_FRAMES;
                awbUnlockPending = false;
            }
        }
    }

    /**
     * Returns {@code Boolean.TRUE} for {@link #AWB_LOCK_HOLD_FRAMES} frames after a lens switch,
     * {@code Boolean.FALSE} once to release our lock, and {@code null} otherwise.
     */
    public static Boolean nextVideoAwbLockOverride() {
        synchronized (AWB_LOCK) {
            if (awbHoldFramesRemaining > 0) {
                awbHoldFramesRemaining--;
                if (awbHoldFramesRemaining == 0) {
                    awbUnlockPending = true;
                }
                return Boolean.TRUE;
            }
            if (awbUnlockPending) {
                awbUnlockPending = false;
                return Boolean.FALSE;
            }
            return null;
        }
    }

    public static void noteResolvedVideoFps(int upperFps) {
        if (upperFps > 0) {
            latestAeUpperFps = upperFps;
        }
    }

    public static int latestVideoAeUpperFps() {
        return latestAeUpperFps;
    }

    public static int resolveVideoBitrate(int sizeBitrate, int upperFps, boolean isHevc) {
        if (sizeBitrate <= 0) return 0;
        int scale = upperFps / 30;
        if (scale < 1) scale = 1;
        long scaled = (long) sizeBitrate * (long) scale;
        int cap = isHevc ? HEVC_MAX_BITRATE : AVC_MAX_BITRATE;
        if (scaled > cap) return cap;
        return (int) scaled;
    }

    public static boolean shouldDisableHdr10ForFps(int upperFps) {
        return upperFps >= 60;
    }

    /**
     * Prefers a fixed {@code [targetFps, targetFps]} row. Otherwise returns the
     * first variable row whose upper bound is {@code targetFps}. Returns null
     * when no row matches.
     */
    public static int[] pickPreferredHfrRange(int targetFps, int[][] ranges) {
        if (ranges == null) return null;
        int[] variable = null;
        for (int i = 0; i < ranges.length; i++) {
            int[] range = ranges[i];
            if (range == null || range.length < 2 || range[0] > range[1]) continue;
            if (range[0] == targetFps && range[1] == targetFps) {
                return new int[] { targetFps, targetFps };
            }
            if (variable == null && range[1] == targetFps && range[0] < targetFps) {
                variable = new int[] { range[0], range[1] };
            }
        }
        return variable;
    }

    public static boolean shouldThermalStepDownFps(int thermalLevel, int upperFps) {
        return thermalLevel >= 2 && upperFps > 30;
    }
}
