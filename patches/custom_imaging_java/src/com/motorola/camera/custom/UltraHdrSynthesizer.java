// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.graphics.Bitmap;
import android.graphics.ColorSpace;
import android.graphics.Gainmap;
import java.nio.ByteBuffer;

/**
 * Clean-room ISO 21496-1 / Android 14-17 Ultra HDR Gainmap synthesizer and Display P3 helper.
 *
 * <p>Bypasses {@code McfUltraHDRWrapper} (which segfaults on {@code HAL_FRAME_STACK} non-RAW paths)
 * by attaching a framework {@link Gainmap} directly to {@link Bitmap} so Android's native
 * {@code libhwui -> libultrahdr} compressor emits valid MPF + {@code hdrgm} JPEG/R across all lenses
 * ({@code 0.5x} UW, {@code 1x/2x} Main, {@code 3x/6x} Tele {@code OV64B}, Front, and {@code CleanRAW}).
 */
public final class UltraHdrSynthesizer {
    public static final float EPSILON = 1.0f / 64.0f;
    public static final float MIN_MEANINGFUL_HEADROOM = 1.06f;
    public static final float MAX_ALLOWED_HEADROOM = 8.0f;
    public static final float DEFAULT_SDR_SHOULDER_HEADROOM = 2.85f;

    private static final float[] SRGB_TO_LIN = new float[256];

    static {
        for (int i = 0; i < 256; i++) {
            double s = i / 255.0;
            SRGB_TO_LIN[i] = (float) (s <= 0.04045 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4));
        }
    }

    private UltraHdrSynthesizer() {}

    public static final class PlaneResult {
        public final byte[] gainBytes;
        public final int width;
        public final int height;
        public final float ratioMin;
        public final float ratioMax;
        public final float gamma;
        public final float epsilonSdr;
        public final float epsilonHdr;

        PlaneResult(byte[] gainBytes, int width, int height, float ratioMin, float ratioMax,
                    float gamma, float epsilonSdr, float epsilonHdr) {
            this.gainBytes = gainBytes;
            this.width = width;
            this.height = height;
            this.ratioMin = ratioMin;
            this.ratioMax = ratioMax;
            this.gamma = gamma;
            this.epsilonSdr = epsilonSdr;
            this.epsilonHdr = epsilonHdr;
        }
    }

    /**
     * Builds a 1/4-resolution single-channel log2 gainmap plane from linear HDR peak luminance
     * vs post-tonemap SDR ARGB pixels. Returns {@code null} when peak headroom is negligible.
     */
    public static PlaneResult computeFromLinearAndSdr(float[] linearPeak, int[] sdrArgb,
                                                      int width, int height, float maxHeadroomCap) {
        if (linearPeak == null || sdrArgb == null || width < 4 || height < 4) return null;
        int count = width * height;
        if (linearPeak.length < count || sdrArgb.length < count) return null;

        int gw = Math.max(1, (width + 3) / 4);
        int gh = Math.max(1, (height + 3) / 4);
        float[] ratios = new float[gw * gh];
        float cap = Math.max(1.10f, Math.min(MAX_ALLOWED_HEADROOM,
                Float.isFinite(maxHeadroomCap) ? maxHeadroomCap : DEFAULT_SDR_SHOULDER_HEADROOM));
        float observedMax = 1.0f;
        int boostedCells = 0;

        for (int gy = 0; gy < gh; gy++) {
            int y0 = gy * 4;
            int y1 = Math.min(height, y0 + 4);
            for (int gx = 0; gx < gw; gx++) {
                int x0 = gx * 4;
                int x1 = Math.min(width, x0 + 4);
                float cellMaxRatio = 1.0f;
                float cellSumRatio = 0f;
                int n = 0;
                for (int y = y0; y < y1; y++) {
                    int row = y * width;
                    for (int x = x0; x < x1; x++) {
                        int idx = row + x;
                        float hdr = linearPeak[idx];
                        if (!Float.isFinite(hdr) || hdr <= 0f) hdr = 0f;
                        int px = sdrArgb[idx];
                        int r8 = (px >>> 16) & 255;
                        int g8 = (px >>> 8) & 255;
                        int b8 = px & 255;
                        int peak8 = Math.max(r8, Math.max(g8, b8));
                        float sdr = SRGB_TO_LIN[peak8];
                        float r = (hdr + EPSILON) / (sdr + EPSILON);
                        if (r < 1.0f) r = 1.0f;
                        if (r > cap) r = cap;
                        if (r > cellMaxRatio) cellMaxRatio = r;
                        cellSumRatio += r;
                        n++;
                    }
                }
                float meanRatio = n > 0 ? (cellSumRatio / n) : 1.0f;
                // Blend 65% local mean + 35% local peak to preserve crisp speculars without blockiness.
                float cellRatio = 0.65f * meanRatio + 0.35f * cellMaxRatio;
                ratios[gy * gw + gx] = cellRatio;
                if (cellRatio > observedMax) observedMax = cellRatio;
                if (cellRatio >= MIN_MEANINGFUL_HEADROOM) boostedCells++;
            }
        }

        if (observedMax < MIN_MEANINGFUL_HEADROOM || boostedCells == 0) {
            return null;
        }
        return encodeLog2Plane(ratios, gw, gh, observedMax);
    }

    /**
     * Synthesizes a smooth highlight-recovery gainmap plane directly from pre-grade SDR pixels vs
     * post-shoulder/LTM SDR pixels when HAL omits an Ultra HDR gainmap (e.g. {@code HAL_FRAME_STACK}
     * on {@code 0.5x}, {@code 1x}, {@code 3x/6x}).
     */
    public static PlaneResult computeFromPreAndPostSdr(int[] preGradeArgb, int[] postGradeArgb,
                                                       int width, int height, float targetPeakHeadroom) {
        if (preGradeArgb == null || postGradeArgb == null || width < 4 || height < 4) return null;
        int count = width * height;
        if (preGradeArgb.length < count || postGradeArgb.length < count) return null;

        int gw = Math.max(1, (width + 3) / 4);
        int gh = Math.max(1, (height + 3) / 4);
        float[] ratios = new float[gw * gh];
        float cap = Math.max(1.25f, Math.min(4.0f,
                Float.isFinite(targetPeakHeadroom) ? targetPeakHeadroom : DEFAULT_SDR_SHOULDER_HEADROOM));
        float observedMax = 1.0f;
        int boostedCells = 0;

        for (int gy = 0; gy < gh; gy++) {
            int y0 = gy * 4;
            int y1 = Math.min(height, y0 + 4);
            for (int gx = 0; gx < gw; gx++) {
                int x0 = gx * 4;
                int x1 = Math.min(width, x0 + 4);
                float sumRatio = 0f;
                float peakRatio = 1.0f;
                int n = 0;
                for (int y = y0; y < y1; y++) {
                    int row = y * width;
                    for (int x = x0; x < x1; x++) {
                        int idx = row + x;
                        int pre = preGradeArgb[idx];
                        int post = postGradeArgb[idx];
                        int prePeak8 = Math.max((pre >>> 16) & 255, Math.max((pre >>> 8) & 255, pre & 255));
                        int postPeak8 = Math.max((post >>> 16) & 255, Math.max((post >>> 8) & 255, post & 255));
                        float preLin = SRGB_TO_LIN[prePeak8];
                        float postLin = SRGB_TO_LIN[postPeak8];
                        // Recover compressed shoulder energy + smooth high-luminance specular expansion above Y>=204.
                        float highlightRamp = prePeak8 <= 204 ? 0f : (prePeak8 - 204) / 51.0f;
                        float smoothRamp = highlightRamp * highlightRamp * (3.0f - 2.0f * highlightRamp);
                        float hdrTargetLin = Math.max(preLin, preLin * (1.0f + (cap - 1.0f) * smoothRamp));
                        float r = (hdrTargetLin + EPSILON) / (postLin + EPSILON);
                        if (r < 1.0f) r = 1.0f;
                        if (r > cap) r = cap;
                        sumRatio += r;
                        if (r > peakRatio) peakRatio = r;
                        n++;
                    }
                }
                float cell = n > 0 ? (0.70f * (sumRatio / n) + 0.30f * peakRatio) : 1.0f;
                ratios[gy * gw + gx] = cell;
                if (cell > observedMax) observedMax = cell;
                if (cell >= MIN_MEANINGFUL_HEADROOM) boostedCells++;
            }
        }

        // Require at least 0.2% of cells to carry meaningful HDR boost so dark indoor shots stay plain SDR.
        int minCells = Math.max(1, (gw * gh) / 500);
        if (observedMax < MIN_MEANINGFUL_HEADROOM || boostedCells < minCells) {
            return null;
        }
        return encodeLog2Plane(ratios, gw, gh, observedMax);
    }

    /**
     * Streams a Bitmap in 4-row strips (zero full-frame int[] allocation) and records packed
     * [meanPeak8, maxPeak8] pairs per 4x4 cell for low-memory Ultra HDR synthesis on 12.5MP-50MP shots.
     */
    public static byte[] sampleQuarterPeakStats(Bitmap bmp) {
        if (bmp == null) return null;
        int width = bmp.getWidth();
        int height = bmp.getHeight();
        if (width < 4 || height < 4) return null;
        int gw = Math.max(1, (width + 3) / 4);
        int gh = Math.max(1, (height + 3) / 4);
        byte[] stats = new byte[gw * gh * 2];
        int[] strip = new int[width * 4];
        for (int gy = 0; gy < gh; gy++) {
            int y0 = gy * 4;
            int rows = Math.min(4, height - y0);
            bmp.getPixels(strip, 0, width, 0, y0, width, rows);
            for (int gx = 0; gx < gw; gx++) {
                int x0 = gx * 4;
                int cols = Math.min(4, width - x0);
                int sum = 0;
                int max = 0;
                int n = 0;
                for (int r = 0; r < rows; r++) {
                    int base = r * width + x0;
                    for (int c = 0; c < cols; c++) {
                        int px = strip[base + c];
                        int pk = Math.max((px >>> 16) & 255, Math.max((px >>> 8) & 255, px & 255));
                        sum += pk;
                        if (pk > max) max = pk;
                        n++;
                    }
                }
                int idx = (gy * gw + gx) * 2;
                stats[idx] = (byte) (n > 0 ? (sum + (n >> 1)) / n : 0);
                stats[idx + 1] = (byte) max;
            }
        }
        return stats;
    }

    /** Synthesizes a 1/4-res log2 gainmap from pre/post {@link #sampleQuarterPeakStats(Bitmap)} buffers. */
    public static PlaneResult computeFromQuarterPeakStats(byte[] preStats, byte[] postStats,
                                                          int width, int height, float targetPeakHeadroom) {
        if (preStats == null || postStats == null || width < 4 || height < 4) return null;
        int gw = Math.max(1, (width + 3) / 4);
        int gh = Math.max(1, (height + 3) / 4);
        int cells = gw * gh;
        if (preStats.length < cells * 2 || postStats.length < cells * 2) return null;
        float[] ratios = new float[cells];
        float cap = Math.max(1.25f, Math.min(4.0f,
                Float.isFinite(targetPeakHeadroom) ? targetPeakHeadroom : DEFAULT_SDR_SHOULDER_HEADROOM));
        float observedMax = 1.0f;
        int boostedCells = 0;
        for (int i = 0; i < cells; i++) {
            int preMean8 = preStats[i * 2] & 255;
            int preMax8 = preStats[i * 2 + 1] & 255;
            int postMean8 = postStats[i * 2] & 255;
            int postMax8 = postStats[i * 2 + 1] & 255;

            float rMean = cellHighlightRatio(preMean8, postMean8, cap);
            float rPeak = cellHighlightRatio(preMax8, postMax8, cap);
            float cell = 0.70f * rMean + 0.30f * rPeak;
            ratios[i] = cell;
            if (cell > observedMax) observedMax = cell;
            if (cell >= MIN_MEANINGFUL_HEADROOM) boostedCells++;
        }
        int minCells = Math.max(1, cells / 500);
        if (observedMax < MIN_MEANINGFUL_HEADROOM || boostedCells < minCells) {
            return null;
        }
        return encodeLog2Plane(ratios, gw, gh, observedMax);
    }

    private static float cellHighlightRatio(int prePeak8, int postPeak8, float cap) {
        float preLin = SRGB_TO_LIN[prePeak8];
        float postLin = SRGB_TO_LIN[postPeak8];
        float highlightRamp = prePeak8 <= 204 ? 0f : (prePeak8 - 204) / 51.0f;
        float smoothRamp = highlightRamp * highlightRamp * (3.0f - 2.0f * highlightRamp);
        float hdrTargetLin = Math.max(preLin, preLin * (1.0f + (cap - 1.0f) * smoothRamp));
        float r = (hdrTargetLin + EPSILON) / (postLin + EPSILON);
        return Math.max(1.0f, Math.min(cap, r));
    }

    private static PlaneResult encodeLog2Plane(float[] ratios, int gw, int gh, float ratioMax) {
        // Light 3x3 box-tent smoothing on the 1/4 grid prevents 8-bit JPEG mosquito ringing in the gainmap.
        float[] smoothed = smoothGrid3x3(ratios, gw, gh);
        double logMax = Math.log(ratioMax);
        if (!(logMax > 1e-5)) return null;
        byte[] bytes = new byte[gw * gh];
        for (int i = 0; i < smoothed.length; i++) {
            float r = Math.max(1.0f, Math.min(ratioMax, smoothed[i]));
            double norm = Math.log(r) / logMax;
            int q = (int) Math.round(Math.max(0.0, Math.min(1.0, norm)) * 255.0);
            bytes[i] = (byte) q;
        }
        return new PlaneResult(bytes, gw, gh, 1.0f, ratioMax, 1.0f, EPSILON, EPSILON);
    }

    private static float[] smoothGrid3x3(float[] src, int gw, int gh) {
        if (gw < 3 || gh < 3) return src;
        float[] tmp = new float[src.length];
        float[] out = new float[src.length];
        for (int y = 0; y < gh; y++) {
            int row = y * gw;
            for (int x = 0; x < gw; x++) {
                float xm = src[row + Math.max(0, x - 1)];
                float xc = src[row + x];
                float xp = src[row + Math.min(gw - 1, x + 1)];
                tmp[row + x] = 0.25f * xm + 0.50f * xc + 0.25f * xp;
            }
        }
        for (int y = 0; y < gh; y++) {
            int ym = Math.max(0, y - 1) * gw;
            int yc = y * gw;
            int yp = Math.min(gh - 1, y + 1) * gw;
            for (int x = 0; x < gw; x++) {
                out[yc + x] = 0.25f * tmp[ym + x] + 0.50f * tmp[yc + x] + 0.25f * tmp[yp + x];
            }
        }
        return out;
    }

    /** Reconstructs linear HDR peak luminance at cell {@code idx} per ISO 21496-1 / Android Gainmap math. */
    public static float reconstructLinearPeak(float sdrLinear, PlaneResult plane, int idx) {
        if (plane == null || idx < 0 || idx >= plane.gainBytes.length) return sdrLinear;
        float g = (plane.gainBytes[idx] & 255) / 255.0f;
        double logGain = (1.0 - g) * Math.log(plane.ratioMin) + g * Math.log(plane.ratioMax);
        float gain = (float) Math.exp(logGain);
        return (sdrLinear + plane.epsilonSdr) * gain - plane.epsilonHdr;
    }

    /** Materializes an Android {@link Gainmap} ready for {@link Bitmap#setGainmap(Gainmap)}. */
    public static Gainmap toAndroidGainmap(PlaneResult plane) {
        if (plane == null || plane.gainBytes == null || plane.width <= 0 || plane.height <= 0) {
            return null;
        }
        try {
            Bitmap contents = null;
            if ((plane.width & 3) == 0) {
                Bitmap alphaBmp = Bitmap.createBitmap(plane.width, plane.height, Bitmap.Config.ALPHA_8);
                if (alphaBmp != null) {
                    alphaBmp.copyPixelsFromBuffer(ByteBuffer.wrap(plane.gainBytes));
                    contents = alphaBmp;
                }
            }
            if (contents == null) {
                int[] argb = new int[plane.gainBytes.length];
                for (int i = 0; i < argb.length; i++) {
                    int v = plane.gainBytes[i] & 255;
                    argb[i] = 0xFF000000 | (v << 16) | (v << 8) | v;
                }
                contents = Bitmap.createBitmap(argb, plane.width, plane.height, Bitmap.Config.ARGB_8888);
            }
            if (contents == null) return null;
            Gainmap gm = new Gainmap(contents);
            gm.setRatioMin(plane.ratioMin, plane.ratioMin, plane.ratioMin);
            gm.setRatioMax(plane.ratioMax, plane.ratioMax, plane.ratioMax);
            gm.setGamma(plane.gamma, plane.gamma, plane.gamma);
            gm.setEpsilonSdr(plane.epsilonSdr, plane.epsilonSdr, plane.epsilonSdr);
            gm.setEpsilonHdr(plane.epsilonHdr, plane.epsilonHdr, plane.epsilonHdr);
            gm.setMinDisplayRatioForHdrTransition(1.0f);
            gm.setDisplayRatioForFullHdr(plane.ratioMax);
            return gm;
        } catch (Throwable ignored) {
            return null;
        }
    }

    /** Preserves {@code Display P3} wide color gamut on decoded/created Bitmaps when supported. */
    public static boolean preserveDisplayP3IfWide(Bitmap target, ColorSpace sourceSpace) {
        if (target == null || sourceSpace == null) return false;
        try {
            if (sourceSpace.isWideGamut()) {
                target.setColorSpace(ColorSpace.get(ColorSpace.Named.DISPLAY_P3));
                return true;
            }
        } catch (Throwable ignored) {}
        return false;
    }
}
