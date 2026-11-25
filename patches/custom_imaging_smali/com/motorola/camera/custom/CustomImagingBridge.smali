.class public final Lcom/motorola/camera/custom/CustomImagingBridge;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;,
        Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;,
        Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;,
        Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;
    }
.end annotation


# static fields
.field private static final BOKEH_DISPLAY_NAMES:[Ljava/lang/String;

.field public static final BOKEH_STYLE:Ljava/lang/String; = "com.motorola.camera.bokeh_style"

.field private static final HTP_RPC_AVAILABLE:Z

.field private static final JPEG_GRADING:Ljava/util/concurrent/Semaphore;

.field private static final JPEG_SAVE_QUALITY:I = 0x62

.field private static final KEY_ENABLE_AUTO_HDR:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

.field private static final KEY_ENABLE_ISZ:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

.field private static final KEY_ENABLE_MCTF_WITH_REF:Ljava/lang/String; = "org.codeaurora.qcamera3.sessionParameters.enableMCTFwithReferenceFrame"

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

.field private static final KEY_IS_MFNR_NIGHT:Ljava/lang/String; = "com.lenovo.moto.extension.is_mfnr_night"

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

.field private static final LOOK_DISPLAY_NAMES:[Ljava/lang/String;

.field public static final LOOK_INTENSITY:Ljava/lang/String; = "com.motorola.camera.look_intensity"

.field public static final LOOK_PRESET:Ljava/lang/String; = "com.motorola.camera.look_preset"

.field private static final LUT_POOL:Ljava/util/concurrent/ExecutorService;

.field private static final MAX_BAYER_PIXELS:I = 0x1312d00

.field private static final MAX_SHOT_CACHE:I = 0x200

.field private static final MOD_VERSION:Ljava/lang/String; = "2.0.0"

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

.field private static final TELEMETRY_COMPASS_CACHE:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;",
            ">;"
        }
    .end annotation
.end field

.field private static final TELEMETRY_NOTE_CACHE:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile application:Landroid/content/Context;

.field private static cachedLook:Lcom/motorola/camera/custom/LookFilterEngine;

.field private static loadedLook:I


# direct methods
.method static constructor <clinit>()V
    .locals 18

    .line 92
    new-instance v0, Ljava/util/concurrent/Semaphore;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    .line 138
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->checkAdspRpcReadable()Z

    move-result v0

    sput-boolean v0, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    .line 156
    nop

    .line 157
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    const/4 v2, 0x2

    div-int/2addr v0, v2

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/4 v3, 0x4

    invoke-static {v3, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    new-instance v4, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;

    const-string v5, "CustomLutWorker"

    invoke-direct {v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;-><init>(Ljava/lang/String;)V

    .line 156
    invoke-static {v0, v4}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 159
    new-instance v4, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v9, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v10, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {v10, v2}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    new-instance v11, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;

    const-string v0, "CleanBayerWorker"

    invoke-direct {v11, v0}, Lcom/motorola/camera/custom/CustomImagingBridge$DaemonThreadFactory;-><init>(Ljava/lang/String;)V

    new-instance v12, Ljava/util/concurrent/ThreadPoolExecutor$CallerRunsPolicy;

    invoke-direct {v12}, Ljava/util/concurrent/ThreadPoolExecutor$CallerRunsPolicy;-><init>()V

    const/4 v5, 0x1

    const/4 v6, 0x1

    const-wide/16 v7, 0x0

    invoke-direct/range {v4 .. v12}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;Ljava/util/concurrent/RejectedExecutionHandler;)V

    sput-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 164
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    .line 207
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    .line 208
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$1;

    const/16 v4, 0x40

    const/high16 v5, 0x3f400000    # 0.75f

    invoke-direct {v0, v4, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$1;-><init>(IFZ)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    .line 215
    const/16 v0, 0x8

    new-array v4, v0, [Ljava/lang/CharSequence;

    const-string v6, "Auto (W/O Stock \u00b7 Clean HAL + LTM)"

    const/4 v7, 0x0

    aput-object v6, v4, v7

    const-string v6, "Auto (W/ Stock \u00b7 Native SuperRes/ISP)"

    aput-object v6, v4, v1

    const-string v6, "Natural ZSL (NR ZSL / Edge ZSL)"

    aput-object v6, v4, v2

    const-string v6, "Minimal ISP (NR Minimal / Edge Off)"

    const/4 v8, 0x3

    aput-object v6, v4, v8

    const-string v6, "Detail HDR (RAW HDR / Low Halo)"

    aput-object v6, v4, v3

    const-string v6, "Pure ISP (MFNR Off / NR Off)"

    const/4 v9, 0x5

    aput-object v6, v4, v9

    const-string v6, "Clean RAW Bayer (DNG -> Clean JPG)"

    const/4 v10, 0x6

    aput-object v6, v4, v10

    const-string v6, "Disable Post Processing (MCF Off / Direct HAL)"

    const/4 v11, 0x7

    aput-object v6, v4, v11

    sput-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 226
    const/16 v4, 0xe

    new-array v6, v4, [Ljava/lang/String;

    const-string v12, "Original"

    aput-object v12, v6, v7

    const-string v12, "Leica Authentic"

    aput-object v12, v6, v1

    const-string v12, "Leica Vibrant"

    aput-object v12, v6, v2

    const-string v12, "Leica B&W HC"

    aput-object v12, v6, v8

    const-string v12, "Zeiss Natural"

    aput-object v12, v6, v3

    const-string v12, "Zeiss T* Textured"

    aput-object v12, v6, v9

    const-string v12, "Google HDR+"

    aput-object v12, v6, v10

    const-string v12, "Black Pro-Mist 1/4"

    aput-object v12, v6, v11

    const-string v12, "CineStill 800T"

    aput-object v12, v6, v0

    const-string v12, "Fujifilm Classic Chrome"

    const/16 v13, 0x9

    aput-object v12, v6, v13

    const-string v12, "Fujifilm Nostalgic Neg."

    const/16 v14, 0xa

    aput-object v12, v6, v14

    const-string v12, "Kodak Portra 400"

    const/16 v15, 0xb

    aput-object v12, v6, v15

    const-string v12, "Ricoh GR Positive"

    const/16 v16, 0xc

    aput-object v12, v6, v16

    const-string v12, "Y2K CCD"

    const/16 v17, 0xd

    aput-object v12, v6, v17

    sput-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->LOOK_DISPLAY_NAMES:[Ljava/lang/String;

    .line 233
    new-array v6, v10, [Ljava/lang/String;

    const-string v12, "Stock"

    aput-object v12, v6, v7

    const-string v12, "Biotar Swirl"

    aput-object v12, v6, v1

    const-string v12, "Planar"

    aput-object v12, v6, v2

    const-string v12, "Sonnar Creamy"

    aput-object v12, v6, v8

    const-string v12, "Anamorphic Oval"

    aput-object v12, v6, v3

    const-string v12, "Triangular B-Speed"

    aput-object v12, v6, v9

    sput-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->BOKEH_DISPLAY_NAMES:[Ljava/lang/String;

    .line 237
    new-array v6, v0, [Ljava/lang/CharSequence;

    const-string v12, "0"

    aput-object v12, v6, v7

    const-string v12, "10"

    aput-object v12, v6, v1

    const-string v12, "1"

    aput-object v12, v6, v2

    const-string v12, "2"

    aput-object v12, v6, v8

    const-string v12, "3"

    aput-object v12, v6, v3

    const-string v12, "4"

    aput-object v12, v6, v9

    const-string v12, "8"

    aput-object v12, v6, v10

    const-string v12, "9"

    aput-object v12, v6, v11

    sput-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    .line 538
    new-instance v6, Ljava/util/HashSet;

    new-array v4, v4, [Ljava/lang/String;

    const-string v12, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    aput-object v12, v4, v7

    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    aput-object v7, v4, v1

    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    aput-object v7, v4, v2

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    aput-object v2, v4, v8

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.enableMCTFwithReferenceFrame"

    aput-object v2, v4, v3

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    aput-object v2, v4, v9

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    aput-object v2, v4, v10

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    aput-object v2, v4, v11

    const-string v2, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    aput-object v2, v4, v0

    const-string v0, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    aput-object v0, v4, v13

    const-string v0, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    aput-object v0, v4, v14

    const-string v0, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    aput-object v0, v4, v15

    const-string v0, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    aput-object v0, v4, v16

    const-string v0, "com.lenovo.moto.SATFallback.T2W"

    aput-object v0, v4, v17

    invoke-static {v4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-direct {v6, v0}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    invoke-static {v6}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->KNOWN_SESSION_KEYS:Ljava/util/Set;

    .line 555
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 556
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 557
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 558
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    .line 2278
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$5;

    const/16 v2, 0x10

    invoke-direct {v0, v2, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$5;-><init>(IFZ)V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    .line 2350
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$6;

    invoke-direct {v0, v2, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$6;-><init>(IFZ)V

    .line 2351
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_COMPASS_CACHE:Ljava/util/Map;

    .line 2350
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 241
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static adaptGainmap(Landroid/graphics/Gainmap;II)V
    .locals 13

    .line 1138
    int-to-float p2, p2

    const/high16 v0, 0x42c80000    # 100.0f

    div-float/2addr p2, v0

    .line 1139
    if-eqz p0, :cond_7

    const/4 v0, 0x0

    cmpg-float v0, p2, v0

    if-gtz v0, :cond_0

    goto/16 :goto_5

    .line 1140
    :cond_0
    const/4 v0, 0x3

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne p1, v0, :cond_3

    .line 1141
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getGainmapContents()Landroid/graphics/Bitmap;

    move-result-object v4

    .line 1142
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v11

    .line 1143
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object p1

    sget-object v0, Landroid/graphics/Bitmap$Config;->ALPHA_8:Landroid/graphics/Bitmap$Config;

    if-eq p1, v0, :cond_2

    int-to-long v5, v7

    int-to-long v8, v11

    mul-long/2addr v5, v8

    const-wide/32 v8, 0x3d0900

    cmp-long p1, v5, v8

    if-gtz p1, :cond_2

    .line 1144
    mul-int p1, v7, v11

    new-array v5, p1, [I

    .line 1145
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v6, 0x0

    move v10, v7

    invoke-virtual/range {v4 .. v11}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 1146
    move v0, v2

    :goto_0
    if-ge v0, p1, :cond_1

    .line 1147
    aget v4, v5, v0

    ushr-int/lit8 v6, v4, 0x10

    and-int/lit16 v6, v6, 0xff

    ushr-int/lit8 v8, v4, 0x8

    and-int/lit16 v8, v8, 0xff

    and-int/lit16 v9, v4, 0xff

    .line 1148
    int-to-float v6, v6

    const v10, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v10, v6

    int-to-float v8, v8

    const v12, 0x3f371759    # 0.7152f

    mul-float/2addr v12, v8

    add-float/2addr v10, v12

    int-to-float v9, v9

    const v12, 0x3d93dd98    # 0.0722f

    mul-float/2addr v12, v9

    add-float/2addr v10, v12

    .line 1149
    const/high16 v12, -0x1000000

    and-int/2addr v4, v12

    sub-float v12, v10, v6

    mul-float/2addr v12, p2

    add-float/2addr v6, v12

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    shl-int/lit8 v6, v6, 0x10

    or-int/2addr v4, v6

    sub-float v6, v10, v8

    mul-float/2addr v6, p2

    add-float/2addr v8, v6

    .line 1150
    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v6

    shl-int/lit8 v6, v6, 0x8

    or-int/2addr v4, v6

    sub-float/2addr v10, v9

    mul-float/2addr v10, p2

    add-float/2addr v9, v10

    invoke-static {v9}, Ljava/lang/Math;->round(F)I

    move-result v6

    or-int/2addr v4, v6

    aput v4, v5, v0

    .line 1146
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1152
    :cond_1
    sget-object p1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v5, v7, v11, p1}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/graphics/Gainmap;->setGainmapContents(Landroid/graphics/Bitmap;)V

    .line 1154
    :cond_2
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMin()[F

    move-result-object p1

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMax()[F

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getGamma()[F

    move-result-object v4

    .line 1155
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getEpsilonSdr()[F

    move-result-object v5

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getEpsilonHdr()[F

    move-result-object v6

    .line 1156
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v0, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v4, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    .line 1157
    invoke-static {v5, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v6, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    .line 1158
    aget p2, p1, v2

    aget v7, p1, v3

    aget p1, p1, v1

    invoke-virtual {p0, p2, v7, p1}, Landroid/graphics/Gainmap;->setRatioMin(FFF)V

    .line 1159
    aget p1, v0, v2

    aget p2, v0, v3

    aget v0, v0, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setRatioMax(FFF)V

    .line 1160
    aget p1, v4, v2

    aget p2, v4, v3

    aget v0, v4, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setGamma(FFF)V

    .line 1161
    aget p1, v5, v2

    aget p2, v5, v3

    aget v0, v5, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setEpsilonSdr(FFF)V

    .line 1162
    aget p1, v6, v2

    aget p2, v6, v3

    aget v0, v6, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setEpsilonHdr(FFF)V

    goto :goto_1

    .line 1163
    :cond_3
    const/4 v0, 0x6

    if-eq p1, v3, :cond_5

    if-ne p1, v0, :cond_4

    goto :goto_2

    :cond_4
    :goto_1
    goto :goto_4

    .line 1164
    :cond_5
    :goto_2
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMax()[F

    move-result-object v4

    .line 1165
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMin()[F

    move-result-object v5

    .line 1166
    const/high16 v6, 0x3f800000    # 1.0f

    if-ne p1, v0, :cond_6

    const p1, 0x3da3d70a    # 0.08f

    mul-float/2addr p2, p1

    add-float/2addr p2, v6

    goto :goto_3

    :cond_6
    const p1, 0x3e051eb8    # 0.13f

    mul-float/2addr p2, p1

    sub-float p2, v6, p2

    .line 1167
    :goto_3
    aget p1, v5, v2

    aget v0, v4, v2

    sub-float/2addr v0, v6

    mul-float/2addr v0, p2

    add-float/2addr v0, v6

    invoke-static {p1, v0}, Ljava/lang/Math;->max(FF)F

    move-result p1

    aget v0, v5, v3

    aget v2, v4, v3

    sub-float/2addr v2, v6

    mul-float/2addr v2, p2

    add-float/2addr v2, v6

    .line 1168
    invoke-static {v0, v2}, Ljava/lang/Math;->max(FF)F

    move-result v0

    aget v2, v5, v1

    aget v1, v4, v1

    sub-float/2addr v1, v6

    mul-float/2addr v1, p2

    add-float/2addr v1, v6

    .line 1169
    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result p2

    .line 1167
    invoke-virtual {p0, p1, v0, p2}, Landroid/graphics/Gainmap;->setRatioMax(FFF)V

    .line 1171
    :goto_4
    return-void

    .line 1139
    :cond_7
    :goto_5
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 1

    .line 644
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V

    .line 645
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V
    .locals 16

    .line 649
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    if-eqz v1, :cond_12

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 651
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v3

    .line 652
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->FLASH_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 653
    const/4 v5, 0x3

    const/4 v6, 0x1

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-eqz v4, :cond_1

    .line 654
    move v3, v6

    goto :goto_0

    .line 656
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 657
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-ne v4, v5, :cond_2

    .line 658
    move v3, v6

    .line 661
    :cond_2
    :goto_0
    nop

    .line 662
    instance-of v4, v2, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v4, :cond_3

    .line 663
    move-object v4, v2

    check-cast v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 664
    iget-object v7, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 665
    iget-boolean v4, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z

    if-eqz v4, :cond_4

    .line 666
    move v3, v6

    goto :goto_1

    .line 662
    :cond_3
    const/4 v7, 0x0

    .line 670
    :cond_4
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v4

    invoke-static {v2, v7, v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v2

    .line 671
    iget-object v2, v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 672
    aget v4, v2, v6

    .line 673
    const/4 v7, 0x2

    aget v8, v2, v7

    .line 674
    aget v5, v2, v5

    .line 676
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v9

    .line 677
    const/4 v10, 0x0

    if-eqz v9, :cond_10

    .line 678
    if-ltz v4, :cond_5

    .line 679
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [I

    .line 680
    invoke-static {v11, v4}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 681
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v1, v11, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 684
    :cond_5
    if-ltz v8, :cond_6

    .line 685
    sget-object v4, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v4}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 686
    invoke-static {v4, v8}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 687
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v1, v4, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 695
    :cond_6
    invoke-static {v9, v10}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v4

    .line 696
    invoke-static {v9, v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v8

    .line 698
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_7

    .line 699
    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v4

    goto :goto_2

    .line 701
    :cond_7
    new-instance v9, Ljava/util/HashSet;

    invoke-direct {v9, v4}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 702
    invoke-interface {v9, v8}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 704
    invoke-interface {v8}, Ljava/util/Set;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_8

    .line 705
    sget-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->KNOWN_SESSION_KEYS:Ljava/util/Set;

    invoke-interface {v9, v4}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 708
    :cond_8
    move-object v4, v9

    :goto_2
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_10

    array-length v8, v2

    const/16 v9, 0xd

    if-lt v8, v9, :cond_10

    .line 709
    const/4 v8, 0x7

    aget v8, v2, v8

    .line 710
    const/16 v9, 0x8

    aget v9, v2, v9

    .line 711
    const/16 v11, 0x9

    aget v11, v2, v11

    .line 712
    const/16 v12, 0xa

    aget v12, v2, v12

    .line 713
    const/16 v13, 0xb

    aget v13, v2, v13

    .line 714
    const/16 v14, 0xc

    aget v2, v2, v14

    .line 716
    if-ltz v8, :cond_9

    .line 717
    const-string v14, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    const-class v15, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v14, v15, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 718
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    const-class v14, Ljava/lang/Byte;

    int-to-byte v15, v8

    invoke-static {v15}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v15

    invoke-static {v1, v4, v7, v14, v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 719
    if-nez v8, :cond_9

    .line 720
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v7, v8, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 723
    :cond_9
    if-ltz v9, :cond_a

    .line 724
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v8, Ljava/lang/Byte;

    int-to-byte v9, v9

    invoke-static {v9}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 726
    :cond_a
    if-ltz v11, :cond_b

    .line 727
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 729
    :cond_b
    if-ltz v12, :cond_e

    .line 730
    if-lez v12, :cond_c

    move v7, v6

    goto :goto_3

    :cond_c
    move v7, v10

    .line 731
    :goto_3
    if-lez v12, :cond_d

    const/4 v8, 0x2

    goto :goto_4

    :cond_d
    move v8, v10

    .line 732
    :goto_4
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v9, v11, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 733
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v9, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 734
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 735
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 736
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-static {v1, v4, v7, v9, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 737
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 738
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 740
    :cond_e
    if-ne v13, v6, :cond_f

    .line 741
    const-string v6, "com.lenovo.moto.SATFallback.T2W"

    const-class v7, Ljava/lang/Byte;

    invoke-static {v10}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v8

    invoke-static {v1, v4, v6, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 743
    :cond_f
    if-ltz v2, :cond_10

    .line 744
    const-string v6, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v7, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v4, v6, v7, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 748
    :cond_10
    if-nez v5, :cond_11

    .line 749
    invoke-static {v0, v1, v10, v3}, Lcom/motorola/camera/fsm/camera/modes/RequestBuilderHelper;->setMfnr(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;ZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 753
    :cond_11
    goto :goto_5

    .line 751
    :catchall_0
    move-exception v0

    .line 752
    const-string v1, "CustomImagingBridge"

    const-string v2, "applyCaptureRequestOverrides failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 754
    :goto_5
    return-void

    .line 649
    :cond_12
    :goto_6
    return-void
.end method

.method public static applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 61

    .line 859
    move-object/from16 v1, p0

    const-string v7, "CustomImagingBridge"

    if-eqz v1, :cond_55

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_55

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_32

    .line 862
    :cond_0
    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v4

    .line 863
    const-string v5, "vendor"

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 864
    const-string v2, "vendor"

    invoke-static {v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v2

    .line 865
    iget v5, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    const/16 v6, 0x9

    if-ne v5, v6, :cond_1

    .line 866
    return-void

    .line 868
    :cond_1
    iget-object v5, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v5, v5, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 869
    instance-of v6, v5, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v6, :cond_2

    iget v6, v5, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCaptureMode:I

    invoke-static {v6}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode(I)Z

    move-result v6

    if-eqz v6, :cond_2

    const/4 v6, 0x1

    goto :goto_0

    :cond_2
    const/4 v6, 0x0

    .line 870
    :goto_0
    if-eqz v6, :cond_3

    check-cast v5, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    move-object v11, v5

    goto :goto_1

    :cond_3
    move-object v11, v3

    .line 871
    :goto_1
    iget-object v5, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    const-string v12, " "

    const-string v16, ""

    if-eqz v10, :cond_4

    move-object/from16 v0, v16

    goto :goto_2

    :cond_4
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_2
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 872
    iget-object v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v10, 0x5

    aget v13, v0, v10

    .line 873
    iget v14, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    .line 874
    iget v15, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    .line 875
    invoke-static {v14}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v17

    .line 876
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->dismiss()V

    .line 877
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->acquireUninterruptibly()V

    .line 879
    :try_start_0
    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_9

    .line 880
    if-nez v0, :cond_5

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 880
    return-void

    .line 881
    :cond_5
    :try_start_1
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 882
    array-length v0, v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_9

    const/16 v9, 0x10

    if-ge v0, v9, :cond_6

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 882
    return-void

    .line 884
    :cond_6
    nop

    .line 886
    :try_start_2
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v9, Ljava/io/ByteArrayInputStream;

    invoke-direct {v9, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 887
    move-object v9, v0

    goto :goto_3

    :catchall_0
    move-exception v0

    const/4 v9, 0x0

    .line 890
    :goto_3
    const-string v8, "ImageDescription"

    if-eqz v9, :cond_7

    :try_start_3
    invoke-virtual {v9, v8}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_7
    const/4 v0, 0x0

    .line 891
    :goto_4
    if-eqz v0, :cond_8

    const-string v10, "Edge50Port "

    invoke-virtual {v0, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_9

    if-eqz v0, :cond_8

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 892
    return-void

    .line 895
    :cond_8
    if-nez v17, :cond_9

    :try_start_4
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-lez v0, :cond_9

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    if-lez v0, :cond_9

    .line 896
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v0

    move-object/from16 v31, v0

    goto :goto_5

    :cond_9
    const/16 v31, 0x0

    .line 897
    :goto_5
    if-eqz v6, :cond_a

    if-nez v17, :cond_a

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    if-lez v0, :cond_a

    const/4 v0, 0x1

    goto :goto_6

    :cond_a
    const/4 v0, 0x0

    .line 898
    :goto_6
    if-eqz v0, :cond_b

    invoke-static {v11}, Lcom/motorola/camera/custom/PortraitBokeh;->original(Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;)Ljava/nio/ByteBuffer;

    move-result-object v10

    goto :goto_7

    :cond_b
    const/4 v10, 0x0

    .line 899
    :goto_7
    nop

    .line 900
    nop

    .line 901
    if-eqz v0, :cond_f

    if-eqz v10, :cond_f

    if-eqz v9, :cond_d

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v17

    if-nez v17, :cond_c

    goto :goto_8

    :cond_c
    move/from16 v17, v0

    move/from16 v21, v6

    move-object/from16 v22, v12

    goto :goto_9

    .line 902
    :cond_d
    :goto_8
    move/from16 v17, v0

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    move/from16 v21, v6

    iget v6, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    move-object/from16 v22, v12

    iget v12, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    invoke-static {v10, v11, v0, v6, v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->renderPortrait(Ljava/nio/ByteBuffer;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;III)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 904
    if-eqz v0, :cond_e

    const-string v6, "orig"

    move-object/from16 v60, v6

    move-object v6, v0

    move-object/from16 v0, v60

    goto :goto_a

    :cond_e
    move-object v6, v0

    const/4 v0, 0x0

    goto :goto_a

    .line 901
    :cond_f
    move/from16 v17, v0

    move/from16 v21, v6

    move-object/from16 v22, v12

    .line 906
    :goto_9
    const/4 v0, 0x0

    const/4 v6, 0x0

    :goto_a
    if-nez v14, :cond_10

    if-gtz v13, :cond_10

    const/16 v32, 0x1

    goto :goto_b

    :cond_10
    const/16 v32, 0x0

    .line 907
    :goto_b
    invoke-static {v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->readIsoSafe(Lcom/motorola/camera/photometadata/PhotoMetadata;)I

    move-result v12

    .line 908
    nop

    .line 909
    nop

    .line 910
    nop

    .line 911
    nop

    .line 912
    nop

    .line 913
    nop

    .line 914
    const/high16 v23, 0x3f800000    # 1.0f

    if-eqz v32, :cond_26

    .line 915
    move-object/from16 v24, v0

    const/16 v0, 0x320

    if-ge v12, v0, :cond_14

    const v25, 0x3ee66666    # 0.45f

    cmpl-float v25, v15, v25

    const v26, 0x3fd9999a    # 1.7f

    if-ltz v25, :cond_11

    cmpg-float v25, v15, v26

    if-gez v25, :cond_11

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v27, 0x43110000    # 145.0f

    cmpg-float v0, v0, v27

    if-lez v0, :cond_13

    :cond_11
    cmpl-float v0, v15, v26

    const/high16 v26, 0x40b00000    # 5.5f

    if-ltz v0, :cond_12

    cmpg-float v0, v15, v26

    if-gez v0, :cond_12

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v27, 0x435c0000    # 220.0f

    cmpg-float v0, v0, v27

    if-ltz v0, :cond_13

    :cond_12
    cmpl-float v0, v15, v26

    if-ltz v0, :cond_14

    const/high16 v0, 0x41f00000    # 30.0f

    cmpg-float v0, v15, v0

    if-gtz v0, :cond_14

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v26, 0x43700000    # 240.0f

    cmpg-float v0, v0, v26

    if-gez v0, :cond_14

    :cond_13
    const/4 v0, 0x1

    goto :goto_c

    :cond_14
    const/4 v0, 0x0

    .line 919
    :goto_c
    move/from16 v26, v0

    if-eqz v31, :cond_15

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isDiffusionLook(I)Z

    move-result v0

    if-eqz v0, :cond_15

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move-object/from16 v28, v6

    const/16 v6, 0x28

    if-lt v0, v6, :cond_16

    .line 921
    const/16 v26, 0x0

    goto :goto_d

    .line 919
    :cond_15
    move-object/from16 v28, v6

    .line 923
    :cond_16
    :goto_d
    if-eqz v9, :cond_18

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v0

    if-nez v0, :cond_17

    goto :goto_e

    :cond_17
    move/from16 v0, v23

    const/16 v25, 0x0

    const/16 v29, 0x0

    const/16 v33, 0x0

    goto/16 :goto_14

    .line 924
    :cond_18
    :goto_e
    invoke-static {v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->evaluateAutoPostGates([B)I

    move-result v0

    .line 925
    and-int/lit8 v6, v0, 0x1

    if-eqz v6, :cond_19

    const/4 v6, 0x1

    goto :goto_f

    :cond_19
    const/4 v6, 0x0

    .line 926
    :goto_f
    and-int/lit8 v29, v0, 0x2

    if-eqz v29, :cond_1a

    const/16 v29, 0x1

    goto :goto_10

    :cond_1a
    const/16 v29, 0x0

    .line 927
    :goto_10
    if-eqz v2, :cond_1b

    move/from16 v33, v0

    iget-boolean v0, v2, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->physicalOutdoorBacklit:Z

    if-eqz v0, :cond_1c

    const/4 v0, 0x1

    goto :goto_11

    :cond_1b
    move/from16 v33, v0

    :cond_1c
    const/4 v0, 0x0

    .line 928
    :goto_11
    if-nez v6, :cond_1f

    and-int/lit8 v33, v33, 0x4

    if-eqz v33, :cond_1f

    move/from16 v33, v0

    const/16 v0, 0x320

    if-ge v12, v0, :cond_1f

    const v0, 0x403ccccd    # 2.95f

    cmpl-float v0, v15, v0

    if-ltz v0, :cond_1d

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v25, 0x43340000    # 180.0f

    cmpg-float v0, v0, v25

    if-ltz v0, :cond_1e

    :cond_1d
    if-eqz v33, :cond_1f

    :cond_1e
    const/4 v0, 0x1

    goto :goto_12

    :cond_1f
    const/4 v0, 0x0

    .line 930
    :goto_12
    if-eqz v31, :cond_24

    .line 931
    move/from16 v25, v0

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isContrastFilmLook(I)Z

    move-result v0

    if-eqz v0, :cond_20

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move/from16 v33, v6

    const/16 v6, 0x28

    if-lt v0, v6, :cond_21

    .line 933
    nop

    .line 934
    const/16 v25, 0x0

    const/16 v33, 0x0

    goto :goto_13

    .line 931
    :cond_20
    move/from16 v33, v6

    .line 936
    :cond_21
    :goto_13
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    const/4 v6, 0x6

    if-ne v0, v6, :cond_23

    .line 937
    nop

    .line 938
    if-eqz v33, :cond_22

    .line 939
    const v0, 0x3ecccccd    # 0.4f

    const/16 v29, 0x1

    goto :goto_14

    .line 938
    :cond_22
    move/from16 v0, v23

    const/16 v29, 0x1

    goto :goto_14

    .line 936
    :cond_23
    move/from16 v0, v23

    goto :goto_14

    .line 930
    :cond_24
    move/from16 v25, v0

    move/from16 v33, v6

    move/from16 v0, v23

    .line 944
    :goto_14
    if-nez v33, :cond_25

    if-nez v29, :cond_25

    if-nez v25, :cond_25

    if-nez v26, :cond_25

    if-nez v31, :cond_25

    if-nez v17, :cond_25

    .line 945
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_9

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 946
    return-void

    .line 952
    :cond_25
    move v6, v0

    goto :goto_15

    .line 948
    :cond_26
    move-object/from16 v24, v0

    move-object/from16 v28, v6

    if-gtz v13, :cond_27

    if-nez v31, :cond_27

    if-nez v17, :cond_27

    .line 949
    :try_start_5
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_9

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 950
    return-void

    .line 952
    :cond_27
    move/from16 v6, v23

    const/16 v25, 0x0

    const/16 v26, 0x0

    const/16 v29, 0x0

    const/16 v33, 0x0

    :goto_15
    if-eqz v31, :cond_28

    :try_start_6
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    move/from16 v34, v6

    const/4 v6, 0x5

    if-ne v0, v6, :cond_29

    if-eqz v26, :cond_29

    .line 953
    const/high16 v23, 0x3f000000    # 0.5f

    move/from16 v6, v23

    goto :goto_16

    .line 952
    :cond_28
    move/from16 v34, v6

    .line 956
    :cond_29
    move/from16 v6, v23

    :goto_16
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 957
    move/from16 v35, v6

    const/4 v6, 0x1

    iput-boolean v6, v0, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 958
    sget-object v6, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v6, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 959
    if-eqz v28, :cond_2a

    move-object/from16 v20, v10

    move-object/from16 v10, v28

    goto :goto_17

    .line 960
    :cond_2a
    array-length v6, v3

    move-object/from16 v20, v10

    const/4 v10, 0x0

    invoke-static {v3, v10, v6, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_9

    move-object v10, v0

    .line 961
    :goto_17
    if-nez v10, :cond_2b

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 961
    return-void

    .line 964
    :cond_2b
    :try_start_7
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_7

    if-nez v0, :cond_2c

    .line 1109
    :try_start_8
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_9

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 964
    return-void

    .line 965
    :cond_2c
    :try_start_9
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getColorSpace()Landroid/graphics/ColorSpace;

    move-result-object v0

    invoke-static {v10, v0}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->preserveDisplayP3IfWide(Landroid/graphics/Bitmap;Landroid/graphics/ColorSpace;)Z

    move-result v6

    .line 966
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->hasGainmap()Z

    move-result v0

    if-eqz v0, :cond_2d

    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getGainmap()Landroid/graphics/Gainmap;

    move-result-object v0

    move-object/from16 v44, v0

    goto :goto_18

    :cond_2d
    const/16 v44, 0x0

    .line 967
    :goto_18
    if-nez v44, :cond_2e

    if-eqz v9, :cond_2e

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v0

    if-eqz v0, :cond_2e

    .line 968
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_7

    .line 1109
    :try_start_a
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_9

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 969
    return-void

    .line 971
    :cond_2e
    move/from16 v54, v6

    :try_start_b
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_7

    .line 972
    move-object/from16 v55, v7

    :try_start_c
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    .line 973
    if-lez v6, :cond_54

    if-gtz v7, :cond_2f

    move-object/from16 v36, v10

    move-object/from16 v1, v55

    goto/16 :goto_2d

    .line 975
    :cond_2f
    if-eqz v17, :cond_31

    if-nez v28, :cond_31

    .line 976
    move-object/from16 v56, v8

    const/4 v8, 0x0

    invoke-static {v1, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_6

    .line 977
    nop

    .line 978
    if-eqz v17, :cond_30

    .line 979
    :try_start_d
    invoke-static/range {v17 .. v17}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    goto :goto_19

    :catchall_1
    move-exception v0

    .line 981
    :cond_30
    move-object v0, v8

    :goto_19
    :try_start_e
    invoke-static/range {v17 .. v17}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFrontCameraId(Ljava/lang/String;)Z

    move-result v17

    .line 982
    nop

    .line 983
    move/from16 v18, v12

    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCaptureResult(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Landroid/hardware/camera2/TotalCaptureResult;

    move-result-object v12

    move/from16 v27, v15

    iget v15, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    .line 982
    move v8, v13

    move/from16 v57, v14

    move/from16 v14, v17

    move-object/from16 v58, v20

    move-object/from16 v59, v22

    move-object v13, v0

    invoke-static/range {v10 .. v15}, Lcom/motorola/camera/custom/PortraitBokeh;->renderSingleCam(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;Landroid/hardware/camera2/TotalCaptureResult;Landroid/hardware/camera2/CameraCharacteristics;ZI)Ljava/lang/String;

    move-result-object v0

    goto :goto_1a

    .line 975
    :cond_31
    move-object/from16 v56, v8

    move/from16 v18, v12

    move v8, v13

    move/from16 v57, v14

    move/from16 v27, v15

    move-object/from16 v58, v20

    move-object/from16 v59, v22

    .line 985
    move-object/from16 v0, v24

    :goto_1a
    if-nez v0, :cond_32

    const/4 v12, 0x0

    goto :goto_1b

    :cond_32
    iget v12, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    .line 986
    :goto_1b
    if-lez v12, :cond_33

    sget-object v13, Lcom/motorola/camera/custom/CustomImagingBridge;->BOKEH_DISPLAY_NAMES:[Ljava/lang/String;

    array-length v13, v13

    if-ge v12, v13, :cond_33

    .line 987
    sget-object v13, Lcom/motorola/camera/custom/CustomImagingBridge;->BOKEH_DISPLAY_NAMES:[Ljava/lang/String;

    aget-object v13, v13, v12

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " Bokeh: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    goto :goto_1c

    :cond_33
    move-object/from16 v13, v16

    .line 988
    :goto_1c
    if-eqz v21, :cond_35

    .line 989
    if-eqz v0, :cond_34

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "("

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v14, ")"

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1d

    :cond_34
    move-object/from16 v0, v16

    :goto_1d
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " bokeh="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1e

    .line 990
    :cond_35
    move-object/from16 v0, v16

    :goto_1e
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 991
    if-eqz v32, :cond_36

    if-nez v33, :cond_36

    if-nez v29, :cond_36

    if-nez v25, :cond_36

    if-nez v26, :cond_36

    if-nez v31, :cond_36

    if-nez v12, :cond_36

    .line 993
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    .line 1109
    :try_start_f
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 994
    return-void

    .line 996
    :cond_36
    if-nez v32, :cond_37

    if-gtz v8, :cond_37

    if-nez v31, :cond_37

    if-nez v12, :cond_37

    .line 997
    :try_start_10
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_6

    .line 1109
    :try_start_11
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 998
    return-void

    .line 1111
    :catchall_2
    move-exception v0

    move-object/from16 v1, v55

    goto/16 :goto_30

    .line 1003
    :cond_37
    if-nez v44, :cond_3a

    if-nez v21, :cond_3a

    if-eqz v32, :cond_38

    if-nez v29, :cond_39

    if-nez v33, :cond_39

    if-nez v25, :cond_39

    :cond_38
    if-lez v8, :cond_3a

    :cond_39
    const/4 v5, 0x1

    goto :goto_1f

    :cond_3a
    const/4 v5, 0x0

    .line 1005
    :goto_1f
    if-eqz v5, :cond_3b

    :try_start_12
    invoke-static {v10}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->sampleQuarterPeakStats(Landroid/graphics/Bitmap;)[B

    move-result-object v5

    goto :goto_20

    :cond_3b
    const/4 v5, 0x0

    .line 1007
    :goto_20
    invoke-static {v10, v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->bitmapSurface(Landroid/graphics/Bitmap;I)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;

    move-result-object v12

    .line 1010
    if-eqz v32, :cond_41

    .line 1011
    nop

    .line 1012
    nop

    .line 1013
    nop

    .line 1014
    nop

    .line 1015
    if-eqz v33, :cond_3d

    const/16 v13, 0x10

    if-lt v6, v13, :cond_3d

    if-lt v7, v13, :cond_3d

    .line 1016
    invoke-static {}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->autoLtmGridStep()I

    move-result v13

    .line 1017
    add-int v14, v6, v13

    const/16 v30, 0x1

    add-int/lit8 v14, v14, -0x1

    div-int/2addr v14, v13

    const/4 v15, 0x2

    invoke-static {v15, v14}, Ljava/lang/Math;->max(II)I

    move-result v52

    .line 1018
    add-int v14, v7, v13

    add-int/lit8 v14, v14, -0x1

    div-int/2addr v14, v13

    invoke-static {v15, v14}, Ljava/lang/Math;->max(II)I

    move-result v53

    .line 1019
    mul-int v14, v52, v53

    new-array v15, v14, [F

    .line 1020
    new-array v14, v14, [F

    .line 1021
    move/from16 v39, v6

    mul-int v6, v39, v13

    new-array v6, v6, [I

    .line 1022
    move-object/from16 v37, v6

    const/4 v6, 0x0

    :goto_21
    if-ge v6, v7, :cond_3c

    .line 1023
    move/from16 v41, v6

    sub-int v6, v7, v41

    invoke-static {v13, v6}, Ljava/lang/Math;->min(II)I

    move-result v47
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_6

    .line 1024
    const/16 v38, 0x0

    const/16 v40, 0x0

    move/from16 v42, v39

    move-object/from16 v36, v10

    move/from16 v43, v47

    :try_start_13
    invoke-virtual/range {v36 .. v43}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_3

    .line 1025
    move/from16 v49, v7

    move-object/from16 v51, v14

    move-object/from16 v50, v15

    move-object/from16 v45, v37

    move/from16 v46, v39

    move/from16 v48, v41

    :try_start_14
    invoke-static/range {v45 .. v53}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    move/from16 v19, v49

    move-object/from16 v14, v50

    move/from16 v6, v52

    move/from16 v7, v53

    .line 1022
    add-int v15, v41, v13

    move/from16 v52, v6

    move/from16 v53, v7

    move v6, v15

    move/from16 v7, v19

    move-object v15, v14

    move-object/from16 v14, v51

    goto :goto_21

    .line 1109
    :catchall_3
    move-exception v0

    move-object/from16 v10, v36

    goto/16 :goto_2e

    .line 1027
    :cond_3c
    move/from16 v19, v7

    move-object/from16 v51, v14

    move-object v14, v15

    move/from16 v6, v52

    move/from16 v7, v53

    invoke-static {v14, v6, v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object v13

    move/from16 v22, v6

    move/from16 v23, v7

    move-object/from16 v20, v13

    move-object/from16 v21, v51

    goto :goto_22

    .line 1015
    :cond_3d
    move/from16 v39, v6

    move/from16 v19, v7

    const/16 v30, 0x1

    .line 1029
    const/16 v20, 0x0

    const/16 v21, 0x0

    const/16 v22, 0x0

    const/16 v23, 0x0

    :goto_22
    nop

    .line 1030
    nop

    .line 1031
    nop

    .line 1032
    nop

    .line 1033
    if-eqz v33, :cond_3e

    if-eqz v20, :cond_3e

    move/from16 v24, v30

    goto :goto_23

    :cond_3e
    const/16 v24, 0x0

    .line 1034
    :goto_23
    nop

    .line 1035
    nop

    .line 1036
    nop

    .line 1037
    if-nez v24, :cond_3f

    if-nez v29, :cond_3f

    if-nez v25, :cond_3f

    if-nez v26, :cond_3f

    if-nez v31, :cond_3f

    if-nez v28, :cond_3f

    .line 1038
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_6

    .line 1109
    :try_start_15
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1039
    return-void

    .line 1041
    :cond_3f
    if-nez v24, :cond_40

    if-nez v29, :cond_40

    if-nez v25, :cond_40

    if-nez v26, :cond_40

    move-object/from16 v17, v12

    move/from16 v12, v19

    move/from16 v28, v25

    move/from16 v25, v29

    move/from16 v6, v30

    move/from16 v7, v39

    goto :goto_24

    .line 1042
    :cond_40
    :try_start_16
    new-instance v17, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;

    move/from16 v28, v25

    move/from16 v25, v29

    move/from16 v29, v18

    move/from16 v18, v39

    invoke-direct/range {v17 .. v29}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;-><init>(II[F[FIIZZZFZI)V

    const/16 v20, 0x200

    const/16 v21, 0x18

    move-object/from16 v22, v17

    move-object/from16 v17, v12

    invoke-static/range {v17 .. v22}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v6

    move/from16 v7, v18

    move/from16 v12, v19

    .line 1046
    :goto_24
    move/from16 v18, v7

    move/from16 v19, v12

    goto :goto_25

    :cond_41
    move-object/from16 v17, v12

    move/from16 v28, v25

    move/from16 v25, v29

    const/16 v30, 0x1

    move v12, v7

    move v7, v6

    if-lez v8, :cond_42

    .line 1047
    new-instance v6, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;

    invoke-direct {v6, v8, v7, v12}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;-><init>(III)V

    const/16 v20, 0x200

    const/16 v21, 0x18

    move-object/from16 v22, v6

    move/from16 v18, v7

    move/from16 v19, v12

    invoke-static/range {v17 .. v22}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v6
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_6

    goto :goto_25

    .line 1051
    :cond_42
    move/from16 v18, v7

    move/from16 v19, v12

    move/from16 v6, v30

    .line 1053
    :goto_25
    if-nez v6, :cond_43

    .line 1109
    :try_start_17
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1053
    return-void

    .line 1054
    :cond_43
    if-eqz v31, :cond_44

    :try_start_18
    iget v6, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v7, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move/from16 v21, v6

    move/from16 v22, v7

    move-object/from16 v20, v31

    move/from16 v24, v34

    move/from16 v23, v35

    invoke-static/range {v17 .. v24}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z

    move-result v6
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_6

    move/from16 v12, v18

    move/from16 v13, v19

    move-object/from16 v7, v20

    if-nez v6, :cond_45

    .line 1109
    :try_start_19
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1056
    return-void

    .line 1054
    :cond_44
    move/from16 v12, v18

    move/from16 v13, v19

    move-object/from16 v7, v31

    .line 1059
    :cond_45
    nop

    .line 1060
    if-eqz v5, :cond_46

    if-nez v44, :cond_46

    .line 1061
    :try_start_1a
    invoke-static {v10}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->sampleQuarterPeakStats(Landroid/graphics/Bitmap;)[B

    move-result-object v6

    .line 1062
    const v14, 0x40366666    # 2.85f

    invoke-static {v5, v6, v12, v13, v14}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->computeFromQuarterPeakStats([B[BIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    move-result-object v5

    .line 1065
    invoke-static {v5}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->toAndroidGainmap(Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;)Landroid/graphics/Gainmap;

    move-result-object v5

    .line 1066
    if-eqz v5, :cond_46

    .line 1067
    nop

    .line 1068
    invoke-virtual {v10, v5}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    .line 1069
    goto :goto_26

    .line 1073
    :cond_46
    move-object/from16 v5, v44

    const/16 v30, 0x0

    :goto_26
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    array-length v3, v3

    invoke-direct {v6, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1074
    if-eqz v7, :cond_47

    if-eqz v5, :cond_47

    .line 1075
    iget v3, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v12, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    invoke-static {v5, v3, v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->adaptGainmap(Landroid/graphics/Gainmap;II)V

    .line 1076
    invoke-virtual {v10, v5}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    .line 1078
    :cond_47
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v12, 0x62

    invoke-virtual {v10, v3, v12, v6}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_6

    if-nez v3, :cond_48

    .line 1109
    :try_start_1b
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1079
    return-void

    .line 1081
    :cond_48
    :try_start_1c
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 1082
    nop

    .line 1083
    if-eqz v32, :cond_49

    if-eqz v33, :cond_49

    const-string v6, " ltm=1"

    goto :goto_27

    :cond_49
    move-object/from16 v6, v16

    .line 1084
    :goto_27
    if-eqz v32, :cond_4a

    if-eqz v28, :cond_4a

    if-nez v33, :cond_4a

    const-string v12, " backlit=1"

    goto :goto_28

    :cond_4a
    move-object/from16 v12, v16

    .line 1085
    :goto_28
    if-eqz v32, :cond_4b

    if-eqz v25, :cond_4b

    if-nez v33, :cond_4b

    const-string v13, " hl=1"

    goto :goto_29

    :cond_4b
    move-object/from16 v13, v16

    .line 1086
    :goto_29
    if-eqz v32, :cond_4c

    if-eqz v26, :cond_4c

    const-string v14, " zsharp=1"

    goto :goto_2a

    :cond_4c
    move-object/from16 v14, v16

    .line 1087
    :goto_2a
    if-eqz v30, :cond_4d

    const-string v15, " uhdr=synth"

    goto :goto_2b

    :cond_4d
    move-object/from16 v15, v16

    .line 1088
    :goto_2b
    if-eqz v54, :cond_4e

    const-string v16, " p3=1"
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_6

    :cond_4e
    move-object/from16 v17, v5

    move-object/from16 v5, v16

    move-object/from16 v36, v10

    :try_start_1d
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1089
    if-eqz v9, :cond_51

    .line 1090
    if-eqz v0, :cond_4f

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_4f

    .line 1091
    move-object/from16 v5, v56

    invoke-virtual {v9, v5, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1092
    const-string v5, "UserComment"

    invoke-virtual {v9, v5, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1094
    :cond_4f
    invoke-static {v9, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 1095
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    array-length v5, v3

    const/high16 v6, 0x10000

    add-int/2addr v5, v6

    invoke-direct {v2, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1096
    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-direct {v5, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v10, 0x0

    invoke-virtual {v9, v5, v2, v10}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1097
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 1098
    if-nez v17, :cond_50

    goto :goto_2c

    :cond_50
    invoke-static {v3, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->preserveGainmapExifSafe([B[B)[B

    move-result-object v2

    :goto_2c
    move-object v3, v2

    .line 1100
    :cond_51
    move-object/from16 v10, v58

    if-eqz v10, :cond_53

    if-eqz v7, :cond_53

    .line 1101
    iget v2, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v4, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    invoke-static {v10, v7, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeDepthOriginal(Ljava/nio/ByteBuffer;Lcom/motorola/camera/custom/LookFilterEngine;II)[B

    move-result-object v2
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_5

    .line 1102
    if-nez v2, :cond_52

    .line 1109
    :try_start_1e
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_2

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1102
    return-void

    .line 1103
    :cond_52
    :try_start_1f
    iget-object v4, v11, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mAuxImages:Ljava/util/HashMap;

    sget-object v5, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;->DEPTH_RENDER_ORIGINAL:Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;

    .line 1104
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 1103
    invoke-virtual {v4, v5, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1106
    :cond_53
    iget-object v1, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v3}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 1107
    array-length v1, v3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Applied post-pass p="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v3, v57

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " lut="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v2, v59

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_5

    move-object/from16 v1, v55

    :try_start_20
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_20
    .catchall {:try_start_20 .. :try_end_20} :catchall_4

    .line 1109
    :try_start_21
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V

    .line 1110
    goto :goto_31

    .line 1109
    :catchall_4
    move-exception v0

    goto :goto_2f

    :catchall_5
    move-exception v0

    goto :goto_2e

    .line 973
    :cond_54
    move-object/from16 v36, v10

    move-object/from16 v1, v55

    .line 1109
    :goto_2d
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_21
    .catchall {:try_start_21 .. :try_end_21} :catchall_8

    .line 1114
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 973
    return-void

    .line 1109
    :catchall_6
    move-exception v0

    move-object/from16 v36, v10

    :goto_2e
    move-object/from16 v1, v55

    goto :goto_2f

    :catchall_7
    move-exception v0

    move-object v1, v7

    move-object/from16 v36, v10

    :goto_2f
    :try_start_22
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V

    .line 1110
    throw v0
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_8

    .line 1111
    :catchall_8
    move-exception v0

    goto :goto_30

    :catchall_9
    move-exception v0

    move-object v1, v7

    .line 1112
    :goto_30
    :try_start_23
    const-string v2, "applyCustomLutIfEnabled failed, keeping original JPEG"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_a

    .line 1114
    :goto_31
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1115
    nop

    .line 1116
    return-void

    .line 1114
    :catchall_a
    move-exception v0

    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v1}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1115
    throw v0

    .line 860
    :cond_55
    :goto_32
    return-void
.end method

.method private static applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z
    .locals 6

    .line 1212
    new-instance v5, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;

    invoke-direct {v5, p3, p5}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;-><init>(Lcom/motorola/camera/custom/LookFilterEngine;I)V

    const/16 v3, 0x200

    const/4 v4, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result p0

    move-object p1, v0

    move p2, v1

    move p3, v2

    if-nez p0, :cond_0

    .line 1214
    const/4 p0, 0x0

    return p0

    .line 1216
    :cond_0
    invoke-static {p4}, Lcom/motorola/camera/custom/LookOptics;->needsPass(I)Z

    move-result p0

    if-nez p0, :cond_1

    .line 1217
    const/4 p0, 0x1

    return p0

    .line 1219
    :cond_1
    invoke-static/range {p1 .. p7}, Lcom/motorola/camera/custom/LookOptics;->prepare(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIIFF)Lcom/motorola/camera/custom/LookOptics;

    move-result-object p0

    .line 1220
    new-instance p6, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;

    invoke-direct {p6, p0}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;-><init>(Lcom/motorola/camera/custom/LookOptics;)V

    const/16 p4, 0x200

    const/4 p5, 0x0

    invoke-static/range {p1 .. p6}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result p0

    return p0
.end method

.method public static applySessionParameterOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 5

    .line 605
    const-string v0, "CustomImagingBridge"

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result v1

    .line 606
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 607
    if-eqz v1, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->ctwoRearTcs3408Layout()Lcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;

    move-result-object v3

    .line 606
    :goto_0
    invoke-static {v2, p0, v1, v3}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraActive(Landroid/content/Context;Ljava/lang/String;ZLcom/motorola/camera/custom/TelemetryCollector$SpectralLayout;)V

    .line 608
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onModeChanged()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 611
    goto :goto_1

    .line 609
    :catchall_0
    move-exception v1

    .line 610
    const-string v2, "TelemetryCollector.onCameraActive skipped"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 612
    :goto_1
    if-eqz p1, :cond_5

    if-nez p0, :cond_1

    goto :goto_3

    .line 614
    :cond_1
    :try_start_1
    invoke-static {p0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->beginSession(Ljava/lang/String;)I

    .line 615
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resetAwbSwitchTracker()V

    .line 617
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v1

    .line 618
    const/16 v2, 0x9

    if-eq v1, v2, :cond_2

    const/4 v2, 0x4

    if-eq v1, v2, :cond_2

    .line 624
    return-void

    .line 627
    :cond_2
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 628
    if-nez p0, :cond_3

    return-void

    .line 629
    :cond_3
    const/4 v1, 0x1

    invoke-static {p0, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object p0

    .line 630
    invoke-interface {p0}, Ljava/util/Set;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_4

    return-void

    .line 632
    :cond_4
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v2, Ljava/lang/Integer;

    const/4 v3, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {p1, p0, v1, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 633
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {p1, p0, v1, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 634
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {p1, p0, v1, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 635
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v2, Ljava/lang/Byte;

    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v4

    invoke-static {p1, p0, v1, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 636
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableMCTFwithReferenceFrame"

    const-class v2, Ljava/lang/Byte;

    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v4

    invoke-static {p1, p0, v1, v2, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 637
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 640
    goto :goto_2

    .line 638
    :catchall_1
    move-exception p0

    .line 639
    const-string p1, "applySessionParameterOverrides failed"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 641
    :goto_2
    return-void

    .line 612
    :cond_5
    :goto_3
    return-void
.end method

.method public static applyVideoRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;I)V
    .locals 3

    .line 2172
    if-eqz p1, :cond_a

    if-nez p0, :cond_0

    goto/16 :goto_4

    .line 2174
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2175
    if-nez p0, :cond_1

    return-void

    .line 2177
    :cond_1
    nop

    .line 2178
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Range;

    .line 2179
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2180
    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    .line 2181
    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    if-lez v0, :cond_3

    .line 2182
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    goto :goto_0

    .line 2181
    :cond_3
    const/16 v0, 0x1e

    .line 2185
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoEdgeMode()I

    move-result v1

    .line 2186
    sget-object v2, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v2}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 2187
    invoke-static {v2, v1}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2188
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v2, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2191
    :cond_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoNoiseReductionMode(I)I

    move-result v0

    .line 2192
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [I

    .line 2193
    invoke-static {v1, v0}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 2194
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2197
    :cond_5
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_OPTICAL_STABILIZATION:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [I

    .line 2198
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->LENS_OPTICAL_STABILIZATION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 2199
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isDualCaptureMode()Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_7

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isDualCaptureVideoMode()Z

    move-result v1

    if-eqz v1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v1, 0x0

    goto :goto_2

    :cond_7
    :goto_1
    move v1, v2

    .line 2200
    :goto_2
    invoke-static {p0, v0, v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldSetVideoOis([ILjava/lang/Integer;Z)Z

    move-result p0

    if-eqz p0, :cond_8

    .line 2201
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->LENS_OPTICAL_STABILIZATION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, p0, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2204
    :cond_8
    const/4 p0, 0x3

    if-ne p2, p0, :cond_9

    .line 2205
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->nextVideoAwbLockOverride()Ljava/lang/Boolean;

    move-result-object p0

    .line 2206
    if-eqz p0, :cond_9

    .line 2207
    sget-object p2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_LOCK:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, p2, p0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2212
    :cond_9
    goto :goto_3

    .line 2210
    :catchall_0
    move-exception p0

    .line 2211
    const-string p1, "CustomImagingBridge"

    const-string p2, "applyVideoRequestOverrides failed"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2213
    :goto_3
    return-void

    .line 2172
    :cond_a
    :goto_4
    return-void
.end method

.method public static applyVideoSnapshotOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 3

    .line 2216
    if-eqz p1, :cond_6

    if-nez p0, :cond_0

    goto :goto_2

    .line 2218
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2219
    if-nez p0, :cond_1

    return-void

    .line 2221
    :cond_1
    nop

    .line 2222
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Range;

    .line 2223
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2224
    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    .line 2225
    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    if-lez v0, :cond_3

    .line 2226
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    goto :goto_0

    .line 2225
    :cond_3
    const/16 v0, 0x1e

    .line 2229
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoEdgeMode()I

    move-result v1

    .line 2230
    sget-object v2, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v2}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 2231
    invoke-static {v2, v1}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2232
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v2, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2235
    :cond_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoNoiseReductionMode(I)I

    move-result v0

    .line 2236
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [I

    .line 2237
    invoke-static {p0, v0}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result p0

    if-eqz p0, :cond_5

    .line 2238
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, p0, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2242
    :cond_5
    goto :goto_1

    .line 2240
    :catchall_0
    move-exception p0

    .line 2241
    const-string p1, "CustomImagingBridge"

    const-string v0, "applyVideoSnapshotOverrides failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2243
    :goto_1
    return-void

    .line 2216
    :cond_6
    :goto_2
    return-void
.end method

.method private static arraySurface([II)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;
    .locals 1

    .line 1236
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$3;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$3;-><init>([II)V

    return-object v0
.end method

.method public static awaitCameraDataReadyForGallery(Lcom/motorola/camera/CameraData;)V
    .locals 11

    .line 1937
    if-nez p0, :cond_0

    return-void

    .line 1940
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/motorola/camera/CameraData;->getId()J

    move-result-wide v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1943
    nop

    .line 1944
    const-wide/16 v2, 0x0

    cmp-long p0, v0, v2

    if-gtz p0, :cond_1

    return-void

    .line 1948
    :cond_1
    move-wide v4, v2

    .line 1952
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

    .line 1955
    :goto_1
    nop

    .line 1956
    const-string v6, "CustomImagingBridge"

    if-nez p0, :cond_4

    .line 1957
    cmp-long p0, v4, v2

    if-eqz p0, :cond_3

    .line 1958
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v4

    const-wide/32 v4, 0xf4240

    div-long/2addr v2, v4

    .line 1959
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

    .line 1961
    :cond_3
    return-void

    .line 1963
    :cond_4
    cmp-long p0, v4, v2

    if-nez p0, :cond_5

    .line 1964
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    goto :goto_2

    .line 1965
    :cond_5
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v7

    sub-long/2addr v7, v4

    const-wide v9, 0x165a0bc00L

    cmp-long p0, v7, v9

    if-ltz p0, :cond_6

    .line 1966
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

    .line 1967
    return-void

    .line 1970
    :cond_6
    :goto_2
    const-wide/16 v6, 0x23

    :try_start_2
    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0

    .line 1974
    nop

    .line 1975
    goto :goto_0

    .line 1971
    :catch_0
    move-exception p0

    .line 1972
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Thread;->interrupt()V

    .line 1973
    return-void

    .line 1953
    :catchall_0
    move-exception p0

    .line 1954
    return-void

    .line 1941
    :catchall_1
    move-exception p0

    .line 1942
    return-void
.end method

.method private static bitmapSurface(Landroid/graphics/Bitmap;I)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;
    .locals 1

    .line 1225
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$2;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$2;-><init>(Landroid/graphics/Bitmap;I)V

    return-object v0
.end method

.method private static calibratedFocalLengthPx(Ljava/lang/String;F)F
    .locals 3

    .line 1355
    invoke-static {p1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    cmpl-float v0, p1, v1

    if-gtz v0, :cond_0

    goto :goto_0

    .line 1357
    :cond_0
    if-eqz p0, :cond_1

    .line 1358
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 1359
    if-eqz p0, :cond_1

    .line 1360
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_ACTIVE_ARRAY_SIZE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;

    .line 1361
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_PHYSICAL_SIZE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/util/SizeF;

    .line 1362
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    if-lez v1, :cond_1

    if-eqz p0, :cond_1

    .line 1363
    invoke-virtual {p0}, Landroid/util/SizeF;->getWidth()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Landroid/util/SizeF;->getWidth()F

    move-result v1

    const v2, 0x3dcccccd    # 0.1f

    cmpl-float v1, v1, v2

    if-lez v1, :cond_1

    .line 1364
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Landroid/util/SizeF;->getWidth()F

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    div-float/2addr v0, p0

    mul-float/2addr p1, v0

    return p1

    .line 1368
    :catchall_0
    move-exception p0

    :cond_1
    nop

    .line 1369
    const/high16 p0, 0x43fa0000    # 500.0f

    mul-float/2addr p1, p0

    return p1

    .line 1355
    :cond_2
    :goto_0
    return v1
.end method

.method private static captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J
    .locals 10

    .line 325
    const-wide/16 v0, 0x0

    if-nez p0, :cond_0

    return-wide v0

    .line 326
    :cond_0
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    const/16 v3, 0x20

    const-wide/32 v4, 0x7fffffff

    const-wide v6, 0xffffffffL

    if-eqz v2, :cond_2

    .line 327
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v2, v2, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 328
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    .line 329
    or-long/2addr v2, v6

    .line 330
    cmp-long p0, v2, v0

    if-eqz p0, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v2, 0x1

    :goto_0
    return-wide v2

    .line 332
    :cond_2
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v2

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 333
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    or-long/2addr v2, v6

    const-wide/high16 v4, -0x8000000000000000L

    or-long/2addr v2, v4

    .line 334
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

    .line 142
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "/dev/adsprpc-smd"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 143
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v2, :cond_0

    .line 144
    return v0

    .line 146
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 147
    nop

    .line 148
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 147
    const/4 v0, 0x1

    return v0

    .line 148
    :catchall_0
    move-exception v1

    .line 149
    return v0

    .line 151
    :catchall_1
    move-exception v1

    .line 152
    return v0
.end method

.method public static clearStockMeishePhotoFilter()V
    .locals 8

    .line 2052
    :try_start_0
    const-class v0, Lcom/motorola/camera/settings/SettingsManager;

    .line 2053
    const-string v1, "MEISHE_PHOTO_LUT_FILE_NAME"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 2054
    const-string v3, "MCF_MEISHE_EFFECTS_MODE_PHOTO"

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 2055
    const-string v4, "set"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const/4 v7, 0x0

    aput-object v6, v5, v7

    const-class v6, Ljava/lang/Object;

    const/4 v7, 0x1

    aput-object v6, v5, v7

    invoke-virtual {v0, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 2056
    const-string v4, "Original"

    filled-new-array {v1, v4}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 2057
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    filled-new-array {v3, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 2058
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 2059
    return-void
.end method

.method public static configureGalleryIntent(Landroid/content/Intent;Z)V
    .locals 1

    .line 1983
    if-eqz p0, :cond_1

    if-eqz p1, :cond_0

    goto :goto_0

    .line 1984
    :cond_0
    const-string p1, "exit_on_swipe"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1985
    return-void

    .line 1983
    :cond_1
    :goto_0
    return-void
.end method

.method private static decodeMutable([B)Landroid/graphics/Bitmap;
    .locals 3

    .line 1179
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 1180
    const/4 v1, 0x1

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 1181
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 1182
    const/4 v1, 0x0

    array-length v2, p0

    invoke-static {p0, v1, v2, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method static effectPreference(Ljava/lang/String;II)I
    .locals 2

    .line 114
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 115
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 116
    if-ltz p0, :cond_0

    if-gt p0, p2, :cond_0

    move p1, p0

    :cond_0
    return p1

    .line 117
    :catch_0
    move-exception p0

    .line 118
    return p1
.end method

.method private static evaluateAutoPostGates([B)I
    .locals 11

    .line 831
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 832
    const/4 v1, 0x4

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 833
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 834
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 835
    if-nez v3, :cond_0

    return v2

    .line 837
    :cond_0
    :try_start_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    .line 838
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    .line 839
    const/16 p0, 0x10

    if-lt v6, p0, :cond_5

    if-ge v10, p0, :cond_1

    goto :goto_0

    .line 840
    :cond_1
    mul-int p0, v6, v10

    new-array v4, p0, [I

    .line 841
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v5, 0x0

    move v9, v6

    invoke-virtual/range {v3 .. v10}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 842
    nop

    .line 843
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoLtmGate([II)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 844
    const/4 v2, 0x1

    .line 846
    :cond_2
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoHighlightGate([II)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 847
    or-int/lit8 v2, v2, 0x2

    .line 849
    :cond_3
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoBacklitSubjectGate([II)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_4

    .line 850
    or-int/lit8 v2, v2, 0x4

    .line 852
    :cond_4
    nop

    .line 854
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 852
    return v2

    .line 854
    :cond_5
    :goto_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 839
    return v2

    .line 854
    :catchall_0
    move-exception v0

    move-object p0, v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 855
    throw p0
.end method

.method public static evaluateFrontAfTimeout(Ljava/lang/String;Landroid/hardware/camera2/TotalCaptureResult;)I
    .locals 3

    .line 2076
    const/4 p0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result v0

    .line 2077
    if-eqz v0, :cond_7

    if-nez p1, :cond_0

    goto :goto_4

    .line 2078
    :cond_0
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 2079
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {p1, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    .line 2080
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    :cond_1
    move v0, p0

    .line 2081
    :goto_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    goto :goto_1

    :cond_2
    move p1, p0

    .line 2082
    :goto_1
    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/motorola/camera/custom/FrontAfHelper;->applies(ZI)Z

    move-result v2

    if-nez v2, :cond_3

    return p0

    .line 2083
    :cond_3
    invoke-static {v1, v0}, Lcom/motorola/camera/custom/FrontAfHelper;->noteResult(ZI)I

    .line 2084
    invoke-static {v1, v0, p1}, Lcom/motorola/camera/custom/FrontAfHelper;->shouldCompleteCurrent(ZII)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_4

    .line 2085
    return v1

    .line 2087
    :cond_4
    const/4 v0, 0x2

    if-eq p1, v0, :cond_6

    const/4 v1, 0x4

    if-ne p1, v1, :cond_5

    goto :goto_2

    .line 2088
    :cond_5
    goto :goto_3

    :cond_6
    :goto_2
    move p0, v0

    .line 2087
    :goto_3
    return p0

    .line 2077
    :cond_7
    :goto_4
    return p0

    .line 2089
    :catchall_0
    move-exception p1

    .line 2090
    return p0
.end method

.method public static exportCleanBayerJpeg(Ljava/nio/ByteBuffer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 10

    .line 1572
    if-eqz p0, :cond_b

    if-eqz p1, :cond_b

    if-eqz p3, :cond_b

    if-nez p2, :cond_0

    goto/16 :goto_6

    .line 1573
    :cond_0
    iget v2, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    .line 1574
    iget v3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    .line 1575
    invoke-static {p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v6

    .line 1576
    iget-object v0, v6, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v1, 0x6

    aget v0, v0, v1

    if-nez v0, :cond_1

    return-void

    .line 1577
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

    .line 1582
    :cond_2
    const-wide/16 v4, 0x5

    mul-long/2addr v0, v4

    const-wide/16 v4, 0x4

    :try_start_0
    div-long/2addr v0, v4

    .line 1583
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

    .line 1584
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

    .line 1585
    return-void

    .line 1587
    :cond_3
    iget-object v0, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    .line 1588
    if-eqz v0, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v1, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v1, v1, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    if-nez v1, :cond_4

    goto/16 :goto_3

    .line 1589
    :cond_4
    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->asSharedMediaFile()Lcom/motorola/camera/storage/backend/MediaStoreFile;

    move-result-object v0

    .line 1590
    if-eqz v0, :cond_8

    iget-object v1, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    if-nez v1, :cond_5

    goto :goto_2

    .line 1592
    :cond_5
    iget-object v1, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v1, :cond_6

    iget-object p3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p3}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_6
    const-string p3, "IMG_CLEAN"

    .line 1593
    :goto_0
    const-string v1, ".dng"

    invoke-virtual {p3, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v4, "_CLEAN.jpg"

    if-eqz v1, :cond_7

    .line 1594
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

    .line 1595
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

    .line 1596
    :goto_1
    iget-object p3, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-virtual {p3, v7}, Lcom/motorola/camera/storage/MediaFilePath;->withFileName(Ljava/lang/String;)Lcom/motorola/camera/storage/MediaFilePath;

    move-result-object v8

    .line 1597
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v1

    .line 1599
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v8}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;-><init>([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    invoke-interface {p0, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1603
    goto :goto_4

    .line 1590
    :cond_8
    :goto_2
    return-void

    .line 1588
    :cond_9
    :goto_3
    return-void

    .line 1601
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 1602
    const-string p1, "exportCleanBayerJpeg dispatch failed (DNG unaffected)"

    invoke-static {v9, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1604
    :goto_4
    return-void

    .line 1578
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

    .line 1579
    return-void

    .line 1572
    :cond_b
    :goto_6
    return-void
.end method

.method private static extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 2264
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    .line 2265
    :cond_0
    const/4 p1, 0x0

    if-eqz p0, :cond_4

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-nez v0, :cond_1

    goto :goto_0

    .line 2266
    :cond_1
    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object v0, v0, Lcom/motorola/camera/saving/ImageDataHolder;->mCameraId:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 2267
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object p0, p0, Lcom/motorola/camera/saving/ImageDataHolder;->mCameraId:Ljava/lang/String;

    return-object p0

    .line 2269
    :cond_2
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 2270
    if-eqz p0, :cond_3

    iget-object v0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCameraId:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object p0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCameraId:Ljava/lang/String;

    return-object p0

    .line 2272
    :cond_3
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2273
    :catchall_0
    move-exception p0

    .line 2274
    return-object p1

    .line 2265
    :cond_4
    :goto_0
    return-object p1
.end method

.method private static extractCaptureResult(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Landroid/hardware/camera2/TotalCaptureResult;
    .locals 4

    .line 2246
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-nez v1, :cond_0

    goto :goto_1

    .line 2247
    :cond_0
    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v1, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v1, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object v1, v1, Lcom/motorola/camera/saving/ImageDataHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v1, :cond_1

    .line 2248
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object p0, p0, Lcom/motorola/camera/saving/ImageDataHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    return-object p0

    .line 2250
    :cond_1
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 2251
    instance-of v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v1, :cond_3

    .line 2252
    check-cast p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 2253
    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    if-eqz v1, :cond_3

    .line 2254
    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    :goto_0
    if-ltz v1, :cond_3

    .line 2255
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/motorola/camera/saving/CaptureHolder;

    .line 2256
    if-eqz v2, :cond_2

    iget-object v3, v2, Lcom/motorola/camera/saving/CaptureHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v3, :cond_2

    iget-object p0, v2, Lcom/motorola/camera/saving/CaptureHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    return-object p0

    .line 2254
    :cond_2
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 2260
    :cond_3
    return-object v0

    .line 2246
    :cond_4
    :goto_1
    return-object v0
.end method

.method private static extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F
    .locals 4

    .line 1879
    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1880
    :cond_0
    const/16 v0, 0x9

    new-array v1, v0, [Landroid/util/Rational;

    .line 1881
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 1882
    new-array p0, v0, [F

    .line 1883
    nop

    :goto_0
    if-ge v2, v0, :cond_3

    .line 1884
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

    .line 1883
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1886
    :cond_3
    return-object p0
.end method

.method private static extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 2359
    nop

    .line 2360
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    if-eqz p0, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v0, :cond_1

    .line 2361
    iget-object p1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p1}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p1

    .line 2363
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_2
    if-eqz p0, :cond_3

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v0, :cond_3

    .line 2366
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object p0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p0}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p1

    .line 2368
    :cond_3
    return-object p1
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

    .line 561
    if-nez p0, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object p0

    return-object p0

    .line 562
    :cond_0
    if-eqz p1, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 563
    :goto_0
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 564
    if-eqz v1, :cond_2

    return-object v1

    .line 565
    :cond_2
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 566
    nop

    .line 568
    const/4 v2, 0x0

    if-eqz p1, :cond_3

    .line 569
    :try_start_0
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableSessionKeys()Ljava/util/List;

    move-result-object v3

    goto :goto_1

    .line 570
    :cond_3
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableCaptureRequestKeys()Ljava/util/List;

    move-result-object v3

    .line 571
    :goto_1
    if-eqz v3, :cond_5

    .line 572
    nop

    .line 573
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

    .line 574
    if-eqz v4, :cond_4

    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_4

    .line 575
    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 577
    :cond_4
    goto :goto_2

    .line 579
    :catchall_0
    move-exception v3

    :cond_5
    nop

    .line 580
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    .line 581
    if-eqz v2, :cond_7

    if-eqz p1, :cond_6

    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_7

    .line 582
    :cond_6
    invoke-interface {v0, p0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 584
    :cond_7
    return-object v1
.end method

.method private static getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 5

    .line 425
    if-nez p0, :cond_1

    .line 426
    nop

    .line 427
    if-nez p1, :cond_0

    .line 429
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 430
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_0

    .line 432
    :cond_0
    :goto_1
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0

    .line 434
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J

    move-result-wide v0

    .line 435
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    monitor-enter v2

    .line 436
    :try_start_1
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 437
    if-eqz v3, :cond_2

    .line 438
    monitor-exit v2

    return-object v3

    .line 440
    :cond_2
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 441
    if-eqz v3, :cond_3

    .line 442
    sget-object p1, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p1, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 443
    monitor-exit v2

    return-object v3

    .line 445
    :cond_3
    nop

    .line 446
    nop

    .line 447
    instance-of v3, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v3, :cond_5

    .line 448
    move-object v3, p0

    check-cast v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 449
    if-nez p1, :cond_4

    iget-object p1, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 450
    :cond_4
    iget-boolean v3, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-eqz v3, :cond_5

    const/4 p2, 0x1

    .line 452
    :cond_5
    if-nez p1, :cond_6

    .line 454
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 455
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v3

    goto :goto_2

    .line 457
    :cond_6
    :goto_3
    :try_start_3
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 458
    sget-object p2, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p2, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 459
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-interface {p0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 460
    monitor-exit v2

    return-object p1

    .line 461
    :catchall_2
    move-exception p0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw p0
.end method

.method private static getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 3

    .line 465
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    .line 466
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    goto :goto_0

    .line 467
    :cond_0
    move-object p0, v0

    .line 468
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v1

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    invoke-static {p0, v0, v1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0
.end method

.method static getProfileShortLabel(Landroid/content/Context;I)Ljava/lang/String;
    .locals 4

    .line 282
    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 283
    :goto_0
    nop

    .line 284
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    .line 285
    const/4 v0, 0x0

    move v1, v0

    :goto_1
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    .line 286
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    aget-object v2, v2, v1

    invoke-interface {v2, p1}, Ljava/lang/CharSequence;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 287
    nop

    .line 288
    goto :goto_2

    .line 285
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    move v1, v0

    .line 291
    :goto_2
    if-eqz p0, :cond_4

    .line 292
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    .line 293
    if-eqz p1, :cond_3

    const-string v2, "array"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    const-string v3, "port_profile_shorts"

    invoke-virtual {p1, v3, v2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    goto :goto_3

    :cond_3
    move p0, v0

    .line 294
    :goto_3
    if-eqz p0, :cond_4

    .line 295
    invoke-virtual {p1, p0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    .line 296
    if-eqz p0, :cond_4

    array-length p1, p0

    if-ge v1, p1, :cond_4

    .line 297
    aget-object p0, p0, v1

    return-object p0

    .line 301
    :cond_4
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    aget-object p0, p0, v1

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p0

    .line 302
    const/16 p1, 0x28

    invoke-virtual {p0, p1}, Ljava/lang/String;->indexOf(I)I

    move-result p1

    .line 303
    if-lez p1, :cond_5

    invoke-virtual {p0, v0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getSelectedProfile()I
    .locals 4

    .line 308
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 309
    if-nez v1, :cond_0

    return v0

    .line 310
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

    .line 311
    :catchall_0
    move-exception v1

    .line 312
    return v0
.end method

.method private static gradeDepthOriginal(Ljava/nio/ByteBuffer;Lcom/motorola/camera/custom/LookFilterEngine;II)[B
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1187
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object p0

    .line 1188
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->decodeMutable([B)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 1189
    const/4 v0, 0x0

    if-nez v1, :cond_0

    return-object v0

    .line 1191
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    .line 1205
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1191
    return-object v0

    .line 1192
    :cond_1
    :try_start_1
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->hasGainmap()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getGainmap()Landroid/graphics/Gainmap;

    move-result-object v2

    goto :goto_0

    :cond_2
    move-object v2, v0

    .line 1193
    :goto_0
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    .line 1194
    invoke-static {v1, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->bitmapSurface(Landroid/graphics/Bitmap;I)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;

    move-result-object v3

    const/high16 v9, 0x3f800000    # 1.0f

    const/high16 v10, 0x3f800000    # 1.0f

    move-object v6, p1

    move v7, p2

    move v8, p3

    invoke-static/range {v3 .. v10}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z

    move-result p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez p1, :cond_3

    .line 1205
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1194
    return-object v0

    .line 1195
    :cond_3
    :try_start_2
    invoke-static {v2, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->adaptGainmap(Landroid/graphics/Gainmap;II)V

    .line 1196
    if-eqz v2, :cond_4

    invoke-virtual {v1, v2}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    .line 1197
    :cond_4
    new-instance p1, Ljava/io/ByteArrayOutputStream;

    array-length p2, p0

    invoke-direct {p1, p2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1198
    sget-object p2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 p3, 0x62

    invoke-virtual {v1, p2, p3, p1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result p2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez p2, :cond_5

    .line 1205
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1198
    return-object v0

    .line 1199
    :cond_5
    :try_start_3
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    .line 1200
    new-instance p2, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance p3, Ljava/io/ByteArrayInputStream;

    invoke-direct {p3, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {p2, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 1201
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    array-length p3, p1

    invoke-direct {p0, p3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1202
    new-instance p3, Ljava/io/ByteArrayInputStream;

    invoke-direct {p3, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v0, 0x0

    invoke-virtual {p2, p3, p0, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1203
    if-nez v2, :cond_6

    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    goto :goto_1

    :cond_6
    invoke-virtual {p0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    invoke-static {p1, p0}, Lcom/motorola/camera/custom/GainmapJpeg;->withExif([B[B)[B

    move-result-object p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1205
    :goto_1
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1203
    return-object p0

    .line 1205
    :catchall_0
    move-exception v0

    move-object p0, v0

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1206
    throw p0
.end method

.method public static gradePixelBufferStrips([IIIIII)Z
    .locals 6

    .line 1338
    if-eqz p0, :cond_2

    if-lez p1, :cond_2

    if-lez p2, :cond_2

    if-lez p3, :cond_2

    if-gtz p5, :cond_0

    goto :goto_0

    .line 1339
    :cond_0
    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_1

    const/4 p0, 0x0

    return p0

    .line 1340
    :cond_1
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$4;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$4;-><init>([II)V

    new-instance v5, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;

    invoke-direct {v5, p5, p1, p2}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;-><init>(III)V

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result p0

    return p0

    .line 1338
    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private static gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z
    .locals 26

    .line 1261
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

    .line 1262
    :cond_0
    const/4 v4, 0x0

    move/from16 v5, p4

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 1264
    new-instance v6, Ljava/util/ArrayList;

    const/4 v7, 0x4

    invoke-direct {v6, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1265
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1266
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1267
    nop

    .line 1268
    nop

    .line 1269
    nop

    .line 1271
    move v13, v1

    move v11, v4

    move v14, v11

    const/4 v12, 0x0

    :goto_0
    if-ge v11, v1, :cond_9

    .line 1272
    sub-int v15, v1, v11

    invoke-static {v2, v15}, Ljava/lang/Math;->min(II)I

    move-result v15

    .line 1273
    sub-int v10, v11, v5

    invoke-static {v4, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 1274
    const/16 v22, 0x1

    add-int v3, v11, v15

    add-int v7, v3, v5

    invoke-static {v1, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 1275
    sub-int v4, v7, v10

    .line 1276
    sub-int v16, v11, v10

    mul-int v2, v16, p1

    .line 1277
    move/from16 v24, v14

    mul-int v14, p1, v4

    new-array v14, v14, [I

    .line 1278
    move/from16 v25, v5

    const/4 v5, 0x0

    invoke-interface {v0, v10, v4, v14, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    .line 1280
    if-eqz v12, :cond_2

    add-int v5, v13, v24

    if-ge v10, v5, :cond_2

    .line 1281
    invoke-static {v10, v13}, Ljava/lang/Math;->max(II)I

    move-result v16

    .line 1282
    invoke-static {v7, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 1283
    sub-int v5, v5, v16

    .line 1284
    if-lez v5, :cond_1

    .line 1285
    sub-int v7, v16, v13

    mul-int v7, v7, p1

    sub-int v16, v16, v10

    move/from16 v20, v4

    mul-int v4, v16, p1

    mul-int v5, v5, p1

    invoke-static {v12, v7, v14, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_1

    .line 1284
    :cond_1
    move/from16 v20, v4

    goto :goto_1

    .line 1280
    :cond_2
    move/from16 v20, v4

    .line 1291
    :goto_1
    invoke-interface {v6, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1292
    filled-new-array {v11, v15, v2}, [I

    move-result-object v2

    invoke-interface {v8, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1293
    nop

    .line 1294
    nop

    .line 1295
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

    .line 1298
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

    .line 1299
    :goto_3
    if-eqz v2, :cond_8

    .line 1300
    nop

    .line 1301
    nop

    .line 1302
    nop

    .line 1303
    nop

    .line 1304
    if-ge v3, v1, :cond_5

    if-lez v25, :cond_5

    .line 1305
    move/from16 v2, v25

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 1306
    sub-int/2addr v3, v5

    .line 1307
    mul-int v7, p1, v5

    new-array v7, v7, [I

    .line 1308
    const/4 v10, 0x0

    invoke-interface {v0, v3, v5, v7, v10}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    move v14, v5

    move-object v12, v7

    move v13, v3

    goto :goto_4

    .line 1304
    :cond_5
    move/from16 v2, v25

    .line 1310
    const/4 v12, 0x0

    const/4 v14, 0x0

    move v13, v3

    :goto_4
    const/4 v5, 0x0

    :goto_5
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v3

    if-ge v5, v3, :cond_7

    .line 1312
    :try_start_0
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/concurrent/Future;

    invoke-interface {v3}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1321
    nop

    .line 1322
    invoke-interface {v8, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 1323
    const/16 v23, 0x0

    aget v7, v3, v23

    aget v10, v3, v22

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, [I

    const/16 v16, 0x2

    aget v3, v3, v16

    invoke-interface {v0, v7, v10, v15, v3}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->writeRows(II[II)V

    .line 1310
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .line 1319
    :catch_0
    move-exception v0

    .line 1320
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-virtual {v0}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1313
    :catch_1
    move-exception v0

    .line 1314
    add-int/lit8 v5, v5, 0x1

    :goto_6
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v0

    if-ge v5, v0, :cond_6

    .line 1315
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/Future;

    move/from16 v1, v22

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 1314
    add-int/lit8 v5, v5, 0x1

    const/16 v22, 0x1

    goto :goto_6

    .line 1317
    :cond_6
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 1318
    const/16 v23, 0x0

    return v23

    .line 1325
    :cond_7
    const/16 v23, 0x0

    .line 1326
    nop

    .line 1327
    nop

    .line 1328
    invoke-interface {v6}, Ljava/util/List;->clear()V

    .line 1329
    invoke-interface {v8}, Ljava/util/List;->clear()V

    .line 1330
    invoke-interface {v9}, Ljava/util/List;->clear()V

    goto :goto_7

    .line 1299
    :cond_8
    move/from16 v2, v25

    const/16 v23, 0x0

    move/from16 v14, v24

    .line 1271
    :goto_7
    add-int v11, v11, p3

    move v5, v2

    move v7, v4

    move/from16 v4, v23

    move/from16 v2, p3

    goto/16 :goto_0

    .line 1333
    :cond_9
    const/16 v22, 0x1

    return v22

    .line 1261
    :cond_a
    const/16 v22, 0x1

    :goto_8
    return v22
.end method

.method public static initPostProcPreference(Landroidx/preference/PreferenceFragmentCompat;)V
    .locals 6

    .line 254
    const-string v0, "com.motorola.camera.post_processing_profile"

    if-nez p0, :cond_0

    return-void

    .line 256
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v1

    check-cast v1, Landroidx/preference/ListPreference;

    .line 257
    if-nez v1, :cond_1

    return-void

    .line 258
    :cond_1
    invoke-virtual {p0}, Landroidx/preference/PreferenceFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Landroidx/preference/PreferenceFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object p0

    goto :goto_0

    :cond_2
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 259
    :goto_0
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 260
    if-eqz p0, :cond_4

    .line 261
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    .line 262
    if-eqz v3, :cond_3

    const-string v4, "port_postproc_entries"

    const-string v5, "array"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v3, v4, v5, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    goto :goto_1

    :cond_3
    const/4 p0, 0x0

    .line 263
    :goto_1
    if-eqz p0, :cond_4

    .line 264
    invoke-virtual {v3, p0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    .line 265
    if-eqz p0, :cond_4

    array-length v3, p0

    sget-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    array-length v4, v4

    if-ne v3, v4, :cond_4

    .line 266
    move-object v2, p0

    .line 270
    :cond_4
    invoke-virtual {v1, v2}, Landroidx/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 271
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    iput-object p0, v1, Landroidx/preference/ListPreference;->mEntryValues:[Ljava/lang/CharSequence;

    .line 272
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 273
    const-string v2, "0"

    if-eqz p0, :cond_5

    :try_start_1
    invoke-interface {p0, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_5
    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->parseProfileIndex(Ljava/lang/String;)I

    move-result p0

    .line 274
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V

    .line 275
    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result p0

    invoke-static {p0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 278
    goto :goto_2

    .line 276
    :catchall_0
    move-exception p0

    .line 277
    const-string v0, "CustomImagingBridge"

    const-string v1, "initPostProcPreference failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 279
    :goto_2
    return-void
.end method

.method public static initializeEffects(Landroid/content/Context;)V
    .locals 3

    .line 98
    sput-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 99
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V

    .line 100
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object p0

    .line 101
    new-instance v0, Ljava/io/File;

    const-string v1, "look-shader-v2-2.0.0"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 102
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_2

    .line 103
    new-instance v1, Ljava/io/File;

    const-string v2, "shader-cache.bin"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 105
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result p0

    if-eqz p0, :cond_1

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 108
    :cond_1
    goto :goto_0

    .line 106
    :catch_0
    move-exception p0

    .line 110
    :cond_2
    :goto_0
    return-void
.end method

.method public static isCustomLutActive()Z
    .locals 1

    .line 764
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecisionForActiveScene(Z)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z

    move-result v0

    return v0
.end method

.method public static isCustomLutActive(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Z
    .locals 1

    .line 768
    if-eqz p0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 769
    const/4 p0, 0x0

    return p0

    .line 771
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z

    move-result p0

    return p0
.end method

.method private static isFlashExpectedSafe()Z
    .locals 1

    .line 339
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->isFlashExpected()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 340
    :catchall_0
    move-exception v0

    .line 341
    const/4 v0, 0x0

    return v0
.end method

.method private static isFrontCameraId(Ljava/lang/String;)Z
    .locals 1

    .line 2287
    const-string v0, "1"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    .line 2289
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p0

    .line 2290
    :catchall_0
    move-exception p0

    .line 2291
    const/4 p0, 0x0

    return p0
.end method

.method public static isHdr10AvailableForCurrentFps()Z
    .locals 8

    .line 2036
    const/4 v0, 0x1

    :try_start_0
    const-class v1, Lcom/motorola/camera/settings/SettingsManager;

    .line 2037
    const-string v2, "VIDEO_FRAME_RATE"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 2038
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 2039
    const-string v4, "get"

    new-array v5, v0, [Ljava/lang/Class;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const/4 v7, 0x0

    aput-object v6, v5, v7

    invoke-virtual {v1, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 2040
    if-eqz v1, :cond_0

    .line 2041
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "mValue"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 2042
    instance-of v2, v1, Ljava/lang/Integer;

    if-eqz v2, :cond_0

    .line 2043
    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldDisableHdr10ForFps(I)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    xor-int/2addr v0, v1

    return v0

    .line 2046
    :catchall_0
    move-exception v1

    :cond_0
    nop

    .line 2047
    return v0
.end method

.method private static isRealtimeTimestampClock(Ljava/lang/String;)Z
    .locals 2

    .line 2296
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 2298
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2299
    if-nez p0, :cond_1

    return v0

    .line 2300
    :cond_1
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_TIMESTAMP_SOURCE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Integer;

    .line 2301
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x1

    if-ne p0, v1, :cond_2

    move v0, v1

    :cond_2
    return v0

    .line 2302
    :catchall_0
    move-exception p0

    .line 2303
    return v0
.end method

.method private static isUiSpecialModeSafe()Z
    .locals 2

    .line 347
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

    .line 348
    :catchall_0
    move-exception v1

    .line 349
    return v0
.end method

.method static synthetic lambda$applyCustomLutIfEnabled$0(II[F[FIIZZZFZI[IIII)V
    .locals 16

    .line 1043
    move/from16 v4, p0

    move/from16 v5, p1

    move-object/from16 v6, p2

    move-object/from16 v7, p3

    move/from16 v8, p4

    move/from16 v9, p5

    move/from16 v10, p6

    move/from16 v11, p7

    move/from16 v12, p8

    move/from16 v13, p9

    move/from16 v14, p10

    move/from16 v15, p11

    move-object/from16 v0, p12

    move/from16 v1, p13

    move/from16 v2, p14

    move/from16 v3, p15

    invoke-static/range {v0 .. v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZFZI)V

    return-void
.end method

.method static synthetic lambda$applyCustomLutIfEnabled$1(III[IIII)V
    .locals 1

    .line 1048
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

.method static synthetic lambda$applyLook$2(Lcom/motorola/camera/custom/LookFilterEngine;I[IIII)V
    .locals 0

    .line 1213
    const/4 p5, 0x0

    mul-int/2addr p3, p4

    invoke-virtual {p0, p2, p5, p3, p1}, Lcom/motorola/camera/custom/LookFilterEngine;->apply([IIII)V

    return-void
.end method

.method static synthetic lambda$applyLook$3(Lcom/motorola/camera/custom/LookOptics;[IIII)V
    .locals 0

    .line 1221
    invoke-virtual {p0, p1, p3, p4}, Lcom/motorola/camera/custom/LookOptics;->apply([III)V

    return-void
.end method

.method static synthetic lambda$exportCleanBayerJpeg$6([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 0

    .line 1600
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    return-void
.end method

.method static synthetic lambda$gradePixelBufferStrips$5(III[IIII)V
    .locals 1

    .line 1351
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

.method static synthetic lambda$gradeSurfaceInBatches$4(Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;[IIII)V
    .locals 0

    .line 1296
    invoke-interface {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;->processStrip([IIII)V

    return-void
.end method

.method private static latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
    .locals 1

    .line 2373
    invoke-static {p0, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 2374
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_0

    goto :goto_0

    .line 2375
    :cond_0
    sget-object p2, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_COMPASS_CACHE:Ljava/util/Map;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ":"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-interface {p2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    return-object p0

    .line 2374
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method static declared-synchronized loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const-class v0, Lcom/motorola/camera/custom/CustomImagingBridge;

    monitor-enter v0

    .line 123
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 124
    if-eqz p0, :cond_3

    if-nez v1, :cond_0

    goto :goto_2

    .line 125
    :cond_0
    sget v2, Lcom/motorola/camera/custom/CustomImagingBridge;->loadedLook:I

    if-eq v2, p0, :cond_2

    .line 126
    invoke-virtual {v1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "luts/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".clut"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 127
    :try_start_1
    invoke-static {v1}, Lcom/motorola/camera/custom/LookFilterEngine;->read(Ljava/io/InputStream;)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v2

    sput-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->cachedLook:Lcom/motorola/camera/custom/LookFilterEngine;

    .line 128
    sput p0, Lcom/motorola/camera/custom/CustomImagingBridge;->loadedLook:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 129
    if-eqz v1, :cond_2

    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    .line 126
    :catchall_0
    move-exception p0

    if-eqz v1, :cond_1

    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v1

    :try_start_4
    invoke-virtual {p0, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    throw p0

    .line 131
    :cond_2
    :goto_1
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->cachedLook:Lcom/motorola/camera/custom/LookFilterEngine;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    monitor-exit v0

    return-object p0

    .line 124
    :cond_3
    :goto_2
    monitor-exit v0

    const/4 p0, 0x0

    return-object p0

    .line 122
    :catchall_2
    move-exception p0

    :try_start_5
    monitor-exit v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    throw p0
.end method

.method private static neutralize([FF)V
    .locals 4

    .line 1174
    const/4 v0, 0x0

    aget v1, p0, v0

    const v2, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v1, v2

    const/4 v2, 0x1

    aget v2, p0, v2

    const v3, 0x3f371759    # 0.7152f

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    const/4 v2, 0x2

    aget v2, p0, v2

    const v3, 0x3d93dd98    # 0.0722f

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    .line 1175
    nop

    :goto_0
    const/4 v2, 0x3

    if-ge v0, v2, :cond_0

    aget v2, p0, v0

    aget v3, p0, v0

    sub-float v3, v1, v3

    mul-float/2addr v3, p1

    add-float/2addr v2, v3

    aput v2, p0, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1176
    :cond_0
    return-void
.end method

.method public static noteRawImageAvailable(JLjava/nio/ByteBuffer;)V
    .locals 14

    .line 1418
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-lez v0, :cond_4

    if-nez p2, :cond_0

    goto :goto_2

    .line 1420
    :cond_0
    :try_start_0
    invoke-virtual/range {p2 .. p2}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 1421
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    .line 1422
    if-lez v1, :cond_3

    const/high16 v4, 0x2000000

    if-le v1, v4, :cond_1

    goto :goto_0

    .line 1423
    :cond_1
    new-array v11, v1, [B

    .line 1424
    invoke-virtual {v0, v11}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1425
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId()Ljava/lang/String;

    move-result-object v0

    .line 1426
    if-nez v0, :cond_2

    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object v0

    :cond_2
    move-object v1, v0

    .line 1427
    const-wide/32 v4, 0x1fca055

    invoke-static {p0, p1, v4, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v8

    .line 1429
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->currentSessionGeneration()I

    move-result v0

    .line 1428
    const-wide/16 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-wide v9, p0

    move-wide v2, p0

    invoke-static/range {v0 .. v13}, Lcom/motorola/camera/custom/MultiFrameBurstController;->offerSessionFrame(ILjava/lang/String;JJIFFJ[BZZ)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    .line 1422
    :cond_3
    :goto_0
    return-void

    .line 1431
    :catchall_0
    move-exception v0

    :goto_1
    nop

    .line 1432
    return-void

    .line 1418
    :cond_4
    :goto_2
    return-void
.end method

.method public static noteZslCaptureCompleted(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 21

    .line 1373
    move-object/from16 v0, p1

    if-nez v0, :cond_0

    return-void

    .line 1375
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isVideoMode()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1376
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1377
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 1378
    invoke-static {v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->onVideoFramePhysicalCamera(Ljava/lang/String;)V

    .line 1381
    :cond_1
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    .line 1382
    sget-object v2, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    .line 1383
    sget-object v3, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v3}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    .line 1384
    sget-object v4, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v4}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Float;

    .line 1385
    if-eqz v1, :cond_a

    if-eqz v2, :cond_a

    if-eqz v3, :cond_a

    if-nez v4, :cond_2

    goto/16 :goto_5

    .line 1386
    :cond_2
    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    .line 1387
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    .line 1388
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v11

    .line 1389
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId()Ljava/lang/String;

    move-result-object v1

    .line 1390
    if-nez v1, :cond_3

    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object v1

    :cond_3
    move-object v6, v1

    .line 1391
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v6, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v12

    .line 1392
    invoke-static {v7, v8, v9, v10}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v13

    .line 1393
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_FOCUS_DISTANCE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    .line 1394
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    goto :goto_0

    :cond_4
    const/high16 v1, 0x7fc00000    # Float.NaN

    :goto_0
    move/from16 v18, v1

    .line 1395
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 1396
    const/4 v2, 0x0

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    move/from16 v19, v1

    goto :goto_1

    :cond_5
    move/from16 v19, v2

    .line 1397
    :goto_1
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 1398
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    move/from16 v20, v1

    goto :goto_2

    :cond_6
    move/from16 v20, v2

    .line 1399
    :goto_2
    nop

    .line 1400
    if-eqz p0, :cond_7

    invoke-virtual/range {p0 .. p0}, Landroid/hardware/camera2/CaptureRequest;->getTag()Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    if-eqz v1, :cond_7

    .line 1401
    invoke-virtual/range {p0 .. p0}, Landroid/hardware/camera2/CaptureRequest;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v1, v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v3, v1

    move-wide v14, v3

    goto :goto_3

    .line 1404
    :cond_7
    move-wide v14, v7

    :goto_3
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->currentSessionGeneration()I

    move-result v5

    const-wide/16 v3, 0x0

    cmp-long v1, v9, v3

    if-lez v1, :cond_8

    if-lez v11, :cond_8

    const/4 v2, 0x1

    :cond_8
    move/from16 v17, v2

    .line 1403
    const/16 v16, 0x0

    invoke-static/range {v5 .. v20}, Lcom/motorola/camera/custom/MultiFrameBurstController;->noteSessionMetadata(ILjava/lang/String;JJIFFJZZFII)V

    .line 1407
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_APERTURE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 1408
    if-eqz v0, :cond_9

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_9

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-lez v1, :cond_9

    .line 1409
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    goto :goto_4

    :cond_9
    const v0, 0x3fcccccd    # 1.6f

    .line 1410
    :goto_4
    invoke-static {v9, v10, v11, v0}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeEv100(JIF)D

    move-result-wide v0

    .line 1411
    invoke-static {v0, v1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 1412
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassHudController;->updateLatestEv100(D)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_6

    .line 1385
    :cond_a
    :goto_5
    return-void

    .line 1414
    :catchall_0
    move-exception v0

    :cond_b
    :goto_6
    nop

    .line 1415
    return-void
.end method

.method public static onCameraActivityResumed()V
    .locals 1

    .line 1989
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onResume()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1990
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1991
    :goto_1
    return-void
.end method

.method public static onCameraPaused()V
    .locals 1

    .line 1995
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onPause()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1996
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1998
    :goto_1
    :try_start_1
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraPaused()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1999
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v0

    goto :goto_2

    .line 2000
    :goto_3
    return-void
.end method

.method public static onFactoryResetPreferences()V
    .locals 3

    .line 2020
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->onSessionResetKeepLastModeOff()V

    .line 2022
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 2023
    if-eqz v0, :cond_0

    .line 2024
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.motorola.camera.post_processing_profile"

    const-string v2, "0"

    .line 2025
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "port_compass_hud"

    .line 2026
    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 2027
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 2029
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V

    .line 2030
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 2031
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 2032
    return-void
.end method

.method public static onFrontAfCaptureEnd()V
    .locals 0

    .line 2066
    invoke-static {}, Lcom/motorola/camera/custom/FrontAfHelper;->endCapture()V

    .line 2067
    return-void
.end method

.method public static onFrontAfCaptureStart()V
    .locals 0

    .line 2062
    invoke-static {}, Lcom/motorola/camera/custom/FrontAfHelper;->beginCapture()V

    .line 2063
    return-void
.end method

.method public static onSessionResetKeepLastModeOff()V
    .locals 3

    .line 2004
    const-string v0, "0"

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 2005
    if-eqz v1, :cond_0

    .line 2006
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "com.motorola.camera.look_preset"

    .line 2007
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "com.motorola.camera.bokeh_style"

    .line 2008
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.motorola.camera.look_intensity"

    const-string v2, "100"

    .line 2009
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 2010
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 2012
    :cond_0
    const/16 v0, 0x64

    const/4 v1, 0x0

    invoke-static {v1, v0}, Lcom/motorola/camera/custom/LiveLookPreview;->select(II)V

    .line 2013
    invoke-static {v1}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 2014
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->refreshPreview()V

    .line 2015
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 2016
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 2017
    return-void
.end method

.method public static overrideSceneMode(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)Lcom/motorola/camera/mcf/Mcf$SceneMode;
    .locals 3

    .line 473
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 474
    return-object p0

    .line 476
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

    .line 477
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    .line 478
    invoke-static {p0, p1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 479
    iget-object v2, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget v2, v2, v1

    if-ne v2, v0, :cond_3

    .line 480
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->HAL_FRAME_STACK:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    return-object p0

    .line 482
    :cond_3
    iget-object p1, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget p1, p1, v1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_4

    .line 483
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->RAW_HDR:Lcom/motorola/camera/mcf/Mcf$SceneMode;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 487
    :cond_4
    goto :goto_2

    .line 485
    :catchall_0
    move-exception p1

    .line 486
    const-string v0, "CustomImagingBridge"

    const-string v1, "overrideSceneMode fallback"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 488
    :goto_2
    return-object p0
.end method

.method private static parseProfileIndex(Ljava/lang/String;)I
    .locals 2

    .line 244
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 246
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 247
    if-ltz p0, :cond_1

    const/16 v1, 0xa

    if-gt p0, v1, :cond_1

    move v0, p0

    :cond_1
    return v0

    .line 248
    :catchall_0
    move-exception p0

    .line 249
    return v0

    .line 244
    :cond_2
    :goto_0
    return v0
.end method

.method public static pickPreferredHfrRange([Landroid/util/Range;Landroid/util/Range;)Landroid/util/Range;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Landroid/util/Range<",
            "Ljava/lang/Integer;",
            ">;",
            "Landroid/util/Range<",
            "Ljava/lang/Integer;",
            ">;)",
            "Landroid/util/Range<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 2107
    if-eqz p0, :cond_7

    array-length v0, p0

    if-eqz v0, :cond_7

    if-eqz p1, :cond_7

    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 2110
    :cond_0
    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 2111
    array-length v1, p0

    new-array v1, v1, [[I

    .line 2112
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    array-length v4, p0

    if-ge v3, v4, :cond_3

    .line 2113
    aget-object v4, p0, v3

    .line 2114
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-nez v5, :cond_1

    goto :goto_1

    .line 2115
    :cond_1
    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    filled-new-array {v5, v4}, [I

    move-result-object v4

    aput-object v4, v1, v3

    .line 2112
    :cond_2
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2117
    :cond_3
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->pickPreferredHfrRange(I[[I)[I

    move-result-object v0

    .line 2118
    if-nez v0, :cond_4

    return-object p1

    .line 2119
    :cond_4
    array-length v1, p0

    move v3, v2

    :goto_2
    if-ge v3, v1, :cond_6

    aget-object v4, p0, v3

    .line 2120
    if-eqz v4, :cond_5

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_5

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_5

    .line 2121
    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    aget v6, v0, v2

    if-ne v5, v6, :cond_5

    .line 2122
    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/4 v6, 0x1

    aget v6, v0, v6

    if-ne v5, v6, :cond_5

    .line 2123
    return-object v4

    .line 2119
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 2126
    :cond_6
    return-object p1

    .line 2108
    :cond_7
    :goto_3
    return-object p1
.end method

.method private static preserveGainmapExifSafe([B[B)[B
    .locals 0

    .line 1436
    :try_start_0
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/GainmapJpeg;->withExif([B[B)[B

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 1437
    :catchall_0
    move-exception p0

    .line 1438
    return-object p1
.end method

.method private static readIsoSafe(Lcom/motorola/camera/photometadata/PhotoMetadata;)I
    .locals 3

    .line 817
    const/16 v0, 0x64

    if-nez p0, :cond_0

    return v0

    .line 819
    :cond_0
    :try_start_0
    const-string v1, "ISOSpeedRatings"

    invoke-virtual {p0, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 820
    if-eqz p0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    .line 821
    :cond_1
    const/16 v1, 0x2c

    invoke-virtual {p0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 822
    if-lez v1, :cond_2

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 823
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 824
    if-lez p0, :cond_3

    move v0, p0

    :cond_3
    return v0

    .line 820
    :cond_4
    :goto_0
    return v0

    .line 825
    :catchall_0
    move-exception p0

    .line 826
    return v0
.end method

.method private static recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    .line 2384
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Ljava/lang/String;
    .locals 17

    .line 2397
    move-object/from16 v0, p0

    move-object/from16 v1, p3

    if-eqz p1, :cond_0

    move-object/from16 v3, p1

    goto :goto_0

    :cond_0
    :try_start_0
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCaptureResult(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Landroid/hardware/camera2/TotalCaptureResult;

    move-result-object v2

    move-object v3, v2

    .line 2398
    :goto_0
    move-object/from16 v2, p2

    invoke-static {v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 2399
    move-object/from16 v4, p5

    invoke-static {v0, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 2400
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 2401
    move-object v5, v4

    goto :goto_1

    .line 2402
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "shot_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v5, v4

    .line 2403
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v15, p4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ":"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 2404
    sget-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    invoke-interface {v6, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 2405
    if-eqz v6, :cond_2

    .line 2406
    return-object v6

    .line 2408
    :cond_2
    const/16 v16, 0x0

    if-eqz v0, :cond_3

    iget-object v6, v0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v6, :cond_3

    iget-object v6, v0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v6, v6, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v6, :cond_3

    iget-object v0, v0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCaptureMode:I

    .line 2410
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode(I)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    goto :goto_2

    :cond_3
    move/from16 v0, v16

    .line 2411
    :goto_2
    const/4 v6, 0x0

    if-eqz v1, :cond_4

    iget v7, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    invoke-static {v7}, Ljava/lang/Float;->isFinite(F)Z

    move-result v7

    if-eqz v7, :cond_4

    iget v7, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    invoke-static {v7}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    goto :goto_3

    :cond_4
    move-object v7, v6

    .line 2412
    :goto_3
    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->isRealtimeTimestampClock(Ljava/lang/String;)Z

    move-result v2

    .line 2413
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->latestMergeGapMs()F

    move-result v8

    .line 2414
    invoke-static {v8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-static {v8}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v8

    goto :goto_4

    :cond_5
    move-object v8, v6

    .line 2415
    :goto_4
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->latestMergeFocusSpread()F

    move-result v9

    .line 2416
    invoke-static {v9}, Ljava/lang/Float;->isFinite(F)Z

    move-result v10

    if-eqz v10, :cond_6

    invoke-static {v9}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v9

    goto :goto_5

    :cond_6
    move-object v9, v6

    .line 2417
    :goto_5
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->wasLastMergeMotionRejected()Z

    move-result v10

    if-eqz v10, :cond_7

    sget-object v10, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_6

    :cond_7
    move-object v10, v6

    .line 2418
    :goto_6
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v11

    .line 2419
    if-lez v11, :cond_8

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    :cond_8
    move-object v11, v6

    .line 2420
    const/4 v12, 0x0

    move-object/from16 v13, p6

    move-object/from16 v14, p7

    move-object v6, v7

    move v7, v2

    invoke-static/range {v5 .. v14}, Lcom/motorola/camera/custom/TelemetryCollector;->shotMetadata(Ljava/lang/String;Ljava/lang/Float;ZLjava/lang/Float;Ljava/lang/Float;Ljava/lang/Boolean;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;

    move-result-object v2

    move-object v10, v5

    .line 2423
    if-eqz v1, :cond_9

    iget v5, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    move v6, v5

    goto :goto_7

    :cond_9
    move/from16 v6, v16

    .line 2424
    :goto_7
    if-eqz v0, :cond_a

    if-eqz v1, :cond_a

    iget v0, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    move v7, v0

    goto :goto_8

    :cond_a
    move/from16 v7, v16

    .line 2425
    :goto_8
    if-eqz v1, :cond_b

    iget v0, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    goto :goto_9

    :cond_b
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    :goto_9
    move v8, v0

    .line 2426
    invoke-static {v3, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->sampleCompass(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v9

    .line 2427
    if-eqz v9, :cond_c

    .line 2428
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_COMPASS_CACHE:Ljava/util/Map;

    invoke-interface {v0, v4, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2430
    :cond_c
    move-object v0, v4

    move-object v5, v15

    move-object v4, v2

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/TelemetryCollector;->buildShotTelemetryJson(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;IIILcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/lang/String;

    move-result-object v1

    .line 2432
    const-string v2, "[^a-zA-Z0-9._-]"

    const-string v5, "_"

    invoke-virtual {v10, v2, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 2433
    sget-object v5, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    invoke-static {v5, v2, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->writePublicTelemetrySidecar(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 2434
    move-object/from16 v5, p4

    invoke-static/range {v3 .. v8}, Lcom/motorola/camera/custom/TelemetryCollector;->buildConciseExifNote(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;III)Ljava/lang/String;

    move-result-object v1

    .line 2436
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2437
    return-object v1

    .line 2438
    :catchall_0
    move-exception v0

    .line 2439
    const-string v1, "CustomImagingBridge"

    const-string v2, "recordShotTelemetry skipped"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2440
    const-string v0, ""

    return-object v0
.end method

.method private static renderPortrait(Ljava/nio/ByteBuffer;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;III)Landroid/graphics/Bitmap;
    .locals 3

    .line 1120
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object p0

    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->decodeMutable([B)Landroid/graphics/Bitmap;

    move-result-object p0

    .line 1121
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 1122
    :cond_0
    nop

    .line 1124
    :try_start_0
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->hasGainmap()Z

    move-result v1

    if-nez v1, :cond_6

    if-lez p3, :cond_1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    if-ne v1, p3, :cond_6

    :cond_1
    if-lez p4, :cond_2

    .line 1125
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p3

    if-ne p3, p4, :cond_6

    .line 1126
    :cond_2
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p3

    int-to-long p3, p3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    int-to-long v1, v1

    mul-long/2addr p3, v1

    const-wide/32 v1, 0x1312d00

    cmp-long p3, p3, v1

    if-lez p3, :cond_3

    goto :goto_0

    .line 1127
    :cond_3
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/PortraitBokeh;->render(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;I)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1128
    if-eqz p1, :cond_4

    move-object v0, p0

    .line 1133
    :cond_4
    if-nez p1, :cond_5

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1128
    :cond_5
    return-object v0

    .line 1126
    :cond_6
    :goto_0
    nop

    .line 1133
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1126
    return-object v0

    .line 1133
    :catchall_0
    move-exception p1

    goto :goto_1

    .line 1129
    :catch_0
    move-exception p1

    .line 1130
    :try_start_1
    const-string p2, "CustomImagingBridge"

    const-string p3, "Using stock portrait rendering"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1131
    nop

    .line 1133
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1131
    return-object v0

    .line 1133
    :goto_1
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1134
    throw p1
.end method

.method private static resolveActiveScene(Z)[I
    .locals 0

    .line 420
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecisionForActiveScene(Z)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    iget-object p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    return-object p0
.end method

.method private static resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 29

    .line 354
    nop

    .line 355
    nop

    .line 357
    const/high16 v1, 0x3f800000    # 1.0f

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraType()Lcom/motorola/camera/settings/CameraType;

    move-result-object v0

    .line 358
    if-eqz v0, :cond_0

    .line 359
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getZoomValue(Lcom/motorola/camera/settings/CameraType;)F

    move-result v0

    .line 361
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

    .line 363
    :catchall_0
    move-exception v0

    :cond_0
    :goto_0
    move v3, v1

    .line 365
    const/high16 v1, 0x42480000    # 50.0f

    :try_start_1
    invoke-static {}, Lcom/motorola/camera/IqConfigManager;->getInstance()Lcom/motorola/camera/IqConfigManager;

    move-result-object v0

    .line 367
    if-eqz v0, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    const/4 v4, 0x0

    cmpl-float v2, v2, v4

    if-lez v2, :cond_1

    .line 368
    iget v1, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    .line 370
    :catchall_1
    move-exception v0

    :cond_1
    :goto_1
    move v4, v1

    .line 372
    const-string v0, ""

    if-eqz p0, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/Mcf$SceneMode;->name()Ljava/lang/String;

    move-result-object v1

    move-object v5, v1

    goto :goto_2

    :cond_2
    move-object v5, v0

    .line 373
    :goto_2
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v2

    .line 374
    invoke-static {v2}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v1

    .line 375
    const-string v6, "com.motorola.camera.look_preset"

    const/16 v7, 0xd

    const/4 v11, 0x0

    invoke-static {v6, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v6

    .line 376
    const-string v7, "com.motorola.camera.look_intensity"

    const/16 v8, 0x64

    invoke-static {v7, v8, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v7

    .line 377
    const-string v8, "com.motorola.camera.bokeh_style"

    const/4 v12, 0x5

    invoke-static {v8, v11, v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v8

    .line 378
    if-eqz v1, :cond_3

    move v9, v11

    goto :goto_3

    :cond_3
    move v9, v6

    .line 379
    :goto_3
    if-nez v1, :cond_5

    if-nez v9, :cond_4

    goto :goto_4

    :cond_4
    move v10, v7

    goto :goto_5

    :cond_5
    :goto_4
    move v10, v11

    .line 380
    :goto_5
    if-eqz v1, :cond_6

    move v13, v11

    goto :goto_6

    :cond_6
    move v13, v8

    .line 381
    :goto_6
    const/4 v14, 0x1

    if-eqz v1, :cond_8

    if-gtz v6, :cond_7

    if-lez v8, :cond_8

    :cond_7
    move v1, v11

    move v11, v14

    goto :goto_7

    :cond_8
    move v1, v11

    .line 382
    :goto_7
    sget-boolean v8, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    move/from16 v6, p1

    move/from16 v7, p2

    invoke-static/range {v2 .. v10}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtendedWithLook(IFFLjava/lang/String;ZZZII)[I

    move-result-object v7

    .line 385
    move v8, v9

    move v9, v10

    if-lez v8, :cond_9

    sget-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->LOOK_DISPLAY_NAMES:[Ljava/lang/String;

    array-length v6, v6

    if-ge v8, v6, :cond_9

    if-lez v9, :cond_9

    .line 386
    sget-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->LOOK_DISPLAY_NAMES:[Ljava/lang/String;

    aget-object v6, v6, v8

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Look: "

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, " ("

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, "%) | "

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_8

    .line 387
    :cond_9
    if-eqz v11, :cond_a

    const-string v6, "Look: Paused | "

    goto :goto_8

    :cond_a
    move-object v6, v0

    .line 388
    :goto_8
    const/high16 v10, 0x41200000    # 10.0f

    mul-float v15, v3, v10

    .line 389
    invoke-static {v15}, Ljava/lang/Math;->round(F)I

    move-result v15

    int-to-float v15, v15

    div-float/2addr v15, v10

    .line 390
    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v10

    aget v1, v7, v1

    move/from16 p0, v12

    aget v12, v7, v14

    const/16 v16, 0x2

    aget v14, v7, v16

    const/16 v16, 0x3

    move-object/from16 v18, v0

    aget v0, v7, v16

    const/16 v16, 0x4

    move/from16 p2, v3

    aget v3, v7, v16

    move/from16 v16, v4

    aget v4, v7, p0

    const/16 v19, 0x6

    move-object/from16 p0, v7

    aget v7, p0, v19

    .line 393
    const/16 v19, 0x7

    aget v20, p0, v19

    if-ltz v20, :cond_b

    move/from16 v20, v11

    aget v11, p0, v19

    move/from16 v19, v13

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v21, v9

    const-string v9, " isz="

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    goto :goto_9

    :cond_b
    move/from16 v21, v9

    move/from16 v20, v11

    move/from16 v19, v13

    move-object/from16 v9, v18

    .line 394
    :goto_9
    const/16 v11, 0x8

    aget v13, p0, v11

    if-ltz v13, :cond_c

    aget v11, p0, v11

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v22, v8

    const-string v8, " aide="

    invoke-virtual {v13, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_a

    :cond_c
    move/from16 v22, v8

    move-object/from16 v8, v18

    .line 395
    :goto_a
    const/16 v11, 0x9

    aget v13, p0, v11

    if-lez v13, :cond_d

    aget v13, p0, v11

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v24, v8

    const-string v8, " vsr="

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_b

    :cond_d
    move-object/from16 v24, v8

    move-object/from16 v8, v18

    .line 396
    :goto_b
    const/16 v11, 0xa

    aget v13, p0, v11

    if-ltz v13, :cond_e

    aget v13, p0, v11

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v26, v8

    const-string v8, " hdr="

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    goto :goto_c

    :cond_e
    move-object/from16 v26, v8

    move-object/from16 v8, v18

    .line 397
    :goto_c
    const/16 v11, 0xb

    aget v11, p0, v11

    const/4 v13, 0x1

    if-ne v11, v13, :cond_f

    const-string v11, " t2w=0"

    goto :goto_d

    :cond_f
    move-object/from16 v11, v18

    .line 398
    :goto_d
    const/16 v17, 0xc

    move-object/from16 v27, v11

    aget v11, p0, v17

    if-ne v11, v13, :cond_10

    const-string v11, " qll=1"

    goto :goto_e

    :cond_10
    move-object/from16 v11, v18

    .line 399
    :goto_e
    const/16 v13, 0xa

    if-ne v2, v13, :cond_11

    const-string v13, " stock=1"

    goto :goto_f

    :cond_11
    move-object/from16 v13, v18

    .line 400
    :goto_f
    move-object/from16 v17, v13

    const/16 v13, 0x9

    if-ne v2, v13, :cond_12

    const-string v13, " mcf=0"

    goto :goto_10

    :cond_12
    move-object/from16 v13, v18

    .line 401
    :goto_10
    sget-boolean v23, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    if-nez v23, :cond_13

    const-string v23, " htp=0"

    move-object/from16 v28, v23

    goto :goto_11

    :cond_13
    move-object/from16 v28, v18

    .line 402
    :goto_11
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v23

    if-eqz v23, :cond_14

    move-object/from16 v25, v11

    move-object/from16 v23, v13

    move-object/from16 v5, v18

    goto :goto_12

    :cond_14
    move-object/from16 v23, v13

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v25, v11

    const-string v11, " in="

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 403
    :goto_12
    if-eqz p1, :cond_15

    const-string v11, " flash=1"

    goto :goto_13

    :cond_15
    move-object/from16 v11, v18

    .line 404
    :goto_13
    if-eqz v20, :cond_16

    const-string v13, " fxPause=1"

    goto :goto_14

    :cond_16
    move-object/from16 v13, v18

    :goto_14
    move-object/from16 v18, v13

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p1, v11

    const-string v11, "Edge50Port v2.0.0 | "

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, "p="

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, " z="

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v11, " lux="

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, " act="

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, " nr="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, " edge="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, " mfnr="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " sz="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " lut="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " raw="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v11, v27

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v11, v25

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v13, v17

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v13, v23

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v11, p1

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v13, v18

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 405
    move v5, v2

    new-instance v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " fx="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move/from16 v8, v22

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    move/from16 v9, v21

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v3, p0

    move/from16 v6, p2

    move/from16 v7, v16

    move/from16 v10, v19

    move/from16 v11, v20

    invoke-direct/range {v2 .. v11}, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;-><init>([ILjava/lang/String;IFFIIIZ)V

    return-object v2
.end method

.method private static resolveDecisionForActiveScene(Z)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 2

    .line 410
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

    .line 411
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v0

    .line 412
    nop

    .line 414
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 415
    goto :goto_2

    :catchall_0
    move-exception v1

    const/4 v1, 0x0

    .line 416
    :goto_2
    invoke-static {v1, p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0
.end method

.method public static resolveEdgeMode(I)I
    .locals 2

    .line 497
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x2

    aget v0, v0, v1

    .line 498
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveEnableMfnr(Z)Z
    .locals 1

    .line 507
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveEnableMfnr(ZZ)Z

    move-result p0

    return p0
.end method

.method public static resolveEnableMfnr(ZZ)Z
    .locals 1

    .line 511
    invoke-static {p1}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object p1

    const/4 v0, 0x3

    aget p1, p1, v0

    .line 512
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

    .line 321
    const/16 v0, 0x5f

    if-ne p0, v0, :cond_0

    const/16 p0, 0x62

    :cond_0
    return p0
.end method

.method public static resolveNoiseReduction(I)I
    .locals 2

    .line 492
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    .line 493
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveQualcommVideoFpsRange(Ljava/lang/String;Landroid/util/Range;)Landroid/util/Range;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Landroid/util/Range<",
            "Ljava/lang/Integer;",
            ">;)",
            "Landroid/util/Range<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 2130
    if-eqz p1, :cond_8

    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_5

    .line 2133
    :cond_0
    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 2135
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isSlowMotionMode()Z

    move-result v1

    if-nez v1, :cond_7

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isDualCaptureVideoMode()Z

    move-result v1

    if-eqz v1, :cond_1

    goto/16 :goto_3

    .line 2139
    :cond_1
    if-eqz p0, :cond_6

    .line 2140
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2141
    if-eqz p0, :cond_6

    .line 2142
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Landroid/util/Range;

    .line 2143
    if-eqz p0, :cond_6

    array-length v1, p0

    if-lez v1, :cond_6

    .line 2144
    array-length v1, p0

    new-array v1, v1, [[I

    .line 2145
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    array-length v4, p0

    if-ge v3, v4, :cond_4

    .line 2146
    aget-object v4, p0, v3

    .line 2147
    if-eqz v4, :cond_3

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_3

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-nez v5, :cond_2

    goto :goto_1

    .line 2148
    :cond_2
    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    filled-new-array {v5, v4}, [I

    move-result-object v4

    aput-object v4, v1, v3

    .line 2145
    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2150
    :cond_4
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoAeRange(I[[IZ)[I

    move-result-object v1

    .line 2151
    if-eqz v1, :cond_6

    .line 2152
    array-length v3, p0

    move v4, v2

    :goto_2
    if-ge v4, v3, :cond_6

    aget-object v5, p0, v4

    .line 2153
    if-eqz v5, :cond_5

    invoke-virtual {v5}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v6

    if-eqz v6, :cond_5

    invoke-virtual {v5}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v6

    if-eqz v6, :cond_5

    .line 2154
    invoke-virtual {v5}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    aget v7, v1, v2

    if-ne v6, v7, :cond_5

    .line 2155
    invoke-virtual {v5}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    const/4 v7, 0x1

    aget v8, v1, v7

    if-ne v6, v8, :cond_5

    .line 2156
    aget p0, v1, v7

    invoke-static {p0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V

    .line 2157
    return-object v5

    .line 2152
    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 2166
    :cond_6
    goto :goto_4

    .line 2136
    :cond_7
    :goto_3
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2137
    return-object p1

    .line 2164
    :catchall_0
    move-exception p0

    .line 2165
    const-string v1, "CustomImagingBridge"

    const-string v2, "resolveQualcommVideoFpsRange fallback"

    invoke-static {v1, v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2167
    :goto_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V

    .line 2168
    return-object p1

    .line 2131
    :cond_8
    :goto_5
    return-object p1
.end method

.method public static resolveSuperZoom(B)B
    .locals 2

    .line 502
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x4

    aget v0, v0, v1

    .line 503
    if-ltz v0, :cond_0

    int-to-byte p0, v0

    :cond_0
    return p0
.end method

.method public static resolveVideoBitrate(IIZ)I
    .locals 0

    .line 2095
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoBitrate(IIZ)I

    move-result p0

    return p0
.end method

.method private static runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 2

    .line 1611
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 1612
    :try_start_0
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    .line 1613
    monitor-exit v1

    .line 1614
    return-void

    .line 1613
    :catchall_0
    move-exception v0

    move-object p0, v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private static runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 45

    .line 1621
    move-object/from16 v1, p0

    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v9, p3

    const-string v15, "FocalLength"

    const-string v12, "CustomImagingBridge"

    :try_start_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v16

    .line 1622
    int-to-long v4, v2

    int-to-long v6, v3

    mul-long/2addr v4, v6

    const-wide/16 v6, 0x5

    mul-long/2addr v6, v4

    const-wide/16 v10, 0x4

    div-long/2addr v6, v10

    .line 1623
    const-wide/16 v10, 0x2

    mul-long/2addr v4, v10

    .line 1625
    array-length v0, v1

    int-to-long v10, v0

    cmp-long v0, v10, v4

    const/4 v13, 0x1

    if-ltz v0, :cond_0

    .line 1626
    array-length v0, v1

    div-int/2addr v0, v3

    invoke-static {v1, v2, v3, v0, v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object v0

    move-object v14, v0

    goto :goto_0

    .line 1627
    :cond_0
    array-length v0, v1

    int-to-long v4, v0

    cmp-long v0, v4, v6

    if-ltz v0, :cond_34

    .line 1628
    array-length v0, v1

    div-int/2addr v0, v3

    invoke-static {v1, v2, v3, v0}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object v0

    move-object v14, v0

    .line 1634
    :goto_0
    invoke-static/range {p4 .. p4}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v4

    .line 1635
    nop

    .line 1636
    const/4 v5, 0x4

    new-array v6, v5, [F

    const/high16 v0, 0x42800000    # 64.0f

    const/4 v7, 0x0

    aput v0, v6, v7

    aput v0, v6, v13

    const/4 v8, 0x2

    aput v0, v6, v8

    const/4 v10, 0x3

    aput v0, v6, v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_11

    .line 1637
    nop

    .line 1638
    nop

    .line 1639
    nop

    .line 1641
    :try_start_1
    sget-object v0, Landroid/graphics/ColorSpace$Named;->DISPLAY_P3:Landroid/graphics/ColorSpace$Named;

    invoke-static {v0}, Landroid/graphics/ColorSpace;->get(Landroid/graphics/ColorSpace$Named;)Landroid/graphics/ColorSpace;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1642
    move/from16 v18, v8

    move-object v8, v0

    goto :goto_1

    :catchall_0
    move-exception v0

    move/from16 v18, v8

    const/4 v8, 0x0

    .line 1643
    :goto_1
    if-eqz v8, :cond_1

    move/from16 v24, v13

    goto :goto_2

    :cond_1
    move/from16 v24, v7

    .line 1644
    :goto_2
    :try_start_2
    invoke-static/range {p4 .. p4}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFrontCameraId(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 v25, 0x0

    goto :goto_3

    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->latestRearAmbientCctK()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    move-object/from16 v25, v0

    .line 1646
    :goto_3
    if-eqz v4, :cond_a

    .line 1647
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_COLOR_FILTER_ARRANGEMENT:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1648
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_4

    :cond_3
    move v0, v7

    .line 1649
    :goto_4
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_BLACK_LEVEL_PATTERN:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/hardware/camera2/params/BlackLevelPattern;

    .line 1650
    if-eqz v11, :cond_4

    .line 1651
    move/from16 v27, v10

    invoke-virtual {v11, v7, v7}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v10

    int-to-float v10, v10

    aput v10, v6, v7

    .line 1652
    invoke-virtual {v11, v13, v7}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v10

    int-to-float v10, v10

    aput v10, v6, v13

    .line 1653
    invoke-virtual {v11, v7, v13}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v10

    int-to-float v10, v10

    aput v10, v6, v18

    .line 1654
    invoke-virtual {v11, v13, v13}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v10

    int-to-float v10, v10

    aput v10, v6, v27

    goto :goto_5

    .line 1650
    :cond_4
    move/from16 v27, v10

    .line 1656
    :goto_5
    sget-object v10, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_WHITE_LEVEL:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v10}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Integer;

    .line 1657
    if-eqz v10, :cond_5

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v11

    if-lez v11, :cond_5

    .line 1658
    invoke-virtual {v10}, Ljava/lang/Integer;->floatValue()F

    move-result v10

    goto :goto_6

    .line 1660
    :cond_5
    const v10, 0x447fc000    # 1023.0f

    :goto_6
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_COLOR_TRANSFORM1:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-static {v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v19

    .line 1661
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_COLOR_TRANSFORM2:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-static {v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v21

    .line 1662
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_REFERENCE_ILLUMINANT1:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Integer;

    .line 1663
    move/from16 v28, v13

    sget-object v13, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_REFERENCE_ILLUMINANT2:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v13}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Byte;

    .line 1664
    if-eqz v11, :cond_6

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v11

    goto :goto_7

    :cond_6
    const/16 v11, 0x15

    :goto_7
    move/from16 v20, v11

    .line 1665
    if-eqz v13, :cond_7

    invoke-virtual {v13}, Ljava/lang/Byte;->byteValue()B

    move-result v11

    and-int/lit16 v11, v11, 0xff

    goto :goto_8

    :cond_7
    const/16 v11, 0x11

    :goto_8
    move/from16 v22, v11

    .line 1666
    if-eqz v19, :cond_9

    .line 1667
    nop

    .line 1669
    if-eqz v25, :cond_8

    invoke-virtual/range {v25 .. v25}, Ljava/lang/Float;->floatValue()F

    move-result v11

    goto :goto_9

    :cond_8
    const/high16 v11, 0x7fc00000    # Float.NaN

    :goto_9
    move/from16 v23, v11

    .line 1667
    invoke-static/range {v19 .. v24}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->dualIlluminantSensorToOutputCcm([FI[FIFZ)[F

    move-result-object v11
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_11

    move-object v13, v4

    move v4, v0

    goto :goto_a

    .line 1666
    :cond_9
    move-object v13, v4

    const/4 v11, 0x0

    move v4, v0

    goto :goto_a

    .line 1646
    :cond_a
    move/from16 v27, v10

    move/from16 v28, v13

    move-object v13, v4

    move v4, v7

    const v10, 0x447fc000    # 1023.0f

    const/4 v11, 0x0

    .line 1675
    :goto_a
    const/high16 v19, 0x3f800000    # 1.0f

    const/16 v20, 0x0

    :try_start_3
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_DYNAMIC_BLACK_LEVEL:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    .line 1676
    if-eqz v0, :cond_e

    array-length v7, v0

    if-ne v7, v5, :cond_e

    .line 1677
    nop

    .line 1678
    const/4 v7, 0x0

    :goto_b
    if-ge v7, v5, :cond_d

    .line 1679
    aget v22, v0, v7

    invoke-static/range {v22 .. v22}, Ljava/lang/Float;->isFinite(F)Z

    move-result v22

    if-eqz v22, :cond_c

    aget v22, v0, v7

    cmpg-float v22, v22, v20

    if-ltz v22, :cond_c

    aget v22, v0, v7

    sub-float v23, v10, v19

    cmpl-float v22, v22, v23

    if-ltz v22, :cond_b

    goto :goto_c

    .line 1678
    :cond_b
    add-int/lit8 v7, v7, 0x1

    goto :goto_b

    .line 1680
    :cond_c
    :goto_c
    nop

    .line 1681
    const/4 v7, 0x0

    goto :goto_d

    .line 1678
    :cond_d
    move/from16 v7, v28

    .line 1684
    :goto_d
    if-eqz v7, :cond_e

    .line 1685
    const/4 v7, 0x0

    invoke-static {v0, v7, v6, v7, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_e

    .line 1688
    :catchall_1
    move-exception v0

    :cond_e
    :goto_e
    nop

    .line 1691
    if-eqz v11, :cond_f

    if-nez v24, :cond_10

    if-nez v25, :cond_10

    .line 1692
    :cond_f
    :try_start_4
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 1693
    if-eqz v0, :cond_10

    .line 1694
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_11

    .line 1695
    if-eqz v0, :cond_10

    move-object/from16 v36, v0

    goto :goto_f

    .line 1699
    :cond_10
    move-object/from16 v36, v11

    :goto_f
    nop

    .line 1700
    nop

    .line 1702
    :try_start_5
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_NOISE_PROFILE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroid/util/Pair;

    .line 1703
    if-eqz v0, :cond_14

    array-length v7, v0

    if-lt v7, v5, :cond_14

    .line 1704
    new-array v7, v5, [F
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 1705
    :try_start_6
    new-array v11, v5, [F
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 1706
    move-object/from16 v22, v0

    const/4 v0, 0x0

    :goto_10
    if-ge v0, v5, :cond_15

    .line 1707
    :try_start_7
    aget-object v5, v22, v0

    .line 1708
    if-eqz v5, :cond_11

    move/from16 v29, v0

    iget-object v0, v5, Landroid/util/Pair;->first:Ljava/lang/Object;

    if-eqz v0, :cond_12

    iget-object v0, v5, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->floatValue()F

    move-result v0

    goto :goto_11

    :cond_11
    move/from16 v29, v0

    :cond_12
    move/from16 v0, v20

    :goto_11
    aput v0, v7, v29

    .line 1709
    if-eqz v5, :cond_13

    iget-object v0, v5, Landroid/util/Pair;->second:Ljava/lang/Object;

    if-eqz v0, :cond_13

    iget-object v0, v5, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v0, Ljava/lang/Double;

    invoke-virtual {v0}, Ljava/lang/Double;->floatValue()F

    move-result v0

    goto :goto_12

    :cond_13
    move/from16 v0, v20

    :goto_12
    aput v0, v11, v29
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 1706
    add-int/lit8 v0, v29, 0x1

    const/4 v5, 0x4

    goto :goto_10

    .line 1712
    :catchall_2
    move-exception v0

    goto :goto_14

    :catchall_3
    move-exception v0

    goto :goto_13

    :cond_14
    const/4 v7, 0x0

    const/4 v11, 0x0

    goto :goto_14

    :catchall_4
    move-exception v0

    const/4 v7, 0x0

    :goto_13
    const/4 v11, 0x0

    :cond_15
    :goto_14
    nop

    .line 1714
    move/from16 v5, v27

    :try_start_8
    new-array v5, v5, [F

    const v0, 0x3fe66666    # 1.8f

    const/16 v21, 0x0

    aput v0, v5, v21

    aput v19, v5, v28

    const v0, 0x3fcccccd    # 1.6f

    aput v0, v5, v18

    .line 1715
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_GAINS:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 1716
    if-eqz v0, :cond_16

    .line 1717
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result v19

    const/16 v21, 0x0

    aput v19, v5, v21

    .line 1718
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v19

    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v20

    add-float v19, v19, v20

    const/high16 v20, 0x3f000000    # 0.5f

    mul-float v19, v19, v20

    aput v19, v5, v28

    .line 1719
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result v0

    aput v0, v5, v18
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_11

    .line 1722
    :cond_16
    nop

    .line 1723
    nop

    .line 1724
    nop

    .line 1726
    :try_start_9
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->STATISTICS_LENS_SHADING_CORRECTION_MAP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/LensShadingMap;

    .line 1727
    if-eqz v0, :cond_17

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v1

    move/from16 v2, v18

    if-lt v1, v2, :cond_17

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v1

    if-lt v1, v2, :cond_17

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v1

    if-lez v1, :cond_17

    .line 1728
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_8

    .line 1729
    :try_start_a
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_7

    .line 1730
    move/from16 v18, v1

    :try_start_b
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v1

    new-array v1, v1, [F
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_6

    .line 1731
    move/from16 v19, v2

    const/4 v2, 0x0

    :try_start_c
    invoke-virtual {v0, v1, v2}, Landroid/hardware/camera2/params/LensShadingMap;->copyGainFactors([FI)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_5

    goto :goto_16

    .line 1733
    :catchall_5
    move-exception v0

    goto :goto_16

    :catchall_6
    move-exception v0

    move/from16 v19, v2

    const/4 v2, 0x0

    goto :goto_15

    :catchall_7
    move-exception v0

    move/from16 v18, v1

    const/4 v2, 0x0

    move/from16 v19, v2

    goto :goto_15

    .line 1727
    :cond_17
    const/4 v2, 0x0

    .line 1733
    move/from16 v18, v2

    move/from16 v19, v18

    goto :goto_15

    :catchall_8
    move-exception v0

    const/4 v2, 0x0

    move/from16 v18, v2

    move/from16 v19, v18

    :goto_15
    const/4 v1, 0x0

    :goto_16
    move-object/from16 v38, v1

    move/from16 v39, v18

    move/from16 v40, v19

    .line 1735
    nop

    .line 1737
    const/16 v1, 0x64

    :try_start_d
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v9, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1738
    if-eqz v0, :cond_18

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v18

    if-lez v18, :cond_18

    .line 1739
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_9

    goto :goto_17

    .line 1741
    :catchall_9
    move-exception v0

    :cond_18
    :goto_17
    move/from16 v41, v1

    .line 1745
    nop

    .line 1746
    :try_start_e
    const-string v0, "singleRaw"

    .line 1747
    nop

    .line 1748
    nop

    .line 1749
    nop

    .line 1750
    move-object/from16 v1, p0

    move/from16 v2, p1

    move-object/from16 v35, v5

    move-object v5, v6

    move v6, v10

    move-object/from16 v18, v15

    const/16 v23, 0x4

    const/16 v26, 0x0

    move-object/from16 v10, p5

    move-object v15, v8

    move-object v8, v11

    move-object/from16 v11, p4

    invoke-static/range {v1 .. v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->tryMultiFrameRawMerge([BIII[FF[F[FLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v1
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_11

    .line 1753
    const-string v19, ""

    if-eqz v1, :cond_1b

    .line 1754
    :try_start_f
    iget v0, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->width:I

    .line 1755
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->height:I

    .line 1756
    iget v3, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->cfaPattern:I

    .line 1757
    iget-object v4, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->blackLevel4:[F

    .line 1758
    iget v5, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->whiteLevel:F

    .line 1759
    const-string v6, "rawBurst"

    .line 1760
    iget v7, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 1761
    iget-wide v8, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->headroom:D

    const-wide v10, 0x4003333333333333L    # 2.4

    mul-double/2addr v8, v10

    const-wide/high16 v10, 0x4020000000000000L    # 8.0

    invoke-static {v10, v11, v8, v9}, Ljava/lang/Math;->min(DD)D

    move-result-wide v8

    const-wide v10, 0x4004cccccccccccdL    # 2.6

    invoke-static {v10, v11, v8, v9}, Ljava/lang/Math;->max(DD)D

    move-result-wide v8

    double-to-float v8, v8

    .line 1762
    iget v9, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    .line 1763
    iget-boolean v10, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->superResolved:Z

    if-eqz v10, :cond_19

    const-string v10, " sr=1"

    goto :goto_18

    :cond_19
    move-object/from16 v10, v19

    .line 1764
    :goto_18
    iget-boolean v11, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->usedGlGuide:Z

    if-eqz v11, :cond_1a

    const-string v11, " glGuide=1"

    goto :goto_19

    :cond_1a
    move-object/from16 v11, v19

    :goto_19
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v30, v0

    const-string v0, " rawBurst="

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1765
    mul-int v9, v30, v2

    new-array v9, v9, [F

    .line 1766
    iget-object v1, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->raw:[I

    const/high16 v37, 0x3e800000    # 0.25f

    move-object/from16 v29, v1

    move/from16 v31, v2

    move/from16 v32, v3

    move-object/from16 v33, v4

    move/from16 v34, v5

    move-object/from16 v42, v9

    invoke-static/range {v29 .. v42}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII[F)[I

    move-result-object v1

    move v2, v8

    move-object v8, v0

    move v0, v2

    move-object v2, v1

    move-object v1, v6

    move-object/from16 v20, v7

    move-object/from16 v44, v12

    move-object/from16 v43, v13

    move-object/from16 v21, v15

    move-object/from16 v9, v42

    move-object/from16 v15, p5

    goto :goto_1a

    .line 1770
    :cond_1b
    move-object/from16 v8, v36

    move-object/from16 v10, v38

    move/from16 v11, v39

    invoke-static/range {v28 .. v28}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v20

    .line 1771
    mul-int v1, p1, p2

    new-array v1, v1, [F
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_11

    .line 1772
    const/high16 v9, 0x3e800000    # 0.25f

    move-object v2, v14

    move-object v14, v1

    move-object v1, v2

    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v44, v12

    move-object/from16 v43, v13

    move-object/from16 v21, v15

    move-object/from16 v7, v35

    move/from16 v12, v40

    move/from16 v13, v41

    move-object/from16 v15, p5

    :try_start_10
    invoke-static/range {v1 .. v14}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII[F)[I

    move-result-object v1

    const v8, 0x40266666    # 2.6f

    move/from16 v30, p1

    move/from16 v31, p2

    move-object v2, v1

    move-object v9, v14

    move-object v1, v0

    move v0, v8

    move-object/from16 v8, v19

    .line 1776
    :goto_1a
    iget-object v3, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v4, 0x5

    aget v7, v3, v4

    .line 1777
    if-lez v7, :cond_1d

    .line 1778
    const/16 v5, 0x200

    const/16 v6, 0x18

    move/from16 v3, v30

    move/from16 v4, v31

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradePixelBufferStrips([IIIIII)Z

    move-result v5

    if-nez v5, :cond_1c

    .line 1779
    const-string v0, "Abort CleanBayerRaw export because strip grading was interrupted"
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_f

    move-object/from16 v10, v44

    :try_start_11
    invoke-static {v10, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1780
    return-void

    .line 1778
    :cond_1c
    move-object/from16 v10, v44

    goto :goto_1b

    .line 1777
    :cond_1d
    move/from16 v3, v30

    move-object/from16 v10, v44

    .line 1784
    :goto_1b
    iget v4, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-lez v4, :cond_1e

    iget v4, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    if-lez v4, :cond_1e

    iget v4, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v11

    move-object/from16 v32, v11

    goto :goto_1c

    :cond_1e
    const/16 v32, 0x0

    .line 1785
    :goto_1c
    if-eqz v32, :cond_1f

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->arraySurface([II)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;

    move-result-object v29

    iget v4, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v5, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    const/high16 v35, 0x3f800000    # 1.0f

    const/high16 v36, 0x3f800000    # 1.0f

    move/from16 v30, v3

    move/from16 v33, v4

    move/from16 v34, v5

    invoke-static/range {v29 .. v36}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z

    move-result v3

    move/from16 v4, v30

    move/from16 v5, v31

    if-nez v3, :cond_20

    .line 1786
    return-void

    .line 1785
    :cond_1f
    move v4, v3

    move/from16 v5, v31

    .line 1788
    :cond_20
    invoke-static {v9, v2, v4, v5, v0}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->computeFromLinearAndSdr([F[IIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    move-result-object v0

    .line 1790
    nop

    .line 1791
    invoke-static {v0}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->toAndroidGainmap(Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;)Landroid/graphics/Gainmap;

    move-result-object v9

    .line 1792
    if-eqz v32, :cond_21

    if-eqz v9, :cond_21

    .line 1793
    iget v0, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v3, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    invoke-static {v9, v0, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->adaptGainmap(Landroid/graphics/Gainmap;II)V

    .line 1796
    :cond_21
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v2, v4, v5, v0}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_10

    .line 1797
    if-nez v2, :cond_22

    return-void

    .line 1800
    :cond_22
    if-eqz v24, :cond_23

    if-eqz v21, :cond_23

    .line 1801
    move-object/from16 v11, v21

    :try_start_12
    invoke-virtual {v2, v11}, Landroid/graphics/Bitmap;->setColorSpace(Landroid/graphics/ColorSpace;)V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_a

    goto :goto_1d

    :catchall_a
    move-exception v0

    .line 1803
    :cond_23
    :goto_1d
    if-eqz v9, :cond_24

    .line 1804
    :try_start_13
    invoke-virtual {v2, v9}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    .line 1806
    :cond_24
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    mul-int v30, v4, v5

    div-int/lit8 v3, v30, 0x4

    invoke-direct {v0, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1807
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x62

    invoke-virtual {v2, v3, v4, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_e

    if-nez v3, :cond_25

    .line 1810
    :try_start_14
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_10

    .line 1807
    return-void

    .line 1808
    :cond_25
    :try_start_15
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v11
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_e

    .line 1810
    :try_start_16
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 1811
    nop

    .line 1813
    move-object/from16 v2, p3

    move-object/from16 v3, p4

    const/4 v12, 0x0

    invoke-static {v11, v2, v12, v3, v12}, Lcom/motorola/camera/utility/ExifUtility;->appendExifToJpeg([BLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/mcf/McfMetadata;Ljava/lang/String;[B)[B

    move-result-object v13
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_10

    .line 1815
    const/4 v0, 0x0

    const/4 v7, 0x0

    move-object/from16 v5, p6

    move-object v4, v1

    move-object v1, v2

    move-object v2, v3

    move-object v3, v15

    move-object/from16 v6, v20

    :try_start_17
    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1817
    invoke-static {v12, v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v2

    .line 1818
    iget-object v3, v15, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_26

    move-object/from16 v0, v19

    goto :goto_1e

    :cond_26
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1e
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1819
    if-eqz v13, :cond_30

    .line 1820
    new-instance v3, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v4, Ljava/io/ByteArrayInputStream;

    invoke-direct {v4, v13}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 1821
    nop

    .line 1822
    if-eqz v2, :cond_27

    .line 1823
    invoke-static {v3, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 1824
    move/from16 v2, v28

    goto :goto_1f

    .line 1822
    :cond_27
    const/4 v2, 0x0

    .line 1826
    :goto_1f
    if-eqz v0, :cond_2b

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2b

    .line 1827
    nop

    .line 1828
    if-eqz v9, :cond_28

    const-string v2, " uhdr=raw"

    goto :goto_20

    :cond_28
    move-object/from16 v2, v19

    .line 1829
    :goto_20
    if-eqz v24, :cond_29

    const-string v4, " p3=1"

    goto :goto_21

    :cond_29
    move-object/from16 v4, v19

    .line 1830
    :goto_21
    if-eqz v25, :cond_2a

    invoke-virtual/range {v25 .. v25}, Ljava/lang/Float;->floatValue()F

    move-result v6

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, " cct="

    invoke-virtual {v7, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    :cond_2a
    move-object/from16 v6, v19

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v7, " cleanBayer=1"

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1831
    const-string v2, "ImageDescription"

    invoke-virtual {v3, v2, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1832
    const-string v2, "UserComment"

    invoke-virtual {v3, v2, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1833
    move/from16 v2, v28

    .line 1835
    :cond_2b
    move-object/from16 v4, v18

    invoke-virtual {v3, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2e

    .line 1836
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 1837
    if-nez v0, :cond_2d

    move-object/from16 v1, v43

    if-eqz v1, :cond_2d

    .line 1838
    sget-object v6, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_FOCAL_LENGTHS:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v1, v6}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    .line 1839
    if-eqz v1, :cond_2c

    array-length v6, v1

    if-lez v6, :cond_2c

    .line 1840
    const/4 v7, 0x0

    aget v0, v1, v7

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto :goto_22

    .line 1839
    :cond_2c
    const/4 v7, 0x0

    goto :goto_22

    .line 1837
    :cond_2d
    const/4 v7, 0x0

    .line 1843
    :goto_22
    if-eqz v0, :cond_2f

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_2f

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    const v6, 0x3dcccccd    # 0.1f

    cmpl-float v1, v1, v6

    if-lez v1, :cond_2f

    .line 1844
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

    .line 1845
    goto :goto_23

    .line 1835
    :cond_2e
    const/4 v7, 0x0

    .line 1848
    :cond_2f
    move/from16 v28, v2

    :goto_23
    if-eqz v28, :cond_30

    .line 1849
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, v13

    add-int/lit16 v1, v1, 0x400

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1850
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v13}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v3, v1, v0, v7}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1851
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 1852
    array-length v1, v0
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_b

    const/16 v2, 0x40

    if-le v1, v2, :cond_30

    .line 1853
    move-object v13, v0

    goto :goto_24

    .line 1857
    :catchall_b
    move-exception v0

    :cond_30
    :goto_24
    nop

    .line 1858
    if-eqz v9, :cond_31

    if-eqz v13, :cond_31

    .line 1859
    :try_start_18
    invoke-static {v11, v13}, Lcom/motorola/camera/custom/CustomImagingBridge;->preserveGainmapExifSafe([B[B)[B

    move-result-object v13

    .line 1862
    :cond_31
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/storage/MediaFile;->fromMediaFilePath(Lcom/motorola/camera/storage/MediaFilePath;)Lcom/motorola/camera/storage/backend/MediaStoreMediaFile;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/storage/StorageUtils;->createMediaFileWithFallback(Lcom/motorola/camera/storage/MediaFile;)Lcom/motorola/camera/storage/MediaFile;

    move-result-object v0

    .line 1863
    if-nez v0, :cond_32

    return-void

    .line 1864
    :cond_32
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->getWriteFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    .line 1865
    if-nez v1, :cond_33

    return-void

    .line 1866
    :cond_33
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_10

    .line 1867
    :try_start_19
    invoke-virtual {v2, v13}, Ljava/io/FileOutputStream;->write([B)V

    .line 1868
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_c

    .line 1869
    :try_start_1a
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 1870
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->finish()V

    .line 1871
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sub-long v0, v0, v16

    const-wide/32 v2, 0xf4240

    div-long/2addr v0, v2

    .line 1872
    array-length v2, v13

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CleanBayerRaw async saved "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

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

    invoke-static {v10, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_10

    .line 1875
    goto :goto_27

    .line 1866
    :catchall_c
    move-exception v0

    move-object v1, v0

    :try_start_1b
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_d

    goto :goto_25

    :catchall_d
    move-exception v0

    :try_start_1c
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_25
    throw v1

    .line 1810
    :catchall_e
    move-exception v0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 1811
    throw v0

    .line 1873
    :catchall_f
    move-exception v0

    move-object/from16 v10, v44

    goto :goto_26

    .line 1630
    :cond_34
    move-object v10, v12

    array-length v0, v1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Raw buffer too small: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v10, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_10

    .line 1631
    return-void

    .line 1873
    :catchall_10
    move-exception v0

    goto :goto_26

    :catchall_11
    move-exception v0

    move-object v10, v12

    .line 1874
    :goto_26
    const-string v1, "runCleanBayerExport failed cleanly (DNG unaffected)"

    invoke-static {v10, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1876
    :goto_27
    return-void
.end method

.method private static sensorTransformToSrgbCcm([F)[F
    .locals 26

    .line 1891
    move-object/from16 v0, p0

    if-eqz v0, :cond_5

    array-length v2, v0

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    const/16 v23, 0x0

    goto/16 :goto_3

    .line 1892
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    const/4 v5, 0x1

    aget v6, v0, v5

    const/4 v7, 0x2

    aget v8, v0, v7

    .line 1893
    const/4 v9, 0x3

    aget v10, v0, v9

    const/4 v11, 0x4

    aget v12, v0, v11

    const/4 v13, 0x5

    aget v14, v0, v13

    .line 1894
    const/4 v15, 0x6

    aget v16, v0, v15

    const/16 v17, 0x7

    aget v18, v0, v17

    const/16 v19, 0x8

    aget v0, v0, v19

    .line 1895
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

    .line 1896
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

    .line 1897
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

    .line 1898
    mul-float v4, v4, v20

    mul-float/2addr v6, v1

    add-float/2addr v4, v6

    mul-float v8, v8, v21

    add-float/2addr v4, v8

    .line 1899
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v8, 0x3727c5ac    # 1.0E-5f

    cmpg-float v6, v6, v8

    if-gez v6, :cond_1

    goto :goto_2

    .line 1900
    :cond_1
    const/high16 v6, 0x3f800000    # 1.0f

    div-float/2addr v6, v4

    .line 1902
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

    .line 1907
    new-array v0, v3, [F

    fill-array-data v0, :array_0

    .line 1912
    new-array v1, v3, [F

    .line 1913
    move/from16 v2, v25

    :goto_0
    if-ge v2, v9, :cond_3

    .line 1914
    move/from16 v3, v25

    :goto_1
    if-ge v3, v9, :cond_2

    .line 1915
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

    .line 1914
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1913
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1920
    :cond_3
    return-object v1

    .line 1899
    :cond_4
    :goto_2
    return-object v23

    .line 1891
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

    .line 589
    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_1

    .line 593
    :cond_0
    :try_start_0
    new-instance p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-direct {p1, p2, p3}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 594
    invoke-virtual {p0, p1, p4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 595
    :catchall_0
    move-exception p0

    :goto_0
    nop

    .line 596
    return-void

    .line 590
    :cond_1
    :goto_1
    return-void
.end method

.method public static shouldAllowInSensorCrop()Z
    .locals 2

    .line 516
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 517
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

    .line 317
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

.method public static shouldDisableHdr10ForFps(I)Z
    .locals 0

    .line 2099
    invoke-static {p0}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldDisableHdr10ForFps(I)Z

    move-result p0

    return p0
.end method

.method private static shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z
    .locals 4

    .line 757
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 758
    :cond_0
    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    const/16 v2, 0x9

    const/4 v3, 0x1

    if-ne v1, v2, :cond_1

    return v3

    .line 759
    :cond_1
    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    invoke-static {v1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v1

    if-eqz v1, :cond_2

    return v0

    .line 760
    :cond_2
    iget-object v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v2, 0x5

    aget v1, v1, v2

    if-gtz v1, :cond_3

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-lez v1, :cond_4

    iget p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    if-lez p0, :cond_4

    :cond_3
    move v0, v3

    :cond_4
    return v0
.end method

.method public static shouldThermalStepDownFps(II)Z
    .locals 0

    .line 2103
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldThermalStepDownFps(II)Z

    move-result p0

    return p0
.end method

.method private static stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    .locals 3

    .line 775
    if-eqz p0, :cond_8

    if-eqz p1, :cond_8

    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->accuracy:Ljava/lang/Integer;

    if-eqz v0, :cond_8

    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->accuracy:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_0

    goto :goto_3

    .line 778
    :cond_0
    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->headingDeg:Ljava/lang/Float;

    .line 779
    :goto_0
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_2

    .line 780
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Float;->doubleValue()D

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassSolarHelper;->formatExifDirection(D)Ljava/lang/String;

    move-result-object v0

    .line 781
    if-nez v0, :cond_3

    return-void

    .line 782
    :cond_3
    const-string v1, "GPSImgDirection"

    invoke-virtual {p0, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 783
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 784
    :cond_4
    invoke-virtual {p0, v1, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 785
    iget-object p1, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    if-eqz p1, :cond_5

    const-string p1, "T"

    goto :goto_1

    :cond_5
    const-string p1, "M"

    :goto_1
    const-string v0, "GPSImgDirectionRef"

    invoke-virtual {p0, v0, p1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 787
    :cond_6
    return-void

    .line 779
    :cond_7
    :goto_2
    return-void

    .line 776
    :cond_8
    :goto_3
    return-void
.end method

.method private static stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V
    .locals 1

    .line 791
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 792
    return-void
.end method

.method private static stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    .locals 3

    .line 798
    const-string v0, "CustomImagingBridge"

    if-eqz p2, :cond_2

    if-eqz p3, :cond_2

    :try_start_0
    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    .line 799
    const-string v1, "ImageDescription"

    invoke-virtual {p2, v1, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 800
    const-string v1, "UserComment"

    invoke-virtual {p2, v1, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 801
    invoke-static {p2, p4}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 802
    new-instance p4, Ljava/io/ByteArrayOutputStream;

    array-length v1, p1

    add-int/lit16 v1, v1, 0x800

    invoke-direct {p4, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 803
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v2, 0x0

    invoke-virtual {p2, v1, p4, v2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 804
    invoke-virtual {p4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p4

    .line 805
    invoke-virtual {p2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-static {p1, p4}, Lcom/motorola/camera/custom/GainmapJpeg;->withExif([B[B)[B

    move-result-object p4

    .line 806
    :cond_0
    if-eqz p4, :cond_1

    array-length p1, p4

    const/16 p2, 0x40

    if-le p1, p2, :cond_1

    .line 807
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {p4}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 809
    :cond_1
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "Shot diag: "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 811
    :catchall_0
    move-exception p0

    .line 812
    const-string p1, "stampExifDescription skipped"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 813
    :cond_2
    :goto_0
    nop

    .line 814
    :goto_1
    return-void
.end method

.method private static toByteArray(Ljava/nio/ByteBuffer;)[B
    .locals 1

    .line 1924
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 1925
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 1926
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 1927
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1928
    return-object v0
.end method

.method private static tryMultiFrameRawMerge([BIII[FF[F[FLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
    .locals 51

    .line 1447
    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v0, p8

    move-object/from16 v1, p9

    move-object/from16 v4, p10

    int-to-long v5, v2

    int-to-long v7, v3

    mul-long/2addr v5, v7

    const-wide/16 v7, 0x5

    mul-long/2addr v7, v5

    const-wide/16 v9, 0x4

    const/16 v18, 0x0

    const/high16 v11, 0x7fc00000    # Float.NaN

    const/4 v12, 0x0

    :try_start_0
    div-long/2addr v7, v9

    long-to-int v7, v7

    .line 1448
    const-wide/16 v8, 0x2

    mul-long/2addr v5, v8

    long-to-int v5, v5

    .line 1449
    mul-int/lit8 v6, v2, 0x10

    add-int v8, v5, v6

    add-int/2addr v6, v7

    invoke-static {v8, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 1450
    nop

    .line 1451
    const/4 v8, 0x5

    invoke-static {v4, v7, v6, v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->snapshotSessionFrames(Ljava/lang/String;III)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    move-result-object v6

    .line 1452
    array-length v8, v6

    const/4 v9, 0x1

    if-ge v8, v9, :cond_0

    .line 1453
    invoke-static {v12, v11, v11}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1454
    return-object v18

    .line 1457
    :cond_0
    nop

    .line 1458
    const-string v8, "3"

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    const/4 v13, 0x6

    if-eqz v8, :cond_1

    .line 1459
    const/4 v1, 0x4

    goto :goto_0

    .line 1460
    :cond_1
    if-eqz v1, :cond_2

    iget v8, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    const v15, 0x3fb9999a    # 1.45f

    cmpl-float v8, v8, v15

    if-ltz v8, :cond_2

    iget v1, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-eq v1, v13, :cond_2

    .line 1461
    const/4 v1, 0x3

    goto :goto_0

    .line 1464
    :cond_2
    move v1, v9

    :goto_0
    nop

    .line 1465
    nop

    .line 1466
    nop

    .line 1467
    const/high16 v8, 0x40c00000    # 6.0f

    invoke-static {v4, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 1468
    nop

    .line 1469
    nop

    .line 1470
    const-wide/16 v19, 0x0

    const/16 v21, 0x0

    const/16 v17, 0x64

    if-eqz v0, :cond_9

    .line 1471
    :try_start_1
    sget-object v11, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v11}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Long;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1472
    move/from16 v23, v12

    :try_start_2
    sget-object v12, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v12}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Long;

    .line 1473
    sget-object v13, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v13}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    .line 1474
    sget-object v15, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v15}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/Float;

    .line 1475
    sget-object v10, Landroid/hardware/camera2/CaptureResult;->LENS_FOCUS_DISTANCE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v10}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Float;

    .line 1476
    sget-object v9, Landroid/hardware/camera2/CaptureResult;->LENS_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v9}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1477
    if-eqz v11, :cond_3

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v28

    cmp-long v9, v28, v19

    if-lez v9, :cond_3

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v28

    goto :goto_1

    .line 1478
    :cond_3
    move-wide/from16 v28, v19

    :goto_1
    if-eqz v12, :cond_4

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v30

    cmp-long v9, v30, v19

    if-lez v9, :cond_4

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v11

    move-wide/from16 v25, v11

    goto :goto_2

    .line 1479
    :cond_4
    const-wide/32 v25, 0x989680

    :goto_2
    if-eqz v13, :cond_5

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v9

    if-lez v9, :cond_5

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v17

    .line 1480
    :cond_5
    if-eqz v15, :cond_6

    invoke-virtual {v15}, Ljava/lang/Float;->floatValue()F

    move-result v9

    cmpl-float v9, v9, v21

    if-lez v9, :cond_6

    .line 1481
    invoke-virtual {v15}, Ljava/lang/Float;->floatValue()F

    move-result v8

    invoke-static {v4, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v4

    move v8, v4

    .line 1483
    :cond_6
    if-eqz v10, :cond_7

    invoke-virtual {v10}, Ljava/lang/Float;->floatValue()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-virtual {v10}, Ljava/lang/Float;->floatValue()F

    move-result v4

    goto :goto_3

    .line 1484
    :cond_7
    const/high16 v4, 0x7fc00000    # Float.NaN

    :goto_3
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    move v13, v8

    goto :goto_4

    :cond_8
    move v13, v8

    move/from16 v0, v23

    :goto_4
    move-wide/from16 v8, v25

    move/from16 v25, v17

    goto :goto_5

    .line 1552
    :catchall_0
    move-exception v0

    move/from16 v23, v12

    goto/16 :goto_1b

    .line 1470
    :cond_9
    move/from16 v23, v12

    move v13, v8

    move/from16 v25, v17

    move-wide/from16 v28, v19

    move/from16 v0, v23

    const/high16 v4, 0x7fc00000    # Float.NaN

    const-wide/32 v8, 0x989680

    .line 1488
    :goto_5
    cmp-long v26, v28, v19

    if-lez v26, :cond_a

    move-wide/from16 v10, v28

    goto :goto_6

    :cond_a
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v10

    .line 1487
    :goto_6
    invoke-static {v10, v11, v8, v9}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v10

    .line 1489
    cmpg-float v11, v10, v21

    if-gez v11, :cond_b

    move/from16 v30, v21

    goto :goto_7

    :cond_b
    move/from16 v30, v10

    .line 1490
    :goto_7
    cmpl-float v10, v13, v21

    if-lez v10, :cond_c

    mul-float v10, v13, v30

    goto :goto_8

    :cond_c
    move/from16 v10, v21

    .line 1491
    :goto_8
    invoke-static {v6, v4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->computeFocusSpreadDiopters([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;F)F

    move-result v11

    .line 1492
    nop

    .line 1493
    if-lez v26, :cond_d

    move-wide/from16 v31, v28

    goto :goto_9

    :cond_d
    const-wide/high16 v31, -0x8000000000000000L

    .line 1494
    :goto_9
    array-length v12, v6

    const-wide v33, 0x7fffffffffffffffL

    move/from16 v15, v23

    move-wide/from16 v35, v33

    :goto_a
    if-ge v15, v12, :cond_10

    aget-object v14, v6, v15

    .line 1495
    move-wide/from16 p8, v8

    iget-wide v8, v14, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v8, v8, v19

    if-lez v8, :cond_f

    .line 1496
    iget-wide v8, v14, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v8, v8, v35

    if-gez v8, :cond_e

    iget-wide v8, v14, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move-wide/from16 v35, v8

    .line 1497
    :cond_e
    iget-wide v8, v14, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v8, v8, v31

    if-lez v8, :cond_f

    iget-wide v8, v14, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move-wide/from16 v31, v8

    .line 1494
    :cond_f
    add-int/lit8 v15, v15, 0x1

    move-wide/from16 v8, p8

    goto :goto_a

    .line 1500
    :cond_10
    move-wide/from16 p8, v8

    cmp-long v8, v31, v35

    if-lez v8, :cond_11

    cmp-long v8, v35, v33

    if-gez v8, :cond_11

    sub-long v8, v31, v35

    long-to-float v8, v8

    const v9, 0x49742400    # 1000000.0f

    div-float/2addr v8, v9

    goto :goto_b

    :cond_11
    const/high16 v8, 0x7fc00000    # Float.NaN

    .line 1502
    :goto_b
    const/4 v9, 0x4

    if-ne v1, v9, :cond_12

    const/4 v9, 0x1

    goto :goto_c

    :cond_12
    move/from16 v9, v23

    :goto_c
    invoke-static {v6, v4, v0, v10, v9}, Lcom/motorola/camera/custom/MultiFrameBurstController;->hasFocusDriftOrMotion([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;FIFZ)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 1505
    const/4 v0, 0x1

    invoke-static {v0, v11, v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1506
    return-object v18

    .line 1509
    :cond_13
    const/4 v0, 0x3

    if-ne v1, v0, :cond_14

    const/16 v0, 0x8

    goto :goto_d

    :cond_14
    const/4 v0, 0x6

    .line 1510
    :goto_d
    new-instance v4, Lcom/motorola/camera/custom/MultiFrameRawEngine;

    invoke-direct {v4, v1, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;-><init>(II)V

    .line 1512
    cmp-long v0, v35, v33

    if-gez v0, :cond_15

    move-wide/from16 v0, v35

    goto :goto_e

    :cond_15
    move-wide/from16 v0, v28

    .line 1513
    :goto_e
    nop

    .line 1514
    nop

    .line 1515
    array-length v9, v6

    const-wide/16 v14, -0x1

    move/from16 v10, v23

    move/from16 v24, v10

    :goto_f
    if-ge v10, v9, :cond_1d

    aget-object v12, v6, v10

    .line 1516
    move/from16 v16, v8

    move/from16 v17, v9

    iget-wide v8, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v8, v8, v14

    if-lez v8, :cond_1c

    if-lez v26, :cond_16

    iget-wide v8, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v8, v8, v28

    if-nez v8, :cond_16

    move-wide/from16 v31, p8

    move-wide/from16 v43, v0

    move-object v1, v4

    move/from16 v38, v5

    move-object/from16 v22, v6

    move/from16 v37, v7

    move/from16 v27, v10

    move/from16 v40, v11

    move/from16 v39, v13

    move/from16 v41, v16

    move/from16 v23, v17

    const/16 v33, 0x1

    goto/16 :goto_14

    .line 1517
    :cond_16
    iget-object v8, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->raw:[B

    invoke-static {v8, v2, v3, v7, v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->unpackRawAuto([BIIII)[I

    move-result-object v8

    .line 1518
    if-nez v8, :cond_17

    move-wide/from16 v31, p8

    move-wide/from16 v43, v0

    move-object v1, v4

    move/from16 v38, v5

    move-object/from16 v22, v6

    move/from16 v37, v7

    move/from16 v27, v10

    move/from16 v40, v11

    move/from16 v39, v13

    move/from16 v41, v16

    move/from16 v23, v17

    const/16 v33, 0x1

    goto/16 :goto_14

    .line 1519
    :cond_17
    iget-wide v14, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    cmp-long v9, v14, v19

    if-lez v9, :cond_18

    iget-wide v14, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    goto :goto_10

    :cond_18
    move-wide/from16 v14, p8

    .line 1520
    :goto_10
    iget v9, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    if-lez v9, :cond_19

    iget v9, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    goto :goto_11

    :cond_19
    move/from16 v9, v25

    .line 1521
    :goto_11
    iget v2, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    cmpl-float v2, v2, v21

    if-lez v2, :cond_1a

    iget v2, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    goto :goto_12

    :cond_1a
    move v2, v13

    .line 1522
    :goto_12
    iget v3, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    cmpl-float v3, v3, v21

    if-ltz v3, :cond_1b

    iget v3, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    goto :goto_13

    :cond_1b
    move/from16 v3, v21

    .line 1523
    :goto_13
    move/from16 v31, v3

    move-object/from16 p10, v4

    iget-wide v3, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    invoke-static {v0, v1, v3, v4, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->interFrameGyroShiftPx(JJF)[F

    move-result-object v3

    .line 1524
    move-wide/from16 v35, v0

    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;

    move v1, v7

    move-object v4, v8

    iget-wide v7, v12, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move/from16 v32, v11

    move v11, v9

    move-wide/from16 v49, v14

    move v15, v10

    move-wide/from16 v9, v49

    aget v14, v3, v23

    const/16 v27, 0x1

    aget v3, v3, v27

    move-object/from16 v42, p10

    move/from16 v37, v1

    move-object v1, v4

    move/from16 v38, v5

    move-object/from16 v22, v6

    move-object/from16 v45, v12

    move/from16 v39, v13

    move/from16 v41, v16

    move/from16 v23, v17

    move/from16 v33, v27

    move/from16 v12, v31

    move/from16 v40, v32

    move-wide/from16 v43, v35

    move/from16 v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p5

    move-object/from16 v16, p6

    move-object/from16 v17, p7

    move-wide/from16 v31, p8

    move v13, v2

    move/from16 v27, v15

    move/from16 v2, p1

    move v15, v3

    move/from16 v3, p2

    invoke-direct/range {v0 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;-><init>([IIII[FFJJIFFFF[F[F)V

    move-object/from16 v1, v42

    invoke-virtual {v1, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->addFrame(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V

    .line 1527
    move-object/from16 v0, v45

    iget-wide v4, v0, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    .line 1528
    add-int/lit8 v24, v24, 0x1

    move-wide v14, v4

    goto :goto_14

    .line 1516
    :cond_1c
    move-wide/from16 v31, p8

    move-wide/from16 v43, v0

    move-object v1, v4

    move/from16 v38, v5

    move-object/from16 v22, v6

    move/from16 v37, v7

    move/from16 v27, v10

    move/from16 v40, v11

    move/from16 v39, v13

    move/from16 v41, v16

    move/from16 v23, v17

    const/16 v33, 0x1

    .line 1515
    :goto_14
    add-int/lit8 v10, v27, 0x1

    move-object v4, v1

    move-object/from16 v6, v22

    move/from16 v9, v23

    move-wide/from16 p8, v31

    move/from16 v7, v37

    move/from16 v5, v38

    move/from16 v13, v39

    move/from16 v11, v40

    move/from16 v8, v41

    move-wide/from16 v0, v43

    const/16 v23, 0x0

    goto/16 :goto_f

    .line 1530
    :cond_1d
    move-wide/from16 v31, p8

    move-wide/from16 v43, v0

    move-object v1, v4

    move/from16 v38, v5

    move/from16 v37, v7

    move/from16 v41, v8

    move/from16 v40, v11

    move/from16 v39, v13

    const/16 v33, 0x1

    if-nez v24, :cond_1e

    .line 1531
    move/from16 v0, v40

    move/from16 v4, v41

    const/4 v5, 0x0

    invoke-static {v5, v0, v4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1532
    return-object v18

    .line 1534
    :cond_1e
    move/from16 v0, v40

    move/from16 v4, v41

    const/4 v5, 0x0

    move-object/from16 v6, p0

    move/from16 v7, v37

    move/from16 v8, v38

    invoke-static {v6, v2, v3, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->unpackRawAuto([BIIII)[I

    move-result-object v6

    .line 1535
    if-nez v6, :cond_1f

    .line 1536
    invoke-static {v5, v0, v4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1537
    return-object v18

    .line 1539
    :cond_1f
    cmp-long v7, v28, v14

    if-lez v7, :cond_20

    goto :goto_15

    :cond_20
    const-wide/16 v7, 0x1

    add-long v28, v14, v7

    :goto_15
    move-wide/from16 v7, v28

    .line 1540
    move/from16 v13, v39

    move-wide/from16 v9, v43

    invoke-static {v9, v10, v7, v8, v13}, Lcom/motorola/camera/custom/TelemetryCollector;->interFrameGyroShiftPx(JJF)[F

    move-result-object v9

    .line 1541
    move/from16 v40, v0

    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;

    aget v14, v9, v5

    aget v15, v9, v33

    move-object/from16 v5, p4

    move-object/from16 v16, p6

    move-object/from16 v17, p7

    move-object/from16 v48, v1

    move/from16 v47, v4

    move-object v1, v6

    move/from16 v11, v25

    move/from16 v12, v30

    move-wide/from16 v9, v31

    move/from16 v46, v40

    move/from16 v4, p3

    move/from16 v6, p5

    invoke-direct/range {v0 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;-><init>([IIII[FFJJIFFFF[F[F)V

    move-object/from16 v1, v48

    invoke-virtual {v1, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->addFrame(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V

    .line 1544
    nop

    .line 1545
    invoke-virtual {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size()I

    move-result v0

    const/4 v2, 0x2

    if-lt v0, v2, :cond_23

    .line 1546
    invoke-static {}, Lcom/motorola/camera/custom/GpuComputeContext;->acquire()Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    move-result-object v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 1547
    if-eqz v3, :cond_21

    :try_start_3
    invoke-virtual {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mergeOnCurrentGlContext()Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v0

    goto :goto_16

    :cond_21
    invoke-virtual {v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->merge()Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1548
    :goto_16
    if-eqz v3, :cond_24

    :try_start_4
    invoke-virtual {v3}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    goto :goto_18

    .line 1546
    :catchall_1
    move-exception v0

    move-object v1, v0

    if-eqz v3, :cond_22

    :try_start_5
    invoke-virtual {v3}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    goto :goto_17

    :catchall_2
    move-exception v0

    :try_start_6
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_22
    :goto_17
    throw v1

    .line 1545
    :cond_23
    move-object/from16 v0, v18

    .line 1550
    :cond_24
    :goto_18
    if-eqz v0, :cond_26

    iget v1, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    if-ge v1, v2, :cond_25

    goto :goto_19

    :cond_25
    const/4 v12, 0x0

    goto :goto_1a

    :cond_26
    :goto_19
    move/from16 v12, v33

    :goto_1a
    move/from16 v1, v46

    move/from16 v4, v47

    invoke-static {v12, v1, v4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 1551
    return-object v0

    .line 1552
    :catchall_3
    move-exception v0

    .line 1553
    :goto_1b
    const/high16 v1, 0x7fc00000    # Float.NaN

    const/4 v5, 0x0

    invoke-static {v5, v1, v1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1554
    const-string v1, "CustomImagingBridge"

    const-string v2, "MultiFrameRaw merge skipped (singleRaw fallback)"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1555
    return-object v18
.end method

.method private static unpackRawAuto([BIIII)[I
    .locals 2

    .line 1560
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    if-gtz p2, :cond_0

    goto :goto_0

    .line 1561
    :cond_0
    array-length v1, p0

    if-lt v1, p4, :cond_1

    .line 1562
    array-length p3, p0

    div-int/2addr p3, p2

    const/4 p4, 0x1

    invoke-static {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object p0

    return-object p0

    .line 1564
    :cond_1
    array-length p4, p0

    if-lt p4, p3, :cond_2

    .line 1565
    array-length p3, p0

    div-int/2addr p3, p2

    invoke-static {p0, p1, p2, p3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object p0

    return-object p0

    .line 1567
    :cond_2
    return-object v0

    .line 1560
    :cond_3
    :goto_0
    return-object v0
.end method

.method private static writePublicTelemetrySidecar(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8

    .line 2308
    const-string v0, "is_pending"

    if-eqz p0, :cond_9

    if-eqz p2, :cond_9

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_7

    .line 2309
    :cond_0
    nop

    .line 2311
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2312
    goto :goto_0

    :catchall_0
    move-exception v2

    move-object v2, v1

    .line 2313
    :goto_0
    const-string v3, ".telemetry.json"

    if-eqz v2, :cond_6

    .line 2314
    nop

    .line 2316
    :try_start_1
    const-string v4, "external_primary"

    invoke-static {v4}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    .line 2317
    if-eqz v4, :cond_4

    .line 2318
    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    .line 2319
    const-string v6, "_display_name"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2320
    const-string v6, "mime_type"

    const-string v7, "application/json"

    invoke-virtual {v5, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2321
    const-string v6, "relative_path"

    const-string v7, "Documents/Edge50Telemetry"

    invoke-virtual {v5, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2322
    const/4 v6, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v0, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2323
    invoke-virtual {v2, v4, v5}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 2324
    if-eqz v4, :cond_4

    .line 2325
    :try_start_2
    invoke-virtual {v2, v4}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 2326
    if-eqz v6, :cond_2

    .line 2327
    :try_start_3
    sget-object v7, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v7}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/OutputStream;->write([B)V

    .line 2328
    invoke-virtual {v6}, Ljava/io/OutputStream;->flush()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    .line 2325
    :catchall_1
    move-exception v0

    if-eqz v6, :cond_1

    :try_start_4
    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception v5

    :try_start_5
    invoke-virtual {v0, v5}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_1
    :goto_1
    throw v0

    .line 2330
    :cond_2
    :goto_2
    if-eqz v6, :cond_3

    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V

    .line 2331
    :cond_3
    invoke-virtual {v5}, Landroid/content/ContentValues;->clear()V

    .line 2332
    const/4 v6, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v0, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2333
    invoke-virtual {v2, v4, v5, v1, v1}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    goto :goto_3

    .line 2336
    :catchall_3
    move-exception v0

    goto :goto_4

    .line 2341
    :cond_4
    :goto_3
    goto :goto_6

    .line 2336
    :catchall_4
    move-exception v0

    move-object v4, v1

    .line 2337
    :goto_4
    if-eqz v4, :cond_5

    .line 2338
    :try_start_6
    invoke-virtual {v2, v4, v1, v1}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_5

    goto :goto_5

    :catchall_5
    move-exception v1

    .line 2340
    :cond_5
    :goto_5
    const-string v1, "CustomImagingBridge"

    const-string v2, "Public telemetry MediaStore write skipped"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2343
    :cond_6
    :goto_6
    const-string v0, "telemetry"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    .line 2344
    if-eqz p0, :cond_8

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_7

    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2345
    :cond_7
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 2346
    invoke-static {v0, p2}, Lcom/motorola/camera/custom/TelemetryCollector;->writeSidecarJsonIfEnabled(Ljava/io/File;Ljava/lang/String;)Z

    .line 2348
    :cond_8
    return-void

    .line 2308
    :cond_9
    :goto_7
    return-void
.end method
