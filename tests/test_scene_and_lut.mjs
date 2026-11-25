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
            } else if (op.equals("X")) {
                int[] out = com.motorola.camera.custom.ScenePostProcSelector.resolveExtended(
                        Integer.parseInt(part[2]),
                        Float.parseFloat(part[3]),
                        Float.parseFloat(part[4]),
                        part[5],
                        part[6].equals("1"),
                        part[7].equals("1"),
                        part[8].equals("1"));
                System.out.print("X " + part[1]);
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

  addResolve('daylight-1x', 0, '1', '100', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
  addResolve('daylight-hdr', 0, '1', '120', 1, 0, 0, [2, 2, 1, 1, 0, 0, 0]);
  addResolve('dusk-1x', 0, '1', '160', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('tele-3x', 0, '3', '100', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('tele-3x-hdr', 0, '3', '140', 1, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('tele-295', 0, '2.95', '200', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('zoom-15x', 0, '15', '90', 0, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('zoom-15x-hdr', 0, '15', '90', 1, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('zoom-12-low-light', 0, '12', '400', 1, 0, 0, [1, 3, 1, 1, 0, 0, 0]);
  addResolve('low-light', 0, '1', '280', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('low-light-hdr', 0, '1', '350', 1, 0, 0, [0, 2, 0, 1, 0, 0, 0]);
  addResolve('tele-goes-low-light', 0, '3.5', '280', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('nan-zoom', 0, 'NaN', '100', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
  addResolve('nan-lux', 0, '1', 'NaN', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
  addResolve('nan-zoom-keeps-low-light', 0, 'NaN', '320', 0, 0, 0, [1, 2, 0, 1, 0, 0, 0]);
  addResolve('negative-zoom', 0, '-2', '80', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
  addResolve('negative-lux-hdr', 0, '1', '-40', 1, 0, 0, [2, 2, 1, 1, 0, 0, 0]);
  addResolve('infinity-zoom', 0, 'Infinity', '100', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
  addResolve('negative-infinity-lux', 0, '1', '-Infinity', 0, 0, 0, [1, 2, 1, 1, 0, 0, 0]);
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
  expectResolve.set('exact-295', [1, 2, 0, 1, 0, 0, 0]);
  expectResolve.set('exact-280', [1, 2, 0, 1, 0, 0, 0]);
  expectResolve.set('below-12', [1, 2, 0, 1, 0, 0, 0]);
  expectResolve.set('below-295', [1, 2, 1, 1, 0, 0, 0]);

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

  jobs.push('X uw-day 0 0.5 100 NORMAL 0 0 0');
  jobs.push('X uw-dusk 0 0.5 200 NORMAL 0 0 0');
  jobs.push('X isz2x-dusk 0 2.0 257 NORMAL 0 0 0');
  jobs.push('X isz2x-night 0 2.0 340 NORMAL 0 0 0');
  jobs.push('X tele3x-day 0 3.0 120 NORMAL 0 0 0');
  jobs.push('X tele6x-day 0 6.0 150 NORMAL 0 0 0');
  jobs.push('X tele6x-dusk 0 6.0 290 NORMAL 0 0 0');
  jobs.push('X detail-hdr 3 1.0 100 NORMAL 0 0 0');
  jobs.push('X p9-direct 9 2.0 250 NORMAL 0 0 0');

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

  const extChecks = {
    // [sceneAction, nr, edge, mfnr, sz, lut, raw, isz, aide, vsr, hdr, t2wLock, qll]
    'uw-day': [1, 2, 1, 1, 0, 0, 0, -1, 0, -1, -1, -1, -1],
    'uw-dusk': [1, 2, 1, 1, 0, 0, 0, -1, 0, -1, -1, -1, -1],
    'isz2x-dusk': [1, 2, 0, 1, 0, 0, 0, 1, 0, -1, -1, -1, -1],
    'isz2x-night': [1, 2, 0, 1, 0, 0, 0, 0, 1, -1, -1, -1, -1],
    'tele3x-day': [1, 2, 0, 1, 0, 0, 0, -1, 0, -1, -1, 1, -1],
    'tele6x-day': [1, 2, 0, 1, 0, 0, 0, 1, 0, 2, -1, 1, -1],
    'tele6x-dusk': [1, 2, 0, 1, 0, 0, 0, 0, 1, 2, -1, 1, -1],
    'detail-hdr': [1, 3, 0, 1, 0, 0, 0, -1, 0, -1, 2, -1, -1],
    'p9-direct': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0],
  };
  for (const [name, expected] of Object.entries(extChecks)) {
    const parts = lines.get(`X ${name}`);
    assert.ok(parts, `Missing extended check ${name}`);
    assert.deepEqual(parts.slice(2).map(Number), expected, `Extended mismatch for ${name}`);
  }
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

    // Controllable PersistBehavior + SettingsManager test doubles inside temp dir (keeps repo stubs unchanged).
    const testPersist = join(overrideSrc, 'com', 'motorola', 'camera', 'settings', 'PersistBehavior.java');
    writeFileSync(testPersist, `package com.motorola.camera.settings;
import android.content.SharedPreferences;
public final class PersistBehavior {
    public static String mockProfile = "0";
    public static String mockLook = null;
    public static String mockIntensity = null;
    public static SharedPreferences getPreferences() {
        return (key, defValue) -> {
            if ("com.motorola.camera.look_preset".equals(key) && mockLook != null) return mockLook;
            if ("com.motorola.camera.look_intensity".equals(key) && mockIntensity != null) return mockIntensity;
            return mockProfile;
        };
    }
}
`);
    const testSettingsMgr = join(overrideSrc, 'com', 'motorola', 'camera', 'settings', 'SettingsManager.java');
    writeFileSync(testSettingsMgr, `package com.motorola.camera.settings;
import android.hardware.camera2.CameraCharacteristics;
public final class SettingsManager {
    public static CameraType mockCamType = null;
    public static float mockZoomInv = 1f;
    public static CameraCharacteristics mockChars = null;
    public static String getCurrentCameraId() { return "2"; }
    public static CameraType getCurrentCameraType() { return mockCamType; }
    public static float getZoomValue(CameraType type) { return mockZoomInv; }
    public static CameraCharacteristics getCharacteristics(String cameraId) { return mockChars; }
}
`);
    const testIqMgr = join(overrideSrc, 'com', 'motorola', 'camera', 'IqConfigManager.java');
    writeFileSync(testIqMgr, `package com.motorola.camera;
public final class IqConfigManager {
    private static final IqConfigManager INST = new IqConfigManager();
    public float mLastLuxIdx = 0.0f;
    public static IqConfigManager getInstance() { return INST; }
}
`);
    const filteredStubs = stubFiles.filter(
      (f) => !f.endsWith('PersistBehavior.java') && !f.endsWith('SettingsManager.java') && !f.endsWith('IqConfigManager.java'),
    );
    run(javac, ['--release', '11', '-d', bridgeClasses, ...filteredStubs, testPersist, testSettingsMgr, testIqMgr]);

    const customFiles = [
      selectorSource,
      toneSource,
      join(sourceDir, 'CleanBayerRawProcessor.java'),
      join(sourceDir, 'CompassHudController.java'),
      join(sourceDir, 'CompassSolarHelper.java'),
      join(sourceDir, 'FrontAfHelper.java'),
      join(sourceDir, 'LookFilterEngine.java'),
      join(sourceDir, 'LookOptics.java'),
      join(sourceDir, 'MultiFrameBurstController.java'),
      join(sourceDir, 'MultiFrameRawEngine.java'),
      join(sourceDir, 'EffectsUiController.java'),
      join(sourceDir, 'LiveLookPreview.java'),
      join(sourceDir, 'BokehKernel.java'),
      join(sourceDir, 'OffscreenBokeh.java'),
      join(sourceDir, 'PortraitBokeh.java'),
      join(sourceDir, 'GainmapJpeg.java'),
      join(sourceDir, 'GpuComputeContext.java'),
      join(sourceDir, 'UltraHdrSynthesizer.java'),
      join(sourceDir, 'TelemetryCollector.java'),
      join(sourceDir, 'VideoConfigHelper.java'),
      join(sourceDir, 'CustomImagingBridge.java'),
    ];
    run(javac, ['--release', '11', '-cp', bridgeClasses, '-d', bridgeClasses, ...customFiles]);

    writeFileSync(harnessSrc, `
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import com.motorola.camera.capturedmediadata.CapturedImageMediaData;
import com.motorola.camera.custom.AppleStyleToneEngine;
import com.motorola.camera.custom.CustomImagingBridge;
import com.motorola.camera.custom.ScenePostProcSelector;
import com.motorola.camera.fsm.camera.record.ImageCaptureRecord;
import com.motorola.camera.fsm.camera.record.SequenceIdentifier;
import com.motorola.camera.saving.SaveImageService;
import com.motorola.camera.settings.CameraType;
import com.motorola.camera.settings.PersistBehavior;
import com.motorola.camera.settings.SettingsManager;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
        if (hdrRes[0] != ScenePostProcSelector.SCENE_RAW_HDR || hdrRes[1] != ScenePostProcSelector.NR_HIGH_QUALITY) {
            throw new AssertionError("Expected Auto HDR -> RAW_HDR+HIGH_QUALITY: " + Arrays.toString(hdrRes));
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
        // shouldAllowInSensorCrop must stay true for p=0,1,2,3,5,6,7,10 regardless of zoom/MFNR and false only for p=4,9.
        for (String pStr : new String[] {"0", "1", "2", "3", "5", "6", "7", "10"}) {
            PersistBehavior.mockProfile = pStr;
            if (!CustomImagingBridge.shouldAllowInSensorCrop()) {
                throw new AssertionError("shouldAllowInSensorCrop must be true for profile=" + pStr);
            }
        }
        PersistBehavior.mockProfile = "4";
        if (CustomImagingBridge.shouldAllowInSensorCrop()) {
            throw new AssertionError("shouldAllowInSensorCrop must be false for Pure ISP");
        }
        PersistBehavior.mockProfile = "9";
        if (CustomImagingBridge.shouldAllowInSensorCrop()) {
            throw new AssertionError("shouldAllowInSensorCrop must be false for Disable Post Processing");
        }
        PersistBehavior.mockProfile = "10";
        if (CustomImagingBridge.getSelectedProfile() != ScenePostProcSelector.PROFILE_AUTO_STOCK) {
            throw new AssertionError("Expected getSelectedProfile()==10 for Auto W/ Stock");
        }

        // 2c. Profile 0 extreme zoom SUPER_RESOLUTION override vs Profile 10 Auto (W/ Stock).
        int[] p0Sr15x = ScenePostProcSelector.resolve(0, 15.4f, 314.0f, "SUPER_RESOLUTION", false, false, false);
        if (p0Sr15x[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK
                || p0Sr15x[1] != ScenePostProcSelector.NR_MINIMAL
                || p0Sr15x[2] != ScenePostProcSelector.EDGE_FAST
                || p0Sr15x[3] != 1
                || p0Sr15x[4] != 0) {
            throw new AssertionError("Profile 0 at 15.4x SUPER_RESOLUTION must use HAL_FRAME_STACK+NR_MINIMAL+EDGE_FAST+MFNR=1+sz=0, got "
                    + Arrays.toString(p0Sr15x));
        }
        int[] p10Sr15x = ScenePostProcSelector.resolve(ScenePostProcSelector.PROFILE_AUTO_STOCK,
                15.4f, 314.0f, "SUPER_RESOLUTION", false, false, false);
        if (p10Sr15x[0] != ScenePostProcSelector.SCENE_KEEP || p10Sr15x[1] != -1 || p10Sr15x[4] != -1) {
            throw new AssertionError("Profile 10 at 15.4x SUPER_RESOLUTION must preserve Stock (-1), got "
                    + Arrays.toString(p10Sr15x));
        }
        int[] p10RawHdrRescue = ScenePostProcSelector.resolve(ScenePostProcSelector.PROFILE_AUTO_STOCK,
                1.0f, 120.0f, "RAW_HDR", false, false, false);
        if (p10RawHdrRescue[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK
                || p10RawHdrRescue[1] != -1 || p10RawHdrRescue[3] != 1 || p10RawHdrRescue[4] != -1) {
            throw new AssertionError("Profile 10 must rescue HTP-blocked RAW_HDR to HAL_FRAME_STACK while keeping NR/SZ=-1, got "
                    + Arrays.toString(p10RawHdrRescue));
        }
        int[] p10RawSrRescue = ScenePostProcSelector.resolve(ScenePostProcSelector.PROFILE_AUTO_STOCK,
                20.0f, 120.0f, "RAW_SUPER_RESOLUTION", false, false, false);
        if (p10RawSrRescue[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK || p10RawSrRescue[3] != 1) {
            throw new AssertionError("Profile 10 must rescue QNN-HTP-blocked RAW_SUPER_RESOLUTION when !htpAvailable, got "
                    + Arrays.toString(p10RawSrRescue));
        }
        int[] p0Ultra100x = ScenePostProcSelector.resolve(0, 100.0f, 120.0f, "NORMAL", false, false, false);
        if (p0Ultra100x[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK
                || p0Ultra100x[1] != ScenePostProcSelector.NR_FAST
                || p0Ultra100x[2] != ScenePostProcSelector.EDGE_OFF) {
            throw new AssertionError("Profile 0 at 100x must use HAL_FRAME_STACK+NR_FAST+EDGE_OFF (no block worms), got "
                    + Arrays.toString(p0Ultra100x));
        }
        PersistBehavior.mockProfile = "0";

        // 2d. Profile 0 High-DR LTM gate & zero-overshoot steerable zoom acutance.
        int[] flatFrame = new int[64 * 64];
        Arrays.fill(flatFrame, 0xFF808080);
        if (AppleStyleToneEngine.evaluateAutoLtmGate(flatFrame, flatFrame.length)) {
            throw new AssertionError("evaluateAutoLtmGate must return false on flat frame");
        }
        int[] normalOutdoor = new int[64 * 64];
        for (int i = 0; i < normalOutdoor.length; i++) {
            int y = i / 64;
            if (y < 6) normalOutdoor[i] = 0xFF141414;      // ~9% frame shadow
            else if (y < 60) normalOutdoor[i] = 0xFF7890B0; // ~84% midtones
            else normalOutdoor[i] = 0xFFF2F2F2;             // ~6% bright cloud
        }
        if (AppleStyleToneEngine.evaluateAutoLtmGate(normalOutdoor, normalOutdoor.length)) {
            throw new AssertionError("evaluateAutoLtmGate must ignore well-exposed daylight scenes with midCount > 62%");
        }
        int[] hdrFrame = new int[64 * 64];
        for (int i = 0; i < hdrFrame.length; i++) {
            int y = (i / 64);
            if (y < 24) hdrFrame[i] = 0xFF141414;       // ~37% deep shadows (<32)
            else if (y < 48) hdrFrame[i] = 0xFF808080;  // 37.5% midtones
            else hdrFrame[i] = 0xFFF4F4F4;              // 25% highlights (>236)
        }
        if (!AppleStyleToneEngine.evaluateAutoLtmGate(hdrFrame, hdrFrame.length)) {
            throw new AssertionError("evaluateAutoLtmGate must trigger on bimodal high-DR backlit frame");
        }
        int sw = 32, sh = 32;
        int[] stepEdge = new int[sw * sh];
        for (int y = 0; y < sh; y++) {
            for (int x = 0; x < sw; x++) {
                int v = x < 15 ? 40 : (x == 15 ? 120 : 210);
                stepEdge[y * sw + x] = 0xFF000000 | (v << 16) | (v << 8) | v;
            }
        }
        int[] edge100x = stepEdge.clone();
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                edge100x, sw, sh, 0, sw, sh, null, null, 0, 0, false, true, 100.0f);
        if (!Arrays.equals(stepEdge, edge100x)) {
            throw new AssertionError("Steerable zoom acutance must stay off above 30x");
        }
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                stepEdge, sw, sh, 0, sw, sh, null, null, 0, 0, false, true, 6.0f);
        for (int y = 2; y < sh - 2; y++) {
            for (int x = 2; x < sw - 2; x++) {
                int lum = stepEdge[y * sw + x] & 255;
                if (lum < 40 || lum > 210) {
                    throw new AssertionError("Steerable zoom acutance produced overshoot/ringing: lum=" + lum);
                }
            }
        }

        // Independent white-point monotonicity & highlight-gate check (prevents 254->242, 255->255 cliff).
        if (AppleStyleToneEngine.evaluateAutoHighlightGate(flatFrame, flatFrame.length)
                || AppleStyleToneEngine.evaluateAutoHighlightGate(normalOutdoor, normalOutdoor.length)) {
            throw new AssertionError("evaluateAutoHighlightGate must stay false when Y>=250 is <0.5%");
        }
        int[] clippedCloudFrame = new int[64 * 64];
        for (int i = 0; i < clippedCloudFrame.length; i++) {
            int y = i / 64;
            clippedCloudFrame[i] = y < 2 ? 0xFFFCFCFC : 0xFF808080; // ~3.1% near-clipped white (Y=252), 97% midtones
        }
        if (!AppleStyleToneEngine.evaluateAutoHighlightGate(clippedCloudFrame, clippedCloudFrame.length)) {
            throw new AssertionError("evaluateAutoHighlightGate must catch bright clouds (Y>=250 >=0.5%) even when midtones > 62%");
        }
        int[] whiteRamp = new int[256];
        for (int v = 0; v < 256; v++) whiteRamp[v] = 0xFF000000 | (v << 16) | (v << 8) | v;
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                whiteRamp, 256, 1, 0, 256, 1, null, null, 0, 0, false, true, false, 1.0f);
        int prevGray = -1;
        for (int v = 0; v < 256; v++) {
            int outY = whiteRamp[v] & 255;
            if (outY < prevGray) {
                throw new AssertionError("White-point shoulder must remain monotone at " + v + ": " + outY + " < " + prevGray);
            }
            if (v <= 224 && outY != v) {
                throw new AssertionError("Highlight-only shoulder must leave <=224 untouched at " + v + ", got " + outY);
            }
            prevGray = outY;
        }
        int g254 = whiteRamp[254] & 255;
        int g255 = whiteRamp[255] & 255;
        if (g255 - g254 > 2 || g255 < 248 || g255 > 250) {
            throw new AssertionError("Unexpected white-point shoulder endpoints: 254->" + g254 + ", 255->" + g255);
        }

        // 2e. Non-root (!htpAvailable) rescue for HTP-blocked RAW_SUPER_NIGHT / RAW_HDR / MOTION_CAPTURE.
        for (String s : new String[] {"RAW_SUPER_NIGHT", "RAW_SUPER_NIGHT_DEDICATED", "RAW_HDR", "MOTION_CAPTURE"}) {
            int[] rescued = ScenePostProcSelector.resolve(0, 1.0f, 500.0f, s, false, "RAW_SUPER_NIGHT_DEDICATED".equals(s), false);
            if (rescued[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK
                    || rescued[1] != ScenePostProcSelector.NR_HIGH_QUALITY
                    || rescued[2] != ScenePostProcSelector.EDGE_FAST
                    || rescued[3] != 1) {
                throw new AssertionError("Expected !htpAvailable dark rescue to HAL_FRAME_STACK+HQ_NR+MFNR=1 for " + s + ", got " + Arrays.toString(rescued));
            }
        }
        int[] rawHdrBrightNoHtp = ScenePostProcSelector.resolve(0, 1.0f, 80.0f, "RAW_HDR", false, false, false);
        if (rawHdrBrightNoHtp[0] != ScenePostProcSelector.SCENE_HAL_FRAME_STACK || rawHdrBrightNoHtp[3] != 1) {
            throw new AssertionError("Expected bright RAW_HDR -> HAL_FRAME_STACK when !htpAvailable: " + Arrays.toString(rawHdrBrightNoHtp));
        }
        int[] portraitNoHtp = ScenePostProcSelector.resolve(0, 1.0f, 80.0f, "RAW_HDR_PORTRAIT", false, true, false);
        if (portraitNoHtp[0] != ScenePostProcSelector.SCENE_KEEP || portraitNoHtp[1] != -1) {
            throw new AssertionError("Portrait must stay preserved even when !htpAvailable: " + Arrays.toString(portraitNoHtp));
        }
        int[] p9NoHtp = ScenePostProcSelector.resolve(9, 1.0f, 500.0f, "RAW_SUPER_NIGHT", false, false, false);
        if (p9NoHtp[0] != ScenePostProcSelector.SCENE_KEEP || p9NoHtp[3] != 0) {
            throw new AssertionError("Profile 9 must stay direct HAL / MFNR=0 even when !htpAvailable: " + Arrays.toString(p9NoHtp));
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

        // 4. Amber spatial optics (vignette + 6-tap deterministic grain) full-frame vs strip parity & gray corner balance.
        int w2 = 128, h2 = 640;
        int[] amberFull = new int[w2 * h2];
        Arrays.fill(amberFull, 0xFF888888);
        int[] amberExp = amberFull.clone();
        AppleStyleToneEngine.applyToArgbPixels(amberExp, w2, h2, AppleStyleToneEngine.STYLE_IPHONE_AMBER);
        int[] amberStrip = amberFull.clone();
        if (!CustomImagingBridge.gradePixelBufferStrips(amberStrip, w2, h2, 256, 24, AppleStyleToneEngine.STYLE_IPHONE_AMBER)) {
            throw new AssertionError("gradePixelBufferStrips Amber failed");
        }
        int corner = amberExp[0];
        int center = amberExp[(h2 / 2) * w2 + (w2 / 2)];
        if (((corner >> 8) & 0xFF) >= ((center >> 8) & 0xFF)) {
            throw new AssertionError("Expected Amber vignette darker corner than center");
        }
        for (int y = 0; y < h2; y += 37) {
            for (int x = 0; x < w2; x += 17) {
                if (amberExp[y * w2 + x] != amberStrip[y * w2 + x]) {
                    throw new AssertionError("Amber strip vs full pixel mismatch at (" + x + "," + y + ")");
                }
            }
        }

        // 5. Verified CamX vendor key injection: request-only keys vs session keys guard.
        List<CaptureRequest.Key<?>> ctwoVendorKeys = new ArrayList<>();
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.HDRMode", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.HDRModePreference", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableSHDR", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableQHDR", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization", Byte.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode", Byte.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableVSR", Integer.class));
        ctwoVendorKeys.add(new CaptureRequest.Key<>("com.lenovo.moto.SATFallback.T2W", Byte.class));

        // 5a. When HAL exposes vendor keys purely as per-request keys (absent from SessionKeys), they are injected.
        SettingsManager.mockChars = new CameraCharacteristics() {
            @Override
            public List<CaptureRequest.Key<?>> getAvailableCaptureRequestKeys() {
                return ctwoVendorKeys;
            }
            @Override
            public List<CaptureRequest.Key<?>> getAvailableSessionKeys() {
                return java.util.Collections.singletonList(
                        new CaptureRequest.Key<>("com.example.mock.SessionOnly", Integer.class));
            }
        };
        PersistBehavior.mockProfile = "0";
        SettingsManager.mockCamType = new CameraType();
        SettingsManager.mockZoomInv = 1f / 6.0f; // 6x tele -> triggers ISZ=1, VSR=2, t2wLock=1
        CaptureRequest.Builder req6x = new CaptureRequest.Builder();
        CustomImagingBridge.applyCaptureRequestOverrides("0", req6x, null);
        if (!Integer.valueOf(1).equals(req6x.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom", Integer.class)))) {
            throw new AssertionError("Expected EnableSnapshotOnlyInsensorZoom=1 at 6x daylight when request-only");
        }
        if (!Integer.valueOf(2).equals(req6x.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableVSR", Integer.class)))) {
            throw new AssertionError("Expected EnableVSR=2 at 6x when request-only");
        }
        if (!Byte.valueOf((byte) 0).equals(req6x.get(new CaptureRequest.Key<>("com.lenovo.moto.SATFallback.T2W", Byte.class)))) {
            throw new AssertionError("Expected SATFallback.T2W=0 lock at 6x daylight when request-only");
        }
        if (!Byte.valueOf((byte) 0).equals(req6x.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode", Byte.class)))) {
            throw new AssertionError("Expected enableMFNRAIDEMode=0 at 6x bright lux=50 when request-only");
        }

        // 5b. Fail-closed guard: when getAvailableSessionKeys() returns empty, KNOWN_SESSION_KEYS are NOT mutated per-shot.
        SettingsManager.mockChars = new CameraCharacteristics() {
            @Override
            public List<CaptureRequest.Key<?>> getAvailableCaptureRequestKeys() {
                return ctwoVendorKeys;
            }
            @Override
            public List<CaptureRequest.Key<?>> getAvailableSessionKeys() {
                return java.util.Collections.emptyList();
            }
        };
        CaptureRequest.Builder reqEmptySessionKeys = new CaptureRequest.Builder();
        CustomImagingBridge.applyCaptureRequestOverrides("0", reqEmptySessionKeys, null);
        if (reqEmptySessionKeys.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class)) != null
                || reqEmptySessionKeys.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableVSR", Integer.class)) != null
                || reqEmptySessionKeys.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom", Integer.class)) != null) {
            throw new AssertionError("KNOWN_SESSION_KEYS must fail-closed when getAvailableSessionKeys() is empty");
        }

        // 5b. On real SM8635 ctwo HAL, keys present in availableSessionKeys MUST NOT be mutated per-shot
        // (avoids Camera3Device::isReconfigurationRequired -> mid-shot reconfigureCamera -> MCXSuperFG -38 teardown).
        SettingsManager.mockChars = new CameraCharacteristics() {
            @Override
            public List<CaptureRequest.Key<?>> getAvailableCaptureRequestKeys() {
                return ctwoVendorKeys;
            }
            @Override
            public List<CaptureRequest.Key<?>> getAvailableSessionKeys() {
                return ctwoVendorKeys;
            }
        };
        CaptureRequest.Builder reqCtwoSessionGuarded = new CaptureRequest.Builder();
        CustomImagingBridge.applyCaptureRequestOverrides("0", reqCtwoSessionGuarded, null);
        if (reqCtwoSessionGuarded.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class)) != null
                || reqCtwoSessionGuarded.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableVSR", Integer.class)) != null
                || reqCtwoSessionGuarded.get(new CaptureRequest.Key<>("com.lenovo.moto.SATFallback.T2W", Byte.class)) != null) {
            throw new AssertionError("Session keys must NEVER be mutated per-shot in applyCaptureRequestOverrides");
        }

        // Session setup must NOT force EnableMFHDR=1 on non-pure sessions (prevents Chi MCXSuperFG sink failure);
        // Pure ISP / Disable PostProc still clears session HDR/VSR flags safely.
        PersistBehavior.mockProfile = "3";
        CaptureRequest.Builder sesHdr = new CaptureRequest.Builder();
        CustomImagingBridge.applySessionParameterOverrides("0", sesHdr);
        if (sesHdr.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class)) != null) {
            throw new AssertionError("Non-pure session setup must leave EnableMFHDR unset to avoid streaming graph failure");
        }
        PersistBehavior.mockProfile = "4";
        CaptureRequest.Builder sesPure = new CaptureRequest.Builder();
        CustomImagingBridge.applySessionParameterOverrides("0", sesPure);
        if (!Integer.valueOf(0).equals(sesPure.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class)))
                || !Integer.valueOf(0).equals(sesPure.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableVSR", Integer.class)))) {
            throw new AssertionError("Pure ISP session setup should explicitly clear EnableMFHDR=0 and EnableVSR=0");
        }

        // Empty characteristics must skip vendor keys safely without throwing or polluting builder.
        SettingsManager.mockChars = new CameraCharacteristics();
        CaptureRequest.Builder noSupport = new CaptureRequest.Builder();
        CustomImagingBridge.applyCaptureRequestOverrides("1", noSupport, null);
        if (noSupport.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableMFHDR", Integer.class)) != null) {
            throw new AssertionError("Unsupported key should not be set when CameraCharacteristics omits it");
        }
        SettingsManager.mockChars = null;
        SettingsManager.mockCamType = null;
        SettingsManager.mockZoomInv = 1f;
        PersistBehavior.mockProfile = "0";

        // 6. v1.7.0 Backlit Subject Gate, ISO-800 suppression, flat-sky safety, and daylight 1x acutance bounds.
        int[] backlitSample = new int[200];
        for (int i = 0; i < 200; i++) {
            backlitSample[i] = (i < 24) ? 0xFF282B1E : 0xFFBEBFC4; // 12% dark olive subject (Y~42) + 88% overcast cloud (Y~190)
        }
        if (!AppleStyleToneEngine.evaluateAutoBacklitSubjectGate(backlitSample, backlitSample.length)) {
            throw new AssertionError("Expected high-key overcast + 12% dark bird sample to pass evaluateAutoBacklitSubjectGate");
        }
        int[] openBeachSample = new int[200];
        for (int i = 0; i < 200; i++) {
            openBeachSample[i] = (i < 16) ? 0xFF64645E : 0xFFB0C8DC; // P5~100 bright coastal scene must reject
        }
        if (AppleStyleToneEngine.evaluateAutoBacklitSubjectGate(openBeachSample, openBeachSample.length)) {
            throw new AssertionError("Open coastal daylight scene (P5>=95) must NOT pass evaluateAutoBacklitSubjectGate");
        }
        int[] grayRamp = new int[256];
        for (int i = 0; i < 256; i++) {
            grayRamp[i] = 0xFF000000 | (i << 16) | (i << 8) | i;
        }
        if (AppleStyleToneEngine.evaluateAutoBacklitSubjectGate(grayRamp, grayRamp.length)) {
            throw new AssertionError("Flat full-range gray ramp must NOT pass evaluateAutoBacklitSubjectGate");
        }

        // Backlit curve must lift Y=42 olive feather noticeably while leaving overcast cloud Y=190 neutral & unshifted, and ISO>=800 must be no-op.
        int[] backlitTest = new int[32 * 32];
        for (int i = 0; i < backlitTest.length; i++) {
            backlitTest[i] = (i % 8 < 2) ? 0xFF2A3218 : 0xFFBEC0CA; // subtle lavender cast (spread 12) + olive dark subject
        }
        int[] backlitIso800 = backlitTest.clone();
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                backlitTest, 32, 32, 0, 32, 32,
                null, null, 0, 0, false, false, true, 6.0f, true, 100);
        int liftedBird = backlitTest[0];
        int birdY = (((liftedBird >> 16) & 255) * 77 + ((liftedBird >> 8) & 255) * 150 + (liftedBird & 255) * 29) >> 8;
        if (birdY < 60) {
            throw new AssertionError("Expected backlit lift to raise olive shadow Y=45 to >=60, got " + birdY);
        }
        int cloudPx = backlitTest[4];
        int cloudSpread = Math.max((cloudPx >> 16) & 255, Math.max((cloudPx >> 8) & 255, cloudPx & 255))
                - Math.min((cloudPx >> 16) & 255, Math.min((cloudPx >> 8) & 255, cloudPx & 255));
        if (cloudSpread >= 12) {
            throw new AssertionError("Expected cloud-tint clamp to damp subtle overcast cast (spread <12), got " + cloudSpread);
        }
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                backlitIso800, 32, 32, 0, 32, 32,
                null, null, 0, 0, false, false, true, 6.0f, true, 800);
        if (backlitIso800[0] != 0xFF2A3218) {
            throw new AssertionError("ISO >= 800 must suppress both backlit lift and zoom acutance");
        }

        // 7. v1.8.0 Look <-> PostProc policy coupling checks.
        int[] autoProMist = ScenePostProcSelector.resolveExtendedWithLook(
                ScenePostProcSelector.PROFILE_AUTO_SCENE_ADAPTIVE, 1.0f, 50.0f, "", false, false, false, 7, 80);
        if (autoProMist[2] != ScenePostProcSelector.EDGE_OFF) {
            throw new AssertionError("Diffusion look >=50% on Auto daylight must drop EDGE_FAST to EDGE_OFF, got " + autoProMist[2]);
        }
        int[] cleanRawCoupled = ScenePostProcSelector.resolveExtendedWithLook(
                ScenePostProcSelector.PROFILE_CLEAN_RAW_BAYER, 1.0f, 50.0f, "", false, false, false, 0, 100);
        if (cleanRawCoupled[5] != 0 || cleanRawCoupled[6] != 1) {
            throw new AssertionError("Clean RAW with look coupling should clear implicit lutStyle while preserving rawProcess=1");
        }
        if (!ScenePostProcSelector.isProtectedProfile(ScenePostProcSelector.PROFILE_PURE_ISP)
                || !ScenePostProcSelector.isProtectedProfile(ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING)
                || !ScenePostProcSelector.isProtectedProfile(ScenePostProcSelector.PROFILE_AUTO_STOCK)
                || ScenePostProcSelector.isProtectedProfile(ScenePostProcSelector.PROFILE_AUTO_SCENE_ADAPTIVE)) {
            throw new AssertionError("Protected profile classification mismatch");
        }

        // 8. P0-3 regression: Look at 0% intensity must NOT suppress stock Motorola applyColorTone.
        PersistBehavior.mockProfile = "0";
        PersistBehavior.mockLook = "1";
        PersistBehavior.mockIntensity = "0";
        if (CustomImagingBridge.isCustomLutActive()) {
            throw new AssertionError("Look@0% must not report custom LUT active");
        }
        PersistBehavior.mockIntensity = "50";
        if (!CustomImagingBridge.isCustomLutActive()) {
            throw new AssertionError("Look@50% must report custom LUT active");
        }
        PersistBehavior.mockLook = null;
        PersistBehavior.mockIntensity = null;

        // 9. v1.9.2 highlight gate (>=0.5% Y>=250) & neutral-safe sky cyan->cobalt protection.
        int[] belowGate = new int[201];
        for (int i = 0; i < 201; i++) {
            belowGate[i] = i == 0 ? 0xFFFDFDFD : 0xFF90C8E8; // 1/201 = 0.497% < ceil=2 -> reject
        }
        if (AppleStyleToneEngine.evaluateAutoHighlightGate(belowGate, belowGate.length)) {
            throw new AssertionError("Below-threshold (<0.5% Y>=250) sky sample must NOT trigger highlight shoulder");
        }
        int[] brightSkySample = new int[200];
        for (int i = 0; i < 200; i++) {
            brightSkySample[i] = i < 12 ? 0xFFFDFDFD : 0xFF90C8E8; // 6% >=250 -> trigger
        }
        if (!AppleStyleToneEngine.evaluateAutoHighlightGate(brightSkySample, brightSkySample.length)) {
            throw new AssertionError("Bright sky frame (>=0.5% Y>=250) must trigger highlight shoulder");
        }

        int[] skyAndGrayAndSkin = new int[] {
            0xFFD8D8D8, // neutral gray highlight (spread 0 -> invariant hue)
            0xFFE29674, // warm skin tone (R > G > B -> untouched by blue/cyan sky curve)
            0xFF5CE2FA  // bright cyan-drifted sky (B=250, G=226, R=92 -> pull G slightly toward cobalt before shoulder)
        };
        AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                skyAndGrayAndSkin, 3, 1, 0, 3, 1,
                null, null, 0, 0, false, true, false, 1.0f, false, 100);
        int gGray = skyAndGrayAndSkin[0];
        if (((gGray >> 16) & 255) != ((gGray >> 8) & 255) || ((gGray >> 8) & 255) != (gGray & 255)) {
            throw new AssertionError("Highlight roll-off must keep neutral gray strictly achromatic");
        }
        if (skyAndGrayAndSkin[1] != 0xFFE29674) {
            throw new AssertionError("Warm skin highlight below 224 peak must remain untouched: " + Integer.toHexString(skyAndGrayAndSkin[1]));
        }
        int skyOut = skyAndGrayAndSkin[2];
        int skyG = (skyOut >> 8) & 255, skyB = skyOut & 255;
        if (skyG >= skyB) {
            throw new AssertionError("Expected bright cyan sky stabilization to keep G well below B");
        }

        // 10. v2.0.0 UltraHdrSynthesizer ISO 21496-1 round-trip, ctwo is_mfnr_night request key & Dual-Illuminant Display P3 CCM.
        int uw = 32, uh = 32;
        float[] linHdr = new float[uw * uh];
        int[] sdrPost = new int[uw * uh];
        for (int i = 0; i < uw * uh; i++) {
            boolean spec = (i / uw) < 8 && (i % uw) < 8;
            linHdr[i] = spec ? 2.80f : 0.25f;
            int s8 = spec ? 242 : 137;
            sdrPost[i] = 0xFF000000 | (s8 << 16) | (s8 << 8) | s8;
        }
        com.motorola.camera.custom.UltraHdrSynthesizer.PlaneResult plane =
                com.motorola.camera.custom.UltraHdrSynthesizer.computeFromLinearAndSdr(linHdr, sdrPost, uw, uh, 4.0f);
        if (plane == null || plane.width != 8 || plane.height != 8 || plane.ratioMax < 2.5f) {
            throw new AssertionError("Expected valid 8x8 UltraHDR gainmap plane");
        }
        float sdrSpecLin = (float) Math.pow((242 / 255.0 + 0.055) / 1.055, 2.4);
        float recHdr = com.motorola.camera.custom.UltraHdrSynthesizer.reconstructLinearPeak(sdrSpecLin, plane, 0);
        if (Math.abs(recHdr - 2.80f) / 2.80f > 0.025f) {
            throw new AssertionError("ISO 21496-1 Gainmap round-trip error > 2.5%: " + recHdr);
        }
        int[] darkIndoor = new int[uw * uh];
        Arrays.fill(darkIndoor, 0xFF303030);
        if (com.motorola.camera.custom.UltraHdrSynthesizer.computeFromPreAndPostSdr(darkIndoor, darkIndoor, uw, uh, 2.8f) != null) {
            throw new AssertionError("Dark indoor frame without highlights must NOT synthesize a Gainmap");
        }

        // Dual-illuminant mired CCM interpolation + Display P3 vs sRGB gamut matrix.
        float[] idXyz = {1, 0, 0, 0, 1, 0, 0, 0, 1};
        float[] scaledXyz = {1.2f, 0, 0, 0, 1.0f, 0, 0, 0, 0.8f};
        float[] midCcmSrgb = com.motorola.camera.custom.CleanBayerRawProcessor.dualIlluminantSensorToOutputCcm(
                idXyz, 17, scaledXyz, 21, 4100f, false);
        float[] midCcmP3 = com.motorola.camera.custom.CleanBayerRawProcessor.dualIlluminantSensorToOutputCcm(
                idXyz, 17, scaledXyz, 21, 4100f, true);
        if (midCcmSrgb == null || midCcmP3 == null || Math.abs(midCcmSrgb[0] - midCcmP3[0]) < 0.05f) {
            throw new AssertionError("Expected distinct sRGB vs Display P3 dual-illuminant CCMs");
        }

        // ctwo real HAL partition: 70 session keys must stay untouched on adaptive Photo sessions so
        // EnableSnapshotOnlyInsensorZoom/XCFA/AIDE never collide with RequestBuilderHelper.setInsensorZoomForSession
        // in ChiFeature2GraphSelector::SelectFeatureGraphforRequestFromTable (0x50 SIGSEGV on MultiCameraSAT).
        SettingsManager.mockChars = new CameraCharacteristics() {
            @Override public List<CaptureRequest.Key<?>> getAvailableCaptureRequestKeys() { return ctwoVendorKeys; }
            @Override public List<CaptureRequest.Key<?>> getAvailableSessionKeys() { return ctwoVendorKeys; }
        };
        PersistBehavior.mockProfile = "0";
        CaptureRequest.Builder sesP0 = new CaptureRequest.Builder();
        CustomImagingBridge.applySessionParameterOverrides("0", sesP0);
        if (sesP0.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom", Integer.class)) != null
                || sesP0.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization", Byte.class)) != null
                || sesP0.get(new CaptureRequest.Key<>("org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode", Byte.class)) != null) {
            throw new AssertionError("EnableSnapshotOnlyInsensorZoom, EnableXCFAOptimization, and enableMFNRAIDEMode must stay unset on ctwo SAT sessions to avoid ChiFeature2GraphSelector SIGSEGV");
        }
        SettingsManager.mockChars = null;
    }
}
`);
    run(javac, ['--release', '11', '-cp', bridgeClasses, '-d', bridgeClasses, harnessSrc]);
    run(java, ['-cp', bridgeClasses, 'BridgeChecks']);
  } finally {
    rmSync(dir, { recursive: true, force: true });
  }
});
