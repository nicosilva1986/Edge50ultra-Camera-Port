# MotCamera4 v9.1.22.52 developer menu and ctwo tunables

This note records what the decompiled `MotCamera4_v3` tree and the `ctwo` config files actually contain. The machine-readable catalog is `docs/TUNABLE_KEYS_REFERENCE.json`. Package observed in `AndroidManifest.xml` line 2 is `com.motorola.camera3`. The version string `MotCamera4-v9.1.22.52_release` is the Kotlin metadata on `DebugUiPreference` line 25. Action strings stay under `com.motorola.camera3` when the installed package is renamed to `com.motorola.camera3.mod`.

## Developer menu gate

`DeveloperMenu.isMenuEnabled()` (`DeveloperMenu.smali` line 11) caches `mDebug`.

`Util.USERDEBUG_BUILD` is read at line 22 and then overwritten by the next `sget-object` before any branch uses it.

The method then reads:

- `ro.product.is_production` (`DeviceProperties.DEV_PROP_STR.PROPERTY_KEY_IS_PRODUCTION`, line 330)
- `ro.boot.secure_hardware` (`DEV_PROP_INT.SECURE_DEVICE`, line 64)
- `persist.qe` (`DEV_PROP_STR.ROOTED_DEVICE`, line 84), compared with the literal `qe 1/1`

The cached flag is true when `ro.product.is_production` equals `false` (case-insensitive) and the pair `persist.qe == "qe 1/1"` plus `ro.boot.secure_hardware == 1` is absent. Any other `is_production` value caches false. The method returns true only when that flag is true and `CameraApp.isUserAMonkey()` is false.

`GeneralSettingsFragment` line 1100 removes preference key `settings_list_about_debug_key` when the menu is disabled. The surviving row is titled `Debug` and opens `DebugPreferencesFragment`, which inflates `res/xml/settings_list_debug_preferences.xml` (`0x7f150005`). That screen contains one `DebugUiPreference` with key `settings_list_about_debug_layout_key` and layout `developer_menu`.

## Tabs

`DebugUiPreference.onBindViewHolder` (line 187) fills a `TabLayout` (`debug_ui_tab_layout`, `0x7f0a013b`) and `ViewPager2` (`debug_ui_pager`, `0x7f0a0139`).

When `Util.AUTO_TEST` is false the pages are:

| Tab title | Fragment | Key filter |
| --- | --- | --- |
| App | SettingsManagerFragment | `.debug_` or `dump_` or the names of `PREVIEW_SIZE`, `ACTIVITY_TIMEOUT`, `COMPOSITION_GUIDE` |
| MCF&Algorithm | SettingsManagerFragment (`mcf=true`) | `mcf_debug_` or `ai_debug_` |
| IQ | SettingsManagerFragment | `tuning_debug_` |
| KPI (msec) | KpiReportFragment | bundle `EXTRA_MESSAGE=KpiReportFragment` |
| CAMERA INFO | CalibrationDataFragment | no SettingsManager filter |

`Util.AUTO_TEST` is true when `ro.product.is_production` equals `false` and `Log.isLoggable("CAMERA_AUTO_TEST", DEBUG)` is true (`Util.smali` line 144). In that mode the pager has three pages: App (every key in `mSettingsMap`), KPI, and CAMERA INFO.

The lists below are the keys `SettingsFactory.getSettingsMap` passes to `addSetting` whose `mName` matches the normal-mode filter. Runtime branches inside `getSettingsMap` can still skip an `addSetting`. Static key count is 401. Factory `addSetting` key count is 381.

Normal-mode counts: App 46 (37 boolean switches), MCF&Algorithm 11, IQ 3.

Boolean rows use `SwitchCompat` (`SettingsManagerFragment.getKeyViewType` returns 0, line 40). Integer and long use view type 1, float and double use 2, `String` uses 3, and the remaining types open a dialog. Search text is stored under `LAST_DEBUG_UI_SETTING_SEARCH_QUERY`.

Explicit App-tab names that do not contain `.debug_`:

- `com.motorola.camera.activity_timeout`
- `com.motorola.camera.composition_guide`
- `com.motorola.camera.preview_size`

The full field, type, and `SettingsManager.smali` line for every matching key is the `settings_keys.tabs` object in the JSON catalog.

`scene_mode_debug_menu.xml` is a `ViewStub` (`scene_debug_stub`) whose root starts `gone`. `UIComponentFactory` line 710 constructs `SceneDetectionDebugComponent` when the developer menu is enabled and `FeaturesUtil.SUPPORT_AI` is true. The spinner id is `current_scene_picker`.

## DebugBroadcastHelper

`DebugBroadcastHelper.registerActionReceiver` (line 50) adds action `com.motorola.camera3.DEBUG` and registers `SecureCamera$1` on `LocalBroadcastManager`. The receiver (line 130) reads `com.motorola.camera3.EXTRA_ACTION` with default `-1`.

| extra value | callback |
| --- | --- |
| 0 | `enteringAction` |
| 1 | `exitingAction` |
| any other value | ignored |

`DebugUiPreference.onAttached` (line 163) and `onDetached` (line 714) build that same action and send it with `Context.sendBroadcast`, extra 0 on attach and extra 1 on detach. That call is a process-global broadcast. The helper's receiver is local. `AndroidManifest.xml` does not declare a receiver for `com.motorola.camera3.DEBUG`.

`adb shell am broadcast -a com.motorola.camera3.DEBUG --ei com.motorola.camera3.EXTRA_ACTION 0 -p com.motorola.camera3.mod` is a system broadcast. The helper receiver stays on `LocalBroadcastManager`, so `enteringAction` and `exitingAction` stay uninvoked. Extra value 1 has the same delivery. The JSON field `debug_broadcast.adb_commands_that_reach_helper` is an empty array.

`DebugBroadcastStateChangeListener$1.invoke` calls `getClass()` and returns `Unit`. `DebugIdComponent` passes a null entering callback. Those decompiled callback bodies contain no `SettingsManager` write.

`com.motorola.camera3.EXTRA_ACTION` is also put on action `com.motorola.camera3.CLI_CONTENT_ACTION_RECEIVER` by the CLI content path. `DebugBroadcastHelper` does not register that action.

## ctwo feature flags

`AppFeatures` loads plaintext asset `app_feature_` plus the stripped device name and reads array `fs`. `configs/app_feature_ctwo` has device `ctwo` and 92 features:

- `ADOBE_SCAN`
- `AI_CAMERA_CUSTOMIZED_LIMITED_TYPE1`
- `ARC_LONG_EXPOSURE`
- `ARC_LONG_EXPOSURE_STAR_TRAILS`
- `AUDIO_SMART_NOISE_CANCELLATION`
- `AUDIO_ZOOM`
- `AUDIO_ZOOM_DEFAULT_OFF`
- `AUTO_FOV_SWITCH` (value="1.4")
- `AUTO_NV_FOR_DEPTH`
- `AUTO_NV_FOR_SCBOKEH`
- `AUTO_SMILE_CAPTURE`
- `BG_SERVICE_PROCESSING_SAME_PROCESS`
- `CAPTURE_BAR_LAYOUT_2023`
- `DEPTH_ENABLED`
- `DISABLE_REPROC`
- `DISPLAY_FLASH_DEFAULT` (value="2")
- `DUAL_CAPTURE_AUDIO_LENS_SWITCH`
- `DUAL_CAPTURE_PHOTO`
- `DUAL_CAPTURE_REAR_REAR`
- `DUAL_CAPTURE_VIDEO`
- `DUAL_DEPTH_ALL_SIZES`
- `DYNAMIC_DEPTH_XMP`
- `EDITOR_LAYER`
- `EXTERNAL_MIC`
- `FACE_BEAUTY_MANUAL_MULTI`
- `FACE_BEAUTY_VIDEO`
- `FLASH_DEFAULT` (value="0")
- `FULL_FACE_DETECT_HIDDEN`
- `GAO_DING` (region=cn)
- `GESTURE_CAPTURE`
- `GOOGLE_AUTO_ENHANCE_LOW_PERFORMANCE`
- `HEVC_FOR_ALL_RESOLUTIONS`
- `HIGH_ASPECT_TOLERANCE`
- `LAUNCH_GALLERY_CUSTOMER_ANIMATION`
- `LONG_EXPOSURE`
- `MACRO_MODE_WITH_WIDE` (value="1.803523")
- `MCF_SN_TRIGGER` (value="-1")
- `MOTION_CAPTURE` (value="20")
- `NON_STANDARD_PREVIEW_ASPECT` (value="1.387")
- `PANORAMA_360_VIEW_DISABLE`
- `PHOTO_BOOTH`
- `PHOTO_PREVIEW_EIS`
- `PRESS_KEY_SWITCH_MODE`
- `QC_MFNR_BURST` (value="21")
- `QCFA_FOUR_STREAMS`
- `QCFA_SINGLE_SESSION_WITH_MCF`
- `REMOVE_HDR_SETTING_UI`
- `ROI_BRACKET_SIZE_FACTOR` (value="0.143")
- `SCAN_DOCUMENT`
- `SCAN_DOCUMENT_SHADOW_REMOVAL`
- `SCAN_EDITOR`
- `SCAN_SLIDE`
- `SCREEN_BRIGHTNESS_ADJUSTMENT_OFFSET` (value="0.0")
- `SEC_FRONT_PHOTO_SIZE_WIDTH` (value="-1")
- `SEC_PHOTO_SIZE_WIDTH` (value="-1")
- `SELECTIVE_COLOR`
- `SELECTIVE_COLOR_VIDEO`
- `SENSOR_RATIO_SAME_TO_PREVIEW`
- `SLIDER_ADOBE_SCAN`
- `SLIDER_DEFAULT_SCAN`
- `SMART_HIGH_RES_DEFAULT_OFF`
- `SMOOTH_ZOOM_JUMP`
- `SQUARE_ASPECT_RATIO`
- `SUPER_NIGHT`
- `SUPER_NIGHT_UW`
- `SUPER_PORTRAIT`
- `SUPER_SLOW_MOTION`
- `SUPER_ZOOM`
- `SUPER_ZOOM_ASSISTANT_WINDOW` (value="0.05")
- `SUPER_ZOOM_EXTENDED_MAX_ZOOM`
- `SUPER_ZOOM_MCX`
- `SUPPORT_P3`
- `TILT_SHIFT`
- `ULTRA_RES_NO_ZOOM`
- `ULTRA_RES_STANDARD_ONLY`
- `ULTRA_RES_WITH_HDR`
- `USE_POST_VIEW_AS_BACKUP` (value="1")
- `VIDEO_FACE_DETECTION` (array=[true,true])
- `VIDEO_FOCUS_TRACKING_AUTO_MODE`
- `VIDEO_HDR10_FHD`
- `VIDEO_HDR10_PLUS`
- `VIDEO_HDR10_PLUS_WITH_STABILIZATION`
- `VIDEO_LOW_LIGHT_LUX` (value="5")
- `VIDEO_SHDR`
- `VIDEO_SIZE_LIMIT_WIDTH` (value="1920")
- `VIDEO_SNAPSHOT_WITH_ALL_SURFACES`
- `VIDEO_TIMELAPSE`
- `VIDEO_TIMELAPSE_WITH_MACRO`
- `VSTAB_IHC_LOW_LIGHT_LUX` (value="9000")
- `ZOOM_BLENDING_VIDEO`
- `ZOOM_RATIO_CONTROL`
- `ZOOM_TELE_EXTRA` (value="6.0")

## IQ asset versus MCF override

`JsonConfig` line 8203 opens plaintext asset `iq_config_` plus `stripVariant(device)` and then `getJSONObject` for that device. For this config the object key is `ctwo`. Top-level IQ sections:

- `auto_slow_capture`
- `lp-star-exp-schedule`
- `lp-star-tele-exp-schedule`
- `lux-idx-to-std-params`
- `panorama`
- `qc_mfnr_settings`
- `scene_selection_advanced_overrides`
- `software_flash`
- `time_estimates`
- `uhdr_settings`
- `video_nv_prompt_lux`
- `zsl_settings`

Scene-selection cameras: `BACK_MAIN`, `BACK_TELE`, `BACK_WIDE`, `FRONT_MAIN`, `default_cam_type`.

Override scene names found under `scene_selection_advanced_overrides`:

- `HAL_FRAME_STACK`
- `HAL_FRAME_STACK_FLASH`
- `MOTION_CAPTURE`
- `RAW_HDR`
- `RAW_HDR_PORTRAIT`
- `RAW_NV_PORTRAIT`
- `RAW_SUPER_NIGHT`
- `RAW_SUPER_NIGHT_DEDICATED`
- `SUPER_RESOLUTION`

Lux sensors: `mot_ov50h`, `mot_s5kjns`, `mot_ov64b`, `mot_s5kjn1`, `mot_s5kjn1_macro`, `mot_depth`, `mot_depth_3x`, `mot_zoom`.

`video_nv_prompt_lux` is show-on 5, show-off 10.

Editing `iq_config_ctwo` (the plaintext asset) changes those IQ tables. That path does not go through `McfUtil.decryptJSonConfig`.

MCF static config is chosen in `McfJsonConfig.getConfiguration` (decision at line 49).

- `Util.TEST_BUILD` (line 70) is true when `Build.TAGS` contains `test-keys`.
- On a test-keys build the override flag is the OR of `Log.isLoggable("mcf.override.config", DEBUG)` and `getInt(persist.camera.mot.mcf_override) == 1` (property line 110).
- The MCF&Algorithm tab shows the literal hint at `SettingsManagerFragment.smali` line 646: `adb shell setprop log.tag.mcf.override.config D`.
- When the flag is true, `McfUtil.readOverrideMcfConfig` lists `Context.getFilesDir()` for files whose names start with `mcf_config_ctwo`, accepts one or two matches, and merges a `mcf_config_base_*_sensor` file from that same directory. A missing file throws `IOException` `"MCF config override file not found"`.
- When the flag is false, `McfUtil.decryptJSonConfig` opens asset `mcf_config_ctwo` (or the India/RAM name from `getFeasibleDeviceName`), decrypts it with Blowfish `DECRYPT_MODE`, and gunzips it. The cipher name is at `McfUtil.smali` line 304. The key literal is at line 307.

`configs/mcf_config_ctwo` is 14240 bytes. `configs/mcf_config_ctwo.decrypted.json` is an analysis copy whose root keys are `ctwo`. The process reads the APK asset, not that configs directory.

`Mcf.doInitByHighPriority` passes the MCF bytes and `readTuningMcfConfig` bytes into `native_init`. `readTuningMcfConfig` returns the UTF-8 bytes of `{}` after checking `TuningProviderHelper.WHITE_LIST`, which is an `EmptySet` in this decompile. Shared preference `MCF_DEBUG_LOGDD_MASK` is passed as the log mask integer.

## Limits

- Tab membership is the static `addSetting` set filtered the way `onBindViewHolder` filters `mSettingsMap`. A branch that skips `addSetting` at runtime will hide that row.
- No manifest receiver and no `LocalBroadcastManager.sendBroadcast` of `com.motorola.camera3.DEBUG` were found, so the helper callbacks have no observed sender that can reach them.
- `readTuningMcfConfig` does not expose the IQ asset. IQ and app features are separate plaintext assets.
