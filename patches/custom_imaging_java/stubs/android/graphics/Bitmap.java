package android.graphics;

import java.io.OutputStream;

public final class Bitmap {
    public enum Config { ARGB_8888 }
    public enum CompressFormat { JPEG }
    public static Bitmap createBitmap(int[] colors, int width, int height, Config config) { return null; }
    public int getWidth() { return 0; }
    public int getHeight() { return 0; }
    public boolean isMutable() { return false; }
    public void getPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {}
    public void setPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {}
    public boolean compress(CompressFormat format, int quality, OutputStream stream) { return false; }
    public void recycle() {}
}
