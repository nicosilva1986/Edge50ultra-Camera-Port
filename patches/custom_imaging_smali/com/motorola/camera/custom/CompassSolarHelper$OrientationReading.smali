.class public final Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;
.super Ljava/lang/Object;
.source "CompassSolarHelper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassSolarHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "OrientationReading"
.end annotation


# instance fields
.field public final accuracy:I

.field public final headingDeg:F

.field public final pitchDeg:F

.field public final rollDeg:F

.field public final timestampNs:J


# direct methods
.method public constructor <init>(FFFIJ)V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput p1, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    .line 32
    iput p2, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    .line 33
    iput p3, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->rollDeg:F

    .line 34
    iput p4, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->accuracy:I

    .line 35
    iput-wide p5, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->timestampNs:J

    .line 36
    return-void
.end method
