// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Bitrate, HDR10, high-speed range, and thermal decisions for the video encoder.
 * Integer fps scale is {@code max(1, upperFps / 30)}, so 31–59 fps stays on the
 * 30 fps rate and 60–89 fps doubles it. Caps sit under the pineapple XML limits
 * (AVC 105 Mbps, HEVC 73.5 Mbps).
 */
public final class VideoConfigHelper {
    public static final int HEVC_MAX_BITRATE = 70_000_000;
    public static final int AVC_MAX_BITRATE = 100_000_000;

    private VideoConfigHelper() {}

    public static int resolveVideoBitrate(int sizeBitrate, int upperFps, boolean isHevc) {
        if (sizeBitrate <= 0) return 0;
        int scale = upperFps / 30;
        if (scale < 1) scale = 1;
        long scaled = (long) sizeBitrate * (long) scale;
        int cap = isHevc ? HEVC_MAX_BITRATE : AVC_MAX_BITRATE;
        if (scaled > cap) return cap;
        return (int) scaled;
    }

    public static boolean shouldDisableHdr10ForFps(int upperFps) {
        return upperFps >= 60;
    }

    /**
     * Prefers a fixed {@code [targetFps, targetFps]} row. Otherwise returns the
     * first variable row whose upper bound is {@code targetFps}. Returns null
     * when no row matches.
     */
    public static int[] pickPreferredHfrRange(int targetFps, int[][] ranges) {
        if (ranges == null) return null;
        int[] variable = null;
        for (int i = 0; i < ranges.length; i++) {
            int[] range = ranges[i];
            if (range == null || range.length < 2 || range[0] > range[1]) continue;
            if (range[0] == targetFps && range[1] == targetFps) {
                return new int[] { targetFps, targetFps };
            }
            if (variable == null && range[1] == targetFps && range[0] < targetFps) {
                variable = new int[] { range[0], range[1] };
            }
        }
        return variable;
    }

    public static boolean shouldThermalStepDownFps(int thermalLevel, int upperFps) {
        return thermalLevel >= 2 && upperFps > 30;
    }
}
