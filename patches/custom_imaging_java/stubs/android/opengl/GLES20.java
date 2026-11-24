package android.opengl;
import java.nio.Buffer;
public final class GLES20 {
    public static final int GL_ACTIVE_TEXTURE = 0x84e0, GL_TEXTURE0 = 0x84c0, GL_TEXTURE_2D = 0x0de1,
            GL_TEXTURE_MIN_FILTER = 0x2801, GL_TEXTURE_MAG_FILTER = 0x2800, GL_TEXTURE_WRAP_S = 0x2802,
            GL_TEXTURE_WRAP_T = 0x2803, GL_LINEAR = 0x2601, GL_CLAMP_TO_EDGE = 0x812f,
            GL_RGB = 0x1907, GL_UNSIGNED_BYTE = 0x1401, GL_UNPACK_ALIGNMENT = 0x0cf5;
    public static int glGetUniformLocation(int program, String name) { return -1; }
    public static void glUniform1f(int location, float value) {}
    public static void glUniform1i(int location, int value) {}
    public static void glGetIntegerv(int name, int[] values, int offset) {}
    public static void glGenTextures(int count, int[] ids, int offset) {}
    public static void glActiveTexture(int unit) {}
    public static void glBindTexture(int target, int texture) {}
    public static void glTexParameteri(int target, int parameter, int value) {}
    public static void glPixelStorei(int parameter, int value) {}
    public static void glTexImage2D(int target, int level, int internal, int width, int height,
            int border, int format, int type, Buffer pixels) {}
    public static final int GL_NEAREST=0x2600, GL_RGBA=0x1908, GL_TRIANGLES=4,
            GL_VERTEX_SHADER=0x8b31, GL_FRAGMENT_SHADER=0x8b30, GL_LINK_STATUS=0x8b82, GL_COMPILE_STATUS=0x8b81;
    public static int glCreateProgram() { return 0; }
    public static void glAttachShader(int program, int shader) {}
    public static void glLinkProgram(int program) {}
    public static void glGetProgramiv(int program, int name, int[] values, int offset) {}
    public static void glUseProgram(int program) {}
    public static void glUniform2f(int location, float x, float y) {}
    public static void glUniform3fv(int location, int count, float[] values, int offset) {}
    public static void glViewport(int x, int y, int width, int height) {}
    public static void glDrawArrays(int mode, int first, int count) {}
    public static void glReadPixels(int x, int y, int w, int h, int format, int type, Buffer buffer) {}
    public static int glGetError() { return 0; }
    public static int glCreateShader(int type) { return 0; }
    public static void glShaderSource(int shader, String source) {}
    public static void glCompileShader(int shader) {}
    public static void glGetShaderiv(int shader, int name, int[] values, int offset) {}
}
