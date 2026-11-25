package android.graphics;

public final class BitmapFactory {
    public static Bitmap decodeByteArray(byte[] data, int offset, int length) { return null; }
    public static class Options {
        public boolean inMutable;
        public Bitmap.Config inPreferredConfig;
        public ColorSpace inPreferredColorSpace;
        public ColorSpace outColorSpace;
        public int inSampleSize = 1;
    }
    public static Bitmap decodeByteArray(byte[] data, int offset, int length, Options opts) { return null; }
}
