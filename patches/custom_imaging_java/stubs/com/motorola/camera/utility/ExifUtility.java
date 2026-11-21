package com.motorola.camera.utility;

import android.hardware.camera2.TotalCaptureResult;
import com.motorola.camera.mcf.McfMetadata;

public abstract class ExifUtility {
    public static byte[] appendExifToJpeg(byte[] jpeg, TotalCaptureResult res, McfMetadata meta, String camId, byte[] thumb) { return jpeg; }
}
