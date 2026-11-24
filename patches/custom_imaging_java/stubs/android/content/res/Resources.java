package android.content.res;

import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;

public class Resources {
    public static final class Theme {}
    public DisplayMetrics getDisplayMetrics() { return null; }
    public Configuration getConfiguration() { return null; }
    public int getIdentifier(String name, String defType, String defPackage) { return 0; }
    public String getString(int id) { return null; }
    public String getString(int id, Object... formatArgs) { return null; }
    public String[] getStringArray(int id) { return null; }
    public int getColor(int id, Theme theme) { return 0; }
    public Drawable getDrawable(int id, Theme theme) { return null; }
}
