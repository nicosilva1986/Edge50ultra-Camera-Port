.class final Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Frame"
.end annotation


# instance fields
.field final black:[F

.field final blur:D

.field final cfa:I

.field final data:[S

.field final exposureGain:D

.field final h:I

.field final inv:[F

.field final time:J

.field final w:I

.field final white:F


# direct methods
.method constructor <init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V
    .locals 6

    .line 82
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    const/4 v0, 0x4

    new-array v1, v0, [F

    iput-object v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    .line 83
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    .line 84
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    .line 85
    iget-wide v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    iput-wide v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->time:J

    .line 86
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->cfa:I

    .line 87
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    .line 88
    iget-wide v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->exposureNs:J

    long-to-double v1, v1

    iget v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->iso:I

    int-to-double v3, v3

    mul-double/2addr v1, v3

    iput-wide v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    .line 89
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-lez v1, :cond_0

    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 90
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    mul-float/2addr v1, v2

    float-to-double v1, v1

    goto :goto_0

    :cond_0
    const-wide/high16 v1, 0x7ff8000000000000L    # Double.NaN

    :goto_0
    iput-wide v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    .line 91
    iget-object v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    invoke-virtual {v1}, [F->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    iput-object v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    .line 92
    const/4 v1, 0x0

    move v2, v1

    :goto_1
    if-ge v2, v0, :cond_1

    iget-object v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    iget v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    iget-object v5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget v5, v5, v2

    sub-float/2addr v4, v5

    const/high16 v5, 0x3f800000    # 1.0f

    div-float/2addr v5, v4

    aput v5, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 93
    :cond_1
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    mul-int/2addr v0, v2

    new-array v0, v0, [S

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    .line 94
    nop

    :goto_2
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    array-length v0, v0

    if-ge v1, v0, :cond_3

    .line 95
    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    aget v0, v0, v1

    .line 96
    const/high16 v2, -0x10000

    and-int/2addr v2, v0

    if-nez v2, :cond_2

    .line 97
    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    int-to-short v0, v0

    aput-short v0, v2, v1

    .line 94
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 96
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "RAW sample outside unsigned 16-bit range"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 99
    :cond_3
    return-void
.end method


# virtual methods
.method linear(III)D
    .locals 2

    .line 102
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    iget v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    mul-int/2addr p2, v1

    add-int/2addr p2, p1

    aget-short p1, v0, p2

    const p2, 0xffff

    and-int/2addr p1, p2

    int-to-float p1, p1

    iget-object p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget p2, p2, p3

    sub-float/2addr p1, p2

    iget-object p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    aget p2, p2, p3

    mul-float/2addr p1, p2

    float-to-double p1, p1

    return-wide p1
.end method
