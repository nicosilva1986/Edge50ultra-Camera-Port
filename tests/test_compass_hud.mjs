// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { existsSync, mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { delimiter, dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const tree = fileURLToPath(new URL('../patches/custom_imaging_java/', import.meta.url));
const pkg = 'com/motorola/camera/custom';
const controller = join(tree, 'src', pkg, 'CompassHudController.java');
const helper = join(tree, 'src', pkg, 'CompassSolarHelper.java');
const stubs = join(tree, 'stubs');
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
let work;
let classpath, productionClasses;

function run(tool, args) {
  const proc = spawnSync(tool, args, { encoding: 'utf8', windowsHide: true, timeout: 60000 });
  if (proc.error) throw proc.error;
  assert.equal(proc.status, 0, [proc.stdout, proc.stderr].filter(Boolean).join('\n'));
}

function source(name, body) {
  const path = join(work, 'src', name + '.java');
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, body, 'utf8');
  return path;
}

// Deterministic attitude and sun inputs. The astronomical solver has its own tests.
// A separate compilation below always checks the controller against the shipped helper when available.
const helperFixture = `package com.motorola.camera.custom;
public final class CompassSolarHelper {
    public static final class OrientationReading {
        public final double headingDeg, pitchDeg, rollDeg;
        public final int accuracy;
        public final long timestampNs;
        public OrientationReading(double h, double p, double r, int a, long t) {
            headingDeg = h; pitchDeg = p; rollDeg = r; accuracy = a; timestampNs = t;
        }
    }
    public static final class SolarPosition {
        public final double azimuthDeg, elevationDeg;
        public SolarPosition(double a, double e) { azimuthDeg = a; elevationDeg = e; }
    }
    public static OrientationReading computeOrientation(float[] v, int len, int rot,
            boolean front, int accuracy, long ns) {
        return new OrientationReading(0, 0, 0, accuracy, ns);
    }
    public static SolarPosition computeSolarPosition(double lat, double lon, long when) {
        return new SolarPosition(0, 5);
    }
    public static String formatCardinal(double a) {
        String[] c = {"N", "NE", "E", "SE", "S", "SO", "O", "NO"};
        return c[Math.floorMod((int)Math.round(a / 45), 8)];
    }
    public static String formatHeadingLabel(double a) {
        return formatCardinal(a) + " " + Math.floorMod((int)Math.round(a), 360) + "°";
    }
    public static double horizontalAzimuthDeltaDeg(double cam, double sun) {
        return (sun - cam + 540) % 360 - 180;
    }
    public static double angularSeparationDeg(double a, double e, double b, double f) {
        double x = Math.toRadians(e), y = Math.toRadians(f);
        double cos = Math.sin(x)*Math.sin(y) + Math.cos(x)*Math.cos(y)*Math.cos(Math.toRadians(a-b));
        return Math.toDegrees(Math.acos(Math.max(-1, Math.min(1, cos))));
    }
    public static boolean isPhysicalOutdoorBacklit(double ev, double elev, double angle, int accuracy) {
        return ev >= 11 && elev > 0 && angle < 25 && accuracy >= 2;
    }
}`;

const modeFixture = `package com.motorola.camera.settings;
public final class SettingsHelper {
    public static int mode;
    public static int getCurrentMode() { return mode; }
    public static boolean isPhotoMode() { return mode == 0; }
    public static boolean isPortraitMode() { return mode == 6; }
    public static boolean isProPhotoMode() { return mode == 4; }
    public static boolean isNightVisionMode() { return mode == 24; }
    public static boolean isSuperNightMode() { return mode == 24; }
    public static boolean isTenBitVideoMode() { return false; }
    public static boolean isCurrentFrontCamera() { return false; }
}`;
const prefsFixture = `package com.motorola.camera.settings;
import android.content.SharedPreferences;
public final class PersistBehavior {
    public static SharedPreferences preferences;
    public static SharedPreferences getPreferences() { return preferences; }
}`;

// Only the runtime fixture records the view properties set by the actual controller.
const textFixture = `package android.widget;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.text.TextUtils;
import android.view.View;
public class TextView extends View {
    private final Context context;
    public Object tag;
    public int color, visibility;
    public boolean clickable = true, focusable = true;
    public CharSequence label = "";
    public TextView(Context ctx) { super(ctx); context = ctx; }
    public Context getContext() { return context; }
    public Resources getResources() { return context.getResources(); }
    public void setTag(Object value) { tag = value; }
    public void setText(CharSequence value) { label = value; }
    public void setTextColor(int value) { color = value; }
    public void setVisibility(int value) { visibility = value; }
    public void setClickable(boolean value) { clickable = value; }
    public void setFocusable(boolean value) { focusable = value; }
    public void setTextSize(float value) {}
    public void setTypeface(Typeface value) {}
    public void setTypeface(Typeface value, int style) {}
    public void setGravity(int value) {}
    public void setMaxLines(int value) {}
    public void setSingleLine(boolean value) {}
    public void setEllipsize(TextUtils.TruncateAt value) {}
    public void setAllCaps(boolean value) {}
}`;
// Independent poses in Android's east/north/up world frame. This probe lives in the
// production classpath only, so the synthetic orientation reader can never satisfy it.
const nativePoses = `package com.motorola.camera.custom;
import com.motorola.camera.custom.CompassSolarHelper.OrientationReading;
public final class HudNativePoseProbe {
    static OrientationReading read(float[] q, int rotation, boolean front) {
        return CompassHudController.sensorOrientation(q, rotation, front, 3, 123L);
    }
    static void pose(float[] q, int rotation, boolean front, double heading, double pitch) {
        OrientationReading reading = read(q, rotation, front);
        if (reading == null || !Double.isFinite(reading.pitchDeg) || Math.abs(reading.pitchDeg - pitch) > .05)
            throw new AssertionError("expected camera pitch " + pitch + " got " + (reading == null ? null : reading.pitchDeg));
        double error = Math.abs(Math.IEEEremainder(reading.headingDeg - heading, 360));
        if (Double.isFinite(heading) && !(error < .05)) throw new AssertionError("heading " + reading.headingDeg);
        if (reading.accuracy != 3 || reading.timestampNs != 123L) throw new AssertionError("lost sensor metadata");
    }
    public static void main(String[] args) {
        float s = (float)Math.sqrt(.5);
        for (int rotation : new int[]{0,90,180,270}) {
            pose(new float[]{s,0,0,s}, rotation,false, 0,0); // Rear axis (+north)
            pose(new float[]{.5f,-.5f,-.5f,.5f}, rotation,false, 90,0);
            pose(new float[]{.5f,-.5f,-.5f,.5f}, rotation,true, 270,0);
        }
        pose(new float[]{0,0,0,1},0,false,Double.NaN,-90); // Azimuth undefined facing straight down
        if (read(new float[4],0,false) != null) throw new AssertionError("zero quaternion accepted");
    }
}`;

const mathProbe = `package com.motorola.camera.custom;
import static com.motorola.camera.custom.CompassHudController.*;
import com.motorola.camera.custom.CompassSolarHelper.OrientationReading;
import com.motorola.camera.custom.CompassSolarHelper.SolarPosition;

public final class HudMathProbe {
    static void check(boolean ok, String message) {
        if (!ok) throw new AssertionError(message);
    }
    static void near(double value, double expected, double tolerance) {
        check(Math.abs(value - expected) <= tolerance, "expected " + expected + ", got " + value);
    }
    static void format() {
        OrientationReading good = new OrientationReading(12, 5, 0, 3, 1);
        OrientationReading low = new OrientationReading(318, 0, 0, 1, 1);
        SolarPosition forward = new SolarPosition(12, 5);
        SolarPosition side = new SolarPosition(102, 42);
        String base = formatHudText(good, null, 13, true);
        check(base.contains("N 12°") && !base.contains("☀"), base);
        check(formatHudText(good, forward, 13, false).equals(base), "location suppressed");
        check(formatHudText(good, new SolarPosition(12,-2), 15, true).equals(base), "twilight boundary");
        check(formatHudText(good, new SolarPosition(12,-5), 15, true).equals(base), "nighttime");
        check(formatHudText(good, new SolarPosition(12,Double.NaN), 15, true).equals(base),
                "missing elevation");
        String twilight = formatHudText(good, new SolarPosition(102,-1.9), 10, true);
        check(twilight.contains("☀") && !twilight.contains("Contraluz"), twilight);
        String away = formatHudText(good, side, 14, true);
        check(away.contains("N 12°") && away.contains("☀") && !away.contains("Contraluz"), away);
        for (double ev : new double[]{10.99, Double.NaN, Double.POSITIVE_INFINITY}) {
            check(!formatHudText(good, forward, ev, true).contains("Contraluz"), "bad EV " + ev);
        }
        String backlit = formatHudText(good, forward, 11, true);
        check(backlit.contains("Contraluz"), backlit);
        String uncalibrated = formatHudText(low, forward, 15, true);
        check(uncalibrated.contains("NO 318°") && uncalibrated.contains("Calibrar")
                && !uncalibrated.contains("Contraluz"), uncalibrated);
        String missing = formatHudText(null, forward, 13, true);
        check(missing == null || (!missing.contains("0°") && !missing.contains("☀")), "missing reading");
    }
    static void smoothing() {
        near(smoothHeading(Double.NaN, 12), 12, 1e-6);
        // The 3:1 weighted vectors (3,0) + (0,1) make atan(1/3) = 18.43495°.
        near(smoothHeading(0, 90), 18.43495, .01);
        near(smoothHeading(359, 1), 359.5, .01);
        near(smoothHeading(1, 359), .5, .01);
        double reverse = 0;
        for (int i=0; i<64; i++) reverse = smoothHeading(reverse, 180);
        near(reverse, 180, .1);
        near(smoothHeading(90, Double.NaN), 90, 1e-6);
        check(Double.isNaN(smoothHeading(Double.NaN, Double.NaN)), "no observations");
        long t = 3_000_000_000L;
        check(renderDue(-1, t), "first reading");
        check(!renderDue(t, t + 65_999_999L), "over 15 Hz");
        check(renderDue(t, t + 66_000_000L), "66 ms boundary");
        check(!renderDue(t, t), "duplicate delivery");
        check(!renderDue(t, t - 1), "out of order");
    }
    static void geometry() {
        near(rotationDestination(-270f, 0), -360, 1e-6);
        near(rotationDestination(-359f, -90), -450, 1e-6);
        near(rotationDestination(-91f, -90), -90, 1e-6);
        int[][] screens = {{412, 915, 1}, {915, 412, 1}, {1080, 2400, 3}};
        for (int[] screen : screens) {
            int w = screen[0], h = screen[1], d = screen[2];
            int pillW = 160*d, pillH = 28*d, top = 125*d, bottom = h - 115*d;
            int cy = safeCenterY(w, h, pillW, pillH, top, bottom);
            check(cy >= 0, "feasible safe area " + w + "x" + h);
            for (int angle=0; angle<360; angle++) {
                double cos = Math.cos(Math.toRadians(angle)), sin = Math.sin(Math.toRadians(angle));
                for (int sx : new int[]{-1, 1}) for (int sy : new int[]{-1, 1}) {
                    double x = sx*pillW/2.0, y = sy*pillH/2.0;
                    double px = w/2.0 + x*cos-y*sin, py = cy + x*sin+y*cos;
                    check(px>=0 && px<=w && py>=top && py<=bottom,
                            "pill intersects exclusion at " + angle + "°, " + px + "," + py);
                }
            }
        }
        check(safeCenterY(412, 320, 160, 28, 126, 240) == -1, "vertical collision");
        check(safeCenterY(150, 915, 160, 28, 126, 700) == -1, "side clipping");
        check(safeCenterY(0, 0, 160, 28, 126, 700) == -1, "layout pending");
    }
    public static void main(String[] args) {
        switch (args[0]) {
            case "format": format(); break;
            case "smoothing": smoothing(); break;
            case "geometry": geometry(); break;
            default: throw new AssertionError(args[0]);
        }
    }
}`;
const hostProbe = `package com.motorola.camera.custom;
import android.app.Activity;
import android.content.*;
import android.content.res.*;
import android.hardware.*;
import android.os.Handler;
import android.util.DisplayMetrics;
import android.view.*;
import android.widget.*;
import com.motorola.camera.settings.PersistBehavior;
import com.motorola.camera.settings.FastSettingsManager;
import com.google.android.gms.internal.mlkit_vision_common.zzkj;
import com.motorola.camera.settings.SettingsHelper;
import java.util.*;
import static com.motorola.camera.custom.CompassHudController.*;

public final class HudHostProbe {
    static void check(boolean ok, String message) {
        if (!ok) throw new AssertionError(message);
    }
    static final class Prefs implements SharedPreferences, SharedPreferences.Editor {
        final Map<String,Boolean> values = new HashMap<>();
        final Set<OnSharedPreferenceChangeListener> observers = new HashSet<>();
        String changed;
        public Editor edit() { return this; }
        public String getString(String key,String fallback) { return fallback; }
        public boolean getBoolean(String key,boolean fallback) { return values.getOrDefault(key, fallback); }
        public Editor putString(String key,String value) { throw new AssertionError("expected boolean"); }
        public Editor putBoolean(String key,boolean value) { values.put(key,value); changed=key; return this; }
        public void apply() {
            for (OnSharedPreferenceChangeListener l : new ArrayList<>(observers))
                l.onSharedPreferenceChanged(this, changed);
        }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { observers.add(l); }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { observers.remove(l); }
    }
    public static final class Rig extends Activity {
        final Resources res = new Resources() {
            public DisplayMetrics getDisplayMetrics() { DisplayMetrics m = new DisplayMetrics(); m.density=1; return m; }
            public Configuration getConfiguration() { Configuration cfg = new Configuration(); cfg.orientation=1; return cfg; }
        };
        final Root root = new Root(this);
        final Sensors sensors = new Sensors();
        boolean withLocation;
        final long fixTime = System.currentTimeMillis() - 1000;
        final android.location.LocationManager locations = new android.location.LocationManager() {
            public List<String> getProviders(boolean onlyEnabled) { return Arrays.asList(GPS_PROVIDER, PASSIVE_PROVIDER); }
            public boolean isProviderEnabled(String id) { return true; }
            public android.location.Location getLastKnownLocation(String provider) {
                if (!withLocation) return null;
                return new android.location.Location(provider) {
                    public double getLatitude() { return 42; }
                    public double getLongitude() { return -8; }
                    public long getTime() { return fixTime; }
                    public float getAccuracy() { return 12; }
                };
            }
        };
        public Object getSystemService(String name) {
            if (SENSOR_SERVICE.equals(name)) return sensors;
            if (LOCATION_SERVICE.equals(name)) return locations;
            return null;
        }
        public Resources getResources() { return res; }
        public <T extends View> T findViewById(int id) { return id == 0x7f0a0283 ? (T)root : null; }
    }
    public static final class Root extends RelativeLayout {
        final Rig rig;
        TextView pill;
        int count;
        Root(Rig rig) { super(rig); this.rig=rig; }
        public Context getContext() { return rig; }
        public Resources getResources() { return rig.getResources(); }
        public boolean post(Runnable r) { r.run(); return true; }
        public boolean isAttachedToWindow() { return true; }
        public int getWidth() { return 412; }
        public int getHeight() { return 915; }
        public void addView(View v) { addView(v, null); }
        public void addView(View v, ViewGroup.LayoutParams p) {
            check(pill == null, "pill attached twice");
            pill = (TextView)v;
            count++;
        }
        public void removeView(View v) { if (v == pill) pill = null; }
        public int getChildCount() { return pill == null ? 0 : 1; }
        public View getChildAt(int i) { return i == 0 ? pill : null; }
        public <T extends View> T findViewWithTag(Object tag) {
            return pill != null && Objects.equals(tag, pill.tag) ? (T)pill : null;
        }
    }
    static final class Sensors extends SensorManager {
        boolean rejectPrimary;
        SensorEventListener active;
        Sensor current;
        int registrations;
        final List<Integer> attempts = new ArrayList<>();
        public Sensor getDefaultSensor(int type) { return new Sensor() { public int getType() { return type; } }; }
        public boolean registerListener(SensorEventListener l, Sensor s, int rate) {
            return registerListener(l, s, rate, null);
        }
        public boolean registerListener(SensorEventListener l, Sensor s, int rate, Handler h) {
            check(rate == SENSOR_DELAY_UI, "unexpected sensor rate " + rate);
            int type = s.getType();
            check(type == Sensor.TYPE_ROTATION_VECTOR || type == Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR,
                    "unexpected sensor type " + type);
            attempts.add(type);
            if (type == Sensor.TYPE_ROTATION_VECTOR && rejectPrimary) return false;
            check(active == null, "duplicate subscription");
            active=l; current=s; registrations++; return true;
        }
        public void unregisterListener(SensorEventListener l) { if (l == active) { active=null; current=null; } }
    }
    static void lifecycle() {
        Rig rig = new Rig();
        Prefs prefs = new Prefs();
        PersistBehavior.preferences = prefs;
        check(isEnabled(rig), "default should be enabled");
        attach(rig); attach(rig);
        check(rig.root.count == 1 && rig.root.findViewWithTag("compass-hud-pill") != null, "attachment/tag");
        check(!rig.root.pill.clickable && !rig.root.pill.focusable, "pill intercepts input");
        check(rig.sensors.active == null, "sensor started before resume");
        onResume(); onResume(); refreshVisibility();
        check(rig.sensors.registrations == 1 && rig.sensors.current.getType() == Sensor.TYPE_ROTATION_VECTOR,
                "default rotation sensor");
        for (int mode : new int[]{1,2,4,6,24,29,35}) {
            SettingsHelper.mode = mode; onModeChanged();
            check(rig.sensors.active != null, "hidden viewfinder mode " + mode);
        }
        SettingsHelper.mode = 3; onModeChanged();
        check(rig.sensors.active == null && rig.root.pill.visibility == View.GONE, "slow motion still active");
        SettingsHelper.mode = 0; onModeChanged();
        check(rig.sensors.active != null, "photo did not restore");
        setEnabled(rig,false);
        check(Boolean.FALSE.equals(prefs.values.get("port_compass_hud")), "disabled preference");
        check(!isEnabled(rig) && rig.sensors.active == null && rig.root.pill.visibility == View.GONE,
                "disabled HUD still active");
        setEnabled(rig,true);
        check(isEnabled(rig) && rig.sensors.active != null, "enabled HUD did not resume");
        onPause(); onPause(); refreshVisibility(); onModeChanged();
        check(rig.sensors.active == null && rig.root.pill.visibility == View.GONE, "pause leaked listener/view");
        rig.sensors.rejectPrimary = true; rig.sensors.attempts.clear();
        onResume();
        check(rig.sensors.attempts.equals(Arrays.asList(Sensor.TYPE_ROTATION_VECTOR,
                Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR)) && rig.sensors.active != null, "missing fallback");
        Rig replacement = new Rig();
        attach(replacement);
        check(rig.sensors.active == null, "old activity still subscribed");
        onPause();
        check(replacement.sensors.active == null, "replacement listener leaked");
    }
    static void emit(Rig rig, int accuracy) throws Exception {
        deliver(rig.sensors.active, rig.sensors.current, accuracy);
    }
    static void deliver(SensorEventListener listener, Sensor sensor, int accuracy) throws Exception {
        check(listener != null, "cannot deliver to an inactive HUD");
        java.lang.reflect.Constructor<SensorEvent> ctor = SensorEvent.class.getDeclaredConstructor(int.class);
        ctor.setAccessible(true);
        SensorEvent e = ctor.newInstance(4);
        e.sensor = sensor; e.values[3]=1; e.accuracy=accuracy; e.timestamp=System.nanoTime();
        listener.onAccuracyChanged(e.sensor, accuracy);
        listener.onSensorChanged(e);
    }
    static void rendering() throws Exception {
        Rig rig = new Rig();
        PersistBehavior.preferences = new Prefs();
        attach(rig); onResume();
        emit(rig, 1);
        check(rig.root.pill.visibility == View.VISIBLE && rig.root.pill.color == 0xB8F1F0F4 &&
                rig.root.pill.label.toString().contains("Calibrar"), "low-confidence display: " + rig.root.pill.label);
        onPause(); onResume();
        emit(rig, 3);
        check(rig.root.pill.color == 0xFFF1F0F4 && rig.root.pill.label.toString().contains("N 0°")
                && !rig.root.pill.label.toString().contains("☀"), "heading without cached location");
        onPause();
        rig.withLocation=true;
        PersistBehavior.preferences.edit().putBoolean("com.motorola.camera.geo_location_state", false).apply();
        onResume();
        updateLatestEv100(14);
        emit(rig, 3);
        check(rig.root.pill.label.toString().contains("N 0°") && !rig.root.pill.label.toString().contains("☀"),
                "save-location OFF must keep magnetic heading and suppress solar lookup: " + rig.root.pill.label);
        PersistBehavior.preferences.edit().putBoolean("com.motorola.camera.geo_location_state", true).apply();
        onPause(); onResume();
        updateLatestEv100(14);
        emit(rig, 3);
        check(rig.root.pill.color == 0xFFFFCC80 && rig.root.pill.label.toString().contains("Contraluz"),
                "bright sun-aligned preview: " + rig.root.pill.label);
        onPause();
    }
    static void menusAndQueuedEvents() throws Exception {
        Rig rig = new Rig();
        Prefs prefs = new Prefs();
        PersistBehavior.preferences = prefs;
        attach(rig); onResume();
        SensorEventListener queued = rig.sensors.active;
        Sensor sensor = rig.sensors.current;
        onPause(); deliver(queued, sensor, 3);
        check(rig.root.pill.visibility == View.GONE && rig.sensors.active == null, "queued event after pause");
        onResume(); deliver(queued, sensor, 3);
        check(rig.root.pill.visibility == View.GONE, "old sensor revived a new preview");
        com.motorola.camera.settings.Setting more = FastSettingsManager.get(FastSettingsManager.MODE_MENU_SHOW);
        more.mValue = Boolean.TRUE;
        emit(rig, 3); // GL-only open without a View layout change.
        check(rig.sensors.active == null && rig.root.pill.visibility == View.GONE, "GL More menu");
        more.setValuePriv(Boolean.FALSE); // No Android layout or mode switch on GL-only close.
        check(rig.sensors.active != null, "automatic return from More");
        zzkj.open = true; refreshVisibility();
        check(rig.sensors.active == null, "quick settings");
        zzkj.open = false; refreshVisibility();
        emit(rig, 3);
        check(rig.root.pill.visibility == View.VISIBLE, "return from quick settings");
        prefs.edit().putBoolean("port_compass_hud", false).apply();
        check(rig.sensors.active == null && rig.root.pill.visibility == View.GONE, "external prefs disable");
        onPause();
    }
    public static void main(String[] args) throws Exception {
        if (args.length == 0) lifecycle();
        else if ("menus".equals(args[0])) menusAndQueuedEvents();
        else rendering();
    }
}`;
before(() => {
  work = mkdtempSync(join(tmpdir(), 'moto-compass-hud-'));
  const fixture = source(pkg + '/CompassSolarHelper', helperFixture);
  const compiled = join(work, 'production'), behavioral = join(work, 'behavioral');
  mkdirSync(compiled);
  mkdirSync(behavioral);
  const flags = ['--release', '11', '-encoding', 'UTF-8', '-sourcepath', stubs];
  productionClasses = compiled;
  const productionSources = [controller, existsSync(helper) ? helper : fixture];
  if (existsSync(helper)) productionSources.push(source(pkg + '/HudNativePoseProbe', nativePoses));
  run(javac, [...flags, '-d', compiled, ...productionSources]);
  // Keep the release-11 ABI check above independent of Android/Moto boundary doubles.
  run(javac, [...flags, '-d', behavioral, controller, fixture,
    source('com/motorola/camera/settings/SettingsHelper', modeFixture),
    source('com/motorola/camera/settings/PersistBehavior', prefsFixture),
    source('android/widget/TextView', textFixture),
    source('com/motorola/camera/settings/SettingChangeListener', `package com.motorola.camera.settings;
      public interface SettingChangeListener { void onChange(Setting setting); }`),
    source('com/motorola/camera/settings/Setting', `package com.motorola.camera.settings;
      public final class Setting {
        public Object mValue = Boolean.FALSE;
        public final java.util.Set<SettingChangeListener> mListeners = new java.util.concurrent.CopyOnWriteArraySet<>();
        public void setValuePriv(Object value) {
          mValue = value;
          for (SettingChangeListener listener : mListeners) listener.onChange(this);
        }
      }`),
    source('com/motorola/camera/settings/FastSettingsManager', `package com.motorola.camera.settings;
      public final class FastSettingsManager {
        public static final class Key {}
        public static final Key MODE_MENU_SHOW = new Key();
        private static final Setting more = new Setting();
        public static Setting get(Key key) { return key == MODE_MENU_SHOW ? more : null; }
      }`),
    source('com/google/android/gms/internal/mlkit_vision_common/zzkj',
      `package com.google.android.gms.internal.mlkit_vision_common;
       public final class zzkj {
         public static boolean open;
         public static boolean isControlPanelOpen() { return open; }
       }`),
    source('android/hardware/GeomagneticField', `package android.hardware;
      public final class GeomagneticField {
        public GeomagneticField(float lat,float lon,float altitude,long epochMillis) {}
        public float getDeclination() { return 0f; }
      }`),
    source(pkg + '/HudMathProbe', mathProbe),
    source(pkg + '/HudHostProbe', hostProbe)]);
  classpath = [behavioral, compiled].join(delimiter);
});
after(() => { if (work) rmSync(work, { recursive: true, force: true }); });

function probe(name, ...args) {
  run(java, ['-Dfile.encoding=UTF-8', '-cp', classpath, 'com.motorola.camera.custom.' + name, ...args]);
}
test('calibration, location, twilight and EV gate the heading and sun labels', () => probe('HudMathProbe', 'format'));
test('circular smoothing crosses north, and duplicate or fast renders are suppressed', () =>
  probe('HudMathProbe', 'smoothing'));
test('the full rotating pill clears top, capture and side exclusions or stays hidden', () =>
  probe('HudMathProbe', 'geometry'));
test('preview lifecycle, viewfinder modes, preferences and sensor fallback balance registrations', () =>
  probe('HudHostProbe'));
test('sensor events render dim, normal and backlit colors against cached location and AE inputs', () =>
  probe('HudHostProbe', 'render'));
test('menu transitions, external settings changes and queued sensor deliveries respect preview visibility', () =>
  probe('HudHostProbe', 'menus'));
test('Android upright north/east, front lens reversal and flat phone poses use real solar helper math',
  { skip: !existsSync(helper) && 'CompassSolarHelper source has not landed' }, () =>
    run(java, ['-cp', productionClasses, 'com.motorola.camera.custom.HudNativePoseProbe']));

