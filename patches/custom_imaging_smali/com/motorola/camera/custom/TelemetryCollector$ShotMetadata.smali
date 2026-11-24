.class public final Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ShotMetadata"
.end annotation


# instance fields
.field public final cameraId:Ljava/lang/String;

.field private final generation:J

.field public final iqLuxIdx:Ljava/lang/Float;

.field public final isFront:Ljava/lang/Boolean;

.field public final realtimeClock:Z

.field public final shotId:Ljava/lang/String;


# direct methods
.method static bridge synthetic -$$Nest$fgetgeneration(Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)J
    .locals 2

    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->generation:J

    return-wide v0
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;)V
    .locals 0

    .line 89
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->shotId:Ljava/lang/String;

    .line 91
    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    .line 92
    iput-boolean p3, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->realtimeClock:Z

    .line 93
    const/4 p1, 0x0

    if-nez p4, :cond_0

    move-object p2, p1

    goto :goto_0

    :cond_0
    iget-object p2, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->cameraId:Ljava/lang/String;

    :goto_0
    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->cameraId:Ljava/lang/String;

    .line 94
    if-nez p4, :cond_1

    goto :goto_1

    :cond_1
    iget-boolean p1, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->front:Z

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    :goto_1
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->isFront:Ljava/lang/Boolean;

    .line 95
    if-nez p4, :cond_2

    const-wide/16 p1, 0x0

    goto :goto_2

    :cond_2
    iget-wide p1, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->id:J

    :goto_2
    iput-wide p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->generation:J

    .line 96
    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;Lcom/motorola/camera/custom/TelemetryCollector-IA;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;-><init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;)V

    return-void
.end method
