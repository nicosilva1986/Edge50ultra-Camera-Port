import assert from 'node:assert/strict';
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';

import { decryptMcf, encryptMcf } from './mcf_crypto.mjs';
import { REPO_ROOT, resolveConfigsDir } from './env_paths.mjs';
import { join } from 'node:path';
import { pathToFileURL } from 'node:url';

const stockDir = pathToFileURL(resolveConfigsDir() + '/');
const modDir = pathToFileURL(join(REPO_ROOT, 'configs_mod') + '/');
const iqName = 'iq_config_ctwo';
const appName = 'app_feature_ctwo';
const mcfName = 'mcf_config_ctwo';
const modJsonName = mcfName + '.mod.json';
const stock = name => readFileSync(new URL(name, stockDir));

function parseConfig(bytes) {
  // Native JSON readers can distinguish integer tokens from doubles.
  return JSON.parse(bytes, (_key, value, context) =>
    typeof value === 'number' ? JSON.rawJSON(context.source) : value,
  );
}

function cloneConfig(value) {
  return JSON.parse(JSON.stringify(value), (_key, inner, context) =>
    typeof inner === 'number' ? JSON.rawJSON(context.source) : inner,
  );
}

const iqBytes = stock(iqName);
const appBytes = stock(appName);
const stockMcf = decryptMcf(stock(mcfName));
assert(
  stockMcf.equals(stock(mcfName + '.decrypted.json')),
  'Stock MCF asset and decrypted reference differ',
);

const iq = parseConfig(iqBytes);
const app = parseConfig(appBytes);
const mcf = parseConfig(stockMcf);
assert.equal(app.d, 'ctwo', 'App config device');

const changes = [];

function replaceNumber(file, config, path, before, after, rationale) {
  const key = path.at(-1);
  const parent = path.slice(0, -1).reduce((node, part) => node?.[part], config);
  const pointer = '/' + path.join('/');
  assert.equal(parent?.[key]?.rawJSON, before, file + ' ' + pointer + ' stock number');
  parent[key] = JSON.rawJSON(after);
  changes.push({ file, pointer, before, after, rationale });
}

function replaceValue(file, config, path, before, after, rationale) {
  const key = path.at(-1);
  const parent = path.slice(0, -1).reduce((node, part) => node?.[part], config);
  const pointer = '/' + path.join('/');
  assert.deepEqual(parent?.[key], before, file + ' ' + pointer + ' stock value');
  parent[key] = after;
  changes.push({
    file,
    pointer,
    before: JSON.stringify(before),
    after: JSON.stringify(after),
    rationale,
  });
}

function sceneSignature(rows) {
  return rows.map(row => ({
    zoom: row.zoom_range.map(value => value.rawJSON),
    lux: row.lux_range.map(value => value.rawJSON),
    scene: row.override_scene,
  }));
}

function retargetScene(rows, index, before, after, file, pointer, rationale) {
  assert.equal(rows[index].override_scene, before, file + ' ' + pointer);
  rows[index].override_scene = after;
  changes.push({ file, pointer, before, after, rationale });
}

const schedule = ['ctwo', 'qc_mfnr_settings', 'exposure_schedule_lowlight'];
for (const [index, luxRange, before, after] of [
  [0, ['470.0', '10000.0'], '250.0', '225.0'],
  [1, ['458.0', '470.0'], '200.0', '185.0'],
]) {
  const row = iq.ctwo.qc_mfnr_settings.exposure_schedule_lowlight[index];
  assert.equal(row.code_override, false, 'Expected a static exposure hint');
  assert.deepEqual(row.lux_idx_range.map(value => value.rawJSON), luxRange);
  replaceNumber(iqName, iq, [...schedule, index, 'exposure_time'], before, after,
    'Shorten the static MFNR timing hint for lux index ' + luxRange.join('–') + '.');
}

const throttleBase = ['ctwo', 'qc_mfnr_settings', 'default'];
for (const [index, zoom, lux, frames, before, after] of [
  [0, ['0', '2'], ['0', '8'], '255', '800', '150'],
  [1, ['0', '2'], ['8', '80'], '255', '400', '100'],
  [2, ['0', '2'], ['80', '-1'], '255', '400', '100'],
  [3, ['2', '-1'], ['0', '10000'], '255', '400', '100'],
  [4, ['2', '-1'], ['10000', '-1'], '255', '400', '100'],
]) {
  const row = iq.ctwo.qc_mfnr_settings.default[index];
  assert.deepEqual(row.zoom_range.map(value => value.rawJSON), zoom, 'MFNR zoom row ' + index);
  assert.deepEqual(row.lux_range.map(value => value.rawJSON), lux, 'MFNR lux row ' + index);
  assert.equal(row.number_of_frames.rawJSON, frames, 'MFNR frame-count row ' + index);
  replaceNumber(iqName, iq, [...throttleBase, index, 'shutter_throttle_time'], before, after,
    'Lower the stored MFNR shutter throttle for zoom ' + zoom.join('–')
    + ' and lux ' + lux.join('–') + '. Row 0 is the value mfnrShutterThrottle returns while every row keeps frame count 255.');
}

const advanced = iq.ctwo.scene_selection_advanced_overrides;
const fastScene = 'Use the Qualcomm HAL frame stack for this HDR state. RAW_HDR stays available on the auto-on rows.';
const keepScene = 'Keep the stock scene on this zoom and lux row.';

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
assert.deepEqual(sceneSignature(defaultMode.hdr_auto_on), [
  { zoom: ['0.0', '12.1'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' },
  { zoom: ['12.1', '-1.0'], lux: ['0.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
]);
assert.deepEqual(sceneSignature(defaultMode.hdr_auto_on_nv_auto_on), [
  { zoom: ['0.0', '12.1'], lux: ['0.0', '2.99'], scene: 'RAW_SUPER_NIGHT' },
  { zoom: ['0.0', '12.1'], lux: ['3.0', '-1.0'], scene: 'RAW_HDR' },
  { zoom: ['12.1', '-1.0'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
  { zoom: ['12.1', '-1.0'], lux: ['10.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
]);
retargetScene(
  defaultMode.hdr_off, 0, 'RAW_HDR', 'HAL_FRAME_STACK', iqName,
  '/ctwo/scene_selection_advanced_overrides/default_cam_type/default_mode/hdr_off/0/override_scene',
  fastScene,
);
retargetScene(
  defaultMode.hdr_auto_off, 1, 'RAW_HDR', 'HAL_FRAME_STACK', iqName,
  '/ctwo/scene_selection_advanced_overrides/default_cam_type/default_mode/hdr_auto_off/1/override_scene',
  fastScene,
);
assert.equal(defaultMode.hdr_off[1].override_scene, 'SUPER_RESOLUTION', keepScene);
assert.equal(defaultMode.hdr_auto_off[0].override_scene, 'RAW_SUPER_NIGHT', keepScene);
assert.equal(defaultMode.hdr_auto_off[2].override_scene, 'RAW_SUPER_NIGHT', keepScene);
assert.equal(defaultMode.hdr_auto_off[3].override_scene, 'SUPER_RESOLUTION', keepScene);
assert.equal(defaultMode.hdr_auto_on[0].override_scene, 'RAW_HDR', keepScene);
assert.equal(defaultMode.hdr_auto_on_nv_auto_on[1].override_scene, 'RAW_HDR', keepScene);

const frontMode = advanced.FRONT_MAIN.default_mode;
for (const key of ['hdr_off', 'hdr_auto_off', 'hdr_auto_on']) {
  assert.deepEqual(sceneSignature(frontMode[key]), [
    { zoom: ['0.0', '-1.0'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' },
  ], 'FRONT_MAIN ' + key);
}
retargetScene(
  frontMode.hdr_off, 0, 'RAW_HDR', 'HAL_FRAME_STACK', iqName,
  '/ctwo/scene_selection_advanced_overrides/FRONT_MAIN/default_mode/hdr_off/0/override_scene',
  fastScene,
);
retargetScene(
  frontMode.hdr_auto_off, 0, 'RAW_HDR', 'HAL_FRAME_STACK', iqName,
  '/ctwo/scene_selection_advanced_overrides/FRONT_MAIN/default_mode/hdr_auto_off/0/override_scene',
  fastScene,
);
assert.equal(frontMode.hdr_auto_on[0].override_scene, 'RAW_HDR', keepScene);

function replaceHdrDefault(camType, stockScenes, offScenes, rationale) {
  const mode = advanced[camType].default_mode;
  assert.deepEqual(Object.keys(mode), ['hdr_default'], camType + ' default_mode keys');
  assert.deepEqual(sceneSignature(mode.hdr_default), stockScenes, camType + ' hdr_default');
  const base = '/ctwo/scene_selection_advanced_overrides/' + camType + '/default_mode/';
  const stockJson = JSON.stringify(mode.hdr_default);
  const hdrOff = cloneConfig(mode.hdr_default);
  const hdrAutoOn = cloneConfig(mode.hdr_default);
  for (const [index, scene] of offScenes.entries()) hdrOff[index].override_scene = scene;
  delete mode.hdr_default;
  mode.hdr_off = hdrOff;
  mode.hdr_auto_off = cloneConfig(hdrOff);
  mode.hdr_auto_on = hdrAutoOn;
  assert.deepEqual(Object.keys(mode), ['hdr_off', 'hdr_auto_off', 'hdr_auto_on'], camType);
  changes.push({
    file: iqName,
    pointer: base + 'hdr_default',
    before: stockJson,
    after: null,
    rationale,
  });
  for (const key of ['hdr_off', 'hdr_auto_off', 'hdr_auto_on']) {
    changes.push({
      file: iqName,
      pointer: base + key,
      before: null,
      after: JSON.stringify(mode[key]),
      rationale,
    });
  }
}

const fullFrame = [{ zoom: ['0', '-1'], lux: ['0.0', '-1.0'], scene: 'RAW_HDR' }];
const fullFrameRationale = 'Split the rear catch-all hdr_default row into the keys MotCamera4 reads. HDR off and HDR auto with a non-HDR scene use HAL_FRAME_STACK. HDR auto with an HDR scene keeps RAW_HDR. HDR on has no hdr_on entry, so the scene chosen before the override remains.';
replaceHdrDefault('BACK_MAIN', fullFrame, ['HAL_FRAME_STACK'], fullFrameRationale);
replaceHdrDefault('BACK_WIDE', fullFrame, ['HAL_FRAME_STACK'], fullFrameRationale);

const teleStock = [
  { zoom: ['0', '12.1'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
  { zoom: ['0', '12.1'], lux: ['10.1', '-1.0'], scene: 'RAW_HDR' },
  { zoom: ['12.1', '29.9'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
  { zoom: ['12.1', '29.9'], lux: ['10.1', '-1.0'], scene: 'SUPER_RESOLUTION' },
  { zoom: ['30.0', '-1'], lux: ['0.0', '10.0'], scene: 'RAW_SUPER_NIGHT' },
  { zoom: ['30.0', '-1'], lux: ['10.0', '-1.0'], scene: 'SUPER_RESOLUTION' },
];
const teleOff = teleStock.map((row, index) => (
  index === 1 ? { ...row, scene: 'HAL_FRAME_STACK' } : { ...row }
));
replaceHdrDefault(
  'BACK_TELE',
  teleStock,
  teleOff.map(row => row.scene),
  'Split the tele hdr_default table. Zoom 0–12.1 and lux 0–10 stays RAW_SUPER_NIGHT. Zoom 0–12.1 and lux above 10.1 uses HAL_FRAME_STACK when HDR is off or auto-off. Zoom above 12.1 stays on the stock scenes. HDR auto-on keeps the stock table, including RAW_HDR.',
);
assert.deepEqual(sceneSignature(advanced.BACK_TELE.default_mode.hdr_off), teleOff);
assert.deepEqual(sceneSignature(advanced.BACK_TELE.default_mode.hdr_auto_off), teleOff);
assert.deepEqual(sceneSignature(advanced.BACK_TELE.default_mode.hdr_auto_on), teleStock);
assert.equal(advanced.BACK_MAIN.default_mode.hdr_off[0].zoom_range[0].rawJSON, '0');
assert.equal(advanced.BACK_MAIN.default_mode.hdr_off[0].lux_range[0].rawJSON, '0.0');
assert.equal(advanced.BACK_TELE.default_mode.hdr_auto_on[4].zoom_range[0].rawJSON, '30.0');
assert.equal(advanced.BACK_TELE.default_mode.hdr_auto_on[4].zoom_range[1].rawJSON, '-1');

const hdrFlag = 'REMOVE_HDR_SETTING_UI';
const hdrIndex = app.fs.findIndex(entry => entry.f === hdrFlag);
assert.deepEqual(app.fs.filter(entry => entry.f === hdrFlag), [{ f: hdrFlag }]);
const [removed] = app.fs.splice(hdrIndex, 1);
changes.push({
  file: appName,
  pointer: '/fs/' + hdrIndex,
  before: JSON.stringify(removed),
  after: null,
  rationale: 'Lift the device-level HDR settings UI suppression. The app still checks supported HDR modes.',
});

const fallbackBracket = ['ctwo', 'state-machine', 'raw-hdr', 'frame-ev-default'];
for (const [slot, imager, lens] of [
  [0, 'mot_ov50h', 'OV50H main'],
  [2, 'mot_ov64b', 'OV64B tele'],
  [3, 'mot_s5kjn1', 'S5KJN1 ultrawide'],
]) {
  assert.equal(mcf.ctwo.imagers[slot], imager, 'MCF sensor slot ' + slot);
  assert.deepEqual(
    mcf.ctwo['state-machine']['raw-hdr']['frame-ev-default'][slot].map(value => value.rawJSON),
    ['0.0', '0.0', '0.0', '0.0', '-24.0', '-12.0', '0.0'],
  );
  replaceNumber(mcfName, mcf, [...fallbackBracket, slot, 4], '-24.0', '-26.0',
    'Give the darkest fallback RAW HDR bracket more highlight headroom on the ' + lens + '.');
}

assert.deepEqual(mcf.ctwo.imagers, [
  'mot_ov50h', 'mot_s5kjns', 'mot_ov64b', 'mot_s5kjn1',
  'mot_s5kjn1_macro', 'mot_depth', 'mot_depth_3x', 'mot_zoom',
]);
assert.deepEqual(mcf.ctwo['camera-type'], [
  'back-main', 'front-main', 'back-tele', 'back-wide',
  'back-macro', 'back-depth_1x', 'back-depth_3x', 'back-zoom',
]);

replaceNumber(mcfName, mcf, ['ctwo', 'beauty-shot-fotonation', 'default-beauty-level'], '2', '0',
  'Set the built-in beauty preset to level 0. FotoNation beauty capture is disabled on every camera slot.');

const disabled = [false, false, false, false, false, false, false, false];
replaceValue(
  mcfName, mcf, ['ctwo', 'beauty-shot-fotonation', 'enable'],
  [false, true, false, false, false, false, false, false],
  disabled,
  'Disable FotoNation beauty on the front camera. The other seven slots are already false.',
);
replaceValue(
  mcfName, mcf, ['ctwo', 'ai-scene-detect', 'enable'],
  [true, true, false, false, true, false, false, true],
  disabled,
  'Disable AI scene detection on the main, front, macro, and zoom slots. The other four slots are already false.',
);
replaceValue(
  mcfName, mcf, ['ctwo', 'tetras-raw-sr', 'enable'],
  [false, false, true, false, false, false, false, true],
  disabled,
  'Disable Tetras RAW super-resolution on the tele and zoom slots. The other six slots are already false.',
);
replaceValue(
  mcfName, mcf, ['ctwo', 'fast-init', 'hold-startup-handle-for-algo', 'algorithms'],
  [
    ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_TETRAS_RAW_SUPER_RESOLUTION_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_ARCSOFT_TF_REFOCUS_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_ARCSOFT_TF_REFOCUS_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
    ['MCF_TETRAS_RAW_SUPER_RESOLUTION_CAPTURE_ALG', 'MCF_AS_TF_MOTION_CAPTURE_ALG'],
  ],
  [[], [], [], [], [], [], [], []],
  'Clear the per-slot startup algorithm hold list so ArcSoft TF motion capture, ArcSoft TF refocus, and Tetras RAW SR are not named for startup preload.',
);

const halStack = [
  'MCF_BST_PURPLE_FRINGE_CAPTURE_ALG',
  'MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG',
  'MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG',
];
replaceValue(
  mcfName, mcf, ['ctwo', 'state-machine-to-algorithms-map', 'MCF_HAL_FRAME_STACK_STATE_MACHINE'],
  [
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
  ],
  halStack,
  'Keep purple-fringe correction, ArcSoft distortion correction, and Meishe effects on the clean HAL frame-stack path. Tetras SensePR, FotoNation beauty, AI portrait, and the other stock post-processors are removed from this state machine.',
);

const tick = value => '\x60' + value + '\x60';
const changelogCell = (value, emptyLabel) => value === null ? emptyLabel : tick(value);
const changelog = [
  '# Motorola Edge 50 Ultra camera config changes',
  '',
  'Generated for the ctwo Motorola Camera clone. Paths are JSON Pointers into the stock documents. The app feature pointer uses its stock array index. This is the Sin IA / Fast profile.',
  '',
  '| File | JSON Pointer | Stock | Mod | Technical rationale |',
  '| --- | --- | --- | --- | --- |',
  ...changes.map(({ file, pointer, before, after, rationale }) => {
    const files = file === mcfName
      ? tick(mcfName) + ' and ' + tick(modJsonName)
      : tick(file);
    return '| ' + files + ' | ' + tick(pointer) + ' | ' + changelogCell(before, 'Absent') + ' | '
      + changelogCell(after, 'Removed') + ' | ' + rationale + ' |';
  }),
  '',
  '## Stock behavior and verification',
  '',
  '- IQ uses the low-light timing hint when the static schedule applies. Camera-characteristics hints take precedence. The app uses the hint for estimates and a delayed handler callback on applicable bracketed captures. The HAL controls exposure and frame acquisition.',
  '- `QcMfnrSetting` reads `shutter_throttle_time` with `getInt`. `IqConfigManager.mfnrShutterThrottle` walks `qc_mfnr_settings.default` and returns the first row whose `number_of_frames` byte equals the looked-up frame count. `BracketingCaptureRequestRunnable` stores that long in `ShutterThrottle.mDuration`. All five stock rows use frame-count token 255, which is -1 as a signed byte, so a matching walk returns row 0. Rows 1–4 are still lowered. The 255 token stays in place.',
  '- `IqConfigManager.getFinalSettingAccordingToHDR` reads `com.motorola.camera.hdr`. `PostCaptureImageEvent.getHdrMode` labels 0 as off, 1 as on, and 2 as auto, and the settings factory stores 2 by default. The method selects `hdr_off` for 0 and `hdr_on` for 1. Every other value uses `hdr_auto_on` when the incoming scene `isHdr()`, or `hdr_auto_on_nv_auto_on` when that key exists and auto night vision with zero exposure compensation is active. A non-HDR scene uses `hdr_auto_off`, with the night-vision and flash key names when those entries exist. A null result then uses `hdr_default`. `getIqJsonOverrideScene` reads the current camera `default_mode` and then `default_cam_type.default_mode`. `SceneOverrideSetting` requires `zoom_range`, `lux_range`, and an `override_scene` name from `Mcf.SceneMode`. `HAL_FRAME_STACK` is one of those names.',
  '- `default_cam_type` and `FRONT_MAIN` already have the off and auto keys. Only their `RAW_HDR` cells under `hdr_off` and `hdr_auto_off` change to `HAL_FRAME_STACK`. `SUPER_RESOLUTION`, `RAW_SUPER_NIGHT`, `hdr_auto_on`, and `hdr_auto_on_nv_auto_on` stay on the stock scenes. `BACK_MAIN` and `BACK_WIDE` replace the single `hdr_default` row with `hdr_off`, `hdr_auto_off`, and `hdr_auto_on`. `BACK_TELE` does the same split: zoom 0–12.1 and lux above 10.1 becomes `HAL_FRAME_STACK` for off and auto-off, the dark zoom 0–12.1 row stays `RAW_SUPER_NIGHT`, zoom above 12.1 stays stock, and auto-on keeps the stock table. HDR on looks up `hdr_on` and then `hdr_default`. Those keys are absent after the split, so MotCamera4 keeps the scene it already selected.',
  '- The three rear fallback RAW HDR brackets move their darkest EV from -24.0 to -26.0. That offset targets highlight clipping and can make the short frame noisier. Dynamic HDR exposure selection, night and flash tables, and the other state machines stay stock, so an auto-on `RAW_HDR` capture still has its stock algorithm list.',
  '- `fast-init.hold-startup-handle-for-algo.algorithms` is an eight-slot list aligned with `imagers` and `camera-type`. Every slot is now empty. Stock named ArcSoft TF motion capture on all eight, Tetras RAW SR on the tele and zoom slots, and ArcSoft TF refocus on both depth slots. `ai-scene-detect.enable` and `tetras-raw-sr.enable` are false on all eight slots. `beauty-shot-fotonation.enable` is false on all eight slots and `default-beauty-level` is 0.',
  '- `MCF_HAL_FRAME_STACK_STATE_MACHINE` keeps `MCF_BST_PURPLE_FRINGE_CAPTURE_ALG`, `MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG`, and `MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG` in that stock order. Tetras SensePR, FotoNation beauty, ArcSoft low-light AI portrait, selective color, miniature bokeh, DSLR, composition, the CUD model, and the BST distortion corrector are removed from this path only.',
  '- App features are read as presence-based entries. The single flag removal preserves every other entry in stock order, including capture, zoom, video, and HAL-related flags. The HDR control remains subject to the app’s mode support checks.',
  '- The generator verifies the stock MCF plaintext byte for byte before writing. The encrypted mod contains the exact readable JSON bytes. The test suite checks every edit, the original numeric token forms everywhere else, and Java Blowfish interoperability. Native library initialization and photo quality require ctwo device validation.',
  '',
  'The generator is ' + tick('scripts/generate_mod_configs.mjs') + '. The codec is ' + tick('scripts/mcf_crypto.mjs') + ' and the tests are in ' + tick('tests/test_configs_mod.mjs') + '.',
  '',
].join('\n');

function compactConfig(config, stockBytes) {
  const lineEnding = stockBytes.toString('utf8').match(/\r?\n$/)?.[0] ?? '';
  return JSON.stringify(config) + lineEnding;
}

// Keep calibration rows readable while avoiding whitespace on every number.
const mcfJson = JSON.stringify(mcf, null, 2).replace(
  /\[\n(?: +(?:-?\d[\d.eE+-]*|true|false|null),?\n)+ +\]/g,
  array => array.replace(/\n +/g, ''),
);
const modMcf = Buffer.from(mcfJson + '\n', 'utf8');
const outputs = [
  [iqName, compactConfig(iq, iqBytes)],
  [appName, compactConfig(app, appBytes)],
  [modJsonName, modMcf],
  [mcfName, encryptMcf(modMcf)],
  ['CONFIG_CHANGELOG.md', changelog],
];

mkdirSync(modDir, { recursive: true });
for (const [name, bytes] of outputs) {
  writeFileSync(new URL(name, modDir), bytes);
}
console.log('Generated ' + outputs.length + ' files in configs_mod/.');
