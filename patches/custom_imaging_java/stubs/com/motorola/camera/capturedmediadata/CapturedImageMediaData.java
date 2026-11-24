package com.motorola.camera.capturedmediadata;

import com.motorola.camera.saving.ImageDataHolder;
import java.nio.ByteBuffer;

public final class CapturedImageMediaData extends CapturedMediaData {
    public ImageDataHolder mImageDataHolder;
    public ByteBuffer getByteBuffer() { return null; }
    public boolean isRawData() { return false; }
    public void setByteBuffer(ByteBuffer buf) {}
}
