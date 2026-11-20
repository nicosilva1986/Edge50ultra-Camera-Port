import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import { existsSync, readFileSync } from 'node:fs';
import { test } from 'node:test';
import { fileURLToPath } from 'node:url';

import { decryptMcf, encryptMcf } from '../scripts/mcf_crypto.mjs';
import { REPO_ROOT, resolveConfigsDir, resolveJshell } from '../scripts/env_paths.mjs';
import { join } from 'node:path';
import { pathToFileURL } from 'node:url';

const stockDir = pathToFileURL(resolveConfigsDir() + '/');
const modDir = pathToFileURL(join(REPO_ROOT, 'configs_mod') + '/');
const hasStockAndMod = existsSync(new URL('mcf_config_ctwo', stockDir)) && existsSync(new URL('mcf_config_ctwo', modDir));
const readStock = name => readFileSync(new URL(name, stockDir));
const readMod = name => readFileSync(new URL(name, modDir));
const hash = bytes => createHash('sha256').update(bytes).digest('hex');

// Preserve original number tokens in the oracle, including floating-point
// forms like 1.0 that a native JSON reader can distinguish from integers.
function readSchema(bytes) {
  return JSON.parse(bytes, (_key, value, context) =>
    typeof value === 'number' ? JSON.rawJSON(context.source) : value,
  );
}

function cloneConfig(value) {
  return JSON.parse(JSON.stringify(value), (_key, inner, context) =>
    typeof inner === 'number' ? JSON.rawJSON(context.source) : inner,
  );
}

function assertConfig(bytes, expected) {
  JSON.parse(bytes);
  assert.equal(JSON.stringify(readSchema(bytes)), JSON.stringify(expected));
}

function sceneSignature(rows) {
  return rows.map(row => ({
    zoom: row.zoom_range.map(value => value.rawJSON),
    lux: row.lux_range.map(value => value.rawJSON),
    scene: row.override_scene,
  }));
}

const disabled = [false, false, false, false, false, false, false, false];
const halStack = [
  'MCF_BST_PURPLE_FRINGE_CAPTURE_ALG',
  'MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG',
  'MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG',
];
const stockStartup = [
  ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_TETRAS_RAW_SUPER_RESOLUTION_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_ARCSOFT_TF_REFOCUS_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_ARCSOFT_TF_REFOCUS_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ['MCF_TETRAS_RAW_SUPER_RESOLUTION_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
];
const stockHal = [
  'MCF_ML_MODEL_CUD',
  'MCF_BST_PURPLE_FRINGE_CAPTURE_ALG',
  'MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG',
  'MCF_BST_DISTORTION_CORRECTION_CAPTURE_ALG',
  'MCF_TETRAS_SENSEPR_CAPTURE_ALG',
  'MCF_FOTONATION_BEAUTY_CAPTURE_ALG',
  'MCF_MOT_SELECTIVE_COLOR_CAPTURE_ALG',
  'MCF_AS_MINIATURE_BOKEH_CAPTURE_ALG',
  'MCF_ARCSOFT_LL_AI_PORTRAIT_CAPTURE_ALG',
  'MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG',
  'MCF_BST_DSLR_CAPTURE_ALG',
  'MCF_MOT_COMPOSITION_ALG',
];

test('stock decryption matches the 188,320-byte reference and round-trips exactly', { skip: !hasStockAndMod }, () => {
  const reference = readStock('mcf_config_ctwo.decrypted.json');
  assert.equal(reference.length, 188320);
  assert.equal(hash(reference), '3a5e42b7b6bc3f701e61e0c18fe80531c19b8b796ee7e4d150fbda36bd5d4228');

  const plaintext = decryptMcf(readStock('mcf_config_ctwo'));
  assert.deepEqual(plaintext, reference);
  assert.deepEqual(decryptMcf(encryptMcf(plaintext)), reference);
});

test('mod ciphertext decodes to the exact readable MCF bytes and encrypts deterministically', { skip: !hasStockAndMod }, () => {
  const plaintext = readMod('mcf_config_ctwo.mod.json');
  const ciphertext = readMod('mcf_config_ctwo');

  assert.notDeepEqual(ciphertext, readStock('mcf_config_ctwo'));
  assert.deepEqual(decryptMcf(ciphertext), plaintext);
  assert.deepEqual(encryptMcf(plaintext), ciphertext);
});

test('truncated ciphertext is rejected and empty plaintext round-trips', { skip: !hasStockAndMod }, () => {
  const ciphertext = readStock('mcf_config_ctwo');
  assert.throws(() => decryptMcf(ciphertext.subarray(0, -1)), /Blowfish.*length/);
  assert.deepEqual(decryptMcf(encryptMcf(Buffer.alloc(0))), Buffer.alloc(0));
});

test('IQ keeps the low-light exposure edits, lowers MFNR throttles, and routes HDR off and auto-off to HAL_FRAME_STACK', { skip: !hasStockAndMod }, () => {
  const stock = readStock('iq_config_ctwo');
  const stockSchema = readSchema(stock);
  const expected = readSchema(stock);
  const schedule = expected.ctwo.qc_mfnr_settings.exposure_schedule_lowlight;

  assert.equal(schedule[0].exposure_time.rawJSON, '250.0');
  assert.equal(schedule[1].exposure_time.rawJSON, '200.0');
  assert.equal(schedule[0].code_override, false);
  assert.equal(schedule[1].code_override, false);
  schedule[0].exposure_time = JSON.rawJSON('225.0');
  schedule[1].exposure_time = JSON.rawJSON('185.0');

  const throttles = [
    [0, ['0', '2'], ['0', '8'], '800', '150'],
    [1, ['0', '2'], ['8', '80'], '400', '100'],
    [2, ['0', '2'], ['80', '-1'], '400', '100'],
    [3, ['2', '-1'], ['0', '10000'], '400', '100'],
    [4, ['2', '-1'], ['10000', '-1'], '400', '100'],
  ];
  for (const [index, zoom, lux, before, after] of throttles) {
    const row = expected.ctwo.qc_mfnr_settings.default[index];
    assert.deepEqual(row.zoom_range.map(value => value.rawJSON), zoom);
    assert.deepEqual(row.lux_range.map(value => value.rawJSON), lux);
    assert.equal(row.number_of_frames.rawJSON, '255');
    assert.equal(row.shutter_throttle_time.rawJSON, before);
    row.shutter_throttle_time = JSON.rawJSON(after);
  }

  const advanced = expected.ctwo.scene_selection_advanced_overrides;
  const defaultMode = advanced.default_cam_type.default_mode;
  assert.deepEqual(sceneSignature(defaultMode.hdr_off), [
    { zoom: ['0.0', '12.1'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' },
    { zoom: ['12.1', '-1.0'], lux: ['0.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
  ]);
  assert.deepEqual(sceneSignature(defaultMode.hdr_auto_off), [
    { zoom: ['0.0', '12.1'], lux: ['0.0', '2.99'], scene: 'RAW_SUPER_NIGHT' },
    { zoom: ['0.0', '12.1'], lux: ['3.0', '-1.0'], scene: 'RAW_HDR' },
    { zoom: ['12.1', '-1.0'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
    { zoom: ['12.1', '-1.0'], lux: ['10.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
  ]);
  assert.equal(defaultMode.hdr_auto_on[0].override_scene, 'RAW_HDR');
  assert.equal(defaultMode.hdr_auto_on[1].override_scene, 'SUPER_RESOLUTION');
  assert.equal(defaultMode.hdr_auto_on_nv_auto_on[1].override_scene, 'RAW_HDR');
  defaultMode.hdr_off[0].override_scene = 'HAL_FRAME_STACK';
  defaultMode.hdr_auto_off[1].override_scene = 'HAL_FRAME_STACK';
  assert.equal(defaultMode.hdr_off[1].override_scene, 'SUPER_RESOLUTION');
  assert.equal(defaultMode.hdr_auto_off[0].override_scene, 'RAW_SUPER_NIGHT');
  assert.equal(defaultMode.hdr_auto_off[2].override_scene, 'RAW_SUPER_NIGHT');
  assert.equal(defaultMode.hdr_auto_off[3].override_scene, 'SUPER_RESOLUTION');
  assert.equal(defaultMode.hdr_auto_on[0].override_scene, 'RAW_HDR');
  assert.equal(defaultMode.hdr_auto_on_nv_auto_on[0].override_scene, 'RAW_SUPER_NIGHT');
  assert.equal(defaultMode.hdr_auto_on_nv_auto_on[1].override_scene, 'RAW_HDR');

  const frontMode = advanced.FRONT_MAIN.default_mode;
  for (const key of ['hdr_off', 'hdr_auto_off', 'hdr_auto_on']) {
    assert.deepEqual(sceneSignature(frontMode[key]), [
      { zoom: ['0.0', '-1.0'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' },
    ]);
  }
  frontMode.hdr_off[0].override_scene = 'HAL_FRAME_STACK';
  frontMode.hdr_auto_off[0].override_scene = 'HAL_FRAME_STACK';
  assert.equal(frontMode.hdr_auto_on[0].override_scene, 'RAW_HDR');

  const teleStock = [
    { zoom: ['0', '12.1'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
    { zoom: ['0', '12.1'], lux: ['10.1', '-1.0'], scene: 'RAW_HDR' },
    { zoom: ['12.1', '29.9'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
    { zoom: ['12.1', '29.9'], lux: ['10.1', '-1.0'], scene: 'SUPER_RESOLUTION' },
    { zoom: ['30.0', '-1'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
    { zoom: ['30.0', '-1'], lux: ['10.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
  ];
  const teleOff = teleStock.map((row, index) => (
    index === 1 ? { ...row, scene: 'HAL_FRAME_STACK' } : row
  ));
  for (const camType of ['BACK_MAIN', 'BACK_WIDE', 'BACK_TELE']) {
    const mode = advanced[camType].default_mode;
    assert.deepEqual(Object.keys(mode), ['hdr_default']);
    if (camType === 'BACK_TELE') {
      assert.deepEqual(sceneSignature(mode.hdr_default), teleStock);
    } else {
      assert.deepEqual(sceneSignature(mode.hdr_default), [
        { zoom: ['0', '-1'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' },
      ]);
    }
    const hdrOff = cloneConfig(mode.hdr_default);
    const hdrAutoOn = cloneConfig(mode.hdr_default);
    if (camType === 'BACK_TELE') hdrOff[1].override_scene = 'HAL_FRAME_STACK';
    else hdrOff[0].override_scene = 'HAL_FRAME_STACK';
    delete mode.hdr_default;
    mode.hdr_off = hdrOff;
    mode.hdr_auto_off = cloneConfig(hdrOff);
    mode.hdr_auto_on = hdrAutoOn;
  }

  const main = advanced.BACK_MAIN.default_mode;
  assert.deepEqual(Object.keys(main), ['hdr_off', 'hdr_auto_off', 'hdr_auto_on']);
  assert.equal(main.hdr_off[0].override_scene, 'HAL_FRAME_STACK');
  assert.equal(main.hdr_auto_off[0].override_scene, 'HAL_FRAME_STACK');
  assert.equal(main.hdr_auto_on[0].override_scene, 'RAW_HDR');
  assert.equal(main.hdr_off[0].zoom_range[0].rawJSON, '0');
  assert.equal(main.hdr_off[0].zoom_range[1].rawJSON, '-1');
  assert.equal(main.hdr_off[0].lux_range[0].rawJSON, '0.0');
  assert.equal(main.hdr_off[0].lux_range[1].rawJSON, '-1.0');
  assert.equal(advanced.BACK_WIDE.default_mode.hdr_auto_on[0].override_scene, 'RAW_HDR');
  assert.equal(advanced.BACK_WIDE.default_mode.hdr_off[0].zoom_range[0].rawJSON, '0');

  const tele = advanced.BACK_TELE.default_mode;
  assert.deepEqual(sceneSignature(tele.hdr_off), teleOff);
  assert.deepEqual(sceneSignature(tele.hdr_auto_off), teleOff);
  assert.deepEqual(sceneSignature(tele.hdr_auto_on), teleStock);
  assert.equal(tele.hdr_off[1].override_scene, 'HAL_FRAME_STACK');
  assert.equal(tele.hdr_off[1].lux_range[0].rawJSON, '10.1');
  assert.equal(tele.hdr_off[1].lux_range[1].rawJSON, '-1.0');
  assert.equal(tele.hdr_off[0].override_scene, 'RAW_SUPER_NIGHT');
  assert.equal(tele.hdr_off[3].override_scene, 'SUPER_RESOLUTION');
  assert.equal(tele.hdr_auto_on[1].override_scene, 'RAW_HDR');
  assert.equal(tele.hdr_auto_on[4].zoom_range[0].rawJSON, '30.0');
  assert.equal(tele.hdr_auto_on[4].zoom_range[1].rawJSON, '-1');
  assert.equal(tele.hdr_auto_on[5].lux_range[0].rawJSON, '10.0');
  assert.equal(defaultMode.hdr_auto_off[0].lux_range[1].rawJSON, '2.99');
  assert.equal(defaultMode.hdr_auto_off[1].lux_range[0].rawJSON, '3.0');
  assert.equal(JSON.stringify(expected.ctwo.uhdr_settings), JSON.stringify(stockSchema.ctwo.uhdr_settings));
  assert.equal(
    JSON.stringify(expected.ctwo.scene_selection_advanced_overrides.BACK_MAIN.super_night),
    JSON.stringify(stockSchema.ctwo.scene_selection_advanced_overrides.BACK_MAIN.super_night),
  );

  assertConfig(readMod('iq_config_ctwo'), expected);
  assert.notEqual(JSON.stringify(expected), JSON.stringify(stockSchema));
});

test('MCF keeps the rear HDR brackets and disables startup preload, AI scene detect, Tetras RAW SR, and beauty', { skip: !hasStockAndMod }, () => {
  const stock = readStock('mcf_config_ctwo.decrypted.json');
  const stockSchema = readSchema(stock);
  const expected = readSchema(stock);
  const mcf = expected.ctwo;

  assert.deepEqual(
    [mcf.imagers[0], mcf.imagers[2], mcf.imagers[3]],
    ['mot_ov50h', 'mot_ov64b', 'mot_s5kjn1'],
  );
  assert.equal(mcf.imagers.length, 8);
  const brackets = mcf['state-machine']['raw-hdr']['frame-ev-default'];
  for (const index of [0, 2, 3]) {
    assert.deepEqual(brackets[index].map(value => value.rawJSON), ['0.0', '0.0', '0.0', '0.0', '-24.0', '-12.0', '0.0']);
    brackets[index][4] = JSON.rawJSON('-26.0');
    assert.equal(brackets[index][5].rawJSON, '-12.0');
  }
  assert.equal(brackets[1][4].rawJSON, '-24.0');

  assert.equal(mcf['beauty-shot-fotonation']['default-beauty-level'].rawJSON, '2');
  mcf['beauty-shot-fotonation']['default-beauty-level'] = JSON.rawJSON('0');
  assert.deepEqual(mcf['beauty-shot-fotonation'].enable, [false, true, false, false, false, false, false, false]);
  mcf['beauty-shot-fotonation'].enable = disabled.slice();
  assert.deepEqual(mcf['ai-scene-detect'].enable, [true, true, false, false, true, false, false, true]);
  mcf['ai-scene-detect'].enable = disabled.slice();
  assert.deepEqual(mcf['tetras-raw-sr'].enable, [false, false, true, false, false, false, false, true]);
  mcf['tetras-raw-sr'].enable = disabled.slice();
  assert.deepEqual(mcf['fast-init']['hold-startup-handle-for-algo'].algorithms, stockStartup);
  mcf['fast-init']['hold-startup-handle-for-algo'].algorithms = stockStartup.map(() => []);
  assert.deepEqual(
    mcf['state-machine-to-algorithms-map'].MCF_HAL_FRAME_STACK_STATE_MACHINE,
    stockHal,
  );
  mcf['state-machine-to-algorithms-map'].MCF_HAL_FRAME_STACK_STATE_MACHINE = halStack.slice();

  assert.deepEqual(mcf['beauty-shot-fotonation'].enable, disabled);
  assert.deepEqual(mcf['ai-scene-detect'].enable, disabled);
  assert.deepEqual(mcf['tetras-raw-sr'].enable, disabled);
  assert.deepEqual(mcf['fast-init']['hold-startup-handle-for-algo'].algorithms, [[], [], [], [], [], [], [], []]);
  assert.deepEqual(mcf['state-machine-to-algorithms-map'].MCF_HAL_FRAME_STACK_STATE_MACHINE, halStack);
  assert.equal(mcf['beauty-shot-fotonation']['default-beauty-level'].rawJSON, '0');
  assert.equal(
    JSON.stringify(mcf['state-machine-to-algorithms-map'].MCF_RAW_HDR_STATE_MACHINE),
    JSON.stringify(stockSchema.ctwo['state-machine-to-algorithms-map'].MCF_RAW_HDR_STATE_MACHINE),
  );
  assert.equal(mcf.basezoom[2].rawJSON, '3.0');
  assert.equal(mcf.basezoom[2].rawJSON, stockSchema.ctwo.basezoom[2].rawJSON);
  assert.equal(mcf.basezoom[3].rawJSON, '0.5');

  assertConfig(readMod('mcf_config_ctwo.mod.json'), expected);
  assert.notEqual(JSON.stringify(expected), JSON.stringify(stockSchema));
});

test('app features remove the HDR settings UI suppression flag and preserve every other entry', { skip: !hasStockAndMod }, () => {
  const stock = readStock('app_feature_ctwo');
  const expected = readSchema(stock);
  const matching = expected.fs.filter(entry => entry.f === 'REMOVE_HDR_SETTING_UI');

  assert.deepEqual(matching, [{ f: 'REMOVE_HDR_SETTING_UI' }]);
  expected.fs = expected.fs.filter(entry => entry.f !== 'REMOVE_HDR_SETTING_UI');

  assertConfig(readMod('app_feature_ctwo'), expected);
  assert.notEqual(JSON.stringify(expected), JSON.stringify(readSchema(stock)));
});

test('changelog names every Sin IA / Fast edit and its stock token', { skip: !hasStockAndMod }, () => {
  const changelog = readMod('CONFIG_CHANGELOG.md').toString('utf8');
  const required = [
    '`/ctwo/qc_mfnr_settings/exposure_schedule_lowlight/0/exposure_time` | `250.0` | `225.0`',
    '`/ctwo/qc_mfnr_settings/exposure_schedule_lowlight/1/exposure_time` | `200.0` | `185.0`',
    '`/ctwo/qc_mfnr_settings/default/0/shutter_throttle_time` | `800` | `150`',
    '`/ctwo/qc_mfnr_settings/default/1/shutter_throttle_time` | `400` | `100`',
    '`/ctwo/qc_mfnr_settings/default/2/shutter_throttle_time` | `400` | `100`',
    '`/ctwo/qc_mfnr_settings/default/3/shutter_throttle_time` | `400` | `100`',
    '`/ctwo/qc_mfnr_settings/default/4/shutter_throttle_time` | `400` | `100`',
    '`/ctwo/scene_selection_advanced_overrides/default_cam_type/default_mode/hdr_off/0/override_scene` | `RAW_HDR` | `HAL_FRAME_STACK`',
    '`/ctwo/scene_selection_advanced_overrides/default_cam_type/default_mode/hdr_auto_off/1/override_scene` | `RAW_HDR` | `HAL_FRAME_STACK`',
    '`/ctwo/scene_selection_advanced_overrides/FRONT_MAIN/default_mode/hdr_off/0/override_scene` | `RAW_HDR` | `HAL_FRAME_STACK`',
    '`/ctwo/scene_selection_advanced_overrides/FRONT_MAIN/default_mode/hdr_auto_off/0/override_scene` | `RAW_HDR` | `HAL_FRAME_STACK`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_MAIN/default_mode/hdr_default`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_MAIN/default_mode/hdr_off`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_MAIN/default_mode/hdr_auto_off`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_MAIN/default_mode/hdr_auto_on`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_WIDE/default_mode/hdr_default`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_WIDE/default_mode/hdr_off`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_WIDE/default_mode/hdr_auto_on`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_TELE/default_mode/hdr_default`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_TELE/default_mode/hdr_off`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_TELE/default_mode/hdr_auto_off`',
    '`/ctwo/scene_selection_advanced_overrides/BACK_TELE/default_mode/hdr_auto_on`',
    '`/fs/46` | `{"f":"REMOVE_HDR_SETTING_UI"}` | Removed',
    '`/ctwo/state-machine/raw-hdr/frame-ev-default/0/4` | `-24.0` | `-26.0`',
    '`/ctwo/state-machine/raw-hdr/frame-ev-default/2/4` | `-24.0` | `-26.0`',
    '`/ctwo/state-machine/raw-hdr/frame-ev-default/3/4` | `-24.0` | `-26.0`',
    '`/ctwo/beauty-shot-fotonation/default-beauty-level` | `2` | `0`',
    '`/ctwo/beauty-shot-fotonation/enable` | `[false,true,false,false,false,false,false,false]` | `[false,false,false,false,false,false,false,false]`',
    '`/ctwo/ai-scene-detect/enable` | `[true,true,false,false,true,false,false,true]` | `[false,false,false,false,false,false,false,false]`',
    '`/ctwo/tetras-raw-sr/enable` | `[false,false,true,false,false,false,false,true]` | `[false,false,false,false,false,false,false,false]`',
    '`/ctwo/fast-init/hold-startup-handle-for-algo/algorithms`',
    '`/ctwo/state-machine-to-algorithms-map/MCF_HAL_FRAME_STACK_STATE_MACHINE`',
    'MCF_BST_PURPLE_FRINGE_CAPTURE_ALG',
    'MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG',
    'MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG',
    'MCF_TETRAS_SENSEPR_CAPTURE_ALG',
    'HAL_FRAME_STACK',
    'RAW_SUPER_NIGHT',
  ];
  for (const fragment of required) assert.equal(changelog.includes(fragment), true, fragment);
  assert.equal(changelog.includes('Sin IA / Fast'), true);
  assert.equal(changelog.includes('| `1` |'), false);
});

test('Java SunJCE independently decrypts stock and mod and encrypts the same gzip bytes', { skip: !hasStockAndMod }, () => {
  const bundledJshell = 'C:/Users/soled/.local/share/atlas-rea-tools/jdk-21.0.12.1+1/bin/jshell.exe';
  const jshell = process.env.MCF_JSHELL || (existsSync(bundledJshell) ? bundledJshell : 'jshell');
  const file = (dir, name) => JSON.stringify(fileURLToPath(new URL(name, dir)));
  const java = [
    'import java.nio.file.*;',
    'import java.nio.charset.*;',
    'import java.io.*;',
    'import java.security.*;',
    'import java.util.zip.*;',
    'import javax.crypto.*;',
    'import javax.crypto.spec.*;',
    'byte[] cipher(int mode, byte[] bytes) throws Exception { var c = Cipher.getInstance("Blowfish"); c.init(mode, new SecretKeySpec("PsDnGz8m".getBytes(StandardCharsets.UTF_8), "Blowfish")); return c.doFinal(bytes); }',
    'byte[] gunzip(byte[] bytes) throws Exception { try (var in = new GZIPInputStream(new ByteArrayInputStream(bytes))) { return in.readAllBytes(); } }',
    'String sha256(byte[] bytes) throws Exception { return java.util.HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(bytes)); }',
    'var stockGzip = cipher(Cipher.DECRYPT_MODE, Files.readAllBytes(Path.of(' + file(stockDir, 'mcf_config_ctwo') + ')));',
    'var modCiphertext = Files.readAllBytes(Path.of(' + file(modDir, 'mcf_config_ctwo') + '));',
    'var modGzip = cipher(Cipher.DECRYPT_MODE, modCiphertext);',
    'System.out.println("stock " + sha256(gunzip(stockGzip)));',
    'System.out.println("mod " + sha256(gunzip(modGzip)));',
    'System.out.println("reencrypted " + sha256(cipher(Cipher.ENCRYPT_MODE, modGzip)));',
    '/exit',
    '',
  ].join('\n');

  const result = spawnSync(jshell, ['--execution', 'local', '--feedback', 'silent', '-'], {
    encoding: 'utf8',
    input: java,
    timeout: 30000,
  });
  assert.ifError(result.error);
  assert.equal(result.status, 0, result.stderr);
  assert.deepEqual(result.stdout.trim().split(/\r?\n/), [
    'stock ' + hash(readStock('mcf_config_ctwo.decrypted.json')),
    'mod ' + hash(readMod('mcf_config_ctwo.mod.json')),
    'reencrypted ' + hash(readMod('mcf_config_ctwo')),
  ]);
});
