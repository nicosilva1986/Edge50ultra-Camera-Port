.class public final Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;
.super Ljava/lang/Object;
.source "MultiFrameBurstController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameBurstController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "BurstFrameSnapshot"
.end annotation


# instance fields
.field public final afState:I

.field public final cameraId:Ljava/lang/String;

.field public final exposureNs:J

.field public final focalLengthPx:F

.field public final focusDistance:F

.field public final gyroExcursionRad:F

.field public final iso:I

.field public final lensState:I

.field public final raw:[B

.field public final sessionGeneration:I

.field public final timestampNs:J


# direct methods
.method constructor <init>(JJIFFFIIILjava/lang/String;[B)V
    .locals 0

    .line 310
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 311
    iput-wide p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    .line 312
    iput-wide p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    .line 313
    iput p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    .line 314
    iput p6, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    .line 315
    iput p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    .line 316
    iput p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focusDistance:F

    .line 317
    iput p9, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->afState:I

    .line 318
    iput p10, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->lensState:I

    .line 319
    iput p11, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->sessionGeneration:I

    .line 320
    iput-object p12, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->cameraId:Ljava/lang/String;

    .line 321
    iput-object p13, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->raw:[B

    .line 322
    return-void
.end method
