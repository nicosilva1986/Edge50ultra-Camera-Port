package com.motorola.camera.storage;

import com.motorola.camera.storage.backend.MediaStoreFile;
import com.motorola.camera.storage.backend.MediaStoreMediaFile;
import java.io.FileDescriptor;

public interface MediaFile {
    static MediaStoreMediaFile fromMediaFilePath(MediaFilePath path) { return null; }
    MediaStoreFile asSharedMediaFile();
    void finish();
    FileDescriptor getWriteFileDescriptor();
}
