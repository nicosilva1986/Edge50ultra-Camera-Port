.class public final Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "SpectralLayout"
.end annotation


# instance fields
.field private final channels:[I

.field private final driverCctChannel:I

.field private final driverLuxChannel:I

.field private final xyzMatrix:[D


# direct methods
.method static bridge synthetic -$$Nest$fgetchannels(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[I
    .locals 0

    iget-object p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->channels:[I

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetdriverCctChannel(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)I
    .locals 0

    iget p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->driverCctChannel:I

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetdriverLuxChannel(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)I
    .locals 0

    iget p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->driverLuxChannel:I

    return p0
.end method

.method static bridge synthetic -$$Nest$fgetxyzMatrix(Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)[D
    .locals 0

    iget-object p0, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->xyzMatrix:[D

    return-object p0
.end method

.method public constructor <init>(IIIIII[D)V
    .locals 10

    .line 74
    const/4 v8, -0x1

    const/4 v9, -0x1

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    invoke-direct/range {v0 .. v9}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;-><init>(IIIIII[DII)V

    .line 75
    return-void
.end method

.method private constructor <init>(IIIIII[DII)V
    .locals 1

    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    filled-new-array/range {p1 .. p6}, [I

    move-result-object p1

    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->channels:[I

    .line 80
    const/16 p1, 0x10

    new-array p2, p1, [Z

    .line 81
    iget-object p3, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->channels:[I

    array-length p4, p3

    const/4 p5, 0x0

    :goto_0
    if-ge p5, p4, :cond_2

    aget p6, p3, p5

    .line 82
    const/4 v0, -0x1

    if-ne p6, v0, :cond_0

    goto :goto_1

    .line 83
    :cond_0
    if-ltz p6, :cond_1

    if-ge p6, p1, :cond_1

    aget-boolean v0, p2, p6

    if-nez v0, :cond_1

    .line 84
    const/4 v0, 0x1

    aput-boolean v0, p2, p6

    .line 81
    :goto_1
    add-int/lit8 p5, p5, 0x1

    goto :goto_0

    .line 83
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "channel index"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 86
    :cond_2
    if-eqz p7, :cond_4

    array-length p1, p7

    const/16 p2, 0x9

    if-ne p1, p2, :cond_3

    goto :goto_2

    :cond_3
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "XYZ matrix"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 87
    :cond_4
    :goto_2
    if-nez p7, :cond_5

    const/4 p1, 0x0

    goto :goto_3

    :cond_5
    invoke-virtual {p7}, [D->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [D

    :goto_3
    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->xyzMatrix:[D

    .line 88
    iput p8, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->driverCctChannel:I

    .line 89
    iput p9, p0, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;->driverLuxChannel:I

    .line 90
    return-void
.end method

.method synthetic constructor <init>(IIIIII[DIILcom/motorola/camera/custom/TelemetryCollector-IA;)V
    .locals 0

    invoke-direct/range {p0 .. p9}, Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;-><init>(IIIIII[DII)V

    return-void
.end method
