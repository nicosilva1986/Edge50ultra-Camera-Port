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

.field public static final LENS_STATE_MOVING:I = 0x1

.field public static final MAX_FOCUS_SPREAD_DIOPTERS:F = 0.15f

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

.field private static activeCameraId:Ljava/lang/String;

.field private static activeSessionGeneration:I

.field private static byteCap:J

.field private static count:I

.field private static lastMergeFocusSpread:F

.field private static lastMergeGapMs:F

.field private static lastMergeMotionRejected:Z

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

    .line 72
    const/16 v0, 0x8

    new-array v1, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sput-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    .line 73
    new-array v0, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sput-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    .line 77
    const/4 v0, 0x6

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 78
    const-wide/32 v0, 0x14000000

    sput-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    .line 82
    const/4 v0, -0x1

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    .line 86
    const/high16 v0, 0x7fc00000    # Float.NaN

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeFocusSpread:F

    .line 87
    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeGapMs:F

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 89
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized abort(Ljava/lang/String;)V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 173
    const/4 v1, 0x1

    :try_start_0
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    .line 174
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 175
    :cond_0
    sput-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    goto :goto_1

    .line 174
    :cond_1
    :goto_0
    const-string p0, "aborted"

    sput-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    .line 176
    :goto_1
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-lez p0, :cond_2

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V

    goto :goto_1

    .line 177
    :cond_2
    const/4 p0, 0x0

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 178
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

    .line 179
    :cond_3
    monitor-exit v0

    return-void

    .line 172
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method public static declared-synchronized activeCameraId()Ljava/lang/String;
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 109
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 109
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static baseCount(IFZ)I
    .locals 5

    .line 478
    const/4 v0, 0x1

    const/4 v1, 0x5

    const/4 v2, 0x6

    const/4 v3, 0x4

    if-ne p0, v0, :cond_3

    .line 479
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

    .line 480
    :goto_0
    if-eqz p2, :cond_2

    if-le v1, v3, :cond_2

    goto :goto_1

    .line 481
    :cond_2
    move v3, v1

    :goto_1
    return v3

    .line 483
    :cond_3
    const/4 v0, 0x2

    const/4 v4, 0x3

    if-ne p0, v0, :cond_4

    return v4

    .line 484
    :cond_4
    if-ne p0, v4, :cond_6

    if-nez p2, :cond_5

    const/high16 p0, 0x43480000    # 200.0f

    cmpl-float p0, p1, p0

    if-ltz p0, :cond_5

    const/16 v2, 0x8

    :cond_5
    return v2

    .line 485
    :cond_6
    if-ne p0, v3, :cond_7

    return v1

    .line 486
    :cond_7
    if-ne p0, v1, :cond_8

    return v2

    .line 487
    :cond_8
    const/4 p0, -0x1

    return p0
.end method

.method public static declared-synchronized beginSession(Ljava/lang/String;)I
    .locals 4

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 92
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    .line 93
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    if-gtz v1, :cond_0

    sput v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    .line 94
    :cond_0
    sput-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    .line 95
    :goto_0
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-lez p0, :cond_1

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V

    goto :goto_0

    .line 96
    :cond_1
    const/4 p0, 0x0

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 97
    move v1, p0

    :goto_1
    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    const/4 v3, 0x0

    aput-object v3, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 98
    :cond_2
    sput-boolean p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeMotionRejected:Z

    .line 99
    const/high16 p0, 0x7fc00000    # Float.NaN

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeFocusSpread:F

    .line 100
    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeGapMs:F

    .line 101
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return p0

    .line 91
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method public static boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;I)I
    .locals 1

    .line 119
    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)I

    move-result p0

    return p0
.end method

.method public static boundRawMaxImages(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)I
    .locals 1

    .line 124
    const/4 v0, 0x1

    if-ge p3, v0, :cond_0

    move p3, v0

    .line 125
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    .line 126
    invoke-static {p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->isBoundedZslCamera(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    .line 127
    return p3

    .line 129
    :cond_1
    const/4 p0, 0x6

    if-le p3, p0, :cond_2

    return p0

    .line 130
    :cond_2
    return p3
.end method

.method public static computeFocusSpreadDiopters([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;F)F
    .locals 7

    .line 360
    nop

    .line 361
    nop

    .line 362
    nop

    .line 363
    invoke-static {p1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    cmpl-float v0, p1, v1

    if-ltz v0, :cond_0

    .line 364
    nop

    .line 365
    nop

    .line 366
    const/4 v0, 0x1

    move v3, v0

    move v0, p1

    goto :goto_0

    .line 368
    :cond_0
    const/high16 p1, 0x7f800000    # Float.POSITIVE_INFINITY

    const/high16 v0, -0x800000    # Float.NEGATIVE_INFINITY

    move v3, v2

    :goto_0
    if-eqz p0, :cond_4

    .line 369
    array-length v4, p0

    :goto_1
    if-ge v2, v4, :cond_4

    aget-object v5, p0, v2

    .line 370
    if-eqz v5, :cond_3

    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    invoke-static {v6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_3

    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    cmpl-float v6, v6, v1

    if-ltz v6, :cond_3

    .line 371
    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    cmpg-float v6, v6, p1

    if-gez v6, :cond_1

    iget p1, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    .line 372
    :cond_1
    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    cmpl-float v6, v6, v0

    if-lez v6, :cond_2

    iget v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    .line 373
    :cond_2
    add-int/lit8 v3, v3, 0x1

    .line 369
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 377
    :cond_4
    const/4 p0, 0x2

    if-lt v3, p0, :cond_5

    sub-float/2addr v0, p1

    goto :goto_2

    :cond_5
    const/high16 v0, 0x7fc00000    # Float.NaN

    :goto_2
    return v0
.end method

.method public static declared-synchronized configure(I)V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 162
    const/4 v1, 0x3

    if-ne p0, v1, :cond_0

    .line 163
    const/16 p0, 0x8

    :try_start_0
    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 164
    const-wide/32 v1, 0x1a400000

    sput-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    goto :goto_0

    .line 166
    :cond_0
    const/4 p0, 0x6

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 167
    const-wide/32 v1, 0x14000000

    sput-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    .line 169
    :goto_0
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-le p0, v1, :cond_1

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 170
    :cond_1
    monitor-exit v0

    return-void

    .line 161
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method public static declared-synchronized currentSessionGeneration()I
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 105
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 105
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static estimateRawBytes(Z)I
    .locals 4

    .line 135
    nop

    .line 136
    if-eqz p0, :cond_0

    const-wide/32 v0, 0x17ec040

    goto :goto_0

    :cond_0
    const-wide/32 v0, 0xef3828

    .line 137
    :goto_0
    const-wide/32 v2, 0x7fffffff

    cmp-long p0, v0, v2

    if-lez p0, :cond_1

    const p0, 0x7fffffff

    return p0

    .line 138
    :cond_1
    long-to-int p0, v0

    return p0
.end method

.method private static evictOldest()V
    .locals 1

    .line 640
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-nez v0, :cond_0

    return-void

    .line 641
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->removeAt(I)V

    .line 642
    return-void
.end method

.method private static exposureOffsets(IIF)[F
    .locals 6

    .line 502
    new-array v0, p1, [F

    .line 503
    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x2

    if-ne p0, v4, :cond_0

    const/4 v5, 0x3

    if-ne p1, v5, :cond_0

    .line 504
    const/high16 p0, -0x40000000    # -2.0f

    aput p0, v0, v2

    .line 505
    aput v1, v0, v3

    .line 506
    const/high16 p0, 0x40000000    # 2.0f

    aput p0, v0, v4

    .line 507
    return-object v0

    .line 509
    :cond_0
    if-ne p0, v3, :cond_1

    if-le p1, v3, :cond_1

    cmpl-float p0, p2, v1

    if-lez p0, :cond_1

    .line 510
    add-int/lit8 p0, p1, -0x1

    int-to-float p0, p0

    .line 511
    nop

    :goto_0
    if-ge v2, p1, :cond_1

    .line 512
    int-to-float v1, v2

    div-float/2addr v1, p0

    const/high16 v3, 0x3f000000    # 0.5f

    sub-float/2addr v1, v3

    mul-float/2addr v1, p2

    aput v1, v0, v2

    .line 511
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 515
    :cond_1
    return-object v0
.end method

.method private static fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;ILjava/lang/String;JJIFFJZZFII)V
    .locals 0

    .line 570
    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    .line 571
    iput-object p2, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    .line 572
    iput-wide p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    .line 573
    iput-wide p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    .line 574
    iput p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    .line 575
    iput p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    .line 576
    iput p9, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    .line 577
    iput p14, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focusDistance:F

    .line 578
    iput p15, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->afState:I

    .line 579
    move/from16 p1, p16

    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->lensState:I

    .line 580
    iput-wide p10, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    .line 581
    iput-boolean p12, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    .line 582
    iput-boolean p13, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    .line 583
    return-void
.end method

.method private static findSeq(J)I
    .locals 3

    .line 626
    const/4 v0, 0x0

    :goto_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v0, v1, :cond_1

    .line 627
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v1, v1, v0

    iget-wide v1, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v1, v1, p0

    if-nez v1, :cond_0

    return v0

    .line 626
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 629
    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method private static findSessionTimestamp(ILjava/lang/String;J)I
    .locals 3

    .line 610
    const/4 v0, 0x0

    :goto_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v0, v1, :cond_1

    .line 611
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v1, v1, v0

    .line 612
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    if-ne v2, p0, :cond_0

    iget-object v2, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    .line 613
    invoke-static {v2, p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->sameCamera(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-wide v1, v1, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v1, v1, p2

    if-nez v1, :cond_0

    .line 615
    return v0

    .line 610
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 618
    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method private static finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
    .locals 12

    .line 472
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p6, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    sput-boolean v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z

    .line 473
    sput p1, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    .line 474
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

    .line 519
    const/4 v0, 0x0

    const/4 v1, 0x4

    if-ne p0, v1, :cond_7

    if-gtz p1, :cond_0

    goto :goto_3

    .line 520
    :cond_0
    const/high16 p0, 0x41000000    # 8.0f

    const/high16 v2, 0x40800000    # 4.0f

    const/4 v3, 0x3

    const/high16 v4, 0x40000000    # 2.0f

    const/4 v5, 0x5

    const/4 v6, 0x2

    const/4 v7, 0x1

    if-eqz p2, :cond_1

    .line 521
    new-array p2, v5, [F

    aput v4, p2, v0

    aput v2, p2, v7

    const/high16 v2, 0x40c00000    # 6.0f

    aput v2, p2, v6

    aput p0, p2, v3

    const/high16 p0, 0x41200000    # 10.0f

    aput p0, p2, v1

    goto :goto_0

    .line 522
    :cond_1
    new-array p2, v5, [F

    const/high16 v5, 0x3f000000    # 0.5f

    aput v5, p2, v0

    const/high16 v5, 0x3f800000    # 1.0f

    aput v5, p2, v7

    aput v4, p2, v6

    aput v2, p2, v3

    aput p0, p2, v1

    .line 523
    :goto_0
    array-length p0, p2

    if-ne p1, p0, :cond_3

    .line 524
    array-length p0, p2

    new-array p0, p0, [F

    .line 525
    nop

    :goto_1
    array-length p1, p2

    if-ge v0, p1, :cond_2

    aget p1, p2, v0

    aput p1, p0, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 526
    :cond_2
    return-object p0

    .line 528
    :cond_3
    new-array p0, p1, [F

    .line 529
    if-ne p1, v7, :cond_4

    .line 530
    aget p1, p2, v0

    aput p1, p0, v0

    .line 531
    return-object p0

    .line 533
    :cond_4
    array-length v1, p2

    sub-int/2addr v1, v7

    .line 534
    add-int/lit8 v2, p1, -0x1

    .line 535
    nop

    :goto_2
    if-ge v0, p1, :cond_6

    .line 536
    mul-int v3, v0, v1

    div-int/lit8 v4, v2, 0x2

    add-int/2addr v3, v4

    div-int/2addr v3, v2

    .line 537
    if-le v3, v1, :cond_5

    move v3, v1

    .line 538
    :cond_5
    aget v3, p2, v3

    aput v3, p0, v0

    .line 535
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 540
    :cond_6
    return-object p0

    .line 519
    :cond_7
    :goto_3
    new-array p0, v0, [F

    return-object p0
.end method

.method public static hasFocusDriftOrMotion([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;FIFZ)Z
    .locals 2

    .line 383
    invoke-static {p3}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    const/high16 v0, 0x3f400000    # 0.75f

    cmpl-float p3, p3, v0

    if-ltz p3, :cond_0

    .line 384
    return v1

    .line 386
    :cond_0
    const/4 p3, 0x0

    if-eqz p4, :cond_1

    .line 387
    return p3

    .line 389
    :cond_1
    if-ne p2, v1, :cond_2

    .line 390
    return v1

    .line 392
    :cond_2
    if-eqz p0, :cond_4

    .line 393
    array-length p2, p0

    move p4, p3

    :goto_0
    if-ge p4, p2, :cond_4

    aget-object v0, p0, p4

    .line 394
    if-eqz v0, :cond_3

    iget v0, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->lensState:I

    if-ne v0, v1, :cond_3

    .line 395
    return v1

    .line 393
    :cond_3
    add-int/lit8 p4, p4, 0x1

    goto :goto_0

    .line 399
    :cond_4
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->computeFocusSpreadDiopters([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;F)F

    move-result p0

    .line 400
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result p1

    if-eqz p1, :cond_5

    const p1, 0x3e19999a    # 0.15f

    cmpl-float p0, p0, p1

    if-lez p0, :cond_5

    goto :goto_1

    :cond_5
    move v1, p3

    :goto_1
    return v1
.end method

.method private static isBoundedZslCamera(Ljava/lang/String;)Z
    .locals 1

    .line 645
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

.method public static declared-synchronized latestMergeFocusSpread()F
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 414
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeFocusSpread:F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 414
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized latestMergeGapMs()F
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 418
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeGapMs:F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 418
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized noteMetadata(JJIFFJZZ)V
    .locals 19

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 238
    :try_start_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    const/16 v17, 0x0

    const/16 v18, 0x1

    const/4 v3, 0x0

    const/high16 v15, 0x7fc00000    # Float.NaN

    const/16 v16, 0x0

    move-wide/from16 v4, p0

    move-wide/from16 v6, p2

    move/from16 v8, p4

    move/from16 v9, p5

    move/from16 v10, p6

    move-wide/from16 v11, p7

    move/from16 v13, p9

    move/from16 v14, p10

    invoke-static/range {v2 .. v18}, Lcom/motorola/camera/custom/MultiFrameBurstController;->noteMetadataInternal(ILjava/lang/String;JJIFFJZZFIIZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 241
    monitor-exit v1

    return-void

    .line 237
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private static noteMetadataInternal(ILjava/lang/String;JJIFFJZZFIIZ)V
    .locals 22

    .line 260
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v3, 0x1

    if-ge v1, v2, :cond_7

    .line 261
    sget-object v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v4, v2, v1

    .line 262
    if-eqz p16, :cond_2

    .line 263
    iget-wide v5, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v2, v5, p2

    if-eqz v2, :cond_1

    iget-wide v5, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v2, v5, p9

    if-nez v2, :cond_0

    goto :goto_1

    :cond_0
    move/from16 v5, p0

    move-object/from16 v6, p1

    move v3, v0

    goto :goto_2

    :cond_1
    :goto_1
    move/from16 v5, p0

    move-object/from16 v6, p1

    goto :goto_2

    .line 264
    :cond_2
    iget v2, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    move/from16 v5, p0

    if-ne v2, v5, :cond_3

    iget-object v2, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    .line 265
    move-object/from16 v6, p1

    invoke-static {v2, v6}, Lcom/motorola/camera/custom/MultiFrameBurstController;->sameCamera(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget-wide v7, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v2, v7, p2

    if-nez v2, :cond_4

    goto :goto_2

    .line 264
    :cond_3
    move-object/from16 v6, p1

    .line 265
    :cond_4
    move v3, v0

    .line 267
    :goto_2
    if-eqz v3, :cond_6

    .line 268
    const/4 v0, 0x0

    cmpg-float v0, p8, v0

    if-gez v0, :cond_5

    iget v0, v4, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    move v13, v0

    goto :goto_3

    :cond_5
    move/from16 v13, p8

    .line 269
    :goto_3
    move-wide/from16 v7, p2

    move-wide/from16 v9, p4

    move/from16 v11, p6

    move/from16 v12, p7

    move-wide/from16 v14, p9

    move/from16 v16, p11

    move/from16 v17, p12

    move/from16 v18, p13

    move/from16 v19, p14

    move/from16 v20, p15

    invoke-static/range {v4 .. v20}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;ILjava/lang/String;JJIFFJZZFII)V

    .line 271
    return-void

    .line 260
    :cond_6
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 274
    :cond_7
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    array-length v1, v1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_9

    .line 275
    move v0, v3

    :goto_4
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v0, v1, :cond_8

    sget-object v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    add-int/lit8 v4, v0, -0x1

    sget-object v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v5, v5, v0

    aput-object v5, v1, v4

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 276
    :cond_8
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    sub-int/2addr v0, v3

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 277
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    aput-object v2, v0, v1

    .line 279
    :cond_9
    new-instance v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    invoke-direct {v5, v2}, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;-><init>(Lcom/motorola/camera/custom/MultiFrameBurstController-IA;)V

    .line 280
    move/from16 v6, p0

    move-object/from16 v7, p1

    move-wide/from16 v8, p2

    move-wide/from16 v10, p4

    move/from16 v12, p6

    move/from16 v13, p7

    move/from16 v14, p8

    move-wide/from16 v15, p9

    move/from16 v17, p11

    move/from16 v18, p12

    move/from16 v19, p13

    move/from16 v20, p14

    move/from16 v21, p15

    invoke-static/range {v5 .. v21}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;ILjava/lang/String;JJIFFJZZFII)V

    .line 282
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    aput-object v5, v0, v1

    .line 283
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    add-int/2addr v0, v3

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 284
    return-void
.end method

.method public static declared-synchronized noteSessionMetadata(ILjava/lang/String;JJIFFJZZFII)V
    .locals 19

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 248
    :try_start_0
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move/from16 v2, p0

    if-eq v2, v0, :cond_0

    monitor-exit v1

    return-void

    .line 249
    :cond_0
    :try_start_1
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    move-object/from16 v3, p1

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v0, :cond_2

    monitor-exit v1

    return-void

    :cond_1
    move-object/from16 v3, p1

    .line 250
    :cond_2
    const-wide/16 v4, 0x0

    cmp-long v0, p2, v4

    if-gtz v0, :cond_3

    monitor-exit v1

    return-void

    .line 251
    :cond_3
    const/16 v18, 0x0

    move-wide/from16 v4, p2

    move-wide/from16 v6, p4

    move/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    move-wide/from16 v11, p9

    move/from16 v13, p11

    move/from16 v14, p12

    move/from16 v15, p13

    move/from16 v16, p14

    move/from16 v17, p15

    :try_start_2
    invoke-static/range {v2 .. v18}, Lcom/motorola/camera/custom/MultiFrameBurstController;->noteMetadataInternal(ILjava/lang/String;JJIFFJZZFIIZ)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 254
    monitor-exit v1

    return-void

    .line 247
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0
.end method

.method public static declared-synchronized offer(JJIFFJ[BZZ)Z
    .locals 20

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 190
    :try_start_0
    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    const/16 v18, 0x0

    const/16 v19, 0x1

    const/4 v3, 0x0

    const/high16 v16, 0x7fc00000    # Float.NaN

    const/16 v17, 0x0

    move-wide/from16 v4, p0

    move-wide/from16 v6, p2

    move/from16 v8, p4

    move/from16 v9, p5

    move/from16 v10, p6

    move-wide/from16 v11, p7

    move-object/from16 v13, p9

    move/from16 v14, p10

    move/from16 v15, p11

    invoke-static/range {v2 .. v19}, Lcom/motorola/camera/custom/MultiFrameBurstController;->offerInternal(ILjava/lang/String;JJIFFJ[BZZFIIZ)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return v0

    .line 190
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private static offerInternal(ILjava/lang/String;JJIFFJ[BZZFIIZ)Z
    .locals 22

    .line 212
    move-object/from16 v0, p11

    sget-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    const/4 v2, 0x0

    if-nez v1, :cond_8

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 213
    :cond_0
    array-length v1, v0

    int-to-long v3, v1

    .line 214
    sget-wide v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    cmp-long v1, v3, v5

    if-lez v1, :cond_1

    return v2

    .line 215
    :cond_1
    if-eqz p17, :cond_2

    .line 216
    invoke-static/range {p9 .. p10}, Lcom/motorola/camera/custom/MultiFrameBurstController;->findSeq(J)I

    move-result v1

    goto :goto_0

    .line 217
    :cond_2
    invoke-static/range {p0 .. p3}, Lcom/motorola/camera/custom/MultiFrameBurstController;->findSessionTimestamp(ILjava/lang/String;J)I

    move-result v1

    .line 218
    :goto_0
    if-ltz v1, :cond_3

    invoke-static {v1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->removeAt(I)V

    .line 219
    :cond_3
    :goto_1
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-lez v1, :cond_5

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-ge v1, v5, :cond_4

    sget-wide v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v5, v3

    sget-wide v7, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    cmp-long v1, v5, v7

    if-lez v1, :cond_5

    .line 220
    :cond_4
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->evictOldest()V

    goto :goto_1

    .line 222
    :cond_5
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    sget v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    if-ge v1, v5, :cond_7

    sget-wide v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v5, v3

    sget-wide v7, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    cmp-long v1, v5, v7

    if-lez v1, :cond_6

    goto :goto_2

    .line 223
    :cond_6
    new-instance v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    const/4 v1, 0x0

    invoke-direct {v5, v1}, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;-><init>(Lcom/motorola/camera/custom/MultiFrameBurstController-IA;)V

    .line 224
    move/from16 v6, p0

    move-object/from16 v7, p1

    move-wide/from16 v8, p2

    move-wide/from16 v10, p4

    move/from16 v12, p6

    move/from16 v13, p7

    move/from16 v14, p8

    move-wide/from16 v15, p9

    move/from16 v17, p12

    move/from16 v18, p13

    move/from16 v19, p14

    move/from16 v20, p15

    move/from16 v21, p16

    invoke-static/range {v5 .. v21}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;ILjava/lang/String;JJIFFJZZFII)V

    .line 226
    iput-object v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 227
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    aput-object v5, v0, v1

    .line 228
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 229
    sget-wide v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    add-long/2addr v6, v3

    sput-wide v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 230
    xor-int/lit8 v0, p17, 0x1

    invoke-static {v5, v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->overlayPending(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;Z)V

    .line 231
    return v1

    .line 222
    :cond_7
    :goto_2
    return v2

    .line 212
    :cond_8
    :goto_3
    return v2
.end method

.method public static declared-synchronized offerSessionFrame(ILjava/lang/String;JJIFFJ[BZZ)Z
    .locals 21

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 200
    :try_start_0
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v2, 0x0

    move/from16 v3, p0

    if-eq v3, v0, :cond_0

    monitor-exit v1

    return v2

    .line 201
    :cond_0
    :try_start_1
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    move-object/from16 v4, p1

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v0, :cond_2

    monitor-exit v1

    return v2

    :cond_1
    move-object/from16 v4, p1

    .line 202
    :cond_2
    const-wide/16 v5, 0x0

    cmp-long v0, p2, v5

    if-gtz v0, :cond_3

    monitor-exit v1

    return v2

    .line 203
    :cond_3
    const/16 v19, 0x0

    const/16 v20, 0x0

    const/high16 v17, 0x7fc00000    # Float.NaN

    const/16 v18, 0x0

    move-wide/from16 v5, p2

    move-wide/from16 v7, p4

    move/from16 v9, p6

    move/from16 v10, p7

    move/from16 v11, p8

    move-wide/from16 v12, p9

    move-object/from16 v14, p11

    move/from16 v15, p12

    move/from16 v16, p13

    :try_start_2
    invoke-static/range {v3 .. v20}, Lcom/motorola/camera/custom/MultiFrameBurstController;->offerInternal(ILjava/lang/String;JJIFFJ[BZZFIIZ)Z

    move-result v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit v1

    return v0

    .line 199
    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0
.end method

.method public static declared-synchronized oldestSeqId()J
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 422
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    monitor-exit v0

    const-wide/16 v0, -0x1

    return-wide v0

    .line 423
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

    .line 421
    :catchall_0
    move-exception v1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method private static overlayPending(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;Z)V
    .locals 22

    .line 586
    move-object/from16 v0, p0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v2, v3, :cond_8

    .line 587
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v3, v2

    .line 588
    const/16 v17, 0x1

    if-eqz p1, :cond_1

    .line 589
    iget v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    iget v5, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    if-ne v4, v5, :cond_0

    iget-object v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    iget-object v5, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    .line 590
    invoke-static {v4, v5}, Lcom/motorola/camera/custom/MultiFrameBurstController;->sameCamera(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    iget-wide v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    iget-wide v6, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v4, v4, v6

    if-nez v4, :cond_0

    move/from16 v4, v17

    goto :goto_2

    :cond_0
    move v4, v1

    goto :goto_2

    .line 592
    :cond_1
    iget-wide v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    iget-wide v6, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v4, v4, v6

    if-eqz v4, :cond_3

    iget-wide v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    iget-wide v6, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    cmp-long v4, v4, v6

    if-nez v4, :cond_2

    goto :goto_1

    :cond_2
    move v4, v1

    goto :goto_2

    :cond_3
    :goto_1
    move/from16 v4, v17

    .line 593
    :goto_2
    if-nez v4, :cond_4

    .line 586
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 594
    :cond_4
    iget-boolean v1, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-nez v1, :cond_6

    iget-boolean v1, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-eqz v1, :cond_6

    .line 595
    iget-object v1, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 596
    iget v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    const/4 v5, 0x0

    cmpg-float v4, v4, v5

    if-gez v4, :cond_5

    iget v4, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    goto :goto_3

    :cond_5
    iget v4, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    :goto_3
    move v9, v4

    .line 597
    move-object v4, v1

    iget v1, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    move v5, v2

    iget-object v2, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    iget-wide v6, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    move-wide v10, v6

    move v7, v5

    iget-wide v5, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    move v8, v7

    iget v7, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    move v12, v8

    iget v8, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    move-wide v13, v10

    iget-wide v10, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    move v15, v12

    iget-boolean v12, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    move-wide/from16 v18, v13

    iget v14, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focusDistance:F

    move v13, v15

    iget v15, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->afState:I

    iget v3, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->lensState:I

    move/from16 v16, v13

    const/4 v13, 0x1

    move-object/from16 v20, v4

    move/from16 v21, v16

    move/from16 v16, v3

    move-wide/from16 v3, v18

    move/from16 v18, v21

    invoke-static/range {v0 .. v16}, Lcom/motorola/camera/custom/MultiFrameBurstController;->fill(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;ILjava/lang/String;JJIFFJZZFII)V

    .line 600
    move-object/from16 v4, v20

    iput-object v4, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    goto :goto_4

    .line 594
    :cond_6
    move/from16 v18, v2

    .line 602
    :goto_4
    add-int/lit8 v2, v18, 0x1

    :goto_5
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    if-ge v2, v0, :cond_7

    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    add-int/lit8 v1, v2, -0x1

    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v3, v2

    aput-object v3, v0, v1

    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 603
    :cond_7
    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    add-int/lit8 v0, v0, -0x1

    sput v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 604
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->pending:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    const/4 v2, 0x0

    aput-object v2, v0, v1

    .line 605
    return-void

    .line 607
    :cond_8
    return-void
.end method

.method public static declared-synchronized planBurst(IFFIZZ)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
    .locals 9

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 445
    :try_start_0
    invoke-static {p0, p1, p4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->baseCount(IFZ)I

    move-result p1

    .line 446
    const/4 p4, 0x0

    const/4 v0, 0x1

    if-gez p1, :cond_0

    .line 447
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

    .line 449
    :cond_0
    move v2, p0

    :try_start_1
    invoke-static {v2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->configure(I)V

    .line 450
    const/4 p0, 0x4

    if-lt p3, p0, :cond_1

    .line 451
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

    .line 453
    :cond_1
    :try_start_2
    sget-boolean p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    if-eqz p0, :cond_3

    .line 454
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    if-nez p0, :cond_2

    const-string p0, "aborted"

    goto :goto_0

    :cond_2
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    :goto_0
    move-object v8, p0

    .line 455
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

    .line 457
    :cond_3
    :try_start_3
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-nez p0, :cond_4

    .line 458
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

    .line 460
    :cond_4
    :try_start_4
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->selectAnchor()J

    move-result-wide v6

    .line 461
    const-wide/16 v3, 0x0

    cmp-long p0, v6, v3

    if-gez p0, :cond_5

    .line 462
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

    .line 464
    :cond_5
    const/4 p0, 0x2

    if-lt p3, p0, :cond_6

    :try_start_5
    invoke-static {v2, p1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->stepped(II)I

    move-result p1

    :cond_6
    move v3, p1

    .line 465
    invoke-static {v2, v3, p2}, Lcom/motorola/camera/custom/MultiFrameBurstController;->exposureOffsets(IIF)[F

    move-result-object v4

    .line 466
    invoke-static {v2, v3, p5}, Lcom/motorola/camera/custom/MultiFrameBurstController;->focusFor(IIZ)[F

    move-result-object v5

    .line 467
    const/4 v8, 0x0

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->finish(II[F[FJLjava/lang/String;)Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;

    move-result-object p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    monitor-exit v1

    return-object p0

    .line 444
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

    .line 440
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 440
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized recordMergeDiagnostics(ZFF)V
    .locals 1

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 404
    :try_start_0
    sput-boolean p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeMotionRejected:Z

    .line 405
    sput p1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeFocusSpread:F

    .line 406
    sput p2, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeGapMs:F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 407
    monitor-exit v0

    return-void

    .line 403
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private static releaseRaw(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V
    .locals 4

    .line 649
    if-eqz p0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    if-eqz v0, :cond_0

    .line 650
    sget-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v2, v2

    int-to-long v2, v2

    sub-long/2addr v0, v2

    sput-wide v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 651
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    .line 653
    :cond_0
    return-void
.end method

.method private static removeAt(I)V
    .locals 3

    .line 633
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v0, v0, p0

    invoke-static {v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->releaseRaw(Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;)V

    .line 634
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

    .line 635
    :cond_0
    sget p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    add-int/lit8 p0, p0, -0x1

    sput p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 636
    sget-object p0, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    sget v0, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    const/4 v1, 0x0

    aput-object v1, p0, v0

    .line 637
    return-void
.end method

.method public static declared-synchronized reset()V
    .locals 5

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 142
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

    .line 143
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

    .line 144
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

    .line 145
    :cond_2
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    .line 146
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->pendingCount:I

    .line 147
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J

    .line 148
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->aborted:Z

    .line 149
    sput-object v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->abortReason:Ljava/lang/String;

    .line 150
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z

    .line 151
    const/4 v2, -0x1

    sput v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->plannedFrames:I

    .line 152
    const/4 v2, 0x6

    sput v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->maxFrames:I

    .line 153
    const-wide/32 v2, 0x14000000

    sput-wide v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->byteCap:J

    .line 154
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    .line 155
    sput-object v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId:Ljava/lang/String;

    .line 156
    sput-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeMotionRejected:Z

    .line 157
    const/high16 v1, 0x7fc00000    # Float.NaN

    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeFocusSpread:F

    .line 158
    sput v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeGapMs:F
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 159
    monitor-exit v0

    return-void

    .line 141
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

    .line 291
    :try_start_0
    sget-wide v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->retained:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-wide v1

    .line 291
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static sameCamera(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    .line 622
    if-nez p0, :cond_1

    if-nez p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    :goto_0
    return p0
.end method

.method private static selectAnchor()J
    .locals 13

    .line 548
    nop

    .line 549
    nop

    .line 550
    nop

    .line 551
    const-wide/16 v0, -0x1

    const/high16 v2, 0x7f800000    # Float.POSITIVE_INFINITY

    const-wide/high16 v3, -0x8000000000000000L

    const/4 v5, 0x0

    :goto_0
    sget v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v5, v6, :cond_6

    .line 552
    sget-object v6, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v6, v6, v5

    .line 553
    if-eqz v6, :cond_5

    iget-boolean v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    if-nez v7, :cond_5

    iget-boolean v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureValid:Z

    if-nez v7, :cond_0

    goto :goto_1

    .line 554
    :cond_0
    iget-wide v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    const-wide/16 v9, 0x0

    cmp-long v7, v7, v9

    if-lez v7, :cond_5

    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    if-gtz v7, :cond_1

    goto :goto_1

    .line 555
    :cond_1
    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    const/4 v8, 0x0

    cmpg-float v7, v7, v8

    if-lez v7, :cond_5

    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    cmpg-float v7, v7, v8

    if-gez v7, :cond_2

    goto :goto_1

    .line 556
    :cond_2
    iget v7, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    iget v8, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    mul-float/2addr v7, v8

    .line 557
    const/high16 v8, 0x3f400000    # 0.75f

    cmpg-float v8, v7, v8

    if-ltz v8, :cond_3

    goto :goto_1

    .line 558
    :cond_3
    cmpg-float v8, v7, v2

    if-ltz v8, :cond_4

    cmpl-float v8, v7, v2

    if-nez v8, :cond_5

    iget-wide v8, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    cmp-long v8, v8, v3

    if-lez v8, :cond_5

    .line 559
    :cond_4
    nop

    .line 560
    iget-wide v0, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    .line 561
    iget-wide v2, v6, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    move-wide v11, v2

    move-wide v3, v0

    move-wide v0, v11

    move v2, v7

    .line 551
    :cond_5
    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 564
    :cond_6
    return-wide v0
.end method

.method public static declared-synchronized seqIds()Ljava/lang/String;
    .locals 5

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 427
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 428
    const/4 v2, 0x0

    :goto_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-ge v2, v3, :cond_1

    .line 429
    if-lez v2, :cond_0

    const/16 v3, 0x2c

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 430
    :cond_0
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v3, v3, v2

    iget-wide v3, v3, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->seqId:J

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 428
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 432
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 426
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

    .line 287
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 287
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized snapshotMatchingFrames(III)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    .locals 8

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 328
    :try_start_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    const/4 v7, 0x0

    const/4 v2, 0x0

    move v4, p0

    move v5, p1

    move v6, p2

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/MultiFrameBurstController;->snapshotMatchingFrames(Ljava/lang/String;IIIIZ)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object p0

    .line 328
    :catchall_0
    move-exception v0

    move-object p0, v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private static snapshotMatchingFrames(Ljava/lang/String;IIIIZ)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    .locals 24

    .line 340
    move-object/from16 v0, p0

    move/from16 v1, p4

    sget v2, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    if-eqz v2, :cond_9

    if-gtz v1, :cond_0

    const/4 v0, 0x0

    goto/16 :goto_2

    .line 341
    :cond_0
    new-instance v2, Ljava/util/ArrayList;

    sget v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    invoke-static {v4, v1}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-direct {v2, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 342
    sget v4, Lcom/motorola/camera/custom/MultiFrameBurstController;->count:I

    add-int/lit8 v4, v4, -0x1

    :goto_0
    if-ltz v4, :cond_8

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-ge v5, v1, :cond_8

    .line 343
    sget-object v5, Lcom/motorola/camera/custom/MultiFrameBurstController;->slots:[Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;

    aget-object v5, v5, v4

    .line 344
    if-eqz v5, :cond_7

    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    if-eqz v6, :cond_7

    iget-boolean v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->saturated:Z

    if-eqz v6, :cond_1

    move/from16 v7, p1

    move/from16 v8, p2

    move/from16 v9, p3

    goto/16 :goto_1

    .line 345
    :cond_1
    if-eqz p5, :cond_3

    .line 346
    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    move/from16 v7, p1

    if-eq v6, v7, :cond_2

    move/from16 v8, p2

    move/from16 v9, p3

    goto :goto_1

    .line 347
    :cond_2
    if-eqz v0, :cond_4

    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_4

    move/from16 v8, p2

    move/from16 v9, p3

    goto :goto_1

    .line 345
    :cond_3
    move/from16 v7, p1

    .line 349
    :cond_4
    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v6, v6

    move/from16 v8, p2

    if-lt v6, v8, :cond_6

    iget-object v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    array-length v6, v6

    move/from16 v9, p3

    if-le v6, v9, :cond_5

    goto :goto_1

    .line 350
    :cond_5
    new-instance v10, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    iget-wide v11, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->timestampNs:J

    iget-wide v13, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->exposureNs:J

    iget v15, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->iso:I

    iget v6, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focalLengthPx:F

    iget v3, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->gyroExcursionRad:F

    iget v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->focusDistance:F

    move/from16 v18, v0

    iget v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->afState:I

    move/from16 v19, v0

    iget v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->lensState:I

    move/from16 v20, v0

    iget v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->sessionGeneration:I

    move/from16 v21, v0

    iget-object v0, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->cameraId:Ljava/lang/String;

    iget-object v5, v5, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;->raw:[B

    move-object/from16 v22, v0

    move/from16 v17, v3

    move-object/from16 v23, v5

    move/from16 v16, v6

    invoke-direct/range {v10 .. v23}, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;-><init>(JJIFFFIIILjava/lang/String;[B)V

    invoke-virtual {v2, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 349
    :cond_6
    move/from16 v9, p3

    goto :goto_1

    .line 344
    :cond_7
    move/from16 v7, p1

    move/from16 v8, p2

    move/from16 v9, p3

    .line 342
    :goto_1
    add-int/lit8 v4, v4, -0x1

    move-object/from16 v0, p0

    goto/16 :goto_0

    .line 354
    :cond_8
    invoke-static {v2}, Ljava/util/Collections;->reverse(Ljava/util/List;)V

    .line 355
    const/4 v0, 0x0

    new-array v0, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    return-object v0

    .line 340
    :cond_9
    const/4 v0, 0x0

    :goto_2
    new-array v0, v0, [Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    return-object v0
.end method

.method public static declared-synchronized snapshotSessionFrames(Ljava/lang/String;III)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
    .locals 8

    const-class v1, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v1

    .line 334
    :try_start_0
    sget v3, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeSessionGeneration:I

    const/4 v7, 0x1

    move-object v2, p0

    move v4, p1

    move v5, p2

    move v6, p3

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/MultiFrameBurstController;->snapshotMatchingFrames(Ljava/lang/String;IIIIZ)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object p0

    .line 334
    :catchall_0
    move-exception v0

    move-object p0, v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method private static stepped(II)I
    .locals 4

    .line 491
    nop

    .line 492
    const/4 v0, 0x3

    const/4 v1, 0x2

    if-ne p0, v1, :cond_0

    goto :goto_0

    .line 493
    :cond_0
    const/4 v2, 0x4

    const/4 v3, 0x1

    if-ne p0, v3, :cond_1

    move v0, v2

    goto :goto_0

    .line 494
    :cond_1
    if-ne p0, v0, :cond_2

    const/4 v0, 0x6

    goto :goto_0

    .line 495
    :cond_2
    if-ne p0, v2, :cond_3

    goto :goto_0

    .line 496
    :cond_3
    const/4 v0, 0x5

    if-ne p0, v0, :cond_4

    move v0, v2

    goto :goto_0

    :cond_4
    move v0, v3

    .line 497
    :goto_0
    sub-int/2addr p1, v1

    .line 498
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

    .line 436
    :try_start_0
    sget-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->singleFrame:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 436
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized wasLastMergeMotionRejected()Z
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/MultiFrameBurstController;

    monitor-enter v0

    .line 410
    :try_start_0
    sget-boolean v1, Lcom/motorola/camera/custom/MultiFrameBurstController;->lastMergeMotionRejected:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return v1

    .line 410
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

    .line 544
    new-array p0, p0, [F

    return-object p0
.end method
