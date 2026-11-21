package com.motorola.camera.settings;

import android.hardware.camera2.CameraCharacteristics;

public final class SettingsManager {
    public static CameraType getCurrentCameraType() { return null; }
    public static float getZoomValue(CameraType type) { return 1f; }
    public static CameraCharacteristics getCharacteristics(String cameraId) { return null; }
}
