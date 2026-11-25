.class public final Lcom/motorola/camera/custom/GpuComputeContext$Scope;
.super Ljava/lang/Object;
.source "GpuComputeContext.java"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/GpuComputeContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Scope"
.end annotation


# instance fields
.field public final active:Z

.field public final computeSupported:Z

.field private final display:Landroid/opengl/EGLDisplay;

.field public final maxWorkGroupInvocations:I

.field private final unbindOnClose:Z


# direct methods
.method constructor <init>(ZZIZLandroid/opengl/EGLDisplay;)V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-boolean p1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->active:Z

    .line 40
    iput-boolean p2, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->computeSupported:Z

    .line 41
    iput p3, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->maxWorkGroupInvocations:I

    .line 42
    iput-boolean p4, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->unbindOnClose:Z

    .line 43
    iput-object p5, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->display:Landroid/opengl/EGLDisplay;

    .line 44
    return-void
.end method


# virtual methods
.method public close()V
    .locals 4

    .line 48
    iget-boolean v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->unbindOnClose:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->display:Landroid/opengl/EGLDisplay;

    if-eqz v0, :cond_0

    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->display:Landroid/opengl/EGLDisplay;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 50
    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->display:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 51
    :catch_0
    move-exception v0

    :goto_0
    nop

    .line 53
    :cond_0
    return-void
.end method
