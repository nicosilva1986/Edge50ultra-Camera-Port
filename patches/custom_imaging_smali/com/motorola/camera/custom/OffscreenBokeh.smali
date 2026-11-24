.class final Lcom/motorola/camera/custom/OffscreenBokeh;
.super Ljava/lang/Object;
.source "OffscreenBokeh.java"


# static fields
.field private static final FRAGMENT:Ljava/lang/String;

.field private static final VERTEX:Ljava/lang/String; = "#version 300 es\nout vec2 uv;\nvoid main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }"


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 17
    const/16 v0, 0x2a

    new-array v0, v0, [Ljava/lang/CharSequence;

    const/4 v1, 0x0

    const-string v2, "#version 300 es"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "precision highp float;"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "in vec2 uv;"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "out vec4 outputColor;"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "uniform sampler2D image, depth;"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "uniform vec2 radius;"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "uniform float focus;"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "uniform int style;"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "uniform vec3 taps[32];"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "float coc(float d){return smoothstep(9.0/255.0,74.0/255.0,abs(d-focus));}"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "void main(){"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, " float d=texture(depth,uv).r; float c=coc(d);"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, " vec3 original=texture(image,uv).rgb;"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, " if(c<0.06){outputColor=vec4(original,1.0);return;}"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, " vec2 radial=uv-0.5; float edge=length(radial); vec2 n=radial/max(edge,0.0001);"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, " float a=1.7*edge*c; mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, " vec3 rgb=vec3(0.0); float sum=0.0;"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, " for(int i=0;i<32;++i){"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "   vec2 p=taps[i].xy;"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "   if(style==1){p=rot*p; p-=n*dot(n,p)*edge*0.8;}"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "   vec2 at=uv+p*radius*c; float ds=texture(depth,at).r;"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "   if(abs(d-ds)>34.0/255.0 || coc(ds)<c*0.38) continue;"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "   rgb+=texture(image,at).rgb*taps[i].z; sum+=taps[i].z;"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, " }"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v3, " rgb=sum>0.0?rgb/sum:original;"

    aput-object v3, v0, v1

    const/16 v1, 0x19

    const-string v3, " if(style==4){"

    aput-object v3, v0, v1

    const/16 v1, 0x1a

    const-string v3, "   vec2 streak=vec2(radius.x*c,0.0);"

    aput-object v3, v0, v1

    const/16 v1, 0x1b

    const-string v3, "   vec3 sSum=vec3(0.0); float sW=0.0;"

    aput-object v3, v0, v1

    const/16 v1, 0x1c

    const-string v3, "   for(int k=-1;k<=1;k+=2){"

    aput-object v3, v0, v1

    const/16 v1, 0x1d

    const-string v3, "     vec2 sat=uv+float(k)*streak;"

    aput-object v3, v0, v1

    const/16 v1, 0x1e

    const-string v3, "     float sds=texture(depth,sat).r;"

    aput-object v3, v0, v1

    const/16 v1, 0x1f

    const-string v3, "     if(abs(d-sds)<=34.0/255.0 && coc(sds)>=c*0.38){"

    aput-object v3, v0, v1

    const/16 v1, 0x20

    const-string v3, "       sSum+=texture(image,sat).rgb; sW+=1.0;"

    aput-object v3, v0, v1

    const/16 v1, 0x21

    const-string v3, "     }"

    aput-object v3, v0, v1

    const/16 v1, 0x22

    const-string v3, "   }"

    aput-object v3, v0, v1

    const/16 v1, 0x23

    const-string v4, "   if(sW>0.0){"

    aput-object v4, v0, v1

    const/16 v1, 0x24

    const-string v4, "     vec3 b=sSum/sW;"

    aput-object v4, v0, v1

    const/16 v1, 0x25

    const-string v4, "     rgb+=0.10*c*vec3(0.6,0.9,1.0)*max(0.0,max(b.r,max(b.g,b.b))-0.85);"

    aput-object v4, v0, v1

    const/16 v1, 0x26

    aput-object v3, v0, v1

    const/16 v1, 0x27

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, " outputColor=vec4(clamp(rgb,0.0,1.0),1.0);"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "}"

    aput-object v2, v0, v1

    const-string v1, "\n"

    invoke-static {v1, v0}, Ljava/lang/String;->join(Ljava/lang/CharSequence;[Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/OffscreenBokeh;->FRAGMENT:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static compile(ILjava/lang/String;)I
    .locals 2

    .line 133
    invoke-static {p0}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result p0

    .line 134
    invoke-static {p0, p1}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    .line 135
    invoke-static {p0}, Landroid/opengl/GLES20;->glCompileShader(I)V

    .line 136
    const/4 p1, 0x1

    new-array p1, p1, [I

    .line 137
    const v0, 0x8b81

    const/4 v1, 0x0

    invoke-static {p0, v0, p1, v1}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    .line 138
    aget p1, p1, v1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    move p0, v1

    :goto_0
    return p0
.end method

.method private static draw([I[BIIII)[I
    .locals 11

    .line 91
    const v0, 0x8b31

    const-string v1, "#version 300 es\nout vec2 uv;\nvoid main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }"

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/OffscreenBokeh;->compile(ILjava/lang/String;)I

    move-result v0

    .line 92
    const v1, 0x8b30

    sget-object v2, Lcom/motorola/camera/custom/OffscreenBokeh;->FRAGMENT:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/motorola/camera/custom/OffscreenBokeh;->compile(ILjava/lang/String;)I

    move-result v1

    .line 93
    const/4 v7, 0x0

    if-eqz v0, :cond_5

    if-nez v1, :cond_0

    goto/16 :goto_2

    .line 94
    :cond_0
    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v2

    .line 95
    invoke-static {v2, v0}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 96
    invoke-static {v2, v1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 97
    invoke-static {v2}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    .line 98
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 99
    const v1, 0x8b82

    const/4 v8, 0x0

    invoke-static {v2, v1, v0, v8}, Landroid/opengl/GLES20;->glGetProgramiv(II[II)V

    .line 100
    aget v0, v0, v8

    if-nez v0, :cond_1

    return-object v7

    .line 101
    :cond_1
    invoke-static {v2}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 102
    array-length v0, p0

    const/4 v9, 0x4

    mul-int/2addr v0, v9

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    .line 103
    array-length v0, p0

    mul-int/2addr v0, v9

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v10

    .line 104
    move v0, v8

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_2

    .line 105
    aget v1, p0, v0

    .line 106
    ushr-int/lit8 v3, v1, 0x10

    int-to-byte v3, v3

    invoke-virtual {v6, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v3

    ushr-int/lit8 v4, v1, 0x8

    int-to-byte v4, v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v3

    int-to-byte v1, v1

    invoke-virtual {v3, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v1

    const/4 v3, -0x1

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 107
    aget-byte v1, p1, v0

    invoke-virtual {v10, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 104
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 109
    :cond_2
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 110
    invoke-virtual {v10}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 111
    const/4 v5, 0x0

    move v0, v2

    move-object v2, v6

    const/16 v6, 0x2601

    const-string v1, "image"

    move v3, p2

    move v4, p3

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/OffscreenBokeh;->texture(ILjava/lang/String;Ljava/nio/ByteBuffer;IIII)V

    .line 112
    move-object p1, v2

    const/4 v5, 0x1

    const/16 v6, 0x2600

    const-string v1, "depth"

    move-object v2, v10

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/OffscreenBokeh;->texture(ILjava/lang/String;Ljava/nio/ByteBuffer;IIII)V

    .line 113
    const-string v1, "style"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    move/from16 v2, p5

    invoke-static {v1, v2}, Landroid/opengl/GLES20;->glUniform1i(II)V

    .line 114
    const-string v1, "focus"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    int-to-float v5, p4

    const/high16 v6, 0x437f0000    # 255.0f

    div-float/2addr v5, v6

    invoke-static {v1, v5}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 115
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->min(II)I

    move-result v1

    int-to-float v1, v1

    const v5, 0x3cdd2f1b    # 0.027f

    mul-float/2addr v1, v5

    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 116
    const-string v5, "radius"

    invoke-static {v0, v5}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v5

    int-to-float v6, p2

    div-float v6, v1, v6

    int-to-float v10, p3

    div-float/2addr v1, v10

    invoke-static {v5, v6, v1}, Landroid/opengl/GLES20;->glUniform2f(IFF)V

    .line 117
    const-string v1, "taps[0]"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    .line 118
    invoke-static {v2}, Lcom/motorola/camera/custom/BokehKernel;->aperture(I)[F

    move-result-object v1

    .line 117
    const/16 v2, 0x20

    invoke-static {v0, v2, v1, v8}, Landroid/opengl/GLES20;->glUniform3fv(II[FI)V

    .line 119
    invoke-static {v8, v8, p2, p3}, Landroid/opengl/GLES20;->glViewport(IIII)V

    .line 120
    const/4 v0, 0x3

    invoke-static {v9, v8, v0}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    .line 121
    const/16 v4, 0x1908

    const/16 v5, 0x1401

    const/4 v0, 0x0

    const/4 v1, 0x0

    move-object v6, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v6}, Landroid/opengl/GLES20;->glReadPixels(IIIIIILjava/nio/Buffer;)V

    .line 122
    move-object v2, v6

    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result p1

    if-eqz p1, :cond_3

    return-object v7

    .line 123
    :cond_3
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/ByteBuffer;

    .line 124
    array-length p0, p0

    new-array p1, p0, [I

    .line 125
    nop

    :goto_1
    if-ge v8, p0, :cond_4

    .line 126
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->get()B

    move-result p2

    and-int/lit16 p2, p2, 0xff

    shl-int/lit8 p2, p2, 0x10

    const/high16 v0, -0x1000000

    or-int/2addr p2, v0

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->get()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    or-int/2addr p2, v0

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->get()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    or-int/2addr p2, v0

    aput p2, p1, v8

    .line 127
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->get()B

    .line 125
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 129
    :cond_4
    return-object p1

    .line 93
    :cond_5
    :goto_2
    return-object v7
.end method

.method static render([I[BIIII)[I
    .locals 12

    .line 59
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 60
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Landroid/opengl/EGL14;->eglGetDisplay(I)Landroid/opengl/EGLDisplay;

    move-result-object v2

    .line 61
    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    invoke-virtual {v3, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v1

    .line 62
    :cond_1
    invoke-static {v2, v1, v0, v1, v0}, Landroid/opengl/EGL14;->eglInitialize(Landroid/opengl/EGLDisplay;[II[II)Z

    move-result v3

    if-nez v3, :cond_2

    return-object v1

    .line 63
    :cond_2
    sget-object v10, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    .line 64
    sget-object v11, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    .line 66
    const/4 v3, 0x1

    :try_start_0
    new-array v5, v3, [Landroid/opengl/EGLConfig;

    .line 67
    new-array v8, v3, [I

    .line 68
    nop

    .line 69
    const/16 v3, 0xd

    new-array v3, v3, [I

    fill-array-data v3, :array_0

    .line 72
    const/4 v7, 0x1

    const/4 v9, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    invoke-static/range {v2 .. v9}, Landroid/opengl/EGL14;->eglChooseConfig(Landroid/opengl/EGLDisplay;[II[Landroid/opengl/EGLConfig;II[II)Z

    move-result v3

    if-eqz v3, :cond_d

    aget v3, v8, v0

    if-nez v3, :cond_3

    goto/16 :goto_1

    .line 73
    :cond_3
    aget-object v3, v5, v0

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    const/16 v6, 0x3038

    const/16 v7, 0x3098

    const/4 v8, 0x3

    filled-new-array {v7, v8, v6}, [I

    move-result-object v7

    invoke-static {v2, v3, v4, v7, v0}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v10

    .line 75
    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v3, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_6

    .line 83
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p0, p1, p2}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p0, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_4

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_4
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p0, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_5

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_5
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 75
    return-object v1

    .line 76
    :cond_6
    :try_start_1
    aget-object v3, v5, v0

    const/16 v4, 0x3057

    const/16 v5, 0x3056

    filled-new-array {v4, p2, v5, p3, v6}, [I

    move-result-object v4

    invoke-static {v2, v3, v4, v0}, Landroid/opengl/EGL14;->eglCreatePbufferSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;[II)Landroid/opengl/EGLSurface;

    move-result-object v11

    .line 78
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {v0, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    invoke-static {v2, v11, v11, v10}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move-result v0

    if-nez v0, :cond_7

    goto :goto_0

    .line 79
    :cond_7
    invoke-static/range {p0 .. p5}, Lcom/motorola/camera/custom/OffscreenBokeh;->draw([I[BIIII)[I

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 83
    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p1, p2, p3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p1, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_8

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_8
    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p1, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_9

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_9
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 79
    return-object p0

    .line 83
    :cond_a
    :goto_0
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p0, p1, p2}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p0, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_b

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_b
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p0, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_c

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_c
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 78
    return-object v1

    .line 83
    :cond_d
    :goto_1
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p0, p1, p2}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p0, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_e

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_e
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p0, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_f

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_f
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 72
    return-object v1

    .line 83
    :catchall_0
    move-exception v0

    move-object p0, v0

    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p1, p2, p3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p1, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_10

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_10
    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p1, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_11

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_11
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 87
    throw p0

    .line 80
    :catch_0
    move-exception v0

    .line 81
    nop

    .line 83
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object p2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, p0, p1, p2}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 84
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    invoke-virtual {p0, v11}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_12

    invoke-static {v2, v11}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 85
    :cond_12
    sget-object p0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {p0, v10}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_13

    invoke-static {v2, v10}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 86
    :cond_13
    invoke-static {v2}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 81
    return-object v1

    :array_0
    .array-data 4
        0x3033
        0x1
        0x3040
        0x40
        0x3024
        0x8
        0x3023
        0x8
        0x3022
        0x8
        0x3021
        0x8
        0x3038
    .end array-data
.end method

.method private static texture(ILjava/lang/String;Ljava/nio/ByteBuffer;IIII)V
    .locals 13

    .line 142
    move/from16 v0, p5

    move/from16 v1, p6

    const/4 v2, 0x1

    new-array v3, v2, [I

    .line 143
    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Landroid/opengl/GLES20;->glGenTextures(I[II)V

    .line 144
    const v2, 0x84c0

    add-int/2addr v2, v0

    invoke-static {v2}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 145
    aget v2, v3, v4

    const/16 v3, 0xde1

    invoke-static {v3, v2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 146
    const/16 v2, 0x2801

    invoke-static {v3, v2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 147
    const/16 v2, 0x2800

    invoke-static {v3, v2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 148
    const/16 v1, 0x2802

    const v2, 0x812f

    invoke-static {v3, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 149
    const/16 v1, 0x2803

    invoke-static {v3, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 150
    const/16 v10, 0x1908

    const/16 v11, 0x1401

    const/16 v4, 0xde1

    const/4 v5, 0x0

    const/16 v6, 0x1908

    const/4 v9, 0x0

    move-object v12, p2

    move/from16 v7, p3

    move/from16 v8, p4

    invoke-static/range {v4 .. v12}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 152
    invoke-static/range {p0 .. p1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result p0

    invoke-static {p0, v0}, Landroid/opengl/GLES20;->glUniform1i(II)V

    .line 153
    return-void
.end method
