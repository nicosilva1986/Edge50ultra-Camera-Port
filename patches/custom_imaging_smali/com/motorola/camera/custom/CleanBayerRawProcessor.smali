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

    .line 456
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

    .line 200
    invoke-virtual/range {p0 .. p0}, [F->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [F

    .line 201
    mul-int/lit8 v1, p1, 0x2

    .line 202
    const/4 v2, 0x2

    move v3, v2

    :goto_0
    add-int/lit8 v4, p2, -0x2

    if-ge v3, v4, :cond_3

    .line 203
    mul-int v4, v3, p1

    .line 204
    move v5, v2

    :goto_1
    add-int/lit8 v6, p1, -0x2

    if-ge v5, v6, :cond_2

    .line 205
    add-int v6, v4, v5

    .line 206
    aget v7, v0, v6

    .line 207
    sub-int v8, v6, v1

    add-int/lit8 v9, v8, -0x2

    aget v9, v0, v9

    aget v10, v0, v8

    add-int/2addr v8, v2

    aget v8, v0, v8

    .line 208
    add-int/lit8 v11, v6, -0x2

    aget v11, v0, v11

    add-int/lit8 v12, v6, 0x2

    aget v12, v0, v12

    .line 209
    add-int v13, v6, v1

    add-int/lit8 v14, v13, -0x2

    aget v14, v0, v14

    aget v15, v0, v13

    add-int/2addr v13, v2

    aget v13, v0, v13

    .line 210
    invoke-static {v9, v10}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move-object/from16 v16, v0

    invoke-static {v8, v11}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 211
    invoke-static {v12, v14}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move/from16 v17, v1

    invoke-static {v15, v13}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 210
    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 212
    invoke-static {v9, v10}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v8, v11}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 213
    invoke-static {v12, v14}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v15, v13}, Ljava/lang/Math;->min(FF)F

    move-result v8

    invoke-static {v2, v8}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 212
    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    .line 214
    const/high16 v2, 0x3fe00000    # 1.75f

    mul-float/2addr v2, v0

    const v8, 0x3ca3d70a    # 0.02f

    add-float/2addr v2, v8

    cmpl-float v2, v7, v2

    if-lez v2, :cond_0

    .line 215
    aput v0, p0, v6

    goto :goto_2

    .line 216
    :cond_0
    const v0, 0x3ecccccd    # 0.4f

    mul-float/2addr v0, v1

    cmpg-float v0, v7, v0

    if-gez v0, :cond_1

    const v0, 0x3d23d70a    # 0.04f

    cmpl-float v0, v1, v0

    if-lez v0, :cond_1

    .line 217
    aput v1, p0, v6

    .line 204
    :cond_1
    :goto_2
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v0, v16

    move/from16 v1, v17

    const/4 v2, 0x2

    goto/16 :goto_1

    .line 202
    :cond_2
    move-object/from16 v16, v0

    move/from16 v17, v1

    add-int/lit8 v3, v3, 0x1

    const/4 v2, 0x2

    goto/16 :goto_0

    .line 221
    :cond_3
    return-void
.end method

.method private static demosaicMalvar([FII[I[D[F[F[F)V
    .locals 38

    .line 225
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_13

    .line 226
    if-nez v3, :cond_0

    move v4, v0

    goto :goto_1

    :cond_0
    neg-int v4, v0

    .line 227
    :goto_1
    add-int/lit8 v5, v1, -0x1

    if-ne v3, v5, :cond_1

    neg-int v5, v0

    goto :goto_2

    :cond_1
    move v5, v0

    .line 228
    :goto_2
    mul-int v6, v3, v0

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v0, :cond_12

    .line 229
    const/4 v8, -0x1

    const/4 v9, 0x1

    if-nez v7, :cond_2

    move v10, v9

    goto :goto_4

    :cond_2
    move v10, v8

    .line 230
    :goto_4
    add-int/lit8 v11, v0, -0x1

    if-ne v7, v11, :cond_3

    goto :goto_5

    :cond_3
    move v8, v9

    .line 231
    :goto_5
    and-int/lit8 v11, v3, 0x1

    shl-int/2addr v11, v9

    and-int/lit8 v12, v7, 0x1

    or-int/2addr v11, v12

    .line 232
    aget v12, p3, v11

    .line 233
    aget v13, p0, v6

    float-to-double v13, v13

    .line 234
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

    .line 235
    add-int v2, v6, v4

    aget v3, p0, v2

    float-to-double v0, v3

    add-int v3, v6, v5

    aget v15, p0, v3

    move-wide/from16 v20, v0

    float-to-double v0, v15

    add-double v0, v20, v0

    .line 236
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

    .line 238
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

    .line 239
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

    .line 240
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

    .line 243
    :goto_8
    const-wide/high16 v2, 0x4020000000000000L    # 8.0

    const-wide/high16 v28, 0x4000000000000000L    # 2.0

    const-wide/high16 v30, 0x4010000000000000L    # 4.0

    const/4 v15, 0x1

    if-ne v12, v15, :cond_d

    .line 244
    nop

    .line 245
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

    .line 246
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

    .line 247
    :goto_a
    xor-int/lit8 v0, v11, 0x1

    aget v0, p3, v0

    if-nez v0, :cond_a

    const/4 v15, 0x1

    goto :goto_b

    :cond_a
    move/from16 v15, v18

    .line 248
    :goto_b
    if-eqz v15, :cond_b

    move-wide/from16 v0, v36

    goto :goto_c

    :cond_b
    move-wide/from16 v0, v34

    .line 249
    :goto_c
    if-eqz v15, :cond_c

    move-wide/from16 v36, v34

    .line 250
    :cond_c
    goto :goto_11

    .line 251
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

    .line 252
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

    .line 253
    :goto_e
    if-nez v12, :cond_10

    move-wide v0, v13

    goto :goto_f

    :cond_10
    move-wide v0, v8

    .line 254
    :goto_f
    const/4 v15, 0x2

    if-ne v12, v15, :cond_11

    goto :goto_10

    :cond_11
    move-wide v13, v8

    :goto_10
    move-wide/from16 v36, v13

    move-wide/from16 v13, v32

    .line 256
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

    .line 257
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

    .line 258
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

    .line 228
    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    move/from16 v3, v19

    goto/16 :goto_3

    .line 225
    :cond_12
    move/from16 v19, v3

    const/16 v18, 0x0

    add-int/lit8 v3, v19, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_0

    .line 261
    :cond_13
    return-void
.end method

.method private static encode(D)F
    .locals 5

    .line 600
    const-wide/16 v0, 0x0

    cmpg-double v0, p0, v0

    if-gtz v0, :cond_0

    .line 601
    const/4 p0, 0x0

    return p0

    .line 603
    :cond_0
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_1

    .line 604
    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 606
    :cond_1
    const-wide/high16 v0, 0x40b0000000000000L    # 4096.0

    mul-double/2addr p0, v0

    .line 607
    double-to-int v0, p0

    .line 608
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

.method private static normalizedMatrix([F)[D
    .locals 13

    .line 583
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

    .line 584
    if-eqz p0, :cond_1

    array-length v3, p0

    if-ne v3, v0, :cond_1

    .line 585
    nop

    :goto_0
    if-ge v2, v0, :cond_1

    .line 586
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

    .line 587
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

    .line 588
    invoke-static {v9, v10}, Ljava/lang/Math;->abs(D)D

    move-result-wide v9

    add-double/2addr v7, v9

    .line 589
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

    .line 590
    aget v7, p0, v2

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v2

    .line 591
    aget v7, p0, v5

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v5

    .line 592
    aget v5, p0, v6

    float-to-double v7, v5

    div-double/2addr v7, v3

    aput-wide v7, v1, v6

    .line 585
    :cond_0
    add-int/lit8 v2, v2, 0x3

    goto :goto_0

    .line 596
    :cond_1
    return-object v1
.end method

.method private static pack(FFF)I
    .locals 2

    .line 634
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

    .line 635
    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p1

    or-int/2addr p0, p1

    .line 634
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

    .line 466
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result v6

    .line 467
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

    .line 471
    invoke-static/range {p5 .. p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    invoke-static/range {p8 .. p8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    .line 474
    sget-object v9, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    aget-object v3, v9, v3

    .line 475
    new-array v9, v10, [D

    .line 476
    const/4 v12, 0x0

    :goto_0
    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    move v15, v8

    move-object/from16 p3, v9

    if-ge v12, v10, :cond_1

    .line 477
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

    .line 478
    cmpg-double v7, v11, v21

    if-lez v7, :cond_0

    invoke-static {v11, v12}, Ljava/lang/Double;->isFinite(D)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 481
    div-double/2addr v13, v11

    aput-wide v13, p3, v18

    .line 476
    add-int/lit8 v12, v18, 0x1

    move-object/from16 v9, p3

    move/from16 v10, v16

    move/from16 v8, v19

    const/4 v7, 0x2

    goto :goto_0

    .line 479
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White level must exceed each finite black level"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 483
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

    .line 484
    invoke-static {v10}, Ljava/lang/Float;->isFinite(F)Z

    move-result v11

    if-eqz v11, :cond_2

    cmpg-float v9, v10, v9

    if-ltz v9, :cond_2

    .line 483
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 485
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White balance gains must be finite and nonnegative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 489
    :cond_3
    new-array v7, v6, [F

    .line 490
    move/from16 v8, v17

    :goto_2
    const/4 v10, 0x1

    if-ge v8, v2, :cond_5

    .line 491
    and-int/lit8 v11, v8, 0x1

    shl-int/2addr v11, v10

    .line 492
    mul-int v12, v8, v1

    move/from16 v15, v17

    :goto_3
    if-ge v15, v1, :cond_4

    .line 493
    and-int/lit8 v18, v15, 0x1

    or-int v18, v11, v18

    .line 494
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

    .line 495
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

    .line 492
    add-int/lit8 v15, v15, 0x1

    add-int/lit8 v12, v12, 0x1

    move/from16 v9, p5

    move/from16 v10, v23

    move/from16 v11, v24

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_3

    .line 490
    :cond_4
    move/from16 p5, v9

    add-int/lit8 v8, v8, 0x1

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_2

    .line 499
    :cond_5
    move/from16 p5, v9

    move/from16 v23, v10

    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->normalizedMatrix([F)[D

    move-result-object v0

    .line 500
    move-object v4, v0

    new-array v0, v6, [I

    .line 502
    cmpl-float v5, p8, p5

    const/4 v8, 0x0

    if-lez v5, :cond_6

    new-array v9, v6, [F

    goto :goto_4

    :cond_6
    move-object v9, v8

    .line 503
    :goto_4
    if-lez v5, :cond_7

    new-array v10, v6, [F

    goto :goto_5

    :cond_7
    move-object v10, v8

    .line 504
    :goto_5
    if-lez v5, :cond_8

    new-array v11, v6, [F

    goto :goto_6

    :cond_8
    move-object v11, v8

    .line 505
    :goto_6
    if-lez v5, :cond_9

    new-array v8, v6, [F

    :cond_9
    move-object v6, v8

    .line 507
    move/from16 v5, v17

    :goto_7
    if-ge v5, v2, :cond_1d

    .line 508
    if-nez v5, :cond_a

    move v8, v1

    goto :goto_8

    :cond_a
    neg-int v8, v1

    .line 509
    :goto_8
    add-int/lit8 v12, v2, -0x1

    if-ne v5, v12, :cond_b

    neg-int v12, v1

    goto :goto_9

    :cond_b
    move v12, v1

    .line 510
    :goto_9
    mul-int v13, v5, v1

    move/from16 v14, v17

    :goto_a
    if-ge v14, v1, :cond_1c

    .line 511
    if-nez v14, :cond_c

    move/from16 v18, v23

    goto :goto_b

    :cond_c
    const/16 v18, -0x1

    .line 512
    :goto_b
    add-int/lit8 v15, v1, -0x1

    if-ne v14, v15, :cond_d

    const/4 v15, -0x1

    goto :goto_c

    :cond_d
    move/from16 v15, v23

    .line 513
    :goto_c
    and-int/lit8 v24, v5, 0x1

    shl-int/lit8 v24, v24, 0x1

    and-int/lit8 v25, v14, 0x1

    or-int v24, v24, v25

    .line 514
    move-object/from16 v25, v0

    aget v0, v3, v24

    .line 515
    aget v1, v7, v13

    float-to-double v1, v1

    .line 516
    add-int v26, v13, v18

    move-wide/from16 p3, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v26, v13, v15

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-double v1, p5, v1

    .line 517
    add-int v26, v13, v8

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v27, v13, v12

    move-wide/from16 v28, v1

    aget v1, v7, v27

    float-to-double v1, v1

    add-double v1, v28, v1

    .line 518
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

    .line 520
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

    .line 521
    :goto_d
    nop

    .line 522
    nop

    .line 523
    if-eqz v15, :cond_f

    .line 524
    add-int/lit8 v18, v13, -0x2

    move-wide/from16 v26, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-int/lit8 v18, v13, 0x2

    move-wide/from16 v31, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-double v1, v31, v1

    .line 525
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

    .line 523
    :cond_f
    move-wide/from16 v26, v1

    const-wide/16 v1, 0x0

    const-wide/16 v31, 0x0

    .line 533
    :goto_e
    const-wide/high16 v33, 0x4020000000000000L    # 8.0

    const-wide/high16 v35, 0x4000000000000000L    # 2.0

    const-wide/high16 v37, 0x4010000000000000L    # 4.0

    move-wide/from16 v39, v1

    move/from16 v1, v23

    if-ne v0, v1, :cond_15

    .line 534
    nop

    .line 535
    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    const-wide/high16 v41, 0x4014000000000000L    # 5.0

    if-eqz v15, :cond_10

    .line 536
    mul-double v43, p3, v41

    mul-double v45, p5, v37

    add-double v43, v43, v45

    sub-double v43, v43, v26

    sub-double v43, v43, v39

    mul-double v45, v31, v0

    add-double v43, v43, v45

    div-double v43, v43, v33

    goto :goto_f

    .line 537
    :cond_10
    div-double v43, p5, v35

    .line 538
    :goto_f
    if-eqz v15, :cond_11

    .line 539
    mul-double v35, p3, v41

    mul-double v28, v29, v37

    add-double v35, v35, v28

    sub-double v35, v35, v26

    sub-double v35, v35, v31

    mul-double v1, v39, v0

    add-double v35, v35, v1

    div-double v35, v35, v33

    goto :goto_10

    .line 540
    :cond_11
    div-double v35, v29, v35

    .line 541
    :goto_10
    xor-int/lit8 v0, v24, 0x1

    aget v0, v3, v0

    if-nez v0, :cond_12

    const/4 v1, 0x1

    goto :goto_11

    :cond_12
    move/from16 v1, v17

    .line 542
    :goto_11
    if-eqz v1, :cond_13

    move-wide/from16 v26, v43

    goto :goto_12

    :cond_13
    move-wide/from16 v26, v35

    .line 543
    :goto_12
    if-eqz v1, :cond_14

    move-wide/from16 v43, v35

    .line 544
    :cond_14
    move-wide/from16 v1, p3

    goto :goto_16

    .line 545
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

    .line 546
    :cond_16
    add-double v1, p5, v29

    div-double v1, v1, v37

    .line 547
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

    .line 548
    :cond_17
    div-double v28, v26, v37

    .line 549
    :goto_14
    if-nez v0, :cond_18

    move-wide/from16 v26, p3

    goto :goto_15

    :cond_18
    move-wide/from16 v26, v28

    .line 550
    :goto_15
    const/4 v15, 0x2

    if-ne v0, v15, :cond_19

    move-wide/from16 v28, p3

    :cond_19
    move-wide/from16 v43, v28

    .line 553
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

    .line 554
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

    .line 555
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

    .line 556
    move-object/from16 p3, v6

    move-object/from16 v24, v7

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    invoke-static {v0, v1, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    .line 557
    nop

    .line 558
    const-wide v26, 0x3fe999999999999aL    # 0.8

    cmpl-double v28, v6, v26

    if-lez v28, :cond_1a

    .line 559
    sub-double v28, v6, v26

    .line 561
    const-wide v30, 0x3fc999999999999aL    # 0.2

    add-double v32, v28, v30

    div-double v28, v28, v32

    mul-double v28, v28, v30

    add-double v28, v28, v26

    div-double v28, v28, v6

    goto :goto_17

    .line 558
    :cond_1a
    const-wide/high16 v28, 0x3ff0000000000000L    # 1.0

    .line 563
    :goto_17
    mul-double v0, v0, v28

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v0

    .line 564
    mul-double v2, v2, v28

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v1

    .line 565
    mul-double v4, v4, v28

    invoke-static {v4, v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v2

    .line 566
    if-nez p3, :cond_1b

    .line 567
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v0

    aput v0, v25, v13

    goto :goto_18

    .line 569
    :cond_1b
    aput v0, v9, v13

    .line 570
    aput v1, v10, v13

    .line 571
    aput v2, v11, v13

    .line 572
    const v3, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v0, v3

    const v3, 0x3f371759    # 0.7152f

    mul-float/2addr v1, v3

    add-float/2addr v0, v1

    const v1, 0x3d93dd98    # 0.0722f

    mul-float/2addr v2, v1

    add-float/2addr v0, v2

    aput v0, p3, v13

    .line 510
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

    .line 507
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

    .line 576
    :cond_1d
    move-object/from16 v25, v0

    move-object/from16 p3, v6

    if-eqz p3, :cond_1e

    .line 577
    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v6, p3

    move/from16 v7, p8

    move-object v3, v9

    move-object v4, v10

    move-object v5, v11

    move-object/from16 v0, v25

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->sharpen([III[F[F[F[FF)V

    .line 579
    :cond_1e
    return-object v25

    .line 472
    :cond_1f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid Bayer image or calibration"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static processRawToArgb([IIII[FF[F[FF[FIII)[I
    .locals 33

    .line 91
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    move-object/from16 v6, p9

    move/from16 v7, p10

    move/from16 v8, p11

    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result v9

    .line 92
    const/4 v10, 0x2

    if-lt v1, v10, :cond_1c

    if-lt v2, v10, :cond_1c

    if-eqz v0, :cond_1c

    array-length v11, v0

    if-lt v11, v9, :cond_1c

    if-ltz v3, :cond_1c

    const/4 v11, 0x3

    if-gt v3, v11, :cond_1c

    if-eqz v4, :cond_1c

    array-length v12, v4

    const/4 v13, 0x4

    if-ne v12, v13, :cond_1c

    if-eqz v5, :cond_1c

    array-length v12, v5

    if-ne v12, v11, :cond_1c

    .line 96
    invoke-static/range {p5 .. p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v12

    if-eqz v12, :cond_1c

    invoke-static/range {p8 .. p8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v12

    if-eqz v12, :cond_1c

    .line 99
    sget-object v12, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    aget-object v12, v12, v3

    .line 100
    new-array v14, v13, [D

    .line 101
    const/4 v11, 0x0

    :goto_0
    move-object/from16 v17, v14

    const-wide/16 v19, 0x0

    if-ge v11, v13, :cond_1

    .line 102
    move/from16 v21, v13

    const-wide/high16 v22, 0x3ff0000000000000L    # 1.0

    move/from16 v13, p5

    float-to-double v14, v13

    aget v10, v4, v11

    move/from16 v25, v11

    float-to-double v10, v10

    sub-double/2addr v14, v10

    .line 103
    cmpg-double v10, v14, v19

    if-lez v10, :cond_0

    invoke-static {v14, v15}, Ljava/lang/Double;->isFinite(D)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 106
    div-double v14, v22, v14

    aput-wide v14, v17, v25

    .line 101
    add-int/lit8 v11, v25, 0x1

    move-object/from16 v14, v17

    move/from16 v13, v21

    const/4 v10, 0x2

    goto :goto_0

    .line 104
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White level must exceed each finite black level"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 108
    :cond_1
    move/from16 v21, v13

    const-wide/high16 v22, 0x3ff0000000000000L    # 1.0

    array-length v10, v5

    const/4 v11, 0x0

    :goto_1
    const/4 v13, 0x0

    if-ge v11, v10, :cond_3

    aget v14, v5, v11

    .line 109
    invoke-static {v14}, Ljava/lang/Float;->isFinite(F)Z

    move-result v15

    if-eqz v15, :cond_2

    cmpg-float v13, v14, v13

    if-ltz v13, :cond_2

    .line 108
    add-int/lit8 v11, v11, 0x1

    goto :goto_1

    .line 110
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White balance gains must be finite and nonnegative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 114
    :cond_3
    const/4 v10, 0x1

    if-eqz v6, :cond_4

    const/4 v11, 0x2

    if-lt v7, v11, :cond_4

    if-lt v8, v11, :cond_4

    array-length v11, v6

    mul-int v14, v7, v8

    mul-int/lit8 v14, v14, 0x4

    if-lt v11, v14, :cond_4

    move v11, v10

    goto :goto_2

    :cond_4
    const/4 v11, 0x0

    .line 116
    :goto_2
    new-array v0, v9, [F

    .line 117
    const/4 v14, 0x0

    :goto_3
    if-ge v14, v2, :cond_10

    .line 118
    and-int/lit8 v15, v14, 0x1

    shl-int/lit8 v25, v15, 0x1

    .line 119
    if-eqz v11, :cond_5

    add-int/lit8 v26, v8, -0x1

    move/from16 p5, v13

    mul-int v13, v14, v26

    int-to-float v13, v13

    add-int/lit8 v4, v2, -0x1

    invoke-static {v10, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v13, v4

    goto :goto_4

    :cond_5
    move/from16 p5, v13

    .line 120
    :goto_4
    if-eqz v11, :cond_6

    add-int/lit8 v4, v8, -0x2

    float-to-int v10, v13

    invoke-static {v4, v10}, Ljava/lang/Math;->min(II)I

    move-result v4

    goto :goto_5

    :cond_6
    const/4 v4, 0x0

    .line 121
    :goto_5
    if-eqz v11, :cond_7

    int-to-float v10, v4

    sub-float/2addr v13, v10

    goto :goto_6

    :cond_7
    move/from16 v13, p5

    .line 122
    :goto_6
    mul-int v10, v14, v1

    move/from16 v27, v4

    const/4 v4, 0x0

    :goto_7
    if-ge v4, v1, :cond_f

    .line 123
    and-int/lit8 v28, v4, 0x1

    or-int v28, v25, v28

    .line 124
    move/from16 v29, v4

    aget v4, p0, v10

    int-to-double v4, v4

    move-wide/from16 v30, v4

    aget v4, p4, v28

    float-to-double v4, v4

    sub-double v4, v30, v4

    aget-wide v30, v17, v28

    mul-double v4, v4, v30

    .line 125
    move/from16 v31, v10

    move/from16 v30, v11

    move-wide/from16 v10, v22

    invoke-static {v10, v11, v4, v5}, Ljava/lang/Math;->min(DD)D

    move-result-wide v4

    move-wide/from16 v10, v19

    invoke-static {v10, v11, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    aget v19, v12, v28

    aget v10, p6, v19

    float-to-double v10, v10

    mul-double/2addr v4, v10

    .line 126
    if-eqz v30, :cond_d

    .line 127
    aget v10, v12, v28

    .line 128
    if-nez v15, :cond_8

    const/4 v11, 0x1

    goto :goto_8

    :cond_8
    const/4 v11, 0x0

    :goto_8
    move-wide/from16 v19, v4

    const/4 v4, 0x2

    if-lt v3, v4, :cond_9

    const/4 v4, 0x1

    goto :goto_9

    :cond_9
    const/4 v4, 0x0

    :goto_9
    xor-int/2addr v4, v11

    .line 129
    if-nez v10, :cond_a

    const/4 v11, 0x0

    goto :goto_a

    :cond_a
    const/4 v11, 0x2

    if-ne v10, v11, :cond_b

    const/4 v11, 0x3

    goto :goto_a

    :cond_b
    if-eqz v4, :cond_c

    const/4 v11, 0x1

    goto :goto_a

    :cond_c
    const/4 v11, 0x2

    .line 130
    :goto_a
    add-int/lit8 v4, v7, -0x1

    mul-int v4, v4, v29

    int-to-float v4, v4

    add-int/lit8 v5, v1, -0x1

    const/4 v10, 0x1

    invoke-static {v10, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    int-to-float v5, v5

    div-float/2addr v4, v5

    .line 131
    add-int/lit8 v5, v7, -0x2

    float-to-int v10, v4

    invoke-static {v5, v10}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 132
    int-to-float v10, v5

    sub-float/2addr v4, v10

    .line 133
    mul-int v10, v27, v7

    add-int/2addr v10, v5

    const/16 v24, 0x2

    shl-int/lit8 v5, v10, 0x2

    add-int/2addr v5, v11

    .line 134
    add-int/lit8 v10, v5, 0x4

    .line 135
    shl-int/lit8 v11, v7, 0x2

    add-int/2addr v11, v5

    .line 136
    add-int/lit8 v28, v11, 0x4

    .line 137
    aget v32, v6, v5

    aget v10, v6, v10

    aget v5, v6, v5

    sub-float/2addr v10, v5

    mul-float/2addr v10, v4

    add-float v32, v32, v10

    .line 138
    aget v5, v6, v11

    aget v10, v6, v28

    aget v11, v6, v11

    sub-float/2addr v10, v11

    mul-float/2addr v10, v4

    add-float/2addr v5, v10

    .line 139
    sub-float v5, v5, v32

    mul-float/2addr v5, v13

    add-float v4, v32, v5

    .line 140
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v5

    if-eqz v5, :cond_e

    cmpl-float v5, v4, p5

    if-lez v5, :cond_e

    .line 141
    const/high16 v5, 0x41000000    # 8.0f

    invoke-static {v5, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const v5, 0x3f4ccccd    # 0.8f

    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    float-to-double v4, v4

    mul-double v4, v4, v19

    goto :goto_b

    .line 126
    :cond_d
    move-wide/from16 v19, v4

    const/16 v24, 0x2

    .line 144
    :cond_e
    move-wide/from16 v4, v19

    :goto_b
    double-to-float v4, v4

    aput v4, v0, v31

    .line 122
    add-int/lit8 v4, v29, 0x1

    add-int/lit8 v10, v31, 0x1

    move-object/from16 v5, p6

    move/from16 v11, v30

    const-wide/16 v19, 0x0

    const-wide/high16 v22, 0x3ff0000000000000L    # 1.0

    goto/16 :goto_7

    .line 117
    :cond_f
    move/from16 v30, v11

    const/16 v24, 0x2

    add-int/lit8 v14, v14, 0x1

    move-object/from16 v4, p4

    move/from16 v13, p5

    move-object/from16 v5, p6

    const/4 v10, 0x1

    const-wide/16 v19, 0x0

    const-wide/high16 v22, 0x3ff0000000000000L    # 1.0

    goto/16 :goto_3

    .line 148
    :cond_10
    move/from16 p5, v13

    const/4 v8, 0x6

    if-lt v1, v8, :cond_11

    if-lt v2, v8, :cond_11

    .line 149
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clampBayerHotPixels([FII)V

    .line 152
    :cond_11
    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->normalizedMatrix([F)[D

    move-result-object v4

    .line 153
    new-array v5, v9, [F

    .line 154
    new-array v6, v9, [F

    .line 155
    new-array v7, v9, [F

    .line 156
    move-object v3, v12

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->demosaicMalvar([FII[I[D[F[F[F)V

    .line 158
    const/16 v0, 0x96

    move/from16 v3, p12

    if-le v3, v0, :cond_12

    move/from16 v0, v21

    if-lt v1, v0, :cond_12

    if-lt v2, v0, :cond_12

    .line 159
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

    .line 161
    :cond_12
    if-lt v1, v8, :cond_13

    if-lt v2, v8, :cond_13

    .line 162
    invoke-static {v5, v6, v7, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->suppressDemosaicFringes([F[F[FII)V

    .line 165
    :cond_13
    new-array v0, v9, [I

    .line 166
    cmpl-float v3, p8, p5

    const/4 v4, 0x0

    if-lez v3, :cond_14

    new-array v8, v9, [F

    goto :goto_c

    :cond_14
    move-object v8, v4

    .line 167
    :goto_c
    if-lez v3, :cond_15

    new-array v10, v9, [F

    goto :goto_d

    :cond_15
    move-object v10, v4

    .line 168
    :goto_d
    if-lez v3, :cond_16

    new-array v11, v9, [F

    goto :goto_e

    :cond_16
    move-object v11, v4

    .line 169
    :goto_e
    if-lez v3, :cond_17

    new-array v4, v9, [F

    .line 171
    :cond_17
    const/4 v15, 0x0

    :goto_f
    if-ge v15, v9, :cond_1a

    .line 172
    aget v3, v5, v15

    float-to-double v12, v3

    .line 173
    aget v3, v6, v15

    move-object v14, v0

    float-to-double v0, v3

    .line 174
    aget v3, v7, v15

    float-to-double v2, v3

    .line 175
    move-object/from16 p0, v4

    move-object/from16 v16, v5

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    invoke-static {v12, v13, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v4

    .line 176
    nop

    .line 177
    const-wide v17, 0x3feae147ae147ae1L    # 0.84

    cmpl-double v19, v4, v17

    if-lez v19, :cond_18

    .line 178
    sub-double v19, v4, v17

    .line 179
    const-wide v24, 0x3fc47ae147ae147bL    # 0.16

    add-double v26, v19, v24

    div-double v19, v19, v26

    mul-double v19, v19, v24

    add-double v19, v19, v17

    div-double v19, v19, v4

    goto :goto_10

    .line 177
    :cond_18
    const-wide/high16 v19, 0x3ff0000000000000L    # 1.0

    .line 181
    :goto_10
    mul-double v12, v12, v19

    invoke-static {v12, v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v4

    .line 182
    mul-double v0, v0, v19

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v0

    .line 183
    mul-double v2, v2, v19

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v1

    .line 184
    if-nez p0, :cond_19

    .line 185
    invoke-static {v4, v0, v1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v0

    aput v0, v14, v15

    goto :goto_11

    .line 187
    :cond_19
    aput v4, v8, v15

    .line 188
    aput v0, v10, v15

    .line 189
    aput v1, v11, v15

    .line 190
    const v2, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v4, v2

    const v2, 0x3f371759    # 0.7152f

    mul-float/2addr v0, v2

    add-float/2addr v4, v0

    const v0, 0x3d93dd98    # 0.0722f

    mul-float/2addr v1, v0

    add-float/2addr v4, v1

    aput v4, p0, v15

    .line 171
    :goto_11
    add-int/lit8 v15, v15, 0x1

    move-object/from16 v4, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object v0, v14

    move-object/from16 v5, v16

    goto :goto_f

    .line 193
    :cond_1a
    move-object v14, v0

    move-object/from16 p0, v4

    if-eqz p0, :cond_1b

    .line 194
    move-object/from16 v6, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v7, p8

    move-object v3, v8

    move-object v4, v10

    move-object v5, v11

    move-object v0, v14

    move/from16 v8, p12

    invoke-static/range {v0 .. v8}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->sharpenHeadroomDamped([III[F[F[F[FFI)V

    .line 196
    :cond_1b
    return-object v14

    .line 97
    :cond_1c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid Bayer image or calibration"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static sharpen([III[F[F[F[FF)V
    .locals 17

    .line 613
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_7

    .line 614
    if-nez v3, :cond_0

    const/4 v4, 0x0

    goto :goto_1

    :cond_0
    neg-int v4, v0

    .line 615
    :goto_1
    add-int/lit8 v5, v1, -0x1

    if-ne v3, v5, :cond_1

    const/4 v5, 0x0

    goto :goto_2

    :cond_1
    move v5, v0

    .line 616
    :goto_2
    mul-int v6, v3, v0

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v0, :cond_6

    .line 617
    if-nez v7, :cond_2

    const/4 v8, 0x0

    goto :goto_4

    :cond_2
    const/4 v8, -0x1

    .line 618
    :goto_4
    add-int/lit8 v9, v0, -0x1

    if-ne v7, v9, :cond_3

    const/4 v9, 0x0

    goto :goto_5

    :cond_3
    const/4 v9, 0x1

    .line 619
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

    .line 622
    aget v8, p6, v6

    sub-float/2addr v8, v11

    float-to-double v8, v8

    move/from16 v10, p7

    float-to-double v11, v10

    mul-double/2addr v8, v11

    .line 623
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

    .line 624
    :cond_4
    aget v13, p3, v6

    aget v14, p4, v6

    aget v15, p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->min(FF)F

    move-result v14

    invoke-static {v13, v14}, Ljava/lang/Math;->min(FF)F

    move-result v13

    float-to-double v13, v13

    .line 626
    :goto_6
    move/from16 v16, v3

    const-wide v2, 0x3f90101010101010L    # 0.01568627450980392

    invoke-static {v13, v14, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    .line 627
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

    .line 628
    aget v3, p3, v6

    add-float/2addr v3, v2

    aget v8, p4, v6

    add-float/2addr v8, v2

    aget v9, p5, v6

    add-float/2addr v9, v2

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v2

    aput v2, p0, v6

    .line 616
    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, 0x1

    move/from16 v3, v16

    goto/16 :goto_3

    .line 613
    :cond_6
    move/from16 v10, p7

    move/from16 v16, v3

    add-int/lit8 v3, v16, 0x1

    goto/16 :goto_0

    .line 631
    :cond_7
    return-void
.end method

.method private static sharpenHeadroomDamped([III[F[F[F[FFI)V
    .locals 20

    .line 409
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v2, 0x1

    const/4 v3, -0x1

    const/4 v4, 0x0

    filled-new-array {v3, v4, v3, v2}, [I

    move-result-object v2

    .line 410
    filled-new-array {v4, v3, v3, v3}, [I

    move-result-object v3

    .line 411
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

    .line 412
    mul-float v5, v5, p7

    .line 413
    move v7, v4

    :goto_0
    if-ge v7, v1, :cond_b

    .line 414
    mul-int v8, v7, v0

    move v9, v4

    :goto_1
    if-ge v9, v0, :cond_a

    .line 415
    aget v10, p6, v8

    .line 416
    nop

    .line 417
    nop

    .line 418
    nop

    .line 419
    nop

    .line 420
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

    .line 421
    add-int/lit8 v6, v0, -0x1

    aget v18, v2, v12

    const/16 p7, 0x0

    add-int v11, v9, v18

    invoke-static {v6, v11}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-static {v4, v11}, Ljava/lang/Math;->max(II)I

    move-result v11

    .line 422
    add-int/lit8 v4, v1, -0x1

    aget v19, v3, v12

    add-int v0, v7, v19

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 423
    aget v18, v2, v12

    move/from16 v19, v0

    sub-int v0, v9, v18

    invoke-static {v6, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 424
    aget v6, v3, v12

    sub-int v6, v7, v6

    invoke-static {v4, v6}, Ljava/lang/Math;->min(II)I

    move-result v4

    invoke-static {v1, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 425
    mul-int v6, v19, p1

    add-int/2addr v6, v11

    aget v6, p6, v6

    .line 426
    mul-int v4, v4, p1

    add-int/2addr v4, v0

    aget v0, p6, v4

    .line 427
    cmpg-float v4, v6, v15

    if-gez v4, :cond_0

    move v15, v6

    .line 428
    :cond_0
    cmpg-float v4, v0, v15

    if-gez v4, :cond_1

    move v15, v0

    .line 429
    :cond_1
    cmpl-float v4, v6, v17

    if-lez v4, :cond_2

    move/from16 v17, v6

    .line 430
    :cond_2
    cmpl-float v4, v0, v17

    if-lez v4, :cond_3

    move/from16 v17, v0

    .line 431
    :cond_3
    sub-float v4, v6, v0

    invoke-static {v4}, Ljava/lang/Math;->abs(F)F

    move-result v4

    .line 432
    cmpl-float v11, v4, v13

    if-lez v11, :cond_4

    move v13, v4

    .line 434
    :cond_4
    const v11, 0x3ca3d70a    # 0.02f

    add-float/2addr v4, v11

    .line 435
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

    .line 436
    :goto_3
    mul-float/2addr v6, v4

    add-float v16, v16, v6

    .line 437
    add-float/2addr v14, v4

    .line 420
    add-int/lit8 v12, v12, 0x1

    move/from16 v0, p1

    move/from16 v6, p8

    move v4, v1

    move/from16 v1, p2

    goto/16 :goto_2

    .line 439
    :cond_6
    move v1, v4

    const/16 p7, 0x0

    const v0, 0x3c449ba6    # 0.012f

    sub-float/2addr v13, v0

    const v0, 0x3d072b02    # 0.033f

    div-float/2addr v13, v0

    invoke-static {v13}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->clamp01(F)F

    move-result v0

    .line 440
    mul-float v4, v0, v0

    const/high16 v6, 0x40000000    # 2.0f

    mul-float/2addr v0, v6

    const/high16 v6, 0x40400000    # 3.0f

    sub-float/2addr v6, v0

    mul-float/2addr v4, v6

    .line 441
    cmpl-float v0, v14, p7

    if-lez v0, :cond_7

    div-float v16, v16, v14

    goto :goto_4

    :cond_7
    move/from16 v16, v10

    .line 442
    :goto_4
    sub-float v0, v10, v16

    mul-float/2addr v0, v5

    mul-float/2addr v0, v4

    .line 443
    sub-float v4, v17, v10

    move/from16 v6, p7

    invoke-static {v6, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 444
    sub-float/2addr v10, v15

    invoke-static {v6, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 445
    cmpl-float v11, v0, v6

    const/high16 v6, 0x3f000000    # 0.5f

    if-lez v11, :cond_8

    .line 446
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

    .line 447
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

    .line 448
    :goto_5
    const v6, 0x3c40c0c1

    invoke-static {v4, v6}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/4 v6, 0x0

    invoke-static {v6, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 449
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

    .line 450
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

    .line 414
    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v8, v8, 0x1

    move/from16 v0, p1

    move/from16 v6, p8

    move v4, v1

    move/from16 v1, p2

    goto/16 :goto_1

    .line 413
    :cond_a
    move v1, v4

    move/from16 p8, v6

    add-int/lit8 v7, v7, 0x1

    move/from16 v0, p1

    move/from16 v1, p2

    goto/16 :goto_0

    .line 453
    :cond_b
    return-void
.end method

.method private static smoothChromaByIso([F[F[FIII)V
    .locals 25

    .line 266
    mul-int v0, p3, p4

    .line 267
    new-array v1, v0, [F

    .line 268
    new-array v2, v0, [F

    .line 269
    new-array v3, v0, [F

    .line 270
    const/4 v4, 0x0

    :goto_0
    const v5, 0x3d93dd98    # 0.0722f

    const v6, 0x3f371759    # 0.7152f

    const v7, 0x3e59b3d0    # 0.2126f

    if-ge v4, v0, :cond_0

    .line 271
    aget v8, p0, v4

    mul-float/2addr v8, v7

    aget v7, p1, v4

    mul-float/2addr v7, v6

    add-float/2addr v8, v7

    aget v6, p2, v4

    mul-float/2addr v6, v5

    add-float/2addr v8, v6

    .line 272
    aput v8, v1, v4

    .line 273
    aget v5, p2, v4

    sub-float/2addr v5, v8

    aput v5, v2, v4

    .line 274
    aget v5, p0, v4

    sub-float/2addr v5, v8

    aput v5, v3, v4

    .line 270
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 276
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

    .line 277
    const v8, 0x3d75c28f    # 0.06f

    mul-float/2addr v8, v0

    const v9, 0x3d23d70a    # 0.04f

    add-float/2addr v8, v9

    div-float v8, v4, v8

    .line 278
    const/4 v9, 0x1

    move v10, v9

    :goto_1
    add-int/lit8 v11, p4, -0x1

    if-ge v10, v11, :cond_6

    .line 279
    mul-int v11, v10, p3

    .line 280
    move v12, v9

    :goto_2
    add-int/lit8 v13, p3, -0x1

    if-ge v12, v13, :cond_5

    .line 281
    add-int v13, v11, v12

    .line 282
    aget v14, v1, v13

    .line 283
    aget v15, v2, v13

    aget v16, v3, v13

    .line 284
    const/16 v17, -0x1

    move/from16 p5, v4

    move/from16 v18, p5

    move/from16 v4, v17

    :goto_3
    move/from16 v19, v5

    const/4 v5, 0x0

    if-gt v4, v9, :cond_4

    .line 285
    add-int v20, v10, v4

    mul-int v20, v20, p3

    .line 286
    move/from16 v21, v6

    move/from16 v6, v17

    :goto_4
    if-gt v6, v9, :cond_3

    .line 287
    if-nez v6, :cond_1

    if-nez v4, :cond_1

    goto :goto_6

    .line 288
    :cond_1
    add-int v22, v20, v12

    add-int v22, v22, v6

    .line 289
    aget v23, v1, v22

    sub-float v23, v23, v14

    invoke-static/range {v23 .. v23}, Ljava/lang/Math;->abs(F)F

    move-result v23

    mul-float v23, v23, v8

    .line 290
    cmpl-float v24, v23, p5

    if-ltz v24, :cond_2

    move/from16 v23, v5

    goto :goto_5

    :cond_2
    sub-float v23, p5, v23

    .line 291
    :goto_5
    aget v24, v2, v22

    mul-float v24, v24, v23

    add-float v15, v15, v24

    .line 292
    aget v22, v3, v22

    mul-float v22, v22, v23

    add-float v16, v16, v22

    .line 293
    add-float v18, v18, v23

    .line 286
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 284
    :cond_3
    add-int/lit8 v4, v4, 0x1

    move/from16 v5, v19

    move/from16 v6, v21

    goto :goto_3

    .line 296
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

    .line 297
    aget v15, v3, v13

    div-float v16, v16, v18

    aget v17, v3, v13

    sub-float v16, v16, v17

    mul-float v16, v16, v6

    add-float v15, v15, v16

    .line 298
    add-float/2addr v15, v14

    .line 299
    add-float/2addr v4, v14

    .line 300
    mul-float v6, v15, v7

    sub-float/2addr v14, v6

    mul-float v6, v4, v19

    sub-float/2addr v14, v6

    div-float v14, v14, v21

    .line 301
    invoke-static {v5, v15}, Ljava/lang/Math;->max(FF)F

    move-result v6

    aput v6, p0, v13

    .line 302
    invoke-static {v5, v14}, Ljava/lang/Math;->max(FF)F

    move-result v6

    aput v6, p1, v13

    .line 303
    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    aput v4, p2, v13

    .line 280
    add-int/lit8 v12, v12, 0x1

    move/from16 v4, p5

    move/from16 v5, v19

    move/from16 v6, v21

    goto/16 :goto_2

    .line 278
    :cond_5
    move/from16 p5, v4

    move/from16 v19, v5

    move/from16 v21, v6

    add-int/lit8 v10, v10, 0x1

    goto/16 :goto_1

    .line 306
    :cond_6
    return-void
.end method

.method private static suppressDemosaicFringes([F[F[FII)V
    .locals 26

    .line 315
    move/from16 v0, p3

    move/from16 v1, p4

    mul-int v2, v0, v1

    .line 316
    new-array v3, v2, [F

    .line 317
    new-array v4, v2, [F

    .line 318
    const/4 v6, 0x0

    :goto_0
    if-ge v6, v2, :cond_0

    .line 319
    aget v7, p0, v6

    aget v8, p1, v6

    sub-float/2addr v7, v8

    aput v7, v3, v6

    .line 320
    aget v7, p2, v6

    aget v8, p1, v6

    sub-float/2addr v7, v8

    aput v7, v4, v6

    .line 318
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 322
    :cond_0
    const/4 v2, 0x1

    move v6, v2

    :goto_1
    add-int/lit8 v7, v1, -0x1

    if-ge v6, v7, :cond_11

    .line 323
    mul-int v7, v6, v0

    .line 324
    move v8, v2

    :goto_2
    add-int/lit8 v9, v0, -0x1

    if-ge v8, v9, :cond_10

    .line 325
    add-int v9, v7, v8

    .line 326
    aget v10, p1, v9

    .line 327
    sub-int v11, v9, v0

    aget v11, p1, v11

    add-int v12, v9, v0

    aget v12, p1, v12

    .line 328
    add-int/lit8 v13, v9, -0x1

    aget v13, p1, v13

    add-int/lit8 v14, v9, 0x1

    aget v14, p1, v14

    .line 329
    invoke-static {v10, v11}, Ljava/lang/Math;->max(FF)F

    move-result v15

    invoke-static {v13, v14}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-static {v12, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    invoke-static {v15, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 330
    invoke-static {v10, v11}, Ljava/lang/Math;->min(FF)F

    move-result v11

    invoke-static {v13, v14}, Ljava/lang/Math;->min(FF)F

    move-result v13

    invoke-static {v12, v13}, Ljava/lang/Math;->min(FF)F

    move-result v12

    invoke-static {v11, v12}, Ljava/lang/Math;->min(FF)F

    move-result v11

    sub-float/2addr v5, v11

    .line 331
    const v11, 0x3e0f5c29    # 0.14f

    cmpg-float v5, v5, v11

    if-gez v5, :cond_1

    .line 332
    goto/16 :goto_9

    .line 334
    :cond_1
    aget v5, v3, v9

    .line 335
    aget v11, v4, v9

    .line 336
    nop

    .line 337
    nop

    .line 338
    mul-float v12, v5, v5

    mul-float v13, v11, v11

    add-float/2addr v12, v13

    .line 339
    nop

    .line 340
    nop

    .line 341
    move/from16 v16, v5

    move/from16 v17, v11

    move v15, v12

    const/4 v14, -0x1

    const/16 v18, 0x0

    :goto_3
    const v19, 0x3da3d70a    # 0.08f

    if-gt v14, v2, :cond_5

    .line 342
    add-int v20, v6, v14

    mul-int v20, v20, v0

    .line 343
    const/4 v13, -0x1

    :goto_4
    if-gt v13, v2, :cond_4

    .line 344
    if-nez v13, :cond_2

    if-nez v14, :cond_2

    goto :goto_5

    .line 345
    :cond_2
    add-int v22, v20, v8

    add-int v22, v22, v13

    .line 346
    aget v23, p1, v22

    sub-float v23, v23, v10

    invoke-static/range {v23 .. v23}, Ljava/lang/Math;->abs(F)F

    move-result v23

    cmpg-float v23, v23, v19

    if-gez v23, :cond_3

    .line 347
    aget v23, v3, v22

    .line 348
    aget v22, v4, v22

    .line 349
    mul-float v24, v23, v23

    mul-float v25, v22, v22

    add-float v24, v24, v25

    .line 350
    cmpg-float v25, v24, v15

    if-gez v25, :cond_3

    .line 351
    nop

    .line 352
    nop

    .line 353
    nop

    .line 354
    move/from16 v18, v2

    move/from16 v17, v22

    move/from16 v16, v23

    move/from16 v15, v24

    .line 343
    :cond_3
    :goto_5
    add-int/lit8 v13, v13, 0x1

    goto :goto_4

    .line 341
    :cond_4
    add-int/lit8 v14, v14, 0x1

    goto :goto_3

    .line 360
    :cond_5
    const/4 v13, 0x0

    :goto_6
    const/4 v14, 0x4

    if-ge v13, v14, :cond_b

    .line 361
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

    .line 362
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

    .line 363
    if-ltz v2, :cond_a

    if-ge v2, v0, :cond_a

    if-ltz v14, :cond_a

    if-ge v14, v1, :cond_a

    .line 364
    mul-int/2addr v14, v0

    add-int/2addr v14, v2

    .line 365
    aget v2, p1, v14

    sub-float/2addr v2, v10

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    cmpg-float v2, v2, v19

    if-gez v2, :cond_a

    .line 366
    aget v2, v3, v14

    .line 367
    aget v14, v4, v14

    .line 368
    mul-float v20, v2, v2

    mul-float v21, v14, v14

    add-float v20, v20, v21

    .line 369
    cmpg-float v21, v20, v15

    if-gez v21, :cond_a

    .line 370
    nop

    .line 371
    nop

    .line 372
    nop

    .line 373
    move/from16 v16, v2

    move/from16 v17, v14

    move/from16 v15, v20

    const/16 v18, 0x1

    .line 360
    :cond_a
    add-int/lit8 v13, v13, 0x1

    const/4 v2, 0x1

    goto :goto_6

    .line 378
    :cond_b
    if-eqz v18, :cond_f

    const/high16 v2, 0x40100000    # 2.25f

    mul-float/2addr v15, v2

    const v2, 0x3a03126f    # 5.0E-4f

    add-float/2addr v15, v2

    cmpg-float v2, v12, v15

    if-gtz v2, :cond_c

    .line 379
    goto/16 :goto_9

    .line 381
    :cond_c
    sub-float v16, v16, v5

    const v2, 0x3f4ccccd    # 0.8f

    mul-float v16, v16, v2

    add-float v16, v5, v16

    .line 382
    sub-float v17, v17, v11

    mul-float v17, v17, v2

    add-float v17, v11, v17

    .line 383
    cmpl-float v2, v16, v5

    if-nez v2, :cond_d

    cmpl-float v2, v17, v11

    if-eqz v2, :cond_f

    .line 384
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

    .line 385
    mul-float v5, v5, v16

    sub-float v10, v2, v5

    mul-float v11, v11, v17

    sub-float/2addr v10, v11

    .line 386
    const/4 v12, 0x0

    cmpl-float v13, v10, v12

    if-ltz v13, :cond_e

    .line 387
    add-float v2, v10, v16

    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p0, v9

    .line 388
    aput v10, p1, v9

    .line 389
    add-float v10, v10, v17

    invoke-static {v12, v10}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p2, v9

    goto :goto_9

    .line 391
    :cond_e
    const v10, 0x3727c5ac    # 1.0E-5f

    add-float v13, v5, v11

    invoke-static {v10, v13}, Ljava/lang/Math;->max(FF)F

    move-result v10

    div-float v10, v2, v10

    .line 392
    const/high16 v13, 0x3f800000    # 1.0f

    invoke-static {v13, v10}, Ljava/lang/Math;->min(FF)F

    move-result v10

    invoke-static {v12, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 393
    mul-float/2addr v5, v10

    sub-float/2addr v2, v5

    mul-float/2addr v11, v10

    sub-float/2addr v2, v11

    mul-float v16, v16, v10

    add-float v5, v2, v16

    invoke-static {v12, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    aput v5, p0, v9

    .line 394
    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v5

    aput v5, p1, v9

    .line 395
    mul-float v17, v17, v10

    add-float v2, v2, v17

    invoke-static {v12, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, p2, v9

    .line 324
    :cond_f
    :goto_9
    add-int/lit8 v8, v8, 0x1

    const/4 v2, 0x1

    goto/16 :goto_2

    .line 322
    :cond_10
    add-int/lit8 v6, v6, 0x1

    const/4 v2, 0x1

    goto/16 :goto_1

    .line 400
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
