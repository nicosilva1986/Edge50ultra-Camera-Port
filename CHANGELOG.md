# Changelog — Edge50ultra-Camera-Port (`MotCamera5-Port-ctwo` & `MotCamera4-Mod`)

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
