package com.motorola.camera.saving;

import com.motorola.camera.capturedmediadata.CapturedImageMediaData;

public final class SaveImageService {
    public static final class ImageContainer {
        public CapturedImageMediaData mMediaData;
        public FileName mFileName;
        public int mWidth;
        public int mHeight;
    }
}
