package android.opengl;
public final class EGL14 {
    public static final EGLContext EGL_NO_CONTEXT = null;
    public static final EGLDisplay EGL_NO_DISPLAY = null;
    public static final EGLSurface EGL_NO_SURFACE = null;
    public static final int EGL_DEFAULT_DISPLAY = 0, EGL_NONE = 0x3038, EGL_SURFACE_TYPE = 0x3033,
            EGL_PBUFFER_BIT = 1, EGL_RENDERABLE_TYPE = 0x3040, EGL_RED_SIZE = 0x3024,
            EGL_GREEN_SIZE = 0x3023, EGL_BLUE_SIZE = 0x3022, EGL_ALPHA_SIZE = 0x3021,
            EGL_CONTEXT_CLIENT_VERSION = 0x3098, EGL_WIDTH = 0x3057, EGL_HEIGHT = 0x3056;
    public static EGLContext eglGetCurrentContext() { return null; }
    public static EGLDisplay eglGetDisplay(int id) { return null; }
    public static boolean eglInitialize(EGLDisplay display, int[] major, int a, int[] minor, int b) { return false; }
    public static boolean eglChooseConfig(EGLDisplay display, int[] values, int a, EGLConfig[] configs, int b, int count, int[] found, int c) { return false; }
    public static EGLContext eglCreateContext(EGLDisplay display, EGLConfig config, EGLContext shared, int[] values, int a) { return null; }
    public static EGLSurface eglCreatePbufferSurface(EGLDisplay display, EGLConfig config, int[] values, int a) { return null; }
    public static boolean eglMakeCurrent(EGLDisplay display, EGLSurface draw, EGLSurface read, EGLContext context) { return false; }
    public static boolean eglDestroyContext(EGLDisplay display, EGLContext context) { return false; }
    public static boolean eglDestroySurface(EGLDisplay display, EGLSurface surface) { return false; }
    public static boolean eglTerminate(EGLDisplay display) { return false; }
}
