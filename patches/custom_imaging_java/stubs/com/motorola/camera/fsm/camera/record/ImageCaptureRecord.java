package com.motorola.camera.fsm.camera.record;

import com.motorola.camera.mcf.Mcf;
import com.motorola.camera.saving.CaptureHolder;
import java.util.concurrent.CopyOnWriteArrayList;

public final class ImageCaptureRecord extends CaptureRecord {
    public enum AuxiliaryImage { DEPTH_RENDER_ORIGINAL }
    public java.util.HashMap<AuxiliaryImage, java.nio.ByteBuffer> mAuxImages;
    public CopyOnWriteArrayList<CaptureHolder> mCaptureHolders;
    public com.motorola.camera.mcf.McfAuxiliaryData mMcfAuxData;
    public boolean mIsFlash;
    public Mcf.SceneMode mSceneMode;
}
