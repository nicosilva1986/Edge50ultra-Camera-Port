.class public final Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "CompassSnapshot"
.end annotation


# instance fields
.field public final accuracy:Ljava/lang/Integer;

.field public final cameraSunAngleDeg:Ljava/lang/Double;

.field public final cardinal:Ljava/lang/String;

.field public final ev100:Ljava/lang/Float;

.field public final headingDeg:Ljava/lang/Float;

.field public final magneticDeclinationDeg:Ljava/lang/Float;

.field public final physicalOutdoorBacklit:Z

.field public final pitchDeg:Ljava/lang/Float;

.field public final rollDeg:Ljava/lang/Float;

.field public final status:Ljava/lang/String;

.field public final sunAzimuthDeg:Ljava/lang/Double;

.field public final sunElevationDeg:Ljava/lang/Double;

.field public final trueHeadingDeg:Ljava/lang/Float;

.field public final unavailableReason:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Integer;Ljava/lang/Float;Ljava/lang/String;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Float;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 869
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 870
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->headingDeg:Ljava/lang/Float;

    .line 871
    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    .line 872
    iput-object p3, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->pitchDeg:Ljava/lang/Float;

    .line 873
    iput-object p4, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->rollDeg:Ljava/lang/Float;

    .line 874
    iput-object p5, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->accuracy:Ljava/lang/Integer;

    .line 875
    iput-object p6, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->magneticDeclinationDeg:Ljava/lang/Float;

    .line 876
    iput-object p7, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->cardinal:Ljava/lang/String;

    .line 877
    iput-object p8, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->sunAzimuthDeg:Ljava/lang/Double;

    .line 878
    iput-object p9, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->sunElevationDeg:Ljava/lang/Double;

    .line 879
    iput-object p10, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->cameraSunAngleDeg:Ljava/lang/Double;

    .line 880
    iput-object p11, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->ev100:Ljava/lang/Float;

    .line 881
    iput-boolean p12, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->physicalOutdoorBacklit:Z

    .line 882
    iput-object p13, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->status:Ljava/lang/String;

    .line 883
    iput-object p14, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->unavailableReason:Ljava/lang/String;

    .line 884
    return-void
.end method
