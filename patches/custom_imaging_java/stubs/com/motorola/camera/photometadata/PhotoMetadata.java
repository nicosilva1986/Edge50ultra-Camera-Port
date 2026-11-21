package com.motorola.camera.photometadata;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public final class PhotoMetadata {
    public PhotoMetadata(InputStream is) throws IOException {}
    public void saveJpegAttributes(InputStream in, OutputStream out, boolean keepThumb) throws IOException {}
    public String getAttribute(String tag) { return null; }
    public void setAttribute(String tag, String value) {}
    public boolean isUltraHdr() { return false; }
}
