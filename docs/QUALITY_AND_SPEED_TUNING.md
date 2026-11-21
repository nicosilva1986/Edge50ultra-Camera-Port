# Deep Quality & Speed Tuning Guide — Edge 50 Ultra (`ctwo`, SM8635)

This document catalogs verified, evidence-backed quality and latency optimizations discovered across `MotCamera5` (`10.0.44.42` / `10.0.47.31`), `MotCamera4` (`9.1.22.52`), and `ctwo`'s live Qualcomm CamX HAL (`SM8635`).

See the [Moto Camera 5 investigation](MOTO_CAMERA_5_INVESTIGATION.md) for the v1.0.0 baseline, measured comparisons and current validation status.

---

## 1. Speed & Shutter Latency Optimizations

### A. Route default capture from ArcSoft `RAW_HDR` to Qualcomm `HAL_FRAME_STACK` (ZSL + Hardware MFNR)
- **Root cause:** In stock `iq_config_ctwo` (`scene_selection_advanced_overrides`), `BACK_MAIN`, `BACK_WIDE`, `BACK_TELE` (`< 12.1x`), and `FRONT_MAIN` unconditionally override `default_mode` to `RAW_HDR`. In `iq_config_ctwo.zsl_settings`, `RAW_HDR` explicitly disables Zero-Shutter-Lag (`"use_zsl": false`), forcing non-ZSL multi-exposure bracketing + `bg-service2` out-of-process ArcSoft fusion on every snap.
- **Optimization:** Split `hdr_default` into `hdr_off` / `hdr_auto_off` -> `HAL_FRAME_STACK` and `hdr_auto_on` -> `RAW_HDR`. `HAL_FRAME_STACK` inherits `zsl_settings.default` (`use_zsl: true` for `lux >= 4`), uses `frames-required: 1` with Qualcomm Spectra hardware MFNR, and cuts synthetic ArcSoft/Tetras sharpening.

### B. Disable pre-capture AE lock in `HAL_FRAME_STACK`
- **Root cause:** `ctwo` stock `mcf_config_ctwo` sets `state-machine.hal-frame-stack.need-to-lock-ae` to `true` on all 8 imagers, adding an AE-convergence wait cycle before capture.
- **Improvement:** `MotCamera5` (`roadstr` `10.0.44.42`) sets `"need-to-lock-ae": false` across all imagers. Mirroring `false` in `ctwo` removes pre-shutter AE-lock stalls in `HAL_FRAME_STACK`.

### C. Lower `qc_mfnr_settings` shutter throttle & startup algorithm preload
- **Root cause:** `iq_config_ctwo.qc_mfnr_settings.default` sets `shutter_throttle_time` to `800 ms` (row 0, dark) and `400 ms` (rows 1–4, daylight), artificially rate-limiting consecutive captures. Meanwhile, `mcf_config_ctwo.fast-init.hold-startup-handle-for-algo` preloads `MCF_AS_TF_MOTION_CAPTURE_ALG`, `MCF_TETRAS_RAW_SUPER_RESOLUTION_CAPTURE_ALG`, and `MCF_ARCSOFT_TF_REFOCUS_CAPTURE_ALG` on startup.
- **Optimization:** Lower `shutter_throttle_time` (`800 -> 150 ms`, `400 -> 100 ms`), shorten `exposure_schedule_lowlight` hints (`250.0 -> 225.0`, `200.0 -> 185.0`), and clear `hold-startup-handle-for-algo.algorithms` to `[]` per slot.

### D. Session setup and extra memory handling in Moto Camera 5

- `APP_ACCELERATE` lets the applicable Photo setup path skip the explicit `CameraCharacteristics.getAvailableSessionKeys()` query.
- The [Camera 5 builder](../scripts/build_motcam5_port.mjs) adds it alongside `SET_EXTRA_FREE_REPEATEDLY=10000`. The separate contribution of either flag to the measured startup time remains unverified.

---

## 2. Image Quality & Dynamic Range Optimizations

### A. Ultra HDR gain-map routing in Moto Camera 5

- The [Camera 5 builder](../scripts/build_motcam5_port.mjs) supplies the Ultra HDR configuration and adds `MCF_UHDR_ALG` to the RAW HDR, RAW super-resolution, ArcSoft RAW NV and HAL frame-stack maps in the verified APK.
- Output verification requires inspecting a captured image for its encoded gain map and SDR fallback.

### B. Highlight headroom on `RAW_HDR` & `Tetras RAW SR` suppression
- **Highlight protection:** Extending `state-machine.raw-hdr.frame-ev-default[slot][4]` from `-24.0` to `-26.0` on `mot_ov50h` (slot 0), `mot_ov64b` (slot 2), and `mot_s5kjn1` (slot 3) gives the darkest bracket 2 EV-steps more highlight headroom against clipped skies/lamps.
- **Eliminate watercolor artifacts:** Setting `ai-scene-detect.enable = false`, `tetras-raw-sr.enable = false`, `beauty-shot-fotonation.enable = false` (`default-beauty-level = 0`), and stripping `MCF_TETRAS_SENSEPR_CAPTURE_ALG` / `MCF_FOTONATION_BEAUTY_CAPTURE_ALG` / `MCF_ARCSOFT_LL_AI_PORTRAIT_CAPTURE_ALG` from `MCF_HAL_FRAME_STACK_STATE_MACHINE` removes synthetic smoothing and oversharpening.

### C. Enable `MotCamera5` Video & Color Features
- Available in `MotCamera5_roadstr` `app_feature_roadstr` and compatible with `ctwo`'s `P010` / `LEVEL_3` HAL:
  - `VIDEO_HDR10`, `VIDEO_HDR10_WITH_STABILIZATION`, `VIDEO_AUTO_FPS: "6"`, `VIDEO_FILTERS: "1920"`, `VIDEO_RECORDING_KNIFE_SWITCH`, `ZOOM_MAIN_2X`, `PANTONE`, `AI_PERSONAL_COLOR_TONE`, `AI_GROUP_PHOTO`.

### D. Remaining Native Boundaries (Verified)
1. **Meishe V2 License (`I/meicam: Failed to check lic`):** `libNvBeautySdkCoreV2.so` validates the signing certificate against its embedded/asset `.lic` (`22276-1634-518bb786-e8f3-4e4c-8665-d4798ad936ef.lic`). User-signed non-root builds fail this check natively; converting the 15 `.mslut` Signature LUTs to `.cube` for **PhotonCamera** bypasses this completely.
2. **Mcf `logical_multicam` warning:** Camera 4 reports sensor name `logical_multicam` (`dumpsys media.camera`), which is absent from `ctwo.imagers` (`mot_zoom` is used instead). Camera 4 still configures 9 streams cleanly via `customized-hal-zsl-on-modes`.

---

## 3. Pantone Validation & Color Style Configuration

- **What lenses are Pantone-validated & where calibration lives:**
  - Motorola markets Edge 50 Ultra (`ctwo`) as Pantone Validated across its rear camera system (`mot_ov50h` main, `mot_ov64b` 3x tele, `mot_s5kjn1` ultrawide).
  - There is **no** Pantone switch, LUT, or calibration toggle in `mcf_config`, `iq_config`, or CamX HAL vendor tags (`device_camera_hal_dump.txt` contains 0 Pantone tags). Color accuracy and SkinTone rendering are baked into the read-only `/vendor` Qualcomm CamX Chromatix / AWB / CCM tuning binaries.
- **What `PANTONE` in `app_feature_ctwo` actually controls:**
  - In `MotCamera4` (`9.1.22.52`), the `PANTONE` feature flag does not exist (`DISPLAY_CUTOUT_PANTONE` only controls a screen cutout animation).
  - In `MotCamera5` (`10.0.44.42`), `AppFeatures$Feature.PANTONE` sets `FeaturesUtil.SUPPORT_PANTONE`. In `IndicatorBarComponent.smali:1440,1480` and `IndicatorBarComponent$$ExternalSyntheticLambda5.smali:108–167`, it solely displays the **Pantone badge/button** in the top bar on cold start in rear Photo mode when `IMAGE_PREFERENCE_SELECTOR == 0` (**Natural**). Removing `{ "f": "PANTONE" }` hides the UI badge without altering ISP output.
- **What IS user-configurable:**
  - **`Image Preference Selector` (`SettingsManager.IMAGE_PREFERENCE_SELECTOR`)**: switches between **Natural (`0`)** (true-to-life / Pantone-faithful base rendering), **Enhanced (`1`)** (`AutoEnhanceManager` vivid/bright boost), and **Signature Style / AI Personal Color Tone** (`AI_PERSONAL_COLOR_TONE`). Keeping **Natural** with our `HAL_FRAME_STACK` clean profile (`ai-scene-detect=false`, `beauty-shot-fotonation=false`) preserves the cleanest un-cooked Pantone/Chromatix rendering.
