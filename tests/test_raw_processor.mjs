// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const processor = fileURLToPath(new URL(
  '../patches/custom_imaging_java/src/com/motorola/camera/custom/CleanBayerRawProcessor.java',
  import.meta.url,
));
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
let classes;

function run(executable, args) {
  const result = spawnSync(executable, args, { encoding: 'utf8', timeout: 30_000 });
  assert.ifError(result.error);
  assert.equal(result.status, 0, [executable, result.stdout, result.stderr].join('\n'));
}

const javaChecks = String.raw`
import java.util.Arrays;
import static com.motorola.camera.custom.CleanBayerRawProcessor.*;

public final class RawChecks {
    private static final String[] TILES = {"RGGB", "GRBG", "GBRG", "BGGR"};
    private static final int[] PATTERNS = {CFA_RGGB, CFA_GRBG, CFA_GBRG, CFA_BGGR};
    private static final float[] ZERO = {0, 0, 0, 0};
    private static final float[] UNITY = {1, 1, 1};

    public static void main(String[] args) {
        switch (args[0]) {
            case "raw10": raw10(); break;
            case "raw16": raw16(); break;
            case "neutral": neutral(); break;
            case "primaries": primaries(); break;
            case "impulse": impulse(); break;
            case "edges": edges(); break;
            case "tone": tone(); break;
            case "lsc_and_halo": lscAndHalo(); break;
            case "lsc_high_gain": lscHighGain(); break;
            case "ov64b_fringe": ov64bFringeAndDirectional(); break;
            case "invalid": invalid(); break;
            default: throw new AssertionError(args[0]);
        }
    }

    private static void lscAndHalo() {
        // 1. Dark wire against saturated bright sky must never create white halos in headroom-damped sharpen.
        int w = 16, h = 12;
        int[] wireRaw = new int[w * h];
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                wireRaw[y * w + x] = (x == 7 || x == 8) ? 60 : 950;
            }
        }
        int[] wirePixels = processRawToArgb(wireRaw, w, h, CFA_RGGB, ZERO, 1023, UNITY, null, 0.5f, null, 0, 0, 100);
        // Bright pixels right next to the wire must not overshoot brighter than distant sky background.
        int farSky = channel(at(wirePixels, w, 2, 6), 8);
        int edgeSky = channel(at(wirePixels, w, 6, 6), 8);
        check(edgeSky <= farSky + 2, "expected zero white wire halo, edge=" + edgeSky + " far=" + farSky);

        // 2. LensShadingMap 2x2x4 corner vignetting compensation recovers uniform corner brightness.
        float[] lscGrid = new float[2 * 2 * 4];
        for (int i = 0; i < lscGrid.length; i++) lscGrid[i] = 2.0f; // bottom-right/corners boosted uniformly in this synthetic check
        lscGrid[0] = lscGrid[1] = lscGrid[2] = lscGrid[3] = 1.0f; // top-left = 1.0x
        int[] vignRaw = new int[12 * 10];
        for (int y = 0; y < 10; y++) {
            for (int x = 0; x < 12; x++) {
                float u = x / 11f, v = y / 9f;
                float gainApprox = (1f - u) * (1f - v) * 1.0f + (1f - (1f - u) * (1f - v)) * 2.0f;
                vignRaw[y * 12 + x] = Math.round(400f / gainApprox);
            }
        }
        int[] flat = processRawToArgb(vignRaw, 12, 10, CFA_RGGB, ZERO, 1023, UNITY, null, 0f, lscGrid, 2, 2, 100);
        int tl = channel(at(flat, 12, 2, 2), 8);
        int br = channel(at(flat, 12, 9, 7), 8);
        check(Math.abs(tl - br) <= 4, "LSC corner flat-field check tl=" + tl + " br=" + br);
    }

    private static void raw10() {
        byte[] packed = {0, 63, (byte) 128, (byte) 255, (byte) 0xcc, 55, 66,
                         1, 2, 3, 4, 0x39};
        equal(unpackRaw10ToInt(packed, 4, 2, 7), 0, 255, 512, 1023, 5, 10, 15, 16);
    }

    private static void raw16() {
        byte[] big = {0x12, 0x34, (byte) 0xff, (byte) 0xff, 99, (byte) 0x80, 0, 0, 1};
        byte[] little = {0x34, 0x12, (byte) 0xff, (byte) 0xff, 99, 0, (byte) 0x80, 1, 0};
        equal(unpackRaw16ToInt(big, 2, 2, 5, false), 0x1234, 0xffff, 0x8000, 1);
        equal(unpackRaw16ToInt(little, 2, 2, 5, true), 0x1234, 0xffff, 0x8000, 1);
    }

    private static void neutral() {
        float[] gains = {1.8f, 1, 1.6f};
        float[] matrix = {2, -1, 0.5f, 0.2f, 3, 0.1f, 0.25f, 0, 2};
        for (int p = 0; p < 4; p++) {
            for (float[] black : new float[][] {{64, 64, 64, 64}, {61, 63, 67, 71}}) {
                int[] raw = new int[14 * 10];
                for (int i = 0; i < raw.length; i++) {
                    int site = ((i / 14 & 1) << 1) | (i % 14 & 1);
                    int channel = "RGB".indexOf(TILES[p].charAt(site));
                    raw[i] = Math.round(black[site] + (1023 - black[site]) * 0.30f / gains[channel]);
                }
                int[] pixels = processRawToArgb(raw, 14, 10, PATTERNS[p], black, 1023, gains, matrix, 0);
                for (int pixel : pixels) rgb(pixel, 149, 149, 149, 1);
            }
        }
    }

    private static void primaries() {
        for (int p = 0; p < 4; p++) {
            check(PATTERNS[p] == p, "CFA numeric contract");
            for (char primary : "RGB".toCharArray()) {
                int[] raw = new int[12 * 8];
                for (int i = 0; i < raw.length; i++) {
                    raw[i] = filter(p, i % 12, i / 12) == primary ? 512 : 0;
                }
                long error = 0;
                for (int pixel : process(raw, 12, 8, p)) {
                    int r = primary == 'R' ? 188 : 0;
                    int g = primary == 'G' ? 188 : 0;
                    int b = primary == 'B' ? 188 : 0;
                    rgb(pixel, r, g, b, 2);
                    error += Math.abs(channel(pixel, 16) - r)
                            + Math.abs(channel(pixel, 8) - g) + Math.abs(channel(pixel, 0) - b);
                }
                check(error / (3.0 * raw.length) < 3, "primary mean RGB error");
            }
        }
        int[] red = {512, 0, 0, 0};
        float[] swap = {0, 0, 2, 0, 0, 0, 3, 0, 0};
        for (int pixel : processRawToArgb(red, 2, 2, CFA_RGGB, ZERO, 1024, UNITY, swap, 0)) {
            rgb(pixel, 0, 0, 188, 0);
        }
        equal(processRawToArgb(red, 2, 2, CFA_RGGB, ZERO, 1024, UNITY, new float[8], 0),
                process(red, 2, 2, 0));
    }

    private static void impulse() {
        int w = 12;
        for (int p = 0; p < 4; p++) {
            int[] raw = new int[w * 10];
            Arrays.fill(raw, 256);
            int x = 2 + (p & 1);
            int y = 4 + (p >> 1);
            raw[y * w + x] += 64; // Red impulse on a 0.25 linear gray field.
            int[] pixels = process(raw, w, 10, p);
            // At the impulse: measured red, +4/8 green, +6/8 blue.
            linearRgb(at(pixels, w, x, y), 320, 288, 304);
            // At neighboring green: +4/8 red horizontally or vertically.
            linearRgb(at(pixels, w, x + 1, y), 288, 256, 256);
            linearRgb(at(pixels, w, x, y + 1), 288, 256, 256);
            linearRgb(at(pixels, w, x + 2, y), 256, 248, 244);
            linearRgb(at(pixels, w, x + 1, y + 1), 272, 256, 256);
            // A second-shell tap would affect this pixel if the border used MHC.
            linearRgb(at(pixels, w, x - 2, y), 256, 256, 256);
            if (x == 2) linearRgb(at(pixels, w, 1, y), 288, 256, 256);
        }
        int[] green = new int[w * 10];
        Arrays.fill(green, 256);
        green[4 * w + 5] += 64;
        int[] pixels = process(green, w, 10, 0);
        linearRgb(at(pixels, w, 5, 4), 296, 320, 296);
        linearRgb(at(pixels, w, 7, 4), 248, 256, 260);
        linearRgb(at(pixels, w, 5, 6), 260, 256, 248);
    }

    private static void edges() {
        int w = 32;
        int h = 24;
        for (boolean vertical : new boolean[] {false, true}) {
            for (int p = 0; p < 4; p++) {
                int[] raw = new int[w * h];
                for (int y = 0; y < h; y++) {
                    for (int x = 0; x < w; x++) {
                        int axis = vertical ? x : y;
                        raw[y * w + x] = 224 + 2 * axis + (axis >= 12 ? 128 : 0);
                    }
                }
                int[] pixels = process(raw, w, h, p);
                long error = 0;
                for (int y = 2; y < h - 2; y++) {
                    for (int x = 2; x < w - 2; x++) {
                        int i = y * w + x;
                        int expected = srgb(raw[i] / 1024.0);
                        rgb(pixels[i], expected, expected, expected, 10);
                        for (int shift : new int[] {16, 8, 0}) {
                            error += Math.abs(channel(pixels[i], shift) - expected);
                            int previous = vertical ? i - w : i - 1;
                            if ((vertical ? y : x) > 2) {
                                int zipper = Math.abs(channel(pixels[i], shift)
                                        - channel(pixels[previous], shift));
                                check(zipper <= 11, "edge zipper " + zipper + " for " + TILES[p]);
                            }
                        }
                    }
                }
                check(error / (3.0 * (w - 4) * (h - 4)) < 3, "edge mean RGB error");
            }
        }
    }

    private static void tone() {
        int[] full = new int[16];
        Arrays.fill(full, 1024);
        int previous = 0;
        for (float gain : new float[] {0.8f, 1, 1.25f, 2, 4}) {
            int pixel = processRawToArgb(full, 4, 4, CFA_RGGB, ZERO, 1024,
                    new float[] {gain, gain, gain}, null, 0)[0];
            int r = channel(pixel, 16);
            rgb(pixel, r, r, r, 0);
            check(r > previous && r < 255, "neutral highlights preserve tonal separation");
            previous = r;
        }
        int pixel = processRawToArgb(full, 4, 4, CFA_RGGB, ZERO, 1024,
                new float[] {2, 1, 2}, null, 0)[0];
        check(channel(pixel, 16) == channel(pixel, 0) && channel(pixel, 8) < 195,
                "highlight roll-off uses a common linear scale");

        int w = 12;
        int[] step = new int[w * 8];
        for (int i = 0; i < step.length; i++) step[i] = i % w < 6 ? 256 : 512;
        int[] base = process(step, w, 8, 0);
        int[] sharp = processRawToArgb(step, w, 8, CFA_RGGB, ZERO, 1024, UNITY, null, 2);
        check(!Arrays.equals(base, sharp), "sharpen has a visible effect");
        check(base[0] == sharp[0], "flat region is unchanged");
        for (int i = 0; i < step.length; i++) {
            int dr = channel(sharp[i], 16) - channel(base[i], 16);
            int dg = channel(sharp[i], 8) - channel(base[i], 8);
            int db = channel(sharp[i], 0) - channel(base[i], 0);
            check(Math.abs(dr) <= 4 && Math.abs(dg) <= 4 && Math.abs(db) <= 4
                    && Math.abs(dr - dg) <= 1 && Math.abs(dr - db) <= 1, "luma-only bounded delta");
        }
    }

    private static void invalid() {
        rejects(() -> unpackRaw10ToInt(new byte[20], 6, 2, 10));
        rejects(() -> unpackRaw10ToInt(new byte[20], 4, 3, 5));
        rejects(() -> unpackRaw10ToInt(new byte[9], 4, 2, 5));
        rejects(() -> unpackRaw10ToInt(new byte[10], 4, 2, 4));
        rejects(() -> unpackRaw10ToInt(null, 4, 2, 5));
        rejects(() -> unpackRaw16ToInt(new byte[7], 2, 2, 4, true));
        rejects(() -> unpackRaw16ToInt(new byte[8], 2, 2, 3, true));
        rejects(() -> unpackRaw16ToInt(new byte[8], Integer.MAX_VALUE, 2, 4, true));
        rejects(() -> unpackRaw16ToInt(null, 2, 2, 4, false));
        rejects(() -> process(null, 2, 2, 0));
        rejects(() -> process(new int[3], 2, 2, 0));
        rejects(() -> processRawToArgb(new int[4], 2, 2, -1, ZERO, 1024, UNITY, null, 0));
        rejects(() -> processRawToArgb(new int[4], 2, 2, 0, ZERO, 0, UNITY, null, 0));
        rejects(() -> processRawToArgb(new int[4], 2, 2, 0, ZERO, 1024, null, null, 0));
    }

    private static char filter(int pattern, int x, int y) {
        return TILES[pattern].charAt(2 * (y % 2) + x % 2);
    }

    private static int[] process(int[] raw, int w, int h, int pattern) {
        return processRawToArgb(raw, w, h, PATTERNS[pattern], ZERO, 1024, UNITY, null, 0);
    }

    private static int at(int[] pixels, int width, int x, int y) {
        return pixels[y * width + x];
    }

    private static int srgb(double v) {
        return (int) Math.round(255 * (v <= 0.0031308 ? 12.92 * v
                : 1.055 * Math.pow(v, 1.0 / 2.4) - 0.055));
    }

    private static void linearRgb(int pixel, int red, int green, int blue) {
        rgb(pixel, srgb(red / 1024.0), srgb(green / 1024.0), srgb(blue / 1024.0), 0);
    }

    private static int channel(int pixel, int shift) {
        return (pixel >>> shift) & 255;
    }

    private static void rgb(int pixel, int r, int g, int b, int tolerance) {
        check(channel(pixel, 24) == 255 && Math.abs(channel(pixel, 16) - r) <= tolerance
                && Math.abs(channel(pixel, 8) - g) <= tolerance
                && Math.abs(channel(pixel, 0) - b) <= tolerance,
                String.format("%08x expected RGB (%d, %d, %d) within %d", pixel, r, g, b, tolerance));
    }

    private static void equal(int[] actual, int... expected) {
        check(Arrays.equals(actual, expected),
                Arrays.toString(actual) + " expected " + Arrays.toString(expected));
    }

    private static void rejects(Runnable run) {
        try {
            run.run();
        } catch (IllegalArgumentException expected) {
            return;
        }
        throw new AssertionError("Expected IllegalArgumentException");
    }

    private static void lscHighGain() {
        int w = 12, h = 8;
        int[] raw = new int[w * h];
        Arrays.fill(raw, 128);
        // 2x2 LensShadingMap: left column 1.0f, right column 4.2f (exceeds legacy 4.0f cutoff).
        float[] lsc = {
            1.0f, 1.0f, 1.0f, 1.0f,  4.2f, 4.2f, 4.2f, 4.2f,
            1.0f, 1.0f, 1.0f, 1.0f,  4.2f, 4.2f, 4.2f, 4.2f
        };
        float[] identity = {1, 0, 0, 0, 1, 0, 0, 0, 1};
        int[] pixels = processRawToArgb(
                raw, w, h, CFA_RGGB, ZERO, 1024f, UNITY, identity, 0f, lsc, 2, 2, 100);
        int leftG = channel(at(pixels, w, 0, h / 2), 8);
        int rightG = channel(at(pixels, w, w - 1, h / 2), 8);
        check(leftG >= 90 && leftG <= 115, "left baseline green=" + leftG);
        check(rightG >= 165, "right 4.2x LSC corner dropped back to 1.0x: green=" + rightG);
        check(rightG - leftG >= 60, "corner vs center delta too small: " + (rightG - leftG));
    }

    private static void ov64bFringeAndDirectional() {
        // High-contrast dark wire against bright overcast sky on OV64B CFA_GBRG at low & high ISO.
        int w = 24, h = 16;
        int[] raw = new int[w * h];
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                boolean wire = (x == 11 || x == 12);
                raw[y * w + x] = wire ? 80 : 940;
            }
        }
        int[] lowIso = processRawToArgb(raw, w, h, CFA_GBRG, ZERO, 1023f, UNITY, null, 0.30f, null, 0, 0, 100);
        int[] highIso = processRawToArgb(raw, w, h, CFA_GBRG, ZERO, 1023f, UNITY, null, 0.30f, null, 0, 0, 3200);
        int farSky = channel(at(lowIso, w, 3, 8), 8);
        int edgeSky = channel(at(lowIso, w, 10, 8), 8);
        check(edgeSky <= farSky + 2, "expected zero white halo on GBRG wire, edge=" + edgeSky + " far=" + farSky);
        // Verify fringe clamp prevents strong magenta/green color cast right along the edge.
        int edgePx = at(lowIso, w, 10, 8);
        int maxDiff = Math.max(Math.abs(channel(edgePx, 16) - channel(edgePx, 8)),
                               Math.abs(channel(edgePx, 0) - channel(edgePx, 8)));
        check(maxDiff <= 8, "expected low chromatic demosaic fringe on neutral edge, maxDiff=" + maxDiff);
        // Flat sky on high ISO stays neutral gray without spurious sharpen overshoot.
        rgb(at(highIso, w, 3, 8), farSky, farSky, farSky, 2);
    }

    private static void check(boolean condition, String message) {
        if (!condition) throw new AssertionError(message);
    }
}
`;

before(() => {
  classes = mkdtempSync(join(tmpdir(), 'bayer-raw-test-'));
  const harness = join(classes, 'RawChecks.java');
  run(javac, ['--release', '11', '-d', classes, processor]);
  const bytecode = readFileSync(join(classes, 'com/motorola/camera/custom/CleanBayerRawProcessor.class'));
  assert.equal(bytecode.readUInt16BE(6), 55);
  writeFileSync(harness, javaChecks);
  run(javac, ['--release', '11', '-cp', classes, '-d', classes, harness]);
});

after(() => {
  if (classes) rmSync(classes, { recursive: true, force: true });
});

for (const [name, check] of [
  ['RAW10 unpacks fixed MIPI bytes and skips row padding', 'raw10'],
  ['RAW16 honors byte order, unsigned samples, and row stride', 'raw16'],
  ['black level, white balance, and normalized CCM preserve neutral gray', 'neutral'],
  ['all Bayer phases reconstruct red, green, and blue patches', 'primaries'],
  ['5×5 impulse coefficients and bilinear border match expected RGB', 'impulse'],
  ['vertical and horizontal edges have low phase-dependent error', 'edges'],
  ['highlight shoulder and bounded luminance sharpening', 'tone'],
  ['LensShadingMap flat-field and zero white cable halo in 13-arg pipeline', 'lsc_and_halo'],
  ['LensShadingMap preserves continuous corner gains above 4.0x', 'lsc_high_gain'],
  ['OV64B GBRG fringe clamp and ISO-damped directional sharpening', 'ov64b_fringe'],
  ['invalid buffers, geometry, and calibration are rejected', 'invalid'],
]) {
  test(name, () => run(java, ['-cp', classes, 'RawChecks', check]));
}
