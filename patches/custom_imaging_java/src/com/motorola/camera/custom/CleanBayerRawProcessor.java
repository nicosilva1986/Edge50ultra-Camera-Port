// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/** Converts Bayer sensor samples to opaque, row-major sRGB ARGB pixels. */
public final class CleanBayerRawProcessor {
    public static final int CFA_RGGB = 0;
    public static final int CFA_GRBG = 1;
    public static final int CFA_GBRG = 2;
    public static final int CFA_BGGR = 3;

    private static final int RED = 0;
    private static final int GREEN = 1;
    private static final int BLUE = 2;
    private static final int[][] CFA = {
        {RED, GREEN, GREEN, BLUE}, {GREEN, RED, BLUE, GREEN},
        {GREEN, BLUE, RED, GREEN}, {BLUE, GREEN, GREEN, RED}
    };
    private static final int GAMMA_STEPS = 4096;
    private static final float[] SRGB = new float[GAMMA_STEPS + 1];

    static {
        for (int i = 0; i <= GAMMA_STEPS; i++) {
            double linear = (double) i / GAMMA_STEPS;
            SRGB[i] = (float) (linear <= 0.0031308 ? 12.92 * linear
                    : 1.055 * Math.pow(linear, 1.0 / 2.4) - 0.055);
        }
    }

    private CleanBayerRawProcessor() {}

    public static int[] unpackRaw10ToInt(byte[] packed, int width, int height, int rowStride) {
        if ((width & 3) != 0 || (height & 1) != 0) {
            throw new IllegalArgumentException("RAW10 width must be divisible by 4 and height even");
        }
        int[] raw = allocateUnpacked(packed, width, height, rowStride, (long) width * 5 / 4);
        for (int y = 0; y < height; y++) {
            int src = y * rowStride;
            int dst = y * width;
            for (int x = 0; x < width; x += 4, src += 5, dst += 4) {
                int low = packed[src + 4] & 255;
                raw[dst] = ((packed[src] & 255) << 2) | (low & 3);
                raw[dst + 1] = ((packed[src + 1] & 255) << 2) | ((low >>> 2) & 3);
                raw[dst + 2] = ((packed[src + 2] & 255) << 2) | ((low >>> 4) & 3);
                raw[dst + 3] = ((packed[src + 3] & 255) << 2) | (low >>> 6);
            }
        }
        return raw;
    }

    public static int[] unpackRaw16ToInt(byte[] bytes, int width, int height, int rowStride,
                                         boolean littleEndian) {
        int[] raw = allocateUnpacked(bytes, width, height, rowStride, (long) width * 2);
        int highByte = littleEndian ? 1 : 0;
        int lowByte = highByte ^ 1;
        for (int y = 0; y < height; y++) {
            int src = y * rowStride;
            int dst = y * width;
            for (int x = 0; x < width; x++, src += 2) {
                raw[dst + x] = ((bytes[src + highByte] & 255) << 8) | (bytes[src + lowByte] & 255);
            }
        }
        return raw;
    }

    private static int[] allocateUnpacked(byte[] bytes, int width, int height, int stride,
                                          long rowBytes) {
        int count = pixelCount(width, height);
        if (bytes == null || stride < rowBytes || (long) (height - 1) * stride + rowBytes > bytes.length) {
            throw new IllegalArgumentException("Invalid RAW buffer or row stride");
        }
        return new int[count];
    }

    private static int pixelCount(int width, int height) {
        long count = (long) width * height;
        if (width <= 0 || height <= 0 || count > Integer.MAX_VALUE) {
            throw new IllegalArgumentException("Invalid image dimensions");
        }
        return (int) count;
    }

    /**
     * Converts a Bayer mosaic using optional Camera2 LensShadingMap gains, pre-demosaic
     * hot-pixel suppression, ISO-scaled chroma denoising, and headroom-damped sharpening.
     */
    public static int[] processRawToArgb(int[] raw, int width, int height, int cfaPattern,
                                         float[] blackLevel4, float whiteLevel, float[] wbGains3,
                                         float[] ccm3x3, float sharpenAmount,
                                         float[] lscGrid4, int lscCols, int lscRows,
                                         int isoSensitivity) {
        int count = pixelCount(width, height);
        if (width < 2 || height < 2 || raw == null || raw.length < count
                || cfaPattern < CFA_RGGB || cfaPattern > CFA_BGGR
                || blackLevel4 == null || blackLevel4.length != 4
                || wbGains3 == null || wbGains3.length != 3
                || !Float.isFinite(whiteLevel) || !Float.isFinite(sharpenAmount)) {
            throw new IllegalArgumentException("Invalid Bayer image or calibration");
        }
        int[] colors = CFA[cfaPattern];
        double[] inverseRange = new double[4];
        for (int site = 0; site < 4; site++) {
            double range = (double) whiteLevel - blackLevel4[site];
            if (range <= 0 || !Double.isFinite(range)) {
                throw new IllegalArgumentException("White level must exceed each finite black level");
            }
            inverseRange[site] = 1.0 / range;
        }
        for (float gain : wbGains3) {
            if (!Float.isFinite(gain) || gain < 0) {
                throw new IllegalArgumentException("White balance gains must be finite and nonnegative");
            }
        }

        boolean hasLsc = lscGrid4 != null && lscCols >= 2 && lscRows >= 2
                && lscGrid4.length >= lscCols * lscRows * 4;
        float[] mosaic = new float[count];
        for (int y = 0; y < height; y++) {
            int rowSite = (y & 1) << 1;
            float lscY = hasLsc ? (y * (lscRows - 1)) / (float) Math.max(1, height - 1) : 0f;
            int ly0 = hasLsc ? Math.min(lscRows - 2, (int) lscY) : 0;
            float fy = hasLsc ? lscY - ly0 : 0f;
            for (int x = 0, i = y * width; x < width; x++, i++) {
                int site = rowSite | (x & 1);
                double normalized = ((double) raw[i] - blackLevel4[site]) * inverseRange[site];
                double val = Math.max(0.0, Math.min(1.0, normalized)) * wbGains3[colors[site]];
                if (hasLsc) {
                    int color = colors[site];
                    boolean greenRedRow = ((y & 1) == 0) ^ (cfaPattern >= CFA_GBRG);
                    int lscCh = color == RED ? 0 : (color == BLUE ? 3 : (greenRedRow ? 1 : 2));
                    float lscX = (x * (lscCols - 1)) / (float) Math.max(1, width - 1);
                    int lx0 = Math.min(lscCols - 2, (int) lscX);
                    float fx = lscX - lx0;
                    int idx00 = ((ly0 * lscCols + lx0) << 2) + lscCh;
                    int idx10 = idx00 + 4;
                    int idx01 = idx00 + (lscCols << 2);
                    int idx11 = idx01 + 4;
                    float g0 = lscGrid4[idx00] + (lscGrid4[idx10] - lscGrid4[idx00]) * fx;
                    float g1 = lscGrid4[idx01] + (lscGrid4[idx11] - lscGrid4[idx01]) * fx;
                    float lscGain = g0 + (g1 - g0) * fy;
                    if (Float.isFinite(lscGain) && lscGain > 0.0f) {
                        val *= Math.max(0.8f, Math.min(8.0f, lscGain));
                    }
                }
                mosaic[i] = (float) val;
            }
        }

        if (width >= 6 && height >= 6) {
            clampBayerHotPixels(mosaic, width, height);
        }

        double[] matrix = normalizedMatrix(ccm3x3);
        float[] linR = new float[count];
        float[] linG = new float[count];
        float[] linB = new float[count];
        demosaicMalvar(mosaic, width, height, colors, matrix, linR, linG, linB);

        if (isoSensitivity > 150 && width >= 4 && height >= 4) {
            smoothChromaByIso(linR, linG, linB, width, height, isoSensitivity);
        }
        if (width >= 6 && height >= 6) {
            suppressDemosaicFringes(linR, linG, linB, width, height);
        }

        int[] argb = new int[count];
        float[] sRed = sharpenAmount > 0 ? new float[count] : null;
        float[] sGreen = sharpenAmount > 0 ? new float[count] : null;
        float[] sBlue = sharpenAmount > 0 ? new float[count] : null;
        float[] luma = sharpenAmount > 0 ? new float[count] : null;

        for (int i = 0; i < count; i++) {
            double cr = linR[i];
            double cg = linG[i];
            double cb = linB[i];
            double peak = Math.max(cr, Math.max(cg, cb));
            double scale = 1.0;
            if (peak > 0.84) {
                double excess = peak - 0.84;
                scale = (0.84 + 0.16 * (excess / (0.16 + excess))) / peak;
            }
            float sr = encode(cr * scale);
            float sg = encode(cg * scale);
            float sb = encode(cb * scale);
            if (luma == null) {
                argb[i] = pack(sr, sg, sb);
            } else {
                sRed[i] = sr;
                sGreen[i] = sg;
                sBlue[i] = sb;
                luma[i] = 0.2126f * sr + 0.7152f * sg + 0.0722f * sb;
            }
        }
        if (luma != null) {
            sharpenHeadroomDamped(argb, width, height, sRed, sGreen, sBlue, luma, sharpenAmount, isoSensitivity);
        }
        return argb;
    }

    private static void clampBayerHotPixels(float[] mosaic, int width, int height) {
        float[] src = mosaic.clone();
        int s2 = width * 2;
        for (int y = 2; y < height - 2; y++) {
            int row = y * width;
            for (int x = 2; x < width - 2; x++) {
                int i = row + x;
                float c = src[i];
                float n0 = src[i - s2 - 2], n1 = src[i - s2], n2 = src[i - s2 + 2];
                float n3 = src[i - 2],                           n4 = src[i + 2];
                float n5 = src[i + s2 - 2], n6 = src[i + s2], n7 = src[i + s2 + 2];
                float maxN = Math.max(Math.max(Math.max(n0, n1), Math.max(n2, n3)),
                                      Math.max(Math.max(n4, n5), Math.max(n6, n7)));
                float minN = Math.min(Math.min(Math.min(n0, n1), Math.min(n2, n3)),
                                      Math.min(Math.min(n4, n5), Math.min(n6, n7)));
                if (c > maxN * 1.75f + 0.02f) {
                    mosaic[i] = maxN;
                } else if (c < minN * 0.40f && minN > 0.04f) {
                    mosaic[i] = minN;
                }
            }
        }
    }

    private static void demosaicMalvar(float[] mosaic, int width, int height, int[] colors,
                                       double[] matrix, float[] outR, float[] outG, float[] outB) {
        for (int y = 0; y < height; y++) {
            int up = y == 0 ? width : -width;
            int down = y == height - 1 ? -width : width;
            for (int x = 0, i = y * width; x < width; x++, i++) {
                int left = x == 0 ? 1 : -1;
                int right = x == width - 1 ? -1 : 1;
                int site = ((y & 1) << 1) | (x & 1);
                int color = colors[site];
                double center = mosaic[i];
                double horizontal = (double) mosaic[i + left] + mosaic[i + right];
                double vertical = (double) mosaic[i + up] + mosaic[i + down];
                double diagonals = (double) mosaic[i + up + left] + mosaic[i + up + right]
                        + mosaic[i + down + left] + mosaic[i + down + right];
                boolean interior = x >= 2 && x < width - 2 && y >= 2 && y < height - 2;
                double h2 = interior ? (double) mosaic[i - 2] + mosaic[i + 2] : 0;
                double v2 = interior ? (double) mosaic[i - 2 * width] + mosaic[i + 2 * width] : 0;

                double r, g, b;
                if (color == GREEN) {
                    g = center;
                    double h = interior ? (5 * center + 4 * horizontal - diagonals - h2 + 0.5 * v2) / 8 : horizontal / 2;
                    double v = interior ? (5 * center + 4 * vertical - diagonals - v2 + 0.5 * h2) / 8 : vertical / 2;
                    boolean redHorizontal = colors[site ^ 1] == RED;
                    r = redHorizontal ? h : v;
                    b = redHorizontal ? v : h;
                } else {
                    g = interior ? (4 * center + 2 * (horizontal + vertical) - h2 - v2) / 8 : (horizontal + vertical) / 4;
                    double opposite = interior ? (6 * center + 2 * diagonals - 1.5 * (h2 + v2)) / 8 : diagonals / 4;
                    r = color == RED ? center : opposite;
                    b = color == BLUE ? center : opposite;
                }
                outR[i] = (float) Math.max(0.0, matrix[0] * r + matrix[1] * g + matrix[2] * b);
                outG[i] = (float) Math.max(0.0, matrix[3] * r + matrix[4] * g + matrix[5] * b);
                outB[i] = (float) Math.max(0.0, matrix[6] * r + matrix[7] * g + matrix[8] * b);
            }
        }
    }

    /** Edge-preserving chroma-only denoise in linear YCbCr leaving luminance detail untouched. */
    private static void smoothChromaByIso(float[] rArr, float[] gArr, float[] bArr,
                                          int width, int height, int iso) {
        int count = width * height;
        float[] yArr = new float[count];
        float[] cbArr = new float[count];
        float[] crArr = new float[count];
        for (int i = 0; i < count; i++) {
            float y = 0.2126f * rArr[i] + 0.7152f * gArr[i] + 0.0722f * bArr[i];
            yArr[i] = y;
            cbArr[i] = bArr[i] - y;
            crArr[i] = rArr[i] - y;
        }
        float strength = Math.min(1f, (iso - 150f) / 1400f);
        float invLumaThresh = 1f / (0.04f + 0.06f * strength);
        for (int y = 1; y < height - 1; y++) {
            int row = y * width;
            for (int x = 1; x < width - 1; x++) {
                int i = row + x;
                float yc = yArr[i];
                float accCb = cbArr[i], accCr = crArr[i], wSum = 1f;
                for (int dy = -1; dy <= 1; dy++) {
                    int nRow = (y + dy) * width;
                    for (int dx = -1; dx <= 1; dx++) {
                        if (dx == 0 && dy == 0) continue;
                        int ni = nRow + x + dx;
                        float dyL = Math.abs(yArr[ni] - yc) * invLumaThresh;
                        float w = dyL >= 1f ? 0f : (1f - dyL);
                        accCb += cbArr[ni] * w;
                        accCr += crArr[ni] * w;
                        wSum += w;
                    }
                }
                float fCb = cbArr[i] + (accCb / wSum - cbArr[i]) * (0.35f + 0.55f * strength);
                float fCr = crArr[i] + (accCr / wSum - crArr[i]) * (0.35f + 0.55f * strength);
                float rr = yc + fCr;
                float bb = yc + fCb;
                float gg = (yc - 0.2126f * rr - 0.0722f * bb) / 0.7152f;
                rArr[i] = Math.max(0f, rr);
                gArr[i] = Math.max(0f, gg);
                bArr[i] = Math.max(0f, bb);
            }
        }
    }

    /**
     * Suppresses 1-pixel chromatic demosaic fringes along high-contrast edges by pulling
     * anomalous color-difference spikes (R-G, B-G) toward the calmest same-brightness neighbor
     * while strictly conserving pixel luminance and preserving solid saturated edges.
     */
    private static void suppressDemosaicFringes(float[] rArr, float[] gArr, float[] bArr,
                                                int width, int height) {
        int count = width * height;
        float[] origRG = new float[count];
        float[] origBG = new float[count];
        for (int i = 0; i < count; i++) {
            origRG[i] = rArr[i] - gArr[i];
            origBG[i] = bArr[i] - gArr[i];
        }
        for (int y = 1; y < height - 1; y++) {
            int row = y * width;
            for (int x = 1; x < width - 1; x++) {
                int i = row + x;
                float gc = gArr[i];
                float gu = gArr[i - width], gd = gArr[i + width];
                float gl = gArr[i - 1], gr = gArr[i + 1];
                float gSpan = Math.max(Math.max(gc, gu), Math.max(gd, Math.max(gl, gr)))
                            - Math.min(Math.min(gc, gu), Math.min(gd, Math.min(gl, gr)));
                if (gSpan < 0.14f) {
                    continue;
                }
                float rg = origRG[i];
                float bg = origBG[i];
                float bestRG = rg;
                float bestBG = bg;
                float origMag = rg * rg + bg * bg;
                float bestChromaMag = origMag;
                boolean foundSameSide = false;
                for (int dy = -1; dy <= 1; dy++) {
                    int nRow = (y + dy) * width;
                    for (int dx = -1; dx <= 1; dx++) {
                        if (dx == 0 && dy == 0) continue;
                        int ni = nRow + x + dx;
                        if (Math.abs(gArr[ni] - gc) < 0.08f) {
                            float nrg = origRG[ni];
                            float nbg = origBG[ni];
                            float mag = nrg * nrg + nbg * nbg;
                            if (mag < bestChromaMag) {
                                bestChromaMag = mag;
                                bestRG = nrg;
                                bestBG = nbg;
                                foundSameSide = true;
                            }
                        }
                    }
                }
                // Check 2-pixel cardinal steps outside the 5x5 Malvar second-shell fringe zone.
                for (int s = 0; s < 4; s++) {
                    int nx = x + (s == 0 ? -2 : (s == 1 ? 2 : 0));
                    int ny = y + (s == 2 ? -2 : (s == 3 ? 2 : 0));
                    if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
                        int ni = ny * width + nx;
                        if (Math.abs(gArr[ni] - gc) < 0.08f) {
                            float nrg = origRG[ni];
                            float nbg = origBG[ni];
                            float mag = nrg * nrg + nbg * nbg;
                            if (mag < bestChromaMag) {
                                bestChromaMag = mag;
                                bestRG = nrg;
                                bestBG = nbg;
                                foundSameSide = true;
                            }
                        }
                    }
                }
                if (!foundSameSide || origMag <= 2.25f * bestChromaMag + 0.0005f) {
                    continue;
                }
                float crg = rg + (bestRG - rg) * 0.80f;
                float cbg = bg + (bestBG - bg) * 0.80f;
                if (crg != rg || cbg != bg) {
                    float yLum = 0.2126f * rArr[i] + 0.7152f * gArr[i] + 0.0722f * bArr[i];
                    float gNew = yLum - 0.2126f * crg - 0.0722f * cbg;
                    if (gNew >= 0f) {
                        rArr[i] = Math.max(0f, gNew + crg);
                        gArr[i] = gNew;
                        bArr[i] = Math.max(0f, gNew + cbg);
                    } else {
                        float scale = yLum / Math.max(1e-5f, 0.2126f * crg + 0.0722f * cbg);
                        float s = Math.max(0f, Math.min(1f, scale));
                        rArr[i] = Math.max(0f, (yLum - 0.2126f * crg * s - 0.0722f * cbg * s) + crg * s);
                        gArr[i] = Math.max(0f, yLum - 0.2126f * crg * s - 0.0722f * cbg * s);
                        bArr[i] = Math.max(0f, (yLum - 0.2126f * crg * s - 0.0722f * cbg * s) + cbg * s);
                    }
                }
            }
        }
    }

    /**
     * Directional gradient-weighted + noise-floor-gated symmetric sharpening:
     * keeps smooth ISO-grainy areas untouched and eliminates white halos on dark wires.
     */
    private static void sharpenHeadroomDamped(int[] argb, int width, int height, float[] red,
                                              float[] green, float[] blue, float[] luma,
                                              float amount, int iso) {
        final int[] oppX = {-1, 0, -1, 1};
        final int[] oppY = {0, -1, -1, -1};
        float isoDamp = 1.0f / (1.0f + Math.max(0, iso - 200) / 1400.0f);
        float effAmount = amount * isoDamp;
        for (int y = 0; y < height; y++) {
            for (int x = 0, i = y * width; x < width; x++, i++) {
                float yc = luma[i];
                float minY = yc, maxY = yc;
                float wNum = 0f;
                float wDen = 0f;
                float maxGrad = 0f;
                for (int k = 0; k < 4; k++) {
                    int x1 = Math.max(0, Math.min(width - 1, x + oppX[k]));
                    int y1 = Math.max(0, Math.min(height - 1, y + oppY[k]));
                    int x2 = Math.max(0, Math.min(width - 1, x - oppX[k]));
                    int y2 = Math.max(0, Math.min(height - 1, y - oppY[k]));
                    float a = luma[y1 * width + x1];
                    float b = luma[y2 * width + x2];
                    if (a < minY) minY = a;
                    if (b < minY) minY = b;
                    if (a > maxY) maxY = a;
                    if (b > maxY) maxY = b;
                    float gAxis = Math.abs(a - b);
                    if (gAxis > maxGrad) maxGrad = gAxis;
                    // Focus sharpening weight across strong local edge axes (reduces diagonal zipper).
                    float axisW = 0.02f + gAxis;
                    float symSample = (Math.abs(a - yc) <= Math.abs(b - yc)) ? a : b;
                    wNum += symSample * axisW;
                    wDen += axisW;
                }
                float tGate = clamp01((maxGrad - 0.012f) / 0.033f);
                float flatGate = tGate * tGate * (3f - 2f * tGate);
                float meanSym = wDen > 0f ? (wNum / wDen) : yc;
                float delta = (yc - meanSym) * effAmount * flatGate;
                float dMax = Math.max(0f, maxY - yc);
                float dMin = Math.max(0f, yc - minY);
                float headroom = delta > 0f
                        ? Math.min(1f - Math.max(red[i], Math.max(green[i], blue[i])), dMax * 0.5f)
                        : Math.min(Math.min(red[i], Math.min(green[i], blue[i])), dMin * 0.5f);
                float limit = Math.max(0f, Math.min(headroom, 3.0f / 255f));
                float boost = limit <= 0f ? 0f : (float) (delta * limit / (limit + Math.abs(delta)));
                argb[i] = pack(clamp01(red[i] + boost), clamp01(green[i] + boost), clamp01(blue[i] + boost));
            }
        }
    }

    private static float clamp01(float v) {
        return v < 0f ? 0f : (v > 1f ? 1f : v);
    }

    /**
     * Processes a mosaic of at least 2 by 2 pixels. Black levels are in row-major
     * CFA tile order. Gains are in RGB order and the optional matrix is row-major.
     */
    public static int[] processRawToArgb(int[] raw, int width, int height, int cfaPattern,
                                         float[] blackLevel4, float whiteLevel, float[] wbGains3,
                                         float[] ccm3x3, float sharpenAmount) {
        int count = pixelCount(width, height);
        if (width < 2 || height < 2 || raw == null || raw.length < count
                || cfaPattern < CFA_RGGB || cfaPattern > CFA_BGGR
                || blackLevel4 == null || blackLevel4.length != 4
                || wbGains3 == null || wbGains3.length != 3
                || !Float.isFinite(whiteLevel) || !Float.isFinite(sharpenAmount)) {
            throw new IllegalArgumentException("Invalid Bayer image or calibration");
        }
        int[] colors = CFA[cfaPattern];
        double[] inverseRange = new double[4];
        for (int site = 0; site < 4; site++) {
            double range = (double) whiteLevel - blackLevel4[site];
            if (range <= 0 || !Double.isFinite(range)) {
                throw new IllegalArgumentException("White level must exceed each finite black level");
            }
            inverseRange[site] = 1 / range;
        }
        for (float gain : wbGains3) {
            if (!Float.isFinite(gain) || gain < 0) {
                throw new IllegalArgumentException("White balance gains must be finite and nonnegative");
            }
        }

        float[] mosaic = new float[count];
        for (int y = 0; y < height; y++) {
            int rowSite = (y & 1) << 1;
            for (int x = 0, i = y * width; x < width; x++, i++) {
                int site = rowSite | (x & 1);
                double normalized = ((double) raw[i] - blackLevel4[site]) * inverseRange[site];
                mosaic[i] = (float) (Math.max(0, Math.min(1, normalized)) * wbGains3[colors[site]]);
            }
        }

        double[] matrix = normalizedMatrix(ccm3x3);
        int[] argb = new int[count];
        // Quantize only after sharpening. Luma is read from an unmodified frame.
        float[] red = sharpenAmount > 0 ? new float[count] : null;
        float[] green = sharpenAmount > 0 ? new float[count] : null;
        float[] blue = sharpenAmount > 0 ? new float[count] : null;
        float[] luma = sharpenAmount > 0 ? new float[count] : null;

        for (int y = 0; y < height; y++) {
            int up = y == 0 ? width : -width;
            int down = y == height - 1 ? -width : width;
            for (int x = 0, i = y * width; x < width; x++, i++) {
                int left = x == 0 ? 1 : -1;
                int right = x == width - 1 ? -1 : 1;
                int site = ((y & 1) << 1) | (x & 1);
                int color = colors[site];
                double center = mosaic[i];
                double horizontal = (double) mosaic[i + left] + mosaic[i + right];
                double vertical = (double) mosaic[i + up] + mosaic[i + down];
                double diagonals = (double) mosaic[i + up + left] + mosaic[i + up + right]
                        + mosaic[i + down + left] + mosaic[i + down + right];
                boolean interior = x >= 2 && x < width - 2 && y >= 2 && y < height - 2;
                double h2 = 0;
                double v2 = 0;
                if (interior) {
                    h2 = (double) mosaic[i - 2] + mosaic[i + 2];
                    v2 = (double) mosaic[i - 2 * width] + mosaic[i + 2 * width];
                }

                // The four 5x5 filters in Malvar, He and Cutler (ICASSP 2004).
                // At green sites the vertical chroma filter is the transpose of the horizontal one.
                double r;
                double g;
                double b;
                if (color == GREEN) {
                    g = center;
                    double h = interior
                            ? (5 * center + 4 * horizontal - diagonals - h2 + 0.5 * v2) / 8
                            : horizontal / 2;
                    double v = interior
                            ? (5 * center + 4 * vertical - diagonals - v2 + 0.5 * h2) / 8
                            : vertical / 2;
                    boolean redHorizontal = colors[site ^ 1] == RED;
                    r = redHorizontal ? h : v;
                    b = redHorizontal ? v : h;
                } else {
                    g = interior ? (4 * center + 2 * (horizontal + vertical) - h2 - v2) / 8
                            : (horizontal + vertical) / 4;
                    double opposite = interior ? (6 * center + 2 * diagonals - 1.5 * (h2 + v2)) / 8
                            : diagonals / 4;
                    r = color == RED ? center : opposite;
                    b = color == BLUE ? center : opposite;
                }

                double correctedR = matrix[0] * r + matrix[1] * g + matrix[2] * b;
                double correctedG = matrix[3] * r + matrix[4] * g + matrix[5] * b;
                double correctedB = matrix[6] * r + matrix[7] * g + matrix[8] * b;
                double peak = Math.max(correctedR, Math.max(correctedG, correctedB));
                double scale = 1;
                if (peak > 0.8) {
                    double excess = peak - 0.8;
                    // Match the slope at the knee and approach 1 asymptotically.
                    scale = (0.8 + 0.2 * (excess / (0.2 + excess))) / peak;
                }
                float sr = encode(correctedR * scale);
                float sg = encode(correctedG * scale);
                float sb = encode(correctedB * scale);
                if (luma == null) {
                    argb[i] = pack(sr, sg, sb);
                } else {
                    red[i] = sr;
                    green[i] = sg;
                    blue[i] = sb;
                    luma[i] = 0.2126f * sr + 0.7152f * sg + 0.0722f * sb;
                }
            }
        }
        if (luma != null) {
            sharpen(argb, width, height, red, green, blue, luma, sharpenAmount);
        }
        return argb;
    }

    private static double[] normalizedMatrix(float[] input) {
        double[] matrix = {1, 0, 0, 0, 1, 0, 0, 0, 1};
        if (input != null && input.length == 9) {
            for (int i = 0; i < 9; i += 3) {
                double sum = (double) input[i] + input[i + 1] + input[i + 2];
                double magnitude = Math.abs((double) input[i]) + Math.abs((double) input[i + 1])
                        + Math.abs((double) input[i + 2]);
                if (Double.isFinite(sum) && Math.abs(sum) > Math.max(1e-8, magnitude * 1e-6)) {
                    matrix[i] = input[i] / sum;
                    matrix[i + 1] = input[i + 1] / sum;
                    matrix[i + 2] = input[i + 2] / sum;
                }
            }
        }
        return matrix;
    }

    private static float encode(double linear) {
        if (linear <= 0) {
            return 0;
        }
        if (linear >= 1) {
            return 1;
        }
        double position = linear * GAMMA_STEPS;
        int lower = (int) position;
        return (float) (SRGB[lower] + (position - lower) * (SRGB[lower + 1] - SRGB[lower]));
    }

    private static void sharpen(int[] argb, int width, int height, float[] red, float[] green,
                                float[] blue, float[] luma, float amount) {
        for (int y = 0; y < height; y++) {
            int up = y == 0 ? 0 : -width;
            int down = y == height - 1 ? 0 : width;
            for (int x = 0, i = y * width; x < width; x++, i++) {
                int left = x == 0 ? 0 : -1;
                int right = x == width - 1 ? 0 : 1;
                float blur = (luma[i + up + left] + luma[i + up] + luma[i + up + right]
                        + luma[i + left] + luma[i] + luma[i + right]
                        + luma[i + down + left] + luma[i + down] + luma[i + down + right]) / 9;
                double delta = (luma[i] - blur) * (double) amount;
                double room = delta > 0 ? 1 - Math.max(red[i], Math.max(green[i], blue[i]))
                        : Math.min(red[i], Math.min(green[i], blue[i]));
                // Limit boosted edges to four sRGB code values and preserve channel differences.
                double limit = Math.min(room, 4.0 / 255);
                float boost = (float) (limit == 0 ? 0 : delta * limit / (limit + Math.abs(delta)));
                argb[i] = pack(red[i] + boost, green[i] + boost, blue[i] + boost);
            }
        }
    }

    private static int pack(float r, float g, float b) {
        return 0xff000000 | (Math.round(r * 255) << 16) | (Math.round(g * 255) << 8)
                | Math.round(b * 255);
    }
}
