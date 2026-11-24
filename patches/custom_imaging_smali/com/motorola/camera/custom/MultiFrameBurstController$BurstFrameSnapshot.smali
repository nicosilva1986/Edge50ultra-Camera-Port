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
.field public final exposureNs:J

.field public final focalLengthPx:F

.field public final gyroExcursionRad:F

.field public final iso:I

.field public final raw:[B

.field public final timestampNs:J


# direct methods
.method constructor <init>(JJIFF[B)V
    .locals 0

    .line 215
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 216
    iput-wide p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    .line 217
    iput-wide p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    .line 218
    iput p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    .line 219
    iput p6, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    .line 220
    iput p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    .line 221
    iput-object p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->raw:[B

    .line 222
    return-void
.end method
