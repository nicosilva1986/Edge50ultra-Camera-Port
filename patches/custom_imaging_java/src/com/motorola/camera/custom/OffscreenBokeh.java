// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.opengl.EGL14;
import android.opengl.GLES20;
import java.nio.ByteBuffer;

/**
 * Offscreen OpenGL ES 3.x portrait aperture renderer on Adreno 735.
 * Reuses thread-local GpuComputeContext, gathers 32 taps in fp32 linear light with HDR specular
 * highlight expansion and mechanical cat's-eye vignetting, and cleans up all VRAM objects per shot.
 */
final class OffscreenBokeh {
    private static final String VERTEX = "#version 300 es\n"
            + "out vec2 uv;\n"
            + "void main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));"
            + "gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }";

    private static final String FRAGMENT = String.join("\n",
            "#version 300 es",
            "precision highp float;",
            "precision highp int;",
            "in vec2 uv;",
            "out vec4 outputColor;",
            "uniform sampler2D image, depth;",
            "uniform vec2 radius;",
            "uniform float focus;",
            "uniform int style;",
            "uniform vec3 taps[32];",
            "vec3 toLin(vec3 s){ bvec3 lo=lessThanEqual(s,vec3(0.04045)); return mix(pow((s+0.055)/1.055,vec3(2.4)),s/12.92,lo); }",
            "vec3 toSrgb(vec3 l){ l=clamp(l,0.0,1.0); bvec3 lo=lessThanEqual(l,vec3(0.0031308)); return mix(1.055*pow(l,vec3(1.0/2.4))-0.055,12.92*l,lo); }",
            "float coc(float d){return smoothstep(3.0/255.0,71.0/255.0,abs(d-focus));}",
            "float dweight(float d,float ds,float c){return (1.0-smoothstep(18.0/255.0,46.0/255.0,abs(d-ds)))*step(c*0.38,coc(ds));}",
            "void main(){",
            " float d=texture(depth,uv).r; float c=coc(d);",
            " vec3 origSrgb=texture(image,uv).rgb;",
            " if(c<0.02){outputColor=vec4(origSrgb,1.0);return;}",
            " vec2 radial=uv-0.5; float edge=length(radial); vec2 n=radial/max(edge,0.0001);",
            " float a=1.7*edge*c; mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));",
            " vec3 rgb=vec3(0.0); float sum=0.0;",
            " for(int i=0;i<32;++i){",
            "   vec2 p=taps[i].xy;",
            "   if(style==1){p=rot*p; p-=n*dot(n,p)*edge*0.8;}",
            "   else if(style!=4){p-=n*dot(n,p)*edge*edge*0.22;}",
            "   vec2 at=clamp(uv+p*radius*c,vec2(0.0),vec2(1.0)); float ds=texture(depth,at).r;",
            "   float dw=dweight(d,ds,c);",
            "   if(dw<=0.0) continue;",
            "   vec3 lin=toLin(texture(image,at).rgb);",
            "   float luma=dot(lin,vec3(0.2126,0.7152,0.0722));",
            "   float spec=1.0+1.35*smoothstep(0.72,1.0,luma)*c;",
            "   float w=taps[i].z*dw;",
            "   rgb+=lin*spec*w; sum+=w;",
            " }",
            " rgb=sum>0.0?rgb/sum:toLin(origSrgb);",
            " if(style==4){",
            "   vec2 streak=vec2(radius.x*c,0.0);",
            "   vec3 sSum=vec3(0.0); float sW=0.0;",
            "   for(int k=-1;k<=1;k+=2){",
            "     vec2 sat=clamp(uv+float(k)*streak,vec2(0.0),vec2(1.0));",
            "     float sds=texture(depth,sat).r;",
            "     float dw=dweight(d,sds,c);",
            "     if(dw>0.0){",
            "       sSum+=toLin(texture(image,sat).rgb)*dw; sW+=dw;",
            "     }",
            "   }",
            "   if(sW>0.0){",
            "     vec3 b=sSum/sW;",
            "     rgb+=0.18*c*vec3(0.45,0.85,1.0)*max(0.0,max(b.r,max(b.g,b.b))-0.68);",
            "   }",
            " }",
            " outputColor=vec4(toSrgb(rgb),1.0);",
            "}");

    private OffscreenBokeh() {}

    static int[] render(int[] image, byte[] depth, int width, int height, int focus, int style) {
        return render(image, depth, width, height, focus, style, 1.0f);
    }

    static int[] render(int[] image, byte[] depth, int width, int height, int focus, int style, float radiusScale) {
        if (image == null || depth == null || width <= 0 || height <= 0
                || image.length < width * height || depth.length < width * height) {
            return null;
        }
        // Leave any caller-owned preview GL context untouched; acquire our worker Pbuffer context otherwise.
        if (!EGL14.EGL_NO_CONTEXT.equals(EGL14.eglGetCurrentContext())) return null;
        try (GpuComputeContext.Scope scope = GpuComputeContext.acquire()) {
            if (scope == null) return null;
            return drawFbo(image, depth, width, height, focus, style, radiusScale);
        } catch (RuntimeException | LinkageError failure) {
            return null;
        }
    }

    private static int[] drawFbo(int[] pixels, byte[] depth, int width, int height,
                                 int focus, int style, float radiusScale) {
        int vertex = 0, fragment = 0, program = 0;
        int[] texIds = new int[3];
        int[] fboIds = new int[1];
        try {
            vertex = compile(GLES20.GL_VERTEX_SHADER, VERTEX);
            fragment = compile(GLES20.GL_FRAGMENT_SHADER, FRAGMENT);
            if (vertex == 0 || fragment == 0) return null;
            program = GLES20.glCreateProgram();
            if (program == 0) return null;
            GLES20.glAttachShader(program, vertex);
            GLES20.glAttachShader(program, fragment);
            GLES20.glLinkProgram(program);
            int[] status = new int[1];
            GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, status, 0);
            if (status[0] == 0) return null;

            GLES20.glGenTextures(3, texIds, 0);
            GLES20.glGenFramebuffers(1, fboIds, 0);
            if (texIds[0] == 0 || texIds[1] == 0 || texIds[2] == 0 || fboIds[0] == 0) return null;

            // Attach offscreen color target sized to full portrait resolution.
            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, texIds[2]);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_NEAREST);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_NEAREST);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
            GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0,
                    GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, null);
            GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, fboIds[0]);
            GLES20.glFramebufferTexture2D(GLES20.GL_FRAMEBUFFER, GLES20.GL_COLOR_ATTACHMENT0,
                    GLES20.GL_TEXTURE_2D, texIds[2], 0);
            if (GLES20.glCheckFramebufferStatus(GLES20.GL_FRAMEBUFFER) != GLES20.GL_FRAMEBUFFER_COMPLETE) {
                return null;
            }

            ByteBuffer imageBuf = ByteBuffer.allocateDirect(4 * pixels.length);
            ByteBuffer depthBuf = ByteBuffer.allocateDirect(4 * pixels.length);
            for (int i = 0; i < pixels.length; i++) {
                int color = pixels[i];
                imageBuf.put((byte) (color >>> 16)).put((byte) (color >>> 8)).put((byte) color).put((byte) 255);
                depthBuf.put(depth[i]).put((byte) 0).put((byte) 0).put((byte) 255);
            }
            imageBuf.flip();
            depthBuf.flip();

            GLES20.glUseProgram(program);
            uploadTexture(program, "image", texIds[0], imageBuf, width, height, 0, GLES20.GL_LINEAR);
            uploadTexture(program, "depth", texIds[1], depthBuf, width, height, 1, GLES20.GL_NEAREST);
            GLES20.glUniform1i(GLES20.glGetUniformLocation(program, "style"), style);
            GLES20.glUniform1f(GLES20.glGetUniformLocation(program, "focus"), focus / 255f);
            float safeScale = Math.max(0.70f, Math.min(1.45f, Float.isFinite(radiusScale) ? radiusScale : 1.0f));
            float radius = Math.max(2f, Math.min(width, height) * 0.027f * safeScale);
            GLES20.glUniform2f(GLES20.glGetUniformLocation(program, "radius"), radius / width, radius / height);
            GLES20.glUniform3fv(GLES20.glGetUniformLocation(program, "taps[0]"), BokehKernel.TAPS,
                    BokehKernel.aperture(style), 0);
            GLES20.glViewport(0, 0, width, height);
            GLES20.glDrawArrays(GLES20.GL_TRIANGLES, 0, 3);
            imageBuf.clear();
            GLES20.glReadPixels(0, 0, width, height, GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, imageBuf);
            if (GLES20.glGetError() != 0) return null;
            imageBuf.rewind();
            int[] result = new int[pixels.length];
            for (int i = 0; i < result.length; i++) {
                result[i] = 0xff000000 | ((imageBuf.get() & 255) << 16)
                        | ((imageBuf.get() & 255) << 8) | (imageBuf.get() & 255);
                imageBuf.get();
            }
            return result;
        } finally {
            try {
                GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);
                GLES20.glUseProgram(0);
                if (fboIds[0] != 0) GLES20.glDeleteFramebuffers(1, fboIds, 0);
                if (texIds[0] != 0 || texIds[1] != 0 || texIds[2] != 0) GLES20.glDeleteTextures(3, texIds, 0);
                if (program != 0) GLES20.glDeleteProgram(program);
                if (vertex != 0) GLES20.glDeleteShader(vertex);
                if (fragment != 0) GLES20.glDeleteShader(fragment);
            } catch (RuntimeException | LinkageError ignored) {}
        }
    }

    private static int compile(int type, String source) {
        int shader = GLES20.glCreateShader(type);
        if (shader == 0) return 0;
        GLES20.glShaderSource(shader, source);
        GLES20.glCompileShader(shader);
        int[] status = new int[1];
        GLES20.glGetShaderiv(shader, GLES20.GL_COMPILE_STATUS, status, 0);
        if (status[0] == 0) {
            GLES20.glDeleteShader(shader);
            return 0;
        }
        return shader;
    }

    private static void uploadTexture(int program, String name, int texId, ByteBuffer data,
                                      int width, int height, int unit, int filter) {
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0 + unit);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, texId);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, filter);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, filter);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0,
                GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, data);
        GLES20.glUniform1i(GLES20.glGetUniformLocation(program, name), unit);
    }
}
