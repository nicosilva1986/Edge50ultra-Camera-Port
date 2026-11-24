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
  assert.ok(Array.isArray(data.patches));
  assert.equal(data.patches.length, 62);

  const galleryPatchIds = data.patches.filter((p) => p.category === 'gallery').map((p) => p.id);
  assert.deepEqual(galleryPatchIds, [
    'gallery_await_processing_before_launch',
    'gallery_skip_processing_uri_for_gphotos',
    'gallery_disable_exit_on_swipe_for_gphotos',
  ]);

  const customClasses = [
    'AppleStyleToneEngine', 'BokehKernel', 'CleanBayerRawProcessor', 'CompassHudController',
    'CompassSolarHelper', 'CustomImagingBridge', 'EffectsUiController', 'FrontAfHelper',
    'GainmapJpeg', 'LiveLookPreview', 'LookFilterEngine', 'LookOptics',
    'MultiFrameBurstController', 'MultiFrameRawEngine', 'OffscreenBokeh',
    'PortraitBokeh', 'ScenePostProcSelector', 'TelemetryCollector', 'VideoConfigHelper',
  ];
  for (const name of customClasses) {
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
    for (const cam of ['BACK_MAIN', 'BACK_TELE', 'ZOOM_BLENDING', 'FRONT_MAIN']) {
      const idx = dev.ctwo['camera-type'].indexOf(cam);
      assert.ok(idx >= 0, `Missing camera-type ${cam}`);
      assert.equal(dev.ctwo['hq-preview'][idx], false, `Expected hq-preview=false for ${cam}`);
    }
    assert.equal(dev.ctwo['disable-app-zsl-on-scenes'].includes('ALL_SCENES'), false);
    assert.deepEqual(
      dev.ctwo['in-sensor-crop-logic']?.['in-sensor-crop-back-main-overrides']?.['in-sensor-crop-lux-idx-threshold'],
      [380, 410],
    );
    assert.deepEqual(
      dev.ctwo['in-sensor-crop-logic']?.['in-sensor-crop-back-tele-overrides']?.['in-sensor-crop-lux-idx-threshold'],
      [250, 280],
    );
    assert.ok((dev.ctwo['remosaic-config']?.['to-high-res-rg-threshold']?.[0] ?? 9) <= 0.1);
    assert.deepEqual(dev.ctwo['portrait-lens'], {
      'camera-type': ['BACK_MAIN', 'BACK_MAIN', 'BACK_MAIN', ''],
      'zoom-value': [1, 1.5, 2, 0],
      'blur-level': [3, 3, 3, 0],
    });
    for (const depthType of ['LOGICAL_DEPTH', 'LOGICAL_DEPTH3X']) {
      const dIdx = dev.ctwo['camera-type'].indexOf(depthType);
      assert.ok(dIdx >= 0, `Expected ${depthType} slot preserved for table alignment`);
      assert.deepEqual(dev.ctwo['camera-mapping'][dIdx]['sensor-name'], ['disabled_logical_depth']);
      assert.deepEqual(dev.ctwo['camera-mapping'][dIdx]['sensor-name-override'], ['disabled_logical_depth']);
    }

    const iq = JSON.parse(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'iq_config_ctwo'), 'utf8'));
    assert.equal(
      iq.ctwo.scene_selection_advanced_overrides?.BACK_MAIN?.auto_ultra_resolution?.hdr_auto_on?.[0]?.override_scene,
      'HAL_FRAME_STACK',
      'auto_ultra_resolution hdr_auto_on must stay HAL_FRAME_STACK (not RAW_HDR)',
    );
    assert.ok(
      Array.isArray(iq.ctwo.scene_selection_advanced_overrides?.BACK_MAIN?.default_mode?.hdr_on),
      'BACK_MAIN default_mode must provide hdr_on for HDR=ON mode',
    );
    assert.ok(Array.isArray(iq.ctwo.qc_mfnr_settings?.default) && iq.ctwo.qc_mfnr_settings.default.length === 5);
    for (const row of iq.ctwo.qc_mfnr_settings.default) {
      assert.equal(row.number_of_frames, 6);
      assert.equal(row.mfnr_burst_mode_enable, false);
      assert.equal(row.shutter_throttle_time, 0);
    }

    const feat = JSON.parse(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'app_feature_ctwo'), 'utf8'));
    assert.equal(
      feat.fs.some((entry) => entry.f === 'SET_EXTRA_FREE_REPEATEDLY'),
      false,
      'SET_EXTRA_FREE_REPEATEDLY must be omitted from Camera 5 app_feature_ctwo',
    );
    assert.equal(
      feat.fs.some((entry) => entry.f === 'DEPTH_ENABLED'),
      false,
      'DEPTH_ENABLED must be omitted on non-privapp ctwo so Rear Portrait uses SINGLE_REAR_BOKEH',
    );
    assert.equal(
      feat.fs.some((entry) => entry.f === 'SINGLE_REAR_BOKEH'),
      true,
      'SINGLE_REAR_BOKEH must be enabled in app_feature_ctwo for Rear Portrait mode 18',
    );
    assert.ok(fs.existsSync(path.join(STAGE_CAM5, 'res', 'values-b+es+419', 'port_effects.xml')));
    assert.ok(fs.existsSync(path.join(STAGE_CAM5, 'res', 'values-es', 'port_effects.xml')));
    assert.ok(fs.existsSync(path.join(STAGE_CAM5, 'res', 'drawable', 'port_logo_leica.xml')));

    const mcf = JSON.parse(decryptMcf(fs.readFileSync(path.join(STAGE_CAM5, 'assets', 'mcf_config_ctwo')), MCF5_KEY).toString('utf8'));
    assert.ok(mcf.ctwo['tetras-raw-sr']?.enable.every((v) => v === false));
    assert.ok(mcf.ctwo['state-machine']?.['raw-super-resolution']?.enable.every((v) => v === false));
    assert.ok(mcf.ctwo['state-machine']?.['hal-frame-stack']?.['streaming-cache-enable']?.every((v) => v === true));
    assert.equal(mcf.ctwo['fullframe-config']?.color?.skipPattern?.[0], 'skip-1');
    assert.equal(mcf.ctwo['fullframe-config']?.color?.skipPattern?.[3], 'skip-1');
    assert.equal(mcf.ctwo['state-machine']?.['hal-super-resolution']?.enable?.[2], true);
    assert.equal(mcf.ctwo['scene-classifer']?.['super-resolution']?.enable?.[2], true);
    assert.equal(mcf.ctwo['arcsoft-sfbokeh-preview']?.enable?.[0], true);
    assert.equal(mcf.ctwo['arcsoft-sfbokeh-preview']?.enable?.[1], true);
    assert.equal(mcf.ctwo['arcsoft-sfbokeh-preview']?.['face-detection-optional']?.[1], true);
    assert.equal(mcf.ctwo['arcsoft-sfbokeh-capture']?.enable?.[0], true);
    assert.equal(mcf.ctwo['arcsoft-sfbokeh-capture']?.enable?.[1], true);
    assert.equal(mcf.ctwo['state-machine']?.['hal-frame-stack-sf-bokeh']?.enable?.[1], true);
    for (const camKey of ['BACK_MAIN', 'FRONT_MAIN']) {
      for (const hdrKey of ['hdr_off', 'hdr_auto_off', 'hdr_auto_on']) {
        assert.equal(
          iq.ctwo.scene_selection_advanced_overrides?.[camKey]?.single_bokeh?.[hdrKey]?.[0]?.override_scene,
          'RAW_HDR',
          `${camKey}.single_bokeh.${hdrKey} must keep RAW_HDR for SF Bokeh`,
        );
      }
    }
    assert.ok(
      mcf.ctwo['state-machine-to-algorithms-map']?.MCF_HAL_FRAME_STACK_STATE_MACHINE?.includes('MCF_MOT_SELECTIVE_COLOR_CAPTURE_ALG'),
      'MCF_HAL_FRAME_STACK_STATE_MACHINE should preserve OpenCL/Moto capture modes',
    );
    assert.equal(
      mcf.ctwo['state-machine-to-algorithms-map']?.MCF_HAL_FRAME_STACK_STATE_MACHINE?.includes('MCF_ARCSOFT_DISTORTION_CORREC_CAPTURE_ALG'),
      false,
      'MCF_HAL_FRAME_STACK_STATE_MACHINE should not apply portrait distortion correction globally',
    );
    const srThresh = mcf.ctwo['arcsoft-tf-drsd']?.['custom-thresh']?.find((t) => t?.variant === 'super-resolution');
    assert.ok(srThresh && srThresh['zoom-thresh-in'][2] <= 12);
    assert.equal(mcf.ctwo['arcsoft-tf-drsd']?.['ev-lib-api-version'], 1);

    for (const sec of [
      'arcsoft-turbo-fusion-raw-nv',
      'arcsoft-turbo-fusion-raw-hdr',
      'arcsoft-turbo-fusion-motion-capture',
    ]) {
      const cfg = mcf.ctwo[sec];
      assert.ok(cfg, `Missing ${sec}`);
      assert.ok(
        Array.isArray(cfg['api-version']) && cfg['api-version'].every((v) => v === 1),
        `${sec}.api-version must pin SM8635 V1 instead of roadstr V3`,
      );
      assert.equal(
        cfg['grf-lib-api-version'],
        1,
        `${sec}.grf-lib-api-version must pin SM8635 V1 instead of roadstr V3`,
      );
    }

    const rootSettingsXml = fs.readFileSync(path.join(STAGE_CAM5, 'res', 'xml', 'settings_list_root_preferences.xml'), 'utf8');
    assert.equal(rootSettingsXml.includes('settings_list_general_camera_feedback_key'), false);
    assert.equal(rootSettingsXml.includes('settings_list_about_help_key'), false);
    assert.equal(rootSettingsXml.includes('settings_list_about_reset_key'), true);

    const assistXml = fs.readFileSync(path.join(STAGE_CAM5, 'res', 'xml', 'settings_list_capture_assistant_preferences.xml'), 'utf8');
    assert.equal(assistXml.includes('android:key="port_compass_hud"'), true);
    assert.equal(assistXml.includes('@string/port_compass_hud_title'), true);
    const esPortEffects = fs.readFileSync(path.join(STAGE_CAM5, 'res', 'values-es', 'port_effects.xml'), 'utf8');
    assert.equal(esPortEffects.includes('port_compass_hud_title'), true);

    const cameraSmali = fs.readFileSync(path.join(STAGE_CAM5, 'smali', 'com', 'motorola', 'camera', 'Camera.smali'), 'utf8');
    assert.equal(cameraSmali.includes('CustomImagingBridge;->onCameraActivityResumed()V'), true);
    assert.equal(cameraSmali.includes('CustomImagingBridge;->onSessionResetKeepLastModeOff()V'), true);
    const settingsSmali = fs.readFileSync(path.join(STAGE_CAM5, 'smali', 'com', 'motorola', 'camera', 'settings', 'SettingsManager.smali'), 'utf8');
    assert.equal(settingsSmali.includes(':cond_meishe_vid_off'), true);
    const resetSmali = fs.readFileSync(
      path.join(STAGE_CAM5, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'settings', 'fragment', 'GeneralSettingsFragment$resetDialogClickListener$1$1.smali'),
      'utf8',
    );
    assert.equal(resetSmali.includes('CustomImagingBridge;->onFactoryResetPreferences()V'), true);
    const panelSmali = fs.readFileSync(
      path.join(STAGE_CAM5, 'smali', 'com', 'motorola', 'camera', 'ui', 'controls_2020', 'ControlPanelHelper.smali'),
      'utf8',
    );
    assert.equal(panelSmali.includes('CustomImagingBridge;->isHdr10AvailableForCurrentFps()Z'), true);
  },
);
