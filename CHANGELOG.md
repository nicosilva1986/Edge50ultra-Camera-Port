# Changelog — Edge50ultra-Camera-Port (`MotCamera5-Port-ctwo` & `MotCamera4-Mod`)

## v2.0.0 (2026-11-24)
- **Universal ISO 21496-1 Ultra HDR (`Gainmap`) & `Display P3` Wide Gamut:**
  - Added [`UltraHdrSynthesizer`](patches/custom_imaging_java/src/com/motorola/camera/custom/UltraHdrSynthesizer.java) generating clean-room ISO 21496-1 / Android 14–17 `Gainmap` planes directly on `Bitmap` (`libhwui -> libultrahdr` MPF + `hdrgm`), bypassing `McfUltraHDRWrapper` crashes on `HAL_FRAME_STACK` (`0.5x`, `1x`, `2x`, `3x`, `6x`) and attaching true linear-radiance Ultra HDR headroom + `Display P3` wide color gamut on `CleanBayerRawProcessor` `_CLEAN.jpg` exports while preserving EXIF via [`GainmapJpeg`](patches/custom_imaging_java/src/com/motorola/camera/custom/GainmapJpeg.java).
- **Adreno 735 GLES 3.2 Offscreen Compute & Linear-Light Portrait Bokeh:**
  - Added [`GpuComputeContext`](patches/custom_imaging_java/src/com/motorola/camera/custom/GpuComputeContext.java) (thread-local persistent offscreen `EGL14` ES 3.2/3.1 Pbuffer context) and wired `MultiFrameRawEngine.mergeOnCurrentGlContext()` in `CustomImagingBridge` so Adreno 735 SSBO compute shaders accelerate 2×2 Bayer alignment guides.
  - Upgraded [`BokehKernel`](patches/custom_imaging_java/src/com/motorola/camera/custom/BokehKernel.java) and [`OffscreenBokeh`](patches/custom_imaging_java/src/com/motorola/camera/custom/OffscreenBokeh.java) to gather 32 aperture taps in physically linear light with HDR specular highlight expansion, subtle mechanical cat's-eye corner vignetting, full-resolution FBO rendering, and complete VRAM texture/FBO cleanup per shot.
  - Upgraded [`LookOptics`](patches/custom_imaging_java/src/com/motorola/camera/custom/LookOptics.java) and live viewfinder GLSL (`stage_preview_effects.mjs`) to a two-scale optical Highlight Diffusion Filter (HDF) across `Black Pro-Mist`, `CineStill 800T`, and `Ricoh GR Positive`.
- **Hardware Calibration (`ams tcs3408`, IMU Gyro-Seeded Pyramid Alignment, Dynamic Black Level & `ctwo` HAL Keys):**
  - Calibrated [`TelemetryCollector`](patches/custom_imaging_java/src/com/motorola/camera/custom/TelemetryCollector.java) against live `ctwo` `ams AG tcs3408` hardware (`raw[0]` driver Kelvin CCT, `raw[1]` calibrated lux, `raw[2..6]` CRGBW counts, `raw[8]` analog gain, `raw[9]` 100 ms ATIME) and added `interFrameGyroShiftPx` IMU trajectory integration.
  - Upgraded [`MultiFrameRawEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameRawEngine.java) with coarse-to-fine pyramid + IMU gyro-prior registration up to `±48` Bayer pixels, `SENSOR_NOISE_PROFILE` Poisson-Gaussian per-phase variance, `SENSOR_DYNAMIC_BLACK_LEVEL` thermal pedestal tracking, and Wronski-style edge-oriented anisotropic `1.5x` Super-Resolution kernels.
  - Fixed a live `ChiFeature2GraphSelector::SelectFeatureGraphforRequestFromTable` (`0x50` `SIGSEGV`) session crash on `ctwo`: stopped writing `EnableSnapshotOnlyInsensorZoom = 1` alongside stock `RequestBuilderHelper.setInsensorZoomForSession`'s `EnableInsensorZoom = 1` on `MultiCameraSAT` sessions, and added DNG 1.7 mired Dual-Illuminant (`SENSOR_COLOR_TRANSFORM1`/`2`) CCM interpolation in [`CleanBayerRawProcessor`](patches/custom_imaging_java/src/com/motorola/camera/custom/CleanBayerRawProcessor.java).

## v1.9.2 (2026-11-24)
- **Video Quality & CaptureRequest HAL Overhaul:**
  - Fixed `VideoMode.setFps` Qualcomm path (`video_setfps_qualcomm_ae_range`): stopped bypassing `resolveQualcommVideoFpsRange()` on `!isHardwareMtk()`, enforcing fixed `[30, 30]` / `[60, 60]` / `[120, 120]` / `[240, 240]` AE FPS ranges when supported in `CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES` to eliminate low-to-mid-light variable FPS judder.
  - Hooked `VideoMode.setBuilder`, streaming recording requests, and Video Snapshots (`CustomImagingBridge.applyVideoRequestOverrides` / `applyVideoSnapshotOverrides` via [`VideoConfigHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/VideoConfigHelper.java)): forces `EDGE_MODE = OFF (0)` to remove oversharpening halos, selects frame-rate-safe `NOISE_REDUCTION_MODE` (`FAST (1)` at `>= 60 fps` so 60 fps streams never drop frames; `HIGH_QUALITY (2)` at `<= 30 fps`), enables single-camera `LENS_OPTICAL_STABILIZATION_MODE = 1` when unset, holds `CONTROL_AWB_LOCK` for 3 frames across physical camera switches, and probes `enableMCTFwithReferenceFrame` (`Byte.class`) at video session creation when exposed.
- **ISZ Session Preservation & Multi-Frame RAW Sync:**
  - Updated `applySessionParameterOverrides` so `EnableInsensorZoom` stays intact across adaptive photo sessions while safely writing `EnableSnapshotOnlyInsensorZoom` on `0`/`3`/`5`–`7` when supported in `getAvailableSessionKeys()`.
  - Keep `HAL_FRAME_STACK` excluded from stock `uhdr_settings_advanced` (hardware testing confirmed `McfUltraHDRWrapper::process()` segfaults when invoked on non-RAW HAL stack output).
  - Enforced strict `(sessionGeneration, cameraId, SENSOR_TIMESTAMP)` join identity in [`MultiFrameBurstController`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameBurstController.java) with calibrated `focalLengthPx` (`SENSOR_INFO_ACTIVE_ARRAY_SIZE` / `SENSOR_INFO_PHYSICAL_SIZE`), focus-drift (`> 0.15 D` / `LENS_STATE_MOVING`) & gyro rejection, plus residual/`> 30%` failed-tile guards in `MODE_RAW_AEB` & `MODE_SUPER_RES` inside [`MultiFrameRawEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameRawEngine.java).
- **Sky Highlight Protection, Preview Parity, Portrait Bokeh & Scorecard Telemetry:**
  - Refined `AppleStyleToneEngine` sky highlight handling (`evaluateAutoHighlightGate` >= 0.5% `Y >= 250` threshold + bounded bright cyan-to-cobalt sky protection inside the highlight shoulder without shifting neutrals or warm skin) and added matching `u_EffectsShoulder` highlight compression in [`LiveLookPreview`](patches/custom_imaging_java/src/com/motorola/camera/custom/LiveLookPreview.java) + OES/YUV shaders (`stage_preview_effects.mjs`).
  - Smoothed Portrait Bokeh transition ([`BokehKernel`](patches/custom_imaging_java/src/com/motorola/camera/custom/BokehKernel.java), [`OffscreenBokeh`](patches/custom_imaging_java/src/com/motorola/camera/custom/OffscreenBokeh.java), [`PortraitBokeh`](patches/custom_imaging_java/src/com/motorola/camera/custom/PortraitBokeh.java)) with continuous `3/255` CoC deadband, soft foreground depth attenuation, focal/aperture scaling, and extended [`TelemetryCollector`](patches/custom_imaging_java/src/com/motorola/camera/custom/TelemetryCollector.java) EXIF/sidecar fields (`gapMs`, `focusSpreadD`, `motion`, `aeFps`, `ois`, `merge`, `depth`).

## v1.9.1 (2026-11-24)
- **Viewfinder Layout & Filter Polish:**
  - Raised the live **Effects** sheet bottom margin in `Pro` mode (`EffectsUiController.computeBottomMargin`) so it clears the manual control bar and expanded EV/ISO sliders without overlapping touch targets.
  - Added mode re-validation in `EffectsUiController.toggleSelector()` so stale quick-bar icons during mode switches never open Effects inside unsupported modes (`Scanner`, `Slow Motion`).
  - Fixed Look presets at `0%` intensity still suppressing stock `applyColorTone()` (`CustomImagingBridge.shouldSkipStockColorTone`).
  - Automatically cleared any active Motorola Meishe photo filter (`Original`) when selecting a Port Look (`> 0`) to prevent accidental double-LUT stacking, and added TalkBack click toggle + `contentDescription` on **Hold to compare**.
- **Video & Privacy Accuracy:**
  - Hid the `HDR10+` toggle in `ControlPanelHelper` whenever `VIDEO_FRAME_RATE >= 60 fps`, matching `VideoConfigHelper` recording behavior.
  - Made `CompassHudController` and `TelemetryCollector` honor Moto's **Save location** (`com.motorola.camera.geo_location_state`) preference: disabling location stops cached `LocationManager` / solar ephemeris lookups while keeping pure magnetic compass direction (`GPSImgDirectionRef=M`).
  - Deduplicated compass sampling per capture so EXIF and `.telemetry.json` always share a single time-aligned reading.

## v1.9.0 (2026-11-24)
- **Compass, Solar Ephemeris & Physical Outdoor Backlit Disambiguation:**
  - Added [`CompassSolarHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/CompassSolarHelper.java) (Android ENU `TYPE_ROTATION_VECTOR` fusion, offline NOAA/Meeus solar azimuth/elevation, `EV100`, `GPSImgDirection`/`GPSImgDirectionRef` EXIF formatting, and strict `EV100 >= 11.0` + `accuracy >= 2` outdoor backlit gating) and [`CompassHudController`](patches/custom_imaging_java/src/com/motorola/camera/custom/CompassHudController.java) with a lifecycle-safe toggle in **Capture Assistant**.
- **Multi-Frame RAW Merging & Sensor Telemetry:**
  - Added [`MultiFrameRawEngine`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameRawEngine.java) + [`MultiFrameBurstController`](patches/custom_imaging_java/src/com/motorola/camera/custom/MultiFrameBurstController.java) for aligned ZSL/Pro Bayer HDR+, AEB highlight recovery, 1.5x multi-frame SR, macro focus stacking, and thermal step-down.
  - Added [`TelemetryCollector`](patches/custom_imaging_java/src/com/motorola/camera/custom/TelemetryCollector.java) logging high-rate IMU (gyro excursion, accelerometer), spectral RGB/ALS/ToF, thermal zones, Camera2 tags, and compass state into readable `Documents/Edge50Telemetry/*.telemetry.json` sidecars.
- **Front Camera AF & Video Bitrate:**
  - Added [`FrontAfHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/FrontAfHelper.java) extending `FRONT_MAIN` CAF convergence window to a 12-frame budget without affecting rear zero-timeout AF.
  - Added [`VideoConfigHelper`](patches/custom_imaging_java/src/com/motorola/camera/custom/VideoConfigHelper.java) scaling H.264/HEVC bitrates cleanly up to `4K60` / `HFR` and disabling HDR10 above `60 fps` cleanly.
- **Settings & Reset Cleanup:**
  - Removed non-functional OEM `Camera feedback` and `Help` entries from `settings_list_root_preferences.xml`.
  - Fixed lingering zoom, mode, Meishe video effects, and custom Effects presets/Bokeh remaining active when **Keep last mode** (`KEEP_LAST_MODE`) is OFF or on **Reset**.

## v1.8.0 (2026-11-22)
- **Live GPU Effects Drawer & Portrait Bokeh Separation:**
  - Replaced non-functional Google Lens shortcut with [`EffectsUiController`](patches/custom_imaging_java/src/com/motorola/camera/custom/EffectsUiController.java) + [`LiveLookPreview`](patches/custom_imaging_java/src/com/motorola/camera/custom/LiveLookPreview.java) OpenGL 3D `.clut` preview shaders across **Optical** (`Leica`, `Zeiss`), **HDR+** (`Google HDR+`), and **Film** (`Black Pro-Mist`, `CineStill 800T`, `Fujifilm`, `Kodak Portra`, `Ricoh GR`, `Y2K CCD`).
  - Separated **Bokeh Lens** (`Biotar Swirl`, `Planar`, `Sonnar Creamy`, `Anamorphic Oval`, `Triangular B-Speed`) strictly to **Portrait** mode with depthmap / face / single-cam [`PortraitBokeh`](patches/custom_imaging_java/src/com/motorola/camera/custom/PortraitBokeh.java) rendering and routed both rear and front `single_bokeh` cleanly.

## v1.7.0 (2026-11-20)
- Added bright daylight `1x`/`0.5x`/`3x` directional acutance, high-key `6x` backlit shadow lift (`evalAutoBacklitSubjectGate`), and clean-room port improvements.
