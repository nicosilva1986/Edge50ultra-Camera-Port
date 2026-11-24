.class public final Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;
.super Ljava/lang/Object;
.source "CompassSolarHelper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassSolarHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "SolarPosition"
.end annotation


# instance fields
.field public final azimuthDeg:D

.field public final elevationDeg:D


# direct methods
.method public constructor <init>(DD)V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    iput-wide p1, p0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->azimuthDeg:D

    .line 45
    iput-wide p3, p0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    .line 46
    return-void
.end method
