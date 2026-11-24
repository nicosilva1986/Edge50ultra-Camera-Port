package com.motorola.camera.fsm.camera.record;

import com.motorola.camera.saving.FileName;
import com.motorola.camera.storage.MediaFile;

public abstract class CaptureRecord {
    public String mCameraId;
    public int mCaptureMode;
    public FileName mFileName;
    public MediaFile mMediaFile;
    public SequenceIdentifier mSeqId;
    public long mUUID;
}
