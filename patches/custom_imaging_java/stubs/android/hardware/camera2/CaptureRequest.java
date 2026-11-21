package android.hardware.camera2;

public final class CaptureRequest {
    public static final class Key<T> {}
    public static final Key<Integer> NOISE_REDUCTION_MODE = new Key<>();
    public static final Key<Integer> EDGE_MODE = new Key<>();
    public static final Key<Integer> FLASH_MODE = new Key<>();
    public static final Key<Integer> CONTROL_AE_MODE = new Key<>();
    public static final class Builder {
        public <T> T get(Key<T> key) { return null; }
        public <T> void set(Key<T> key, T value) {}
    }
}
