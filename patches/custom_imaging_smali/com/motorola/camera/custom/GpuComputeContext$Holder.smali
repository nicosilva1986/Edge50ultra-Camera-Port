.class final Lcom/motorola/camera/custom/GpuComputeContext$Holder;
.super Ljava/lang/Object;
.source "GpuComputeContext.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/GpuComputeContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Holder"
.end annotation


# instance fields
.field computeSupported:Z

.field config:Landroid/opengl/EGLConfig;

.field context:Landroid/opengl/EGLContext;

.field display:Landroid/opengl/EGLDisplay;

.field maxInvocations:I

.field pbuffer:Landroid/opengl/EGLSurface;

.field valid:Z


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    .line 59
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    .line 60
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    .line 62
    const/16 v0, 0x80

    iput v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->maxInvocations:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/motorola/camera/custom/GpuComputeContext-IA;)V
    .locals 0

    invoke-direct {p0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;-><init>()V

    return-void
.end method


# virtual methods
.method destroy()V
    .locals 4

    .line 110
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->valid:Z

    .line 112
    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    if-eqz v0, :cond_1

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 113
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 114
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    if-eqz v0, :cond_0

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 115
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 117
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    if-eqz v0, :cond_1

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 118
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 121
    :catch_0
    move-exception v0

    :cond_1
    :goto_0
    nop

    .line 122
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    .line 123
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    .line 124
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    .line 125
    return-void
.end method

.method init()Z
    .locals 10

    .line 67
    const/4 v1, 0x0

    :try_start_0
    invoke-static {v1}, Landroid/opengl/EGL14;->eglGetDisplay(I)Landroid/opengl/EGLDisplay;

    move-result-object v0

    iput-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    .line 68
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    if-eqz v0, :cond_c

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_4

    .line 69
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2, v1}, Landroid/opengl/EGL14;->eglInitialize(Landroid/opengl/EGLDisplay;[II[II)Z

    move-result v0

    if-nez v0, :cond_1

    return v1

    .line 70
    :cond_1
    const/4 v0, 0x1

    new-array v5, v0, [Landroid/opengl/EGLConfig;

    .line 71
    new-array v8, v0, [I

    .line 72
    const/16 v2, 0xd

    new-array v3, v2, [I

    fill-array-data v3, :array_0

    .line 81
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    const/4 v7, 0x1

    const/4 v9, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    invoke-static/range {v2 .. v9}, Landroid/opengl/EGL14;->eglChooseConfig(Landroid/opengl/EGLDisplay;[II[Landroid/opengl/EGLConfig;II[II)Z

    move-result v2

    if-eqz v2, :cond_b

    aget v2, v8, v1

    if-nez v2, :cond_2

    goto/16 :goto_3

    .line 84
    :cond_2
    aget-object v2, v5, v1

    iput-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->config:Landroid/opengl/EGLConfig;

    .line 85
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->config:Landroid/opengl/EGLConfig;

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    const/16 v5, 0x3038

    const/16 v6, 0x3098

    const/4 v7, 0x3

    filled-new-array {v6, v7, v5}, [I

    move-result-object v6

    invoke-static {v2, v3, v4, v6, v1}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v2

    iput-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    .line 87
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    if-eqz v2, :cond_a

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iget-object v3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    goto/16 :goto_2

    .line 88
    :cond_3
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->config:Landroid/opengl/EGLConfig;

    const/4 v4, 0x4

    const/16 v6, 0x3057

    const/16 v7, 0x3056

    filled-new-array {v6, v4, v7, v4, v5}, [I

    move-result-object v4

    invoke-static {v2, v3, v4, v1}, Landroid/opengl/EGL14;->eglCreatePbufferSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;[II)Landroid/opengl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    .line 90
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    if-eqz v2, :cond_9

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_1

    .line 91
    :cond_4
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    iget-object v4, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    iget-object v5, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    invoke-static {v2, v3, v4, v5}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move-result v2

    if-nez v2, :cond_5

    return v1

    .line 93
    :cond_5
    const/16 v2, 0x1f02

    invoke-static {v2}, Landroid/opengl/GLES31;->glGetString(I)Ljava/lang/String;

    move-result-object v2

    .line 94
    if-eqz v2, :cond_7

    const-string v3, "OpenGL ES 3.1"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_6

    const-string v3, "OpenGL ES 3.2"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_7

    :cond_6
    move v2, v0

    goto :goto_0

    :cond_7
    move v2, v1

    :goto_0
    iput-boolean v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->computeSupported:Z

    .line 95
    iget-boolean v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->computeSupported:Z

    if-eqz v2, :cond_8

    .line 96
    new-array v2, v0, [I

    .line 97
    const v3, 0x90eb

    invoke-static {v3, v2, v1}, Landroid/opengl/GLES31;->glGetIntegerv(I[II)V

    .line 98
    aget v3, v2, v1

    const/16 v4, 0x40

    if-lt v3, v4, :cond_8

    aget v2, v2, v1

    iput v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->maxInvocations:I

    .line 100
    :cond_8
    iget-object v2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v5, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v2, v3, v4, v5}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 101
    iput-boolean v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->valid:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 102
    return v0

    .line 90
    :cond_9
    :goto_1
    return v1

    .line 87
    :cond_a
    :goto_2
    return v1

    .line 82
    :cond_b
    :goto_3
    return v1

    .line 68
    :cond_c
    :goto_4
    return v1

    .line 103
    :catch_0
    move-exception v0

    .line 104
    invoke-virtual {p0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->destroy()V

    .line 105
    return v1

    nop

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
