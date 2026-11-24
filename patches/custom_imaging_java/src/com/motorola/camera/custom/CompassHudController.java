// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.SystemClock;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.motorola.camera.settings.PersistBehavior;
import com.motorola.camera.settings.SettingsHelper;

import java.lang.ref.WeakReference;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/** Viewfinder overlay. The Activity calls attach on its UI thread after setContentView. */
public final class CompassHudController {
    public static final String PREF_KEY_ENABLED = "port_compass_hud";
    private static final String TAG = "compass-hud-pill";
    private static final int ROOT = 0x7f0a0283;
    private static final int SURFACE_GLASS = 0xE31B2029, BORDER_SUBTLE = 0x29FFFFFF;
    private static final int TEXT_PRIMARY = 0xFFF1F0F4, TEXT_SECONDARY = 0xB8F1F0F4, TEXT_WARN = 0xFFFFCC80;
    private static final long UI_INTERVAL_NS = 66_000_000L;
    private static final String BACKLIT = "☀ Contraluz";

    private static final String GEO_LOCATION_PREF = "com.motorola.camera.geo_location_state";
    private static WeakReference<Pill> current = new WeakReference<>(null);
    private static Thread uiThread;
    private static boolean resumed;
    private static int orientation;
    private static volatile Stream stream;
    private static SharedPreferences observedPrefs;
    private static final SharedPreferences.OnSharedPreferenceChangeListener PREF_CHANGE = (prefs, key) -> {
        if (key == null || PREF_KEY_ENABLED.equals(key) || GEO_LOCATION_PREF.equals(key)) {
            Stream active = stream;
            if (active != null) {
                active.lastFixCheck = -1L;
                active.lastPaint = -1L;
            }
            refreshVisibility();
        }
    };

    private CompassHudController() {}

    public static synchronized void attach(Activity camera) {
        View view = camera == null ? null : camera.findViewById(ROOT);
        Pill old = current.get();
        if (old != null && old.root == view) {
            refreshVisibility();
            return;
        }
        stopStream();
        if (old != null) {
            old.observeLayout(false);
            old.root.removeView(old);
        }
        current.clear();
        if (!(view instanceof RelativeLayout)) return;
        RelativeLayout root = (RelativeLayout) view;
        uiThread = Thread.currentThread();
        View tagged = root.findViewWithTag(TAG);
        Pill pill;
        if (tagged instanceof Pill) {
            pill = (Pill) tagged;
        } else {
            if (tagged != null) return;
            pill = new Pill(root);
            root.addView(pill, new RelativeLayout.LayoutParams(-2, pill.dp(28)));
        }
        current = new WeakReference<>(pill);
        refreshVisibility();
    }

    public static synchronized void onResume() {
        resumed = true;
        if (observedPrefs == null) {
            observedPrefs = PersistBehavior.getPreferences();
            if (observedPrefs != null) observedPrefs.registerOnSharedPreferenceChangeListener(PREF_CHANGE);
        }
        refreshVisibility();
    }

    public static synchronized void onPause() {
        resumed = false;
        stopStream();
        if (observedPrefs != null) observedPrefs.unregisterOnSharedPreferenceChangeListener(PREF_CHANGE);
        observedPrefs = null;
        refreshVisibility();
    }

    public static synchronized void onModeChanged() {
        stopStream();
        refreshVisibility();
    }

    public static synchronized void onOrientation(int degrees) {
        if (degrees < 0) return; // OrientationEventListener.ORIENTATION_UNKNOWN
        int quadrant = ((degrees % 360 + 45) / 90 * 90) % 360;
        if (quadrant == orientation) return;
        orientation = quadrant;
        refreshVisibility();
    }

    public static void updateLatestEv100(double ev100) {
        // AE runs on the capture thread. An expired subscription cannot seed the next camera's EV.
        Stream active = stream;
        if (active != null) active.ev100 = Double.isFinite(ev100) ? ev100 : Double.NaN;
    }

    public static boolean isEnabled(Context ctx) {
        SharedPreferences p = PersistBehavior.getPreferences();
        if (p == null) return true;
        try {
            return p.getBoolean(PREF_KEY_ENABLED, true);
        } catch (ClassCastException legacyString) {
            return Boolean.parseBoolean(p.getString(PREF_KEY_ENABLED, "true"));
        }
    }

    public static synchronized void setEnabled(Context ctx, boolean enabled) {
        if (!enabled) stopStream();
        SharedPreferences p = PersistBehavior.getPreferences();
        if (p != null) p.edit().putBoolean(PREF_KEY_ENABLED, enabled).apply();
        refreshVisibility();
    }

    public static boolean showsInCurrentMode() {
        if (Roadstr.menuOpen()) return false;
        if (SettingsHelper.isPhotoMode() || SettingsHelper.isPortraitMode()
                || SettingsHelper.isProPhotoMode() || SettingsHelper.isNightVisionMode()) return true;
        Object mode = call(Roadstr.CURRENT_MODE, null);
        // SettingsHelper.isVideoMode / isPanoramaMode / isHighMPRemosaicFamilyMode.
        if (mode instanceof Integer) {
            int id = (Integer) mode;
            return id == 1 || id == 2 || id == 0x1d || id == 0x23;
        }
        return SettingsHelper.isTenBitVideoMode();
    }

    public static synchronized void refreshVisibility() {
        Pill p = current.get();
        if (p == null) { stopStream(); return; }
        if (!resumed || !isEnabled(p.getContext())) stopStream();
        if (Thread.currentThread() == uiThread) reconcile();
        else p.root.post(CompassHudController::reconcile);
    }

    private static synchronized void reconcile() {
        Pill p = current.get();
        if (p == null) { stopStream(); return; }
        boolean enabled = resumed && isEnabled(p.getContext());
        p.observeLayout(enabled);
        if (!enabled || !p.root.isAttachedToWindow() || !p.previewShown() || !showsInCurrentMode()
                || p.panelShown() || !p.place()) {
            stopStream();
            p.triedSensor = false;
            p.hide();
            return;
        }
        boolean front = SettingsHelper.isCurrentFrontCamera();
        if (stream != null && stream.front != front) {
            stopStream();
        }
        if (stream == null && !p.triedSensor) {
            Object service = p.getContext().getSystemService(Context.SENSOR_SERVICE);
            if (service instanceof SensorManager) {
                SensorManager manager = (SensorManager) service;
                Stream next = new Stream(manager, front);
                if (next.register(Sensor.TYPE_ROTATION_VECTOR)
                        || next.register(Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR)) stream = next;
            }
            p.triedSensor = true;
        }
        if (stream == null || !Double.isFinite(stream.heading)) p.hide();
        p.rotateTo(-orientation);
    }

    private static void stopStream() {
        Stream old = stream;
        stream = null;
        if (old != null) {
            old.manager.unregisterListener(old);
        }
        Pill pill = current.get();
        if (pill != null) pill.triedSensor = false;
    }

    static boolean renderDue(long lastNs, long nowNs) {
        return nowNs >= 0 && (lastNs < 0 || (nowNs >= lastNs && nowNs - lastNs >= UI_INTERVAL_NS));
    }

    static double smoothHeading(double previous, double sample) {
        if (!Double.isFinite(sample)) return previous;
        double b = Math.toRadians(sample % 360);
        if (!Double.isFinite(previous)) return wrap(sample);
        double a = Math.toRadians(previous % 360);
        // Exactly opposite vectors have no preferred turn direction. Pick a quarter turn of the arc.
        if (Math.cos(b - a) < -0.999999) return wrap(previous + 0.25 * (wrap(sample - previous + 180) - 180));
        return wrap(Math.toDegrees(Math.atan2(0.75 * Math.sin(a) + 0.25 * Math.sin(b),
                0.75 * Math.cos(a) + 0.25 * Math.cos(b))));
    }

    static float rotationDestination(float currentDeg, int targetDeg) {
        return currentDeg + (float) wrap(targetDeg - currentDeg + 180) - 180;
    }

    private static double wrap(double degrees) {
        return ((degrees % 360) + 360) % 360;
    }

    /** The disk around the pill encloses all four corners throughout a rotation animation. */
    static int safeCenterY(int width, int height, int pillW, int pillH, int top, int bottom) {
        if (width <= 0 || height <= 0 || pillW <= 0 || pillH <= 0
                || top < 0 || bottom > height || bottom <= top) return -1;
        long radius = (long) Math.ceil(Math.hypot(pillW, pillH) * 0.5);
        if (radius * 2 > width || radius * 2 > bottom - top) return -1;
        return (int) (top + radius);
    }

    /** Input heading and solar azimuth must share a north reference. showSolar denotes a valid fix. */
    public static String formatHudText(CompassSolarHelper.OrientationReading r,
            CompassSolarHelper.SolarPosition sun, double ev100, boolean showSolar) {
        double heading = r == null ? Double.NaN : r.headingDeg;
        return label(r, heading, sun, ev100, showSolar, heading);
    }

    private static String label(CompassSolarHelper.OrientationReading r, double heading,
            CompassSolarHelper.SolarPosition sun, double ev, boolean showSolar, double trueCameraHeading) {
        if (r == null || !Double.isFinite(heading)) return "";
        String text = CompassSolarHelper.formatHeadingLabel(wrap(heading));
        if (r.accuracy < SensorManager.SENSOR_STATUS_ACCURACY_MEDIUM) return text + " · Calibrar";
        if (!showSolar || sun == null || !Double.isFinite(sun.azimuthDeg)
                || !Double.isFinite(sun.elevationDeg) || sun.elevationDeg <= -2 || sun.elevationDeg > 90) return text;
        if (Double.isFinite(trueCameraHeading) && Double.isFinite(ev) && ev >= 11.0 && Double.isFinite(r.pitchDeg)
                && Math.abs(r.pitchDeg) <= 90) {
            double angle = CompassSolarHelper.angularSeparationDeg(trueCameraHeading, r.pitchDeg,
                    sun.azimuthDeg, sun.elevationDeg);
            if (Double.isFinite(angle)
                    && CompassSolarHelper.isPhysicalOutdoorBacklit(ev, sun.elevationDeg, angle, r.accuracy))
                return text + " · " + BACKLIT;
        }
        return text + " · ☀ " + (sun.elevationDeg < 0 ? "↘ " : "↗ ") + Math.round(sun.elevationDeg) + "°";
    }

    // Android world coordinates are east/north/up. Some helper revisions expose an upright-camera
    // reference (east/up/south). Check an unambiguous level, north-pointing pose once so a native
    // ENU helper can also consume the original vector directly.
    private static final class SensorBasis {
        static final float HALF = (float) Math.sqrt(0.5);
        static final boolean UPRIGHT_REFERENCE = usesUprightReference();
        private static boolean usesUprightReference() {
            CompassSolarHelper.OrientationReading north = CompassSolarHelper.computeOrientation(
                    new float[]{HALF, 0, 0, HALF}, 4, 0, false, 3, 0);
            return north != null && Math.abs(north.pitchDeg - 90) < 0.1;
        }
    }

    static CompassSolarHelper.OrientationReading sensorOrientation(float[] values, int rotation,
            boolean front, int accuracy, long ns) {
        if (values == null || values.length < 3) return null;
        float x = values[0], y = values[1], z = values[2];
        double xyz = (double) x * x + (double) y * y + (double) z * z;
        float w = values.length >= 4 ? values[3] : (float) Math.sqrt(Math.max(0, 1 - xyz));
        double norm = xyz + (double) w * w;
        if (!Double.isFinite(norm) || Math.abs(norm - 1) > 0.02) return null;
        if (SensorBasis.UPRIGHT_REFERENCE) {
            // Left multiply by Rx(-90°), preserving the sensor's device basis and optical axis.
            float k = SensorBasis.HALF;
            values = new float[]{k * (x - w), k * (y + z), k * (z - y), k * (w + x)};
        }
        return CompassSolarHelper.computeOrientation(values, values.length, rotation, front, accuracy, ns);
    }

    private static final class Stream implements SensorEventListener {
        final SensorManager manager;
        final boolean front;
        volatile double ev100 = Double.NaN;
        double heading = Double.NaN, declination = Double.NaN;
        long lastSample = -1, lastPaint = -1, lastFixCheck = -1;
        CompassSolarHelper.SolarPosition sun;

        Stream(SensorManager manager, boolean front) { this.manager = manager; this.front = front; }

        boolean register(int type) {
            try {
                Sensor s = manager.getDefaultSensor(type);
                return s != null && manager.registerListener(this, s, SensorManager.SENSOR_DELAY_UI);
            } catch (RuntimeException unavailableSensor) { return false; }
        }

        public void onAccuracyChanged(Sensor sensor, int accuracy) { /* Each event carries its accuracy. */ }

        public void onSensorChanged(SensorEvent event) {
            synchronized (CompassHudController.class) {
                if (this != stream || event == null || event.values == null || event.values.length < 3
                        || event.timestamp <= lastSample) return;
                Pill p = current.get();
                if (p == null || !p.root.isAttachedToWindow()) { stopStream(); return; }
                lastSample = event.timestamp;
                CompassSolarHelper.OrientationReading r = sensorOrientation(
                        event.values, orientation, front, event.accuracy, event.timestamp);
                if (r == null || !Double.isFinite(r.headingDeg)) {
                    heading = Double.NaN;
                    p.hide();
                    return;
                }
                heading = smoothHeading(heading, r.headingDeg);
                long now = SystemClock.elapsedRealtimeNanos();
                if (!renderDue(lastPaint, now)) return;
                lastPaint = now;
                // More is a GL texture and can open without an Android layout traversal.
                if (Roadstr.menuOpen()) { reconcile(); return; }
                if (lastFixCheck < 0 || now - lastFixCheck >= 60_000_000_000L) {
                    lastFixCheck = now;
                    updateSun(p.getContext());
                }
                boolean trueNorth = Double.isFinite(declination);
                String text = label(r, trueNorth ? wrap(heading + declination) : heading,
                        sun, ev100, sun != null, trueNorth ? wrap(r.headingDeg + declination) : Double.NaN);
                p.display(text, r.accuracy < 2 ? TEXT_SECONDARY : text.endsWith(BACKLIT) ? TEXT_WARN : TEXT_PRIMARY);
            }
        }

        void updateSun(Context ctx) {
            sun = null;
            declination = Double.NaN;
            if (!isSaveLocationAllowed()) return;
            if (ctx.checkSelfPermission("android.permission.ACCESS_COARSE_LOCATION") != 0
                    && ctx.checkSelfPermission("android.permission.ACCESS_FINE_LOCATION") != 0) return;
            Object service = ctx.getSystemService(Context.LOCATION_SERVICE);
            if (!(service instanceof LocationManager)) return;
            LocationManager locations = (LocationManager) service;
            long now = System.currentTimeMillis();
            Location best = null;
            for (String provider : PROVIDERS) {
                try {
                    Location loc = locations.getLastKnownLocation(provider);
                    if (loc != null && validFix(loc, now) && (best == null || loc.getTime() > best.getTime()))
                        best = loc;
                } catch (IllegalArgumentException | SecurityException unavailableProvider) { /* Try next cache. */ }
            }
            if (best == null) return;
            sun = CompassSolarHelper.computeSolarPosition(best.getLatitude(), best.getLongitude(), now);
            // Rotation-vector north is magnetic, the solar ephemeris uses geographic north.
            try {
                Class<?> field = Class.forName("android.hardware.GeomagneticField");
                float alt = best.hasAltitude() && Double.isFinite(best.getAltitude()) ? (float) best.getAltitude() : 0;
                Object model = field.getConstructor(float.class, float.class, float.class, long.class)
                        .newInstance((float) best.getLatitude(), (float) best.getLongitude(), alt, now);
                declination = ((Number) field.getMethod("getDeclination").invoke(model)).doubleValue();
            } catch (ReflectiveOperationException unavailableModel) { /* Elevation remains usable. */ }
        }
    }

    private static final String[] PROVIDERS = {LocationManager.PASSIVE_PROVIDER, LocationManager.GPS_PROVIDER,
            LocationManager.NETWORK_PROVIDER};
    private static boolean validFix(Location loc, long now) {
        return Math.abs(loc.getLatitude()) <= 90 && Math.abs(loc.getLongitude()) <= 180
                && loc.getTime() > 0 && loc.getTime() <= now && now - loc.getTime() <= 3_600_000L;
    }

    private static final class Pill extends TextView {
        final RelativeLayout root;
        final Rect rootBounds = new Rect(), bounds = new Rect();
        boolean triedSensor, visible;
        int topMargin = -1, maximumWidth = -1, rotationTarget = Integer.MIN_VALUE;
        int color;
        Object layoutListener, menuListener;
        String lastText = "";

        Pill(RelativeLayout root) {
            super(root.getContext());
            this.root = root;
            setTag(TAG);
            setVisibility(View.GONE);
            setClickable(false);
            setFocusable(false);
            setSingleLine(true);
            setEllipsize(TextUtils.TruncateAt.END);
            setTextSize(11f);
            setTypeface(Typeface.SANS_SERIF, Typeface.BOLD);
            call(Sdk.FONT_FEATURES, this, "tnum");
            setGravity(Gravity.CENTER);
            setPadding(dp(8), 0, dp(8), 0);
            GradientDrawable glass = new GradientDrawable();
            glass.setColor(SURFACE_GLASS);
            glass.setCornerRadius(dp(14));
            glass.setStroke(Math.max(1, dp(1)), BORDER_SUBTLE);
            setBackground(glass);
        }

        int dp(int units) { return Math.round(units * root.getResources().getDisplayMetrics().density); }

        void hide() {
            if (visible) {
                visible = false;
                setVisibility(View.GONE);
            }
        }

        void display(String text, int tint) {
            if (!text.equals(lastText)) { setText(text); lastText = text; }
            if (color != tint) { setTextColor(tint); color = tint; }
            if (!visible) { visible = true; setVisibility(View.VISIBLE); }
        }

        boolean previewShown() {
            if (Sdk.IS_SHOWN == null) return true; // The JVM stub has no window visibility API.
            if (!shown(root)) return false;
            View preview = root.findViewById(0x7f0a0349);
            View tenBit = root.findViewById(0x7f0a034a);
            return (preview == null && tenBit == null) || shown(preview) || shown(tenBit);
        }

        boolean panelShown() {
            return (Roadstr.EFFECTS != null && root.findViewWithTag(Roadstr.EFFECTS) != null)
                    || shown(root.findViewById(0x7f0a0102)) // control_panel_recycler
                    || shown(root.findViewById(0x7f0a03ca)); // settings_root_view
        }

        private boolean shown(View view) {
            return view != null && Boolean.TRUE.equals(call(Sdk.IS_SHOWN, view));
        }

        boolean place() {
            int w = root.getWidth(), h = root.getHeight(), pillH = dp(28);
            // Keep the top controls, cutout and centered badge (88dp) clear even before inflation.
            int top = dp(124), bottom = h - dp(w > h ? 132 : 210);
            if (Boolean.TRUE.equals(call(Sdk.RECT, root, rootBounds))) {
                View badge = root.findViewWithTag("effects-hdr-badge");
                if (visibleBounds(badge)) {
                    int radius = (int) Math.ceil(Math.hypot(badge.getWidth(), badge.getHeight()) * 0.5);
                    int sweptBottom = Math.max(bounds.bottom, bounds.centerY() + radius);
                    top = Math.max(top, sweptBottom - rootBounds.top + dp(4));
                }
                View bar = root.findViewById(0x7f0a00bf); // capture_bar_layout
                if (visibleBounds(bar)) bottom = Math.min(bottom, bounds.top - rootBounds.top - dp(54));
                // The zero-height ConstraintLayout guideline shares the full-screen root's origin.
                View guide = root.findViewById(0x7f0a020f); // guideline_zoom_toggle_bar
                if (guide != null && guide.getTop() > 0) bottom = Math.min(bottom, guide.getTop() - dp(28));
                View zoom = root.findViewById(0x7f0a050b); // zoom_toggle_bar_button
                if (visibleBounds(zoom)) bottom = Math.min(bottom, bounds.top - rootBounds.top - dp(4));
            }
            // Leave two pixels for Android's integer centering and an odd measured width/height.
            int span = Math.min(w, bottom - top) - 2;
            if (span <= pillH) return false;
            int maxW = Math.min(dp(164), (int) Math.sqrt((double) span * span - (double) pillH * pillH));
            if (maxW < dp(60)) return false;
            int center = safeCenterY(w, h, maxW, pillH, top + 1, bottom - 1);
            if (center < 0) return false;
            int margin = center - pillH / 2;
            if (margin != topMargin || maxW != maximumWidth) {
                topMargin = margin;
                maximumWidth = maxW;
                call(Sdk.MAX_WIDTH, this, maxW);
                RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(Sdk.MAX_WIDTH == null ? maxW : -2, pillH);
                lp.addRule(RelativeLayout.ALIGN_PARENT_TOP);
                lp.addRule(RelativeLayout.CENTER_HORIZONTAL);
                lp.setMargins(0, margin, 0, 0);
                setLayoutParams(lp);
            }
            return true;
        }

        private boolean visibleBounds(View v) {
            return shown(v) && Boolean.TRUE.equals(call(Sdk.RECT, v, bounds));
        }

        void rotateTo(int target) {
            if (target == rotationTarget) return;
            boolean animate = visible && rotationTarget != Integer.MIN_VALUE;
            rotationTarget = target;
            Object angle = call(Sdk.ROTATION, this);
            if (animate && angle instanceof Number && Sdk.ANIMATE_TO != null) {
                float from = ((Number) angle).floatValue();
                Object animator = call(Sdk.ANIMATE, this);
                if (animator != null) {
                    call(Sdk.DURATION, animator, 160L);
                    if (call(Sdk.ANIMATE_TO, animator, rotationDestination(from, target)) != null) return;
                }
            }
            setRotation(target);
        }

        void observeLayout(boolean watch) {
            if (watch && menuListener == null && Roadstr.CHANGE != null) {
                // Moto invokes onChange under the Setting lock. Only queue UI work from that lock.
                menuListener = listener(Roadstr.CHANGE, "onChange", () -> root.post(CompassHudController::reconcile));
                Roadstr.observeMenus(menuListener, true);
            } else if (!watch && menuListener != null) {
                Roadstr.observeMenus(menuListener, false);
                menuListener = null;
            }
            if (watch == (layoutListener != null) || Sdk.LAYOUT_EVENT == null) return;
            Object tree = call(Sdk.TREE, root);
            if (tree == null) return;
            if (!watch) {
                call(Sdk.REMOVE_LAYOUT, tree, layoutListener);
                layoutListener = null;
                return;
            }
            // The listener follows this root through its first layout, resizes, and menu transitions.
            layoutListener = listener(Sdk.LAYOUT_EVENT, "onGlobalLayout", CompassHudController::reconcile);
            call(Sdk.ADD_LAYOUT, tree, layoutListener);
        }
    }

    private static Object listener(Class<?> contract, String event, Runnable action) {
        return Proxy.newProxyInstance(CompassHudController.class.getClassLoader(), new Class<?>[]{contract},
                (proxy, method, args) -> {
                    String name = method.getName();
                    if (name.equals(event)) { action.run(); return null; }
                    if (name.equals("hashCode")) return System.identityHashCode(proxy);
                    if (name.equals("equals")) return proxy == args[0];
                    return TAG;
                });
    }

    // These public Android APIs are present on ctwo but omitted from the port's compile-only stubs.
    private static final class Sdk {
        static final Method RECT = method(View.class, "getGlobalVisibleRect", Rect.class);
        static final Method IS_SHOWN = method(View.class, "isShown");
        static final Method FONT_FEATURES = method(TextView.class, "setFontFeatureSettings", String.class);
        static final Method MAX_WIDTH = method(TextView.class, "setMaxWidth", int.class);
        static final Method ROTATION = method(View.class, "getRotation");
        static final Method ANIMATE = method(View.class, "animate");
        static final Class<?> ANIMATOR = ANIMATE == null ? null : ANIMATE.getReturnType();
        static final Method ANIMATE_TO = method(ANIMATOR, "rotation", float.class);
        static final Method DURATION = method(ANIMATOR, "setDuration", long.class);
        static final Method TREE = method(View.class, "getViewTreeObserver");
        static final Class<?> OBSERVER = TREE == null ? null : TREE.getReturnType();
        static final Class<?> LAYOUT_EVENT = type("android.view.ViewTreeObserver$OnGlobalLayoutListener");
        static final Method ADD_LAYOUT = method(OBSERVER, "addOnGlobalLayoutListener", LAYOUT_EVENT);
        static final Method REMOVE_LAYOUT = method(OBSERVER, "removeOnGlobalLayoutListener", LAYOUT_EVENT);
    }

    // Roadstr's More menu is a GL surface. The quick-settings panel may be Compose or a RecyclerView.
    private static final class Roadstr {
        static final Method CURRENT_MODE = method(SettingsHelper.class, "getCurrentMode");
        static final Class<?> EFFECTS = type("com.motorola.camera.custom.EffectsUiController");
        static final Method QUICK_OPEN = method(type("com.google.android.gms.internal.mlkit_vision_common.zzkj"),
                "isControlPanelOpen"); // Local read of SettingsManager flags inside the APK.
        static final Class<?> FAST = type("com.motorola.camera.settings.FastSettingsManager");
        static final Class<?> SETTINGS = type("com.motorola.camera.settings.SettingsManager");
        static final Class<?> CHANGE = type("com.motorola.camera.settings.SettingChangeListener");
        static final Object MORE = setting(FAST, "MODE_MENU_SHOW");
        static final java.lang.reflect.Field VALUE = moreValue();

        static boolean menuOpen() {
            if (Boolean.TRUE.equals(call(QUICK_OPEN, null))) return true;
            try { return VALUE != null && Boolean.TRUE.equals(VALUE.get(MORE)); }
            catch (IllegalAccessException inaccessible) { return false; }
        }

        @SuppressWarnings("unchecked")
        static void observeMenus(Object callback, boolean add) {
            // FastSettingsManager has its own Setting map. Use the same monitor and mListeners set
            // as SettingsManager.registerChangeListener, including for the GL-only More menu.
            Object[] flags = {MORE, setting(SETTINGS, "CONTROL_PANEL"), setting(SETTINGS, "VIDEO_RESOLUTION_AND_FRAME_RATE"),
                    setting(SETTINGS, "VIDEO_SLOW_MO_RES_AND_FRAME_RATE")};
            for (Object flag : flags) {
                if (flag == null) continue;
                try {
                    synchronized (flag) {
                        java.util.Set<Object> listeners = (java.util.Set<Object>) flag.getClass().getField("mListeners").get(flag);
                        if (add) listeners.add(callback); else listeners.remove(callback);
                    }
                } catch (ReflectiveOperationException unavailable) { /* refreshVisibility still reads the flags. */ }
            }
        }

        private static Object setting(Class<?> owner, String name) {
            if (owner == null) return null;
            try {
                java.lang.reflect.Field key = owner.getField(name);
                return owner.getMethod("get", key.getType()).invoke(null, key.get(null));
            } catch (ReflectiveOperationException unavailable) { return null; }
        }

        private static java.lang.reflect.Field moreValue() {
            if (MORE == null) return null;
            try { return MORE.getClass().getField("mValue"); }
            catch (NoSuchFieldException unavailable) { return null; }
        }
    }

    private static boolean isSaveLocationAllowed() {
        try {
            SharedPreferences p = PersistBehavior.getPreferences();
            if (p != null) {
                try {
                    if (!p.getBoolean(GEO_LOCATION_PREF, true)) return false;
                } catch (ClassCastException legacyString) {
                    if ("false".equalsIgnoreCase(p.getString(GEO_LOCATION_PREF, "true"))) return false;
                }
            }
        } catch (RuntimeException ignored) {}
        return !Boolean.FALSE.equals(settingValue(Roadstr.setting(Roadstr.SETTINGS, "GEO_LOCATION_STATE")));
    }

    private static Object settingValue(Object setting) {
        if (setting == null) return null;
        try {
            return setting.getClass().getField("mValue").get(setting);
        } catch (ReflectiveOperationException ignored) {
            return null;
        }
    }

    private static Class<?> type(String name) {
        try { return Class.forName(name, false, CompassHudController.class.getClassLoader()); }
        catch (ClassNotFoundException unavailable) { return null; }
    }

    private static Method method(Class<?> owner, String name, Class<?>... args) {
        if (owner == null) return null;
        for (Class<?> arg : args) if (arg == null) return null;
        try { return owner.getMethod(name, args); }
        catch (NoSuchMethodException unavailable) { return null; }
    }

    private static Object call(Method m, Object receiver, Object... args) {
        if (m == null) return null;
        try { return m.invoke(receiver, args); }
        catch (ReflectiveOperationException unavailable) { return null; }
    }
}
