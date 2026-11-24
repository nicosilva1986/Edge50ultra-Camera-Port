.class final Lcom/motorola/camera/custom/CompassHudController$Stream;
.super Ljava/lang/Object;
.source "CompassHudController.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassHudController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Stream"
.end annotation


# instance fields
.field declination:D

.field volatile ev100:D

.field final front:Z

.field heading:D

.field lastFixCheck:J

.field lastPaint:J

.field lastSample:J

.field final manager:Landroid/hardware/SensorManager;

.field sun:Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;


# direct methods
.method constructor <init>(Landroid/hardware/SensorManager;Z)V
    .locals 2

    .line 297
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 292
    const-wide/high16 v0, 0x7ff8000000000000L    # Double.NaN

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->ev100:D

    .line 293
    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D

    .line 294
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastSample:J

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastPaint:J

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastFixCheck:J

    .line 297
    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->manager:Landroid/hardware/SensorManager;

    iput-boolean p2, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->front:Z

    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    .line 306
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 21

    .line 309
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-class v2, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v2

    .line 310
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$sfgetstream()Lcom/motorola/camera/custom/CompassHudController$Stream;

    move-result-object v3

    if-ne v0, v3, :cond_e

    if-eqz v1, :cond_e

    iget-object v3, v1, Landroid/hardware/SensorEvent;->values:[F

    if-eqz v3, :cond_e

    iget-object v3, v1, Landroid/hardware/SensorEvent;->values:[F

    array-length v3, v3

    const/4 v4, 0x3

    if-lt v3, v4, :cond_e

    iget-wide v3, v1, Landroid/hardware/SensorEvent;->timestamp:J

    iget-wide v5, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastSample:J

    cmp-long v3, v3, v5

    if-gtz v3, :cond_0

    goto/16 :goto_5

    .line 312
    :cond_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$sfgetcurrent()Ljava/lang/ref/WeakReference;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CompassHudController$Pill;

    .line 313
    if-eqz v3, :cond_d

    iget-object v4, v3, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v4}, Landroid/widget/RelativeLayout;->isAttachedToWindow()Z

    move-result v4

    if-nez v4, :cond_1

    goto/16 :goto_4

    .line 314
    :cond_1
    iget-wide v4, v1, Landroid/hardware/SensorEvent;->timestamp:J

    iput-wide v4, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastSample:J

    .line 315
    iget-object v6, v1, Landroid/hardware/SensorEvent;->values:[F

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$sfgetorientation()I

    move-result v7

    iget-boolean v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->front:Z

    iget v9, v1, Landroid/hardware/SensorEvent;->accuracy:I

    iget-wide v10, v1, Landroid/hardware/SensorEvent;->timestamp:J

    invoke-static/range {v6 .. v11}, Lcom/motorola/camera/custom/CompassHudController;->sensorOrientation([FIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    move-result-object v12

    .line 317
    const-wide/high16 v4, 0x7ff8000000000000L    # Double.NaN

    if-eqz v12, :cond_c

    iget v1, v12, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v6, v1

    invoke-static {v6, v7}, Ljava/lang/Double;->isFinite(D)Z

    move-result v1

    if-nez v1, :cond_2

    goto/16 :goto_3

    .line 322
    :cond_2
    iget-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    iget v1, v12, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v8, v1

    invoke-static {v6, v7, v8, v9}, Lcom/motorola/camera/custom/CompassHudController;->smoothHeading(DD)D

    move-result-wide v6

    iput-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    .line 323
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v6

    .line 324
    iget-wide v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastPaint:J

    invoke-static {v8, v9, v6, v7}, Lcom/motorola/camera/custom/CompassHudController;->renderDue(JJ)Z

    move-result v1

    if-nez v1, :cond_3

    monitor-exit v2

    return-void

    .line 325
    :cond_3
    iput-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastPaint:J

    .line 327
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->menuOpen()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smreconcile()V

    monitor-exit v2

    return-void

    .line 328
    :cond_4
    iget-wide v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastFixCheck:J

    const-wide/16 v10, 0x0

    cmp-long v1, v8, v10

    if-ltz v1, :cond_5

    iget-wide v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastFixCheck:J

    sub-long v8, v6, v8

    const-wide v10, 0xdf8475800L

    cmp-long v1, v8, v10

    if-ltz v1, :cond_6

    .line 329
    :cond_5
    iput-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastFixCheck:J

    .line 330
    invoke-virtual {v3}, Lcom/motorola/camera/custom/CompassHudController$Pill;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/motorola/camera/custom/CompassHudController$Stream;->updateSun(Landroid/content/Context;)V

    .line 332
    :cond_6
    iget-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D

    invoke-static {v6, v7}, Ljava/lang/Double;->isFinite(D)Z

    move-result v1

    .line 333
    if-eqz v1, :cond_7

    iget-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    iget-wide v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D

    add-double/2addr v6, v8

    invoke-static {v6, v7}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smwrap(D)D

    move-result-wide v6

    goto :goto_0

    :cond_7
    iget-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    :goto_0
    move-wide v13, v6

    iget-object v15, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->sun:Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    iget-wide v6, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->ev100:D

    iget-object v8, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->sun:Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    if-eqz v8, :cond_8

    const/4 v8, 0x1

    goto :goto_1

    :cond_8
    const/4 v8, 0x0

    :goto_1
    move/from16 v18, v8

    .line 334
    if-eqz v1, :cond_9

    iget v1, v12, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v4, v1

    iget-wide v0, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D

    add-double/2addr v4, v0

    invoke-static {v4, v5}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smwrap(D)D

    move-result-wide v4

    :cond_9
    move-wide/from16 v19, v4

    .line 333
    move-wide/from16 v16, v6

    invoke-static/range {v12 .. v20}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smlabel(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;DLcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZD)Ljava/lang/String;

    move-result-object v0

    .line 335
    iget v1, v12, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->accuracy:I

    const/4 v4, 0x2

    if-ge v1, v4, :cond_a

    const v1, -0x470e0f0c

    goto :goto_2

    :cond_a
    const-string v1, "\u2600 Contraluz"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    const/16 v1, -0x3380

    goto :goto_2

    :cond_b
    const v1, -0xe0f0c

    :goto_2
    invoke-virtual {v3, v0, v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->display(Ljava/lang/String;I)V

    .line 336
    monitor-exit v2

    .line 337
    return-void

    .line 318
    :cond_c
    :goto_3
    iput-wide v4, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    .line 319
    invoke-virtual {v3}, Lcom/motorola/camera/custom/CompassHudController$Pill;->hide()V

    .line 320
    monitor-exit v2

    return-void

    .line 313
    :cond_d
    :goto_4
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smstopStream()V

    monitor-exit v2

    return-void

    .line 311
    :cond_e
    :goto_5
    monitor-exit v2

    return-void

    .line 336
    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method register(I)Z
    .locals 3

    .line 301
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v1, p1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object p1

    .line 302
    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->manager:Landroid/hardware/SensorManager;

    const/4 v2, 0x2

    invoke-virtual {v1, p0, p1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 303
    :catch_0
    move-exception p1

    return v0
.end method

.method updateSun(Landroid/content/Context;)V
    .locals 13

    .line 340
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->sun:Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    .line 341
    const-wide/high16 v1, 0x7ff8000000000000L    # Double.NaN

    iput-wide v1, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D

    .line 342
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smisSaveLocationAllowed()Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    .line 343
    :cond_0
    const-string v1, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-virtual {p1, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    .line 344
    const-string v1, "android.permission.ACCESS_FINE_LOCATION"

    invoke-virtual {p1, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    return-void

    .line 345
    :cond_1
    const-string v1, "location"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    .line 346
    instance-of v1, p1, Landroid/location/LocationManager;

    if-nez v1, :cond_2

    return-void

    .line 347
    :cond_2
    check-cast p1, Landroid/location/LocationManager;

    .line 348
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    .line 349
    nop

    .line 350
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$sfgetPROVIDERS()[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v7, 0x0

    move-object v8, v0

    move v3, v7

    :goto_0
    if-ge v3, v2, :cond_5

    aget-object v0, v1, v3

    .line 352
    :try_start_0
    invoke-virtual {p1, v0}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v0

    .line 353
    if-eqz v0, :cond_4

    invoke-static {v0, v5, v6}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smvalidFix(Landroid/location/Location;J)Z

    move-result v4

    if-eqz v4, :cond_4

    if-eqz v8, :cond_3

    invoke-virtual {v0}, Landroid/location/Location;->getTime()J

    move-result-wide v9

    invoke-virtual {v8}, Landroid/location/Location;->getTime()J

    move-result-wide v11
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v4, v9, v11

    if-lez v4, :cond_4

    .line 354
    :cond_3
    move-object v8, v0

    goto :goto_1

    .line 355
    :catch_0
    move-exception v0

    :cond_4
    :goto_1
    nop

    .line 350
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 357
    :cond_5
    if-nez v8, :cond_6

    return-void

    .line 358
    :cond_6
    invoke-virtual {v8}, Landroid/location/Location;->getLatitude()D

    move-result-wide v1

    invoke-virtual {v8}, Landroid/location/Location;->getLongitude()D

    move-result-wide v3

    invoke-static/range {v1 .. v6}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeSolarPosition(DDJ)Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    move-result-object p1

    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->sun:Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    .line 361
    :try_start_1
    const-string p1, "android.hardware.GeomagneticField"

    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p1

    .line 362
    invoke-virtual {v8}, Landroid/location/Location;->hasAltitude()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {v8}, Landroid/location/Location;->getAltitude()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {v8}, Landroid/location/Location;->getAltitude()D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_2

    :cond_7
    const/4 v0, 0x0

    .line 363
    :goto_2
    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/Class;

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v2, v1, v7

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x1

    aput-object v2, v1, v3

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x2

    aput-object v2, v1, v3

    sget-object v2, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x3

    aput-object v2, v1, v3

    invoke-virtual {p1, v1}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v1

    .line 364
    invoke-virtual {v8}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    double-to-float v2, v2

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    invoke-virtual {v8}, Landroid/location/Location;->getLongitude()D

    move-result-wide v3

    double-to-float v3, v3

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    filled-new-array {v2, v3, v0, v4}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 365
    const-string v1, "getDeclination"

    new-array v2, v7, [Ljava/lang/Class;

    invoke-virtual {p1, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    new-array v1, v7, [Ljava/lang/Object;

    invoke-virtual {p1, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v0

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->declination:D
    :try_end_1
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_3

    .line 366
    :catch_1
    move-exception v0

    :goto_3
    nop

    .line 367
    return-void
.end method
