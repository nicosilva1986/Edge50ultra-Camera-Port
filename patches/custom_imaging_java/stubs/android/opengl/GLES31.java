package android.opengl;

import java.nio.Buffer;

/** Compile-time SDK signatures. No GL context exists in the headless test runner. */
public final class GLES31 {
    private GLES31() {}
    public static String glGetString(int name) { return null; }
    public static int glCreateShader(int type) { return 0; }
    public static void glShaderSource(int shader, String text) {  }
    public static void glCompileShader(int shader) {  }
    public static void glGetShaderiv(int shader, int name, int[] values, int offset) {  }
    public static int glCreateProgram() { return 0; }
    public static void glAttachShader(int program, int shader) {  }
    public static void glLinkProgram(int program) {  }
    public static void glGetProgramiv(int program, int name, int[] values, int offset) {  }
    public static int glGetUniformLocation(int program, String name) { return 0; }
    public static void glGenBuffers(int count, int[] buffers, int offset) {  }
    public static void glUseProgram(int program) {  }
    public static int glGetError() { return 0; }
    public static void glUniform4fv(int location, int count, float[] values, int offset) {  }
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
