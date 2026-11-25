.class final Lcom/motorola/camera/custom/TelemetryCollector$Series;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Series"
.end annotation


# instance fields
.field final data:[F

.field next:I

.field size:I

.field final sizes:[I

.field final times:[J

.field final width:I


# direct methods
.method constructor <init>(II)V
    .locals 1

    .line 312
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 313
    iput p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    .line 314
    new-array v0, p1, [J

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    .line 315
    new-array v0, p1, [I

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->sizes:[I

    .line 316
    mul-int/2addr p1, p2

    new-array p1, p1, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    .line 317
    return-void
.end method


# virtual methods
.method declared-synchronized add(J[F)V
    .locals 2

    monitor-enter p0

    .line 320
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-lez v0, :cond_2

    :try_start_0
    array-length v0, p3

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    iget v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {p0, v1}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v1

    aget-wide v0, v0, v1

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    goto :goto_0

    .line 321
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    iget v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    aput-wide p1, v0, v1

    .line 322
    iget-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->sizes:[I

    iget p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    iget v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    array-length v1, p3

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    aput v0, p1, p2

    .line 323
    iget-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->data:[F

    iget p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    iget v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->width:I

    mul-int/2addr p2, v0

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->sizes:[I

    iget v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    aget v0, v0, v1

    const/4 v1, 0x0

    invoke-static {p3, v1, p1, p2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 324
    iget p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    add-int/lit8 p1, p1, 0x1

    iget-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    array-length p2, p2

    rem-int/2addr p1, p2

    iput p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    .line 325
    iget p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    iget-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    array-length p2, p2

    if-ge p1, p2, :cond_1

    iget p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 326
    :cond_1
    monitor-exit p0

    return-void

    .line 319
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    .line 320
    :cond_2
    :goto_0
    monitor-exit p0

    return-void
.end method

.method declared-synchronized atOrBefore(J)I
    .locals 3

    monitor-enter p0

    .line 342
    :try_start_0
    invoke-virtual {p0, p1, p2}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->lowerBound(J)I

    move-result v0

    .line 343
    iget v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v2

    aget-wide v1, v1, v2

    cmp-long p1, v1, p1

    if-nez p1, :cond_0

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return p1

    .line 344
    :cond_0
    if-nez v0, :cond_1

    const/4 p1, -0x1

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v0, -0x1

    :try_start_1
    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit p0

    return p1

    .line 341
    :catchall_0
    move-exception p1

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1
.end method

.method lowerBound(J)I
    .locals 5

    .line 332
    iget v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    const/4 v1, 0x0

    .line 333
    :goto_0
    if-ge v1, v0, :cond_1

    .line 334
    add-int v2, v1, v0

    ushr-int/lit8 v2, v2, 0x1

    .line 335
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    invoke-virtual {p0, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->slot(I)I

    move-result v4

    aget-wide v3, v3, v4

    cmp-long v3, v3, p1

    if-gez v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    move v1, v2

    goto :goto_1

    .line 336
    :cond_0
    move v0, v2

    .line 337
    :goto_1
    goto :goto_0

    .line 338
    :cond_1
    return v1
.end method

.method slot(I)I
    .locals 2

    .line 328
    iget v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->next:I

    iget v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->size:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    array-length v1, v1

    add-int/2addr v0, v1

    add-int/2addr v0, p1

    iget-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Series;->times:[J

    array-length p1, p1

    rem-int/2addr v0, p1

    return v0
.end method
