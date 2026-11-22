package android.hardware.camera2;

import java.util.HashMap;
import java.util.Map;

public final class CaptureRequest {
    public static final class Key<T> {
        private final String name;
        private final Class<T> type;

        public Key() {
            this("", null);
        }

        public Key(String name, Class<T> type) {
            this.name = name;
            this.type = type;
        }

        public String getName() {
            return name;
        }

        public Class<T> getType() {
            return type;
        }
    }

    public static final Key<Integer> NOISE_REDUCTION_MODE = new Key<>("android.noiseReduction.mode", Integer.class);
    public static final Key<Integer> EDGE_MODE = new Key<>("android.edge.mode", Integer.class);
    public static final Key<Integer> FLASH_MODE = new Key<>("android.flash.mode", Integer.class);
    public static final Key<Integer> CONTROL_AE_MODE = new Key<>("android.control.aeMode", Integer.class);

    public static final class Builder {
        private final Map<String, Object> values = new HashMap<>();

        @SuppressWarnings("unchecked")
        public <T> T get(Key<T> key) {
            if (key == null) return null;
            return (T) values.get(key.getName());
        }

        public <T> void set(Key<T> key, T value) {
            if (key != null) {
                values.put(key.getName(), value);
            }
        }
    }
}
