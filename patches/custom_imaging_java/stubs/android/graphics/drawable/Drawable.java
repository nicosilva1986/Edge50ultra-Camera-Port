package android.graphics.drawable;

public abstract class Drawable {
    public Drawable mutate() { return this; }
    public void setTint(int tintColor) {}
}
