package android.hardware.camera2;

import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.RggbChannelVector;

public class CaptureResult {
    public static final class Key<T> {}
    public static final Key<RggbChannelVector> COLOR_CORRECTION_GAINS = new Key<>();
    public static final Key<ColorSpaceTransform> COLOR_CORRECTION_TRANSFORM = new Key<>();
    public <T> T get(Key<T> key) { return null; }
}
