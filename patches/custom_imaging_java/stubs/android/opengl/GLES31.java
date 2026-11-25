package android.opengl;

import java.nio.Buffer;

/** Compile-time SDK signatures. No GL context exists in the headless test runner. */
public final class GLES31 {
    public static final int GL_COMPUTE_SHADER = 0x91B9;
    public static final int GL_SHADER_STORAGE_BUFFER = 0x90D2;
    public static final int GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = 0x00000020;
    public static final int GL_TEXTURE_FETCH_BARRIER_BIT = 0x00000008;
    public static final int GL_BUFFER_UPDATE_BARRIER_BIT = 0x00000200;
    public static final int GL_FRAMEBUFFER_BARRIER_BIT = 0x00000400;
    public static final int GL_SHADER_STORAGE_BARRIER_BIT = 0x00002000;
    public static final int GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = 0x90EB;
    public static final int GL_RGBA16F = 0x881A;
    public static final int GL_HALF_FLOAT = 0x140B;
    public static final int GL_FLOAT = 0x1406;

    private GLES31() {}
    public static String glGetString(int name) { return null; }
    public static void glGetIntegerv(int pname, int[] data, int offset) {}
    public static int glCreateShader(int type) { return 0; }
    public static void glShaderSource(int shader, String text) {  }
    public static void glCompileShader(int shader) {  }
    public static void glGetShaderiv(int shader, int name, int[] values, int offset) {  }
    public static String glGetShaderInfoLog(int shader) { return ""; }
    public static int glCreateProgram() { return 0; }
    public static void glAttachShader(int program, int shader) {  }
    public static void glLinkProgram(int program) {  }
    public static void glGetProgramiv(int program, int name, int[] values, int offset) {  }
    public static String glGetProgramInfoLog(int program) { return ""; }
    public static int glGetUniformLocation(int program, String name) { return 0; }
    public static void glGenBuffers(int count, int[] buffers, int offset) {  }
    public static void glUseProgram(int program) {  }
    public static int glGetError() { return 0; }
    public static void glUniform4fv(int location, int count, float[] values, int offset) {  }
    public static void glUniform2f(int location, float v0, float v1) {  }
    public static void glUniform1f(int location, float v0) {  }
    public static void glBindBuffer(int target, int buffer) {  }
    public static void glBufferData(int target, int size, Buffer data, int usage) {  }
    public static void glBindBufferBase(int target, int index, int buffer) {  }
    public static void glUniform1i(int location, int value) {  }
    public static void glDispatchCompute(int x, int y, int z) {  }
    public static void glMemoryBarrier(int barriers) {  }
    public static Buffer glMapBufferRange(int target, int offset, int bytes, int access) { return null; }
    public static boolean glUnmapBuffer(int target) { return false; }
    public static void glDeleteProgram(int program) {  }
    public static void glDeleteShader(int shader) {  }
    public static void glDeleteBuffers(int count, int[] buffers, int offset) {  }
}
