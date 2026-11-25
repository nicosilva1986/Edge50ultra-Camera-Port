package android.hardware.camera2;

import android.graphics.Rect;
import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.Face;
import android.hardware.camera2.params.LensShadingMap;
import android.hardware.camera2.params.RggbChannelVector;

public class CaptureResult {
    public static final class Key<T> {}
    public static final Key<RggbChannelVector> COLOR_CORRECTION_GAINS = new Key<>();
    public static final Key<ColorSpaceTransform> COLOR_CORRECTION_TRANSFORM = new Key<>();
    public static final Key<LensShadingMap> STATISTICS_LENS_SHADING_CORRECTION_MAP = new Key<>();
    public static final Key<Face[]> STATISTICS_FACES = new Key<>();
    public static final Key<Rect> SCALER_CROP_REGION = new Key<>();
    public static final Key<Integer> SENSOR_SENSITIVITY = new Key<>();
    public static final Key<Float> LENS_APERTURE = new Key<>();
    public static final Key<Float> LENS_FOCAL_LENGTH = new Key<>();
    public static final Key<Integer> CONTROL_AF_MODE = new Key<>();
    public static final Key<Integer> CONTROL_AF_STATE = new Key<>();
    public static final Key<Float> LENS_FOCUS_DISTANCE = new Key<>();
    public static final Key<Integer> LENS_STATE = new Key<>();
    public static final Key<String> LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID = new Key<>();
    public static final Key<Long> SENSOR_TIMESTAMP = new Key<>();
    public static final Key<Long> SENSOR_EXPOSURE_TIME = new Key<>();
    public <T> T get(Key<T> key) { return null; }
}
