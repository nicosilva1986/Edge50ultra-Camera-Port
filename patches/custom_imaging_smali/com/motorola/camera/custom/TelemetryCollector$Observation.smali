.class final Lcom/motorola/camera/custom/TelemetryCollector$Observation;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Observation"
.end annotation


# instance fields
.field reason:Ljava/lang/String;

.field timestamp:Ljava/lang/Long;

.field values:[F


# direct methods
.method constructor <init>(Lcom/motorola/camera/custom/TelemetryCollector$Series;JJLjava/lang/String;)V
    .locals 2

    .line 553
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 554
    iput-object p6, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    .line 555
    if-nez p1, :cond_0

    return-void

    .line 556
    :cond_0
    monitor-enter p1

    .line 557
    :try_start_0
    invoke-virtual {p1, p2, p3}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->atOrBefore(J)I

    move-result p6

    .line 558
    if-gez p6, :cond_1

    monitor-exit p1

    return-void

    .line 559
    :cond_1
    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    aget-wide v0, v0, p6

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    .line 560
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    sub-long/2addr p2, v0

    cmp-long p2, p2, p4

    if-lez p2, :cond_2

    .line 561
    const-string p2, "stale"

    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    .line 562
    monitor-exit p1

    return-void

    .line 564
    :cond_2
    iget p2, p1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    mul-int/2addr p2, p6

    .line 565
    iget-object p3, p1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    iget-object p4, p1, Lcom/motorola/camera/custom/TelemetryCollector$Series;->sizes:[I

    aget p4, p4, p6

    add-int/2addr p4, p2

    invoke-static {p3, p2, p4}, Ljava/util/Arrays;->copyOfRange([FII)[F

    move-result-object p2

    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    .line 566
    const/4 p2, 0x0

    iput-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    .line 567
    monitor-exit p1

    .line 568
    return-void

    .line 567
    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2
.end method


# virtual methods
.method channel(I)Ljava/lang/Float;
    .locals 2

    .line 571
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    if-eqz v0, :cond_1

    if-ltz p1, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    array-length v0, v0

    if-ge p1, v0, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v0, v0, p1

    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget v0, v0, p1

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    goto :goto_0

    .line 572
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    aget p1, v0, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    return-object p1

    .line 571
    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method json()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 576
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 577
    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->timestamp:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    const-string v2, "timestampNs"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 578
    const-string v1, "reason"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->reason:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 579
    const-string v1, "raw"

    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Observation;->values:[F

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 580
    return-object v0
.end method
