// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

final class LookOptics {
    private static final float[] LINEAR = new float[256];
    private static final int[] SRGB = new int[4097];
    private static final int[] GAUSSIAN = {1, 4, 6, 4, 1};

    static {
        for (int i = 0; i < LINEAR.length; i++) {
            double s = i / 255.0;
            LINEAR[i] = (float) (s <= 0.04045 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4));
        }
        for (int i = 0; i < SRGB.length; i++) {
            double l = i / 4096.0;
            SRGB[i] = (int) Math.round(255 * (l <= 0.0031308 ? 12.92 * l : 1.055 * Math.pow(l, 1.0 / 2.4) - 0.055));
        }
    }

    private final int width, height, look, gridWidth, gridHeight, step;
    private final float strength;
    private final float clarityScale;
    private final float ltmScale;
    private final float[] grid;

    private LookOptics(int width, int height, int look, int intensity, float clarityScale,
                       float ltmScale, int step, int gridWidth, int gridHeight, float[] grid) {
        this.width = width;
        this.height = height;
        this.look = look;
        this.strength = intensity / 100f;
        this.clarityScale = clarityScale;
        this.ltmScale = ltmScale;
        this.step = step;
        this.gridWidth = gridWidth;
        this.gridHeight = gridHeight;
        this.grid = grid;
    }

    static boolean needsPass(int look) {
        return look == 1 || look == 2 || look == 3 || look >= 5;
    }

    static LookOptics prepare(CustomImagingBridge.PixelSurface source, int width, int height,
                              int look, int intensity) {
        return prepare(source, width, height, look, intensity, 1.0f, 1.0f);
    }

    static LookOptics prepare(CustomImagingBridge.PixelSurface source, int width, int height,
                              int look, int intensity, float clarityScale, float ltmScale) {
        boolean localTone = (look == 5 || look == 6) && width >= 16 && height >= 16;
        boolean glow = look == 7 || look == 8;
        int step = glow ? 4 : AppleStyleToneEngine.autoLtmGridStep();
        int gw = (width + step - 1) / step;
        int gh = (height + step - 1) / step;
        float[] grid = null;
        if (localTone || glow) {
            grid = new float[gw * gh];
            float[] variance = localTone ? new float[grid.length] : null;
            int[] band = new int[width * step];
            for (int y = 0; y < height; y += step) {
                int rows = Math.min(step, height - y);
                source.readRows(y, rows, band, 0);
                if (localTone) {
                    AppleStyleToneEngine.accumulateAutoLtmBand(band, width, rows, y, height, grid, variance, gw, gh);
                    continue;
                }
                for (int gx = 0; gx < gw; gx++) {
                    float sum = 0;
                    int samples = Math.min(step, width - gx * step);
                    for (int yy = 0; yy < rows; yy++) {
                        for (int xx = 0; xx < samples; xx++) {
                            int pixel = band[yy * width + gx * step + xx];
                            float red = LINEAR[pixel >>> 16 & 255];
                            float yLin = luma(red, LINEAR[pixel >>> 8 & 255], LINEAR[pixel & 255]);
                            sum += Math.max(0, (look == 8 ? red : yLin) - 0.58f);
                        }
                    }
                    grid[y / step * gw + gx] = sum / (rows * samples);
                }
            }
            if (localTone) {
                grid = AppleStyleToneEngine.finalizeAutoLtmBaseGrid(grid, gw, gh);
                if (grid != null) for (int i = 0; i < grid.length; i++) grid[i] = (float) Math.exp(grid[i]) - 0.002f;
            } else {
                grid = gaussian(grid, gw, gh);
            }
        }
        return new LookOptics(width, height, look, intensity, clarityScale, ltmScale, step, gw, gh, grid);
    }

    void apply(int[] pixels, int rows, int top) {
        float vignette = look == 1 ? 0.27f : look == 2 ? 0.13f : 0;
        float grain = look == 3 ? 0.020f : look == 13 ? 0.016f : look >= 9 ? 0.010f : 0;
        if (vignette == 0 && grain == 0 && grid == null) return;
        for (int i = 0; i < rows * width; i++) {
            int x = i % width, y = top + i / width;
            int pixel = pixels[i];
            float r = LINEAR[pixel >>> 16 & 255], g = LINEAR[pixel >>> 8 & 255], b = LINEAR[pixel & 255];
            float light = luma(r, g, b);
            float factor = 1;
            if (vignette != 0) {
                float nx = (2f * (x + 0.5f) / width - 1) * 0.9f;
                float ny = 2f * (y + 0.5f) / height - 1;
                factor -= strength * vignette * smooth((nx * nx + ny * ny - 0.18f) / 1.55f)
                        * (1 - smooth((light - 0.22f) / 0.78f));
            }
            float add = 0;
            if (grid != null) {
                float base = sample(x, y);
                if (look == 6) {
                    float skin = smooth((r - g) * 12) * smooth((g - b) * 16);
                    factor += strength * 0.40f * ltmScale * (1 - smooth(base / 0.28f)) * (1 - 0.62f * skin);
                } else if (look == 5) {
                    add = strength * 0.16f * clarityScale * Math.max(-0.20f, Math.min(0.20f, light - base));
                } else {
                    add = strength * base * (look == 7 ? 0.25f : 0.34f);
                }
            }
            int hash = x * 0x5bd1e995 ^ y * 0x27d4eb2d;
            hash ^= hash >>> 15;
            hash *= 0x85ebca6b;
            float noise = strength * grain * (1f - light) * (((hash & 255) + (hash >>> 8 & 255)) / 255f - 1f);
            float bloomG = look == 8 ? 0.18f : 1f;
            float bloomB = look == 8 ? 0.04f : 1f;
            float chroma = look == 13 ? noise * 0.25f : 0f;
            pixels[i] = (pixel & 0xff000000) | encode(r * factor + add + noise + chroma) << 16
                    | encode(g * factor + add * bloomG + noise) << 8
                    | encode(b * factor + add * bloomB + noise - chroma);
        }
    }

    private float sample(int x, int y) {
        int x0 = x / step, y0 = y / step;
        int x1 = Math.min(x0 + 1, gridWidth - 1), y1 = Math.min(y0 + 1, gridHeight - 1);
        float fx = (x % step) / (float) step, fy = (y % step) / (float) step;
        float top = mix(grid[y0 * gridWidth + x0], grid[y0 * gridWidth + x1], fx);
        float bottom = mix(grid[y1 * gridWidth + x0], grid[y1 * gridWidth + x1], fx);
        return mix(top, bottom, fy);
    }

    private static float[] gaussian(float[] source, int width, int height) {
        float[] horizontal = new float[source.length];
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                float sum = 0;
                for (int k = -2; k <= 2; k++) {
                    sum += GAUSSIAN[k + 2] * source[y * width + Math.max(0, Math.min(width - 1, x + k * 2))];
                }
                horizontal[y * width + x] = sum / 16f;
            }
        }
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                float sum = 0;
                for (int k = -2; k <= 2; k++) {
                    sum += GAUSSIAN[k + 2] * horizontal[Math.max(0, Math.min(height - 1, y + k * 2)) * width + x];
                }
                source[y * width + x] = sum / 16f;
            }
        }
        return source;
    }

    private static float mix(float a, float b, float t) { return a + (b - a) * t; }
    private static float luma(float r, float g, float b) { return 0.2126f * r + 0.7152f * g + 0.0722f * b; }
    private static int encode(float value) { return SRGB[Math.min(4096, Math.max(0, Math.round(value * 4096)))]; }
    private static float smooth(float value) {
        float x = Math.max(0, Math.min(1, value));
        return x * x * (3 - 2 * x);
    }
}
