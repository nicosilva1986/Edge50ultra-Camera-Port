package android.widget;
import android.content.Context;
import android.view.ViewGroup;
public class RelativeLayout extends ViewGroup {
    public static final int ALIGN_PARENT_TOP = 10;
    public static final int ALIGN_PARENT_BOTTOM = 12;
    public static final int CENTER_HORIZONTAL = 14;
    public RelativeLayout(Context context) { super(context); }
    public static class LayoutParams extends ViewGroup.MarginLayoutParams {
        public LayoutParams(int width, int height) {}
        public void addRule(int verb) {}
    }
}
