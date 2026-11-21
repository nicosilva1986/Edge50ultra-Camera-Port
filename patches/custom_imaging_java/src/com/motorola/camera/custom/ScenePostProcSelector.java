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

    public static final int SCENE_KEEP = 0;
    public static final int SCENE_HAL_FRAME_STACK = 1;
    public static final int SCENE_RAW_HDR = 2;

    public static final int NR_OFF = 0;
    public static final int NR_MINIMAL = 3;
    public static final int NR_ZSL = 4;

    public static final int EDGE_OFF = 0;
    public static final int EDGE_FAST = 1;
    public static final int EDGE_ZSL = 3;

    /** Daylight optical / crop tele starts here. Below this, 1x logic applies. */
    private static final float TELE_ZOOM = 2.95f;
    /** 12x–100x needs multi-frame denoise. Tetras / ArcSoft super-zoom stays off. */
    private static final float EXTREME_ZOOM = 12.0f;
    /** Qualcomm lux index at and above this is the low-light stabilization band. */
    private static final float LOW_LIGHT_LUX = 280.0f;

    private ScenePostProcSelector() {}

    public static boolean isPreservedSceneName(String sceneName) {
        if (sceneName == null || sceneName.isEmpty()) {
            return false;
        }
        return sceneName.contains("FLASH")
                || sceneName.contains("PORTRAIT")
                || sceneName.contains("BOKEH")
                || sceneName.contains("DEPTH")
                || sceneName.contains("NIGHT")
                || sceneName.contains("_SN_")
                || sceneName.contains("LRNV")
                || sceneName.contains("DEDICATED")
                || sceneName.contains("REMOSAIC")
                || sceneName.contains("SUPER_RESOLUTION")
                || sceneName.contains("MOTION");
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                String origSceneName, boolean isFlash) {
        return resolve(profile, zoomRatio, luxIdx, origSceneName, isFlash, false);
    }

    public static int[] resolve(int profile, float zoomRatio, float luxIdx,
                                String origSceneName, boolean isFlash, boolean isUiSpecialMode) {
        if (profile == PROFILE_DISABLE_POST_PROCESSING) {
            // MCF Off / Direct HAL single-frame capture with NR=OFF, Edge=OFF, MFNR=0.
            return pack(SCENE_KEEP, NR_OFF, EDGE_OFF, 0, 0, 0, 0);
        }
        if (isFlash || isUiSpecialMode || isPreservedSceneName(origSceneName)) {
            return hold();
        }
        boolean isHdrScene = origSceneName != null && origSceneName.contains("HDR");
        return resolve(profile, zoomRatio, luxIdx, isHdrScene, false, false);
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

    private static int[] resolveAuto(float zoomRatio, float luxIdx, boolean isHdrScene) {
        if (!Float.isFinite(zoomRatio) || zoomRatio < 0f) {
            zoomRatio = 1f;
        }
        if (!Float.isFinite(luxIdx) || luxIdx < 0f) {
            luxIdx = 50f;
        }
        if (zoomRatio >= EXTREME_ZOOM) {
            return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_FAST, 1, 0, 0, 0);
        }
        // Keep optical/daylight 1x and 3x–11.9x on EDGE_OFF + NR_MINIMAL to avoid CamX +31 luma
        // edge halos on wires/horizon trees while keeping multi-frame HAL_FRAME_STACK stability.
        if (zoomRatio >= TELE_ZOOM && luxIdx < LOW_LIGHT_LUX) {
            return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
        }
        if (luxIdx >= LOW_LIGHT_LUX) {
            int scene = isHdrScene ? SCENE_KEEP : SCENE_HAL_FRAME_STACK;
            return pack(scene, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
        }
        if (isHdrScene) {
            return pack(SCENE_RAW_HDR, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
        }
        return pack(SCENE_HAL_FRAME_STACK, NR_MINIMAL, EDGE_OFF, 1, 0, 0, 0);
    }

    private static int[] hold() {
        return pack(SCENE_KEEP, -1, -1, -1, -1, 0, 0);
    }

    private static int[] pack(int sceneAction, int nrMode, int edgeMode, int enableMfnr,
                              int superZoom, int lutStyle, int rawProcess) {
        return new int[] {sceneAction, nrMode, edgeMode, enableMfnr, superZoom, lutStyle, rawProcess};
    }
}
