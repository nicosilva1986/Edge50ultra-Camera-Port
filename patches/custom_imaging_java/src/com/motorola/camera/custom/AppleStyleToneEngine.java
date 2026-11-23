// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Perceptual Apple Photonic / Photographic Styles engine in linear light + Oklab/OKLCh.
 * Combines 2D edge-aware local shadow/highlight tone shaping (when height >= 16) with
 * chroma-preserving highlight headroom compression, skin-undertone isolation, cyan-sky
 * correction, and foliage taming. Preserves neutral grays exactly and exposes parseCubeLut().
 */
public final class AppleStyleToneEngine {
    public static final int STYLE_NONE = 0;
    public static final int STYLE_IPHONE_NATURAL = 1;
    public static final int STYLE_IPHONE_RICH_CONTRAST = 2;
    public static final int STYLE_IPHONE_AMBER = 3;

    private static final int MAX_CUBE_SIZE = 64;
    private static final int GAMMA_LUT_SIZE = 4096;
    private static final int GRID_STEP = 8;

    private static final float[] SRGB_TO_LIN = new float[256];
    private static final int[] LIN_TO_SRGB_BYTE = new int[GAMMA_LUT_SIZE + 1];

    static {
        for (int i = 0; i < 256; i++) {
            float s = i / 255f;
            SRGB_TO_LIN[i] = s <= 0.04045f ? s / 12.92f : (float) Math.pow((s + 0.055f) / 1.055f, 2.4);
        }
        for (int i = 0; i <= GAMMA_LUT_SIZE; i++) {
            double lin = i / (double) GAMMA_LUT_SIZE;
            double s = lin <= 0.0031308 ? 12.92 * lin : 1.055 * Math.pow(lin, 1.0 / 2.4) - 0.055;
            LIN_TO_SRGB_BYTE[i] = Math.max(0, Math.min(255, (int) Math.round(s * 255.0)));
        }
    }

    private AppleStyleToneEngine() {}

    public static void applyToArgbPixels(int[] argb, int width, int height, int styleId) {
        applyToArgbPixels(argb, width, height, styleId, width, height, 0);
    }

    /**
     * Grades an ARGB buffer or horizontal strip using full-frame geometry for seamless
     * highlight-protected luma-only optical vignette and deterministic film micro-grain.
     */
    public static void applyToArgbPixels(int[] argb, int width, int height, int styleId,
                                         int fullWidth, int fullHeight, int stripTopY) {
        if (argb == null || width <= 0 || height <= 0) {
            return;
        }
        if (styleId < STYLE_IPHONE_NATURAL || styleId > STYLE_IPHONE_AMBER) {
            return;
        }
        long requested = (long) width * (long) height;
        int count = (int) Math.min(argb.length, requested);
        int effHeight = count / width;
        if (effHeight <= 0) {
            return;
        }
        boolean enableSpatialOptics = fullWidth >= 64 && fullHeight >= 64;
        float invHalfW = enableSpatialOptics ? (2.0f / (float) fullWidth) : 0f;
        float invHalfH = enableSpatialOptics ? (2.0f / (float) fullHeight) : 0f;
        float vigStrength = styleId == STYLE_IPHONE_AMBER ? 0.16f
                : (styleId == STYLE_IPHONE_RICH_CONTRAST ? 0.12f : 0.05f);

        float[] baseGrid = null;
        int gw = 0;
        int gh = 0;
        if (width >= 16 && effHeight >= 16) {
            gw = Math.max(2, (width + GRID_STEP - 1) / GRID_STEP);
            gh = Math.max(2, (effHeight + GRID_STEP - 1) / GRID_STEP);
            baseGrid = buildEdgeAwareBaseGrid(argb, width, effHeight, gw, gh);
        }

        for (int y = 0; y < effHeight; y++) {
            float fy = baseGrid != null ? clamp((y + 0.5f) / GRID_STEP - 0.5f, 0f, gh - 1.0001f) : 0f;
            int y0 = (int) fy;
            int y1 = Math.min(y0 + 1, Math.max(0, gh - 1));
            float ty = fy - y0;
            int rowBase = y * width;
            int globalY = stripTopY + y;
            float ny = enableSpatialOptics ? ((globalY + 0.5f) * invHalfH - 1.0f) : 0f;
            float ny2 = ny * ny;

            for (int x = 0; x < width; x++) {
                int i = rowBase + x;
                int pixel = argb[i];
                int alpha = pixel & 0xFF000000;
                int r8 = (pixel >>> 16) & 255;
                int g8 = (pixel >>> 8) & 255;
                int b8 = pixel & 255;

                float r = SRGB_TO_LIN[r8];
                float g = SRGB_TO_LIN[g8];
                float b = SRGB_TO_LIN[b8];
                boolean isGray = (r8 == g8 && g8 == b8);

                float localBase = -1f;
                if (baseGrid != null) {
                    float fx = clamp((x + 0.5f) / GRID_STEP - 0.5f, 0f, gw - 1.0001f);
                    int x0 = (int) fx;
                    int x1 = Math.min(x0 + 1, gw - 1);
                    float tx = fx - x0;
                    float b00 = baseGrid[y0 * gw + x0];
                    float b10 = baseGrid[y0 * gw + x1];
                    float b01 = baseGrid[y1 * gw + x0];
                    float b11 = baseGrid[y1 * gw + x1];
                    float top = b00 + (b10 - b00) * tx;
                    float bot = b01 + (b11 - b01) * tx;
                    localBase = top + (bot - top) * ty;
                }

                float radialEdge = 0f;
                if (enableSpatialOptics) {
                    float nx = (x + 0.5f) * invHalfW - 1.0f;
                    // Elliptical aspect weighting (~0.82x on long side, matching cv_style.c optics).
                    float r2 = nx * nx * 0.82f + ny2;
                    radialEdge = vigStrength * smoothstep(0.28f, 1.38f, r2);
                }

                argb[i] = gradePixel(alpha, r, g, b, isGray, localBase, styleId, radialEdge, enableSpatialOptics, x, globalY);
            }
        }
    }

    /** Computes a fast 1/8-resolution bilateral-filtered log-luminance guide for halo-free LTM. */
    private static float[] buildEdgeAwareBaseGrid(int[] argb, int width, int height, int gw, int gh) {
        float[] src = new float[gw * gh];
        for (int gy = 0; gy < gh; gy++) {
            int yStart = gy * GRID_STEP;
            int yEnd = Math.min(height, yStart + GRID_STEP);
            for (int gx = 0; gx < gw; gx++) {
                int xStart = gx * GRID_STEP;
                int xEnd = Math.min(width, xStart + GRID_STEP);
                double sum = 0.0;
                int n = 0;
                for (int py = yStart; py < yEnd; py += 2) {
                    int row = py * width;
                    for (int px = xStart; px < xEnd; px += 2) {
                        int p = argb[row + px];
                        float yLin = 0.2126f * SRGB_TO_LIN[(p >>> 16) & 255]
                                   + 0.7152f * SRGB_TO_LIN[(p >>> 8) & 255]
                                   + 0.0722f * SRGB_TO_LIN[p & 255];
                        sum += yLin;
                        n++;
                    }
                }
                float meanY = n > 0 ? (float) (sum / n) : 0f;
                src[gy * gw + gx] = (float) Math.log(meanY + 0.002f);
            }
        }

        // Fast separable 5-tap edge-stopping bilateral filter on log-luminance.
        return bilateralSmoothLogGrid(src, gw, gh, 0.40f);
    }

    private static float[] bilateralSmoothLogGrid(float[] src, int gw, int gh, float sigmaR) {
        float[] tmp = new float[gw * gh];
        float[] out = new float[gw * gh];
        final float inv2SigmaR2 = 1f / (2f * sigmaR * sigmaR);
        final float[] spatialW = {0.25f, 0.61f, 1.0f, 0.61f, 0.25f};

        for (int gy = 0; gy < gh; gy++) {
            int row = gy * gw;
            for (int gx = 0; gx < gw; gx++) {
                float c = src[row + gx];
                float acc = 0f;
                float wSum = 0f;
                for (int k = -2; k <= 2; k++) {
                    int sx = Math.max(0, Math.min(gw - 1, gx + k));
                    float v = src[row + sx];
                    float d = v - c;
                    float w = spatialW[k + 2] * fastExpNeg(d * d * inv2SigmaR2);
                    acc += v * w;
                    wSum += w;
                }
                tmp[row + gx] = wSum > 0f ? acc / wSum : c;
            }
        }
        for (int gy = 0; gy < gh; gy++) {
            int row = gy * gw;
            for (int gx = 0; gx < gw; gx++) {
                float c = tmp[row + gx];
                float acc = 0f;
                float wSum = 0f;
                for (int k = -2; k <= 2; k++) {
                    int sy = Math.max(0, Math.min(gh - 1, gy + k));
                    float v = tmp[sy * gw + gx];
                    float d = v - c;
                    float w = spatialW[k + 2] * fastExpNeg(d * d * inv2SigmaR2);
                    acc += v * w;
                    wSum += w;
                }
                out[row + gx] = wSum > 0f ? acc / wSum : c;
            }
        }
        return out;
    }

    /**
     * Fast pre-gate for Profile 0 auto LTM: triggers only on genuinely wide dynamic range frames
     * with meaningful deep shadows (< 40) AND bright highlights (> 228). Skips flat/normal frames.
     */
    public static boolean evaluateAutoLtmGate(int[] sampleArgb, int sampleCount) {
        if (sampleArgb == null || sampleCount <= 0) {
            return false;
        }
        int n = Math.min(sampleArgb.length, sampleCount);
        if (n <= 0) {
            return false;
        }
        int[] hist = new int[256];
        int shadowCount = 0;
        int hlCount = 0;
        int midCount = 0;
        for (int i = 0; i < n; i++) {
            int p = sampleArgb[i];
            int y = (((p >>> 16) & 255) * 77 + ((p >>> 8) & 255) * 150 + (p & 255) * 29) >>> 8;
            hist[y]++;
            if (y < 32) shadowCount++;
            else if (y > 236) hlCount++;
            if (y >= 48 && y <= 200) midCount++;
        }
        int p05Target = Math.max(1, (n * 5) / 100);
        int p95Target = Math.max(p05Target, (n * 95) / 100);
        int cum = 0;
        int p05 = 0;
        int p95 = 255;
        boolean found05 = false;
        for (int bin = 0; bin < 256; bin++) {
            cum += hist[bin];
            if (!found05 && cum >= p05Target) {
                p05 = bin;
                found05 = true;
            }
            if (cum >= p95Target) {
                p95 = bin;
                break;
            }
        }
        return (p95 - p05) >= 165
                && shadowCount >= 0.10f * n
                && hlCount >= 0.02f * n
                && midCount <= 0.62f * n;
    }

    /**
     * Independent highlight-rolloff pre-gate for Profile 0: triggers when >= 0.5% of pixels
     * reach near-clipping luminance (Y >= 250) on a bright-sky/highlight frame (p95 >= 232),
     * avoiding decode/encode work on indoor/shaded frames with intact highlights.
     */
    public static boolean evaluateAutoHighlightGate(int[] sampleArgb, int sampleCount) {
        if (sampleArgb == null || sampleCount <= 0) {
            return false;
        }
        int n = Math.min(sampleArgb.length, sampleCount);
        if (n <= 0) {
            return false;
        }
        int nearClipCount = 0;
        final int threshold = Math.max(1, (int) Math.ceil(0.005f * n));
        for (int i = 0; i < n; i++) {
            int p = sampleArgb[i];
            int y = (((p >>> 16) & 255) * 77 + ((p >>> 8) & 255) * 150 + (p & 255) * 29) >>> 8;
            if (y >= 250 && ++nearClipCount >= threshold) {
                return true;
            }
        }
        return false;
    }

    /** Grid step size (8 px) used for whole-frame edge-aware Auto LTM base & variance grids. */
    public static int autoLtmGridStep() {
        return GRID_STEP;
    }

    /** Accumulates one horizontal band (height <= bandRows) into coarse 8x8 log-luma & std cells. */
    public static void accumulateAutoLtmBand(int[] bandArgb, int width, int bandRows, int bandTopY,
                                             int fullHeight, float[] rawLogGrid, float[] stdGrid, int gw, int gh) {
        if (bandArgb == null || rawLogGrid == null || stdGrid == null || width < 16 || fullHeight < 16) {
            return;
        }
        int gyStart = bandTopY / GRID_STEP;
        int gyEnd = Math.min(gh, (bandTopY + bandRows + GRID_STEP - 1) / GRID_STEP);
        for (int gy = gyStart; gy < gyEnd; gy++) {
            int y0 = Math.max(bandTopY, gy * GRID_STEP);
            int y1 = Math.min(Math.min(fullHeight, bandTopY + bandRows), (gy + 1) * GRID_STEP);
            for (int gx = 0; gx < gw; gx++) {
                int x0 = gx * GRID_STEP;
                int x1 = Math.min(width, x0 + GRID_STEP);
                double sum = 0.0;
                double sumSq = 0.0;
                int n = 0;
                for (int y = y0; y < y1; y += 2) {
                    int row = (y - bandTopY) * width;
                    for (int x = x0; x < x1; x += 2) {
                        int p = bandArgb[row + x];
                        float yLin = 0.2126f * SRGB_TO_LIN[(p >>> 16) & 255]
                                   + 0.7152f * SRGB_TO_LIN[(p >>> 8) & 255]
                                   + 0.0722f * SRGB_TO_LIN[p & 255];
                        sum += yLin;
                        sumSq += (double) yLin * (double) yLin;
                        n++;
                    }
                }
                if (n > 0) {
                    float meanY = (float) (sum / n);
                    float var = Math.max(0f, (float) (sumSq / n) - meanY * meanY);
                    int idx = gy * gw + gx;
                    rawLogGrid[idx] = (float) Math.log(meanY + 0.002f);
                    stdGrid[idx] = (float) Math.sqrt(var);
                }
            }
        }
    }

    /** Finalizes a coarse log-luma LTM grid with tight edge-stopping sigma_r = 0.35 smoothing. */
    public static float[] finalizeAutoLtmBaseGrid(float[] rawLogGrid, int gw, int gh) {
        if (rawLogGrid == null || gw < 2 || gh < 2) {
            return null;
        }
        return bilateralSmoothLogGrid(rawLogGrid, gw, gh, 0.35f);
    }

    /** Convenience whole-frame builder returning {baseLogGrid, stdGrid} for Auto LTM. */
    public static float[][] buildAutoLtmGrid(int[] argb, int width, int height) {
        if (argb == null || width < 16 || height < 16 || argb.length < width * height) {
            return null;
        }
        int gw = Math.max(2, (width + GRID_STEP - 1) / GRID_STEP);
        int gh = Math.max(2, (height + GRID_STEP - 1) / GRID_STEP);
        float[] rawLog = new float[gw * gh];
        float[] std = new float[gw * gh];
        accumulateAutoLtmBand(argb, width, height, 0, height, rawLog, std, gw, gh);
        return new float[][] {finalizeAutoLtmBaseGrid(rawLog, gw, gh), std};
    }

    /**
     * Profile 0 post-pass: (1) high-DR gated 8x8 edge-aware log-luma LTM using full-frame grids,
     * and/or (2) structure-tensor steerable zoom acutance strictly clamped to 3x3 [min, max].
     */
    public static void applyAutoLocalToneAndZoomAcutance(
            int[] argb, int width, int height,
            int stripTopY, int fullWidth, int fullHeight,
            float[] ltmBaseGrid, float[] ltmStdGrid, int gw, int gh,
            boolean applyLtm, boolean applyZoomAcutance) {
        applyAutoLocalToneAndZoomAcutance(
                argb, width, height, stripTopY, fullWidth, fullHeight,
                ltmBaseGrid, ltmStdGrid, gw, gh, applyLtm, applyZoomAcutance, 6.0f);
    }

    /**
     * Profile 0 post-pass: (1) true high-DR gated 8x8 edge-aware log-luma LTM (protecting blue sky/mids),
     * and/or (2) zoom-calibrated structure-tensor steerable acutance clamped strictly to 3x3 [min, max].
     */
    public static void applyAutoLocalToneAndZoomAcutance(
            int[] argb, int width, int height,
            int stripTopY, int fullWidth, int fullHeight,
            float[] ltmBaseGrid, float[] ltmStdGrid, int gw, int gh,
            boolean applyLtm, boolean applyZoomAcutance, float zoomRatio) {
        applyAutoLocalToneAndZoomAcutance(
                argb, width, height, stripTopY, fullWidth, fullHeight,
                ltmBaseGrid, ltmStdGrid, gw, gh, applyLtm, applyLtm, applyZoomAcutance, zoomRatio);
    }

    /**
     * Profile 0 post-pass: (1) high-DR shadow LTM and/or monotone SDR highlight shoulder above 224
     * (continuous across pure white 255 -> 249 with zero neighbor cliff), and (2) zoom-calibrated
     * structure-tensor steerable acutance clamped strictly to 3x3 [min, max].
     */
    public static void applyAutoLocalToneAndZoomAcutance(
            int[] argb, int width, int height,
            int stripTopY, int fullWidth, int fullHeight,
            float[] ltmBaseGrid, float[] ltmStdGrid, int gw, int gh,
            boolean applyLtm, boolean applyHighlightShoulder,
            boolean applyZoomAcutance, float zoomRatio) {
        if (argb == null || width <= 0 || height <= 0
                || (!applyLtm && !applyHighlightShoulder && !applyZoomAcutance)) {
            return;
        }
        long requested = (long) width * (long) height;
        int count = (int) Math.min(argb.length, requested);
        int effHeight = count / width;
        if (effHeight <= 0) {
            return;
        }

        final boolean hasLtmGrid = applyLtm && ltmBaseGrid != null && ltmStdGrid != null
                && gw >= 2 && gh >= 2
                && ltmBaseGrid.length >= gw * gh && ltmStdGrid.length >= gw * gh;

        if (hasLtmGrid || applyHighlightShoulder) {
            for (int y = 0; y < effHeight; y++) {
                int globalY = stripTopY + y;
                float fy = hasLtmGrid ? clamp((globalY + 0.5f) / GRID_STEP - 0.5f, 0f, gh - 1.0001f) : 0f;
                int y0 = (int) fy;
                int y1 = hasLtmGrid ? Math.min(y0 + 1, gh - 1) : 0;
                float ty = fy - y0;
                int rowBase = y * width;

                for (int x = 0; x < width; x++) {
                    int i = rowBase + x;
                    int pixel = argb[i];
                    int alpha = pixel & 0xFF000000;
                    int r8 = (pixel >>> 16) & 255;
                    int g8 = (pixel >>> 8) & 255;
                    int b8 = pixel & 255;
                    if ((r8 | g8 | b8) == 0) {
                        continue;
                    }

                    int outR8 = r8;
                    int outG8 = g8;
                    int outB8 = b8;

                    if (hasLtmGrid) {
                        float fx = clamp((x + 0.5f) / GRID_STEP - 0.5f, 0f, gw - 1.0001f);
                        int x0 = (int) fx;
                        int x1 = Math.min(x0 + 1, gw - 1);
                        float tx = fx - x0;
                        int idx00 = y0 * gw + x0;
                        int idx10 = y0 * gw + x1;
                        int idx01 = y1 * gw + x0;
                        int idx11 = y1 * gw + x1;

                        float bTop = ltmBaseGrid[idx00] + (ltmBaseGrid[idx10] - ltmBaseGrid[idx00]) * tx;
                        float bBot = ltmBaseGrid[idx01] + (ltmBaseGrid[idx11] - ltmBaseGrid[idx01]) * tx;
                        float baseLogY = bTop + (bBot - bTop) * ty;
                        float baseY = Math.max(0.0005f, (float) Math.exp(baseLogY) - 0.002f);

                        float sTop = ltmStdGrid[idx00] + (ltmStdGrid[idx10] - ltmStdGrid[idx00]) * tx;
                        float sBot = ltmStdGrid[idx01] + (ltmStdGrid[idx11] - ltmStdGrid[idx01]) * tx;
                        float baseStd = sTop + (sBot - sTop) * ty;

                        float darkFloor = smoothstep(0.004f, 0.020f, baseY);
                        float shadowBand = 1f - smoothstep(0.035f, 0.14f, baseY);
                        float noiseDamp = smoothstep(0.008f, 0.034f, baseStd);
                        float lift = 1f + 0.24f * darkFloor * shadowBand * (0.25f + 0.75f * noiseDamp);
                        if (lift > 1.001f) {
                            float r = SRGB_TO_LIN[r8] * lift;
                            float g = SRGB_TO_LIN[g8] * lift;
                            float b = SRGB_TO_LIN[b8] * lift;
                            outR8 = toSrgbByte(r);
                            outG8 = toSrgbByte(g);
                            outB8 = toSrgbByte(b);
                        }
                    }

                    if (applyHighlightShoulder || hasLtmGrid) {
                        int peak8 = Math.max(outR8, Math.max(outG8, outB8));
                        if (peak8 > 224) {
                            float excess = peak8 - 224.0f;
                            float targetPeak = 224.0f + 128.0f * excess / (128.0f + excess);
                            float scale = targetPeak / (float) peak8;
                            outR8 = clampByte(Math.round(outR8 * scale));
                            outG8 = clampByte(Math.round(outG8 * scale));
                            outB8 = clampByte(Math.round(outB8 * scale));
                        }
                    }

                    if (outR8 != r8 || outG8 != g8 || outB8 != b8) {
                        argb[i] = alpha | (outR8 << 16) | (outG8 << 8) | outB8;
                    }
                }
            }
        }

        if (applyZoomAcutance && zoomRatio >= 1.70f && zoomRatio <= 30.0f && width >= 6 && effHeight >= 6) {
            final float threshPx;
            final float cohMin;
            final float maxAmount;
            if (zoomRatio < 2.95f) {
                threshPx = 10.0f / 255.0f;
                cohMin = 0.55f;
                maxAmount = 0.25f;
            } else if (zoomRatio < 12.0f) {
                threshPx = 8.0f / 255.0f;
                cohMin = 0.48f;
                maxAmount = 0.42f;
            } else {
                threshPx = 9.0f / 255.0f;
                cohMin = 0.55f;
                maxAmount = 0.32f;
            }
            float[] yBuf = new float[count];
            for (int i = 0; i < count; i++) {
                int p = argb[i];
                yBuf[i] = (0.2126f * ((p >>> 16) & 255)
                         + 0.7152f * ((p >>> 8) & 255)
                         + 0.0722f * (p & 255)) * (1.0f / 255.0f);
            }
            final float noiseThresh = threshPx * threshPx;
            for (int y = 2; y < effHeight - 2; y++) {
                int row = y * width;
                for (int x = 2; x < width - 2; x++) {
                    float jxx = 0f;
                    float jxy = 0f;
                    float jyy = 0f;
                    float localMin = 1f;
                    float localMax = 0f;
                    for (int ky = -1; ky <= 1; ky++) {
                        int kRow = (y + ky) * width;
                        for (int kx = -1; kx <= 1; kx++) {
                            int ki = kRow + x + kx;
                            float v = yBuf[ki];
                            if (v < localMin) localMin = v;
                            if (v > localMax) localMax = v;
                            float gx = 0.5f * (yBuf[ki + 1] - yBuf[ki - 1]);
                            float gy = 0.5f * (yBuf[ki + width] - yBuf[ki - width]);
                            jxx += gx * gx;
                            jxy += gx * gy;
                            jyy += gy * gy;
                        }
                    }
                    jxx *= (1f / 9f);
                    jxy *= (1f / 9f);
                    jyy *= (1f / 9f);
                    float tr = jxx + jyy;
                    if (tr < noiseThresh) {
                        continue;
                    }
                    float diff = jxx - jyy;
                    float disc = (float) Math.sqrt(diff * diff + 4f * jxy * jxy);
                    float l1 = 0.5f * (tr + disc);
                    float l2 = 0.5f * (tr - disc);
                    float coh = (l1 - l2) / (l1 + l2 + 1e-8f);
                    if (coh < cohMin) {
                        continue;
                    }
                    float vx = diff >= 0f ? (diff + disc) : (2f * jxy);
                    float vy = diff >= 0f ? (2f * jxy) : (disc - diff);
                    float len = (float) Math.sqrt(vx * vx + vy * vy);
                    if (len < 1e-6f) {
                        continue;
                    }
                    vx /= len;
                    vy /= len;
                    float ym = sampleBilinearY(yBuf, width, effHeight, x - vx, y - vy);
                    float yp = sampleBilinearY(yBuf, width, effHeight, x + vx, y + vy);
                    float yc = yBuf[row + x];
                    float detail = yc - 0.5f * (ym + yp);
                    float amount = maxAmount * smoothstep(cohMin, Math.min(0.95f, cohMin + 0.35f), coh);
                    float yTarget = clamp(yc + amount * detail, localMin, localMax);
                    float delta255 = (yTarget - yc) * 255.0f;
                    if (Math.abs(delta255) < 0.25f) {
                        continue;
                    }
                    int i = row + x;
                    int pixel = argb[i];
                    int r8 = (pixel >>> 16) & 255;
                    int g8 = (pixel >>> 8) & 255;
                    int b8 = pixel & 255;
                    if (delta255 > 0f) {
                        float maxHeadroom = 255f - Math.max(r8, Math.max(g8, b8));
                        delta255 = Math.min(delta255, maxHeadroom);
                    } else {
                        float minFloor = -Math.min(r8, Math.min(g8, b8));
                        delta255 = Math.max(delta255, minFloor);
                    }
                    int dInt = Math.round(delta255);
                    if (dInt != 0) {
                        argb[i] = (pixel & 0xFF000000)
                                | (clampByte(r8 + dInt) << 16)
                                | (clampByte(g8 + dInt) << 8)
                                | clampByte(b8 + dInt);
                    }
                }
            }
        }
    }

    private static float sampleBilinearY(float[] yBuf, int w, int h, float fx, float fy) {
        float cx = clamp(fx, 0f, w - 1.0001f);
        float cy = clamp(fy, 0f, h - 1.0001f);
        int x0 = (int) cx;
        int y0 = (int) cy;
        int x1 = Math.min(x0 + 1, w - 1);
        int y1 = Math.min(y0 + 1, h - 1);
        float tx = cx - x0;
        float ty = cy - y0;
        float v00 = yBuf[y0 * w + x0];
        float v10 = yBuf[y0 * w + x1];
        float v01 = yBuf[y1 * w + x0];
        float v11 = yBuf[y1 * w + x1];
        float top = v00 + (v10 - v00) * tx;
        float bot = v01 + (v11 - v01) * tx;
        return top + (bot - top) * ty;
    }

    private static int clampByte(int v) {
        return v < 0 ? 0 : (Math.min(255, v));
    }

    private static int gradePixel(int alpha, float r, float g, float b, boolean isGray,
                                  float baseLogY, int style, float radialEdge,
                                  boolean enableSpatialOptics, int gx, int gy) {
        if (r <= 0f && g <= 0f && b <= 0f) {
            return alpha;
        }
        if (r >= 1f && g >= 1f && b >= 1f) {
            return alpha | 0x00FFFFFF;
        }

        // 1. Chroma-preserving linear highlight headroom shoulder + gentle local tone shaping.
        float yLin = 0.2126f * r + 0.7152f * g + 0.0722f * b;
        float guide = Math.max(yLin, Math.max(r, Math.max(g, b)));
        if (guide > 0.62f) {
            float excess = (guide - 0.62f) / 0.38f;
            float knee = 0.62f + 0.38f * (excess * 1.14f / (1f + 0.28f * (1f - excess) + 0.14f * excess * excess));
            if (style == STYLE_IPHONE_NATURAL && knee > guide) {
                knee = guide;
            }
            float hScale = knee / guide;
            r *= hScale;
            g *= hScale;
            b *= hScale;
            // Subtle specular neutral highlight convergence above 0.86 linear.
            if (guide > 0.86f && !isGray) {
                float wWhite = smoothstep(0.86f, 1.0f, guide) * 0.24f;
                float lum = 0.2126f * r + 0.7152f * g + 0.0722f * b;
                r += (lum - r) * wWhite;
                g += (lum - g) * wWhite;
                b += (lum - b) * wWhite;
            }
            yLin = 0.2126f * r + 0.7152f * g + 0.0722f * b;
        }

        // Apply low-frequency bilateral base contrast adjustment when 2D context is present.
        if (baseLogY > -9f && !isGray) {
            float baseY = Math.max(0.0005f, (float) Math.exp(baseLogY) - 0.002f);
            float baseGain = localBaseGain(baseY, yLin, style);
            r = Math.max(0f, r * baseGain);
            g = Math.max(0f, g * baseGain);
            b = Math.max(0f, b * baseGain);
        }

        // 2. Linear sRGB -> Oklab (Björn Ottosson exact D65 M1 / M2 matrices).
        float l = 0.4122214708f * r + 0.5363325363f * g + 0.0514459929f * b;
        float m = 0.2119034982f * r + 0.6806995451f * g + 0.1073969566f * b;
        float s = 0.0883024619f * r + 0.2817188376f * g + 0.6299787005f * b;

        float l3 = fastCbrtPos(l);
        float m3 = fastCbrtPos(m);
        float s3 = fastCbrtPos(s);

        float okL = 0.2104542553f * l3 + 0.7936177850f * m3 - 0.0040720468f * s3;
        float okA = 1.9779984951f * l3 - 2.4285922050f * m3 + 0.4505937099f * s3;
        float okB = 0.0259040371f * l3 + 0.7827717662f * m3 - 0.8086757660f * s3;

        // 3. Tone curve in perceptual lightness L (guarantees smooth shadow/mid contrast without hue shift).
        float newL = applyLightnessCurve(okL, style);

        if (enableSpatialOptics) {
            // OPPO/Xiaomi-style luma-only highlight-protected vignette: shapes corner falloff in Oklab L.
            if (radialEdge > 0f) {
                float hlProtect = 1f - smoothstep(0.58f, 0.92f, newL);
                newL = clamp01(newL * (1f - radialEdge * hlProtect));
            }
            // Xiaomi frag_madrid-inspired 6-tap triangular micro-grain strictly on midtones of Amber.
            if (style == STYLE_IPHONE_AMBER) {
                float midMask = smoothstep(0.06f, 0.20f, newL) * (1f - smoothstep(0.75f, 0.96f, newL));
                if (midMask > 0f) {
                    newL = clamp01(newL + deterministicGrain6(gx, gy) * 0.0032f * midMask);
                }
            }
        }

        if (isGray) {
            float outLin = newL * newL * newL;
            int v8 = toSrgbByte(outLin);
            return alpha | (v8 << 16) | (v8 << 8) | v8;
        }

        float chroma = (float) Math.sqrt(okA * okA + okB * okB);
        float newA = okA;
        float newB = okB;

        if (chroma > 1e-4f) {
            float hueDeg = (float) Math.toDegrees(Math.atan2(okB, okA));
            if (hueDeg < 0f) {
                hueDeg += 360f;
            }
            // Smooth onset starting right above near-neutral (0.012..0.050), eliminating the 0.12 cliff.
            float chromaGate = smoothstep(0.012f, 0.050f, chroma);

            // A) Foliage green taming (~136 deg, sigma=22 deg): naturalize neon greens.
            float wFoliage = gaussianHueWeight(hueDeg, 136f, 22f) * chromaGate;
            if (wFoliage > 0.01f) {
                float scale = 1f - 0.14f * wFoliage;
                float rot = 4.0f * (float) (Math.PI / 180.0) * wFoliage;
                float cosR = (float) Math.cos(-rot);
                float sinR = (float) Math.sin(-rot);
                float ra = (newA * cosR - newB * sinR) * scale;
                float rb = (newA * sinR + newB * cosR) * scale;
                newA = ra;
                newB = rb;
            }

            // B) Cyan sky fix (~220 deg, sigma=26 deg, sunlit L > 0.40): push cyan toward cobalt (~242 deg).
            float wSky = gaussianHueWeight(hueDeg, 220f, 26f) * smoothstep(0.38f, 0.62f, okL) * chromaGate;
            if (wSky > 0.01f) {
                float rot = 8.5f * (float) (Math.PI / 180.0) * wSky;
                float cosR = (float) Math.cos(rot);
                float sinR = (float) Math.sin(rot);
                float scale = 1f + (style == STYLE_IPHONE_RICH_CONTRAST ? 0.09f : 0.05f) * wSky;
                float ra = (newA * cosR - newB * sinR) * scale;
                float rb = (newA * sinR + newB * cosR) * scale;
                newA = ra;
                newB = rb;
            }

            // C) Skin-undertone isolation (~42 deg, sigma=24 deg, skin L in 0.20..0.88, moderate chroma).
            float wSkin = gaussianHueWeight(hueDeg, 42f, 24f)
                    * smoothstep(0.18f, 0.30f, okL)
                    * (1f - smoothstep(0.84f, 0.94f, okL))
                    * (1f - smoothstep(0.11f, 0.22f, chroma));

            if (style == STYLE_IPHONE_RICH_CONTRAST) {
                // Decoupled Tone vs Skin: keep skin luminous while deeper global shadows stay contrasty.
                newL = newL + (okL - newL) * (0.48f * wSkin);
                newA += 0.002f * wSkin;
                newB += 0.004f * wSkin;
            } else if (style == STYLE_IPHONE_AMBER) {
                // Authentic golden-amber warmth inside skin & sunlit mid-highlights; clean neutral shadows.
                float warmHighlight = smoothstep(0.55f, 0.85f, okL) * (1f - smoothstep(0.92f, 1.0f, okL)) * chromaGate;
                float skinBoost = wSkin * smoothstep(0.015f, 0.04f, chroma);
                newA += 0.0085f * skinBoost + 0.0025f * warmHighlight;
                newB += 0.0185f * skinBoost + 0.0080f * warmHighlight;
                newL = clamp01(newL + 0.008f * wSkin);
            } else {
                // iPhone Natural: gentle clean warm skin fidelity, subtle organic contrast.
                newA += 0.002f * wSkin;
                newB += 0.004f * wSkin;
            }
        }

        // Preserve chroma proportional scale softly when lightness rises in highlights to avoid pastel clip.
        if (newL > okL && okL > 0.05f && newL > 0.72f) {
            float damp = 1f - 0.15f * smoothstep(0.72f, 0.98f, newL);
            newA *= damp;
            newB *= damp;
        }

        // 4. Oklab -> Linear sRGB.
        float nl3 = newL + 0.3963377774f * newA + 0.2158037573f * newB;
        float nm3 = newL - 0.1055613458f * newA - 0.0638541728f * newB;
        float ns3 = newL - 0.0894841775f * newA - 1.2914855480f * newB;

        float nl = nl3 * nl3 * nl3;
        float nm = nm3 * nm3 * nm3;
        float ns = ns3 * ns3 * ns3;

        float outR = +4.0767416621f * nl - 3.3077115913f * nm + 0.2309699292f * ns;
        float outG = -1.2684380046f * nl + 2.6097574011f * nm - 0.3413193965f * ns;
        float outB = -0.0041960863f * nl - 0.7034186147f * nm + 1.7076147010f * ns;

        // Soft constant-L desaturation fallback only if Oklab push pushed any channel outside [0, 1].
        float maxC = Math.max(outR, Math.max(outG, outB));
        float minC = Math.min(outR, Math.min(outG, outB));
        if (minC < 0f || maxC > 1f) {
            float grayLin = newL * newL * newL;
            float t = 1f;
            if (minC < 0f && grayLin > minC) {
                t = Math.min(t, grayLin / (grayLin - minC));
            }
            if (maxC > 1f && maxC > grayLin) {
                t = Math.min(t, (1f - grayLin) / (maxC - grayLin));
            }
            t = clamp01(t);
            outR = grayLin + (outR - grayLin) * t;
            outG = grayLin + (outG - grayLin) * t;
            outB = grayLin + (outB - grayLin) * t;
        }

        return alpha | (toSrgbByte(outR) << 16) | (toSrgbByte(outG) << 8) | toSrgbByte(outB);
    }

    /** Adjusts ONLY wide-area low-frequency base density, protecting micro-detail & avoiding halos. */
    private static float localBaseGain(float baseY, float yLin, int style) {
        if (yLin <= 1e-4f) {
            return 1f;
        }
        float detailProtection = smoothstep(0.02f, 0.14f, baseY) * (1f - smoothstep(0.55f, 0.88f, baseY));
        float targetBase = baseY;
        if (style == STYLE_IPHONE_RICH_CONTRAST) {
            // Pull down hazy HDR-overlifted shadow regions locally without crushing true blacks.
            float shadowWeight = (1f - smoothstep(0.08f, 0.42f, baseY)) * smoothstep(0.01f, 0.05f, baseY);
            targetBase = baseY * (1f - 0.12f * shadowWeight);
        } else if (style == STYLE_IPHONE_NATURAL) {
            float shadowLift = (1f - smoothstep(0.05f, 0.25f, baseY)) * smoothstep(0.005f, 0.03f, baseY);
            targetBase = baseY * (1f + 0.05f * shadowLift);
        } else if (style == STYLE_IPHONE_AMBER) {
            float midLift = smoothstep(0.08f, 0.35f, baseY) * (1f - smoothstep(0.45f, 0.78f, baseY));
            targetBase = baseY * (1f + 0.04f * midLift);
        }
        float blend = 1f + ((targetBase / Math.max(1e-4f, baseY)) - 1f) * (0.4f + 0.6f * detailProtection);
        return clamp(blend, 0.82f, 1.16f);
    }

    private static float applyLightnessCurve(float okL, int style) {
        if (okL <= 0f) return 0f;
        if (okL >= 1f) return 1f;
        if (style == STYLE_IPHONE_RICH_CONTRAST) {
            // Deeper low-mid filmic curve (Rich Contrast): steepens 0.20..0.55, gentle highlight top.
            if (okL < 0.22f) {
                return (float) (0.22 * Math.pow(okL / 0.22, 1.18));
            }
            if (okL < 0.72f) {
                float u = (okL - 0.22f) / 0.50f;
                return okL - 0.032f * (float) Math.sin(Math.PI * u);
            }
            return clamp01(okL + 0.010f * smoothstep(0.72f, 0.92f, okL) * (1f - okL) * 2.5f);
        }
        if (style == STYLE_IPHONE_AMBER) {
            // Luminous mid-lightness curve (+subtle mid lift, crisp deep anchor).
            return clamp01(okL + 0.018f * okL * (1f - okL) * (okL - 0.12f) * 3.2f);
        }
        // iPhone Natural: gentle S-balance keeping shadow clarity + unclipped highlights.
        return clamp01(okL + 0.012f * smoothstep(0.18f, 0.45f, okL) * (1f - okL) * (0.55f - okL) * 2f);
    }

    private static float gaussianHueWeight(float hueDeg, float centerDeg, float sigmaDeg) {
        float d = Math.abs(hueDeg - centerDeg);
        if (d > 180f) {
            d = 360f - d;
        }
        float z = d / sigmaDeg;
        return fastExpNeg(0.5f * z * z);
    }

    private static float fastExpNeg(float x) {
        if (x >= 10f) return 0f;
        if (x <= 0f) return 1f;
        return (float) Math.exp(-x);
    }

    private static float fastCbrtPos(float x) {
        if (x <= 0f) return 0f;
        int i = Float.floatToRawIntBits(x);
        i = 0x2a5137a0 + i / 3;
        float y = Float.intBitsToFloat(i);
        // Two Halley steps give ~1e-6 accuracy across [1e-4, 2].
        float y3 = y * y * y;
        y = y * (y3 + 2f * x) / (2f * y3 + x);
        y3 = y * y * y;
        return y * (y3 + 2f * x) / (2f * y3 + x);
    }

    private static float smoothstep(float e0, float e1, float x) {
        float t = clamp01((x - e0) / (e1 - e0));
        return t * t * (3f - 2f * t);
    }

    /** Zero-mean quasi-Gaussian deterministic film grain [-1, +1] from 4 spatial taps (irwin-hall). */
    private static float deterministicGrain6(int x, int y) {
        int h = (x * 0x9E3779B1) ^ (y * 0x85EBCA77);
        h ^= (h >>> 15);
        h *= 0x2C1B3C6D;
        h ^= (h >>> 12);
        // Split 32-bit whitened integer into four 8-bit uniform taps in [0, 255].
        int t0 = (h & 255) + ((h >>> 8) & 255);
        int t1 = ((h >>> 16) & 255) + ((h >>> 24) & 255);
        return ((t0 + t1) - 510.0f) * (1.0f / 510.0f);
    }

    private static int toSrgbByte(float lin) {
        if (lin <= 0f) return 0;
        if (lin >= 1f) return 255;
        int idx = (int) (lin * GAMMA_LUT_SIZE + 0.5f);
        return LIN_TO_SRGB_BYTE[idx >= GAMMA_LUT_SIZE ? GAMMA_LUT_SIZE : idx];
    }

    private static float clamp01(float v) {
        return v < 0f ? 0f : (v > 1f ? 1f : v);
    }

    private static float clamp(float v, float lo, float hi) {
        return v < lo ? lo : (v > hi ? hi : v);
    }

    /**
     * Parses an Adobe-style {@code .cube} 3D LUT. {@code outSize[0]} receives {@code LUT_3D_SIZE}
     * when {@code outSize} is non-null and non-empty. Malformed text throws {@link IllegalArgumentException}.
     * Samples stay in file order (red index changes fastest).
     */
    public static float[] parseCubeLut(String cubeText, int[] outSize) {
        if (cubeText == null) {
            throw new IllegalArgumentException("cube text is null");
        }
        int start = 0;
        if (!cubeText.isEmpty() && cubeText.charAt(0) == '\uFEFF') {
            start = 1;
        }
        int size = -1;
        float[] domainMin = null;
        float[] domainMax = null;
        float[] samples = null;
        int filled = 0;
        int lineStart = start;
        int length = cubeText.length();
        while (lineStart <= length) {
            int lineEnd = lineStart;
            while (lineEnd < length) {
                char ch = cubeText.charAt(lineEnd);
                if (ch == '\n' || ch == '\r') {
                    break;
                }
                lineEnd++;
            }
            int tokenBase = lineStart;
            while (tokenBase < lineEnd && isSpace(cubeText.charAt(tokenBase))) {
                tokenBase++;
            }
            int tokenEnd = lineEnd;
            while (tokenEnd > tokenBase && isSpace(cubeText.charAt(tokenEnd - 1))) {
                tokenEnd--;
            }
            if (tokenBase < tokenEnd && cubeText.charAt(tokenBase) != '#') {
                int words = countWords(cubeText, tokenBase, tokenEnd);
                int firstEnd = wordEnd(cubeText, tokenBase, tokenEnd);
                if (eqKey(cubeText, tokenBase, firstEnd, "TITLE")
                        || eqKey(cubeText, tokenBase, firstEnd, "LUT_IN_VIDEO_RANGE")) {
                    // Metadata only.
                } else if (eqKey(cubeText, tokenBase, firstEnd, "DOMAIN_MIN")
                        || eqKey(cubeText, tokenBase, firstEnd, "DOMAIN_MAX")) {
                    if (words != 4) {
                        throw new IllegalArgumentException("DOMAIN line needs 3 finite components");
                    }
                    float[] domain = readTriple(cubeText, tokenBase, tokenEnd, true);
                    if (eqKey(cubeText, tokenBase, firstEnd, "DOMAIN_MIN")) {
                        domainMin = domain;
                    } else {
                        domainMax = domain;
                    }
                } else if (eqKey(cubeText, tokenBase, firstEnd, "LUT_1D_SIZE")
                        || eqKey(cubeText, tokenBase, firstEnd, "LUT_1D_INPUT_RANGE")) {
                    throw new IllegalArgumentException("1D cube is not a 3D LUT");
                } else if (eqKey(cubeText, tokenBase, firstEnd, "LUT_3D_SIZE")) {
                    if (words != 2 || samples != null) {
                        throw new IllegalArgumentException("LUT_3D_SIZE must appear once before samples");
                    }
                    size = parseSize(word(cubeText, firstEnd, tokenEnd));
                    long floats = (long) size * size * size * 3L;
                    if (floats > Integer.MAX_VALUE) {
                        throw new IllegalArgumentException("LUT_3D_SIZE is too large");
                    }
                    samples = new float[(int) floats];
                } else if (eqKey(cubeText, tokenBase, firstEnd, "LUT_3D_INPUT_RANGE")) {
                    if (words != 3) {
                        throw new IllegalArgumentException("LUT_3D_INPUT_RANGE needs two finite bounds");
                    }
                } else {
                    if (samples == null) {
                        throw new IllegalArgumentException("sample appears before LUT_3D_SIZE");
                    }
                    if (words != 3) {
                        throw new IllegalArgumentException("RGB sample must contain 3 values");
                    }
                    if (filled + 3 > samples.length) {
                        throw new IllegalArgumentException("too many RGB samples");
                    }
                    float[] rgb = readTriple(cubeText, tokenBase, tokenEnd, false);
                    samples[filled++] = rgb[0];
                    samples[filled++] = rgb[1];
                    samples[filled++] = rgb[2];
                }
            }
            if (lineEnd >= length) {
                break;
            }
            lineStart = lineEnd + 1;
            if (lineEnd < length && cubeText.charAt(lineEnd) == '\r' && lineStart < length
                    && cubeText.charAt(lineStart) == '\n') {
                lineStart++;
            }
        }
        if (size < 2 || samples == null || filled != samples.length) {
            throw new IllegalArgumentException("cube is missing LUT_3D_SIZE or the N^3 RGB samples");
        }
        if (domainMin != null && domainMax != null) {
            for (int channel = 0; channel < 3; channel++) {
                if (!(domainMin[channel] < domainMax[channel])) {
                    throw new IllegalArgumentException("DOMAIN_MIN must be below DOMAIN_MAX");
                }
            }
        }
        if (outSize != null && outSize.length > 0) {
            outSize[0] = size;
        }
        return samples;
    }

    private static int parseSize(String token) {
        if (token.isEmpty() || token.charAt(0) == '+' || token.charAt(0) == '-') {
            throw new IllegalArgumentException("LUT_3D_SIZE must be an integer from 2 to 64");
        }
        int size;
        try {
            size = Integer.parseInt(token);
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException("LUT_3D_SIZE must be an integer from 2 to 64");
        }
        if (size < 2 || size > MAX_CUBE_SIZE) {
            throw new IllegalArgumentException("LUT_3D_SIZE must be an integer from 2 to 64");
        }
        return size;
    }

    private static float[] readTriple(String text, int start, int end, boolean skipFirst) {
        int cursor = start;
        if (skipFirst) {
            cursor = wordEnd(text, cursor, end);
        }
        float[] rgb = new float[3];
        for (int channel = 0; channel < 3; channel++) {
            while (cursor < end && isSpace(text.charAt(cursor))) {
                cursor++;
            }
            int word = wordEnd(text, cursor, end);
            rgb[channel] = parseFinite(text.substring(cursor, word));
            cursor = word;
        }
        return rgb;
    }

    private static float parseFinite(String token) {
        final float value;
        try {
            value = Float.parseFloat(token);
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException("cube sample is not a number");
        }
        if (!Float.isFinite(value)) {
            throw new IllegalArgumentException("cube sample is not finite");
        }
        return value;
    }

    private static String word(String text, int start, int end) {
        while (start < end && isSpace(text.charAt(start))) {
            start++;
        }
        return text.substring(start, wordEnd(text, start, end));
    }

    private static int countWords(String text, int start, int end) {
        int words = 0;
        int cursor = start;
        while (cursor < end) {
            while (cursor < end && isSpace(text.charAt(cursor))) {
                cursor++;
            }
            if (cursor >= end) {
                break;
            }
            words++;
            cursor = wordEnd(text, cursor, end);
        }
        return words;
    }

    private static int wordEnd(String text, int start, int end) {
        int cursor = start;
        while (cursor < end && !isSpace(text.charAt(cursor))) {
            cursor++;
        }
        return cursor;
    }

    private static boolean eqKey(String text, int start, int end, String key) {
        return end - start == key.length() && text.regionMatches(true, start, key, 0, key.length());
    }

    private static boolean isSpace(char ch) {
        return ch == ' ' || ch == '\t';
    }
}
