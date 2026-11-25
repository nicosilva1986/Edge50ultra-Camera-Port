.class public final Lcom/motorola/camera/custom/LiveLookPreview;
.super Ljava/lang/Object;
.source "LiveLookPreview.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;,
        Lcom/motorola/camera/custom/LiveLookPreview$GlState;
    }
.end annotation


# static fields
.field private static final GL:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Lcom/motorola/camera/custom/LiveLookPreview$GlState;",
            ">;"
        }
    .end annotation
.end field

.field private static final LOADER:Ljava/util/concurrent/Executor;

.field private static final UNIT:I = 0x7

.field private static volatile compare:Z

.field private static volatile intensity:I

.field private static volatile profilePaused:Z

.field private static volatile ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

.field private static volatile selected:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 15
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/LiveLookPreview;->LOADER:Ljava/util/concurrent/Executor;

    .line 16
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/LiveLookPreview;->GL:Ljava/lang/ThreadLocal;

    .line 18
    const/16 v0, 0x64

    sput v0, Lcom/motorola/camera/custom/LiveLookPreview;->intensity:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bind(Lcom/motorola/camera/ui/widgets/gl/Shader;)V
    .locals 23

    .line 60
    move-object/from16 v0, p0

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v1

    .line 61
    sget-object v2, Lcom/motorola/camera/custom/LiveLookPreview;->GL:Ljava/lang/ThreadLocal;

    invoke-virtual {v2}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;

    .line 62
    if-eqz v2, :cond_0

    iget-object v3, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->context:Landroid/opengl/EGLContext;

    invoke-virtual {v1, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 63
    :cond_0
    new-instance v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;

    invoke-direct {v2, v1}, Lcom/motorola/camera/custom/LiveLookPreview$GlState;-><init>(Landroid/opengl/EGLContext;)V

    .line 64
    sget-object v1, Lcom/motorola/camera/custom/LiveLookPreview;->GL:Ljava/lang/ThreadLocal;

    invoke-virtual {v1, v2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 66
    :cond_1
    iget v1, v0, Lcom/motorola/camera/ui/widgets/gl/Shader;->mProgramHandle:I

    .line 67
    iget-object v3, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->programs:Ljava/util/Map;

    invoke-interface {v3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 68
    const/4 v4, 0x4

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x5

    const/4 v8, 0x1

    const/4 v9, 0x0

    if-nez v3, :cond_2

    .line 69
    const/4 v3, 0x6

    new-array v3, v3, [I

    .line 70
    const-string v10, "u_EffectsLutTex"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v10

    aput v10, v3, v9

    .line 71
    const-string v10, "u_EffectsIntensity"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v10

    aput v10, v3, v8

    .line 72
    const-string v10, "u_EffectsVignette"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v10

    aput v10, v3, v6

    .line 73
    const-string v10, "u_EffectsHalation"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v10

    aput v10, v3, v5

    .line 74
    const-string v10, "u_EffectsGrain"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v10

    aput v10, v3, v4

    .line 75
    const-string v10, "u_EffectsShoulder"

    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    aput v1, v3, v7

    .line 77
    iget-object v1, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->programs:Ljava/util/Map;

    invoke-interface {v1, v0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 79
    :cond_2
    aget v0, v3, v9

    if-gez v0, :cond_3

    return-void

    .line 80
    :cond_3
    aget v0, v3, v9

    const/4 v1, 0x7

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glUniform1i(II)V

    .line 81
    sget-object v0, Lcom/motorola/camera/custom/LiveLookPreview;->ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    .line 82
    const/4 v10, 0x0

    if-eqz v0, :cond_e

    sget v11, Lcom/motorola/camera/custom/LiveLookPreview;->selected:I

    iget v12, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-ne v11, v12, :cond_e

    sget-boolean v11, Lcom/motorola/camera/custom/LiveLookPreview;->compare:Z

    if-nez v11, :cond_e

    sget-boolean v11, Lcom/motorola/camera/custom/LiveLookPreview;->profilePaused:Z

    if-nez v11, :cond_e

    sget v11, Lcom/motorola/camera/custom/LiveLookPreview;->intensity:I

    if-nez v11, :cond_4

    goto/16 :goto_2

    .line 87
    :cond_4
    const v11, 0x84e0

    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    invoke-static {v11, v12, v9}, Landroid/opengl/GLES20;->glGetIntegerv(I[II)V

    .line 88
    iget-object v11, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    aget v11, v11, v9

    .line 89
    const v12, 0x84c7

    invoke-static {v12}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 90
    iget v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->texture:I

    if-nez v12, :cond_5

    .line 91
    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    invoke-static {v8, v12, v9}, Landroid/opengl/GLES20;->glGenTextures(I[II)V

    .line 92
    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    aget v12, v12, v9

    iput v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->texture:I

    .line 94
    :cond_5
    iget v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->texture:I

    const/16 v13, 0xde1

    invoke-static {v13, v12}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 95
    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->uploaded:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    if-eq v12, v0, :cond_6

    .line 96
    const/16 v12, 0x2801

    const/16 v14, 0x2601

    invoke-static {v13, v12, v14}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 97
    const/16 v12, 0x2800

    invoke-static {v13, v12, v14}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 98
    const/16 v12, 0x2802

    const v14, 0x812f

    invoke-static {v13, v12, v14}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 99
    const/16 v12, 0x2803

    invoke-static {v13, v12, v14}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 100
    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    const/16 v13, 0xcf5

    invoke-static {v13, v12, v9}, Landroid/opengl/GLES20;->glGetIntegerv(I[II)V

    .line 101
    invoke-static {v13, v8}, Landroid/opengl/GLES20;->glPixelStorei(II)V

    .line 102
    iget-object v12, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->pixels:Ljava/nio/ByteBuffer;

    .line 103
    invoke-virtual {v12}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v22

    .line 102
    const/16 v14, 0xde1

    const/4 v15, 0x0

    const/16 v16, 0x1907

    const/16 v17, 0x21

    const/16 v18, 0x441

    const/16 v19, 0x0

    const/16 v20, 0x1907

    const/16 v21, 0x1401

    invoke-static/range {v14 .. v22}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 104
    iget-object v12, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    aget v9, v12, v9

    invoke-static {v13, v9}, Landroid/opengl/GLES20;->glPixelStorei(II)V

    .line 105
    iput-object v0, v2, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->uploaded:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    .line 107
    :cond_6
    invoke-static {v11}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 108
    aget v2, v3, v8

    sget v9, Lcom/motorola/camera/custom/LiveLookPreview;->intensity:I

    int-to-float v9, v9

    const/high16 v11, 0x42c80000    # 100.0f

    div-float/2addr v9, v11

    invoke-static {v2, v9}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 109
    aget v2, v3, v6

    iget v9, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-ne v9, v8, :cond_7

    const v6, 0x3e8a3d71    # 0.27f

    goto :goto_0

    :cond_7
    iget v8, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-ne v8, v6, :cond_8

    const v6, 0x3e051eb8    # 0.13f

    goto :goto_0

    :cond_8
    move v6, v10

    :goto_0
    invoke-static {v2, v6}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 110
    aget v2, v3, v5

    iget v6, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-ne v6, v1, :cond_9

    const v1, 0x3e23d70a    # 0.16f

    goto :goto_1

    :cond_9
    iget v1, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    const/16 v6, 0x8

    if-ne v1, v6, :cond_a

    const v1, -0x419eb852    # -0.22f

    goto :goto_1

    :cond_a
    move v1, v10

    :goto_1
    invoke-static {v2, v1}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 111
    aget v1, v3, v4

    iget v2, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-eq v2, v5, :cond_b

    iget v0, v0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    const/16 v2, 0x9

    if-lt v0, v2, :cond_c

    :cond_b
    const v10, 0x3c83126f    # 0.016f

    :cond_c
    invoke-static {v1, v10}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 112
    aget v0, v3, v7

    if-ltz v0, :cond_d

    aget v0, v3, v7

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 113
    :cond_d
    return-void

    .line 83
    :cond_e
    :goto_2
    aget v0, v3, v8

    invoke-static {v0, v10}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 84
    aget v0, v3, v7

    if-ltz v0, :cond_f

    aget v0, v3, v7

    invoke-static {v0, v10}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 85
    :cond_f
    return-void
.end method

.method static synthetic lambda$select$0(I)V
    .locals 2

    .line 39
    sget v0, Lcom/motorola/camera/custom/LiveLookPreview;->selected:I

    if-eq v0, p0, :cond_0

    return-void

    .line 41
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v0

    .line 42
    if-nez v0, :cond_1

    return-void

    .line 43
    :cond_1
    invoke-virtual {v0}, Lcom/motorola/camera/custom/LookFilterEngine;->texturePixels()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 44
    sget v1, Lcom/motorola/camera/custom/LiveLookPreview;->selected:I

    if-ne v1, p0, :cond_2

    new-instance v1, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    invoke-direct {v1, p0, v0}, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;-><init>(ILjava/nio/ByteBuffer;)V

    sput-object v1, Lcom/motorola/camera/custom/LiveLookPreview;->ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    :cond_2
    goto :goto_0

    .line 45
    :catch_0
    move-exception p0

    .line 48
    :goto_0
    return-void
.end method

.method public static select(II)V
    .locals 1

    .line 26
    sput p1, Lcom/motorola/camera/custom/LiveLookPreview;->intensity:I

    .line 27
    sget-object p1, Lcom/motorola/camera/custom/LiveLookPreview;->ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    .line 28
    sget v0, Lcom/motorola/camera/custom/LiveLookPreview;->selected:I

    if-ne v0, p0, :cond_1

    if-eqz p0, :cond_0

    if-eqz p1, :cond_1

    iget v0, p1, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-ne v0, p0, :cond_1

    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 29
    :goto_0
    if-eqz v0, :cond_2

    return-void

    .line 30
    :cond_2
    sput p0, Lcom/motorola/camera/custom/LiveLookPreview;->selected:I

    .line 31
    const/4 v0, 0x0

    if-eqz p1, :cond_3

    iget p1, p1, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    if-eq p1, p0, :cond_3

    .line 32
    sput-object v0, Lcom/motorola/camera/custom/LiveLookPreview;->ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    .line 34
    :cond_3
    if-nez p0, :cond_4

    .line 35
    sput-object v0, Lcom/motorola/camera/custom/LiveLookPreview;->ready:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;

    .line 36
    return-void

    .line 38
    :cond_4
    sget-object p1, Lcom/motorola/camera/custom/LiveLookPreview;->LOADER:Ljava/util/concurrent/Executor;

    new-instance v0, Lcom/motorola/camera/custom/LiveLookPreview$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/motorola/camera/custom/LiveLookPreview$$ExternalSyntheticLambda0;-><init>(I)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 49
    return-void
.end method

.method public static setCompare(Z)V
    .locals 0

    .line 52
    sput-boolean p0, Lcom/motorola/camera/custom/LiveLookPreview;->compare:Z

    .line 53
    return-void
.end method

.method public static setProfilePaused(Z)V
    .locals 0

    .line 56
    sput-boolean p0, Lcom/motorola/camera/custom/LiveLookPreview;->profilePaused:Z

    .line 57
    return-void
.end method
