// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.BlackLevelPattern;
import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.LensShadingMap;
import android.hardware.camera2.params.RggbChannelVector;
import android.util.Log;
import android.util.Rational;
import androidx.preference.ListPreference;
import androidx.preference.PreferenceFragmentCompat;
import com.motorola.camera.CameraData;
import com.motorola.camera.IqConfigManager;
import com.motorola.camera.capturedmediadata.CapturedImageMediaData;
import com.motorola.camera.fsm.camera.modes.RequestBuilderHelper;
import com.motorola.camera.fsm.camera.record.CaptureRecord;
import com.motorola.camera.fsm.camera.record.ImageCaptureRecord;
import com.motorola.camera.mcf.Mcf;
import com.motorola.camera.mcfmanagers.SceneModeManager;
import com.motorola.camera.photometadata.PhotoMetadata;
import com.motorola.camera.saving.SaveImageService;
import com.motorola.camera.settings.CameraType;
import com.motorola.camera.settings.PersistBehavior;
import com.motorola.camera.settings.SettingsHelper;
import com.motorola.camera.settings.SettingsManager;
import com.motorola.camera.storage.MediaFile;
import com.motorola.camera.storage.MediaFilePath;
import com.motorola.camera.storage.StorageUtils;
import com.motorola.camera.storage.backend.MediaStoreFile;
import com.motorola.camera.utility.ExifUtility;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.WeakHashMap;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * Android/Motorola runtime bridge for scene-adaptive post-processing, Apple-style LUT grading,
 * Pure ISP / MCF-Off capture overrides, and clean-room Bayer RAW JPEG export.
 */
public final class CustomImagingBridge {
    private static final String TAG = "CustomImagingBridge";
    public static final String PREF_KEY = "com.motorola.camera.post_processing_profile";
    private static final int STRIP_HEIGHT = 512;
    private static final int MAX_BAYER_PIXELS = 20_000_000;
    private static final int MAX_SHOT_CACHE = 512;
    private static final int JPEG_SAVE_QUALITY = 98;
    private static final boolean HTP_RPC_AVAILABLE = checkAdspRpcReadable();

    private static boolean checkAdspRpcReadable() {
        try {
            java.io.File dev = new java.io.File("/dev/adsprpc-smd");
            if (!dev.exists()) {
                return false;
            }
            try (java.io.FileInputStream ignored = new java.io.FileInputStream(dev)) {
                return true;
            } catch (Throwable denied) {
                return false;
            }
        } catch (Throwable ignored) {
            return false;
        }
    }

    private static final ExecutorService LUT_POOL = Executors.newFixedThreadPool(
            Math.min(4, Math.max(2, Runtime.getRuntime().availableProcessors() / 2)),
            new DaemonThreadFactory("CustomLutWorker"));
    private static final ExecutorService RAW_EXPORT_POOL = new ThreadPoolExecutor(
            1, 1, 0L, TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(2),
            new DaemonThreadFactory("CleanBayerWorker"),
            new ThreadPoolExecutor.CallerRunsPolicy());
    private static final Object RAW_EXPORT_SERIAL_LOCK = new Object();

    private static final class DaemonThreadFactory implements ThreadFactory {
        private final String prefix;
        private int count = 0;

        DaemonThreadFactory(String prefix) {
            this.prefix = prefix;
        }

        @Override
        public synchronized Thread newThread(Runnable r) {
            Thread t = new Thread(r, prefix + "-" + (++count));
            t.setDaemon(true);
            return t;
        }
    }

    private static final class ShotDecision {
        final int[] resolved;
        final String summary;
        final int profile;
        final float zoom;
        final float lux;

        ShotDecision(int[] resolved, String summary, int profile, float zoom, float lux) {
            this.resolved = resolved;
            this.summary = summary;
            this.profile = profile;
            this.zoom = zoom;
            this.lux = lux;
        }
    }

    private static final Map<CaptureRecord, ShotDecision> RECORD_DECISIONS = new WeakHashMap<>();
    private static final Map<Long, ShotDecision> SHOT_CACHE = new LinkedHashMap<Long, ShotDecision>(64, 0.75f, true) {
        @Override
        protected boolean removeEldestEntry(Map.Entry<Long, ShotDecision> eldest) {
            return size() > MAX_SHOT_CACHE;
        }
    };

    private static final CharSequence[] PROFILE_LABELS = {
        "Auto (W/O Stock · Clean HAL + LTM)",
        "Auto (W/ Stock · Native SuperRes/ISP)",
        "Natural ZSL (NR ZSL / Edge ZSL)",
        "Minimal ISP (NR Minimal / Edge Off)",
        "Detail HDR (RAW HDR / Low Halo)",
        "Pure ISP (MFNR Off / NR Off)",
        "iPhone Natural (Apple Style LUT)",
        "iPhone Rich Contrast (Apple Style)",
        "iPhone Amber (Warm Photonic LUT)",
        "Clean RAW Bayer (DNG -> Clean JPG)",
        "Disable Post Processing (MCF Off / Direct HAL)"
    };

    private static final CharSequence[] PROFILE_VALUES = {
        "0", "10", "1", "2", "3", "4", "5", "6", "7", "8", "9"
    };

    private CustomImagingBridge() {}

    private static int parseProfileIndex(String raw) {
        if (raw == null || raw.isEmpty()) return 0;
        try {
            int val = Integer.parseInt(raw.trim());
            return (val >= 0 && val <= 10) ? val : 0;
        } catch (Throwable ignored) {
            return 0;
        }
    }

    public static void initPostProcPreference(PreferenceFragmentCompat fragment) {
        if (fragment == null) return;
        try {
            ListPreference pref = (ListPreference) fragment.findPreference(PREF_KEY);
            if (pref == null) return;
            pref.setEntries(PROFILE_LABELS);
            pref.mEntryValues = PROFILE_VALUES;
            SharedPreferences prefs = PersistBehavior.getPreferences();
            String current = String.valueOf(parseProfileIndex(prefs != null ? prefs.getString(PREF_KEY, "0") : "0"));
            pref.setValue(current);
        } catch (Throwable t) {
            Log.w(TAG, "initPostProcPreference failed", t);
        }
    }

    public static int getSelectedProfile() {
        try {
            SharedPreferences prefs = PersistBehavior.getPreferences();
            if (prefs == null) return 0;
            return parseProfileIndex(prefs.getString(PREF_KEY, "0"));
        } catch (Throwable ignored) {
            return 0;
        }
    }

    public static boolean shouldAllowMcf(boolean origAllow) {
        return origAllow && getSelectedProfile() != ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING;
    }

    public static int resolveJpegQuality(int origQuality) {
        return origQuality == 95 ? JPEG_SAVE_QUALITY : origQuality;
    }

    private static long captureKey(CaptureRecord record) {
        if (record == null) return 0L;
        if (record.mSeqId != null) {
            long seq = record.mSeqId.mSeqId & 0xFFFFFFFFL;
            long uuidMix = (record.mUUID & 0x7FFFFFFFL) << 32;
            long key = uuidMix | seq;
            return key != 0L ? key : 1L;
        }
        long idHash = System.identityHashCode(record) & 0xFFFFFFFFL;
        long key = ((record.mUUID & 0x7FFFFFFFL) << 32) | idHash | 0x80000000_00000000L;
        return key != 0L ? key : -1L;
    }

    private static boolean isFlashExpectedSafe() {
        try {
            return SceneModeManager.isFlashExpected();
        } catch (Throwable ignored) {
            return false;
        }
    }

    private static boolean isUiSpecialModeSafe() {
        try {
            return SettingsHelper.isPortraitMode() || SettingsHelper.isSuperNightMode();
        } catch (Throwable ignored) {
            return false;
        }
    }

    private static ShotDecision resolveDecision(Mcf.SceneMode scene, boolean isFlash, boolean isUiSpecial) {
        float zoom = 1.0f;
        float lux = 50.0f;
        try {
            CameraType camType = SettingsManager.getCurrentCameraType();
            if (camType != null) {
                float z = SettingsManager.getZoomValue(camType);
                // SettingsManager.ZOOM stores the inverse crop ratio (1 / displayZoom, e.g. 0.333 for 3x).
                if (Float.isFinite(z) && z > 0.002f) zoom = 1.0f / z;
            }
        } catch (Throwable ignored) {}
        try {
            IqConfigManager iq = IqConfigManager.getInstance();
            // Treat uninitialized 0.0f lux index as nominal daylight 50.0f.
            if (iq != null && Float.isFinite(iq.mLastLuxIdx) && iq.mLastLuxIdx > 0f) {
                lux = iq.mLastLuxIdx;
            }
        } catch (Throwable ignored) {}

        String name = scene != null ? scene.name() : "";
        int profile = getSelectedProfile();
        int[] res = ScenePostProcSelector.resolveExtended(profile, zoom, lux, name, isFlash, isUiSpecial, HTP_RPC_AVAILABLE);
        String summary = "Edge50Port v1.6.0 p=" + profile
                + " z=" + (Math.round(zoom * 10f) / 10f)
                + " lux=" + Math.round(lux)
                + " act=" + res[0] + " nr=" + res[1] + " edge=" + res[2]
                + " mfnr=" + res[3] + " sz=" + res[4] + " lut=" + res[5] + " raw=" + res[6]
                + (res[7] >= 0 ? (" isz=" + res[7]) : "")
                + (res[8] >= 0 ? (" aide=" + res[8]) : "")
                + (res[9] > 0 ? (" vsr=" + res[9]) : "")
                + (res[10] >= 0 ? (" hdr=" + res[10]) : "")
                + (res[11] == 1 ? " t2w=0" : "")
                + (res[12] == 1 ? " qll=1" : "")
                + (profile == ScenePostProcSelector.PROFILE_AUTO_STOCK ? " stock=1" : "")
                + (profile == ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING ? " mcf=0" : "")
                + (!HTP_RPC_AVAILABLE ? " htp=0" : "")
                + (name.isEmpty() ? "" : " in=" + name)
                + (isFlash ? " flash=1" : "");
        return new ShotDecision(res, summary, profile, zoom, lux);
    }

    private static int[] resolveActiveScene(boolean isFlash) {
        boolean flash = isFlash || isFlashExpectedSafe();
        boolean uiSpecial = isUiSpecialModeSafe();
        Mcf.SceneMode scene = null;
        try {
            scene = SceneModeManager.getCurrentScene();
        } catch (Throwable ignored) {}
        return resolveDecision(scene, flash, uiSpecial).resolved;
    }

    private static ShotDecision getOrComputeDecision(CaptureRecord record, Mcf.SceneMode sceneOverride,
                                                     boolean flashHint, boolean uiSpecial) {
        if (record == null) {
            Mcf.SceneMode scene = sceneOverride;
            if (scene == null) {
                try {
                    scene = SceneModeManager.getCurrentScene();
                } catch (Throwable ignored) {}
            }
            return resolveDecision(scene, flashHint, uiSpecial);
        }
        long key = captureKey(record);
        synchronized (SHOT_CACHE) {
            ShotDecision cached = RECORD_DECISIONS.get(record);
            if (cached != null) {
                return cached;
            }
            cached = SHOT_CACHE.get(key);
            if (cached != null) {
                RECORD_DECISIONS.put(record, cached);
                return cached;
            }
            Mcf.SceneMode scene = sceneOverride;
            boolean effectiveFlash = flashHint;
            if (record instanceof ImageCaptureRecord) {
                ImageCaptureRecord imgRec = (ImageCaptureRecord) record;
                if (scene == null) scene = imgRec.mSceneMode;
                if (imgRec.mIsFlash) effectiveFlash = true;
            }
            if (scene == null) {
                try {
                    scene = SceneModeManager.getCurrentScene();
                } catch (Throwable ignored) {}
            }
            ShotDecision dec = resolveDecision(scene, effectiveFlash, uiSpecial);
            RECORD_DECISIONS.put(record, dec);
            SHOT_CACHE.put(key, dec);
            return dec;
        }
    }

    private static ShotDecision getOrResolveForContainer(SaveImageService.ImageContainer container) {
        CaptureRecord record = (container != null && container.mMediaData != null)
                ? container.mMediaData.mCaptureRecord
                : null;
        return getOrComputeDecision(record, null, isFlashExpectedSafe(), isUiSpecialModeSafe());
    }

    public static Mcf.SceneMode overrideSceneMode(Mcf.SceneMode origScene, boolean isFlash) {
        try {
            if (getSelectedProfile() == ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING) {
                return origScene;
            }
            boolean effectiveFlash = isFlash || isFlashExpectedSafe();
            boolean uiSpecial = isUiSpecialModeSafe();
            ShotDecision dec = resolveDecision(origScene, effectiveFlash, uiSpecial);
            if (dec.resolved[0] == ScenePostProcSelector.SCENE_HAL_FRAME_STACK) {
                return Mcf.SceneMode.HAL_FRAME_STACK;
            }
            if (dec.resolved[0] == ScenePostProcSelector.SCENE_RAW_HDR) {
                return Mcf.SceneMode.RAW_HDR;
            }
        } catch (Throwable t) {
            Log.w(TAG, "overrideSceneMode fallback", t);
        }
        return origScene;
    }

    public static int resolveNoiseReduction(int origNr) {
        int v = resolveActiveScene(false)[1];
        return v >= 0 ? v : origNr;
    }

    public static int resolveEdgeMode(int origEdge) {
        int v = resolveActiveScene(false)[2];
        return v >= 0 ? v : origEdge;
    }

    public static byte resolveSuperZoom(byte origSuperZoom) {
        int v = resolveActiveScene(false)[4];
        return v >= 0 ? (byte) v : origSuperZoom;
    }

    public static boolean resolveEnableMfnr(boolean origEnable) {
        return resolveEnableMfnr(origEnable, isFlashExpectedSafe());
    }

    public static boolean resolveEnableMfnr(boolean origEnable, boolean isFlash) {
        int v = resolveActiveScene(isFlash)[3];
        return v >= 0 ? (v != 0) : origEnable;
    }

    public static boolean shouldAllowInSensorCrop() {
        int profile = getSelectedProfile();
        return profile != ScenePostProcSelector.PROFILE_PURE_ISP
                && profile != ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING;
    }

    private static final String KEY_ENABLE_ISZ = "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom";
    private static final String KEY_ENABLE_SNAPSHOT_ISZ = "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom";
    private static final String KEY_ENABLE_XCFA = "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization";
    private static final String KEY_ENABLE_MFNR_AIDE = "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode";
    private static final String KEY_ENABLE_VSR = "org.codeaurora.qcamera3.sessionParameters.EnableVSR";
    private static final String KEY_ENABLE_AUTO_HDR = "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR";
    private static final String KEY_ENABLE_MFHDR = "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR";
    private static final String KEY_ENABLE_SHDR = "org.codeaurora.qcamera3.sessionParameters.EnableSHDR";
    private static final String KEY_ENABLE_QHDR = "org.codeaurora.qcamera3.sessionParameters.EnableQHDR";
    private static final String KEY_HDR_MODE = "org.codeaurora.qcamera3.sessionParameters.HDRMode";
    private static final String KEY_SNAPSHOT_HDR_MODE = "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode";
    private static final String KEY_HDR_MODE_PREF = "org.codeaurora.qcamera3.sessionParameters.HDRModePreference";
    private static final String KEY_ENABLE_QLL = "org.codeaurora.qcamera3.sessionParameters.enableQLL";
    private static final String KEY_SAT_FALLBACK_T2W = "com.lenovo.moto.SATFallback.T2W";

    private static final Set<String> KNOWN_SESSION_KEYS = Collections.unmodifiableSet(new HashSet<>(Arrays.asList(
            KEY_ENABLE_ISZ,
            KEY_ENABLE_SNAPSHOT_ISZ,
            KEY_ENABLE_XCFA,
            KEY_ENABLE_MFNR_AIDE,
            KEY_ENABLE_VSR,
            KEY_ENABLE_AUTO_HDR,
            KEY_ENABLE_MFHDR,
            KEY_ENABLE_SHDR,
            KEY_ENABLE_QHDR,
            KEY_HDR_MODE,
            KEY_HDR_MODE_PREF,
            KEY_ENABLE_QLL,
            KEY_SAT_FALLBACK_T2W
    )));

    private static final Map<CameraCharacteristics, Set<String>> REQ_KEY_CACHE =
            Collections.synchronizedMap(new WeakHashMap<>());
    private static final Map<CameraCharacteristics, Set<String>> SES_KEY_CACHE =
            Collections.synchronizedMap(new WeakHashMap<>());

    private static Set<String> getKeyNames(CameraCharacteristics chars, boolean sessionKeys) {
        if (chars == null) return Collections.emptySet();
        Map<CameraCharacteristics, Set<String>> cache = sessionKeys ? SES_KEY_CACHE : REQ_KEY_CACHE;
        Set<String> cached = cache.get(chars);
        if (cached != null) return cached;
        Set<String> names = new HashSet<>();
        boolean querySucceeded = false;
        try {
            List<CaptureRequest.Key<?>> list = sessionKeys
                    ? chars.getAvailableSessionKeys()
                    : chars.getAvailableCaptureRequestKeys();
            if (list != null) {
                querySucceeded = true;
                for (CaptureRequest.Key<?> key : list) {
                    if (key != null && key.getName() != null) {
                        names.add(key.getName());
                    }
                }
            }
        } catch (Throwable ignored) {}
        Set<String> unmodifiable = Collections.unmodifiableSet(names);
        if (querySucceeded && (!sessionKeys || !unmodifiable.isEmpty())) {
            cache.put(chars, unmodifiable);
        }
        return unmodifiable;
    }

    private static <T> void setVendorKeyIfSupported(CaptureRequest.Builder builder, Set<String> supported,
                                                    String keyName, Class<T> valueType, T value) {
        if (builder == null || supported == null || !supported.contains(keyName)) {
            return;
        }
        try {
            CaptureRequest.Key<T> key = new CaptureRequest.Key<>(keyName, valueType);
            builder.set(key, value);
        } catch (Throwable ignored) {}
    }

    /**
     * Session parameters are only cleared for explicit Pure ISP / Disable PostProc modes;
     * never force MFHDR/VSR at CreateCaptureSession time because Chi MCXSuperFG streaming
     * preview fails WalkAllExtSinkLinks when HDRFeatureMode=2 is forced on SDR sessions.
     */
    public static void applySessionParameterOverrides(String cameraId, CaptureRequest.Builder builder) {
        if (builder == null || cameraId == null) return;
        try {
            int profile = getSelectedProfile();
            if (profile != ScenePostProcSelector.PROFILE_DISABLE_POST_PROCESSING
                    && profile != ScenePostProcSelector.PROFILE_PURE_ISP) {
                return;
            }
            CameraCharacteristics chars = SettingsManager.getCharacteristics(cameraId);
            if (chars == null) return;
            Set<String> sesKeys = getKeyNames(chars, true);
            if (sesKeys.isEmpty()) return;

            setVendorKeyIfSupported(builder, sesKeys, KEY_ENABLE_AUTO_HDR, Integer.class, Integer.valueOf(0));
            setVendorKeyIfSupported(builder, sesKeys, KEY_ENABLE_MFHDR, Integer.class, Integer.valueOf(0));
            setVendorKeyIfSupported(builder, sesKeys, KEY_ENABLE_VSR, Integer.class, Integer.valueOf(0));
            setVendorKeyIfSupported(builder, sesKeys, KEY_ENABLE_MFNR_AIDE, Byte.class, Byte.valueOf((byte) 0));
            setVendorKeyIfSupported(builder, sesKeys, KEY_ENABLE_QLL, Integer.class, Integer.valueOf(0));
        } catch (Throwable t) {
            Log.w(TAG, "applySessionParameterOverrides failed", t);
        }
    }

    public static void applyCaptureRequestOverrides(String cameraId, CaptureRequest.Builder builder) {
        applyCaptureRequestOverrides(cameraId, builder, null);
    }

    public static void applyCaptureRequestOverrides(String cameraId, CaptureRequest.Builder builder,
                                                    CaptureRecord record) {
        if (builder == null || cameraId == null) return;
        try {
            boolean isFlash = isFlashExpectedSafe();
            Integer flash = builder.get(CaptureRequest.FLASH_MODE);
            if (flash != null && flash.intValue() != 0) {
                isFlash = true;
            } else {
                Integer aeMode = builder.get(CaptureRequest.CONTROL_AE_MODE);
                if (aeMode != null && aeMode.intValue() == 3) {
                    isFlash = true;
                }
            }
            Mcf.SceneMode sceneHint = null;
            if (record instanceof ImageCaptureRecord) {
                ImageCaptureRecord imgRec = (ImageCaptureRecord) record;
                sceneHint = imgRec.mSceneMode;
                if (imgRec.mIsFlash) {
                    isFlash = true;
                }
            }

            ShotDecision dec = getOrComputeDecision(record, sceneHint, isFlash, isUiSpecialModeSafe());
            int[] r = dec.resolved;
            int nr = r[1];
            int edge = r[2];
            int enableMfnr = r[3];

            CameraCharacteristics chars = SettingsManager.getCharacteristics(cameraId);
            if (chars != null) {
                if (nr >= 0) {
                    int[] availNr = chars.get(CameraCharacteristics.NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES);
                    if (SettingsHelper.isContainedInArray(availNr, nr)) {
                        builder.set(CaptureRequest.NOISE_REDUCTION_MODE, Integer.valueOf(nr));
                    }
                }
                if (edge >= 0) {
                    int[] availEdge = chars.get(CameraCharacteristics.EDGE_AVAILABLE_EDGE_MODES);
                    if (SettingsHelper.isContainedInArray(availEdge, edge)) {
                        builder.set(CaptureRequest.EDGE_MODE, Integer.valueOf(edge));
                    }
                }

                // Only write vendor keys that are true per-request keys (absent from
                // getAvailableSessionKeys()): mutating any session key on a CaptureRequest forces
                // Camera3Device::isReconfigurationRequired -> mid-shot reconfigureCamera() ->
                // MCXSuperFG (-38) teardown on SM8635 Moto HAL.
                Set<String> reqKeys = getKeyNames(chars, false);
                Set<String> sesKeys = getKeyNames(chars, true);
                Set<String> reqOnlyKeys;
                if (reqKeys.isEmpty()) {
                    reqOnlyKeys = Collections.emptySet();
                } else {
                    reqOnlyKeys = new HashSet<>(reqKeys);
                    reqOnlyKeys.removeAll(sesKeys);
                    // Fail closed if getAvailableSessionKeys() returns empty or fails.
                    if (sesKeys.isEmpty()) {
                        reqOnlyKeys.removeAll(KNOWN_SESSION_KEYS);
                    }
                }
                if (!reqOnlyKeys.isEmpty() && r.length >= 13) {
                    int iszMode = r[7];
                    int aideMode = r[8];
                    int vsrMode = r[9];
                    int hdrMode = r[10];
                    int t2wLock = r[11];
                    int qllMode = r[12];

                    if (iszMode >= 0) {
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_SNAPSHOT_ISZ, Integer.class, Integer.valueOf(iszMode));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_XCFA, Byte.class, Byte.valueOf((byte) iszMode));
                        if (iszMode == 0) {
                            setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_ISZ, Integer.class, Integer.valueOf(0));
                        }
                    }
                    if (aideMode >= 0) {
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_MFNR_AIDE, Byte.class, Byte.valueOf((byte) aideMode));
                    }
                    if (vsrMode >= 0) {
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_VSR, Integer.class, Integer.valueOf(vsrMode));
                    }
                    if (hdrMode >= 0) {
                        int hdrEnable = hdrMode > 0 ? 1 : 0;
                        int mfHdrVal = hdrMode > 0 ? 2 : 0;
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_AUTO_HDR, Integer.class, Integer.valueOf(hdrEnable));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_MFHDR, Integer.class, Integer.valueOf(hdrEnable));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_HDR_MODE, Integer.class, Integer.valueOf(mfHdrVal));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_SNAPSHOT_HDR_MODE, Integer.class, Integer.valueOf(hdrMode));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_HDR_MODE_PREF, Integer.class, Integer.valueOf(mfHdrVal));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_SHDR, Integer.class, Integer.valueOf(0));
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_QHDR, Integer.class, Integer.valueOf(0));
                    }
                    if (t2wLock == 1) {
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_SAT_FALLBACK_T2W, Byte.class, Byte.valueOf((byte) 0));
                    }
                    if (qllMode >= 0) {
                        setVendorKeyIfSupported(builder, reqOnlyKeys, KEY_ENABLE_QLL, Integer.class, Integer.valueOf(qllMode));
                    }
                }
            }
            if (enableMfnr == 0) {
                RequestBuilderHelper.setMfnr(cameraId, builder, false, isFlash);
            }
        } catch (Throwable t) {
            Log.w(TAG, "applyCaptureRequestOverrides failed", t);
        }
    }

    public static boolean isCustomLutActive() {
        return resolveActiveScene(false)[5] > 0;
    }

    public static boolean isCustomLutActive(SaveImageService.ImageContainer container) {
        if (container != null && container.mMediaData != null && container.mMediaData.isRawData()) {
            return false;
        }
        return getOrResolveForContainer(container).resolved[5] > 0;
    }

    private static void stampExifDescription(SaveImageService.ImageContainer container, byte[] jpegBytes,
                                             PhotoMetadata origMeta, String summary) {
        try {
            if (origMeta != null && !origMeta.isUltraHdr() && summary != null && !summary.isEmpty()) {
                origMeta.setAttribute("ImageDescription", summary);
                ByteArrayOutputStream exifOut = new ByteArrayOutputStream(jpegBytes.length + 1024);
                origMeta.saveJpegAttributes(new ByteArrayInputStream(jpegBytes), exifOut, false);
                byte[] stamped = exifOut.toByteArray();
                if (stamped.length > 64) {
                    container.mMediaData.setByteBuffer(ByteBuffer.wrap(stamped));
                }
                Log.i(TAG, "Shot diag: " + summary);
            }
        } catch (Throwable ignored) {}
    }

    private static int evaluateAutoPostGates(byte[] origBytes) {
        BitmapFactory.Options thumbOpts = new BitmapFactory.Options();
        thumbOpts.inSampleSize = 4;
        thumbOpts.inPreferredConfig = Bitmap.Config.ARGB_8888;
        Bitmap thumb = BitmapFactory.decodeByteArray(origBytes, 0, origBytes.length, thumbOpts);
        if (thumb == null) return 0;
        try {
            int sw = thumb.getWidth();
            int sh = thumb.getHeight();
            if (sw < 16 || sh < 16) return 0;
            int[] sampleArgb = new int[sw * sh];
            thumb.getPixels(sampleArgb, 0, sw, 0, 0, sw, sh);
            int flags = 0;
            if (AppleStyleToneEngine.evaluateAutoLtmGate(sampleArgb, sampleArgb.length)) {
                flags |= 1;
            }
            if (AppleStyleToneEngine.evaluateAutoHighlightGate(sampleArgb, sampleArgb.length)) {
                flags |= 2;
            }
            return flags;
        } finally {
            thumb.recycle();
        }
    }

    public static void applyCustomLutIfEnabled(SaveImageService.ImageContainer container) {
        if (container == null || container.mMediaData == null || container.mMediaData.isRawData()) {
            return;
        }
        ShotDecision decision = getOrResolveForContainer(container);
        String summary = decision.summary;
        int lutStyle = decision.resolved[5];
        int profile = decision.profile;
        float zoom = decision.zoom;
        ByteBuffer buf = container.mMediaData.getByteBuffer();
        if (buf == null) {
            return;
        }
        try {
            byte[] origBytes = toByteArray(buf);
            if (origBytes.length < 16) return;

            PhotoMetadata origMeta = null;
            try {
                origMeta = new PhotoMetadata(new ByteArrayInputStream(origBytes));
            } catch (Throwable ignored) {}

            // Prevent double-grading if MotCamera5 invokes post-process hook more than once per buffer.
            String existingDesc = origMeta != null ? origMeta.getAttribute("ImageDescription") : null;
            if (existingDesc != null && existingDesc.contains("Edge50Port ")) {
                return;
            }

            boolean isAutoPost = (profile == ScenePostProcSelector.PROFILE_AUTO_SCENE_ADAPTIVE && lutStyle <= 0);
            boolean wantLtm = false;
            boolean wantHighlight = false;
            boolean wantZoomSharp = false;
            if (isAutoPost) {
                wantZoomSharp = (zoom >= 1.70f && zoom < 2.95f && decision.lux < 220f)
                        || (zoom >= 6.0f && zoom <= 30.0f);
                if (origMeta == null || !origMeta.isUltraHdr()) {
                    int gates = evaluateAutoPostGates(origBytes);
                    wantLtm = (gates & 1) != 0;
                    wantHighlight = (gates & 2) != 0;
                }
                if (!wantLtm && !wantHighlight && !wantZoomSharp) {
                    stampExifDescription(container, origBytes, origMeta, summary);
                    return;
                }
            } else if (lutStyle <= 0) {
                stampExifDescription(container, origBytes, origMeta, summary);
                return;
            }

            BitmapFactory.Options opts = new BitmapFactory.Options();
            opts.inMutable = true;
            opts.inPreferredConfig = Bitmap.Config.ARGB_8888;
            Bitmap bmp = BitmapFactory.decodeByteArray(origBytes, 0, origBytes.length, opts);
            if (bmp == null) return;

            try {
                if (!bmp.isMutable()) return;
                int w = bmp.getWidth();
                int h = bmp.getHeight();
                if (w <= 0 || h <= 0) return;

                final PixelSurface surface = new PixelSurface() {
                    @Override
                    public void readRows(int srcY, int rows, int[] dst, int dstOff) {
                        bmp.getPixels(dst, dstOff, w, 0, srcY, w, rows);
                    }

                    @Override
                    public void writeRows(int dstY, int rows, int[] src, int srcOff) {
                        bmp.setPixels(src, srcOff, w, 0, dstY, w, rows);
                    }
                };

                boolean graded;
                if (isAutoPost) {
                    float[] baseGrid = null;
                    float[] stdGrid = null;
                    int gw = 0;
                    int gh = 0;
                    if (wantLtm && w >= 16 && h >= 16) {
                        int step = AppleStyleToneEngine.autoLtmGridStep();
                        gw = Math.max(2, (w + step - 1) / step);
                        gh = Math.max(2, (h + step - 1) / step);
                        float[] rawLog = new float[gw * gh];
                        stdGrid = new float[gw * gh];
                        int[] band = new int[w * step];
                        for (int y = 0; y < h; y += step) {
                            int rows = Math.min(step, h - y);
                            bmp.getPixels(band, 0, w, 0, y, w, rows);
                            AppleStyleToneEngine.accumulateAutoLtmBand(band, w, rows, y, h, rawLog, stdGrid, gw, gh);
                        }
                        baseGrid = AppleStyleToneEngine.finalizeAutoLtmBaseGrid(rawLog, gw, gh);
                    }
                    final float[] fBase = baseGrid;
                    final float[] fStd = stdGrid;
                    final int fGw = gw;
                    final int fGh = gh;
                    final boolean fLtm = wantLtm && fBase != null;
                    final boolean fHighlight = wantHighlight;
                    final boolean fZoomSharp = wantZoomSharp;
                    if (!fLtm && !fHighlight && !fZoomSharp) {
                        stampExifDescription(container, origBytes, origMeta, summary);
                        return;
                    }
                    graded = gradeSurfaceInBatches(surface, w, h, STRIP_HEIGHT, 24,
                            (strip, sw, rows, topY) -> AppleStyleToneEngine.applyAutoLocalToneAndZoomAcutance(
                                    strip, sw, rows, topY, w, h, fBase, fStd, fGw, fGh, fLtm, fHighlight, fZoomSharp, zoom));
                } else {
                    graded = gradeSurfaceInBatches(surface, w, h, STRIP_HEIGHT, 24,
                            (strip, sw, rows, topY) -> AppleStyleToneEngine.applyToArgbPixels(
                                    strip, sw, rows, lutStyle, w, h, topY));
                }
                if (!graded) return;

                ByteArrayOutputStream jpegOut = new ByteArrayOutputStream(origBytes.length);
                if (!bmp.compress(Bitmap.CompressFormat.JPEG, JPEG_SAVE_QUALITY, jpegOut)) {
                    return;
                }
                byte[] gradedBytes = jpegOut.toByteArray();
                String finalSummary = summary
                        + (isAutoPost && wantLtm ? " ltm=1" : "")
                        + (isAutoPost && wantHighlight && !wantLtm ? " hl=1" : "")
                        + (isAutoPost && wantZoomSharp ? " zsharp=1" : "");
                if (origMeta != null) {
                    if (finalSummary != null && !finalSummary.isEmpty()) {
                        origMeta.setAttribute("ImageDescription", finalSummary);
                    }
                    ByteArrayOutputStream exifOut = new ByteArrayOutputStream(gradedBytes.length + 65536);
                    origMeta.saveJpegAttributes(new ByteArrayInputStream(gradedBytes), exifOut, false);
                    gradedBytes = exifOut.toByteArray();
                }
                container.mMediaData.setByteBuffer(ByteBuffer.wrap(gradedBytes));
                Log.i(TAG, "Applied post-pass p=" + profile + " lut=" + lutStyle + " bytes=" + gradedBytes.length + " " + finalSummary);
            } finally {
                bmp.recycle();
            }
        } catch (Throwable t) {
            Log.w(TAG, "applyCustomLutIfEnabled failed, keeping original JPEG", t);
        }
    }

    private interface PixelSurface {
        void readRows(int srcY, int rows, int[] dst, int dstOff);
        void writeRows(int dstY, int rows, int[] src, int srcOff);
    }

    private interface StripPixelProcessor {
        void processStrip(int[] stripArgb, int width, int rows, int stripTopY);
    }

    /**
     * Grades a PixelSurface in batches of up to 4 overlapped strips while carrying the untouched
     * tail rows of each batch across batch boundaries so strip 0 of batch k+1 never reads graded pixels.
     */
    private static boolean gradeSurfaceInBatches(PixelSurface surface, int w, int h,
                                                 int stripHeight, int pad, StripPixelProcessor processor) {
        if (surface == null || processor == null || w <= 0 || h <= 0 || stripHeight <= 0) return true;
        pad = Math.max(0, pad);
        final int batchLimit = 4;
        List<int[]> batchBuffers = new ArrayList<>(batchLimit);
        List<int[]> batchMeta = new ArrayList<>(batchLimit); // [y, rows, writeOff]
        List<Future<?>> batchFutures = new ArrayList<>(batchLimit);
        int[] prevBatchTail = null;
        int prevTailStartY = h;
        int prevTailRows = 0;

        for (int y = 0; y < h; y += stripHeight) {
            int rows = Math.min(stripHeight, h - y);
            int srcY = Math.max(0, y - pad);
            int endY = Math.min(h, y + rows + pad);
            int srcRows = endY - srcY;
            int writeOff = (y - srcY) * w;
            int[] srcStrip = new int[w * srcRows];
            surface.readRows(srcY, srcRows, srcStrip, 0);
            // Replace any upper overlap rows that belong to an already-written previous batch.
            if (prevBatchTail != null && srcY < prevTailStartY + prevTailRows) {
                int overlapStart = Math.max(srcY, prevTailStartY);
                int overlapEnd = Math.min(endY, prevTailStartY + prevTailRows);
                int overlapRows = overlapEnd - overlapStart;
                if (overlapRows > 0) {
                    System.arraycopy(
                            prevBatchTail, (overlapStart - prevTailStartY) * w,
                            srcStrip, (overlapStart - srcY) * w,
                            overlapRows * w);
                }
            }
            batchBuffers.add(srcStrip);
            batchMeta.add(new int[] {y, rows, writeOff});
            final int taskRows = srcRows;
            final int taskTopY = srcY;
            batchFutures.add(LUT_POOL.submit(() ->
                    processor.processStrip(srcStrip, w, taskRows, taskTopY)));

            boolean isBatchEnd = batchBuffers.size() == batchLimit || y + rows >= h;
            if (isBatchEnd) {
                int batchEndY = y + rows;
                int[] nextTail = null;
                int nextTailStartY = batchEndY;
                int nextTailRows = 0;
                if (batchEndY < h && pad > 0) {
                    nextTailRows = Math.min(pad, batchEndY);
                    nextTailStartY = batchEndY - nextTailRows;
                    nextTail = new int[w * nextTailRows];
                    surface.readRows(nextTailStartY, nextTailRows, nextTail, 0);
                }
                for (int i = 0; i < batchFutures.size(); i++) {
                    try {
                        batchFutures.get(i).get();
                    } catch (InterruptedException ie) {
                        for (int j = i + 1; j < batchFutures.size(); j++) {
                            batchFutures.get(j).cancel(true);
                        }
                        Thread.currentThread().interrupt();
                        return false;
                    } catch (ExecutionException ee) {
                        throw new RuntimeException(ee.getCause());
                    }
                    int[] m = batchMeta.get(i);
                    surface.writeRows(m[0], m[1], batchBuffers.get(i), m[2]);
                }
                prevBatchTail = nextTail;
                prevTailStartY = nextTailStartY;
                prevTailRows = nextTailRows;
                batchBuffers.clear();
                batchMeta.clear();
                batchFutures.clear();
            }
        }
        return true;
    }

    /** Grades a full ARGB buffer in overlapped strips in parallel without read-after-write bleed. */
    public static boolean gradePixelBufferStrips(int[] pixels, int w, int h, int stripHeight, int pad, int lutStyle) {
        if (pixels == null || w <= 0 || h <= 0 || stripHeight <= 0 || lutStyle <= 0) return true;
        if (pixels.length < w * h) return false;
        return gradeSurfaceInBatches(new PixelSurface() {
            @Override
            public void readRows(int srcY, int rows, int[] dst, int dstOff) {
                System.arraycopy(pixels, srcY * w, dst, dstOff, rows * w);
            }

            @Override
            public void writeRows(int dstY, int rows, int[] src, int srcOff) {
                System.arraycopy(src, srcOff, pixels, dstY * w, rows * w);
            }
        }, w, h, stripHeight, pad, (strip, sw, rows, topY) ->
                AppleStyleToneEngine.applyToArgbPixels(strip, sw, rows, lutStyle, w, h, topY));
    }

    public static void exportCleanBayerJpeg(ByteBuffer rawBuffer, TotalCaptureResult result,
                                            String cameraId, SaveImageService.ImageContainer container) {
        if (rawBuffer == null || result == null || container == null || cameraId == null) return;
        int width = container.mWidth;
        int height = container.mHeight;
        ShotDecision decision = getOrResolveForContainer(container);
        if (decision.resolved[6] == 0) return;
        if (width <= 0 || height <= 0 || (long) width * height > MAX_BAYER_PIXELS) {
            Log.w(TAG, "Skip CleanBayerRaw for unsupported size " + width + "x" + height);
            return;
        }
        try {
            long minRaw10 = (long) width * height * 5L / 4L;
            if (rawBuffer.remaining() < minRaw10 && rawBuffer.capacity() < minRaw10) {
                Log.w(TAG, "Raw buffer too small: " + rawBuffer.remaining());
                return;
            }
            CapturedImageMediaData md = container.mMediaData;
            if (md == null || md.mCaptureRecord == null || md.mCaptureRecord.mMediaFile == null) return;
            MediaStoreFile baseFile = md.mCaptureRecord.mMediaFile.asSharedMediaFile();
            if (baseFile == null || baseFile.mediaFilePath == null) return;

            String origName = container.mFileName != null ? container.mFileName.getName() : "IMG_CLEAN";
            String cleanName = origName.endsWith(".dng")
                    ? origName.substring(0, origName.length() - 4) + "_CLEAN.jpg"
                    : origName + "_CLEAN.jpg";
            final MediaFilePath cleanPath = baseFile.mediaFilePath.withFileName(cleanName);
            final byte[] rawBytes = toByteArray(rawBuffer);

            RAW_EXPORT_POOL.submit(() ->
                    runCleanBayerExport(rawBytes, width, height, result, cameraId, decision, cleanName, cleanPath));
        } catch (Throwable t) {
            Log.w(TAG, "exportCleanBayerJpeg dispatch failed (DNG unaffected)", t);
        }
    }

    private static void runCleanBayerExport(byte[] rawBytes, int width, int height,
                                            TotalCaptureResult result, String cameraId,
                                            ShotDecision decision, String cleanName,
                                            MediaFilePath cleanPath) {
        // Serialize heavy 384 MiB demosaic buffers even when CallerRunsPolicy runs on the caller thread.
        synchronized (RAW_EXPORT_SERIAL_LOCK) {
            runCleanBayerExportLocked(rawBytes, width, height, result, cameraId, decision, cleanName, cleanPath);
        }
    }

    private static void runCleanBayerExportLocked(byte[] rawBytes, int width, int height,
                                                  TotalCaptureResult result, String cameraId,
                                                  ShotDecision decision, String cleanName,
                                                  MediaFilePath cleanPath) {
        try {
            long t0 = System.nanoTime();
            long minRaw10 = (long) width * height * 5L / 4L;
            long minRaw16 = (long) width * height * 2L;
            int[] unpacked;
            if (rawBytes.length >= minRaw16) {
                unpacked = CleanBayerRawProcessor.unpackRaw16ToInt(rawBytes, width, height, rawBytes.length / height, true);
            } else if (rawBytes.length >= minRaw10) {
                unpacked = CleanBayerRawProcessor.unpackRaw10ToInt(rawBytes, width, height, rawBytes.length / height);
            } else {
                Log.w(TAG, "Raw buffer too small: " + rawBytes.length);
                return;
            }

            CameraCharacteristics chars = SettingsManager.getCharacteristics(cameraId);
            int cfa = CleanBayerRawProcessor.CFA_RGGB;
            float[] black4 = {64f, 64f, 64f, 64f};
            float white = 1023f;
            float[] ccm = null;

            if (chars != null) {
                Integer cfaObj = chars.get(CameraCharacteristics.SENSOR_INFO_COLOR_FILTER_ARRANGEMENT);
                if (cfaObj != null) cfa = cfaObj.intValue();
                BlackLevelPattern blp = chars.get(CameraCharacteristics.SENSOR_BLACK_LEVEL_PATTERN);
                if (blp != null) {
                    black4[0] = blp.getOffsetForIndex(0, 0);
                    black4[1] = blp.getOffsetForIndex(1, 0);
                    black4[2] = blp.getOffsetForIndex(0, 1);
                    black4[3] = blp.getOffsetForIndex(1, 1);
                }
                Integer wObj = chars.get(CameraCharacteristics.SENSOR_INFO_WHITE_LEVEL);
                if (wObj != null && wObj.intValue() > 0) {
                    white = wObj.floatValue();
                }
                ccm = sensorTransformToSrgbCcm(extractCcm(chars.get(CameraCharacteristics.SENSOR_COLOR_TRANSFORM1)));
            }

            ColorSpaceTransform resCcm = result.get(CaptureResult.COLOR_CORRECTION_TRANSFORM);
            if (resCcm != null) {
                float[] parsed = extractCcm(resCcm);
                if (parsed != null) ccm = parsed;
            }

            float[] wb = {1.8f, 1.0f, 1.6f};
            RggbChannelVector gains = result.get(CaptureResult.COLOR_CORRECTION_GAINS);
            if (gains != null) {
                wb[0] = gains.getRed();
                wb[1] = (gains.getGreenEven() + gains.getGreenOdd()) * 0.5f;
                wb[2] = gains.getBlue();
            }

            float[] lscGrid = null;
            int lscCols = 0;
            int lscRows = 0;
            try {
                LensShadingMap lsc = result.get(CaptureResult.STATISTICS_LENS_SHADING_CORRECTION_MAP);
                if (lsc != null && lsc.getColumnCount() >= 2 && lsc.getRowCount() >= 2 && lsc.getGainFactorCount() > 0) {
                    lscCols = lsc.getColumnCount();
                    lscRows = lsc.getRowCount();
                    lscGrid = new float[lsc.getGainFactorCount()];
                    lsc.copyGainFactors(lscGrid, 0);
                }
            } catch (Throwable ignored) {}

            int isoSensitivity = 100;
            try {
                Integer isoObj = result.get(CaptureResult.SENSOR_SENSITIVITY);
                if (isoObj != null && isoObj.intValue() > 0) {
                    isoSensitivity = isoObj.intValue();
                }
            } catch (Throwable ignored) {}

            int[] argb = CleanBayerRawProcessor.processRawToArgb(
                    unpacked, width, height, cfa, black4, white, wb, ccm, 0.25f,
                    lscGrid, lscCols, lscRows, isoSensitivity);
            int lutStyle = decision.resolved[5];
            if (lutStyle > 0) {
                if (!gradePixelBufferStrips(argb, width, height, STRIP_HEIGHT, 24, lutStyle)) {
                    Log.w(TAG, "Abort CleanBayerRaw export because strip grading was interrupted");
                    return;
                }
            }

            Bitmap bmp = Bitmap.createBitmap(argb, width, height, Bitmap.Config.ARGB_8888);
            if (bmp == null) return;
            byte[] jpegBytes;
            try {
                ByteArrayOutputStream baos = new ByteArrayOutputStream(width * height / 4);
                if (!bmp.compress(Bitmap.CompressFormat.JPEG, JPEG_SAVE_QUALITY, baos)) return;
                jpegBytes = baos.toByteArray();
            } finally {
                bmp.recycle();
            }

            jpegBytes = ExifUtility.appendExifToJpeg(jpegBytes, result, null, cameraId, null);
            try {
                String summary = decision.summary;
                if (jpegBytes != null) {
                    PhotoMetadata meta = new PhotoMetadata(new ByteArrayInputStream(jpegBytes));
                    boolean changed = false;
                    if (summary != null && !summary.isEmpty()) {
                        meta.setAttribute("ImageDescription", summary + " cleanBayer=1");
                        changed = true;
                    }
                    if (meta.getAttribute("FocalLength") == null) {
                        Float fl = result.get(CaptureResult.LENS_FOCAL_LENGTH);
                        if (fl == null && chars != null) {
                            float[] availFl = chars.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS);
                            if (availFl != null && availFl.length > 0) {
                                fl = availFl[0];
                            }
                        }
                        if (fl != null && Float.isFinite(fl) && fl > 0.1f) {
                            meta.setAttribute("FocalLength", Math.round(fl * 100f) + "/100");
                            changed = true;
                        }
                    }
                    if (changed) {
                        ByteArrayOutputStream exifOut = new ByteArrayOutputStream(jpegBytes.length + 1024);
                        meta.saveJpegAttributes(new ByteArrayInputStream(jpegBytes), exifOut, false);
                        byte[] stamped = exifOut.toByteArray();
                        if (stamped.length > 64) {
                            jpegBytes = stamped;
                        }
                    }
                }
            } catch (Throwable ignored) {}

            MediaFile outFile = StorageUtils.createMediaFileWithFallback(MediaFile.fromMediaFilePath(cleanPath));
            if (outFile == null) return;
            FileDescriptor fd = outFile.getWriteFileDescriptor();
            if (fd == null) return;
            try (FileOutputStream fos = new FileOutputStream(fd)) {
                fos.write(jpegBytes);
                fos.flush();
            }
            outFile.finish();
            long elapsedMs = (System.nanoTime() - t0) / 1_000_000L;
            Log.i(TAG, "CleanBayerRaw async saved " + cleanName + " (" + jpegBytes.length + "B) in " + elapsedMs + "ms");
        } catch (Throwable t) {
            Log.w(TAG, "runCleanBayerExport failed cleanly (DNG unaffected)", t);
        }
    }

    private static float[] extractCcm(ColorSpaceTransform xform) {
        if (xform == null) return null;
        Rational[] elems = new Rational[9];
        xform.copyElements(elems, 0);
        float[] out = new float[9];
        for (int i = 0; i < 9; i++) {
            out[i] = elems[i] != null ? elems[i].floatValue() : (i % 4 == 0 ? 1f : 0f);
        }
        return out;
    }

    /** Camera2 SENSOR_COLOR_TRANSFORM1 maps CIE XYZ -> camera sensor RGB; invert and convert to linear sRGB. */
    private static float[] sensorTransformToSrgbCcm(float[] xyzToSensor) {
        if (xyzToSensor == null || xyzToSensor.length < 9) return null;
        float a = xyzToSensor[0], b = xyzToSensor[1], c = xyzToSensor[2];
        float d = xyzToSensor[3], e = xyzToSensor[4], f = xyzToSensor[5];
        float g = xyzToSensor[6], h = xyzToSensor[7], i = xyzToSensor[8];
        float c00 = e * i - f * h, c01 = -(d * i - f * g), c02 = d * h - e * g;
        float c10 = -(b * i - c * h), c11 = a * i - c * g, c12 = -(a * h - b * g);
        float c20 = b * f - c * e, c21 = -(a * f - c * d), c22 = a * e - b * d;
        float det = a * c00 + b * c01 + c * c02;
        if (!Float.isFinite(det) || Math.abs(det) < 1e-5f) return null;
        float invDet = 1f / det;
        // transpose(cofactor) * invDet = sensor -> XYZ
        float[] s2x = {
            c00 * invDet, c10 * invDet, c20 * invDet,
            c01 * invDet, c11 * invDet, c21 * invDet,
            c02 * invDet, c12 * invDet, c22 * invDet
        };
        float[] x2srgb = {
             3.2406f, -1.5372f, -0.4986f,
            -0.9689f,  1.8758f,  0.0415f,
             0.0557f, -0.2040f,  1.0570f
        };
        float[] out = new float[9];
        for (int r = 0; r < 3; r++) {
            for (int col = 0; col < 3; col++) {
                out[r * 3 + col] = x2srgb[r * 3] * s2x[col]
                        + x2srgb[r * 3 + 1] * s2x[3 + col]
                        + x2srgb[r * 3 + 2] * s2x[6 + col];
            }
        }
        return out;
    }

    private static byte[] toByteArray(ByteBuffer buf) {
        ByteBuffer dup = buf.duplicate();
        dup.clear();
        byte[] bytes = new byte[dup.remaining()];
        dup.get(bytes);
        return bytes;
    }

    /**
     * Wait off the UI thread while SaveImageService finishes finalizing the MediaStore item for
     * freshly captured shots so Google Photos receives a finalized public MediaStore URI rather
     * than an unauthorized Moto OEM processing URI that locks HostPhotoPagerActivity in bitmap_view.
     */
    public static void awaitCameraDataReadyForGallery(CameraData data) {
        if (data == null) return;
        final long mediaId;
        try {
            mediaId = data.getId();
        } catch (Throwable ignored) {
            return;
        }
        if (mediaId <= 0L) return;

        final long maxWaitMs = 6000L;
        final long pollMs = 35L;
        long startNs = 0L;
        while (true) {
            boolean stillProcessing;
            try {
                stillProcessing = SaveImageService.getProcessingCameraData(mediaId) != null;
            } catch (Throwable ignored) {
                return;
            }
            if (!stillProcessing) {
                if (startNs != 0L) {
                    long waitedMs = (System.nanoTime() - startNs) / 1_000_000L;
                    Log.d(TAG, "Gallery launch waited " + waitedMs + "ms for mediaId=" + mediaId);
                }
                return;
            }
            if (startNs == 0L) {
                startNs = System.nanoTime();
            } else if ((System.nanoTime() - startNs) >= maxWaitMs * 1_000_000L) {
                Log.w(TAG, "Gallery launch timed out waiting for mediaId=" + mediaId);
                return;
            }
            try {
                Thread.sleep(pollMs);
            } catch (InterruptedException ie) {
                Thread.currentThread().interrupt();
                return;
            }
        }
    }

    /**
     * Keep Google Photos pager swipe navigation unlocked in both directions instead of exiting back
     * to the camera on left-to-right swipe (Google Photos defaults exit_on_swipe=true on REVIEW).
     */
    public static void configureGalleryIntent(Intent intent, boolean isPrc) {
        if (intent == null || isPrc) return;
        intent.putExtra("exit_on_swipe", false);
    }
}
