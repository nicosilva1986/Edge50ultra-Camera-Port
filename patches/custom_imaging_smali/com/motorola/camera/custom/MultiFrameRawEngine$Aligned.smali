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

.field noiseVariance:D

.field final scale:D

.field final sharpness:[F


# direct methods
.method constructor <init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IZ)V
    .locals 2

    .line 209
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 210
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 211
    iget-wide v0, p2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    iget-wide p1, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    div-double/2addr v0, p1

    iput-wide v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    .line 212
    new-array p1, p3, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    .line 213
    new-array p1, p3, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    .line 214
    if-eqz p4, :cond_0

    new-array p1, p3, [F

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->sharpness:[F

    .line 215
    return-void
.end method
