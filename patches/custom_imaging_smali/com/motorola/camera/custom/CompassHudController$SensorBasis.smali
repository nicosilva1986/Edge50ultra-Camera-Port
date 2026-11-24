.class final Lcom/motorola/camera/custom/CompassHudController$SensorBasis;
.super Ljava/lang/Object;
.source "CompassHudController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassHudController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "SensorBasis"
.end annotation


# static fields
.field static final HALF:F

.field static final UPRIGHT_REFERENCE:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 264
    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    sput v0, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->HALF:F

    .line 265
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->usesUprightReference()Z

    move-result v0

    sput-boolean v0, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->UPRIGHT_REFERENCE:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 263
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static usesUprightReference()Z
    .locals 10

    .line 267
    const/4 v0, 0x4

    new-array v1, v0, [F

    sget v0, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->HALF:F

    const/4 v8, 0x0

    aput v0, v1, v8

    const/4 v9, 0x1

    const/4 v2, 0x0

    aput v2, v1, v9

    const/4 v3, 0x2

    aput v2, v1, v3

    const/4 v2, 0x3

    aput v0, v1, v2

    const/4 v5, 0x3

    const-wide/16 v6, 0x0

    const/4 v2, 0x4

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v1 .. v7}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeOrientation([FIIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    move-result-object v0

    .line 269
    if-eqz v0, :cond_0

    iget v0, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    const/high16 v1, 0x42b40000    # 90.0f

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    float-to-double v0, v0

    const-wide v2, 0x3fb999999999999aL    # 0.1

    cmpg-double v0, v0, v2

    if-gez v0, :cond_0

    move v8, v9

    :cond_0
    return v8
.end method
