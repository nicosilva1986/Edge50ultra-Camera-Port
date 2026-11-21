package android.hardware.camera2;

import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.LensShadingMap;
import android.hardware.camera2.params.RggbChannelVector;

public class CaptureResult {
    public static final class Key<T> {}
    public static final Key<RggbChannelVector> COLOR_CORRECTION_GAINS = new Key<>();
    public static final Key<ColorSpaceTransform> COLOR_CORRECTION_TRANSFORM = new Key<>();
    public static final Key<LensShadingMap> STATISTICS_LENS_SHADING_CORRECTION_MAP = new Key<>();
    public static final Key<Integer> SENSOR_SENSITIVITY = new Key<>();
    public static final Key<Float> LENS_FOCAL_LENGTH = new Key<>();
    public <T> T get(Key<T> key) { return null; }
}
