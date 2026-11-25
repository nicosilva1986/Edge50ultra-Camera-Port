.class final Lcom/motorola/camera/custom/TelemetryCollector$Session;
.super Ljava/lang/Object;
.source "TelemetryCollector.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Session"
.end annotation


# instance fields
.field final appContext:Landroid/content/Context;

.field final cameraId:Ljava/lang/String;

.field volatile closed:Z

.field final front:Z

.field final history:Ljava/util/EnumMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/EnumMap<",
            "Lcom/motorola/camera/custom/TelemetryCollector$Stream;",
            "Lcom/motorola/camera/custom/TelemetryCollector$Series;",
            ">;"
        }
    .end annotation
.end field

.field final id:J

.field final layout:Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;

.field final manager:Landroid/hardware/SensorManager;

.field final registered:Ljava/util/IdentityHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/IdentityHashMap<",
            "Landroid/hardware/Sensor;",
            "Lcom/motorola/camera/custom/TelemetryCollector$Stream;",
            ">;"
        }
    .end annotation
.end field

.field final sensors:Ljava/util/EnumMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/EnumMap<",
            "Lcom/motorola/camera/custom/TelemetryCollector$Stream;",
            "Landroid/hardware/Sensor;",
            ">;"
        }
    .end annotation
.end field

.field final status:Ljava/util/EnumMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/EnumMap<",
            "Lcom/motorola/camera/custom/TelemetryCollector$Stream;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final thermal:Lcom/motorola/camera/custom/TelemetryCollector$Series;

.field final thermalWorker:Ljava/util/concurrent/ScheduledExecutorService;

.field final thread:Landroid/os/HandlerThread;


# direct methods
.method constructor <init>(JLandroid/content/Context;Ljava/lang/String;ZLandroid/hardware/SensorManager;Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)V
    .locals 3

    .line 193
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 180
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "CameraTelemetrySensors"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    .line 181
    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Session$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Lcom/motorola/camera/custom/TelemetryCollector$Session$$ExternalSyntheticLambda1;-><init>()V

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermalWorker:Ljava/util/concurrent/ScheduledExecutorService;

    .line 186
    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    .line 187
    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    .line 188
    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->-$$Nest$sfgetZONES()[Ljava/lang/String;

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x20

    invoke-direct {v0, v2, v1}, Lcom/motorola/camera/custom/TelemetryCollector$Series;-><init>(II)V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermal:Lcom/motorola/camera/custom/TelemetryCollector$Series;

    .line 189
    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registered:Ljava/util/IdentityHashMap;

    .line 190
    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    iput-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    .line 194
    iput-wide p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->id:J

    .line 195
    iput-object p3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->appContext:Landroid/content/Context;

    .line 196
    iput-object p4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->cameraId:Ljava/lang/String;

    .line 197
    iput-boolean p5, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->front:Z

    .line 198
    iput-object p6, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    .line 199
    iput-object p7, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->layout:Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;

    .line 200
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->values()[Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    move-result-object p1

    array-length p2, p1

    const/4 p3, 0x0

    move p4, p3

    :goto_0
    if-ge p4, p2, :cond_5

    aget-object p5, p1, p4

    .line 201
    sget-object p6, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-eq p5, p6, :cond_1

    sget-object p6, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne p5, p6, :cond_0

    goto :goto_1

    :cond_0
    move p6, p3

    goto :goto_2

    :cond_1
    :goto_1
    const/4 p6, 0x1

    .line 202
    :goto_2
    if-eqz p6, :cond_2

    const/16 p7, 0x2000

    goto :goto_3

    :cond_2
    const/16 p7, 0x80

    .line 203
    :goto_3
    if-eqz p6, :cond_3

    const/4 p6, 0x3

    goto :goto_4

    :cond_3
    sget-object p6, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne p5, p6, :cond_4

    const/4 p6, 0x5

    goto :goto_4

    :cond_4
    const/16 p6, 0x10

    .line 204
    :goto_4
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    new-instance v1, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    invoke-direct {v1, p7, p6}, Lcom/motorola/camera/custom/TelemetryCollector$Series;-><init>(II)V

    invoke-virtual {v0, p5, v1}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 205
    iget-object p6, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string p7, "notExposed"

    invoke-virtual {p6, p5, p7}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 200
    add-int/lit8 p4, p4, 0x1

    goto :goto_0

    .line 207
    :cond_5
    return-void
.end method

.method static synthetic lambda$new$0(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .locals 2

    .line 182
    new-instance v0, Ljava/lang/Thread;

    const-string v1, "CameraTelemetryThermal"

    invoke-direct {v0, p0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 183
    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 184
    return-object v0
.end method

.method private declared-synchronized register(Lcom/motorola/camera/custom/TelemetryCollector$Stream;Landroid/hardware/Sensor;Landroid/os/Handler;)V
    .locals 5

    monitor-enter p0

    .line 256
    if-nez p2, :cond_0

    monitor-exit p0

    return-void

    .line 257
    :cond_0
    :try_start_0
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const/4 v1, 0x0

    if-eq p1, v0, :cond_2

    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne p1, v0, :cond_1

    goto :goto_0

    :cond_1
    move v0, v1

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    .line 258
    :goto_1
    const/16 v2, 0x4e20

    if-eqz v0, :cond_3

    const/16 v0, 0x9c4

    const/16 v3, 0x1388

    filled-new-array {v0, v3, v2}, [I

    move-result-object v0

    goto :goto_2

    .line 259
    :cond_3
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne p1, v0, :cond_4

    const v0, 0x1046b

    filled-new-array {v2, v0}, [I

    move-result-object v0

    goto :goto_2

    :cond_4
    const v0, 0x186a0

    filled-new-array {v0}, [I

    move-result-object v0

    .line 260
    :goto_2
    array-length v2, v0

    :goto_3
    if-ge v1, v2, :cond_7

    aget v3, v0, v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 262
    :try_start_1
    iget-object v4, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v4, p0, p2, v3, p3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;ILandroid/os/Handler;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 263
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    invoke-virtual {v3, p1, p2}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 264
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registered:Ljava/util/IdentityHashMap;

    invoke-virtual {v3, p2}, Ljava/util/IdentityHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registered:Ljava/util/IdentityHashMap;

    invoke-virtual {v3, p2, p1}, Ljava/util/IdentityHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 265
    :cond_5
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string v4, "noSample"

    invoke-virtual {v3, p1, v4}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 266
    monitor-exit p0

    return-void

    .line 268
    :cond_6
    :try_start_2
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string v4, "registrationFailed"

    invoke-virtual {v3, p1, v4}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_4

    .line 271
    :catch_0
    move-exception v3

    .line 272
    :try_start_3
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string v4, "registrationFailed"

    invoke-virtual {v3, p1, v4}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_5

    .line 269
    :catch_1
    move-exception v3

    .line 270
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string v4, "accessDenied"

    invoke-virtual {v3, p1, v4}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 273
    :goto_4
    nop

    .line 260
    :goto_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 275
    :cond_7
    monitor-exit p0

    return-void

    .line 255
    :catchall_0
    move-exception p1

    :try_start_4
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw p1
.end method

.method private registerImu(Lcom/motorola/camera/custom/TelemetryCollector$Stream;ILandroid/os/Handler;)V
    .locals 1

    .line 235
    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object p2

    invoke-direct {p0, p1, p2, p3}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->register(Lcom/motorola/camera/custom/TelemetryCollector$Stream;Landroid/hardware/Sensor;Landroid/os/Handler;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 238
    goto :goto_0

    .line 236
    :catch_0
    move-exception p2

    .line 237
    iget-object p2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string p3, "unavailable"

    invoke-virtual {p2, p1, p3}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    :goto_0
    return-void
.end method

.method private registerRotation(Landroid/os/Handler;)V
    .locals 5

    .line 243
    const/16 v0, 0x14

    const/16 v1, 0xb

    :try_start_0
    filled-new-array {v1, v0}, [I

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x2

    if-ge v1, v2, :cond_1

    aget v2, v0, v1

    .line 244
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v3, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v3

    .line 245
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Landroid/hardware/Sensor;->getType()I

    move-result v4

    if-ne v4, v2, :cond_0

    .line 246
    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-direct {p0, v2, v3, p1}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->register(Lcom/motorola/camera/custom/TelemetryCollector$Stream;Landroid/hardware/Sensor;Landroid/os/Handler;)V

    .line 247
    iget-object v2, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v2, v3}, Ljava/util/EnumMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_0

    return-void

    .line 243
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 252
    :cond_1
    goto :goto_1

    .line 250
    :catch_0
    move-exception p1

    .line 251
    iget-object p1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "unavailable"

    invoke-virtual {p1, v0, v1}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 253
    :goto_1
    return-void
.end method


# virtual methods
.method close()V
    .locals 2

    .line 298
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->closed:Z

    .line 299
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermalWorker:Ljava/util/concurrent/ScheduledExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->shutdownNow()Ljava/util/List;

    .line 301
    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 305
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->isAlive()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->quitSafely()Z

    .line 306
    :cond_1
    throw v0

    .line 302
    :catch_0
    move-exception v0

    .line 305
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_2

    :goto_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->quitSafely()Z

    .line 307
    :cond_2
    return-void
.end method

.method synthetic lambda$start$1$com-motorola-camera-custom-TelemetryCollector$Session()V
    .locals 4

    .line 211
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "/sys/class/thermal"

    invoke-static {v1, v0}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/custom/TelemetryCollector;->readThermalZones(Ljava/nio/file/Path;)[F

    move-result-object v0

    .line 212
    iget-boolean v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->closed:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermal:Lcom/motorola/camera/custom/TelemetryCollector$Series;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->add(J[F)V

    .line 213
    :cond_0
    return-void
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    .line 277
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 13

    .line 280
    iget-boolean v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->closed:Z

    if-nez v0, :cond_9

    if-eqz p1, :cond_9

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 282
    :cond_0
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registered:Ljava/util/IdentityHashMap;

    iget-object v1, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0, v1}, Ljava/util/IdentityHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 283
    if-nez v0, :cond_1

    return-void

    .line 284
    :cond_1
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-eq v0, v1, :cond_2

    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne v0, v1, :cond_3

    :cond_2
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    invoke-static {v1}, Lcom/motorola/camera/custom/TelemetryCollector;->-$$Nest$smvalidTriplet([F)Z

    move-result v1

    if-nez v1, :cond_3

    return-void

    .line 285
    :cond_3
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    if-ne v0, v1, :cond_8

    .line 286
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    array-length v0, v0

    const/4 v1, 0x3

    if-ge v0, v1, :cond_4

    return-void

    .line 287
    :cond_4
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v2, 0x0

    aget v0, v0, v2

    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v4, 0x1

    aget v3, v3, v4

    iget-object v5, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v6, 0x2

    aget v5, v5, v6

    .line 288
    iget-object v7, p1, Landroid/hardware/SensorEvent;->values:[F

    array-length v7, v7

    const/4 v8, 0x4

    if-lt v7, v8, :cond_5

    iget-object v7, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v7, v7, v1

    goto :goto_0

    .line 289
    :cond_5
    float-to-double v9, v0

    mul-double/2addr v9, v9

    mul-float v7, v3, v3

    float-to-double v11, v7

    add-double/2addr v9, v11

    mul-float v7, v5, v5

    float-to-double v11, v7

    add-double/2addr v9, v11

    const-wide/high16 v11, 0x3ff0000000000000L    # 1.0

    sub-double/2addr v11, v9

    const-wide/16 v9, 0x0

    invoke-static {v9, v10, v11, v12}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v9

    double-to-float v7, v9

    .line 290
    :goto_0
    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_7

    invoke-static {v3}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_7

    invoke-static {v5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_7

    invoke-static {v7}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-nez v9, :cond_6

    goto :goto_1

    .line 291
    :cond_6
    iget-object v9, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    sget-object v10, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v9, v10}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    iget-wide v10, p1, Landroid/hardware/SensorEvent;->timestamp:J

    iget p1, p1, Landroid/hardware/SensorEvent;->accuracy:I

    int-to-float p1, p1

    const/4 v12, 0x5

    new-array v12, v12, [F

    aput v0, v12, v2

    aput v3, v12, v4

    aput v5, v12, v6

    aput v7, v12, v1

    aput p1, v12, v8

    invoke-virtual {v9, v10, v11, v12}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->add(J[F)V

    .line 292
    return-void

    .line 290
    :cond_7
    :goto_1
    return-void

    .line 294
    :cond_8
    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->history:Ljava/util/EnumMap;

    invoke-virtual {v1, v0}, Ljava/util/EnumMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/motorola/camera/custom/TelemetryCollector$Series;

    iget-wide v1, p1, Landroid/hardware/SensorEvent;->timestamp:J

    iget-object p1, p1, Landroid/hardware/SensorEvent;->values:[F

    invoke-virtual {v0, v1, v2, p1}, Lcom/motorola/camera/custom/TelemetryCollector$Series;->add(J[F)V

    .line 295
    return-void

    .line 282
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    .line 280
    :cond_9
    :goto_2
    return-void
.end method

.method start()V
    .locals 7

    .line 210
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thermalWorker:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v1, Lcom/motorola/camera/custom/TelemetryCollector$Session$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/motorola/camera/custom/TelemetryCollector$Session$$ExternalSyntheticLambda0;-><init>(Lcom/motorola/camera/custom/TelemetryCollector$Session;)V

    const-wide/16 v4, 0x1

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x0

    invoke-interface/range {v0 .. v6}, Ljava/util/concurrent/ScheduledExecutorService;->scheduleWithFixedDelay(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    .line 214
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    if-nez v0, :cond_0

    return-void

    .line 215
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 216
    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->thread:Landroid/os/HandlerThread;

    invoke-virtual {v1}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 217
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const/4 v2, 0x4

    invoke-direct {p0, v1, v2, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registerImu(Lcom/motorola/camera/custom/TelemetryCollector$Stream;ILandroid/os/Handler;)V

    .line 218
    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const/4 v2, 0x1

    invoke-direct {p0, v1, v2, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registerImu(Lcom/motorola/camera/custom/TelemetryCollector$Stream;ILandroid/os/Handler;)V

    .line 219
    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->registerRotation(Landroid/os/Handler;)V

    .line 221
    :try_start_0
    iget-object v1, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->manager:Landroid/hardware/SensorManager;

    const/4 v3, -0x1

    invoke-virtual {v1, v3}, Landroid/hardware/SensorManager;->getSensorList(I)Ljava/util/List;

    move-result-object v1

    .line 222
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/hardware/Sensor;

    .line 223
    invoke-static {v3}, Lcom/motorola/camera/custom/TelemetryCollector;->-$$Nest$smvendorStream(Landroid/hardware/Sensor;)Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    move-result-object v4

    .line 224
    if-eqz v4, :cond_1

    iget-object v5, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    invoke-virtual {v5, v4}, Ljava/util/EnumMap;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-direct {p0, v4, v3, v0}, Lcom/motorola/camera/custom/TelemetryCollector$Session;->register(Lcom/motorola/camera/custom/TelemetryCollector$Stream;Landroid/hardware/Sensor;Landroid/os/Handler;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 225
    :cond_1
    goto :goto_0

    .line 230
    :cond_2
    goto :goto_2

    .line 226
    :catch_0
    move-exception v0

    .line 227
    const/4 v0, 0x3

    new-array v1, v0, [Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const/4 v4, 0x0

    aput-object v3, v1, v4

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    aput-object v3, v1, v2

    :goto_1
    if-ge v4, v0, :cond_4

    aget-object v2, v1, v4

    .line 228
    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->sensors:Ljava/util/EnumMap;

    invoke-virtual {v3, v2}, Ljava/util/EnumMap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lcom/motorola/camera/custom/TelemetryCollector$Session;->status:Ljava/util/EnumMap;

    const-string v5, "enumerationFailed"

    invoke-virtual {v3, v2, v5}, Ljava/util/EnumMap;->put(Ljava/lang/Enum;Ljava/lang/Object;)Ljava/lang/Object;

    .line 227
    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 231
    :cond_4
    :goto_2
    return-void
.end method
