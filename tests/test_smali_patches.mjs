import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';

import { REPO_ROOT, resolveBaseDir } from '../scripts/env_paths.mjs';

const PATCHES_PATH = path.join(REPO_ROOT, 'patches', 'smali_patches.json');
const DECOMPILED_ROOT = path.join(resolveBaseDir(), 'decompiled', 'MotCamera4_v3');

test('smali_patches.json loads cleanly and defines valid unique patch entries', () => {
  const data = JSON.parse(fs.readFileSync(PATCHES_PATH, 'utf8'));
  assert.equal(data.targetPackage, 'com.motorola.camera3.mod');
  assert.ok(Array.isArray(data.patches) && data.patches.length >= 15);

  const ids = new Set();
  for (const patch of data.patches) {
    assert.ok(patch.id && !ids.has(patch.id), `Duplicate or missing patch id: ${patch.id}`);
    ids.add(patch.id);
    assert.ok(patch.file && patch.find && typeof patch.replace === 'string');
    assert.notEqual(patch.find, patch.replace, `No-op patch: ${patch.id}`);
  }
});

test('every patch matches uniquely once against decompiled MotCamera4_v3', { skip: !fs.existsSync(DECOMPILED_ROOT) }, () => {
  const data = JSON.parse(fs.readFileSync(PATCHES_PATH, 'utf8'));
  for (const patch of data.patches) {
    const targetPath = path.join(DECOMPILED_ROOT, patch.file);
    assert.ok(fs.existsSync(targetPath), `Missing target smali file for ${patch.id}: ${targetPath}`);
    const content = fs.readFileSync(targetPath, 'utf8').replace(/\r\n/g, '\n');
    const occurrences = content.split(patch.find).length - 1;
    assert.equal(occurrences, 1, `Patch ${patch.id} matched ${occurrences} times (expected 1)`);
  }
});
