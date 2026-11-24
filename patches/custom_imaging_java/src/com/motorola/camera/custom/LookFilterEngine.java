package com.motorola.camera.custom;

import java.io.IOException;
import java.io.InputStream;

/** Samples an RGB8 cube in red-fastest order. */
public final class LookFilterEngine {
    private static final int SIZE = 33;
    private static final int RED_STRIDE = 3;
    private static final int GREEN_STRIDE = RED_STRIDE * SIZE;
    private static final int BLUE_STRIDE = GREEN_STRIDE * SIZE;
    private static final int BYTES = BLUE_STRIDE * SIZE;
    private final byte[] cube;

    private LookFilterEngine(byte[] cube) {
        this.cube = cube;
    }

    public static LookFilterEngine read(InputStream input) throws IOException {
        byte[] cube = new byte[BYTES];
        int offset = 0;
        while (offset < cube.length) {
            int count = input.read(cube, offset, cube.length - offset);
            if (count < 0) throw new IOException("Truncated look cube");
            if (count == 0) {
                int value = input.read();
                if (value < 0) throw new IOException("Truncated look cube");
                cube[offset++] = (byte) value;
            } else {
                offset += count;
            }
        }
        if (input.read() != -1) throw new IOException("Oversized look cube");
        return new LookFilterEngine(cube);
    }

    java.nio.ByteBuffer texturePixels() {
        java.nio.ByteBuffer bytes = java.nio.ByteBuffer.allocateDirect(cube.length);
        bytes.put(cube);
        bytes.flip();
        return bytes;
    }

    public void apply(int[] pixels, int offset, int count, int intensity) {
        int amount = Math.max(0, Math.min(100, intensity));
        if (amount == 0) return;
        for (int i = offset; i < offset + count; i++) {
            int pixel = pixels[i];
            int red = pixel >>> 16 & 255;
            int green = pixel >>> 8 & 255;
            int blue = pixel & 255;
            // Coordinates in 1/255 of a cell, with the upper edge in cell 31.
            int x = red * 32;
            int y = green * 32;
            int z = blue * 32;
            int r = Math.min(x / 255, 31);
            int g = Math.min(y / 255, 31);
            int b = Math.min(z / 255, 31);
            int base = r * RED_STRIDE + g * GREEN_STRIDE + b * BLUE_STRIDE;
            x -= r * 255;
            y -= g * 255;
            z -= b * 255;
            int sx = RED_STRIDE;
            int sy = GREEN_STRIDE;
            int sz = BLUE_STRIDE;
            if (x < y) {
                int swap = x; x = y; y = swap;
                swap = sx; sx = sy; sy = swap;
            }
            if (y < z) {
                int swap = y; y = z; z = swap;
                swap = sy; sy = sz; sz = swap;
            }
            if (x < y) {
                int swap = x; x = y; y = swap;
                swap = sx; sx = sy; sy = swap;
            }
            int second = base + sx;
            int third = second + sy;
            int fourth = third + sz;
            int outR = blend(red, amount, base, second, third, fourth, x, y, z);
            int outG = blend(green, amount, base + 1, second + 1, third + 1, fourth + 1, x, y, z);
            int outB = blend(blue, amount, base + 2, second + 2, third + 2, fourth + 2, x, y, z);
            pixels[i] = (pixel & 0xff000000) | (outR << 16) | (outG << 8) | outB;
        }
    }

    private int blend(int original, int amount, int a, int b, int c, int d, int x, int y, int z) {
        int weighted = (cube[a] & 255) * (255 - x) + (cube[b] & 255) * (x - y)
                + (cube[c] & 255) * (y - z) + (cube[d] & 255) * z;
        return (weighted * amount + original * (100 - amount) * 255 + 12750) / 25500;
    }
}
