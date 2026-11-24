# Edge50ultra-Camera-Port

Clean-room APK patcher, **Moto Camera 5 (`10.0.44.42`)** port, **"Fast / Low-AI"** config generator for **Moto Camera 4 (`9.1.22.52`)**, and tuned **GCam BSG 9.7** XML profiles for the **Motorola Edge 50 Ultra (`ctwo`, Snapdragon 8s Gen 3 / `SM8635`)** — designed for **locked-bootloader, non-root Android 17 (`SDK 37`)**.

> **Prebuilt APKs:** Ready-to-install APKs (`MotCamera5-Port-ctwo.apk` and `MotCamera4-Mod.apk`) are hosted on the [**GitHub Releases**](https://github.com/nicosilva1986/Edge50ultra-Camera-Port/releases/latest) page.
>
> **Zero-proprietary-blobs policy:** The Git tree itself contains **only** original Node.js (ESM) tooling, Smali patches, third-party Apache-2.0 `AndroidHiddenApiBypass` Smali, GCam XML configs, and documentation. You can rebuild everything from scratch by supplying your own `MotCamera4.apk` / `MotCamera3AI.apk` (pulled via `adb`) and Qualcomm `MotCamera5` donor APK.

---

## What's Inside

1. **Moto Camera 5 Port (`com.motorola.camera5` `v10.0.44.42`, Mod `v1.9.1`)** — [`scripts/build_motcam5_port.mjs`](scripts/build_motcam5_port.mjs) + [`patches/smali_patches_cam5.json`](patches/smali_patches_cam5.json) + [`patches/custom_imaging_java/`](patches/custom_imaging_java/src/com/motorola/camera/custom/CustomImagingBridge.java)
   - Ports the Qualcomm Moto Camera 5 UI, 2x zoom toggle, `VIDEO_HDR10` (`< 60 fps`), `AI_PERSONAL_COLOR_TONE`, and 10-bit Ultra HDR (`MCF_UHDR_ALG` + `libultrahdr.so`) onto `ctwo` in parallel with stock camera.
   - Applies 62 declarative Smali/XML patches plus a clean-room MIT Java 11 imaging module compiled to `smali_classes2`: fixes `"Use the official app"` (`vendor_ctwo`), fixes the gallery thumbnail `bitmap_view` lock & `exit_on_swipe` trap (`awaitCameraDataReadyForGallery` + `configureGalleryIntent`), migrates `mcf_config_ctwo` (`uljw91D2`) with pinned SM8635 ArcSoft V1 API versions, rescues Hexagon-HTP RAW scenes (`RAW_HDR`/`RAW_SUPER_NIGHT`/`RAW_SUPER_RESOLUTION`/`MOTION_CAPTURE`) to Qualcomm `HAL_FRAME_STACK` when non-root SELinux denies `/dev/adsprpc-smd`, adds a **live GPU Look & Optical Portrait Bokeh drawer** ([`EffectsUiController`](patches/custom_imaging_java/src/com/motorola/camera/custom/EffectsUiController.java) + [`LiveLookPreview`](patches/custom_imaging_java/src/com/motorola/camera/custom/LiveLookPreview.java) + [`PortraitBokeh`](patches/custom_imaging_java/src/com/motorola/camera/custom/PortraitBokeh.java)), **Multi-Frame RAW HDR+/AEB/SR merging** ([`MultiFrameRawEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameRawEngine.java)), **Front CAF tuning** ([`FrontAfHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/FrontAfHelper.java)), **4K60/HFR video bitrate & HDR10 UI sync** ([`VideoConfigHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/VideoConfigHelper.java)), **Compass + Solar Ephemeris HUD & EXIF/telemetry** ([`CompassHudController`](patches/custom_imaging_java/src/com/motorola/camera/custom/CompassHudController.java) + [`TelemetryCollector`](patches/custom_imaging_java/src/com/motorola/camera/custom/TelemetryCollector.java)), clean settings/reset behavior (`!KEEP_LAST_MODE` reset + removal of broken Feedback/Help rows), stamps per-shot EXIF `ImageDescription` & `GPSImgDirection` telemetry (`Edge50Port v1.9.1 ...`), and provides 8 live **Post-processing profiles** (`0`, `10`, `1`–`4`, `8`, `9`) under *Settings → Photos*:
     - **`0` Auto (W/O Stock · Clean HAL + LTM, default):** [`ScenePostProcSelector`](patches/custom_imaging_java/src/com/motorola/camera/custom/ScenePostProcSelector.java) + [`AppleStyleToneEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/AppleStyleToneEngine.java) route `0.5x` UW (`NR_HIGH_QUALITY + EDGE_FAST`), `1x`–`2x` bright daylight (`<= 145 lux`: `NR_HIGH_QUALITY + EDGE_FAST`, `> 145 lux`: `EDGE_OFF`), `3x`–`11.9x` (`NR_HIGH_QUALITY + Edge=OFF`), `12x–29.9x` (`NR_MINIMAL + Edge=FAST`), and `30x+` (`NR_FAST + Edge=OFF`) through `HAL_FRAME_STACK`, plus idempotent single-pass post-processing: a bimodal high-DR gate (`evaluateAutoLtmGate`), a high-key backlit tele subject lift (`evaluateAutoBacklitSubjectGate`, `backlit=1`, `3x+`, `< 180 lux`, ISO `< 800`, lifting dark plumage/shadows with near-neutral cloud protection), an independent clipped-sky gate (`evaluateAutoHighlightGate`, `Y >= 250 >= 0.5%`, `hl=1`), and ISO-guarded 3×3-clamped texture/edge acutance (`zsharp=1`, covering bright `0.5x`–`1x` daylight `<= 145 lux`, `2x–3x` `< 220 lux`, and `6x–30x` `< 240 lux`).
     - **`10` Auto (W/ Stock · Native SuperRes/ISP):** Preserves stock `ctwo` IQ/MCF routing (`SCENE_KEEP`, `NR=-1`, `Edge=-1`, `MFNR=-1`, native `HAL_SUPER_RESOLUTION` at `12x+`, stock JPEG untouched), while rescuing only `/dev/adsprpc-smd`-blocked HTP scenes (`RAW_HDR`, `RAW_SUPER_NIGHT*`, `RAW_SUPER_RESOLUTION`, `MOTION_CAPTURE`) to `HAL_FRAME_STACK + MFNR=1`.
     - **`1..4` Manual ISP / HDR presets:** `Natural ZSL` (`NR=4, Edge=3`), `Minimal ISP` (`NR=3, Edge=0, AIDE=0`), `Detail HDR` (`HAL/RAW MFHDR`, `NR=3, Edge=0`), and `Pure ISP` (`MFNR=0, NR=0, Edge=0, AIDE=0, HDR=0`).
     - **`5..7` Apple Style Photonic Grading (`iPhone Natural`, `iPhone Rich Contrast`, `iPhone Amber`):** [`AppleStyleToneEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/AppleStyleToneEngine.java) executes a perceptual Oklab/OKLCh + 1/8-res separable bilateral guided contrast + chroma-preserving highlight shoulder + highlight-protected luma-only corner vignetting & 4-tap Amber film micro-grain across full-frame-aware 512-row strips in parallel (`LUT_POOL`, single-pass idempotent, full EXIF preserved).
     - **`8` Clean RAW Bayer (DNG -> Clean JPG):** [`CleanBayerRawProcessor`](patches/custom_imaging_java/src/com/motorola/camera/custom/CleanBayerRawProcessor.java) demosaics Pro-mode `RAW10`/`RAW16` buffers (including `OV64B` 16MP `CFA_GBRG` with fixed `Gr`/`Gb` LSC row parity) using a 5×5 Malvar–He–Cutler kernel with per-frame `LensShadingMap` corner compensation (`[0.8x, 8.0x]`), copy-safe 3×3 hot-pixel clamping, ISO-scaled YCbCr chroma smoothing, outlier-gated chromatic-fringe clamping, highlight shoulder headroom (`>= 245` @ unity while keeping `+2 EV` separation `< 255`), ISO-damped directional gradient sharpening, and bounded background export beside each `.dng`.
     - **`9` Disable Post Processing (MCF Off / Direct HAL):** Bypasses Moto MCF (`isMcfSupportedByCurrentCamera = false`), AI scene detect, multi-frame offline reproc, and stock `applyColorTone` while requesting Camera2 single-frame `NR=OFF, Edge=OFF, MFNR=0` directly from Qualcomm HAL.
   - **Known non-root limits:** In-app **Google Lens** (`com.motorola.camera.utility.lens` / Google Search handshake) and stock **Meishe V2 Signature LUTs** (`Failed to check lic`) do not pass OEM/Google caller signature verification on user-signed builds (best fallback for Google Lens is opening the standalone Google Lens app; profiles `5..7` provide the built-in LUT alternative).
2. **Moto Camera 4 Clone — "Fast / Low-AI" (`com.motorola.camera3.mod`)** — [`scripts/build_clone.mjs`](scripts/build_clone.mjs) + [`scripts/generate_mod_configs.mjs`](scripts/generate_mod_configs.mjs)
   - Routes default `hdr_off` / `hdr_auto_off` capture from ArcSoft `RAW_HDR` (which forces `use_zsl: false`) to Qualcomm Spectra ISP **`HAL_FRAME_STACK`** (`use_zsl: true`, `need-to-lock-ae: false`, `shutter_throttle_time` `800/400 -> 150/100 ms`).
   - Disables `ai-scene-detect`, `tetras-raw-sr`, `beauty-shot-fotonation` (`level 0`), and 245 MB startup preload (`fast-init.hold-startup-handle-for-algo`).
   - Bundles all 9 `MotCamera3AI` `.bin` models offline (`LocalAiModelFallback.smali`) and injects `HiddenApiBypass` v6.2 for Android 17 ART hidden-API access without root.
3. **GCam BSG 9.7 (`org.codeaurora.snapcam`) XML Profiles** — [`gcam/`](gcam/README.md)
   - Tuned for `ctwo`'s physical sensors (`OV50H`, `OV64B`, `S5KJN1`, `S5KJNS`) with `camcorder.amethyst=false` fixing Video mode ANR.

---

## Prerequisites

- **Node.js `>= 24.0.0`** (uses `JSON.rawJSON` and native `node:test`)
- **JDK 21+** (`java`, `jshell`)
- **External build JARs** placed in `tools/` (or set `APKTOOL_JAR` / `UBER_APK_SIGNER_JAR`):
  - `tools/apktool3.jar` (Apktool `3.0.3+`)
  - `tools/uber-apk-signer.jar` (`1.3.0+`)

---

## Quick Start

1. **Extract stock files from your Edge 50 Ultra (`adb`):**
   ```bash
   adb pull /product/priv-app/MotCamera4/MotCamera4.apk apks/
   adb pull /product/app/MotCamera3AI/MotCamera3AI.apk apks/
   ```
   Decompile `MotCamera4.apk` into `decompiled/MotCamera4_v3` and copy `assets/*_ctwo` into `configs/`.
2. **Run the unit test suite (runs cleanly with or without extracted blobs):**
   ```bash
   npm test
   ```
3. **Generate "Fast / Low-AI" configs & build `MotCamera4-Mod.apk`:**
   ```bash
   npm run gen:configs
   node scripts/build_clone.mjs \
     --patches patches/smali_patches.json \
     --configs-dir configs_mod \
     --extra-smali patches/hiddenapibypass_smali \
     --extra-smali patches/ai_fallback_smali \
     --bundle-ai-apk apks/MotCamera3AI.apk \
     --merge-arsc-from apks/MotCamera4.apk
   node scripts/verify_apk.mjs --apk dist/MotCamera4-Mod.apk
   ```
4. **Build Moto Camera 5 Port (`MotCamera5-Port-ctwo.apk`):**
   Generate `configs_mod/` first (`npm run gen:configs`) so `HAL_FRAME_STACK` ZSL / MFNR `iq_config_ctwo` tuning is picked up, place a Qualcomm `MotCamera5` donor APK in `apks/MotCamera5_roadstr.apk`, decompile it to `decompiled/MotCamera5_roadstr`, then run:
   ```bash
   npm run gen:configs
   npm run build:cam5
   ```

---

## Documentation

- [Changelog (`v1.7.0` – `v1.9.1`)](CHANGELOG.md)
- [Moto Camera 5 optimization investigation](docs/MOTO_CAMERA_5_INVESTIGATION.md) — startup timings, autofocus comparisons and image processing on the v1.0.0 port
- [Deep Quality & Speed Tuning Guide](docs/QUALITY_AND_SPEED_TUNING.md) (including Pantone validation & `HAL_FRAME_STACK` ZSL analysis)
- [Smali & Clone Isolation Audit](docs/SMALI_AUDIT.md)
- [Developer Menu & Tunable Keys](docs/CAMERA_MOD_FEATURES.md)
- [GCam BSG 9.7 Profiles](gcam/README.md)

## License

[MIT](LICENSE) — see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for Apache-2.0 third-party notices.
