// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.RippleDrawable;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.HorizontalScrollView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.SeekBar;
import android.widget.TextView;
import com.motorola.camera.settings.PersistBehavior;
import com.motorola.camera.settings.SettingsHelper;
import java.lang.ref.WeakReference;

public final class EffectsUiController {
    private static final String[] LOOKS = {
        "Original", "Leica Authentic", "Leica Vibrant", "Leica B&W HC", "Zeiss Natural",
        "Zeiss T* Textured", "Google HDR+", "Black Pro-Mist 1/4", "CineStill 800T",
        "Fujifilm Classic Chrome", "Fujifilm Nostalgic Neg.", "Kodak Portra 400",
        "Ricoh GR Positive", "2000s Y2K CCD"
    };
    private static final String[] LOOK_BADGES = {
        "port_logo_none", "port_logo_leica", "port_logo_leica", "port_logo_leica",
        "port_logo_zeiss", "port_logo_zeiss", "port_logo_google", "port_logo_promist",
        "port_logo_cinestill", "port_logo_fujifilm", "port_logo_fujifilm", "port_logo_kodak",
        "port_logo_ricoh", "port_logo_ccd"
    };
    private static final String[] CATEGORY_KEYS = {
        "port_cat_all", "port_cat_optical", "port_cat_hdr", "port_cat_film", "port_cat_bokeh"
    };
    private static final String[] CATEGORY_FALLBACKS = {
        "All", "Optical", "HDR+", "Film", "Bokeh"
    };
    private static final String[] BOKEH = {
        "Stock", "Biotar Swirl", "Planar", "Sonnar Creamy", "Anamorphic Oval", "Triangular B-Speed"
    };
    private static final String[] BOKEH_BADGES = {
        "port_logo_bokeh", "port_logo_bokeh_biotar", "port_logo_bokeh_planar",
        "port_logo_bokeh_sonnar", "port_logo_bokeh_anamorphic", "port_logo_bokeh_bspeed"
    };
    private static final String HDR_BADGE = "effects-hdr-badge";
    private static final int SURFACE_GLASS = 0xE31B2029;
    private static final int SURFACE_CARD = 0xFF262A32;
    private static final int SURFACE_PILL = 0xFF30343B;
    private static final int TEXT_PRIMARY = 0xFFF1F0F4;
    private static final int TEXT_SECONDARY = 0xB8F1F0F4;
    private static final int TEXT_DARK_INK = 0xFF111318;
    private static final int TEXT_WARN = 0xFFFFCC80;
    private static final int BORDER_SUBTLE = 0x29FFFFFF;
    private static final int RIPPLE_LIGHT = 0x38FFFFFF;

    private static int orientation;
    private static int activeCategory;
    private static WeakReference<Activity> hostActivity = new WeakReference<>(null);
    private static WeakReference<RelativeLayout> root = new WeakReference<>(null);

    private EffectsUiController() {}

    public static void attach(Activity camera) {
        if (camera != null) hostActivity = new WeakReference<>(camera);
        View view = camera != null ? camera.findViewById(0x7f0a0283) : null;
        if (view instanceof RelativeLayout) root = new WeakReference<>((RelativeLayout) view);
        CompassHudController.attach(camera);
        refreshPreview();
    }

    public static boolean showsInCurrentMode() {
        return SettingsHelper.isPhotoMode() || SettingsHelper.isPortraitMode()
                || SettingsHelper.isProPhotoMode() || SettingsHelper.isNightVisionMode()
                || SettingsHelper.isTenBitVideoMode();
    }

    public static void onOrientation(int degrees) {
        orientation = degrees;
        CompassHudController.onOrientation(degrees);
        RelativeLayout parent = root.get();
        if (parent != null) parent.post(() -> {
            View badge = parent.findViewWithTag(HDR_BADGE);
            if (badge != null) badge.setRotation(-orientation);
            View sheet = parent.findViewWithTag(EffectsUiController.class);
            if (sheet != null && sheet.getLayoutParams() instanceof RelativeLayout.LayoutParams) {
                RelativeLayout.LayoutParams lp = (RelativeLayout.LayoutParams) sheet.getLayoutParams();
                int side = dp(parent, 12);
                lp.setMargins(side, 0, side, computeBottomMargin(parent));
                sheet.setLayoutParams(lp);
            }
        });
    }

    public static void dispatchTransition(String event) {
        if ("SHUTTER_BUTTON_DOWN".equals(event) || "SETTINGS_LIST_OPENED".equals(event)
                || "CAPTURE".equals(event) || "VIDEO_CAPTURE".equals(event)) dismiss();
        CompassHudController.refreshVisibility();
    }

    public static void dismiss() {
        RelativeLayout parent = root.get();
        if (parent != null) parent.post(() -> removeSheet(parent));
    }

    private static boolean removeSheet(RelativeLayout parent) {
        View existing = parent.findViewWithTag(EffectsUiController.class);
        if (existing == null) return false;
        LiveLookPreview.setCompare(false);
        parent.removeView(existing);
        CompassHudController.refreshVisibility();
        return true;
    }

    public static void toggleSelector() {
        RelativeLayout parent = root.get();
        if (parent != null) parent.post(() -> {
            if (!showsInCurrentMode()) {
                removeSheet(parent);
                return;
            }
            if (!removeSheet(parent) && parent.isAttachedToWindow()) {
                show(parent);
                CompassHudController.refreshVisibility();
            }
        });
    }

    private static void show(RelativeLayout parent) {
        Context context = parent.getContext();
        SharedPreferences preferences = PersistBehavior.getPreferences();
        if (preferences == null) return;
        int accent = resolveAccentColor(context);

        LinearLayout sheet = new LinearLayout(context);
        sheet.setTag(EffectsUiController.class);
        sheet.setOrientation(LinearLayout.VERTICAL);
        sheet.setBackground(roundedRect(SURFACE_GLASS, dp(parent, 24), dp(parent, 1), BORDER_SUBTLE));
        sheet.setElevation(dp(parent, 8));
        sheet.setClickable(true);
        sheet.setFocusable(true);
        int padH = dp(parent, 12);
        int padV = dp(parent, 10);
        sheet.setPadding(padH, padV, padH, dp(parent, 12));

        // Header strip: active profile/look status on start, compact rounded close circle on end.
        LinearLayout header = new LinearLayout(context);
        header.setOrientation(LinearLayout.HORIZONTAL);
        header.setGravity(Gravity.CENTER_VERTICAL);
        header.setPadding(dp(parent, 2), 0, dp(parent, 2), dp(parent, 6));

        TextView statusView = new TextView(context);
        statusView.setTextSize(12f);
        statusView.setMaxLines(1);
        statusView.setEllipsize(TextUtils.TruncateAt.END);
        LinearLayout.LayoutParams statusParams = new LinearLayout.LayoutParams(0, -2, 1f);
        header.addView(statusView, statusParams);

        TextView closeBtn = new TextView(context);
        closeBtn.setText("\u00D7");
        closeBtn.setTextSize(16f);
        closeBtn.setTextColor(TEXT_PRIMARY);
        closeBtn.setTypeface(Typeface.SANS_SERIF, Typeface.BOLD);
        closeBtn.setGravity(Gravity.CENTER);
        closeBtn.setContentDescription(str(context, "port_close_cd", "Close effects panel"));
        int closeSize = dp(parent, 28);
        closeBtn.setBackground(pillRipple(SURFACE_PILL, closeSize, dp(parent, 1), BORDER_SUBTLE));
        closeBtn.setClickable(true);
        closeBtn.setFocusable(true);
        closeBtn.setOnClickListener(view -> removeSheet(parent));
        header.addView(closeBtn, new LinearLayout.LayoutParams(closeSize, closeSize));
        sheet.addView(header, new LinearLayout.LayoutParams(-1, -2));

        // Category capsules row.
        LinearLayout categories = new LinearLayout(context);
        categories.setOrientation(LinearLayout.HORIZONTAL);
        categories.setGravity(Gravity.CENTER_VERTICAL);
        HorizontalScrollView categoryScroll = new HorizontalScrollView(context);
        categoryScroll.setHorizontalScrollBarEnabled(false);
        categoryScroll.addView(categories);
        LinearLayout.LayoutParams catScrollLp = new LinearLayout.LayoutParams(-1, -2);
        catScrollLp.setMargins(0, 0, 0, dp(parent, 8));
        sheet.addView(categoryScroll, catScrollLp);

        // Preset cards row.
        LinearLayout presets = new LinearLayout(context);
        presets.setOrientation(LinearLayout.HORIZONTAL);
        presets.setGravity(Gravity.CENTER_VERTICAL);
        HorizontalScrollView presetScroll = new HorizontalScrollView(context);
        presetScroll.setHorizontalScrollBarEnabled(false);
        presetScroll.addView(presets);
        LinearLayout.LayoutParams presetScrollLp = new LinearLayout.LayoutParams(-1, -2);
        presetScrollLp.setMargins(0, 0, 0, dp(parent, 8));
        sheet.addView(presetScroll, presetScrollLp);

        // Contextual notice (Bokeh mode hint or HDR10 preview notice).
        TextView noteView = new TextView(context);
        noteView.setTextSize(11.5f);
        noteView.setTextColor(TEXT_SECONDARY);
        noteView.setGravity(Gravity.START);
        noteView.setPadding(dp(parent, 10), dp(parent, 5), dp(parent, 10), dp(parent, 5));
        noteView.setBackground(roundedRect(SURFACE_PILL, dp(parent, 12), 0, 0));
        LinearLayout.LayoutParams noteLp = new LinearLayout.LayoutParams(-1, -2);
        noteLp.setMargins(0, 0, 0, dp(parent, 8));
        sheet.addView(noteView, noteLp);

        // Footer controls: Intensity slider + Hold to compare capsule.
        LinearLayout controls = new LinearLayout(context);
        controls.setOrientation(LinearLayout.HORIZONTAL);
        controls.setGravity(Gravity.CENTER_VERTICAL);

        LinearLayout sliderBox = new LinearLayout(context);
        sliderBox.setOrientation(LinearLayout.VERTICAL);
        TextView intensityText = new TextView(context);
        int intensity = CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_INTENSITY, 100, 100);
        intensityText.setTextColor(TEXT_PRIMARY);
        intensityText.setTextSize(12f);
        intensityText.setText(formatIntensity(context, intensity));
        sliderBox.addView(intensityText, new LinearLayout.LayoutParams(-1, -2));

        SeekBar slider = new SeekBar(context);
        slider.setContentDescription(str(context, "port_intensity_cd", "Filter intensity"));
        slider.setMax(100);
        slider.setProgress(intensity);
        ColorStateList accentList = ColorStateList.valueOf(accent);
        slider.setProgressTintList(accentList);
        slider.setThumbTintList(accentList);
        slider.setSplitTrack(false);
        slider.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                intensityText.setText(formatIntensity(context, progress));
                if (fromUser) {
                    store(preferences, CustomImagingBridge.LOOK_INTENSITY, progress);
                    updateStatus(context, statusView, accent);
                }
            }
            @Override public void onStartTrackingTouch(SeekBar bar) {}
            @Override public void onStopTrackingTouch(SeekBar bar) {}
        });
        sliderBox.addView(slider, new LinearLayout.LayoutParams(-1, -2));
        LinearLayout.LayoutParams sliderBoxLp = new LinearLayout.LayoutParams(0, -2, 1f);
        sliderBoxLp.setMargins(0, 0, dp(parent, 8), 0);
        controls.addView(sliderBox, sliderBoxLp);

        if (!SettingsHelper.isTenBitVideoMode()) {
            TextView compare = new TextView(context);
            String compareLabel = str(context, "port_hold_compare", "Hold to compare");
            compare.setText(compareLabel);
            compare.setContentDescription(compareLabel);
            compare.setTextColor(TEXT_PRIMARY);
            compare.setTextSize(12f);
            compare.setTypeface(Typeface.SANS_SERIF, Typeface.BOLD);
            compare.setGravity(Gravity.CENTER);
            compare.setMaxLines(1);
            compare.setClickable(true);
            compare.setFocusable(true);
            int capH = dp(parent, 38);
            int capPad = dp(parent, 14);
            compare.setPaddingRelative(capPad, 0, capPad, 0);
            compare.setMinimumHeight(capH);
            compare.setBackground(pillRipple(SURFACE_PILL, capH, dp(parent, 1), BORDER_SUBTLE));
            final boolean[] touchHeld = new boolean[1];
            final boolean[] toggleState = new boolean[1];
            Runnable syncCompareVisual = () -> {
                boolean active = toggleState[0];
                compare.setBackground(pillRipple(active ? withAlpha(accent, 0x33) : SURFACE_PILL,
                        capH, dp(parent, 1), active ? accent : BORDER_SUBTLE));
                compare.setTextColor(active ? accent : TEXT_PRIMARY);
            };
            compare.setOnTouchListener((view, event) -> {
                int action = event.getActionMasked();
                if (action == MotionEvent.ACTION_DOWN) {
                    touchHeld[0] = true;
                    toggleState[0] = true;
                    LiveLookPreview.setCompare(true);
                    syncCompareVisual.run();
                } else if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) {
                    toggleState[0] = false;
                    LiveLookPreview.setCompare(false);
                    syncCompareVisual.run();
                    if (action == MotionEvent.ACTION_UP) {
                        view.performClick();
                    }
                    touchHeld[0] = false;
                }
                return true;
            });
            compare.setOnClickListener(view -> {
                if (touchHeld[0]) return;
                toggleState[0] = !toggleState[0];
                LiveLookPreview.setCompare(toggleState[0]);
                syncCompareVisual.run();
            });
            controls.addView(compare, new LinearLayout.LayoutParams(-2, capH));
        }
        sheet.addView(controls, new LinearLayout.LayoutParams(-1, -2));

        boolean portraitMode = SettingsHelper.isPortraitMode();
        if (activeCategory < 0 || activeCategory >= CATEGORY_KEYS.length || (!portraitMode && activeCategory == 4)) {
            activeCategory = 0;
        }
        Runnable renderCategories = new Runnable() {
            @Override public void run() {
                buildCategories(context, categories, accent, () -> {
                    run();
                    populate(presets, preferences, activeCategory, accent, statusView, noteView, controls);
                    presetScroll.scrollTo(0, 0);
                });
            }
        };
        renderCategories.run();
        populate(presets, preferences, activeCategory, accent, statusView, noteView, controls);

        if (SettingsHelper.isTenBitVideoMode()) {
            categoryScroll.setVisibility(View.GONE);
            presetScroll.setVisibility(View.GONE);
        }
        RelativeLayout.LayoutParams bounds = new RelativeLayout.LayoutParams(-1, -2);
        bounds.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        int side = dp(parent, 12);
        bounds.setMargins(side, 0, side, computeBottomMargin(parent));
        parent.addView(sheet, bounds);
    }

    private static void buildCategories(Context context, LinearLayout row, int accent, Runnable onChanged) {
        row.removeAllViews();
        boolean portraitMode = SettingsHelper.isPortraitMode();
        int capH = dp(row, 34);
        int padH = dp(row, 14);
        int gap = dp(row, 6);
        for (int i = 0; i < CATEGORY_KEYS.length; i++) {
            if (i == 4 && !portraitMode) continue;
            final int category = i;
            boolean selected = category == activeCategory;
            TextView chip = new TextView(context);
            chip.setText(str(context, CATEGORY_KEYS[i], CATEGORY_FALLBACKS[i]));
            chip.setTextSize(12.5f);
            chip.setMaxLines(1);
            chip.setGravity(Gravity.CENTER);
            chip.setMinimumHeight(capH);
            chip.setPaddingRelative(padH, 0, padH, 0);
            chip.setClickable(true);
            chip.setFocusable(true);
            chip.setSelected(selected);
            if (selected) {
                chip.setTextColor(TEXT_DARK_INK);
                chip.setTypeface(Typeface.SANS_SERIF, Typeface.BOLD);
                chip.setBackground(pillRipple(accent, capH, 0, 0));
            } else {
                chip.setTextColor(TEXT_PRIMARY);
                chip.setTypeface(Typeface.SANS_SERIF, 0);
                chip.setBackground(pillRipple(SURFACE_PILL, capH, dp(row, 1), BORDER_SUBTLE));
            }
            chip.setOnClickListener(view -> {
                if (activeCategory == category) return;
                activeCategory = category;
                onChanged.run();
            });
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(-2, capH);
            if (i < CATEGORY_KEYS.length - 1) lp.setMargins(0, 0, gap, 0);
            row.addView(chip, lp);
        }
    }

    static boolean includes(int category, int look) {
        return look == 0 || category == 0 || (category == 1 && look <= 5)
                || (category == 2 && look == 6) || (category == 3 && look >= 7);
    }

    private static void populate(LinearLayout presets, SharedPreferences preferences, int category,
                                 int accent, TextView statusView, TextView noteView, LinearLayout controls) {
        Context context = presets.getContext();
        presets.removeAllViews();
        boolean bokeh = category == 4;
        String[] names = bokeh ? BOKEH : LOOKS;
        String[] badges = bokeh ? BOKEH_BADGES : LOOK_BADGES;
        String key = bokeh ? CustomImagingBridge.BOKEH_STYLE : CustomImagingBridge.LOOK_PRESET;
        int selected = CustomImagingBridge.effectPreference(key, 0, names.length - 1);

        int cardW = dp(presets, 96);
        int cardH = dp(presets, 76);
        int cardRadius = dp(presets, 16);
        int gap = dp(presets, 8);
        int iconSize = dp(presets, 28);
        int pad = dp(presets, 5);

        for (int i = 0; i < names.length; i++) {
            if (!bokeh && !includes(category, i)) continue;
            final int choice = i;
            boolean isSelected = i == selected;

            LinearLayout card = new LinearLayout(context);
            card.setOrientation(LinearLayout.VERTICAL);
            card.setGravity(Gravity.CENTER);
            card.setPadding(pad, pad, pad, pad);
            card.setClickable(true);
            card.setFocusable(true);
            card.setSelected(isSelected);
            int cardBg = isSelected ? withAlpha(accent, 0x2B) : SURFACE_CARD;
            int strokeW = dp(presets, isSelected ? 2 : 1);
            int strokeColor = isSelected ? accent : BORDER_SUBTLE;
            card.setBackground(new RippleDrawable(
                    ColorStateList.valueOf(RIPPLE_LIGHT),
                    roundedRect(cardBg, cardRadius, strokeW, strokeColor),
                    roundedRect(0xFFFFFFFF, cardRadius, 0, 0)));

            Drawable logo = resolveDrawable(context, badges[i]);
            if (logo != null) {
                ImageView icon = new ImageView(context);
                icon.setImageDrawable(logo);
                icon.setScaleType(ImageView.ScaleType.FIT_CENTER);
                LinearLayout.LayoutParams iconLp = new LinearLayout.LayoutParams(iconSize, iconSize);
                iconLp.setMargins(0, 0, 0, dp(presets, 4));
                card.addView(icon, iconLp);
            }

            String displayName = names[i];
            if (!bokeh && i == 0) displayName = str(context, "port_look_none", "Original");
            else if (bokeh && i == 0) displayName = str(context, "port_bokeh_stock", "Stock");

            TextView label = new TextView(context);
            label.setText(displayName);
            label.setTextSize(11f);
            label.setMaxLines(2);
            label.setEllipsize(TextUtils.TruncateAt.END);
            label.setGravity(Gravity.CENTER);
            label.setTextColor(isSelected ? accent : TEXT_PRIMARY);
            label.setTypeface(Typeface.SANS_SERIF, isSelected ? Typeface.BOLD : 0);
            card.addView(label, new LinearLayout.LayoutParams(-1, -2));

            card.setOnClickListener(view -> {
                if (!bokeh && choice > 0) {
                    CustomImagingBridge.clearStockMeishePhotoFilter();
                }
                store(preferences, key, choice);
                populate(presets, preferences, category, accent, statusView, noteView, controls);
            });
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(cardW, cardH);
            lp.setMargins(0, 0, gap, 0);
            presets.addView(card, lp);
        }

        if (SettingsHelper.isTenBitVideoMode()) {
            noteView.setText(str(context, "port_hdr10_notice", "Preview unavailable in HDR10 Video"));
            noteView.setTextColor(TEXT_SECONDARY);
            noteView.setTag(HDR_BADGE);
            noteView.setRotation(-orientation);
            noteView.setVisibility(View.VISIBLE);
        } else if (bokeh) {
            String msg = SettingsHelper.isPortraitMode()
                    ? str(context, "port_bokeh_portrait_active", "Applied when saving in Portrait mode")
                    : str(context, "port_bokeh_use_portrait", "Available in Portrait mode (pre-selected for Portrait)");
            noteView.setText(msg);
            noteView.setTextColor(TEXT_SECONDARY);
            noteView.setTag(null);
            noteView.setRotation(0f);
            noteView.setVisibility(View.VISIBLE);
        } else {
            updatePairingNote(context, noteView);
        }

        controls.setVisibility((SettingsHelper.isTenBitVideoMode() || bokeh) ? View.GONE : View.VISIBLE);
        updateStatus(context, statusView, accent);
    }

    private static void updatePairingNote(Context context, TextView noteView) {
        int profile = CustomImagingBridge.getSelectedProfile();
        int look = CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_PRESET, 0, LOOKS.length - 1);
        if (look == 0) {
            noteView.setVisibility(View.GONE);
            return;
        }
        String profileName = CustomImagingBridge.getProfileShortLabel(context, profile);
        String msg;
        if (ScenePostProcSelector.isProtectedProfile(profile)) {
            msg = strFmt(context, "port_pair_paused_fmt", "Uses %1$s only \u2014 Look paused", profileName);
        } else if (profile >= ScenePostProcSelector.PROFILE_IPHONE_NATURAL
                && profile <= ScenePostProcSelector.PROFILE_IPHONE_AMBER) {
            msg = strFmt(context, "port_pair_double_lut_fmt",
                    "2x LUT active: %1$s + Look (prefer Auto / Minimal)", profileName);
        } else if (ScenePostProcSelector.isDiffusionLook(look)) {
            msg = strFmt(context, "port_pair_diffusion_fmt",
                    "1x LUT + soft highlights/zoom (%1$s)", profileName);
        } else if (look == 6) {
            msg = strFmt(context, "port_pair_hdrplus_fmt",
                    "1x LUT + highlight roll-off (%1$s)", profileName);
        } else if (ScenePostProcSelector.isContrastFilmLook(look)) {
            msg = strFmt(context, "port_pair_film_fmt",
                    "1x LUT + crisp shadows (%1$s)", profileName);
        } else {
            msg = strFmt(context, "port_pair_active_fmt", "1x LUT paired with %1$s", profileName);
        }
        noteView.setText(msg);
        noteView.setTextColor(profile >= ScenePostProcSelector.PROFILE_IPHONE_NATURAL
                && profile <= ScenePostProcSelector.PROFILE_IPHONE_AMBER ? TEXT_WARN : TEXT_SECONDARY);
        noteView.setTag(null);
        noteView.setRotation(0f);
        noteView.setVisibility(View.VISIBLE);
    }

    private static void updateStatus(Context context, TextView statusView, int accent) {
        int profile = CustomImagingBridge.getSelectedProfile();
        String profileName = CustomImagingBridge.getProfileShortLabel(context, profile);
        boolean portraitMode = SettingsHelper.isPortraitMode();
        int look = CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_PRESET, 0, LOOKS.length - 1);
        int bokeh = portraitMode
                ? CustomImagingBridge.effectPreference(CustomImagingBridge.BOKEH_STYLE, 0, BOKEH.length - 1)
                : 0;
        int intensity = CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_INTENSITY, 100, 100);
        if (ScenePostProcSelector.isProtectedProfile(profile) && (look > 0 || bokeh > 0)) {
            statusView.setTextColor(TEXT_WARN);
            statusView.setText(strFmt(context, "port_look_paused_fmt", "Paused in %1$s", profileName));
            return;
        }
        statusView.setTextColor(look > 0 || bokeh > 0 ? accent : TEXT_SECONDARY);
        String lookLabel = look == 0 ? str(context, "port_look_none", "Original") : LOOKS[look];
        String line = (look == 0 && bokeh > 0) ? profileName : (profileName + " \u00B7 " + lookLabel);
        if (look > 0) line += " \u00B7 " + intensity + "%";
        if (bokeh > 0) line += " \u00B7 Bokeh: " + BOKEH[bokeh];
        statusView.setText(line);
    }

    private static void store(SharedPreferences preferences, String key, int value) {
        preferences.edit().putString(key, String.valueOf(value)).apply();
        refreshPreview();
    }

    static void refreshPreview() {
        int profile = CustomImagingBridge.getSelectedProfile();
        LiveLookPreview.setProfilePaused(ScenePostProcSelector.isProtectedProfile(profile));
        LiveLookPreview.select(
                CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_PRESET, 0, LOOKS.length - 1),
                CustomImagingBridge.effectPreference(CustomImagingBridge.LOOK_INTENSITY, 100, 100));
    }

    private static int computeBottomMargin(RelativeLayout parent) {
        Configuration cfg = parent.getResources().getConfiguration();
        boolean landscape = cfg != null && cfg.orientation == 2;
        int margin = dp(parent, landscape ? 132 : 210);
        if (SettingsHelper.isProPhotoMode()) {
            margin = Math.max(margin, dp(parent, landscape ? 180 : 405));
        }
        Resources res = parent.getResources();
        if (res != null && parent.getHeight() > 0) {
            String pkg = parent.getContext().getPackageName();
            Activity act = hostActivity.get();
            int capId = res.getIdentifier("capture_bar_layout", "id", pkg);
            View capBar = capId != 0 ? parent.findViewById(capId) : null;
            if (capBar == null && act != null && capId != 0) capBar = act.findViewById(capId);
            if (capBar != null && capBar.getTop() > 0 && parent.getHeight() > capBar.getTop()) {
                int aboveCapture = parent.getHeight() - capBar.getTop() + dp(parent, 54);
                margin = Math.max(margin, Math.min(dp(parent, 250), aboveCapture));
            }
            for (String trayName : new String[]{"pro_mode_slider_bar_layout", "portrait_bokeh_slider_bar_layout"}) {
                int trayId = res.getIdentifier(trayName, "id", pkg);
                View tray = trayId != 0 ? parent.findViewById(trayId) : null;
                if (tray == null && act != null && trayId != 0) tray = act.findViewById(trayId);
                if (tray != null && tray.getVisibility() == View.VISIBLE && tray.getTop() > 0 && parent.getHeight() > tray.getTop()) {
                    margin = Math.max(margin, parent.getHeight() - tray.getTop() + dp(parent, 12));
                }
            }
            int ceiling = Math.max(dp(parent, 132), parent.getHeight() - dp(parent, 320));
            margin = Math.min(margin, ceiling);
        }
        return margin;
    }

    private static int resolveAccentColor(Context context) {
        try {
            Resources res = context.getResources();
            int id = res.getIdentifier("primary_main", "color", context.getPackageName());
            if (id != 0) return res.getColor(id, null);
        } catch (Throwable ignored) {}
        return 0xFF8BEAFF;
    }

    private static Drawable resolveDrawable(Context context, String name) {
        if (name == null) return null;
        try {
            Resources res = context.getResources();
            int id = res.getIdentifier(name, "drawable", context.getPackageName());
            return id != 0 ? res.getDrawable(id, null) : null;
        } catch (Throwable ignored) {
            return null;
        }
    }

    private static String str(Context context, String key, String fallback) {
        try {
            Resources res = context.getResources();
            int id = res.getIdentifier(key, "string", context.getPackageName());
            if (id != 0) {
                String value = res.getString(id);
                if (value != null && !value.isEmpty()) return value;
            }
        } catch (Throwable ignored) {}
        return fallback;
    }

    private static String strFmt(Context context, String key, String fallbackFmt, Object arg) {
        try {
            Resources res = context.getResources();
            int id = res.getIdentifier(key, "string", context.getPackageName());
            if (id != 0) {
                String value = res.getString(id, arg);
                if (value != null && !value.isEmpty()) return value;
            }
        } catch (Throwable ignored) {}
        return String.format(fallbackFmt, arg);
    }

    private static String formatIntensity(Context context, int value) {
        return strFmt(context, "port_intensity_fmt", "Intensity %1$d%%", Integer.valueOf(value));
    }

    private static GradientDrawable roundedRect(int fill, int radius, int strokeWidth, int strokeColor) {
        GradientDrawable bg = new GradientDrawable();
        bg.setShape(GradientDrawable.RECTANGLE);
        bg.setColor(fill);
        bg.setCornerRadius(radius);
        if (strokeWidth > 0) bg.setStroke(strokeWidth, strokeColor);
        return bg;
    }

    private static Drawable pillRipple(int fill, int heightPx, int strokeWidth, int strokeColor) {
        int radius = Math.max(heightPx, dpRadius(heightPx));
        return new RippleDrawable(
                ColorStateList.valueOf(RIPPLE_LIGHT),
                roundedRect(fill, radius, strokeWidth, strokeColor),
                roundedRect(0xFFFFFFFF, radius, 0, 0));
    }

    private static int dpRadius(int sizePx) {
        return sizePx;
    }

    private static int withAlpha(int argb, int alphaByte) {
        return (argb & 0x00FFFFFF) | ((alphaByte & 0xFF) << 24);
    }

    private static int dp(View view, int value) {
        return Math.round(value * view.getResources().getDisplayMetrics().density);
    }
}
