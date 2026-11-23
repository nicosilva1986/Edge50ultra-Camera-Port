// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Chooses the capture route and ISP knobs for a post-processing profile.
 * The result is {@code {sceneAction, nrMode, edgeMode, enableMfnr, superZoom, lutStyle, rawProcess}}.
 * Scene actions are {@code 0=KEEP}, {@code 1=HAL_FRAME_STACK}, {@code 2=RAW_HDR}.
 * Noise-reduction and edge values use the Camera2 still-capture codes.
 */
public final class ScenePostProcSelector {
    public static final int PROFILE_AUTO_SCENE_ADAPTIVE = 0;
    public static final int PROFILE_NATURAL_ZSL = 1;
    public static final int PROFILE_MINIMAL_ISP = 2;
    public static final int PROFILE_DETAIL_HDR = 3;
    public static final int PROFILE_PURE_ISP = 4;
    public static final int PROFILE_IPHONE_NATURAL = 5;
    public static final int PROFILE_IPHONE_RICH_CONTRAST = 6;
    public static final int PROFILE_IPHONE_AMBER = 7;
    public static final int PROFILE_CLEAN_RAW_BAYER = 8;
    public static final int PROFILE_DISABLE_POST_PROCESSING = 9;
    public static final int PROFILE_AUTO_STOCK = 10;

    public static final int SCENE_KEEP = 0;
    public static final int SCENE_HAL_FRAME_STACK = 1;
    public static final int SCENE_RAW_HDR = 2;

    public static final int NR_OFF = 0;
    public static final int NR_FAST = 1;
    public static final int NR_HIGH_QUALITY = 2;
    public static final int NR_MINIMAL = 3;
    public static final int NR_ZSL = 4;

    public static final int EDGE_OFF = 0;
    public static final int EDGE_FAST = 1;
    public static final int EDGE_ZSL = 3;

    /** Daylight optical / crop tele starts here. Below this, 1x / UW logic applies. */
    private static final float UW_ZOOM_MAX = 0.95f;
    private static final float WIDE_ISZ_MIN = 1.70f;
    private static final float TELE_ZOOM = 2.95f;
    private static final float TELE_ISZ_MIN = 5.50f;
    private static final float TELE_FALLBACK_MAX = 10.0f;
    /** 12x–100x needs multi-frame denoise. Tetras / ArcSoft super-zoom stays off. */
    private static final float EXTREME_ZOOM = 12.0f;
    /** Lux bands calibrated from OV50H/OV64B/S5KJN1 SM8635 CamX peers. */
    private static final float UW_LOW_LIGHT_LUX = 180.0f;
    private static final float DUSK_HDR_MIN_LUX = 140.0f;
    private static final float TELE_ISZ_MAX_LUX = 260.0f;
    /** Qualcomm lux index at and above this is the low-light stabilization band. */
    private static final float LOW_LIGHT_LUX = 280.0f;
    private static final float WIDE_ISZ_MAX_LUX = 310.0f;
    private static final float QLL_MIN_LUX = 380.0f;
    private static final float TELE_FALLBACK_MAX_LUX = 400.0f;

    private ScenePostProcSelector() {}

    public static boolean isRawHtpSceneName(String sceneName) {
        if (sceneName == null || sceneName.isEmpty()) {
            return false;
        }
        return "RAW_SUPER_NIGHT".equals(sceneName)
                || "RAW_SUPER_NIGHT_DEDICATED".equals(sceneName)
                || "RAW_HDR".equals(sceneName)
                || "RAW_SN_AUTO".equals(sceneName)
                || "RAW_SN_DEDICATED".equals(sceneName)
                || "RAW_SUPER_RESOLUTION".equals(sceneName)
                || "SUPER_RESOLUTION_HDR".equals(sceneName)
                || "MOTION_CAPTURE".equals(sceneName);
    }

    public static boolean isPreservedSceneName(String sceneName) {
        return isPreservedSceneName(sceneName, true, PROFILE_AUTO_STOCK);
    }

    public static boolean isPreservedSceneName(String sceneName, boolean htpAvailable) {
        return isPreservedSceneName(sceneName, htpAvailable, PROFILE_AUTO_STOCK);
    }

    public static boolean isPreservedSceneName(String sceneName, boolean htpAvailable, int profile) {
        if (sceneName == null || sceneName.isEmpty()) {
            return false;
        }
        if (!htpAvailable && isRawHtpSceneName(sceneName)) {
            return false;
        }
        boolean preserveSuperRes = (profile == PROFILE_AUTO_STOCK)
                ? sceneName.contains("SUPER_RESOLUTION")
                : "RAW_SUPER_RESOLUTION".equals(sceneName);
        return preserveSuperRes
                || sceneName.contains("FLASH")
                || sceneName.contains("PORTRAIT")
                || sceneName.contains("BOKEH")
                || sceneName.contains("DEPTH")
                || sceneName.contains("NIGHT")
                || sceneName.contains("_SN_")
                || sceneName.contains("LRNV")
                || sceneName.contains("DEDICATED")
                || sceneName.contains("REMOSAIC")
                || sceneName.contains("MOTION");
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                String origSceneName, boolean isFlash) {
        return resolve(profile, zoomRatio, luxIdx, origSceneName, isFlash, false, true);
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                String origSceneName, boolean isFlash, boolean isUiSpecialMode) {
        return resolve(profile, zoomRatio, luxIdx, origSceneName, isFlash, isUiSpecialMode, true);
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                String origSceneName, boolean isFlash, boolean isUiSpecialMode,
                                boolean htpAvailable) {
        int[] ext = resolveExtended(profile, zoomRatio, luxIdx, origSceneName, isFlash, isUiSpecialMode, htpAvailable);
        return new int[] {ext[0], ext[1], ext[2], ext[3], ext[4], ext[5], ext[6]};
    }

    /**
     * Full v1.4.0 policy vector:
     * {sceneAction, nrMode, edgeMode, enableMfnr, superZoom, lutStyle, rawProcess,
     *  iszMode, aideMode, vsrMode, hdrMode, t2wLock, qllMode}.
     */
    public static int[] resolveExtended(int profile, float zoomRatio, float luxIdx,
                                        String origSceneName, boolean isFlash, boolean isUiSpecialMode,
                                        boolean htpAvailable) {
        if (profile == PROFILE_DISABLE_POST_PROCESSING) {
            // MCF Off / Direct HAL single-frame capture with NR=OFF, Edge=OFF, MFNR=0, vendor extras off.
            return packExtended(SCENE_KEEP, NR_OFF, EDGE_OFF, 0, 0, 0, 0,
                    0, 0, 0, 0, -1, 0);
        }
        boolean rescueHtpRaw = !htpAvailable && isRawHtpSceneName(origSceneName);
        if (profile == PROFILE_AUTO_STOCK) {
            if (isFlash || (isUiSpecialMode && !rescueHtpRaw)
                    || isPreservedSceneName(origSceneName, htpAvailable, profile)) {
                return holdExtended();
            }
            if (rescueHtpRaw) {
                return packExtended(SCENE_HAL_FRAME_STACK, -1, -1, 1, -1, 0, 0,
                        -1, -1, -1, -1, -1, -1);
            }
            return holdExtended();
        }
        if (isFlash || (isUiSpecialMode && !rescueHtpRaw)
                || isPreservedSceneName(origSceneName, htpAvailable, profile)) {
            return holdExtended();
        }
        float z = sanitizeZoom(zoomRatio);
        float lux = sanitizeLux(luxIdx);
        boolean isHdrScene = origSceneName != null && origSceneName.contains("HDR");
        int[] base = resolve(profile, z, lux, isHdrScene, false, false);
        if (base[1] == -1 && base[3] == -1) {
            return holdExtended();
        }
        if (!htpAvailable && (base[0] == SCENE_RAW_HDR || (base[0] == SCENE_KEEP && rescueHtpRaw))) {
            // Non-root untrusted_app cannot open /dev/adsprpc-smd signed PD for ArcSoft Turbo HDR/NV;
            // route to HAL_FRAME_STACK so Qualcomm HAL performs hardware multi-frame MFNR instead.
            base[0] = SCENE_HAL_FRAME_STACK;
        }
        if (profile == PROFILE_AUTO_SCENE_ADAPTIVE && rescueHtpRaw && lux >= LOW_LIGHT_LUX) {
            // Rescued dark scenes lack ArcSoft Turbo Fusion RAW NV; use balanced HQ NR + Fast Edge
            // instead of NR_MINIMAL (grainy at ISO 10k) or NR_ZSL (excessive ZSL blur).
            base[1] = NR_HIGH_QUALITY;
            base[2] = EDGE_FAST;
        }

        int isz = -1;
        if (profile == PROFILE_PURE_ISP) {
            isz = 0;
        } else if (profile == PROFILE_AUTO_SCENE_ADAPTIVE
                || profile == PROFILE_DETAIL_HDR
                || (profile >= PROFILE_IPHONE_NATURAL && profile <= PROFILE_IPHONE_AMBER)) {
            if (z >= WIDE_ISZ_MIN && z < TELE_ZOOM) {
                isz = lux < WIDE_ISZ_MAX_LUX ? 1 : 0;
            } else if (z >= TELE_ISZ_MIN && z < EXTREME_ZOOM) {
                isz = lux < TELE_ISZ_MAX_LUX ? 1 : 0;
            }
        }

        int aide = -1;
        if (profile == PROFILE_PURE_ISP || profile == PROFILE_MINIMAL_ISP) {
            aide = 0;
        } else if (profile == PROFILE_AUTO_SCENE_ADAPTIVE) {
            boolean needAide = lux >= LOW_LIGHT_LUX
                    || (z >= TELE_ISZ_MIN && z < EXTREME_ZOOM && lux >= TELE_ISZ_MAX_LUX)
                    || (z >= EXTREME_ZOOM && lux >= 240.0f);
            aide = needAide ? 1 : 0;
        } else if (profile == PROFILE_DETAIL_HDR
                || (profile >= PROFILE_IPHONE_NATURAL && profile <= PROFILE_IPHONE_AMBER)) {
            aide = (lux >= LOW_LIGHT_LUX) ? 1 : 0;
        }

        int vsr = -1;
        if (profile == PROFILE_PURE_ISP || profile == PROFILE_MINIMAL_ISP) {
            vsr = 0;
        } else if ((profile == PROFILE_AUTO_SCENE_ADAPTIVE || profile == PROFILE_DETAIL_HDR
                || (profile >= PROFILE_IPHONE_NATURAL && profile <= PROFILE_IPHONE_AMBER))
                && z >= TELE_ISZ_MIN) {
            vsr = 2;
        }

        int hdr = -1;
        if (profile == PROFILE_PURE_ISP) {
            hdr = 0;
        } else if (profile == PROFILE_DETAIL_HDR) {
            hdr = 2;
        } else if (profile == PROFILE_AUTO_SCENE_ADAPTIVE) {
            if (rescueHtpRaw && "RAW_HDR".equals(origSceneName)) {
                hdr = 2;
            } else if (base[0] == SCENE_RAW_HDR) {
                hdr = 1;
            }
        } else if (profile >= PROFILE_IPHONE_NATURAL && profile <= PROFILE_IPHONE_AMBER) {
            if (base[0] == SCENE_RAW_HDR) {
                hdr = 1;
            }
        }

        int t2wLock = (z >= TELE_ZOOM && z < TELE_FALLBACK_MAX && lux < TELE_FALLBACK_MAX_LUX) ? 1 : -1;
        int qll = -1;
        if (profile == PROFILE_PURE_ISP) {
            qll = 0;
        } else if (profile == PROFILE_AUTO_SCENE_ADAPTIVE && lux >= QLL_MIN_LUX) {
            qll = 1;
        }

        return packExtended(base[0], base[1], base[2], base[3], base[4], base[5], base[6],
                isz, aide, vsr, hdr, t2wLock, qll);
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                boolean isHdrScene, boolean isDedNight, boolean isFlash) {
        if (profile == PROFILE_DISABLE_POST_PROCESSING) {
            return pack(SCENE_KEEP, NR_OFF, EDGE_OFF, 0, 0, 0, 0);
        }
        // Flash and dedicated night own the scene. Do not retarget NR, edge, MFNR, or the LUT.
        if (isFlash || isDedNight) {
            return hold();
        }
        if (profile == PROFILE_AUTO_SCENE_ADAPTIVE) {
            return resolveAuto(zoomRatio, luxIdx, isHdrScene);
        }
        switch (profile) {
            case PROFILE_NATURAL_ZSL:
                return pack(SCENE_HAL_FRAME_STACK, NR_ZSL, EDGE_ZSL, 1, 0, 0, 0);
            case PROFILE_MINIMAL_ISP:
                return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
            case PROFILE_DETAIL_HDR:
                return pack(SCENE_RAW_HDR, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
            case PROFILE_PURE_ISP:
                return pack(SCENE_HAL_FRAME_STACK, NR_OFF, EDGE_OFF, 0, 0, 0, 0);
            case PROFILE_IPHONE_NATURAL:
                return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 1, 0);
            case PROFILE_IPHONE_RICH_CONTRAST:
                return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 2, 0);
            case PROFILE_IPHONE_AMBER:
                return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 3, 0);
            case PROFILE_CLEAN_RAW_BAYER:
                // rawProcess selects the custom Bayer path, so the MCF scene is left alone.
                return pack(SCENE_KEEP, NR_MINIMAL, EDGE_OFF, 1, 0, 1, 1);
            default:
                return hold();
        }
    }

    private static float sanitizeZoom(float zoomRatio) {
        return (!Float.isFinite(zoomRatio) || zoomRatio < 0f) ? 1f : zoomRatio;
    }

    private static float sanitizeLux(float luxIdx) {
        return (!Float.isFinite(luxIdx) || luxIdx < 0f) ? 50f : luxIdx;
    }

    private static int[] resolveAuto(float zoomRatio, float luxIdx, boolean isHdrScene) {
        zoomRatio = sanitizeZoom(zoomRatio);
        luxIdx = sanitizeLux(luxIdx);
        if (zoomRatio >= 30.0f) {
            return pack(SCENE_HAL_FRAME_STACK, NR_FAST, EDGE_OFF, 1, 0, 0, 0);
        }
        if (zoomRatio >= EXTREME_ZOOM) {
            return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_FAST, 1, 0, 0, 0);
        }
        // S5KJN1 ultrawide needs still HQ NR + gentle Fast Edge in bright/dusk bands to preserve
        // fine detail without chroma noise; drop Edge at >= 280 lux to avoid dark-frame halos.
        if (zoomRatio < UW_ZOOM_MAX) {
            int uwEdge = luxIdx < LOW_LIGHT_LUX ? EDGE_FAST : EDGE_OFF;
            return pack(SCENE_HAL_FRAME_STACK, NR_HIGH_QUALITY, uwEdge, 1, 0, 0, 0);
        }
        // Keep optical/daylight 1x and 3x–11.9x on EDGE_OFF + NR_HIGH_QUALITY so hardware still MFNR
        // cleans chroma/luma grain without CamX +31 luma edge halos or Tetras watercolor.
        if (zoomRatio >= TELE_ZOOM && luxIdx < LOW_LIGHT_LUX) {
            return pack(SCENE_HAL_FRAME_STACK, NR_HIGH_QUALITY, EDGE_OFF, 1, 0, 0, 0);
        }
        if (luxIdx >= LOW_LIGHT_LUX) {
            int scene = isHdrScene ? SCENE_KEEP : SCENE_HAL_FRAME_STACK;
            return pack(scene, NR_HIGH_QUALITY, EDGE_OFF, 1, 0, 0, 0);
        }
        if (isHdrScene) {
            return pack(SCENE_RAW_HDR, NR_HIGH_QUALITY, EDGE_OFF, 1, 0, 0, 0);
        }
        return pack(SCENE_HAL_FRAME_STACK, NR_HIGH_QUALITY, EDGE_OFF, 1, 0, 0, 0);
    }

    private static int[] hold() {
        return pack(SCENE_KEEP, -1, -1, -1, -1, 0, 0);
    }

    private static int[] holdExtended() {
        return packExtended(SCENE_KEEP, -1, -1, -1, -1, 0, 0, -1, -1, -1, -1, -1, -1);
    }

    private static int[] pack(int sceneAction, int nrMode, int edgeMode, int enableMfnr,
                              int superZoom, int lutStyle, int rawProcess) {
        return new int[] {sceneAction, nrMode, edgeMode, enableMfnr, superZoom, lutStyle, rawProcess};
    }

    private static int[] packExtended(int sceneAction, int nrMode, int edgeMode, int enableMfnr,
                                      int superZoom, int lutStyle, int rawProcess,
                                      int iszMode, int aideMode, int vsrMode, int hdrMode,
                                      int t2wLock, int qllMode) {
        return new int[] {
            sceneAction, nrMode, edgeMode, enableMfnr, superZoom, lutStyle, rawProcess,
            iszMode, aideMode, vsrMode, hdrMode, t2wLock, qllMode
        };
    }
}
