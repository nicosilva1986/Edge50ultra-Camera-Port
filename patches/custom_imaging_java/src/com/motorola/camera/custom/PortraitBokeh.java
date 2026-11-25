// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.Face;
import com.motorola.camera.fsm.camera.record.ImageCaptureRecord;
import com.motorola.camera.mcf.McfAuxFrameData;
import com.motorola.camera.mcf.McfAuxiliaryData;
import com.motorola.camera.mcf.McfImagingModelAuxData;
import com.motorola.camera.photometadata.PhotoMetadata;
import java.io.ByteArrayInputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;

final class PortraitBokeh {
    private static final int MAX_SIDE = 960;
    private static final int SUBJECT_DEPTH = 210;
    private static final int BG_DEPTH = 40;

    private PortraitBokeh() {}

    static ByteBuffer original(ImageCaptureRecord record) {
        if (record == null || record.mAuxImages == null || record.mMcfAuxData == null) return null;
        if (!(record.mMcfAuxData.get(McfAuxiliaryData.DEPTHMAP) instanceof McfAuxFrameData)
                || !(record.mMcfAuxData.get(McfAuxiliaryData.IMAGING_MODEL) instanceof McfImagingModelAuxData)) return null;
        return record.mAuxImages.get(ImageCaptureRecord.AuxiliaryImage.DEPTH_RENDER_ORIGINAL);
    }

    static boolean render(Bitmap source, ImageCaptureRecord record, int style) {
        if (source == null || record == null || record.mMcfAuxData == null) return false;
        Object rawDepth = record.mMcfAuxData.get(McfAuxiliaryData.DEPTHMAP);
        Object rawModel = record.mMcfAuxData.get(McfAuxiliaryData.IMAGING_MODEL);
        if (!(rawDepth instanceof McfAuxFrameData) || !(rawModel instanceof McfImagingModelAuxData)) return false;
        McfAuxFrameData frame = (McfAuxFrameData) rawDepth;
        McfImagingModelAuxData model = (McfImagingModelAuxData) rawModel;
        int width = source.getWidth(), height = source.getHeight();
        if (model.getWidth() <= 0 || model.getHeight() <= 0 || width < 2 || height < 2) return false;
        double scale = Math.min(1, MAX_SIDE / (double) Math.max(width, height));
        int sw = Math.max(2, (int) (width * scale)), sh = Math.max(2, (int) (height * scale));
        byte[] depth = readDepth(frame, sw, sh);
        if (depth == null) return false;
        return renderWithDepth(source, depth, sw, sh, focus(depth, sw, sh), style, 1.0f);
    }

    /**
     * Renders optical bokeh styles for single-camera Portrait mode (FRONT_MAIN and SINGLE_REAR_BOKEH).
     * Prefers hardware/ArcSoft DEPTHMAP when present, falls back to STATISTICS_FACES head+torso mask,
     * and finally a centered radial subject-focus depth map so every optical bokeh lens operates reliably.
     * Returns the depth source tag ("hw", "face", or "radial") or null if rendering cannot run.
     */
    static String renderSingleCam(Bitmap source, ImageCaptureRecord record,
                                  TotalCaptureResult result, CameraCharacteristics chars,
                                  boolean isFrontCamera, int style) {
        if (source == null || style <= 0) return null;
        int width = source.getWidth(), height = source.getHeight();
        if (width < 2 || height < 2) return null;
        double scale = Math.min(1, MAX_SIDE / (double) Math.max(width, height));
        int sw = Math.max(2, (int) (width * scale)), sh = Math.max(2, (int) (height * scale));

        byte[] depth = null;
        String depthSource = null;
        if (record != null && record.mMcfAuxData != null) {
            Object rawDepth = record.mMcfAuxData.get(McfAuxiliaryData.DEPTHMAP);
            if (rawDepth instanceof McfAuxFrameData) {
                depth = readDepth((McfAuxFrameData) rawDepth, sw, sh);
                if (depth != null) depthSource = "hw";
            }
        }
        if (depth == null) {
            depth = buildFaceDepthMap(result, chars, sw, sh, isFrontCamera);
            if (depth != null) depthSource = "face";
        }
        if (depth == null) {
            depth = buildRadialDepthMap(sw, sh);
            depthSource = "radial";
        }
        int focus = "hw".equals(depthSource) ? focus(depth, sw, sh) : SUBJECT_DEPTH;
        float radiusScale = computeRadiusScale(result);
        return renderWithDepth(source, depth, sw, sh, focus, style, radiusScale) ? depthSource : null;
    }

    private static float computeRadiusScale(TotalCaptureResult result) {
        if (result == null) return 1.0f;
        float scale = 1.0f;
        try {
            Float fl = result.get(CaptureResult.LENS_FOCAL_LENGTH);
            if (fl != null && Float.isFinite(fl) && fl > 0.5f) {
                float flFactor = Math.max(0.75f, Math.min(1.35f, fl / 6.9f));
                scale *= flFactor;
            }
            Float ap = result.get(CaptureResult.LENS_APERTURE);
            if (ap != null && Float.isFinite(ap) && ap > 0.5f) {
                float apFactor = Math.max(0.75f, Math.min(1.20f, 1.6f / ap));
                scale *= apFactor;
            }
        } catch (Throwable ignored) {}
        return Math.max(0.70f, Math.min(1.45f, scale));
    }

    private static boolean renderWithDepth(Bitmap source, byte[] depth, int sw, int sh, int focus, int style, float radiusScale) {
        int width = source.getWidth(), height = source.getHeight();
        Bitmap small = Bitmap.createScaledBitmap(source, sw, sh, true);
        int[] pixels = new int[sw * sh];
        try {
            small.getPixels(pixels, 0, sw, 0, 0, sw, sh);
        } finally {
            if (small != source) small.recycle();
        }
        int[] blurred = OffscreenBokeh.render(pixels, depth, sw, sh, focus, style, radiusScale);
        if (blurred == null) blurred = BokehKernel.gather(pixels, depth, sw, sh, focus, style, radiusScale);
        Bitmap blur = Bitmap.createBitmap(blurred, sw, sh, Bitmap.Config.ARGB_8888);
        Bitmap expanded = blur;
        try {
            expanded = Bitmap.createScaledBitmap(blur, width, height, true);
            int[] originalRow = new int[width], blurRow = new int[width];
            int[] depthX = new int[width];
            for (int x = 0; x < width; x++) depthX[x] = x * sw / width;
            int[] amounts = new int[256];
            for (int d = 0; d < amounts.length; d++) {
                float c = BokehKernel.coc(d, focus);
                float ramped = Math.min(1f, c * 1.65f);
                amounts[d] = Math.round(256 * ramped);
            }
            for (int y = 0; y < height; y++) {
                source.getPixels(originalRow, 0, width, 0, y, width, 1);
                expanded.getPixels(blurRow, 0, width, 0, y, width, 1);
                int dy = y * sh / height * sw;
                for (int x = 0; x < width; x++) {
                    int weight = amounts[depth[dy + depthX[x]] & 255];
                    if (weight != 0) originalRow[x] = mix(originalRow[x], blurRow[x], weight);
                }
                source.setPixels(originalRow, 0, width, 0, y, width, 1);
            }
        } finally {
            if (expanded != blur) expanded.recycle();
            blur.recycle();
        }
        return true;
    }

    private static byte[] buildFaceDepthMap(TotalCaptureResult result, CameraCharacteristics chars,
                                            int sw, int sh, boolean isFrontCamera) {
        if (result == null) return null;
        Face[] faces = null;
        try {
            faces = result.get(CaptureResult.STATISTICS_FACES);
        } catch (Throwable ignored) {}
        if (faces == null || faces.length == 0) return null;

        Rect crop = null;
        try {
            crop = result.get(CaptureResult.SCALER_CROP_REGION);
        } catch (Throwable ignored) {}
        if ((crop == null || crop.width() <= 0 || crop.height() <= 0) && chars != null) {
            try {
                crop = chars.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
            } catch (Throwable ignored) {}
        }
        if (crop == null || crop.width() <= 0 || crop.height() <= 0) return null;

        int sensorOrientation = isFrontCamera ? 270 : 90;
        if (chars != null) {
            try {
                Integer so = chars.get(CameraCharacteristics.SENSOR_ORIENTATION);
                if (so != null) sensorOrientation = ((so.intValue() % 360) + 360) % 360;
            } catch (Throwable ignored) {}
        }

        boolean bitmapPortrait = sh > sw;
        boolean cropLandscape = crop.width() > crop.height();
        int count = Math.min(faces.length, 4);
        double[] cxs = new double[count], cys = new double[count], rxs = new double[count], rys = new double[count];
        int valid = 0;
        for (int i = 0; i < faces.length && valid < count; i++) {
            Face f = faces[i];
            if (f == null || f.getBounds() == null) continue;
            Rect b = f.getBounds();
            double nCx = (b.centerX() - crop.left) / (double) crop.width();
            double nCy = (b.centerY() - crop.top) / (double) crop.height();
            double nW = Math.max(0.06, Math.abs(b.width()) / (double) crop.width());
            double nH = Math.max(0.06, Math.abs(b.height()) / (double) crop.height());

            double ux, uy, uw, uh;
            if (bitmapPortrait == cropLandscape) {
                if (sensorOrientation == 270) {
                    ux = nCy;
                    uy = 1.0 - nCx;
                    if (isFrontCamera) ux = 1.0 - ux;
                } else {
                    ux = 1.0 - nCy;
                    uy = nCx;
                    if (isFrontCamera) ux = 1.0 - ux;
                }
                uw = nH;
                uh = nW;
            } else {
                ux = isFrontCamera ? (1.0 - nCx) : nCx;
                uy = nCy;
                uw = nW;
                uh = nH;
            }
            cxs[valid] = Math.max(0.05, Math.min(0.95, ux)) * sw;
            cys[valid] = Math.max(0.05, Math.min(0.95, uy)) * sh;
            rxs[valid] = Math.max(sw * 0.14, uw * sw * 0.95);
            rys[valid] = Math.max(sh * 0.14, uh * sh * 1.15);
            valid++;
        }
        if (valid == 0) return null;

        byte[] depth = new byte[sw * sh];
        for (int y = 0; y < sh; y++) {
            int rowOff = y * sw;
            for (int x = 0; x < sw; x++) {
                double best = 99.0;
                for (int i = 0; i < valid; i++) {
                    double dx = (x - cxs[i]) / rxs[i];
                    double dy = (y - cys[i]) / rys[i];
                    double headDist = Math.sqrt(dx * dx + dy * dy);
                    double torsoDx = (x - cxs[i]) / (rxs[i] * 1.65);
                    double torsoDy = (y - (cys[i] + rys[i] * 1.45)) / (rys[i] * 1.85);
                    double torsoDist = Math.sqrt(torsoDx * torsoDx + torsoDy * torsoDy);
                    double dist = Math.min(headDist, torsoDist);
                    if (dist < best) best = dist;
                }
                depth[rowOff + x] = smoothFocusByte(best);
            }
        }
        return depth;
    }

    private static byte[] buildRadialDepthMap(int sw, int sh) {
        byte[] depth = new byte[sw * sh];
        double cx = sw * 0.5;
        double cy = sh * 0.45;
        double rx = Math.max(2.0, sw * 0.27);
        double ry = Math.max(2.0, sh * 0.34);
        for (int y = 0; y < sh; y++) {
            double dy = (y - cy) / ry;
            int rowOff = y * sw;
            for (int x = 0; x < sw; x++) {
                double dx = (x - cx) / rx;
                depth[rowOff + x] = smoothFocusByte(Math.sqrt(dx * dx + dy * dy));
            }
        }
        return depth;
    }

    private static byte smoothFocusByte(double normDist) {
        if (normDist <= 1.0) return (byte) SUBJECT_DEPTH;
        double t = Math.min(1.0, (normDist - 1.0) / 1.35);
        double s = t * t * (3.0 - 2.0 * t);
        return (byte) Math.round(SUBJECT_DEPTH - s * (SUBJECT_DEPTH - BG_DEPTH));
    }

    private static int focus(byte[] depth, int width, int height) {
        int[] samples = new int[49];
        int i = 0;
        for (int y = -3; y <= 3; y++) {
            for (int x = -3; x <= 3; x++) {
                samples[i++] = depth[(height / 2 + y * height / 32) * width
                        + width / 2 + x * width / 32] & 255;
            }
        }
        Arrays.sort(samples);
        return samples[samples.length / 2];
    }

    private static int readExifRotation(byte[] jpegBytes) {
        try {
            PhotoMetadata meta = new PhotoMetadata(new ByteArrayInputStream(jpegBytes));
            String orientation = meta.getAttribute("Orientation");
            if ("6".equals(orientation)) return 90;
            if ("3".equals(orientation)) return 180;
            if ("8".equals(orientation)) return 270;
        } catch (Throwable ignored) {}
        return 0;
    }

    private static byte[] readDepth(McfAuxFrameData frame, int width, int height) {
        byte[] frameData = frame.getData();
        int dw = frame.getWidth(), dh = frame.getHeight();
        if (frameData == null || dw < 2 || dh < 2 || (long) dw * dh > 20_000_000) return null;
        double targetAspect = width / (double) height;
        double sameAspect = Math.abs((dw / (double) dh) / targetAspect - 1.0);
        double rotAspect = Math.abs((dh / (double) dw) / targetAspect - 1.0);
        boolean autoRotate90 = (dw > dh) != (width > height) && sameAspect > 0.12 && rotAspect <= 0.12;
        if (!autoRotate90 && sameAspect > 0.12) return null;
        byte[] result = new byte[width * height];
        if ("NV21".equals(frame.getFormat())) {
            int stride = frame.getStride();
            if (stride < dw || (long) stride * (dh - 1) + dw > frameData.length) return null;
            for (int y = 0; y < height; y++) {
                if (autoRotate90) {
                    int sx = Math.min(dw - 1, y * dw / height);
                    for (int x = 0; x < width; x++) {
                        int sy = Math.min(dh - 1, (width - 1 - x) * dh / width);
                        result[y * width + x] = frameData[sy * stride + sx];
                    }
                } else {
                    int row = y * dh / height * stride;
                    for (int x = 0; x < width; x++) result[y * width + x] = frameData[row + x * dw / width];
                }
            }
            return result;
        }
        if (!"JPEG".equals(frame.getFormat())) return null;
        Bitmap jpeg = BitmapFactory.decodeByteArray(frameData, 0, frameData.length);
        if (jpeg == null) return null;
        Bitmap oriented = jpeg;
        Bitmap resized = null;
        try {
            int jw = jpeg.getWidth(), jh = jpeg.getHeight();
            boolean validSize = (jw == dw && jh == dh) || (jw == dh && jh == dw);
            if (!validSize || jw < 2 || jh < 2) return null;
            int exifDeg = readExifRotation(frameData);
            int deg = exifDeg != 0 ? exifDeg : ((jw > jh) != (width > height) ? 90 : 0);
            if (deg != 0) {
                Matrix matrix = new Matrix();
                matrix.postRotate(deg);
                oriented = Bitmap.createBitmap(jpeg, 0, 0, jw, jh, matrix, true);
                if (oriented == null) return null;
            }
            double orientedAspect = Math.abs((oriented.getWidth() / (double) oriented.getHeight()) / targetAspect - 1.0);
            if (orientedAspect > 0.12) return null;
            resized = Bitmap.createScaledBitmap(oriented, width, height, true);
            if (resized == null) return null;
            int[] gray = new int[width * height];
            resized.getPixels(gray, 0, width, 0, 0, width, height);
            for (int i = 0; i < gray.length; i++) result[i] = (byte) (gray[i] >>> 16);
            return result;
        } finally {
            if (resized != null && resized != oriented && resized != jpeg) resized.recycle();
            if (oriented != null && oriented != jpeg) oriented.recycle();
            jpeg.recycle();
        }
    }

    private static int mix(int a, int b, int t) {
        int r = (((a >>> 16 & 255) * (256 - t) + (b >>> 16 & 255) * t + 128) >>> 8) << 16;
        int g = (((a >>> 8 & 255) * (256 - t) + (b >>> 8 & 255) * t + 128) >>> 8) << 8;
        int blue = ((a & 255) * (256 - t) + (b & 255) * t + 128) >>> 8;
        return 0xff000000 | r | g | blue;
    }
}
