.class public final Lcom/motorola/camera/custom/CustomImagingBridge;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;,
        Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;,
        Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;
    }
.end annotation


# static fields
.field private static final HTP_RPC_AVAILABLE:Z

.field private static final JPEG_SAVE_QUALITY:I = 0x62

.field private static final KEY_ENABLE_AUTO_HDR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

.field private static final KEY_ENABLE_ISZ:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

.field private static final KEY_ENABLE_MFHDR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

.field private static final KEY_ENABLE_MFNR_AIDE:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

.field private static final KEY_ENABLE_QHDR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

.field private static final KEY_ENABLE_QLL:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.enableQLL"

.field private static final KEY_ENABLE_SHDR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

.field private static final KEY_ENABLE_SNAPSHOT_ISZ:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

.field private static final KEY_ENABLE_VSR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

.field private static final KEY_ENABLE_XCFA:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

.field private static final KEY_HDR_MODE:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.HDRMode"

.field private static final KEY_HDR_MODE_PREF:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

.field private static final KEY_SAT_FALLBACK_T2W:Ljava/lang/String; = "com.lenovo.moto.SATFallback.T2W"

.field private static final KEY_SNAPSHOT_HDR_MODE:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode"

.field private static final LUT_POOL:Ljava/util/concurrent/ExecutorService;

.field private static final MAX_BAYER_PIXELS:I = 0x1312d00

.field private static final MAX_SHOT_CACHE:I = 0x200

.field public static final PREF_KEY:Ljava/lang/String; = "com.motorola.camera.post_processing_profile"

.field private static final PROFILE_LABELS:[Ljava/lang/CharSequence;

.field private static final PROFILE_VALUES:[Ljava/lang/CharSequence;

.field private static final RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

.field private static final RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

.field private static final RECORD_DECISIONS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/motorola/camera/fsm/camera/record/CaptureRecord;",
            "Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;",
            ">;"
        }
    .end annotation
.end field

.field private static final REQ_KEY_CACHE:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/hardware/camera2/CameraCharacteristics;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final SES_KEY_CACHE:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/hardware/camera2/CameraCharacteristics;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final SHOT_CACHE:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Long;",
            "Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;",
            ">;"
        }
    .end annotation
.end field

.field private static final STRIP_HEIGHT:I = 0x200

.field private static final TAG:Ljava/lang/String; = "CustomImagingBridge"


# direct methods
.method static constructor <clinit>()V
    .locals 13

    .line 70
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->checkAdspRpcReadable()Z

    move-result v0

    sput-boolean v0, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    .line 88
    nop

    .line 89
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    const/4 v1, 0x2

    div-int/2addr v0, v1

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/4 v2, 0x4

    invoke-static {v2, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    new-instance v3, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;

    const-string v4, "CustomLutWorker"

    invoke-direct {v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;-><init>(Ljava/lang/String;)V

    .line 88
    invoke-static {v0, v3}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 91
    new-instance v3, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v9, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {v9, v1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    new-instance v10, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;

    const-string v0, "CleanBayerWorker"

    invoke-direct {v10, v0}, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;-><init>(Ljava/lang/String;)V

    new-instance v11, Ljava/util/concurrent/ThreadPoolExecutor$CallerRunsPolicy;

    invoke-direct {v11}, Ljava/util/concurrent/ThreadPoolExecutor$CallerRunsPolicy;-><init>()V

    const/4 v4, 0x1

    const/4 v5, 0x1

    const-wide/16 v6, 0x0

    invoke-direct/range {v3 .. v11}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;Ljava/util/concurrent/RejectedExecutionHandler;)V

    sput-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 96
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    .line 124
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    .line 125
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$1;

    const/16 v3, 0x40

    const/high16 v4, 0x3f400000    # 0.75f

    invoke-direct {v0, v3, v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$1;-><init>(IFZ)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    .line 132
    const/16 v0, 0xa

    new-array v3, v0, [Ljava/lang/CharSequence;

    const-string v4, "Auto (Scene-Adaptive)"

    const/4 v6, 0x0

    aput-object v4, v3, v6

    const-string v4, "Natural ZSL (NR ZSL / Edge ZSL)"

    aput-object v4, v3, v5

    const-string v4, "Minimal ISP (NR Minimal / Edge Off)"

    aput-object v4, v3, v1

    const-string v4, "Detail HDR (RAW HDR / Low Halo)"

    const/4 v7, 0x3

    aput-object v4, v3, v7

    const-string v4, "Pure ISP (MFNR Off / NR Off)"

    aput-object v4, v3, v2

    const-string v4, "iPhone Natural (Apple Style LUT)"

    const/4 v8, 0x5

    aput-object v4, v3, v8

    const-string v4, "iPhone Rich Contrast (Apple Style)"

    const/4 v9, 0x6

    aput-object v4, v3, v9

    const-string v4, "iPhone Amber (Warm Photonic LUT)"

    const/4 v10, 0x7

    aput-object v4, v3, v10

    const-string v4, "Clean RAW Bayer (DNG -> Clean JPG)"

    const/16 v11, 0x8

    aput-object v4, v3, v11

    const-string v4, "Disable Post Processing (MCF Off / Direct HAL)"

    const/16 v12, 0x9

    aput-object v4, v3, v12

    sput-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 145
    new-array v0, v0, [Ljava/lang/CharSequence;

    const-string v3, "0"

    aput-object v3, v0, v6

    const-string v3, "1"

    aput-object v3, v0, v5

    const-string v3, "2"

    aput-object v3, v0, v1

    const-string v1, "3"

    aput-object v1, v0, v7

    const-string v1, "4"

    aput-object v1, v0, v2

    const-string v1, "5"

    aput-object v1, v0, v8

    const-string v1, "6"

    aput-object v1, v0, v9

    const-string v1, "7"

    aput-object v1, v0, v10

    const-string v1, "8"

    aput-object v1, v0, v11

    const-string v1, "9"

    aput-object v1, v0, v12

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    .line 381
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 382
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 383
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 384
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    .line 383
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 1

    .line 449
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V

    .line 450
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V
    .locals 16

    .line 454
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    if-eqz v1, :cond_12

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 456
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v3

    .line 457
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->FLASH_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 458
    const/4 v5, 0x3

    const/4 v6, 0x1

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-eqz v4, :cond_1

    .line 459
    move v3, v6

    goto :goto_0

    .line 461
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 462
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-ne v4, v5, :cond_2

    .line 463
    move v3, v6

    .line 466
    :cond_2
    :goto_0
    nop

    .line 467
    instance-of v4, v2, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v4, :cond_3

    .line 468
    move-object v4, v2

    check-cast v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 469
    iget-object v7, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 470
    iget-boolean v4, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z

    if-eqz v4, :cond_4

    .line 471
    move v3, v6

    goto :goto_1

    .line 467
    :cond_3
    const/4 v7, 0x0

    .line 475
    :cond_4
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v4

    invoke-static {v2, v7, v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v2

    .line 476
    iget-object v2, v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 477
    aget v4, v2, v6

    .line 478
    const/4 v7, 0x2

    aget v8, v2, v7

    .line 479
    aget v5, v2, v5

    .line 481
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v9

    .line 482
    const/4 v10, 0x0

    if-eqz v9, :cond_10

    .line 483
    if-ltz v4, :cond_5

    .line 484
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [I

    .line 485
    invoke-static {v11, v4}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 486
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v1, v11, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 489
    :cond_5
    if-ltz v8, :cond_6

    .line 490
    sget-object v4, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v4}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 491
    invoke-static {v4, v8}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 492
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v1, v4, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 500
    :cond_6
    invoke-static {v9, v10}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v4

    .line 501
    invoke-static {v9, v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v8

    .line 503
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_7

    .line 504
    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v4

    goto :goto_2

    .line 505
    :cond_7
    invoke-interface {v8}, Ljava/util/Set;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_8

    .line 506
    goto :goto_2

    .line 508
    :cond_8
    new-instance v9, Ljava/util/HashSet;

    invoke-direct {v9, v4}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 509
    invoke-interface {v9, v8}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    move-object v4, v9

    .line 511
    :goto_2
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_10

    array-length v8, v2

    const/16 v9, 0xd

    if-lt v8, v9, :cond_10

    .line 512
    const/4 v8, 0x7

    aget v8, v2, v8

    .line 513
    const/16 v9, 0x8

    aget v9, v2, v9

    .line 514
    const/16 v11, 0x9

    aget v11, v2, v11

    .line 515
    const/16 v12, 0xa

    aget v12, v2, v12

    .line 516
    const/16 v13, 0xb

    aget v13, v2, v13

    .line 517
    const/16 v14, 0xc

    aget v2, v2, v14

    .line 519
    if-ltz v8, :cond_9

    .line 520
    const-string v14, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    const-class v15, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v14, v15, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 521
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    const-class v14, Ljava/lang/Byte;

    int-to-byte v15, v8

    invoke-static {v15}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v15

    invoke-static {v1, v4, v7, v14, v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 522
    if-nez v8, :cond_9

    .line 523
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v7, v8, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 526
    :cond_9
    if-ltz v9, :cond_a

    .line 527
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v8, Ljava/lang/Byte;

    int-to-byte v9, v9

    invoke-static {v9}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 529
    :cond_a
    if-ltz v11, :cond_b

    .line 530
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 532
    :cond_b
    if-ltz v12, :cond_e

    .line 533
    if-lez v12, :cond_c

    move v7, v6

    goto :goto_3

    :cond_c
    move v7, v10

    .line 534
    :goto_3
    if-lez v12, :cond_d

    const/4 v8, 0x2

    goto :goto_4

    :cond_d
    move v8, v10

    .line 535
    :goto_4
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v9, v11, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 536
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v9, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 537
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 538
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 539
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-static {v1, v4, v7, v9, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 540
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 541
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 543
    :cond_e
    if-ne v13, v6, :cond_f

    .line 544
    const-string v6, "com.lenovo.moto.SATFallback.T2W"

    const-class v7, Ljava/lang/Byte;

    invoke-static {v10}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v8

    invoke-static {v1, v4, v6, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 546
    :cond_f
    if-ltz v2, :cond_10

    .line 547
    const-string v6, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v7, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v4, v6, v7, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 551
    :cond_10
    if-nez v5, :cond_11

    .line 552
    invoke-static {v0, v1, v10, v3}, Lcom/motorola/camera/fsm/camera/modes/RequestBuilderHelper;->setMfnr(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;ZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 556
    :cond_11
    goto :goto_5

    .line 554
    :catchall_0
    move-exception v0

    .line 555
    const-string v1, "CustomImagingBridge"

    const-string v2, "applyCaptureRequestOverrides failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 557
    :goto_5
    return-void

    .line 454
    :cond_12
    :goto_6
    return-void
.end method

.method public static applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 13

    .line 571
    const-string v1, "CustomImagingBridge"

    if-eqz p0, :cond_e

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_3

    .line 574
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v0

    .line 575
    iget-object v2, v0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 576
    iget-object v0, v0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v3, 0x5

    aget v9, v0, v3

    .line 577
    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 578
    if-nez v0, :cond_1

    .line 579
    return-void

    .line 582
    :cond_1
    :try_start_0
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 583
    array-length v0, v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/16 v4, 0x10

    if-ge v0, v4, :cond_2

    return-void

    .line 585
    :cond_2
    nop

    .line 587
    :try_start_1
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v4, Ljava/io/ByteArrayInputStream;

    invoke-direct {v4, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 588
    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v0, 0x0

    .line 590
    :goto_0
    const-string v10, "ImageDescription"

    const/4 v11, 0x0

    if-gtz v9, :cond_5

    .line 591
    if-eqz v0, :cond_4

    :try_start_2
    invoke-virtual {v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v4

    if-nez v4, :cond_4

    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_4

    .line 592
    invoke-virtual {v0, v10, v2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 593
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    array-length v5, v3

    add-int/lit16 v5, v5, 0x400

    invoke-direct {v4, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 594
    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-direct {v5, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v5, v4, v11}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 595
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 596
    array-length v3, v0

    const/16 v4, 0x40

    if-le v3, v4, :cond_3

    .line 597
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 599
    :cond_3
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Shot diag: "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 601
    :cond_4
    return-void

    .line 604
    :cond_5
    new-instance v4, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v4}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 605
    const/4 v5, 0x1

    iput-boolean v5, v4, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 606
    sget-object v5, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v5, v4, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 607
    array-length v5, v3

    invoke-static {v3, v11, v5, v4}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v12
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 608
    if-nez v12, :cond_6

    return-void

    .line 611
    :cond_6
    :try_start_3
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-nez v4, :cond_7

    .line 645
    :try_start_4
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 611
    return-void

    .line 612
    :cond_7
    :try_start_5
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    .line 613
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v6

    .line 614
    if-lez v5, :cond_d

    if-gtz v6, :cond_8

    goto/16 :goto_1

    .line 616
    :cond_8
    new-instance v4, Lcom/motorola/camera/custom/CustomImagingBridge$2;

    invoke-direct {v4, v12, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$2;-><init>(Landroid/graphics/Bitmap;I)V

    const/16 v7, 0x200

    const/16 v8, 0x18

    invoke-static/range {v4 .. v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIII)Z

    move-result v4
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 627
    if-nez v4, :cond_9

    .line 645
    :try_start_6
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 627
    return-void

    .line 629
    :cond_9
    :try_start_7
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    array-length v3, v3

    invoke-direct {v4, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 630
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v5, 0x62

    invoke-virtual {v12, v3, v5, v4}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    if-nez v3, :cond_a

    .line 645
    :try_start_8
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .line 631
    return-void

    .line 633
    :cond_a
    :try_start_9
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 634
    if-eqz v0, :cond_c

    .line 635
    if-eqz v2, :cond_b

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_b

    .line 636
    invoke-virtual {v0, v10, v2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 638
    :cond_b
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    array-length v5, v3

    const/high16 v6, 0x10000

    add-int/2addr v5, v6

    invoke-direct {v4, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 639
    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-direct {v5, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v5, v4, v11}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 640
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 642
    :cond_c
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v3}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 643
    array-length p0, v3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Applied AppleStyle LUT="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " bytes="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 645
    :try_start_a
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V

    .line 646
    nop

    .line 649
    goto :goto_2

    .line 645
    :cond_d
    :goto_1
    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V

    .line 614
    return-void

    .line 645
    :catchall_1
    move-exception v0

    move-object p0, v0

    invoke-virtual {v12}, Landroid/graphics/Bitmap;->recycle()V

    .line 646
    throw p0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 647
    :catchall_2
    move-exception v0

    move-object p0, v0

    .line 648
    const-string v0, "applyCustomLutIfEnabled failed, keeping original JPEG"

    invoke-static {v1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 650
    :goto_2
    return-void

    .line 572
    :cond_e
    :goto_3
    return-void
.end method

.method public static applySessionParameterOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 4

    .line 426
    if-eqz p1, :cond_4

    if-nez p0, :cond_0

    goto :goto_1

    .line 428
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 429
    const/16 v1, 0x9

    if-eq v0, v1, :cond_1

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    .line 431
    return-void

    .line 433
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 434
    if-nez p0, :cond_2

    return-void

    .line 435
    :cond_2
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object p0

    .line 436
    invoke-interface {p0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    return-void

    .line 438
    :cond_3
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v1, Ljava/lang/Integer;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 439
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 440
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 441
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v1, Ljava/lang/Byte;

    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 442
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {p1, p0, v0, v1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 445
    goto :goto_0

    .line 443
    :catchall_0
    move-exception p0

    .line 444
    const-string p1, "CustomImagingBridge"

    const-string v0, "applySessionParameterOverrides failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 446
    :goto_0
    return-void

    .line 426
    :cond_4
    :goto_1
    return-void
.end method

.method private static captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J
    .locals 10

    .line 191
    const-wide/16 v0, 0x0

    if-nez p0, :cond_0

    return-wide v0

    .line 192
    :cond_0
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    const/16 v3, 0x20

    const-wide/32 v4, 0x7fffffff

    const-wide v6, 0xffffffffL

    if-eqz v2, :cond_2

    .line 193
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v2, v2, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 194
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    .line 195
    or-long/2addr v2, v6

    .line 196
    cmp-long p0, v2, v0

    if-eqz p0, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v2, 0x1

    :goto_0
    return-wide v2

    .line 198
    :cond_2
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v2

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 199
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    or-long/2addr v2, v6

    const-wide/high16 v4, -0x8000000000000000L

    or-long/2addr v2, v4

    .line 200
    cmp-long p0, v2, v0

    if-eqz p0, :cond_3

    goto :goto_1

    :cond_3
    const-wide/16 v2, -0x1

    :goto_1
    return-wide v2
.end method

.method private static checkAdspRpcReadable()Z
    .locals 3

    .line 74
    const/4 v0, 0x1

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "/dev/adsprpc-smd"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 75
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v2, :cond_0

    .line 76
    return v0

    .line 78
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 79
    nop

    .line 80
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 79
    return v0

    .line 80
    :catchall_0
    move-exception v0

    .line 81
    const/4 v0, 0x0

    return v0

    .line 83
    :catchall_1
    move-exception v1

    .line 84
    return v0
.end method

.method public static exportCleanBayerJpeg(Ljava/nio/ByteBuffer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 10

    .line 757
    if-eqz p0, :cond_b

    if-eqz p1, :cond_b

    if-eqz p3, :cond_b

    if-nez p2, :cond_0

    goto/16 :goto_6

    .line 758
    :cond_0
    iget v2, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    .line 759
    iget v3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    .line 760
    invoke-static {p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v6

    .line 761
    iget-object v0, v6, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v1, 0x6

    aget v0, v0, v1

    if-nez v0, :cond_1

    return-void

    .line 762
    :cond_1
    const-string v9, "CustomImagingBridge"

    if-lez v2, :cond_a

    if-lez v3, :cond_a

    int-to-long v0, v2

    int-to-long v4, v3

    mul-long/2addr v0, v4

    const-wide/32 v4, 0x1312d00

    cmp-long v4, v0, v4

    if-lez v4, :cond_2

    goto/16 :goto_5

    .line 767
    :cond_2
    const-wide/16 v4, 0x5

    mul-long/2addr v0, v4

    const-wide/16 v4, 0x4

    :try_start_0
    div-long/2addr v0, v4

    .line 768
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    int-to-long v4, v4

    cmp-long v4, v4, v0

    if-gez v4, :cond_3

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v4

    int-to-long v4, v4

    cmp-long v0, v4, v0

    if-gez v0, :cond_3

    .line 769
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Raw buffer too small: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v9, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    return-void

    .line 772
    :cond_3
    iget-object v0, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    .line 773
    if-eqz v0, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v1, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v1, v1, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    if-nez v1, :cond_4

    goto/16 :goto_3

    .line 774
    :cond_4
    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->asSharedMediaFile()Lcom/motorola/camera/storage/backend/MediaStoreFile;

    move-result-object v0

    .line 775
    if-eqz v0, :cond_8

    iget-object v1, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    if-nez v1, :cond_5

    goto :goto_2

    .line 777
    :cond_5
    iget-object v1, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v1, :cond_6

    iget-object p3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p3}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_6
    const-string p3, "IMG_CLEAN"

    .line 778
    :goto_0
    const-string v1, ".dng"

    invoke-virtual {p3, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v4, "_CLEAN.jpg"

    if-eqz v1, :cond_7

    .line 779
    :try_start_1
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x4

    const/4 v5, 0x0

    invoke-virtual {p3, v5, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    move-object v7, p3

    goto :goto_1

    .line 780
    :cond_7
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    move-object v7, p3

    .line 781
    :goto_1
    iget-object p3, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-virtual {p3, v7}, Lcom/motorola/camera/storage/MediaFilePath;->withFileName(Ljava/lang/String;)Lcom/motorola/camera/storage/MediaFilePath;

    move-result-object v8

    .line 782
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v1

    .line 784
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v8}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;-><init>([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    invoke-interface {p0, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 788
    goto :goto_4

    .line 775
    :cond_8
    :goto_2
    return-void

    .line 773
    :cond_9
    :goto_3
    return-void

    .line 786
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 787
    const-string p1, "exportCleanBayerJpeg dispatch failed (DNG unaffected)"

    invoke-static {v9, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 789
    :goto_4
    return-void

    .line 763
    :cond_a
    :goto_5
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Skip CleanBayerRaw for unsupported size "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "x"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v9, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 764
    return-void

    .line 757
    :cond_b
    :goto_6
    return-void
.end method

.method private static extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F
    .locals 4

    .line 950
    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 951
    :cond_0
    const/16 v0, 0x9

    new-array v1, v0, [Landroid/util/Rational;

    .line 952
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 953
    new-array p0, v0, [F

    .line 954
    nop

    :goto_0
    if-ge v2, v0, :cond_3

    .line 955
    aget-object v3, v1, v2

    if-eqz v3, :cond_1

    aget-object v3, v1, v2

    invoke-virtual {v3}, Landroid/util/Rational;->floatValue()F

    move-result v3

    goto :goto_1

    :cond_1
    rem-int/lit8 v3, v2, 0x4

    if-nez v3, :cond_2

    const/high16 v3, 0x3f800000    # 1.0f

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    aput v3, p0, v2

    .line 954
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 957
    :cond_3
    return-object p0
.end method

.method private static getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/hardware/camera2/CameraCharacteristics;",
            "Z)",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 387
    if-nez p0, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object p0

    return-object p0

    .line 388
    :cond_0
    if-eqz p1, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 389
    :goto_0
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 390
    if-eqz v1, :cond_2

    return-object v1

    .line 391
    :cond_2
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 393
    if-eqz p1, :cond_3

    .line 394
    :try_start_0
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableSessionKeys()Ljava/util/List;

    move-result-object p1

    goto :goto_1

    .line 395
    :cond_3
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableCaptureRequestKeys()Ljava/util/List;

    move-result-object p1

    .line 396
    :goto_1
    if-eqz p1, :cond_5

    .line 397
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/hardware/camera2/CaptureRequest$Key;

    .line 398
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_4

    .line 399
    invoke-virtual {v2}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 401
    :cond_4
    goto :goto_2

    .line 403
    :catchall_0
    move-exception p1

    :cond_5
    nop

    .line 404
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object p1

    .line 405
    invoke-interface {v0, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 406
    return-object p1
.end method

.method private static getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 5

    .line 271
    if-nez p0, :cond_1

    .line 272
    nop

    .line 273
    if-nez p1, :cond_0

    .line 275
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 276
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_0

    .line 278
    :cond_0
    :goto_1
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0

    .line 280
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J

    move-result-wide v0

    .line 281
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    monitor-enter v2

    .line 282
    :try_start_1
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 283
    if-eqz v3, :cond_2

    .line 284
    monitor-exit v2

    return-object v3

    .line 286
    :cond_2
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 287
    if-eqz v3, :cond_3

    .line 288
    sget-object p1, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p1, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 289
    monitor-exit v2

    return-object v3

    .line 291
    :cond_3
    nop

    .line 292
    nop

    .line 293
    instance-of v3, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v3, :cond_5

    .line 294
    move-object v3, p0

    check-cast v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 295
    if-nez p1, :cond_4

    iget-object p1, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 296
    :cond_4
    iget-boolean v3, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-eqz v3, :cond_5

    const/4 p2, 0x1

    .line 298
    :cond_5
    if-nez p1, :cond_6

    .line 300
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 301
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v3

    goto :goto_2

    .line 303
    :cond_6
    :goto_3
    :try_start_3
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 304
    sget-object p2, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p2, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 305
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-interface {p0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 306
    monitor-exit v2

    return-object p1

    .line 307
    :catchall_2
    move-exception p0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw p0
.end method

.method private static getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 3

    .line 311
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    .line 312
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    goto :goto_0

    .line 313
    :cond_0
    move-object p0, v0

    .line 314
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v1

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    invoke-static {p0, v0, v1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0
.end method

.method public static getSelectedProfile()I
    .locals 4

    .line 171
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 172
    if-nez v1, :cond_0

    return v0

    .line 173
    :cond_0
    const-string v2, "com.motorola.camera.post_processing_profile"

    const-string v3, "0"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 174
    if-nez v1, :cond_1

    return v0

    .line 175
    :cond_1
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 176
    if-ltz v1, :cond_2

    const/16 v2, 0x9

    if-gt v1, v2, :cond_2

    move v0, v1

    :cond_2
    return v0

    .line 177
    :catchall_0
    move-exception v1

    .line 178
    return v0
.end method

.method public static gradePixelBufferStrips([IIIIII)Z
    .locals 6

    .line 740
    if-eqz p0, :cond_2

    if-lez p1, :cond_2

    if-lez p2, :cond_2

    if-lez p3, :cond_2

    if-gtz p5, :cond_0

    goto :goto_0

    .line 741
    :cond_0
    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_1

    const/4 p0, 0x0

    return p0

    .line 742
    :cond_1
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$3;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$3;-><init>([II)V

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIII)Z

    move-result p0

    return p0

    .line 740
    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private static gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIII)Z
    .locals 23

    .line 663
    move-object/from16 v0, p0

    move/from16 v6, p2

    move/from16 v8, p3

    if-eqz v0, :cond_a

    if-lez p1, :cond_a

    if-lez v6, :cond_a

    if-lez v8, :cond_a

    if-gtz p5, :cond_0

    const/16 v18, 0x1

    goto/16 :goto_8

    .line 664
    :cond_0
    const/4 v10, 0x0

    move/from16 v1, p4

    invoke-static {v10, v1}, Ljava/lang/Math;->max(II)I

    move-result v11

    .line 666
    new-instance v12, Ljava/util/ArrayList;

    const/4 v13, 0x4

    invoke-direct {v12, v13}, Ljava/util/ArrayList;-><init>(I)V

    .line 667
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14, v13}, Ljava/util/ArrayList;-><init>(I)V

    .line 668
    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15, v13}, Ljava/util/ArrayList;-><init>(I)V

    .line 669
    nop

    .line 670
    nop

    .line 671
    nop

    .line 673
    const/16 v16, 0x0

    move v3, v6

    move v1, v10

    move/from16 v17, v1

    move-object/from16 v2, v16

    :goto_0
    if-ge v1, v6, :cond_9

    .line 674
    sub-int v4, v6, v1

    invoke-static {v8, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 675
    sub-int v5, v1, v11

    invoke-static {v10, v5}, Ljava/lang/Math;->max(II)I

    move-result v7

    .line 676
    add-int v5, v1, v4

    const/16 v18, 0x1

    add-int v9, v5, v11

    invoke-static {v6, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 677
    sub-int v13, v9, v7

    .line 678
    sub-int v19, v1, v7

    mul-int v10, v19, p1

    .line 679
    move/from16 v19, v5

    mul-int v5, p1, v13

    new-array v5, v5, [I

    .line 680
    const/4 v6, 0x0

    invoke-interface {v0, v7, v13, v5, v6}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    .line 682
    if-eqz v2, :cond_2

    add-int v6, v3, v17

    if-ge v7, v6, :cond_2

    .line 683
    invoke-static {v7, v3}, Ljava/lang/Math;->max(II)I

    move-result v21

    .line 684
    invoke-static {v9, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 685
    sub-int v6, v6, v21

    .line 686
    if-lez v6, :cond_1

    .line 687
    sub-int v9, v21, v3

    mul-int v9, v9, p1

    sub-int v21, v21, v7

    move/from16 v22, v3

    mul-int v3, v21, p1

    mul-int v6, v6, p1

    invoke-static {v2, v9, v5, v3, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_1

    .line 686
    :cond_1
    move/from16 v22, v3

    goto :goto_1

    .line 682
    :cond_2
    move/from16 v22, v3

    .line 693
    :goto_1
    invoke-interface {v12, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 694
    filled-new-array {v1, v4, v10}, [I

    move-result-object v3

    invoke-interface {v14, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 695
    nop

    .line 696
    nop

    .line 697
    sget-object v9, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    move v10, v1

    new-instance v1, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;

    move/from16 v3, p1

    move/from16 v6, p2

    move v4, v13

    move/from16 v13, v19

    move/from16 v19, v10

    move-object v10, v2

    move-object v2, v5

    move/from16 v5, p5

    invoke-direct/range {v1 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;-><init>([IIIIII)V

    invoke-interface {v9, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v1

    invoke-interface {v15, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 700
    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x4

    if-eq v1, v2, :cond_4

    if-lt v13, v6, :cond_3

    goto :goto_2

    :cond_3
    const/4 v1, 0x0

    goto :goto_3

    :cond_4
    :goto_2
    move/from16 v1, v18

    .line 701
    :goto_3
    if-eqz v1, :cond_8

    .line 702
    nop

    .line 703
    nop

    .line 704
    nop

    .line 705
    nop

    .line 706
    if-ge v13, v6, :cond_5

    if-lez v11, :cond_5

    .line 707
    invoke-static {v11, v13}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 708
    sub-int v5, v13, v1

    .line 709
    mul-int v3, p1, v1

    new-array v3, v3, [I

    .line 710
    const/4 v4, 0x0

    invoke-interface {v0, v5, v1, v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    move/from16 v17, v1

    goto :goto_4

    .line 712
    :cond_5
    move v5, v13

    move-object/from16 v3, v16

    const/16 v17, 0x0

    :goto_4
    const/4 v1, 0x0

    :goto_5
    invoke-interface {v15}, Ljava/util/List;->size()I

    move-result v4

    if-ge v1, v4, :cond_7

    .line 714
    :try_start_0
    invoke-interface {v15, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/concurrent/Future;

    invoke-interface {v4}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 723
    nop

    .line 724
    invoke-interface {v14, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 725
    const/16 v20, 0x0

    aget v7, v4, v20

    aget v9, v4, v18

    invoke-interface {v12, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, [I

    const/4 v13, 0x2

    aget v4, v4, v13

    invoke-interface {v0, v7, v9, v10, v4}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->writeRows(II[II)V

    .line 712
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 721
    :catch_0
    move-exception v0

    .line 722
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-virtual {v0}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 715
    :catch_1
    move-exception v0

    .line 716
    add-int/lit8 v1, v1, 0x1

    :goto_6
    invoke-interface {v15}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_6

    .line 717
    invoke-interface {v15, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/Future;

    move/from16 v2, v18

    invoke-interface {v0, v2}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 716
    add-int/lit8 v1, v1, 0x1

    const/16 v18, 0x1

    goto :goto_6

    .line 719
    :cond_6
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 720
    const/16 v20, 0x0

    return v20

    .line 727
    :cond_7
    const/16 v20, 0x0

    .line 728
    nop

    .line 729
    nop

    .line 730
    invoke-interface {v12}, Ljava/util/List;->clear()V

    .line 731
    invoke-interface {v14}, Ljava/util/List;->clear()V

    .line 732
    invoke-interface {v15}, Ljava/util/List;->clear()V

    move-object v10, v3

    move v3, v5

    goto :goto_7

    .line 701
    :cond_8
    const/16 v20, 0x0

    move/from16 v3, v22

    .line 673
    :goto_7
    add-int v1, v19, v8

    move v13, v2

    move-object v2, v10

    move/from16 v10, v20

    goto/16 :goto_0

    .line 735
    :cond_9
    const/16 v18, 0x1

    return v18

    .line 663
    :cond_a
    const/16 v18, 0x1

    :goto_8
    return v18
.end method

.method public static initPostProcPreference(Landroidx/preference/PreferenceFragmentCompat;)V
    .locals 5

    .line 152
    const-string v0, "com.motorola.camera.post_processing_profile"

    if-nez p0, :cond_0

    return-void

    .line 154
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object p0

    check-cast p0, Landroidx/preference/ListPreference;

    .line 155
    if-nez p0, :cond_1

    return-void

    .line 156
    :cond_1
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    invoke-virtual {p0, v1}, Landroidx/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 157
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    iput-object v1, p0, Landroidx/preference/ListPreference;->mEntryValues:[Ljava/lang/CharSequence;

    .line 158
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 159
    const-string v2, "0"

    if-eqz v1, :cond_2

    :try_start_1
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v2

    .line 160
    :goto_0
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_4

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x30

    if-lt v3, v4, :cond_4

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v3, 0x39

    if-le v1, v3, :cond_3

    goto :goto_1

    :cond_3
    move-object v2, v0

    goto :goto_2

    .line 161
    :cond_4
    :goto_1
    nop

    .line 163
    :goto_2
    invoke-virtual {p0, v2}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 166
    goto :goto_3

    .line 164
    :catchall_0
    move-exception p0

    .line 165
    const-string v0, "CustomImagingBridge"

    const-string v1, "initPostProcPreference failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 167
    :goto_3
    return-void
.end method

.method public static isCustomLutActive()Z
    .locals 3

    .line 560
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v1

    const/4 v2, 0x5

    aget v1, v1, v2

    if-lez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static isCustomLutActive(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Z
    .locals 2

    .line 564
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 565
    return v0

    .line 567
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    iget-object p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v1, 0x5

    aget p0, p0, v1

    if-lez p0, :cond_1

    const/4 v0, 0x1

    :cond_1
    return v0
.end method

.method private static isFlashExpectedSafe()Z
    .locals 1

    .line 205
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->isFlashExpected()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 206
    :catchall_0
    move-exception v0

    .line 207
    const/4 v0, 0x0

    return v0
.end method

.method private static isUiSpecialModeSafe()Z
    .locals 2

    .line 213
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isSuperNightMode()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :cond_1
    return v0

    .line 214
    :catchall_0
    move-exception v1

    .line 215
    return v0
.end method

.method static synthetic lambda$exportCleanBayerJpeg$1([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 0

    .line 785
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    return-void
.end method

.method static synthetic lambda$gradeSurfaceInBatches$0([IIIIII)V
    .locals 7

    .line 698
    move v4, p1

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIIIIII)V

    return-void
.end method

.method public static overrideSceneMode(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)Lcom/motorola/camera/mcf/Mcf$SceneMode;
    .locals 3

    .line 319
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 320
    return-object p0

    .line 322
    :cond_0
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-nez p1, :cond_2

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    move p1, v1

    goto :goto_1

    :cond_2
    :goto_0
    move p1, v0

    .line 323
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    .line 324
    invoke-static {p0, p1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 325
    iget-object v2, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget v2, v2, v1

    if-ne v2, v0, :cond_3

    .line 326
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->HAL_FRAME_STACK:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    return-object p0

    .line 328
    :cond_3
    iget-object p1, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget p1, p1, v1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_4

    .line 329
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->RAW_HDR:Lcom/motorola/camera/mcf/Mcf$SceneMode;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 333
    :cond_4
    goto :goto_2

    .line 331
    :catchall_0
    move-exception p1

    .line 332
    const-string v0, "CustomImagingBridge"

    const-string v1, "overrideSceneMode fallback"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 334
    :goto_2
    return-object p0
.end method

.method private static resolveActiveScene(Z)[I
    .locals 2

    .line 260
    if-nez p0, :cond_1

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    .line 261
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v0

    .line 262
    nop

    .line 264
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 265
    goto :goto_2

    :catchall_0
    move-exception v1

    const/4 v1, 0x0

    .line 266
    :goto_2
    invoke-static {v1, p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    iget-object p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    return-object p0
.end method

.method private static resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 21

    .line 220
    nop

    .line 221
    nop

    .line 223
    const/high16 v1, 0x3f800000    # 1.0f

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraType()Lcom/motorola/camera/settings/CameraType;

    move-result-object v0

    .line 224
    if-eqz v0, :cond_0

    .line 225
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getZoomValue(Lcom/motorola/camera/settings/CameraType;)F

    move-result v0

    .line 227
    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    const v2, 0x3b03126f    # 0.002f

    cmpl-float v2, v0, v2

    if-lez v2, :cond_0

    div-float/2addr v1, v0

    goto :goto_0

    .line 229
    :catchall_0
    move-exception v0

    :cond_0
    :goto_0
    move v3, v1

    .line 231
    const/high16 v1, 0x42480000    # 50.0f

    :try_start_1
    invoke-static {}, Lcom/motorola/camera/IqConfigManager;->getInstance()Lcom/motorola/camera/IqConfigManager;

    move-result-object v0

    .line 233
    if-eqz v0, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    const/4 v4, 0x0

    cmpl-float v2, v2, v4

    if-lez v2, :cond_1

    .line 234
    iget v0, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move v1, v0

    goto :goto_1

    .line 236
    :catchall_1
    move-exception v0

    :cond_1
    :goto_1
    move v4, v1

    .line 238
    const-string v0, ""

    if-eqz p0, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/Mcf$SceneMode;->name()Ljava/lang/String;

    move-result-object v1

    move-object v5, v1

    goto :goto_2

    :cond_2
    move-object v5, v0

    .line 239
    :goto_2
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v2

    .line 240
    sget-boolean v8, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    move/from16 v6, p1

    move/from16 v7, p2

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtended(IFFLjava/lang/String;ZZZ)[I

    move-result-object v1

    .line 241
    const/high16 v6, 0x41200000    # 10.0f

    mul-float/2addr v3, v6

    .line 242
    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v3, v6

    .line 243
    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    const/4 v6, 0x0

    aget v6, v1, v6

    const/4 v7, 0x1

    aget v8, v1, v7

    const/4 v9, 0x2

    aget v9, v1, v9

    const/4 v10, 0x3

    aget v10, v1, v10

    const/4 v11, 0x4

    aget v11, v1, v11

    const/4 v12, 0x5

    aget v12, v1, v12

    const/4 v13, 0x6

    aget v13, v1, v13

    .line 246
    const/4 v14, 0x7

    aget v15, v1, v14

    if-ltz v15, :cond_3

    aget v14, v1, v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " isz="

    invoke-virtual {v15, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    goto :goto_3

    :cond_3
    move-object v7, v0

    .line 247
    :goto_3
    const/16 v14, 0x8

    aget v15, v1, v14

    if-ltz v15, :cond_4

    aget v14, v1, v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v16, v0

    const-string v0, " aide="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_4
    move-object/from16 v16, v0

    .line 248
    :goto_4
    const/16 v14, 0x9

    aget v15, v1, v14

    if-lez v15, :cond_5

    aget v15, v1, v14

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v17, v1

    const-string v1, " vsr="

    invoke-virtual {v14, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_5

    :cond_5
    move-object/from16 v17, v1

    move-object/from16 v1, v16

    .line 249
    :goto_5
    const/16 v14, 0xa

    aget v15, v17, v14

    if-ltz v15, :cond_6

    aget v14, v17, v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v1

    const-string v1, " hdr="

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_6

    :cond_6
    move-object/from16 v18, v1

    move-object/from16 v1, v16

    .line 250
    :goto_6
    const/16 v14, 0xb

    aget v14, v17, v14

    const/4 v15, 0x1

    if-ne v14, v15, :cond_7

    const-string v14, " t2w=0"

    goto :goto_7

    :cond_7
    move-object/from16 v14, v16

    .line 251
    :goto_7
    const/16 v19, 0xc

    move-object/from16 p0, v14

    aget v14, v17, v19

    if-ne v14, v15, :cond_8

    const-string v14, " qll=1"

    goto :goto_8

    :cond_8
    move-object/from16 v14, v16

    .line 252
    :goto_8
    const/16 v15, 0x9

    if-ne v2, v15, :cond_9

    const-string v15, " mcf=0"

    goto :goto_9

    :cond_9
    move-object/from16 v15, v16

    .line 253
    :goto_9
    sget-boolean v19, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    if-nez v19, :cond_a

    const-string v19, " htp=0"

    move-object/from16 v20, v19

    goto :goto_a

    :cond_a
    move-object/from16 v20, v16

    .line 254
    :goto_a
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v19

    if-eqz v19, :cond_b

    move-object/from16 p2, v14

    move-object/from16 v19, v15

    move-object/from16 v5, v16

    goto :goto_b

    :cond_b
    move-object/from16 v19, v15

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p2, v14

    const-string v14, " in="

    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 255
    :goto_b
    if-eqz p1, :cond_c

    const-string v14, " flash=1"

    goto :goto_c

    :cond_c
    move-object/from16 v14, v16

    :goto_c
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v16, v14

    const-string v14, "Edge50Port v1.4.0 p="

    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v14, " z="

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " lux="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " act="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " nr="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " edge="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " mfnr="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " sz="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " lut="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " raw="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v2, v18

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v14, p0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v14, p2

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v15, v19

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v14, v16

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 256
    new-instance v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-object/from16 v2, v17

    invoke-direct {v1, v2, v0}, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;-><init>([ILjava/lang/String;)V

    return-object v1
.end method

.method public static resolveEdgeMode(I)I
    .locals 2

    .line 343
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x2

    aget v0, v0, v1

    .line 344
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveEnableMfnr(Z)Z
    .locals 1

    .line 353
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveEnableMfnr(ZZ)Z

    move-result p0

    return p0
.end method

.method public static resolveEnableMfnr(ZZ)Z
    .locals 1

    .line 357
    invoke-static {p1}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object p1

    const/4 v0, 0x3

    aget p1, p1, v0

    .line 358
    if-ltz p1, :cond_1

    if-eqz p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :cond_1
    :goto_0
    return p0
.end method

.method public static resolveJpegQuality(I)I
    .locals 1

    .line 187
    const/16 v0, 0x5f

    if-ne p0, v0, :cond_0

    const/16 p0, 0x62

    :cond_0
    return p0
.end method

.method public static resolveNoiseReduction(I)I
    .locals 2

    .line 338
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    .line 339
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveSuperZoom(B)B
    .locals 2

    .line 348
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x4

    aget v0, v0, v1

    .line 349
    if-ltz v0, :cond_0

    int-to-byte p0, v0

    :cond_0
    return p0
.end method

.method private static runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 2

    .line 796
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 797
    :try_start_0
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    .line 798
    monitor-exit v1

    .line 799
    return-void

    .line 798
    :catchall_0
    move-exception v0

    move-object p0, v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private static runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 26

    .line 806
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v14, p3

    move-object/from16 v15, p5

    const-string v3, "FocalLength"

    const-string v4, "CustomImagingBridge"

    :try_start_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v16

    .line 807
    int-to-long v5, v1

    int-to-long v7, v2

    mul-long/2addr v5, v7

    const-wide/16 v7, 0x5

    mul-long/2addr v7, v5

    const-wide/16 v9, 0x4

    div-long/2addr v7, v9

    .line 808
    const-wide/16 v9, 0x2

    mul-long/2addr v5, v9

    .line 810
    array-length v9, v0

    int-to-long v9, v9

    cmp-long v5, v9, v5

    const/4 v6, 0x1

    if-ltz v5, :cond_0

    .line 811
    array-length v5, v0

    div-int/2addr v5, v2

    invoke-static {v0, v1, v2, v5, v6}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object v0

    move-object v5, v0

    goto :goto_0

    .line 812
    :cond_0
    array-length v5, v0

    int-to-long v9, v5

    cmp-long v5, v9, v7

    if-ltz v5, :cond_15

    .line 813
    array-length v5, v0

    div-int/2addr v5, v2

    invoke-static {v0, v1, v2, v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object v0

    move-object v5, v0

    .line 819
    :goto_0
    invoke-static/range {p4 .. p4}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v7

    .line 820
    nop

    .line 821
    const/4 v8, 0x4

    move-object v1, v5

    new-array v5, v8, [F

    const/high16 v0, 0x42800000    # 64.0f

    const/4 v9, 0x0

    aput v0, v5, v9

    aput v0, v5, v6

    const/4 v10, 0x2

    aput v0, v5, v10

    const/4 v11, 0x3

    aput v0, v5, v11

    .line 822
    nop

    .line 823
    nop

    .line 825
    if-eqz v7, :cond_4

    .line 826
    sget-object v13, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_COLOR_FILTER_ARRANGEMENT:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v13}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    .line 827
    if-eqz v13, :cond_1

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    goto :goto_1

    :cond_1
    move v13, v9

    .line 828
    :goto_1
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_BLACK_LEVEL_PATTERN:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/BlackLevelPattern;

    .line 829
    if-eqz v0, :cond_2

    .line 830
    invoke-virtual {v0, v9, v9}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v9

    .line 831
    invoke-virtual {v0, v6, v9}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v6

    .line 832
    invoke-virtual {v0, v9, v6}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v10

    .line 833
    invoke-virtual {v0, v6, v6}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v0

    int-to-float v0, v0

    aput v0, v5, v11

    .line 835
    :cond_2
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_WHITE_LEVEL:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 836
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-lez v8, :cond_3

    .line 837
    invoke-virtual {v0}, Ljava/lang/Integer;->floatValue()F

    move-result v0

    goto :goto_2

    .line 839
    :cond_3
    const v0, 0x447fc000    # 1023.0f

    :goto_2
    sget-object v8, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_COLOR_TRANSFORM1:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v8}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-static {v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v8

    invoke-static {v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->sensorTransformToSrgbCcm([F)[F

    move-result-object v8

    move-object/from16 v25, v8

    move v8, v0

    move-object/from16 v0, v25

    goto :goto_3

    .line 825
    :cond_4
    move v13, v9

    const/4 v0, 0x0

    const v8, 0x447fc000    # 1023.0f

    .line 842
    :goto_3
    move/from16 v19, v6

    sget-object v6, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v6}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 843
    if-eqz v6, :cond_5

    .line 844
    invoke-static {v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v6

    .line 845
    if-eqz v6, :cond_5

    goto :goto_4

    .line 848
    :cond_5
    move-object v6, v0

    :goto_4
    new-array v11, v11, [F

    const v0, 0x3fe66666    # 1.8f

    aput v0, v11, v9

    const/high16 v0, 0x3f800000    # 1.0f

    aput v0, v11, v19

    const v0, 0x3fcccccd    # 1.6f

    aput v0, v11, v10

    .line 849
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_GAINS:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 850
    if-eqz v0, :cond_6

    .line 851
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result v20

    aput v20, v11, v9

    .line 852
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v20

    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v21

    add-float v20, v20, v21

    const/high16 v21, 0x3f000000    # 0.5f

    mul-float v20, v20, v21

    aput v20, v11, v19

    .line 853
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result v0

    aput v0, v11, v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_a

    .line 856
    :cond_6
    nop

    .line 857
    nop

    .line 858
    nop

    .line 860
    :try_start_1
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->STATISTICS_LENS_SHADING_CORRECTION_MAP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/LensShadingMap;

    .line 861
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v12

    if-lt v12, v10, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v12

    if-lt v12, v10, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v10

    if-lez v10, :cond_7

    .line 862
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v10
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 863
    :try_start_2
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v12
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 864
    :try_start_3
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v9

    new-array v9, v9, [F
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 865
    move-object/from16 v21, v1

    const/4 v1, 0x0

    :try_start_4
    invoke-virtual {v0, v9, v1}, Landroid/hardware/camera2/params/LensShadingMap;->copyGainFactors([FI)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_6

    .line 867
    :catchall_0
    move-exception v0

    goto :goto_6

    :catchall_1
    move-exception v0

    move-object/from16 v21, v1

    const/4 v1, 0x0

    goto :goto_5

    :catchall_2
    move-exception v0

    move-object/from16 v21, v1

    move v1, v9

    move v12, v1

    goto :goto_5

    .line 861
    :cond_7
    move-object/from16 v21, v1

    move v1, v9

    .line 867
    move v10, v1

    move v12, v10

    goto :goto_5

    :catchall_3
    move-exception v0

    move-object/from16 v21, v1

    move v1, v9

    move v10, v1

    move v12, v10

    :goto_5
    const/4 v9, 0x0

    :goto_6
    move-object/from16 v25, v9

    move-object v9, v7

    move-object v7, v11

    move v11, v10

    move-object/from16 v10, v25

    .line 869
    nop

    .line 871
    const/16 v20, 0x64

    :try_start_5
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 872
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v22

    if-lez v22, :cond_8

    .line 873
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    move/from16 v20, v0

    goto :goto_7

    .line 875
    :catchall_4
    move-exception v0

    :cond_8
    :goto_7
    nop

    .line 877
    move-object/from16 v22, v9

    const/high16 v9, 0x3e800000    # 0.25f

    move v1, v8

    move-object v8, v6

    move v6, v1

    move-object/from16 v24, v3

    move-object v14, v4

    move v4, v13

    move/from16 v13, v20

    move-object/from16 v1, v21

    move-object/from16 v23, v22

    const/16 v18, 0x4

    move v3, v2

    move/from16 v2, p1

    :try_start_6
    invoke-static/range {v1 .. v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII)[I

    move-result-object v0

    .line 880
    iget-object v1, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v2, 0x5

    aget v5, v1, v2

    .line 881
    if-lez v5, :cond_9

    .line 882
    const/16 v3, 0x200

    const/16 v4, 0x18

    move/from16 v1, p1

    move/from16 v2, p2

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradePixelBufferStrips([IIIIII)Z

    move-result v3

    if-nez v3, :cond_a

    .line 883
    const-string v0, "Abort CleanBayerRaw export because strip grading was interrupted"

    invoke-static {v14, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 884
    return-void

    .line 881
    :cond_9
    move/from16 v1, p1

    move/from16 v2, p2

    .line 888
    :cond_a
    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2, v3}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_9

    .line 889
    if-nez v3, :cond_b

    return-void

    .line 892
    :cond_b
    :try_start_7
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    mul-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x4

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 893
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x62

    invoke-virtual {v3, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_8

    if-nez v1, :cond_c

    .line 896
    :try_start_8
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_9

    .line 893
    return-void

    .line 894
    :cond_c
    :try_start_9
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_8

    .line 896
    :try_start_a
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 897
    nop

    .line 899
    move-object/from16 v1, p3

    move-object/from16 v2, p4

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2, v3}, Lcom/motorola/camera/utility/ExifUtility;->appendExifToJpeg([BLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/mcf/McfMetadata;Ljava/lang/String;[B)[B

    move-result-object v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_9

    .line 901
    :try_start_b
    iget-object v0, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 902
    if-eqz v2, :cond_12

    .line 903
    new-instance v3, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v4, Ljava/io/ByteArrayInputStream;

    invoke-direct {v4, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 904
    nop

    .line 905
    if-eqz v0, :cond_d

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_d

    .line 906
    const-string v4, "ImageDescription"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " cleanBayer=1"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v4, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 907
    move/from16 v6, v19

    goto :goto_8

    .line 909
    :cond_d
    const/4 v6, 0x0

    :goto_8
    move-object/from16 v4, v24

    invoke-virtual {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_10

    .line 910
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 911
    if-nez v0, :cond_f

    move-object/from16 v9, v23

    if-eqz v9, :cond_f

    .line 912
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_FOCAL_LENGTHS:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    .line 913
    if-eqz v1, :cond_e

    array-length v5, v1

    if-lez v5, :cond_e

    .line 914
    const/4 v5, 0x0

    aget v0, v1, v5

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto :goto_9

    .line 913
    :cond_e
    const/4 v5, 0x0

    goto :goto_9

    .line 911
    :cond_f
    const/4 v5, 0x0

    .line 917
    :goto_9
    if-eqz v0, :cond_11

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_11

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    const v7, 0x3dcccccd    # 0.1f

    cmpl-float v1, v1, v7

    if-lez v1, :cond_11

    .line 918
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    const/high16 v1, 0x42c80000    # 100.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/100"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v4, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 919
    move/from16 v6, v19

    goto :goto_a

    .line 909
    :cond_10
    const/4 v5, 0x0

    .line 922
    :cond_11
    :goto_a
    if-eqz v6, :cond_12

    .line 923
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, v2

    add-int/lit16 v1, v1, 0x400

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 924
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v3, v1, v0, v5}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 925
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 926
    array-length v1, v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    const/16 v3, 0x40

    if-le v1, v3, :cond_12

    .line 927
    move-object v2, v0

    goto :goto_b

    .line 931
    :catchall_5
    move-exception v0

    :cond_12
    :goto_b
    nop

    .line 933
    :try_start_c
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/storage/MediaFile;->fromMediaFilePath(Lcom/motorola/camera/storage/MediaFilePath;)Lcom/motorola/camera/storage/backend/MediaStoreMediaFile;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/storage/StorageUtils;->createMediaFileWithFallback(Lcom/motorola/camera/storage/MediaFile;)Lcom/motorola/camera/storage/MediaFile;

    move-result-object v0

    .line 934
    if-nez v0, :cond_13

    return-void

    .line 935
    :cond_13
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->getWriteFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    .line 936
    if-nez v1, :cond_14

    return-void

    .line 937
    :cond_14
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_9

    .line 938
    :try_start_d
    invoke-virtual {v3, v2}, Ljava/io/FileOutputStream;->write([B)V

    .line 939
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_6

    .line 940
    :try_start_e
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    .line 941
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->finish()V

    .line 942
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sub-long v0, v0, v16

    const-wide/32 v3, 0xf4240

    div-long/2addr v0, v3

    .line 943
    array-length v2, v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CleanBayerRaw async saved "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v4, p6

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "B) in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v14, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_9

    .line 946
    goto :goto_e

    .line 937
    :catchall_6
    move-exception v0

    move-object v1, v0

    :try_start_f
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    goto :goto_c

    :catchall_7
    move-exception v0

    :try_start_10
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_c
    throw v1

    .line 896
    :catchall_8
    move-exception v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 897
    throw v0

    .line 815
    :cond_15
    move-object v14, v4

    array-length v0, v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Raw buffer too small: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v14, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_9

    .line 816
    return-void

    .line 944
    :catchall_9
    move-exception v0

    goto :goto_d

    :catchall_a
    move-exception v0

    move-object v14, v4

    .line 945
    :goto_d
    const-string v1, "runCleanBayerExport failed cleanly (DNG unaffected)"

    invoke-static {v14, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 947
    :goto_e
    return-void
.end method

.method private static sensorTransformToSrgbCcm([F)[F
    .locals 26

    .line 962
    move-object/from16 v0, p0

    if-eqz v0, :cond_5

    array-length v2, v0

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    const/16 v23, 0x0

    goto/16 :goto_3

    .line 963
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    const/4 v5, 0x1

    aget v6, v0, v5

    const/4 v7, 0x2

    aget v8, v0, v7

    .line 964
    const/4 v9, 0x3

    aget v10, v0, v9

    const/4 v11, 0x4

    aget v12, v0, v11

    const/4 v13, 0x5

    aget v14, v0, v13

    .line 965
    const/4 v15, 0x6

    aget v16, v0, v15

    const/16 v17, 0x7

    aget v18, v0, v17

    const/16 v19, 0x8

    aget v0, v0, v19

    .line 966
    mul-float v20, v12, v0

    mul-float v21, v14, v18

    sub-float v20, v20, v21

    mul-float v21, v10, v0

    mul-float v22, v14, v16

    const/16 v23, 0x0

    sub-float v1, v21, v22

    neg-float v1, v1

    mul-float v21, v10, v18

    mul-float v22, v12, v16

    sub-float v21, v21, v22

    .line 967
    mul-float v22, v6, v0

    mul-float v24, v8, v18

    move/from16 v25, v2

    sub-float v2, v22, v24

    neg-float v2, v2

    mul-float/2addr v0, v4

    mul-float v22, v8, v16

    sub-float v0, v0, v22

    mul-float v18, v18, v4

    mul-float v16, v16, v6

    move/from16 v22, v5

    sub-float v5, v18, v16

    neg-float v5, v5

    .line 968
    mul-float v16, v6, v14

    mul-float v18, v8, v12

    sub-float v16, v16, v18

    mul-float/2addr v14, v4

    mul-float v18, v8, v10

    sub-float v14, v14, v18

    neg-float v14, v14

    mul-float/2addr v12, v4

    mul-float/2addr v10, v6

    sub-float/2addr v12, v10

    .line 969
    mul-float v4, v4, v20

    mul-float/2addr v6, v1

    add-float/2addr v4, v6

    mul-float v8, v8, v21

    add-float/2addr v4, v8

    .line 970
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v8, 0x3727c5ac    # 1.0E-5f

    cmpg-float v6, v6, v8

    if-gez v6, :cond_1

    goto :goto_2

    .line 971
    :cond_1
    const/high16 v6, 0x3f800000    # 1.0f

    div-float/2addr v6, v4

    .line 973
    mul-float v20, v20, v6

    mul-float/2addr v2, v6

    mul-float v16, v16, v6

    mul-float/2addr v1, v6

    mul-float/2addr v0, v6

    mul-float/2addr v14, v6

    mul-float v21, v21, v6

    mul-float/2addr v5, v6

    mul-float/2addr v12, v6

    new-array v4, v3, [F

    aput v20, v4, v25

    aput v2, v4, v22

    aput v16, v4, v7

    aput v1, v4, v9

    aput v0, v4, v11

    aput v14, v4, v13

    aput v21, v4, v15

    aput v5, v4, v17

    aput v12, v4, v19

    .line 978
    new-array v0, v3, [F

    fill-array-data v0, :array_0

    .line 983
    new-array v1, v3, [F

    .line 984
    move/from16 v2, v25

    :goto_0
    if-ge v2, v9, :cond_3

    .line 985
    move/from16 v3, v25

    :goto_1
    if-ge v3, v9, :cond_2

    .line 986
    mul-int/lit8 v5, v2, 0x3

    add-int v6, v5, v3

    aget v8, v0, v5

    aget v10, v4, v3

    mul-float/2addr v8, v10

    add-int/lit8 v10, v5, 0x1

    aget v10, v0, v10

    add-int/lit8 v11, v3, 0x3

    aget v11, v4, v11

    mul-float/2addr v10, v11

    add-float/2addr v8, v10

    add-int/2addr v5, v7

    aget v5, v0, v5

    add-int/lit8 v10, v3, 0x6

    aget v10, v4, v10

    mul-float/2addr v5, v10

    add-float/2addr v8, v5

    aput v8, v1, v6

    .line 985
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 984
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 991
    :cond_3
    return-object v1

    .line 970
    :cond_4
    :goto_2
    return-object v23

    .line 962
    :cond_5
    const/16 v23, 0x0

    :goto_3
    return-object v23

    nop

    :array_0
    .array-data 4
        0x404f65fe
        -0x403b3d08    # -1.5372f
        -0x4100b780    # -0.4986f
        -0x4087f62b    # -0.9689f
        0x3ff01a37    # 1.8758f
        0x3d29fbe7    # 0.0415f
        0x3d6425af    # 0.0557f
        -0x41af1aa0    # -0.204f
        0x3f874bc7    # 1.057f
    .end array-data
.end method

.method private static setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Landroid/hardware/camera2/CaptureRequest$Builder;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "TT;>;TT;)V"
        }
    .end annotation

    .line 411
    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_1

    .line 415
    :cond_0
    :try_start_0
    new-instance p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-direct {p1, p2, p3}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 416
    invoke-virtual {p0, p1, p4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 417
    :catchall_0
    move-exception p0

    :goto_0
    nop

    .line 418
    return-void

    .line 412
    :cond_1
    :goto_1
    return-void
.end method

.method public static shouldAllowInSensorCrop()Z
    .locals 3

    .line 362
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v1

    const/4 v2, 0x3

    aget v1, v1, v2

    .line 363
    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method public static shouldAllowMcf(Z)Z
    .locals 1

    .line 183
    if-eqz p0, :cond_0

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result p0

    const/16 v0, 0x9

    if-eq p0, v0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static toByteArray(Ljava/nio/ByteBuffer;)[B
    .locals 1

    .line 995
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 996
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 997
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 998
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 999
    return-object v0
.end method
