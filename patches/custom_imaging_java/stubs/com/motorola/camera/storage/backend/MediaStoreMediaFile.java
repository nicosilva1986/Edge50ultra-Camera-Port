package com.motorola.camera.storage.backend;

import com.motorola.camera.storage.MediaFile;
import java.io.FileDescriptor;

public class MediaStoreMediaFile extends MediaStoreFile implements MediaFile {
    public MediaStoreFile asSharedMediaFile() { return this; }
    public void finish() {}
    public FileDescriptor getWriteFileDescriptor() { return null; }
}
