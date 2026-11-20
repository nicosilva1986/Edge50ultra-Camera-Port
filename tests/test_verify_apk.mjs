import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import { inspectApk } from '../scripts/verify_apk.mjs';

import { resolveBaseDir } from '../scripts/env_paths.mjs';

const STOCK_DIR = resolveBaseDir();
const STOCK_APK = `${STOCK_DIR}/apks/MotCamera4.apk`;
const MOD_APK = `${STOCK_DIR}/dist/MotCamera4-Mod.apk`;

function loadStockConfigs() {
  return {
    iq_config_ctwo: fs.readFileSync(`${STOCK_DIR}/configs/iq_config_ctwo`),
    app_feature_ctwo: fs.readFileSync(`${STOCK_DIR}/configs/app_feature_ctwo`),
    mcf_config_ctwo: fs.readFileSync(`${STOCK_DIR}/configs/mcf_config_ctwo.decrypted.json`),
  };
}

test('known-bad control: stock MotCamera4.apk fails clone isolation but passes archive & config parse', { skip: !fs.existsSync(STOCK_APK) }, () => {
  const bytes = fs.readFileSync(STOCK_APK);
  const res = inspectApk(bytes, loadStockConfigs(), 'com.motorola.camera3.mod');

  assert.equal(res.archive.pass, true, res.archive.error);
  assert.equal(res.manifest.pass, false);
  assert.equal(res.manifest.checks.package.pass, false);
  assert.equal(res.manifest.checks.package.actual, 'com.motorola.camera3');
  assert.equal(res.manifest.checks.permissionIsolation.pass, false);
  assert.equal(res.manifest.checks.providerIsolation.pass, false);
  assert.equal(res.manifest.checks.motoSignatureOptional.pass, false);
  assert.equal(res.manifest.checks.appLabel.pass, false);

  assert.equal(res.configs.iq_config_ctwo.pass, true);
  assert.equal(res.configs.iq_config_ctwo.diff.total, 0);
  assert.equal(res.configs.mcf_config_ctwo.diff.total, 0);
});

test('built clone APK passes full inspection if present on disk', { skip: !fs.existsSync(MOD_APK) }, () => {
  const bytes = fs.readFileSync(MOD_APK);
  const res = inspectApk(bytes, loadStockConfigs(), 'com.motorola.camera3.mod');

  assert.equal(res.archive.pass, true, res.archive.error);
  assert.equal(res.manifest.pass, true, JSON.stringify(res.manifest.checks));
  assert.ok(res.signingBlockSchemes.includes('v2') || res.signingBlockSchemes.includes('v3'));
  assert.ok(res.configs.iq_config_ctwo.diff.total > 0);
  assert.ok(res.configs.app_feature_ctwo.diff.total > 0);
  assert.ok(res.configs.mcf_config_ctwo.diff.total > 0);
});
