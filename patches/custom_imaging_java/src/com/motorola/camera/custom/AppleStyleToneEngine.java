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

                argb[i] = gradePixel(alpha, r, g, b, isGray, localBase, styleId);
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
        float[] tmp = new float[gw * gh];
        float[] out = new float[gw * gh];
        final float inv2SigmaR2 = 1f / (2f * 0.40f * 0.40f);
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

    private static int gradePixel(int alpha, float r, float g, float b, boolean isGray,
                                  float baseLogY, int style) {
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
