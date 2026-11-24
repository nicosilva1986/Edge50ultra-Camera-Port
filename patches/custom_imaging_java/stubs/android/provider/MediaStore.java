package android.provider;

import android.net.Uri;

public final class MediaStore {
    public interface MediaColumns {
        String DISPLAY_NAME = "_display_name";
        String MIME_TYPE = "mime_type";
        String RELATIVE_PATH = "relative_path";
        String IS_PENDING = "is_pending";
    }

    public static final class Files {
        public static Uri getContentUri(String volumeName) { return null; }
    }
}
