.class public final Lcom/motorola/camera/custom/VideoConfigHelper;
.super Ljava/lang/Object;
.source "VideoConfigHelper.java"


# static fields
.field public static final AVC_MAX_BITRATE:I = 0x5f5e100

.field private static final AWB_LOCK:Ljava/lang/Object;

.field public static final AWB_LOCK_HOLD_FRAMES:I = 0x3

.field public static final EDGE_OFF:I = 0x0

.field public static final HEVC_MAX_BITRATE:I = 0x42c1d80

.field public static final NR_FAST:I = 0x1

.field public static final NR_HIGH_QUALITY:I = 0x2

.field private static awbHoldFramesRemaining:I

.field private static awbUnlockPending:Z

.field private static lastVideoPhysicalId:Ljava/lang/String;

.field private static volatile latestAeUpperFps:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/VideoConfigHelper;->AWB_LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static latestVideoAeUpperFps()I
    .locals 1

    .line 133
    sget v0, Lcom/motorola/camera/custom/VideoConfigHelper;->latestAeUpperFps:I

    return v0
.end method

.method public static nextVideoAwbLockOverride()Ljava/lang/Boolean;
    .locals 3

    .line 110
    sget-object v0, Lcom/motorola/camera/custom/VideoConfigHelper;->AWB_LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 111
    :try_start_0
    sget v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    if-lez v1, :cond_1

    .line 112
    sget v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    sput v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    .line 113
    sget v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    if-nez v1, :cond_0

    .line 114
    sput-boolean v2, Lcom/motorola/camera/custom/VideoConfigHelper;->awbUnlockPending:Z

    .line 116
    :cond_0
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    monitor-exit v0

    return-object v1

    .line 118
    :cond_1
    sget-boolean v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbUnlockPending:Z

    if-eqz v1, :cond_2

    .line 119
    const/4 v1, 0x0

    sput-boolean v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbUnlockPending:Z

    .line 120
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    monitor-exit v0

    return-object v1

    .line 122
    :cond_2
    monitor-exit v0

    const/4 v0, 0x0

    return-object v0

    .line 123
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public static noteResolvedVideoFps(I)V
    .locals 0

    .line 127
    if-lez p0, :cond_0

    .line 128
    sput p0, Lcom/motorola/camera/custom/VideoConfigHelper;->latestAeUpperFps:I

    .line 130
    :cond_0
    return-void
.end method

.method public static onVideoFramePhysicalCamera(Ljava/lang/String;)V
    .locals 2

    .line 89
    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 92
    :cond_0
    sget-object v0, Lcom/motorola/camera/custom/VideoConfigHelper;->AWB_LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 93
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/VideoConfigHelper;->lastVideoPhysicalId:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 94
    sput-object p0, Lcom/motorola/camera/custom/VideoConfigHelper;->lastVideoPhysicalId:Ljava/lang/String;

    .line 95
    monitor-exit v0

    return-void

    .line 97
    :cond_1
    sget-object v1, Lcom/motorola/camera/custom/VideoConfigHelper;->lastVideoPhysicalId:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 98
    sput-object p0, Lcom/motorola/camera/custom/VideoConfigHelper;->lastVideoPhysicalId:Ljava/lang/String;

    .line 99
    const/4 p0, 0x3

    sput p0, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    .line 100
    const/4 p0, 0x0

    sput-boolean p0, Lcom/motorola/camera/custom/VideoConfigHelper;->awbUnlockPending:Z

    .line 102
    :cond_2
    monitor-exit v0

    .line 103
    return-void

    .line 102
    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0

    .line 90
    :cond_3
    :goto_0
    return-void
.end method

.method public static pickPreferredHfrRange(I[[I)[I
    .locals 8

    .line 156
    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 157
    :cond_0
    nop

    .line 158
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v3, p1

    if-ge v2, v3, :cond_4

    .line 159
    aget-object v3, p1, v2

    .line 160
    if-eqz v3, :cond_3

    array-length v4, v3

    const/4 v5, 0x2

    if-lt v4, v5, :cond_3

    aget v4, v3, v1

    const/4 v6, 0x1

    aget v7, v3, v6

    if-le v4, v7, :cond_1

    goto :goto_1

    .line 161
    :cond_1
    aget v4, v3, v1

    if-ne v4, p0, :cond_2

    aget v4, v3, v6

    if-ne v4, p0, :cond_2

    .line 162
    filled-new-array {p0, p0}, [I

    move-result-object p0

    return-object p0

    .line 164
    :cond_2
    if-nez v0, :cond_3

    aget v4, v3, v6

    if-ne v4, p0, :cond_3

    aget v4, v3, v1

    if-ge v4, p0, :cond_3

    .line 165
    new-array v0, v5, [I

    aget v4, v3, v1

    aput v4, v0, v1

    aget v3, v3, v6

    aput v3, v0, v6

    .line 158
    :cond_3
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 168
    :cond_4
    return-object v0
.end method

.method public static resetAwbSwitchTracker()V
    .locals 2

    .line 81
    sget-object v0, Lcom/motorola/camera/custom/VideoConfigHelper;->AWB_LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 82
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/motorola/camera/custom/VideoConfigHelper;->lastVideoPhysicalId:Ljava/lang/String;

    .line 83
    const/4 v1, 0x0

    sput v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbHoldFramesRemaining:I

    .line 84
    sput-boolean v1, Lcom/motorola/camera/custom/VideoConfigHelper;->awbUnlockPending:Z

    .line 85
    monitor-exit v0

    .line 86
    return-void

    .line 85
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public static resolveVideoAeRange(I[[IZ)[I
    .locals 9

    .line 41
    const/4 v0, 0x0

    if-lez p0, :cond_a

    if-nez p1, :cond_0

    goto :goto_3

    .line 44
    :cond_0
    nop

    .line 45
    nop

    .line 46
    const/4 v1, 0x0

    move-object v2, v0

    move v3, v1

    :goto_0
    array-length v4, p1

    if-ge v3, v4, :cond_6

    .line 47
    aget-object v4, p1, v3

    .line 48
    if-eqz v4, :cond_5

    array-length v5, v4

    const/4 v6, 0x2

    if-lt v5, v6, :cond_5

    aget v5, v4, v1

    if-lez v5, :cond_5

    aget v5, v4, v1

    const/4 v7, 0x1

    aget v8, v4, v7

    if-le v5, v8, :cond_1

    goto :goto_1

    .line 49
    :cond_1
    aget v5, v4, v7

    if-eq v5, p0, :cond_2

    goto :goto_1

    .line 50
    :cond_2
    aget v5, v4, v1

    if-ne v5, p0, :cond_3

    .line 51
    new-array v0, v6, [I

    aput p0, v0, v1

    aput p0, v0, v7

    goto :goto_1

    .line 52
    :cond_3
    if-eqz v2, :cond_4

    aget v5, v4, v1

    aget v8, v2, v1

    if-le v5, v8, :cond_5

    .line 53
    :cond_4
    new-array v2, v6, [I

    aget v5, v4, v1

    aput v5, v2, v1

    aget v4, v4, v7

    aput v4, v2, v7

    .line 46
    :cond_5
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 56
    :cond_6
    if-eqz p2, :cond_8

    .line 57
    if-eqz v2, :cond_7

    move-object v0, v2

    :cond_7
    return-object v0

    .line 59
    :cond_8
    if-eqz v0, :cond_9

    goto :goto_2

    :cond_9
    move-object v0, v2

    :goto_2
    return-object v0

    .line 42
    :cond_a
    :goto_3
    return-object v0
.end method

.method public static resolveVideoBitrate(IIZ)I
    .locals 2

    .line 137
    if-gtz p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 138
    :cond_0
    div-int/lit8 p1, p1, 0x1e

    .line 139
    const/4 v0, 0x1

    if-ge p1, v0, :cond_1

    move p1, v0

    .line 140
    :cond_1
    int-to-long v0, p0

    int-to-long p0, p1

    mul-long/2addr v0, p0

    .line 141
    if-eqz p2, :cond_2

    const p0, 0x42c1d80

    goto :goto_0

    :cond_2
    const p0, 0x5f5e100

    .line 142
    :goto_0
    int-to-long p1, p0

    cmp-long p1, v0, p1

    if-lez p1, :cond_3

    return p0

    .line 143
    :cond_3
    long-to-int p0, v0

    return p0
.end method

.method public static resolveVideoEdgeMode()I
    .locals 1

    .line 27
    const/4 v0, 0x0

    return v0
.end method

.method public static resolveVideoNoiseReductionMode(I)I
    .locals 1

    .line 32
    const/16 v0, 0x3c

    if-lt p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x2

    :goto_0
    return p0
.end method

.method public static shouldDisableHdr10ForFps(I)Z
    .locals 1

    .line 147
    const/16 v0, 0x3c

    if-lt p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static shouldSetVideoOis([ILjava/lang/Integer;Z)Z
    .locals 3

    .line 66
    const/4 v0, 0x0

    if-nez p2, :cond_4

    if-nez p0, :cond_0

    goto :goto_1

    .line 69
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-nez p1, :cond_1

    .line 70
    return v0

    .line 72
    :cond_1
    array-length p1, p0

    move p2, v0

    :goto_0
    if-ge p2, p1, :cond_3

    aget v1, p0, p2

    .line 73
    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    .line 74
    return v2

    .line 72
    :cond_2
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 77
    :cond_3
    return v0

    .line 67
    :cond_4
    :goto_1
    return v0
.end method

.method public static shouldThermalStepDownFps(II)Z
    .locals 1

    .line 172
    const/4 v0, 0x2

    if-lt p0, v0, :cond_0

    const/16 p0, 0x1e

    if-le p1, p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method
