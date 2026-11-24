package android.graphics;

import java.io.OutputStream;

public final class Bitmap {
    public enum Config { ARGB_8888, ALPHA_8 }
    public Config getConfig() { return Config.ARGB_8888; }
    public enum CompressFormat { JPEG }
    public static Bitmap createBitmap(int[] colors, int width, int height, Config config) { return null; }
    public static Bitmap createBitmap(Bitmap source, int x, int y, int width, int height, Matrix m, boolean filter) { return null; }
    public static Bitmap createScaledBitmap(Bitmap src, int width, int height, boolean filter) { return null; }
    public int getWidth() { return 0; }
    public int getHeight() { return 0; }
    public boolean isMutable() { return false; }
    public void getPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {}
    public void setPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {}
    public boolean compress(CompressFormat format, int quality, OutputStream stream) { return false; }
    public boolean hasGainmap() { return false; }
    public Gainmap getGainmap() { return null; }
    public void setGainmap(Gainmap value) {}
    public void recycle() {}
}
