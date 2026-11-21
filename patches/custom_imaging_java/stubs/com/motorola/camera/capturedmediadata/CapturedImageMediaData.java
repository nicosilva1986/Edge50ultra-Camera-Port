package com.motorola.camera.capturedmediadata;

import java.nio.ByteBuffer;

public final class CapturedImageMediaData extends CapturedMediaData {
    public ByteBuffer getByteBuffer() { return null; }
    public boolean isRawData() { return false; }
    public void setByteBuffer(ByteBuffer buf) {}
}
