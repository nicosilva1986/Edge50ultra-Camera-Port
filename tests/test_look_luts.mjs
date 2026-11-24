import { test } from 'node:test';
import assert from 'node:assert/strict';
import { LOOKS, generateClut } from '../scripts/generate_look_luts.mjs';

test('catalog IDs are stable and every RGB8 cube has 33 cubed entries', () => {
  assert.deepEqual(LOOKS.map(look => look.id), Array.from({ length: 13 }, (_, i) => i + 1));
  assert.ok(LOOKS.slice(6).every(look => look.category === 'Film'));
  assert.equal(LOOKS.some(look => /2026/.test(look.category)), false);
  const cubes = LOOKS.map(({ id }) => generateClut(id));
  assert.equal(new Set(cubes.map(cube => cube.toString('base64'))).size, 13);
  assert.ok(cubes.every(cube => cube.length === 33 ** 3 * 3));
  assert.deepEqual(generateClut(1), cubes[0]);
  assert.throws(() => generateClut(0), RangeError);
});

test('monochrome cube is neutral and its orange filter darkens blue relative to red', () => {
  const cube = generateClut(3);
  for (let i = 0; i < cube.length; i += 3) {
    assert.equal(cube[i], cube[i + 1]);
    assert.equal(cube[i], cube[i + 2]);
  }
  assert.ok(cube[32 * 3] > cube[32 * 33 * 33 * 3]);
});

test('neutral optical cube preserves the grayscale axis and tonal ordering', () => {
  const cube = generateClut(4);
  let previous = -1;
  for (let level = 0; level < 33; level++) {
    const offset = 3 * level * (1 + 33 + 33 ** 2);
    assert.equal(cube[offset], cube[offset + 1]);
    assert.equal(cube[offset], cube[offset + 2]);
    assert.ok(cube[offset] > previous);
    previous = cube[offset];
  }
});

import { spawnSync } from 'node:child_process';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

test('Java sampler uses a tetrahedral interior, preserves alpha, and rejects truncated cubes', () => {
  const work = mkdtempSync(join(tmpdir(), 'look-cube-'));
  try {
    const engine = fileURLToPath(new URL('../patches/custom_imaging_java/src/com/motorola/camera/custom/LookFilterEngine.java', import.meta.url));
    const harness = join(work, 'LookProbe.java');
    writeFileSync(harness, `
import java.io.*;
import com.motorola.camera.custom.LookFilterEngine;
class LookProbe {
    public static void main(String[] args) throws Exception {
        byte[] cube = new byte[33 * 33 * 33 * 3];
        cube[3 * (1 + 33 + 33 * 33)] = (byte) 255;
        LookFilterEngine filter = LookFilterEngine.read(new ByteArrayInputStream(cube));
        int[] pixels = { 0x7f060402, 0xff060402, 0xffffffff };
        filter.apply(pixels, 0, 1, 100);
        filter.apply(pixels, 1, 1, 50);
        filter.apply(pixels, 2, 1, 0);
        // Fractions 192/255, 128/255, 64/255. Only the final vertex is lit.
        if (pixels[0] != 0x7f400000 || pixels[1] != 0xff230201 || pixels[2] != -1)
            throw new AssertionError(java.util.Arrays.toString(pixels));
        try {
            LookFilterEngine.read(new ByteArrayInputStream(new byte[0]));
            throw new AssertionError("accepted truncated cube");
        } catch (IOException expected) {}
    }
}
`);
    const java = resolveJava();
    const javac = join(java, '..', process.platform === 'win32' ? 'javac.exe' : 'javac');
    const compile = spawnSync(javac, ['--release', '11', '-d', work, engine, harness], { encoding: 'utf8' });
    assert.ifError(compile.error);
    assert.equal(compile.status, 0, compile.stderr);
    const run = spawnSync(java, ['-cp', work, 'LookProbe'], { encoding: 'utf8' });
    assert.ifError(run.error);
    assert.equal(run.status, 0, run.stderr);
  } finally {
    rmSync(work, { recursive: true, force: true });
  }
});
