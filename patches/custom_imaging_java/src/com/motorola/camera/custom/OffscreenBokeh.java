// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES20;
import java.nio.ByteBuffer;

final class OffscreenBokeh {
    private static final String VERTEX = "#version 300 es\n"
            + "out vec2 uv;\n"
            + "void main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));"
            + "gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }";
    private static final String FRAGMENT = String.join("\n",
            "#version 300 es", "precision highp float;", "in vec2 uv;", "out vec4 outputColor;",
            "uniform sampler2D image, depth;", "uniform vec2 radius;", "uniform float focus;",
            "uniform int style;", "uniform vec3 taps[32];",
            "float coc(float d){return smoothstep(9.0/255.0,74.0/255.0,abs(d-focus));}",
            "void main(){",
            " float d=texture(depth,uv).r; float c=coc(d);",
            " vec3 original=texture(image,uv).rgb;",
            " if(c<0.06){outputColor=vec4(original,1.0);return;}",
            " vec2 radial=uv-0.5; float edge=length(radial); vec2 n=radial/max(edge,0.0001);",
            " float a=1.7*edge*c; mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));",
            " vec3 rgb=vec3(0.0); float sum=0.0;",
            " for(int i=0;i<32;++i){",
            "   vec2 p=taps[i].xy;",
            "   if(style==1){p=rot*p; p-=n*dot(n,p)*edge*0.8;}",
            "   vec2 at=uv+p*radius*c; float ds=texture(depth,at).r;",
            "   if(abs(d-ds)>34.0/255.0 || coc(ds)<c*0.38) continue;",
            "   rgb+=texture(image,at).rgb*taps[i].z; sum+=taps[i].z;",
            " }",
            " rgb=sum>0.0?rgb/sum:original;",
            " if(style==4){",
            "   vec2 streak=vec2(radius.x*c,0.0);",
            "   vec3 sSum=vec3(0.0); float sW=0.0;",
            "   for(int k=-1;k<=1;k+=2){",
            "     vec2 sat=uv+float(k)*streak;",
            "     float sds=texture(depth,sat).r;",
            "     if(abs(d-sds)<=34.0/255.0 && coc(sds)>=c*0.38){",
            "       sSum+=texture(image,sat).rgb; sW+=1.0;",
            "     }",
            "   }",
            "   if(sW>0.0){",
            "     vec3 b=sSum/sW;",
            "     rgb+=0.10*c*vec3(0.6,0.9,1.0)*max(0.0,max(b.r,max(b.g,b.b))-0.85);",
            "   }",
            " }",
            " outputColor=vec4(clamp(rgb,0.0,1.0),1.0);",
            "}");

    private OffscreenBokeh() {}

    static int[] render(int[] image, byte[] depth, int width, int height, int focus, int style) {
        // The save worker normally has no GL context. Leave any caller-owned context alone.
        if (!EGL14.EGL_NO_CONTEXT.equals(EGL14.eglGetCurrentContext())) return null;
        EGLDisplay display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY);
        if (EGL14.EGL_NO_DISPLAY.equals(display)) return null;
        if (!EGL14.eglInitialize(display, null, 0, null, 0)) return null;
        EGLContext context = EGL14.EGL_NO_CONTEXT;
        EGLSurface surface = EGL14.EGL_NO_SURFACE;
        try {
            EGLConfig[] configs = new EGLConfig[1];
            int[] count = new int[1];
            int end = EGL14.EGL_NONE;
            int[] attributes = {EGL14.EGL_SURFACE_TYPE, EGL14.EGL_PBUFFER_BIT,
                    EGL14.EGL_RENDERABLE_TYPE, 0x40, EGL14.EGL_RED_SIZE, 8,
                    EGL14.EGL_GREEN_SIZE, 8, EGL14.EGL_BLUE_SIZE, 8, EGL14.EGL_ALPHA_SIZE, 8, end};
            if (!EGL14.eglChooseConfig(display, attributes, 0, configs, 0, 1, count, 0) || count[0] == 0) return null;
            context = EGL14.eglCreateContext(display, configs[0], EGL14.EGL_NO_CONTEXT,
                    new int[] {EGL14.EGL_CONTEXT_CLIENT_VERSION, 3, end}, 0);
            if (EGL14.EGL_NO_CONTEXT.equals(context)) return null;
            surface = EGL14.eglCreatePbufferSurface(display, configs[0],
                    new int[] {EGL14.EGL_WIDTH, width, EGL14.EGL_HEIGHT, height, end}, 0);
            if (EGL14.EGL_NO_SURFACE.equals(surface) || !EGL14.eglMakeCurrent(display, surface, surface, context)) return null;
            return draw(image, depth, width, height, focus, style);
        } catch (RuntimeException failure) {
            return null;
        } finally {
            EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT);
            if (!EGL14.EGL_NO_SURFACE.equals(surface)) EGL14.eglDestroySurface(display, surface);
            if (!EGL14.EGL_NO_CONTEXT.equals(context)) EGL14.eglDestroyContext(display, context);
            EGL14.eglTerminate(display);
        }
    }

    private static int[] draw(int[] pixels, byte[] depth, int width, int height, int focus, int style) {
        int vertex = compile(GLES20.GL_VERTEX_SHADER, VERTEX);
        int fragment = compile(GLES20.GL_FRAGMENT_SHADER, FRAGMENT);
        if (vertex == 0 || fragment == 0) return null;
        int program = GLES20.glCreateProgram();
        GLES20.glAttachShader(program, vertex);
        GLES20.glAttachShader(program, fragment);
        GLES20.glLinkProgram(program);
        int[] status = new int[1];
        GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, status, 0);
        if (status[0] == 0) return null;
        GLES20.glUseProgram(program);
        ByteBuffer image = ByteBuffer.allocateDirect(4 * pixels.length);
        ByteBuffer depthImage = ByteBuffer.allocateDirect(4 * pixels.length);
        for (int i = 0; i < pixels.length; i++) {
            int color = pixels[i];
            image.put((byte) (color >>> 16)).put((byte) (color >>> 8)).put((byte) color).put((byte) 255);
            depthImage.put(depth[i]).put((byte) 0).put((byte) 0).put((byte) 255);
        }
        image.flip();
        depthImage.flip();
        texture(program, "image", image, width, height, 0, GLES20.GL_LINEAR);
        texture(program, "depth", depthImage, width, height, 1, GLES20.GL_NEAREST);
        GLES20.glUniform1i(GLES20.glGetUniformLocation(program, "style"), style);
        GLES20.glUniform1f(GLES20.glGetUniformLocation(program, "focus"), focus / 255f);
        float radius = Math.max(2, Math.min(width, height) * 0.027f);
        GLES20.glUniform2f(GLES20.glGetUniformLocation(program, "radius"), radius / width, radius / height);
        GLES20.glUniform3fv(GLES20.glGetUniformLocation(program, "taps[0]"), BokehKernel.TAPS,
                BokehKernel.aperture(style), 0);
        GLES20.glViewport(0, 0, width, height);
        GLES20.glDrawArrays(GLES20.GL_TRIANGLES, 0, 3);
        GLES20.glReadPixels(0, 0, width, height, GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, image);
        if (GLES20.glGetError() != 0) return null;
        image.rewind();
        int[] result = new int[pixels.length];
        for (int i = 0; i < result.length; i++) {
            result[i] = 0xff000000 | ((image.get() & 255) << 16) | ((image.get() & 255) << 8) | (image.get() & 255);
            image.get();
        }
        return result;
    }

    private static int compile(int type, String source) {
        int shader = GLES20.glCreateShader(type);
        GLES20.glShaderSource(shader, source);
        GLES20.glCompileShader(shader);
        int[] status = new int[1];
        GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, status, 0);
        return status[0] != 0 ? shader : 0;
    }

    private static void texture(int program, String name, ByteBuffer data, int width, int height, int unit, int filter) {
        int[] ids = new int[1];
        GLES20.glGenTextures(1, ids, 0);
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0 + unit);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, ids[0]);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, filter);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, filter);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0,
                GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, data);
        GLES20.glUniform1i(GLES20.glGetUniformLocation(program, name), unit);
    }
}
