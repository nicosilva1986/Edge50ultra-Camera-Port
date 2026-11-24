package android.widget;

import android.content.Context;
import android.graphics.Typeface;
import android.text.TextUtils;
import android.view.View;

public class TextView extends View {
    public TextView(Context context) { super(context); }
    public void setText(CharSequence value) {}
    public void setTextColor(int color) {}
    public void setTextSize(float size) {}
    public void setTypeface(Typeface tf) {}
    public void setTypeface(Typeface tf, int style) {}
    public void setGravity(int gravity) {}
    public void setMaxLines(int maxLines) {}
    public void setSingleLine(boolean singleLine) {}
    public void setAllCaps(boolean allCaps) {}
    public void setEllipsize(TextUtils.TruncateAt where) {}
}
