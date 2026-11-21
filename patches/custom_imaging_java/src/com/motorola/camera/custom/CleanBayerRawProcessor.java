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
