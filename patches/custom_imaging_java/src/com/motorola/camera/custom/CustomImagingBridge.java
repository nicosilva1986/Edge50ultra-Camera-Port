// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.BlackLevelPattern;
import android.hardware.camera2.params.ColorSpaceTransform;
import android.hardware.camera2.params.RggbChannelVector;
import android.util.Log;
import android.util.Rational;
import androidx.preference.ListPreference;
import androidx.preference.PreferenceFragmentCompat;
import com.motorola.camera.IqConfigManager;
import com.motorola.camera.capturedmediadata.CapturedImageMediaData;
import com.motorola.camera.fsm.camera.modes.RequestBuilderHelper;
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

/**
 * Android/Motorola runtime bridge for scene-adaptive post-processing, Apple-style LUT grading,
 * Pure ISP capture overrides, and clean-room Bayer RAW JPEG export.
 */
public final class CustomImagingBridge {
    private static final String TAG = "CustomImagingBridge";
    public static final String PREF_KEY = "com.motorola.camera.post_processing_profile";
    private static final int STRIP_HEIGHT = 512;
    private static final int MAX_BAYER_PIXELS = 20_000_000;

    private static final CharSequence[] PROFILE_LABELS = {
        "Auto (Scene-Adaptive)",
        "Natural ZSL (NR ZSL / Edge ZSL)",
        "Minimal ISP (NR Minimal / Edge Off)",
        "Detail HDR (RAW HDR / Low Halo)",
        "Pure ISP (MFNR Off / NR Off)",
        "iPhone Natural (Apple Style LUT)",
        "iPhone Rich Contrast (Apple Style)",
        "iPhone Amber (Warm Photonic LUT)",
        "Clean RAW Bayer (DNG -> Clean JPG)"
    };

    private static final CharSequence[] PROFILE_VALUES = {
        "0", "1", "2", "3", "4", "5", "6", "7", "8"
    };

    private CustomImagingBridge() {}

    public static void initPostProcPreference(PreferenceFragmentCompat fragment) {
        if (fragment == null) return;
        try {
            ListPreference pref = (ListPreference) fragment.findPreference(PREF_KEY);
            if (pref == null) return;
            pref.setEntries(PROFILE_LABELS);
            pref.mEntryValues = PROFILE_VALUES;
            SharedPreferences prefs = PersistBehavior.getPreferences();
            String current = prefs != null ? prefs.getString(PREF_KEY, "0") : "0";
            if (current == null || current.length() != 1 || current.charAt(0) < '0' || current.charAt(0) > '8') {
                current = "0";
            }
            pref.setValue(current);
        } catch (Throwable t) {
            Log.w(TAG, "initPostProcPreference failed", t);
        }
    }

    public static int getSelectedProfile() {
        try {
            SharedPreferences prefs = PersistBehavior.getPreferences();
            if (prefs == null) return 0;
            String raw = prefs.getString(PREF_KEY, "0");
            if (raw == null) return 0;
            int val = Integer.parseInt(raw);
            return (val >= 0 && val <= 8) ? val : 0;
        } catch (Throwable ignored) {
            return 0;
        }
    }

    private static int[] resolveForScene(Mcf.SceneMode scene, boolean isFlash) {
        float zoom = 1.0f;
        float lux = 50.0f;
        try {
            CameraType camType = SettingsManager.getCurrentCameraType();
            if (camType != null) {
                float z = SettingsManager.getZoomValue(camType);
                if (Float.isFinite(z) && z > 0f) zoom = z;
            }
        } catch (Throwable ignored) {}
        try {
            IqConfigManager iq = IqConfigManager.getInstance();
            if (iq != null && Float.isFinite(iq.mLastLuxIdx) && iq.mLastLuxIdx >= 0f) {
                lux = iq.mLastLuxIdx;
            }
        } catch (Throwable ignored) {}

        String name = scene != null ? scene.name() : "";
        boolean isHdr = name.contains("HDR");
        boolean isDedNight = name.contains("DEDICATED") || "SUPER_NIGHT".equals(name);
        boolean effectiveFlash = isFlash || name.contains("FLASH");
        return ScenePostProcSelector.resolve(getSelectedProfile(), zoom, lux, isHdr, isDedNight, effectiveFlash);
    }

    private static int[] resolveActiveScene(boolean isFlash) {
        Mcf.SceneMode scene = null;
        try {
            scene = SceneModeManager.getCurrentScene();
        } catch (Throwable ignored) {}
        return resolveForScene(scene, isFlash);
    }

    public static Mcf.SceneMode overrideSceneMode(Mcf.SceneMode origScene, boolean isFlash) {
        try {
            int[] resolved = resolveForScene(origScene, isFlash);
            if (resolved[0] == ScenePostProcSelector.SCENE_HAL_FRAME_STACK) {
                return Mcf.SceneMode.HAL_FRAME_STACK;
            }
            if (resolved[0] == ScenePostProcSelector.SCENE_RAW_HDR) {
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
        int v = resolveActiveScene(false)[3];
        return v >= 0 ? (v != 0) : origEnable;
    }

    public static boolean shouldAllowInSensorCrop() {
        int v = resolveActiveScene(false)[3];
        return v != 0;
    }

    public static void applyCaptureRequestOverrides(String cameraId, CaptureRequest.Builder builder) {
        if (builder == null || cameraId == null) return;
        try {
            boolean isFlash = false;
            Integer flash = builder.get(CaptureRequest.FLASH_MODE);
            if (flash != null && flash.intValue() != 0) {
                isFlash = true;
            } else {
                Integer aeMode = builder.get(CaptureRequest.CONTROL_AE_MODE);
                if (aeMode != null && aeMode.intValue() == 3) {
                    isFlash = true;
                }
            }
            int[] resolved = resolveActiveScene(isFlash);
            int nr = resolved[1];
            int edge = resolved[2];
            int enableMfnr = resolved[3];

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
            }
            if (enableMfnr == 0) {
                RequestBuilderHelper.setMfnr(cameraId, builder, false, isFlash);
            }
        } catch (Throwable t) {
            Log.w(TAG, "applyCaptureRequestOverrides failed", t);
        }
    }

    public static void applyCustomLutIfEnabled(SaveImageService.ImageContainer container) {
        if (container == null || container.mMediaData == null || container.mMediaData.isRawData()) {
            return;
        }
        int lutStyle = resolveActiveScene(false)[5];
        if (lutStyle <= 0) {
            return;
        }
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

                int[] strip = new int[w * Math.min(STRIP_HEIGHT, h)];
                for (int y = 0; y < h; y += STRIP_HEIGHT) {
                    int rows = Math.min(STRIP_HEIGHT, h - y);
                    bmp.getPixels(strip, 0, w, 0, y, w, rows);
                    AppleStyleToneEngine.applyToArgbPixels(strip, w, rows, lutStyle);
                    bmp.setPixels(strip, 0, w, 0, y, w, rows);
                }

                ByteArrayOutputStream jpegOut = new ByteArrayOutputStream(origBytes.length);
                if (!bmp.compress(Bitmap.CompressFormat.JPEG, 96, jpegOut)) {
                    return;
                }
                byte[] gradedBytes = jpegOut.toByteArray();
                if (origMeta != null) {
                    ByteArrayOutputStream exifOut = new ByteArrayOutputStream(gradedBytes.length + 65536);
                    origMeta.saveJpegAttributes(new ByteArrayInputStream(gradedBytes), exifOut, false);
                    gradedBytes = exifOut.toByteArray();
                }
                container.mMediaData.setByteBuffer(ByteBuffer.wrap(gradedBytes));
                Log.i(TAG, "Applied AppleStyle LUT=" + lutStyle + " bytes=" + gradedBytes.length);
            } finally {
                bmp.recycle();
            }
        } catch (Throwable t) {
            Log.w(TAG, "applyCustomLutIfEnabled failed, keeping original JPEG", t);
        }
    }

    public static void exportCleanBayerJpeg(ByteBuffer rawBuffer, TotalCaptureResult result,
                                            String cameraId, SaveImageService.ImageContainer container) {
        if (rawBuffer == null || result == null || container == null || cameraId == null) return;
        int width = container.mWidth;
        int height = container.mHeight;
        int[] resolved = resolveActiveScene(false);
        if (resolved[6] == 0) return;
        if (width <= 0 || height <= 0 || (long) width * height > MAX_BAYER_PIXELS) {
            Log.w(TAG, "Skip CleanBayerRaw for unsupported size " + width + "x" + height);
            return;
        }
        try {
            long t0 = System.nanoTime();
            byte[] rawBytes = toByteArray(rawBuffer);
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
                ccm = extractCcm(chars.get(CameraCharacteristics.SENSOR_COLOR_TRANSFORM1));
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

            int[] argb = CleanBayerRawProcessor.processRawToArgb(
                    unpacked, width, height, cfa, black4, white, wb, ccm, 0.25f);
            int lutStyle = resolved[5];
            if (lutStyle > 0) {
                AppleStyleToneEngine.applyToArgbPixels(argb, width, height, lutStyle);
            }

            Bitmap bmp = Bitmap.createBitmap(argb, width, height, Bitmap.Config.ARGB_8888);
            if (bmp == null) return;
            byte[] jpegBytes;
            try {
                ByteArrayOutputStream baos = new ByteArrayOutputStream(width * height / 4);
                if (!bmp.compress(Bitmap.CompressFormat.JPEG, 96, baos)) return;
                jpegBytes = baos.toByteArray();
            } finally {
                bmp.recycle();
            }

            jpegBytes = ExifUtility.appendExifToJpeg(jpegBytes, result, null, cameraId, null);
            CapturedImageMediaData md = container.mMediaData;
            if (md == null || md.mCaptureRecord == null || md.mCaptureRecord.mMediaFile == null) return;
            MediaStoreFile baseFile = md.mCaptureRecord.mMediaFile.asSharedMediaFile();
            if (baseFile == null || baseFile.mediaFilePath == null) return;

            String origName = container.mFileName != null ? container.mFileName.getName() : "IMG_CLEAN";
            String cleanName = origName.endsWith(".dng")
                    ? origName.substring(0, origName.length() - 4) + "_CLEAN.jpg"
                    : origName + "_CLEAN.jpg";

            MediaFilePath cleanPath = baseFile.mediaFilePath.withFileName(cleanName);
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
            Log.i(TAG, "CleanBayerRaw saved " + cleanName + " (" + jpegBytes.length + "B) in " + elapsedMs + "ms");
        } catch (Throwable t) {
            Log.w(TAG, "exportCleanBayerJpeg failed cleanly (DNG unaffected)", t);
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

    private static byte[] toByteArray(ByteBuffer buf) {
        ByteBuffer dup = buf.duplicate();
        dup.clear();
        byte[] bytes = new byte[dup.remaining()];
        dup.get(bytes);
        return bytes;
    }
}
