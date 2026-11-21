// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Deterministic 17³ RGB display LUT for three photographic styles.
 * Tables are built once per style. Pixel application does not allocate.
 */
public final class AppleStyleToneEngine {
    public static final int STYLE_NONE = 0;
    public static final int STYLE_IPHONE_NATURAL = 1;
    public static final int STYLE_IPHONE_RICH_CONTRAST = 2;
    public static final int STYLE_IPHONE_AMBER = 3;

    private static final int GRID = 17;
    private static final int CELLS = GRID - 1;
    private static final int LUT_FLOATS = GRID * GRID * GRID * 3;
    private static final int MAX_CUBE_SIZE = 64;

    private static final Object LUT_LOCK = new Object();
    private static volatile float[] lutNatural;
    private static volatile float[] lutRich;
    private static volatile float[] lutAmber;

    private AppleStyleToneEngine() {}

    public static void applyToArgbPixels(int[] argb, int width, int height, int styleId) {
        if (argb == null || width <= 0 || height <= 0) {
            return;
        }
        if (styleId < STYLE_IPHONE_NATURAL || styleId > STYLE_IPHONE_AMBER) {
            return;
        }
        long requested = (long) width * (long) height;
        int count = (int) Math.min(argb.length, requested);
        float[] lut = lutFor(styleId);
        for (int i = 0; i < count; i++) {
            int pixel = argb[i];
            int alpha = pixel & 0xFF000000;
            int red = (pixel >>> 16) & 255;
            int green = (pixel >>> 8) & 255;
            int blue = pixel & 255;
            if (red == green && green == blue) {
                // Neutral pixels use the diagonal only. A full cell would blend in
                // one-step colors and tint gray.
                int i0 = axisIndex(red);
                int i1 = i0 >= CELLS ? CELLS : i0 + 1;
                float frac = axisFrac(red, i0);
                int outR = toByte(lerp(at(lut, i0, i0, i0, 0), at(lut, i1, i1, i1, 0), frac));
                int outG = toByte(lerp(at(lut, i0, i0, i0, 1), at(lut, i1, i1, i1, 1), frac));
                int outB = toByte(lerp(at(lut, i0, i0, i0, 2), at(lut, i1, i1, i1, 2), frac));
                argb[i] = alpha | (outR << 16) | (outG << 8) | outB;
                continue;
            }
            int r0 = axisIndex(red);
            int g0 = axisIndex(green);
            int b0 = axisIndex(blue);
            float rf = axisFrac(red, r0);
            float gf = axisFrac(green, g0);
            float bf = axisFrac(blue, b0);
            int r1 = r0 == CELLS ? r0 : r0 + 1;
            int g1 = g0 == CELLS ? g0 : g0 + 1;
            int b1 = b0 == CELLS ? b0 : b0 + 1;

            int outR = toByte(trilinear(lut, r0, r1, g0, g1, b0, b1, rf, gf, bf, 0));
            int outG = toByte(trilinear(lut, r0, r1, g0, g1, b0, b1, rf, gf, bf, 1));
            int outB = toByte(trilinear(lut, r0, r1, g0, g1, b0, b1, rf, gf, bf, 2));
            argb[i] = alpha | (outR << 16) | (outG << 8) | outB;
        }
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

    private static float[] lutFor(int styleId) {
        float[] cached = cachedLut(styleId);
        if (cached != null) {
            return cached;
        }
        synchronized (LUT_LOCK) {
            cached = cachedLut(styleId);
            if (cached != null) {
                return cached;
            }
            float[] built = new float[LUT_FLOATS];
            float[] graded = new float[3];
            for (int red = 0; red < GRID; red++) {
                float r = red / (float) CELLS;
                for (int green = 0; green < GRID; green++) {
                    float g = green / (float) CELLS;
                    for (int blue = 0; blue < GRID; blue++) {
                        grade(styleId, r, g, blue / (float) CELLS, graded);
                        int index = (((red * GRID) + green) * GRID + blue) * 3;
                        built[index] = graded[0];
                        built[index + 1] = graded[1];
                        built[index + 2] = graded[2];
                    }
                }
            }
            // Pure black and white stay anchors even if a future curve drifts.
            built[0] = 0f;
            built[1] = 0f;
            built[2] = 0f;
            int white = LUT_FLOATS - 3;
            built[white] = 1f;
            built[white + 1] = 1f;
            built[white + 2] = 1f;
            storeLut(styleId, built);
            return built;
        }
    }

    private static float[] cachedLut(int styleId) {
        if (styleId == STYLE_IPHONE_NATURAL) {
            return lutNatural;
        }
        if (styleId == STYLE_IPHONE_RICH_CONTRAST) {
            return lutRich;
        }
        return lutAmber;
    }

    private static void storeLut(int styleId, float[] built) {
        if (styleId == STYLE_IPHONE_NATURAL) {
            lutNatural = built;
        } else if (styleId == STYLE_IPHONE_RICH_CONTRAST) {
            lutRich = built;
        } else {
            lutAmber = built;
        }
    }

    private static void grade(int style, float inR, float inG, float inB, float[] out) {
        boolean rich = style == STYLE_IPHONE_RICH_CONTRAST;
        float r = rich ? toneRich(inR) : toneNatural(inR);
        float g = rich ? toneRich(inG) : toneNatural(inG);
        float b = rich ? toneRich(inB) : toneNatural(inB);
        float luma = 0.2126f * r + 0.7152f * g + 0.0722f * b;
        float cr = r - luma;
        float cg = g - luma;
        float cb = b - luma;
        float chroma = Math.abs(cr) + Math.abs(cg) + Math.abs(cb);
        // A neutral pixel's trilinear cell reaches one grid step (chroma about 0.08).
        // Leave that shell as a separable tone curve so gray ramps stay neutral.
        float gate = (chroma - 0.12f) * 10f;
        if (gate > 0f) {
            if (gate > 1f) {
                gate = 1f;
            }
            float sat = 1f;
            if (cg > 0f) {
                // Pull vivid foliage back toward the neutral axis.
                sat *= 1f - 0.30f * (cg / chroma);
            }
            if (cr < 0f && cg > 0f && cb > 0f) {
                sat *= 0.88f;
            }
            float skyG = cg;
            float skyB = cb;
            if (cb > 0.02f && cr < 0f && b > g && b > r) {
                skyG *= 0.78f;
                skyB *= 1.08f;
            }
            if (!rich && r > g && g > b && luma > 0.22f && luma < 0.88f) {
                cr += 0.012f;
                skyB -= 0.008f;
            }
            float gradedR = luma + sat * cr;
            float gradedG = luma + sat * skyG;
            float gradedB = luma + sat * skyB;
            float weight = warmth(luma);
            if (style == STYLE_IPHONE_NATURAL) {
                gradedR += 0.016f * weight;
                gradedG += 0.005f * weight;
                gradedB -= 0.010f * weight;
            } else if (style == STYLE_IPHONE_AMBER) {
                // Golden shoulder on R/G. Deep shadows stay neutral because warmth() is 0 there.
                gradedR += 0.052f * weight;
                gradedG += 0.022f * weight;
                gradedB -= 0.040f * weight;
            }
            r += (gradedR - r) * gate;
            g += (gradedG - g) * gate;
            b += (gradedB - b) * gate;
        }
        out[0] = clamp01(r);
        out[1] = clamp01(g);
        out[2] = clamp01(b);
    }

    /** Gentle shoulder above 0.72 and a small shadow opening around the 0.18 pivot. Pins 0 and 1. */
    private static float toneNatural(float x) {
        if (x <= 0f) {
            return 0f;
        }
        if (x >= 1f) {
            return 1f;
        }
        if (x <= 0.72f) {
            return clamp01(x + 0.045f * x * (float) Math.exp(-x / 0.18f));
        }
        float y0 = 0.72f + 0.045f * 0.72f * (float) Math.exp(-0.72f / 0.18f);
        float u = (x - 0.72f) / 0.28f;
        return clamp01(y0 + (1f - y0) * shoulderShape(u, 0.8f));
    }

    /** Darker toe, steeper mids, then a crisp shoulder that still lands on white. */
    private static float toneRich(float x) {
        if (x <= 0f) {
            return 0f;
        }
        if (x >= 1f) {
            return 1f;
        }
        if (x < 0.20f) {
            float n = x / 0.20f;
            return 0.16f * (float) Math.pow(n, 1.65);
        }
        if (x < 0.70f) {
            float u = (x - 0.20f) / 0.50f;
            return 0.16f + u * 0.62f;
        }
        float u = (x - 0.70f) / 0.30f;
        return clamp01(0.78f + 0.22f * shoulderShape(u, 0.55f));
    }

    /** Value 0 at u=0 and 1 at u=1, start slope {@code s0}, end slope 0. */
    private static float shoulderShape(float u, float s0) {
        float u2 = u * u;
        return (s0 * u) + ((3f - 2f * s0) * u2) + ((s0 - 2f) * u2 * u);
    }

    /** Zero at and below 0.12 and at 1, peaking on sunlit highlights near 0.71. */
    private static float warmth(float y) {
        if (y <= 0.12f || y >= 1f) {
            return 0f;
        }
        float t = y - 0.12f;
        float hump = t * t * (1f - y);
        float weight = hump * (1f / 0.1009588f);
        return weight > 1f ? 1f : weight;
    }

    private static float lerp(float a, float b, float t) {
        return a + (b - a) * t;
    }

    private static float trilinear(float[] lut, int r0, int r1, int g0, int g1, int b0, int b1,
                                   float rf, float gf, float bf, int channel) {
        float c000 = at(lut, r0, g0, b0, channel);
        float c100 = at(lut, r1, g0, b0, channel);
        float c010 = at(lut, r0, g1, b0, channel);
        float c110 = at(lut, r1, g1, b0, channel);
        float c001 = at(lut, r0, g0, b1, channel);
        float c101 = at(lut, r1, g0, b1, channel);
        float c011 = at(lut, r0, g1, b1, channel);
        float c111 = at(lut, r1, g1, b1, channel);
        float c00 = c000 + (c100 - c000) * rf;
        float c10 = c010 + (c110 - c010) * rf;
        float c01 = c001 + (c101 - c001) * rf;
        float c11 = c011 + (c111 - c011) * rf;
        float c0 = c00 + (c10 - c00) * gf;
        float c1 = c01 + (c11 - c01) * gf;
        return c0 + (c1 - c0) * bf;
    }

    private static float at(float[] lut, int red, int green, int blue, int channel) {
        return lut[(((red * GRID) + green) * GRID + blue) * 3 + channel];
    }

    private static int axisIndex(int value) {
        if (value <= 0) {
            return 0;
        }
        if (value >= 255) {
            return CELLS;
        }
        return (int) (value * (CELLS / 255f));
    }

    private static float axisFrac(int value, int index) {
        if (value <= 0 || value >= 255 || index >= CELLS) {
            return 0f;
        }
        return value * (CELLS / 255f) - index;
    }

    private static int toByte(float value) {
        if (value <= 0f) {
            return 0;
        }
        if (value >= 1f) {
            return 255;
        }
        return (int) (value * 255f + 0.5f);
    }

    private static float clamp01(float value) {
        if (value < 0f) {
            return 0f;
        }
        if (value > 1f) {
            return 1f;
        }
        return value;
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
        int length = end - start;
        return length == key.length() && text.regionMatches(true, start, key, 0, length);
    }

    private static boolean isSpace(char ch) {
        return ch == ' ' || ch == '\t' || ch == '\f';
    }
}
