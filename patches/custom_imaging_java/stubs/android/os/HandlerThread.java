package android.os;

public class HandlerThread extends Thread {
    public HandlerThread(String name) { super(name); }
    public Looper getLooper() { return null; }
    public boolean quitSafely() { return false; }
}
