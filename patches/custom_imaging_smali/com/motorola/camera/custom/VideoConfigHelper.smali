.class public final Lcom/motorola/camera/custom/VideoConfigHelper;
.super Ljava/lang/Object;
.source "VideoConfigHelper.java"


# static fields
.field public static final AVC_MAX_BITRATE:I = 0x5f5e100

.field public static final HEVC_MAX_BITRATE:I = 0x42c1d80


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static pickPreferredHfrRange(I[[I)[I
    .locals 8

    .line 36
    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 37
    :cond_0
    nop

    .line 38
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    array-length v3, p1

    if-ge v2, v3, :cond_4

    .line 39
    aget-object v3, p1, v2

    .line 40
    if-eqz v3, :cond_3

    array-length v4, v3

    const/4 v5, 0x2

    if-lt v4, v5, :cond_3

    aget v4, v3, v1

    const/4 v6, 0x1

    aget v7, v3, v6

    if-le v4, v7, :cond_1

    goto :goto_1

    .line 41
    :cond_1
    aget v4, v3, v1

    if-ne v4, p0, :cond_2

    aget v4, v3, v6

    if-ne v4, p0, :cond_2

    .line 42
    filled-new-array {p0, p0}, [I

    move-result-object p0

    return-object p0

    .line 44
    :cond_2
    if-nez v0, :cond_3

    aget v4, v3, v6

    if-ne v4, p0, :cond_3

    aget v4, v3, v1

    if-ge v4, p0, :cond_3

    .line 45
    new-array v0, v5, [I

    aget v4, v3, v1

    aput v4, v0, v1

    aget v3, v3, v6

    aput v3, v0, v6

    .line 38
    :cond_3
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 48
    :cond_4
    return-object v0
.end method

.method public static resolveVideoBitrate(IIZ)I
    .locals 2

    .line 17
    if-gtz p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 18
    :cond_0
    div-int/lit8 p1, p1, 0x1e

    .line 19
    const/4 v0, 0x1

    if-ge p1, v0, :cond_1

    move p1, v0

    .line 20
    :cond_1
    int-to-long v0, p0

    int-to-long p0, p1

    mul-long/2addr v0, p0

    .line 21
    if-eqz p2, :cond_2

    const p0, 0x42c1d80

    goto :goto_0

    :cond_2
    const p0, 0x5f5e100

    .line 22
    :goto_0
    int-to-long p1, p0

    cmp-long p1, v0, p1

    if-lez p1, :cond_3

    return p0

    .line 23
    :cond_3
    long-to-int p0, v0

    return p0
.end method

.method public static shouldDisableHdr10ForFps(I)Z
    .locals 1

    .line 27
    const/16 v0, 0x3c

    if-lt p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static shouldThermalStepDownFps(II)Z
    .locals 1

    .line 52
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
