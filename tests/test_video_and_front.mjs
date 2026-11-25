// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const sourceDir = fileURLToPath(new URL(
  '../patches/custom_imaging_java/src/com/motorola/camera/custom/',
  import.meta.url,
));
const frontSource = join(sourceDir, 'FrontAfHelper.java');
const videoSource = join(sourceDir, 'VideoConfigHelper.java');
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');

const probeSource = `
public final class VideoFrontProbe {
    public static void main(String[] args) {
        String[] lines = args[0].split("\\n", -1);
        for (String raw : lines) {
            if (raw.isEmpty()) continue;
            String[] p = raw.split(" ", -1);
            String op = p[0];
            if (op.equals("B")) {
                int value = com.motorola.camera.custom.VideoConfigHelper.resolveVideoBitrate(
                        Integer.parseInt(p[1]), Integer.parseInt(p[2]), p[3].equals("1"));
                System.out.println("B " + value);
            } else if (op.equals("H")) {
                boolean off = com.motorola.camera.custom.VideoConfigHelper.shouldDisableHdr10ForFps(
                        Integer.parseInt(p[1]));
                System.out.println("H " + (off ? 1 : 0));
            } else if (op.equals("P")) {
                int target = Integer.parseInt(p[1]);
                int[][] ranges = null;
                if (!p[2].equals("null")) {
                    int n = Integer.parseInt(p[2]);
                    ranges = new int[n][];
                    for (int i = 0; i < n; i++) {
                        String cell = p[3 + i];
                        if (cell.equals("-")) ranges[i] = null;
                        else if (cell.equals("x")) ranges[i] = new int[] { 1 };
                        else {
                            String[] pair = cell.split(",", -1);
                            ranges[i] = new int[] { Integer.parseInt(pair[0]), Integer.parseInt(pair[1]) };
                        }
                    }
                }
                int[] picked = com.motorola.camera.custom.VideoConfigHelper.pickPreferredHfrRange(target, ranges);
                System.out.println(picked == null ? "P none" : "P " + picked[0] + " " + picked[1]);
            } else if (op.equals("T")) {
                boolean step = com.motorola.camera.custom.VideoConfigHelper.shouldThermalStepDownFps(
                        Integer.parseInt(p[1]), Integer.parseInt(p[2]));
                System.out.println("T " + (step ? 1 : 0));
            } else if (op.equals("L")) {
                boolean done = com.motorola.camera.custom.FrontAfHelper.shouldComplete(
                        p[1].equals("1"), Integer.parseInt(p[2]), Integer.parseInt(p[3]), Integer.parseInt(p[4]));
                System.out.println("L " + (done ? 1 : 0));
            } else if (op.equals("Z")) {
                com.motorola.camera.custom.FrontAfHelper.beginCapture();
                System.out.println("Z " + com.motorola.camera.custom.FrontAfHelper.frameCount());
            } else if (op.equals("E")) {
                com.motorola.camera.custom.FrontAfHelper.endCapture();
                System.out.println("E " + com.motorola.camera.custom.FrontAfHelper.frameCount());
            } else if (op.equals("M")) {
                int count = com.motorola.camera.custom.FrontAfHelper.noteResult(
                        p[1].equals("1"), Integer.parseInt(p[2]));
                System.out.println("M " + count);
            } else if (op.equals("U")) {
                boolean done = com.motorola.camera.custom.FrontAfHelper.shouldCompleteCurrent(
                        p[1].equals("1"), Integer.parseInt(p[2]), Integer.parseInt(p[3]));
                System.out.println("U " + (done ? 1 : 0) + " " + com.motorola.camera.custom.FrontAfHelper.frameCount());
            } else if (op.equals("VE")) {
                System.out.println("VE " + com.motorola.camera.custom.VideoConfigHelper.resolveVideoEdgeMode());
            } else if (op.equals("VNR")) {
                System.out.println("VNR " + com.motorola.camera.custom.VideoConfigHelper.resolveVideoNoiseReductionMode(
                        Integer.parseInt(p[1])));
            } else if (op.equals("VAE")) {
                int target = Integer.parseInt(p[1]);
                boolean allowVar = p[2].equals("1");
                int n = Integer.parseInt(p[3]);
                int[][] ranges = new int[n][];
                for (int i = 0; i < n; i++) {
                    String[] pair = p[4 + i].split(",", -1);
                    ranges[i] = new int[] { Integer.parseInt(pair[0]), Integer.parseInt(pair[1]) };
                }
                int[] picked = com.motorola.camera.custom.VideoConfigHelper.resolveVideoAeRange(target, ranges, allowVar);
                System.out.println(picked == null ? "VAE none" : "VAE " + picked[0] + " " + picked[1]);
            } else if (op.equals("OIS")) {
                int[] avail = p[1].equals("-") ? null : new int[] { 0, Integer.parseInt(p[1]) };
                Integer cur = p[2].equals("null") ? null : Integer.valueOf(Integer.parseInt(p[2]));
                boolean dual = p[3].equals("1");
                System.out.println("OIS " + (com.motorola.camera.custom.VideoConfigHelper.shouldSetVideoOis(avail, cur, dual) ? 1 : 0));
            } else if (op.equals("AWBR")) {
                com.motorola.camera.custom.VideoConfigHelper.resetAwbSwitchTracker();
                System.out.println("AWBR");
            } else if (op.equals("AWBF")) {
                com.motorola.camera.custom.VideoConfigHelper.onVideoFramePhysicalCamera(p[1].equals("null") ? null : p[1]);
                Boolean lock = com.motorola.camera.custom.VideoConfigHelper.nextVideoAwbLockOverride();
                System.out.println("AWBF " + (lock == null ? "null" : (lock.booleanValue() ? "1" : "0")));
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

function probe(lines) {
  const stdout = run(java, ['-cp', work, 'VideoFrontProbe', lines.join('\n')]);
  return stdout.split(/\r?\n/).filter(line => line.length > 0);
}

before(() => {
  for (const source of [frontSource, videoSource]) {
    const text = readFileSync(source, 'utf8');
    assert.equal(/\bimport\s+/.test(text), false, source);
    assert.equal(text.includes('android.'), false, source);
  }
  work = mkdtempSync(join(tmpdir(), 'video-front-'));
  run(javac, ['--release', '11', '-d', work, frontSource, videoSource]);
  for (const name of ['FrontAfHelper.class', 'VideoConfigHelper.class']) {
    const bytecode = readFileSync(join(work, 'com/motorola/camera/custom', name));
    assert.equal(bytecode.readUInt16BE(0), 0xCAFE);
    assert.equal(bytecode.readUInt16BE(6), 55, name);
  }
  const harness = join(work, 'VideoFrontProbe.java');
  writeFileSync(harness, probeSource);
  run(javac, ['--release', '11', '-cp', work, '-d', work, harness]);
});

after(() => {
  if (work) rmSync(work, { recursive: true, force: true });
});

test('video bitrate scales by fps/30 and clamps under the XML caps', () => {
  const jobs = [
    ['B', 20_000_000, 30, 0],
    ['B', 20_000_000, 29, 0],
    ['B', 20_000_000, 0, 0],
    ['B', 20_000_000, -5, 0],
    ['B', 20_000_000, 59, 0],
    ['B', 20_000_000, 60, 0],
    ['B', 20_000_000, 120, 0],
    ['B', 17_500_000, 120, 1],
    ['B', 50_000_000, 60, 0],
    ['B', 35_000_000, 60, 1],
    ['B', 74_000_000, 30, 1],
    ['B', 74_000_000, 24, 1],
    ['B', 74_000_000, 60, 1],
    ['B', 105_000_000, 30, 0],
    ['B', 50_000_000, 120, 0],
    ['B', 2_000_000_000, 120, 1],
    ['B', 0, 60, 0],
    ['B', -1, 60, 1],
    ['B', 70_000_000, 30, 1],
    ['B', 100_000_000, 30, 0],
  ];
  const expected = [
    20_000_000,
    20_000_000,
    20_000_000,
    20_000_000,
    20_000_000,
    40_000_000,
    80_000_000,
    70_000_000,
    100_000_000,
    70_000_000,
    70_000_000,
    70_000_000,
    70_000_000,
    100_000_000,
    100_000_000,
    70_000_000,
    0,
    0,
    70_000_000,
    100_000_000,
  ];
  const lines = probe(jobs.map(job => job.join(' ')));
  assert.deepEqual(lines, expected.map(value => 'B ' + value));
});

test('HDR10 turns off at 60 fps and above', () => {
  const fps = [-1, 0, 30, 59, 60, 119, 120, 240];
  const lines = probe(fps.map(value => 'H ' + value));
  assert.deepEqual(lines, [
    'H 0', 'H 0', 'H 0', 'H 0', 'H 1', 'H 1', 'H 1', 'H 1',
  ]);
});

test('HFR picker prefers a fixed range and otherwise the first variable range', () => {
  const lines = probe([
    'P 120 2 30,120 120,120',
    'P 120 2 120,120 30,120',
    'P 120 2 30,120 60,120',
    'P 120 1 30,240',
    'P 120 0',
    'P 120 null',
    'P 60 2 30,60 60,60',
    'P 60 1 30,60',
    'P 60 3 - x 60,60',
    'P 120 1 180,120',
    'P 240 2 30,120 120,240',
  ]);
  assert.deepEqual(lines, [
    'P 120 120',
    'P 120 120',
    'P 30 120',
    'P none',
    'P none',
    'P none',
    'P 60 60',
    'P 30 60',
    'P 60 60',
    'P none',
    'P 120 240',
  ]);
});

test('thermal step-down starts at level 2 above 30 fps', () => {
  const lines = probe([
    'T 0 120',
    'T 1 60',
    'T 2 30',
    'T 2 31',
    'T 2 60',
    'T 2 24',
    'T 3 120',
    'T 3 30',
  ]);
  assert.deepEqual(lines, [
    'T 0', 'T 0', 'T 0', 'T 1', 'T 1', 'T 0', 'T 1', 'T 0',
  ]);
});

test('front CAF waits for focus or 12 frames and rear stays on the stock timeout', () => {
  const pure = [
    'L 0 4 0 0',
    'L 0 4 2 0',
    'L 1 3 2 0',
    'L 1 4 0 0',
    'L 1 4 1 0',
    'L 1 4 3 0',
    'L 1 4 6 11',
    'L 1 4 5 11',
    'L 1 4 6 12',
    'L 1 4 0 13',
    'L 1 4 2 0',
    'L 1 4 4 1',
    'L 1 4 2 -3',
  ];
  assert.deepEqual(probe(pure), [
    'L 0', 'L 0', 'L 0', 'L 0', 'L 0', 'L 0', 'L 0', 'L 0', 'L 1', 'L 1', 'L 1', 'L 1', 'L 1',
  ]);

  const session = ['Z'];
  for (let i = 0; i < 11; i++) session.push('M 1 4');
  session.push('U 1 4 6', 'M 0 4', 'U 1 4 6', 'M 1 4', 'U 1 4 6', 'E', 'U 1 4 0', 'Z');
  const lines = probe(session);
  assert.equal(lines[0], 'Z 0');
  for (let i = 1; i <= 11; i++) assert.equal(lines[i], 'M ' + i);
  assert.equal(lines[12], 'U 0 11');
  assert.equal(lines[13], 'M 0');
  assert.equal(lines[14], 'U 0 11');
  assert.equal(lines[15], 'M 12');
  assert.equal(lines[16], 'U 1 12');
  assert.equal(lines[17], 'E 0');
  assert.equal(lines[18], 'U 0 0');
  assert.equal(lines[19], 'Z 0');
});

test('video HAL helpers enforce EDGE=0, FPS-safe NR, fixed AE range, safe OIS, and 3-frame AWB switch lock', () => {
  const lines = probe([
    'VE',
    'VNR 30',
    'VNR 60',
    'VNR 120',
    'VAE 30 0 3 15,30 24,30 30,30',
    'VAE 30 1 3 15,30 24,30 30,30',
    'VAE 60 0 2 30,60 60,60',
    'VAE 60 0 1 30,60',
    'OIS 1 null 0',
    'OIS 1 0 0',
    'OIS 1 null 1',
    'AWBR',
    'AWBF 0',
    'AWBF 0',
    'AWBF 4',
    'AWBF 4',
    'AWBF 4',
    'AWBF 4',
    'AWBF 4',
  ]);
  assert.deepEqual(lines, [
    'VE 0',
    'VNR 2',
    'VNR 1',
    'VNR 1',
    'VAE 30 30',
    'VAE 24 30',
    'VAE 60 60',
    'VAE 30 60',
    'OIS 1',
    'OIS 0',
    'OIS 0',
    'AWBR',
    'AWBF null',
    'AWBF null',
    'AWBF 1',
    'AWBF 1',
    'AWBF 1',
    'AWBF 0',
    'AWBF null',
  ]);
});
