// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.opengl.EGL14;
import android.opengl.EGLContext;
import android.opengl.GLES20;
import com.motorola.camera.ui.widgets.gl.Shader;
import java.nio.ByteBuffer;
import java.util.WeakHashMap;
import java.util.Map;
import java.util.concurrent.Executors;

public final class LiveLookPreview {
    private static final int UNIT = 7;
    private static final java.util.concurrent.Executor LOADER = Executors.newSingleThreadExecutor();
    private static final ThreadLocal<GlState> GL = new ThreadLocal<>();
    private static volatile int selected;
    private static volatile int intensity = 100;
    private static volatile boolean compare;
    private static volatile boolean profilePaused;
    private static volatile LookTexture ready;

    private LiveLookPreview() {}

    public static void select(int look, int amount) {
        intensity = amount;
        LookTexture current = ready;
        boolean alreadyReady = selected == look && (look == 0 || (current != null && current.id == look));
        if (alreadyReady) return;
        selected = look;
        if (current != null && current.id != look) {
            ready = null;
        }
        if (look == 0) {
            ready = null;
            return;
        }
        LOADER.execute(() -> {
            if (selected != look) return;
            try {
                LookFilterEngine engine = CustomImagingBridge.loadLook(look);
                if (engine == null) return;
                ByteBuffer pixels = engine.texturePixels();
                if (selected == look) ready = new LookTexture(look, pixels);
            } catch (java.io.IOException ignored) {
                // Keep ready == null so a subsequent select() can retry once assets are ready.
            }
        });
    }

    public static void setCompare(boolean enabled) {
        compare = enabled;
    }

    public static void setProfilePaused(boolean paused) {
        profilePaused = paused;
    }

    public static void bind(Shader shader) {
        EGLContext context = EGL14.eglGetCurrentContext();
        GlState state = GL.get();
        if (state == null || !context.equals(state.context)) {
            state = new GlState(context);
            GL.set(state);
        }
        int program = shader.mProgramHandle;
        int[] locations = state.programs.get(shader);
        if (locations == null) {
            locations = new int[] {
                GLES20.glGetUniformLocation(program, "u_EffectsLutTex"),
                GLES20.glGetUniformLocation(program, "u_EffectsIntensity"),
                GLES20.glGetUniformLocation(program, "u_EffectsVignette"),
                GLES20.glGetUniformLocation(program, "u_EffectsHalation"),
                GLES20.glGetUniformLocation(program, "u_EffectsGrain"),
                GLES20.glGetUniformLocation(program, "u_EffectsShoulder")
            };
            state.programs.put(shader, locations);
        }
        if (locations[0] < 0) return;
        GLES20.glUniform1i(locations[0], UNIT);
        LookTexture look = ready;
        if (look == null || selected != look.id || compare || profilePaused || intensity == 0) {
            GLES20.glUniform1f(locations[1], 0);
            if (locations[5] >= 0) GLES20.glUniform1f(locations[5], 0);
            return;
        }
        GLES20.glGetIntegerv(GLES20.GL_ACTIVE_TEXTURE, state.scratch, 0);
        int active = state.scratch[0];
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0 + UNIT);
        if (state.texture == 0) {
            GLES20.glGenTextures(1, state.scratch, 0);
            state.texture = state.scratch[0];
        }
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, state.texture);
        if (state.uploaded != look) {
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
            GLES20.glGetIntegerv(GLES20.GL_UNPACK_ALIGNMENT, state.scratch, 0);
            GLES20.glPixelStorei(GLES20.GL_UNPACK_ALIGNMENT, 1);
            GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGB, 33, 1089, 0,
                    GLES20.GL_RGB, GLES20.GL_UNSIGNED_BYTE, look.pixels.duplicate());
            GLES20.glPixelStorei(GLES20.GL_UNPACK_ALIGNMENT, state.scratch[0]);
            state.uploaded = look;
        }
        GLES20.glActiveTexture(active);
        GLES20.glUniform1f(locations[1], intensity / 100f);
        GLES20.glUniform1f(locations[2], look.id == 1 ? 0.27f : look.id == 2 ? 0.13f : 0);
        GLES20.glUniform1f(locations[3], look.id == 7 ? 0.16f : look.id == 8 ? -0.22f : 0);
        GLES20.glUniform1f(locations[4], look.id == 3 || look.id >= 9 ? 0.016f : 0);
        if (locations[5] >= 0) GLES20.glUniform1f(locations[5], 1.0f);
    }

    private static final class LookTexture {
        final int id;
        final ByteBuffer pixels;

        LookTexture(int id, ByteBuffer pixels) {
            this.id = id;
            this.pixels = pixels;
        }
    }

    private static final class GlState {
        final EGLContext context;
        final Map<Shader, int[]> programs = new WeakHashMap<>();
        final int[] scratch = new int[1];
        int texture;
        LookTexture uploaded;

        GlState(EGLContext context) {
            this.context = context;
        }
    }
}
