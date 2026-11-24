.class final Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;
.super Ljava/lang/Object;
.source "MultiFrameBurstController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameBurstController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Slot"
.end annotation


# instance fields
.field exposureNs:J

.field exposureValid:Z

.field focalLengthPx:F

.field gyroExcursionRad:F

.field iso:I

.field raw:[B

.field saturated:Z

.field seqId:J

.field timestampNs:J


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/motorola/camera/custom/MultiFrameBurstController-IA;)V
    .locals 0

    invoke-direct {p0}, Lcom/motorola/camera/custom/MultiFrameBurstController$Slot;-><init>()V

    return-void
.end method
