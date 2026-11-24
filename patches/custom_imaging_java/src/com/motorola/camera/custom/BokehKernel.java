// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/** Aperture samples shared by the CPU and GPU gather paths. */
final class BokehKernel {
    static final int TAPS = 32;

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
        float t = Math.min(1f, Math.max(0, (Math.abs(depth - focus) - 9f) / 65f));
        return t * t * (3 - 2 * t);
    }

    static int[] gather(int[] image, byte[] depth, int width, int height, int focus, int style) {
        float[] taps = aperture(style);
        int[] output = new int[image.length];
        float radius = Math.max(2, Math.min(width, height) * 0.027f);
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int position = y * width + x;
                int d = depth[position] & 255;
                float blur = coc(d, focus);
                if (blur < 0.06f) {
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
                    }
                    int sx = clamp(Math.round(x + dx * radius * blur), width - 1);
                    int sy = clamp(Math.round(y + dy * radius * blur), height - 1);
                    int sample = sy * width + sx;
                    int sampleDepth = depth[sample] & 255;
                    if (Math.abs(d - sampleDepth) > 34 || coc(sampleDepth, focus) < blur * 0.38f) continue;
                    int rgb = image[sample];
                    float weight = taps[i + 2];
                    red += (rgb >>> 16 & 255) * weight;
                    green += (rgb >>> 8 & 255) * weight;
                    blue += (rgb & 255) * weight;
                    sum += weight;
                }
                float outR = sum <= 0 ? (image[position] >>> 16 & 255) : red / sum;
                float outG = sum <= 0 ? (image[position] >>> 8 & 255) : green / sum;
                float outB = sum <= 0 ? (image[position] & 255) : blue / sum;
                if (style == 4) {
                    int step = Math.max(1, Math.round(radius * blur));
                    float sR = 0, sG = 0, sB = 0;
                    int sW = 0;
                    for (int dir = -1; dir <= 1; dir += 2) {
                        int sx = clamp(x + dir * step, width - 1);
                        int sample = y * width + sx;
                        int sd = depth[sample] & 255;
                        if (Math.abs(d - sd) <= 34 && coc(sd, focus) >= blur * 0.38f) {
                            int sRgb = image[sample];
                            sR += (sRgb >>> 16 & 255);
                            sG += (sRgb >>> 8 & 255);
                            sB += (sRgb & 255);
                            sW++;
                        }
                    }
                    if (sW > 0) {
                        float maxCh = Math.max(sR / sW, Math.max(sG / sW, sB / sW)) / 255f;
                        float flare = 0.10f * blur * Math.max(0f, maxCh - 0.85f) * 255f;
                        outR += flare * 0.6f;
                        outG += flare * 0.9f;
                        outB += flare * 1.0f;
                    }
                }
                output[position] = 0xff000000 | clamp(Math.round(outR), 255) << 16
                        | clamp(Math.round(outG), 255) << 8 | clamp(Math.round(outB), 255);
            }
        }
        return output;
    }

    private static int clamp(int value, int maximum) {
        return Math.min(maximum, Math.max(0, value));
    }
}
