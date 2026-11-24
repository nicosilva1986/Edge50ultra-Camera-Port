package android.hardware;

import android.os.Handler;
import java.util.List;

public abstract class SensorManager {
    public static final int SENSOR_DELAY_FASTEST = 0;
    public static final int SENSOR_DELAY_GAME = 1;
    public static final int SENSOR_DELAY_UI = 2;
    public static final int SENSOR_DELAY_NORMAL = 3;

    public static final int SENSOR_STATUS_UNRELIABLE = 0;
    public static final int SENSOR_STATUS_ACCURACY_LOW = 1;
    public static final int SENSOR_STATUS_ACCURACY_MEDIUM = 2;
    public static final int SENSOR_STATUS_ACCURACY_HIGH = 3;

    public static final int AXIS_X = 1;
    public static final int AXIS_Y = 2;
    public static final int AXIS_Z = 3;
    public static final int AXIS_MINUS_X = AXIS_X | 0x80;
    public static final int AXIS_MINUS_Y = AXIS_Y | 0x80;
    public static final int AXIS_MINUS_Z = AXIS_Z | 0x80;

    public Sensor getDefaultSensor(int type) { return null; }
    public List<Sensor> getSensorList(int type) { return java.util.Collections.emptyList(); }
    public boolean registerListener(SensorEventListener listener, Sensor sensor, int periodUs) { return false; }
    public boolean registerListener(SensorEventListener listener, Sensor sensor, int periodUs, Handler handler) { return false; }
    public void unregisterListener(SensorEventListener listener) {}

    public static void getRotationMatrixFromVector(float[] R, float[] rotationVector) {}
    public static boolean remapCoordinateSystem(float[] inR, int X, int Y, float[] outR) { return false; }
    public static float[] getOrientation(float[] R, float[] values) { return values; }
}
