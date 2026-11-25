.class public final Lcom/motorola/camera/custom/GpuComputeContext;
.super Ljava/lang/Object;
.source "GpuComputeContext.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/GpuComputeContext$Scope;,
        Lcom/motorola/camera/custom/GpuComputeContext$Holder;
    }
.end annotation


# static fields
.field public static final DEFAULT_WORKGROUP_1D:I = 0x40

.field public static final DEFAULT_WORKGROUP_2D_X:I = 0x8

.field public static final DEFAULT_WORKGROUP_2D_Y:I = 0x8

.field private static final EGL_OPENGL_ES3_BIT:I = 0x40

.field private static final GL_VERSION_ENUM:I = 0x1f02

.field private static final THREAD_HOLDER:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Lcom/motorola/camera/custom/GpuComputeContext$Holder;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 26
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static acquire()Lcom/motorola/camera/custom/GpuComputeContext$Scope;
    .locals 8

    .line 134
    :try_start_0
    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v0

    .line 135
    if-eqz v0, :cond_2

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 136
    const/16 v0, 0x1f02

    invoke-static {v0}, Landroid/opengl/GLES31;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    .line 137
    if-eqz v0, :cond_1

    const-string v1, "OpenGL ES 3.1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "OpenGL ES 3.2"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    move v3, v0

    .line 138
    new-instance v1, Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x1

    const/16 v4, 0x80

    invoke-direct/range {v1 .. v6}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;-><init>(ZZIZLandroid/opengl/EGLDisplay;)V

    return-object v1

    .line 140
    :cond_2
    sget-object v0, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;

    .line 141
    if-eqz v0, :cond_3

    iget-boolean v1, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->valid:Z

    if-nez v1, :cond_6

    .line 142
    :cond_3
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->destroy()V

    .line 143
    :cond_4
    new-instance v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;-><init>(Lcom/motorola/camera/custom/GpuComputeContext-IA;)V

    .line 144
    invoke-virtual {v0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->init()Z

    move-result v1

    if-nez v1, :cond_5

    .line 145
    new-instance v2, Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-direct/range {v2 .. v7}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;-><init>(ZZIZLandroid/opengl/EGLDisplay;)V

    return-object v2

    .line 147
    :cond_5
    sget-object v1, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    invoke-virtual {v1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 149
    :cond_6
    iget-object v1, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    iget-object v2, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    iget-object v3, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->pbuffer:Landroid/opengl/EGLSurface;

    iget-object v4, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->context:Landroid/opengl/EGLContext;

    invoke-static {v1, v2, v3, v4}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move-result v1

    if-nez v1, :cond_7

    .line 150
    invoke-virtual {v0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->destroy()V

    .line 151
    sget-object v0, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 152
    new-instance v1, Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;-><init>(ZZIZLandroid/opengl/EGLDisplay;)V

    return-object v1

    .line 154
    :cond_7
    new-instance v1, Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    iget-boolean v3, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->computeSupported:Z

    iget v4, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->maxInvocations:I

    iget-object v6, v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->display:Landroid/opengl/EGLDisplay;

    const/4 v2, 0x1

    const/4 v5, 0x1

    invoke-direct/range {v1 .. v6}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;-><init>(ZZIZLandroid/opengl/EGLDisplay;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 155
    :catch_0
    move-exception v0

    .line 156
    new-instance v1, Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;-><init>(ZZIZLandroid/opengl/EGLDisplay;)V

    return-object v1
.end method

.method public static isDriverSafeComputeSource(Ljava/lang/String;III)Z
    .locals 3

    .line 162
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    const-string v1, "#version "

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    .line 163
    :cond_0
    if-lez p1, :cond_3

    if-lez p2, :cond_3

    if-gtz p3, :cond_1

    goto :goto_0

    .line 164
    :cond_1
    int-to-long v1, p1

    int-to-long p1, p2

    mul-long/2addr v1, p1

    int-to-long p1, p3

    mul-long/2addr v1, p1

    .line 165
    const-wide/16 p1, 0x80

    cmp-long p1, v1, p1

    if-lez p1, :cond_2

    return v0

    .line 166
    :cond_2
    const-string p1, "precision highp int;"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    return p0

    .line 163
    :cond_3
    :goto_0
    return v0

    .line 162
    :cond_4
    :goto_1
    return v0
.end method

.method public static releaseCurrentThread()V
    .locals 1

    .line 170
    sget-object v0, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/motorola/camera/custom/GpuComputeContext$Holder;

    .line 171
    if-eqz v0, :cond_0

    .line 172
    invoke-virtual {v0}, Lcom/motorola/camera/custom/GpuComputeContext$Holder;->destroy()V

    .line 173
    sget-object v0, Lcom/motorola/camera/custom/GpuComputeContext;->THREAD_HOLDER:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->remove()V

    .line 175
    :cond_0
    return-void
.end method
