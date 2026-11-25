.class final Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "GuideCompute"
.end annotation


# static fields
.field private static final CELLS:I = 0x2000

.field private static final SOURCE:Ljava/lang/String; = "#version 310 es\nprecision highp float;\nprecision highp int;\nlayout(local_size_x=64) in;\nlayout(std430,binding=0) readonly buffer Input { uvec2 pair[]; };\nlayout(std430,binding=1) writeonly buffer Output { float dst[]; };\nuniform vec4 black, invRange; uniform int count;\nvoid main(){ uint i=gl_GlobalInvocationID.x; if(i>=uint(count)) return;uvec2 s=pair[i]; vec4 dn=vec4(s.x&65535u,s.x>>16,s.y&65535u,s.y>>16);dst[i]=dot((dn-black)*invRange,vec4(0.25)); }"

.field private static final SSBO:I = 0x90d2

.field private static final STREAM_DRAW:I = 0x88e0

.field private static final STREAM_READ:I = 0x88e1


# instance fields
.field available:Z

.field black:I

.field final buffers:[I

.field count:I

.field inverse:I

.field program:I

.field shader:I

.field final staging:Ljava/nio/ByteBuffer;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 563
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 574
    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    .line 575
    const/high16 v0, 0x10000

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    return-void
.end method

.method static open()Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;
    .locals 3

    .line 580
    nop

    .line 582
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v1

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 584
    :cond_0
    new-instance v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;

    invoke-direct {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;-><init>()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_1

    .line 585
    :try_start_1
    invoke-virtual {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->init()Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_0

    if-eqz v2, :cond_1

    return-object v1

    .line 588
    :cond_1
    goto :goto_1

    .line 586
    :catch_0
    move-exception v2

    goto :goto_1

    .line 583
    :cond_2
    :goto_0
    return-object v0

    .line 586
    :catch_1
    move-exception v1

    move-object v1, v0

    .line 589
    :goto_1
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->close()V

    .line 590
    :cond_3
    return-object v0
.end method


# virtual methods
.method public close()V
    .locals 3

    .line 659
    :try_start_0
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-static {v1}, Landroid/opengl/GLES31;->glUseProgram(I)V

    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    invoke-static {v0}, Landroid/opengl/GLES31;->glDeleteProgram(I)V

    .line 660
    :cond_0
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    invoke-static {v0}, Landroid/opengl/GLES31;->glDeleteShader(I)V

    .line 661
    :cond_1
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v0, v0, v1

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    const/4 v2, 0x1

    aget v0, v0, v2

    if-eqz v0, :cond_3

    :cond_2
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    const/4 v2, 0x2

    invoke-static {v2, v0, v1}, Landroid/opengl/GLES31;->glDeleteBuffers(I[II)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 662
    :catch_0
    move-exception v0

    :cond_3
    :goto_0
    nop

    .line 663
    return-void
.end method

.method fill(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;[F)Z
    .locals 11

    .line 620
    iget-boolean v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->available:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 621
    :cond_0
    iput-boolean v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->available:Z

    .line 623
    :try_start_0
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->black:I

    iget-object v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    const/4 v3, 0x1

    invoke-static {v0, v3, v2, v1}, Landroid/opengl/GLES31;->glUniform4fv(II[FI)V

    .line 624
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->inverse:I

    iget-object v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    invoke-static {v0, v3, v2, v1}, Landroid/opengl/GLES31;->glUniform4fv(II[FI)V

    .line 625
    move v0, v1

    :goto_0
    array-length v2, p2

    if-ge v0, v2, :cond_6

    .line 626
    array-length v2, p2

    sub-int/2addr v2, v0

    const/16 v4, 0x2000

    invoke-static {v4, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 627
    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 628
    move v4, v0

    :goto_1
    add-int v5, v0, v2

    if-ge v4, v5, :cond_1

    .line 629
    iget v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/lit8 v5, v5, 0x2

    div-int v5, v4, v5

    mul-int/lit8 v5, v5, 0x2

    iget v6, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    mul-int/2addr v5, v6

    iget v6, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/lit8 v6, v6, 0x2

    rem-int v6, v4, v6

    mul-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    .line 630
    iget-object v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    iget-object v7, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    aget-short v7, v7, v5

    const v8, 0xffff

    and-int/2addr v7, v8

    iget-object v9, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    add-int/lit8 v10, v5, 0x1

    aget-short v9, v9, v10

    shl-int/lit8 v9, v9, 0x10

    or-int/2addr v7, v9

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 631
    iget-object v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    iget-object v7, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    iget v9, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/2addr v9, v5

    aget-short v7, v7, v9

    and-int/2addr v7, v8

    iget-object v8, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    iget v9, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/2addr v5, v9

    add-int/2addr v5, v3

    aget-short v5, v8, v5

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v5, v7

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 628
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 633
    :cond_1
    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 634
    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v4, v4, v1

    const v5, 0x90d2

    invoke-static {v5, v4}, Landroid/opengl/GLES31;->glBindBuffer(II)V

    .line 635
    mul-int/lit8 v4, v2, 0x8

    iget-object v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->staging:Ljava/nio/ByteBuffer;

    const v7, 0x88e0

    invoke-static {v5, v4, v6, v7}, Landroid/opengl/GLES31;->glBufferData(IILjava/nio/Buffer;I)V

    .line 636
    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v4, v4, v1

    invoke-static {v5, v1, v4}, Landroid/opengl/GLES31;->glBindBufferBase(III)V

    .line 637
    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v4, v4, v3

    invoke-static {v5, v4}, Landroid/opengl/GLES31;->glBindBuffer(II)V

    .line 638
    mul-int/lit8 v4, v2, 0x4

    const/4 v6, 0x0

    const v7, 0x88e1

    invoke-static {v5, v4, v6, v7}, Landroid/opengl/GLES31;->glBufferData(IILjava/nio/Buffer;I)V

    .line 639
    iget-object v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v6, v6, v3

    invoke-static {v5, v3, v6}, Landroid/opengl/GLES31;->glBindBufferBase(III)V

    .line 640
    iget v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->count:I

    invoke-static {v6, v2}, Landroid/opengl/GLES31;->glUniform1i(II)V

    .line 641
    add-int/lit8 v6, v2, 0x3f

    div-int/lit8 v6, v6, 0x40

    invoke-static {v6, v3, v3}, Landroid/opengl/GLES31;->glDispatchCompute(III)V

    .line 642
    const/16 v6, 0x200

    invoke-static {v6}, Landroid/opengl/GLES31;->glMemoryBarrier(I)V

    .line 643
    invoke-static {}, Landroid/opengl/GLES31;->glGetError()I

    move-result v6

    if-eqz v6, :cond_2

    return v1

    .line 644
    :cond_2
    invoke-static {v5, v1, v4, v3}, Landroid/opengl/GLES31;->glMapBufferRange(IIII)Ljava/nio/Buffer;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 645
    if-nez v4, :cond_3

    return v1

    .line 648
    :cond_3
    :try_start_1
    check-cast v4, Ljava/nio/ByteBuffer;

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v4

    invoke-virtual {v4, p2, v0, v2}, Ljava/nio/FloatBuffer;->get([FII)Ljava/nio/FloatBuffer;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 649
    :try_start_2
    invoke-static {v5}, Landroid/opengl/GLES31;->glUnmapBuffer(I)Z

    move-result v2

    .line 650
    if-eqz v2, :cond_5

    invoke-static {}, Landroid/opengl/GLES31;->glGetError()I

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_2

    .line 625
    :cond_4
    add-int/lit16 v0, v0, 0x2000

    goto/16 :goto_0

    .line 650
    :cond_5
    :goto_2
    return v1

    .line 649
    :catchall_0
    move-exception p1

    invoke-static {v5}, Landroid/opengl/GLES31;->glUnmapBuffer(I)Z

    throw p1

    .line 652
    :cond_6
    iput-boolean v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->available:Z
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_2 .. :try_end_2} :catch_0

    .line 653
    return v3

    .line 654
    :catch_0
    move-exception p1

    return v1
.end method

.method init()Z
    .locals 5

    .line 594
    const/16 v0, 0x1f02

    invoke-static {v0}, Landroid/opengl/GLES31;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    .line 595
    const/4 v1, 0x0

    if-eqz v0, :cond_5

    const-string v2, "OpenGL ES 3.1"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "OpenGL ES 3.2"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_1

    .line 597
    :cond_0
    const v0, 0x91b9

    invoke-static {v0}, Landroid/opengl/GLES31;->glCreateShader(I)I

    move-result v0

    iput v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    .line 598
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    if-nez v0, :cond_1

    return v1

    .line 599
    :cond_1
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    const-string v2, "#version 310 es\nprecision highp float;\nprecision highp int;\nlayout(local_size_x=64) in;\nlayout(std430,binding=0) readonly buffer Input { uvec2 pair[]; };\nlayout(std430,binding=1) writeonly buffer Output { float dst[]; };\nuniform vec4 black, invRange; uniform int count;\nvoid main(){ uint i=gl_GlobalInvocationID.x; if(i>=uint(count)) return;uvec2 s=pair[i]; vec4 dn=vec4(s.x&65535u,s.x>>16,s.y&65535u,s.y>>16);dst[i]=dot((dn-black)*invRange,vec4(0.25)); }"

    invoke-static {v0, v2}, Landroid/opengl/GLES31;->glShaderSource(ILjava/lang/String;)V

    .line 600
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    invoke-static {v0}, Landroid/opengl/GLES31;->glCompileShader(I)V

    .line 601
    const/4 v0, 0x1

    new-array v2, v0, [I

    .line 602
    iget v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    const v4, 0x8b81

    invoke-static {v3, v4, v2, v1}, Landroid/opengl/GLES31;->glGetShaderiv(II[II)V

    .line 603
    aget v3, v2, v1

    if-nez v3, :cond_2

    return v1

    .line 604
    :cond_2
    invoke-static {}, Landroid/opengl/GLES31;->glCreateProgram()I

    move-result v3

    iput v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    .line 605
    iget v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    iget v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->shader:I

    invoke-static {v3, v4}, Landroid/opengl/GLES31;->glAttachShader(II)V

    .line 606
    iget v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    invoke-static {v3}, Landroid/opengl/GLES31;->glLinkProgram(I)V

    .line 607
    iget v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    const v4, 0x8b82

    invoke-static {v3, v4, v2, v1}, Landroid/opengl/GLES31;->glGetProgramiv(II[II)V

    .line 608
    aget v2, v2, v1

    if-nez v2, :cond_3

    return v1

    .line 609
    :cond_3
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    const-string v3, "black"

    invoke-static {v2, v3}, Landroid/opengl/GLES31;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->black:I

    .line 610
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    const-string v3, "invRange"

    invoke-static {v2, v3}, Landroid/opengl/GLES31;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->inverse:I

    .line 611
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    const-string v3, "count"

    invoke-static {v2, v3}, Landroid/opengl/GLES31;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->count:I

    .line 612
    const/4 v2, 0x2

    iget-object v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    invoke-static {v2, v3, v1}, Landroid/opengl/GLES31;->glGenBuffers(I[II)V

    .line 613
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->program:I

    invoke-static {v2}, Landroid/opengl/GLES31;->glUseProgram(I)V

    .line 614
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->black:I

    if-ltz v2, :cond_4

    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->inverse:I

    if-ltz v2, :cond_4

    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->count:I

    if-ltz v2, :cond_4

    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v2, v2, v1

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->buffers:[I

    aget v2, v2, v0

    if-eqz v2, :cond_4

    .line 615
    invoke-static {}, Landroid/opengl/GLES31;->glGetError()I

    move-result v2

    if-nez v2, :cond_4

    move v1, v0

    goto :goto_0

    :cond_4
    nop

    :goto_0
    iput-boolean v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->available:Z

    .line 616
    iget-boolean v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->available:Z

    return v0

    .line 596
    :cond_5
    :goto_1
    return v1
.end method
