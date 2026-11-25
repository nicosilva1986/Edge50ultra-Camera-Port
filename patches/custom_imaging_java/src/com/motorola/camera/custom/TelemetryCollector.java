// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.RggbChannelVector;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.SystemClock;
import android.util.Rational;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.EnumMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/** Shot telemetry for ctwo. Build the JSON while this capture's session is active. */
public final class TelemetryCollector {
    public static final int SCHEMA_VERSION = 1;
    private static final int IMU_PERIOD_US = 2500;
    private static final long SECOND = 1_000_000_000L;
    private static final long MAX_IMU_GAP_NS = 25_000_000L;
    private static final String[] ZONES = {"camera-0", "camera-1", "cam-therm", "msm-therm", "mmi_battery"};
    private static final String[] KEYS = {
        "SENSOR_TIMESTAMP", "SENSOR_EXPOSURE_TIME", "SENSOR_FRAME_DURATION", "SENSOR_SENSITIVITY",
        "SENSOR_ROLLING_SHUTTER_SKEW", "LENS_FOCAL_LENGTH", "LENS_APERTURE", "LENS_FOCUS_DISTANCE",
        "CONTROL_AF_STATE", "CONTROL_AE_STATE", "CONTROL_AWB_STATE", "STATISTICS_SCENE_FLICKER",
        "COLOR_CORRECTION_GAINS", "COLOR_CORRECTION_TRANSFORM"
    };
    private static final String[] EXTRA_DIAG_KEYS = {
        "LENS_OPTICAL_STABILIZATION_MODE", "LENS_STATE", "LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID"
    };
    // Resolve public SDK fields once. The port's existing compile-only CaptureResult stub is partial.
    private static final Map<String, CaptureResult.Key<?>> RESULT_KEYS = resultKeys();
    private static volatile Session active;
    private static long generation;
    private static final Object SIDECAR_MOVE_LOCK = new Object();

    private TelemetryCollector() {}

    /** Indices refer to verified alternate-RGB SensorEvent channels, never to chip register order.
     * Use -1 for absent channels. flickerHz must be a frequency, not a flag word.
     * xyzMatrix maps linear sensor counts to CIE XYZ in row-major order. */
    public static final class SpectralLayout {
        private final int[] channels;
        private final double[] xyzMatrix;

        public SpectralLayout(int red, int green, int blue, int clear, int wideband, int flickerHz,
                              double[] xyzMatrix) {
            channels = new int[]{red, green, blue, clear, wideband, flickerHz};
            boolean[] seen = new boolean[16];
            for (int i : channels) {
                if (i == -1) continue;
                if (i < 0 || i >= seen.length || seen[i]) throw new IllegalArgumentException("channel index");
                seen[i] = true;
            }
            if (xyzMatrix != null && xyzMatrix.length != 9) throw new IllegalArgumentException("XYZ matrix");
            this.xyzMatrix = xyzMatrix == null ? null : xyzMatrix.clone();
        }
    }

    /** Snapshot this identity at request time. Set realtimeClock only for SENSOR_INFO_TIMESTAMP_SOURCE_REALTIME. */
    public static final class ShotMetadata {
        public final String shotId, cameraId, depthSource;
        public final Boolean isFront, motionRejected;
        public final Float iqLuxIdx, gapMs, focusSpreadD;
        public final Integer aeFps, oisMode, mergeCount;
        public final boolean realtimeClock;
        private final long generation;

        private ShotMetadata(String shotId, Float iqLuxIdx, boolean realtimeClock, Session session,
                             Float gapMs, Float focusSpreadD, Boolean motionRejected,
                             Integer aeFps, Integer oisMode, Integer mergeCount, String depthSource) {
            this.shotId = shotId;
            this.iqLuxIdx = iqLuxIdx;
            this.realtimeClock = realtimeClock;
            this.cameraId = session == null ? null : session.cameraId;
            this.isFront = session == null ? null : session.front;
            this.generation = session == null ? 0 : session.id;
            this.gapMs = gapMs;
            this.focusSpreadD = focusSpreadD;
            this.motionRejected = motionRejected;
            this.aeFps = aeFps;
            this.oisMode = oisMode;
            this.mergeCount = mergeCount;
            this.depthSource = depthSource;
        }
    }

    public static ShotMetadata shotMetadata(String shotId, Float iqLuxIdx, boolean realtimeClock) {
        return new ShotMetadata(shotId, iqLuxIdx, realtimeClock, active,
                null, null, null, null, null, null, null);
    }

    public static ShotMetadata shotMetadata(String shotId, Float iqLuxIdx, boolean realtimeClock,
                                            Float gapMs, Float focusSpreadD, Boolean motionRejected,
                                            Integer aeFps, Integer oisMode, Integer mergeCount,
                                            String depthSource) {
        return new ShotMetadata(shotId, iqLuxIdx, realtimeClock, active,
                gapMs, focusSpreadD, motionRejected, aeFps, oisMode, mergeCount, depthSource);
    }

    public static void onCameraActive(Context ctx, String cameraId, boolean isFront) {
        onCameraActive(ctx, cameraId, isFront, null);
    }

    public static synchronized void onCameraActive(Context ctx, String cameraId, boolean isFront, SpectralLayout layout) {
        onCameraPaused();
        if (ctx == null) return;
        SensorManager manager = null;
        try {
            // Public Android Context API, absent from the existing compile stub.
            Method service = Context.class.getMethod("getSystemService", String.class);
            manager = (SensorManager) service.invoke(ctx, "sensor");
        } catch (ReflectiveOperationException | RuntimeException ignored) {}
        Session session = new Session(++generation, ctx, cameraId, isFront, manager, layout);
        try {
            session.start();
            active = session;
        } catch (RuntimeException e) {
            session.close();
        }
    }

    public static synchronized void onCameraPaused() {
        Session session = active;
        active = null;
        if (session != null) session.close();
    }

    private enum Stream { GYRO, ACCEL, ROTATION, RGB, ALS, TOF }

    private static final class Session implements SensorEventListener {
        final long id;
        final Context appContext;
        final String cameraId;
        final boolean front;
        final SensorManager manager;
        final SpectralLayout layout;
        final HandlerThread thread = new HandlerThread("CameraTelemetrySensors");
        final ScheduledExecutorService thermalWorker = Executors.newSingleThreadScheduledExecutor(r -> {
            Thread t = new Thread(r, "CameraTelemetryThermal");
            t.setDaemon(true);
            return t;
        });
        final EnumMap<Stream, Sensor> sensors = new EnumMap<>(Stream.class);
        final EnumMap<Stream, Series> history = new EnumMap<>(Stream.class);
        final Series thermal = new Series(32, ZONES.length);
        final java.util.IdentityHashMap<Sensor, Stream> registered = new java.util.IdentityHashMap<>();
        final EnumMap<Stream, String> status = new EnumMap<>(Stream.class);
        volatile boolean closed;

        Session(long id, Context ctx, String cameraId, boolean front, SensorManager manager, SpectralLayout layout) {
            this.id = id;
            this.appContext = ctx;
            this.cameraId = cameraId;
            this.front = front;
            this.manager = manager;
            this.layout = layout;
            for (Stream s : Stream.values()) {
                boolean imu = s == Stream.GYRO || s == Stream.ACCEL;
                int capacity = imu ? 8192 : 128;
                int width = imu ? 3 : (s == Stream.ROTATION ? 5 : 16);
                history.put(s, new Series(capacity, width));
                status.put(s, "notExposed");
            }
        }

        void start() {
            thermalWorker.scheduleWithFixedDelay(() -> {
                float[] values = readThermalZones(Paths.get("/sys/class/thermal"));
                if (!closed) thermal.add(SystemClock.elapsedRealtimeNanos(), values);
            }, 0, 1, TimeUnit.SECONDS);
            if (manager == null) return;
            thread.start();
            Handler handler = new Handler(thread.getLooper());
            registerImu(Stream.GYRO, Sensor.TYPE_GYROSCOPE, handler);
            registerImu(Stream.ACCEL, Sensor.TYPE_ACCELEROMETER, handler);
            registerRotation(handler);
            try {
                List<Sensor> list = manager.getSensorList(Sensor.TYPE_ALL);
                for (Sensor sensor : list) {
                    Stream kind = vendorStream(sensor);
                    if (kind != null && !sensors.containsKey(kind)) register(kind, sensor, handler);
                }
            } catch (RuntimeException unavailable) {
                for (Stream s : new Stream[]{Stream.RGB, Stream.ALS, Stream.TOF}) {
                    if (!sensors.containsKey(s)) status.put(s, "enumerationFailed");
                }
            }
        }

        private void registerImu(Stream kind, int type, Handler handler) {
            try {
                register(kind, manager.getDefaultSensor(type), handler);
            } catch (RuntimeException failure) {
                status.put(kind, "unavailable");
            }
        }

        private void registerRotation(Handler handler) {
            try {
                for (int type : new int[]{Sensor.TYPE_ROTATION_VECTOR, Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR}) {
                    Sensor sensor = manager.getDefaultSensor(type);
                    if (sensor != null && sensor.getType() == type) {
                        register(Stream.ROTATION, sensor, handler);
                        if (sensors.containsKey(Stream.ROTATION)) return;
                    }
                }
            } catch (RuntimeException failure) {
                status.put(Stream.ROTATION, "unavailable");
            }
        }

        private synchronized void register(Stream kind, Sensor sensor, Handler handler) {
            if (sensor == null) return;
            boolean imu = kind == Stream.GYRO || kind == Stream.ACCEL;
            int[] periods = imu ? new int[]{IMU_PERIOD_US, 5000, 20000}
                    : (kind == Stream.ROTATION ? new int[]{20000, 66667} : new int[]{100000});
            for (int period : periods) {
                try {
                    if (manager.registerListener(this, sensor, period, handler)) {
                        sensors.put(kind, sensor);
                        if (!registered.containsKey(sensor)) registered.put(sensor, kind);
                        status.put(kind, "noSample");
                        return;
                    }
                    status.put(kind, "registrationFailed");
                } catch (SecurityException denied) {
                    status.put(kind, "accessDenied");
                } catch (RuntimeException unavailable) {
                    status.put(kind, "registrationFailed");
                }
            }
        }

        @Override public void onAccuracyChanged(Sensor sensor, int accuracy) {}

        @Override public void onSensorChanged(SensorEvent event) {
            if (closed || event == null || event.values == null) return;
            Stream kind;
            synchronized (this) { kind = registered.get(event.sensor); }
            if (kind == null) return;
            if ((kind == Stream.GYRO || kind == Stream.ACCEL) && !validTriplet(event.values)) return;
            if (kind == Stream.ROTATION) {
                if (event.values.length < 3) return;
                float x = event.values[0], y = event.values[1], z = event.values[2];
                float w = event.values.length >= 4 ? event.values[3]
                        : (float) Math.sqrt(Math.max(0.0, 1.0 - ((double) x * x + y * y + z * z)));
                if (!Float.isFinite(x) || !Float.isFinite(y) || !Float.isFinite(z) || !Float.isFinite(w)) return;
                history.get(Stream.ROTATION).add(event.timestamp, new float[]{x, y, z, w, (float) event.accuracy});
                return;
            }
            history.get(kind).add(event.timestamp, event.values);
        }

        void close() {
            closed = true;
            thermalWorker.shutdownNow();
            try {
                if (manager != null) manager.unregisterListener(this);
            } catch (RuntimeException ignored) {
                // The framework can already have disconnected the sensor service.
            } finally {
                if (thread.isAlive()) thread.quitSafely();
            }
        }
    }

    private static Stream vendorStream(Sensor sensor) {
        String type = String.valueOf(sensor.getStringType()).toLowerCase(Locale.ROOT);
        String name = (type + " " + sensor.getName()).toLowerCase(Locale.ROOT).replace('_', ' ');
        if ("com.motorola.sensor.tof".equals(type)) return Stream.TOF;
        if (name.contains("front")) return null;
        boolean rear = name.contains("tcs3408") || name.contains("alternate") || name.contains("rear");
        if (!rear) return null;
        if (name.contains("rgb")) return Stream.RGB;
        if (name.contains("light") || name.contains("als")) return Stream.ALS;
        return null;
    }

    /** Fixed storage, including the 400 Hz callback path. Never retains SensorEvent.values. */
    private static final class Series {
        final long[] times;
        final float[] data;
        final int[] sizes;
        final int width;
        int next, size;

        Series(int capacity, int width) {
            this.width = width;
            times = new long[capacity];
            sizes = new int[capacity];
            data = new float[capacity * width];
        }

        synchronized void add(long time, float[] values) {
            if (time <= 0 || values.length == 0 || (size > 0 && time <= times[slot(size - 1)])) return;
            times[next] = time;
            sizes[next] = Math.min(width, values.length);
            System.arraycopy(values, 0, data, next * width, sizes[next]);
            next = (next + 1) % times.length;
            if (size < times.length) size++;
        }

        int slot(int index) { return (next - size + times.length + index) % times.length; }

        // Ordered lower bound, including after wraparound.
        int lowerBound(long time) {
            int lo = 0, hi = size;
            while (lo < hi) {
                int mid = (lo + hi) >>> 1;
                if (times[slot(mid)] < time) lo = mid + 1;
                else hi = mid;
            }
            return lo;
        }

        synchronized int atOrBefore(long time) {
            int i = lowerBound(time);
            if (i < size && times[slot(i)] == time) return slot(i);
            return i == 0 ? -1 : slot(i - 1);
        }
    }
    /** Linux thermal_zone/temp ABI uses millidegrees even near 0 C. Other sources can pass whole degrees explicitly. */
    public static Double normalizeThermalCelsius(double raw, boolean millidegrees) {
        double c = millidegrees ? raw / 1000.0 : raw;
        return Double.isFinite(c) && c >= -40 && c <= 150 ? c : null;
    }

    static float[] readThermalZones(Path root) {
        float[] values = new float[ZONES.length];
        Arrays.fill(values, Float.NaN);
        try (DirectoryStream<Path> dirs = Files.newDirectoryStream(root, "thermal_zone*")) {
            for (Path dir : dirs) {
                try {
                    int index = Arrays.asList(ZONES).indexOf(readLine(dir.resolve("type")));
                    if (index < 0) continue;
                    Double c = normalizeThermalCelsius(Double.parseDouble(readLine(dir.resolve("temp"))), true);
                    if (c != null) values[index] = c.floatValue();
                } catch (IOException | RuntimeException ignored) {}
            }
        } catch (IOException | RuntimeException ignored) {}
        return values;
    }

    private static String readLine(Path path) throws IOException {
        try (BufferedReader r = Files.newBufferedReader(path, StandardCharsets.US_ASCII)) {
            String s = r.readLine();
            return s == null ? "" : s.trim();
        }
    }

    /** McCamy estimate after a calibrated sensor-RGB -> CIE XYZ conversion. */
    public static Double estimateCctKelvin(double r, double g, double b, double[] matrix) {
        if (!(r > 0 && g > 0 && b > 0) || matrix == null || matrix.length != 9) return null;
        double x = matrix[0]*r + matrix[1]*g + matrix[2]*b;
        double y = matrix[3]*r + matrix[4]*g + matrix[5]*b;
        double z = matrix[6]*r + matrix[7]*g + matrix[8]*b;
        double sum = x + y + z;
        if (!(x > 0 && y > 0 && z > 0) || !Double.isFinite(sum)) return null;
        double cx = x / sum, cy = y / sum;
        if (Math.abs(cy - 0.1858) < 1e-7) return null;
        double n = (cx - 0.3320) / (0.1858 - cy);
        double k = ((449*n + 3525)*n + 6823.3)*n + 5520.33;
        return k >= 2850 && k <= 10000 ? k : null;
    }

    private static boolean validTriplet(float[] v) {
        return v != null && v.length >= 3 && Float.isFinite(v[0]) && Float.isFinite(v[1]) && Float.isFinite(v[2]);
    }

    // Maximum angular distance from the exposure-start orientation. Two midpoint integration
    // steps per sample interval retain reversals and compose rotations about changing body axes.
    private static final class Integral {
        final boolean rotation;
        double w = 1, x, y, z, excursion, squareSeconds, peak;

        Integral(boolean rotation) { this.rotation = rotation; }

        void rotate(double dt, double gx, double gy, double gz) {
            double rate = Math.sqrt(gx*gx + gy*gy + gz*gz);
            if (rate == 0) return;
            double halfAngle = rate * dt / 2;
            double c = Math.cos(halfAngle), scale = Math.sin(halfAngle) / rate;
            double dx = gx*scale, dy = gy*scale, dz = gz*scale;
            double nw = w*c - x*dx - y*dy - z*dz;
            double nx = w*dx + x*c + y*dz - z*dy;
            double ny = w*dy - x*dz + y*c + z*dx;
            double nz = w*dz + x*dy - y*dx + z*c;
            double norm = Math.sqrt(nw*nw + nx*nx + ny*ny + nz*nz);
            w = nw/norm; x = nx/norm; y = ny/norm; z = nz/norm;
            double angle = 2 * Math.atan2(Math.sqrt(x*x + y*y + z*z), Math.abs(w));
            excursion = Math.max(excursion, angle);
        }

        void step(double dt, double ax, double ay, double az, double bx, double by, double bz) {
            double aa = ax*ax + ay*ay + az*az, bb = bx*bx + by*by + bz*bz;
            peak = Math.max(peak, Math.sqrt(Math.max(aa, bb)));
            squareSeconds += dt * (aa + ax*bx + ay*by + az*bz + bb) / 3.0;
            if (rotation) {
                rotate(dt/2, (3*ax+bx)/4, (3*ay+by)/4, (3*az+bz)/4);
                rotate(dt/2, (ax+3*bx)/4, (ay+3*by)/4, (az+3*bz)/4);
            }
        }
    }

    /** Returns integrated gyro angular excursion (rad) over [timestampNs - exposureNs, timestampNs], or -1 if unavailable. */
    public static float latestGyroExcursionRad(long frameTimestampNs, long exposureNs) {
        Session s = active;
        if (s == null || frameTimestampNs <= 0L || exposureNs <= 0L) return -1f;
        try {
            Map<String, Object> m = motion(s.history.get(Stream.GYRO), frameTimestampNs, exposureNs, true, null);
            Object exc = m.get("angularExcursionRad");
            return exc instanceof Number ? ((Number) exc).floatValue() : -1f;
        } catch (Throwable ignored) {
            return -1f;
        }
    }

    /** Standalone integration of a complete, ordered gyro trace. Durations are nanoseconds. */
    public static Double gyroExcursionRad(long[] timesNs, float[][] rates) {
        if (timesNs == null || rates == null || timesNs.length < 2 || timesNs.length != rates.length) return null;
        Integral total = new Integral(true);
        for (int i = 0; i < timesNs.length; i++) {
            if (timesNs[i] < 0 || !validTriplet(rates[i])) return null;
            if (i == 0) continue;
            if (timesNs[i] <= timesNs[i-1]) return null;
            float[] a = rates[i-1], b = rates[i];
            total.step((timesNs[i]-timesNs[i-1]) / (double) SECOND, a[0], a[1], a[2], b[0], b[1], b[2]);
        }
        return total.excursion;
    }

    private static Map<String,Object> motion(Series series, long start, long duration, boolean gyro, String reason) {
        Map<String,Object> m = new LinkedHashMap<>();
        m.put("sampleCount", null);
        m.put("achievedHz", null);
        String rms = gyro ? "rmsRadPerSec" : "rmsMps2";
        String peak = gyro ? "peakRadPerSec" : "peakMps2";
        m.put(rms, null);
        m.put(peak, null);
        if (gyro) m.put("angularExcursionRad", null);
        m.put("reason", reason);
        if (series == null || start <= 0 || duration <= 0 || start > Long.MAX_VALUE-duration) return m;
        long end = start + duration;
        synchronized (series) {
            int first = series.lowerBound(start), last = series.lowerBound(end);
            int count = last - first;
            if (last < series.size && series.times[series.slot(last)] == end) count++;
            m.put("sampleCount", count);
            if (count >= 2) {
                long span = series.times[series.slot(first+count-1)] - series.times[series.slot(first)];
                m.put("achievedHz", (count-1) * (double) SECOND / span);
            }
            if (first == series.size || last == series.size) return m;
            if (series.times[series.slot(first)] > start) first--;
            if (first < 0) return m;
            Integral total = new Integral(gyro);
            for (int i = first; i < last; i++) {
                int a = series.slot(i), b = series.slot(i+1);
                long t0 = series.times[a], t1 = series.times[b], gap = t1-t0;
                if (gap > MAX_IMU_GAP_NS) {
                    m.put("reason", "sampleGap");
                    return m;
                }
                long from = Math.max(start, t0), to = Math.min(end, t1);
                double p = (from-t0)/(double)gap, q = (to-t0)/(double)gap;
                int ai = a * series.width, bi = b * series.width;
                double ax = series.data[ai], ay = series.data[ai+1], az = series.data[ai+2];
                double dx = series.data[bi]-ax, dy = series.data[bi+1]-ay, dz = series.data[bi+2]-az;
                total.step((to-from)/(double)SECOND, ax+p*dx, ay+p*dy, az+p*dz, ax+q*dx, ay+q*dy, az+q*dz);
            }
            m.put(rms, Math.sqrt(total.squareSeconds / (duration/(double)SECOND)));
            m.put(peak, total.peak);
            if (gyro) m.put("angularExcursionRad", total.excursion);
            m.put("reason", null);
        }
        return m;
    }

    private static Map<String,CaptureResult.Key<?>> resultKeys() {
        Map<String,CaptureResult.Key<?>> keys = new LinkedHashMap<>();
        for (String name : KEYS) {
            try {
                keys.put(name, (CaptureResult.Key<?>) CaptureResult.class.getField(name).get(null));
            } catch (ReflectiveOperationException | SecurityException ignored) {}
        }
        for (String name : EXTRA_DIAG_KEYS) {
            try {
                keys.put(name, (CaptureResult.Key<?>) CaptureResult.class.getField(name).get(null));
            } catch (ReflectiveOperationException | SecurityException ignored) {}
        }
        return keys;
    }

    private static Object readTag(TotalCaptureResult result, String name) {
        CaptureResult.Key<?> key = RESULT_KEYS.get(name);
        if (result == null || key == null) return null;
        try {
            Object v = result.get(key);
            if (v instanceof RggbChannelVector) {
                RggbChannelVector g = (RggbChannelVector)v;
                return finiteArray(new float[]{g.getRed(), g.getGreenEven(), g.getGreenOdd(), g.getBlue()});
            }
            if (v instanceof ColorSpaceTransform) {
                Rational[] matrix = new Rational[9];
                ((ColorSpaceTransform)v).copyElements(matrix, 0);
                float[] values = new float[9];
                for (int i = 0; i < 9; i++) {
                    if (matrix[i] == null) return null;
                    values[i] = matrix[i].floatValue();
                }
                return finiteArray(values);
            }
            if (!(v instanceof Number)) return null;
            double n = ((Number)v).doubleValue();
            if (!Double.isFinite(n) || n < 0) return null;
            switch (name) {
                case "SENSOR_EXPOSURE_TIME":
                case "SENSOR_FRAME_DURATION":
                case "SENSOR_SENSITIVITY":
                case "LENS_FOCAL_LENGTH":
                case "LENS_APERTURE":
                    return n > 0 ? v : null;
                default:
                    return v;
            }
        } catch (RuntimeException ignored) { return null; }
    }

    private static float[] finiteArray(float[] values) {
        for (float v : values) if (!Float.isFinite(v)) return null;
        return values;
    }

    private static String method(String value) {
        if ("vendor".equals(value) || "singleRaw".equals(value) || "rawBurst".equals(value)) return value;
        throw new IllegalArgumentException("Unknown capture method");
    }

    private static String reason(Session s, ShotMetadata meta, long time) {
        if (s == null || meta == null || meta.generation != s.id) return "sessionUnavailable";
        if (!meta.realtimeClock) return "clockUnverified";
        return time <= 0 ? "missingTimestamp" : null;
    }

    private static String streamReason(Session s, Stream kind, String reason) {
        if (reason != null) return reason;
        return s.status.get(kind);
    }

    private static final class Observation {
        float[] values;
        Long timestamp;
        String reason;

        Observation(Series series, long time, long maxAge, String reason) {
            this.reason = reason;
            if (series == null) return;
            synchronized (series) {
                int slot = series.atOrBefore(time);
                if (slot < 0) return;
                timestamp = series.times[slot];
                if (time - timestamp > maxAge) {
                    this.reason = "stale";
                    return;
                }
                int from = slot*series.width;
                values = Arrays.copyOfRange(series.data, from, from+series.sizes[slot]);
                this.reason = null;
            }
        }

        Float channel(int i) {
            if (values == null || i < 0 || i >= values.length || !Float.isFinite(values[i]) || values[i] < 0) return null;
            return values[i];
        }

        Map<String,Object> json() {
            Map<String,Object> m = new LinkedHashMap<>();
            m.put("timestampNs", timestamp == null ? null : timestamp.toString());
            m.put("reason", reason);
            m.put("raw", values);
            return m;
        }
    }

    private static Observation observe(Session s, Stream kind, long time, String reason) {
        return new Observation(reason == null ? s.history.get(kind) : null, time, SECOND, streamReason(s, kind, reason));
    }

    private static Map<String,Object> spectrum(Observation rgb, SpectralLayout layout) {
        Map<String,Object> m = rgb.json();
        String[] names = {"redCounts", "greenCounts", "blueCounts", "clearCounts", "widebandCounts"};
        Float[] counts = new Float[names.length];
        for (int i = 0; i < counts.length; i++) {
            counts[i] = layout == null ? null : rgb.channel(layout.channels[i]);
            m.put(names[i], counts[i]);
        }
        if (rgb.values != null && layout == null) m.put("reason", "unverifiedLayout");
        Double cct = null;
        if (counts[0] != null && counts[1] != null && counts[2] != null) {
            cct = estimateCctKelvin(counts[0], counts[1], counts[2], layout.xyzMatrix);
        }
        m.put("cctK", cct);
        String cctReason = (String)m.get("reason");
        if (cct == null && cctReason == null) {
            cctReason = layout.xyzMatrix == null ? "uncalibrated" : "invalidChromaticity";
        }
        m.put("cctReason", cctReason);
        Float hz = layout == null ? null : rgb.channel(layout.channels[5]);
        Integer mains = null;
        if (hz != null && (hz == 50 || hz == 100)) mains = 50;
        if (hz != null && (hz == 60 || hz == 120)) mains = 60;
        m.put("reportedFlickerHz", hz);
        m.put("mainsClassHz", mains);
        m.put("nominalOpticalHz", mains == null ? null : 2 * mains);
        // A mains class alone is not a measurement of the optical modulation.
        m.put("opticalFlickerHz", hz != null && (hz == 100 || hz == 120) ? hz : null);
        return m;
    }

    /** Serialize immediately after final result delivery. Pass the returned string to the save worker. */
    public static String buildShotTelemetryJson(TotalCaptureResult result, ShotMetadata meta,
                                                 String captureMethod, int lookId, int bokehId, int profileId) {
        return buildShotTelemetryJson(result, meta, captureMethod, lookId, bokehId, profileId,
                sampleCompass(result, meta));
    }

    public static String buildShotTelemetryJson(TotalCaptureResult result, ShotMetadata meta,
                                                 String captureMethod, int lookId, int bokehId, int profileId,
                                                 CompassSnapshot compass) {
        Map<String,Object> shot = new LinkedHashMap<>();
        shot.put("schemaVersion", SCHEMA_VERSION);
        shot.put("shotId", meta == null ? null : meta.shotId);
        shot.put("cameraId", meta == null ? null : meta.cameraId);
        shot.put("isFront", meta == null ? null : meta.isFront);
        shot.put("captureMethod", method(captureMethod));
        shot.put("lookId", lookId);
        shot.put("bokehId", bokehId);
        shot.put("profileId", profileId);
        shot.put("iqLuxIdx", meta == null ? null : meta.iqLuxIdx);
        Map<String,Object> tags = new LinkedHashMap<>();
        for (String name : KEYS) {
            Object value = readTag(result, name);
            // Camera2 nanoseconds are int64. Preserve them exactly in JavaScript readers.
            tags.put(name, value instanceof Long ? value.toString() : value);
        }
        shot.put("captureResult", tags);
        Object sceneFlicker = tags.get("STATISTICS_SCENE_FLICKER");
        Integer sceneMains = null;
        if (Integer.valueOf(1).equals(sceneFlicker)) sceneMains = 50;
        if (Integer.valueOf(2).equals(sceneFlicker)) sceneMains = 60;
        shot.put("cameraSceneMainsClassHz", sceneMains);
        long time = nanos(tags.get("SENSOR_TIMESTAMP")), duration = nanos(tags.get("SENSOR_EXPOSURE_TIME"));
        Session s = active;
        String unavailable = reason(s, meta, time);
        String motionReason = unavailable == null && duration <= 0 ? "missingExposureTime" : unavailable;
        for (Stream kind : new Stream[]{Stream.GYRO, Stream.ACCEL}) {
            boolean gyro = kind == Stream.GYRO;
            String why = streamReason(s, kind, motionReason);
            shot.put(gyro ? "gyro" : "accelerometer", motion(
                    motionReason == null ? s.history.get(kind) : null, time, duration, gyro,
                    "noSample".equals(why) ? "insufficientCoverage" : why));
        }
        Observation rgb = observe(s, Stream.RGB, time, unavailable);
        shot.put("rearSpectral", spectrum(rgb, unavailable == null ? s.layout : null));
        Observation als = observe(s, Stream.ALS, time, unavailable);
        Map<String,Object> light = als.json();
        Sensor alsSensor = unavailable == null ? s.sensors.get(Stream.ALS) : null;
        // Only TYPE_LIGHT has a public Android lux contract. Keep private ALS payloads verbatim.
        light.put("lux", alsSensor != null && alsSensor.getType() == Sensor.TYPE_LIGHT ? als.channel(0) : null);
        shot.put("rearAls", light);
        Observation tof = observe(s, Stream.TOF, time, unavailable);
        Map<String,Object> proximity = tof.json();
        proximity.put("distanceMm", null);
        proximity.put("distanceReason", tof.values == null ? tof.reason : "unverifiedUnits");
        shot.put("rearTof", proximity);

        Observation temps = new Observation(unavailable == null ? s.thermal : null, time, 2*SECOND,
                unavailable == null ? "noSample" : unavailable);
        Map<String,Object> thermal = new LinkedHashMap<>();
        thermal.put("sampledNs", temps.timestamp == null ? null : temps.timestamp.toString());
        Map<String,Object> thermalReasons = new LinkedHashMap<>();
        for (int i = 0; i < ZONES.length; i++) {
            Float v = temps.values == null || !Float.isFinite(temps.values[i]) ? null : temps.values[i];
            thermal.put(ZONES[i], v);
            if (v == null) thermalReasons.put(ZONES[i], temps.reason == null ? "unavailableOrInvalid" : temps.reason);
        }
        thermal.put("reasons", thermalReasons);
        shot.put("thermalC", thermal);
        shot.put("compass", compassJson(compass != null ? compass : sampleCompass(result, meta)));
        Object tagOis = readTag(result, "LENS_OPTICAL_STABILIZATION_MODE");
        Integer effectiveOis = meta != null && meta.oisMode != null ? meta.oisMode
                : (tagOis instanceof Integer ? (Integer) tagOis : null);
        if (meta != null && (meta.gapMs != null || meta.focusSpreadD != null || meta.motionRejected != null
                || meta.aeFps != null || effectiveOis != null || meta.mergeCount != null || meta.depthSource != null)) {
            Map<String,Object> diag = new LinkedHashMap<>();
            if (meta.gapMs != null && Float.isFinite(meta.gapMs)) diag.put("gapMs", meta.gapMs);
            if (meta.focusSpreadD != null && Float.isFinite(meta.focusSpreadD)) diag.put("focusSpreadD", meta.focusSpreadD);
            if (meta.motionRejected != null) diag.put("motionRejected", meta.motionRejected);
            if (meta.aeFps != null) diag.put("aeFps", meta.aeFps);
            if (effectiveOis != null) diag.put("oisMode", effectiveOis);
            if (meta.mergeCount != null) diag.put("mergeCount", meta.mergeCount);
            if (meta.depthSource != null && !meta.depthSource.isEmpty()) diag.put("depthSource", meta.depthSource);
            shot.put("diagnostics", diag);
        } else if (effectiveOis != null) {
            Map<String,Object> diag = new LinkedHashMap<>();
            diag.put("oisMode", effectiveOis);
            shot.put("diagnostics", diag);
        }
        Map<String,Object> absent = new LinkedHashMap<>();
        for (String field : new String[]{"humidityPct", "pressureHpa", "ambientTempC"}) {
            shot.put(field, null);
            absent.put(field, "notPresentOnHardware");
        }
        shot.put("unavailableReasons", absent);
        StringBuilder out = new StringBuilder(1900);
        appendJson(out, shot);
        return out.toString();
    }

    public static final class CompassSnapshot {
        public final Float headingDeg;
        public final Float trueHeadingDeg;
        public final Float pitchDeg;
        public final Float rollDeg;
        public final Integer accuracy;
        public final Float magneticDeclinationDeg;
        public final String cardinal;
        public final Double sunAzimuthDeg;
        public final Double sunElevationDeg;
        public final Double cameraSunAngleDeg;
        public final Float ev100;
        public final boolean physicalOutdoorBacklit;
        public final String status;
        public final String unavailableReason;

        CompassSnapshot(Float headingDeg, Float trueHeadingDeg, Float pitchDeg, Float rollDeg,
                        Integer accuracy, Float magneticDeclinationDeg, String cardinal,
                        Double sunAzimuthDeg, Double sunElevationDeg, Double cameraSunAngleDeg,
                        Float ev100, boolean physicalOutdoorBacklit, String status, String unavailableReason) {
            this.headingDeg = headingDeg;
            this.trueHeadingDeg = trueHeadingDeg;
            this.pitchDeg = pitchDeg;
            this.rollDeg = rollDeg;
            this.accuracy = accuracy;
            this.magneticDeclinationDeg = magneticDeclinationDeg;
            this.cardinal = cardinal;
            this.sunAzimuthDeg = sunAzimuthDeg;
            this.sunElevationDeg = sunElevationDeg;
            this.cameraSunAngleDeg = cameraSunAngleDeg;
            this.ev100 = ev100;
            this.physicalOutdoorBacklit = physicalOutdoorBacklit;
            this.status = status;
            this.unavailableReason = unavailableReason;
        }
    }

    public static CompassSnapshot sampleCompass(TotalCaptureResult result, ShotMetadata meta) {
        return sampleCompassAt(result, meta, System.currentTimeMillis());
    }

    static CompassSnapshot sampleCompassAt(TotalCaptureResult result, ShotMetadata meta, long nowMs) {
        Double evVal = null;
        Object expObj = readTag(result, "SENSOR_EXPOSURE_TIME");
        Object isoObj = readTag(result, "SENSOR_SENSITIVITY");
        Object apObj = readTag(result, "LENS_APERTURE");
        if (expObj instanceof Long && isoObj instanceof Integer && apObj instanceof Number) {
            double computed = CompassSolarHelper.computeEv100(
                    (Long) expObj, (Integer) isoObj, ((Number) apObj).floatValue());
            if (Double.isFinite(computed)) evVal = computed;
        }
        Float ev100 = evVal == null ? null : Float.valueOf(evVal.floatValue());
        double evForGate = evVal == null ? Double.NaN : evVal.doubleValue();

        Session s = active;
        long time = nanos(readTag(result, "SENSOR_TIMESTAMP") instanceof Long
                ? String.valueOf(readTag(result, "SENSOR_TIMESTAMP")) : null);
        String unavailable = reason(s, meta, time);
        Observation rot = unavailable == null
                ? new Observation(s.history.get(Stream.ROTATION), time, 2 * SECOND, streamReason(s, Stream.ROTATION, null))
                : new Observation(null, time, 2 * SECOND, unavailable);
        if (rot.values == null && s != null && unavailable != null && !"sessionUnavailable".equals(unavailable)
                && !Boolean.TRUE.equals(meta == null ? null : Long.valueOf(meta.generation) != s.id)) {
            Series rotSeries = s.history.get(Stream.ROTATION);
            synchronized (rotSeries) {
                if (rotSeries.size > 0) {
                    int latestSlot = rotSeries.slot(rotSeries.size - 1);
                    int from = latestSlot * rotSeries.width;
                    rot.values = Arrays.copyOfRange(rotSeries.data, from, from + rotSeries.sizes[latestSlot]);
                    rot.reason = null;
                }
            }
        }
        if (rot.values == null || rot.values.length < 4) {
            String why = rot.reason != null ? rot.reason : "noSample";
            return new CompassSnapshot(null, null, null, null, null, null, null,
                    null, null, null, ev100, false, why, why);
        }

        int acc = rot.values.length >= 5 && Float.isFinite(rot.values[4]) ? Math.round(rot.values[4]) : 0;
        boolean front = meta != null && Boolean.TRUE.equals(meta.isFront);
        CompassSolarHelper.OrientationReading reading = CompassSolarHelper.computeOrientation(
                rot.values, 4, 0, front, acc, time);
        if (reading == null || !Float.isFinite(reading.headingDeg)) {
            return new CompassSnapshot(null, null, null, null, acc, null, null,
                    null, null, null, ev100, false, "invalidOrientation", "invalidOrientation");
        }

        Float magHeading = reading.headingDeg;
        Float trueHeading = null;
        Float declDeg = null;
        Double sunAz = null;
        Double sunEl = null;
        Double sunSep = null;
        boolean backlit = false;
        String status = acc < 2 ? "uncalibrated" : "ok";
        String sunReason = null;

        double[] fix = isSaveLocationAllowed() ? readLocationFixReflect(s.appContext, nowMs) : null;
        if (fix != null) {
            CompassSolarHelper.SolarPosition solar = CompassSolarHelper.computeSolarPosition(fix[0], fix[1], nowMs);
            sunAz = solar.azimuthDeg;
            sunEl = solar.elevationDeg;
            Double decl = readDeclinationReflect((float) fix[0], (float) fix[1], (float) fix[2], nowMs);
            double northAlignedCamAz = reading.headingDeg;
            if (decl != null && Double.isFinite(decl)) {
                declDeg = Float.valueOf(decl.floatValue());
                double tDeg = (reading.headingDeg + decl.doubleValue()) % 360.0;
                if (tDeg < 0.0) tDeg += 360.0;
                trueHeading = Float.valueOf((float) tDeg);
                northAlignedCamAz = tDeg;
            }
            sunSep = CompassSolarHelper.angularSeparationDeg(
                    northAlignedCamAz, reading.pitchDeg, solar.azimuthDeg, solar.elevationDeg);
            backlit = CompassSolarHelper.isPhysicalOutdoorBacklit(evForGate, solar.elevationDeg, sunSep, acc);
        } else {
            sunReason = isSaveLocationAllowed() ? "locationUnavailable" : "locationSettingOff";
        }
        String cardinal = CompassSolarHelper.formatCardinal(trueHeading != null ? trueHeading : magHeading);
        return new CompassSnapshot(magHeading, trueHeading, reading.pitchDeg, reading.rollDeg, acc, declDeg,
                cardinal, sunAz, sunEl, sunSep, ev100, backlit, status, sunReason);
    }

    private static Map<String,Object> compassJson(CompassSnapshot c) {
        Map<String,Object> m = new LinkedHashMap<>();
        m.put("headingDeg", c.headingDeg);
        m.put("trueHeadingDeg", c.trueHeadingDeg);
        m.put("pitchDeg", c.pitchDeg);
        m.put("rollDeg", c.rollDeg);
        m.put("accuracy", c.accuracy);
        m.put("magneticDeclinationDeg", c.magneticDeclinationDeg);
        m.put("cardinal", c.cardinal);
        m.put("sunAzimuthDeg", c.sunAzimuthDeg);
        m.put("sunElevationDeg", c.sunElevationDeg);
        m.put("cameraSunAngleDeg", c.cameraSunAngleDeg);
        m.put("ev100", c.ev100);
        m.put("physicalOutdoorBacklit", c.physicalOutdoorBacklit);
        m.put("status", c.status);
        m.put("unavailableReason", c.unavailableReason);
        return m;
    }

    private static boolean isSaveLocationAllowed() {
        try {
            Class<?> pb = Class.forName("com.motorola.camera.settings.PersistBehavior");
            Object prefs = pb.getMethod("getPreferences").invoke(null);
            if (prefs != null) {
                Method getBool = prefs.getClass().getMethod("getBoolean", String.class, boolean.class);
                Object val = getBool.invoke(prefs, "com.motorola.camera.geo_location_state", Boolean.TRUE);
                if (Boolean.FALSE.equals(val)) return false;
            }
        } catch (Throwable ignored) {}
        return true;
    }

    private static double[] readLocationFixReflect(Context ctx, long nowMs) {
        if (ctx == null) return null;
        try {
            Method checkPerm = ctx.getClass().getMethod("checkSelfPermission", String.class);
            Object coarse = checkPerm.invoke(ctx, "android.permission.ACCESS_COARSE_LOCATION");
            Object fine = checkPerm.invoke(ctx, "android.permission.ACCESS_FINE_LOCATION");
            boolean okCoarse = coarse instanceof Integer && (Integer) coarse == 0;
            boolean okFine = fine instanceof Integer && (Integer) fine == 0;
            if (!okCoarse && !okFine) return null;
            Method getSys = ctx.getClass().getMethod("getSystemService", String.class);
            Object lm = getSys.invoke(ctx, "location");
            if (lm == null) return null;
            Class<?> lmCls = lm.getClass();
            Method lastKnown = lmCls.getMethod("getLastKnownLocation", String.class);
            Object best = null;
            long bestTime = -1L;
            for (String p : new String[]{"passive", "gps", "network"}) {
                try {
                    Object loc = lastKnown.invoke(lm, p);
                    if (loc == null) continue;
                    long t = ((Number) loc.getClass().getMethod("getTime").invoke(loc)).longValue();
                    double lat = ((Number) loc.getClass().getMethod("getLatitude").invoke(loc)).doubleValue();
                    double lon = ((Number) loc.getClass().getMethod("getLongitude").invoke(loc)).doubleValue();
                    if (Math.abs(lat) > 90.0 || Math.abs(lon) > 180.0 || t <= 0L || t > nowMs || nowMs - t > 3_600_000L) {
                        continue;
                    }
                    if (best == null || t > bestTime) {
                        best = loc;
                        bestTime = t;
                    }
                } catch (Throwable ignored) {}
            }
            if (best == null) return null;
            double lat = ((Number) best.getClass().getMethod("getLatitude").invoke(best)).doubleValue();
            double lon = ((Number) best.getClass().getMethod("getLongitude").invoke(best)).doubleValue();
            double alt = 0.0;
            try {
                boolean hasAlt = Boolean.TRUE.equals(best.getClass().getMethod("hasAltitude").invoke(best));
                if (hasAlt) {
                    double a = ((Number) best.getClass().getMethod("getAltitude").invoke(best)).doubleValue();
                    if (Double.isFinite(a)) alt = a;
                }
            } catch (Throwable ignored) {}
            return new double[]{lat, lon, alt};
        } catch (Throwable ignored) {
            return null;
        }
    }

    private static Double readDeclinationReflect(float lat, float lon, float alt, long epochMs) {
        try {
            Class<?> field = Class.forName("android.hardware.GeomagneticField");
            Object model = field.getConstructor(float.class, float.class, float.class, long.class)
                    .newInstance(lat, lon, alt, epochMs);
            return ((Number) field.getMethod("getDeclination").invoke(model)).doubleValue();
        } catch (Throwable ignored) {
            return null;
        }
    }

    private static long nanos(Object value) {
        return value instanceof String ? Long.parseLong((String)value) : 0;
    }

    /** Short, bounded ASCII note. Dynamic sensor series and private IDs belong in the sidecar. */
    public static String buildConciseExifNote(TotalCaptureResult result, ShotMetadata meta, String captureMethod,
                                               int lookId, int bokehId, int profileId) {
        Object iso = readTag(result, "SENSOR_SENSITIVITY");
        Object ns = readTag(result, "SENSOR_EXPOSURE_TIME");
        Object tagOis = readTag(result, "LENS_OPTICAL_STABILIZATION_MODE");
        Integer effectiveOis = meta != null && meta.oisMode != null ? meta.oisMode
                : (tagOis instanceof Integer ? (Integer) tagOis : null);
        StringBuilder sb = new StringBuilder(160);
        sb.append("telemetry=1 capture=").append(method(captureMethod))
          .append(" look=").append(lookId)
          .append(" bokeh=").append(bokehId)
          .append(" profile=").append(profileId);
        if (iso != null) sb.append(" ISO=").append(iso);
        if (ns != null) sb.append(" exposureNs=").append(ns);
        if (meta != null && meta.iqLuxIdx != null && Float.isFinite(meta.iqLuxIdx)) {
            sb.append(" iqLuxIdx=").append(meta.iqLuxIdx);
        }
        if (effectiveOis != null) sb.append(" ois=").append(effectiveOis);
        if (meta != null) {
            if (meta.aeFps != null) sb.append(" aeFps=").append(meta.aeFps);
            if (meta.mergeCount != null) sb.append(" merge=").append(meta.mergeCount);
            if (meta.gapMs != null && Float.isFinite(meta.gapMs)) {
                sb.append(" gapMs=").append(String.format(Locale.ROOT, "%.1f", meta.gapMs));
            }
            if (meta.focusSpreadD != null && Float.isFinite(meta.focusSpreadD)) {
                sb.append(" focusSpreadD=").append(String.format(Locale.ROOT, "%.2f", meta.focusSpreadD));
            }
            if (Boolean.TRUE.equals(meta.motionRejected)) sb.append(" motion=1");
            if (meta.depthSource != null && !meta.depthSource.isEmpty()) sb.append(" depth=").append(meta.depthSource);
        }
        return sb.toString();
    }

    /** A null destination disables sidecars. Call on a save worker after the media file is finalized. */
    public static boolean writeSidecarJsonIfEnabled(File sidecarFile, String json) {
        if (sidecarFile == null || json == null || json.isEmpty()) return false;
        Path tmp = null;
        try {
            Path dst = sidecarFile.toPath().toAbsolutePath();
            tmp = Files.createTempFile(dst.getParent(), ".telemetry-", ".tmp");
            Files.write(tmp, json.getBytes(StandardCharsets.UTF_8));
            synchronized (SIDECAR_MOVE_LOCK) {
                try {
                    Files.move(tmp, dst, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);
                } catch (AtomicMoveNotSupportedException unsupported) {
                    // Same-directory rename. Never truncate the previous good copy on a failed replacement.
                    if (!tmp.toFile().renameTo(dst.toFile())) return false;
                }
            }
            return true;
        } catch (IOException | RuntimeException failed) {
            return false;
        } finally {
            if (tmp != null) {
                try { Files.deleteIfExists(tmp); } catch (IOException | SecurityException ignored) {}
            }
        }
    }

    /** Returns a complete JSON string literal (or the JSON null literal). */
    public static String escapeJson(String value) {
        if (value == null) return "null";
        StringBuilder out = new StringBuilder(value.length() + 2).append('"');
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '"': out.append("\\\""); break;
                case '\\': out.append("\\\\"); break;
                case '\b': out.append("\\b"); break;
                case '\f': out.append("\\f"); break;
                case '\n': out.append("\\n"); break;
                case '\r': out.append("\\r"); break;
                case '\t': out.append("\\t"); break;
                default:
                    if (c < 32 || Character.isSurrogate(c)) {
                        out.append("\\u");
                        for (int shift = 12; shift >= 0; shift -= 4) out.append(Character.forDigit((c >> shift) & 15, 16));
                    } else out.append(c);
            }
        }
        return out.append('"').toString();
    }

    private static void appendJson(StringBuilder out, Object v) {
        if (v instanceof Map) {
            out.append('{');
            boolean first = true;
            for (Map.Entry<?,?> e : ((Map<?,?>)v).entrySet()) {
                if (!first) out.append(',');
                first = false;
                out.append(escapeJson((String)e.getKey())).append(':');
                appendJson(out, e.getValue());
            }
            out.append('}');
        } else if (v instanceof float[]) {
            out.append('[');
            float[] a = (float[])v;
            for (int i = 0; i < a.length; i++) {
                if (i != 0) out.append(',');
                appendJson(out, a[i]);
            }
            out.append(']');
        } else if (v instanceof Number) {
            out.append(Double.isFinite(((Number)v).doubleValue()) ? v.toString() : "null");
        } else if (v instanceof Boolean) {
            out.append(v);
        } else {
            out.append(escapeJson((String)v));
        }
    }
}
