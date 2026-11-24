.class public final Lcom/motorola/camera/custom/FrontAfHelper;
.super Ljava/lang/Object;
.source "FrontAfHelper.java"


# static fields
.field public static final AF_MODE_CONTINUOUS_PICTURE:I = 0x4

.field public static final AF_STATE_FOCUSED_LOCKED:I = 0x4

.field public static final AF_STATE_PASSIVE_FOCUSED:I = 0x2

.field public static final MAX_FRONT_WAIT_FRAMES:I = 0xc

.field private static captureFrames:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applies(ZI)Z
    .locals 0

    .line 27
    if-eqz p0, :cond_0

    const/4 p0, 0x4

    if-ne p1, p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static beginCapture()V
    .locals 1

    .line 45
    const/4 v0, 0x0

    sput v0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    .line 46
    return-void
.end method

.method public static endCapture()V
    .locals 1

    .line 49
    const/4 v0, 0x0

    sput v0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    .line 50
    return-void
.end method

.method public static frameCount()I
    .locals 1

    .line 62
    sget v0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    return v0
.end method

.method public static noteResult(ZI)I
    .locals 0

    .line 56
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/FrontAfHelper;->applies(ZI)Z

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 57
    :cond_0
    sget p0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    const p1, 0x7fffffff

    if-ge p0, p1, :cond_1

    sget p0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    add-int/lit8 p0, p0, 0x1

    sput p0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    .line 58
    :cond_1
    sget p0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    return p0
.end method

.method public static shouldComplete(ZIII)Z
    .locals 1

    .line 35
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/FrontAfHelper;->applies(ZI)Z

    move-result p0

    const/4 p1, 0x0

    if-nez p0, :cond_0

    return p1

    .line 36
    :cond_0
    const/4 p0, 0x2

    const/4 v0, 0x1

    if-eq p2, p0, :cond_3

    const/4 p0, 0x4

    if-ne p2, p0, :cond_1

    goto :goto_0

    .line 37
    :cond_1
    const/16 p0, 0xc

    if-lt p3, p0, :cond_2

    move p1, v0

    :cond_2
    return p1

    .line 36
    :cond_3
    :goto_0
    return v0
.end method

.method public static shouldCompleteCurrent(ZII)Z
    .locals 1

    .line 41
    sget v0, Lcom/motorola/camera/custom/FrontAfHelper;->captureFrames:I

    invoke-static {p0, p1, p2, v0}, Lcom/motorola/camera/custom/FrontAfHelper;->shouldComplete(ZIII)Z

    move-result p0

    return p0
.end method
