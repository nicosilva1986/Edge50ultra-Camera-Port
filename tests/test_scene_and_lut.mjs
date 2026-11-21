// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const sourceDir = fileURLToPath(new URL(
  '../patches/custom_imaging_java/src/com/motorola/camera/custom/',
  import.meta.url,
));
const selectorSource = join(sourceDir, 'ScenePostProcSelector.java');
const toneSource = join(sourceDir, 'AppleStyleToneEngine.java');
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');

const KEEP = [0, -1, -1, -1, -1, 0, 0];
const FIXED = {
  1: [1, 4, 3, 1, 0, 0, 0],
  2: [1, 3, 0, 1, 0, 0, 0],
  3: [2, 3, 0, 1, 0, 0, 0],
  4: [1, 0, 0, 0, 0, 0, 0],
  5: [1, 3, 0, 1, 0, 1, 0],
  6: [1, 3, 0, 1, 0, 2, 0],
  7: [1, 3, 0, 1, 0, 3, 0],
  8: [0, 3, 0, 1, 0, 1, 1],
  9: [0, 0, 0, 0, 0, 0, 0],
};

const VALID_CUBE = `# photographic identity with a marked white corner
TITLE "edge50-test"
DOMAIN_MIN 0.0 0.0 0.0
DOMAIN_MAX 1.0 1.0 1.0
LUT_3D_SIZE 2

0 0 0
1 0 0
0 1 0
1 1 0
0 0 1
1 0 1
0 1 1
0.25 0.5 0.75
`;

const probeSource = `
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public final class SceneLutProbe {
    public static void main(String[] args) throws Exception {
        List<String> lines = Files.readAllLines(Path.of(args[0]), StandardCharsets.UTF_8);
        for (String line : lines) {
            if (line.isEmpty()) continue;
            String[] part = line.split(" ", -1);
            String op = part[0];
            if (op.equals("R")) {
                int[] out = com.motorola.camera.custom.ScenePostProcSelector.resolve(
                        Integer.parseInt(part[2]),
                        Float.parseFloat(part[3]),
                        Float.parseFloat(part[4]),
                        part[5].equals("1"),
                        part[6].equals("1"),
                        part[7].equals("1"));
                System.out.print("R " + part[1]);
                for (int value : out) System.out.print(" " + value);
                System.out.println();
            } else if (op.equals("E")) {
                float zoom = part[2].equals("nextDown12") ? Math.nextDown(12f)
                        : part[2].equals("nextDown295") ? Math.nextDown(2.95f)
                        : Float.parseFloat(part[2]);
                float lux = Float.parseFloat(part[3]);
                int[] out = com.motorola.camera.custom.ScenePostProcSelector.resolve(
                        0, zoom, lux, part[4].equals("1"), false, false);
                System.out.print("E " + part[1]);
                for (int value : out) System.out.print(" " + value);
                System.out.println();
            } else if (op.equals("P")) {
                int style = Integer.parseInt(part[2]);
                int count = part.length - 3;
                int[] pixels = new int[count];
                for (int i = 0; i < count; i++) pixels[i] = (int) Long.parseLong(part[3 + i], 16);
                com.motorola.camera.custom.AppleStyleToneEngine.applyToArgbPixels(pixels, count, 1, style);
                System.out.print("P " + part[1] + " " + style);
                for (int pixel : pixels) System.out.print(" " + Integer.toUnsignedString(pixel, 16));
                System.out.println();
            } else if (op.equals("G")) {
                int style = Integer.parseInt(part[2]);
                int[] ramp = new int[256];
                for (int v = 0; v < 256; v++) ramp[v] = 0xFF000000 | (v << 16) | (v << 8) | v;
                com.motorola.camera.custom.AppleStyleToneEngine.applyToArgbPixels(ramp, 256, 1, style);
                System.out.print("G " + part[1]);
                for (int pixel : ramp) {
                    System.out.print(" " + ((pixel >>> 16) & 255));
                    System.out.print(" " + ((pixel >>> 8) & 255));
                    System.out.print(" " + (pixel & 255));
                }
                System.out.println();
            } else if (op.equals("C") || op.equals("N")) {
                String text = Files.readString(Path.of(part[2]), StandardCharsets.UTF_8);
                try {
                    int[] size = op.equals("N") ? null : new int[] {-1, 42};
                    float[] lut = com.motorola.camera.custom.AppleStyleToneEngine.parseCubeLut(text, size);
                    System.out.print("C " + part[1] + " OK " + lut.length);
                    if (size != null) System.out.print(" " + size[0] + " " + size[1]);
                    for (float sample : lut) System.out.print(" " + sample);
                    System.out.println();
                } catch (IllegalArgumentException ex) {
                    System.out.println("C " + part[1] + " REJECT");
                }
            } else if (op.equals("B")) {
                int style = Integer.parseInt(part[2]);
                int width = 1920;
                int height = 1080;
                int[] frame = new int[width * height];
                for (int i = 0; i < frame.length; i++) {
                    int v = i & 255;
                    frame[i] = 0xA5000000 | (v << 16) | ((255 - v) << 8) | (v >>> 1);
                }
                com.motorola.camera.custom.AppleStyleToneEngine.applyToArgbPixels(frame, width, height, style);
                long started = System.nanoTime();
                com.motorola.camera.custom.AppleStyleToneEngine.applyToArgbPixels(frame, width, height, style);
                long elapsed = (System.nanoTime() - started) / 1_000_000L;
                int probe = frame[(height / 2) * width + (width / 2)];
                System.out.println("B " + part[1] + " " + elapsed + " " + Integer.toUnsignedString(probe, 16));
            } else if (op.equals("K")) {
                System.out.println("K " + part[1] + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_AUTO_SCENE_ADAPTIVE + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_NATURAL_ZSL + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_MINIMAL_ISP + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_DETAIL_HDR + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_PURE_ISP + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_IPHONE_NATURAL + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_IPHONE_RICH_CONTRAST + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_IPHONE_AMBER + " "
                        + com.motorola.camera.custom.ScenePostProcSelector.PROFILE_CLEAN_RAW_BAYER + " "
                        + com.motorola.camera.custom.AppleStyleToneEngine.STYLE_NONE + " "
                        + com.motorola.camera.custom.AppleStyleToneEngine.STYLE_IPHONE_NATURAL + " "
                        + com.motorola.camera.custom.AppleStyleToneEngine.STYLE_IPHONE_RICH_CONTRAST + " "
                        + com.motorola.camera.custom.AppleStyleToneEngine.STYLE_IPHONE_AMBER);
            } else {
                throw new IllegalArgumentException(op);
            }
        }
    }
}
`;

let work;

function run(executable, args, timeout = 60_000) {
  const result = spawnSync(executable, args, { encoding: 'utf8', timeout, windowsHide: true });
  assert.ifError(result.error);
  assert.equal(result.status, 0, [executable, ...args, result.stdout, result.stderr].join('\n'));
  return result.stdout;
}

function channels(hex) {
  const pixel = Number.parseInt(hex, 16);
  return {
    a: (pixel >>> 24) & 255,
    r: (pixel >>> 16) & 255,
    g: (pixel >>> 8) & 255,
    b: pixel & 255,
    pixel,
  };
}

before(() => {
  for (const source of [selectorSource, toneSource]) {
    const text = readFileSync(source, 'utf8');
    assert.equal(/\bimport\s+/.test(text), false, source);
    assert.equal(text.includes('android.'), false, source);
  }
  work = mkdtempSync(join(tmpdir(), 'scene-lut-'));
  run(javac, ['--release', '11', '-d', work, selectorSource, toneSource]);
  for (const name of ['ScenePostProcSelector.class', 'AppleStyleToneEngine.class']) {
    const bytecode = readFileSync(join(work, 'com/motorola/camera/custom', name));
    assert.equal(bytecode.readUInt16BE(0), 0xCAFE);
    assert.equal(bytecode.readUInt16BE(6), 55, name);
  }
  const harness = join(work, 'SceneLutProbe.java');
  writeFileSync(harness, probeSource);
  run(javac, ['--release', '11', '-cp', work, '-d', work, harness]);
});

after(() => {
  if (work) rmSync(work, { recursive: true, force: true });
});

test('scene profiles, LUT anchors, cube parser, and 1080p grade', () => {
  const jobs = [];
  const expectResolve = new Map();

  function addResolve(name, profile, zoom, lux, hdr, night, flash, expected) {
    jobs.push(['R', name, profile, zoom, lux, hdr, night, flash].join(' '));
    expectResolve.set(name, expected);
  }

  addResolve('daylight-1x', 0, '1', '100', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('daylight-hdr', 0, '1', '120', 1, 0, 0, [2, 3, 0, 1, 0, 0, 0]);
  addResolve('tele-3x', 0, '3', '100', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('tele-3x-hdr', 0, '3', '140', 1, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('tele-295', 0, '2.95', '200', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('zoom-15x', 0, '15', '90', 0, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('zoom-15x-hdr', 0, '15', '90', 1, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('zoom-12-low-light', 0, '12', '400', 1, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('low-light', 0, '1', '280', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('low-light-hdr', 0, '1', '350', 1, 0, 0, [0, 3, 0, 1, 0, 0, 0]);
  addResolve('tele-goes-low-light', 0, '3.5', '280', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('nan-zoom', 0, 'NaN', '100', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('nan-lux', 0, '1', 'NaN', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('nan-zoom-keeps-low-light', 0, 'NaN', '320', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('negative-zoom', 0, '-2', '80', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('negative-lux-hdr', 0, '1', '-40', 1, 0, 0, [2, 3, 0, 1, 0, 0, 0]);
  addResolve('infinity-zoom', 0, 'Infinity', '100', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('negative-infinity-lux', 0, '1', '-Infinity', 0, 0, 0, [1, 3, 0, 1, 0, 0, 0]);
  addResolve('flash-auto', 0, '1', '100', 1, 0, 1, KEEP);
  addResolve('flash-natural', 1, '20', '500', 1, 0, 1, KEEP);
  addResolve('flash-amber', 7, '15', '400', 1, 0, 1, KEEP);
  addResolve('ded-night-detail', 3, '1', '100', 0, 1, 0, KEEP);
  addResolve('ded-night-and-flash', 5, '1', '10', 0, 1, 1, KEEP);
  addResolve('unknown-profile', 99, '1', '100', 0, 0, 0, KEEP);
  addResolve('negative-profile', -1, '1', '100', 0, 0, 0, KEEP);
  addResolve('nan-on-pure-isp', 4, 'NaN', '-5', 1, 0, 0, FIXED[4]);

  for (const profile of [1, 2, 3, 4, 5, 6, 7, 8, 9]) {
    addResolve(`profile-${profile}-day`, profile, '1', '100', 0, 0, 0, FIXED[profile]);
    addResolve(`profile-${profile}-extreme`, profile, '30', '500', 1, 0, 0, FIXED[profile]);
  }

  jobs.push('E exact-12 12 100 0');
  jobs.push('E exact-295 2.95 100 0');
  jobs.push('E exact-280 1 280 0');
  jobs.push('E below-12 nextDown12 100 0');
  jobs.push('E below-295 nextDown295 100 0');
  expectResolve.set('exact-12', [1, 3, 1, 1, 0, 0, 0]);
  expectResolve.set('exact-295', [1, 3, 0, 1, 0, 0, 0]);
  expectResolve.set('exact-280', [1, 3, 0, 1, 0, 0, 0]);
  expectResolve.set('below-12', [1, 3, 0, 1, 0, 0, 0]);
  expectResolve.set('below-295', [1, 3, 0, 1, 0, 0, 0]);

  for (const style of [1, 2, 3]) {
    jobs.push(`P black-${style} ${style} ff000000`);
    jobs.push(`P white-${style} ${style} ffffffff`);
  }
  jobs.push('P shadow-1 1 ff282828');
  jobs.push('P shadow-2 2 ff282828');
  jobs.push('P warm-1 1 ffbea58c');
  jobs.push('P warm-3 3 ffbea58c');
  jobs.push('P cyansky-1 1 ff6ec2d8');
  jobs.push('P cyansky-2 2 ff6ec2d8');
  jobs.push('P alpha-1 1 80ffffff');
  jobs.push('P alpha-black-2 2 7f000000');
  jobs.push('P noop-0 0 ff123456');
  jobs.push('P noop-99 99 80abcdef');

  jobs.push('G ramp-1 1');
  jobs.push('G ramp-2 2');
  jobs.push('G ramp-3 3');
  jobs.push('K ids');

  const validCube = join(work, 'valid.cube');
  const malformed = {
    empty: '',
    'no-size': '0 0 0\n1 1 1\n',
    short: 'LUT_3D_SIZE 2\n0 0 0\n1 0 0\n',
    'bad-row': 'LUT_3D_SIZE 2\n0 0\n',
    'size-one': 'LUT_3D_SIZE 1\n0 0 0\n',
    nan: 'LUT_3D_SIZE 2\nNaN 0 0\n1 0 0\n0 1 0\n1 1 0\n0 0 1\n1 0 1\n0 1 1\n1 1 1\n',
    domain: `LUT_3D_SIZE 2\nDOMAIN_MIN 1 1 1\nDOMAIN_MAX 0 0 0\n${VALID_CUBE.split('\n').slice(6).join('\n')}`,
    'one-d': 'LUT_1D_SIZE 2\n0\n1\n',
  };
  writeFileSync(validCube, VALID_CUBE);
  jobs.push(`C valid ${validCube}`);
  jobs.push(`N valid-null ${validCube}`);
  for (const [name, text] of Object.entries(malformed)) {
    const path = join(work, `${name}.cube`);
    writeFileSync(path, text);
    jobs.push(`C ${name} ${path}`);
  }
  jobs.push('B fullhd 1');

  const jobPath = join(work, 'jobs.txt');
  writeFileSync(jobPath, jobs.join('\n'));
  const stdout = run(java, ['-cp', work, 'SceneLutProbe', jobPath], 120_000);
  const lines = new Map();
  for (const line of stdout.split(/\r?\n/)) {
    if (!line) continue;
    const parts = line.split(' ');
    lines.set(`${parts[0]} ${parts[1]}`, parts);
  }

  for (const [name, expected] of expectResolve) {
    const parts = lines.get(`R ${name}`) ?? lines.get(`E ${name}`);
    assert.ok(parts, name);
    assert.deepEqual(parts.slice(2).map(Number), expected, name);
  }

  const ids = lines.get('K ids');
  assert.deepEqual(ids.slice(2).map(Number), [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3]);

  const pixels = new Map();
  for (const [key, parts] of lines) {
    if (!key.startsWith('P ')) continue;
    pixels.set(parts[1], parts.slice(3).map(channels));
  }

  for (const style of [1, 2, 3]) {
    const black = pixels.get(`black-${style}`)[0];
    assert.equal(black.a, 255);
    assert.ok(black.r <= 2 && black.g <= 2 && black.b <= 2, `black style ${style} ${black.r},${black.g},${black.b}`);
    const white = pixels.get(`white-${style}`)[0];
    assert.equal(white.a, 255);
    for (const channel of [white.r, white.g, white.b]) {
      assert.ok(channel >= 252 && channel <= 255, `white style ${style} channel ${channel}`);
    }
    assert.ok(Math.max(white.r, white.g, white.b) - Math.min(white.r, white.g, white.b) <= 1);
  }

  const naturalShadow = pixels.get('shadow-1')[0];
  const richShadow = pixels.get('shadow-2')[0];
  const naturalLuma = naturalShadow.r + naturalShadow.g + naturalShadow.b;
  const richLuma = richShadow.r + richShadow.g + richShadow.b;
  assert.ok(richLuma < naturalLuma, `rich ${richLuma} vs natural ${naturalLuma}`);
  assert.ok(richShadow.r <= naturalShadow.r && richShadow.g <= naturalShadow.g && richShadow.b <= naturalShadow.b);

  const naturalWarm = pixels.get('warm-1')[0];
  const amberWarm = pixels.get('warm-3')[0];
  assert.ok((amberWarm.r - amberWarm.b) > (naturalWarm.r - naturalWarm.b),
    `amber delta ${amberWarm.r - amberWarm.b} vs natural ${naturalWarm.r - naturalWarm.b}`);
  for (const sample of [naturalWarm, amberWarm]) {
    assert.ok(sample.r > sample.g && sample.g > sample.b, `${sample.r},${sample.g},${sample.b}`);
  }
  const cyanSky2 = pixels.get('cyansky-2')[0];
  assert.ok(cyanSky2.b > cyanSky2.g, `expected cyan sky shift toward cobalt blue (${cyanSky2.r},${cyanSky2.g},${cyanSky2.b})`);

  const fadedWhite = pixels.get('alpha-1')[0];
  assert.equal(fadedWhite.a, 0x80);
  assert.ok(fadedWhite.r >= 252 && fadedWhite.g >= 252 && fadedWhite.b >= 252);
  const fadedBlack = pixels.get('alpha-black-2')[0];
  assert.equal(fadedBlack.a, 0x7f);
  assert.ok(fadedBlack.r <= 2 && fadedBlack.g <= 2 && fadedBlack.b <= 2);
  assert.equal(pixels.get('noop-0')[0].pixel >>> 0, 0xFF123456);
  assert.equal(pixels.get('noop-99')[0].pixel >>> 0, 0x80ABCDEF);

  for (const style of [1, 2, 3]) {
    const values = lines.get(`G ramp-${style}`).slice(2).map(Number);
    assert.equal(values.length, 256 * 3);
    let previous = [-1, -1, -1];
    for (let i = 0; i < 256; i++) {
      const r = values[i * 3];
      const g = values[i * 3 + 1];
      const b = values[i * 3 + 2];
      assert.equal(r, g, `style ${style} gray ${i} red/green`);
      assert.equal(g, b, `style ${style} gray ${i} green/blue`);
      assert.ok(r >= previous[0] && g >= previous[1] && b >= previous[2], `style ${style} dip at ${i}`);
      previous = [r, g, b];
    }
    assert.equal(values[0], 0);
    assert.ok(values[253 * 3] >= 251, `style ${style} 253=${values[253 * 3]}`);
    assert.ok(values[254 * 3] >= 253, `style ${style} 254=${values[254 * 3]}`);
    assert.equal(values[255 * 3], 255, `style ${style} 255`);
    assert.ok(values[255 * 3] - values[254 * 3] <= 2,
      `style ${style} white shoulder discontinuity: ${values[254 * 3]} -> ${values[255 * 3]}`);
  }

  const valid = lines.get('C valid');
  assert.equal(valid[2], 'OK');
  assert.equal(Number(valid[3]), 24);
  assert.equal(Number(valid[4]), 2);
  assert.equal(Number(valid[5]), 42);
  const samples = valid.slice(6).map(Number);
  assert.equal(samples.length, 24);
  assert.deepEqual(samples.slice(0, 3), [0, 0, 0]);
  assert.deepEqual(samples.slice(3, 6), [1, 0, 0]);
  assert.deepEqual(samples.slice(21, 24), [0.25, 0.5, 0.75]);
  const nullSize = lines.get('C valid-null');
  assert.equal(nullSize[2], 'OK');
  assert.equal(Number(nullSize[3]), 24);
  assert.equal(nullSize.length, 4 + 24);

  for (const name of Object.keys(malformed)) {
    assert.deepEqual(lines.get(`C ${name}`).slice(2), ['REJECT'], name);
  }

  const bench = lines.get('B fullhd');
  const elapsed = Number(bench[2]);
  assert.equal(Number.isFinite(elapsed), true);
  assert.ok(elapsed >= 0 && elapsed < 15_000, `benchmark ${elapsed} ms`);
  const graded = channels(bench[3]);
  assert.equal(graded.a, 0xA5);
  console.log(`1920x1080 AppleStyleToneEngine benchmark: ${elapsed} ms`);
});

test('specialized scenes, per-capture bridge isolation, and strip overlap parity', () => {
  const dir = mkdtempSync(join(tmpdir(), 'bridge-isolation-test-'));
  try {
    const stubsDir = fileURLToPath(new URL(
      '../patches/custom_imaging_java/stubs/',
      import.meta.url,
    ));
    const stubFiles = [];
    const walk = (d) => {
      for (const entry of readdirSync(d, { withFileTypes: true })) {
        const full = join(d, entry.name);
        if (entry.isDirectory()) walk(full);
        else if (entry.name.endsWith('.java')) stubFiles.push(full);
      }
    };
    walk(stubsDir);
    const bridgeClasses = join(dir, 'classes');
    const overrideSrc = join(dir, 'override');
    const harnessSrc = join(dir, 'BridgeChecks.java');
    mkdirSync(bridgeClasses, { recursive: true });
    mkdirSync(join(overrideSrc, 'com', 'motorola', 'camera', 'settings'), { recursive: true });

    // Controllable PersistBehavior test double inside temp dir (keeps repo stubs unchanged).
    const testPersist = join(overrideSrc, 'com', 'motorola', 'camera', 'settings', 'PersistBehavior.java');
    writeFileSync(testPersist, `package com.motorola.camera.settings;
import android.content.SharedPreferences;
public final class PersistBehavior {
    public static String mockProfile = "0";
    public static SharedPreferences getPreferences() {
        return (key, defValue) -> mockProfile;
    }
}
`);
    const filteredStubs = stubFiles.filter((f) => !f.endsWith('PersistBehavior.java'));
    run(javac, ['--release', '11', '-d', bridgeClasses, ...filteredStubs, testPersist]);

    const customFiles = [
      selectorSource,
      toneSource,
      join(sourceDir, 'CleanBayerRawProcessor.java'),
      join(sourceDir, 'CustomImagingBridge.java'),
    ];
    run(javac, ['--release', '11', '-cp', bridgeClasses, '-d', bridgeClasses, ...customFiles]);

    writeFileSync(harnessSrc, `
import android.hardware.camera2.CaptureRequest;
import com.motorola.camera.capturedmediadata.CapturedImageMediaData;
import com.motorola.camera.custom.AppleStyleToneEngine;
import com.motorola.camera.custom.CustomImagingBridge;
import com.motorola.camera.custom.ScenePostProcSelector;
import com.motorola.camera.fsm.camera.record.ImageCaptureRecord;
import com.motorola.camera.fsm.camera.record.SequenceIdentifier;
import com.motorola.camera.saving.SaveImageService;
import com.motorola.camera.settings.PersistBehavior;
import java.util.Arrays;

public final class BridgeChecks {
    public static void main(String[] args) {
        // 1. Specialized Portrait/Bokeh/Night/SuperRes scenes must stay untouched (KEEP) across profiles.
        String[] preserved = {
            "RAW_HDR_PORTRAIT", "MULTI_FRAME_BOKEH", "RAW_HDR_NIGHT",
            "RAW_SN_AUTO", "SUPER_PORTRAIT", "RAW_SUPER_RESOLUTION", "FLASH"
        };
        for (int p : new int[] {0, 3, 5, 6, 7}) {
            for (String s : preserved) {
                int[] r = ScenePostProcSelector.resolve(p, 1.0f, 50.0f, s, false);
                if (r[0] != 0 || r[1] != -1 || r[2] != -1 || r[3] != -1 || r[5] != 0) {
                    throw new AssertionError("Specialized scene mutated for p=" + p + " scene=" + s + ": " + Arrays.toString(r));
                }
            }
        }
        int[] hdrRes = ScenePostProcSelector.resolve(0, 1.0f, 50.0f, "HDR", false);
        if (hdrRes[0] != ScenePostProcSelector.SCENE_RAW_HDR || hdrRes[1] != ScenePostProcSelector.NR_MINIMAL) {
            throw new AssertionError("Expected Auto HDR -> RAW_HDR+MINIMAL: " + Arrays.toString(hdrRes));
        }

        // 2. Per-capture isolation: Shot 10 (profile 5 LUT=1) vs overlapping Shot 11 (profile 0 LUT=0).
        ImageCaptureRecord rec10 = new ImageCaptureRecord();
        rec10.mSeqId = new SequenceIdentifier();
        rec10.mSeqId.mSeqId = 10;
        rec10.mUUID = 1001L;

        ImageCaptureRecord rec11 = new ImageCaptureRecord();
        rec11.mSeqId = new SequenceIdentifier();
        rec11.mSeqId.mSeqId = 11;
        rec11.mUUID = 1001L;

        PersistBehavior.mockProfile = "5";
        CustomImagingBridge.applyCaptureRequestOverrides("0", new CaptureRequest.Builder(), rec10);
        PersistBehavior.mockProfile = "0";
        CustomImagingBridge.applyCaptureRequestOverrides("0", new CaptureRequest.Builder(), rec11);

        SaveImageService.ImageContainer c10 = new SaveImageService.ImageContainer();
        c10.mMediaData = new CapturedImageMediaData();
        c10.mMediaData.mCaptureRecord = rec10;

        SaveImageService.ImageContainer c11 = new SaveImageService.ImageContainer();
        c11.mMediaData = new CapturedImageMediaData();
        c11.mMediaData.mCaptureRecord = rec11;

        if (!CustomImagingBridge.isCustomLutActive(c10)) {
            throw new AssertionError("Shot 10 lost its LUT=1 decision after Shot 11 captured");
        }
        if (CustomImagingBridge.isCustomLutActive(c11)) {
            throw new AssertionError("Shot 11 inherited LUT=1 unexpectedly");
        }
        // Delayed save survival after 600 newer distinct shots (> 512 LRU size) while rec10 stays alive.
        PersistBehavior.mockProfile = "0";
        for (int k = 100; k < 700; k++) {
            ImageCaptureRecord recK = new ImageCaptureRecord();
            recK.mSeqId = new SequenceIdentifier();
            recK.mSeqId.mSeqId = k;
            recK.mUUID = 1001L;
            CustomImagingBridge.applyCaptureRequestOverrides("0", new CaptureRequest.Builder(), recK);
        }
        if (!CustomImagingBridge.isCustomLutActive(c10)) {
            throw new AssertionError("Shot 10 was evicted after 600 newer captures despite live CaptureRecord");
        }

        // 2b. Profile 9 Disable Post Processing & flash MFNR preservation.
        PersistBehavior.mockProfile = "9";
        if (CustomImagingBridge.shouldAllowMcf(true)) {
            throw new AssertionError("Profile 9 must disable MCF");
        }
        int[] p9 = ScenePostProcSelector.resolve(9, 1.0f, 50.0f, "NORMAL", false, false);
        if (p9[0] != 0 || p9[1] != 0 || p9[2] != 0 || p9[3] != 0 || p9[5] != 0 || p9[6] != 0) {
            throw new AssertionError("Profile 9 unexpected decision: " + Arrays.toString(p9));
        }
        PersistBehavior.mockProfile = "4";
        if (!CustomImagingBridge.shouldAllowMcf(true)) {
            throw new AssertionError("Profile 4 Pure ISP keeps MCF flag intact");
        }
        if (!CustomImagingBridge.resolveEnableMfnr(true, true)) {
            throw new AssertionError("Flash=true must preserve stock MFNR enable");
        }
        if (CustomImagingBridge.resolveEnableMfnr(true, false)) {
            throw new AssertionError("Profile 4 without flash must force MFNR off");
        }
        if (CustomImagingBridge.resolveJpegQuality(95) != 98) {
            throw new AssertionError("Expected JPEG quality bump 95 -> 98");
        }

        // 3. Real parallel strip runner parity across BOTH strip seam (512) and batch-4 boundary (2048).
        int w = 64, h = 2160;
        int[] full = new int[w * h];
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                boolean brightBand = y < 512 || (y >= 1500 && y < 2048);
                int v = brightBand ? (180 + ((x + y) & 15)) : (40 + ((x * 3 + y) & 15));
                full[y * w + x] = 0xFF000000 | (v << 16) | ((v - 10) << 8) | Math.min(255, v + 12);
            }
        }
        int[] fullExpected = full.clone();
        AppleStyleToneEngine.applyToArgbPixels(fullExpected, w, h, AppleStyleToneEngine.STYLE_IPHONE_RICH_CONTRAST);

        int[] fullStripped = full.clone();
        if (!CustomImagingBridge.gradePixelBufferStrips(
                fullStripped, w, h, 512, 24, AppleStyleToneEngine.STYLE_IPHONE_RICH_CONTRAST)) {
            throw new AssertionError("gradePixelBufferStrips returned false");
        }

        for (int y : new int[] {508, 511, 512, 513, 518, 2025, 2047, 2048, 2049, 2055}) {
            for (int x = 16; x < w - 16; x++) {
                int pExp = fullExpected[y * w + x];
                int pStrip = fullStripped[y * w + x];
                int dr = Math.abs(((pExp >> 16) & 0xFF) - ((pStrip >> 16) & 0xFF));
                int dg = Math.abs(((pExp >> 8) & 0xFF) - ((pStrip >> 8) & 0xFF));
                int db = Math.abs((pExp & 0xFF) - (pStrip & 0xFF));
                if (dr > 1 || dg > 1 || db > 1) {
                    throw new AssertionError("Strip seam mismatch at (" + x + "," + y + ") dr=" + dr + " dg=" + dg + " db=" + db);
                }
            }
        }
    }
}
`);
    run(javac, ['--release', '11', '-cp', bridgeClasses, '-d', bridgeClasses, harnessSrc]);
    run(java, ['-cp', bridgeClasses, 'BridgeChecks']);
  } finally {
    rmSync(dir, { recursive: true, force: true });
  }
});
