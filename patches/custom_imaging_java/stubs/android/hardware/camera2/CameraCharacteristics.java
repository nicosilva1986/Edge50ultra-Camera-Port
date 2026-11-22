package android.hardware.camera2;

import android.hardware.camera2.params.BlackLevelPattern;
import android.hardware.camera2.params.ColorSpaceTransform;
import java.util.List;

public class CameraCharacteristics {
    public static final class Key<T> {}
    public static final Key<int[]> NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES = new Key<>();
    public static final Key<int[]> EDGE_AVAILABLE_EDGE_MODES = new Key<>();
    public static final Key<Integer> SENSOR_INFO_COLOR_FILTER_ARRANGEMENT = new Key<>();
    public static final Key<BlackLevelPattern> SENSOR_BLACK_LEVEL_PATTERN = new Key<>();
    public static final Key<Integer> SENSOR_INFO_WHITE_LEVEL = new Key<>();
    public static final Key<ColorSpaceTransform> SENSOR_COLOR_TRANSFORM1 = new Key<>();
    public static final Key<float[]> LENS_INFO_AVAILABLE_FOCAL_LENGTHS = new Key<>();
    public <T> T get(Key<T> key) { return null; }
    public List<CaptureRequest.Key<?>> getAvailableCaptureRequestKeys() { return null; }
    public List<CaptureRequest.Key<?>> getAvailableSessionKeys() { return null; }
}
