// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const source = fileURLToPath(new URL(
  '../patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameBurstController.java',
  import.meta.url,
));
const smaliRoot = 'C:/Users/soled/.gemini/antigravity/scratch/moto-camera-re/decompiled/MotCamera5_roadstr/smali';
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');

const HDR = 1;
const AEB = 2;
const SR = 3;
const FOCUS = 4;
const ND = 5;

const probeSource = `
public final class BurstProbe {
    public static void main(String[] args) throws Exception {
        String[] lines = args[0].split("\\n", -1);
        for (String raw : lines) {
            if (raw.isEmpty()) continue;
            String[] p = raw.split(" ", -1);
            String op = p[0];
            if (op.equals("Z")) {
                com.motorola.camera.custom.MultiFrameBurstController.reset();
                System.out.println("Z");
            } else if (op.equals("C")) {
                com.motorola.camera.custom.MultiFrameBurstController.configure(Integer.parseInt(p[1]));
                System.out.println("C");
            } else if (op.equals("O")) {
                byte[] bytes = new byte[Integer.parseInt(p[7])];
                boolean ok = com.motorola.camera.custom.MultiFrameBurstController.offer(
                        Long.parseLong(p[1]), Long.parseLong(p[2]), Integer.parseInt(p[3]),
                        Float.parseFloat(p[4]), Float.parseFloat(p[5]), Long.parseLong(p[6]),
                        bytes, p[8].equals("1"), p[9].equals("1"));
                System.out.println("O " + (ok ? 1 : 0) + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.size() + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.retainedBytes() + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.seqIds() + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.oldestSeqId());
            } else if (op.equals("M")) {
                com.motorola.camera.custom.MultiFrameBurstController.noteMetadata(
                        Long.parseLong(p[1]), Long.parseLong(p[2]), Integer.parseInt(p[3]),
                        Float.parseFloat(p[4]), Float.parseFloat(p[5]), Long.parseLong(p[6]),
                        p[7].equals("1"), p[8].equals("1"));
                System.out.println("M");
            } else if (op.equals("A")) {
                com.motorola.camera.custom.MultiFrameBurstController.abort(p[1]);
                System.out.println("A " + com.motorola.camera.custom.MultiFrameBurstController.size() + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.retainedBytes());
            } else if (op.equals("P")) {
                com.motorola.camera.custom.MultiFrameBurstController.Plan plan =
                        com.motorola.camera.custom.MultiFrameBurstController.planBurst(
                                Integer.parseInt(p[1]), Float.parseFloat(p[2]), Float.parseFloat(p[3]),
                                Integer.parseInt(p[4]), p[5].equals("1"), p[6].equals("1"));
                System.out.println("P " + plan.frameCount + " " + millis(plan.evOffsets) + " "
                        + millis(plan.focusDistances) + " " + plan.anchorSeqId + " "
                        + (plan.fallbackReason == null ? "none" : plan.fallbackReason) + " "
                        + (plan.singleRaw ? 1 : 0));
            } else if (op.equals("Q")) {
                System.out.println("Q "
                        + (com.motorola.camera.custom.MultiFrameBurstController.useSingleFrame() ? 1 : 0)
                        + " " + com.motorola.camera.custom.MultiFrameBurstController.plannedFrameCount());
            } else if (op.equals("N")) {
                String cameraId = p[1].equals("null") ? null : p[1];
                String secondId = p[2].equals("null") ? null : p[2];
                int bounded;
                if (p.length > 4) {
                    String thirdId = p[3].equals("null") ? null : p[3];
                    bounded = com.motorola.camera.custom.MultiFrameBurstController.boundRawMaxImages(
                            cameraId, secondId, thirdId, Integer.parseInt(p[4]));
                } else {
                    bounded = com.motorola.camera.custom.MultiFrameBurstController.boundRawMaxImages(
                            cameraId, secondId, Integer.parseInt(p[3]));
                }
                System.out.println("N " + bounded);
            } else if (op.equals("B")) {
                System.out.println("B "
                        + com.motorola.camera.custom.MultiFrameBurstController.estimateRawBytes(true) + " "
                        + com.motorola.camera.custom.MultiFrameBurstController.estimateRawBytes(false));
            } else if (op.equals("T")) {
                final int[] fail = new int[1];
                Thread left = new Thread(new Runnable() {
                    public void run() {
                        try {
                            for (int i = 0; i < 20; i++) {
                                com.motorola.camera.custom.MultiFrameBurstController.offer(
                                        i, 1000000L, 100, 1000f, 0.0001f, 1000L + i,
                                        new byte[16], false, true);
                            }
                        } catch (Throwable t) {
                            fail[0] = 1;
                        }
                    }
                });
                Thread right = new Thread(new Runnable() {
                    public void run() {
                        try {
                            for (int i = 0; i < 20; i++) {
                                com.motorola.camera.custom.MultiFrameBurstController.offer(
                                        100L + i, 1000000L, 100, 1000f, 0.0001f, 2000L + i,
                                        new byte[16], false, true);
                            }
                        } catch (Throwable t) {
                            fail[0] = 1;
                        }
                    }
                });
                left.start();
                right.start();
                left.join();
                right.join();
                System.out.println("T " + com.motorola.camera.custom.MultiFrameBurstController.size()
                        + " " + com.motorola.camera.custom.MultiFrameBurstController.retainedBytes()
                        + " " + fail[0]);
            } else {
                throw new IllegalArgumentException(op);
            }
        }
    }

    private static String millis(float[] values) {
        if (values == null || values.length == 0) return "-";
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < values.length; i++) {
            if (i > 0) out.append(',');
            out.append(Math.round(values[i] * 1000f));
        }
        return out.toString();
    }
}
`;

let work;

function run(executable, args, timeout = 120_000) {
  const result = spawnSync(executable, args, { encoding: 'utf8', timeout, windowsHide: true });
  assert.ifError(result.error);
  assert.equal(result.status, 0, [executable, ...args, result.stdout, result.stderr].join('\n'));
  return result.stdout;
}

function probe(lines) {
  const stdout = run(java, ['-cp', work, 'BurstProbe', lines.join('\n')]);
  return stdout.split(/\r?\n/).filter(line => line.length > 0);
}

function offerLine(ts, exp, iso, focal, gyro, seq, nbytes, sat, valid) {
  return `O ${ts} ${exp} ${iso} ${focal} ${gyro} ${seq} ${nbytes} ${sat} ${valid}`;
}

function sharp(seq, ts, gyro) {
  return offerLine(ts, 1_000_000, 100, 1000, gyro, seq, 8, 0, 1);
}

function planLine(mode, lux, range, thermal, front, macro) {
  return `P ${mode} ${lux} ${range} ${thermal} ${front} ${macro}`;
}

function parsePlan(line) {
  const p = line.split(' ');
  assert.equal(p[0], 'P');
  return {
    frames: Number(p[1]),
    ev: p[2].split(',').map(Number),
    focus: p[3] === '-' ? [] : p[3].split(',').map(Number),
    anchor: Number(p[4]),
    fallback: p[5],
    single: Number(p[6]),
  };
}

function parseOffer(line) {
  const p = line.split(' ');
  assert.equal(p[0], 'O');
  return {
    ok: Number(p[1]),
    size: Number(p[2]),
    bytes: Number(p[3]),
    seqs: p[4] === undefined || p[4] === '' ? [] : p[4].split(',').map(Number),
    oldest: Number(p[5]),
  };
}

function countOf(file, needle) {
  const text = readFileSync(file, 'utf8').replace(/\r\n/g, '\n');
  let found = 0;
  let from = 0;
  while (from <= text.length) {
    const at = text.indexOf(needle, from);
    if (at < 0) break;
    found += 1;
    from = at + needle.length;
  }
  return found;
}

before(() => {
  const text = readFileSync(source, 'utf8');
  assert.equal(/\bimport\s+/.test(text), false);
  assert.equal(text.includes('android.'), false);
  work = mkdtempSync(join(tmpdir(), 'burst-controller-'));
  run(javac, ['--release', '11', '-d', work, source]);
  const bytecode = readFileSync(join(work, 'com/motorola/camera/custom/MultiFrameBurstController.class'));
  assert.equal(bytecode.readUInt16BE(0), 0xCAFE);
  assert.equal(bytecode.readUInt16BE(6), 55);
  const harness = join(work, 'BurstProbe.java');
  writeFileSync(harness, probeSource);
  run(javac, ['--release', '11', '-cp', work, '-d', work, harness]);
});

after(() => {
  if (work) rmSync(work, { recursive: true, force: true });
});

test('binned OV50H RAW16 and RAW10 sizes sit under both byte caps', () => {
  const pixels = 4088 * 3068;
  const raw16 = pixels * 2;
  const raw10 = Math.floor((pixels * 5) / 4);
  const [line] = probe(['B']);
  assert.equal(line, `B ${raw16} ${raw10}`);
  assert.ok(raw16 * 6 < 320 * 1024 * 1024);
  assert.ok(raw16 * 8 < 420 * 1024 * 1024);
  assert.equal(raw16, 25_083_968);
  assert.equal(raw10, 15_677_480);
});

test('ring drops the oldest slot and its byte[] when the frame cap overflows', () => {
  const lines = [offerLine(1, 1_000_000, 100, 1000, 0.0002, 1, 8, 0, 1)];
  for (let seq = 2; seq <= 7; seq += 1) {
    lines.push(offerLine(seq, 1_000_000, 100, 1000, 0.0002, seq, 8, 0, 1));
  }
  lines.push(offerLine(40, 1_000_000, 100, 1000, 0.0002, 4, 4, 0, 1));
  lines.push(offerLine(80, 1_000_000, 100, 1000, 0.0002, 8, 8, 0, 1));
  const out = probe(lines).map(parseOffer);
  assert.equal(out[6].ok, 1);
  assert.equal(out[6].size, 6);
  assert.deepEqual(out[6].seqs, [2, 3, 4, 5, 6, 7]);
  assert.equal(out[6].oldest, 2);
  assert.equal(out[6].bytes, 48);
  assert.deepEqual(out[7].seqs, [2, 3, 5, 6, 7, 4]);
  assert.equal(out[7].bytes, 44);
  assert.deepEqual(out[8].seqs, [3, 5, 6, 7, 4, 8]);
  assert.equal(out[8].bytes, 44);
  assert.equal(out[8].size, 6);
});

test('super-resolution keeps eight frames and the larger byte cap', () => {
  const standard = probe([
    offerLine(1, 1_000_000, 100, 1000, 0.0002, 1, 200_000_000, 0, 1),
    offerLine(2, 1_000_000, 100, 1000, 0.0002, 2, 200_000_000, 0, 1),
  ]).map(parseOffer);
  assert.equal(standard[1].size, 1);
  assert.equal(standard[1].bytes, 200_000_000);
  assert.deepEqual(standard[1].seqs, [2]);

  const sr = probe([
    `C ${SR}`,
    offerLine(1, 1_000_000, 100, 1000, 0.0002, 1, 200_000_000, 0, 1),
    offerLine(2, 1_000_000, 100, 1000, 0.0002, 2, 200_000_000, 0, 1),
    offerLine(3, 1_000_000, 100, 1000, 0.0002, 3, 200_000_000, 0, 1),
  ]).filter(line => line.startsWith('O')).map(parseOffer);
  assert.equal(sr[2].size, 2);
  assert.equal(sr[2].bytes, 400_000_000);
  assert.deepEqual(sr[2].seqs, [2, 3]);

  const tiny = [];
  for (let seq = 1; seq <= 9; seq += 1) tiny.push(offerLine(seq, 1_000_000, 100, 1000, 0.0002, seq, 8, 0, 1));
  const overflow = probe([`C ${SR}`, ...tiny]).filter(line => line.startsWith('O')).map(parseOffer);
  assert.equal(overflow[8].size, 8);
  assert.deepEqual(overflow[8].seqs, [2, 3, 4, 5, 6, 7, 8, 9]);
  assert.equal(overflow[8].bytes, 64);
});

test('a buffer larger than the active cap is refused and leaves the ring untouched', () => {
  const refused = probe([
    offerLine(1, 1_000_000, 100, 1000, 0.0002, 1, 8, 0, 1),
    offerLine(2, 1_000_000, 100, 1000, 0.0002, 2, 320 * 1024 * 1024 + 1, 0, 1),
  ]).map(parseOffer);
  assert.equal(refused[0].ok, 1);
  assert.equal(refused[1].ok, 0);
  assert.equal(refused[1].size, 1);
  assert.equal(refused[1].bytes, 8);
  assert.deepEqual(refused[1].seqs, [1]);
});

test('anchor is the lowest motion under 0.75 px, skipping saturated and invalid frames', () => {
  const lines = [
    offerLine(10, 1_000_000, 100, 1000, 0.0001, 10, 8, 1, 1),
    offerLine(11, 1_000_000, 100, 1000, 0.0005, 11, 8, 0, 1),
    offerLine(12, 1_000_000, 100, 1000, 0.0002, 12, 8, 0, 0),
    offerLine(13, 1_000_000, 100, 1000, 0.01, 13, 8, 0, 1),
    offerLine(14, 1_000_000, 100, 1000, 0.0004, 14, 8, 0, 1),
    offerLine(15, 1_000_000, 100, 1000, 0.0004, 15, 8, 0, 1),
    offerLine(20, 1_000_000, 100, 1000, 0.0004, 16, 8, 0, 1),
    planLine(HDR, 0, 0, 0, 0, 0),
  ];
  const plan = parsePlan(probe(lines).at(-1));
  assert.equal(plan.anchor, 16);
  assert.equal(plan.fallback, 'none');
  assert.equal(plan.single, 0);
  assert.equal(plan.frames, 4);
});

test('motion of exactly 0.75 px is rejected and a lower-motion frame is accepted', () => {
  const rejected = parsePlan(probe([
    offerLine(1, 1_000_000, 100, 1, 0.75, 1, 8, 0, 1),
    planLine(HDR, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(rejected.fallback, 'no-anchor');
  assert.equal(rejected.anchor, -1);
  assert.equal(rejected.single, 1);
  assert.equal(rejected.frames, 1);

  const accepted = parsePlan(probe([
    offerLine(1, 1_000_000, 100, 1, 0.75, 1, 8, 0, 1),
    offerLine(2, 1_000_000, 100, 1, 0.749, 2, 8, 0, 1),
    planLine(AEB, 0, 4, 0, 0, 0),
  ]).at(-1));
  assert.equal(accepted.anchor, 2);
  assert.equal(accepted.fallback, 'none');
  assert.deepEqual(accepted.ev, [-2000, 0, 2000]);
  assert.equal(accepted.frames, 3);
});

test('camera 0 and camera 3 raw queues are capped at 6 and other ids are not', () => {
  const lines = probe([
    'N 0 null 10',
    'N null 3 8',
    'N 0 1 6',
    'N 0 null 1',
    'N 0 null 0',
    'N 1 null 10',
    'N 4 null 4',
    'N 2 5 2',
    'N 2 4 0 9',
    'N 2 4 1 9',
  ]);
  assert.deepEqual(lines, ['N 6', 'N 6', 'N 6', 'N 1', 'N 1', 'N 10', 'N 4', 'N 2', 'N 6', 'N 9']);
});

test('unknown gyro does not invent a sharp anchor', () => {
  const unknown = parsePlan(probe([
    offerLine(50, 0, 0, 0, -1, 7, 8, 0, 0),
    'M 50 1000000 80 1000 -1 7 0 1',
    planLine(ND, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(unknown.fallback, 'no-anchor');
  assert.equal(unknown.anchor, -1);
  assert.equal(unknown.single, 1);

  const kept = parsePlan(probe([
    offerLine(50, 0, 0, 1000, 0.0002, 7, 8, 0, 0),
    'M 50 1000000 80 1000 -1 7 0 1',
    planLine(ND, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(kept.anchor, 7);
  assert.equal(kept.fallback, 'none');
});

test('metadata noted before the raw buffer still becomes the anchor', () => {
  const plan = parsePlan(probe([
    'M 50 1000000 80 1000 0.0002 7 0 1',
    offerLine(50, 0, 0, 1, 1, 7, 8, 0, 0),
    planLine(ND, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(plan.anchor, 7);
  assert.equal(plan.fallback, 'none');
  assert.equal(plan.frames, 6);
  assert.deepEqual(plan.ev, [0, 0, 0, 0, 0, 0]);
  assert.deepEqual(plan.focus, []);
});

test('thermal level 2 steps the burst down and level 4 falls back to one raw frame', () => {
  const hdrPlan = parsePlan(probe([
    sharp(3, 3, 0.0002),
    planLine(HDR, 400, 4, 2, 0, 0),
  ]).at(-1));
  assert.equal(hdrPlan.frames, 4);
  assert.equal(hdrPlan.fallback, 'none');
  assert.equal(hdrPlan.ev[0], -2000);
  assert.equal(hdrPlan.ev.at(-1), 2000);
  for (let i = 1; i < hdrPlan.ev.length; i += 1) assert.ok(hdrPlan.ev[i] > hdrPlan.ev[i - 1]);

  const hdrCool = parsePlan(probe([
    sharp(3, 3, 0.0002),
    planLine(HDR, 400, 4, 1, 0, 0),
  ]).at(-1));
  assert.equal(hdrCool.frames, 6);
  assert.equal(hdrCool.fallback, 'none');

  const front = parsePlan(probe([
    sharp(3, 3, 0.0002),
    planLine(HDR, 400, 4, 0, 1, 0),
  ]).at(-1));
  assert.equal(front.frames, 4);

  const cutoff = probe([
    sharp(9, 9, 0.0002),
    planLine(HDR, 400, 4, 4, 0, 0),
    'Q',
  ]);
  const cutPlan = parsePlan(cutoff[1]);
  assert.equal(cutPlan.frames, 1);
  assert.equal(cutPlan.fallback, 'thermal-cutoff');
  assert.equal(cutPlan.single, 1);
  assert.equal(cutPlan.anchor, 9);
  assert.deepEqual(cutPlan.ev, [0]);
  assert.equal(cutoff[2], 'Q 1 1');

  const hotter = parsePlan(probe([
    sharp(9, 9, 0.0002),
    planLine(SR, 400, 0, 5, 0, 0),
  ]).at(-1));
  assert.equal(hotter.fallback, 'thermal-cutoff');
  assert.equal(hotter.frames, 1);

  const aeb = parsePlan(probe([
    sharp(4, 4, 0.0002),
    planLine(AEB, 0, 4, 2, 0, 0),
  ]).at(-1));
  assert.equal(aeb.frames, 3);
  assert.deepEqual(aeb.ev, [-2000, 0, 2000]);
  assert.equal(aeb.fallback, 'none');

  const nd = parsePlan(probe([
    sharp(4, 4, 0.0002),
    planLine(ND, 0, 0, 2, 0, 0),
  ]).at(-1));
  assert.equal(nd.frames, 4);
  assert.deepEqual(nd.ev, [0, 0, 0, 0]);

  const srFull = parsePlan(probe([
    sharp(4, 4, 0.0002),
    planLine(SR, 400, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(srFull.frames, 8);
  const srStep = parsePlan(probe([
    sharp(4, 4, 0.0002),
    planLine(SR, 400, 0, 2, 0, 0),
  ]).at(-1));
  assert.equal(srStep.frames, 6);
  const srFront = parsePlan(probe([
    sharp(4, 4, 0.0002),
    planLine(SR, 400, 0, 0, 1, 0),
  ]).at(-1));
  assert.equal(srFront.frames, 6);
});

test('macro focus stack sweeps the close distances and thermal 2 keeps the endpoints', () => {
  const full = parsePlan(probe([
    sharp(5, 5, 0.0002),
    planLine(FOCUS, 0, 0, 0, 0, 1),
  ]).at(-1));
  assert.equal(full.frames, 5);
  assert.deepEqual(full.focus, [2000, 4000, 6000, 8000, 10000]);
  assert.deepEqual(full.ev, [0, 0, 0, 0, 0]);
  assert.equal(full.fallback, 'none');
  assert.equal(full.anchor, 5);

  const stepped = parsePlan(probe([
    sharp(5, 5, 0.0002),
    planLine(FOCUS, 0, 0, 2, 0, 1),
  ]).at(-1));
  assert.equal(stepped.frames, 3);
  assert.deepEqual(stepped.focus, [2000, 6000, 10000]);

  const rear = parsePlan(probe([
    sharp(5, 5, 0.0002),
    planLine(FOCUS, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.deepEqual(rear.focus, [500, 1000, 2000, 4000, 8000]);

  const hdrMacro = parsePlan(probe([
    sharp(5, 5, 0.0002),
    planLine(HDR, 0, 0, 0, 0, 1),
  ]).at(-1));
  assert.deepEqual(hdrMacro.focus, []);
});

test('empty ring, abort, and an unknown mode fall back without throwing', () => {
  const empty = probe([
    'Q',
    planLine(HDR, 10, 2, 0, 0, 0),
    'Q',
  ]);
  assert.equal(empty[0], 'Q 0 -1');
  const emptyPlan = parsePlan(empty[1]);
  assert.equal(emptyPlan.fallback, 'empty');
  assert.equal(emptyPlan.frames, 1);
  assert.equal(emptyPlan.anchor, -1);
  assert.equal(emptyPlan.single, 1);
  assert.equal(empty[2], 'Q 1 1');

  const aborted = probe([
    sharp(1, 1, 0.0001),
    'A shutter-abort',
    offerLine(2, 1_000_000, 100, 1000, 0.0001, 2, 8, 0, 1),
    planLine(AEB, 0, 4, 0, 0, 0),
  ]);
  assert.equal(aborted[1], 'A 0 0');
  assert.equal(parseOffer(aborted[2]).ok, 0);
  const abortPlan = parsePlan(aborted[3]);
  assert.equal(abortPlan.fallback, 'shutter-abort');
  assert.equal(abortPlan.single, 1);
  assert.equal(abortPlan.anchor, -1);
  assert.equal(abortPlan.frames, 1);

  const unknown = parsePlan(probe([
    sharp(1, 1, 0.0001),
    planLine(99, 0, 0, 0, 0, 0),
  ]).at(-1));
  assert.equal(unknown.fallback, 'mode');
  assert.equal(unknown.frames, 1);
  assert.equal(unknown.single, 1);
});

test('concurrent offers stay inside the six-frame cap', () => {
  const [line] = probe(['T']);
  const [, size, bytes, fail] = line.split(' ').map((part, index) => (index === 0 ? part : Number(part)));
  assert.equal(line.startsWith('T '), true);
  assert.equal(fail, 0);
  assert.equal(size, 6);
  assert.equal(bytes, 96);
});

test('every cited MotCamera5 smali anchor exists once', () => {
  const anchors = [
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '.method public static checkCreateRawStream(Lcom/motorola/camera/fsm/camera/modes/PhotoMode$McfHolder;Ljava/util/ArrayList;Ljava/lang/String;Ljava/lang/String;Landroid/util/Size;ILcom/motorola/camera/mcf/McfInputStream$StreamType;Lcom/motorola/camera/settings/CameraType;Ljava/lang/String;Ljava/lang/String;)V'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    const/16 v8, 0x20\n\n    move/from16 v12, p5\n\n    move-object/from16 v1, p7\n\n    invoke-static {v7, v8, v12, v1, v5}, Lcom/motorola/camera/utility/SurfaceUtil;->newImageReader(Landroid/util/Size;IILcom/motorola/camera/settings/CameraType;Lcom/motorola/camera/fsm/camera/SurfaceManager$SurfaceType;)Landroid/media/ImageReader;'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    const/16 v11, 0x20\n\n    invoke-static {v10, v11, v5, v2, v8}, Lcom/motorola/camera/utility/SurfaceUtil;->newImageReaderWrapper(Landroid/util/Size;IILcom/motorola/camera/settings/CameraType;Lcom/motorola/camera/fsm/camera/SurfaceManager$SurfaceType;)Lcom/motorola/camera/utility/ImageReaderWrapper;'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '.method public final setupJpegImageReaderImpl(Lcom/motorola/camera/fsm/camera/FsmContext;Landroid/util/Size;ILcom/motorola/camera/settings/CameraType;Ljava/lang/String;)V'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    sget-object v3, Lcom/motorola/camera/fsm/camera/SurfaceManager$SurfaceType;->CAPTURE:Lcom/motorola/camera/fsm/camera/SurfaceManager$SurfaceType;\n\n    const/16 v0, 0x100\n\n    invoke-static {p2, v0, p3, p4, v3}, Lcom/motorola/camera/utility/SurfaceUtil;->newImageReaderWrapper(Landroid/util/Size;IILcom/motorola/camera/settings/CameraType;Lcom/motorola/camera/fsm/camera/SurfaceManager$SurfaceType;)Lcom/motorola/camera/utility/ImageReaderWrapper;'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->getQcfaRawImageFormat()I'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    const-string v4, "Exception: create stream: "'],
    ['com/motorola/camera/fsm/camera/modes/PhotoMode.smali',
      '    invoke-virtual {p1}, Lcom/motorola/camera/utility/ImageReaderWrapper;->close()V\n\n    iput-object v2, p0, Lcom/motorola/camera/fsm/camera/modes/PhotoMode;->mRawImageReader:Lcom/motorola/camera/utility/ImageReaderWrapper;'],
    ['com/motorola/camera/device/callables/CaptureBurstRequestCallable.smali',
      '.method public final call()Landroidx/viewpager/widget/ViewPager$4;'],
    ['com/motorola/camera/device/callables/CaptureBurstRequestCallable.smali',
      '    invoke-virtual {v1, v0, v3, p0}, Landroid/hardware/camera2/CameraCaptureSession;->captureBurst(Ljava/util/List;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/os/Handler;)I'],
    ['com/motorola/camera/saving/ImageCaptureManager.smali',
      '.method public static declared-synchronized onZslImage(Lcom/motorola/camera/utility/ImageReaderWrapper$ImageWrapper;)V'],
    ['com/motorola/camera/saving/ImageCaptureManager.smali',
      '.method public static declared-synchronized onCaptureCompleted(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)Z'],
    ['com/motorola/camera/saving/ImageCaptureManager.smali',
      '    const-string p1, "CaptureRequest tag is null!"'],
    ['com/motorola/camera/saving/ImageCaptureManager.smali',
      '    iget-object p0, v1, Lcom/motorola/camera/saving/ImageCaptureManager;->mZslResultMap:Lcom/motorola/camera/saving/ImageCaptureManager$1;\n\n    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;'],
    ['kotlinx/coroutines/internal/Symbol.smali',
      '    invoke-static {v1, v0}, Lcom/motorola/camera/saving/ImageCaptureManager;->-$$Nest$smonImage(Ljava/lang/String;Lcom/motorola/camera/utility/ImageReaderWrapper$ImageWrapper;)V'],
    ['com/motorola/camera/mcf/McfInputStream$OnStreamImageAvailableListener.smali',
      '    const-string p1, "onImageAvailable: stream is closed"'],
    ['com/motorola/camera/mcf/McfInputStream$OnStreamImageAvailableListener.smali',
      '    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/mcf/McfInputStream;->-$$Nest$smnative_stream_process_image(ILjava/lang/String;IILandroid/media/Image;II)I'],
    ['com/motorola/camera/fsm/camera/states/runnables/SetRepeatingRequestRunnable$SetRepeatingRequestListenerExt.smali',
      '    iget-object v2, v0, Lcom/motorola/camera/saving/ImageCaptureManager;->mZslResultMap:Lcom/motorola/camera/saving/ImageCaptureManager$1;\n\n    invoke-virtual {v2, v5, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;'],
    ['com/motorola/camera/fsm/camera/record/SequenceIdentifier.smali',
      '.field public final mSeqId:I'],
    ['com/motorola/camera/fsm/camera/modes/RequestBuilderHelper.smali',
      '    sget-object v1, Lcom/motorola/camera/settings/CustomKeyHelper;->MOT_CONTROL_CAPTURE_ZSL_MODE_KEY:Lcom/motorola/camera/settings/CustomKeyHelper$CaptureResultKey;'],
  ];
  for (const [rel, needle] of anchors) {
    const file = join(smaliRoot, rel);
    assert.equal(countOf(file, needle), 1, rel);
  }
});
