package android.content;

import android.content.res.AssetManager;
import android.content.res.Resources;

public class Context {
    public static final String SENSOR_SERVICE = "sensor";
    public static final String LOCATION_SERVICE = "location";

    public Context getApplicationContext() { return this; }
    public java.io.File getFilesDir() { return null; }
    public java.io.File getExternalFilesDir(String type) { return null; }
    public AssetManager getAssets() { return null; }
    public Resources getResources() { return null; }
    public ContentResolver getContentResolver() { return null; }
    public String getPackageName() { return null; }
    public Object getSystemService(String name) { return null; }
    public int checkSelfPermission(String permission) { return 0; }
}
