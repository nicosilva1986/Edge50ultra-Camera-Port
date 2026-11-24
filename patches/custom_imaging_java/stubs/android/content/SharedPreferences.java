package android.content;

public interface SharedPreferences {
    default Editor edit() { return null; }
    interface Editor {
        Editor putString(String key, String value);
        default Editor putBoolean(String key, boolean value) { return this; }
        default Editor putInt(String key, int value) { return this; }
        default Editor putFloat(String key, float value) { return this; }
        default Editor remove(String key) { return this; }
        void apply();
    }
    String getString(String key, String defValue);
    default boolean getBoolean(String key, boolean defValue) { return defValue; }
    default int getInt(String key, int defValue) { return defValue; }
    default float getFloat(String key, float defValue) { return defValue; }
    default void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener listener) {}
    default void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener listener) {}

    interface OnSharedPreferenceChangeListener {
        void onSharedPreferenceChanged(SharedPreferences sharedPreferences, String key);
    }
}
