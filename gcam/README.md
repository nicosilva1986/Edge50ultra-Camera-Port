# GCam BSG 9.7 Profiles for Motorola Edge 50 Ultra (`ctwo`)

These three XML profiles target **BSG `MGC_9.7.047` (`org.codeaurora.snapcam`)** on the Motorola Edge 50 Ultra (`ctwo`, Snapdragon 8s Gen 3 / `SM8635`, non-root).

## Verified `ctwo` Camera2 Sensor Mapping

| Camera ID | Sensor | Lens | CFA | White / Black Level |
|---:|---|---|---|---|
| `1` | `mot_s5kjns` | Front (`3.23mm`, `f/1.9`) | `GBRG` (`2`) | `1023` / `64` |
| `2` | `mot_ov50h` | Main (`6.57mm`, `f/1.6`) | `RGGB` (`0`) | `1023` / `64` |
| `3` | `mot_s5kjn1` | Ultrawide / Macro (`1.826mm`, `f/2.0`) | `GRBG` (`1`) | `1023` / `64` |
| `5` | `mot_ov64b` | Periscope 3x Tele (`13.3mm`, `f/2.4`) | `GBRG` (`2`) | `1023` / `64` |

## Profiles Included

- **`Edge50Ultra_ctwo_Natural.xml`** — Balanced daily driver (`HDR+ Enhanced` / `HDRNet`, natural peaking `1.0`, `satCCT=1.0`, `JPG quality=100`, `RAW10`).
- **`Edge50Ultra_ctwo_ActionFast.xml`** — Reduced frame count and faster shutter priority for moving subjects.
- **`Edge50Ultra_ctwo_NightDetail.xml`** — Higher frame merge count and shadow recovery for low-light scenes.

## Installation

1. Install BSG `MGC_9.7.047_*_snap.apk` (`org.codeaurora.snapcam` — required to expose auxiliary lenses via `persist.vendor.camera.privapp.list=org.codeaurora.snapcam`).
2. Copy the XMLs to `/sdcard/Download/MGC.9.7.047/` (or `/sdcard/Download/GCam/Configs9.7/`).
3. Double-tap next to the shutter button and load your preferred XML.

## Important Fixes & Known Limits

- **4K Video ANR Fix:** All three XMLs set `camcorder.amethyst=false` and `camcorder.amethyst_opt=false`, resolving the deterministic Video-mode ANR on `ctwo`.
- **"Add Me" (`Agrégame` / `cottage`) Blue/Red Tint:** `libgcastartup.so` / ARCore `SharedCamera` expects `NV12` while Qualcomm `SM8635` delivers `NV21` `YUV_420_888` buffers. This is not configurable via XML and is protected inside `libpairipcore.so`.
