.class public final Lcom/motorola/camera/custom/TelemetryCollector;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;,
        Lcom/motorola/camera/custom/TelemetryCollector$Session;,
        Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;,
        Lcom/motorola/camera/custom/TelemetryCollector$Stream;,
        Lcom/motorola/camera/custom/TelemetryCollector$Series;,
        Lcom/motorola/camera/custom/TelemetryCollector$Integral;,
        Lcom/motorola/camera/custom/TelemetryCollector$Observation;,
        Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
    }
.end annotation


# static fields
.field private static final IMU_PERIOD_US:I = 0x9c4

.field private static final KEYS:[Ljava/lang/String;

.field private static final MAX_IMU_GAP_NS:J = 0x17d7840L

.field private static final RESULT_KEYS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Landroid/hardware/camera2/CaptureResult$Key<",
            "*>;>;"
        }
    .end annotation
.end field

.field public static final SCHEMA_VERSION:I = 0x1

.field private static final SECOND:J = 0x3b9aca00L

.field private static final SIDECAR_MOVE_LOCK:Ljava/lang/Object;

.field private static final ZONES:[Ljava/lang/String;

.field private static volatile active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

.field private static generation:J


# direct methods
.method static bridge synthetic -$$Nest$sfgetZONES()[Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smvalidTriplet([F)Z
    .locals 0

    invoke-static {p0}, Lcom/motorola/camera/custom/TelemetryCollector;->validTriplet([F)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smvendorStream(Landroid/hardware/Sensor;)Lcom/motorola/camera/custom/TelemetryCollector$Stream;
    .locals 0

    invoke-static {p0}, Lcom/motorola/camera/custom/TelemetryCollector;->vendorStream(Landroid/hardware/Sensor;)Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 8

    .line 45
    const/4 v0, 0x5

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "camera-0"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "camera-1"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "cam-therm"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "msm-therm"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-string v2, "mmi_battery"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    sput-object v1, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    .line 46
    const/16 v1, 0xe

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "SENSOR_TIMESTAMP"

    aput-object v2, v1, v3

    const-string v2, "SENSOR_EXPOSURE_TIME"

    aput-object v2, v1, v4

    const-string v2, "SENSOR_FRAME_DURATION"

    aput-object v2, v1, v5

    const-string v2, "SENSOR_SENSITIVITY"

    aput-object v2, v1, v6

    const-string v2, "SENSOR_ROLLING_SHUTTER_SKEW"

    aput-object v2, v1, v7

    const-string v2, "LENS_FOCAL_LENGTH"

    aput-object v2, v1, v0

    const/4 v0, 0x6

    const-string v2, "LENS_APERTURE"

    aput-object v2, v1, v0

    const/4 v0, 0x7

    const-string v2, "LENS_FOCUS_DISTANCE"

    aput-object v2, v1, v0

    const/16 v0, 0x8

    const-string v2, "CONTROL_AF_STATE"

    aput-object v2, v1, v0

    const/16 v0, 0x9

    const-string v2, "CONTROL_AE_STATE"

    aput-object v2, v1, v0

    const/16 v0, 0xa

    const-string v2, "CONTROL_AWB_STATE"

    aput-object v2, v1, v0

    const/16 v0, 0xb

    const-string v2, "STATISTICS_SCENE_FLICKER"

    aput-object v2, v1, v0

    const/16 v0, 0xc

    const-string v2, "COLOR_CORRECTION_GAINS"

    aput-object v2, v1, v0

    const/16 v0, 0xd

    const-string v2, "COLOR_CORRECTION_TRANSFORM"

    aput-object v2, v1, v0

    sput-object v1, Lcom/motorola/camera/custom/TelemetryCollector;->KEYS:[Ljava/lang/String;

    .line 53
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->resultKeys()Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->RESULT_KEYS:Ljava/util/Map;

    .line 56
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->SIDECAR_MOVE_LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static appendJson(Ljava/lang/StringBuilder;Ljava/lang/Object;)V
    .locals 5

    .line 982
    instance-of v0, p1, Ljava/util/Map;

    const/16 v1, 0x2c

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    .line 983
    const/16 v0, 0x7b

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 984
    nop

    .line 985
    check-cast p1, Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    const/4 v0, 0x1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 986
    if-nez v0, :cond_0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 987
    :cond_0
    nop

    .line 988
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/motorola/camera/custom/TelemetryCollector;->escapeJson(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v4, 0x3a

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 989
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector;->appendJson(Ljava/lang/StringBuilder;Ljava/lang/Object;)V

    .line 990
    move v0, v2

    goto :goto_0

    .line 991
    :cond_1
    const/16 p1, 0x7d

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 992
    goto :goto_3

    :cond_2
    instance-of v0, p1, [F

    if-eqz v0, :cond_5

    .line 993
    const/16 v0, 0x5b

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 994
    check-cast p1, [F

    .line 995
    nop

    :goto_1
    array-length v0, p1

    if-ge v2, v0, :cond_4

    .line 996
    if-eqz v2, :cond_3

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 997
    :cond_3
    aget v0, p1, v2

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector;->appendJson(Ljava/lang/StringBuilder;Ljava/lang/Object;)V

    .line 995
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 999
    :cond_4
    const/16 p1, 0x5d

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1000
    goto :goto_3

    :cond_5
    instance-of v0, p1, Ljava/lang/Number;

    if-eqz v0, :cond_7

    .line 1001
    move-object v0, p1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_6
    const-string p1, "null"

    :goto_2
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 1002
    :cond_7
    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_8

    .line 1003
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 1005
    :cond_8
    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lcom/motorola/camera/custom/TelemetryCollector;->escapeJson(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1007
    :goto_3
    return-void
.end method

.method public static buildConciseExifNote(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;III)Ljava/lang/String;
    .locals 4

    .line 922
    const-string v0, "SENSOR_SENSITIVITY"

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 923
    const-string v1, "SENSOR_EXPOSURE_TIME"

    invoke-static {p0, v1}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 924
    invoke-static {p2}, Lcom/motorola/camera/custom/TelemetryCollector;->method(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 925
    const-string v1, ""

    if-nez v0, :cond_0

    move-object v0, v1

    goto :goto_0

    :cond_0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " ISO="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 926
    :goto_0
    if-nez p0, :cond_1

    move-object p0, v1

    goto :goto_1

    :cond_1
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " exposureNs="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 927
    :goto_1
    if-eqz p1, :cond_3

    iget-object v2, p1, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    if-eqz v2, :cond_3

    iget-object v2, p1, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-nez v2, :cond_2

    goto :goto_2

    .line 928
    :cond_2
    iget-object p1, p1, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " iqLuxIdx="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    :cond_3
    :goto_2
    nop

    :goto_3
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "telemetry=1 capture="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " look="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " bokeh="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " profile="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 924
    return-object p0
.end method

.method public static buildShotTelemetryJson(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;III)Ljava/lang/String;
    .locals 7

    .line 622
    nop

    .line 623
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/TelemetryCollector;->sampleCompass(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v6

    .line 622
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/TelemetryCollector;->buildShotTelemetryJson(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;IIILcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static buildShotTelemetryJson(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;IIILcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/lang/String;
    .locals 20

    .line 629
    move-object/from16 v0, p1

    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    .line 630
    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "schemaVersion"

    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 631
    if-nez v0, :cond_0

    const/4 v5, 0x0

    goto :goto_0

    :cond_0
    iget-object v5, v0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->shotId:Ljava/lang/String;

    :goto_0
    const-string v6, "shotId"

    invoke-interface {v1, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 632
    if-nez v0, :cond_1

    const/4 v5, 0x0

    goto :goto_1

    :cond_1
    iget-object v5, v0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->cameraId:Ljava/lang/String;

    :goto_1
    const-string v6, "cameraId"

    invoke-interface {v1, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 633
    if-nez v0, :cond_2

    const/4 v5, 0x0

    goto :goto_2

    :cond_2
    iget-object v5, v0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->isFront:Ljava/lang/Boolean;

    :goto_2
    const-string v6, "isFront"

    invoke-interface {v1, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 634
    const-string v5, "captureMethod"

    invoke-static/range {p2 .. p2}, Lcom/motorola/camera/custom/TelemetryCollector;->method(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 635
    const-string v5, "lookId"

    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 636
    const-string v5, "bokehId"

    invoke-static/range {p4 .. p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 637
    const-string v5, "profileId"

    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 638
    if-nez v0, :cond_3

    const/4 v5, 0x0

    goto :goto_3

    :cond_3
    iget-object v5, v0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    :goto_3
    const-string v6, "iqLuxIdx"

    invoke-interface {v1, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 639
    new-instance v5, Ljava/util/LinkedHashMap;

    invoke-direct {v5}, Ljava/util/LinkedHashMap;-><init>()V

    .line 640
    sget-object v6, Lcom/motorola/camera/custom/TelemetryCollector;->KEYS:[Ljava/lang/String;

    array-length v7, v6

    const/4 v8, 0x0

    move v9, v8

    :goto_4
    if-ge v9, v7, :cond_5

    aget-object v10, v6, v9

    .line 641
    move-object/from16 v11, p0

    invoke-static {v11, v10}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    .line 643
    instance-of v13, v12, Ljava/lang/Long;

    if-eqz v13, :cond_4

    invoke-virtual {v12}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v12

    :cond_4
    invoke-interface {v5, v10, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 640
    add-int/lit8 v9, v9, 0x1

    goto :goto_4

    .line 645
    :cond_5
    move-object/from16 v11, p0

    const-string v6, "captureResult"

    invoke-interface {v1, v6, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 646
    const-string v6, "STATISTICS_SCENE_FLICKER"

    invoke-interface {v5, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 647
    nop

    .line 648
    invoke-virtual {v3, v6}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    const/16 v3, 0x32

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_5

    :cond_6
    const/4 v3, 0x0

    .line 649
    :goto_5
    const/4 v7, 0x2

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    const/16 v3, 0x3c

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 650
    :cond_7
    const-string v6, "cameraSceneMainsClassHz"

    invoke-interface {v1, v6, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 651
    const-string v3, "SENSOR_TIMESTAMP"

    invoke-interface {v5, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/motorola/camera/custom/TelemetryCollector;->nanos(Ljava/lang/Object;)J

    move-result-wide v13

    const-string v3, "SENSOR_EXPOSURE_TIME"

    invoke-interface {v5, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/motorola/camera/custom/TelemetryCollector;->nanos(Ljava/lang/Object;)J

    move-result-wide v15

    .line 652
    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    .line 653
    invoke-static {v3, v0, v13, v14}, Lcom/motorola/camera/custom/TelemetryCollector;->reason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;J)Ljava/lang/String;

    move-result-object v5

    .line 654
    if-nez v5, :cond_8

    const-wide/16 v9, 0x0

    cmp-long v6, v15, v9

    if-gtz v6, :cond_8

    const-string v6, "missingExposureTime"

    goto :goto_6

    :cond_8
    move-object v6, v5

    .line 655
    :goto_6
    new-array v9, v7, [Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v10, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    aput-object v10, v9, v8

    sget-object v10, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    aput-object v10, v9, v2

    move v10, v8

    :goto_7
    const-string v12, "noSample"

    if-ge v10, v7, :cond_d

    move/from16 v19, v2

    aget-object v2, v9, v10

    .line 656
    move/from16 p2, v7

    sget-object v7, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne v2, v7, :cond_9

    move/from16 v17, v19

    goto :goto_8

    :cond_9
    move/from16 v17, v8

    .line 657
    :goto_8
    invoke-static {v3, v2, v6}, Lcom/motorola/camera/custom/TelemetryCollector;->streamReason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 658
    if-eqz v17, :cond_a

    const-string v18, "gyro"

    goto :goto_9

    :cond_a
    const-string v18, "accelerometer"

    :goto_9
    move-object/from16 v4, v18

    .line 659
    if-nez v6, :cond_b

    iget-object v8, v3, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    invoke-virtual {v8, v2}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    goto :goto_a

    :cond_b
    const/4 v2, 0x0

    .line 660
    :goto_a
    invoke-virtual {v12, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_c

    const-string v7, "insufficientCoverage"

    :cond_c
    move-object/from16 v18, v7

    .line 658
    move-object v12, v2

    invoke-static/range {v12 .. v18}, Lcom/motorola/camera/custom/TelemetryCollector;->motion(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJZLjava/lang/String;)Ljava/util/Map;

    move-result-object v2

    invoke-interface {v1, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 655
    add-int/lit8 v10, v10, 0x1

    move/from16 v7, p2

    move/from16 v2, v19

    const/4 v8, 0x0

    goto :goto_7

    .line 662
    :cond_d
    move/from16 v19, v2

    move/from16 p2, v7

    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {v3, v2, v13, v14, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->observe(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;JLjava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    move-result-object v2

    .line 663
    if-nez v5, :cond_e

    iget-object v4, v3, Lcom/motorola/camera/custom/TelemetryCollector$Session;->layout:Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;

    goto :goto_b

    :cond_e
    const/4 v4, 0x0

    :goto_b
    invoke-static {v2, v4}, Lcom/motorola/camera/custom/TelemetryCollector;->spectrum(Lcom/motorola/camera/custom/TelemetryCollector$Observation;Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)Ljava/util/Map;

    move-result-object v2

    const-string v4, "rearSpectral"

    invoke-interface {v1, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 664
    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {v3, v2, v13, v14, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->observe(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;JLjava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    move-result-object v2

    .line 665
    invoke-virtual {v2}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->json()Ljava/util/Map;

    move-result-object v4

    .line 666
    if-nez v5, :cond_f

    iget-object v6, v3, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    sget-object v7, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v6, v7}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/hardware/Sensor;

    goto :goto_c

    :cond_f
    const/4 v6, 0x0

    .line 668
    :goto_c
    if-eqz v6, :cond_10

    invoke-virtual {v6}, Landroid/hardware/Sensor;->getType()I

    move-result v6

    const/4 v7, 0x5

    if-ne v6, v7, :cond_10

    const/4 v6, 0x0

    invoke-virtual {v2, v6}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->channel(I)Ljava/lang/Float;

    move-result-object v2

    goto :goto_d

    :cond_10
    const/4 v2, 0x0

    :goto_d
    const-string v6, "lux"

    invoke-interface {v4, v6, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 669
    const-string v2, "rearAls"

    invoke-interface {v1, v2, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 670
    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {v3, v2, v13, v14, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->observe(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;JLjava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    move-result-object v2

    .line 671
    invoke-virtual {v2}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->json()Ljava/util/Map;

    move-result-object v4

    .line 672
    const-string v6, "distanceMm"

    const/4 v7, 0x0

    invoke-interface {v4, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 673
    iget-object v6, v2, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    if-nez v6, :cond_11

    iget-object v2, v2, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    goto :goto_e

    :cond_11
    const-string v2, "unverifiedUnits"

    :goto_e
    const-string v6, "distanceReason"

    invoke-interface {v4, v6, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 674
    const-string v2, "rearTof"

    invoke-interface {v1, v2, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 676
    move-object v2, v12

    new-instance v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    if-nez v5, :cond_12

    iget-object v7, v3, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermal:Lcom/motorola/camera/custom/TelemetryCollector$Series;

    goto :goto_f

    :cond_12
    const/4 v7, 0x0

    .line 677
    :goto_f
    if-nez v5, :cond_13

    move-object/from16 v18, v2

    goto :goto_10

    :cond_13
    move-object/from16 v18, v5

    :goto_10
    const-wide/32 v16, 0x77359400

    move-wide v14, v13

    move-object v13, v7

    invoke-direct/range {v12 .. v18}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;-><init>(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJLjava/lang/String;)V

    .line 678
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    .line 679
    iget-object v3, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    if-nez v3, :cond_14

    const/4 v7, 0x0

    goto :goto_11

    :cond_14
    iget-object v3, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->toString()Ljava/lang/String;

    move-result-object v7

    :goto_11
    const-string v3, "sampledNs"

    invoke-interface {v2, v3, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 680
    new-instance v3, Ljava/util/LinkedHashMap;

    invoke-direct {v3}, Ljava/util/LinkedHashMap;-><init>()V

    .line 681
    const/4 v6, 0x0

    :goto_12
    sget-object v4, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    array-length v4, v4

    if-ge v6, v4, :cond_19

    .line 682
    iget-object v4, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    if-eqz v4, :cond_16

    iget-object v4, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v4, v4, v6

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-nez v4, :cond_15

    goto :goto_13

    :cond_15
    iget-object v4, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v4, v4, v6

    invoke-static {v4}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    goto :goto_14

    :cond_16
    :goto_13
    const/4 v7, 0x0

    .line 683
    :goto_14
    sget-object v4, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    aget-object v4, v4, v6

    invoke-interface {v2, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 684
    if-nez v7, :cond_18

    sget-object v4, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    aget-object v4, v4, v6

    iget-object v5, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    if-nez v5, :cond_17

    const-string v5, "unavailableOrInvalid"

    goto :goto_15

    :cond_17
    iget-object v5, v12, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    :goto_15
    invoke-interface {v3, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 681
    :cond_18
    add-int/lit8 v6, v6, 0x1

    goto :goto_12

    .line 686
    :cond_19
    const-string v4, "reasons"

    invoke-interface {v2, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 687
    const-string v3, "thermalC"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 688
    if-eqz p6, :cond_1a

    move-object/from16 v0, p6

    goto :goto_16

    :cond_1a
    invoke-static/range {p0 .. p1}, Lcom/motorola/camera/custom/TelemetryCollector;->sampleCompass(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v0

    :goto_16
    invoke-static {v0}, Lcom/motorola/camera/custom/TelemetryCollector;->compassJson(Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/util/Map;

    move-result-object v0

    const-string v2, "compass"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 689
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 690
    const/4 v2, 0x3

    new-array v3, v2, [Ljava/lang/String;

    const-string v4, "humidityPct"

    const/4 v6, 0x0

    aput-object v4, v3, v6

    const-string v4, "pressureHpa"

    aput-object v4, v3, v19

    const-string v4, "ambientTempC"

    aput-object v4, v3, p2

    move v8, v6

    :goto_17
    if-ge v8, v2, :cond_1b

    aget-object v4, v3, v8

    .line 691
    const/4 v7, 0x0

    invoke-interface {v1, v4, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 692
    const-string v5, "notPresentOnHardware"

    invoke-interface {v0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 690
    add-int/lit8 v8, v8, 0x1

    goto :goto_17

    .line 694
    :cond_1b
    const-string v2, "unavailableReasons"

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 695
    new-instance v0, Ljava/lang/StringBuilder;

    const/16 v2, 0x76c

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 696
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/TelemetryCollector;->appendJson(Ljava/lang/StringBuilder;Ljava/lang/Object;)V

    .line 697
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static compassJson(Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 824
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 825
    const-string v1, "headingDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->headingDeg:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 826
    const-string v1, "trueHeadingDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 827
    const-string v1, "pitchDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->pitchDeg:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 828
    const-string v1, "rollDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->rollDeg:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 829
    const-string v1, "accuracy"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->accuracy:Ljava/lang/Integer;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 830
    const-string v1, "magneticDeclinationDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->magneticDeclinationDeg:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 831
    const-string v1, "cardinal"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->cardinal:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 832
    const-string v1, "sunAzimuthDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->sunAzimuthDeg:Ljava/lang/Double;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 833
    const-string v1, "sunElevationDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->sunElevationDeg:Ljava/lang/Double;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 834
    const-string v1, "cameraSunAngleDeg"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->cameraSunAngleDeg:Ljava/lang/Double;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 835
    const-string v1, "ev100"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->ev100:Ljava/lang/Float;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 836
    iget-boolean v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->physicalOutdoorBacklit:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "physicalOutdoorBacklit"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 837
    const-string v1, "status"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->status:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 838
    const-string v1, "unavailableReason"

    iget-object p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->unavailableReason:Ljava/lang/String;

    invoke-interface {v0, v1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 839
    return-object v0
.end method

.method public static escapeJson(Ljava/lang/String;)Ljava/lang/String;
    .locals 7

    .line 959
    if-nez p0, :cond_0

    const-string p0, "null"

    return-object p0

    .line 960
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x2

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    const/16 v1, 0x22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 961
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_4

    .line 962
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 963
    sparse-switch v3, :sswitch_data_0

    .line 972
    const/16 v4, 0x20

    if-lt v3, v4, :cond_2

    invoke-static {v3}, Ljava/lang/Character;->isSurrogate(C)Z

    move-result v4

    if-eqz v4, :cond_1

    goto :goto_1

    .line 965
    :sswitch_0
    const-string v3, "\\\\"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 964
    :sswitch_1
    const-string v3, "\\\""

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 969
    :sswitch_2
    const-string v3, "\\r"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 967
    :sswitch_3
    const-string v3, "\\f"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 968
    :sswitch_4
    const-string v3, "\\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 970
    :sswitch_5
    const-string v3, "\\t"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 966
    :sswitch_6
    const-string v3, "\\b"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 975
    :cond_1
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 973
    :cond_2
    :goto_1
    const-string v4, "\\u"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 974
    const/16 v4, 0xc

    :goto_2
    if-ltz v4, :cond_3

    shr-int v5, v3, v4

    and-int/lit8 v5, v5, 0xf

    const/16 v6, 0x10

    invoke-static {v5, v6}, Ljava/lang/Character;->forDigit(II)C

    move-result v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v4, v4, -0x4

    goto :goto_2

    .line 961
    :cond_3
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 978
    :cond_4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x8 -> :sswitch_6
        0x9 -> :sswitch_5
        0xa -> :sswitch_4
        0xc -> :sswitch_3
        0xd -> :sswitch_2
        0x22 -> :sswitch_1
        0x5c -> :sswitch_0
    .end sparse-switch
.end method

.method public static estimateCctKelvin(DDD[D)Ljava/lang/Double;
    .locals 11

    .line 356
    move-object/from16 v0, p6

    const-wide/16 v1, 0x0

    cmpl-double v3, p0, v1

    const/4 v4, 0x0

    if-lez v3, :cond_5

    cmpl-double v3, p2, v1

    if-lez v3, :cond_5

    cmpl-double v3, p4, v1

    if-lez v3, :cond_5

    if-eqz v0, :cond_5

    array-length v3, v0

    const/16 v5, 0x9

    if-eq v3, v5, :cond_0

    goto/16 :goto_1

    .line 357
    :cond_0
    const/4 v3, 0x0

    aget-wide v5, v0, v3

    mul-double/2addr v5, p0

    const/4 v3, 0x1

    aget-wide v7, v0, v3

    mul-double/2addr v7, p2

    add-double/2addr v5, v7

    const/4 v3, 0x2

    aget-wide v7, v0, v3

    mul-double/2addr v7, p4

    add-double/2addr v5, v7

    .line 358
    const/4 v3, 0x3

    aget-wide v7, v0, v3

    mul-double/2addr v7, p0

    const/4 v3, 0x4

    aget-wide v9, v0, v3

    mul-double/2addr v9, p2

    add-double/2addr v7, v9

    const/4 v3, 0x5

    aget-wide v9, v0, v3

    mul-double/2addr v9, p4

    add-double/2addr v7, v9

    .line 359
    const/4 v3, 0x6

    aget-wide v9, v0, v3

    mul-double/2addr v9, p0

    const/4 p0, 0x7

    aget-wide p0, v0, p0

    mul-double/2addr p0, p2

    add-double/2addr v9, p0

    const/16 p0, 0x8

    aget-wide p0, v0, p0

    mul-double/2addr p0, p4

    add-double/2addr v9, p0

    .line 360
    add-double p0, v5, v7

    add-double/2addr p0, v9

    .line 361
    cmpl-double v0, v5, v1

    if-lez v0, :cond_4

    cmpl-double v0, v7, v1

    if-lez v0, :cond_4

    cmpl-double v0, v9, v1

    if-lez v0, :cond_4

    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 362
    :cond_1
    div-double/2addr v5, p0

    div-double/2addr v7, p0

    .line 363
    const-wide p0, 0x3fc7c84b5dcc63f1L    # 0.1858

    sub-double v0, v7, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x3e7ad7f29abcaf48L    # 1.0E-7

    cmpg-double v0, v0, v2

    if-gez v0, :cond_2

    return-object v4

    .line 364
    :cond_2
    const-wide v0, 0x3fd53f7ced916873L    # 0.332

    sub-double/2addr v5, v0

    sub-double/2addr p0, v7

    div-double/2addr v5, p0

    .line 365
    const-wide p0, 0x407c100000000000L    # 449.0

    mul-double/2addr p0, v5

    const-wide v0, 0x40ab8a0000000000L    # 3525.0

    add-double/2addr p0, v0

    mul-double/2addr p0, v5

    const-wide v0, 0x40baa74ccccccccdL    # 6823.3

    add-double/2addr p0, v0

    mul-double/2addr p0, v5

    const-wide v0, 0x40b590547ae147aeL    # 5520.33

    add-double/2addr p0, v0

    .line 366
    const-wide v0, 0x40a6440000000000L    # 2850.0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_3

    const-wide v0, 0x40c3880000000000L    # 10000.0

    cmpg-double v0, p0, v0

    if-gtz v0, :cond_3

    invoke-static {p0, p1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    :cond_3
    return-object v4

    .line 361
    :cond_4
    :goto_0
    return-object v4

    .line 356
    :cond_5
    :goto_1
    return-object v4
.end method

.method private static finiteArray([F)[F
    .locals 3

    .line 528
    array-length v0, p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget v2, p0, v1

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-nez v2, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 529
    :cond_1
    return-object p0
.end method

.method public static gyroExcursionRad([J[[F)Ljava/lang/Double;
    .locals 26

    .line 423
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const/4 v2, 0x0

    if-eqz v0, :cond_6

    if-eqz v1, :cond_6

    array-length v3, v0

    const/4 v4, 0x2

    if-lt v3, v4, :cond_6

    array-length v3, v0

    array-length v5, v1

    if-eq v3, v5, :cond_0

    move-object/from16 v21, v2

    goto/16 :goto_3

    .line 424
    :cond_0
    new-instance v6, Lcom/motorola/camera/custom/TelemetryCollector$Integral;

    const/4 v3, 0x1

    invoke-direct {v6, v3}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;-><init>(Z)V

    .line 425
    const/4 v5, 0x0

    move v7, v5

    :goto_0
    array-length v8, v0

    if-ge v7, v8, :cond_5

    .line 426
    aget-wide v8, v0, v7

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-ltz v8, :cond_4

    aget-object v8, v1, v7

    invoke-static {v8}, Lcom/motorola/camera/custom/TelemetryCollector;->validTriplet([F)Z

    move-result v8

    if-nez v8, :cond_1

    move-object/from16 v21, v2

    goto/16 :goto_2

    .line 427
    :cond_1
    if-nez v7, :cond_2

    move-object/from16 v21, v2

    move/from16 v22, v3

    move/from16 v23, v4

    move v5, v7

    goto :goto_1

    .line 428
    :cond_2
    aget-wide v8, v0, v7

    add-int/lit8 v10, v7, -0x1

    aget-wide v11, v0, v10

    cmp-long v8, v8, v11

    if-gtz v8, :cond_3

    return-object v2

    .line 429
    :cond_3
    aget-object v8, v1, v10

    aget-object v9, v1, v7

    .line 430
    aget-wide v11, v0, v7

    aget-wide v13, v0, v10

    sub-long/2addr v11, v13

    long-to-double v10, v11

    const-wide v12, 0x41cdcd6500000000L    # 1.0E9

    div-double/2addr v10, v12

    aget v12, v8, v5

    float-to-double v12, v12

    aget v14, v8, v3

    float-to-double v14, v14

    aget v8, v8, v4

    move-object/from16 v21, v2

    move/from16 v22, v3

    float-to-double v2, v8

    aget v8, v9, v5

    move/from16 v23, v4

    float-to-double v4, v8

    aget v8, v9, v22

    float-to-double v0, v8

    aget v8, v9, v23

    float-to-double v8, v8

    move-wide/from16 v17, v0

    move-wide/from16 v19, v8

    move-wide/from16 v24, v4

    move v5, v7

    move-wide v7, v10

    move-wide v9, v12

    move-wide v11, v14

    move-wide v13, v2

    move-wide/from16 v15, v24

    invoke-virtual/range {v6 .. v20}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->step(DDDDDDD)V

    .line 425
    :goto_1
    add-int/lit8 v7, v5, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v21

    move/from16 v3, v22

    move/from16 v4, v23

    const/4 v5, 0x0

    goto :goto_0

    .line 426
    :cond_4
    move-object/from16 v21, v2

    :goto_2
    return-object v21

    .line 432
    :cond_5
    iget-wide v0, v6, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->excursion:D

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    return-object v0

    .line 423
    :cond_6
    move-object/from16 v21, v2

    :goto_3
    return-object v21
.end method

.method private static isSaveLocationAllowed()Z
    .locals 7

    .line 844
    const/4 v0, 0x1

    :try_start_0
    const-string v1, "com.motorola.camera.settings.PersistBehavior"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 845
    const-string v2, "getPreferences"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 846
    if-eqz v1, :cond_0

    .line 847
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v4, "getBoolean"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const-class v6, Ljava/lang/String;

    aput-object v6, v5, v3

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v6, v5, v0

    invoke-virtual {v2, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 848
    const-string v4, "com.motorola.camera.geo_location_state"

    sget-object v5, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    filled-new-array {v4, v5}, [Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v2, v1, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 849
    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v2, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    return v3

    .line 851
    :catchall_0
    move-exception v1

    :cond_0
    nop

    .line 852
    return v0
.end method

.method public static latestGyroExcursionRad(JJ)F
    .locals 9

    .line 410
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    .line 411
    const/high16 v1, -0x40800000    # -1.0f

    if-eqz v0, :cond_2

    const-wide/16 v2, 0x0

    cmp-long v4, p0, v2

    if-lez v4, :cond_2

    cmp-long v2, p2, v2

    if-gtz v2, :cond_0

    goto :goto_0

    .line 413
    :cond_0
    :try_start_0
    iget-object v0, v0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v0, v2}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    const/4 v7, 0x1

    const/4 v8, 0x0

    move-wide v3, p0

    move-wide v5, p2

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/TelemetryCollector;->motion(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJZLjava/lang/String;)Ljava/util/Map;

    move-result-object p0

    .line 414
    const-string p1, "angularExcursionRad"

    invoke-interface {p0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 415
    instance-of p1, p0, Ljava/lang/Number;

    if-eqz p1, :cond_1

    check-cast p0, Ljava/lang/Number;

    invoke-virtual {p0}, Ljava/lang/Number;->floatValue()F

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    return v1

    .line 416
    :catchall_0
    move-exception v0

    .line 417
    return v1

    .line 411
    :cond_2
    :goto_0
    return v1
.end method

.method private static method(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 533
    const-string v0, "vendor"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "singleRaw"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "rawBurst"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 534
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Unknown capture method"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 533
    :cond_1
    :goto_0
    return-object p0
.end method

.method private static motion(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJZLjava/lang/String;)Ljava/util/Map;
    .locals 36
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/motorola/camera/custom/TelemetryCollector$Series;",
            "JJZ",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 436
    move-object/from16 v1, p0

    move-wide/from16 v2, p1

    move/from16 v0, p5

    new-instance v6, Ljava/util/LinkedHashMap;

    invoke-direct {v6}, Ljava/util/LinkedHashMap;-><init>()V

    .line 437
    const-string v7, "sampleCount"

    const/4 v8, 0x0

    invoke-interface {v6, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 438
    const-string v7, "achievedHz"

    invoke-interface {v6, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 439
    if-eqz v0, :cond_0

    const-string v7, "rmsRadPerSec"

    goto :goto_0

    :cond_0
    const-string v7, "rmsMps2"

    .line 440
    :goto_0
    if-eqz v0, :cond_1

    const-string v9, "peakRadPerSec"

    goto :goto_1

    :cond_1
    const-string v9, "peakMps2"

    .line 441
    :goto_1
    invoke-interface {v6, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 442
    invoke-interface {v6, v9, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 443
    if-eqz v0, :cond_2

    const-string v10, "angularExcursionRad"

    invoke-interface {v6, v10, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 444
    :cond_2
    const-string v10, "reason"

    move-object/from16 v11, p6

    invoke-interface {v6, v10, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 445
    if-eqz v1, :cond_d

    const-wide/16 v10, 0x0

    cmp-long v12, v2, v10

    if-lez v12, :cond_d

    cmp-long v10, p3, v10

    if-lez v10, :cond_d

    const-wide v10, 0x7fffffffffffffffL

    sub-long v10, v10, p3

    cmp-long v10, v2, v10

    if-lez v10, :cond_3

    goto/16 :goto_5

    .line 446
    :cond_3
    add-long v10, v2, p3

    .line 447
    monitor-enter p0

    .line 448
    :try_start_0
    invoke-virtual/range {p0 .. p2}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->lowerBound(J)I

    move-result v12

    invoke-virtual {v1, v10, v11}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->lowerBound(J)I

    move-result v13

    .line 449
    sub-int v14, v13, v12

    .line 450
    iget v15, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-ge v13, v15, :cond_4

    iget-object v15, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    invoke-virtual {v1, v13}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v16

    aget-wide v15, v15, v16

    cmp-long v15, v15, v10

    if-nez v15, :cond_4

    add-int/lit8 v14, v14, 0x1

    .line 451
    :cond_4
    const-string v15, "sampleCount"

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v6, v15, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 452
    const-wide v17, 0x41cdcd6500000000L    # 1.0E9

    const/4 v8, 0x2

    if-lt v14, v8, :cond_5

    .line 453
    iget-object v8, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    add-int v15, v12, v14

    add-int/lit8 v15, v15, -0x1

    invoke-virtual {v1, v15}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v15

    aget-wide v19, v8, v15

    iget-object v8, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    invoke-virtual {v1, v12}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v15

    aget-wide v21, v8, v15

    move/from16 p6, v14

    sub-long v14, v19, v21

    .line 454
    const-string v8, "achievedHz"

    move-object/from16 v19, v9

    add-int/lit8 v9, p6, -0x1

    int-to-double v4, v9

    mul-double v4, v4, v17

    long-to-double v14, v14

    div-double/2addr v4, v14

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-interface {v6, v8, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 452
    :cond_5
    move-object/from16 v19, v9

    .line 456
    :goto_2
    iget v4, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-eq v12, v4, :cond_c

    iget v4, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-ne v13, v4, :cond_6

    goto/16 :goto_4

    .line 457
    :cond_6
    iget-object v4, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    invoke-virtual {v1, v12}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v5

    aget-wide v4, v4, v5

    cmp-long v4, v4, v2

    if-lez v4, :cond_7

    add-int/lit8 v12, v12, -0x1

    .line 458
    :cond_7
    if-gez v12, :cond_8

    monitor-exit p0

    return-object v6

    .line 459
    :cond_8
    new-instance v4, Lcom/motorola/camera/custom/TelemetryCollector$Integral;

    invoke-direct {v4, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;-><init>(Z)V

    .line 460
    nop

    :goto_3
    if-ge v12, v13, :cond_a

    .line 461
    invoke-virtual {v1, v12}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v5

    add-int/lit8 v12, v12, 0x1

    invoke-virtual {v1, v12}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v8

    .line 462
    iget-object v9, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    aget-wide v14, v9, v5

    iget-object v9, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    move-object/from16 v20, v4

    move/from16 p6, v5

    aget-wide v4, v9, v8

    move/from16 v21, v8

    sub-long v8, v4, v14

    .line 463
    const-wide/32 v22, 0x17d7840

    cmp-long v22, v8, v22

    if-lez v22, :cond_9

    .line 464
    const-string v0, "reason"

    const-string v2, "sampleGap"

    invoke-interface {v6, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 465
    monitor-exit p0

    return-object v6

    .line 467
    :cond_9
    invoke-static {v2, v3, v14, v15}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v22

    invoke-static {v10, v11, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    .line 468
    sub-long v2, v22, v14

    long-to-double v2, v2

    long-to-double v8, v8

    div-double/2addr v2, v8

    sub-long v14, v4, v14

    long-to-double v14, v14

    div-double/2addr v14, v8

    .line 469
    iget v8, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    mul-int v8, v8, p6

    iget v9, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    mul-int v9, v9, v21

    .line 470
    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    aget v0, v0, v8

    move-wide/from16 v24, v2

    float-to-double v2, v0

    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    add-int/lit8 v21, v8, 0x1

    aget v0, v0, v21

    move-wide/from16 v26, v2

    float-to-double v2, v0

    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    add-int/lit8 v8, v8, 0x2

    aget v0, v0, v8

    move-wide/from16 v28, v2

    float-to-double v2, v0

    .line 471
    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    aget v0, v0, v9

    move-wide/from16 v30, v2

    float-to-double v2, v0

    sub-double v2, v2, v26

    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    add-int/lit8 v8, v9, 0x1

    aget v0, v0, v8

    move-wide/from16 v32, v2

    float-to-double v2, v0

    sub-double v2, v2, v28

    iget-object v0, v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    add-int/lit8 v9, v9, 0x2

    aget v0, v0, v9

    float-to-double v8, v0

    sub-double v8, v8, v30

    .line 472
    sub-long v4, v4, v22

    long-to-double v4, v4

    div-double v21, v4, v17

    mul-double v4, v24, v32

    add-double v4, v26, v4

    mul-double v34, v24, v2

    add-double v34, v28, v34

    mul-double v23, v24, v8

    add-double v23, v30, v23

    mul-double v32, v32, v14

    add-double v25, v26, v32

    mul-double/2addr v2, v14

    add-double v2, v28, v2

    mul-double/2addr v14, v8

    add-double v8, v30, v14

    move-wide/from16 v31, v2

    move-wide/from16 v27, v23

    move-wide/from16 v29, v25

    move-wide/from16 v25, v34

    move-wide/from16 v23, v4

    move-wide/from16 v33, v8

    invoke-virtual/range {v20 .. v34}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->step(DDDDDDD)V

    move-object/from16 v0, v20

    .line 460
    move-wide/from16 v2, p1

    move-object v4, v0

    move/from16 v0, p5

    goto/16 :goto_3

    .line 474
    :cond_a
    move-object v0, v4

    iget-wide v2, v0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->squareSeconds:D

    move-wide/from16 v4, p3

    long-to-double v4, v4

    div-double v4, v4, v17

    div-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    invoke-interface {v6, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 475
    iget-wide v2, v0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->peak:D

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    move-object/from16 v9, v19

    invoke-interface {v6, v9, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 476
    if-eqz p5, :cond_b

    const-string v2, "angularExcursionRad"

    iget-wide v3, v0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->excursion:D

    invoke-static {v3, v4}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-interface {v6, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 477
    :cond_b
    const-string v0, "reason"

    const/4 v2, 0x0

    invoke-interface {v6, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 478
    monitor-exit p0

    .line 479
    return-object v6

    .line 456
    :cond_c
    :goto_4
    monitor-exit p0

    return-object v6

    .line 478
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 445
    :cond_d
    :goto_5
    return-object v6
.end method

.method private static nanos(Ljava/lang/Object;)J
    .locals 2

    .line 916
    instance-of v0, p0, Ljava/lang/String;

    if-eqz v0, :cond_0

    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    goto :goto_0

    :cond_0
    const-wide/16 v0, 0x0

    :goto_0
    return-wide v0
.end method

.method public static normalizeThermalCelsius(DZ)Ljava/lang/Double;
    .locals 2

    .line 327
    if-eqz p2, :cond_0

    const-wide v0, 0x408f400000000000L    # 1000.0

    div-double/2addr p0, v0

    .line 328
    :cond_0
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result p2

    if-eqz p2, :cond_1

    const-wide/high16 v0, -0x3fbc000000000000L    # -40.0

    cmpl-double p2, p0, v0

    if-ltz p2, :cond_1

    const-wide v0, 0x4062c00000000000L    # 150.0

    cmpg-double p2, p0, v0

    if-gtz p2, :cond_1

    invoke-static {p0, p1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    :goto_0
    return-object p0
.end method

.method private static observe(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;JLjava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$Observation;
    .locals 7

    .line 585
    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    if-nez p4, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    invoke-virtual {v1, p1}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    const-wide/32 v4, 0x3b9aca00

    invoke-static {p0, p1, p4}, Lcom/motorola/camera/custom/TelemetryCollector;->streamReason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-wide v2, p2

    invoke-direct/range {v0 .. v6}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;-><init>(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJLjava/lang/String;)V

    return-object v0
.end method

.method public static onCameraActive(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 1

    .line 104
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraActive(Landroid/content/Context;Ljava/lang/String;ZLcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)V

    .line 105
    return-void
.end method

.method public static declared-synchronized onCameraActive(Landroid/content/Context;Ljava/lang/String;ZLcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)V
    .locals 10

    const-class v1, Lcom/motorola/camera/custom/TelemetryCollector;

    monitor-enter v1

    .line 108
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraPaused()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 109
    if-nez p0, :cond_0

    monitor-exit v1

    return-void

    .line 110
    :cond_0
    nop

    .line 113
    :try_start_1
    const-class v0, Landroid/content/Context;

    const-string v2, "getSystemService"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const-class v4, Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 114
    const-string v2, "sensor"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;
    :try_end_1
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 115
    goto :goto_0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    :goto_0
    move-object v8, v0

    .line 116
    :try_start_2
    new-instance v2, Lcom/motorola/camera/custom/TelemetryCollector$Session;

    sget-wide v3, Lcom/motorola/camera/custom/TelemetryCollector;->generation:J

    const-wide/16 v5, 0x1

    add-long/2addr v3, v5

    sput-wide v3, Lcom/motorola/camera/custom/TelemetryCollector;->generation:J

    move-object v5, p0

    move-object v6, p1

    move v7, p2

    move-object v9, p3

    invoke-direct/range {v2 .. v9}, Lcom/motorola/camera/custom/TelemetryCollector$Session;-><init>(JLandroid/content/Context;Ljava/lang/String;ZLandroid/hardware/SensorManager;Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 118
    :try_start_3
    invoke-virtual {v2}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->start()V

    .line 119
    sput-object v2, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 122
    goto :goto_1

    .line 120
    :catch_1
    move-exception v0

    .line 121
    :try_start_4
    invoke-virtual {v2}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 123
    :goto_1
    monitor-exit v1

    return-void

    .line 107
    :catchall_0
    move-exception v0

    move-object p0, v0

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    throw p0
.end method

.method public static declared-synchronized onCameraPaused()V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/TelemetryCollector;

    monitor-enter v0

    .line 126
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    .line 127
    const/4 v2, 0x0

    sput-object v2, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    .line 128
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 129
    :cond_0
    monitor-exit v0

    return-void

    .line 125
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static readDeclinationReflect(FFFJ)Ljava/lang/Double;
    .locals 5

    .line 906
    :try_start_0
    const-string v0, "android.hardware.GeomagneticField"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 907
    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/Class;

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v4, 0x1

    aput-object v2, v1, v4

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v4, 0x2

    aput-object v2, v1, v4

    sget-object v2, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const/4 v4, 0x3

    aput-object v2, v1, v4

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v1

    .line 908
    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    filled-new-array {p0, p1, p2, p3}, [Ljava/lang/Object;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 909
    const-string p1, "getDeclination"

    new-array p2, v3, [Ljava/lang/Class;

    invoke-virtual {v0, p1, p2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    new-array p2, v3, [Ljava/lang/Object;

    invoke-virtual {p1, p0, p2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Number;

    invoke-virtual {p0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 910
    :catchall_0
    move-exception p0

    .line 911
    const/4 p0, 0x0

    return-object p0
.end method

.method private static readLine(Ljava/nio/file/Path;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 348
    sget-object v0, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-static {p0, v0}, Ljava/nio/file/Files;->newBufferedReader(Ljava/nio/file/Path;Ljava/nio/charset/Charset;)Ljava/io/BufferedReader;

    move-result-object p0

    .line 349
    :try_start_0
    invoke-virtual {p0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0

    .line 350
    if-nez v0, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 351
    :goto_0
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/io/BufferedReader;->close()V

    .line 350
    :cond_1
    return-object v0

    .line 348
    :catchall_0
    move-exception v0

    if-eqz p0, :cond_2

    :try_start_1
    invoke-virtual {p0}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    invoke-virtual {v0, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    throw v0
.end method

.method private static readLocationFixReflect(Landroid/content/Context;J)[D
    .locals 24

    .line 856
    move-object/from16 v0, p0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 858
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "checkSelfPermission"

    const/4 v4, 0x1

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/String;

    const/4 v7, 0x0

    aput-object v6, v5, v7

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 859
    const-string v3, "android.permission.ACCESS_COARSE_LOCATION"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 860
    const-string v5, "android.permission.ACCESS_FINE_LOCATION"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v2, v0, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 861
    instance-of v5, v3, Ljava/lang/Integer;

    if-eqz v5, :cond_1

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_0

    :cond_1
    move v3, v7

    .line 862
    :goto_0
    instance-of v5, v2, Ljava/lang/Integer;

    if-eqz v5, :cond_2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-nez v2, :cond_2

    move v2, v4

    goto :goto_1

    :cond_2
    move v2, v7

    .line 863
    :goto_1
    if-nez v3, :cond_3

    if-nez v2, :cond_3

    return-object v1

    .line 864
    :cond_3
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getSystemService"

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/String;

    aput-object v6, v5, v7

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 865
    const-string v3, "location"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 866
    if-nez v2, :cond_4

    return-object v1

    .line 867
    :cond_4
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 868
    const-string v3, "getLastKnownLocation"

    new-array v5, v4, [Ljava/lang/Class;

    const-class v6, Ljava/lang/String;

    aput-object v6, v5, v7

    invoke-virtual {v0, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 869
    nop

    .line 870
    nop

    .line 871
    const/4 v5, 0x3

    new-array v6, v5, [Ljava/lang/String;

    const-string v0, "passive"

    aput-object v0, v6, v7

    const-string v0, "gps"

    aput-object v0, v6, v4

    const-string v0, "network"

    const/4 v8, 0x2

    aput-object v0, v6, v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    const-wide/16 v9, -0x1

    move-object v12, v1

    move v11, v7

    :goto_2
    const-string v0, "getLongitude"

    const-string v13, "getLatitude"

    if-ge v11, v5, :cond_a

    :try_start_1
    aget-object v14, v6, v11
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_5

    .line 873
    :try_start_2
    filled-new-array {v14}, [Ljava/lang/Object;

    move-result-object v14

    invoke-virtual {v3, v2, v14}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    .line 874
    if-nez v14, :cond_5

    move-object/from16 v16, v1

    move/from16 v17, v4

    goto/16 :goto_6

    .line 875
    :cond_5
    invoke-virtual {v14}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v15
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move-object/from16 v16, v1

    :try_start_3
    const-string v1, "getTime"
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move/from16 v17, v4

    :try_start_4
    new-array v4, v7, [Ljava/lang/Class;

    invoke-virtual {v15, v1, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v14, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v18

    .line 876
    invoke-virtual {v14}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    new-array v4, v7, [Ljava/lang/Class;

    invoke-virtual {v1, v13, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v14, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v20

    .line 877
    invoke-virtual {v14}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    new-array v4, v7, [Ljava/lang/Class;

    invoke-virtual {v1, v0, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v1, v7, [Ljava/lang/Object;

    invoke-virtual {v0, v14, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v0

    .line 878
    invoke-static/range {v20 .. v21}, Ljava/lang/Math;->abs(D)D

    move-result-wide v20

    const-wide v22, 0x4056800000000000L    # 90.0

    cmpl-double v4, v20, v22

    if-gtz v4, :cond_9

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    const-wide v20, 0x4066800000000000L    # 180.0

    cmpl-double v0, v0, v20

    if-gtz v0, :cond_9

    const-wide/16 v0, 0x0

    cmp-long v0, v18, v0

    if-lez v0, :cond_9

    cmp-long v0, v18, p1

    if-gtz v0, :cond_9

    sub-long v0, p1, v18

    const-wide/32 v20, 0x36ee80

    cmp-long v0, v0, v20

    if-lez v0, :cond_6

    goto :goto_4

    .line 881
    :cond_6
    if-eqz v12, :cond_7

    cmp-long v0, v18, v9

    if-lez v0, :cond_8

    .line 882
    :cond_7
    nop

    .line 883
    move-object v12, v14

    move-wide/from16 v9, v18

    .line 885
    :cond_8
    :goto_3
    goto :goto_6

    .line 879
    :cond_9
    :goto_4
    goto :goto_6

    .line 885
    :catchall_0
    move-exception v0

    goto :goto_3

    :catchall_1
    move-exception v0

    goto :goto_5

    :catchall_2
    move-exception v0

    move-object/from16 v16, v1

    :goto_5
    move/from16 v17, v4

    goto :goto_3

    .line 871
    :goto_6
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v1, v16

    move/from16 v4, v17

    goto/16 :goto_2

    .line 887
    :cond_a
    move-object/from16 v16, v1

    move/from16 v17, v4

    if-nez v12, :cond_b

    return-object v16

    .line 888
    :cond_b
    :try_start_5
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    new-array v2, v7, [Ljava/lang/Class;

    invoke-virtual {v1, v13, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v7, [Ljava/lang/Object;

    invoke-virtual {v1, v12, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v1

    .line 889
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    new-array v4, v7, [Ljava/lang/Class;

    invoke-virtual {v3, v0, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v3, v7, [Ljava/lang/Object;

    invoke-virtual {v0, v12, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 890
    nop

    .line 892
    const-wide/16 v9, 0x0

    :try_start_6
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v11, "hasAltitude"

    new-array v13, v7, [Ljava/lang/Class;

    invoke-virtual {v6, v11, v13}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    new-array v11, v7, [Ljava/lang/Object;

    invoke-virtual {v6, v12, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 893
    if-eqz v0, :cond_c

    .line 894
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v6, "getAltitude"

    new-array v11, v7, [Ljava/lang/Class;

    invoke-virtual {v0, v6, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v6, v7, [Ljava/lang/Object;

    invoke-virtual {v0, v12, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v11

    .line 895
    invoke-static {v11, v12}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    if-eqz v0, :cond_c

    move-wide v9, v11

    goto :goto_7

    .line 897
    :catchall_3
    move-exception v0

    :cond_c
    :goto_7
    nop

    .line 898
    :try_start_7
    new-array v0, v5, [D

    aput-wide v1, v0, v7

    aput-wide v3, v0, v17

    aput-wide v9, v0, v8
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    return-object v0

    .line 899
    :catchall_4
    move-exception v0

    goto :goto_8

    :catchall_5
    move-exception v0

    move-object/from16 v16, v1

    .line 900
    :goto_8
    return-object v16
.end method

.method private static readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;
    .locals 11

    .line 493
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->RESULT_KEYS:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/CaptureResult$Key;

    .line 494
    const/4 v1, 0x0

    if-eqz p0, :cond_a

    if-nez v0, :cond_0

    goto/16 :goto_4

    .line 496
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object p0

    .line 497
    instance-of v0, p0, Landroid/hardware/camera2/params/RggbChannelVector;

    const/4 v2, 0x3

    const/4 v3, 0x2

    const/4 v4, 0x4

    const/4 v5, 0x1

    const/4 v6, 0x0

    if-eqz v0, :cond_1

    .line 498
    check-cast p0, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 499
    invoke-virtual {p0}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result p1

    invoke-virtual {p0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v0

    invoke-virtual {p0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v7

    invoke-virtual {p0}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result p0

    new-array v4, v4, [F

    aput p1, v4, v6

    aput v0, v4, v5

    aput v7, v4, v3

    aput p0, v4, v2

    invoke-static {v4}, Lcom/motorola/camera/custom/TelemetryCollector;->finiteArray([F)[F

    move-result-object p0

    return-object p0

    .line 501
    :cond_1
    instance-of v0, p0, Landroid/hardware/camera2/params/ColorSpaceTransform;

    if-eqz v0, :cond_4

    .line 502
    const/16 p1, 0x9

    new-array v0, p1, [Landroid/util/Rational;

    .line 503
    check-cast p0, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-virtual {p0, v0, v6}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 504
    new-array p0, p1, [F

    .line 505
    nop

    :goto_0
    if-ge v6, p1, :cond_3

    .line 506
    aget-object v2, v0, v6

    if-nez v2, :cond_2

    return-object v1

    .line 507
    :cond_2
    aget-object v2, v0, v6

    invoke-virtual {v2}, Landroid/util/Rational;->floatValue()F

    move-result v2

    aput v2, p0, v6

    .line 505
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 509
    :cond_3
    invoke-static {p0}, Lcom/motorola/camera/custom/TelemetryCollector;->finiteArray([F)[F

    move-result-object p0

    return-object p0

    .line 511
    :cond_4
    instance-of v0, p0, Ljava/lang/Number;

    if-nez v0, :cond_5

    return-object v1

    .line 512
    :cond_5
    move-object v0, p0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v7

    .line 513
    invoke-static {v7, v8}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_9

    const-wide/16 v9, 0x0

    cmpg-double v0, v7, v9

    if-gez v0, :cond_6

    goto :goto_3

    .line 514
    :cond_6
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    :cond_7
    goto :goto_1

    :sswitch_0
    const-string v0, "LENS_FOCAL_LENGTH"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    goto :goto_2

    :sswitch_1
    const-string v0, "SENSOR_SENSITIVITY"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    move v2, v3

    goto :goto_2

    :sswitch_2
    const-string v0, "SENSOR_FRAME_DURATION"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    move v2, v5

    goto :goto_2

    :sswitch_3
    const-string v0, "LENS_APERTURE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    move v2, v4

    goto :goto_2

    :sswitch_4
    const-string v0, "SENSOR_EXPOSURE_TIME"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_7

    move v2, v6

    goto :goto_2

    :goto_1
    const/4 v2, -0x1

    :goto_2
    packed-switch v2, :pswitch_data_0

    .line 522
    return-object p0

    .line 520
    :pswitch_0
    cmpl-double p1, v7, v9

    if-lez p1, :cond_8

    move-object v1, p0

    :cond_8
    return-object v1

    .line 513
    :cond_9
    :goto_3
    return-object v1

    .line 524
    :catch_0
    move-exception p0

    return-object v1

    .line 494
    :cond_a
    :goto_4
    return-object v1

    nop

    :sswitch_data_0
    .sparse-switch
        -0x612550c0 -> :sswitch_4
        -0x24ccde4f -> :sswitch_3
        -0x1e65a095 -> :sswitch_2
        -0x14086e86 -> :sswitch_1
        0x7cca87c1 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static readThermalZones(Ljava/nio/file/Path;)[F
    .locals 6

    .line 332
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [F

    .line 333
    const/high16 v1, 0x7fc00000    # Float.NaN

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([FF)V

    .line 334
    :try_start_0
    const-string v1, "thermal_zone*"

    invoke-static {p0, v1}, Ljava/nio/file/Files;->newDirectoryStream(Ljava/nio/file/Path;Ljava/lang/String;)Ljava/nio/file/DirectoryStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 335
    :try_start_1
    invoke-interface {p0}, Ljava/nio/file/DirectoryStream;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/nio/file/Path;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 337
    :try_start_2
    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector;->ZONES:[Ljava/lang/String;

    invoke-static {v3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    const-string v4, "type"

    invoke-interface {v2, v4}, Ljava/nio/file/Path;->resolve(Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v4

    invoke-static {v4}, Lcom/motorola/camera/custom/TelemetryCollector;->readLine(Ljava/nio/file/Path;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v3

    .line 338
    if-gez v3, :cond_0

    goto :goto_0

    .line 339
    :cond_0
    const-string v4, "temp"

    invoke-interface {v2, v4}, Ljava/nio/file/Path;->resolve(Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/TelemetryCollector;->readLine(Ljava/nio/file/Path;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    const/4 v2, 0x1

    invoke-static {v4, v5, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->normalizeThermalCelsius(DZ)Ljava/lang/Double;

    move-result-object v2

    .line 340
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/Double;->floatValue()F

    move-result v2

    aput v2, v0, v3
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 341
    :catch_0
    move-exception v2

    :cond_1
    :goto_1
    nop

    .line 342
    goto :goto_0

    .line 343
    :cond_2
    if-eqz p0, :cond_4

    :try_start_3
    invoke-interface {p0}, Ljava/nio/file/DirectoryStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    .line 334
    :catchall_0
    move-exception v1

    if-eqz p0, :cond_3

    :try_start_4
    invoke-interface {p0}, Ljava/nio/file/DirectoryStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception p0

    :try_start_5
    invoke-virtual {v1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_3
    :goto_2
    throw v1
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_1

    .line 343
    :catch_1
    move-exception p0

    .line 344
    :cond_4
    :goto_3
    return-object v0
.end method

.method private static reason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;J)Ljava/lang/String;
    .locals 4

    .line 538
    if-eqz p0, :cond_3

    if-eqz p1, :cond_3

    invoke-static {p1}, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->-$$Nest$fgetgeneration(Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)J

    move-result-wide v0

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->id:J

    cmp-long p0, v0, v2

    if-eqz p0, :cond_0

    goto :goto_1

    .line 539
    :cond_0
    iget-boolean p0, p1, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->realtimeClock:Z

    if-nez p0, :cond_1

    const-string p0, "clockUnverified"

    return-object p0

    .line 540
    :cond_1
    const-wide/16 p0, 0x0

    cmp-long p0, p2, p0

    if-gtz p0, :cond_2

    const-string p0, "missingTimestamp"

    goto :goto_0

    :cond_2
    const/4 p0, 0x0

    :goto_0
    return-object p0

    .line 538
    :cond_3
    :goto_1
    const-string p0, "sessionUnavailable"

    return-object p0
.end method

.method private static resultKeys()Ljava/util/Map;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Landroid/hardware/camera2/CaptureResult$Key<",
            "*>;>;"
        }
    .end annotation

    .line 483
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 484
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector;->KEYS:[Ljava/lang/String;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-object v4, v1, v3

    .line 486
    :try_start_0
    const-class v5, Landroid/hardware/camera2/CaptureResult;

    invoke-virtual {v5, v4}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/hardware/camera2/CaptureResult$Key;

    invoke-interface {v0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 487
    :catch_0
    move-exception v4

    :goto_1
    nop

    .line 484
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 489
    :cond_0
    return-object v0
.end method

.method public static sampleCompass(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
    .locals 2

    .line 738
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {p0, p1, v0, v1}, Lcom/motorola/camera/custom/TelemetryCollector;->sampleCompassAt(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;J)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object p0

    return-object p0
.end method

.method static sampleCompassAt(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;J)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
    .locals 31

    .line 742
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-wide/from16 v4, p2

    .line 743
    const-string v2, "SENSOR_EXPOSURE_TIME"

    invoke-static {v0, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 744
    const-string v3, "SENSOR_SENSITIVITY"

    invoke-static {v0, v3}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 745
    const-string v6, "LENS_APERTURE"

    invoke-static {v0, v6}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    .line 746
    instance-of v7, v2, Ljava/lang/Long;

    const/4 v8, 0x0

    if-eqz v7, :cond_0

    instance-of v7, v3, Ljava/lang/Integer;

    if-eqz v7, :cond_0

    instance-of v7, v6, Ljava/lang/Number;

    if-eqz v7, :cond_0

    .line 747
    check-cast v2, Ljava/lang/Long;

    .line 748
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v2

    check-cast v6, Ljava/lang/Number;

    invoke-virtual {v6}, Ljava/lang/Number;->floatValue()F

    move-result v3

    .line 747
    invoke-static {v9, v10, v2, v3}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeEv100(JIF)D

    move-result-wide v2

    .line 749
    invoke-static {v2, v3}, Ljava/lang/Double;->isFinite(D)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    goto :goto_0

    .line 751
    :cond_0
    move-object v2, v8

    :goto_0
    if-nez v2, :cond_1

    move-object/from16 v20, v8

    goto :goto_1

    :cond_1
    invoke-virtual {v2}, Ljava/lang/Double;->floatValue()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    move-object/from16 v20, v3

    .line 752
    :goto_1
    if-nez v2, :cond_2

    const-wide/high16 v2, 0x7ff8000000000000L    # Double.NaN

    goto :goto_2

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v2

    :goto_2
    move-wide v9, v2

    .line 754
    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    .line 755
    const-string v3, "SENSOR_TIMESTAMP"

    invoke-static {v0, v3}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    instance-of v3, v3, Ljava/lang/Long;

    if-eqz v3, :cond_3

    .line 756
    const-string v3, "SENSOR_TIMESTAMP"

    invoke-static {v0, v3}, Lcom/motorola/camera/custom/TelemetryCollector;->readTag(Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    :cond_3
    move-object v0, v8

    .line 755
    :goto_3
    invoke-static {v0}, Lcom/motorola/camera/custom/TelemetryCollector;->nanos(Ljava/lang/Object;)J

    move-result-wide v13

    .line 757
    invoke-static {v2, v1, v13, v14}, Lcom/motorola/camera/custom/TelemetryCollector;->reason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;J)Ljava/lang/String;

    move-result-object v0

    .line 758
    if-nez v0, :cond_4

    .line 759
    new-instance v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    iget-object v3, v2, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    sget-object v6, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v3, v6}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    move-object v12, v3

    check-cast v12, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {v2, v3, v8}, Lcom/motorola/camera/custom/TelemetryCollector;->streamReason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    const-wide/32 v15, 0x77359400

    invoke-direct/range {v11 .. v17}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;-><init>(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJLjava/lang/String;)V

    goto :goto_4

    .line 760
    :cond_4
    new-instance v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;

    const/4 v12, 0x0

    const-wide/32 v15, 0x77359400

    move-object/from16 v17, v0

    invoke-direct/range {v11 .. v17}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;-><init>(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJLjava/lang/String;)V

    .line 761
    :goto_4
    iget-object v3, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    if-nez v3, :cond_8

    if-eqz v2, :cond_8

    if-eqz v0, :cond_8

    const-string v3, "sessionUnavailable"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 762
    if-nez v1, :cond_5

    move-object v3, v8

    const/16 p0, 0x1

    const/16 v18, 0x0

    goto :goto_6

    :cond_5
    invoke-static {v1}, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->-$$Nest$fgetgeneration(Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)J

    move-result-wide v15

    invoke-static/range {v15 .. v16}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v15

    const/16 p0, 0x1

    const/16 v18, 0x0

    iget-wide v6, v2, Lcom/motorola/camera/custom/TelemetryCollector$Session;->id:J

    cmp-long v3, v15, v6

    if-eqz v3, :cond_6

    move/from16 v3, p0

    goto :goto_5

    :cond_6
    move/from16 v3, v18

    :goto_5
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    :goto_6
    invoke-virtual {v0, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    .line 763
    iget-object v0, v2, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v0, v3}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    .line 764
    monitor-enter v3

    .line 765
    :try_start_0
    iget v0, v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-lez v0, :cond_7

    .line 766
    iget v0, v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v3, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v0

    .line 767
    iget v6, v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    mul-int/2addr v6, v0

    .line 768
    iget-object v7, v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    iget-object v12, v3, Lcom/motorola/camera/custom/TelemetryCollector$Series;->sizes:[I

    aget v0, v12, v0

    add-int/2addr v0, v6

    invoke-static {v7, v6, v0}, Ljava/util/Arrays;->copyOfRange([FII)[F

    move-result-object v0

    iput-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    .line 769
    iput-object v8, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    .line 771
    :cond_7
    monitor-exit v3

    goto :goto_7

    :catchall_0
    move-exception v0

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 761
    :cond_8
    const/16 p0, 0x1

    const/16 v18, 0x0

    .line 773
    :cond_9
    :goto_7
    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    if-eqz v0, :cond_16

    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    array-length v0, v0

    const/4 v3, 0x4

    if-ge v0, v3, :cond_a

    goto/16 :goto_11

    .line 779
    :cond_a
    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    array-length v0, v0

    const/4 v6, 0x5

    if-lt v0, v6, :cond_b

    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v0, v0, v3

    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_b

    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v0, v0, v3

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    move v15, v0

    goto :goto_8

    :cond_b
    move/from16 v15, v18

    .line 780
    :goto_8
    if-eqz v1, :cond_c

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v1, v1, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->isFront:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    move-wide/from16 v16, v13

    move/from16 v14, p0

    goto :goto_9

    :cond_c
    move-wide/from16 v16, v13

    move/from16 v14, v18

    .line 781
    :goto_9
    iget-object v11, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    const/4 v12, 0x4

    const/4 v13, 0x0

    invoke-static/range {v11 .. v17}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeOrientation([FIIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    move-result-object v6

    .line 783
    if-eqz v6, :cond_15

    iget v0, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-nez v0, :cond_d

    goto/16 :goto_10

    .line 788
    :cond_d
    iget v0, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    .line 789
    nop

    .line 790
    nop

    .line 791
    nop

    .line 792
    nop

    .line 793
    nop

    .line 794
    nop

    .line 795
    const/4 v11, 0x2

    if-ge v15, v11, :cond_e

    const-string v0, "uncalibrated"

    goto :goto_a

    :cond_e
    const-string v0, "ok"

    :goto_a
    move-object/from16 v22, v0

    .line 796
    nop

    .line 798
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->isSaveLocationAllowed()Z

    move-result v0

    if-eqz v0, :cond_f

    iget-object v0, v2, Lcom/motorola/camera/custom/TelemetryCollector$Session;->appContext:Landroid/content/Context;

    invoke-static {v0, v4, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->readLocationFixReflect(Landroid/content/Context;J)[D

    move-result-object v0

    move-object v12, v0

    goto :goto_b

    :cond_f
    move-object v12, v8

    .line 799
    :goto_b
    if-eqz v12, :cond_12

    .line 800
    aget-wide v0, v12, v18

    aget-wide v2, v12, p0

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeSolarPosition(DDJ)Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    move-result-object v0

    .line 801
    iget-wide v1, v0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->azimuthDeg:D

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    .line 802
    iget-wide v2, v0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    invoke-static {v2, v3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v2

    .line 803
    aget-wide v13, v12, v18

    double-to-float v3, v13

    aget-wide v13, v12, p0

    double-to-float v13, v13

    aget-wide v11, v12, v11

    double-to-float v11, v11

    invoke-static {v3, v13, v11, v4, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->readDeclinationReflect(FFFJ)Ljava/lang/Double;

    move-result-object v3

    .line 804
    iget v4, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v4, v4

    .line 805
    if-eqz v3, :cond_11

    invoke-virtual {v3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v11

    invoke-static {v11, v12}, Ljava/lang/Double;->isFinite(D)Z

    move-result v11

    if-eqz v11, :cond_11

    .line 806
    invoke-virtual {v3}, Ljava/lang/Double;->floatValue()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    .line 807
    iget v5, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v11, v5

    invoke-virtual {v3}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v13

    add-double/2addr v11, v13

    const-wide v13, 0x4076800000000000L    # 360.0

    rem-double/2addr v11, v13

    .line 808
    const-wide/16 v16, 0x0

    cmpg-double v3, v11, v16

    if-gez v3, :cond_10

    add-double/2addr v11, v13

    .line 809
    :cond_10
    double-to-float v3, v11

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    .line 810
    move-wide/from16 v23, v11

    goto :goto_c

    .line 812
    :cond_11
    move-wide/from16 v23, v4

    move-object v3, v8

    move-object v4, v3

    :goto_c
    iget v5, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    float-to-double v11, v5

    iget-wide v13, v0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->azimuthDeg:D

    move-wide/from16 v16, v9

    iget-wide v8, v0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    move-wide/from16 v29, v8

    move-wide/from16 v25, v11

    move-wide/from16 v27, v13

    invoke-static/range {v23 .. v30}, Lcom/motorola/camera/custom/CompassSolarHelper;->angularSeparationDeg(DDDD)D

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v8

    .line 814
    iget-wide v11, v0, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    invoke-virtual {v8}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v13

    move-wide/from16 v9, v16

    invoke-static/range {v9 .. v15}, Lcom/motorola/camera/custom/CompassSolarHelper;->isPhysicalOutdoorBacklit(DDDI)Z

    move-result v0

    .line 815
    move/from16 v21, v0

    move-object/from16 v17, v1

    move-object/from16 v18, v2

    move-object v11, v3

    move-object/from16 v19, v8

    const/16 v23, 0x0

    move-object v8, v4

    goto :goto_e

    .line 816
    :cond_12
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->isSaveLocationAllowed()Z

    move-result v0

    if-eqz v0, :cond_13

    const-string v0, "locationUnavailable"

    goto :goto_d

    :cond_13
    const-string v0, "locationSettingOff"

    :goto_d
    move-object/from16 v23, v0

    move/from16 v21, v18

    const/4 v8, 0x0

    const/4 v11, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    .line 818
    :goto_e
    if-eqz v11, :cond_14

    move-object v0, v11

    goto :goto_f

    :cond_14
    move-object v0, v7

    :goto_f
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    float-to-double v0, v0

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassSolarHelper;->formatCardinal(D)Ljava/lang/String;

    move-result-object v16

    .line 819
    new-instance v9, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    iget v0, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v12

    iget v0, v6, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->rollDeg:F

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v13

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    move-object v10, v7

    move-object v15, v8

    invoke-direct/range {v9 .. v23}, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;-><init>(Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Integer;Ljava/lang/Float;Ljava/lang/String;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Float;ZLjava/lang/String;Ljava/lang/String;)V

    return-object v9

    .line 784
    :cond_15
    :goto_10
    new-instance v9, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    const-string v22, "invalidOrientation"

    const-string v23, "invalidOrientation"

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    const/16 v21, 0x0

    invoke-direct/range {v9 .. v23}, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;-><init>(Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Integer;Ljava/lang/Float;Ljava/lang/String;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Float;ZLjava/lang/String;Ljava/lang/String;)V

    return-object v9

    .line 774
    :cond_16
    :goto_11
    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    if-eqz v0, :cond_17

    iget-object v0, v11, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    goto :goto_12

    :cond_17
    const-string v0, "noSample"

    :goto_12
    move-object/from16 v22, v0

    .line 775
    new-instance v9, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    const/16 v19, 0x0

    const/16 v21, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    move-object/from16 v23, v22

    invoke-direct/range {v9 .. v23}, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;-><init>(Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Integer;Ljava/lang/Float;Ljava/lang/String;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Double;Ljava/lang/Float;ZLjava/lang/String;Ljava/lang/String;)V

    return-object v9
.end method

.method public static shotMetadata(Ljava/lang/String;Ljava/lang/Float;Z)Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;
    .locals 6

    .line 100
    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;

    sget-object v4, Lcom/motorola/camera/custom/TelemetryCollector;->active:Lcom/motorola/camera/custom/TelemetryCollector$Session;

    const/4 v5, 0x0

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    invoke-direct/range {v0 .. v5}, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;-><init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector-IA;)V

    return-object v0
.end method

.method private static spectrum(Lcom/motorola/camera/custom/TelemetryCollector$Observation;Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)Ljava/util/Map;
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/motorola/camera/custom/TelemetryCollector$Observation;",
            "Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 589
    move-object/from16 v0, p0

    invoke-virtual {v0}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->json()Ljava/util/Map;

    move-result-object v1

    .line 590
    const/4 v2, 0x5

    new-array v3, v2, [Ljava/lang/String;

    const-string v4, "redCounts"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-string v4, "greenCounts"

    const/4 v6, 0x1

    aput-object v4, v3, v6

    const-string v4, "blueCounts"

    const/4 v7, 0x2

    aput-object v4, v3, v7

    const/4 v4, 0x3

    const-string v8, "clearCounts"

    aput-object v8, v3, v4

    const/4 v4, 0x4

    const-string v8, "widebandCounts"

    aput-object v8, v3, v4

    .line 591
    new-array v4, v2, [Ljava/lang/Float;

    .line 592
    move v8, v5

    :goto_0
    const/4 v9, 0x0

    if-ge v8, v2, :cond_1

    .line 593
    if-nez p1, :cond_0

    goto :goto_1

    :cond_0
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->-$$Nest$fgetchannels(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[I

    move-result-object v9

    aget v9, v9, v8

    invoke-virtual {v0, v9}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->channel(I)Ljava/lang/Float;

    move-result-object v9

    :goto_1
    aput-object v9, v4, v8

    .line 594
    aget-object v9, v3, v8

    aget-object v10, v4, v8

    invoke-interface {v1, v9, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 592
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 596
    :cond_1
    iget-object v3, v0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    const-string v8, "reason"

    if-eqz v3, :cond_2

    if-nez p1, :cond_2

    const-string v3, "unverifiedLayout"

    invoke-interface {v1, v8, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 597
    :cond_2
    nop

    .line 598
    aget-object v3, v4, v5

    if-eqz v3, :cond_3

    aget-object v3, v4, v6

    if-eqz v3, :cond_3

    aget-object v3, v4, v7

    if-eqz v3, :cond_3

    .line 599
    aget-object v3, v4, v5

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    float-to-double v10, v3

    aget-object v3, v4, v6

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    float-to-double v12, v3

    aget-object v3, v4, v7

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    float-to-double v14, v3

    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->-$$Nest$fgetxyzMatrix(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[D

    move-result-object v16

    invoke-static/range {v10 .. v16}, Lcom/motorola/camera/custom/TelemetryCollector;->estimateCctKelvin(DDD[D)Ljava/lang/Double;

    move-result-object v3

    goto :goto_2

    .line 601
    :cond_3
    move-object v3, v9

    :goto_2
    const-string v4, "cctK"

    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 602
    invoke-interface {v1, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 603
    if-nez v3, :cond_5

    if-nez v4, :cond_5

    .line 604
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->-$$Nest$fgetxyzMatrix(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[D

    move-result-object v3

    if-nez v3, :cond_4

    const-string v3, "uncalibrated"

    goto :goto_3

    :cond_4
    const-string v3, "invalidChromaticity"

    :goto_3
    move-object v4, v3

    .line 606
    :cond_5
    const-string v3, "cctReason"

    invoke-interface {v1, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 607
    if-nez p1, :cond_6

    move-object v0, v9

    goto :goto_4

    :cond_6
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->-$$Nest$fgetchannels(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[I

    move-result-object v3

    aget v2, v3, v2

    invoke-virtual {v0, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->channel(I)Ljava/lang/Float;

    move-result-object v0

    .line 608
    :goto_4
    nop

    .line 609
    const/high16 v2, 0x42c80000    # 100.0f

    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    const/high16 v4, 0x42480000    # 50.0f

    cmpl-float v3, v3, v4

    if-eqz v3, :cond_7

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    cmpl-float v3, v3, v2

    if-nez v3, :cond_8

    :cond_7
    const/16 v3, 0x32

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_5

    .line 610
    :cond_8
    move-object v3, v9

    :goto_5
    const/high16 v4, 0x42f00000    # 120.0f

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v5

    const/high16 v6, 0x42700000    # 60.0f

    cmpl-float v5, v5, v6

    if-eqz v5, :cond_9

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v5

    cmpl-float v5, v5, v4

    if-nez v5, :cond_a

    :cond_9
    const/16 v3, 0x3c

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 611
    :cond_a
    const-string v5, "reportedFlickerHz"

    invoke-interface {v1, v5, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 612
    const-string v5, "mainsClassHz"

    invoke-interface {v1, v5, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 613
    if-nez v3, :cond_b

    move-object v3, v9

    goto :goto_6

    :cond_b
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    mul-int/2addr v3, v7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    :goto_6
    const-string v5, "nominalOpticalHz"

    invoke-interface {v1, v5, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 615
    if-eqz v0, :cond_d

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    cmpl-float v2, v3, v2

    if-eqz v2, :cond_c

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v2

    cmpl-float v2, v2, v4

    if-nez v2, :cond_d

    :cond_c
    move-object v9, v0

    :cond_d
    const-string v0, "opticalFlickerHz"

    invoke-interface {v1, v0, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 616
    return-object v1
.end method

.method private static streamReason(Lcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector$Stream;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 544
    if-eqz p2, :cond_0

    return-object p2

    .line 545
    :cond_0
    iget-object p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    invoke-virtual {p0, p1}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    return-object p0
.end method

.method private static validTriplet([F)Z
    .locals 3

    .line 370
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    array-length v1, p0

    const/4 v2, 0x3

    if-lt v1, v2, :cond_0

    aget v1, p0, v0

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    aget v2, p0, v1

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x2

    aget p0, p0, v2

    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result p0

    if-eqz p0, :cond_0

    move v0, v1

    :cond_0
    return v0
.end method

.method private static vendorStream(Landroid/hardware/Sensor;)Lcom/motorola/camera/custom/TelemetryCollector$Stream;
    .locals 3

    .line 271
    invoke-virtual {p0}, Landroid/hardware/Sensor;->getStringType()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 272
    invoke-virtual {p0}, Landroid/hardware/Sensor;->getName()Ljava/lang/String;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p0

    const/16 v1, 0x5f

    const/16 v2, 0x20

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    .line 273
    const-string v1, "com.motorola.sensor.tof"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object p0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-object p0

    .line 274
    :cond_0
    const-string v0, "front"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    return-object v1

    .line 275
    :cond_1
    const-string v0, "tcs3408"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "alternate"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "rear"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    :goto_0
    const/4 v0, 0x1

    .line 276
    :goto_1
    if-nez v0, :cond_4

    return-object v1

    .line 277
    :cond_4
    const-string v0, "rgb"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_5

    sget-object p0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-object p0

    .line 278
    :cond_5
    const-string v0, "light"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_7

    const-string v0, "als"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_6

    goto :goto_2

    .line 279
    :cond_6
    return-object v1

    .line 278
    :cond_7
    :goto_2
    sget-object p0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-object p0
.end method

.method public static writeSidecarJsonIfEnabled(Ljava/io/File;Ljava/lang/String;)Z
    .locals 6

    .line 933
    const/4 v0, 0x0

    if-eqz p0, :cond_6

    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_6

    .line 934
    :cond_0
    nop

    .line 936
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object p0

    invoke-interface {p0}, Ljava/nio/file/Path;->toAbsolutePath()Ljava/nio/file/Path;

    move-result-object p0

    .line 937
    invoke-interface {p0}, Ljava/nio/file/Path;->getParent()Ljava/nio/file/Path;

    move-result-object v2

    const-string v3, ".telemetry-"

    const-string v4, ".tmp"

    new-array v5, v0, [Ljava/nio/file/attribute/FileAttribute;

    invoke-static {v2, v3, v4, v5}, Ljava/nio/file/Files;->createTempFile(Ljava/nio/file/Path;Ljava/lang/String;Ljava/lang/String;[Ljava/nio/file/attribute/FileAttribute;)Ljava/nio/file/Path;

    move-result-object v1

    .line 938
    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    new-array v2, v0, [Ljava/nio/file/OpenOption;

    invoke-static {v1, p1, v2}, Ljava/nio/file/Files;->write(Ljava/nio/file/Path;[B[Ljava/nio/file/OpenOption;)Ljava/nio/file/Path;

    .line 939
    sget-object p1, Lcom/motorola/camera/custom/TelemetryCollector;->SIDECAR_MOVE_LOCK:Ljava/lang/Object;

    monitor-enter p1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 941
    const/4 v2, 0x2

    const/4 v3, 0x1

    :try_start_1
    new-array v2, v2, [Ljava/nio/file/CopyOption;

    sget-object v4, Ljava/nio/file/StandardCopyOption;->ATOMIC_MOVE:Ljava/nio/file/StandardCopyOption;

    aput-object v4, v2, v0

    sget-object v4, Ljava/nio/file/StandardCopyOption;->REPLACE_EXISTING:Ljava/nio/file/StandardCopyOption;

    aput-object v4, v2, v3

    invoke-static {v1, p0, v2}, Ljava/nio/file/Files;->move(Ljava/nio/file/Path;Ljava/nio/file/Path;[Ljava/nio/file/CopyOption;)Ljava/nio/file/Path;
    :try_end_1
    .catch Ljava/nio/file/AtomicMoveNotSupportedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 945
    goto :goto_1

    .line 946
    :catchall_0
    move-exception p0

    goto :goto_3

    .line 942
    :catch_0
    move-exception v2

    .line 944
    :try_start_2
    invoke-interface {v1}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object v2

    invoke-interface {p0}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p0

    if-nez p0, :cond_2

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 951
    if-eqz v1, :cond_1

    .line 952
    :try_start_3
    invoke-static {v1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :catch_1
    move-exception p0

    .line 944
    :cond_1
    :goto_0
    return v0

    .line 946
    :cond_2
    :goto_1
    :try_start_4
    monitor-exit p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 947
    nop

    .line 951
    if-eqz v1, :cond_3

    .line 952
    :try_start_5
    invoke-static {v1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_2

    :catch_2
    move-exception p0

    .line 947
    :cond_3
    :goto_2
    return v3

    .line 946
    :goto_3
    :try_start_6
    monitor-exit p1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    throw p0
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 951
    :catchall_1
    move-exception p0

    if-eqz v1, :cond_4

    .line 952
    :try_start_8
    invoke-static {v1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/lang/SecurityException; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_4

    :catch_3
    move-exception p1

    .line 954
    :cond_4
    :goto_4
    throw p0

    .line 948
    :catch_4
    move-exception p0

    .line 949
    nop

    .line 951
    if-eqz v1, :cond_5

    .line 952
    :try_start_9
    invoke-static {v1}, Ljava/nio/file/Files;->deleteIfExists(Ljava/nio/file/Path;)Z
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5
    .catch Ljava/lang/SecurityException; {:try_start_9 .. :try_end_9} :catch_5

    goto :goto_5

    :catch_5
    move-exception p0

    .line 949
    :cond_5
    :goto_5
    return v0

    .line 933
    :cond_6
    :goto_6
    return v0
.end method
