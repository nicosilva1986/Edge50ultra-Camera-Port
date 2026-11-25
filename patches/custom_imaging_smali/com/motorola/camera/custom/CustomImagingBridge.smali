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

.field private static final MOD_VERSION:Ljava/lang/String; = "1.9.2"

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

    .line 90
    new-instance v0, Ljava/util/concurrent/Semaphore;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    .line 136
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->checkAdspRpcReadable()Z

    move-result v0

    sput-boolean v0, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    .line 154
    nop

    .line 155
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

    .line 154
    invoke-static {v0, v4}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->LUT_POOL:Ljava/util/concurrent/ExecutorService;

    .line 157
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

    .line 162
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    .line 205
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    .line 206
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$1;

    const/16 v4, 0x40

    const/high16 v5, 0x3f400000    # 0.75f

    invoke-direct {v0, v4, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$1;-><init>(IFZ)V

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    .line 213
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

    .line 224
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

    .line 231
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

    .line 235
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

    .line 535
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

    .line 552
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 553
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 554
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 555
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    .line 2165
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$5;

    const/16 v2, 0x10

    invoke-direct {v0, v2, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$5;-><init>(IFZ)V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    .line 2237
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$6;

    invoke-direct {v0, v2, v5, v1}, Lcom/motorola/camera/custom/CustomImagingBridge$6;-><init>(IFZ)V

    .line 2238
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_COMPASS_CACHE:Ljava/util/Map;

    .line 2237
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 239
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static adaptGainmap(Landroid/graphics/Gainmap;II)V
    .locals 13

    .line 1122
    int-to-float p2, p2

    const/high16 v0, 0x42c80000    # 100.0f

    div-float/2addr p2, v0

    .line 1123
    if-eqz p0, :cond_7

    const/4 v0, 0x0

    cmpg-float v0, p2, v0

    if-gtz v0, :cond_0

    goto/16 :goto_5

    .line 1124
    :cond_0
    const/4 v0, 0x3

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne p1, v0, :cond_3

    .line 1125
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getGainmapContents()Landroid/graphics/Bitmap;

    move-result-object v4

    .line 1126
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v11

    .line 1127
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

    .line 1128
    mul-int p1, v7, v11

    new-array v5, p1, [I

    .line 1129
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v6, 0x0

    move v10, v7

    invoke-virtual/range {v4 .. v11}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 1130
    move v0, v2

    :goto_0
    if-ge v0, p1, :cond_1

    .line 1131
    aget v4, v5, v0

    ushr-int/lit8 v6, v4, 0x10

    and-int/lit16 v6, v6, 0xff

    ushr-int/lit8 v8, v4, 0x8

    and-int/lit16 v8, v8, 0xff

    and-int/lit16 v9, v4, 0xff

    .line 1132
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

    .line 1133
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

    .line 1134
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

    .line 1130
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1136
    :cond_1
    sget-object p1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v5, v7, v11, p1}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/graphics/Gainmap;->setGainmapContents(Landroid/graphics/Bitmap;)V

    .line 1138
    :cond_2
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMin()[F

    move-result-object p1

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMax()[F

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getGamma()[F

    move-result-object v4

    .line 1139
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getEpsilonSdr()[F

    move-result-object v5

    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getEpsilonHdr()[F

    move-result-object v6

    .line 1140
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v0, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v4, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    .line 1141
    invoke-static {v5, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    invoke-static {v6, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->neutralize([FF)V

    .line 1142
    aget p2, p1, v2

    aget v7, p1, v3

    aget p1, p1, v1

    invoke-virtual {p0, p2, v7, p1}, Landroid/graphics/Gainmap;->setRatioMin(FFF)V

    .line 1143
    aget p1, v0, v2

    aget p2, v0, v3

    aget v0, v0, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setRatioMax(FFF)V

    .line 1144
    aget p1, v4, v2

    aget p2, v4, v3

    aget v0, v4, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setGamma(FFF)V

    .line 1145
    aget p1, v5, v2

    aget p2, v5, v3

    aget v0, v5, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setEpsilonSdr(FFF)V

    .line 1146
    aget p1, v6, v2

    aget p2, v6, v3

    aget v0, v6, v1

    invoke-virtual {p0, p1, p2, v0}, Landroid/graphics/Gainmap;->setEpsilonHdr(FFF)V

    goto :goto_1

    .line 1147
    :cond_3
    const/4 v0, 0x6

    if-eq p1, v3, :cond_5

    if-ne p1, v0, :cond_4

    goto :goto_2

    :cond_4
    :goto_1
    goto :goto_4

    .line 1148
    :cond_5
    :goto_2
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMax()[F

    move-result-object v4

    .line 1149
    invoke-virtual {p0}, Landroid/graphics/Gainmap;->getRatioMin()[F

    move-result-object v5

    .line 1150
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

    .line 1151
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

    .line 1152
    invoke-static {v0, v2}, Ljava/lang/Math;->max(FF)F

    move-result v0

    aget v2, v5, v1

    aget v1, v4, v1

    sub-float/2addr v1, v6

    mul-float/2addr v1, p2

    add-float/2addr v1, v6

    .line 1153
    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result p2

    .line 1151
    invoke-virtual {p0, p1, v0, p2}, Landroid/graphics/Gainmap;->setRatioMax(FFF)V

    .line 1155
    :goto_4
    return-void

    .line 1123
    :cond_7
    :goto_5
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 1

    .line 651
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V

    .line 652
    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)V
    .locals 16

    .line 656
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    if-eqz v1, :cond_12

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 658
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v3

    .line 659
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->FLASH_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 660
    const/4 v5, 0x3

    const/4 v6, 0x1

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-eqz v4, :cond_1

    .line 661
    move v3, v6

    goto :goto_0

    .line 663
    :cond_1
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {v1, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    .line 664
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    if-ne v4, v5, :cond_2

    .line 665
    move v3, v6

    .line 668
    :cond_2
    :goto_0
    nop

    .line 669
    instance-of v4, v2, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v4, :cond_3

    .line 670
    move-object v4, v2

    check-cast v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 671
    iget-object v7, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 672
    iget-boolean v4, v4, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z

    if-eqz v4, :cond_4

    .line 673
    move v3, v6

    goto :goto_1

    .line 669
    :cond_3
    const/4 v7, 0x0

    .line 677
    :cond_4
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v4

    invoke-static {v2, v7, v3, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v2

    .line 678
    iget-object v2, v2, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 679
    aget v4, v2, v6

    .line 680
    const/4 v7, 0x2

    aget v8, v2, v7

    .line 681
    aget v5, v2, v5

    .line 683
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v9

    .line 684
    const/4 v10, 0x0

    if-eqz v9, :cond_10

    .line 685
    if-ltz v4, :cond_5

    .line 686
    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [I

    .line 687
    invoke-static {v11, v4}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 688
    sget-object v11, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v1, v11, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 691
    :cond_5
    if-ltz v8, :cond_6

    .line 692
    sget-object v4, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v9, v4}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    .line 693
    invoke-static {v4, v8}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 694
    sget-object v4, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v1, v4, v8}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 702
    :cond_6
    invoke-static {v9, v10}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v4

    .line 703
    invoke-static {v9, v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object v8

    .line 705
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_7

    .line 706
    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v4

    goto :goto_2

    .line 708
    :cond_7
    new-instance v9, Ljava/util/HashSet;

    invoke-direct {v9, v4}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 709
    invoke-interface {v9, v8}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 711
    invoke-interface {v8}, Ljava/util/Set;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_8

    .line 712
    sget-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->KNOWN_SESSION_KEYS:Ljava/util/Set;

    invoke-interface {v9, v4}, Ljava/util/Set;->removeAll(Ljava/util/Collection;)Z

    .line 715
    :cond_8
    move-object v4, v9

    :goto_2
    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_10

    array-length v8, v2

    const/16 v9, 0xd

    if-lt v8, v9, :cond_10

    .line 716
    const/4 v8, 0x7

    aget v8, v2, v8

    .line 717
    const/16 v9, 0x8

    aget v9, v2, v9

    .line 718
    const/16 v11, 0x9

    aget v11, v2, v11

    .line 719
    const/16 v12, 0xa

    aget v12, v2, v12

    .line 720
    const/16 v13, 0xb

    aget v13, v2, v13

    .line 721
    const/16 v14, 0xc

    aget v2, v2, v14

    .line 723
    if-ltz v8, :cond_9

    .line 724
    const-string v14, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    const-class v15, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v14, v15, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 725
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableXCFAOptimization"

    const-class v14, Ljava/lang/Byte;

    int-to-byte v15, v8

    invoke-static {v15}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v15

    invoke-static {v1, v4, v7, v14, v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 726
    if-nez v8, :cond_9

    .line 727
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableInsensorZoom"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v7, v8, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 730
    :cond_9
    if-ltz v9, :cond_a

    .line 731
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v8, Ljava/lang/Byte;

    int-to-byte v9, v9

    invoke-static {v9}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 733
    :cond_a
    if-ltz v11, :cond_b

    .line 734
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 736
    :cond_b
    if-ltz v12, :cond_e

    .line 737
    if-lez v12, :cond_c

    move v7, v6

    goto :goto_3

    :cond_c
    move v7, v10

    .line 738
    :goto_3
    if-lez v12, :cond_d

    const/4 v8, 0x2

    goto :goto_4

    :cond_d
    move v8, v10

    .line 739
    :goto_4
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    invoke-static {v1, v4, v9, v11, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 740
    const-string v9, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v11, Ljava/lang/Integer;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-static {v1, v4, v9, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 741
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 742
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.SnapshotHDRMode"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-static {v1, v4, v7, v9, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 743
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.HDRModePreference"

    const-class v9, Ljava/lang/Integer;

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-static {v1, v4, v7, v9, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 744
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableSHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 745
    const-string v7, "org.codeaurora.qcamera3.sessionParameters.EnableQHDR"

    const-class v8, Ljava/lang/Integer;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-static {v1, v4, v7, v8, v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 747
    :cond_e
    if-ne v13, v6, :cond_f

    .line 748
    const-string v6, "com.lenovo.moto.SATFallback.T2W"

    const-class v7, Ljava/lang/Byte;

    invoke-static {v10}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v8

    invoke-static {v1, v4, v6, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 750
    :cond_f
    if-ltz v2, :cond_10

    .line 751
    const-string v6, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v7, Ljava/lang/Integer;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v4, v6, v7, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 755
    :cond_10
    if-nez v5, :cond_11

    .line 756
    invoke-static {v0, v1, v10, v3}, Lcom/motorola/camera/fsm/camera/modes/RequestBuilderHelper;->setMfnr(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;ZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 760
    :cond_11
    goto :goto_5

    .line 758
    :catchall_0
    move-exception v0

    .line 759
    const-string v1, "CustomImagingBridge"

    const-string v2, "applyCaptureRequestOverrides failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 761
    :goto_5
    return-void

    .line 656
    :cond_12
    :goto_6
    return-void
.end method

.method public static applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 52

    .line 866
    move-object/from16 v1, p0

    const-string v7, "CustomImagingBridge"

    if-eqz v1, :cond_4f

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_4f

    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_2f

    .line 869
    :cond_0
    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v4

    .line 870
    const-string v5, "vendor"

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 871
    const-string v2, "vendor"

    invoke-static {v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v2

    .line 872
    iget v5, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    const/16 v6, 0x9

    if-ne v5, v6, :cond_1

    .line 873
    return-void

    .line 875
    :cond_1
    iget-object v5, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v5, v5, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 876
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

    .line 877
    :goto_0
    if-eqz v6, :cond_3

    check-cast v5, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    move-object v11, v5

    goto :goto_1

    :cond_3
    move-object v11, v3

    .line 878
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

    .line 879
    iget-object v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v10, 0x5

    aget v13, v0, v10

    .line 880
    iget v14, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    .line 881
    iget v15, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    .line 882
    invoke-static {v14}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v17

    .line 883
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->dismiss()V

    .line 884
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->acquireUninterruptibly()V

    .line 886
    :try_start_0
    iget-object v0, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_a

    .line 887
    if-nez v0, :cond_5

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 887
    return-void

    .line 888
    :cond_5
    :try_start_1
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 889
    array-length v0, v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_a

    const/16 v9, 0x10

    if-ge v0, v9, :cond_6

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 889
    return-void

    .line 891
    :cond_6
    nop

    .line 893
    :try_start_2
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v9, Ljava/io/ByteArrayInputStream;

    invoke-direct {v9, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 894
    move-object v9, v0

    goto :goto_3

    :catchall_0
    move-exception v0

    const/4 v9, 0x0

    .line 897
    :goto_3
    const-string v8, "ImageDescription"

    if-eqz v9, :cond_7

    :try_start_3
    invoke-virtual {v9, v8}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_7
    const/4 v0, 0x0

    .line 898
    :goto_4
    if-eqz v0, :cond_8

    const-string v10, "Edge50Port "

    invoke-virtual {v0, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_a

    if-eqz v0, :cond_8

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 899
    return-void

    .line 902
    :cond_8
    if-nez v17, :cond_9

    :try_start_4
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-lez v0, :cond_9

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    if-lez v0, :cond_9

    .line 903
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v0

    move-object/from16 v30, v0

    goto :goto_5

    :cond_9
    const/16 v30, 0x0

    .line 904
    :goto_5
    if-eqz v6, :cond_a

    if-nez v17, :cond_a

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    if-lez v0, :cond_a

    const/4 v0, 0x1

    goto :goto_6

    :cond_a
    const/4 v0, 0x0

    .line 905
    :goto_6
    if-eqz v0, :cond_b

    invoke-static {v11}, Lcom/motorola/camera/custom/PortraitBokeh;->original(Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;)Ljava/nio/ByteBuffer;

    move-result-object v10

    goto :goto_7

    :cond_b
    const/4 v10, 0x0

    .line 906
    :goto_7
    nop

    .line 907
    nop

    .line 908
    if-eqz v0, :cond_f

    if-eqz v10, :cond_f

    if-eqz v9, :cond_d

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v17

    if-nez v17, :cond_c

    goto :goto_8

    :cond_c
    move/from16 v17, v0

    move/from16 v22, v6

    move-object/from16 v23, v12

    goto :goto_9

    .line 909
    :cond_d
    :goto_8
    move/from16 v17, v0

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    move/from16 v22, v6

    iget v6, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    move-object/from16 v23, v12

    iget v12, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    invoke-static {v10, v11, v0, v6, v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->renderPortrait(Ljava/nio/ByteBuffer;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;III)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 911
    if-eqz v0, :cond_e

    const-string v6, "orig"

    move-object/from16 v51, v6

    move-object v6, v0

    move-object/from16 v0, v51

    goto :goto_a

    :cond_e
    move-object v6, v0

    const/4 v0, 0x0

    goto :goto_a

    .line 908
    :cond_f
    move/from16 v17, v0

    move/from16 v22, v6

    move-object/from16 v23, v12

    .line 913
    :goto_9
    const/4 v0, 0x0

    const/4 v6, 0x0

    :goto_a
    if-nez v14, :cond_10

    if-gtz v13, :cond_10

    const/16 v31, 0x1

    goto :goto_b

    :cond_10
    const/16 v31, 0x0

    .line 914
    :goto_b
    invoke-static {v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->readIsoSafe(Lcom/motorola/camera/photometadata/PhotoMetadata;)I

    move-result v12

    .line 915
    nop

    .line 916
    nop

    .line 917
    nop

    .line 918
    nop

    .line 919
    nop

    .line 920
    nop

    .line 921
    const/high16 v24, 0x3f800000    # 1.0f

    if-eqz v31, :cond_26

    .line 922
    move-object/from16 v25, v0

    const/16 v0, 0x320

    if-ge v12, v0, :cond_14

    const v26, 0x3ee66666    # 0.45f

    cmpl-float v26, v15, v26

    const v27, 0x3fd9999a    # 1.7f

    if-ltz v26, :cond_11

    cmpg-float v26, v15, v27

    if-gez v26, :cond_11

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v28, 0x43110000    # 145.0f

    cmpg-float v0, v0, v28

    if-lez v0, :cond_13

    :cond_11
    cmpl-float v0, v15, v27

    const/high16 v27, 0x40b00000    # 5.5f

    if-ltz v0, :cond_12

    cmpg-float v0, v15, v27

    if-gez v0, :cond_12

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v28, 0x435c0000    # 220.0f

    cmpg-float v0, v0, v28

    if-ltz v0, :cond_13

    :cond_12
    cmpl-float v0, v15, v27

    if-ltz v0, :cond_14

    const/high16 v0, 0x41f00000    # 30.0f

    cmpg-float v0, v15, v0

    if-gtz v0, :cond_14

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    const/high16 v27, 0x43700000    # 240.0f

    cmpg-float v0, v0, v27

    if-gez v0, :cond_14

    :cond_13
    const/4 v0, 0x1

    goto :goto_c

    :cond_14
    const/4 v0, 0x0

    .line 926
    :goto_c
    move/from16 v27, v0

    if-eqz v30, :cond_15

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isDiffusionLook(I)Z

    move-result v0

    if-eqz v0, :cond_15

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move-object/from16 v29, v6

    const/16 v6, 0x28

    if-lt v0, v6, :cond_16

    .line 928
    const/16 v27, 0x0

    goto :goto_d

    .line 926
    :cond_15
    move-object/from16 v29, v6

    .line 930
    :cond_16
    :goto_d
    if-eqz v9, :cond_18

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v0

    if-nez v0, :cond_17

    goto :goto_e

    :cond_17
    move/from16 v0, v24

    const/16 v26, 0x0

    const/16 v32, 0x0

    const/16 v33, 0x0

    goto/16 :goto_14

    .line 931
    :cond_18
    :goto_e
    invoke-static {v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->evaluateAutoPostGates([B)I

    move-result v0

    .line 932
    and-int/lit8 v6, v0, 0x1

    if-eqz v6, :cond_19

    const/4 v6, 0x1

    goto :goto_f

    :cond_19
    const/4 v6, 0x0

    .line 933
    :goto_f
    and-int/lit8 v32, v0, 0x2

    if-eqz v32, :cond_1a

    const/16 v32, 0x1

    goto :goto_10

    :cond_1a
    const/16 v32, 0x0

    .line 934
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

    .line 935
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

    const/high16 v26, 0x43340000    # 180.0f

    cmpg-float v0, v0, v26

    if-ltz v0, :cond_1e

    :cond_1d
    if-eqz v33, :cond_1f

    :cond_1e
    const/4 v0, 0x1

    goto :goto_12

    :cond_1f
    const/4 v0, 0x0

    .line 937
    :goto_12
    if-eqz v30, :cond_24

    .line 938
    move/from16 v26, v0

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isContrastFilmLook(I)Z

    move-result v0

    if-eqz v0, :cond_20

    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move/from16 v33, v6

    const/16 v6, 0x28

    if-lt v0, v6, :cond_21

    .line 940
    nop

    .line 941
    const/16 v26, 0x0

    const/16 v33, 0x0

    goto :goto_13

    .line 938
    :cond_20
    move/from16 v33, v6

    .line 943
    :cond_21
    :goto_13
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    const/4 v6, 0x6

    if-ne v0, v6, :cond_23

    .line 944
    nop

    .line 945
    if-eqz v33, :cond_22

    .line 946
    const v0, 0x3ecccccd    # 0.4f

    const/16 v32, 0x1

    goto :goto_14

    .line 945
    :cond_22
    move/from16 v0, v24

    const/16 v32, 0x1

    goto :goto_14

    .line 943
    :cond_23
    move/from16 v0, v24

    goto :goto_14

    .line 937
    :cond_24
    move/from16 v26, v0

    move/from16 v33, v6

    move/from16 v0, v24

    .line 951
    :goto_14
    if-nez v33, :cond_25

    if-nez v32, :cond_25

    if-nez v26, :cond_25

    if-nez v27, :cond_25

    if-nez v30, :cond_25

    if-nez v17, :cond_25

    .line 952
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_a

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 953
    return-void

    .line 959
    :cond_25
    move v6, v0

    move/from16 v28, v26

    move/from16 v26, v27

    goto :goto_15

    .line 955
    :cond_26
    move-object/from16 v25, v0

    move-object/from16 v29, v6

    if-gtz v13, :cond_27

    if-nez v30, :cond_27

    if-nez v17, :cond_27

    .line 956
    :try_start_5
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_a

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 957
    return-void

    .line 959
    :cond_27
    move/from16 v6, v24

    const/16 v26, 0x0

    const/16 v28, 0x0

    const/16 v32, 0x0

    const/16 v33, 0x0

    :goto_15
    if-eqz v30, :cond_28

    :try_start_6
    iget v0, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    move/from16 v34, v6

    const/4 v6, 0x5

    if-ne v0, v6, :cond_29

    if-eqz v26, :cond_29

    .line 960
    const/high16 v24, 0x3f000000    # 0.5f

    move/from16 v6, v24

    goto :goto_16

    .line 959
    :cond_28
    move/from16 v34, v6

    .line 963
    :cond_29
    move/from16 v6, v24

    :goto_16
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 964
    move/from16 v35, v6

    const/4 v6, 0x1

    iput-boolean v6, v0, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 965
    sget-object v6, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v6, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 966
    if-eqz v29, :cond_2a

    move-object/from16 v21, v10

    move-object/from16 v36, v29

    goto :goto_17

    .line 967
    :cond_2a
    array-length v6, v3

    move-object/from16 v21, v10

    const/4 v10, 0x0

    invoke-static {v3, v10, v6, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_a

    move-object/from16 v36, v0

    .line 968
    :goto_17
    if-nez v36, :cond_2b

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 968
    return-void

    .line 971
    :cond_2b
    :try_start_7
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_8

    if-nez v0, :cond_2c

    .line 1093
    :try_start_8
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_a

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 971
    return-void

    .line 972
    :cond_2c
    :try_start_9
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->hasGainmap()Z

    move-result v0

    if-eqz v0, :cond_2d

    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->getGainmap()Landroid/graphics/Gainmap;

    move-result-object v0

    move-object v6, v0

    goto :goto_18

    :cond_2d
    const/4 v6, 0x0

    .line 973
    :goto_18
    if-nez v6, :cond_2e

    if-eqz v9, :cond_2e

    invoke-virtual {v9}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result v0

    if-eqz v0, :cond_2e

    .line 974
    invoke-static {v1, v3, v9, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_8

    .line 1093
    :try_start_a
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_a

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 975
    return-void

    .line 977
    :cond_2e
    :try_start_b
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v39

    .line 978
    invoke-virtual/range {v36 .. v36}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_8

    .line 979
    if-lez v39, :cond_4e

    if-gtz v10, :cond_2f

    move-object v1, v7

    move-object/from16 v5, v36

    goto/16 :goto_2b

    .line 981
    :cond_2f
    if-eqz v17, :cond_31

    if-nez v29, :cond_31

    .line 982
    move-object/from16 v44, v7

    const/4 v7, 0x0

    :try_start_c
    invoke-static {v1, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_2

    .line 983
    nop

    .line 984
    if-eqz v17, :cond_30

    .line 985
    :try_start_d
    invoke-static/range {v17 .. v17}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    goto :goto_19

    :catchall_1
    move-exception v0

    .line 987
    :cond_30
    move-object v0, v7

    :goto_19
    :try_start_e
    invoke-static/range {v17 .. v17}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFrontCameraId(Ljava/lang/String;)Z

    move-result v17

    .line 988
    nop

    .line 989
    move/from16 v18, v12

    invoke-static {v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCaptureResult(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Landroid/hardware/camera2/TotalCaptureResult;

    move-result-object v12

    move/from16 v27, v15

    iget v15, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_2

    .line 988
    move-object/from16 v49, v6

    move-object/from16 v48, v8

    move v6, v10

    move v7, v13

    move/from16 v45, v14

    move/from16 v14, v17

    move-object/from16 v46, v21

    move-object/from16 v50, v23

    move-object/from16 v47, v29

    move-object/from16 v10, v36

    move/from16 v8, v39

    move-object v13, v0

    move/from16 v29, v18

    :try_start_f
    invoke-static/range {v10 .. v15}, Lcom/motorola/camera/custom/PortraitBokeh;->renderSingleCam(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;Landroid/hardware/camera2/TotalCaptureResult;Landroid/hardware/camera2/CameraCharacteristics;ZI)Ljava/lang/String;

    move-result-object v0

    goto :goto_1a

    .line 1093
    :catchall_2
    move-exception v0

    move-object/from16 v10, v36

    goto/16 :goto_29

    .line 981
    :cond_31
    move-object/from16 v49, v6

    move-object/from16 v44, v7

    move-object/from16 v48, v8

    move v6, v10

    move v7, v13

    move/from16 v45, v14

    move/from16 v27, v15

    move-object/from16 v46, v21

    move-object/from16 v50, v23

    move-object/from16 v47, v29

    move-object/from16 v10, v36

    move/from16 v8, v39

    move/from16 v29, v12

    .line 991
    move-object/from16 v0, v25

    :goto_1a
    if-nez v0, :cond_32

    const/4 v12, 0x0

    goto :goto_1b

    :cond_32
    iget v12, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    .line 992
    :goto_1b
    if-lez v12, :cond_33

    sget-object v13, Lcom/motorola/camera/custom/CustomImagingBridge;->BOKEH_DISPLAY_NAMES:[Ljava/lang/String;

    array-length v13, v13

    if-ge v12, v13, :cond_33

    .line 993
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

    .line 994
    :goto_1c
    if-eqz v22, :cond_35

    .line 995
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

    .line 996
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

    .line 997
    if-eqz v31, :cond_36

    if-nez v33, :cond_36

    if-nez v32, :cond_36

    if-nez v28, :cond_36

    if-nez v26, :cond_36

    if-nez v30, :cond_36

    if-nez v12, :cond_36

    .line 999
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    .line 1093
    :try_start_10
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1000
    return-void

    .line 1002
    :cond_36
    if-nez v31, :cond_37

    if-gtz v7, :cond_37

    if-nez v30, :cond_37

    if-nez v12, :cond_37

    .line 1003
    :try_start_11
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_7

    .line 1093
    :try_start_12
    invoke-virtual {v10}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1004
    return-void

    .line 1095
    :catchall_3
    move-exception v0

    move-object/from16 v1, v44

    goto/16 :goto_2d

    .line 1007
    :cond_37
    move-object v5, v10

    :try_start_13
    invoke-static {v5, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->bitmapSurface(Landroid/graphics/Bitmap;I)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;

    move-result-object v10

    .line 1010
    if-eqz v31, :cond_3d

    .line 1011
    nop

    .line 1012
    nop

    .line 1013
    nop

    .line 1014
    nop

    .line 1015
    if-eqz v33, :cond_39

    const/16 v12, 0x10

    if-lt v8, v12, :cond_39

    if-lt v6, v12, :cond_39

    .line 1016
    invoke-static {}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->autoLtmGridStep()I

    move-result v12

    .line 1017
    add-int v39, v8, v12

    const/4 v13, 0x1

    add-int/lit8 v39, v39, -0x1

    div-int v14, v39, v12

    const/4 v15, 0x2

    invoke-static {v15, v14}, Ljava/lang/Math;->max(II)I

    move-result v24

    .line 1018
    add-int v14, v6, v12

    sub-int/2addr v14, v13

    div-int/2addr v14, v12

    invoke-static {v15, v14}, Ljava/lang/Math;->max(II)I

    move-result v25

    .line 1019
    mul-int v14, v24, v25

    new-array v15, v14, [F

    .line 1020
    new-array v14, v14, [F

    .line 1021
    mul-int v13, v8, v12

    new-array v13, v13, [I
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_6

    .line 1022
    move-object/from16 v36, v5

    const/4 v5, 0x0

    :goto_1f
    if-ge v5, v6, :cond_38

    .line 1023
    move/from16 v41, v5

    sub-int v5, v6, v41

    :try_start_14
    invoke-static {v12, v5}, Ljava/lang/Math;->min(II)I

    move-result v19

    .line 1024
    const/16 v38, 0x0

    const/16 v40, 0x0

    move/from16 v42, v8

    move/from16 v39, v8

    move-object/from16 v37, v13

    move/from16 v43, v19

    invoke-virtual/range {v36 .. v43}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_4

    move-object/from16 v5, v36

    move-object/from16 v17, v37

    move/from16 v18, v39

    .line 1025
    move/from16 v21, v6

    move-object/from16 v23, v14

    move-object/from16 v22, v15

    move/from16 v20, v41

    :try_start_15
    invoke-static/range {v17 .. v25}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    move/from16 v19, v21

    move-object/from16 v13, v22

    move/from16 v6, v24

    move/from16 v8, v25

    .line 1022
    add-int v14, v41, v12

    move-object/from16 v36, v5

    move/from16 v24, v6

    move/from16 v25, v8

    move-object v15, v13

    move v5, v14

    move-object/from16 v13, v17

    move/from16 v8, v18

    move/from16 v6, v19

    move-object/from16 v14, v23

    goto :goto_1f

    .line 1093
    :catchall_4
    move-exception v0

    move-object/from16 v5, v36

    goto/16 :goto_2a

    .line 1027
    :cond_38
    move/from16 v19, v6

    move/from16 v18, v8

    move-object/from16 v23, v14

    move-object v13, v15

    move/from16 v6, v24

    move/from16 v8, v25

    move-object/from16 v5, v36

    invoke-static {v13, v6, v8}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object v12

    move/from16 v22, v6

    move-object/from16 v20, v12

    move-object/from16 v21, v23

    move/from16 v23, v8

    goto :goto_20

    .line 1015
    :cond_39
    move/from16 v19, v6

    move/from16 v18, v8

    .line 1029
    const/16 v20, 0x0

    const/16 v21, 0x0

    const/16 v22, 0x0

    const/16 v23, 0x0

    :goto_20
    nop

    .line 1030
    nop

    .line 1031
    nop

    .line 1032
    nop

    .line 1033
    if-eqz v33, :cond_3a

    if-eqz v20, :cond_3a

    const/16 v24, 0x1

    goto :goto_21

    :cond_3a
    const/16 v24, 0x0

    .line 1034
    :goto_21
    nop

    .line 1035
    nop

    .line 1036
    nop

    .line 1037
    if-nez v24, :cond_3b

    if-nez v32, :cond_3b

    if-nez v28, :cond_3b

    if-nez v26, :cond_3b

    if-nez v30, :cond_3b

    if-nez v47, :cond_3b

    .line 1038
    invoke-static {v1, v3, v9, v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_6

    .line 1093
    :try_start_16
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1039
    return-void

    .line 1041
    :cond_3b
    if-nez v24, :cond_3c

    if-nez v32, :cond_3c

    if-nez v28, :cond_3c

    if-nez v26, :cond_3c

    move-object v6, v11

    move/from16 v11, v18

    move/from16 v12, v19

    move/from16 v25, v32

    const/4 v8, 0x1

    goto :goto_22

    .line 1042
    :cond_3c
    :try_start_17
    new-instance v15, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;

    move-object/from16 v17, v15

    move/from16 v25, v32

    invoke-direct/range {v17 .. v29}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;-><init>(II[F[FIIZZZFZI)V

    const/16 v13, 0x200

    const/16 v14, 0x18

    move-object v6, v11

    move/from16 v11, v18

    move/from16 v12, v19

    invoke-static/range {v10 .. v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v8

    .line 1046
    :goto_22
    move/from16 v18, v11

    move/from16 v19, v12

    goto :goto_23

    :cond_3d
    move v12, v6

    move-object v6, v11

    move/from16 v25, v32

    move v11, v8

    if-lez v7, :cond_3e

    .line 1047
    new-instance v15, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;

    invoke-direct {v15, v7, v11, v12}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda3;-><init>(III)V

    const/16 v13, 0x200

    const/16 v14, 0x18

    invoke-static/range {v10 .. v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result v8
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_6

    move/from16 v18, v11

    move/from16 v19, v12

    goto :goto_23

    .line 1051
    :cond_3e
    move/from16 v18, v11

    move/from16 v19, v12

    const/4 v8, 0x1

    .line 1053
    :goto_23
    if-nez v8, :cond_3f

    .line 1093
    :try_start_18
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1053
    return-void

    .line 1054
    :cond_3f
    if-eqz v30, :cond_40

    :try_start_19
    iget v8, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v11, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move/from16 v21, v8

    move-object/from16 v17, v10

    move/from16 v22, v11

    move-object/from16 v20, v30

    move/from16 v24, v34

    move/from16 v23, v35

    invoke-static/range {v17 .. v24}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z

    move-result v8
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_6

    move-object/from16 v10, v20

    if-nez v8, :cond_41

    .line 1093
    :try_start_1a
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1056
    return-void

    .line 1054
    :cond_40
    move-object/from16 v10, v30

    .line 1059
    :cond_41
    :try_start_1b
    new-instance v8, Ljava/io/ByteArrayOutputStream;

    array-length v3, v3

    invoke-direct {v8, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1060
    if-eqz v10, :cond_42

    .line 1061
    iget v3, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v11, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    move-object/from16 v12, v49

    invoke-static {v12, v3, v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->adaptGainmap(Landroid/graphics/Gainmap;II)V

    .line 1062
    if-eqz v12, :cond_43

    invoke-virtual {v5, v12}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    goto :goto_24

    .line 1060
    :cond_42
    move-object/from16 v12, v49

    .line 1064
    :cond_43
    :goto_24
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v11, 0x62

    invoke-virtual {v5, v3, v11, v8}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3
    :try_end_1b
    .catchall {:try_start_1b .. :try_end_1b} :catchall_6

    if-nez v3, :cond_44

    .line 1093
    :try_start_1c
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1c
    .catchall {:try_start_1c .. :try_end_1c} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1065
    return-void

    .line 1067
    :cond_44
    :try_start_1d
    invoke-virtual {v8}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 1068
    nop

    .line 1069
    if-eqz v31, :cond_45

    if-eqz v33, :cond_45

    const-string v8, " ltm=1"

    goto :goto_25

    :cond_45
    move-object/from16 v8, v16

    .line 1070
    :goto_25
    if-eqz v31, :cond_46

    if-eqz v28, :cond_46

    if-nez v33, :cond_46

    const-string v11, " backlit=1"

    goto :goto_26

    :cond_46
    move-object/from16 v11, v16

    .line 1071
    :goto_26
    if-eqz v31, :cond_47

    if-eqz v25, :cond_47

    if-nez v33, :cond_47

    const-string v13, " hl=1"

    goto :goto_27

    :cond_47
    move-object/from16 v13, v16

    .line 1072
    :goto_27
    if-eqz v31, :cond_48

    if-eqz v26, :cond_48

    const-string v16, " zsharp=1"

    :cond_48
    move-object/from16 v14, v16

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1073
    if-eqz v9, :cond_4b

    .line 1074
    if-eqz v0, :cond_49

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_49

    .line 1075
    move-object/from16 v8, v48

    invoke-virtual {v9, v8, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1076
    const-string v8, "UserComment"

    invoke-virtual {v9, v8, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1078
    :cond_49
    invoke-static {v9, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 1079
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    array-length v8, v3

    const/high16 v11, 0x10000

    add-int/2addr v8, v11

    invoke-direct {v2, v8}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1080
    new-instance v8, Ljava/io/ByteArrayInputStream;

    invoke-direct {v8, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v11, 0x0

    invoke-virtual {v9, v8, v2, v11}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1081
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 1082
    if-nez v12, :cond_4a

    goto :goto_28

    :cond_4a
    invoke-static {v3, v2}, Lcom/motorola/camera/custom/GainmapJpeg;->withExif([B[B)[B

    move-result-object v2

    :goto_28
    move-object v3, v2

    .line 1084
    :cond_4b
    move-object/from16 v2, v46

    if-eqz v2, :cond_4d

    if-eqz v10, :cond_4d

    .line 1085
    iget v8, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v4, v4, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    invoke-static {v2, v10, v8, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeDepthOriginal(Ljava/nio/ByteBuffer;Lcom/motorola/camera/custom/LookFilterEngine;II)[B

    move-result-object v2
    :try_end_1d
    .catchall {:try_start_1d .. :try_end_1d} :catchall_6

    .line 1086
    if-nez v2, :cond_4c

    .line 1093
    :try_start_1e
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_3

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1086
    return-void

    .line 1087
    :cond_4c
    :try_start_1f
    iget-object v4, v6, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mAuxImages:Ljava/util/HashMap;

    sget-object v6, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;->DEPTH_RENDER_ORIGINAL:Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;

    .line 1088
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 1087
    invoke-virtual {v4, v6, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1090
    :cond_4d
    iget-object v1, v1, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v3}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 1091
    array-length v1, v3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Applied post-pass p="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v3, v45

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " lut="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " bytes="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v2, v50

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_6

    move-object/from16 v1, v44

    :try_start_20
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_20
    .catchall {:try_start_20 .. :try_end_20} :catchall_5

    .line 1093
    :try_start_21
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V

    .line 1094
    goto :goto_2e

    .line 1093
    :catchall_5
    move-exception v0

    goto :goto_2c

    :catchall_6
    move-exception v0

    goto :goto_2a

    :catchall_7
    move-exception v0

    :goto_29
    move-object v5, v10

    :goto_2a
    move-object/from16 v1, v44

    goto :goto_2c

    .line 979
    :cond_4e
    move-object v1, v7

    move-object/from16 v5, v36

    .line 1093
    :goto_2b
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_21
    .catchall {:try_start_21 .. :try_end_21} :catchall_9

    .line 1098
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 979
    return-void

    .line 1093
    :catchall_8
    move-exception v0

    move-object v1, v7

    move-object/from16 v5, v36

    :goto_2c
    :try_start_22
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->recycle()V

    .line 1094
    throw v0
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_9

    .line 1095
    :catchall_9
    move-exception v0

    goto :goto_2d

    :catchall_a
    move-exception v0

    move-object v1, v7

    .line 1096
    :goto_2d
    :try_start_23
    const-string v2, "applyCustomLutIfEnabled failed, keeping original JPEG"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_b

    .line 1098
    :goto_2e
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1099
    nop

    .line 1100
    return-void

    .line 1098
    :catchall_b
    move-exception v0

    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->JPEG_GRADING:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v1}, Ljava/util/concurrent/Semaphore;->release()V

    .line 1099
    throw v0

    .line 867
    :cond_4f
    :goto_2f
    return-void
.end method

.method private static applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z
    .locals 6

    .line 1196
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

    .line 1198
    const/4 p0, 0x0

    return p0

    .line 1200
    :cond_0
    invoke-static {p4}, Lcom/motorola/camera/custom/LookOptics;->needsPass(I)Z

    move-result p0

    if-nez p0, :cond_1

    .line 1201
    const/4 p0, 0x1

    return p0

    .line 1203
    :cond_1
    invoke-static/range {p1 .. p7}, Lcom/motorola/camera/custom/LookOptics;->prepare(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIIFF)Lcom/motorola/camera/custom/LookOptics;

    move-result-object p0

    .line 1204
    new-instance p6, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;

    invoke-direct {p6, p0}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;-><init>(Lcom/motorola/camera/custom/LookOptics;)V

    const/16 p4, 0x200

    const/4 p5, 0x0

    invoke-static/range {p1 .. p6}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z

    move-result p0

    return p0
.end method

.method public static applySessionParameterOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 6

    .line 602
    const-string v0, "CustomImagingBridge"

    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result v2

    invoke-static {v1, p0, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraActive(Landroid/content/Context;Ljava/lang/String;Z)V

    .line 603
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onModeChanged()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 606
    goto :goto_0

    .line 604
    :catchall_0
    move-exception v1

    .line 605
    const-string v2, "TelemetryCollector.onCameraActive skipped"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 607
    :goto_0
    if-eqz p1, :cond_a

    if-nez p0, :cond_0

    goto/16 :goto_3

    .line 609
    :cond_0
    :try_start_1
    invoke-static {p0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->beginSession(Ljava/lang/String;)I

    .line 610
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resetAwbSwitchTracker()V

    .line 612
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 613
    if-nez p0, :cond_1

    return-void

    .line 614
    :cond_1
    const/4 v1, 0x1

    invoke-static {p0, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->getKeyNames(Landroid/hardware/camera2/CameraCharacteristics;Z)Ljava/util/Set;

    move-result-object p0

    .line 615
    invoke-interface {p0}, Ljava/util/Set;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    return-void

    .line 617
    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 618
    const/16 v3, 0x9

    const-string v4, "org.codeaurora.qcamera3.sessionParameters.enableMCTFwithReferenceFrame"

    const/4 v5, 0x0

    if-eq v2, v3, :cond_9

    const/4 v3, 0x4

    if-ne v2, v3, :cond_3

    goto :goto_1

    .line 629
    :cond_3
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isVideoMode()Z

    move-result v3

    if-eqz v3, :cond_5

    .line 630
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isDualCaptureVideoMode()Z

    move-result v2

    if-nez v2, :cond_4

    .line 631
    const-class v2, Ljava/lang/Byte;

    invoke-static {v1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v1

    invoke-static {p1, p0, v4, v2, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 633
    :cond_4
    return-void

    .line 638
    :cond_5
    if-eqz v2, :cond_6

    const/4 v3, 0x3

    if-eq v2, v3, :cond_6

    const/4 v3, 0x5

    if-lt v2, v3, :cond_7

    const/4 v3, 0x7

    if-gt v2, v3, :cond_7

    :cond_6
    move v5, v1

    .line 642
    :cond_7
    if-eqz v5, :cond_8

    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->shouldAllowInSensorCrop()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 643
    const-string v2, "org.codeaurora.qcamera3.sessionParameters.EnableSnapshotOnlyInsensorZoom"

    const-class v3, Ljava/lang/Integer;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {p1, p0, v2, v3, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 647
    :cond_8
    goto :goto_2

    .line 620
    :cond_9
    :goto_1
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableAutoHDR"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 621
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableMFHDR"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 622
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.EnableVSR"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 623
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableMFNRAIDEMode"

    const-class v2, Ljava/lang/Byte;

    invoke-static {v5}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 624
    const-class v1, Ljava/lang/Byte;

    invoke-static {v5}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2

    invoke-static {p1, p0, v4, v1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V

    .line 625
    const-string v1, "org.codeaurora.qcamera3.sessionParameters.enableQLL"

    const-class v2, Ljava/lang/Integer;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1, p0, v1, v2, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->setVendorKeyIfSupported(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/util/Set;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 626
    return-void

    .line 645
    :catchall_1
    move-exception p0

    .line 646
    const-string p1, "applySessionParameterOverrides failed"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 648
    :goto_2
    return-void

    .line 607
    :cond_a
    :goto_3
    return-void
.end method

.method public static applyVideoRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;I)V
    .locals 3

    .line 2059
    if-eqz p1, :cond_a

    if-nez p0, :cond_0

    goto/16 :goto_4

    .line 2061
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2062
    if-nez p0, :cond_1

    return-void

    .line 2064
    :cond_1
    nop

    .line 2065
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Range;

    .line 2066
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2067
    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    .line 2068
    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    if-lez v0, :cond_3

    .line 2069
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    goto :goto_0

    .line 2068
    :cond_3
    const/16 v0, 0x1e

    .line 2072
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoEdgeMode()I

    move-result v1

    .line 2073
    sget-object v2, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v2}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 2074
    invoke-static {v2, v1}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2075
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v2, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2078
    :cond_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoNoiseReductionMode(I)I

    move-result v0

    .line 2079
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [I

    .line 2080
    invoke-static {v1, v0}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 2081
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2084
    :cond_5
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_OPTICAL_STABILIZATION:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [I

    .line 2085
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->LENS_OPTICAL_STABILIZATION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 2086
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

    .line 2087
    :goto_2
    invoke-static {p0, v0, v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldSetVideoOis([ILjava/lang/Integer;Z)Z

    move-result p0

    if-eqz p0, :cond_8

    .line 2088
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->LENS_OPTICAL_STABILIZATION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, p0, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2091
    :cond_8
    const/4 p0, 0x3

    if-ne p2, p0, :cond_9

    .line 2092
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->nextVideoAwbLockOverride()Ljava/lang/Boolean;

    move-result-object p0

    .line 2093
    if-eqz p0, :cond_9

    .line 2094
    sget-object p2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_LOCK:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, p2, p0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2099
    :cond_9
    goto :goto_3

    .line 2097
    :catchall_0
    move-exception p0

    .line 2098
    const-string p1, "CustomImagingBridge"

    const-string p2, "applyVideoRequestOverrides failed"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2100
    :goto_3
    return-void

    .line 2059
    :cond_a
    :goto_4
    return-void
.end method

.method public static applyVideoSnapshotOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 3

    .line 2103
    if-eqz p1, :cond_6

    if-nez p0, :cond_0

    goto :goto_2

    .line 2105
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2106
    if-nez p0, :cond_1

    return-void

    .line 2108
    :cond_1
    nop

    .line 2109
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Range;

    .line 2110
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2111
    invoke-virtual {v0}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    .line 2112
    :cond_2
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    if-lez v0, :cond_3

    .line 2113
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v0

    goto :goto_0

    .line 2112
    :cond_3
    const/16 v0, 0x1e

    .line 2116
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoEdgeMode()I

    move-result v1

    .line 2117
    sget-object v2, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v2}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 2118
    invoke-static {v2, v1}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2119
    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p1, v2, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 2122
    :cond_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoNoiseReductionMode(I)I

    move-result v0

    .line 2123
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [I

    .line 2124
    invoke-static {p0, v0}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result p0

    if-eqz p0, :cond_5

    .line 2125
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, p0, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2129
    :cond_5
    goto :goto_1

    .line 2127
    :catchall_0
    move-exception p0

    .line 2128
    const-string p1, "CustomImagingBridge"

    const-string v0, "applyVideoSnapshotOverrides failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2130
    :goto_1
    return-void

    .line 2103
    :cond_6
    :goto_2
    return-void
.end method

.method private static arraySurface([II)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;
    .locals 1

    .line 1220
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$3;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$3;-><init>([II)V

    return-object v0
.end method

.method public static awaitCameraDataReadyForGallery(Lcom/motorola/camera/CameraData;)V
    .locals 11

    .line 1824
    if-nez p0, :cond_0

    return-void

    .line 1827
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/motorola/camera/CameraData;->getId()J

    move-result-wide v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1830
    nop

    .line 1831
    const-wide/16 v2, 0x0

    cmp-long p0, v0, v2

    if-gtz p0, :cond_1

    return-void

    .line 1835
    :cond_1
    move-wide v4, v2

    .line 1839
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

    .line 1842
    :goto_1
    nop

    .line 1843
    const-string v6, "CustomImagingBridge"

    if-nez p0, :cond_4

    .line 1844
    cmp-long p0, v4, v2

    if-eqz p0, :cond_3

    .line 1845
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v4

    const-wide/32 v4, 0xf4240

    div-long/2addr v2, v4

    .line 1846
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

    .line 1848
    :cond_3
    return-void

    .line 1850
    :cond_4
    cmp-long p0, v4, v2

    if-nez p0, :cond_5

    .line 1851
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    goto :goto_2

    .line 1852
    :cond_5
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v7

    sub-long/2addr v7, v4

    const-wide v9, 0x165a0bc00L

    cmp-long p0, v7, v9

    if-ltz p0, :cond_6

    .line 1853
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

    .line 1854
    return-void

    .line 1857
    :cond_6
    :goto_2
    const-wide/16 v6, 0x23

    :try_start_2
    invoke-static {v6, v7}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0

    .line 1861
    nop

    .line 1862
    goto :goto_0

    .line 1858
    :catch_0
    move-exception p0

    .line 1859
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Thread;->interrupt()V

    .line 1860
    return-void

    .line 1840
    :catchall_0
    move-exception p0

    .line 1841
    return-void

    .line 1828
    :catchall_1
    move-exception p0

    .line 1829
    return-void
.end method

.method private static bitmapSurface(Landroid/graphics/Bitmap;I)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;
    .locals 1

    .line 1209
    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$2;

    invoke-direct {v0, p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge$2;-><init>(Landroid/graphics/Bitmap;I)V

    return-object v0
.end method

.method private static calibratedFocalLengthPx(Ljava/lang/String;F)F
    .locals 3

    .line 1339
    invoke-static {p1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    cmpl-float v0, p1, v1

    if-gtz v0, :cond_0

    goto :goto_0

    .line 1341
    :cond_0
    if-eqz p0, :cond_1

    .line 1342
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 1343
    if-eqz p0, :cond_1

    .line 1344
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_ACTIVE_ARRAY_SIZE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;

    .line 1345
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_PHYSICAL_SIZE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/util/SizeF;

    .line 1346
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    if-lez v1, :cond_1

    if-eqz p0, :cond_1

    .line 1347
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

    .line 1348
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

    .line 1352
    :catchall_0
    move-exception p0

    :cond_1
    nop

    .line 1353
    const/high16 p0, 0x43fa0000    # 500.0f

    mul-float/2addr p1, p0

    return p1

    .line 1339
    :cond_2
    :goto_0
    return v1
.end method

.method private static captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J
    .locals 10

    .line 323
    const-wide/16 v0, 0x0

    if-nez p0, :cond_0

    return-wide v0

    .line 324
    :cond_0
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    const/16 v3, 0x20

    const-wide/32 v4, 0x7fffffff

    const-wide v6, 0xffffffffL

    if-eqz v2, :cond_2

    .line 325
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mSeqId:Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v2, v2, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 326
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    .line 327
    or-long/2addr v2, v6

    .line 328
    cmp-long p0, v2, v0

    if-eqz p0, :cond_1

    goto :goto_0

    :cond_1
    const-wide/16 v2, 0x1

    :goto_0
    return-wide v2

    .line 330
    :cond_2
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v2

    int-to-long v8, v2

    and-long/2addr v6, v8

    .line 331
    iget-wide v8, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mUUID:J

    and-long/2addr v4, v8

    shl-long v2, v4, v3

    or-long/2addr v2, v6

    const-wide/high16 v4, -0x8000000000000000L

    or-long/2addr v2, v4

    .line 332
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

    .line 140
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "/dev/adsprpc-smd"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 141
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v2, :cond_0

    .line 142
    return v0

    .line 144
    :cond_0
    :try_start_1
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 145
    nop

    .line 146
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 145
    const/4 v0, 0x1

    return v0

    .line 146
    :catchall_0
    move-exception v1

    .line 147
    return v0

    .line 149
    :catchall_1
    move-exception v1

    .line 150
    return v0
.end method

.method public static clearStockMeishePhotoFilter()V
    .locals 8

    .line 1939
    :try_start_0
    const-class v0, Lcom/motorola/camera/settings/SettingsManager;

    .line 1940
    const-string v1, "MEISHE_PHOTO_LUT_FILE_NAME"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 1941
    const-string v3, "MCF_MEISHE_EFFECTS_MODE_PHOTO"

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 1942
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

    .line 1943
    const-string v4, "Original"

    filled-new-array {v1, v4}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 1944
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    filled-new-array {v3, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 1945
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 1946
    return-void
.end method

.method public static configureGalleryIntent(Landroid/content/Intent;Z)V
    .locals 1

    .line 1870
    if-eqz p0, :cond_1

    if-eqz p1, :cond_0

    goto :goto_0

    .line 1871
    :cond_0
    const-string p1, "exit_on_swipe"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1872
    return-void

    .line 1870
    :cond_1
    :goto_0
    return-void
.end method

.method private static decodeMutable([B)Landroid/graphics/Bitmap;
    .locals 3

    .line 1163
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 1164
    const/4 v1, 0x1

    iput-boolean v1, v0, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 1165
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 1166
    const/4 v1, 0x0

    array-length v2, p0

    invoke-static {p0, v1, v2, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method static effectPreference(Ljava/lang/String;II)I
    .locals 2

    .line 112
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 113
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 114
    if-ltz p0, :cond_0

    if-gt p0, p2, :cond_0

    move p1, p0

    :cond_0
    return p1

    .line 115
    :catch_0
    move-exception p0

    .line 116
    return p1
.end method

.method private static evaluateAutoPostGates([B)I
    .locals 11

    .line 838
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 839
    const/4 v1, 0x4

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 840
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v1, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 841
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v1, v0}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 842
    if-nez v3, :cond_0

    return v2

    .line 844
    :cond_0
    :try_start_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    .line 845
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    .line 846
    const/16 p0, 0x10

    if-lt v6, p0, :cond_5

    if-ge v10, p0, :cond_1

    goto :goto_0

    .line 847
    :cond_1
    mul-int p0, v6, v10

    new-array v4, p0, [I

    .line 848
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v5, 0x0

    move v9, v6

    invoke-virtual/range {v3 .. v10}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 849
    nop

    .line 850
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoLtmGate([II)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 851
    const/4 v2, 0x1

    .line 853
    :cond_2
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoHighlightGate([II)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 854
    or-int/lit8 v2, v2, 0x2

    .line 856
    :cond_3
    invoke-static {v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->evaluateAutoBacklitSubjectGate([II)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_4

    .line 857
    or-int/lit8 v2, v2, 0x4

    .line 859
    :cond_4
    nop

    .line 861
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 859
    return v2

    .line 861
    :cond_5
    :goto_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 846
    return v2

    .line 861
    :catchall_0
    move-exception v0

    move-object p0, v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 862
    throw p0
.end method

.method public static evaluateFrontAfTimeout(Ljava/lang/String;Landroid/hardware/camera2/TotalCaptureResult;)I
    .locals 3

    .line 1963
    const/4 p0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result v0

    .line 1964
    if-eqz v0, :cond_7

    if-nez p1, :cond_0

    goto :goto_4

    .line 1965
    :cond_0
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1966
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {p1, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    .line 1967
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    :cond_1
    move v0, p0

    .line 1968
    :goto_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    goto :goto_1

    :cond_2
    move p1, p0

    .line 1969
    :goto_1
    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/motorola/camera/custom/FrontAfHelper;->applies(ZI)Z

    move-result v2

    if-nez v2, :cond_3

    return p0

    .line 1970
    :cond_3
    invoke-static {v1, v0}, Lcom/motorola/camera/custom/FrontAfHelper;->noteResult(ZI)I

    .line 1971
    invoke-static {v1, v0, p1}, Lcom/motorola/camera/custom/FrontAfHelper;->shouldCompleteCurrent(ZII)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_4

    .line 1972
    return v1

    .line 1974
    :cond_4
    const/4 v0, 0x2

    if-eq p1, v0, :cond_6

    const/4 v1, 0x4

    if-ne p1, v1, :cond_5

    goto :goto_2

    .line 1975
    :cond_5
    goto :goto_3

    :cond_6
    :goto_2
    move p0, v0

    .line 1974
    :goto_3
    return p0

    .line 1964
    :cond_7
    :goto_4
    return p0

    .line 1976
    :catchall_0
    move-exception p1

    .line 1977
    return p0
.end method

.method public static exportCleanBayerJpeg(Ljava/nio/ByteBuffer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 10

    .line 1538
    if-eqz p0, :cond_b

    if-eqz p1, :cond_b

    if-eqz p3, :cond_b

    if-nez p2, :cond_0

    goto/16 :goto_6

    .line 1539
    :cond_0
    iget v2, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    .line 1540
    iget v3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    .line 1541
    invoke-static {p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v6

    .line 1542
    iget-object v0, v6, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v1, 0x6

    aget v0, v0, v1

    if-nez v0, :cond_1

    return-void

    .line 1543
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

    .line 1548
    :cond_2
    const-wide/16 v4, 0x5

    mul-long/2addr v0, v4

    const-wide/16 v4, 0x4

    :try_start_0
    div-long/2addr v0, v4

    .line 1549
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

    .line 1550
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

    .line 1551
    return-void

    .line 1553
    :cond_3
    iget-object v0, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    .line 1554
    if-eqz v0, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v1, :cond_9

    iget-object v1, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v1, v1, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    if-nez v1, :cond_4

    goto/16 :goto_3

    .line 1555
    :cond_4
    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v0, v0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->asSharedMediaFile()Lcom/motorola/camera/storage/backend/MediaStoreFile;

    move-result-object v0

    .line 1556
    if-eqz v0, :cond_8

    iget-object v1, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    if-nez v1, :cond_5

    goto :goto_2

    .line 1558
    :cond_5
    iget-object v1, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v1, :cond_6

    iget-object p3, p3, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p3}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_6
    const-string p3, "IMG_CLEAN"

    .line 1559
    :goto_0
    const-string v1, ".dng"

    invoke-virtual {p3, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v4, "_CLEAN.jpg"

    if-eqz v1, :cond_7

    .line 1560
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

    .line 1561
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

    .line 1562
    :goto_1
    iget-object p3, v0, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-virtual {p3, v7}, Lcom/motorola/camera/storage/MediaFilePath;->withFileName(Ljava/lang/String;)Lcom/motorola/camera/storage/MediaFilePath;

    move-result-object v8

    .line 1563
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v1

    .line 1565
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_POOL:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v8}, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;-><init>([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    invoke-interface {p0, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1569
    goto :goto_4

    .line 1556
    :cond_8
    :goto_2
    return-void

    .line 1554
    :cond_9
    :goto_3
    return-void

    .line 1567
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 1568
    const-string p1, "exportCleanBayerJpeg dispatch failed (DNG unaffected)"

    invoke-static {v9, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1570
    :goto_4
    return-void

    .line 1544
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

    .line 1545
    return-void

    .line 1538
    :cond_b
    :goto_6
    return-void
.end method

.method private static extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 2151
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    .line 2152
    :cond_0
    const/4 p1, 0x0

    if-eqz p0, :cond_4

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-nez v0, :cond_1

    goto :goto_0

    .line 2153
    :cond_1
    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v0, v0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object v0, v0, Lcom/motorola/camera/saving/ImageDataHolder;->mCameraId:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 2154
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object p0, p0, Lcom/motorola/camera/saving/ImageDataHolder;->mCameraId:Ljava/lang/String;

    return-object p0

    .line 2156
    :cond_2
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 2157
    if-eqz p0, :cond_3

    iget-object v0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCameraId:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object p0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mCameraId:Ljava/lang/String;

    return-object p0

    .line 2159
    :cond_3
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2160
    :catchall_0
    move-exception p0

    .line 2161
    return-object p1

    .line 2152
    :cond_4
    :goto_0
    return-object p1
.end method

.method private static extractCaptureResult(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Landroid/hardware/camera2/TotalCaptureResult;
    .locals 4

    .line 2133
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-nez v1, :cond_0

    goto :goto_1

    .line 2134
    :cond_0
    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v1, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object v1, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object v1, v1, Lcom/motorola/camera/saving/ImageDataHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v1, :cond_1

    .line 2135
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mImageDataHolder:Lcom/motorola/camera/saving/ImageDataHolder;

    iget-object p0, p0, Lcom/motorola/camera/saving/ImageDataHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    return-object p0

    .line 2137
    :cond_1
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    .line 2138
    instance-of v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v1, :cond_3

    .line 2139
    check-cast p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 2140
    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    if-eqz v1, :cond_3

    .line 2141
    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    :goto_0
    if-ltz v1, :cond_3

    .line 2142
    iget-object v2, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mCaptureHolders:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/motorola/camera/saving/CaptureHolder;

    .line 2143
    if-eqz v2, :cond_2

    iget-object v3, v2, Lcom/motorola/camera/saving/CaptureHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    if-eqz v3, :cond_2

    iget-object p0, v2, Lcom/motorola/camera/saving/CaptureHolder;->mResult:Landroid/hardware/camera2/TotalCaptureResult;

    return-object p0

    .line 2141
    :cond_2
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 2147
    :cond_3
    return-object v0

    .line 2133
    :cond_4
    :goto_1
    return-object v0
.end method

.method private static extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F
    .locals 4

    .line 1766
    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 1767
    :cond_0
    const/16 v0, 0x9

    new-array v1, v0, [Landroid/util/Rational;

    .line 1768
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 1769
    new-array p0, v0, [F

    .line 1770
    nop

    :goto_0
    if-ge v2, v0, :cond_3

    .line 1771
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

    .line 1770
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1773
    :cond_3
    return-object p0
.end method

.method private static extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 2246
    nop

    .line 2247
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    if-eqz p0, :cond_1

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v0, :cond_1

    .line 2248
    iget-object p1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p1}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p1

    .line 2250
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

    .line 2253
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object p0, p0, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {p0}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object p1

    .line 2255
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

    .line 558
    if-nez p0, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object p0

    return-object p0

    .line 559
    :cond_0
    if-eqz p1, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->SES_KEY_CACHE:Ljava/util/Map;

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->REQ_KEY_CACHE:Ljava/util/Map;

    .line 560
    :goto_0
    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 561
    if-eqz v1, :cond_2

    return-object v1

    .line 562
    :cond_2
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 563
    nop

    .line 565
    const/4 v2, 0x0

    if-eqz p1, :cond_3

    .line 566
    :try_start_0
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableSessionKeys()Ljava/util/List;

    move-result-object v3

    goto :goto_1

    .line 567
    :cond_3
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraCharacteristics;->getAvailableCaptureRequestKeys()Ljava/util/List;

    move-result-object v3

    .line 568
    :goto_1
    if-eqz v3, :cond_5

    .line 569
    nop

    .line 570
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

    .line 571
    if-eqz v4, :cond_4

    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_4

    .line 572
    invoke-virtual {v4}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 574
    :cond_4
    goto :goto_2

    .line 576
    :catchall_0
    move-exception v3

    :cond_5
    nop

    .line 577
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    .line 578
    if-eqz v2, :cond_7

    if-eqz p1, :cond_6

    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_7

    .line 579
    :cond_6
    invoke-interface {v0, p0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 581
    :cond_7
    return-object v1
.end method

.method private static getOrComputeDecision(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 5

    .line 423
    if-nez p0, :cond_1

    .line 424
    nop

    .line 425
    if-nez p1, :cond_0

    .line 427
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 428
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_0

    .line 430
    :cond_0
    :goto_1
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0

    .line 432
    :cond_1
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->captureKey(Lcom/motorola/camera/fsm/camera/record/CaptureRecord;)J

    move-result-wide v0

    .line 433
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    monitor-enter v2

    .line 434
    :try_start_1
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 435
    if-eqz v3, :cond_2

    .line 436
    monitor-exit v2

    return-object v3

    .line 438
    :cond_2
    sget-object v3, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    .line 439
    if-eqz v3, :cond_3

    .line 440
    sget-object p1, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p1, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 441
    monitor-exit v2

    return-object v3

    .line 443
    :cond_3
    nop

    .line 444
    nop

    .line 445
    instance-of v3, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    if-eqz v3, :cond_5

    .line 446
    move-object v3, p0

    check-cast v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;

    .line 447
    if-nez p1, :cond_4

    iget-object p1, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mSceneMode:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    .line 448
    :cond_4
    iget-boolean v3, v3, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mIsFlash:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-eqz v3, :cond_5

    const/4 p2, 0x1

    .line 450
    :cond_5
    if-nez p1, :cond_6

    .line 452
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 453
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v3

    goto :goto_2

    .line 455
    :cond_6
    :goto_3
    :try_start_3
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 456
    sget-object p2, Lcom/motorola/camera/custom/CustomImagingBridge;->RECORD_DECISIONS:Ljava/util/Map;

    invoke-interface {p2, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 457
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->SHOT_CACHE:Ljava/util/Map;

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-interface {p0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 458
    monitor-exit v2

    return-object p1

    .line 459
    :catchall_2
    move-exception p0

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw p0
.end method

.method private static getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 3

    .line 463
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    iget-object v1, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v1, :cond_0

    .line 464
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    iget-object p0, p0, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    goto :goto_0

    .line 465
    :cond_0
    move-object p0, v0

    .line 466
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

    .line 280
    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 281
    :goto_0
    nop

    .line 282
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    .line 283
    const/4 v0, 0x0

    move v1, v0

    :goto_1
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    .line 284
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    aget-object v2, v2, v1

    invoke-interface {v2, p1}, Ljava/lang/CharSequence;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 285
    nop

    .line 286
    goto :goto_2

    .line 283
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    move v1, v0

    .line 289
    :goto_2
    if-eqz p0, :cond_4

    .line 290
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    .line 291
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

    .line 292
    :goto_3
    if-eqz p0, :cond_4

    .line 293
    invoke-virtual {p1, p0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    .line 294
    if-eqz p0, :cond_4

    array-length p1, p0

    if-ge v1, p1, :cond_4

    .line 295
    aget-object p0, p0, v1

    return-object p0

    .line 299
    :cond_4
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    aget-object p0, p0, v1

    invoke-interface {p0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p0

    .line 300
    const/16 p1, 0x28

    invoke-virtual {p0, p1}, Ljava/lang/String;->indexOf(I)I

    move-result p1

    .line 301
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

    .line 306
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 307
    if-nez v1, :cond_0

    return v0

    .line 308
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

    .line 309
    :catchall_0
    move-exception v1

    .line 310
    return v0
.end method

.method private static gradeDepthOriginal(Ljava/nio/ByteBuffer;Lcom/motorola/camera/custom/LookFilterEngine;II)[B
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1171
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object p0

    .line 1172
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->decodeMutable([B)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 1173
    const/4 v0, 0x0

    if-nez v1, :cond_0

    return-object v0

    .line 1175
    :cond_0
    :try_start_0
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_1

    .line 1189
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1175
    return-object v0

    .line 1176
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

    .line 1177
    :goto_0
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    .line 1178
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

    .line 1189
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1178
    return-object v0

    .line 1179
    :cond_3
    :try_start_2
    invoke-static {v2, v7, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->adaptGainmap(Landroid/graphics/Gainmap;II)V

    .line 1180
    if-eqz v2, :cond_4

    invoke-virtual {v1, v2}, Landroid/graphics/Bitmap;->setGainmap(Landroid/graphics/Gainmap;)V

    .line 1181
    :cond_4
    new-instance p1, Ljava/io/ByteArrayOutputStream;

    array-length p2, p0

    invoke-direct {p1, p2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1182
    sget-object p2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 p3, 0x62

    invoke-virtual {v1, p2, p3, p1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result p2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez p2, :cond_5

    .line 1189
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1182
    return-object v0

    .line 1183
    :cond_5
    :try_start_3
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    .line 1184
    new-instance p2, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance p3, Ljava/io/ByteArrayInputStream;

    invoke-direct {p3, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {p2, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 1185
    new-instance p0, Ljava/io/ByteArrayOutputStream;

    array-length p3, p1

    invoke-direct {p0, p3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1186
    new-instance p3, Ljava/io/ByteArrayInputStream;

    invoke-direct {p3, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v0, 0x0

    invoke-virtual {p2, p3, p0, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1187
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

    .line 1189
    :goto_1
    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1187
    return-object p0

    .line 1189
    :catchall_0
    move-exception v0

    move-object p0, v0

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 1190
    throw p0
.end method

.method public static gradePixelBufferStrips([IIIIII)Z
    .locals 6

    .line 1322
    if-eqz p0, :cond_2

    if-lez p1, :cond_2

    if-lez p2, :cond_2

    if-lez p3, :cond_2

    if-gtz p5, :cond_0

    goto :goto_0

    .line 1323
    :cond_0
    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_1

    const/4 p0, 0x0

    return p0

    .line 1324
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

    .line 1322
    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private static gradeSurfaceInBatches(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIILcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;)Z
    .locals 26

    .line 1245
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

    .line 1246
    :cond_0
    const/4 v4, 0x0

    move/from16 v5, p4

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 1248
    new-instance v6, Ljava/util/ArrayList;

    const/4 v7, 0x4

    invoke-direct {v6, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1249
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1250
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1251
    nop

    .line 1252
    nop

    .line 1253
    nop

    .line 1255
    move v13, v1

    move v11, v4

    move v14, v11

    const/4 v12, 0x0

    :goto_0
    if-ge v11, v1, :cond_9

    .line 1256
    sub-int v15, v1, v11

    invoke-static {v2, v15}, Ljava/lang/Math;->min(II)I

    move-result v15

    .line 1257
    sub-int v10, v11, v5

    invoke-static {v4, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 1258
    const/16 v22, 0x1

    add-int v3, v11, v15

    add-int v7, v3, v5

    invoke-static {v1, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 1259
    sub-int v4, v7, v10

    .line 1260
    sub-int v16, v11, v10

    mul-int v2, v16, p1

    .line 1261
    move/from16 v24, v14

    mul-int v14, p1, v4

    new-array v14, v14, [I

    .line 1262
    move/from16 v25, v5

    const/4 v5, 0x0

    invoke-interface {v0, v10, v4, v14, v5}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    .line 1264
    if-eqz v12, :cond_2

    add-int v5, v13, v24

    if-ge v10, v5, :cond_2

    .line 1265
    invoke-static {v10, v13}, Ljava/lang/Math;->max(II)I

    move-result v16

    .line 1266
    invoke-static {v7, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 1267
    sub-int v5, v5, v16

    .line 1268
    if-lez v5, :cond_1

    .line 1269
    sub-int v7, v16, v13

    mul-int v7, v7, p1

    sub-int v16, v16, v10

    move/from16 v20, v4

    mul-int v4, v16, p1

    mul-int v5, v5, p1

    invoke-static {v12, v7, v14, v4, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    goto :goto_1

    .line 1268
    :cond_1
    move/from16 v20, v4

    goto :goto_1

    .line 1264
    :cond_2
    move/from16 v20, v4

    .line 1275
    :goto_1
    invoke-interface {v6, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1276
    filled-new-array {v11, v15, v2}, [I

    move-result-object v2

    invoke-interface {v8, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1277
    nop

    .line 1278
    nop

    .line 1279
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

    .line 1282
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

    .line 1283
    :goto_3
    if-eqz v2, :cond_8

    .line 1284
    nop

    .line 1285
    nop

    .line 1286
    nop

    .line 1287
    nop

    .line 1288
    if-ge v3, v1, :cond_5

    if-lez v25, :cond_5

    .line 1289
    move/from16 v2, v25

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 1290
    sub-int/2addr v3, v5

    .line 1291
    mul-int v7, p1, v5

    new-array v7, v7, [I

    .line 1292
    const/4 v10, 0x0

    invoke-interface {v0, v3, v5, v7, v10}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    move v14, v5

    move-object v12, v7

    move v13, v3

    goto :goto_4

    .line 1288
    :cond_5
    move/from16 v2, v25

    .line 1294
    const/4 v12, 0x0

    const/4 v14, 0x0

    move v13, v3

    :goto_4
    const/4 v5, 0x0

    :goto_5
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v3

    if-ge v5, v3, :cond_7

    .line 1296
    :try_start_0
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/concurrent/Future;

    invoke-interface {v3}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1305
    nop

    .line 1306
    invoke-interface {v8, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 1307
    const/16 v23, 0x0

    aget v7, v3, v23

    aget v10, v3, v22

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, [I

    const/16 v16, 0x2

    aget v3, v3, v16

    invoke-interface {v0, v7, v10, v15, v3}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->writeRows(II[II)V

    .line 1294
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .line 1303
    :catch_0
    move-exception v0

    .line 1304
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-virtual {v0}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 1297
    :catch_1
    move-exception v0

    .line 1298
    add-int/lit8 v5, v5, 0x1

    :goto_6
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v0

    if-ge v5, v0, :cond_6

    .line 1299
    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/Future;

    move/from16 v1, v22

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 1298
    add-int/lit8 v5, v5, 0x1

    const/16 v22, 0x1

    goto :goto_6

    .line 1301
    :cond_6
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 1302
    const/16 v23, 0x0

    return v23

    .line 1309
    :cond_7
    const/16 v23, 0x0

    .line 1310
    nop

    .line 1311
    nop

    .line 1312
    invoke-interface {v6}, Ljava/util/List;->clear()V

    .line 1313
    invoke-interface {v8}, Ljava/util/List;->clear()V

    .line 1314
    invoke-interface {v9}, Ljava/util/List;->clear()V

    goto :goto_7

    .line 1283
    :cond_8
    move/from16 v2, v25

    const/16 v23, 0x0

    move/from16 v14, v24

    .line 1255
    :goto_7
    add-int v11, v11, p3

    move v5, v2

    move v7, v4

    move/from16 v4, v23

    move/from16 v2, p3

    goto/16 :goto_0

    .line 1317
    :cond_9
    const/16 v22, 0x1

    return v22

    .line 1245
    :cond_a
    const/16 v22, 0x1

    :goto_8
    return v22
.end method

.method public static initPostProcPreference(Landroidx/preference/PreferenceFragmentCompat;)V
    .locals 6

    .line 252
    const-string v0, "com.motorola.camera.post_processing_profile"

    if-nez p0, :cond_0

    return-void

    .line 254
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v1

    check-cast v1, Landroidx/preference/ListPreference;

    .line 255
    if-nez v1, :cond_1

    return-void

    .line 256
    :cond_1
    invoke-virtual {p0}, Landroidx/preference/PreferenceFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Landroidx/preference/PreferenceFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object p0

    goto :goto_0

    :cond_2
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 257
    :goto_0
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 258
    if-eqz p0, :cond_4

    .line 259
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    .line 260
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

    .line 261
    :goto_1
    if-eqz p0, :cond_4

    .line 262
    invoke-virtual {v3, p0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    .line 263
    if-eqz p0, :cond_4

    array-length v3, p0

    sget-object v4, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    array-length v4, v4

    if-ne v3, v4, :cond_4

    .line 264
    move-object v2, p0

    .line 268
    :cond_4
    invoke-virtual {v1, v2}, Landroidx/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 269
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    iput-object p0, v1, Landroidx/preference/ListPreference;->mEntryValues:[Ljava/lang/CharSequence;

    .line 270
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 271
    const-string v2, "0"

    if-eqz p0, :cond_5

    :try_start_1
    invoke-interface {p0, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_5
    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->parseProfileIndex(Ljava/lang/String;)I

    move-result p0

    .line 272
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V

    .line 273
    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result p0

    invoke-static {p0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 276
    goto :goto_2

    .line 274
    :catchall_0
    move-exception p0

    .line 275
    const-string v0, "CustomImagingBridge"

    const-string v1, "initPostProcPreference failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 277
    :goto_2
    return-void
.end method

.method public static initializeEffects(Landroid/content/Context;)V
    .locals 3

    .line 96
    sput-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 97
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V

    .line 98
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object p0

    .line 99
    new-instance v0, Ljava/io/File;

    const-string v1, "look-shader-v2-1.9.2"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 100
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_2

    .line 101
    new-instance v1, Ljava/io/File;

    const-string v2, "shader-cache.bin"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 103
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

    .line 106
    :cond_1
    goto :goto_0

    .line 104
    :catch_0
    move-exception p0

    .line 108
    :cond_2
    :goto_0
    return-void
.end method

.method public static isCustomLutActive()Z
    .locals 1

    .line 771
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecisionForActiveScene(Z)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z

    move-result v0

    return v0
.end method

.method public static isCustomLutActive(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Z
    .locals 1

    .line 775
    if-eqz p0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 776
    const/4 p0, 0x0

    return p0

    .line 778
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getOrResolveForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z

    move-result p0

    return p0
.end method

.method private static isFlashExpectedSafe()Z
    .locals 1

    .line 337
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->isFlashExpected()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 338
    :catchall_0
    move-exception v0

    .line 339
    const/4 v0, 0x0

    return v0
.end method

.method private static isFrontCameraId(Ljava/lang/String;)Z
    .locals 1

    .line 2174
    const-string v0, "1"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    .line 2176
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p0

    .line 2177
    :catchall_0
    move-exception p0

    .line 2178
    const/4 p0, 0x0

    return p0
.end method

.method public static isHdr10AvailableForCurrentFps()Z
    .locals 8

    .line 1923
    const/4 v0, 0x1

    :try_start_0
    const-class v1, Lcom/motorola/camera/settings/SettingsManager;

    .line 1924
    const-string v2, "VIDEO_FRAME_RATE"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 1925
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 1926
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

    .line 1927
    if-eqz v1, :cond_0

    .line 1928
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "mValue"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 1929
    instance-of v2, v1, Ljava/lang/Integer;

    if-eqz v2, :cond_0

    .line 1930
    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldDisableHdr10ForFps(I)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    xor-int/2addr v0, v1

    return v0

    .line 1933
    :catchall_0
    move-exception v1

    :cond_0
    nop

    .line 1934
    return v0
.end method

.method private static isRealtimeTimestampClock(Ljava/lang/String;)Z
    .locals 2

    .line 2183
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 2185
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2186
    if-nez p0, :cond_1

    return v0

    .line 2187
    :cond_1
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_TIMESTAMP_SOURCE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Integer;

    .line 2188
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

    .line 2189
    :catchall_0
    move-exception p0

    .line 2190
    return v0
.end method

.method private static isUiSpecialModeSafe()Z
    .locals 2

    .line 345
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

    .line 346
    :catchall_0
    move-exception v1

    .line 347
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

    .line 1197
    const/4 p5, 0x0

    mul-int/2addr p3, p4

    invoke-virtual {p0, p2, p5, p3, p1}, Lcom/motorola/camera/custom/LookFilterEngine;->apply([IIII)V

    return-void
.end method

.method static synthetic lambda$applyLook$3(Lcom/motorola/camera/custom/LookOptics;[IIII)V
    .locals 0

    .line 1205
    invoke-virtual {p0, p1, p3, p4}, Lcom/motorola/camera/custom/LookOptics;->apply([III)V

    return-void
.end method

.method static synthetic lambda$exportCleanBayerJpeg$6([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 0

    .line 1566
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    return-void
.end method

.method static synthetic lambda$gradePixelBufferStrips$5(III[IIII)V
    .locals 1

    .line 1335
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

    .line 1280
    invoke-interface {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;->processStrip([IIII)V

    return-void
.end method

.method private static latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;
    .locals 1

    .line 2260
    invoke-static {p0, p2}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 2261
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_0

    goto :goto_0

    .line 2262
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

    .line 2261
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

    .line 121
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    .line 122
    if-eqz p0, :cond_3

    if-nez v1, :cond_0

    goto :goto_2

    .line 123
    :cond_0
    sget v2, Lcom/motorola/camera/custom/CustomImagingBridge;->loadedLook:I

    if-eq v2, p0, :cond_2

    .line 124
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

    .line 125
    :try_start_1
    invoke-static {v1}, Lcom/motorola/camera/custom/LookFilterEngine;->read(Ljava/io/InputStream;)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v2

    sput-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->cachedLook:Lcom/motorola/camera/custom/LookFilterEngine;

    .line 126
    sput p0, Lcom/motorola/camera/custom/CustomImagingBridge;->loadedLook:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 127
    if-eqz v1, :cond_2

    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    .line 124
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

    .line 129
    :cond_2
    :goto_1
    sget-object p0, Lcom/motorola/camera/custom/CustomImagingBridge;->cachedLook:Lcom/motorola/camera/custom/LookFilterEngine;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    monitor-exit v0

    return-object p0

    .line 122
    :cond_3
    :goto_2
    monitor-exit v0

    const/4 p0, 0x0

    return-object p0

    .line 120
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

    .line 1158
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

    .line 1159
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

    .line 1160
    :cond_0
    return-void
.end method

.method public static noteRawImageAvailable(JLjava/nio/ByteBuffer;)V
    .locals 14

    .line 1402
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-lez v0, :cond_4

    if-nez p2, :cond_0

    goto :goto_2

    .line 1404
    :cond_0
    :try_start_0
    invoke-virtual/range {p2 .. p2}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 1405
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    .line 1406
    if-lez v1, :cond_3

    const/high16 v4, 0x2000000

    if-le v1, v4, :cond_1

    goto :goto_0

    .line 1407
    :cond_1
    new-array v11, v1, [B

    .line 1408
    invoke-virtual {v0, v11}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1409
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId()Ljava/lang/String;

    move-result-object v0

    .line 1410
    if-nez v0, :cond_2

    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object v0

    :cond_2
    move-object v1, v0

    .line 1411
    const-wide/32 v4, 0x1fca055

    invoke-static {p0, p1, v4, v5}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v8

    .line 1413
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->currentSessionGeneration()I

    move-result v0

    .line 1412
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

    .line 1406
    :cond_3
    :goto_0
    return-void

    .line 1415
    :catchall_0
    move-exception v0

    :goto_1
    nop

    .line 1416
    return-void

    .line 1402
    :cond_4
    :goto_2
    return-void
.end method

.method public static noteZslCaptureCompleted(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
    .locals 21

    .line 1357
    move-object/from16 v0, p1

    if-nez v0, :cond_0

    return-void

    .line 1359
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isVideoMode()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1360
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LOGICAL_MULTI_CAMERA_ACTIVE_PHYSICAL_ID:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1361
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 1362
    invoke-static {v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->onVideoFramePhysicalCamera(Ljava/lang/String;)V

    .line 1365
    :cond_1
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    .line 1366
    sget-object v2, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v2}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    .line 1367
    sget-object v3, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v3}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    .line 1368
    sget-object v4, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v4}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Float;

    .line 1369
    if-eqz v1, :cond_a

    if-eqz v2, :cond_a

    if-eqz v3, :cond_a

    if-nez v4, :cond_2

    goto/16 :goto_5

    .line 1370
    :cond_2
    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    .line 1371
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    .line 1372
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v11

    .line 1373
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->activeCameraId()Ljava/lang/String;

    move-result-object v1

    .line 1374
    if-nez v1, :cond_3

    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraId()Ljava/lang/String;

    move-result-object v1

    :cond_3
    move-object v6, v1

    .line 1375
    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v6, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v12

    .line 1376
    invoke-static {v7, v8, v9, v10}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v13

    .line 1377
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_FOCUS_DISTANCE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    .line 1378
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

    .line 1379
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->CONTROL_AF_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 1380
    const/4 v2, 0x0

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    move/from16 v19, v1

    goto :goto_1

    :cond_5
    move/from16 v19, v2

    .line 1381
    :goto_1
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 1382
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    move/from16 v20, v1

    goto :goto_2

    :cond_6
    move/from16 v20, v2

    .line 1383
    :goto_2
    nop

    .line 1384
    if-eqz p0, :cond_7

    invoke-virtual/range {p0 .. p0}, Landroid/hardware/camera2/CaptureRequest;->getTag()Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    if-eqz v1, :cond_7

    .line 1385
    invoke-virtual/range {p0 .. p0}, Landroid/hardware/camera2/CaptureRequest;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;

    iget v1, v1, Lcom/motorola/camera/fsm/camera/record/SequenceIdentifier;->mSeqId:I

    int-to-long v3, v1

    move-wide v14, v3

    goto :goto_3

    .line 1388
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

    .line 1387
    const/16 v16, 0x0

    invoke-static/range {v5 .. v20}, Lcom/motorola/camera/custom/MultiFrameBurstController;->noteSessionMetadata(ILjava/lang/String;JJIFFJZZFII)V

    .line 1391
    sget-object v1, Landroid/hardware/camera2/CaptureResult;->LENS_APERTURE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v1}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 1392
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

    .line 1393
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    goto :goto_4

    :cond_9
    const v0, 0x3fcccccd    # 1.6f

    .line 1394
    :goto_4
    invoke-static {v9, v10, v11, v0}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeEv100(JIF)D

    move-result-wide v0

    .line 1395
    invoke-static {v0, v1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 1396
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassHudController;->updateLatestEv100(D)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_6

    .line 1369
    :cond_a
    :goto_5
    return-void

    .line 1398
    :catchall_0
    move-exception v0

    :cond_b
    :goto_6
    nop

    .line 1399
    return-void
.end method

.method public static onCameraActivityResumed()V
    .locals 1

    .line 1876
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onResume()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1877
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1878
    :goto_1
    return-void
.end method

.method public static onCameraPaused()V
    .locals 1

    .line 1882
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->onPause()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1883
    :goto_0
    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1885
    :goto_1
    :try_start_1
    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector;->onCameraPaused()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1886
    :goto_2
    goto :goto_3

    :catchall_1
    move-exception v0

    goto :goto_2

    .line 1887
    :goto_3
    return-void
.end method

.method public static onFactoryResetPreferences()V
    .locals 3

    .line 1907
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->onSessionResetKeepLastModeOff()V

    .line 1909
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 1910
    if-eqz v0, :cond_0

    .line 1911
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.motorola.camera.post_processing_profile"

    const-string v2, "0"

    .line 1912
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "port_compass_hud"

    .line 1913
    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 1914
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1916
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V

    .line 1917
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 1918
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 1919
    return-void
.end method

.method public static onFrontAfCaptureEnd()V
    .locals 0

    .line 1953
    invoke-static {}, Lcom/motorola/camera/custom/FrontAfHelper;->endCapture()V

    .line 1954
    return-void
.end method

.method public static onFrontAfCaptureStart()V
    .locals 0

    .line 1949
    invoke-static {}, Lcom/motorola/camera/custom/FrontAfHelper;->beginCapture()V

    .line 1950
    return-void
.end method

.method public static onSessionResetKeepLastModeOff()V
    .locals 3

    .line 1891
    const-string v0, "0"

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 1892
    if-eqz v1, :cond_0

    .line 1893
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "com.motorola.camera.look_preset"

    .line 1894
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "com.motorola.camera.bokeh_style"

    .line 1895
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.motorola.camera.look_intensity"

    const-string v2, "100"

    .line 1896
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 1897
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1899
    :cond_0
    const/16 v0, 0x64

    const/4 v1, 0x0

    invoke-static {v1, v0}, Lcom/motorola/camera/custom/LiveLookPreview;->select(II)V

    .line 1900
    invoke-static {v1}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 1901
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->refreshPreview()V

    .line 1902
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 1903
    :catchall_0
    move-exception v0

    :goto_0
    nop

    .line 1904
    return-void
.end method

.method public static overrideSceneMode(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)Lcom/motorola/camera/mcf/Mcf$SceneMode;
    .locals 3

    .line 471
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 472
    return-object p0

    .line 474
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

    .line 475
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v2

    .line 476
    invoke-static {p0, p1, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p1

    .line 477
    iget-object v2, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget v2, v2, v1

    if-ne v2, v0, :cond_3

    .line 478
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->HAL_FRAME_STACK:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    return-object p0

    .line 480
    :cond_3
    iget-object p1, p1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    aget p1, p1, v1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_4

    .line 481
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->RAW_HDR:Lcom/motorola/camera/mcf/Mcf$SceneMode;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 485
    :cond_4
    goto :goto_2

    .line 483
    :catchall_0
    move-exception p1

    .line 484
    const-string v0, "CustomImagingBridge"

    const-string v1, "overrideSceneMode fallback"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 486
    :goto_2
    return-object p0
.end method

.method private static parseProfileIndex(Ljava/lang/String;)I
    .locals 2

    .line 242
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 244
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 245
    if-ltz p0, :cond_1

    const/16 v1, 0xa

    if-gt p0, v1, :cond_1

    move v0, p0

    :cond_1
    return v0

    .line 246
    :catchall_0
    move-exception p0

    .line 247
    return v0

    .line 242
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

    .line 1994
    if-eqz p0, :cond_7

    array-length v0, p0

    if-eqz v0, :cond_7

    if-eqz p1, :cond_7

    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 1997
    :cond_0
    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 1998
    array-length v1, p0

    new-array v1, v1, [[I

    .line 1999
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    array-length v4, p0

    if-ge v3, v4, :cond_3

    .line 2000
    aget-object v4, p0, v3

    .line 2001
    if-eqz v4, :cond_2

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-nez v5, :cond_1

    goto :goto_1

    .line 2002
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

    .line 1999
    :cond_2
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2004
    :cond_3
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/VideoConfigHelper;->pickPreferredHfrRange(I[[I)[I

    move-result-object v0

    .line 2005
    if-nez v0, :cond_4

    return-object p1

    .line 2006
    :cond_4
    array-length v1, p0

    move v3, v2

    :goto_2
    if-ge v3, v1, :cond_6

    aget-object v4, p0, v3

    .line 2007
    if-eqz v4, :cond_5

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_5

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_5

    .line 2008
    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    aget v6, v0, v2

    if-ne v5, v6, :cond_5

    .line 2009
    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/4 v6, 0x1

    aget v6, v0, v6

    if-ne v5, v6, :cond_5

    .line 2010
    return-object v4

    .line 2006
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 2013
    :cond_6
    return-object p1

    .line 1995
    :cond_7
    :goto_3
    return-object p1
.end method

.method private static readIsoSafe(Lcom/motorola/camera/photometadata/PhotoMetadata;)I
    .locals 3

    .line 824
    const/16 v0, 0x64

    if-nez p0, :cond_0

    return v0

    .line 826
    :cond_0
    :try_start_0
    const-string v1, "ISOSpeedRatings"

    invoke-virtual {p0, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 827
    if-eqz p0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    .line 828
    :cond_1
    const/16 v1, 0x2c

    invoke-virtual {p0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 829
    if-lez v1, :cond_2

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 830
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 831
    if-lez p0, :cond_3

    move v0, p0

    :cond_3
    return v0

    .line 827
    :cond_4
    :goto_0
    return v0

    .line 832
    :catchall_0
    move-exception p0

    .line 833
    return v0
.end method

.method private static recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    .line 2271
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

    .line 2284
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

    .line 2285
    :goto_0
    move-object/from16 v2, p2

    invoke-static {v0, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCameraId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 2286
    move-object/from16 v4, p5

    invoke-static {v0, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractTelemetryShotId(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 2287
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 2288
    move-object v5, v4

    goto :goto_1

    .line 2289
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

    .line 2290
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

    .line 2291
    sget-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    invoke-interface {v6, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 2292
    if-eqz v6, :cond_2

    .line 2293
    return-object v6

    .line 2295
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

    .line 2297
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode(I)Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    goto :goto_2

    :cond_3
    move/from16 v0, v16

    .line 2298
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

    .line 2299
    :goto_3
    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->isRealtimeTimestampClock(Ljava/lang/String;)Z

    move-result v2

    .line 2300
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->latestMergeGapMs()F

    move-result v8

    .line 2301
    invoke-static {v8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_5

    invoke-static {v8}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v8

    goto :goto_4

    :cond_5
    move-object v8, v6

    .line 2302
    :goto_4
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->latestMergeFocusSpread()F

    move-result v9

    .line 2303
    invoke-static {v9}, Ljava/lang/Float;->isFinite(F)Z

    move-result v10

    if-eqz v10, :cond_6

    invoke-static {v9}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v9

    goto :goto_5

    :cond_6
    move-object v9, v6

    .line 2304
    :goto_5
    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameBurstController;->wasLastMergeMotionRejected()Z

    move-result v10

    if-eqz v10, :cond_7

    sget-object v10, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_6

    :cond_7
    move-object v10, v6

    .line 2305
    :goto_6
    invoke-static {}, Lcom/motorola/camera/custom/VideoConfigHelper;->latestVideoAeUpperFps()I

    move-result v11

    .line 2306
    if-lez v11, :cond_8

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    :cond_8
    move-object v11, v6

    .line 2307
    const/4 v12, 0x0

    move-object/from16 v13, p6

    move-object/from16 v14, p7

    move-object v6, v7

    move v7, v2

    invoke-static/range {v5 .. v14}, Lcom/motorola/camera/custom/TelemetryCollector;->shotMetadata(Ljava/lang/String;Ljava/lang/Float;ZLjava/lang/Float;Ljava/lang/Float;Ljava/lang/Boolean;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;

    move-result-object v2

    move-object v10, v5

    .line 2310
    if-eqz v1, :cond_9

    iget v5, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    move v6, v5

    goto :goto_7

    :cond_9
    move/from16 v6, v16

    .line 2311
    :goto_7
    if-eqz v0, :cond_a

    if-eqz v1, :cond_a

    iget v0, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    move v7, v0

    goto :goto_8

    :cond_a
    move/from16 v7, v16

    .line 2312
    :goto_8
    if-eqz v1, :cond_b

    iget v0, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    goto :goto_9

    :cond_b
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    :goto_9
    move v8, v0

    .line 2313
    invoke-static {v3, v2}, Lcom/motorola/camera/custom/TelemetryCollector;->sampleCompass(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v9

    .line 2314
    if-eqz v9, :cond_c

    .line 2315
    sget-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_COMPASS_CACHE:Ljava/util/Map;

    invoke-interface {v0, v4, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 2317
    :cond_c
    move-object v0, v4

    move-object v5, v15

    move-object v4, v2

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/TelemetryCollector;->buildShotTelemetryJson(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;IIILcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)Ljava/lang/String;

    move-result-object v1

    .line 2319
    const-string v2, "[^a-zA-Z0-9._-]"

    const-string v5, "_"

    invoke-virtual {v10, v2, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 2320
    sget-object v5, Lcom/motorola/camera/custom/CustomImagingBridge;->application:Landroid/content/Context;

    invoke-static {v5, v2, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->writePublicTelemetrySidecar(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 2321
    move-object/from16 v5, p4

    invoke-static/range {v3 .. v8}, Lcom/motorola/camera/custom/TelemetryCollector;->buildConciseExifNote(Landroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/TelemetryCollector$ShotMetadata;Ljava/lang/String;III)Ljava/lang/String;

    move-result-object v1

    .line 2323
    sget-object v2, Lcom/motorola/camera/custom/CustomImagingBridge;->TELEMETRY_NOTE_CACHE:Ljava/util/Map;

    invoke-interface {v2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2324
    return-object v1

    .line 2325
    :catchall_0
    move-exception v0

    .line 2326
    const-string v1, "CustomImagingBridge"

    const-string v2, "recordShotTelemetry skipped"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2327
    const-string v0, ""

    return-object v0
.end method

.method private static renderPortrait(Ljava/nio/ByteBuffer;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;III)Landroid/graphics/Bitmap;
    .locals 3

    .line 1104
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object p0

    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->decodeMutable([B)Landroid/graphics/Bitmap;

    move-result-object p0

    .line 1105
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 1106
    :cond_0
    nop

    .line 1108
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

    .line 1109
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p3

    if-ne p3, p4, :cond_6

    .line 1110
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

    .line 1111
    :cond_3
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/PortraitBokeh;->render(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;I)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1112
    if-eqz p1, :cond_4

    move-object v0, p0

    .line 1117
    :cond_4
    if-nez p1, :cond_5

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1112
    :cond_5
    return-object v0

    .line 1110
    :cond_6
    :goto_0
    nop

    .line 1117
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1110
    return-object v0

    .line 1117
    :catchall_0
    move-exception p1

    goto :goto_1

    .line 1113
    :catch_0
    move-exception p1

    .line 1114
    :try_start_1
    const-string p2, "CustomImagingBridge"

    const-string p3, "Using stock portrait rendering"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1115
    nop

    .line 1117
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1115
    return-object v0

    .line 1117
    :goto_1
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 1118
    throw p1
.end method

.method private static resolveActiveScene(Z)[I
    .locals 0

    .line 418
    invoke-static {p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecisionForActiveScene(Z)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    iget-object p0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    return-object p0
.end method

.method private static resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
    .locals 29

    .line 352
    nop

    .line 353
    nop

    .line 355
    const/high16 v1, 0x3f800000    # 1.0f

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraType()Lcom/motorola/camera/settings/CameraType;

    move-result-object v0

    .line 356
    if-eqz v0, :cond_0

    .line 357
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getZoomValue(Lcom/motorola/camera/settings/CameraType;)F

    move-result v0

    .line 359
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

    .line 361
    :catchall_0
    move-exception v0

    :cond_0
    :goto_0
    move v3, v1

    .line 363
    const/high16 v1, 0x42480000    # 50.0f

    :try_start_1
    invoke-static {}, Lcom/motorola/camera/IqConfigManager;->getInstance()Lcom/motorola/camera/IqConfigManager;

    move-result-object v0

    .line 365
    if-eqz v0, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    invoke-static {v2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_1

    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    const/4 v4, 0x0

    cmpl-float v2, v2, v4

    if-lez v2, :cond_1

    .line 366
    iget v1, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    .line 368
    :catchall_1
    move-exception v0

    :cond_1
    :goto_1
    move v4, v1

    .line 370
    const-string v0, ""

    if-eqz p0, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/Mcf$SceneMode;->name()Ljava/lang/String;

    move-result-object v1

    move-object v5, v1

    goto :goto_2

    :cond_2
    move-object v5, v0

    .line 371
    :goto_2
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v2

    .line 372
    invoke-static {v2}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v1

    .line 373
    const-string v6, "com.motorola.camera.look_preset"

    const/16 v7, 0xd

    const/4 v11, 0x0

    invoke-static {v6, v11, v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v6

    .line 374
    const-string v7, "com.motorola.camera.look_intensity"

    const/16 v8, 0x64

    invoke-static {v7, v8, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v7

    .line 375
    const-string v8, "com.motorola.camera.bokeh_style"

    const/4 v12, 0x5

    invoke-static {v8, v11, v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v8

    .line 376
    if-eqz v1, :cond_3

    move v9, v11

    goto :goto_3

    :cond_3
    move v9, v6

    .line 377
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

    .line 378
    :goto_5
    if-eqz v1, :cond_6

    move v13, v11

    goto :goto_6

    :cond_6
    move v13, v8

    .line 379
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

    .line 380
    :goto_7
    sget-boolean v8, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    move/from16 v6, p1

    move/from16 v7, p2

    invoke-static/range {v2 .. v10}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtendedWithLook(IFFLjava/lang/String;ZZZII)[I

    move-result-object v7

    .line 383
    move v8, v9

    move v9, v10

    if-lez v8, :cond_9

    sget-object v6, Lcom/motorola/camera/custom/CustomImagingBridge;->LOOK_DISPLAY_NAMES:[Ljava/lang/String;

    array-length v6, v6

    if-ge v8, v6, :cond_9

    if-lez v9, :cond_9

    .line 384
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

    .line 385
    :cond_9
    if-eqz v11, :cond_a

    const-string v6, "Look: Paused | "

    goto :goto_8

    :cond_a
    move-object v6, v0

    .line 386
    :goto_8
    const/high16 v10, 0x41200000    # 10.0f

    mul-float v15, v3, v10

    .line 387
    invoke-static {v15}, Ljava/lang/Math;->round(F)I

    move-result v15

    int-to-float v15, v15

    div-float/2addr v15, v10

    .line 388
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

    .line 391
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

    .line 392
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

    .line 393
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

    .line 394
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

    .line 395
    :goto_c
    const/16 v11, 0xb

    aget v11, p0, v11

    const/4 v13, 0x1

    if-ne v11, v13, :cond_f

    const-string v11, " t2w=0"

    goto :goto_d

    :cond_f
    move-object/from16 v11, v18

    .line 396
    :goto_d
    const/16 v17, 0xc

    move-object/from16 v27, v11

    aget v11, p0, v17

    if-ne v11, v13, :cond_10

    const-string v11, " qll=1"

    goto :goto_e

    :cond_10
    move-object/from16 v11, v18

    .line 397
    :goto_e
    const/16 v13, 0xa

    if-ne v2, v13, :cond_11

    const-string v13, " stock=1"

    goto :goto_f

    :cond_11
    move-object/from16 v13, v18

    .line 398
    :goto_f
    move-object/from16 v17, v13

    const/16 v13, 0x9

    if-ne v2, v13, :cond_12

    const-string v13, " mcf=0"

    goto :goto_10

    :cond_12
    move-object/from16 v13, v18

    .line 399
    :goto_10
    sget-boolean v23, Lcom/motorola/camera/custom/CustomImagingBridge;->HTP_RPC_AVAILABLE:Z

    if-nez v23, :cond_13

    const-string v23, " htp=0"

    move-object/from16 v28, v23

    goto :goto_11

    :cond_13
    move-object/from16 v28, v18

    .line 400
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

    .line 401
    :goto_12
    if-eqz p1, :cond_15

    const-string v11, " flash=1"

    goto :goto_13

    :cond_15
    move-object/from16 v11, v18

    .line 402
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

    const-string v11, "Edge50Port v1.9.2 | "

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

    .line 403
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

    .line 408
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

    .line 409
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isUiSpecialModeSafe()Z

    move-result v0

    .line 410
    nop

    .line 412
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 413
    goto :goto_2

    :catchall_0
    move-exception v1

    const/4 v1, 0x0

    .line 414
    :goto_2
    invoke-static {v1, p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveDecision(Lcom/motorola/camera/mcf/Mcf$SceneMode;ZZ)Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    move-result-object p0

    return-object p0
.end method

.method public static resolveEdgeMode(I)I
    .locals 2

    .line 495
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x2

    aget v0, v0, v1

    .line 496
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveEnableMfnr(Z)Z
    .locals 1

    .line 505
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->isFlashExpectedSafe()Z

    move-result v0

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveEnableMfnr(ZZ)Z

    move-result p0

    return p0
.end method

.method public static resolveEnableMfnr(ZZ)Z
    .locals 1

    .line 509
    invoke-static {p1}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object p1

    const/4 v0, 0x3

    aget p1, p1, v0

    .line 510
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

    .line 319
    const/16 v0, 0x5f

    if-ne p0, v0, :cond_0

    const/16 p0, 0x62

    :cond_0
    return p0
.end method

.method public static resolveNoiseReduction(I)I
    .locals 2

    .line 490
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    .line 491
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

    .line 2017
    if-eqz p1, :cond_8

    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_5

    .line 2020
    :cond_0
    invoke-virtual {p1}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 2022
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isSlowMotionMode()Z

    move-result v1

    if-nez v1, :cond_7

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isDualCaptureVideoMode()Z

    move-result v1

    if-eqz v1, :cond_1

    goto/16 :goto_3

    .line 2026
    :cond_1
    if-eqz p0, :cond_6

    .line 2027
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p0

    .line 2028
    if-eqz p0, :cond_6

    .line 2029
    sget-object v1, Landroid/hardware/camera2/CameraCharacteristics;->CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Landroid/util/Range;

    .line 2030
    if-eqz p0, :cond_6

    array-length v1, p0

    if-lez v1, :cond_6

    .line 2031
    array-length v1, p0

    new-array v1, v1, [[I

    .line 2032
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    array-length v4, p0

    if-ge v3, v4, :cond_4

    .line 2033
    aget-object v4, p0, v3

    .line 2034
    if-eqz v4, :cond_3

    invoke-virtual {v4}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v5

    if-eqz v5, :cond_3

    invoke-virtual {v4}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v5

    if-nez v5, :cond_2

    goto :goto_1

    .line 2035
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

    .line 2032
    :cond_3
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2037
    :cond_4
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoAeRange(I[[IZ)[I

    move-result-object v1

    .line 2038
    if-eqz v1, :cond_6

    .line 2039
    array-length v3, p0

    move v4, v2

    :goto_2
    if-ge v4, v3, :cond_6

    aget-object v5, p0, v4

    .line 2040
    if-eqz v5, :cond_5

    invoke-virtual {v5}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v6

    if-eqz v6, :cond_5

    invoke-virtual {v5}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v6

    if-eqz v6, :cond_5

    .line 2041
    invoke-virtual {v5}, Landroid/util/Range;->getLower()Ljava/lang/Comparable;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    aget v7, v1, v2

    if-ne v6, v7, :cond_5

    .line 2042
    invoke-virtual {v5}, Landroid/util/Range;->getUpper()Ljava/lang/Comparable;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    const/4 v7, 0x1

    aget v8, v1, v7

    if-ne v6, v8, :cond_5

    .line 2043
    aget p0, v1, v7

    invoke-static {p0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V

    .line 2044
    return-object v5

    .line 2039
    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 2053
    :cond_6
    goto :goto_4

    .line 2023
    :cond_7
    :goto_3
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2024
    return-object p1

    .line 2051
    :catchall_0
    move-exception p0

    .line 2052
    const-string v1, "CustomImagingBridge"

    const-string v2, "resolveQualcommVideoFpsRange fallback"

    invoke-static {v1, v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2054
    :goto_4
    invoke-static {v0}, Lcom/motorola/camera/custom/VideoConfigHelper;->noteResolvedVideoFps(I)V

    .line 2055
    return-object p1

    .line 2018
    :cond_8
    :goto_5
    return-object p1
.end method

.method public static resolveSuperZoom(B)B
    .locals 2

    .line 500
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x4

    aget v0, v0, v1

    .line 501
    if-ltz v0, :cond_0

    int-to-byte p0, v0

    :cond_0
    return p0
.end method

.method public static resolveVideoBitrate(IIZ)I
    .locals 0

    .line 1982
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/VideoConfigHelper;->resolveVideoBitrate(IIZ)I

    move-result p0

    return p0
.end method

.method private static runCleanBayerExport([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 2

    .line 1577
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->RAW_EXPORT_SERIAL_LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 1578
    :try_start_0
    invoke-static/range {p0 .. p7}, Lcom/motorola/camera/custom/CustomImagingBridge;->runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    .line 1579
    monitor-exit v1

    .line 1580
    return-void

    .line 1579
    :catchall_0
    move-exception v0

    move-object p0, v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private static runCleanBayerExportLocked([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 36

    .line 1587
    move-object/from16 v1, p0

    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v7, p3

    const-string v14, "FocalLength"

    const-string v15, "CustomImagingBridge"

    :try_start_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v16

    .line 1588
    int-to-long v4, v2

    int-to-long v8, v3

    mul-long/2addr v4, v8

    const-wide/16 v8, 0x5

    mul-long/2addr v8, v4

    const-wide/16 v10, 0x4

    div-long/2addr v8, v10

    .line 1589
    const-wide/16 v10, 0x2

    mul-long/2addr v4, v10

    .line 1591
    array-length v0, v1

    int-to-long v10, v0

    cmp-long v0, v10, v4

    const/4 v10, 0x1

    if-ltz v0, :cond_0

    .line 1592
    array-length v0, v1

    div-int/2addr v0, v3

    invoke-static {v1, v2, v3, v0, v10}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object v0

    move-object v11, v0

    goto :goto_0

    .line 1593
    :cond_0
    array-length v0, v1

    int-to-long v4, v0

    cmp-long v0, v4, v8

    if-ltz v0, :cond_1b

    .line 1594
    array-length v0, v1

    div-int/2addr v0, v3

    invoke-static {v1, v2, v3, v0}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object v0

    move-object v11, v0

    .line 1600
    :goto_0
    invoke-static/range {p4 .. p4}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v12

    .line 1601
    nop

    .line 1602
    const/4 v13, 0x4

    new-array v5, v13, [F

    const/high16 v0, 0x42800000    # 64.0f

    const/4 v4, 0x0

    aput v0, v5, v4

    aput v0, v5, v10

    const/4 v6, 0x2

    aput v0, v5, v6

    const/4 v8, 0x3

    aput v0, v5, v8

    .line 1603
    nop

    .line 1604
    nop

    .line 1606
    if-eqz v12, :cond_4

    .line 1607
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_COLOR_FILTER_ARRANGEMENT:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v12, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1608
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_1

    :cond_1
    move v0, v4

    .line 1609
    :goto_1
    sget-object v9, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_BLACK_LEVEL_PATTERN:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v12, v9}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/hardware/camera2/params/BlackLevelPattern;

    .line 1610
    if-eqz v9, :cond_2

    .line 1611
    invoke-virtual {v9, v4, v4}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v13

    int-to-float v13, v13

    aput v13, v5, v4

    .line 1612
    invoke-virtual {v9, v10, v4}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v13

    int-to-float v13, v13

    aput v13, v5, v10

    .line 1613
    invoke-virtual {v9, v4, v10}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v13

    int-to-float v13, v13

    aput v13, v5, v6

    .line 1614
    invoke-virtual {v9, v10, v10}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v9

    int-to-float v9, v9

    aput v9, v5, v8

    .line 1616
    :cond_2
    sget-object v9, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_WHITE_LEVEL:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v12, v9}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Integer;

    .line 1617
    if-eqz v9, :cond_3

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v13

    if-lez v13, :cond_3

    .line 1618
    invoke-virtual {v9}, Ljava/lang/Integer;->floatValue()F

    move-result v9

    goto :goto_2

    .line 1620
    :cond_3
    const v9, 0x447fc000    # 1023.0f

    :goto_2
    sget-object v13, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_COLOR_TRANSFORM1:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v12, v13}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-static {v13}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v13

    invoke-static {v13}, Lcom/motorola/camera/custom/CustomImagingBridge;->sensorTransformToSrgbCcm([F)[F

    move-result-object v13

    move/from16 v18, v9

    move v9, v0

    goto :goto_3

    .line 1606
    :cond_4
    move v9, v4

    const/4 v13, 0x0

    const v18, 0x447fc000    # 1023.0f

    .line 1623
    :goto_3
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 1624
    if-eqz v0, :cond_5

    .line 1625
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v0

    .line 1626
    if-eqz v0, :cond_5

    move-object/from16 v27, v0

    goto :goto_4

    .line 1629
    :cond_5
    move-object/from16 v27, v13

    :goto_4
    new-array v13, v8, [F

    const v0, 0x3fe66666    # 1.8f

    aput v0, v13, v4

    const/high16 v0, 0x3f800000    # 1.0f

    aput v0, v13, v10

    const v0, 0x3fcccccd    # 1.6f

    aput v0, v13, v6

    .line 1630
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_GAINS:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 1631
    if-eqz v0, :cond_6

    .line 1632
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result v8

    aput v8, v13, v4

    .line 1633
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v8

    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v20

    add-float v8, v8, v20

    const/high16 v20, 0x3f000000    # 0.5f

    mul-float v8, v8, v20

    aput v8, v13, v10

    .line 1634
    invoke-virtual {v0}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result v0

    aput v0, v13, v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_9

    .line 1637
    :cond_6
    nop

    .line 1638
    nop

    .line 1639
    nop

    .line 1641
    :try_start_1
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->STATISTICS_LENS_SHADING_CORRECTION_MAP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/camera2/params/LensShadingMap;

    .line 1642
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v8

    if-lt v8, v6, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v8

    if-lt v8, v6, :cond_7

    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v6

    if-lez v6, :cond_7

    .line 1643
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getColumnCount()I

    move-result v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 1644
    :try_start_2
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getRowCount()I

    move-result v8
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1645
    move/from16 v33, v10

    :try_start_3
    invoke-virtual {v0}, Landroid/hardware/camera2/params/LensShadingMap;->getGainFactorCount()I

    move-result v10

    new-array v10, v10, [F
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1646
    :try_start_4
    invoke-virtual {v0, v10, v4}, Landroid/hardware/camera2/params/LensShadingMap;->copyGainFactors([FI)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_6

    .line 1648
    :catchall_0
    move-exception v0

    goto :goto_6

    :catchall_1
    move-exception v0

    goto :goto_5

    :catchall_2
    move-exception v0

    move/from16 v33, v10

    move v8, v4

    goto :goto_5

    .line 1642
    :cond_7
    move/from16 v33, v10

    .line 1648
    move v6, v4

    move v8, v6

    goto :goto_5

    :catchall_3
    move-exception v0

    move/from16 v33, v10

    move v6, v4

    move v8, v6

    :goto_5
    const/4 v10, 0x0

    :goto_6
    move/from16 v30, v6

    move/from16 v31, v8

    .line 1650
    nop

    .line 1652
    const/16 v6, 0x64

    :try_start_5
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1653
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-lez v8, :cond_8

    .line 1654
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    goto :goto_7

    .line 1656
    :catchall_4
    move-exception v0

    :cond_8
    :goto_7
    move/from16 v32, v6

    .line 1659
    :try_start_6
    const-string v0, "singleRaw"

    .line 1660
    nop

    .line 1661
    nop

    .line 1662
    nop

    .line 1663
    move-object/from16 v8, p5

    move v4, v9

    move-object/from16 v34, v14

    move/from16 v6, v18

    const/4 v14, 0x0

    move-object/from16 v9, p4

    invoke-static/range {v1 .. v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->tryMultiFrameRawMerge([BIII[FFLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_9

    .line 1665
    const-string v18, ""

    if-eqz v1, :cond_a

    .line 1666
    :try_start_7
    iget v0, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->width:I

    .line 1667
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->height:I

    .line 1668
    iget v3, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->cfaPattern:I

    .line 1669
    iget-object v4, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->blackLevel4:[F

    .line 1670
    iget v5, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->whiteLevel:F

    .line 1671
    const-string v6, "rawBurst"

    .line 1672
    iget v7, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 1673
    iget v8, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    iget-boolean v9, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->superResolved:Z

    if-eqz v9, :cond_9

    const-string v9, " sr=1"

    goto :goto_8

    :cond_9
    move-object/from16 v9, v18

    :goto_8
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, " rawBurst="

    invoke-virtual {v11, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 1674
    iget-object v1, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->raw:[I

    const/high16 v28, 0x3e800000    # 0.25f

    move/from16 v21, v0

    move-object/from16 v20, v1

    move/from16 v22, v2

    move/from16 v23, v3

    move-object/from16 v24, v4

    move/from16 v25, v5

    move-object/from16 v29, v10

    move-object/from16 v26, v13

    invoke-static/range {v20 .. v32}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII)[I

    move-result-object v0

    move-object/from16 v14, p5

    move-object v2, v0

    move-object v0, v6

    move-object v1, v7

    move-object v10, v8

    move-object/from16 v35, v12

    move/from16 v3, v21

    move/from16 v4, v22

    const/16 v19, 0x4

    goto :goto_9

    .line 1678
    :cond_a
    move-object/from16 v26, v13

    move-object/from16 v8, v27

    move/from16 v13, v32

    invoke-static/range {v33 .. v33}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    .line 1679
    const/high16 v9, 0x3e800000    # 0.25f

    move/from16 v2, p1

    move/from16 v3, p2

    move-object v1, v11

    move-object/from16 v35, v12

    move-object/from16 p0, v14

    move-object/from16 v7, v26

    move/from16 v11, v30

    move/from16 v12, v31

    const/16 v19, 0x4

    move-object/from16 v14, p5

    invoke-static/range {v1 .. v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII)[I

    move-result-object v1

    move/from16 v3, p1

    move/from16 v4, p2

    move-object v2, v1

    move-object/from16 v10, v18

    move-object/from16 v1, p0

    .line 1683
    :goto_9
    iget-object v5, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    const/4 v6, 0x5

    aget v7, v5, v6

    .line 1684
    if-lez v7, :cond_b

    .line 1685
    const/16 v5, 0x200

    const/16 v6, 0x18

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->gradePixelBufferStrips([IIIIII)Z

    move-result v5

    move-object v11, v2

    if-nez v5, :cond_c

    .line 1686
    const-string v0, "Abort CleanBayerRaw export because strip grading was interrupted"

    invoke-static {v15, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1687
    return-void

    .line 1684
    :cond_b
    move-object v11, v2

    .line 1691
    :cond_c
    iget v2, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-lez v2, :cond_d

    iget v2, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    if-lez v2, :cond_d

    iget v2, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->loadLook(I)Lcom/motorola/camera/custom/LookFilterEngine;

    move-result-object v9

    move-object v5, v9

    goto :goto_a

    :cond_d
    const/4 v5, 0x0

    .line 1692
    :goto_a
    if-eqz v5, :cond_e

    invoke-static {v11, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->arraySurface([II)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;

    move-result-object v2

    iget v6, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    iget v7, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    const/high16 v8, 0x3f800000    # 1.0f

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-static/range {v2 .. v9}, Lcom/motorola/camera/custom/CustomImagingBridge;->applyLook(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IILcom/motorola/camera/custom/LookFilterEngine;IIFF)Z

    move-result v2

    if-nez v2, :cond_e

    .line 1693
    return-void

    .line 1695
    :cond_e
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v11, v3, v4, v2}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_9

    .line 1696
    if-nez v2, :cond_f

    return-void

    .line 1699
    :cond_f
    :try_start_8
    new-instance v5, Ljava/io/ByteArrayOutputStream;

    mul-int/2addr v3, v4

    div-int/lit8 v3, v3, 0x4

    invoke-direct {v5, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1700
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x62

    invoke-virtual {v2, v3, v4, v5}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v3
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_8

    if-nez v3, :cond_10

    .line 1703
    :try_start_9
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_9

    .line 1700
    return-void

    .line 1701
    :cond_10
    :try_start_a
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_8

    .line 1703
    :try_start_b
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 1704
    nop

    .line 1706
    move-object/from16 v7, p3

    move-object/from16 v9, p4

    const/4 v8, 0x0

    invoke-static {v3, v7, v8, v9, v8}, Lcom/motorola/camera/utility/ExifUtility;->appendExifToJpeg([BLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/mcf/McfMetadata;Ljava/lang/String;[B)[B

    move-result-object v11
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_9

    .line 1708
    move-object v4, v0

    const/4 v0, 0x0

    const/4 v7, 0x0

    move-object/from16 v5, p6

    move-object v6, v1

    move-object v2, v9

    move-object v3, v14

    move-object/from16 v1, p3

    :try_start_c
    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->recordShotTelemetry(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v7, v1

    .line 1710
    invoke-static {v8, v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->latestCompassForContainer(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;Ljava/lang/String;Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;

    move-result-object v1

    .line 1711
    iget-object v2, v14, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_11

    :goto_b
    move-object/from16 v0, v18

    goto :goto_c

    :cond_11
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    goto :goto_b

    :goto_c
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1712
    if-eqz v11, :cond_18

    .line 1713
    new-instance v2, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v3, Ljava/io/ByteArrayInputStream;

    invoke-direct {v3, v11}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v2, v3}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 1714
    nop

    .line 1715
    if-eqz v1, :cond_12

    .line 1716
    invoke-static {v2, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 1717
    move/from16 v1, v33

    goto :goto_d

    .line 1715
    :cond_12
    const/4 v1, 0x0

    .line 1719
    :goto_d
    if-eqz v0, :cond_13

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_13

    .line 1720
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " cleanBayer=1"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1721
    const-string v1, "ImageDescription"

    invoke-virtual {v2, v1, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1722
    const-string v1, "UserComment"

    invoke-virtual {v2, v1, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1723
    move/from16 v10, v33

    goto :goto_e

    .line 1725
    :cond_13
    move v10, v1

    :goto_e
    move-object/from16 v1, v34

    invoke-virtual {v2, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_16

    .line 1726
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v7, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 1727
    if-nez v0, :cond_15

    move-object/from16 v3, v35

    if-eqz v3, :cond_15

    .line 1728
    sget-object v4, Landroid/hardware/camera2/CameraCharacteristics;->LENS_INFO_AVAILABLE_FOCAL_LENGTHS:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v3, v4}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [F

    .line 1729
    if-eqz v3, :cond_14

    array-length v4, v3

    if-lez v4, :cond_14

    .line 1730
    const/4 v4, 0x0

    aget v0, v3, v4

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    goto :goto_f

    .line 1729
    :cond_14
    const/4 v4, 0x0

    goto :goto_f

    .line 1727
    :cond_15
    const/4 v4, 0x0

    .line 1733
    :goto_f
    if-eqz v0, :cond_17

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->isFinite(F)Z

    move-result v3

    if-eqz v3, :cond_17

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v3

    const v6, 0x3dcccccd    # 0.1f

    cmpl-float v3, v3, v6

    if-lez v3, :cond_17

    .line 1734
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    const/high16 v3, 0x42c80000    # 100.0f

    mul-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "/100"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v1, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 1735
    move/from16 v10, v33

    goto :goto_10

    .line 1725
    :cond_16
    const/4 v4, 0x0

    .line 1738
    :cond_17
    :goto_10
    if-eqz v10, :cond_18

    .line 1739
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    array-length v1, v11

    add-int/lit16 v1, v1, 0x400

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1740
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v11}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v2, v1, v0, v4}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 1741
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 1742
    array-length v1, v0
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_5

    const/16 v2, 0x40

    if-le v1, v2, :cond_18

    .line 1743
    move-object v11, v0

    goto :goto_11

    .line 1747
    :catchall_5
    move-exception v0

    :cond_18
    :goto_11
    nop

    .line 1749
    :try_start_d
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/storage/MediaFile;->fromMediaFilePath(Lcom/motorola/camera/storage/MediaFilePath;)Lcom/motorola/camera/storage/backend/MediaStoreMediaFile;

    move-result-object v0

    invoke-static {v0}, Lcom/motorola/camera/storage/StorageUtils;->createMediaFileWithFallback(Lcom/motorola/camera/storage/MediaFile;)Lcom/motorola/camera/storage/MediaFile;

    move-result-object v0

    .line 1750
    if-nez v0, :cond_19

    return-void

    .line 1751
    :cond_19
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->getWriteFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    .line 1752
    if-nez v1, :cond_1a

    return-void

    .line 1753
    :cond_1a
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_9

    .line 1754
    :try_start_e
    invoke-virtual {v2, v11}, Ljava/io/FileOutputStream;->write([B)V

    .line 1755
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    .line 1756
    :try_start_f
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 1757
    invoke-interface {v0}, Lcom/motorola/camera/storage/MediaFile;->finish()V

    .line 1758
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sub-long v0, v0, v16

    const-wide/32 v2, 0xf4240

    div-long/2addr v0, v2

    .line 1759
    array-length v2, v11

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

    invoke-static {v15, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_9

    .line 1762
    goto :goto_13

    .line 1753
    :catchall_6
    move-exception v0

    move-object v1, v0

    :try_start_10
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_7

    goto :goto_12

    :catchall_7
    move-exception v0

    :try_start_11
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_12
    throw v1

    .line 1703
    :catchall_8
    move-exception v0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 1704
    throw v0

    .line 1596
    :cond_1b
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

    invoke-static {v15, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_9

    .line 1597
    return-void

    .line 1760
    :catchall_9
    move-exception v0

    .line 1761
    const-string v1, "runCleanBayerExport failed cleanly (DNG unaffected)"

    invoke-static {v15, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1763
    :goto_13
    return-void
.end method

.method private static sensorTransformToSrgbCcm([F)[F
    .locals 26

    .line 1778
    move-object/from16 v0, p0

    if-eqz v0, :cond_5

    array-length v2, v0

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    const/16 v23, 0x0

    goto/16 :goto_3

    .line 1779
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    const/4 v5, 0x1

    aget v6, v0, v5

    const/4 v7, 0x2

    aget v8, v0, v7

    .line 1780
    const/4 v9, 0x3

    aget v10, v0, v9

    const/4 v11, 0x4

    aget v12, v0, v11

    const/4 v13, 0x5

    aget v14, v0, v13

    .line 1781
    const/4 v15, 0x6

    aget v16, v0, v15

    const/16 v17, 0x7

    aget v18, v0, v17

    const/16 v19, 0x8

    aget v0, v0, v19

    .line 1782
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

    .line 1783
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

    .line 1784
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

    .line 1785
    mul-float v4, v4, v20

    mul-float/2addr v6, v1

    add-float/2addr v4, v6

    mul-float v8, v8, v21

    add-float/2addr v4, v8

    .line 1786
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v8, 0x3727c5ac    # 1.0E-5f

    cmpg-float v6, v6, v8

    if-gez v6, :cond_1

    goto :goto_2

    .line 1787
    :cond_1
    const/high16 v6, 0x3f800000    # 1.0f

    div-float/2addr v6, v4

    .line 1789
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

    .line 1794
    new-array v0, v3, [F

    fill-array-data v0, :array_0

    .line 1799
    new-array v1, v3, [F

    .line 1800
    move/from16 v2, v25

    :goto_0
    if-ge v2, v9, :cond_3

    .line 1801
    move/from16 v3, v25

    :goto_1
    if-ge v3, v9, :cond_2

    .line 1802
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

    .line 1801
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1800
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1807
    :cond_3
    return-object v1

    .line 1786
    :cond_4
    :goto_2
    return-object v23

    .line 1778
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

    .line 586
    if-eqz p0, :cond_1

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_1

    .line 590
    :cond_0
    :try_start_0
    new-instance p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-direct {p1, p2, p3}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Ljava/lang/Class;)V

    .line 591
    invoke-virtual {p0, p1, p4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 592
    :catchall_0
    move-exception p0

    :goto_0
    nop

    .line 593
    return-void

    .line 587
    :cond_1
    :goto_1
    return-void
.end method

.method public static shouldAllowInSensorCrop()Z
    .locals 2

    .line 514
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 515
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

    .line 315
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

    .line 1986
    invoke-static {p0}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldDisableHdr10ForFps(I)Z

    move-result p0

    return p0
.end method

.method private static shouldSkipStockColorTone(Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;)Z
    .locals 4

    .line 764
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 765
    :cond_0
    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    const/16 v2, 0x9

    const/4 v3, 0x1

    if-ne v1, v2, :cond_1

    return v3

    .line 766
    :cond_1
    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    invoke-static {v1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v1

    if-eqz v1, :cond_2

    return v0

    .line 767
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

    .line 1990
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/VideoConfigHelper;->shouldThermalStepDownFps(II)Z

    move-result p0

    return p0
.end method

.method private static stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    .locals 3

    .line 782
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

    .line 785
    :cond_0
    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->headingDeg:Ljava/lang/Float;

    .line 786
    :goto_0
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_2

    .line 787
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Float;->doubleValue()D

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassSolarHelper;->formatExifDirection(D)Ljava/lang/String;

    move-result-object v0

    .line 788
    if-nez v0, :cond_3

    return-void

    .line 789
    :cond_3
    const-string v1, "GPSImgDirection"

    invoke-virtual {p0, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 790
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 791
    :cond_4
    invoke-virtual {p0, v1, v0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 792
    iget-object p1, p1, Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;->trueHeadingDeg:Ljava/lang/Float;

    if-eqz p1, :cond_5

    const-string p1, "T"

    goto :goto_1

    :cond_5
    const-string p1, "M"

    :goto_1
    const-string v0, "GPSImgDirectionRef"

    invoke-virtual {p0, v0, p1}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 794
    :cond_6
    return-void

    .line 786
    :cond_7
    :goto_2
    return-void

    .line 783
    :cond_8
    :goto_3
    return-void
.end method

.method private static stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;)V
    .locals 1

    .line 798
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 799
    return-void
.end method

.method private static stampExifDescription(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;[BLcom/motorola/camera/photometadata/PhotoMetadata;Ljava/lang/String;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V
    .locals 3

    .line 805
    const-string v0, "CustomImagingBridge"

    if-eqz p2, :cond_2

    if-eqz p3, :cond_2

    :try_start_0
    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    .line 806
    const-string v1, "ImageDescription"

    invoke-virtual {p2, v1, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 807
    const-string v1, "UserComment"

    invoke-virtual {p2, v1, p3}, Lcom/motorola/camera/photometadata/PhotoMetadata;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 808
    invoke-static {p2, p4}, Lcom/motorola/camera/custom/CustomImagingBridge;->stampCompassExif(Lcom/motorola/camera/photometadata/PhotoMetadata;Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;)V

    .line 809
    new-instance p4, Ljava/io/ByteArrayOutputStream;

    array-length v1, p1

    add-int/lit16 v1, v1, 0x800

    invoke-direct {p4, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 810
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    const/4 v2, 0x0

    invoke-virtual {p2, v1, p4, v2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 811
    invoke-virtual {p4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p4

    .line 812
    invoke-virtual {p2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->isUltraHdr()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-static {p1, p4}, Lcom/motorola/camera/custom/GainmapJpeg;->withExif([B[B)[B

    move-result-object p4

    .line 813
    :cond_0
    if-eqz p4, :cond_1

    array-length p1, p4

    const/16 p2, 0x40

    if-le p1, p2, :cond_1

    .line 814
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {p4}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 816
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

    .line 818
    :catchall_0
    move-exception p0

    .line 819
    const-string p1, "stampExifDescription skipped"

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 820
    :cond_2
    :goto_0
    nop

    .line 821
    :goto_1
    return-void
.end method

.method private static toByteArray(Ljava/nio/ByteBuffer;)[B
    .locals 1

    .line 1811
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 1812
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 1813
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 1814
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1815
    return-object v0
.end method

.method private static tryMultiFrameRawMerge([BIII[FFLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
    .locals 39

    .line 1422
    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v0, p6

    move-object/from16 v1, p7

    move-object/from16 v4, p8

    int-to-long v5, v2

    int-to-long v7, v3

    mul-long/2addr v5, v7

    const-wide/16 v7, 0x5

    mul-long/2addr v7, v5

    const-wide/16 v9, 0x4

    const/4 v14, 0x0

    const/high16 v15, 0x7fc00000    # Float.NaN

    const/4 v11, 0x0

    :try_start_0
    div-long/2addr v7, v9

    long-to-int v7, v7

    .line 1423
    const-wide/16 v8, 0x2

    mul-long/2addr v5, v8

    long-to-int v5, v5

    .line 1424
    mul-int/lit8 v6, v2, 0x10

    add-int v8, v5, v6

    add-int/2addr v6, v7

    invoke-static {v8, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 1425
    nop

    .line 1426
    const/4 v8, 0x5

    invoke-static {v4, v7, v6, v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->snapshotSessionFrames(Ljava/lang/String;III)[Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;

    move-result-object v6

    .line 1427
    array-length v8, v6

    const/4 v9, 0x1

    if-ge v8, v9, :cond_0

    .line 1428
    invoke-static {v11, v15, v15}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1429
    return-object v14

    .line 1432
    :cond_0
    nop

    .line 1433
    const-string v8, "3"

    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    const/4 v12, 0x6

    if-eqz v8, :cond_1

    .line 1434
    const/4 v1, 0x4

    goto :goto_0

    .line 1435
    :cond_1
    if-eqz v1, :cond_2

    iget v8, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    const v16, 0x3fb9999a    # 1.45f

    cmpl-float v8, v8, v16

    if-ltz v8, :cond_2

    iget v1, v1, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    if-eq v1, v12, :cond_2

    .line 1436
    const/4 v1, 0x3

    goto :goto_0

    .line 1439
    :cond_2
    move v1, v9

    :goto_0
    nop

    .line 1440
    nop

    .line 1441
    nop

    .line 1442
    const/high16 v8, 0x40c00000    # 6.0f

    invoke-static {v4, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v8

    .line 1443
    nop

    .line 1444
    nop

    .line 1445
    const-wide/16 v16, 0x0

    const/16 v18, 0x0

    const-wide/32 v19, 0x989680

    const/16 v21, 0x64

    if-eqz v0, :cond_9

    .line 1446
    sget-object v11, Landroid/hardware/camera2/CaptureResult;->SENSOR_TIMESTAMP:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v11}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Long;

    .line 1447
    sget-object v12, Landroid/hardware/camera2/CaptureResult;->SENSOR_EXPOSURE_TIME:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v12}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Long;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1448
    move-object/from16 v24, v14

    :try_start_1
    sget-object v14, Landroid/hardware/camera2/CaptureResult;->SENSOR_SENSITIVITY:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v14}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Integer;

    .line 1449
    sget-object v15, Landroid/hardware/camera2/CaptureResult;->LENS_FOCAL_LENGTH:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v15}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/Float;

    .line 1450
    sget-object v10, Landroid/hardware/camera2/CaptureResult;->LENS_FOCUS_DISTANCE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v10}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Float;

    .line 1451
    sget-object v9, Landroid/hardware/camera2/CaptureResult;->LENS_STATE:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v9}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1452
    if-eqz v11, :cond_3

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v27

    cmp-long v9, v27, v16

    if-lez v9, :cond_3

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v27

    goto :goto_1

    .line 1453
    :cond_3
    move-wide/from16 v27, v16

    :goto_1
    if-eqz v12, :cond_4

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v29

    cmp-long v9, v29, v16

    if-lez v9, :cond_4

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v11

    move-wide/from16 v19, v11

    .line 1454
    :cond_4
    if-eqz v14, :cond_5

    invoke-virtual {v14}, Ljava/lang/Integer;->intValue()I

    move-result v9

    if-lez v9, :cond_5

    invoke-virtual {v14}, Ljava/lang/Integer;->intValue()I

    move-result v21

    .line 1455
    :cond_5
    if-eqz v15, :cond_6

    invoke-virtual {v15}, Ljava/lang/Float;->floatValue()F

    move-result v9

    cmpl-float v9, v9, v18

    if-lez v9, :cond_6

    .line 1456
    invoke-virtual {v15}, Ljava/lang/Float;->floatValue()F

    move-result v8

    invoke-static {v4, v8}, Lcom/motorola/camera/custom/CustomImagingBridge;->calibratedFocalLengthPx(Ljava/lang/String;F)F

    move-result v4

    move v8, v4

    .line 1458
    :cond_6
    if-eqz v10, :cond_7

    invoke-virtual {v10}, Ljava/lang/Float;->floatValue()F

    move-result v4

    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-virtual {v10}, Ljava/lang/Float;->floatValue()F

    move-result v4

    goto :goto_2

    .line 1459
    :cond_7
    const/high16 v4, 0x7fc00000    # Float.NaN

    :goto_2
    if-eqz v0, :cond_8

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    move v14, v8

    move-wide/from16 v8, v19

    goto :goto_3

    :cond_8
    move v14, v8

    move-wide/from16 v8, v19

    const/4 v0, 0x0

    goto :goto_3

    .line 1445
    :cond_9
    move-object/from16 v24, v14

    move v14, v8

    move-wide/from16 v27, v16

    move-wide/from16 v8, v19

    const/4 v0, 0x0

    const/high16 v4, 0x7fc00000    # Float.NaN

    .line 1463
    :goto_3
    cmp-long v15, v27, v16

    if-lez v15, :cond_a

    move-wide/from16 v10, v27

    goto :goto_4

    :cond_a
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v10

    .line 1462
    :goto_4
    invoke-static {v10, v11, v8, v9}, Lcom/motorola/camera/custom/TelemetryCollector;->latestGyroExcursionRad(JJ)F

    move-result v10

    .line 1464
    cmpg-float v11, v10, v18

    if-gez v11, :cond_b

    move/from16 v19, v18

    goto :goto_5

    :cond_b
    move/from16 v19, v10

    .line 1465
    :goto_5
    cmpl-float v10, v14, v18

    if-lez v10, :cond_c

    mul-float v10, v14, v19

    goto :goto_6

    :cond_c
    move/from16 v10, v18

    .line 1466
    :goto_6
    invoke-static {v6, v4}, Lcom/motorola/camera/custom/MultiFrameBurstController;->computeFocusSpreadDiopters([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;F)F

    move-result v11

    .line 1467
    nop

    .line 1468
    if-lez v15, :cond_d

    move-wide/from16 v29, v27

    goto :goto_7

    :cond_d
    const-wide/high16 v29, -0x8000000000000000L

    .line 1469
    :goto_7
    array-length v12, v6

    const-wide v31, 0x7fffffffffffffffL

    move-wide/from16 v33, v31

    const/4 v13, 0x0

    :goto_8
    if-ge v13, v12, :cond_10

    move-wide/from16 p6, v8

    aget-object v8, v6, v13

    .line 1470
    move v9, v12

    move/from16 p8, v13

    iget-wide v12, v8, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v12, v12, v16

    if-lez v12, :cond_f

    .line 1471
    iget-wide v12, v8, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v12, v12, v33

    if-gez v12, :cond_e

    iget-wide v12, v8, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move-wide/from16 v33, v12

    .line 1472
    :cond_e
    iget-wide v12, v8, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v12, v12, v29

    if-lez v12, :cond_f

    iget-wide v12, v8, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move-wide/from16 v29, v12

    .line 1469
    :cond_f
    add-int/lit8 v13, p8, 0x1

    move v12, v9

    move-wide/from16 v8, p6

    goto :goto_8

    .line 1475
    :cond_10
    move-wide/from16 p6, v8

    cmp-long v8, v29, v33

    if-lez v8, :cond_11

    cmp-long v8, v33, v31

    if-gez v8, :cond_11

    sub-long v8, v29, v33

    long-to-float v8, v8

    const v9, 0x49742400    # 1000000.0f

    div-float/2addr v8, v9

    goto :goto_9

    :cond_11
    const/high16 v8, 0x7fc00000    # Float.NaN

    .line 1477
    :goto_9
    const/4 v9, 0x4

    if-ne v1, v9, :cond_12

    const/4 v9, 0x1

    goto :goto_a

    :cond_12
    const/4 v9, 0x0

    :goto_a
    invoke-static {v6, v4, v0, v10, v9}, Lcom/motorola/camera/custom/MultiFrameBurstController;->hasFocusDriftOrMotion([Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;FIFZ)Z

    move-result v0

    if-eqz v0, :cond_13

    .line 1480
    const/4 v0, 0x1

    invoke-static {v0, v11, v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1481
    return-object v24

    .line 1484
    :cond_13
    const/4 v0, 0x1

    const/4 v4, 0x3

    if-ne v1, v4, :cond_14

    const/16 v12, 0x8

    goto :goto_b

    :cond_14
    const/4 v12, 0x6

    .line 1485
    :goto_b
    new-instance v4, Lcom/motorola/camera/custom/MultiFrameRawEngine;

    invoke-direct {v4, v1, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine;-><init>(II)V

    .line 1487
    nop

    .line 1488
    nop

    .line 1489
    array-length v1, v6

    const-wide/16 v9, -0x1

    const/4 v12, 0x0

    const/16 v20, 0x0

    :goto_c
    if-ge v12, v1, :cond_1c

    aget-object v13, v6, v12

    .line 1490
    move/from16 v23, v1

    iget-wide v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v0, v0, v9

    if-lez v0, :cond_1b

    if-lez v15, :cond_15

    iget-wide v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    cmp-long v0, v0, v27

    if-nez v0, :cond_15

    move-wide/from16 v25, p6

    move/from16 v36, v5

    move-object/from16 v22, v6

    move/from16 v35, v7

    move/from16 v37, v8

    move/from16 v31, v11

    move/from16 v30, v12

    move/from16 v32, v14

    move/from16 p6, v15

    move/from16 v29, v23

    const/16 v33, 0x1

    move-object v14, v4

    goto/16 :goto_11

    .line 1491
    :cond_15
    iget-object v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->raw:[B

    invoke-static {v0, v2, v3, v7, v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->unpackRawAuto([BIIII)[I

    move-result-object v1

    .line 1492
    if-nez v1, :cond_16

    move-wide/from16 v25, p6

    move/from16 v36, v5

    move-object/from16 v22, v6

    move/from16 v35, v7

    move/from16 v37, v8

    move/from16 v31, v11

    move/from16 v30, v12

    move/from16 v32, v14

    move/from16 p6, v15

    move/from16 v29, v23

    const/16 v33, 0x1

    move-object v14, v4

    goto/16 :goto_11

    .line 1493
    :cond_16
    iget-wide v9, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    cmp-long v0, v9, v16

    if-lez v0, :cond_17

    iget-wide v9, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->exposureNs:J

    goto :goto_d

    :cond_17
    move-wide/from16 v9, p6

    .line 1494
    :goto_d
    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    if-lez v0, :cond_18

    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->iso:I

    goto :goto_e

    :cond_18
    move/from16 v0, v21

    .line 1495
    :goto_e
    move/from16 p8, v0

    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    cmpl-float v0, v0, v18

    if-lez v0, :cond_19

    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->focalLengthPx:F

    goto :goto_f

    :cond_19
    move v0, v14

    .line 1496
    :goto_f
    move/from16 v25, v0

    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    cmpl-float v0, v0, v18

    if-ltz v0, :cond_1a

    iget v0, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->gyroExcursionRad:F

    goto :goto_10

    :cond_1a
    move/from16 v0, v18

    .line 1497
    :goto_10
    move/from16 v29, v12

    move v12, v0

    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;

    move/from16 v30, v7

    move/from16 v31, v8

    iget-wide v7, v13, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    move/from16 v22, v15

    move-object v15, v13

    move/from16 v13, v25

    move-wide/from16 v25, p6

    move/from16 p6, v22

    move/from16 v36, v5

    move-object/from16 v22, v6

    move/from16 v32, v14

    move/from16 v35, v30

    move/from16 v37, v31

    const/16 v33, 0x1

    move-object/from16 v5, p4

    move/from16 v6, p5

    move-object v14, v4

    move/from16 v31, v11

    move/from16 v30, v29

    move/from16 v4, p3

    move/from16 v11, p8

    move/from16 v29, v23

    invoke-direct/range {v0 .. v13}, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;-><init>([IIII[FFJJIFF)V

    invoke-virtual {v14, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->addFrame(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V

    .line 1499
    iget-wide v0, v15, Lcom/motorola/camera/custom/MultiFrameBurstController$BurstFrameSnapshot;->timestampNs:J

    .line 1500
    add-int/lit8 v20, v20, 0x1

    move-wide v9, v0

    goto :goto_11

    .line 1490
    :cond_1b
    move-wide/from16 v25, p6

    move/from16 v36, v5

    move-object/from16 v22, v6

    move/from16 v35, v7

    move/from16 v37, v8

    move/from16 v31, v11

    move/from16 v30, v12

    move/from16 v32, v14

    move/from16 p6, v15

    move/from16 v29, v23

    const/16 v33, 0x1

    move-object v14, v4

    .line 1489
    :goto_11
    add-int/lit8 v12, v30, 0x1

    move/from16 v15, p6

    move-object v4, v14

    move-object/from16 v6, v22

    move-wide/from16 p6, v25

    move/from16 v1, v29

    move/from16 v11, v31

    move/from16 v14, v32

    move/from16 v0, v33

    move/from16 v7, v35

    move/from16 v5, v36

    move/from16 v8, v37

    goto/16 :goto_c

    .line 1502
    :cond_1c
    move-wide/from16 v25, p6

    move/from16 v33, v0

    move/from16 v36, v5

    move/from16 v35, v7

    move/from16 v37, v8

    move/from16 v31, v11

    move/from16 v32, v14

    move-object v14, v4

    if-nez v20, :cond_1d

    .line 1503
    move/from16 v15, v31

    move/from16 v0, v37

    const/4 v1, 0x0

    invoke-static {v1, v15, v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1504
    return-object v24

    .line 1506
    :cond_1d
    move/from16 v15, v31

    move/from16 v0, v37

    move-object/from16 v1, p0

    move/from16 v4, v35

    move/from16 v5, v36

    invoke-static {v1, v2, v3, v4, v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->unpackRawAuto([BIIII)[I

    move-result-object v1

    .line 1507
    if-nez v1, :cond_1e

    .line 1508
    const/4 v1, 0x0

    invoke-static {v1, v15, v0}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1509
    return-object v24

    .line 1511
    :cond_1e
    cmp-long v4, v27, v9

    if-lez v4, :cond_1f

    goto :goto_12

    :cond_1f
    const-wide/16 v4, 0x1

    add-long v27, v9, v4

    :goto_12
    move-wide/from16 v7, v27

    .line 1512
    move/from16 v31, v0

    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;

    move/from16 v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p5

    move/from16 v12, v19

    move/from16 v11, v21

    move-wide/from16 v9, v25

    move/from16 v38, v31

    move/from16 v13, v32

    invoke-direct/range {v0 .. v13}, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;-><init>([IIII[FFJJIFF)V

    invoke-virtual {v14, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->addFrame(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V

    .line 1515
    invoke-virtual {v14}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_20

    invoke-virtual {v14}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->merge()Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v0

    goto :goto_13

    :cond_20
    move-object/from16 v0, v24

    .line 1516
    :goto_13
    if-eqz v0, :cond_22

    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    if-ge v2, v1, :cond_21

    goto :goto_14

    :cond_21
    const/4 v11, 0x0

    goto :goto_15

    :cond_22
    :goto_14
    move/from16 v11, v33

    :goto_15
    move/from16 v8, v38

    invoke-static {v11, v15, v8}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1517
    return-object v0

    .line 1518
    :catchall_0
    move-exception v0

    goto :goto_16

    :catchall_1
    move-exception v0

    move-object/from16 v24, v14

    .line 1519
    :goto_16
    const/high16 v1, 0x7fc00000    # Float.NaN

    const/4 v2, 0x0

    invoke-static {v2, v1, v1}, Lcom/motorola/camera/custom/MultiFrameBurstController;->recordMergeDiagnostics(ZFF)V

    .line 1520
    const-string v1, "CustomImagingBridge"

    const-string v2, "MultiFrameRaw merge skipped (singleRaw fallback)"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1521
    return-object v24
.end method

.method private static unpackRawAuto([BIIII)[I
    .locals 2

    .line 1526
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    if-gtz p2, :cond_0

    goto :goto_0

    .line 1527
    :cond_0
    array-length v1, p0

    if-lt v1, p4, :cond_1

    .line 1528
    array-length p3, p0

    div-int/2addr p3, p2

    const/4 p4, 0x1

    invoke-static {p0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object p0

    return-object p0

    .line 1530
    :cond_1
    array-length p4, p0

    if-lt p4, p3, :cond_2

    .line 1531
    array-length p3, p0

    div-int/2addr p3, p2

    invoke-static {p0, p1, p2, p3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object p0

    return-object p0

    .line 1533
    :cond_2
    return-object v0

    .line 1526
    :cond_3
    :goto_0
    return-object v0
.end method

.method private static writePublicTelemetrySidecar(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8

    .line 2195
    const-string v0, "is_pending"

    if-eqz p0, :cond_9

    if-eqz p2, :cond_9

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_7

    .line 2196
    :cond_0
    nop

    .line 2198
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2199
    goto :goto_0

    :catchall_0
    move-exception v2

    move-object v2, v1

    .line 2200
    :goto_0
    const-string v3, ".telemetry.json"

    if-eqz v2, :cond_6

    .line 2201
    nop

    .line 2203
    :try_start_1
    const-string v4, "external_primary"

    invoke-static {v4}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    .line 2204
    if-eqz v4, :cond_4

    .line 2205
    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    .line 2206
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

    .line 2207
    const-string v6, "mime_type"

    const-string v7, "application/json"

    invoke-virtual {v5, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2208
    const-string v6, "relative_path"

    const-string v7, "Documents/Edge50Telemetry"

    invoke-virtual {v5, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2209
    const/4 v6, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v0, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2210
    invoke-virtual {v2, v4, v5}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 2211
    if-eqz v4, :cond_4

    .line 2212
    :try_start_2
    invoke-virtual {v2, v4}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 2213
    if-eqz v6, :cond_2

    .line 2214
    :try_start_3
    sget-object v7, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p2, v7}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/OutputStream;->write([B)V

    .line 2215
    invoke-virtual {v6}, Ljava/io/OutputStream;->flush()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    .line 2212
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

    .line 2217
    :cond_2
    :goto_2
    if-eqz v6, :cond_3

    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V

    .line 2218
    :cond_3
    invoke-virtual {v5}, Landroid/content/ContentValues;->clear()V

    .line 2219
    const/4 v6, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v0, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2220
    invoke-virtual {v2, v4, v5, v1, v1}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    goto :goto_3

    .line 2223
    :catchall_3
    move-exception v0

    goto :goto_4

    .line 2228
    :cond_4
    :goto_3
    goto :goto_6

    .line 2223
    :catchall_4
    move-exception v0

    move-object v4, v1

    .line 2224
    :goto_4
    if-eqz v4, :cond_5

    .line 2225
    :try_start_6
    invoke-virtual {v2, v4, v1, v1}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_5

    goto :goto_5

    :catchall_5
    move-exception v1

    .line 2227
    :cond_5
    :goto_5
    const-string v1, "CustomImagingBridge"

    const-string v2, "Public telemetry MediaStore write skipped"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2230
    :cond_6
    :goto_6
    const-string v0, "telemetry"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    .line 2231
    if-eqz p0, :cond_8

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_7

    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2232
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

    .line 2233
    invoke-static {v0, p2}, Lcom/motorola/camera/custom/TelemetryCollector;->writeSidecarJsonIfEnabled(Ljava/io/File;Ljava/lang/String;)Z

    .line 2235
    :cond_8
    return-void

    .line 2195
    :cond_9
    :goto_7
    return-void
.end method
