# Moto Camera 5 optimization investigation

The tested baseline is the `MotCamera5-Port-ctwo.apk` asset from the [v1.0.0 release](https://github.com/nicosilva1986/Edge50ultra-Camera-Port/releases/tag/v1.0.0), built from [`09b959c`](https://github.com/nicosilva1986/Edge50ultra-Camera-Port/commit/09b959c67faa3887ded1f724f0890a19a88ffa47). The exact APK was verified on a Motorola Edge 50 Ultra (`ctwo`, Snapdragon 8s Gen 3) running Android 17 with a locked bootloader and no root.

| Baseline | Value |
| --- | --- |
| App | `com.motorola.camera5` |
| Version | `10.0.44.42` (`versionCode 10004442`) |
| Release APK SHA-256 | `29ac39b90b286618fa3af428eab34a4f48f9dcfea5c49da4e93abd9eefb3ed7c` |
| Live AF and preview comparisons | Rear Photo at 1×, logical camera 4, active physical camera 2 |
| Final device state | Release APK restored and verified by SHA-256. Camera monitoring was stopped. |

The investigation covered startup, autofocus and image processing. The Camera 4 clone and GCam profiles have their own documentation. [Tuning guide](QUALITY_AND_SPEED_TUNING.md) · [Camera 4 audit](SMALI_AUDIT.md) · [GCam profiles](../gcam/README.md)

## Startup and first preview frame

Android's initial display and the camera's first preview mark different stages. The historical Android launch records contained two cold starts at **335 ms** and **492 ms** to first draw. A live pilot showed **497 ms** to first draw and **1,268 ms** on Motorola's `TOTAL_COLD_O` preview metric. These clocks have different start points. [Android startup metrics](https://developer.android.com/topic/performance/issues/launch-time)

Five further process-cold launches of the release APK gave the following timings. The app reported a fresh preview event for each launch.

| Metric | Median | Range |
| --- | ---: | ---: |
| Android initial display | 359 ms | 351–382 ms |
| Motorola first preview, `TOTAL_COLD_O` | 763 ms | 727–850 ms |
| HAL camera open | 24 ms | 18–34 ms |
| HAL session creation | 311 ms | 308–350 ms |
| HAL repeating request to first frame | 140 ms | 123–198 ms |
| AI model load, three observed launches | 11 ms | 10–11 ms |

The largest measured interval was session creation. In the port, the camera calls `createCaptureSession` and measures the wait for the session callback. The release enables `APP_ACCELERATE`, which can skip the explicit session-key query on the applicable Photo path and enables `SET_EXTRA_FREE_REPEATEDLY=10000`. The latter is a memory-policy feature, with its own runtime guards. All eight MCF startup hold lists are empty in this APK. [Release builder](../scripts/build_motcam5_port.mjs)

The source inspection identified several follow-up hypotheses.

- `McfInitRunnable` starts AI model loading on a separate thread when supported. The branch that waits on MCF calls `Mcf.isInitialized(true)` before emitting `MCF_INIT_COMPLETE`. Its callback lives in `TextureManager`, but the wait is an MCF initialization step. The startup path does not join the AI worker in the inspected branch. The measured 10–11 ms AI interval gives little reason to defer that worker on this build.
- The Camera 4 clone bundles an offline AI model fallback. The Camera 5 port has a separate provider path, and the verified APK contains no bundled models under `assets/ai_models`. A provider-access or startup improvement from porting the fallback remains unverified.
- The on-demand hold lists retain ArcSoft RAW HDR and RAW NV across eight slots, with portrait entries on two slots. Static membership leaves their contribution to session latency unresolved. The verified device asset has 35 input buffers and four output buffers. The proposed reduction to 25 input buffers remains untested. The `killApps` path runs through an executor, and the inspected calibration iterator advances. Buffer counts, memory handling and caching would each need a separate timing and capture regression test.

### Startup experiments

For the A/B runs, each timed block used five launches with new app processes after excluding an initial warmup. Values are median times on the Motorola first-preview marker.

| Change tested | Original before | Variant | Original restored | Finding |
| --- | ---: | ---: | ---: | --- |
| Android ART `speed` instead of `verify` | 638 ms | 682 / 674 ms | 667 ms | Both comparisons were slower, by 44 ms and 7 ms. The original ART filter was restored. |
| `hq-preview=false` for `BACK_MAIN` and `ZOOM_BLENDING` | 667 ms | 674 / 664 ms | 634 ms | The requested and reported edge and noise reduction modes changed from `HIGH_QUALITY` to `ZERO_SHUTTER_LAG` at 1×. The timings showed no consistent startup gain. |

Android exposes the per-package `verify` and `speed` filters through ART compilation controls. [ART compilation](https://source.android.com/docs/core/runtime/jit-compiler)

The preview experiment reused the final original ART block as its before control. The variant changed one APK payload, `assets/config_device_ctwo`, and its signing certificate matched the release. The camera reported `ZERO_SHUTTER_LAG` in practice, which supersedes the initial prediction of `FAST`. This result covers preview requests, with image quality still untested. [Camera2 noise reduction modes](https://developer.android.com/reference/android/hardware/camera2/CameraMetadata#NOISE_REDUCTION_MODE_ZERO_SHUTTER_LAG)

A small same-phone control with the factory Camera 4 app gave median preview times of **656 ms** for Camera 4 and **688 ms** for the Camera 5 port, from three timed starts each. Session creation medians were **324 ms** and **328 ms**. This describes the two app configurations on one phone.

## Autofocus and lens position

Each of four recorded 1× cold starts produced a first result of **0.08873902 diopters**, practically the same as the HAL's advertised **0.08873877 D** hyperfocal distance. The lens reported `MOVING` in this series. The first request carried `CONTINUOUS_PICTURE` and `8.33333302 D`. In ordinary Photo, the app uses `TEMPLATE_PREVIEW` and sets the AF mode. An explicit write of the focus distance in this path was not found. The requested distance is consistent with a preview template value. [Camera2 request templates](https://developer.android.com/reference/android/hardware/camera2/CameraDevice#TEMPLATE_PREVIEW)

| Optical and diagnostic quantity | Finding |
| --- | --- |
| Camera2 `0 D` | Optical infinity |
| Main lens hyperfocal distance | About 11.3 m with approximate calibration |
| Closest nominal manual request, `8.33 D` | About 12 cm with approximate calibration. This is the bound exposed for manual focus requests. |
| Motorola `com.lenovo.moto.envinfo.lens_pos` | The first result on one probe reported `901`. It is a vendor result value. Its units, infinity code and actuator home position are unverified. |
| AF convergence after first camera result | 302, 303 and 878 ms in three timed cold starts with the same reported initial distance |

Camera2 describes the optical distance in diopters for approximately calibrated devices. Other physical modules expose different optical limits. The historical HAL characteristics identify physical camera 3 as ultrawide (1.826 mm, hyperfocal 0.768 D, closest nominal manual request 40 D) and physical camera 5 as telephoto (13.3 mm, 0.019 D and 4 D). Manual focus can request a distance with AF off. Ordinary Photo leaves the continuous AF search and physical actuator control to the HAL. [Focus-distance calibration](https://developer.android.com/reference/android/hardware/camera2/CameraCharacteristics#LENS_INFO_FOCUS_DISTANCE_CALIBRATION) · [Manual focus control](https://developer.android.com/reference/android/hardware/camera2/CaptureRequest#LENS_FOCUS_DISTANCE)

The stable opening position supports keeping the existing continuous-AF startup for general use. Any scene-specific manual pre-position would need to improve total time to stable focus, including the extra move and transition back to AF. The data support testing the app's touch sequence first.

### Touch-to-focus timing and variants

In the first complete eight-tap baseline, the camera reported fresh `PASSIVE_FOCUSED` on every tap. The median from the weighted region request to that result was **556 ms** (525–611 ms). The app took a median of about **265 ms** to send the return to continuous AF, and the median from the reported scan state to focus was **167 ms**. One earlier interrupted trace showed the app clearing the region before focus. The clear did not recur in the eight-tap baseline.

The port's Lib3A single-tap path applies weighted AF and AE regions in `AUTO`, then transitions back to `CONTINUOUS_PICTURE` on `SET_REPEATING_COMPLETE`. In the release, the one-shot repeating request listener emits that event after the first complete result. The baseline handoff takes about seven to eight frames at the observed frame rate.

Two lab variants were independently assembled, signed with the matching certificate and checked against the baseline. An independent comparison of 51,701 methods found one changed method per variant in `classes.dex` (`SetRepeatingRequestListenerExt.onCaptureStarted` for B1 and `RoiStates.configure` for B2). All 3,633 other non-signature APK payloads matched. The variants were installed one at a time with the original restored between comparisons.

1. **B1, confirm at the first exposure.** In the one-shot listener, acknowledge the first `onCaptureStarted` only for the single-tap `AUTO` request in the Lib3A 1 path with an open session. This moves the second request earlier while preserving the weighted regions in the measured flows.
2. **B2, keep continuous AF when setting the region.** Change the single-tap ROI builder's flag so the first request can retain the current AF mode. The original completion transition stays in place. The HAL must still run a fresh scan on the new region for a tap to count as a success.

Each A/B/A block used eight alternating taps, four per target. The two targets had distinct reported focus distances. The active lens and weighted regions were verified in the trace. A success required a fresh scan and focused result, with the lens stationary within the same tap.

| B1 comparison | Original before | Early confirmation | Original restored |
| --- | ---: | ---: | ---: |
| Region request to continuous AF request | 268 ms | **199 ms** | 266 ms |
| Near target, region request to focus | 907 ms | 841 ms | 821 ms |
| Farther target, region request to focus | 648 ms | **595 ms** | 680 ms |
| Fresh focus with stationary lens | 8/8 | 8/8 | 8/8 |

B1 reduced the handoff by about **68 ms** (six frames rather than the usual eight). The farther target reached reported focus **52–85 ms earlier** than both original runs. Its reported focus-distance range matched the restored control. The first original block contained a change in the reported endpoints. The near target varied between controls. A separate rapid double-tap test honored the last target and reached stationary focus in **4/4 pairs** in each original block and with B1.

B2 reached stationary focus in eight of eight taps. The first near tap took **492 ms** and began scanning after two frames. The remaining seven taps began scanning after eight frames, including cases where the request retained continuous AF. The near-target medians were **821 / 990 / 1,007 ms** (original / B2 / restored original). The farther-target medians were **680 / 648 / 678 ms**. The first-tap behavior did not generalize. B1 is the stronger candidate.

### Reopening and failure handling

An additional Back → reopen → tap test brought back the preview in **two of two** runs with B1 and **four of four** original runs. Within the observation window (about 2.4 s), focus was reported after reopening in **one of two** B1 runs and **four of four** original runs. In the other B1 run, the HAL was still scanning. One run per APK clearly captured leaving after the continuous-AF request and before focus. The scene was uncontrolled and the sample is small.

B1 consumes the one-shot confirmation and clears the associated error callback on `onCaptureStarted`. Camera2 can report a failure after exposure starts. That later failure would enter a different recovery branch than in the release. A revision should preserve failure handling for the first complete result, scope completion to the correct session and request, and account for it once. Back and reopen tests exercise an ordinary lifecycle transition. A deterministic hardware failure after `onCaptureStarted` was not exercised. [Camera2 capture callbacks](https://developer.android.com/reference/android/hardware/camera2/CameraCaptureSession.CaptureCallback)

### Further AF hypotheses

- `3a-timeout-frames=0` appears in the device configuration and donor. A counted no-flash lock path can time out on its first counted frame. Flash uses a separate time-based path, and one lock type uses a fixed frame budget. The `FocusComponent` threshold above nine frames controls a UI message. The live tap results support keeping the global value pending a reproduction in the shutter or lock path.
- The released app features include a touch-region factor of 0.143. The minimum region floor feeds both exposure and autofocus. Reducing it needs a matched near/far experiment that checks both outputs. The neighboring motion and timeout reset paths also need separate evidence before a change.
- A missing zoom-blending sensor name in the MCF map has a camera-ID fallback. Any change to focus capability mapping needs a live result by sensor. The passive-focus reuse path also checks capability, shot type, expected flash and scene-specific lock requirements. Photo and video focus tracking have separate guards. The release config includes `VIDEO_FOCUS_TRACKING_AUTO_MODE` and omits `VIDEO_FOCUS_TRACKING`. Their speed and accuracy effects remain unmeasured.
- The app can choose focus mode, regions, trigger and cancel policy, and manual distance. Available evidence does not expose writable actuator coordinates, laser/PDAF tuning, or a replacement for the HAL's focus search.

## Image processing and settings

The tested configuration's ordinary Photo scene overrides route `hdr_off` and `hdr_auto_off` to `HAL_FRAME_STACK` and `hdr_auto_on` to `RAW_HDR`. The effective selection still depends on the sensor, scene and active mode. The default camera map includes a combined HDR and night-vision route. Telephoto can select RAW super-night or super-resolution routes at different light and zoom levels. The builder can source generated IQ input or fall back to stock IQ, so these routes describe the verified APK. [Release builder](../scripts/build_motcam5_port.mjs)

| Area | Source and asset findings |
| --- | --- |
| `HAL_FRAME_STACK` | The release map includes purple-fringe processing, ArcSoft distortion correction, `MCF_UHDR_ALG`, and Meishe NV effects. The release sets one required frame and disables the HAL frame stack's pre-capture AE-lock flag on eight slots. |
| `RAW_HDR` and ArcSoft RAW NV | The maps retain additional vendor processing entries, including Tetras SensePR and FotoNation. The inspected asset disables SensePR, Tetras RAW SR, AI scene detection and FotoNation beauty across its eight imager slots. Map membership describes availability within a route. Actual execution still needs capture evidence. |
| Noise reduction and sharpening | Camera2 request builders set edge and noise reduction modes, with scene overrides. The HAL frame-stack configuration carries no standalone edge or noise-reduction mode field in the inspected APK. The device configuration has custom noise reduction enabled. The preview experiment proved a request/result mode change on the tested main lens. It did not measure still-image noise or detail. |
| Ultra HDR | The builder already wires `MCF_UHDR_ALG` into the RAW HDR, RAW super-resolution, ArcSoft RAW NV and HAL frame-stack maps and supplies gain-map configuration. Encoded gain-map output still needs to be checked on a captured file. |
| App profiles | The existing image preferences (Natural, Enhanced and supported color styles) influence rendering. The HDR control selects an HDR policy that can change route selection. The investigation did not find a verified camera setting that replaces the full MCF engine. A profile switch would need to change a known route or supported control and preserve fallback behavior. |

The verified IQ default enables ZSL at a light metric of 4 or above and disables it below that value. The RAW HDR override disables ZSL. The IQ config sets MFNR shutter throttles to 150/100 ms. The darkest configured RAW HDR bracket remains `-24.0` across eight slots. A change to `-26.0` was a proposal. End-to-end shutter latency and highlight headroom still need capture tests.

The native inspection inventoried the MCF JNI library and its exports and initializers. HAL-backed paths rely on the installed Qualcomm camera stack and its device calibration. App-side alternatives include adjusting an existing MCF profile and using supported Camera2 controls. Replacing the vendor engine, tuning native sharpening or denoising globally, and changing sensor calibration were not implemented or validated. The release builder retains the Photo and Motion Capture HAL ZSL configuration and the listed video and color feature flags. The related color, Pantone and vendor licensing findings remain in the [tuning guide](QUALITY_AND_SPEED_TUNING.md).

### Optical validation

A local JPEG analyzer was prepared for matched text crops at two distances, grouped by lighting. The synthetic controls detected known blur, recovered a 9-pixel translation within one pixel, rejected a different image, and flagged an ISO difference of two stops. This verifies the analysis method on controls. The two-distance, good-light and low-light camera capture comparison still needs a fixed physical scene. There are no device JPEG results for B1's sharpness, exposure, noise, gain maps or capture success.

## Reproducing the measurements

1. Verify the installed APK hash, app version, physical lens and zoom. Use the same phone, scene and mode for the original and candidate. Keep release and variant artifacts separate.
2. Measure each process-cold launch with `am start -S -W` for Android's initial draw. Record the first-preview event from `CameraPreview` with the temporary `log.tag.CameraKpiTag` diagnostic setting. Restore the prior setting after sampling. Keep warm and cold samples separate.
3. Use `cmd media.camera watch` with a package filter for capture requests and results. Record weighted regions, AF mode, AF state, lens state, physical ID and focus distance. Stop monitoring after the run. A previously focused state cannot establish a new tap's success. [CameraService diagnostics](https://source.android.com/docs/core/camera/debugging)
4. Compare original, candidate and restored original with the same target order and observation window. Separate the time to request continuous AF from the total time to focus. Report failures and the final reported distance per target. Confirm optical results with matched captures before drawing conclusions about sharpness.
5. Restore and hash-verify the original APK. Keep decoded artifacts, complete logs, photos and transport details in the local test environment.

B1 produced a repeatable reduction in the app's AF handoff and a measured benefit on the farther target.

---

## Integrated `v1.1.0` Release Verification (`eeb39291...`)

All startup, Touch-AF, live profile-switching, and zoom-watercolor fixes were integrated into [`patches/smali_patches_cam5.json`](../patches/smali_patches_cam5.json) (17 patches) and [`scripts/build_motcam5_port.mjs`](../scripts/build_motcam5_port.mjs), built cleanly with `configs_mod/iq_config_ctwo`, and verified live on `ctwo`:

- **Final APK SHA-256 (`MotCamera5-Port-ctwo.apk`):** `eeb39291c7b0a5700c1454d5720421d2cd301b8178950a48c564fd105550f8b2` (`369,257,026` bytes)
- **Cold-start & IPC cleanup (`verify-final.mjs`, `arm64 [status=verify]`, `n=3` settled after trial 0):** `0` `ACCESS_CHECKIN` `SecurityException` errors and `0` `McfEngine`/fatal errors (`killApps` & `Mcf$9` Checkin IPC skipped via `if-nez p0`; `SET_EXTRA_FREE_REPEATEDLY` omitted; `hq-preview: false` on `BACK_MAIN`, `BACK_TELE`, `ZOOM_BLENDING`). Settled cold starts: `TOTAL_COLD_O` **703–760 ms** (trial 0: `793 ms`), `HAL_CREATE_SESSION` **309–351 ms**, `HAL_SET_REPEATING_TO_FIRST_FRAME` **111–136 ms**, `FSM_IDLE` **803–884 ms**.
- **Hardened Touch-AF (`af_early_ack_*`):** Keeps `mOneShot` true until `onCaptureCompleted` (preserving frame-1 `onCaptureFailed` error callbacks) while dispatching `sendComplete` once on `onCaptureStarted` (`ROI_SINGLE_TAP_SET`, `AF_MODE=1`, 3A `1`). Measured `4/4` taps at **6 frames (`332.3 ms` handoff, `498.8 ms` to `PASSIVE_FOCUSED`, `STATIONARY`)** in the final APK (and `8/8` stationary + `4/4` double-tap bursts + `2/2` lifecycle reopen cycles in `HardenedB1`).
- **Live Post-Processing Profile switcher (`DisableAppearanceListPreference`, same PID without restart):**
  - `0`: **Standard (`Moto MCF`)** — `HAL_FRAME_STACK`, `NR=HIGH_QUALITY`, `Edge=HIGH_QUALITY`
  - `1`: **Natural ZSL (`NR ZSL / Edge ZSL`)** — `HAL_FRAME_STACK`, `NR=ZERO_SHUTTER_LAG`, `Edge=ZERO_SHUTTER_LAG`
  - `2`: **Minimal ISP (`NR Minimal / Edge Off`)** — `HAL_FRAME_STACK`, `NR=MINIMAL`, `Edge=OFF`
  - `3`: **Detail HDR (`RAW HDR / Low Halo`)** — `RAW_HDR`, `NR=MINIMAL`, `Edge=FAST`
- **Zoom Watercolor Mitigation (live `2x / 3x / 6x` + `0.5x` check on `ctwo`):**
  - Extended `iq_override_profile_scene` so Profiles `1`/`2` route `RAW_HDR`, `SUPER_RESOLUTION`, `SUPER_RESOLUTION_HDR`, `RAW_SUPER_RESOLUTION`, and auto `RAW_SUPER_NIGHT` (preserving dedicated `RAW_SUPER_NIGHT_DEDICATED`) to `HAL_FRAME_STACK`; gated `CONTROL_SUPER_ZOOM_KEY = 0` in Profiles `1`/`2`; disabled `state-machine.raw-super-resolution`, `state-machine.hal-super-resolution`, `scene-classifer.super-resolution` (+ `need-edge-nr-on-preview`), raised `arcsoft-tf-drsd` `super-resolution` `zoom-thresh-in` to `999`, added daylight lux gating `[200, 230]` on `BACK_MAIN` `2x` ISZ, and retained `arcsoft-offline-postproc` so `RAW_HDR` Stage-2 JPEG encoding completes reliably.
  - Matched `3x` tele captures (`13.3 mm`, `f/2.4`, ISO `~1463–1575`): Profile `1` (`Natural ZSL`, `471 ms` vs `809 ms`) and Profile `2` (`Minimal ISP`, `547 ms`) preserved **~5.2× higher fine Laplacian texture** (`roiMeanLapVar` `87.92` / `86.60` vs `16.86`; `3.24 MB` / `3.22 MB` vs `1.93 MB` in `Standard`) without watercolor blotches or edge halos, with `6x` also faster (`481` / `454 ms` vs `670 ms`) and sharper (`roiMeanLapVar` `14.12` / `13.71` vs `10.15`; `~2.31 MB` vs `1.84 MB`).
