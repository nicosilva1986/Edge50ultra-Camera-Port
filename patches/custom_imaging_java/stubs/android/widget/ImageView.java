package android.widget;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.View;

public class ImageView extends View {
    public enum ScaleType { FIT_CENTER, CENTER_INSIDE }
    public ImageView(Context context) { super(context); }
    public void setImageResource(int resId) {}
    public void setImageDrawable(Drawable drawable) {}
    public void setScaleType(ScaleType scaleType) {}
    public void setColorFilter(int color) {}
}
