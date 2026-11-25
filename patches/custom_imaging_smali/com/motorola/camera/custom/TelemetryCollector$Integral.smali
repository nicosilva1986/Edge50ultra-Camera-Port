.class final Lcom/motorola/camera/custom/TelemetryCollector$Integral;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Integral"
.end annotation


# instance fields
.field excursion:D

.field peak:D

.field final rotation:Z

.field squareSeconds:D

.field w:D

.field x:D

.field y:D

.field z:D


# direct methods
.method constructor <init>(Z)V
    .locals 2

    .line 401
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 399
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    iput-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    .line 401
    iput-boolean p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->rotation:Z

    return-void
.end method


# virtual methods
.method rotate(DDDD)V
    .locals 14

    .line 404
    mul-double v0, p3, p3

    mul-double v2, p5, p5

    add-double/2addr v0, v2

    mul-double v2, p7, p7

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    .line 405
    const-wide/16 v2, 0x0

    cmpl-double v2, v0, v2

    if-nez v2, :cond_0

    return-void

    .line 406
    :cond_0
    mul-double v2, v0, p1

    const-wide/high16 v4, 0x4000000000000000L    # 2.0

    div-double/2addr v2, v4

    .line 407
    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v6

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    div-double/2addr v2, v0

    .line 408
    mul-double v0, p3, v2

    mul-double v8, p5, v2

    mul-double v2, v2, p7

    .line 409
    iget-wide v10, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    mul-double/2addr v10, v6

    iget-wide v12, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    mul-double/2addr v12, v0

    sub-double/2addr v10, v12

    iget-wide v12, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    mul-double/2addr v12, v8

    sub-double/2addr v10, v12

    iget-wide v12, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    mul-double/2addr v12, v2

    sub-double/2addr v10, v12

    .line 410
    iget-wide v12, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    mul-double/2addr v12, v0

    move-wide p1, v4

    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    mul-double/2addr v4, v6

    add-double/2addr v12, v4

    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    mul-double/2addr v4, v2

    add-double/2addr v12, v4

    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    mul-double/2addr v4, v8

    sub-double/2addr v12, v4

    .line 411
    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    mul-double/2addr v4, v8

    move-wide/from16 p3, v0

    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    mul-double/2addr v0, v2

    sub-double/2addr v4, v0

    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    mul-double/2addr v0, v6

    add-double/2addr v4, v0

    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    mul-double v0, v0, p3

    add-double/2addr v4, v0

    .line 412
    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    mul-double/2addr v0, v2

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    mul-double/2addr v2, v8

    add-double/2addr v0, v2

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    mul-double v2, v2, p3

    sub-double/2addr v0, v2

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    mul-double/2addr v2, v6

    add-double/2addr v0, v2

    .line 413
    mul-double v2, v10, v10

    mul-double v6, v12, v12

    add-double/2addr v2, v6

    mul-double v6, v4, v4

    add-double/2addr v2, v6

    mul-double v6, v0, v0

    add-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    .line 414
    div-double/2addr v10, v2

    iput-wide v10, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    div-double/2addr v12, v2

    iput-wide v12, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    div-double/2addr v4, v2

    iput-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    div-double/2addr v0, v2

    iput-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    .line 415
    iget-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->x:D

    mul-double/2addr v0, v2

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->y:D

    mul-double/2addr v2, v4

    add-double/2addr v0, v2

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->z:D

    mul-double/2addr v2, v4

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->w:D

    invoke-static {v2, v3}, Ljava/lang/Math;->abs(D)D

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v0

    mul-double/2addr v0, p1

    .line 416
    iget-wide v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->excursion:D

    invoke-static {v2, v3, v0, v1}, Ljava/lang/Math;->max(DD)D

    move-result-wide v0

    iput-wide v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->excursion:D

    .line 417
    return-void
.end method

.method step(DDDDDDD)V
    .locals 13

    .line 420
    mul-double v0, p3, p3

    mul-double v2, p5, p5

    add-double/2addr v0, v2

    mul-double v2, p7, p7

    add-double/2addr v0, v2

    mul-double v2, p9, p9

    mul-double v4, p11, p11

    add-double/2addr v2, v4

    mul-double v4, p13, p13

    add-double/2addr v2, v4

    .line 421
    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->peak:D

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v6

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    iput-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->peak:D

    .line 422
    iget-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->squareSeconds:D

    mul-double v6, p3, p9

    add-double/2addr v0, v6

    mul-double v6, p5, p11

    add-double/2addr v0, v6

    mul-double v6, p7, p13

    add-double/2addr v0, v6

    add-double/2addr v0, v2

    mul-double/2addr v0, p1

    const-wide/high16 v2, 0x4008000000000000L    # 3.0

    div-double/2addr v0, v2

    add-double/2addr v4, v0

    iput-wide v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->squareSeconds:D

    .line 423
    iget-boolean v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->rotation:Z

    if-eqz v0, :cond_0

    .line 424
    const-wide/high16 v0, 0x4000000000000000L    # 2.0

    div-double v5, p1, v0

    mul-double p1, p3, v2

    add-double p1, p1, p9

    const-wide/high16 v0, 0x4010000000000000L    # 4.0

    div-double v7, p1, v0

    mul-double p1, p5, v2

    add-double p1, p1, p11

    div-double v9, p1, v0

    mul-double p1, p7, v2

    add-double p1, p1, p13

    div-double v11, p1, v0

    move-object v4, p0

    invoke-virtual/range {v4 .. v12}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->rotate(DDDD)V

    .line 425
    mul-double p1, p9, v2

    add-double p1, p3, p1

    div-double/2addr p1, v0

    mul-double v7, p11, v2

    add-double v7, p5, v7

    div-double/2addr v7, v0

    mul-double v2, v2, p13

    add-double v2, p7, v2

    div-double/2addr v2, v0

    move-wide/from16 p4, p1

    move-wide/from16 p8, v2

    move-wide p2, v5

    move-wide/from16 p6, v7

    move-object p1, p0

    invoke-virtual/range {p1 .. p9}, Lcom/motorola/camera/custom/TelemetryCollector$Integral;->rotate(DDDD)V

    .line 427
    :cond_0
    return-void
.end method
