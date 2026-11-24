package android.view;
import android.content.Context;
public class ViewGroup extends View {
    public ViewGroup(Context context) { super(context); }
    public void addView(View child) {}
    public void addView(View child, LayoutParams params) {}
    public int getChildCount() { return 0; }
    public View getChildAt(int index) { return null; }
    public void removeView(View child) {}
    public void removeAllViews() {}
    public static class LayoutParams {}
    public static class MarginLayoutParams extends LayoutParams {
        public void setMargins(int left, int top, int right, int bottom) {}
    }
}
