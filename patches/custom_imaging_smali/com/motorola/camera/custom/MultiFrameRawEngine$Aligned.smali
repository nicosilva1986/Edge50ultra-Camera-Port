.class final Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Aligned"
.end annotation


# instance fields
.field final dx:[F

.field final dy:[F

.field final f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

.field frameRejected:Z

.field final gyroSuperX:F

.field final gyroSuperY:F

.field noiseVariance:D

.field final scale:D

.field final sharpness:[F

.field final tileRejected:[Z


# direct methods
.method constructor <init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IZ)V
    .locals 4

    .line 245
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 246
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 247
    iget-wide v0, p2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    iget-wide v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    div-double/2addr v0, v2

    iput-wide v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    .line 248
    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroX:F

    iget v1, p2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroX:F

    sub-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float/2addr v0, v1

    iput v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->gyroSuperX:F

    .line 249
    iget p1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroY:F

    iget p2, p2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->gyroY:F

    sub-float/2addr p1, p2

    mul-float/2addr p1, v1

    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->gyroSuperY:F

    .line 250
    new-array p1, p3, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    .line 251
    new-array p1, p3, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    .line 252
    new-array p1, p3, [Z

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->tileRejected:[Z

    .line 253
    if-eqz p4, :cond_0

    new-array p1, p3, [F

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->sharpness:[F

    .line 254
    return-void
.end method
