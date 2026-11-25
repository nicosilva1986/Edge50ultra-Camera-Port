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
.field public final aeFps:Ljava/lang/Integer;

.field public final cameraId:Ljava/lang/String;

.field public final depthSource:Ljava/lang/String;

.field public final focusSpreadD:Ljava/lang/Float;

.field public final gapMs:Ljava/lang/Float;

.field private final generation:J

.field public final iqLuxIdx:Ljava/lang/Float;

.field public final isFront:Ljava/lang/Boolean;

.field public final mergeCount:Ljava/lang/Integer;

.field public final motionRejected:Ljava/lang/Boolean;

.field public final oisMode:Ljava/lang/Integer;

.field public final realtimeClock:Z

.field public final shotId:Ljava/lang/String;


# direct methods
.method static bridge synthetic -$$Nest$fgetgeneration(Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)J
    .locals 2

    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->generation:J

    return-wide v0
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Boolean;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 0

    .line 113
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 114
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->shotId:Ljava/lang/String;

    .line 115
    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->iqLuxIdx:Ljava/lang/Float;

    .line 116
    iput-boolean p3, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->realtimeClock:Z

    .line 117
    const/4 p1, 0x0

    if-nez p4, :cond_0

    move-object p2, p1

    goto :goto_0

    :cond_0
    iget-object p2, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->cameraId:Ljava/lang/String;

    :goto_0
    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->cameraId:Ljava/lang/String;

    .line 118
    if-nez p4, :cond_1

    goto :goto_1

    :cond_1
    iget-boolean p1, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->front:Z

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    :goto_1
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->isFront:Ljava/lang/Boolean;

    .line 119
    if-nez p4, :cond_2

    const-wide/16 p1, 0x0

    goto :goto_2

    :cond_2
    iget-wide p1, p4, Lcom/motorola/camera/custom/TelemetryCollector$Session;->id:J

    :goto_2
    iput-wide p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->generation:J

    .line 120
    iput-object p5, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->gapMs:Ljava/lang/Float;

    .line 121
    iput-object p6, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->focusSpreadD:Ljava/lang/Float;

    .line 122
    iput-object p7, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->motionRejected:Ljava/lang/Boolean;

    .line 123
    iput-object p8, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->aeFps:Ljava/lang/Integer;

    .line 124
    iput-object p9, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->oisMode:Ljava/lang/Integer;

    .line 125
    iput-object p10, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->mergeCount:Ljava/lang/Integer;

    .line 126
    iput-object p11, p0, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;->depthSource:Ljava/lang/String;

    .line 127
    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Boolean;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector-IA;)V
    .locals 0

    invoke-direct/range {p0 .. p11}, Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;-><init>(Ljava/lang/String;Ljava/lang/Float;ZLcom/motorola/camera/custom/TelemetryCollector$Session;Ljava/lang/Float;Ljava/lang/Float;Ljava/lang/Boolean;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;)V

    return-void
.end method
