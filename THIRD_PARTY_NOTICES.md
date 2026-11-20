# Third-Party Notices

This repository includes third-party open-source components in unmodified or Smali-compiled form:

1. **LSPosed / AndroidHiddenApiBypass** (`patches/hiddenapibypass_smali/`)
   - Upstream: https://github.com/LSPosed/AndroidHiddenApiBypass
   - License: Apache License 2.0
   - Purpose: Exempts hidden Android framework fields (`CaptureRequest.mLogicalCameraSettings`, `CaptureResult.mResults`, `CameraCharacteristics.mProperties`) from ART's Android 17 (`SDK 37`) non-SDK interface restrictions for user-installed camera builds.

2. **Recommended Open-Source Companion / Reference Projects**
   - [bjzhou/PhotonCamera](https://github.com/bjzhou/PhotonCamera) (Apache-2.0) — tested as a zero-OEM-AI RAW10 + HDRNet alternative on `ctwo`.
   - [Apktool](https://github.com/iBotPeaches/Apktool) (Apache-2.0) and [uber-apk-signer](https://github.com/patrickfav/uber-apk-signer) (Apache-2.0) — external build tools required by the user at build time.

This project contains **no** proprietary Motorola, ArcSoft, Tetras, Meishe, FotoNation, or Adobe binaries, APKs, models, or config blobs. Users must supply their own stock/donor APKs extracted from their own devices or trusted sources.
