// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Front continuous-picture focus lock for FocusExposureLockRunnable.
 *
 * Rear cameras and every AF mode other than CONTINUOUS_PICTURE (4) are ignored.
 * {@link #shouldComplete} returns false and {@link #noteResult} does not count,
 * so the caller keeps the stock 3A timeout, including a 0-frame timeout.
 * Front CAF completes on PASSIVE_FOCUSED (2), FOCUSED_LOCKED (4), or once
 * {@link #MAX_FRONT_WAIT_FRAMES} results have been counted. Twelve frames is
 * about 400 ms at 30 fps. Call {@link #beginCapture} and {@link #endCapture}
 * around each still so the count does not carry into the next shot.
 */
public final class FrontAfHelper {
    public static final int AF_MODE_CONTINUOUS_PICTURE = 4;
    public static final int AF_STATE_PASSIVE_FOCUSED = 2;
    public static final int AF_STATE_FOCUSED_LOCKED = 4;
    /** About 400 ms of 30 fps preview. */
    public static final int MAX_FRONT_WAIT_FRAMES = 12;

    private static int captureFrames;

    private FrontAfHelper() {}

    public static boolean applies(boolean isFrontMain, int afMode) {
        return isFrontMain && afMode == AF_MODE_CONTINUOUS_PICTURE;
    }

    /**
     * @param frameCount results counted for this still, starting at 1
     * @return true when the front CAF wait should end
     */
    public static boolean shouldComplete(boolean isFrontMain, int afMode, int afState, int frameCount) {
        if (!applies(isFrontMain, afMode)) return false;
        if (afState == AF_STATE_PASSIVE_FOCUSED || afState == AF_STATE_FOCUSED_LOCKED) return true;
        return frameCount >= MAX_FRONT_WAIT_FRAMES;
    }

    public static boolean shouldCompleteCurrent(boolean isFrontMain, int afMode, int afState) {
        return shouldComplete(isFrontMain, afMode, afState, captureFrames);
    }

    public static void beginCapture() {
        captureFrames = 0;
    }

    public static void endCapture() {
        captureFrames = 0;
    }

    /**
     * Counts one front CAF result. Other cameras leave the counter unchanged and return 0.
     */
    public static int noteResult(boolean isFrontMain, int afMode) {
        if (!applies(isFrontMain, afMode)) return 0;
        if (captureFrames < Integer.MAX_VALUE) captureFrames++;
        return captureFrames;
    }

    public static int frameCount() {
        return captureFrames;
    }
}
