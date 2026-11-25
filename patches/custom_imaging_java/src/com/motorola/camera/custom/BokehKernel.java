// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/** Aperture samples shared by the CPU and GPU gather paths (linear-light HDR specular bokeh). */
final class BokehKernel {
    static final int TAPS = 32;
    private static final float[] LINEAR = new float[256];
    private static final int[] SRGB = new int[4097];

    static {
        for (int i = 0; i < LINEAR.length; i++) {
            double s = i / 255.0;
            LINEAR[i] = (float) (s <= 0.04045 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4));
        }
        for (int i = 0; i < SRGB.length; i++) {
            double l = i / 4096.0;
            SRGB[i] = (int) Math.round(255.0 * (l <= 0.0031308 ? 12.92 * l : 1.055 * Math.pow(l, 1.0 / 2.4) - 0.055));
        }
    }

    private BokehKernel() {}

    static float[] aperture(int style) {
        float[] taps = new float[TAPS * 3];
        int blades = style == 5 ? 3 : style == 2 ? 7 : 0;
        for (int i = 0; i < TAPS; i++) {
            double angle = i * Math.PI * (3 - Math.sqrt(5));
            double radius = Math.sqrt((i + 0.5) / TAPS);
            if (blades > 0) {
                double cycle = 2 * Math.PI / blades;
                radius *= Math.cos(cycle / 2) / Math.cos(angle % cycle - cycle / 2);
            }
            taps[3 * i] = (float) (Math.cos(angle) * radius * (style == 4 ? 0.5 : 1));
            taps[3 * i + 1] = (float) (Math.sin(angle) * radius);
            taps[3 * i + 2] = style == 1 ? (float) (0.7 + 0.7 * radius * radius)
                    : style == 3 ? (float) Math.exp(-3 * radius * radius) : 1f;
        }
        return taps;
    }

    static float coc(int depth, int focus) {
        float t = Math.min(1f, Math.max(0f, (Math.abs(depth - focus) - 3f) / 68f));
        return t * t * (3 - 2 * t);
    }

    private static float depthWeight(int d, int sampleDepth, int focus, float blur) {
        if (coc(sampleDepth, focus) < blur * 0.38f) {
            return 0f;
        }
        float diff = Math.abs(d - sampleDepth);
        if (diff <= 18f) return 1f;
        if (diff >= 46f) return 0f;
        float t = (diff - 18f) / 28f;
        return 1f - t * t * (3f - 2f * t);
    }

    static int[] gather(int[] image, byte[] depth, int width, int height, int focus, int style) {
        return gather(image, depth, width, height, focus, style, 1.0f);
    }

    static int[] gather(int[] image, byte[] depth, int width, int height, int focus, int style, float radiusScale) {
        float[] taps = aperture(style);
        int[] output = new int[image.length];
        float safeScale = Math.max(0.70f, Math.min(1.45f, Float.isFinite(radiusScale) ? radiusScale : 1.0f));
        float radius = Math.max(2f, Math.min(width, height) * 0.027f * safeScale);
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int position = y * width + x;
                int d = depth[position] & 255;
                float blur = coc(d, focus);
                if (blur < 0.02f) {
                    output[position] = image[position];
                    continue;
                }
                float cx = (x + 0.5f) / width - 0.5f;
                float cy = (y + 0.5f) / height - 0.5f;
                float edge = (float) Math.sqrt(cx * cx + cy * cy);
                float nx = edge > 0 ? cx / edge : 0;
                float ny = edge > 0 ? cy / edge : 0;
                float cos = style == 1 ? (float) Math.cos(1.7f * edge * blur) : 1;
                float sin = style == 1 ? (float) Math.sin(1.7f * edge * blur) : 0;
                float sum = 0, red = 0, green = 0, blue = 0;
                for (int i = 0; i < taps.length; i += 3) {
                    float dx = taps[i] * cos - taps[i + 1] * sin;
                    float dy = taps[i] * sin + taps[i + 1] * cos;
                    if (style == 1) {
                        float radial = (nx * dx + ny * dy) * edge * 0.80f;
                        dx -= radial * nx;
                        dy -= radial * ny;
                    } else if (style != 4) {
                        float radial = (nx * dx + ny * dy) * edge * edge * 0.22f;
                        dx -= radial * nx;
                        dy -= radial * ny;
                    }
                    int sx = clamp(Math.round(x + dx * radius * blur), width - 1);
                    int sy = clamp(Math.round(y + dy * radius * blur), height - 1);
                    int sample = sy * width + sx;
                    int sampleDepth = depth[sample] & 255;
                    float dw = depthWeight(d, sampleDepth, focus, blur);
                    if (dw <= 0f) continue;
                    int rgb = image[sample];
                    float lr = LINEAR[rgb >>> 16 & 255];
                    float lg = LINEAR[rgb >>> 8 & 255];
                    float lb = LINEAR[rgb & 255];
                    float luma = 0.2126f * lr + 0.7152f * lg + 0.0722f * lb;
                    float spec = 1f + 1.35f * smoothstep(0.72f, 1.0f, luma) * blur;
                    float weight = taps[i + 2] * dw;
                    red += lr * spec * weight;
                    green += lg * spec * weight;
                    blue += lb * spec * weight;
                    sum += weight;
                }
                int orig = image[position];
                float outR = sum <= 0 ? LINEAR[orig >>> 16 & 255] : red / sum;
                float outG = sum <= 0 ? LINEAR[orig >>> 8 & 255] : green / sum;
                float outB = sum <= 0 ? LINEAR[orig & 255] : blue / sum;
                if (style == 4) {
                    int step = Math.max(1, Math.round(radius * blur));
                    float sR = 0, sG = 0, sB = 0;
                    float sW = 0f;
                    for (int dir = -1; dir <= 1; dir += 2) {
                        int sx = clamp(x + dir * step, width - 1);
                        int sample = y * width + sx;
                        int sd = depth[sample] & 255;
                        float dw = depthWeight(d, sd, focus, blur);
                        if (dw > 0f) {
                            int sRgb = image[sample];
                            sR += LINEAR[sRgb >>> 16 & 255] * dw;
                            sG += LINEAR[sRgb >>> 8 & 255] * dw;
                            sB += LINEAR[sRgb & 255] * dw;
                            sW += dw;
                        }
                    }
                    if (sW > 0) {
                        float maxCh = Math.max(sR / sW, Math.max(sG / sW, sB / sW));
                        float flare = 0.18f * blur * Math.max(0f, maxCh - 0.68f);
                        outR += flare * 0.45f;
                        outG += flare * 0.85f;
                        outB += flare * 1.0f;
                    }
                }
                output[position] = 0xff000000 | encodeLinear(outR) << 16
                        | encodeLinear(outG) << 8 | encodeLinear(outB);
            }
        }
        return output;
    }

    private static float smoothstep(float edge0, float edge1, float x) {
        float t = Math.max(0f, Math.min(1f, (x - edge0) / (edge1 - edge0)));
        return t * t * (3f - 2f * t);
    }

    private static int encodeLinear(float linear) {
        return SRGB[clamp(Math.round(linear * 4096f), 4096)];
    }

    private static int clamp(int value, int maximum) {
        return Math.min(maximum, Math.max(0, value));
    }
}
