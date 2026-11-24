package android.view;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;

public class View {
    public static final int VISIBLE = 0;
    public static final int GONE = 8;
    public static final int IMPORTANT_FOR_ACCESSIBILITY_NO = 2;
    public static final int LAYOUT_DIRECTION_RTL = 1;
    public View(Context context) {}
    public Context getContext() { return null; }
    public Resources getResources() { return null; }
    public final View findViewById(int id) { return null; }
    public int getTop() { return 0; }
    public int getWidth() { return 0; }
    public int getHeight() { return 0; }
    public void setTag(Object tag) {}
    public <T extends View> T findViewWithTag(Object tag) { return null; }
    public boolean post(Runnable action) { return false; }
    public boolean isAttachedToWindow() { return false; }
    public void setBackgroundColor(int color) {}
    public void setBackground(Drawable background) {}
    public void setPadding(int left, int top, int right, int bottom) {}
    public void setPaddingRelative(int start, int top, int end, int bottom) {}
    public void setRotation(float degrees) {}
    public void setSelected(boolean selected) {}
    public void setVisibility(int visibility) {}
    public int getVisibility() { return VISIBLE; }
    public void setAlpha(float alpha) {}
    public void setElevation(float elevation) {}
    public void setMinimumWidth(int minWidth) {}
    public void setMinimumHeight(int minHeight) {}
    public void setClickable(boolean clickable) {}
    public void setFocusable(boolean focusable) {}
    public void setImportantForAccessibility(int mode) {}
    public void setContentDescription(CharSequence text) {}
    public void setLayoutParams(ViewGroup.LayoutParams params) {}
    public ViewGroup.LayoutParams getLayoutParams() { return null; }
    public void scrollTo(int x, int y) {}
    public void setOnClickListener(OnClickListener listener) {}
    public boolean performClick() { return false; }
    public void setOnTouchListener(OnTouchListener listener) {}
    public interface OnTouchListener { boolean onTouch(View view, MotionEvent event); }
    public interface OnClickListener { void onClick(View view); }
}
