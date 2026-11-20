import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import {
  mergeMissingArscPackages,
  readZipEntryBytes,
  replaceZipEntryStored,
} from './arsc_merge.mjs';
import { publishSignedApk } from './build_clone.mjs';
import {
  REPO_ROOT,
  resolveBaseDir,
  resolveConfigsDir,
  resolveJava,
  resolveToolJar,
} from './env_paths.mjs';
import { decryptMcf, encryptMcf, MCF5_KEY } from './mcf_crypto.mjs';

const BASE = resolveBaseDir();
const JAVA = resolveJava();
const APKTOOL = resolveToolJar(null, 'APKTOOL_JAR', 'apktool3.jar');
const SIGNER = resolveToolJar(null, 'UBER_APK_SIGNER_JAR', 'uber-apk-signer.jar');

const SRC5 = process.env.MOTCAM5_SRC || path.join(BASE, 'decompiled', 'MotCamera5_roadstr');
const SRC5_APK = process.env.MOTCAM5_APK || path.join(BASE, 'apks', 'MotCamera5_roadstr.apk');
const SRC4 = process.env.MOTCAM4_SRC || path.join(BASE, 'decompiled', 'MotCamera4_v3');
const CTWO_CFG = resolveConfigsDir();
const MOD_CFG = path.join(REPO_ROOT, 'configs_mod');
const HIDDEN_API = path.join(REPO_ROOT, 'patches', 'hiddenapibypass_smali');

const STAGE = path.join(BASE, 'work_motcam5');
const OUT_APK = path.join(BASE, 'dist', 'MotCamera5-Port-ctwo.apk');

function runJava(args) {
  const r = spawnSync(JAVA, args, { stdio: 'inherit', windowsHide: true });
  if (r.error) throw r.error;
  if (r.status !== 0) throw new Error(`java exited ${r.status}`);
}

function patchExact(file, find, replace, label) {
  const raw = fs.readFileSync(file, 'utf8');
  const eol = raw.includes('\r\n') ? '\r\n' : '\n';
  const norm = raw.replace(/\r\n/g, '\n');
  const fNorm = find.replace(/\r\n/g, '\n');
  const count = norm.split(fNorm).length - 1;
  if (count !== 1) throw new Error(`patch ${label}: expected 1 match, got ${count} in ${file}`);
  const out = norm.split(fNorm).join(replace.replace(/\r\n/g, '\n')).replace(/\n/g, eol);
  fs.writeFileSync(file, out);
}

console.log('1. Staging MotCamera5_roadstr...');
fs.rmSync(STAGE, { recursive: true, force: true });
fs.cpSync(SRC5, STAGE, { recursive: true });
fs.cpSync(HIDDEN_API, path.join(STAGE, 'smali_classes2'), { recursive: true });

console.log('2. Patching AndroidManifest.xml and locale labels...');
let manifest = fs.readFileSync(path.join(STAGE, 'AndroidManifest.xml'), 'utf8');
manifest = manifest
  .replace(
    '<uses-feature android:name="com.motorola.camera5" android:required="true"/>',
    '<uses-feature android:name="com.motorola.camera5" android:required="false"/>',
  )
  .replace(
    /^[ \t]*<permission\b[^>]*android:name="com\.motorola\.camera\.permission\.CONTROL_CAMERA"[^>]*\/>[ \t]*\r?\n/gm,
    '',
  )
  .replace(
    '<uses-library android:name="com.motorola.motosignature" android:required="true"/>',
    '<uses-library android:name="com.motorola.motosignature" android:required="false"/>',
  )
  .replace(
    '<meta-data android:name="com.android.dynamic.apk.fused.modules" android:value="base,feature_adobe_scan,vendor_roadstr"/>',
    '<meta-data android:name="com.android.dynamic.apk.fused.modules" android:value="base,feature_adobe_scan,vendor_ctwo"/>',
  );
fs.writeFileSync(path.join(STAGE, 'AndroidManifest.xml'), manifest);

const resDir = path.join(STAGE, 'res');
for (const ent of fs.readdirSync(resDir, { withFileTypes: true })) {
  if (!ent.isDirectory()) continue;
  if (ent.name !== 'values' && !ent.name.startsWith('values-')) continue;
  const sp = path.join(resDir, ent.name, 'strings.xml');
  if (!fs.existsSync(sp)) continue;
  const s = fs.readFileSync(sp, 'utf8');
  const next = s.replace(
    /(<string\b[^>]*\bname="act_name_camera"[^>]*>)([\s\S]*?)(<\/string>)/g,
    '$1MotoCam 5 Port$3',
  );
  if (next !== s) fs.writeFileSync(sp, next);
}

console.log('3. Applying Smali patches (HiddenApiBypass, system feature check, DeveloperMenu)...');
patchExact(
  path.join(STAGE, 'smali', 'com', 'motorola', 'camera', 'CameraApp.smali'),
  '.method public final onCreate()V\n    .locals 5\n\n    invoke-super {p0}, Landroid/app/Application;->onCreate()V',
  '.method public final onCreate()V\n    .locals 5\n\n    const/4 v0, 0x1\n\n    new-array v0, v0, [Ljava/lang/String;\n\n    const/4 v1, 0x0\n\n    const-string v2, "L"\n\n    aput-object v2, v0, v1\n\n    invoke-static {v0}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->addHiddenApiExemptions([Ljava/lang/String;)Z\n\n    invoke-super {p0}, Landroid/app/Application;->onCreate()V',
  'bypass_art_hidden_api',
);
patchExact(
  path.join(STAGE, 'smali', 'com', 'motorola', 'camera', 'Camera.smali'),
  '    const-string v12, "com.motorola.camera5"\n\n    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;',
  '    const-string v12, "com.motorola.camera3"\n\n    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;',
  'camera5_feature_to_camera3',
);
patchExact(
  path.join(STAGE, 'smali', 'com', 'motorola', 'camera', 'Camera.smali'),
  '    sget-object v0, Lcom/motorola/camera/utility/lens/LensApi;->TAG:Ljava/lang/String;\n\n    new-instance v0, Landroid/content/Intent;\n\n    const-string v1, "android.intent.action.VIEW"\n\n    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V\n\n    sget-object v1, Lcom/motorola/camera/utility/lens/LensApi;->GOOGLE_LENS_DATA:Landroid/net/Uri;\n\n    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;\n\n    const-string v1, "com.google.android.googlequicksearchbox"\n\n    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;\n\n    const/4 v1, 0x7\n\n    invoke-virtual {p0, v0, v1}, Landroidx/activity/ComponentActivity;->startActivityForResult(Landroid/content/Intent;I)V',
  '    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;\n\n    move-result-object v0\n\n    const-string v1, "com.google.ar.lens"\n\n    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;\n\n    move-result-object v0\n\n    if-eqz v0, :cond_1\n\n    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V\n\n    goto :goto_1\n\n    :cond_1\n    new-instance v0, Landroid/content/Intent;\n\n    const-string v1, "android.intent.action.VIEW"\n\n    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V\n\n    sget-object v1, Lcom/motorola/camera/utility/lens/LensApi;->GOOGLE_LENS_DATA:Landroid/net/Uri;\n\n    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;\n\n    const-string v1, "com.google.android.googlequicksearchbox"\n\n    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;\n\n    const/4 v1, 0x7\n\n    invoke-virtual {p0, v0, v1}, Landroidx/activity/ComponentActivity;->startActivityForResult(Landroid/content/Intent;I)V\n\n    :goto_1',
  'google_lens_via_ar_lens',
);
patchExact(
  path.join(STAGE, 'smali', 'com', 'motorola', 'camera', 'instrumentreport', 'DeveloperMenu.smali'),
  '    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;\n\n    sput-object v0, Lcom/motorola/camera/instrumentreport/DeveloperMenu;->mDebug:Ljava/lang/Boolean;',
  '    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;\n\n    sput-object v0, Lcom/motorola/camera/instrumentreport/DeveloperMenu;->mDebug:Ljava/lang/Boolean;',
  'unlock_developer_menu',
);

console.log('4. Copying ctwo SM8635 native libs not present in MotCamera5_roadstr...');
const src4Lib = path.join(SRC4, 'lib', 'arm64-v8a');
const stageLib = path.join(STAGE, 'lib', 'arm64-v8a');
const copiedLibs = [];
for (const name of fs.readdirSync(src4Lib)) {
  const dst = path.join(stageLib, name);
  if (!fs.existsSync(dst)) {
    fs.copyFileSync(path.join(src4Lib, name), dst);
    copiedLibs.push(name);
  }
}
console.log('   copied', copiedLibs.length, 'ctwo libs');

console.log('5. Building ctwo configs adapted to MotCamera5 schema...');
const assetsDir = path.join(STAGE, 'assets');
const rAssets = path.join(SRC5, 'assets');

const purpleFringeConfig = 'control_param_pfremove_motovelar_c240329_enc.cfg';
fs.mkdirSync(path.join(assetsDir, 'algo_vendor'), { recursive: true });
fs.copyFileSync(
  path.join(SRC4, 'assets', 'algo_vendor', purpleFringeConfig),
  path.join(assetsDir, 'algo_vendor', purpleFringeConfig),
);

const dev4 = JSON.parse(fs.readFileSync(path.join(CTWO_CFG, 'config_devices_ctwo'), 'utf8'));
const dev5 = JSON.parse(fs.readFileSync(path.join(rAssets, 'config_device_roadstr'), 'utf8')).roadstr;
dev4.ctwo['uhdr-camera-mode-configs'] = dev5['uhdr-camera-mode-configs'];
dev4.ctwo['active-photo-config'] = dev5['active-photo-config'];
dev4.ctwo['face-beauty-ui'] = dev5['face-beauty-ui'];
dev4.ctwo['customized-hal-zsl-on-modes'] = ['MODE_PHOTO', 'MODE_MOTION_CAPTURE'];
fs.writeFileSync(path.join(assetsDir, 'config_device_ctwo'), JSON.stringify(dev4));

fs.copyFileSync(path.join(CTWO_CFG, 'cms_config_ctwo'), path.join(assetsDir, 'cms_config_ctwo'));

const feat4 = JSON.parse(fs.readFileSync(path.join(CTWO_CFG, 'app_feature_ctwo'), 'utf8'));
const featNames = new Set(feat4.fs.map((x) => x.f));
feat4.fs = feat4.fs.filter((x) => x.f !== 'REMOVE_HDR_SETTING_UI');
for (const extra of [
  { f: 'APP_ACCELERATE' },
  { f: 'BG_SERVICE_PROCESSING_SAME_PROCESS' },
  { f: 'PANTONE' },
  { f: 'SET_EXTRA_FREE_REPEATEDLY', value: '10000' },
  { f: 'VIDEO_AUTO_FPS', value: '6' },
  { f: 'VIDEO_FILTERS', value: '1920' },
  { f: 'VIDEO_HDR10' },
  { f: 'VIDEO_HDR10_WITH_STABILIZATION' },
  { f: 'VIDEO_RECORDING_KNIFE_SWITCH' },
  { f: 'ZOOM_MAIN_2X' },
  { f: 'AI_PERSONAL_COLOR_TONE', value: '0' },
  { f: 'AI_GROUP_PHOTO' },
]) {
  if (!featNames.has(extra.f)) feat4.fs.push(extra);
}
fs.writeFileSync(path.join(assetsDir, 'app_feature_ctwo'), JSON.stringify(feat4));

const iqSource = fs.existsSync(path.join(MOD_CFG, 'iq_config_ctwo'))
  ? path.join(MOD_CFG, 'iq_config_ctwo')
  : path.join(CTWO_CFG, 'iq_config_ctwo');
const iq4 = JSON.parse(fs.readFileSync(iqSource, 'utf8'));
const iq5 = JSON.parse(fs.readFileSync(path.join(rAssets, 'iq_config_roadstr'), 'utf8')).roadstr;
delete iq4.ctwo.uhdr_settings;
iq4.ctwo.uhdr_settings_advanced = iq5.uhdr_settings_advanced;
fs.writeFileSync(path.join(assetsDir, 'iq_config_ctwo'), JSON.stringify(iq4));

const mcf4 = JSON.parse(decryptMcf(fs.readFileSync(path.join(CTWO_CFG, 'mcf_config_ctwo'))).toString('utf8'));
const mcf5 = JSON.parse(decryptMcf(fs.readFileSync(path.join(rAssets, 'mcf_config_roadstr')), MCF5_KEY).toString('utf8')).roadstr;
const N = mcf4.ctwo.imagers.length;
const rep = (val) => Array.from({ length: N }, () => structuredClone(val));
const NON_IMAGER_4_KEYS = new Set(['allow-scenes', 'needed-post-view-process-algs', 'bokeh-blur-level-mapping', 'multi-face-bokeh-blur-level-mapping']);
const resizeToN = (val, key = '') => {
  if (!Array.isArray(val) || val.length === 0) return structuredClone(val);
  if (NON_IMAGER_4_KEYS.has(key)) return structuredClone(val);
  if (val.length === N) return structuredClone(val);
  if (val.length === 4) {
    return Array.from({ length: N }, (_, i) => structuredClone(val[Math.min(i, val.length - 1)]));
  }
  return structuredClone(val);
};
const resizeDeep = (node, key = '') => {
  if (Array.isArray(node)) {
    const resized = resizeToN(node, key);
    if (resized.length && typeof resized[0] === 'object' && !Array.isArray(resized[0])) {
      return resized.map((el) => resizeDeep(el));
    }
    return resized;
  }
  if (node && typeof node === 'object') {
    const out = {};
    for (const [k, v] of Object.entries(node)) out[k] = resizeDeep(v, k);
    return out;
  }
  return node;
};
const mergeMissingDeep = (dst, tpl) => {
  if (!dst || !tpl || typeof dst !== 'object' || typeof tpl !== 'object' || Array.isArray(dst) || Array.isArray(tpl)) return;
  for (const [k, v] of Object.entries(tpl)) {
    if (!(k in dst)) {
      dst[k] = resizeDeep(v, k);
    } else if (Array.isArray(dst[k]) && Array.isArray(v) && v.length && typeof v[0] === 'object' && !Array.isArray(v[0])) {
      for (const elem of dst[k]) {
        if (elem && typeof elem === 'object' && !Array.isArray(elem)) {
          mergeMissingDeep(elem, v[0]);
        }
      }
    } else if (dst[k] && typeof dst[k] === 'object' && !Array.isArray(dst[k]) && v && typeof v === 'object' && !Array.isArray(v)) {
      mergeMissingDeep(dst[k], v);
    }
  }
};

for (const [sec, val] of Object.entries(mcf5)) {
  if (sec === 'state-machine-to-algorithms-map' || sec === 'imagers' || sec === 'camera-type' || sec === 'camera-ids') continue;
  if (!(sec in mcf4.ctwo)) {
    mcf4.ctwo[sec] = resizeDeep(val, sec);
  } else {
    mergeMissingDeep(mcf4.ctwo[sec], val);
  }
}

for (const disabledSec of [
  'arcsoft-moondetect',
  'meishe-beauty-shot-capture',
  'meishe-beauty-shot-preview',
  'arcsoft-tf-raw-sr',
  'moto-flicker-detect',
  'bst-hdr4',
  'jiigan-raw-super-resolution',
  'jiigan-raw-sn',
  'jg-flicker-detect',
  'jiigan-motion-capture',
  'as-gesture-detect',
  'postview-arcsoft-offline-postproc',
  'postview-AR-distortion-correction',
]) {
  if (mcf4.ctwo[disabledSec] && typeof mcf4.ctwo[disabledSec] === 'object') {
    mcf4.ctwo[disabledSec].enable = rep(false);
  }
}
if (mcf4.ctwo['scene-classifer']?.['moon-detect']) {
  mcf4.ctwo['scene-classifer']['moon-detect'].enable = rep(false);
}
if (mcf4.ctwo['arcsoft-turbo-fusion-motion-capture']) {
  mcf4.ctwo['arcsoft-turbo-fusion-motion-capture']['grf-lib-name'] = 'libarcsoft_turbo_raw_grf_8635.so';
}
for (const sec of ['arcsoft-turbo-fusion-raw-hdr', 'arcsoft-turbo-fusion-raw-nv']) {
  if (mcf4.ctwo[sec]) {
    mcf4.ctwo[sec]['pdc-lib-name'] = rep('libarcsoft_portrait_distortion_correction.so');
  }
}

mcf4.ctwo['meishe-effects'] = {
  ...mcf5['meishe-effects'],
  enable: rep(true),
  'api-version': rep(2),
  'yuv-color-matrix': rep(0),
  'yuv-range': rep(1),
  'thumbnails-threads': rep(6),
  'thumbnails-size-dp': rep(62),
};
mcf4.ctwo['ultra-hdr'] = {
  enable: rep(true),
  'cpu-boost': rep(true),
  'cpu-affinity': rep([]),
  'gainmap-file': rep('gainmap_tuning_roadstr.json'),
  'lib-name': rep('libultrahdr.so'),
};
mcf4.ctwo['buffer-copy-on-zero-capture-algs'] = { enable: rep(true) };
if (mcf4.ctwo['state-machine']?.['hal-frame-stack']) {
  mcf4.ctwo['state-machine']['hal-frame-stack']['need-to-lock-ae'] = rep(false);
}
if (mcf4.ctwo['fast-init']?.['hold-startup-handle-for-algo']) {
  mcf4.ctwo['fast-init']['hold-startup-handle-for-algo'].algorithms = rep([]);
}
if (mcf4.ctwo['ai-scene-detect']) mcf4.ctwo['ai-scene-detect'].enable = rep(false);
if (mcf4.ctwo['tetras-raw-sr']) mcf4.ctwo['tetras-raw-sr'].enable = rep(false);
if (mcf4.ctwo['beauty-shot-fotonation']) {
  mcf4.ctwo['beauty-shot-fotonation'].enable = rep(false);
  mcf4.ctwo['beauty-shot-fotonation']['default-beauty-level'] = 0;
}

const removedSMs = new Set([
  'MCF_AL_SUPER_RESOLUTION_STATE_MACHINE',
  'MCF_BLUR_STATE_MACHINE',
  'MCF_HAL_FRAME_STACK_AILS_STATE_MACHINE',
  'MCF_HDR_ADVANCED_AILS_STATE_MACHINE',
  'MCF_HAL_FRAME_STACK_AIIST_STATE_MACHINE',
  'MCF_HDR_ADVANCED_AIIST_STATE_MACHINE',
  'MCF_AL_SUPER_RESOLUTION_HDR_STATE_MACHINE',
  'MCF_MOTION_CAPTURE_STATE_MACHINE',
]);
const removedAlgs = new Set([
  'MCF_ML_MODEL_CUD',
  'MCF_MORPHO_IMAGE_REFINER_HDR_ALG',
  'MCF_MORPHO_IMAGE_REFINER_HDR_ADVANCED_ALG',
  'MCF_MORPHO_IMAGE_REFINER_LL_ALG',
  'MCF_MORPHO_SUPERRESOLUTION_CAPTURE_ALG',
  'MCF_MORPHO_HDSUPERRESOLUTION_CAPTURE_ALG',
  'MCF_AILS_CAPTURE_ALG',
  'MCF_ARCSOFT_LL_AI_PORTRAIT_CAPTURE_ALG',
  'MCF_AL_SUPERRESOLUTION_CAPTURE_ALG',
  'MCF_AL_SUPER_RESOLUTION_AS_HDR_CAPTURE_ALG',
  'MCF_AL_SUPER_RESOLUTION_BST_HDR_CAPTURE_ALG',
  'MCF_MOT_TEST_BLUR_CAPTURE_ALG',
  'MCF_MOT_IMAGE_STABILIZATION_ALG',
]);
if (mcf4.ctwo['state-machine-to-algorithms-map']) {
  const cleanMap = {};
  for (const [sm, algs] of Object.entries(mcf4.ctwo['state-machine-to-algorithms-map'])) {
    if (removedSMs.has(sm)) continue;
    cleanMap[sm] = algs.filter((a) => !removedAlgs.has(a));
  }
  for (const sm of ['MCF_RAW_SN_STATE_MACHINE', 'MCF_AS_TF_MOTION_CAPTURE_STATE_MACHINE', 'MCF_JG_MOTION_CAPTURE_STATE_MACHINE']) {
    if (!(sm in cleanMap) && mcf5['state-machine-to-algorithms-map']?.[sm]) {
      cleanMap[sm] = structuredClone(mcf5['state-machine-to-algorithms-map'][sm]);
    }
  }
  for (const uhdrSm of ['MCF_RAW_HDR_STATE_MACHINE', 'MCF_RAW_SUPER_RESOLUTION_STATE_MACHINE', 'MCF_AS_TF_RAW_NV_STATE_MACHINE']) {
    const list = cleanMap[uhdrSm];
    if (Array.isArray(list) && !list.includes('MCF_UHDR_ALG')) {
      const idx = list.indexOf('MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG');
      if (idx >= 0) list.splice(idx, 0, 'MCF_UHDR_ALG');
      else list.push('MCF_UHDR_ALG');
    }
  }
  cleanMap.MCF_HAL_FRAME_STACK_STATE_MACHINE = [
    'MCF_BST_PURPLE_FRINGE_CAPTURE_ALG',
    'MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG',
    'MCF_UHDR_ALG',
    'MCF_MEISHE_NV_EFFECTS_CAPTURE_ALG',
  ];
  mcf4.ctwo['state-machine-to-algorithms-map'] = cleanMap;
}

fs.copyFileSync(
  path.join(assetsDir, 'uhdr', 'gainmap_tuning_roadstr.json'),
  path.join(assetsDir, 'uhdr', 'gainmap_tuning_ctwo.json'),
);
fs.writeFileSync(
  path.join(assetsDir, 'mcf_config_ctwo'),
  encryptMcf(Buffer.from(JSON.stringify(mcf4), 'utf8'), MCF5_KEY),
);

console.log('6. Building MotCamera5-Port-ctwo.apk with apktool3...');
const outDir = path.dirname(OUT_APK);
fs.mkdirSync(outDir, { recursive: true });
const unsigned = path.join(outDir, 'MotCamera5-Port-ctwo.unsigned.apk');
fs.rmSync(unsigned, { force: true });
runJava(['-Xmx4g', '-jar', APKTOOL, 'b', STAGE, '-o', unsigned]);

console.log('7. Merging 0x81 feature_adobe_scan resources.arsc...');
const modArsc = readZipEntryBytes(unsigned, 'resources.arsc');
const stockArsc = readZipEntryBytes(SRC5_APK, 'resources.arsc');
const merged = mergeMissingArscPackages(modArsc, stockArsc);
console.log('   mergedArsc:', merged.addedPackages, 'addedStrings:', merged.addedStrings);
if (merged.addedPackages.length > 0) {
  replaceZipEntryStored(unsigned, 'resources.arsc', merged.arsc);
}

console.log('8. Signing MotCamera5-Port-ctwo.apk...');
runJava(['-jar', SIGNER, '--apks', unsigned, '--out', outDir]);
publishSignedApk(outDir, unsigned, OUT_APK);
console.log('DONE:', OUT_APK, fs.statSync(OUT_APK).size, 'bytes');
