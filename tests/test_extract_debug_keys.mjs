import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { existsSync, readFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  DECOMPILED,
  JSON_OUT,
  MD_OUT,
  RE_ROOT,
  extractReference,
  parseClinitKeys,
  tabsForName,
} from '../scripts/extract_debug_keys.mjs';

const HAS_DECOMPILED = existsSync(DECOMPILED);
if (!HAS_DECOMPILED) {
  console.log('SKIP extract_debug_keys device-tree checks (decompiled MotCamera4_v3 not present)');
  process.exit(0);
}

const scriptPath = resolve(dirname(fileURLToPath(import.meta.url)), '..', 'scripts', 'extract_debug_keys.mjs');
const failures = [];

function check(name, fn) {
  try {
    fn();
    console.log(`PASS ${name}`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    failures.push(`${name}: ${message}`);
    console.log(`FAIL ${name}: ${message}`);
  }
}

const fixture = `
.method public static constructor <clinit>()V
    sget-object v2, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;
    new-instance v1, Lcom/motorola/camera/settings/SettingsManager$Key;
    const-string v4, "com.motorola.camera.debug_sample"
    invoke-direct {v1, v4, v2}, Lcom/motorola/camera/settings/SettingsManager$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V
    sput-object v1, Lcom/motorola/camera/settings/SettingsManager;->DEBUG_SAMPLE:Lcom/motorola/camera/settings/SettingsManager$Key;
    new-instance v1, Lcom/motorola/camera/settings/SettingsManager$Key;
    const-string v4, "com.motorola.camera.flash_mode"
    invoke-direct {v1, v4, v2}, Lcom/motorola/camera/settings/SettingsManager$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V
    sput-object v1, Lcom/motorola/camera/settings/SettingsManager;->FLASH_MODE:Lcom/motorola/camera/settings/SettingsManager$Key;
.end method
`;

const brokenFixture = `
    sput-object v1, Lcom/motorola/camera/settings/SettingsManager;->ORPHAN:Lcom/motorola/camera/settings/SettingsManager$Key;
`;

check('known-bad name matches no developer tab', () => {
  assert.deepEqual(tabsForName('com.motorola.camera.flash_mode', new Set()), []);
});

check('debug, mcf, ai, tuning, dump, and explicit names classify', () => {
  const explicit = new Set(['com.motorola.camera.preview_size']);
  assert.deepEqual(tabsForName('com.motorola.camera.debug_sample', explicit), ['app']);
  assert.deepEqual(tabsForName('com.motorola.camera.dump_yuv', explicit), ['app']);
  assert.deepEqual(tabsForName('com.motorola.camera.preview_size', explicit), ['app']);
  assert.deepEqual(tabsForName('com.motorola.camera.mcf_debug_allow', explicit), ['mcf_algorithm']);
  assert.deepEqual(tabsForName('com.motorola.camera.ai_debug_scene_detection', explicit), ['mcf_algorithm']);
  assert.deepEqual(tabsForName('com.motorola.camera.tuning_debug_face_beauty_region', explicit), ['iq']);
});

check('fixture parser accepts a real key shape and a non-debug key', () => {
  const keys = parseClinitKeys(fixture, new Map(), 10);
  assert.equal(keys.length, 2);
  assert.equal(keys[0].field, 'DEBUG_SAMPLE');
  assert.equal(keys[0].name, 'com.motorola.camera.debug_sample');
  assert.equal(keys[0].type, 'boolean');
  assert.equal(keys[0].line, 16);
  assert.equal(keys[1].name, 'com.motorola.camera.flash_mode');
  assert.deepEqual(tabsForName(keys[1].name, new Set()), []);
});

check('parser rejects a sput-object with no Key.<init>', () => {
  assert.throws(() => parseClinitKeys(brokenFixture, new Map()), /ORPHAN/);
});

const ref = extractReference();
const helperText = readFileSync(join(
  DECOMPILED,
  'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'helper', 'DebugBroadcastHelper.smali',
), 'utf8');
const settingsText = readFileSync(join(
  DECOMPILED,
  'smali', 'com', 'motorola', 'camera', 'settings', 'SettingsManager.smali',
), 'utf8');
const settingsLines = settingsText.split(/\r?\n/);
const manifest = readFileSync(join(DECOMPILED, 'AndroidManifest.xml'), 'utf8');
const appFeature = JSON.parse(readFileSync(join(RE_ROOT, 'configs', 'app_feature_ctwo'), 'utf8'));

check('reference JSON is non-empty and has the observed debug action', () => {
  assert.equal(ref.debug_broadcast.action, 'com.motorola.camera3.DEBUG');
  assert.equal(ref.debug_broadcast.extra, 'com.motorola.camera3.EXTRA_ACTION');
  assert.equal(helperText.includes('"com.motorola.camera3.DEBUG"'), true);
  assert.equal(helperText.includes('LocalBroadcastManager'), true);
  assert.equal(ref.debug_broadcast.adb_reaches_helper, false);
  assert.deepEqual(ref.debug_broadcast.adb_commands_that_reach_helper, []);
  assert.deepEqual(ref.debug_broadcast.in_process_intents.map((item) => item.extra_value), [0, 1]);
  assert.equal(ref.source.manifest_package, 'com.motorola.camera3');
  assert.equal(manifest.includes('package="com.motorola.camera3"'), true);
  assert.equal(manifest.includes('com.motorola.camera3.DEBUG'), false);
});

check('tab filters match observed key names and cite real sput lines', () => {
  assert.ok(ref.settings_keys.tab_counts.app > 0);
  assert.ok(ref.settings_keys.tab_counts.mcf_algorithm > 0);
  assert.ok(ref.settings_keys.tab_counts.iq > 0);
  const explicit = new Set(ref.settings_keys.explicit_app_names);
  for (const key of ref.settings_keys.tabs.app) {
    assert.equal(
      key.name.includes('.debug_') || key.name.includes('dump_') || explicit.has(key.name),
      true,
      key.name,
    );
    assert.match(settingsLines[key.settings_manager_line - 1], new RegExp(`->${key.field}:`));
    assert.equal(settingsText.includes(`"${key.name}"`), true);
  }
  for (const key of ref.settings_keys.tabs.mcf_algorithm) {
    assert.equal(key.name.includes('mcf_debug_') || key.name.includes('ai_debug_'), true, key.name);
    assert.match(settingsLines[key.settings_manager_line - 1], new RegExp(`->${key.field}:`));
  }
  for (const key of ref.settings_keys.tabs.iq) {
    assert.equal(key.name.includes('tuning_debug_'), true, key.name);
    assert.match(settingsLines[key.settings_manager_line - 1], new RegExp(`->${key.field}:`));
  }
  const preview = ref.settings_keys.tabs.app.find((key) => key.field === 'PREVIEW_SIZE_DEBUG_ENABLE');
  assert.equal(preview.name, 'com.motorola.camera.debug_preview_size_enable');
  assert.equal(preview.control, 'switch');
  assert.match(settingsLines[preview.settings_manager_line - 1], /PREVIEW_SIZE_DEBUG_ENABLE/);
  const names = new Set([
    ...ref.settings_keys.tabs.app,
    ...ref.settings_keys.tabs.mcf_algorithm,
    ...ref.settings_keys.tabs.iq,
  ].map((key) => key.name));
  assert.equal(names.has('com.motorola.camera.cta_permission_click'), false);
  assert.equal(names.has('com.motorola.camera.debug_not_a_real_key'), false);
  const missing = [];
  for (const line of settingsLines) {
    const match = line.match(/const-string(?:\/jumbo)?\s+\w+,\s+"([^"]+)"/);
    if (!match) continue;
    const name = match[1];
    const expected = [];
    if (name.includes('.debug_') || name.includes('dump_')) expected.push('app');
    if (name.includes('mcf_debug_') || name.includes('ai_debug_')) expected.push('mcf_algorithm');
    if (name.includes('tuning_debug_')) expected.push('iq');
    for (const tab of expected) {
      const present = ref.settings_keys.tabs[tab].some((key) => key.name === name);
      if (!present) missing.push(`${tab}:${name}`);
    }
  }
  assert.deepEqual(missing, []);
});

check('ctwo feature file and IQ override scenes are preserved', () => {
  assert.equal(ref.ctwo.app_features.device, 'ctwo');
  assert.equal(ref.ctwo.app_features.count, appFeature.fs.length);
  assert.equal(ref.ctwo.app_features.count, 92);
  const features = new Set(ref.ctwo.app_features.features.map((feature) => feature.feature));
  assert.equal(features.has('ADOBE_SCAN'), true);
  assert.equal(features.has('SUPER_NIGHT'), true);
  assert.equal(features.has('QCFA_SINGLE_SESSION_WITH_MCF'), true);
  const zoom = ref.ctwo.app_features.features.find((feature) => feature.feature === 'AUTO_FOV_SWITCH');
  assert.equal(zoom.value, '1.4');
  assert.equal(ref.ctwo.iq.override_scenes.includes('RAW_HDR'), true);
  assert.equal(ref.ctwo.iq.override_scenes.includes('RAW_SUPER_NIGHT'), true);
  assert.equal(ref.ctwo.iq.sensors.includes('mot_ov50h'), true);
  assert.equal(ref.ctwo.mcf_override.property, 'persist.camera.mot.mcf_override');
  assert.equal(ref.ctwo.mcf_override.ctwo_prefix, 'mcf_config_ctwo');
  assert.match(ref.ctwo.mcf_override.ui_hint, /setprop log\.tag\.mcf\.override\.config D/);
});

const run = spawnSync(process.execPath, [scriptPath], { encoding: 'utf8' });

check('extractor process exits 0 and rewrites the same JSON', () => {
  assert.equal(run.status, 0, run.stderr || run.stdout);
  const written = JSON.parse(readFileSync(JSON_OUT, 'utf8'));
  assert.deepEqual(written, ref);
  const markdown = readFileSync(MD_OUT, 'utf8');
  assert.equal(markdown.includes('com.motorola.camera3.DEBUG'), true);
  assert.equal(markdown.includes('App 46'), true);
  assert.equal(markdown.includes('MCF&Algorithm 11'), true);
  assert.equal(markdown.includes('settings_list_about_debug_key'), true);
  assert.equal(markdown.includes('adb_commands_that_reach_helper'), true);
  assert.equal(markdown.includes('LocalBroadcastManager'), true);
  assert.equal(markdown.includes('com.motorola.camera3.DEBUG_ENABLE_ALL'), false);
});

if (failures.length) {
  console.log(`\n${failures.length} failed`);
  process.exit(1);
}
console.log('\nAll checks passed');
