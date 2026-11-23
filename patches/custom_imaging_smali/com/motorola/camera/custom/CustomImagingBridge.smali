.class public final Lcom/motorola/camera/custom/CustomImagingBridge;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;,
        Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;,
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

.field private static final KNOWN_SESSION_KEYS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

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
    .locals 15

    .line 73
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->checkAdspRpcReadable()Z

    move-result v0

    sput-boolean v0, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    .line 91
    nop

    .line 92
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

    .line 91
    invoke-static {v0, v3}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 94
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

    .line 99
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    .line 133
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    .line 134
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$1;

    const/16 v3, 0x40

    const/high16 v4, 0x3f400000    # 0.75f

    invoke-direct {v0, v3, v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$1;-><init>(IFZ)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    .line 141
    const/16 v0, 0xb

    new-array v3, v0, [Ljava/lang/CharSequence;

    const-string v4, "Auto (W/O Stock \u00b7 Clean HAL + LTM)"

    const/4 v6, 0x0

    aput-object v4, v3, v6

    const-string v4, "Auto (W/ Stock \u00b7 Native SuperRes/ISP)"

    aput-object v4, v3, v5

    const-string v4, "Natural ZSL (NR ZSL / Edge ZSL)"

    aput-object v4, v3, v1

    const-string v4, "Minimal ISP (NR Minimal / Edge Off)"

    const/4 v7, 0x3

    aput-object v4, v3, v7

    const-string v4, "Detail HDR (RAW HDR / Low Halo)"

    aput-object v4, v3, v2

    const-string v4, "Pure ISP (MFNR Off / NR Off)"

    const/4 v8, 0x5

    aput-object v4, v3, v8

    const-string v4, "iPhone Natural (Apple Style LUT)"

    const/4 v9, 0x6

    aput-object v4, v3, v9

    const-string v4, "iPhone Rich Contrast (Apple Style)"

    const/4 v10, 0x7

    aput-object v4, v3, v10

    const-string v4, "iPhone Amber (Warm Photonic LUT)"

    const/16 v11, 0x8

    aput-object v4, v3, v11

    const-string v4, "Clean RAW Bayer (DNG -> Clean JPG)"

    const/16 v12, 0x9

    aput-object v4, v3, v12

    const-string v4, "Disable Post Processing (MCF Off / Direct HAL)"

    const/16 v13, 0xa

    aput-object v4, v3, v13

    sput-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 155
    new-array v3, v0, [Ljava/lang/CharSequence;

    const-string v4, "0"

    aput-object v4, v3, v6

    const-string v4, "10"

    aput-object v4, v3, v5

    const-string v4, "1"

    aput-object v4, v3, v1

    const-string v4, "2"

    aput-object v4, v3, v7

    const-string v4, "3"

    aput-object v4, v3, v2

    const-string v4, "4"

    aput-object v4, v3, v8

    const-string v4, "5"

    aput-object v4, v3, v9

    const-string v4, "6"

    aput-object v4, v3, v10

    const-string v4, "7"

    aput-object v4, v3, v11

    const-string v4, "8"

    aput-object v4, v3, v12

    const-string v4, "9"

    aput-object v4, v3, v13

    sput-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    .line 397
    new-instance v3, Ljava/util/HashSet;

    const/16 v4, 0xd

    new-array v4, v4, [Ljava/lang/String;

    const-string v14, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    aput-object v14, v4, v6

    const-string v6, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    aput-object v6, v4, v5

    const-string v5, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    aput-object v5, v4, v1

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    aput-object v1, v4, v7

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    aput-object v1, v4, v2

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    aput-object v1, v4, v8

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    aput-object v1, v4, v9

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    aput-object v1, v4, v10

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    aput-object v1, v4, v11

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    aput-object v1, v4, v12

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    aput-object v1, v4, v13

    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    aput-object v1, v4, v0

    const/16 v0, 0xc

    const-string v1, "com.lenovo.moto.SATFallback.T2W"

    aput-object v1, v4, v0

    invoke-static {v4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-direct {v3, v0}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    invoke-static {v3}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->KNOWN_SESSION_KEYS:Ljava/util/Set;

    .line 413
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 414
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 415
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 416
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    .line 415
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 159
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 1

    .line 485
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V

    .line 486
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V
    .locals 16

    .line 490
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    if-eqz v1, :cond_12

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 492
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v3

    .line 493
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->FLASH_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 494
    const/4 v5, 0x3

    const/4 v6, 0x1

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-eqz v4, :cond_1

    .line 495
    move v3, v6

    goto :goto_0

    .line 497
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 498
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-ne v4, v5, :cond_2

    .line 499
    move v3, v6

    .line 502
    :cond_2
    :goto_0
    nop

    .line 503
    instance-of v4, v2, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v4, :cond_3

    .line 504
    move-object v4, v2

    check-cast v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 505
    iget-object v7, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 506
    iget-boolean v4, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z

    if-eqz v4, :cond_4

    .line 507
    move v3, v6

    goto :goto_1

    .line 503
    :cond_3
    const/4 v7, 0x0

    .line 511
    :cond_4
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v4

    invoke-static {v2, v7, v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v2

    .line 512
    iget-object v2, v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 513
    aget v4, v2, v6

    .line 514
    const/4 v7, 0x2

    aget v8, v2, v7

    .line 515
    aget v5, v2, v5

    .line 517
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v9

    .line 518
    const/4 v10, 0x0

    if-eqz v9, :cond_10

    .line 519
    if-ltz v4, :cond_5

    .line 520
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [I

    .line 521
    invoke-static {v11, v4}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 522
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v1, v11, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 525
    :cond_5
    if-ltz v8, :cond_6

    .line 526
    sget-object v4, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v4}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 527
    invoke-static {v4, v8}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 528
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v1, v4, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 536
    :cond_6
    invoke-static {v9, v10}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v4

    .line 537
    invoke-static {v9, v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v8

    .line 539
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_7

    .line 540
    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v4

    goto :goto_2

    .line 542
    :cond_7
    new-instance v9, Ljava/util/HashSet;

    invoke-direct {v9, v4}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 543
    invoke-interface {v9, v8}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 545
    invoke-interface {v8}, Ljava/util/Set;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_8

    .line 546
    sget-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->KNOWN_SESSION_KEYS:Ljava/util/Set;

    invoke-interface {v9, v4}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 549
    :cond_8
    move-object v4, v9

    :goto_2
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_10

    array-length v8, v2

    const/16 v9, 0xd

    if-lt v8, v9, :cond_10

    .line 550
    const/4 v8, 0x7

    aget v8, v2, v8

    .line 551
    const/16 v9, 0x8

    aget v9, v2, v9

    .line 552
    const/16 v11, 0x9

    aget v11, v2, v11

    .line 553
    const/16 v12, 0xa

    aget v12, v2, v12

    .line 554
    const/16 v13, 0xb

    aget v13, v2, v13

    .line 555
    const/16 v14, 0xc

    aget v2, v2, v14

    .line 557
    if-ltz v8, :cond_9

    .line 558
    const-string v14, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    const-class v15, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v14, v15, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 559
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    const-class v14, Ljava/lang/Byte;

    int-to-byte v15, v8

    invoke-static {v15}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v15

    invoke-static {v1, v4, v7, v14, v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 560
    if-nez v8, :cond_9

    .line 561
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v7, v8, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 564
    :cond_9
    if-ltz v9, :cond_a

    .line 565
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v8, Ljava/lang/Byte;

    int-to-byte v9, v9

    invoke-static {v9}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 567
    :cond_a
    if-ltz v11, :cond_b

    .line 568
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 570
    :cond_b
    if-ltz v12, :cond_e

    .line 571
    if-lez v12, :cond_c

    move v7, v6

    goto :goto_3

    :cond_c
    move v7, v10

    .line 572
    :goto_3
    if-lez v12, :cond_d

    const/4 v8, 0x2

    goto :goto_4

    :cond_d
    move v8, v10

    .line 573
    :goto_4
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v9, v11, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 574
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v9, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 575
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 576
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 577
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-static {v1, v4, v7, v9, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 578
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 579
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 581
    :cond_e
    if-ne v13, v6, :cond_f

    .line 582
    const-string v6, "com.lenovo.moto.SATFallback.T2W"

    const-class v7, Ljava/lang/Byte;

    invoke-static {v10}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v8

    invoke-static {v1, v4, v6, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 584
    :cond_f
    if-ltz v2, :cond_10

    .line 585
    const-string v6, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v7, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v4, v6, v7, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 589
    :cond_10
    if-nez v5, :cond_11

    .line 590
    invoke-static {v0, v1, v10, v3}, Lcom/motorola/camera/fsm/camera/modes/RequestBuilderHelper;->setMfnr(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;ZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 594
    :cond_11
    goto :goto_5

    .line 592
    :catchall_0
    move-exception v0

    .line 593
    const-string v1, "CustomImagingBridge"

    const-string v2, "applyCaptureRequestOverrides failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 595
    :goto_5
    return-void

    .line 490
    :cond_12
    :goto_6
    return-void
.end method

.method public static applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 33

    .line 650
    move-object/from16 v1, p0

    const-string v2, "CustomImagingBridge"

    if-eqz v1, :cond_20

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_20

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_14

    .line 653
    :cond_0
    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v3

    .line 654
    iget-object v4, v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 655
    iget-object v0, v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v5, 0x5

    aget v5, v0, v5

    .line 656
    iget v6, v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    .line 657
    iget v7, v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    .line 658
    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 659
    if-nez v0, :cond_1

    .line 660
    return-void

    .line 663
    :cond_1
    :try_start_0
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v8

    .line 664
    array-length v0, v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_a

    const/16 v9, 0x10

    if-ge v0, v9, :cond_2

    return-void

    .line 666
    :cond_2
    nop

    .line 668
    :try_start_1
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v11, Ljava/io/ByteArrayInputStream;

    invoke-direct {v11, v8}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v11}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 669
    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v0, 0x0

    .line 672
    :goto_0
    const-string v11, "ImageDescription"

    if-eqz v0, :cond_3

    :try_start_2
    invoke-virtual {v0, v11}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    goto :goto_1

    :cond_3
    const/4 v12, 0x0

    .line 673
    :goto_1
    if-eqz v12, :cond_4

    const-string v13, "Edge50Port "

    invoke-virtual {v12, v13}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v12

    if-eqz v12, :cond_4

    .line 674
    return-void

    .line 677
    :cond_4
    const/4 v12, 0x1

    const/4 v13, 0x0

    if-nez v6, :cond_5

    if-gtz v5, :cond_5

    move/from16 v18, v12

    goto :goto_2

    :cond_5
    move/from16 v18, v13

    .line 678
    :goto_2
    nop

    .line 679
    nop

    .line 680
    nop

    .line 681
    const/4 v14, 0x2

    if-eqz v18, :cond_e

    .line 682
    const v15, 0x3fd9999a    # 1.7f

    cmpl-float v15, v7, v15

    if-ltz v15, :cond_6

    const v15, 0x403ccccd    # 2.95f

    cmpg-float v15, v7, v15

    if-gez v15, :cond_6

    iget v3, v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v15, 0x435c0000    # 220.0f

    cmpg-float v3, v3, v15

    if-ltz v3, :cond_7

    :cond_6
    const/high16 v3, 0x40c00000    # 6.0f

    cmpl-float v3, v7, v3

    if-ltz v3, :cond_8

    const/high16 v3, 0x41f00000    # 30.0f

    cmpg-float v3, v7, v3

    if-gtz v3, :cond_8

    :cond_7
    move v3, v12

    goto :goto_3

    :cond_8
    move v3, v13

    .line 684
    :goto_3
    if-eqz v0, :cond_a

    invoke-virtual {v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v15

    if-nez v15, :cond_9

    goto :goto_4

    :cond_9
    move v15, v13

    move/from16 v16, v15

    goto :goto_6

    .line 685
    :cond_a
    :goto_4
    invoke-static {v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->evaluateAutoPostGates([B)I

    move-result v15

    .line 686
    and-int/lit8 v16, v15, 0x1

    if-eqz v16, :cond_b

    move/from16 v16, v12

    goto :goto_5

    :cond_b
    move/from16 v16, v13

    .line 687
    :goto_5
    and-int/2addr v15, v14

    if-eqz v15, :cond_c

    move v15, v12

    goto :goto_6

    :cond_c
    move v15, v13

    .line 689
    :goto_6
    if-nez v16, :cond_d

    if-nez v15, :cond_d

    if-nez v3, :cond_d

    .line 690
    invoke-static {v1, v8, v0, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V

    .line 691
    return-void

    .line 698
    :cond_d
    move/from16 v32, v16

    move/from16 v16, v3

    move/from16 v3, v32

    goto :goto_7

    .line 693
    :cond_e
    if-gtz v5, :cond_f

    .line 694
    invoke-static {v1, v8, v0, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V

    .line 695
    return-void

    .line 693
    :cond_f
    move v3, v13

    move v15, v3

    move/from16 v16, v15

    .line 698
    :goto_7
    new-instance v10, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v10}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 699
    iput-boolean v12, v10, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 700
    move/from16 v19, v12

    sget-object v12, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v12, v10, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 701
    array-length v12, v8

    invoke-static {v8, v13, v12, v10}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v10
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_a

    .line 702
    if-nez v10, :cond_10

    return-void

    .line 705
    :cond_10
    :try_start_3
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v12
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_8

    if-nez v12, :cond_11

    .line 783
    :try_start_4
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_a

    .line 705
    return-void

    .line 706
    :cond_11
    :try_start_5
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v12

    .line 707
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v13

    .line 708
    if-lez v12, :cond_1f

    if-gtz v13, :cond_12

    move-object v1, v2

    move-object v3, v10

    goto/16 :goto_10

    .line 710
    :cond_12
    new-instance v14, Lcom/motorola/camera/custom/CustomImagingBridge$2;

    invoke-direct {v14, v10, v12}, Lcom/motorola/camera/custom/CustomImagingBridge$2;-><init>(Landroid/graphics/Bitmap;I)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_8

    .line 723
    if-eqz v18, :cond_17

    .line 724
    nop

    .line 725
    nop

    .line 726
    nop

    .line 727
    nop

    .line 728
    if-eqz v3, :cond_14

    if-lt v12, v9, :cond_14

    if-lt v13, v9, :cond_14

    .line 729
    :try_start_6
    invoke-static {}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->autoLtmGridStep()I

    move-result v9

    .line 730
    add-int v17, v12, v9

    add-int/lit8 v17, v17, -0x1

    move/from16 v29, v3

    div-int v3, v17, v9

    move/from16 v30, v7

    const/4 v7, 0x2

    invoke-static {v7, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 731
    add-int v17, v13, v9

    add-int/lit8 v17, v17, -0x1

    div-int v7, v17, v9

    move/from16 v17, v3

    const/4 v3, 0x2

    invoke-static {v3, v7}, Ljava/lang/Math;->max(II)I

    move-result v28

    .line 732
    mul-int v3, v17, v28

    new-array v7, v3, [F

    .line 733
    new-array v3, v3, [F

    .line 734
    move-object/from16 v31, v3

    mul-int v3, v12, v9

    new-array v3, v3, [I

    .line 735
    move-object/from16 v21, v3

    const/4 v3, 0x0

    :goto_8
    if-ge v3, v13, :cond_13

    .line 736
    move/from16 v25, v3

    sub-int v3, v13, v25

    invoke-static {v9, v3}, Ljava/lang/Math;->min(II)I

    move-result v22
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 737
    move/from16 v27, v22

    const/16 v22, 0x0

    const/16 v24, 0x0

    move/from16 v26, v12

    move-object/from16 v20, v10

    move/from16 v23, v12

    :try_start_7
    invoke-virtual/range {v20 .. v27}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    move-object/from16 v3, v20

    move-object/from16 v20, v21

    move/from16 v21, v23

    .line 738
    move/from16 v24, v13

    move/from16 v23, v25

    move/from16 v22, v27

    move-object/from16 v26, v31

    move-object/from16 v25, v7

    move/from16 v27, v17

    :try_start_8
    invoke-static/range {v20 .. v28}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    move-object/from16 v12, v25

    move/from16 v7, v27

    move/from16 v10, v28

    move/from16 v25, v23

    .line 735
    add-int v13, v25, v9

    move/from16 v17, v7

    move/from16 v28, v10

    move-object v7, v12

    move/from16 v12, v21

    move-object v10, v3

    move v3, v13

    move-object/from16 v21, v20

    move/from16 v13, v24

    goto :goto_8

    .line 783
    :catchall_1
    move-exception v0

    move-object/from16 v3, v20

    goto :goto_9

    .line 740
    :cond_13
    move-object v3, v10

    move/from16 v21, v12

    move/from16 v24, v13

    move/from16 v10, v28

    move-object v12, v7

    move/from16 v7, v17

    invoke-static {v12, v7, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object v9

    move v12, v7

    move v13, v10

    move-object v7, v11

    move-object/from16 v11, v31

    move-object v10, v9

    goto :goto_a

    .line 783
    :catchall_2
    move-exception v0

    move-object v3, v10

    :goto_9
    move-object v1, v2

    goto/16 :goto_11

    .line 728
    :cond_14
    move/from16 v29, v3

    move/from16 v30, v7

    move-object v3, v10

    move/from16 v21, v12

    move/from16 v24, v13

    .line 742
    move-object v7, v11

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    :goto_a
    nop

    .line 743
    nop

    .line 744
    nop

    .line 745
    nop

    .line 746
    if-eqz v29, :cond_15

    if-eqz v10, :cond_15

    move-object v9, v14

    move/from16 v14, v19

    goto :goto_b

    :cond_15
    move-object v9, v14

    const/4 v14, 0x0

    .line 747
    :goto_b
    nop

    .line 748
    nop

    .line 749
    if-nez v14, :cond_16

    if-nez v15, :cond_16

    if-nez v16, :cond_16

    .line 750
    invoke-static {v1, v8, v0, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 783
    :try_start_9
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_a

    .line 751
    return-void

    .line 783
    :catchall_3
    move-exception v0

    goto :goto_9

    .line 753
    :cond_16
    move-object/from16 v17, v7

    :try_start_a
    new-instance v7, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    move-object/from16 v19, v2

    move-object v2, v8

    move-object/from16 v20, v9

    move/from16 v8, v21

    move/from16 v9, v24

    const/4 v1, 0x0

    move/from16 v21, v6

    move-object/from16 v6, v17

    move/from16 v17, v30

    :try_start_b
    invoke-direct/range {v7 .. v17}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;-><init>(II[F[FIIZZZF)V

    const/16 v10, 0x200

    const/16 v11, 0x18

    move-object v12, v7

    move-object/from16 v7, v20

    invoke-static/range {v7 .. v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v7

    .line 756
    goto :goto_c

    .line 783
    :catchall_4
    move-exception v0

    move-object/from16 v19, v2

    goto/16 :goto_f

    .line 757
    :cond_17
    move-object/from16 v19, v2

    move/from16 v29, v3

    move/from16 v21, v6

    move-object v2, v8

    move-object v3, v10

    move-object v6, v11

    move v8, v12

    move v9, v13

    move-object v7, v14

    const/4 v1, 0x0

    new-instance v12, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;

    invoke-direct {v12, v5, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;-><init>(III)V

    const/16 v10, 0x200

    const/16 v11, 0x18

    invoke-static/range {v7 .. v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v7
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_7

    .line 761
    :goto_c
    if-nez v7, :cond_18

    .line 783
    :try_start_c
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_5

    .line 761
    return-void

    .line 785
    :catchall_5
    move-exception v0

    move-object/from16 v1, v19

    goto/16 :goto_12

    .line 763
    :cond_18
    :try_start_d
    new-instance v7, Ljava/io/ByteArrayOutputStream;

    array-length v2, v2

    invoke-direct {v7, v2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 764
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v8, 0x62

    invoke-virtual {v3, v2, v8, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v2
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_7

    if-nez v2, :cond_19

    .line 783
    :try_start_e
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_5

    .line 765
    return-void

    .line 767
    :cond_19
    :try_start_f
    invoke-virtual {v7}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    .line 768
    nop

    .line 769
    const-string v7, ""

    if-eqz v18, :cond_1a

    if-eqz v29, :cond_1a

    :try_start_10
    const-string v8, " ltm=1"

    goto :goto_d

    :cond_1a
    move-object v8, v7

    .line 770
    :goto_d
    if-eqz v18, :cond_1b

    if-eqz v15, :cond_1b

    if-nez v29, :cond_1b

    const-string v9, " hl=1"

    goto :goto_e

    :cond_1b
    move-object v9, v7

    .line 771
    :goto_e
    if-eqz v18, :cond_1c

    if-eqz v16, :cond_1c

    const-string v7, " zsharp=1"

    :cond_1c
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 772
    if-eqz v0, :cond_1e

    .line 773
    if-eqz v4, :cond_1d

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_1d

    .line 774
    invoke-virtual {v0, v6, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 776
    :cond_1d
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    array-length v7, v2

    const/high16 v8, 0x10000

    add-int/2addr v7, v8

    invoke-direct {v6, v7}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 777
    new-instance v7, Ljava/io/ByteArrayInputStream;

    invoke-direct {v7, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v7, v6, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 778
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 780
    :cond_1e
    move-object/from16 v1, p0

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 781
    array-length v0, v2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Applied post-pass p="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v2, v21

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " lut="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " bytes="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_7

    move-object/from16 v1, v19

    :try_start_11
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_6

    .line 783
    :try_start_12
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 784
    nop

    .line 787
    goto :goto_13

    .line 783
    :catchall_6
    move-exception v0

    goto :goto_11

    :catchall_7
    move-exception v0

    :goto_f
    move-object/from16 v1, v19

    goto :goto_11

    .line 708
    :cond_1f
    move-object v1, v2

    move-object v3, v10

    .line 783
    :goto_10
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 708
    return-void

    .line 783
    :catchall_8
    move-exception v0

    move-object v1, v2

    move-object v3, v10

    :goto_11
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 784
    throw v0
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_9

    .line 785
    :catchall_9
    move-exception v0

    goto :goto_12

    :catchall_a
    move-exception v0

    move-object v1, v2

    .line 786
    :goto_12
    const-string v2, "applyCustomLutIfEnabled failed, keeping original JPEG"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 788
    :goto_13
    return-void

    .line 651
    :cond_20
    :goto_14
    return-void
.end method

.method public static applySessionParameterOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 4

    .line 462
    if-eqz p1, :cond_4

    if-nez p0, :cond_0

    goto :goto_1

    .line 464
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 465
    const/16 v1, 0x9

    if-eq v0, v1, :cond_1

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    .line 467
    return-void

    .line 469
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 470
    if-nez p0, :cond_2

    return-void

    .line 471
    :cond_2
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object p0

    .line 472
    invoke-interface {p0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    return-void

    .line 474
    :cond_3
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v1, Ljava/lang/Integer;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 475
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 476
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 477
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v1, Ljava/lang/Byte;

    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v3

    invoke-static {p1, p0, v0, v1, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 478
    const-string v0, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v1, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {p1, p0, v0, v1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 481
    goto :goto_0

    .line 479
    :catchall_0
    move-exception p0

    .line 480
    const-string p1, "CustomImagingBridge"

    const-string v0, "applySessionParameterOverrides failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 482
    :goto_0
    return-void

    .line 462
    :cond_4
    :goto_1
    return-void
.end method

.method public static awaitCameraDataReadyForGallery(Lcom/motorola/camera/CameraData;)V
    .locals 11

    .line 1151
    if-nez p0, :cond_0

    return-void

    .line 1154
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/motorola/camera/CameraData;->getId()J

    move-result-wide v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1157
    nop

    .line 1158
    const-wide/16 v2, 0x0

    cmp-long p0, v0, v2

    if-gtz p0, :cond_1

    return-void

    .line 1162
    :cond_1
    move-wide v4, v2

    .line 1166
    :goto_0
    :try_start_1
    invoke-static {v0, v1}, Lcom/motorola/camera/saving/SaveImageService;->getProcessingCameraData(J)Lcom/motorola/camera/CameraData;

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz p0, :cond_2

    const/4 p0, 0x1

    goto :goto_1

    :cond_2
    const/4 p0, 0x0

    .line 1169
    :goto_1
    nop

    .line 1170
    const-string v6, "CustomImagingBridge"

    if-nez p0, :cond_4

    .line 1171
    cmp-long p0, v4, v2

    if-eqz p0, :cond_3

    .line 1172
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v4

    const-wide/32 v4, 0xf4240

    div-long/2addr v2, v4

    .line 1173
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Gallery launch waited "

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, "ms for mediaId="

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v6, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1175
    :cond_3
    return-void

    .line 1177
    :cond_4
    cmp-long p0, v4, v2

    if-nez p0, :cond_5

    .line 1178
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    goto :goto_2

    .line 1179
    :cond_5
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v7

    sub-long/2addr v7, v4

    const-wide v9, 0x165a0bc00L

    cmp-long p0, v7, v9

    if-ltz p0, :cond_6

    .line 1180
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Gallery launch timed out waiting for mediaId="

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v6, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1181
    return-void

    .line 1184
    :cond_6
    :goto_2
    const-wide/16 v6, 0x23

    :try_start_2
    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0

    .line 1188
    nop

    .line 1189
    goto :goto_0

    .line 1185
    :catch_0
    move-exception p0

    .line 1186
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Thread;->interrupt()V

    .line 1187
    return-void

    .line 1167
    :catchall_0
    move-exception p0

    .line 1168
    return-void

    .line 1155
    :catchall_1
    move-exception p0

    .line 1156
    return-void
.end method

.method private static captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J
    .locals 10

    .line 205
    const-wide/16 v0, 0x0

    if-nez p0, :cond_0

    return-wide v0

    .line 206
    :cond_0
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    const/16 v3, 0x20

    const-wide/32 v4, 0x7fffffff

    const-wide v6, 0xffffffffL

    if-eqz v2, :cond_2

    .line 207
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v2, v2, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 208
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    .line 209
    or-long/2addr v2, v6

    .line 210
    cmp-long p0, v2, v0

    if-eqz p0, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v2, 0x1

    :goto_0
    return-wide v2

    .line 212
    :cond_2
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v2

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 213
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    or-long/2addr v2, v6

    const-wide/high16 v4, -0x8000000000000000L

    or-long/2addr v2, v4

    .line 214
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

    .line 77
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "/dev/adsprpc-smd"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 78
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v2, :cond_0

    .line 79
    return v0

    .line 81
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 82
    nop

    .line 83
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 82
    const/4 v0, 0x1

    return v0

    .line 83
    :catchall_0
    move-exception v1

    .line 84
    return v0

    .line 86
    :catchall_1
    move-exception v1

    .line 87
    return v0
.end method

.method public static configureGalleryIntent(Landroid/content/Intent;Z)V
    .locals 1

    .line 1197
    if-eqz p0, :cond_1

    if-eqz p1, :cond_0

    goto :goto_0

    .line 1198
    :cond_0
    const-string p1, "exit_on_swipe"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1199
    return-void

    .line 1197
    :cond_1
    :goto_0
    return-void
.end method

.method private static evaluateAutoPostGates([B)I
    .locals 11

    .line 625
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 626
    const/4 v1, 0x4

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 627
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 628
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 629
    if-nez v3, :cond_0

    return v2

    .line 631
    :cond_0
    :try_start_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    .line 632
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    .line 633
    const/16 p0, 0x10

    if-lt v6, p0, :cond_4

    if-ge v10, p0, :cond_1

    goto :goto_0

    .line 634
    :cond_1
    mul-int p0, v6, v10

    new-array v4, p0, [I

    .line 635
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v5, 0x0

    move v9, v6

    invoke-virtual/range {v3 .. v10}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 636
    nop

    .line 637
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoLtmGate([II)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 638
    const/4 v2, 0x1

    .line 640
    :cond_2
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoHighlightGate([II)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_3

    .line 641
    or-int/lit8 v2, v2, 0x2

    .line 643
    :cond_3
    nop

    .line 645
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 643
    return v2

    .line 645
    :cond_4
    :goto_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 633
    return v2

    .line 645
    :catchall_0
    move-exception v0

    move-object p0, v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 646
    throw p0
.end method

.method public static exportCleanBayerJpeg(Ljava/nio/ByteBuffer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 10

    .line 900
    if-eqz p0, :cond_b

    if-eqz p1, :cond_b

    if-eqz p3, :cond_b

    if-nez p2, :cond_0

    goto/16 :goto_6

    .line 901
    :cond_0
    iget v2, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    .line 902
    iget v3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    .line 903
    invoke-static {p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v6

    .line 904
    iget-object v0, v6, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v1, 0x6

    aget v0, v0, v1

    if-nez v0, :cond_1

    return-void

    .line 905
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

    .line 910
    :cond_2
    const-wide/16 v4, 0x5

    mul-long/2addr v0, v4

    const-wide/16 v4, 0x4

    :try_start_0
    div-long/2addr v0, v4

    .line 911
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

    .line 912
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

    .line 913
    return-void

    .line 915
    :cond_3
    iget-object v0, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    .line 916
    if-eqz v0, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v1, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v1, v1, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    if-nez v1, :cond_4

    goto/16 :goto_3

    .line 917
    :cond_4
    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->asSharedMediaFile()Lcom/motorola/camera/storage/backend/MediaStoreFile;

    move-result-object v0

    .line 918
    if-eqz v0, :cond_8

    iget-object v1, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    if-nez v1, :cond_5

    goto :goto_2

    .line 920
    :cond_5
    iget-object v1, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v1, :cond_6

    iget-object p3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p3}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_6
    const-string p3, "IMG_CLEAN"

    .line 921
    :goto_0
    const-string v1, ".dng"

    invoke-virtual {p3, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v4, "_CLEAN.jpg"

    if-eqz v1, :cond_7

    .line 922
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

    .line 923
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

    .line 924
    :goto_1
    iget-object p3, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-virtual {p3, v7}, Lcom/motorola/camera/storage/MediaFilePath;->withFileName(Ljava/lang/String;)Lcom/motorola/camera/storage/MediaFilePath;

    move-result-object v8

    .line 925
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v1

    .line 927
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v8}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;-><init>([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    invoke-interface {p0, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 931
    goto :goto_4

    .line 918
    :cond_8
    :goto_2
    return-void

    .line 916
    :cond_9
    :goto_3
    return-void

    .line 929
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 930
    const-string p1, "exportCleanBayerJpeg dispatch failed (DNG unaffected)"

    invoke-static {v9, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 932
    :goto_4
    return-void

    .line 906
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

    .line 907
    return-void

    .line 900
    :cond_b
    :goto_6
    return-void
.end method

.method private static extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F
    .locals 4

    .line 1093
    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1094
    :cond_0
    const/16 v0, 0x9

    new-array v1, v0, [Landroid/util/Rational;

    .line 1095
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 1096
    new-array p0, v0, [F

    .line 1097
    nop

    :goto_0
    if-ge v2, v0, :cond_3

    .line 1098
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

    .line 1097
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1100
    :cond_3
    return-object p0
.end method

.method private static getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;
    .locals 6
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

    .line 419
    if-nez p0, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object p0

    return-object p0

    .line 420
    :cond_0
    if-eqz p1, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 421
    :goto_0
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 422
    if-eqz v1, :cond_2

    return-object v1

    .line 423
    :cond_2
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 424
    nop

    .line 426
    const/4 v2, 0x0

    if-eqz p1, :cond_3

    .line 427
    :try_start_0
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableSessionKeys()Ljava/util/List;

    move-result-object v3

    goto :goto_1

    .line 428
    :cond_3
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableCaptureRequestKeys()Ljava/util/List;

    move-result-object v3

    .line 429
    :goto_1
    if-eqz v3, :cond_5

    .line 430
    nop

    .line 431
    const/4 v2, 0x1

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/camera2/CaptureRequest$Key;

    .line 432
    if-eqz v4, :cond_4

    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_4

    .line 433
    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 435
    :cond_4
    goto :goto_2

    .line 437
    :catchall_0
    move-exception v3

    :cond_5
    nop

    .line 438
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    .line 439
    if-eqz v2, :cond_7

    if-eqz p1, :cond_6

    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_7

    .line 440
    :cond_6
    invoke-interface {v0, p0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 442
    :cond_7
    return-object v1
.end method

.method private static getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 5

    .line 286
    if-nez p0, :cond_1

    .line 287
    nop

    .line 288
    if-nez p1, :cond_0

    .line 290
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 291
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_0

    .line 293
    :cond_0
    :goto_1
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0

    .line 295
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J

    move-result-wide v0

    .line 296
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    monitor-enter v2

    .line 297
    :try_start_1
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 298
    if-eqz v3, :cond_2

    .line 299
    monitor-exit v2

    return-object v3

    .line 301
    :cond_2
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 302
    if-eqz v3, :cond_3

    .line 303
    sget-object p1, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p1, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 304
    monitor-exit v2

    return-object v3

    .line 306
    :cond_3
    nop

    .line 307
    nop

    .line 308
    instance-of v3, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v3, :cond_5

    .line 309
    move-object v3, p0

    check-cast v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 310
    if-nez p1, :cond_4

    iget-object p1, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 311
    :cond_4
    iget-boolean v3, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-eqz v3, :cond_5

    const/4 p2, 0x1

    .line 313
    :cond_5
    if-nez p1, :cond_6

    .line 315
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 316
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v3

    goto :goto_2

    .line 318
    :cond_6
    :goto_3
    :try_start_3
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 319
    sget-object p2, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p2, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 320
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-interface {p0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 321
    monitor-exit v2

    return-object p1

    .line 322
    :catchall_2
    move-exception p0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw p0
.end method

.method private static getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 3

    .line 326
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    .line 327
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    goto :goto_0

    .line 328
    :cond_0
    move-object p0, v0

    .line 329
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

    .line 188
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 189
    if-nez v1, :cond_0

    return v0

    .line 190
    :cond_0
    const-string v2, "com.motorola.camera.post_processing_profile"

    const-string v3, "0"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->parseProfileIndex(Ljava/lang/String;)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 191
    :catchall_0
    move-exception v1

    .line 192
    return v0
.end method

.method public static gradePixelBufferStrips([IIIIII)Z
    .locals 6

    .line 882
    if-eqz p0, :cond_2

    if-lez p1, :cond_2

    if-lez p2, :cond_2

    if-lez p3, :cond_2

    if-gtz p5, :cond_0

    goto :goto_0

    .line 883
    :cond_0
    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_1

    const/4 p0, 0x0

    return p0

    .line 884
    :cond_1
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$3;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$3;-><init>([II)V

    new-instance v5, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;

    invoke-direct {v5, p5, p1, p2}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;-><init>(III)V

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result p0

    return p0

    .line 882
    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private static gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z
    .locals 26

    .line 805
    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    if-eqz v0, :cond_a

    if-eqz p5, :cond_a

    if-lez p1, :cond_a

    if-lez v1, :cond_a

    if-gtz v2, :cond_0

    const/16 v22, 0x1

    goto/16 :goto_8

    .line 806
    :cond_0
    const/4 v4, 0x0

    move/from16 v5, p4

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 808
    new-instance v6, Ljava/util/ArrayList;

    const/4 v7, 0x4

    invoke-direct {v6, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 809
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 810
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 811
    nop

    .line 812
    nop

    .line 813
    nop

    .line 815
    move v13, v1

    move v11, v4

    move v14, v11

    const/4 v12, 0x0

    :goto_0
    if-ge v11, v1, :cond_9

    .line 816
    sub-int v15, v1, v11

    invoke-static {v2, v15}, Ljava/lang/Math;->min(II)I

    move-result v15

    .line 817
    sub-int v10, v11, v5

    invoke-static {v4, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 818
    const/16 v22, 0x1

    add-int v3, v11, v15

    add-int v7, v3, v5

    invoke-static {v1, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 819
    sub-int v4, v7, v10

    .line 820
    sub-int v16, v11, v10

    mul-int v2, v16, p1

    .line 821
    move/from16 v24, v14

    mul-int v14, p1, v4

    new-array v14, v14, [I

    .line 822
    move/from16 v25, v5

    const/4 v5, 0x0

    invoke-interface {v0, v10, v4, v14, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    .line 824
    if-eqz v12, :cond_2

    add-int v5, v13, v24

    if-ge v10, v5, :cond_2

    .line 825
    invoke-static {v10, v13}, Ljava/lang/Math;->max(II)I

    move-result v16

    .line 826
    invoke-static {v7, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 827
    sub-int v5, v5, v16

    .line 828
    if-lez v5, :cond_1

    .line 829
    sub-int v7, v16, v13

    mul-int v7, v7, p1

    sub-int v16, v16, v10

    move/from16 v20, v4

    mul-int v4, v16, p1

    mul-int v5, v5, p1

    invoke-static {v12, v7, v14, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_1

    .line 828
    :cond_1
    move/from16 v20, v4

    goto :goto_1

    .line 824
    :cond_2
    move/from16 v20, v4

    .line 835
    :goto_1
    invoke-interface {v6, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 836
    filled-new-array {v11, v15, v2}, [I

    move-result-object v2

    invoke-interface {v8, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 837
    nop

    .line 838
    nop

    .line 839
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    new-instance v16, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;

    move/from16 v19, p1

    move-object/from16 v17, p5

    move/from16 v21, v10

    move-object/from16 v18, v14

    invoke-direct/range {v16 .. v21}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;-><init>(Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;[IIII)V

    move-object/from16 v4, v16

    invoke-interface {v2, v4}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v2

    invoke-interface {v9, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 842
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v2

    const/4 v4, 0x4

    if-eq v2, v4, :cond_4

    if-lt v3, v1, :cond_3

    goto :goto_2

    :cond_3
    const/4 v2, 0x0

    goto :goto_3

    :cond_4
    :goto_2
    move/from16 v2, v22

    .line 843
    :goto_3
    if-eqz v2, :cond_8

    .line 844
    nop

    .line 845
    nop

    .line 846
    nop

    .line 847
    nop

    .line 848
    if-ge v3, v1, :cond_5

    if-lez v25, :cond_5

    .line 849
    move/from16 v2, v25

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 850
    sub-int/2addr v3, v5

    .line 851
    mul-int v7, p1, v5

    new-array v7, v7, [I

    .line 852
    const/4 v10, 0x0

    invoke-interface {v0, v3, v5, v7, v10}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    move v14, v5

    move-object v12, v7

    move v13, v3

    goto :goto_4

    .line 848
    :cond_5
    move/from16 v2, v25

    .line 854
    const/4 v12, 0x0

    const/4 v14, 0x0

    move v13, v3

    :goto_4
    const/4 v5, 0x0

    :goto_5
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v3

    if-ge v5, v3, :cond_7

    .line 856
    :try_start_0
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/concurrent/Future;

    invoke-interface {v3}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 865
    nop

    .line 866
    invoke-interface {v8, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 867
    const/16 v23, 0x0

    aget v7, v3, v23

    aget v10, v3, v22

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, [I

    const/16 v16, 0x2

    aget v3, v3, v16

    invoke-interface {v0, v7, v10, v15, v3}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->writeRows(II[II)V

    .line 854
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .line 863
    :catch_0
    move-exception v0

    .line 864
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-virtual {v0}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 857
    :catch_1
    move-exception v0

    .line 858
    add-int/lit8 v5, v5, 0x1

    :goto_6
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v0

    if-ge v5, v0, :cond_6

    .line 859
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/Future;

    move/from16 v1, v22

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 858
    add-int/lit8 v5, v5, 0x1

    const/16 v22, 0x1

    goto :goto_6

    .line 861
    :cond_6
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 862
    const/16 v23, 0x0

    return v23

    .line 869
    :cond_7
    const/16 v23, 0x0

    .line 870
    nop

    .line 871
    nop

    .line 872
    invoke-interface {v6}, Ljava/util/List;->clear()V

    .line 873
    invoke-interface {v8}, Ljava/util/List;->clear()V

    .line 874
    invoke-interface {v9}, Ljava/util/List;->clear()V

    goto :goto_7

    .line 843
    :cond_8
    move/from16 v2, v25

    const/16 v23, 0x0

    move/from16 v14, v24

    .line 815
    :goto_7
    add-int v11, v11, p3

    move v5, v2

    move v7, v4

    move/from16 v4, v23

    move/from16 v2, p3

    goto/16 :goto_0

    .line 877
    :cond_9
    const/16 v22, 0x1

    return v22

    .line 805
    :cond_a
    const/16 v22, 0x1

    :goto_8
    return v22
.end method

.method public static initPostProcPreference(Landroidx/preference/PreferenceFragmentCompat;)V
    .locals 3

    .line 172
    const-string v0, "com.motorola.camera.post_processing_profile"

    if-nez p0, :cond_0

    return-void

    .line 174
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object p0

    check-cast p0, Landroidx/preference/ListPreference;

    .line 175
    if-nez p0, :cond_1

    return-void

    .line 176
    :cond_1
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    invoke-virtual {p0, v1}, Landroidx/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 177
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    iput-object v1, p0, Landroidx/preference/ListPreference;->mEntryValues:[Ljava/lang/CharSequence;

    .line 178
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 179
    const-string v2, "0"

    if-eqz v1, :cond_2

    :try_start_1
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_2
    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->parseProfileIndex(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 180
    invoke-virtual {p0, v0}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 183
    goto :goto_0

    .line 181
    :catchall_0
    move-exception p0

    .line 182
    const-string v0, "CustomImagingBridge"

    const-string v1, "initPostProcPreference failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 184
    :goto_0
    return-void
.end method

.method public static isCustomLutActive()Z
    .locals 3

    .line 598
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

    .line 602
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 603
    return v0

    .line 605
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

    .line 219
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->isFlashExpected()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 220
    :catchall_0
    move-exception v0

    .line 221
    const/4 v0, 0x0

    return v0
.end method

.method private static isUiSpecialModeSafe()Z
    .locals 2

    .line 227
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

    .line 228
    :catchall_0
    move-exception v1

    .line 229
    return v0
.end method

.method static synthetic lambda$applyCustomLutIfEnabled$0(II[F[FIIZZZF[IIII)V
    .locals 1

    .line 754
    move v0, p4

    move p4, p0

    move-object p0, p10

    move p10, p6

    move-object p6, p2

    move p2, p12

    move p12, p8

    move p8, v0

    move v0, p5

    move p5, p1

    move p1, p11

    move p11, p7

    move-object p7, p3

    move p3, p13

    move p13, p9

    move p9, v0

    invoke-static/range {p0 .. p13}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZF)V

    return-void
.end method

.method static synthetic lambda$applyCustomLutIfEnabled$1(III[IIII)V
    .locals 1

    .line 758
    move-object v0, p3

    move p3, p0

    move-object p0, v0

    move v0, p4

    move p4, p1

    move p1, v0

    move v0, p5

    move p5, p2

    move p2, v0

    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIIIIII)V

    return-void
.end method

.method static synthetic lambda$exportCleanBayerJpeg$4([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 0

    .line 928
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    return-void
.end method

.method static synthetic lambda$gradePixelBufferStrips$3(III[IIII)V
    .locals 1

    .line 895
    move-object v0, p3

    move p3, p0

    move-object p0, v0

    move v0, p4

    move p4, p1

    move p1, v0

    move v0, p5

    move p5, p2

    move p2, v0

    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIIIIII)V

    return-void
.end method

.method static synthetic lambda$gradeSurfaceInBatches$2(Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;[IIII)V
    .locals 0

    .line 840
    invoke-interface {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;->processStrip([IIII)V

    return-void
.end method

.method public static overrideSceneMode(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)Lcom/motorola/camera/mcf/Mcf$SceneMode;
    .locals 3

    .line 334
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 335
    return-object p0

    .line 337
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

    .line 338
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    .line 339
    invoke-static {p0, p1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 340
    iget-object v2, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget v2, v2, v1

    if-ne v2, v0, :cond_3

    .line 341
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->HAL_FRAME_STACK:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    return-object p0

    .line 343
    :cond_3
    iget-object p1, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget p1, p1, v1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_4

    .line 344
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->RAW_HDR:Lcom/motorola/camera/mcf/Mcf$SceneMode;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 348
    :cond_4
    goto :goto_2

    .line 346
    :catchall_0
    move-exception p1

    .line 347
    const-string v0, "CustomImagingBridge"

    const-string v1, "overrideSceneMode fallback"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 349
    :goto_2
    return-object p0
.end method

.method private static parseProfileIndex(Ljava/lang/String;)I
    .locals 2

    .line 162
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 164
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 165
    if-ltz p0, :cond_1

    const/16 v1, 0xa

    if-gt p0, v1, :cond_1

    move v0, p0

    :cond_1
    return v0

    .line 166
    :catchall_0
    move-exception p0

    .line 167
    return v0

    .line 162
    :cond_2
    :goto_0
    return v0
.end method

.method private static resolveActiveScene(Z)[I
    .locals 2

    .line 275
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

    .line 276
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v0

    .line 277
    nop

    .line 279
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 280
    goto :goto_2

    :catchall_0
    move-exception v1

    const/4 v1, 0x0

    .line 281
    :goto_2
    invoke-static {v1, p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    iget-object p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    return-object p0
.end method

.method private static resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 24

    .line 234
    nop

    .line 235
    nop

    .line 237
    const/high16 v1, 0x3f800000    # 1.0f

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraType()Lcom/motorola/camera/settings/CameraType;

    move-result-object v0

    .line 238
    if-eqz v0, :cond_0

    .line 239
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getZoomValue(Lcom/motorola/camera/settings/CameraType;)F

    move-result v0

    .line 241
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

    .line 243
    :catchall_0
    move-exception v0

    :cond_0
    :goto_0
    move v3, v1

    .line 245
    const/high16 v1, 0x42480000    # 50.0f

    :try_start_1
    invoke-static {}, Lcom/motorola/camera/IqConfigManager;->getInstance()Lcom/motorola/camera/IqConfigManager;

    move-result-object v0

    .line 247
    if-eqz v0, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    const/4 v4, 0x0

    cmpl-float v2, v2, v4

    if-lez v2, :cond_1

    .line 248
    iget v0, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move v1, v0

    goto :goto_1

    .line 250
    :catchall_1
    move-exception v0

    :cond_1
    :goto_1
    move v4, v1

    .line 252
    const-string v0, ""

    if-eqz p0, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/Mcf$SceneMode;->name()Ljava/lang/String;

    move-result-object v1

    move-object v5, v1

    goto :goto_2

    :cond_2
    move-object v5, v0

    .line 253
    :goto_2
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v2

    .line 254
    sget-boolean v8, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    move/from16 v6, p1

    move/from16 v7, p2

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtended(IFFLjava/lang/String;ZZZ)[I

    move-result-object v1

    .line 255
    const/high16 v6, 0x41200000    # 10.0f

    mul-float v7, v3, v6

    .line 256
    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    int-to-float v7, v7

    div-float/2addr v7, v6

    .line 257
    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v6

    const/4 v8, 0x0

    aget v8, v1, v8

    const/4 v9, 0x1

    aget v10, v1, v9

    const/4 v11, 0x2

    aget v11, v1, v11

    const/4 v12, 0x3

    aget v12, v1, v12

    const/4 v13, 0x4

    aget v13, v1, v13

    const/4 v14, 0x5

    aget v14, v1, v14

    const/4 v15, 0x6

    aget v15, v1, v15

    .line 260
    const/16 v16, 0x7

    aget v17, v1, v16

    if-ltz v17, :cond_3

    aget v9, v1, v16

    move-object/from16 v16, v0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p2, v1

    const-string v1, " isz="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    :cond_3
    move-object/from16 v16, v0

    move-object/from16 p2, v1

    .line 261
    :goto_3
    const/16 v1, 0x8

    aget v9, p2, v1

    if-ltz v9, :cond_4

    aget v1, p2, v1

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v17, v3

    const-string v3, " aide="

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :cond_4
    move/from16 v17, v3

    move-object/from16 v1, v16

    .line 262
    :goto_4
    const/16 v3, 0x9

    aget v9, p2, v3

    if-lez v9, :cond_5

    aget v9, p2, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v19, v4

    const-string v4, " vsr="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_5

    :cond_5
    move/from16 v19, v4

    move-object/from16 v3, v16

    .line 263
    :goto_5
    const/16 v4, 0xa

    aget v9, p2, v4

    if-ltz v9, :cond_6

    aget v9, p2, v4

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v21, v3

    const-string v3, " hdr="

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_6

    :cond_6
    move-object/from16 v21, v3

    move-object/from16 v3, v16

    .line 264
    :goto_6
    const/16 v4, 0xb

    aget v4, p2, v4

    const/4 v9, 0x1

    if-ne v4, v9, :cond_7

    const-string v4, " t2w=0"

    goto :goto_7

    :cond_7
    move-object/from16 v4, v16

    .line 265
    :goto_7
    const/16 v22, 0xc

    move-object/from16 p0, v4

    aget v4, p2, v22

    if-ne v4, v9, :cond_8

    const-string v4, " qll=1"

    goto :goto_8

    :cond_8
    move-object/from16 v4, v16

    .line 266
    :goto_8
    const/16 v9, 0xa

    if-ne v2, v9, :cond_9

    const-string v9, " stock=1"

    goto :goto_9

    :cond_9
    move-object/from16 v9, v16

    .line 267
    :goto_9
    move-object/from16 v20, v9

    const/16 v9, 0x9

    if-ne v2, v9, :cond_a

    const-string v9, " mcf=0"

    goto :goto_a

    :cond_a
    move-object/from16 v9, v16

    .line 268
    :goto_a
    sget-boolean v18, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    if-nez v18, :cond_b

    const-string v18, " htp=0"

    move-object/from16 v23, v18

    goto :goto_b

    :cond_b
    move-object/from16 v23, v16

    .line 269
    :goto_b
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v18

    if-eqz v18, :cond_c

    move-object/from16 v22, v4

    move-object/from16 v18, v9

    move-object/from16 v4, v16

    goto :goto_c

    :cond_c
    move-object/from16 v18, v9

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v22, v4

    const-string v4, " in="

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 270
    :goto_c
    if-eqz p1, :cond_d

    const-string v5, " flash=1"

    goto :goto_d

    :cond_d
    move-object/from16 v5, v16

    :goto_d
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v16, v5

    const-string v5, "Edge50Port v1.6.0 p="

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v9, " z="

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, " lux="

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " act="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " nr="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " edge="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " mfnr="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " sz="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " lut="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " raw="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, p0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v9, v20

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v9, v18

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v5, v16

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 271
    move v5, v2

    new-instance v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-object/from16 v3, p2

    move/from16 v6, v17

    move/from16 v7, v19

    invoke-direct/range {v2 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;-><init>([ILjava/lang/String;IFF)V

    return-object v2
.end method

.method public static resolveEdgeMode(I)I
    .locals 2

    .line 358
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x2

    aget v0, v0, v1

    .line 359
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveEnableMfnr(Z)Z
    .locals 1

    .line 368
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveEnableMfnr(ZZ)Z

    move-result p0

    return p0
.end method

.method public static resolveEnableMfnr(ZZ)Z
    .locals 1

    .line 372
    invoke-static {p1}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object p1

    const/4 v0, 0x3

    aget p1, p1, v0

    .line 373
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

    .line 201
    const/16 v0, 0x5f

    if-ne p0, v0, :cond_0

    const/16 p0, 0x62

    :cond_0
    return p0
.end method

.method public static resolveNoiseReduction(I)I
    .locals 2

    .line 353
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    .line 354
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveSuperZoom(B)B
    .locals 2

    .line 363
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x4

    aget v0, v0, v1

    .line 364
    if-ltz v0, :cond_0

    int-to-byte p0, v0

    :cond_0
    return p0
.end method

.method private static runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 2

    .line 939
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 940
    :try_start_0
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    .line 941
    monitor-exit v1

    .line 942
    return-void

    .line 941
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

    .line 949
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

    .line 950
    int-to-long v5, v1

    int-to-long v7, v2

    mul-long/2addr v5, v7

    const-wide/16 v7, 0x5

    mul-long/2addr v7, v5

    const-wide/16 v9, 0x4

    div-long/2addr v7, v9

    .line 951
    const-wide/16 v9, 0x2

    mul-long/2addr v5, v9

    .line 953
    array-length v9, v0

    int-to-long v9, v9

    cmp-long v5, v9, v5

    const/4 v6, 0x1

    if-ltz v5, :cond_0

    .line 954
    array-length v5, v0

    div-int/2addr v5, v2

    invoke-static {v0, v1, v2, v5, v6}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object v0

    move-object v5, v0

    goto :goto_0

    .line 955
    :cond_0
    array-length v5, v0

    int-to-long v9, v5

    cmp-long v5, v9, v7

    if-ltz v5, :cond_15

    .line 956
    array-length v5, v0

    div-int/2addr v5, v2

    invoke-static {v0, v1, v2, v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object v0

    move-object v5, v0

    .line 962
    :goto_0
    invoke-static/range {p4 .. p4}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v7

    .line 963
    nop

    .line 964
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

    .line 965
    nop

    .line 966
    nop

    .line 968
    if-eqz v7, :cond_4

    .line 969
    sget-object v13, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_COLOR_FILTER_ARRANGEMENT:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v13}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    .line 970
    if-eqz v13, :cond_1

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    goto :goto_1

    :cond_1
    move v13, v9

    .line 971
    :goto_1
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_BLACK_LEVEL_PATTERN:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/BlackLevelPattern;

    .line 972
    if-eqz v0, :cond_2

    .line 973
    invoke-virtual {v0, v9, v9}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v9

    .line 974
    invoke-virtual {v0, v6, v9}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v6

    .line 975
    invoke-virtual {v0, v9, v6}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v5, v10

    .line 976
    invoke-virtual {v0, v6, v6}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v0

    int-to-float v0, v0

    aput v0, v5, v11

    .line 978
    :cond_2
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_WHITE_LEVEL:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 979
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-lez v8, :cond_3

    .line 980
    invoke-virtual {v0}, Ljava/lang/Integer;->floatValue()F

    move-result v0

    goto :goto_2

    .line 982
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

    .line 968
    :cond_4
    move v13, v9

    const/4 v0, 0x0

    const v8, 0x447fc000    # 1023.0f

    .line 985
    :goto_3
    move/from16 v19, v6

    sget-object v6, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v6}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 986
    if-eqz v6, :cond_5

    .line 987
    invoke-static {v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v6

    .line 988
    if-eqz v6, :cond_5

    goto :goto_4

    .line 991
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

    .line 992
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_GAINS:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 993
    if-eqz v0, :cond_6

    .line 994
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result v20

    aput v20, v11, v9

    .line 995
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v20

    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v21

    add-float v20, v20, v21

    const/high16 v21, 0x3f000000    # 0.5f

    mul-float v20, v20, v21

    aput v20, v11, v19

    .line 996
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result v0

    aput v0, v11, v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_a

    .line 999
    :cond_6
    nop

    .line 1000
    nop

    .line 1001
    nop

    .line 1003
    :try_start_1
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->STATISTICS_LENS_SHADING_CORRECTION_MAP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/LensShadingMap;

    .line 1004
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

    .line 1005
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v10
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 1006
    :try_start_2
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v12
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1007
    :try_start_3
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v9

    new-array v9, v9, [F
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1008
    move-object/from16 v21, v1

    const/4 v1, 0x0

    :try_start_4
    invoke-virtual {v0, v9, v1}, Landroid/hardware/camera2/params/LensShadingMap;->copyGainFactors([FI)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_6

    .line 1010
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

    .line 1004
    :cond_7
    move-object/from16 v21, v1

    move v1, v9

    .line 1010
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

    .line 1012
    nop

    .line 1014
    const/16 v20, 0x64

    :try_start_5
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v14, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1015
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v22

    if-lez v22, :cond_8

    .line 1016
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    move/from16 v20, v0

    goto :goto_7

    .line 1018
    :catchall_4
    move-exception v0

    :cond_8
    :goto_7
    nop

    .line 1020
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

    .line 1023
    iget-object v1, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v2, 0x5

    aget v5, v1, v2

    .line 1024
    if-lez v5, :cond_9

    .line 1025
    const/16 v3, 0x200

    const/16 v4, 0x18

    move/from16 v1, p1

    move/from16 v2, p2

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradePixelBufferStrips([IIIIII)Z

    move-result v3

    if-nez v3, :cond_a

    .line 1026
    const-string v0, "Abort CleanBayerRaw export because strip grading was interrupted"

    invoke-static {v14, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1027
    return-void

    .line 1024
    :cond_9
    move/from16 v1, p1

    move/from16 v2, p2

    .line 1031
    :cond_a
    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2, v3}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_9

    .line 1032
    if-nez v3, :cond_b

    return-void

    .line 1035
    :cond_b
    :try_start_7
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    mul-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x4

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1036
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x62

    invoke-virtual {v3, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_8

    if-nez v1, :cond_c

    .line 1039
    :try_start_8
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_9

    .line 1036
    return-void

    .line 1037
    :cond_c
    :try_start_9
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_8

    .line 1039
    :try_start_a
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 1040
    nop

    .line 1042
    move-object/from16 v1, p3

    move-object/from16 v2, p4

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2, v3}, Lcom/motorola/camera/utility/ExifUtility;->appendExifToJpeg([BLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/mcf/McfMetadata;Ljava/lang/String;[B)[B

    move-result-object v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_9

    .line 1044
    :try_start_b
    iget-object v0, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 1045
    if-eqz v2, :cond_12

    .line 1046
    new-instance v3, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v4, Ljava/io/ByteArrayInputStream;

    invoke-direct {v4, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 1047
    nop

    .line 1048
    if-eqz v0, :cond_d

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_d

    .line 1049
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

    .line 1050
    move/from16 v6, v19

    goto :goto_8

    .line 1052
    :cond_d
    const/4 v6, 0x0

    :goto_8
    move-object/from16 v4, v24

    invoke-virtual {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_10

    .line 1053
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 1054
    if-nez v0, :cond_f

    move-object/from16 v9, v23

    if-eqz v9, :cond_f

    .line 1055
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_FOCAL_LENGTHS:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    .line 1056
    if-eqz v1, :cond_e

    array-length v5, v1

    if-lez v5, :cond_e

    .line 1057
    const/4 v5, 0x0

    aget v0, v1, v5

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto :goto_9

    .line 1056
    :cond_e
    const/4 v5, 0x0

    goto :goto_9

    .line 1054
    :cond_f
    const/4 v5, 0x0

    .line 1060
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

    .line 1061
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

    .line 1062
    move/from16 v6, v19

    goto :goto_a

    .line 1052
    :cond_10
    const/4 v5, 0x0

    .line 1065
    :cond_11
    :goto_a
    if-eqz v6, :cond_12

    .line 1066
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, v2

    add-int/lit16 v1, v1, 0x400

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1067
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v3, v1, v0, v5}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1068
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 1069
    array-length v1, v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    const/16 v3, 0x40

    if-le v1, v3, :cond_12

    .line 1070
    move-object v2, v0

    goto :goto_b

    .line 1074
    :catchall_5
    move-exception v0

    :cond_12
    :goto_b
    nop

    .line 1076
    :try_start_c
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/storage/MediaFile;->fromMediaFilePath(Lcom/motorola/camera/storage/MediaFilePath;)Lcom/motorola/camera/storage/backend/MediaStoreMediaFile;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/storage/StorageUtils;->createMediaFileWithFallback(Lcom/motorola/camera/storage/MediaFile;)Lcom/motorola/camera/storage/MediaFile;

    move-result-object v0

    .line 1077
    if-nez v0, :cond_13

    return-void

    .line 1078
    :cond_13
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->getWriteFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    .line 1079
    if-nez v1, :cond_14

    return-void

    .line 1080
    :cond_14
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_9

    .line 1081
    :try_start_d
    invoke-virtual {v3, v2}, Ljava/io/FileOutputStream;->write([B)V

    .line 1082
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_6

    .line 1083
    :try_start_e
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    .line 1084
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->finish()V

    .line 1085
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sub-long v0, v0, v16

    const-wide/32 v3, 0xf4240

    div-long/2addr v0, v3

    .line 1086
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

    .line 1089
    goto :goto_e

    .line 1080
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

    .line 1039
    :catchall_8
    move-exception v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 1040
    throw v0

    .line 958
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

    .line 959
    return-void

    .line 1087
    :catchall_9
    move-exception v0

    goto :goto_d

    :catchall_a
    move-exception v0

    move-object v14, v4

    .line 1088
    :goto_d
    const-string v1, "runCleanBayerExport failed cleanly (DNG unaffected)"

    invoke-static {v14, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1090
    :goto_e
    return-void
.end method

.method private static sensorTransformToSrgbCcm([F)[F
    .locals 26

    .line 1105
    move-object/from16 v0, p0

    if-eqz v0, :cond_5

    array-length v2, v0

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    const/16 v23, 0x0

    goto/16 :goto_3

    .line 1106
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    const/4 v5, 0x1

    aget v6, v0, v5

    const/4 v7, 0x2

    aget v8, v0, v7

    .line 1107
    const/4 v9, 0x3

    aget v10, v0, v9

    const/4 v11, 0x4

    aget v12, v0, v11

    const/4 v13, 0x5

    aget v14, v0, v13

    .line 1108
    const/4 v15, 0x6

    aget v16, v0, v15

    const/16 v17, 0x7

    aget v18, v0, v17

    const/16 v19, 0x8

    aget v0, v0, v19

    .line 1109
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

    .line 1110
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

    .line 1111
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

    .line 1112
    mul-float v4, v4, v20

    mul-float/2addr v6, v1

    add-float/2addr v4, v6

    mul-float v8, v8, v21

    add-float/2addr v4, v8

    .line 1113
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v8, 0x3727c5ac    # 1.0E-5f

    cmpg-float v6, v6, v8

    if-gez v6, :cond_1

    goto :goto_2

    .line 1114
    :cond_1
    const/high16 v6, 0x3f800000    # 1.0f

    div-float/2addr v6, v4

    .line 1116
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

    .line 1121
    new-array v0, v3, [F

    fill-array-data v0, :array_0

    .line 1126
    new-array v1, v3, [F

    .line 1127
    move/from16 v2, v25

    :goto_0
    if-ge v2, v9, :cond_3

    .line 1128
    move/from16 v3, v25

    :goto_1
    if-ge v3, v9, :cond_2

    .line 1129
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

    .line 1128
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1127
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1134
    :cond_3
    return-object v1

    .line 1113
    :cond_4
    :goto_2
    return-object v23

    .line 1105
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

    .line 447
    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_1

    .line 451
    :cond_0
    :try_start_0
    new-instance p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-direct {p1, p2, p3}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 452
    invoke-virtual {p0, p1, p4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 453
    :catchall_0
    move-exception p0

    :goto_0
    nop

    .line 454
    return-void

    .line 448
    :cond_1
    :goto_1
    return-void
.end method

.method public static shouldAllowInSensorCrop()Z
    .locals 2

    .line 377
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 378
    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    const/16 v1, 0x9

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public static shouldAllowMcf(Z)Z
    .locals 1

    .line 197
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

.method private static stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V
    .locals 2

    .line 611
    if-eqz p2, :cond_1

    :try_start_0
    invoke-virtual {p2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v0

    if-nez v0, :cond_1

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 612
    const-string v0, "ImageDescription"

    invoke-virtual {p2, v0, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 613
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, p1

    add-int/lit16 v1, v1, 0x400

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 614
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 p1, 0x0

    invoke-virtual {p2, v1, v0, p1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 615
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    .line 616
    array-length p2, p1

    const/16 v0, 0x40

    if-le p2, v0, :cond_0

    .line 617
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 619
    :cond_0
    const-string p0, "CustomImagingBridge"

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Shot diag: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 621
    :catchall_0
    move-exception p0

    :cond_1
    :goto_0
    nop

    .line 622
    return-void
.end method

.method private static toByteArray(Ljava/nio/ByteBuffer;)[B
    .locals 1

    .line 1138
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 1139
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 1140
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 1141
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1142
    return-object v0
.end method
