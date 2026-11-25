package com.motorola.camera.settings;

public final class SettingsHelper {
    public static boolean isContainedInArray(int[] arr, int value) { return false; }
    public static boolean isPortraitMode(int mode) { return mode == 6 || mode == 18; }
    public static boolean isPortraitMode() { return false; }
    public static boolean isSuperNightMode() { return false; }
    public static boolean isPhotoMode() { return false; }
    public static boolean isProPhotoMode() { return false; }
    public static boolean isNightVisionMode() { return false; }
    public static boolean isTenBitVideoMode() { return false; }
    public static boolean isVideoMode() { return false; }
    public static boolean isDualCaptureMode() { return false; }
    public static boolean isDualCaptureVideoMode() { return false; }
    public static boolean isSlowMotionMode() { return false; }
    public static boolean isVideoHDR10Mode() { return false; }
    public static boolean isCurrentFrontCamera() { return false; }
}
