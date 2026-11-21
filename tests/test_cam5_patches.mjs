import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';

import { decryptMcf, MCF5_KEY } from '../scripts/mcf_crypto.mjs';
import { REPO_ROOT, resolveBaseDir, resolveConfigsDir } from '../scripts/env_paths.mjs';

const PATCHES_PATH = path.join(REPO_ROOT, 'patches', 'smali_patches_cam5.json');
const DECOMPILED_CAM5 = process.env.MOTCAM5_SRC || path.join(resolveBaseDir(), 'decompiled', 'MotCamera5_roadstr');
const STAGE_CAM5 = path.join(resolveBaseDir(), 'work_motcam5');

test('smali_patches_cam5.json loads cleanly and defines valid unique patch entries', () => {
  const data = JSON.parse(fs.readFileSync(PATCHES_PATH, 'utf8'));
  assert.equal(data.targetPackage, 'com.motorola.camera5');
  assert.equal(data.targetVersion, '10.0.44.42');
  assert.ok(Array.isArray(data.patches) && data.patches.length === 23);

  for (const name of ['CustomImagingBridge', 'ScenePostProcSelector', 'AppleStyleToneEngine', 'CleanBayerRawProcessor']) {
    const sp = path.join(REPO_ROOT, 'patches', 'custom_imaging_smali', 'com', 'motorola', 'camera', 'custom', `${name}.smali`);
    assert.ok(fs.existsSync(sp), `Missing compiled custom smali: ${sp}`);
  }

  const ids = new Set();
  for (const patch of data.patches) {
    assert.ok(patch.id && !ids.has(patch.id), `Duplicate or missing patch id: ${patch.id}`);
    ids.add(patch.id);
    assert.ok(patch.category && patch.description);
    assert.ok(patch.file && patch.find && typeof patch.replace === 'string');
    assert.notEqual(patch.find, patch.replace, `No-op patch: ${patch.id}`);
  }
});

test(
  'every cam5 patch applies uniquely in sequence against decompiled MotCamera5_roadstr',
  { skip: !fs.existsSync(DECOMPILED_CAM5) },
  () => {
    const data = JSON.parse(fs.readFileSync(PATCHES_PATH, 'utf8'));
    const cache = new Map();
    for (const patch of data.patches) {
      const targetPath = path.join(DECOMPILED_CAM5, patch.file);
      assert.ok(fs.existsSync(targetPath), `Missing target file for ${patch.id}: ${targetPath}`);
      if (!cache.has(targetPath)) {
        cache.set(targetPath, fs.readFileSync(targetPath, 'utf8').replace(/\r\n/g, '\n'));
      }
      const content = cache.get(targetPath);
      const occurrences = content.split(patch.find).length - 1;
      assert.equal(occurrences, 1, `Patch ${patch.id} matched ${occurrences} times (expected 1)`);
      cache.set(targetPath, content.split(patch.find).join(patch.replace));
    }
  },
);

test(
  'staged work_motcam5 configs disable hq-preview, gate 2x ISZ lux, and strip zoom SR bloat',
  { skip: !fs.existsSync(path.join(STAGE_CAM5, 'assets', 'config_device_ctwo')) || !fs.existsSync(resolveConfigsDir()) },
  () => {
    const dev = JSON.parse(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'config_device_ctwo'), 'utf8'));
    for (const cam of ['BACK_MAIN', 'BACK_TELE', 'ZOOM_BLENDING']) {
      const idx = dev.ctwo['camera-type'].indexOf(cam);
      assert.ok(idx >= 0, `Missing camera-type ${cam}`);
      assert.equal(dev.ctwo['hq-preview'][idx], false, `Expected hq-preview=false for ${cam}`);
    }
    assert.deepEqual(
      dev.ctwo['in-sensor-crop-logic']?.['in-sensor-crop-back-main-overrides']?.['in-sensor-crop-lux-idx-threshold'],
      [200, 230],
    );
    assert.ok((dev.ctwo['remosaic-config']?.['to-high-res-rg-threshold']?.[0] ?? 9) <= 0.1);

    const feat = JSON.parse(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'app_feature_ctwo'), 'utf8'));
    assert.equal(
      feat.fs.some((entry) => entry.f === 'SET_EXTRA_FREE_REPEATEDLY'),
      false,
      'SET_EXTRA_FREE_REPEATEDLY must be omitted from Camera 5 app_feature_ctwo',
    );

    const mcf = JSON.parse(decryptMcf(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'mcf_config_ctwo')), MCF5_KEY).toString('utf8'));
    assert.ok(mcf.ctwo['state-machine']?.['raw-super-resolution']?.enable.every((v) => v === false));
    assert.ok(mcf.ctwo['state-machine']?.['hal-super-resolution']?.enable.every((v) => v === false));
    assert.ok(mcf.ctwo['scene-classifer']?.['super-resolution']?.enable.every((v) => v === false));
    const srThresh = mcf.ctwo['arcsoft-tf-drsd']?.['custom-thresh']?.find((t) => t?.variant === 'super-resolution');
    assert.ok(srThresh && srThresh['zoom-thresh-in'].every((v) => v >= 999));
  },
);
