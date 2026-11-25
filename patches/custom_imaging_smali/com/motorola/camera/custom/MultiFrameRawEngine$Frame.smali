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

.field final gyroX:F

.field final gyroY:F

.field final h:I

.field final inv:[F

.field final noiseOffset:[F

.field final noiseScale:[F

.field final time:J

.field final w:I

.field final white:F


# direct methods
.method constructor <init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V
    .locals 7

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 92
    const/4 v0, 0x4

    new-array v1, v0, [F

    iput-object v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    .line 96
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    .line 97
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    .line 98
    iget-wide v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    iput-wide v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->time:J

    .line 99
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->cfa:I

    .line 100
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    .line 101
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroShiftX:F

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroX:F

    .line 102
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroShiftY:F

    iput v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroY:F

    .line 103
    iget-wide v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->exposureNs:J

    long-to-double v1, v1

    iget v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->iso:I

    int-to-double v3, v3

    mul-double/2addr v1, v3

    iput-wide v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    .line 104
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-lez v1, :cond_0

    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 105
    iget v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    iget v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    mul-float/2addr v1, v3

    float-to-double v3, v1

    goto :goto_0

    :cond_0
    const-wide/high16 v3, 0x7ff8000000000000L    # Double.NaN

    :goto_0
    iput-wide v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    .line 106
    iget-object v1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    invoke-virtual {v1}, [F->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    iput-object v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    .line 107
    const/4 v1, 0x0

    move v3, v1

    :goto_1
    if-ge v3, v0, :cond_1

    iget-object v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    iget v5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    iget-object v6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget v6, v6, v3

    sub-float/2addr v5, v6

    const/high16 v6, 0x3f800000    # 1.0f

    div-float/2addr v6, v5

    aput v6, v4, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 108
    :cond_1
    iget-object v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseScale4:[F

    if-eqz v3, :cond_2

    iget-object v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseOffset4:[F

    if-eqz v3, :cond_2

    const/4 v3, 0x1

    goto :goto_2

    :cond_2
    move v3, v1

    .line 109
    :goto_2
    if-eqz v3, :cond_5

    .line 110
    move v4, v1

    :goto_3
    if-ge v4, v0, :cond_5

    .line 111
    iget-object v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseScale4:[F

    aget v5, v5, v4

    invoke-static {v5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v5

    if-eqz v5, :cond_4

    iget-object v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseScale4:[F

    aget v5, v5, v4

    cmpg-float v5, v5, v2

    if-ltz v5, :cond_4

    iget-object v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseOffset4:[F

    aget v5, v5, v4

    .line 112
    invoke-static {v5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v5

    if-eqz v5, :cond_4

    iget-object v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseOffset4:[F

    aget v5, v5, v4

    cmpg-float v5, v5, v2

    if-gez v5, :cond_3

    goto :goto_4

    .line 110
    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 113
    :cond_4
    :goto_4
    nop

    .line 114
    move v3, v1

    .line 118
    :cond_5
    const/4 v0, 0x0

    if-eqz v3, :cond_6

    iget-object v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseScale4:[F

    invoke-virtual {v2}, [F->clone()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [F

    goto :goto_5

    :cond_6
    move-object v2, v0

    :goto_5
    iput-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseScale:[F

    .line 119
    if-eqz v3, :cond_7

    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseOffset4:[F

    invoke-virtual {v0}, [F->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    :cond_7
    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseOffset:[F

    .line 120
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    mul-int/2addr v0, v2

    new-array v0, v0, [S

    iput-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    .line 121
    nop

    :goto_6
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    array-length v0, v0

    if-ge v1, v0, :cond_9

    .line 122
    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    aget v0, v0, v1

    .line 123
    const/high16 v2, -0x10000

    and-int/2addr v2, v0

    if-nez v2, :cond_8

    .line 124
    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->data:[S

    int-to-short v0, v0

    aput-short v0, v2, v1

    .line 121
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 123
    :cond_8
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "RAW sample outside unsigned 16-bit range"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 126
    :cond_9
    return-void
.end method


# virtual methods
.method linear(III)D
    .locals 2

    .line 129
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

.method shotReadVariance(ID)D
    .locals 5

    .line 133
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseScale:[F

    const-wide/16 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseOffset:[F

    if-nez v0, :cond_0

    goto :goto_0

    .line 134
    :cond_0
    const-wide/high16 v3, 0x3ff0000000000000L    # 1.0

    invoke-static {v3, v4, p2, p3}, Ljava/lang/Math;->min(DD)D

    move-result-wide p2

    invoke-static {v1, v2, p2, p3}, Ljava/lang/Math;->max(DD)D

    move-result-wide p2

    .line 135
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseScale:[F

    aget v0, v0, p1

    float-to-double v0, v0

    mul-double/2addr v0, p2

    iget-object p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->noiseOffset:[F

    aget p1, p2, p1

    float-to-double p1, p1

    add-double/2addr v0, p1

    return-wide v0

    .line 133
    :cond_1
    :goto_0
    return-wide v1
.end method
