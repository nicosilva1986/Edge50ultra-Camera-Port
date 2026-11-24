package android.hardware;

public class Sensor {
    public static final int TYPE_ALL = -1;
    public static final int TYPE_ACCELEROMETER = 1;
    public static final int TYPE_MAGNETIC_FIELD = 2;
    public static final int TYPE_GYROSCOPE = 4;
    public static final int TYPE_LIGHT = 5;
    public static final int TYPE_ROTATION_VECTOR = 11;
    public static final int TYPE_GEOMAGNETIC_ROTATION_VECTOR = 20;

    public String getName() { return null; }
    public String getStringType() { return null; }
    public int getType() { return 0; }
}
