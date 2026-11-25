.class public final Lcom/motorola/camera/custom/CleanBayerRawProcessor;
.super Ljava/lang/Object;
.source "CleanBayerRawProcessor.java"


# static fields
.field private static final BLUE:I = 0x2

.field private static final CFA:[[I

.field public static final CFA_BGGR:I = 0x3

.field public static final CFA_GBRG:I = 0x2

.field public static final CFA_GRBG:I = 0x1

.field public static final CFA_RGGB:I = 0x0

.field private static final GAMMA_STEPS:I = 0x1000

.field private static final GREEN:I = 0x1

.field private static final RED:I

.field private static final SRGB:[F


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 14
    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x2

    filled-new-array {v0, v1, v1, v2}, [I

    move-result-object v3

    filled-new-array {v1, v0, v2, v1}, [I

    move-result-object v4

    filled-new-array {v1, v2, v0, v1}, [I

    move-result-object v5

    filled-new-array {v2, v1, v1, v0}, [I

    move-result-object v1

    filled-new-array {v3, v4, v5, v1}, [[I

    move-result-object v1

    sput-object v1, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    .line 19
    const/16 v1, 0x1001

    new-array v1, v1, [F

    sput-object v1, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->SRGB:[F

    .line 22
    nop

    :goto_0
    const/16 v1, 0x1000

    if-gt v0, v1, :cond_1

    .line 23
    int-to-double v1, v0

    const-wide/high16 v3, 0x40b0000000000000L    # 4096.0

    div-double/2addr v1, v3

    .line 24
    sget-object v3, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->SRGB:[F

    const-wide v4, 0x3f69a5c37387b719L    # 0.0031308

    cmpg-double v4, v1, v4

    if-gtz v4, :cond_0

    const-wide v4, 0x4029d70a3d70a3d7L    # 12.92

    mul-double/2addr v1, v4

    goto :goto_1

    .line 25
    :cond_0
    const-wide v4, 0x3fdaaaaaaaaaaaabL    # 0.4166666666666667

    invoke-static {v1, v2, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v1

    const-wide v4, 0x3ff0e147ae147ae1L    # 1.055

    mul-double/2addr v1, v4

    const-wide v4, 0x3fac28f5c28f5c29L    # 0.055

    sub-double/2addr v1, v4

    :goto_1
    double-to-float v1, v1

    aput v1, v3, v0

    .line 22
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 27
    :cond_1
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static allocateUnpacked([BIIIJ)[I
    .locals 2

    .line 67
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result p1

    .line 68
    if-eqz p0, :cond_0

    int-to-long v0, p3

    cmp-long p3, v0, p4

    if-ltz p3, :cond_0

    add-int/lit8 p2, p2, -0x1

    int-to-long p2, p2

    mul-long/2addr p2, v0

    add-long/2addr p2, p4

    array-length p0, p0

    int-to-long p4, p0

    cmp-long p0, p2, p4

    if-gtz p0, :cond_0

    .line 71
    new-array p0, p1, [I

    return-object p0

    .line 69
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid RAW buffer or row stride"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static clamp01(F)F
    .locals 2

    .line 473
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    :goto_0
    move p0, v0

    goto :goto_1

    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return p0
.end method

.method private static clampBayerHotPixels([FII)V
    .locals 18

    .line 217
    invoke-virtual/range {p0 .. p0}, [F->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    .line 218
    mul-int/lit8 v1, p1, 0x2

    .line 219
    const/4 v2, 0x2

    move v3, v2

    :goto_0
    add-int/lit8 v4, p2, -0x2

    if-ge v3, v4, :cond_3

    .line 220
    mul-int v4, v3, p1

    .line 221
    move v5, v2

    :goto_1
    add-int/lit8 v6, p1, -0x2

    if-ge v5, v6, :cond_2

    .line 222
    add-int v6, v4, v5

    .line 223
    aget v7, v0, v6

    .line 224
    sub-int v8, v6, v1

    add-int/lit8 v9, v8, -0x2

    aget v9, v0, v9

    aget v10, v0, v8

    add-int/2addr v8, v2

    aget v8, v0, v8

    .line 225
    add-int/lit8 v11, v6, -0x2

    aget v11, v0, v11

    add-int/lit8 v12, v6, 0x2

    aget v12, v0, v12

    .line 226
    add-int v13, v6, v1

    add-int/lit8 v14, v13, -0x2

    aget v14, v0, v14

    aget v15, v0, v13

    add-int/2addr v13, v2

    aget v13, v0, v13

    .line 227
    invoke-static {v9, v10}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move-object/from16 v16, v0

    invoke-static {v8, v11}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 228
    invoke-static {v12, v14}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move/from16 v17, v1

    invoke-static {v15, v13}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 227
    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 229
    invoke-static {v9, v10}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v8, v11}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 230
    invoke-static {v12, v14}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v15, v13}, Ljava/lang/Math;->min(FF)F

    move-result v8

    invoke-static {v2, v8}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 229
    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 231
    const/high16 v2, 0x3fe00000    # 1.75f

    mul-float/2addr v2, v0

    const v8, 0x3ca3d70a    # 0.02f

    add-float/2addr v2, v8

    cmpl-float v2, v7, v2

    if-lez v2, :cond_0

    .line 232
    aput v0, p0, v6

    goto :goto_2

    .line 233
    :cond_0
    const v0, 0x3ecccccd    # 0.4f

    mul-float/2addr v0, v1

    cmpg-float v0, v7, v0

    if-gez v0, :cond_1

    const v0, 0x3d23d70a    # 0.04f

    cmpl-float v0, v1, v0

    if-lez v0, :cond_1

    .line 234
    aput v1, p0, v6

    .line 221
    :cond_1
    :goto_2
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v0, v16

    move/from16 v1, v17

    const/4 v2, 0x2

    goto/16 :goto_1

    .line 219
    :cond_2
    move-object/from16 v16, v0

    move/from16 v17, v1

    add-int/lit8 v3, v3, 0x1

    const/4 v2, 0x2

    goto/16 :goto_0

    .line 238
    :cond_3
    return-void
.end method

.method private static demosaicMalvar([FII[I[D[F[F[F)V
    .locals 38

    .line 242
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_13

    .line 243
    if-nez v3, :cond_0

    move v4, v0

    goto :goto_1

    :cond_0
    neg-int v4, v0

    .line 244
    :goto_1
    add-int/lit8 v5, v1, -0x1

    if-ne v3, v5, :cond_1

    neg-int v5, v0

    goto :goto_2

    :cond_1
    move v5, v0

    .line 245
    :goto_2
    mul-int v6, v3, v0

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v0, :cond_12

    .line 246
    const/4 v8, -0x1

    const/4 v9, 0x1

    if-nez v7, :cond_2

    move v10, v9

    goto :goto_4

    :cond_2
    move v10, v8

    .line 247
    :goto_4
    add-int/lit8 v11, v0, -0x1

    if-ne v7, v11, :cond_3

    goto :goto_5

    :cond_3
    move v8, v9

    .line 248
    :goto_5
    and-int/lit8 v11, v3, 0x1

    shl-int/2addr v11, v9

    and-int/lit8 v12, v7, 0x1

    or-int/2addr v11, v12

    .line 249
    aget v12, p3, v11

    .line 250
    aget v13, p0, v6

    float-to-double v13, v13

    .line 251
    add-int v15, v6, v10

    aget v15, p0, v15

    move/from16 v17, v10

    float-to-double v9, v15

    add-int v15, v6, v8

    aget v15, p0, v15

    move/from16 v19, v3

    const/16 v18, 0x0

    float-to-double v2, v15

    add-double/2addr v9, v2

    .line 252
    add-int v2, v6, v4

    aget v3, p0, v2

    float-to-double v0, v3

    add-int v3, v6, v5

    aget v15, p0, v3

    move-wide/from16 v20, v0

    float-to-double v0, v15

    add-double v0, v20, v0

    .line 253
    add-int v15, v2, v17

    aget v15, p0, v15

    move-wide/from16 v20, v0

    float-to-double v0, v15

    add-int/2addr v2, v8

    aget v2, p0, v2

    move-wide/from16 v22, v0

    float-to-double v0, v2

    add-double v0, v22, v0

    add-int v2, v3, v17

    aget v2, p0, v2

    move-wide/from16 v22, v0

    float-to-double v0, v2

    add-double v0, v22, v0

    add-int/2addr v3, v8

    aget v2, p0, v3

    float-to-double v2, v2

    add-double/2addr v0, v2

    .line 255
    const/4 v2, 0x2

    if-lt v7, v2, :cond_4

    add-int/lit8 v3, p1, -0x2

    if-ge v7, v3, :cond_4

    move/from16 v3, v19

    if-lt v3, v2, :cond_5

    add-int/lit8 v8, p2, -0x2

    if-ge v3, v8, :cond_5

    const/4 v8, 0x1

    goto :goto_6

    :cond_4
    move/from16 v3, v19

    :cond_5
    move/from16 v8, v18

    .line 256
    :goto_6
    move/from16 v19, v3

    if-eqz v8, :cond_6

    add-int/lit8 v17, v6, -0x2

    aget v15, p0, v17

    float-to-double v2, v15

    add-int/lit8 v15, v6, 0x2

    aget v15, p0, v15

    move-wide/from16 v24, v0

    float-to-double v0, v15

    add-double/2addr v0, v2

    goto :goto_7

    :cond_6
    move-wide/from16 v24, v0

    const-wide/16 v0, 0x0

    .line 257
    :goto_7
    if-eqz v8, :cond_7

    mul-int/lit8 v2, p1, 0x2

    sub-int v3, v6, v2

    aget v3, p0, v3

    move-wide/from16 v26, v0

    float-to-double v0, v3

    add-int/2addr v2, v6

    aget v2, p0, v2

    float-to-double v2, v2

    add-double/2addr v0, v2

    goto :goto_8

    :cond_7
    move-wide/from16 v26, v0

    const-wide/16 v0, 0x0

    .line 260
    :goto_8
    const-wide/high16 v2, 0x4020000000000000L    # 8.0

    const-wide/high16 v28, 0x4000000000000000L    # 2.0

    const-wide/high16 v30, 0x4010000000000000L    # 4.0

    const/4 v15, 0x1

    if-ne v12, v15, :cond_d

    .line 261
    nop

    .line 262
    const-wide/high16 v32, 0x3fe0000000000000L    # 0.5

    const-wide/high16 v34, 0x4014000000000000L    # 5.0

    if-eqz v8, :cond_8

    mul-double v36, v13, v34

    mul-double v9, v9, v30

    add-double v36, v36, v9

    sub-double v36, v36, v24

    sub-double v36, v36, v26

    mul-double v9, v0, v32

    add-double v36, v36, v9

    div-double v36, v36, v2

    goto :goto_9

    :cond_8
    div-double v36, v9, v28

    .line 263
    :goto_9
    if-eqz v8, :cond_9

    mul-double v34, v34, v13

    mul-double v8, v20, v30

    add-double v34, v34, v8

    sub-double v34, v34, v24

    sub-double v34, v34, v0

    mul-double v0, v26, v32

    add-double v34, v34, v0

    div-double v34, v34, v2

    goto :goto_a

    :cond_9
    div-double v34, v20, v28

    .line 264
    :goto_a
    xor-int/lit8 v0, v11, 0x1

    aget v0, p3, v0

    if-nez v0, :cond_a

    const/4 v15, 0x1

    goto :goto_b

    :cond_a
    move/from16 v15, v18

    .line 265
    :goto_b
    if-eqz v15, :cond_b

    move-wide/from16 v0, v36

    goto :goto_c

    :cond_b
    move-wide/from16 v0, v34

    .line 266
    :goto_c
    if-eqz v15, :cond_c

    move-wide/from16 v36, v34

    .line 267
    :cond_c
    goto :goto_11

    .line 268
    :cond_d
    if-eqz v8, :cond_e

    mul-double v32, v13, v30

    add-double v9, v9, v20

    mul-double v9, v9, v28

    add-double v32, v32, v9

    sub-double v32, v32, v26

    sub-double v32, v32, v0

    div-double v32, v32, v2

    goto :goto_d

    :cond_e
    add-double v9, v9, v20

    div-double v32, v9, v30

    .line 269
    :goto_d
    if-eqz v8, :cond_f

    const-wide/high16 v8, 0x4018000000000000L    # 6.0

    mul-double/2addr v8, v13

    mul-double v10, v24, v28

    add-double/2addr v8, v10

    const-wide/high16 v10, 0x3ff8000000000000L    # 1.5

    add-double v0, v26, v0

    mul-double/2addr v0, v10

    sub-double/2addr v8, v0

    div-double/2addr v8, v2

    goto :goto_e

    :cond_f
    div-double v8, v24, v30

    .line 270
    :goto_e
    if-nez v12, :cond_10

    move-wide v0, v13

    goto :goto_f

    :cond_10
    move-wide v0, v8

    .line 271
    :goto_f
    const/4 v15, 0x2

    if-ne v12, v15, :cond_11

    goto :goto_10

    :cond_11
    move-wide v13, v8

    :goto_10
    move-wide/from16 v36, v13

    move-wide/from16 v13, v32

    .line 273
    :goto_11
    aget-wide v2, p4, v18

    mul-double/2addr v2, v0

    const/16 v16, 0x1

    aget-wide v8, p4, v16

    mul-double/2addr v8, v13

    add-double/2addr v2, v8

    const/4 v15, 0x2

    aget-wide v8, p4, v15

    mul-double v8, v8, v36

    add-double/2addr v2, v8

    const-wide/16 v8, 0x0

    invoke-static {v8, v9, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v2

    double-to-float v2, v2

    aput v2, p5, v6

    .line 274
    const/4 v2, 0x3

    aget-wide v2, p4, v2

    mul-double/2addr v2, v0

    const/4 v8, 0x4

    aget-wide v8, p4, v8

    mul-double/2addr v8, v13

    add-double/2addr v2, v8

    const/4 v8, 0x5

    aget-wide v8, p4, v8

    mul-double v8, v8, v36

    add-double/2addr v2, v8

    const-wide/16 v8, 0x0

    invoke-static {v8, v9, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v2

    double-to-float v2, v2

    aput v2, p6, v6

    .line 275
    const/4 v2, 0x6

    aget-wide v2, p4, v2

    mul-double/2addr v2, v0

    const/4 v0, 0x7

    aget-wide v0, p4, v0

    mul-double/2addr v0, v13

    add-double/2addr v2, v0

    const/16 v0, 0x8

    aget-wide v0, p4, v0

    mul-double v0, v0, v36

    add-double/2addr v2, v0

    const-wide/16 v8, 0x0

    invoke-static {v8, v9, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v0

    double-to-float v0, v0

    aput v0, p7, v6

    .line 245
    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    move/from16 v3, v19

    goto/16 :goto_3

    .line 242
    :cond_12
    move/from16 v19, v3

    const/16 v18, 0x0

    add-int/lit8 v3, v19, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_0

    .line 278
    :cond_13
    return-void
.end method

.method public static dualIlluminantSensorToOutputCcm([FI[FIFZ)[F
    .locals 8

    .line 680
    if-eqz p0, :cond_4

    array-length v0, p0

    const/16 v1, 0x9

    if-ge v0, v1, :cond_0

    goto/16 :goto_1

    .line 681
    :cond_0
    invoke-virtual {p0}, [F->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    .line 682
    invoke-static {p1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->illuminantCodeToKelvin(I)F

    move-result p1

    .line 683
    invoke-static {p3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->illuminantCodeToKelvin(I)F

    move-result p3

    .line 684
    if-eqz p2, :cond_3

    array-length v2, p2

    if-lt v2, v1, :cond_3

    const/4 v2, 0x0

    cmpl-float v3, p1, v2

    if-lez v3, :cond_3

    cmpl-float v2, p3, v2

    if-lez v2, :cond_3

    sub-float v2, p1, p3

    .line 685
    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    const/high16 v3, 0x42c80000    # 100.0f

    cmpl-float v2, v2, v3

    if-lez v2, :cond_3

    .line 686
    invoke-static {p4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v2

    if-eqz v2, :cond_3

    const v2, 0x44bb8000    # 1500.0f

    cmpl-float v2, p4, v2

    if-ltz v2, :cond_3

    const v2, 0x466a6000    # 15000.0f

    cmpg-float v2, p4, v2

    if-gtz v2, :cond_3

    .line 687
    float-to-double v2, p1

    const-wide v4, 0x412e848000000000L    # 1000000.0

    div-double v2, v4, v2

    .line 688
    float-to-double v6, p3

    div-double v6, v4, v6

    .line 689
    float-to-double p3, p4

    div-double/2addr v4, p3

    .line 690
    sub-double/2addr v4, v2

    sub-double/2addr v6, v2

    div-double/2addr v4, v6

    .line 691
    const-wide/16 p3, 0x0

    cmpg-double p1, v4, p3

    if-gez p1, :cond_1

    move-wide v4, p3

    .line 692
    :cond_1
    const-wide/high16 p3, 0x3ff0000000000000L    # 1.0

    cmpl-double p1, v4, p3

    if-lez p1, :cond_2

    move-wide v4, p3

    .line 693
    :cond_2
    const/4 p1, 0x0

    :goto_0
    if-ge p1, v1, :cond_3

    .line 694
    sub-double v2, p3, v4

    aget v6, p0, p1

    float-to-double v6, v6

    mul-double/2addr v2, v6

    aget v6, p2, p1

    float-to-double v6, v6

    mul-double/2addr v6, v4

    add-double/2addr v2, v6

    double-to-float v2, v2

    aput v2, v0, p1

    .line 693
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 697
    :cond_3
    invoke-static {v0, p5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->invertXyzToSensorIntoGamut([FZ)[F

    move-result-object p0

    return-object p0

    .line 680
    :cond_4
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method

.method private static encode(D)F
    .locals 5

    .line 617
    const-wide/16 v0, 0x0

    cmpg-double v0, p0, v0

    if-gtz v0, :cond_0

    .line 618
    const/4 p0, 0x0

    return p0

    .line 620
    :cond_0
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_1

    .line 621
    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 623
    :cond_1
    const-wide/high16 v0, 0x40b0000000000000L    # 4096.0

    mul-double/2addr p0, v0

    .line 624
    double-to-int v0, p0

    .line 625
    sget-object v1, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->SRGB:[F

    aget v1, v1, v0

    float-to-double v1, v1

    int-to-double v3, v0

    sub-double/2addr p0, v3

    sget-object v3, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->SRGB:[F

    add-int/lit8 v4, v0, 0x1

    aget v3, v3, v4

    sget-object v4, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->SRGB:[F

    aget v0, v4, v0

    sub-float/2addr v3, v0

    float-to-double v3, v3

    mul-double/2addr p0, v3

    add-double/2addr v1, p0

    double-to-float p0, v1

    return p0
.end method

.method public static illuminantCodeToKelvin(I)F
    .locals 0

    .line 657
    sparse-switch p0, :sswitch_data_0

    .line 669
    const/high16 p0, -0x40800000    # -1.0f

    return p0

    .line 662
    :sswitch_0
    const p0, 0x459c5800    # 5003.0f

    return p0

    .line 668
    :sswitch_1
    const p0, 0x45ea8000    # 7504.0f

    return p0

    .line 663
    :sswitch_2
    const p0, 0x45abf800    # 5503.0f

    return p0

    .line 667
    :sswitch_3
    const p0, 0x45d3b000    # 6774.0f

    return p0

    .line 661
    :sswitch_4
    const p0, 0x45985000    # 4874.0f

    return p0

    .line 658
    :sswitch_5
    const p0, 0x45328000    # 2856.0f

    return p0

    .line 659
    :sswitch_6
    const p0, 0x4557a000    # 3450.0f

    return p0

    .line 660
    :sswitch_7
    const p0, 0x45843000    # 4230.0f

    return p0

    .line 664
    :sswitch_8
    const p0, 0x45c8f000    # 6430.0f

    return p0

    .line 666
    :sswitch_9
    const p0, 0x45cb4000    # 6504.0f

    return p0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_9
        0xc -> :sswitch_8
        0xe -> :sswitch_7
        0xf -> :sswitch_6
        0x11 -> :sswitch_5
        0x12 -> :sswitch_4
        0x13 -> :sswitch_3
        0x14 -> :sswitch_2
        0x15 -> :sswitch_9
        0x16 -> :sswitch_1
        0x17 -> :sswitch_0
    .end sparse-switch
.end method

.method public static invertXyzToSensorIntoGamut([FZ)[F
    .locals 42

    .line 701
    move-object/from16 v0, p0

    if-eqz v0, :cond_6

    array-length v2, v0

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    const/16 v16, 0x0

    goto/16 :goto_4

    .line 702
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    float-to-double v4, v4

    const/4 v6, 0x1

    aget v7, v0, v6

    float-to-double v7, v7

    const/4 v9, 0x2

    aget v10, v0, v9

    float-to-double v10, v10

    .line 703
    const/4 v12, 0x3

    aget v13, v0, v12

    float-to-double v13, v13

    const/4 v15, 0x4

    const/16 v16, 0x0

    aget v1, v0, v15

    move/from16 v17, v6

    move-wide/from16 v18, v7

    float-to-double v6, v1

    const/4 v1, 0x5

    aget v8, v0, v1

    move/from16 v21, v1

    move/from16 v20, v2

    float-to-double v1, v8

    .line 704
    const/16 v22, 0x6

    aget v8, v0, v22

    move/from16 v23, v9

    move-wide/from16 v24, v10

    float-to-double v9, v8

    const/4 v8, 0x7

    aget v11, v0, v8

    move-wide/from16 v26, v9

    move v10, v8

    float-to-double v8, v11

    const/16 v11, 0x8

    aget v0, v0, v11

    move/from16 v28, v10

    move/from16 v29, v11

    float-to-double v10, v0

    .line 705
    mul-double v30, v6, v10

    mul-double v32, v1, v8

    sub-double v30, v30, v32

    mul-double v32, v13, v10

    mul-double v34, v1, v26

    move v0, v12

    move-wide/from16 v36, v13

    sub-double v12, v32, v34

    neg-double v12, v12

    mul-double v32, v36, v8

    mul-double v34, v6, v26

    sub-double v32, v32, v34

    .line 706
    mul-double v34, v18, v10

    mul-double v38, v24, v8

    move/from16 p0, v0

    move-wide/from16 v40, v1

    sub-double v0, v34, v38

    neg-double v0, v0

    mul-double/2addr v10, v4

    mul-double v34, v24, v26

    sub-double v10, v10, v34

    mul-double/2addr v8, v4

    mul-double v26, v26, v18

    sub-double v8, v8, v26

    neg-double v8, v8

    .line 707
    mul-double v26, v18, v40

    mul-double v34, v24, v6

    sub-double v26, v26, v34

    mul-double v34, v4, v40

    mul-double v38, v24, v36

    move-wide/from16 v40, v4

    sub-double v3, v34, v38

    neg-double v3, v3

    mul-double v5, v40, v6

    mul-double v34, v18, v36

    sub-double v5, v5, v34

    .line 708
    mul-double v34, v40, v30

    mul-double v18, v18, v12

    add-double v34, v34, v18

    mul-double v18, v24, v32

    add-double v34, v34, v18

    .line 709
    invoke-static/range {v34 .. v35}, Ljava/lang/Double;->isFinite(D)Z

    move-result v7

    if-eqz v7, :cond_5

    invoke-static/range {v34 .. v35}, Ljava/lang/Math;->abs(D)D

    move-result-wide v18

    const-wide v24, 0x3eb0c6f7a0b5ed8dL    # 1.0E-6

    cmpg-double v7, v18, v24

    if-gez v7, :cond_1

    goto/16 :goto_3

    .line 710
    :cond_1
    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    div-double v18, v18, v34

    .line 711
    mul-double v30, v30, v18

    mul-double v0, v0, v18

    mul-double v26, v26, v18

    mul-double v12, v12, v18

    mul-double v10, v10, v18

    mul-double v3, v3, v18

    mul-double v32, v32, v18

    mul-double v8, v8, v18

    mul-double v5, v5, v18

    const/16 v2, 0x9

    new-array v7, v2, [D

    aput-wide v30, v7, v20

    aput-wide v0, v7, v17

    aput-wide v26, v7, v23

    aput-wide v12, v7, p0

    aput-wide v10, v7, v15

    aput-wide v3, v7, v21

    aput-wide v32, v7, v22

    aput-wide v8, v7, v28

    aput-wide v5, v7, v29

    .line 716
    if-eqz p1, :cond_2

    const/16 v2, 0x9

    new-array v0, v2, [D

    const-wide v3, 0x4003f2ae80b16b47L    # 2.4934969

    aput-wide v3, v0, v20

    const-wide v3, -0x4012321b053f0422L    # -0.9313836

    aput-wide v3, v0, v17

    const-wide v3, -0x402639fc7b104197L    # -0.4027108

    aput-wide v3, v0, v23

    const-wide v3, -0x401574d37c1376d5L    # -0.829489

    aput-wide v3, v0, p0

    const-wide v3, 0x3ffc33df45755517L    # 1.7626641

    aput-wide v3, v0, v15

    const-wide v3, 0x3f983112c782e0f0L    # 0.0236247

    aput-wide v3, v0, v21

    const-wide v3, 0x3fa25a617565ddaaL    # 0.0358458

    aput-wide v3, v0, v22

    const-wide v3, -0x404c7ff73124653aL    # -0.0761724

    aput-wide v3, v0, v28

    const-wide v3, 0x3fee9ecc3e3193f7L    # 0.9568845

    aput-wide v3, v0, v29

    goto :goto_0

    .line 720
    :cond_2
    const/16 v2, 0x9

    new-array v0, v2, [D

    const-wide v3, 0x4009ecbfb15b573fL    # 3.2406

    aput-wide v3, v0, v20

    const-wide v3, -0x400767a0f9096bbaL    # -1.5372

    aput-wide v3, v0, v17

    const-wide v3, -0x402016f0068db8bbL    # -0.4986

    aput-wide v3, v0, v23

    const-wide v3, -0x4010fec56d5cfaadL    # -0.9689

    aput-wide v3, v0, p0

    const-wide v3, 0x3ffe0346dc5d6388L    # 1.8758

    aput-wide v3, v0, v15

    const-wide v3, 0x3fa53f7ced916873L    # 0.0415

    aput-wide v3, v0, v21

    const-wide v3, 0x3fac84b5dcc63f14L    # 0.0557

    aput-wide v3, v0, v22

    const-wide v3, -0x4035e353f7ced917L    # -0.204

    aput-wide v3, v0, v28

    const-wide v3, 0x3ff0e978d4fdf3b6L    # 1.057

    aput-wide v3, v0, v29

    .line 725
    :goto_0
    const/16 v2, 0x9

    new-array v1, v2, [F

    .line 726
    move/from16 v2, v20

    :goto_1
    move/from16 v3, p0

    if-ge v2, v3, :cond_4

    .line 727
    move/from16 v4, v20

    :goto_2
    if-ge v4, v3, :cond_3

    .line 728
    mul-int/lit8 v5, v2, 0x3

    add-int v6, v5, v4

    aget-wide v8, v0, v5

    aget-wide v10, v7, v4

    mul-double/2addr v8, v10

    add-int/lit8 v10, v5, 0x1

    aget-wide v10, v0, v10

    add-int/lit8 v12, v4, 0x3

    aget-wide v12, v7, v12

    mul-double/2addr v10, v12

    add-double/2addr v8, v10

    add-int/lit8 v5, v5, 0x2

    aget-wide v10, v0, v5

    add-int/lit8 v5, v4, 0x6

    aget-wide v12, v7, v5

    mul-double/2addr v10, v12

    add-double/2addr v8, v10

    double-to-float v5, v8

    aput v5, v1, v6

    .line 727
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 726
    :cond_3
    add-int/lit8 v2, v2, 0x1

    move/from16 p0, v3

    goto :goto_1

    .line 733
    :cond_4
    return-object v1

    .line 709
    :cond_5
    :goto_3
    return-object v16

    .line 701
    :cond_6
    const/16 v16, 0x0

    :goto_4
    return-object v16
.end method

.method private static normalizedMatrix([F)[D
    .locals 13

    .line 600
    const/16 v0, 0x9

    new-array v1, v0, [D

    const/4 v2, 0x0

    const-wide/high16 v3, 0x3ff0000000000000L    # 1.0

    aput-wide v3, v1, v2

    const/4 v5, 0x1

    const-wide/16 v6, 0x0

    aput-wide v6, v1, v5

    const/4 v5, 0x2

    aput-wide v6, v1, v5

    const/4 v5, 0x3

    aput-wide v6, v1, v5

    const/4 v5, 0x4

    aput-wide v3, v1, v5

    const/4 v5, 0x5

    aput-wide v6, v1, v5

    const/4 v5, 0x6

    aput-wide v6, v1, v5

    const/4 v5, 0x7

    aput-wide v6, v1, v5

    const/16 v5, 0x8

    aput-wide v3, v1, v5

    .line 601
    if-eqz p0, :cond_1

    array-length v3, p0

    if-ne v3, v0, :cond_1

    .line 602
    nop

    :goto_0
    if-ge v2, v0, :cond_1

    .line 603
    aget v3, p0, v2

    float-to-double v3, v3

    add-int/lit8 v5, v2, 0x1

    aget v6, p0, v5

    float-to-double v6, v6

    add-double/2addr v3, v6

    add-int/lit8 v6, v2, 0x2

    aget v7, p0, v6

    float-to-double v7, v7

    add-double/2addr v3, v7

    .line 604
    aget v7, p0, v2

    float-to-double v7, v7

    invoke-static {v7, v8}, Ljava/lang/Math;->abs(D)D

    move-result-wide v7

    aget v9, p0, v5

    float-to-double v9, v9

    invoke-static {v9, v10}, Ljava/lang/Math;->abs(D)D

    move-result-wide v9

    add-double/2addr v7, v9

    aget v9, p0, v6

    float-to-double v9, v9

    .line 605
    invoke-static {v9, v10}, Ljava/lang/Math;->abs(D)D

    move-result-wide v9

    add-double/2addr v7, v9

    .line 606
    invoke-static {v3, v4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v9

    if-eqz v9, :cond_0

    invoke-static {v3, v4}, Ljava/lang/Math;->abs(D)D

    move-result-wide v9

    const-wide v11, 0x3eb0c6f7a0b5ed8dL    # 1.0E-6

    mul-double/2addr v7, v11

    const-wide v11, 0x3e45798ee2308c3aL    # 1.0E-8

    invoke-static {v11, v12, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    cmpl-double v7, v9, v7

    if-lez v7, :cond_0

    .line 607
    aget v7, p0, v2

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v2

    .line 608
    aget v7, p0, v5

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v5

    .line 609
    aget v5, p0, v6

    float-to-double v7, v5

    div-double/2addr v7, v3

    aput-wide v7, v1, v6

    .line 602
    :cond_0
    add-int/lit8 v2, v2, 0x3

    goto :goto_0

    .line 613
    :cond_1
    return-object v1
.end method

.method private static pack(FFF)I
    .locals 2

    .line 651
    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p0, v0

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    shl-int/lit8 p0, p0, 0x10

    const/high16 v1, -0x1000000

    or-int/2addr p0, v1

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    shl-int/lit8 p1, p1, 0x8

    or-int/2addr p0, p1

    mul-float/2addr p2, v0

    .line 652
    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p1

    or-int/2addr p0, p1

    .line 651
    return p0
.end method

.method private static pixelCount(II)I
    .locals 4

    .line 75
    int-to-long v0, p0

    int-to-long v2, p1

    mul-long/2addr v0, v2

    .line 76
    if-lez p0, :cond_0

    if-lez p1, :cond_0

    const-wide/32 p0, 0x7fffffff

    cmp-long p0, v0, p0

    if-gtz p0, :cond_0

    .line 79
    long-to-int p0, v0

    return p0

    .line 77
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid image dimensions"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static processRawToArgb([IIII[FF[F[FF)[I
    .locals 49

    .line 483
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result v6

    .line 484
    const/4 v7, 0x2

    if-lt v1, v7, :cond_1f

    if-lt v2, v7, :cond_1f

    if-eqz v0, :cond_1f

    array-length v8, v0

    if-lt v8, v6, :cond_1f

    if-ltz v3, :cond_1f

    const/4 v8, 0x3

    if-gt v3, v8, :cond_1f

    if-eqz v4, :cond_1f

    array-length v9, v4

    const/4 v10, 0x4

    if-ne v9, v10, :cond_1f

    if-eqz v5, :cond_1f

    array-length v9, v5

    if-ne v9, v8, :cond_1f

    .line 488
    invoke-static/range {p5 .. p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    invoke-static/range {p8 .. p8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    .line 491
    sget-object v9, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    aget-object v3, v9, v3

    .line 492
    new-array v9, v10, [D

    .line 493
    const/4 v12, 0x0

    :goto_0
    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    move v15, v8

    move-object/from16 p3, v9

    if-ge v12, v10, :cond_1

    .line 494
    move/from16 v16, v10

    move/from16 v18, v12

    const/16 v17, 0x0

    move/from16 v10, p5

    float-to-double v11, v10

    move/from16 v19, v15

    aget v15, v4, v18

    const-wide/16 v21, 0x0

    float-to-double v7, v15

    sub-double/2addr v11, v7

    .line 495
    cmpg-double v7, v11, v21

    if-lez v7, :cond_0

    invoke-static {v11, v12}, Ljava/lang/Double;->isFinite(D)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 498
    div-double/2addr v13, v11

    aput-wide v13, p3, v18

    .line 493
    add-int/lit8 v12, v18, 0x1

    move-object/from16 v9, p3

    move/from16 v10, v16

    move/from16 v8, v19

    const/4 v7, 0x2

    goto :goto_0

    .line 496
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White level must exceed each finite black level"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 500
    :cond_1
    move/from16 v16, v10

    move/from16 v19, v15

    const/16 v17, 0x0

    const-wide/16 v21, 0x0

    array-length v7, v5

    move/from16 v8, v17

    :goto_1
    const/4 v9, 0x0

    if-ge v8, v7, :cond_3

    aget v10, v5, v8

    .line 501
    invoke-static {v10}, Ljava/lang/Float;->isFinite(F)Z

    move-result v11

    if-eqz v11, :cond_2

    cmpg-float v9, v10, v9

    if-ltz v9, :cond_2

    .line 500
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 502
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White balance gains must be finite and nonnegative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 506
    :cond_3
    new-array v7, v6, [F

    .line 507
    move/from16 v8, v17

    :goto_2
    const/4 v10, 0x1

    if-ge v8, v2, :cond_5

    .line 508
    and-int/lit8 v11, v8, 0x1

    shl-int/2addr v11, v10

    .line 509
    mul-int v12, v8, v1

    move/from16 v15, v17

    :goto_3
    if-ge v15, v1, :cond_4

    .line 510
    and-int/lit8 v18, v15, 0x1

    or-int v18, v11, v18

    .line 511
    move/from16 p5, v9

    aget v9, v0, v12

    move/from16 v23, v10

    move/from16 v24, v11

    int-to-double v10, v9

    aget v9, v4, v18

    float-to-double v13, v9

    sub-double/2addr v10, v13

    aget-wide v13, p3, v18

    mul-double/2addr v10, v13

    .line 512
    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    invoke-static {v13, v14, v10, v11}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    move-wide/from16 v13, v21

    invoke-static {v13, v14, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v9

    aget v11, v3, v18

    aget v11, v5, v11

    float-to-double v13, v11

    mul-double/2addr v9, v13

    double-to-float v9, v9

    aput v9, v7, v12

    .line 509
    add-int/lit8 v15, v15, 0x1

    add-int/lit8 v12, v12, 0x1

    move/from16 v9, p5

    move/from16 v10, v23

    move/from16 v11, v24

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_3

    .line 507
    :cond_4
    move/from16 p5, v9

    add-int/lit8 v8, v8, 0x1

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_2

    .line 516
    :cond_5
    move/from16 p5, v9

    move/from16 v23, v10

    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->normalizedMatrix([F)[D

    move-result-object v0

    .line 517
    move-object v4, v0

    new-array v0, v6, [I

    .line 519
    cmpl-float v5, p8, p5

    const/4 v8, 0x0

    if-lez v5, :cond_6

    new-array v9, v6, [F

    goto :goto_4

    :cond_6
    move-object v9, v8

    .line 520
    :goto_4
    if-lez v5, :cond_7

    new-array v10, v6, [F

    goto :goto_5

    :cond_7
    move-object v10, v8

    .line 521
    :goto_5
    if-lez v5, :cond_8

    new-array v11, v6, [F

    goto :goto_6

    :cond_8
    move-object v11, v8

    .line 522
    :goto_6
    if-lez v5, :cond_9

    new-array v8, v6, [F

    :cond_9
    move-object v6, v8

    .line 524
    move/from16 v5, v17

    :goto_7
    if-ge v5, v2, :cond_1d

    .line 525
    if-nez v5, :cond_a

    move v8, v1

    goto :goto_8

    :cond_a
    neg-int v8, v1

    .line 526
    :goto_8
    add-int/lit8 v12, v2, -0x1

    if-ne v5, v12, :cond_b

    neg-int v12, v1

    goto :goto_9

    :cond_b
    move v12, v1

    .line 527
    :goto_9
    mul-int v13, v5, v1

    move/from16 v14, v17

    :goto_a
    if-ge v14, v1, :cond_1c

    .line 528
    if-nez v14, :cond_c

    move/from16 v18, v23

    goto :goto_b

    :cond_c
    const/16 v18, -0x1

    .line 529
    :goto_b
    add-int/lit8 v15, v1, -0x1

    if-ne v14, v15, :cond_d

    const/4 v15, -0x1

    goto :goto_c

    :cond_d
    move/from16 v15, v23

    .line 530
    :goto_c
    and-int/lit8 v24, v5, 0x1

    shl-int/lit8 v24, v24, 0x1

    and-int/lit8 v25, v14, 0x1

    or-int v24, v24, v25

    .line 531
    move-object/from16 v25, v0

    aget v0, v3, v24

    .line 532
    aget v1, v7, v13

    float-to-double v1, v1

    .line 533
    add-int v26, v13, v18

    move-wide/from16 p3, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v26, v13, v15

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-double v1, p5, v1

    .line 534
    add-int v26, v13, v8

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v27, v13, v12

    move-wide/from16 v28, v1

    aget v1, v7, v27

    float-to-double v1, v1

    add-double v1, v28, v1

    .line 535
    add-int v28, v26, v18

    move-wide/from16 v29, v1

    aget v1, v7, v28

    float-to-double v1, v1

    add-int v26, v26, v15

    move-wide/from16 v31, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-double v1, v31, v1

    add-int v18, v27, v18

    move-wide/from16 v31, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-double v1, v31, v1

    add-int v27, v27, v15

    aget v15, v7, v27

    move-wide/from16 v26, v1

    float-to-double v1, v15

    add-double v1, v26, v1

    .line 537
    const/4 v15, 0x2

    if-lt v14, v15, :cond_e

    add-int/lit8 v15, p1, -0x2

    if-ge v14, v15, :cond_e

    const/4 v15, 0x2

    if-lt v5, v15, :cond_e

    add-int/lit8 v15, p2, -0x2

    if-ge v5, v15, :cond_e

    move/from16 v15, v23

    goto :goto_d

    :cond_e
    move/from16 v15, v17

    .line 538
    :goto_d
    nop

    .line 539
    nop

    .line 540
    if-eqz v15, :cond_f

    .line 541
    add-int/lit8 v18, v13, -0x2

    move-wide/from16 v26, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-int/lit8 v18, v13, 0x2

    move-wide/from16 v31, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-double v1, v31, v1

    .line 542
    mul-int/lit8 v18, p1, 0x2

    sub-int v28, v13, v18

    move-wide/from16 v31, v1

    aget v1, v7, v28

    float-to-double v1, v1

    add-int v18, v13, v18

    move-wide/from16 v33, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-double v1, v33, v1

    move-wide/from16 v47, v31

    move-wide/from16 v31, v1

    move-wide/from16 v1, v47

    goto :goto_e

    .line 540
    :cond_f
    move-wide/from16 v26, v1

    const-wide/16 v1, 0x0

    const-wide/16 v31, 0x0

    .line 550
    :goto_e
    const-wide/high16 v33, 0x4020000000000000L    # 8.0

    const-wide/high16 v35, 0x4000000000000000L    # 2.0

    const-wide/high16 v37, 0x4010000000000000L    # 4.0

    move-wide/from16 v39, v1

    move/from16 v1, v23

    if-ne v0, v1, :cond_15

    .line 551
    nop

    .line 552
    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    const-wide/high16 v41, 0x4014000000000000L    # 5.0

    if-eqz v15, :cond_10

    .line 553
    mul-double v43, p3, v41

    mul-double v45, p5, v37

    add-double v43, v43, v45

    sub-double v43, v43, v26

    sub-double v43, v43, v39

    mul-double v45, v31, v0

    add-double v43, v43, v45

    div-double v43, v43, v33

    goto :goto_f

    .line 554
    :cond_10
    div-double v43, p5, v35

    .line 555
    :goto_f
    if-eqz v15, :cond_11

    .line 556
    mul-double v35, p3, v41

    mul-double v28, v29, v37

    add-double v35, v35, v28

    sub-double v35, v35, v26

    sub-double v35, v35, v31

    mul-double v1, v39, v0

    add-double v35, v35, v1

    div-double v35, v35, v33

    goto :goto_10

    .line 557
    :cond_11
    div-double v35, v29, v35

    .line 558
    :goto_10
    xor-int/lit8 v0, v24, 0x1

    aget v0, v3, v0

    if-nez v0, :cond_12

    const/4 v1, 0x1

    goto :goto_11

    :cond_12
    move/from16 v1, v17

    .line 559
    :goto_11
    if-eqz v1, :cond_13

    move-wide/from16 v26, v43

    goto :goto_12

    :cond_13
    move-wide/from16 v26, v35

    .line 560
    :goto_12
    if-eqz v1, :cond_14

    move-wide/from16 v43, v35

    .line 561
    :cond_14
    move-wide/from16 v1, p3

    goto :goto_16

    .line 562
    :cond_15
    if-eqz v15, :cond_16

    mul-double v1, p3, v37

    add-double v28, p5, v29

    mul-double v28, v28, v35

    add-double v1, v1, v28

    sub-double v1, v1, v39

    sub-double v1, v1, v31

    div-double v1, v1, v33

    goto :goto_13

    .line 563
    :cond_16
    add-double v1, p5, v29

    div-double v1, v1, v37

    .line 564
    :goto_13
    if-eqz v15, :cond_17

    const-wide/high16 v28, 0x4018000000000000L    # 6.0

    mul-double v28, v28, p3

    mul-double v26, v26, v35

    add-double v28, v28, v26

    const-wide/high16 v26, 0x3ff8000000000000L    # 1.5

    add-double v30, v39, v31

    mul-double v30, v30, v26

    sub-double v28, v28, v30

    div-double v28, v28, v33

    goto :goto_14

    .line 565
    :cond_17
    div-double v28, v26, v37

    .line 566
    :goto_14
    if-nez v0, :cond_18

    move-wide/from16 v26, p3

    goto :goto_15

    :cond_18
    move-wide/from16 v26, v28

    .line 567
    :goto_15
    const/4 v15, 0x2

    if-ne v0, v15, :cond_19

    move-wide/from16 v28, p3

    :cond_19
    move-wide/from16 v43, v28

    .line 570
    :goto_16
    aget-wide v28, v4, v17

    mul-double v28, v28, v26

    const/16 v23, 0x1

    aget-wide v30, v4, v23

    mul-double v30, v30, v1

    add-double v28, v28, v30

    const/16 v20, 0x2

    aget-wide v30, v4, v20

    mul-double v30, v30, v43

    move-wide/from16 p3, v1

    add-double v0, v28, v30

    .line 571
    aget-wide v28, v4, v19

    mul-double v28, v28, v26

    aget-wide v30, v4, v16

    mul-double v30, v30, p3

    add-double v28, v28, v30

    const/4 v2, 0x5

    aget-wide v30, v4, v2

    mul-double v30, v30, v43

    move-object v15, v3

    add-double v2, v28, v30

    .line 572
    const/16 v18, 0x6

    aget-wide v28, v4, v18

    mul-double v28, v28, v26

    const/16 v18, 0x7

    aget-wide v26, v4, v18

    mul-double v26, v26, p3

    add-double v28, v28, v26

    const/16 v18, 0x8

    aget-wide v26, v4, v18

    mul-double v26, v26, v43

    move-object/from16 p0, v4

    move/from16 v18, v5

    add-double v4, v28, v26

    .line 573
    move-object/from16 p3, v6

    move-object/from16 v24, v7

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    invoke-static {v0, v1, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    .line 574
    nop

    .line 575
    const-wide v26, 0x3fe999999999999aL    # 0.8

    cmpl-double v28, v6, v26

    if-lez v28, :cond_1a

    .line 576
    sub-double v28, v6, v26

    .line 578
    const-wide v30, 0x3fc999999999999aL    # 0.2

    add-double v32, v28, v30

    div-double v28, v28, v32

    mul-double v28, v28, v30

    add-double v28, v28, v26

    div-double v28, v28, v6

    goto :goto_17

    .line 575
    :cond_1a
    const-wide/high16 v28, 0x3ff0000000000000L    # 1.0

    .line 580
    :goto_17
    mul-double v0, v0, v28

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v0

    .line 581
    mul-double v2, v2, v28

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v1

    .line 582
    mul-double v4, v4, v28

    invoke-static {v4, v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v2

    .line 583
    if-nez p3, :cond_1b

    .line 584
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v0

    aput v0, v25, v13

    goto :goto_18

    .line 586
    :cond_1b
    aput v0, v9, v13

    .line 587
    aput v1, v10, v13

    .line 588
    aput v2, v11, v13

    .line 589
    const v3, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v0, v3

    const v3, 0x3f371759    # 0.7152f

    mul-float/2addr v1, v3

    add-float/2addr v0, v1

    const v1, 0x3d93dd98    # 0.0722f

    mul-float/2addr v2, v1

    add-float/2addr v0, v2

    aput v0, p3, v13

    .line 527
    :goto_18
    add-int/lit8 v14, v14, 0x1

    add-int/lit8 v13, v13, 0x1

    move-object/from16 v4, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v6, p3

    move-object v3, v15

    move/from16 v5, v18

    move-object/from16 v7, v24

    move-object/from16 v0, v25

    goto/16 :goto_a

    .line 524
    :cond_1c
    move-object/from16 v25, v0

    move-object v15, v3

    move-object/from16 p0, v4

    move/from16 v18, v5

    move-object/from16 p3, v6

    move-object/from16 v24, v7

    const/16 v20, 0x2

    add-int/lit8 v5, v18, 0x1

    move/from16 v1, p1

    move/from16 v2, p2

    goto/16 :goto_7

    .line 593
    :cond_1d
    move-object/from16 v25, v0

    move-object/from16 p3, v6

    if-eqz p3, :cond_1e

    .line 594
    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v6, p3

    move/from16 v7, p8

    move-object v3, v9

    move-object v4, v10

    move-object v5, v11

    move-object/from16 v0, v25

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->sharpen([III[F[F[F[FF)V

    .line 596
    :cond_1e
    return-object v25

    .line 489
    :cond_1f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid Bayer image or calibration"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static processRawToArgb([IIII[FF[F[FF[FIII)[I
    .locals 14

    .line 91
    const/4 v13, 0x0

    move-object v0, p0

    move v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move-object/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    move/from16 v12, p12

    invoke-static/range {v0 .. v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF[FIII[F)[I

    move-result-object p0

    return-object p0
.end method

.method public static processRawToArgb([IIII[FF[F[FF[FIII[F)[I
    .locals 34

    .line 104
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    move-object/from16 v6, p9

    move/from16 v7, p10

    move/from16 v8, p11

    move-object/from16 v9, p13

    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result v10

    .line 105
    const/4 v11, 0x2

    if-lt v1, v11, :cond_1e

    if-lt v2, v11, :cond_1e

    if-eqz v0, :cond_1e

    array-length v12, v0

    if-lt v12, v10, :cond_1e

    if-ltz v3, :cond_1e

    const/4 v12, 0x3

    if-gt v3, v12, :cond_1e

    if-eqz v4, :cond_1e

    array-length v13, v4

    const/4 v14, 0x4

    if-ne v13, v14, :cond_1e

    if-eqz v5, :cond_1e

    array-length v13, v5

    if-ne v13, v12, :cond_1e

    .line 109
    invoke-static/range {p5 .. p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v13

    if-eqz v13, :cond_1e

    invoke-static/range {p8 .. p8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v13

    if-eqz v13, :cond_1e

    .line 112
    sget-object v13, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    aget-object v13, v13, v3

    .line 113
    new-array v15, v14, [D

    .line 114
    const/16 v16, 0x0

    move/from16 v12, v16

    :goto_0
    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    if-ge v12, v14, :cond_1

    .line 115
    move/from16 v20, v14

    const-wide/16 v21, 0x0

    move/from16 v14, p5

    float-to-double v3, v14

    aget v11, p4, v12

    move-wide/from16 v24, v3

    float-to-double v3, v11

    sub-double v3, v24, v3

    .line 116
    cmpg-double v11, v3, v21

    if-lez v11, :cond_0

    invoke-static {v3, v4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v11

    if-eqz v11, :cond_0

    .line 119
    div-double v3, v18, v3

    aput-wide v3, v15, v12

    .line 114
    add-int/lit8 v12, v12, 0x1

    move/from16 v3, p3

    move-object/from16 v4, p4

    move/from16 v14, v20

    const/4 v11, 0x2

    goto :goto_0

    .line 117
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White level must exceed each finite black level"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 121
    :cond_1
    move/from16 v20, v14

    const-wide/16 v21, 0x0

    array-length v3, v5

    move/from16 v4, v16

    :goto_1
    const/4 v11, 0x0

    if-ge v4, v3, :cond_3

    aget v12, v5, v4

    .line 122
    invoke-static {v12}, Ljava/lang/Float;->isFinite(F)Z

    move-result v14

    if-eqz v14, :cond_2

    cmpg-float v11, v12, v11

    if-ltz v11, :cond_2

    .line 121
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 123
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White balance gains must be finite and nonnegative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 127
    :cond_3
    const/4 v12, 0x1

    if-eqz v6, :cond_4

    const/4 v3, 0x2

    if-lt v7, v3, :cond_4

    if-lt v8, v3, :cond_4

    array-length v3, v6

    mul-int v4, v7, v8

    mul-int/lit8 v4, v4, 0x4

    if-lt v3, v4, :cond_4

    move v3, v12

    goto :goto_2

    :cond_4
    move/from16 v3, v16

    .line 129
    :goto_2
    new-array v0, v10, [F

    .line 130
    move/from16 v4, v16

    :goto_3
    if-ge v4, v2, :cond_10

    .line 131
    and-int/lit8 v14, v4, 0x1

    shl-int/lit8 v24, v14, 0x1

    .line 132
    if-eqz v3, :cond_5

    add-int/lit8 v25, v8, -0x1

    move/from16 p5, v11

    mul-int v11, v4, v25

    int-to-float v11, v11

    move/from16 v25, v3

    add-int/lit8 v3, v2, -0x1

    invoke-static {v12, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v11, v3

    goto :goto_4

    :cond_5
    move/from16 v25, v3

    move/from16 p5, v11

    .line 133
    :goto_4
    if-eqz v25, :cond_6

    add-int/lit8 v3, v8, -0x2

    float-to-int v12, v11

    invoke-static {v3, v12}, Ljava/lang/Math;->min(II)I

    move-result v3

    goto :goto_5

    :cond_6
    move/from16 v3, v16

    .line 134
    :goto_5
    if-eqz v25, :cond_7

    int-to-float v12, v3

    sub-float/2addr v11, v12

    goto :goto_6

    :cond_7
    move/from16 v11, p5

    .line 135
    :goto_6
    mul-int v12, v4, v1

    move/from16 v27, v3

    move/from16 v3, v16

    :goto_7
    if-ge v3, v1, :cond_f

    .line 136
    and-int/lit8 v28, v3, 0x1

    or-int v28, v24, v28

    .line 137
    move/from16 v29, v3

    aget v3, p0, v12

    move/from16 v30, v4

    int-to-double v3, v3

    move-wide/from16 v31, v3

    aget v3, p4, v28

    float-to-double v3, v3

    sub-double v3, v31, v3

    aget-wide v31, v15, v28

    mul-double v3, v3, v31

    .line 138
    move-wide/from16 v5, v18

    invoke-static {v5, v6, v3, v4}, Ljava/lang/Math;->min(DD)D

    move-result-wide v3

    move-wide/from16 v5, v21

    invoke-static {v5, v6, v3, v4}, Ljava/lang/Math;->max(DD)D

    move-result-wide v3

    aget v21, v13, v28

    aget v5, p6, v21

    float-to-double v5, v5

    mul-double/2addr v3, v5

    .line 139
    if-eqz v25, :cond_d

    .line 140
    aget v5, v13, v28

    .line 141
    if-nez v14, :cond_8

    const/4 v6, 0x1

    goto :goto_8

    :cond_8
    move/from16 v6, v16

    :goto_8
    move-wide/from16 v21, v3

    const/4 v4, 0x2

    move/from16 v3, p3

    if-lt v3, v4, :cond_9

    const/4 v4, 0x1

    goto :goto_9

    :cond_9
    move/from16 v4, v16

    :goto_9
    xor-int/2addr v4, v6

    .line 142
    if-nez v5, :cond_a

    move/from16 v4, v16

    goto :goto_a

    :cond_a
    const/4 v6, 0x2

    if-ne v5, v6, :cond_b

    const/4 v4, 0x3

    goto :goto_a

    :cond_b
    if-eqz v4, :cond_c

    const/4 v4, 0x1

    goto :goto_a

    :cond_c
    const/4 v4, 0x2

    .line 143
    :goto_a
    add-int/lit8 v5, v7, -0x1

    mul-int v5, v5, v29

    int-to-float v5, v5

    add-int/lit8 v6, v1, -0x1

    const/4 v8, 0x1

    invoke-static {v8, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    int-to-float v6, v6

    div-float/2addr v5, v6

    .line 144
    add-int/lit8 v6, v7, -0x2

    float-to-int v8, v5

    invoke-static {v6, v8}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 145
    int-to-float v8, v6

    sub-float/2addr v5, v8

    .line 146
    mul-int v8, v27, v7

    add-int/2addr v8, v6

    const/16 v23, 0x2

    shl-int/lit8 v6, v8, 0x2

    add-int/2addr v6, v4

    .line 147
    add-int/lit8 v4, v6, 0x4

    .line 148
    shl-int/lit8 v8, v7, 0x2

    add-int/2addr v8, v6

    .line 149
    add-int/lit8 v28, v8, 0x4

    .line 150
    aget v33, p9, v6

    aget v4, p9, v4

    aget v6, p9, v6

    sub-float/2addr v4, v6

    mul-float/2addr v4, v5

    add-float v33, v33, v4

    .line 151
    aget v4, p9, v8

    aget v6, p9, v28

    aget v8, p9, v8

    sub-float/2addr v6, v8

    mul-float/2addr v6, v5

    add-float/2addr v4, v6

    .line 152
    sub-float v4, v4, v33

    mul-float/2addr v4, v11

    add-float v4, v33, v4

    .line 153
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v5

    if-eqz v5, :cond_e

    cmpl-float v5, v4, p5

    if-lez v5, :cond_e

    .line 154
    const/high16 v5, 0x41000000    # 8.0f

    invoke-static {v5, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const v5, 0x3f4ccccd    # 0.8f

    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    float-to-double v4, v4

    mul-double v4, v4, v21

    goto :goto_b

    .line 139
    :cond_d
    move-wide/from16 v21, v3

    const/16 v23, 0x2

    move/from16 v3, p3

    .line 157
    :cond_e
    move-wide/from16 v4, v21

    :goto_b
    double-to-float v4, v4

    aput v4, v0, v12

    .line 135
    add-int/lit8 v4, v29, 0x1

    add-int/lit8 v12, v12, 0x1

    move-object/from16 v5, p6

    move-object/from16 v6, p9

    move/from16 v8, p11

    move v3, v4

    move/from16 v4, v30

    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto/16 :goto_7

    .line 130
    :cond_f
    move/from16 v3, p3

    move/from16 v30, v4

    const/16 v23, 0x2

    add-int/lit8 v4, v30, 0x1

    move/from16 v11, p5

    move-object/from16 v5, p6

    move-object/from16 v6, p9

    move/from16 v8, p11

    move/from16 v3, v25

    const/4 v12, 0x1

    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto/16 :goto_3

    .line 161
    :cond_10
    move/from16 p5, v11

    const/4 v8, 0x6

    if-lt v1, v8, :cond_11

    if-lt v2, v8, :cond_11

    .line 162
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clampBayerHotPixels([FII)V

    .line 165
    :cond_11
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->normalizedMatrix([F)[D

    move-result-object v4

    .line 166
    new-array v5, v10, [F

    .line 167
    new-array v6, v10, [F

    .line 168
    new-array v7, v10, [F

    .line 169
    move-object v3, v13

    const-wide/16 v11, 0x0

    const-wide/high16 v18, 0x3ff0000000000000L    # 1.0

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->demosaicMalvar([FII[I[D[F[F[F)V

    .line 171
    const/16 v0, 0x96

    move/from16 v3, p12

    if-le v3, v0, :cond_12

    move/from16 v0, v20

    if-lt v1, v0, :cond_12

    if-lt v2, v0, :cond_12

    .line 172
    move v4, v2

    move-object v0, v5

    move-object v2, v7

    move v5, v3

    move v3, v1

    move-object v1, v6

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->smoothChromaByIso([F[F[FIII)V

    move-object v5, v0

    move v1, v3

    move v2, v4

    .line 174
    :cond_12
    if-lt v1, v8, :cond_13

    if-lt v2, v8, :cond_13

    .line 175
    invoke-static {v5, v6, v7, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->suppressDemosaicFringes([F[F[FII)V

    .line 178
    :cond_13
    new-array v0, v10, [I

    .line 179
    cmpl-float v3, p8, p5

    const/4 v4, 0x0

    if-lez v3, :cond_14

    new-array v8, v10, [F

    goto :goto_c

    :cond_14
    move-object v8, v4

    .line 180
    :goto_c
    if-lez v3, :cond_15

    new-array v13, v10, [F

    goto :goto_d

    :cond_15
    move-object v13, v4

    .line 181
    :goto_d
    if-lez v3, :cond_16

    new-array v14, v10, [F

    goto :goto_e

    :cond_16
    move-object v14, v4

    .line 182
    :goto_e
    if-lez v3, :cond_17

    new-array v4, v10, [F

    .line 184
    :cond_17
    if-eqz v9, :cond_18

    array-length v3, v9

    if-lt v3, v10, :cond_18

    const/16 v26, 0x1

    goto :goto_f

    :cond_18
    move/from16 v26, v16

    .line 185
    :goto_f
    move/from16 v3, v16

    :goto_10
    if-ge v3, v10, :cond_1c

    .line 186
    aget v15, v5, v3

    float-to-double v11, v15

    .line 187
    aget v15, v6, v3

    move-object/from16 v16, v0

    float-to-double v0, v15

    .line 188
    aget v15, v7, v3

    move/from16 v17, v3

    float-to-double v2, v15

    .line 189
    move-object/from16 p0, v4

    move-object v15, v5

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    invoke-static {v11, v12, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    .line 190
    if-eqz v26, :cond_19

    .line 191
    move-wide/from16 v23, v0

    move-wide/from16 v20, v2

    const-wide/16 v0, 0x0

    invoke-static {v0, v1, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v2

    double-to-float v2, v2

    aput v2, v9, v17

    goto :goto_11

    .line 190
    :cond_19
    move-wide/from16 v23, v0

    move-wide/from16 v20, v2

    const-wide/16 v0, 0x0

    .line 193
    :goto_11
    nop

    .line 194
    const-wide v2, 0x3feae147ae147ae1L    # 0.84

    cmpl-double v22, v4, v2

    if-lez v22, :cond_1a

    .line 195
    sub-double v27, v4, v2

    .line 196
    const-wide v29, 0x3fc47ae147ae147bL    # 0.16

    add-double v31, v27, v29

    div-double v27, v27, v31

    mul-double v27, v27, v29

    add-double v27, v27, v2

    div-double v3, v27, v4

    goto :goto_12

    .line 194
    :cond_1a
    move-wide/from16 v3, v18

    .line 198
    :goto_12
    mul-double/2addr v11, v3

    invoke-static {v11, v12}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v2

    .line 199
    mul-double v11, v23, v3

    invoke-static {v11, v12}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v5

    .line 200
    mul-double v3, v3, v20

    invoke-static {v3, v4}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v3

    .line 201
    if-nez p0, :cond_1b

    .line 202
    invoke-static {v2, v5, v3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v2

    aput v2, v16, v17

    goto :goto_13

    .line 204
    :cond_1b
    aput v2, v8, v17

    .line 205
    aput v5, v13, v17

    .line 206
    aput v3, v14, v17

    .line 207
    const v4, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v2, v4

    const v4, 0x3f371759    # 0.7152f

    mul-float/2addr v5, v4

    add-float/2addr v2, v5

    const v4, 0x3d93dd98    # 0.0722f

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    aput v2, p0, v17

    .line 185
    :goto_13
    add-int/lit8 v3, v17, 0x1

    move-object/from16 v4, p0

    move/from16 v2, p2

    move-wide v11, v0

    move-object v5, v15

    move-object/from16 v0, v16

    move/from16 v1, p1

    goto/16 :goto_10

    .line 210
    :cond_1c
    move-object/from16 v16, v0

    move-object/from16 p0, v4

    if-eqz p0, :cond_1d

    .line 211
    move-object/from16 v6, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v7, p8

    move-object v3, v8

    move-object v4, v13

    move-object v5, v14

    move-object/from16 v0, v16

    move/from16 v8, p12

    invoke-static/range {v0 .. v8}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->sharpenHeadroomDamped([III[F[F[F[FFI)V

    goto :goto_14

    .line 210
    :cond_1d
    move-object/from16 v0, v16

    .line 213
    :goto_14
    return-object v0

    .line 110
    :cond_1e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid Bayer image or calibration"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static sharpen([III[F[F[F[FF)V
    .locals 17

    .line 630
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_7

    .line 631
    if-nez v3, :cond_0

    const/4 v4, 0x0

    goto :goto_1

    :cond_0
    neg-int v4, v0

    .line 632
    :goto_1
    add-int/lit8 v5, v1, -0x1

    if-ne v3, v5, :cond_1

    const/4 v5, 0x0

    goto :goto_2

    :cond_1
    move v5, v0

    .line 633
    :goto_2
    mul-int v6, v3, v0

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v0, :cond_6

    .line 634
    if-nez v7, :cond_2

    const/4 v8, 0x0

    goto :goto_4

    :cond_2
    const/4 v8, -0x1

    .line 635
    :goto_4
    add-int/lit8 v9, v0, -0x1

    if-ne v7, v9, :cond_3

    const/4 v9, 0x0

    goto :goto_5

    :cond_3
    const/4 v9, 0x1

    .line 636
    :goto_5
    add-int v10, v6, v4

    add-int v11, v10, v8

    aget v11, p6, v11

    aget v12, p6, v10

    add-float/2addr v11, v12

    add-int/2addr v10, v9

    aget v10, p6, v10

    add-float/2addr v11, v10

    add-int v10, v6, v8

    aget v10, p6, v10

    add-float/2addr v11, v10

    aget v10, p6, v6

    add-float/2addr v11, v10

    add-int v10, v6, v9

    aget v10, p6, v10

    add-float/2addr v11, v10

    add-int v10, v6, v5

    add-int/2addr v8, v10

    aget v8, p6, v8

    add-float/2addr v11, v8

    aget v8, p6, v10

    add-float/2addr v11, v8

    add-int/2addr v10, v9

    aget v8, p6, v10

    add-float/2addr v11, v8

    const/high16 v8, 0x41100000    # 9.0f

    div-float/2addr v11, v8

    .line 639
    aget v8, p6, v6

    sub-float/2addr v8, v11

    float-to-double v8, v8

    move/from16 v10, p7

    float-to-double v11, v10

    mul-double/2addr v8, v11

    .line 640
    const-wide/16 v11, 0x0

    cmpl-double v13, v8, v11

    if-lez v13, :cond_4

    aget v13, p3, v6

    aget v14, p4, v6

    aget v15, p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->max(FF)F

    move-result v14

    invoke-static {v13, v14}, Ljava/lang/Math;->max(FF)F

    move-result v13

    const/high16 v14, 0x3f800000    # 1.0f

    sub-float/2addr v14, v13

    float-to-double v13, v14

    goto :goto_6

    .line 641
    :cond_4
    aget v13, p3, v6

    aget v14, p4, v6

    aget v15, p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->min(FF)F

    move-result v14

    invoke-static {v13, v14}, Ljava/lang/Math;->min(FF)F

    move-result v13

    float-to-double v13, v13

    .line 643
    :goto_6
    move/from16 v16, v3

    const-wide v2, 0x3f90101010101010L    # 0.01568627450980392

    invoke-static {v13, v14, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    .line 644
    cmpl-double v13, v2, v11

    if-nez v13, :cond_5

    goto :goto_7

    :cond_5
    mul-double v11, v8, v2

    invoke-static {v8, v9}, Ljava/lang/Math;->abs(D)D

    move-result-wide v8

    add-double/2addr v2, v8

    div-double/2addr v11, v2

    :goto_7
    double-to-float v2, v11

    .line 645
    aget v3, p3, v6

    add-float/2addr v3, v2

    aget v8, p4, v6

    add-float/2addr v8, v2

    aget v9, p5, v6

    add-float/2addr v9, v2

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v2

    aput v2, p0, v6

    .line 633
    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, 0x1

    move/from16 v3, v16

    goto/16 :goto_3

    .line 630
    :cond_6
    move/from16 v10, p7

    move/from16 v16, v3

    add-int/lit8 v3, v16, 0x1

    goto/16 :goto_0

    .line 648
    :cond_7
    return-void
.end method

.method private static sharpenHeadroomDamped([III[F[F[F[FFI)V
    .locals 20

    .line 426
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v2, 0x1

    const/4 v3, -0x1

    const/4 v4, 0x0

    filled-new-array {v3, v4, v3, v2}, [I

    move-result-object v2

    .line 427
    filled-new-array {v4, v3, v3, v3}, [I

    move-result-object v3

    .line 428
    move/from16 v5, p8

    add-int/lit16 v5, v5, -0xc8

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    int-to-float v5, v5

    const/high16 v6, 0x44af0000    # 1400.0f

    div-float/2addr v5, v6

    const/high16 v6, 0x3f800000    # 1.0f

    add-float/2addr v5, v6

    div-float v5, v6, v5

    .line 429
    mul-float v5, v5, p7

    .line 430
    move v7, v4

    :goto_0
    if-ge v7, v1, :cond_b

    .line 431
    mul-int v8, v7, v0

    move v9, v4

    :goto_1
    if-ge v9, v0, :cond_a

    .line 432
    aget v10, p6, v8

    .line 433
    nop

    .line 434
    nop

    .line 435
    nop

    .line 436
    nop

    .line 437
    move v12, v4

    move v15, v10

    move/from16 v17, v15

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/16 v16, 0x0

    :goto_2
    move/from16 p8, v6

    const/4 v6, 0x4

    if-ge v12, v6, :cond_6

    .line 438
    add-int/lit8 v6, v0, -0x1

    aget v18, v2, v12

    const/16 p7, 0x0

    add-int v11, v9, v18

    invoke-static {v6, v11}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-static {v4, v11}, Ljava/lang/Math;->max(II)I

    move-result v11

    .line 439
    add-int/lit8 v4, v1, -0x1

    aget v19, v3, v12

    add-int v0, v7, v19

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 440
    aget v18, v2, v12

    move/from16 v19, v0

    sub-int v0, v9, v18

    invoke-static {v6, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 441
    aget v6, v3, v12

    sub-int v6, v7, v6

    invoke-static {v4, v6}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v1, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 442
    mul-int v6, v19, p1

    add-int/2addr v6, v11

    aget v6, p6, v6

    .line 443
    mul-int v4, v4, p1

    add-int/2addr v4, v0

    aget v0, p6, v4

    .line 444
    cmpg-float v4, v6, v15

    if-gez v4, :cond_0

    move v15, v6

    .line 445
    :cond_0
    cmpg-float v4, v0, v15

    if-gez v4, :cond_1

    move v15, v0

    .line 446
    :cond_1
    cmpl-float v4, v6, v17

    if-lez v4, :cond_2

    move/from16 v17, v6

    .line 447
    :cond_2
    cmpl-float v4, v0, v17

    if-lez v4, :cond_3

    move/from16 v17, v0

    .line 448
    :cond_3
    sub-float v4, v6, v0

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v4

    .line 449
    cmpl-float v11, v4, v13

    if-lez v11, :cond_4

    move v13, v4

    .line 451
    :cond_4
    const v11, 0x3ca3d70a    # 0.02f

    add-float/2addr v4, v11

    .line 452
    sub-float v11, v6, v10

    invoke-static {v11}, Ljava/lang/Math;->abs(F)F

    move-result v11

    sub-float v18, v0, v10

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->abs(F)F

    move-result v18

    cmpg-float v11, v11, v18

    if-gtz v11, :cond_5

    goto :goto_3

    :cond_5
    move v6, v0

    .line 453
    :goto_3
    mul-float/2addr v6, v4

    add-float v16, v16, v6

    .line 454
    add-float/2addr v14, v4

    .line 437
    add-int/lit8 v12, v12, 0x1

    move/from16 v0, p1

    move/from16 v6, p8

    move v4, v1

    move/from16 v1, p2

    goto/16 :goto_2

    .line 456
    :cond_6
    move v1, v4

    const/16 p7, 0x0

    const v0, 0x3c449ba6    # 0.012f

    sub-float/2addr v13, v0

    const v0, 0x3d072b02    # 0.033f

    div-float/2addr v13, v0

    invoke-static {v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clamp01(F)F

    move-result v0

    .line 457
    mul-float v4, v0, v0

    const/high16 v6, 0x40000000    # 2.0f

    mul-float/2addr v0, v6

    const/high16 v6, 0x40400000    # 3.0f

    sub-float/2addr v6, v0

    mul-float/2addr v4, v6

    .line 458
    cmpl-float v0, v14, p7

    if-lez v0, :cond_7

    div-float v16, v16, v14

    goto :goto_4

    :cond_7
    move/from16 v16, v10

    .line 459
    :goto_4
    sub-float v0, v10, v16

    mul-float/2addr v0, v5

    mul-float/2addr v0, v4

    .line 460
    sub-float v4, v17, v10

    move/from16 v6, p7

    invoke-static {v6, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 461
    sub-float/2addr v10, v15

    invoke-static {v6, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 462
    cmpl-float v11, v0, v6

    const/high16 v6, 0x3f000000    # 0.5f

    if-lez v11, :cond_8

    .line 463
    aget v10, p3, v8

    aget v11, p4, v8

    aget v12, p5, v8

    invoke-static {v11, v12}, Ljava/lang/Math;->max(FF)F

    move-result v11

    invoke-static {v10, v11}, Ljava/lang/Math;->max(FF)F

    move-result v10

    sub-float v10, p8, v10

    mul-float/2addr v4, v6

    invoke-static {v10, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    goto :goto_5

    .line 464
    :cond_8
    aget v4, p3, v8

    aget v11, p4, v8

    aget v12, p5, v8

    invoke-static {v11, v12}, Ljava/lang/Math;->min(FF)F

    move-result v11

    invoke-static {v4, v11}, Ljava/lang/Math;->min(FF)F

    move-result v4

    mul-float/2addr v10, v6

    invoke-static {v4, v10}, Ljava/lang/Math;->min(FF)F

    move-result v4

    .line 465
    :goto_5
    const v6, 0x3c40c0c1

    invoke-static {v4, v6}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/4 v6, 0x0

    invoke-static {v6, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 466
    cmpg-float v10, v4, v6

    if-gtz v10, :cond_9

    move v11, v6

    goto :goto_6

    :cond_9
    mul-float v6, v0, v4

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    add-float/2addr v4, v0

    div-float v11, v6, v4

    .line 467
    :goto_6
    aget v0, p3, v8

    add-float/2addr v0, v11

    invoke-static {v0}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clamp01(F)F

    move-result v0

    aget v4, p4, v8

    add-float/2addr v4, v11

    invoke-static {v4}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clamp01(F)F

    move-result v4

    aget v6, p5, v8

    add-float/2addr v6, v11

    invoke-static {v6}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clamp01(F)F

    move-result v6

    invoke-static {v0, v4, v6}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v0

    aput v0, p0, v8

    .line 431
    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v8, v8, 0x1

    move/from16 v0, p1

    move/from16 v6, p8

    move v4, v1

    move/from16 v1, p2

    goto/16 :goto_1

    .line 430
    :cond_a
    move v1, v4

    move/from16 p8, v6

    add-int/lit8 v7, v7, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_0

    .line 470
    :cond_b
    return-void
.end method

.method private static smoothChromaByIso([F[F[FIII)V
    .locals 25

    .line 283
    mul-int v0, p3, p4

    .line 284
    new-array v1, v0, [F

    .line 285
    new-array v2, v0, [F

    .line 286
    new-array v3, v0, [F

    .line 287
    const/4 v4, 0x0

    :goto_0
    const v5, 0x3d93dd98    # 0.0722f

    const v6, 0x3f371759    # 0.7152f

    const v7, 0x3e59b3d0    # 0.2126f

    if-ge v4, v0, :cond_0

    .line 288
    aget v8, p0, v4

    mul-float/2addr v8, v7

    aget v7, p1, v4

    mul-float/2addr v7, v6

    add-float/2addr v8, v7

    aget v6, p2, v4

    mul-float/2addr v6, v5

    add-float/2addr v8, v6

    .line 289
    aput v8, v1, v4

    .line 290
    aget v5, p2, v4

    sub-float/2addr v5, v8

    aput v5, v2, v4

    .line 291
    aget v5, p0, v4

    sub-float/2addr v5, v8

    aput v5, v3, v4

    .line 287
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 293
    :cond_0
    move/from16 v0, p5

    int-to-float v0, v0

    const/high16 v4, 0x43160000    # 150.0f

    sub-float/2addr v0, v4

    const/high16 v4, 0x44af0000    # 1400.0f

    div-float/2addr v0, v4

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v4, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 294
    const v8, 0x3d75c28f    # 0.06f

    mul-float/2addr v8, v0

    const v9, 0x3d23d70a    # 0.04f

    add-float/2addr v8, v9

    div-float v8, v4, v8

    .line 295
    const/4 v9, 0x1

    move v10, v9

    :goto_1
    add-int/lit8 v11, p4, -0x1

    if-ge v10, v11, :cond_6

    .line 296
    mul-int v11, v10, p3

    .line 297
    move v12, v9

    :goto_2
    add-int/lit8 v13, p3, -0x1

    if-ge v12, v13, :cond_5

    .line 298
    add-int v13, v11, v12

    .line 299
    aget v14, v1, v13

    .line 300
    aget v15, v2, v13

    aget v16, v3, v13

    .line 301
    const/16 v17, -0x1

    move/from16 p5, v4

    move/from16 v18, p5

    move/from16 v4, v17

    :goto_3
    move/from16 v19, v5

    const/4 v5, 0x0

    if-gt v4, v9, :cond_4

    .line 302
    add-int v20, v10, v4

    mul-int v20, v20, p3

    .line 303
    move/from16 v21, v6

    move/from16 v6, v17

    :goto_4
    if-gt v6, v9, :cond_3

    .line 304
    if-nez v6, :cond_1

    if-nez v4, :cond_1

    goto :goto_6

    .line 305
    :cond_1
    add-int v22, v20, v12

    add-int v22, v22, v6

    .line 306
    aget v23, v1, v22

    sub-float v23, v23, v14

    invoke-static/range {v23 .. v23}, Ljava/lang/Math;->abs(F)F

    move-result v23

    mul-float v23, v23, v8

    .line 307
    cmpl-float v24, v23, p5

    if-ltz v24, :cond_2

    move/from16 v23, v5

    goto :goto_5

    :cond_2
    sub-float v23, p5, v23

    .line 308
    :goto_5
    aget v24, v2, v22

    mul-float v24, v24, v23

    add-float v15, v15, v24

    .line 309
    aget v22, v3, v22

    mul-float v22, v22, v23

    add-float v16, v16, v22

    .line 310
    add-float v18, v18, v23

    .line 303
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 301
    :cond_3
    add-int/lit8 v4, v4, 0x1

    move/from16 v5, v19

    move/from16 v6, v21

    goto :goto_3

    .line 313
    :cond_4
    move/from16 v21, v6

    aget v4, v2, v13

    div-float v15, v15, v18

    aget v6, v2, v13

    sub-float/2addr v15, v6

    const v6, 0x3f0ccccd    # 0.55f

    mul-float/2addr v6, v0

    const v17, 0x3eb33333    # 0.35f

    add-float v6, v6, v17

    mul-float/2addr v15, v6

    add-float/2addr v4, v15

    .line 314
    aget v15, v3, v13

    div-float v16, v16, v18

    aget v17, v3, v13

    sub-float v16, v16, v17

    mul-float v16, v16, v6

    add-float v15, v15, v16

    .line 315
    add-float/2addr v15, v14

    .line 316
    add-float/2addr v4, v14

    .line 317
    mul-float v6, v15, v7

    sub-float/2addr v14, v6

    mul-float v6, v4, v19

    sub-float/2addr v14, v6

    div-float v14, v14, v21

    .line 318
    invoke-static {v5, v15}, Ljava/lang/Math;->max(FF)F

    move-result v6

    aput v6, p0, v13

    .line 319
    invoke-static {v5, v14}, Ljava/lang/Math;->max(FF)F

    move-result v6

    aput v6, p1, v13

    .line 320
    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    aput v4, p2, v13

    .line 297
    add-int/lit8 v12, v12, 0x1

    move/from16 v4, p5

    move/from16 v5, v19

    move/from16 v6, v21

    goto/16 :goto_2

    .line 295
    :cond_5
    move/from16 p5, v4

    move/from16 v19, v5

    move/from16 v21, v6

    add-int/lit8 v10, v10, 0x1

    goto/16 :goto_1

    .line 323
    :cond_6
    return-void
.end method

.method private static suppressDemosaicFringes([F[F[FII)V
    .locals 26

    .line 332
    move/from16 v0, p3

    move/from16 v1, p4

    mul-int v2, v0, v1

    .line 333
    new-array v3, v2, [F

    .line 334
    new-array v4, v2, [F

    .line 335
    const/4 v6, 0x0

    :goto_0
    if-ge v6, v2, :cond_0

    .line 336
    aget v7, p0, v6

    aget v8, p1, v6

    sub-float/2addr v7, v8

    aput v7, v3, v6

    .line 337
    aget v7, p2, v6

    aget v8, p1, v6

    sub-float/2addr v7, v8

    aput v7, v4, v6

    .line 335
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 339
    :cond_0
    const/4 v2, 0x1

    move v6, v2

    :goto_1
    add-int/lit8 v7, v1, -0x1

    if-ge v6, v7, :cond_11

    .line 340
    mul-int v7, v6, v0

    .line 341
    move v8, v2

    :goto_2
    add-int/lit8 v9, v0, -0x1

    if-ge v8, v9, :cond_10

    .line 342
    add-int v9, v7, v8

    .line 343
    aget v10, p1, v9

    .line 344
    sub-int v11, v9, v0

    aget v11, p1, v11

    add-int v12, v9, v0

    aget v12, p1, v12

    .line 345
    add-int/lit8 v13, v9, -0x1

    aget v13, p1, v13

    add-int/lit8 v14, v9, 0x1

    aget v14, p1, v14

    .line 346
    invoke-static {v10, v11}, Ljava/lang/Math;->max(FF)F

    move-result v15

    invoke-static {v13, v14}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-static {v12, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-static {v15, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 347
    invoke-static {v10, v11}, Ljava/lang/Math;->min(FF)F

    move-result v11

    invoke-static {v13, v14}, Ljava/lang/Math;->min(FF)F

    move-result v13

    invoke-static {v12, v13}, Ljava/lang/Math;->min(FF)F

    move-result v12

    invoke-static {v11, v12}, Ljava/lang/Math;->min(FF)F

    move-result v11

    sub-float/2addr v5, v11

    .line 348
    const v11, 0x3e0f5c29    # 0.14f

    cmpg-float v5, v5, v11

    if-gez v5, :cond_1

    .line 349
    goto/16 :goto_9

    .line 351
    :cond_1
    aget v5, v3, v9

    .line 352
    aget v11, v4, v9

    .line 353
    nop

    .line 354
    nop

    .line 355
    mul-float v12, v5, v5

    mul-float v13, v11, v11

    add-float/2addr v12, v13

    .line 356
    nop

    .line 357
    nop

    .line 358
    move/from16 v16, v5

    move/from16 v17, v11

    move v15, v12

    const/4 v14, -0x1

    const/16 v18, 0x0

    :goto_3
    const v19, 0x3da3d70a    # 0.08f

    if-gt v14, v2, :cond_5

    .line 359
    add-int v20, v6, v14

    mul-int v20, v20, v0

    .line 360
    const/4 v13, -0x1

    :goto_4
    if-gt v13, v2, :cond_4

    .line 361
    if-nez v13, :cond_2

    if-nez v14, :cond_2

    goto :goto_5

    .line 362
    :cond_2
    add-int v22, v20, v8

    add-int v22, v22, v13

    .line 363
    aget v23, p1, v22

    sub-float v23, v23, v10

    invoke-static/range {v23 .. v23}, Ljava/lang/Math;->abs(F)F

    move-result v23

    cmpg-float v23, v23, v19

    if-gez v23, :cond_3

    .line 364
    aget v23, v3, v22

    .line 365
    aget v22, v4, v22

    .line 366
    mul-float v24, v23, v23

    mul-float v25, v22, v22

    add-float v24, v24, v25

    .line 367
    cmpg-float v25, v24, v15

    if-gez v25, :cond_3

    .line 368
    nop

    .line 369
    nop

    .line 370
    nop

    .line 371
    move/from16 v18, v2

    move/from16 v17, v22

    move/from16 v16, v23

    move/from16 v15, v24

    .line 360
    :cond_3
    :goto_5
    add-int/lit8 v13, v13, 0x1

    goto :goto_4

    .line 358
    :cond_4
    add-int/lit8 v14, v14, 0x1

    goto :goto_3

    .line 377
    :cond_5
    const/4 v13, 0x0

    :goto_6
    const/4 v14, 0x4

    if-ge v13, v14, :cond_b

    .line 378
    const/4 v14, 0x2

    if-nez v13, :cond_6

    const/16 v21, -0x2

    goto :goto_7

    :cond_6
    if-ne v13, v2, :cond_7

    move/from16 v21, v14

    goto :goto_7

    :cond_7
    const/16 v21, 0x0

    :goto_7
    add-int v2, v8, v21

    .line 379
    if-ne v13, v14, :cond_8

    const/4 v14, -0x2

    goto :goto_8

    :cond_8
    const/4 v14, 0x3

    if-ne v13, v14, :cond_9

    const/4 v14, 0x2

    goto :goto_8

    :cond_9
    const/4 v14, 0x0

    :goto_8
    add-int/2addr v14, v6

    .line 380
    if-ltz v2, :cond_a

    if-ge v2, v0, :cond_a

    if-ltz v14, :cond_a

    if-ge v14, v1, :cond_a

    .line 381
    mul-int/2addr v14, v0

    add-int/2addr v14, v2

    .line 382
    aget v2, p1, v14

    sub-float/2addr v2, v10

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    cmpg-float v2, v2, v19

    if-gez v2, :cond_a

    .line 383
    aget v2, v3, v14

    .line 384
    aget v14, v4, v14

    .line 385
    mul-float v20, v2, v2

    mul-float v21, v14, v14

    add-float v20, v20, v21

    .line 386
    cmpg-float v21, v20, v15

    if-gez v21, :cond_a

    .line 387
    nop

    .line 388
    nop

    .line 389
    nop

    .line 390
    move/from16 v16, v2

    move/from16 v17, v14

    move/from16 v15, v20

    const/16 v18, 0x1

    .line 377
    :cond_a
    add-int/lit8 v13, v13, 0x1

    const/4 v2, 0x1

    goto :goto_6

    .line 395
    :cond_b
    if-eqz v18, :cond_f

    const/high16 v2, 0x40100000    # 2.25f

    mul-float/2addr v15, v2

    const v2, 0x3a03126f    # 5.0E-4f

    add-float/2addr v15, v2

    cmpg-float v2, v12, v15

    if-gtz v2, :cond_c

    .line 396
    goto/16 :goto_9

    .line 398
    :cond_c
    sub-float v16, v16, v5

    const v2, 0x3f4ccccd    # 0.8f

    mul-float v16, v16, v2

    add-float v16, v5, v16

    .line 399
    sub-float v17, v17, v11

    mul-float v17, v17, v2

    add-float v17, v11, v17

    .line 400
    cmpl-float v2, v16, v5

    if-nez v2, :cond_d

    cmpl-float v2, v17, v11

    if-eqz v2, :cond_f

    .line 401
    :cond_d
    aget v2, p0, v9

    const v5, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v2, v5

    const v10, 0x3f371759    # 0.7152f

    aget v11, p1, v9

    mul-float/2addr v11, v10

    add-float/2addr v2, v11

    aget v10, p2, v9

    const v11, 0x3d93dd98    # 0.0722f

    mul-float/2addr v10, v11

    add-float/2addr v2, v10

    .line 402
    mul-float v5, v5, v16

    sub-float v10, v2, v5

    mul-float v11, v11, v17

    sub-float/2addr v10, v11

    .line 403
    const/4 v12, 0x0

    cmpl-float v13, v10, v12

    if-ltz v13, :cond_e

    .line 404
    add-float v2, v10, v16

    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p0, v9

    .line 405
    aput v10, p1, v9

    .line 406
    add-float v10, v10, v17

    invoke-static {v12, v10}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p2, v9

    goto :goto_9

    .line 408
    :cond_e
    const v10, 0x3727c5ac    # 1.0E-5f

    add-float v13, v5, v11

    invoke-static {v10, v13}, Ljava/lang/Math;->max(FF)F

    move-result v10

    div-float v10, v2, v10

    .line 409
    const/high16 v13, 0x3f800000    # 1.0f

    invoke-static {v13, v10}, Ljava/lang/Math;->min(FF)F

    move-result v10

    invoke-static {v12, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 410
    mul-float/2addr v5, v10

    sub-float/2addr v2, v5

    mul-float/2addr v11, v10

    sub-float/2addr v2, v11

    mul-float v16, v16, v10

    add-float v5, v2, v16

    invoke-static {v12, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    aput v5, p0, v9

    .line 411
    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v5

    aput v5, p1, v9

    .line 412
    mul-float v17, v17, v10

    add-float v2, v2, v17

    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p2, v9

    .line 341
    :cond_f
    :goto_9
    add-int/lit8 v8, v8, 0x1

    const/4 v2, 0x1

    goto/16 :goto_2

    .line 339
    :cond_10
    add-int/lit8 v6, v6, 0x1

    const/4 v2, 0x1

    goto/16 :goto_1

    .line 417
    :cond_11
    return-void
.end method

.method public static unpackRaw10ToInt([BIII)[I
    .locals 10

    .line 32
    and-int/lit8 v0, p1, 0x3

    if-nez v0, :cond_2

    and-int/lit8 v0, p2, 0x1

    if-nez v0, :cond_2

    .line 35
    int-to-long v0, p1

    const-wide/16 v2, 0x5

    mul-long/2addr v0, v2

    const-wide/16 v2, 0x4

    div-long v8, v0, v2

    move-object v4, p0

    move v5, p1

    move v6, p2

    move v7, p3

    invoke-static/range {v4 .. v9}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->allocateUnpacked([BIIIJ)[I

    move-result-object p0

    .line 36
    const/4 p1, 0x0

    move p2, p1

    :goto_0
    if-ge p2, v6, :cond_1

    .line 37
    mul-int p3, p2, v7

    .line 38
    mul-int v0, p2, v5

    .line 39
    move v1, p1

    :goto_1
    if-ge v1, v5, :cond_0

    .line 40
    add-int/lit8 v2, p3, 0x4

    aget-byte v2, v4, v2

    and-int/lit16 v2, v2, 0xff

    .line 41
    aget-byte v3, v4, p3

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x2

    and-int/lit8 v8, v2, 0x3

    or-int/2addr v3, v8

    aput v3, p0, v0

    .line 42
    add-int/lit8 v3, v0, 0x1

    add-int/lit8 v8, p3, 0x1

    aget-byte v8, v4, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x2

    ushr-int/lit8 v9, v2, 0x2

    and-int/lit8 v9, v9, 0x3

    or-int/2addr v8, v9

    aput v8, p0, v3

    .line 43
    add-int/lit8 v3, v0, 0x2

    add-int/lit8 v8, p3, 0x2

    aget-byte v8, v4, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x2

    ushr-int/lit8 v9, v2, 0x4

    and-int/lit8 v9, v9, 0x3

    or-int/2addr v8, v9

    aput v8, p0, v3

    .line 44
    add-int/lit8 v3, v0, 0x3

    add-int/lit8 v8, p3, 0x3

    aget-byte v8, v4, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x2

    ushr-int/lit8 v2, v2, 0x6

    or-int/2addr v2, v8

    aput v2, p0, v3

    .line 39
    add-int/lit8 v1, v1, 0x4

    add-int/lit8 p3, p3, 0x5

    add-int/lit8 v0, v0, 0x4

    goto :goto_1

    .line 36
    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 47
    :cond_1
    return-object p0

    .line 33
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "RAW10 width must be divisible by 4 and height even"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static unpackRaw16ToInt([BIIIZ)[I
    .locals 10

    .line 52
    int-to-long v0, p1

    const-wide/16 v2, 0x2

    mul-long v8, v0, v2

    move-object v4, p0

    move v5, p1

    move v6, p2

    move v7, p3

    invoke-static/range {v4 .. v9}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->allocateUnpacked([BIIIJ)[I

    move-result-object p0

    .line 53
    nop

    .line 54
    xor-int/lit8 p1, p4, 0x1

    .line 55
    const/4 p2, 0x0

    move p3, p2

    :goto_0
    if-ge p3, v6, :cond_1

    .line 56
    mul-int v0, p3, v7

    .line 57
    mul-int v1, p3, v5

    .line 58
    move v2, p2

    :goto_1
    if-ge v2, v5, :cond_0

    .line 59
    add-int v3, v1, v2

    add-int v8, v0, p4

    aget-byte v8, v4, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x8

    add-int v9, v0, p1

    aget-byte v9, v4, v9

    and-int/lit16 v9, v9, 0xff

    or-int/2addr v8, v9

    aput v8, p0, v3

    .line 58
    add-int/lit8 v2, v2, 0x1

    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    .line 55
    :cond_0
    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    .line 62
    :cond_1
    return-object p0
.end method
