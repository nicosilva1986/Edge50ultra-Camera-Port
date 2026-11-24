.class public final Lcom/motorola/camera/custom/MultiFrameBurstController;
.super Ljava/lang/Object;
.source "MultiFrameBurstController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;,
        Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;,
        Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
    }
.end annotation


# static fields
.field public static final ANCHOR_MAX_MOTION_PX:F = 0.75f

.field public static final BYTE_CAP_SR:J = 0x1a400000L

.field public static final BYTE_CAP_STANDARD:J = 0x14000000L

.field public static final MAX_FRAMES_SR:I = 0x8

.field public static final MAX_FRAMES_STANDARD:I = 0x6

.field public static final MODE_AEB:I = 0x2

.field public static final MODE_FOCUS_STACK:I = 0x4

.field public static final MODE_HDR_PLUS:I = 0x1

.field public static final MODE_SUPER_RES:I = 0x3

.field public static final MODE_SYNTHETIC_ND:I = 0x5

.field public static final OV50H_BINNED_HEIGHT:I = 0xbfc

.field public static final OV50H_BINNED_WIDTH:I = 0xff8

.field private static abortReason:Ljava/lang/String;

.field private static aborted:Z

.field private static byteCap:J

.field private static count:I

.field private static maxFrames:I

.field private static final pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

.field private static pendingCount:I

.field private static plannedFrames:I

.field private static retained:J

.field private static singleFrame:Z

.field private static final slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 65
    const/16 v0, 0x8

    new-array v1, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sput-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    .line 66
    new-array v0, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sput-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    .line 70
    const/4 v0, 0x6

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 71
    const-wide/32 v0, 0x14000000

    sput-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    .line 75
    const/4 v0, -0x1

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized abort(Ljava/lang/String;)V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 135
    const/4 v1, 0x1

    :try_start_0
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    .line 136
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 137
    :cond_0
    sput-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    goto :goto_1

    .line 136
    :cond_1
    :goto_0
    const-string p0, "aborted"

    sput-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    .line 138
    :goto_1
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-lez p0, :cond_2

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V

    goto :goto_1

    .line 139
    :cond_2
    const/4 p0, 0x0

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 140
    nop

    :goto_2
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v1, v1

    if-ge p0, v1, :cond_3

    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    const/4 v2, 0x0

    aput-object v2, v1, p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 p0, p0, 0x1

    goto :goto_2

    .line 141
    :cond_3
    monitor-exit v0

    return-void

    .line 134
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private static baseCount(IFZ)I
    .locals 5

    .line 298
    const/4 v0, 0x1

    const/4 v1, 0x5

    const/4 v2, 0x6

    const/4 v3, 0x4

    if-ne p0, v0, :cond_3

    .line 299
    const/high16 p0, 0x43960000    # 300.0f

    cmpl-float p0, p1, p0

    if-ltz p0, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    const/high16 p0, 0x43160000    # 150.0f

    cmpl-float p0, p1, p0

    if-ltz p0, :cond_1

    goto :goto_0

    :cond_1
    move v1, v3

    .line 300
    :goto_0
    if-eqz p2, :cond_2

    if-le v1, v3, :cond_2

    goto :goto_1

    .line 301
    :cond_2
    move v3, v1

    :goto_1
    return v3

    .line 303
    :cond_3
    const/4 v0, 0x2

    const/4 v4, 0x3

    if-ne p0, v0, :cond_4

    return v4

    .line 304
    :cond_4
    if-ne p0, v4, :cond_6

    if-nez p2, :cond_5

    const/high16 p0, 0x43480000    # 200.0f

    cmpl-float p0, p1, p0

    if-ltz p0, :cond_5

    const/16 v2, 0x8

    :cond_5
    return v2

    .line 305
    :cond_6
    if-ne p0, v3, :cond_7

    return v1

    .line 306
    :cond_7
    if-ne p0, v1, :cond_8

    return v2

    .line 307
    :cond_8
    const/4 p0, -0x1

    return p0
.end method

.method public static boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 1

    .line 86
    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)I

    move-result p0

    return p0
.end method

.method public static boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)I
    .locals 1

    .line 91
    const/4 v0, 0x1

    if-ge p3, v0, :cond_0

    move p3, v0

    .line 92
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    .line 93
    invoke-static {p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    .line 94
    return p3

    .line 96
    :cond_1
    const/4 p0, 0x6

    if-le p3, p0, :cond_2

    return p0

    .line 97
    :cond_2
    return p3
.end method

.method public static declared-synchronized configure(I)V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 124
    const/4 v1, 0x3

    if-ne p0, v1, :cond_0

    .line 125
    const/16 p0, 0x8

    :try_start_0
    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 126
    const-wide/32 v1, 0x1a400000

    sput-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    goto :goto_0

    .line 128
    :cond_0
    const/4 p0, 0x6

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 129
    const-wide/32 v1, 0x14000000

    sput-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    .line 131
    :goto_0
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-le p0, v1, :cond_1

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 132
    :cond_1
    monitor-exit v0

    return-void

    .line 123
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method public static estimateRawBytes(Z)I
    .locals 4

    .line 102
    nop

    .line 103
    if-eqz p0, :cond_0

    const-wide/32 v0, 0x17ec040

    goto :goto_0

    :cond_0
    const-wide/32 v0, 0xef3828

    .line 104
    :goto_0
    const-wide/32 v2, 0x7fffffff

    cmp-long p0, v0, v2

    if-lez p0, :cond_1

    const p0, 0x7fffffff

    return p0

    .line 105
    :cond_1
    long-to-int p0, v0

    return p0
.end method

.method private static evictOldest()V
    .locals 1

    .line 434
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-nez v0, :cond_0

    return-void

    .line 435
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->removeAt(I)V

    .line 436
    return-void
.end method

.method private static exposureOffsets(IIF)[F
    .locals 6

    .line 322
    new-array v0, p1, [F

    .line 323
    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x2

    if-ne p0, v4, :cond_0

    const/4 v5, 0x3

    if-ne p1, v5, :cond_0

    .line 324
    const/high16 p0, -0x40000000    # -2.0f

    aput p0, v0, v2

    .line 325
    aput v1, v0, v3

    .line 326
    const/high16 p0, 0x40000000    # 2.0f

    aput p0, v0, v4

    .line 327
    return-object v0

    .line 329
    :cond_0
    if-ne p0, v3, :cond_1

    if-le p1, v3, :cond_1

    cmpl-float p0, p2, v1

    if-lez p0, :cond_1

    .line 330
    add-int/lit8 p0, p1, -0x1

    int-to-float p0, p0

    .line 331
    nop

    :goto_0
    if-ge v2, p1, :cond_1

    .line 332
    int-to-float v1, v2

    div-float/2addr v1, p0

    const/high16 v3, 0x3f000000    # 0.5f

    sub-float/2addr v1, v3

    mul-float/2addr v1, p2

    aput v1, v0, v2

    .line 331
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 335
    :cond_1
    return-object v0
.end method

.method private static fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;JJIFFJZZ)V
    .locals 0

    .line 390
    iput-wide p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    .line 391
    iput-wide p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    .line 392
    iput p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    .line 393
    iput p6, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    .line 394
    iput p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    .line 395
    iput-wide p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    .line 396
    iput-boolean p10, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    .line 397
    iput-boolean p11, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    .line 398
    return-void
.end method

.method private static findSeq(J)I
    .locals 3

    .line 420
    const/4 v0, 0x0

    :goto_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v0, v1, :cond_1

    .line 421
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v1, v1, v0

    iget-wide v1, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v1, v1, p0

    if-nez v1, :cond_0

    return v0

    .line 420
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 423
    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method private static finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
    .locals 12

    .line 292
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p6, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    sput-boolean v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z

    .line 293
    sput p1, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    .line 294
    new-instance v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    if-eqz p6, :cond_1

    move v11, v0

    goto :goto_1

    :cond_1
    move v11, v1

    :goto_1
    move v4, p0

    move v5, p1

    move-object v6, p2

    move-object v7, p3

    move-wide/from16 v8, p4

    move-object/from16 v10, p6

    invoke-direct/range {v3 .. v11}, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;-><init>(II[F[FJLjava/lang/String;Z)V

    return-object v3
.end method

.method private static focusFor(IIZ)[F
    .locals 8

    .line 339
    const/4 v0, 0x0

    const/4 v1, 0x4

    if-ne p0, v1, :cond_7

    if-gtz p1, :cond_0

    goto :goto_3

    .line 340
    :cond_0
    const/high16 p0, 0x41000000    # 8.0f

    const/high16 v2, 0x40800000    # 4.0f

    const/4 v3, 0x3

    const/high16 v4, 0x40000000    # 2.0f

    const/4 v5, 0x5

    const/4 v6, 0x2

    const/4 v7, 0x1

    if-eqz p2, :cond_1

    .line 341
    new-array p2, v5, [F

    aput v4, p2, v0

    aput v2, p2, v7

    const/high16 v2, 0x40c00000    # 6.0f

    aput v2, p2, v6

    aput p0, p2, v3

    const/high16 p0, 0x41200000    # 10.0f

    aput p0, p2, v1

    goto :goto_0

    .line 342
    :cond_1
    new-array p2, v5, [F

    const/high16 v5, 0x3f000000    # 0.5f

    aput v5, p2, v0

    const/high16 v5, 0x3f800000    # 1.0f

    aput v5, p2, v7

    aput v4, p2, v6

    aput v2, p2, v3

    aput p0, p2, v1

    .line 343
    :goto_0
    array-length p0, p2

    if-ne p1, p0, :cond_3

    .line 344
    array-length p0, p2

    new-array p0, p0, [F

    .line 345
    nop

    :goto_1
    array-length p1, p2

    if-ge v0, p1, :cond_2

    aget p1, p2, v0

    aput p1, p0, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 346
    :cond_2
    return-object p0

    .line 348
    :cond_3
    new-array p0, p1, [F

    .line 349
    if-ne p1, v7, :cond_4

    .line 350
    aget p1, p2, v0

    aput p1, p0, v0

    .line 351
    return-object p0

    .line 353
    :cond_4
    array-length v1, p2

    sub-int/2addr v1, v7

    .line 354
    add-int/lit8 v2, p1, -0x1

    .line 355
    nop

    :goto_2
    if-ge v0, p1, :cond_6

    .line 356
    mul-int v3, v0, v1

    div-int/lit8 v4, v2, 0x2

    add-int/2addr v3, v4

    div-int/2addr v3, v2

    .line 357
    if-le v3, v1, :cond_5

    move v3, v1

    .line 358
    :cond_5
    aget v3, p2, v3

    aput v3, p0, v0

    .line 355
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 360
    :cond_6
    return-object p0

    .line 339
    :cond_7
    :goto_3
    new-array p0, v0, [F

    return-object p0
.end method

.method private static isBoundedZslCamera(Ljava/lang/String;)Z
    .locals 1

    .line 439
    const-string v0, "0"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "3"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method public static declared-synchronized noteMetadata(JJIFFJZZ)V
    .locals 15

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 176
    const/4 v0, 0x0

    :goto_0
    :try_start_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v0, v2, :cond_3

    .line 177
    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v2, v0

    .line 178
    iget-wide v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v2, v4, p0

    if-eqz v2, :cond_1

    iget-wide v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v2, v4, p7

    if-nez v2, :cond_0

    goto :goto_1

    .line 176
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 179
    :cond_1
    :goto_1
    const/4 v0, 0x0

    cmpg-float v0, p6, v0

    if-gez v0, :cond_2

    iget v0, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    move v10, v0

    goto :goto_2

    :cond_2
    move/from16 v10, p6

    .line 180
    :goto_2
    move-wide v4, p0

    move-wide/from16 v6, p2

    move/from16 v8, p4

    move/from16 v9, p5

    move-wide/from16 v11, p7

    move/from16 v13, p9

    move/from16 v14, p10

    invoke-static/range {v3 .. v14}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;JJIFFJZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 182
    monitor-exit v1

    return-void

    .line 185
    :cond_3
    :try_start_1
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v2, v2

    const/4 v3, 0x0

    const/4 v14, 0x1

    if-ne v0, v2, :cond_5

    .line 186
    move v0, v14

    :goto_3
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v0, v2, :cond_4

    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    add-int/lit8 v4, v0, -0x1

    sget-object v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v5, v5, v0

    aput-object v5, v2, v4

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 187
    :cond_4
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    sub-int/2addr v0, v14

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 188
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    aput-object v3, v0, v2

    .line 190
    :cond_5
    new-instance v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    invoke-direct {v2, v3}, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;-><init>(Lcom/motorola/camera/custom/MultiFrameBurstController-IA;)V

    .line 191
    move-wide v3, p0

    move-wide/from16 v5, p2

    move/from16 v7, p4

    move/from16 v8, p5

    move/from16 v9, p6

    move-wide/from16 v10, p7

    move/from16 v12, p9

    move/from16 v13, p10

    invoke-static/range {v2 .. v13}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;JJIFFJZZ)V

    .line 193
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    aput-object v2, v0, v3

    .line 194
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    add-int/2addr v0, v14

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 195
    monitor-exit v1

    return-void

    .line 175
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public static declared-synchronized offer(JJIFFJ[BZZ)Z
    .locals 18

    move-object/from16 v0, p9

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 152
    :try_start_0
    sget-boolean v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    const/4 v3, 0x0

    if-nez v2, :cond_7

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 153
    :cond_0
    array-length v2, v0

    int-to-long v4, v2

    .line 154
    sget-wide v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    cmp-long v2, v4, v6

    if-lez v2, :cond_1

    monitor-exit v1

    return v3

    .line 155
    :cond_1
    :try_start_1
    invoke-static/range {p7 .. p8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->findSeq(J)I

    move-result v2

    .line 156
    if-ltz v2, :cond_2

    invoke-static {v2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->removeAt(I)V

    .line 157
    :cond_2
    :goto_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-lez v2, :cond_4

    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-ge v2, v6, :cond_3

    sget-wide v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v6, v4

    sget-wide v8, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    cmp-long v2, v6, v8

    if-lez v2, :cond_4

    .line 158
    :cond_3
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V

    goto :goto_0

    .line 160
    :cond_4
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-ge v2, v6, :cond_6

    sget-wide v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v6, v4

    sget-wide v8, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    cmp-long v2, v6, v8

    if-lez v2, :cond_5

    goto :goto_1

    .line 161
    :cond_5
    new-instance v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    const/4 v2, 0x0

    invoke-direct {v6, v2}, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;-><init>(Lcom/motorola/camera/custom/MultiFrameBurstController-IA;)V

    .line 162
    move-wide/from16 v7, p0

    move-wide/from16 v9, p2

    move/from16 v11, p4

    move/from16 v12, p5

    move/from16 v13, p6

    move-wide/from16 v14, p7

    move/from16 v16, p10

    move/from16 v17, p11

    invoke-static/range {v6 .. v17}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;JJIFFJZZ)V

    .line 164
    iput-object v0, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 165
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    aput-object v6, v0, v2

    .line 166
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v2, 0x1

    add-int/2addr v0, v2

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 167
    sget-wide v7, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v7, v4

    sput-wide v7, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 168
    invoke-static {v6}, Lcom/motorola/camera/custom/MultiFrameBurstController;->overlayPending(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 169
    monitor-exit v1

    return v2

    .line 160
    :cond_6
    :goto_1
    monitor-exit v1

    return v3

    .line 152
    :cond_7
    :goto_2
    monitor-exit v1

    return v3

    .line 151
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public static declared-synchronized oldestSeqId()J
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 242
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    monitor-exit v0

    const-wide/16 v0, -0x1

    return-wide v0

    .line 243
    :cond_0
    :try_start_1
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    iget-wide v1, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v0

    return-wide v1

    .line 241
    :catchall_0
    move-exception v1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method private static overlayPending(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V
    .locals 17

    .line 401
    move-object/from16 v0, p0

    const/4 v1, 0x0

    move v12, v1

    :goto_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v12, v2, :cond_6

    .line 402
    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v2, v2, v12

    .line 403
    iget-wide v3, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    iget-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v3, v3, v5

    const/4 v13, 0x1

    if-eqz v3, :cond_1

    iget-wide v3, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    iget-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v3, v3, v5

    if-nez v3, :cond_0

    goto :goto_1

    :cond_0
    move v3, v1

    goto :goto_2

    :cond_1
    :goto_1
    move v3, v13

    .line 404
    :goto_2
    if-nez v3, :cond_2

    .line 401
    add-int/lit8 v12, v12, 0x1

    goto :goto_0

    .line 405
    :cond_2
    iget-boolean v1, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-nez v1, :cond_4

    iget-boolean v1, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-eqz v1, :cond_4

    .line 406
    iget-object v14, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 407
    iget v1, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    const/4 v3, 0x0

    cmpg-float v1, v1, v3

    if-gez v1, :cond_3

    iget v1, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    goto :goto_3

    :cond_3
    iget v1, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    :goto_3
    move v7, v1

    .line 408
    iget-wide v3, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    move-wide v5, v3

    iget-wide v3, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    move-wide v8, v5

    iget v5, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    iget v6, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    move-wide v10, v8

    iget-wide v8, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    iget-boolean v1, v2, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    move-wide v15, v10

    move v10, v1

    move-wide v1, v15

    const/4 v11, 0x1

    invoke-static/range {v0 .. v11}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;JJIFFJZZ)V

    .line 410
    iput-object v14, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 412
    :cond_4
    add-int/2addr v12, v13

    :goto_4
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v12, v0, :cond_5

    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    add-int/lit8 v1, v12, -0x1

    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v2, v2, v12

    aput-object v2, v0, v1

    add-int/lit8 v12, v12, 0x1

    goto :goto_4

    .line 413
    :cond_5
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    sub-int/2addr v0, v13

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 414
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    .line 415
    return-void

    .line 417
    :cond_6
    return-void
.end method

.method public static declared-synchronized planBurst(IFFIZZ)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
    .locals 9

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 265
    :try_start_0
    invoke-static {p0, p1, p4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->baseCount(IFZ)I

    move-result p1

    .line 266
    const/4 p4, 0x0

    const/4 v0, 0x1

    if-gez p1, :cond_0

    .line 267
    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->zeros(I)[F

    move-result-object v4

    new-array v5, p4, [F

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->selectAnchor()J

    move-result-wide v6

    const-string v8, "mode"

    const/4 v3, 0x1

    move v2, p0

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object p0

    .line 269
    :cond_0
    move v2, p0

    :try_start_1
    invoke-static {v2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->configure(I)V

    .line 270
    const/4 p0, 0x4

    if-lt p3, p0, :cond_1

    .line 271
    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->zeros(I)[F

    move-result-object v4

    new-array v5, p4, [F

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->selectAnchor()J

    move-result-wide v6

    const-string v8, "thermal-cutoff"

    const/4 v3, 0x1

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v1

    return-object p0

    .line 273
    :cond_1
    :try_start_2
    sget-boolean p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    if-eqz p0, :cond_3

    .line 274
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    if-nez p0, :cond_2

    const-string p0, "aborted"

    goto :goto_0

    :cond_2
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    :goto_0
    move-object v8, p0

    .line 275
    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->zeros(I)[F

    move-result-object v4

    new-array v5, p4, [F

    const-wide/16 v6, -0x1

    const/4 v3, 0x1

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit v1

    return-object p0

    .line 277
    :cond_3
    :try_start_3
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-nez p0, :cond_4

    .line 278
    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->zeros(I)[F

    move-result-object v4

    new-array v5, p4, [F

    const-string v8, "empty"

    const/4 v3, 0x1

    const-wide/16 v6, -0x1

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit v1

    return-object p0

    .line 280
    :cond_4
    :try_start_4
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->selectAnchor()J

    move-result-wide v6

    .line 281
    const-wide/16 v3, 0x0

    cmp-long p0, v6, v3

    if-gez p0, :cond_5

    .line 282
    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->zeros(I)[F

    move-result-object v4

    new-array v5, p4, [F

    const-string v8, "no-anchor"

    const/4 v3, 0x1

    const-wide/16 v6, -0x1

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    monitor-exit v1

    return-object p0

    .line 284
    :cond_5
    const/4 p0, 0x2

    if-lt p3, p0, :cond_6

    :try_start_5
    invoke-static {v2, p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->stepped(II)I

    move-result p1

    :cond_6
    move v3, p1

    .line 285
    invoke-static {v2, v3, p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->exposureOffsets(IIF)[F

    move-result-object v4

    .line 286
    invoke-static {v2, v3, p5}, Lcom/motorola/camera/custom/MultiFrameBurstController;->focusFor(IIZ)[F

    move-result-object v5

    .line 287
    const/4 v8, 0x0

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    monitor-exit v1

    return-object p0

    .line 264
    :catchall_0
    move-exception v0

    move-object p0, v0

    :try_start_6
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    throw p0
.end method

.method public static declared-synchronized plannedFrameCount()I
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 260
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 260
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static releaseRaw(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V
    .locals 4

    .line 443
    if-eqz p0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    if-eqz v0, :cond_0

    .line 444
    sget-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v2, v2

    int-to-long v2, v2

    sub-long/2addr v0, v2

    sput-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 445
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 447
    :cond_0
    return-void
.end method

.method private static removeAt(I)V
    .locals 3

    .line 427
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v0, v0, p0

    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->releaseRaw(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V

    .line 428
    nop

    :goto_0
    add-int/lit8 p0, p0, 0x1

    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge p0, v0, :cond_0

    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    add-int/lit8 v1, p0, -0x1

    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v2, v2, p0

    aput-object v2, v0, v1

    goto :goto_0

    .line 429
    :cond_0
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    add-int/lit8 p0, p0, -0x1

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 430
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v1, 0x0

    aput-object v1, p0, v0

    .line 431
    return-void
.end method

.method public static declared-synchronized reset()V
    .locals 5

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 109
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    :try_start_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v2, v3, :cond_0

    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v3, v2

    invoke-static {v3}, Lcom/motorola/camera/custom/MultiFrameBurstController;->releaseRaw(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 110
    :cond_0
    move v2, v1

    :goto_1
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v3, v3

    const/4 v4, 0x0

    if-ge v2, v3, :cond_1

    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aput-object v4, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 111
    :cond_1
    move v2, v1

    :goto_2
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v3, v3

    if-ge v2, v3, :cond_2

    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aput-object v4, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 112
    :cond_2
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 113
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 114
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 115
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    .line 116
    sput-object v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    .line 117
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z

    .line 118
    const/4 v1, -0x1

    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    .line 119
    const/4 v1, 0x6

    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 120
    const-wide/32 v1, 0x14000000

    sput-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 121
    monitor-exit v0

    return-void

    .line 108
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized retainedBytes()J
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 202
    :try_start_0
    sget-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-wide v1

    .line 202
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static selectAnchor()J
    .locals 13

    .line 368
    nop

    .line 369
    nop

    .line 370
    nop

    .line 371
    const-wide/16 v0, -0x1

    const/high16 v2, 0x7f800000    # Float.POSITIVE_INFINITY

    const-wide/high16 v3, -0x8000000000000000L

    const/4 v5, 0x0

    :goto_0
    sget v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v5, v6, :cond_6

    .line 372
    sget-object v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v6, v6, v5

    .line 373
    if-eqz v6, :cond_5

    iget-boolean v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    if-nez v7, :cond_5

    iget-boolean v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-nez v7, :cond_0

    goto :goto_1

    .line 374
    :cond_0
    iget-wide v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    const-wide/16 v9, 0x0

    cmp-long v7, v7, v9

    if-lez v7, :cond_5

    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    if-gtz v7, :cond_1

    goto :goto_1

    .line 375
    :cond_1
    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    const/4 v8, 0x0

    cmpg-float v7, v7, v8

    if-lez v7, :cond_5

    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    cmpg-float v7, v7, v8

    if-gez v7, :cond_2

    goto :goto_1

    .line 376
    :cond_2
    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    iget v8, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    mul-float/2addr v7, v8

    .line 377
    const/high16 v8, 0x3f400000    # 0.75f

    cmpg-float v8, v7, v8

    if-ltz v8, :cond_3

    goto :goto_1

    .line 378
    :cond_3
    cmpg-float v8, v7, v2

    if-ltz v8, :cond_4

    cmpl-float v8, v7, v2

    if-nez v8, :cond_5

    iget-wide v8, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v8, v8, v3

    if-lez v8, :cond_5

    .line 379
    :cond_4
    nop

    .line 380
    iget-wide v0, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    .line 381
    iget-wide v2, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    move-wide v11, v2

    move-wide v3, v0

    move-wide v0, v11

    move v2, v7

    .line 371
    :cond_5
    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 384
    :cond_6
    return-wide v0
.end method

.method public static declared-synchronized seqIds()Ljava/lang/String;
    .locals 5

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 247
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 248
    const/4 v2, 0x0

    :goto_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v2, v3, :cond_1

    .line 249
    if-lez v2, :cond_0

    const/16 v3, 0x2c

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 250
    :cond_0
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v3, v2

    iget-wide v3, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 248
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 252
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 246
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized size()I
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 198
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 198
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized snapshotMatchingFrames(III)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    .locals 18

    move/from16 v0, p2

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 228
    :try_start_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v3, 0x0

    if-eqz v2, :cond_6

    if-gtz v0, :cond_0

    goto/16 :goto_2

    .line 229
    :cond_0
    new-instance v2, Ljava/util/ArrayList;

    sget v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-direct {v2, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 230
    sget v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    add-int/lit8 v4, v4, -0x1

    :goto_0
    if-ltz v4, :cond_5

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-ge v5, v0, :cond_5

    .line 231
    sget-object v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v5, v5, v4

    .line 232
    if-eqz v5, :cond_4

    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    if-eqz v6, :cond_4

    iget-boolean v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    if-eqz v6, :cond_1

    move/from16 v7, p0

    move/from16 v8, p1

    goto :goto_1

    .line 233
    :cond_1
    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v6, v6

    move/from16 v7, p0

    if-lt v6, v7, :cond_3

    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v6, v6

    move/from16 v8, p1

    if-le v6, v8, :cond_2

    goto :goto_1

    .line 234
    :cond_2
    new-instance v9, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    iget-wide v10, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    iget-wide v12, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    iget v14, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    iget v15, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    iget-object v5, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    move-object/from16 v17, v5

    move/from16 v16, v6

    invoke-direct/range {v9 .. v17}, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;-><init>(JJIFF[B)V

    invoke-virtual {v2, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 233
    :cond_3
    move/from16 v8, p1

    goto :goto_1

    .line 232
    :cond_4
    move/from16 v7, p0

    move/from16 v8, p1

    .line 230
    :goto_1
    add-int/lit8 v4, v4, -0x1

    goto :goto_0

    .line 237
    :cond_5
    invoke-static {v2}, Ljava/util/Collections;->reverse(Ljava/util/List;)V

    .line 238
    new-array v0, v3, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 228
    :cond_6
    :goto_2
    :try_start_1
    new-array v0, v3, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v1

    return-object v0

    .line 227
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method private static stepped(II)I
    .locals 4

    .line 311
    nop

    .line 312
    const/4 v0, 0x3

    const/4 v1, 0x2

    if-ne p0, v1, :cond_0

    goto :goto_0

    .line 313
    :cond_0
    const/4 v2, 0x4

    const/4 v3, 0x1

    if-ne p0, v3, :cond_1

    move v0, v2

    goto :goto_0

    .line 314
    :cond_1
    if-ne p0, v0, :cond_2

    const/4 v0, 0x6

    goto :goto_0

    .line 315
    :cond_2
    if-ne p0, v2, :cond_3

    goto :goto_0

    .line 316
    :cond_3
    const/4 v0, 0x5

    if-ne p0, v0, :cond_4

    move v0, v2

    goto :goto_0

    :cond_4
    move v0, v3

    .line 317
    :goto_0
    sub-int/2addr p1, v1

    .line 318
    if-ge p1, v0, :cond_5

    goto :goto_1

    :cond_5
    move v0, p1

    :goto_1
    return v0
.end method

.method public static declared-synchronized useSingleFrame()Z
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 256
    :try_start_0
    sget-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 256
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static zeros(I)[F
    .locals 0

    .line 364
    new-array p0, p0, [F

    return-object p0
.end method
