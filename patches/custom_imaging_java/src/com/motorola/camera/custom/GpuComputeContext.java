// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES31;

/**
 * Thread-local persistent offscreen EGL14 OpenGL ES 3.2 / 3.1 compute & render context for
 * Adreno 735 ({@code SM8635}) background workers.
 *
 * <p>Eliminates per-shot {@code eglInitialize/eglCreateContext/eglTerminate} churn while leaving
 * any caller-owned UI/viewfinder context untouched. Enforces GLES 3.1+ portable workgroup bounds
 * ({@code <= 128} invocations unless driver advertises higher) and leading-byte {@code #version}.
 */
public final class GpuComputeContext {
    public static final int DEFAULT_WORKGROUP_1D = 64;
    public static final int DEFAULT_WORKGROUP_2D_X = 8;
    public static final int DEFAULT_WORKGROUP_2D_Y = 8;

    private static final int EGL_OPENGL_ES3_BIT = 0x0040;
    private static final int GL_VERSION_ENUM = 0x1F02;
    private static final ThreadLocal<Holder> THREAD_HOLDER = new ThreadLocal<>();

    private GpuComputeContext() {}

    public static final class Scope implements AutoCloseable {
        public final boolean active;
        public final boolean computeSupported;
        public final int maxWorkGroupInvocations;
        private final boolean unbindOnClose;
        private final EGLDisplay display;

        Scope(boolean active, boolean computeSupported, int maxInvocations,
              boolean unbindOnClose, EGLDisplay display) {
            this.active = active;
            this.computeSupported = computeSupported;
            this.maxWorkGroupInvocations = maxInvocations;
            this.unbindOnClose = unbindOnClose;
            this.display = display;
        }

        @Override
        public void close() {
            if (unbindOnClose && display != null && !EGL14.EGL_NO_DISPLAY.equals(display)) {
                try {
                    EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
                } catch (RuntimeException | LinkageError ignored) {}
            }
        }
    }

    private static final class Holder {
        EGLDisplay display = EGL14.EGL_NO_DISPLAY;
        EGLConfig config;
        EGLContext context = EGL14.EGL_NO_CONTEXT;
        EGLSurface pbuffer = EGL14.EGL_NO_SURFACE;
        boolean computeSupported;
        int maxInvocations = 128;
        boolean valid;

        boolean init() {
            try {
                display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY);
                if (display == null || EGL14.EGL_NO_DISPLAY.equals(display)) return false;
                if (!EGL14.eglInitialize(display, null, 0, null, 0)) return false;
                EGLConfig[] configs = new EGLConfig[1];
                int[] num = new int[1];
                int[] attribs = {
                    EGL14.EGL_SURFACE_TYPE, EGL14.EGL_PBUFFER_BIT,
                    EGL14.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES3_BIT,
                    EGL14.EGL_RED_SIZE, 8,
                    EGL14.EGL_GREEN_SIZE, 8,
                    EGL14.EGL_BLUE_SIZE, 8,
                    EGL14.EGL_ALPHA_SIZE, 8,
                    EGL14.EGL_NONE
                };
                if (!EGL14.eglChooseConfig(display, attribs, 0, configs, 0, 1, num, 0) || num[0] == 0) {
                    return false;
                }
                config = configs[0];
                context = EGL14.eglCreateContext(display, config, EGL14.EGL_NO_CONTEXT,
                        new int[]{EGL14.EGL_CONTEXT_CLIENT_VERSION, 3, EGL14.EGL_NONE}, 0);
                if (context == null || EGL14.EGL_NO_CONTEXT.equals(context)) return false;
                pbuffer = EGL14.eglCreatePbufferSurface(display, config,
                        new int[]{EGL14.EGL_WIDTH, 4, EGL14.EGL_HEIGHT, 4, EGL14.EGL_NONE}, 0);
                if (pbuffer == null || EGL14.EGL_NO_SURFACE.equals(pbuffer)) return false;
                if (!EGL14.eglMakeCurrent(display, pbuffer, pbuffer, context)) return false;

                String ver = GLES31.glGetString(GL_VERSION_ENUM);
                computeSupported = ver != null && (ver.contains("OpenGL ES 3.1") || ver.contains("OpenGL ES 3.2"));
                if (computeSupported) {
                    int[] inv = new int[1];
                    GLES31.glGetIntegerv(GLES31.GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS, inv, 0);
                    if (inv[0] >= 64) maxInvocations = inv[0];
                }
                EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
                valid = true;
                return true;
            } catch (RuntimeException | LinkageError failure) {
                destroy();
                return false;
            }
        }

        void destroy() {
            valid = false;
            try {
                if (display != null && !EGL14.EGL_NO_DISPLAY.equals(display)) {
                    EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
                    if (pbuffer != null && !EGL14.EGL_NO_SURFACE.equals(pbuffer)) {
                        EGL14.eglDestroySurface(display, pbuffer);
                    }
                    if (context != null && !EGL14.EGL_NO_CONTEXT.equals(context)) {
                        EGL14.eglDestroyContext(display, context);
                    }
                }
            } catch (RuntimeException | LinkageError ignored) {}
            pbuffer = EGL14.EGL_NO_SURFACE;
            context = EGL14.EGL_NO_CONTEXT;
            display = EGL14.EGL_NO_DISPLAY;
        }
    }

    /**
     * Binds the worker thread's persistent offscreen GLES 3.1+ context if no context is current.
     * If a caller already holds a current context, uses it in place without unbinding on close.
     */
    public static Scope acquire() {
        try {
            EGLContext existing = EGL14.eglGetCurrentContext();
            if (existing != null && !EGL14.EGL_NO_CONTEXT.equals(existing)) {
                String ver = GLES31.glGetString(GL_VERSION_ENUM);
                boolean cs = ver != null && (ver.contains("OpenGL ES 3.1") || ver.contains("OpenGL ES 3.2"));
                return new Scope(true, cs, 128, false, null);
            }
            Holder h = THREAD_HOLDER.get();
            if (h == null || !h.valid) {
                if (h != null) h.destroy();
                h = new Holder();
                if (!h.init()) {
                    return new Scope(false, false, 0, false, null);
                }
                THREAD_HOLDER.set(h);
            }
            if (!EGL14.eglMakeCurrent(h.display, h.pbuffer, h.pbuffer, h.context)) {
                h.destroy();
                THREAD_HOLDER.remove();
                return new Scope(false, false, 0, false, null);
            }
            return new Scope(true, h.computeSupported, h.maxInvocations, true, h.display);
        } catch (RuntimeException | LinkageError unavailable) {
            return new Scope(false, false, 0, false, null);
        }
    }

    /** Validates shader source starts at byte 0 with {@code #version } and enforces highp int for full-res coords. */
    public static boolean isDriverSafeComputeSource(String glslSource, int localX, int localY, int localZ) {
        if (glslSource == null || !glslSource.startsWith("#version ")) return false;
        if (localX <= 0 || localY <= 0 || localZ <= 0) return false;
        long total = (long) localX * (long) localY * (long) localZ;
        if (total > 128L) return false;
        return glslSource.contains("precision highp int;");
    }

    public static void releaseCurrentThread() {
        Holder h = THREAD_HOLDER.get();
        if (h != null) {
            h.destroy();
            THREAD_HOLDER.remove();
        }
    }
}
