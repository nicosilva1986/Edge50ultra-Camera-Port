# Edge50ultra-Camera-Port

Clean-room APK patcher, **Moto Camera 5 (`10.0.44.42`)** port, **"Fast / Low-AI"** config generator for **Moto Camera 4 (`9.1.22.52`)**, and tuned **GCam BSG 9.7** XML profiles for the **Motorola Edge 50 Ultra (`ctwo`, Snapdragon 8s Gen 3 / `SM8635`)** — designed for **locked-bootloader, non-root Android 17 (`SDK 37`)**.

> **Prebuilt APKs:** Ready-to-install APKs (`MotCamera5-Port-ctwo.apk` and `MotCamera4-Mod.apk`) are hosted on the [**GitHub Releases**](https://github.com/nicosilva1986/Edge50ultra-Camera-Port/releases/latest) page.
>
> **Zero-proprietary-blobs policy:** The Git tree itself contains **only** original Node.js (ESM) tooling, Smali patches, third-party Apache-2.0 `AndroidHiddenApiBypass` Smali, GCam XML configs, and documentation. You can rebuild everything from scratch by supplying your own `MotCamera4.apk` / `MotCamera3AI.apk` (pulled via `adb`) and Qualcomm `MotCamera5` donor APK.

---

## What's Inside

1. **Moto Camera 5 Port (`com.motorola.camera5` `v10.0.44.42`)** — [`scripts/build_motcam5_port.mjs`](scripts/build_motcam5_port.mjs)
   - Ports the 2026 Qualcomm Moto Camera 5 UI, 2x zoom toggle, `VIDEO_HDR10`, `AI_PERSONAL_COLOR_TONE`, and 10-bit Ultra HDR (`MCF_UHDR_ALG` + `libultrahdr.so`) onto `ctwo` in parallel with stock camera.
   - Fixes the `"Use the official app"` modal (`vendor_ctwo` in `com.android.dynamic.apk.fused.modules`), migrates `mcf_config_ctwo` to Camera 5's Blowfish key (`"uljw91D2"`) & JSON schema, enables `customized-hal-zsl-on-modes` (`["MODE_PHOTO", "MODE_MOTION_CAPTURE"]`) to fix black Photo viewfinder (`ILLEGAL_ARGUMENT`), routes Google Lens through `com.google.ar.lens` (`LensLauncherActivity`) to bypass debug-signature caller rejection, and merges `0x81` `feature_adobe_scan` resources.
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
   Place a Qualcomm `MotCamera5` donor APK in `apks/MotCamera5_roadstr.apk` and decompile it to `decompiled/MotCamera5_roadstr`, then run:
   ```bash
   npm run build:cam5
   ```

---

## Documentation

- [Moto Camera 5 optimization investigation](docs/MOTO_CAMERA_5_INVESTIGATION.md) — startup timings, autofocus comparisons and image processing on the v1.0.0 port
- [Deep Quality & Speed Tuning Guide](docs/QUALITY_AND_SPEED_TUNING.md) (including Pantone validation & `HAL_FRAME_STACK` ZSL analysis)
- [Smali & Clone Isolation Audit](docs/SMALI_AUDIT.md)
- [Developer Menu & Tunable Keys](docs/CAMERA_MOD_FEATURES.md)
- [GCam BSG 9.7 Profiles](gcam/README.md)

## License

[MIT](LICENSE) — see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for Apache-2.0 third-party notices.
