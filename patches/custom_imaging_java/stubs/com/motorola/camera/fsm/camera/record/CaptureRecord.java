package com.motorola.camera.fsm.camera.record;

import com.motorola.camera.storage.MediaFile;

public abstract class CaptureRecord {
    public MediaFile mMediaFile;
    public SequenceIdentifier mSeqId;
    public long mUUID;
}
