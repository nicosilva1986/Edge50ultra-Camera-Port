.class public final Lcom/motorola/camera/custom/AppleStyleToneEngine;
.super Ljava/lang/Object;
.source "AppleStyleToneEngine.java"


# static fields
.field private static final GAMMA_LUT_SIZE:I = 0x1000

.field private static final GRID_STEP:I = 0x8

.field private static final LIN_TO_SRGB_BYTE:[I

.field private static final MAX_CUBE_SIZE:I = 0x40

.field private static final SRGB_TO_LIN:[F

.field public static final STYLE_IPHONE_AMBER:I = 0x3

.field public static final STYLE_IPHONE_NATURAL:I = 0x1

.field public static final STYLE_IPHONE_RICH_CONTRAST:I = 0x2

.field public static final STYLE_NONE:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 20
    const/16 v0, 0x100

    new-array v1, v0, [F

    sput-object v1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    .line 21
    const/16 v1, 0x1001

    new-array v1, v1, [I

    sput-object v1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->LIN_TO_SRGB_BYTE:[I

    .line 24
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_1

    .line 25
    int-to-float v3, v2

    const/high16 v4, 0x437f0000    # 255.0f

    div-float/2addr v3, v4

    .line 26
    sget-object v4, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    const v5, 0x3d25aee6    # 0.04045f

    cmpg-float v5, v3, v5

    if-gtz v5, :cond_0

    const v5, 0x414eb852    # 12.92f

    div-float/2addr v3, v5

    goto :goto_1

    :cond_0
    const v5, 0x3d6147ae    # 0.055f

    add-float/2addr v3, v5

    const v5, 0x3f870a3d    # 1.055f

    div-float/2addr v3, v5

    float-to-double v5, v3

    const-wide v7, 0x4003333333333333L    # 2.4

    invoke-static {v5, v6, v7, v8}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v5

    double-to-float v3, v5

    :goto_1
    aput v3, v4, v2

    .line 24
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 28
    :cond_1
    move v0, v1

    :goto_2
    const/16 v2, 0x1000

    if-gt v0, v2, :cond_3

    .line 29
    int-to-double v2, v0

    const-wide/high16 v4, 0x40b0000000000000L    # 4096.0

    div-double/2addr v2, v4

    .line 30
    const-wide v4, 0x3f69a5c37387b719L    # 0.0031308

    cmpg-double v4, v2, v4

    if-gtz v4, :cond_2

    const-wide v4, 0x4029d70a3d70a3d7L    # 12.92

    mul-double/2addr v2, v4

    goto :goto_3

    :cond_2
    const-wide v4, 0x3fdaaaaaaaaaaaabL    # 0.4166666666666667

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    const-wide v4, 0x3ff0e147ae147ae1L    # 1.055

    mul-double/2addr v2, v4

    const-wide v4, 0x3fac28f5c28f5c29L    # 0.055

    sub-double/2addr v2, v4

    .line 31
    :goto_3
    sget-object v4, Lcom/motorola/camera/custom/AppleStyleToneEngine;->LIN_TO_SRGB_BYTE:[I

    const-wide v5, 0x406fe00000000000L    # 255.0

    mul-double/2addr v2, v5

    invoke-static {v2, v3}, Ljava/lang/Math;->round(D)J

    move-result-wide v2

    long-to-int v2, v2

    const/16 v3, 0xff

    invoke-static {v3, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    aput v2, v4, v0

    .line 28
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 33
    :cond_3
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static accumulateAutoLtmBand([IIIII[F[FII)V
    .locals 22

    .line 279
    move/from16 v0, p1

    move/from16 v1, p3

    move/from16 v2, p4

    move/from16 v3, p7

    if-eqz p0, :cond_6

    if-eqz p5, :cond_6

    if-eqz p6, :cond_6

    const/16 v4, 0x10

    if-lt v0, v4, :cond_6

    if-ge v2, v4, :cond_0

    goto/16 :goto_4

    .line 282
    :cond_0
    div-int/lit8 v4, v1, 0x8

    .line 283
    add-int v5, v1, p2

    add-int/lit8 v6, v5, 0x8

    add-int/lit8 v6, v6, -0x1

    div-int/lit8 v6, v6, 0x8

    move/from16 v7, p8

    invoke-static {v7, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 284
    nop

    :goto_0
    if-ge v4, v6, :cond_5

    .line 285
    mul-int/lit8 v7, v4, 0x8

    invoke-static {v1, v7}, Ljava/lang/Math;->max(II)I

    move-result v7

    .line 286
    invoke-static {v2, v5}, Ljava/lang/Math;->min(II)I

    move-result v8

    add-int/lit8 v9, v4, 0x1

    mul-int/lit8 v10, v9, 0x8

    invoke-static {v8, v10}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 287
    const/4 v11, 0x0

    :goto_1
    if-ge v11, v3, :cond_4

    .line 288
    mul-int/lit8 v12, v11, 0x8

    .line 289
    add-int/lit8 v13, v12, 0x8

    invoke-static {v0, v13}, Ljava/lang/Math;->min(II)I

    move-result v13

    .line 290
    nop

    .line 291
    nop

    .line 292
    nop

    .line 293
    const-wide/16 v14, 0x0

    move v10, v7

    move-wide/from16 v16, v14

    const/4 v0, 0x0

    :goto_2
    if-ge v10, v8, :cond_2

    .line 294
    sub-int v18, v10, v1

    mul-int v18, v18, p1

    .line 295
    move/from16 p8, v0

    move v0, v12

    :goto_3
    if-ge v0, v13, :cond_1

    .line 296
    add-int v19, v18, v0

    move/from16 v20, v0

    aget v0, p0, v19

    .line 297
    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    aget v1, v19, v1

    const v19, 0x3e59b3d0    # 0.2126f

    mul-float v1, v1, v19

    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    move/from16 v21, v1

    ushr-int/lit8 v1, v0, 0x8

    and-int/lit16 v1, v1, 0xff

    aget v1, v19, v1

    const v19, 0x3f371759    # 0.7152f

    mul-float v1, v1, v19

    add-float v1, v21, v1

    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v19, v0

    const v19, 0x3d93dd98    # 0.0722f

    mul-float v0, v0, v19

    add-float/2addr v1, v0

    .line 300
    float-to-double v0, v1

    add-double/2addr v14, v0

    .line 301
    mul-double/2addr v0, v0

    add-double v16, v16, v0

    .line 302
    add-int/lit8 v0, p8, 0x1

    .line 295
    add-int/lit8 v1, v20, 0x2

    move/from16 p8, v0

    move v0, v1

    move/from16 v1, p3

    goto :goto_3

    .line 293
    :cond_1
    add-int/lit8 v10, v10, 0x2

    move/from16 v1, p3

    move/from16 v0, p8

    goto :goto_2

    .line 305
    :cond_2
    if-lez v0, :cond_3

    .line 306
    int-to-double v0, v0

    div-double/2addr v14, v0

    double-to-float v10, v14

    .line 307
    div-double v0, v16, v0

    double-to-float v0, v0

    mul-float v1, v10, v10

    sub-float/2addr v0, v1

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 308
    mul-int v1, v4, v3

    add-int/2addr v1, v11

    .line 309
    const v12, 0x3b03126f    # 0.002f

    add-float/2addr v10, v12

    float-to-double v12, v10

    invoke-static {v12, v13}, Ljava/lang/Math;->log(D)D

    move-result-wide v12

    double-to-float v10, v12

    aput v10, p5, v1

    .line 310
    float-to-double v12, v0

    invoke-static {v12, v13}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v12

    double-to-float v0, v12

    aput v0, p6, v1

    .line 287
    :cond_3
    add-int/lit8 v11, v11, 0x1

    move/from16 v0, p1

    move/from16 v1, p3

    goto/16 :goto_1

    .line 284
    :cond_4
    move/from16 v0, p1

    move/from16 v1, p3

    move v4, v9

    goto/16 :goto_0

    .line 314
    :cond_5
    return-void

    .line 280
    :cond_6
    :goto_4
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZ)V
    .locals 13

    .line 346
    const/high16 v12, 0x40c00000    # 6.0f

    move-object v0, p0

    move v1, p1

    move v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    invoke-static/range {v0 .. v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZF)V

    .line 349
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZF)V
    .locals 14

    .line 360
    move/from16 v11, p10

    move-object v0, p0

    move v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v12, p11

    move/from16 v13, p12

    invoke-static/range {v0 .. v13}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZF)V

    .line 363
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZF)V
    .locals 30

    .line 376
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    if-eqz v0, :cond_22

    if-lez v1, :cond_22

    if-lez v2, :cond_22

    if-nez p10, :cond_0

    if-nez p11, :cond_0

    if-nez p12, :cond_0

    goto/16 :goto_15

    .line 380
    :cond_0
    int-to-long v7, v1

    int-to-long v9, v2

    mul-long/2addr v7, v9

    .line 381
    array-length v2, v0

    int-to-long v9, v2

    invoke-static {v9, v10, v7, v8}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v7

    long-to-int v2, v7

    .line 382
    div-int v7, v2, v1

    .line 383
    if-gtz v7, :cond_1

    .line 384
    return-void

    .line 387
    :cond_1
    const/4 v9, 0x2

    if-eqz p10, :cond_2

    if-eqz v3, :cond_2

    if-eqz v4, :cond_2

    if-lt v5, v9, :cond_2

    if-lt v6, v9, :cond_2

    array-length v11, v3

    mul-int v12, v5, v6

    if-lt v11, v12, :cond_2

    array-length v11, v4

    if-lt v11, v12, :cond_2

    const/4 v11, 0x1

    goto :goto_0

    :cond_2
    const/4 v11, 0x0

    .line 391
    :goto_0
    const/high16 v15, 0x3f000000    # 0.5f

    const/4 v8, 0x0

    if-nez v11, :cond_4

    if-eqz p11, :cond_3

    goto :goto_1

    :cond_3
    move/from16 v19, v15

    const/high16 p5, -0x1000000

    const/high16 p10, 0x3f800000    # 1.0f

    const/high16 v18, 0x3e800000    # 0.25f

    goto/16 :goto_a

    .line 392
    :cond_4
    :goto_1
    const/4 v9, 0x0

    :goto_2
    if-ge v9, v7, :cond_10

    .line 393
    const/high16 p5, -0x1000000

    add-int v12, p3, v9

    .line 394
    const v16, 0x3f800347    # 1.0001f

    const/high16 v17, 0x41000000    # 8.0f

    if-eqz v11, :cond_5

    int-to-float v12, v12

    add-float/2addr v12, v15

    div-float v12, v12, v17

    sub-float/2addr v12, v15

    const/high16 p10, 0x3f800000    # 1.0f

    int-to-float v13, v6

    sub-float v13, v13, v16

    invoke-static {v12, v8, v13}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v12

    goto :goto_3

    :cond_5
    const/high16 p10, 0x3f800000    # 1.0f

    move v12, v8

    .line 395
    :goto_3
    float-to-int v13, v12

    .line 396
    if-eqz v11, :cond_6

    const/high16 v18, 0x3e800000    # 0.25f

    add-int/lit8 v14, v13, 0x1

    move/from16 v19, v15

    add-int/lit8 v15, v6, -0x1

    invoke-static {v14, v15}, Ljava/lang/Math;->min(II)I

    move-result v14

    goto :goto_4

    :cond_6
    move/from16 v19, v15

    const/high16 v18, 0x3e800000    # 0.25f

    const/4 v14, 0x0

    .line 397
    :goto_4
    int-to-float v15, v13

    sub-float/2addr v12, v15

    .line 398
    mul-int v15, v9, v1

    .line 400
    const/4 v10, 0x0

    :goto_5
    if-ge v10, v1, :cond_f

    .line 401
    add-int v21, v15, v10

    .line 402
    aget v8, v0, v21

    .line 403
    and-int v23, v8, p5

    .line 404
    ushr-int/lit8 v0, v8, 0x10

    and-int/lit16 v0, v0, 0xff

    .line 405
    ushr-int/lit8 v3, v8, 0x8

    and-int/lit16 v3, v3, 0xff

    .line 406
    and-int/lit16 v8, v8, 0xff

    .line 407
    or-int v24, v0, v3

    or-int v24, v24, v8

    if-nez v24, :cond_7

    .line 408
    move/from16 v24, v9

    move/from16 v25, v10

    goto/16 :goto_9

    .line 411
    :cond_7
    nop

    .line 412
    nop

    .line 413
    nop

    .line 415
    if-eqz v11, :cond_8

    .line 416
    int-to-float v4, v10

    add-float v4, v4, v19

    div-float v4, v4, v17

    sub-float v4, v4, v19

    int-to-float v6, v5

    sub-float v6, v6, v16

    const/4 v5, 0x0

    invoke-static {v4, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v4

    .line 417
    float-to-int v5, v4

    .line 418
    add-int/lit8 v6, v5, 0x1

    move/from16 v24, v4

    add-int/lit8 v4, p8, -0x1

    invoke-static {v6, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 419
    int-to-float v6, v5

    sub-float v6, v24, v6

    .line 420
    mul-int v24, v13, p8

    add-int v25, v24, v5

    .line 421
    add-int v24, v24, v4

    .line 422
    mul-int v26, v14, p8

    add-int v5, v26, v5

    .line 423
    add-int v26, v26, v4

    .line 425
    aget v4, p6, v25

    aget v27, p6, v24

    aget v28, p6, v25

    sub-float v27, v27, v28

    mul-float v27, v27, v6

    add-float v4, v4, v27

    .line 426
    aget v27, p6, v5

    aget v28, p6, v26

    aget v29, p6, v5

    sub-float v28, v28, v29

    mul-float v28, v28, v6

    add-float v27, v27, v28

    .line 427
    sub-float v27, v27, v4

    mul-float v27, v27, v12

    add-float v4, v4, v27

    .line 428
    move/from16 v27, v5

    float-to-double v4, v4

    invoke-static {v4, v5}, Ljava/lang/Math;->exp(D)D

    move-result-wide v4

    double-to-float v4, v4

    const v5, 0x3b03126f    # 0.002f

    sub-float/2addr v4, v5

    const v5, 0x3a03126f    # 5.0E-4f

    invoke-static {v5, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    .line 430
    aget v5, p7, v25

    aget v24, p7, v24

    aget v25, p7, v25

    sub-float v24, v24, v25

    mul-float v24, v24, v6

    add-float v5, v5, v24

    .line 431
    aget v24, p7, v27

    aget v25, p7, v26

    aget v26, p7, v27

    sub-float v25, v25, v26

    mul-float v25, v25, v6

    add-float v24, v24, v25

    .line 432
    sub-float v24, v24, v5

    mul-float v24, v24, v12

    add-float v5, v5, v24

    .line 434
    const v6, 0x3b83126f    # 0.004f

    move/from16 v24, v9

    const v9, 0x3ca3d70a    # 0.02f

    invoke-static {v6, v9, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v6

    .line 435
    const v9, 0x3d0f5c29    # 0.035f

    move/from16 v25, v6

    const v6, 0x3e0f5c29    # 0.14f

    invoke-static {v9, v6, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    sub-float v4, p10, v4

    .line 436
    const v6, 0x3c03126f    # 0.008f

    const v9, 0x3d0b4396    # 0.034f

    invoke-static {v6, v9, v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    .line 437
    const v6, 0x3e75c28f    # 0.24f

    mul-float v6, v6, v25

    mul-float/2addr v6, v4

    const/high16 v4, 0x3f400000    # 0.75f

    mul-float/2addr v5, v4

    add-float v5, v5, v18

    mul-float/2addr v6, v5

    add-float v6, v6, p10

    .line 438
    const v4, 0x3f8020c5    # 1.001f

    cmpl-float v4, v6, v4

    if-lez v4, :cond_9

    .line 439
    sget-object v4, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v4, v4, v0

    mul-float/2addr v4, v6

    .line 440
    sget-object v5, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v5, v5, v3

    mul-float/2addr v5, v6

    .line 441
    sget-object v9, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v9, v9, v8

    mul-float/2addr v9, v6

    .line 442
    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v4

    .line 443
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v5

    .line 444
    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v6

    goto :goto_6

    .line 415
    :cond_8
    move/from16 v24, v9

    .line 448
    :cond_9
    move v4, v0

    move v5, v3

    move v6, v8

    :goto_6
    if-nez p11, :cond_b

    if-eqz v11, :cond_a

    goto :goto_7

    :cond_a
    move/from16 v25, v10

    goto :goto_8

    .line 449
    :cond_b
    :goto_7
    invoke-static {v5, v6}, Ljava/lang/Math;->max(II)I

    move-result v9

    invoke-static {v4, v9}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 450
    move/from16 v25, v10

    const/16 v10, 0xe0

    if-le v9, v10, :cond_c

    .line 451
    int-to-float v9, v9

    const/high16 v10, 0x43600000    # 224.0f

    sub-float v26, v9, v10

    .line 452
    const/high16 v27, 0x43000000    # 128.0f

    mul-float v28, v26, v27

    add-float v26, v26, v27

    div-float v28, v28, v26

    add-float v28, v28, v10

    .line 453
    div-float v28, v28, v9

    .line 454
    int-to-float v4, v4

    mul-float v4, v4, v28

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v4

    .line 455
    int-to-float v5, v5

    mul-float v5, v5, v28

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    .line 456
    int-to-float v6, v6

    mul-float v6, v6, v28

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v6

    .line 460
    :cond_c
    :goto_8
    if-ne v4, v0, :cond_d

    if-ne v5, v3, :cond_d

    if-eq v6, v8, :cond_e

    .line 461
    :cond_d
    shl-int/lit8 v0, v4, 0x10

    or-int v0, v23, v0

    shl-int/lit8 v3, v5, 0x8

    or-int/2addr v0, v3

    or-int/2addr v0, v6

    aput v0, p0, v21

    .line 400
    :cond_e
    :goto_9
    add-int/lit8 v10, v25, 0x1

    const/4 v8, 0x0

    move-object/from16 v0, p0

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v9, v24

    goto/16 :goto_5

    .line 392
    :cond_f
    move/from16 v24, v9

    add-int/lit8 v9, v24, 0x1

    const/4 v8, 0x0

    move-object/from16 v0, p0

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v15, v19

    goto/16 :goto_2

    :cond_10
    move/from16 v19, v15

    const/high16 p5, -0x1000000

    const/high16 p10, 0x3f800000    # 1.0f

    const/high16 v18, 0x3e800000    # 0.25f

    .line 467
    :goto_a
    if-eqz p12, :cond_21

    const v0, 0x3fd9999a    # 1.7f

    cmpl-float v0, p13, v0

    if-ltz v0, :cond_21

    const/high16 v0, 0x41f00000    # 30.0f

    cmpg-float v0, p13, v0

    if-gtz v0, :cond_21

    const/4 v0, 0x6

    if-lt v1, v0, :cond_21

    if-lt v7, v0, :cond_21

    .line 471
    const v0, 0x403ccccd    # 2.95f

    cmpg-float v0, p13, v0

    const v3, 0x3f0ccccd    # 0.55f

    if-gez v0, :cond_11

    .line 472
    nop

    .line 473
    nop

    .line 474
    const v0, 0x3d20a0a1

    move/from16 v4, v18

    goto :goto_b

    .line 475
    :cond_11
    const/high16 v0, 0x41400000    # 12.0f

    cmpg-float v0, p13, v0

    if-gez v0, :cond_12

    .line 476
    nop

    .line 477
    nop

    .line 478
    const v0, 0x3d008081

    const v3, 0x3ef5c28f    # 0.48f

    const v4, 0x3ed70a3d    # 0.42f

    goto :goto_b

    .line 480
    :cond_12
    nop

    .line 481
    nop

    .line 482
    const v0, 0x3d109091

    const v4, 0x3ea3d70a    # 0.32f

    .line 484
    :goto_b
    new-array v5, v2, [F

    .line 485
    const/4 v8, 0x0

    :goto_c
    if-ge v8, v2, :cond_13

    .line 486
    aget v6, p0, v8

    .line 487
    ushr-int/lit8 v9, v6, 0x10

    and-int/lit16 v9, v9, 0xff

    int-to-float v9, v9

    const v10, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v9, v10

    ushr-int/lit8 v10, v6, 0x8

    and-int/lit16 v10, v10, 0xff

    int-to-float v10, v10

    const v11, 0x3f371759    # 0.7152f

    mul-float/2addr v10, v11

    add-float/2addr v9, v10

    and-int/lit16 v6, v6, 0xff

    int-to-float v6, v6

    const v10, 0x3d93dd98    # 0.0722f

    mul-float/2addr v6, v10

    add-float/2addr v9, v6

    const v6, 0x3b808081

    mul-float/2addr v9, v6

    aput v9, v5, v8

    .line 485
    add-int/lit8 v8, v8, 0x1

    goto :goto_c

    .line 491
    :cond_13
    mul-float/2addr v0, v0

    .line 492
    const/4 v2, 0x2

    :goto_d
    add-int/lit8 v6, v7, -0x2

    if-ge v2, v6, :cond_21

    .line 493
    mul-int v6, v2, v1

    .line 494
    const/4 v8, 0x2

    :goto_e
    add-int/lit8 v9, v1, -0x2

    if-ge v8, v9, :cond_20

    .line 495
    nop

    .line 496
    nop

    .line 497
    nop

    .line 498
    nop

    .line 499
    nop

    .line 500
    move/from16 v15, p10

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, -0x1

    :goto_f
    const/4 v9, 0x1

    if-gt v14, v9, :cond_17

    .line 501
    add-int v16, v2, v14

    mul-int v16, v16, v1

    .line 502
    move/from16 p3, v0

    const/4 v0, -0x1

    :goto_10
    if-gt v0, v9, :cond_16

    .line 503
    add-int v17, v16, v8

    add-int v17, v17, v0

    .line 504
    aget v20, v5, v17

    .line 505
    cmpg-float v21, v20, v15

    if-gez v21, :cond_14

    move/from16 v15, v20

    .line 506
    :cond_14
    cmpl-float v21, v20, v10

    if-lez v21, :cond_15

    move/from16 v10, v20

    .line 507
    :cond_15
    add-int/lit8 v20, v17, 0x1

    aget v20, v5, v20

    add-int/lit8 v21, v17, -0x1

    aget v21, v5, v21

    sub-float v20, v20, v21

    mul-float v20, v20, v19

    .line 508
    add-int v21, v17, v1

    aget v21, v5, v21

    sub-int v17, v17, v1

    aget v17, v5, v17

    sub-float v21, v21, v17

    mul-float v21, v21, v19

    .line 509
    mul-float v17, v20, v20

    add-float v11, v11, v17

    .line 510
    mul-float v20, v20, v21

    add-float v12, v12, v20

    .line 511
    mul-float v21, v21, v21

    add-float v13, v13, v21

    .line 502
    add-int/lit8 v0, v0, 0x1

    goto :goto_10

    .line 500
    :cond_16
    add-int/lit8 v14, v14, 0x1

    move/from16 v0, p3

    goto :goto_f

    .line 514
    :cond_17
    move/from16 p3, v0

    const v0, 0x3de38e39

    mul-float/2addr v11, v0

    .line 515
    mul-float/2addr v12, v0

    .line 516
    mul-float/2addr v13, v0

    .line 517
    add-float v0, v11, v13

    .line 518
    cmpg-float v14, v0, p3

    if-gez v14, :cond_18

    .line 519
    const/16 v22, 0x0

    goto/16 :goto_14

    .line 521
    :cond_18
    sub-float/2addr v11, v13

    .line 522
    mul-float v13, v11, v11

    const/high16 v14, 0x40800000    # 4.0f

    mul-float/2addr v14, v12

    mul-float/2addr v14, v12

    add-float/2addr v13, v14

    float-to-double v13, v13

    invoke-static {v13, v14}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v13

    double-to-float v13, v13

    .line 523
    add-float v14, v0, v13

    mul-float v14, v14, v19

    .line 524
    sub-float/2addr v0, v13

    mul-float v0, v0, v19

    .line 525
    sub-float v16, v14, v0

    add-float/2addr v14, v0

    const v0, 0x322bcc77    # 1.0E-8f

    add-float/2addr v14, v0

    div-float v0, v16, v14

    .line 526
    cmpg-float v14, v0, v3

    if-gez v14, :cond_19

    .line 527
    const/16 v22, 0x0

    goto/16 :goto_14

    .line 529
    :cond_19
    const/16 v22, 0x0

    cmpl-float v14, v11, v22

    const/high16 v16, 0x40000000    # 2.0f

    if-ltz v14, :cond_1a

    add-float v17, v11, v13

    goto :goto_11

    :cond_1a
    mul-float v17, v12, v16

    .line 530
    :goto_11
    if-ltz v14, :cond_1b

    mul-float v12, v12, v16

    goto :goto_12

    :cond_1b
    sub-float v12, v13, v11

    .line 531
    :goto_12
    mul-float v11, v17, v17

    mul-float v13, v12, v12

    add-float/2addr v11, v13

    float-to-double v13, v11

    invoke-static {v13, v14}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v13

    double-to-float v11, v13

    .line 532
    const v13, 0x358637bd    # 1.0E-6f

    cmpg-float v13, v11, v13

    if-gez v13, :cond_1c

    .line 533
    const/16 v22, 0x0

    goto/16 :goto_14

    .line 535
    :cond_1c
    div-float v17, v17, v11

    .line 536
    div-float/2addr v12, v11

    .line 537
    int-to-float v11, v8

    sub-float v13, v11, v17

    int-to-float v14, v2

    sub-float v9, v14, v12

    invoke-static {v5, v1, v7, v13, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v9

    .line 538
    add-float v11, v11, v17

    add-float/2addr v14, v12

    invoke-static {v5, v1, v7, v11, v14}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v11

    .line 539
    add-int v12, v6, v8

    aget v13, v5, v12

    .line 540
    add-float/2addr v9, v11

    mul-float v9, v9, v19

    sub-float v9, v13, v9

    .line 541
    const v11, 0x3eb33333    # 0.35f

    add-float/2addr v11, v3

    const v14, 0x3f733333    # 0.95f

    invoke-static {v14, v11}, Ljava/lang/Math;->min(FF)F

    move-result v11

    invoke-static {v3, v11, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v0

    mul-float/2addr v0, v4

    .line 542
    mul-float/2addr v0, v9

    add-float/2addr v0, v13

    invoke-static {v0, v15, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v0

    .line 543
    sub-float/2addr v0, v13

    const/high16 v9, 0x437f0000    # 255.0f

    mul-float/2addr v0, v9

    .line 544
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v10

    cmpg-float v10, v10, v18

    if-gez v10, :cond_1d

    .line 545
    const/16 v22, 0x0

    goto :goto_14

    .line 547
    :cond_1d
    nop

    .line 548
    aget v10, p0, v12

    .line 549
    ushr-int/lit8 v11, v10, 0x10

    and-int/lit16 v11, v11, 0xff

    .line 550
    ushr-int/lit8 v13, v10, 0x8

    and-int/lit16 v13, v13, 0xff

    .line 551
    and-int/lit16 v14, v10, 0xff

    .line 552
    const/16 v22, 0x0

    cmpl-float v15, v0, v22

    if-lez v15, :cond_1e

    .line 553
    invoke-static {v13, v14}, Ljava/lang/Math;->max(II)I

    move-result v15

    invoke-static {v11, v15}, Ljava/lang/Math;->max(II)I

    move-result v15

    int-to-float v15, v15

    sub-float/2addr v9, v15

    .line 554
    invoke-static {v0, v9}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 555
    goto :goto_13

    .line 556
    :cond_1e
    invoke-static {v13, v14}, Ljava/lang/Math;->min(II)I

    move-result v9

    invoke-static {v11, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    neg-int v9, v9

    int-to-float v9, v9

    .line 557
    invoke-static {v0, v9}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 559
    :goto_13
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 560
    if-eqz v0, :cond_1f

    .line 561
    and-int v9, v10, p5

    add-int/2addr v11, v0

    .line 562
    invoke-static {v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v10

    shl-int/lit8 v10, v10, 0x10

    or-int/2addr v9, v10

    add-int/2addr v13, v0

    .line 563
    invoke-static {v13}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v10

    shl-int/lit8 v10, v10, 0x8

    or-int/2addr v9, v10

    add-int/2addr v14, v0

    .line 564
    invoke-static {v14}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v0

    or-int/2addr v0, v9

    aput v0, p0, v12

    .line 494
    :cond_1f
    :goto_14
    add-int/lit8 v8, v8, 0x1

    move/from16 v0, p3

    goto/16 :goto_e

    .line 492
    :cond_20
    move/from16 p3, v0

    const/16 v22, 0x0

    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_d

    .line 569
    :cond_21
    return-void

    .line 378
    :cond_22
    :goto_15
    return-void
.end method

.method private static applyLightnessCurve(FI)F
    .locals 4

    .line 800
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 801
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    return v0

    .line 802
    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_4

    .line 804
    const p1, 0x3e6147ae    # 0.22f

    cmpg-float v1, p0, p1

    if-gez v1, :cond_2

    .line 805
    float-to-double p0, p0

    const-wide v0, 0x3fcc28f5c28f5c29L    # 0.22

    div-double/2addr p0, v0

    const-wide v2, 0x3ff2e147ae147ae1L    # 1.18

    invoke-static {p0, p1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide p0

    mul-double/2addr p0, v0

    double-to-float p0, p0

    return p0

    .line 807
    :cond_2
    const v1, 0x3f3851ec    # 0.72f

    cmpg-float v2, p0, v1

    if-gez v2, :cond_3

    .line 808
    sub-float p1, p0, p1

    const/high16 v0, 0x3f000000    # 0.5f

    div-float/2addr p1, v0

    .line 809
    const-wide v0, 0x400921fb54442d18L    # Math.PI

    float-to-double v2, p1

    mul-double/2addr v2, v0

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    double-to-float p1, v0

    const v0, 0x3d03126f    # 0.032f

    mul-float/2addr p1, v0

    sub-float/2addr p0, p1

    return p0

    .line 811
    :cond_3
    const p1, 0x3f6b851f    # 0.92f

    invoke-static {v1, p1, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p1

    const v1, 0x3c23d70a    # 0.01f

    mul-float/2addr p1, v1

    sub-float/2addr v0, p0

    mul-float/2addr p1, v0

    const/high16 v0, 0x40200000    # 2.5f

    mul-float/2addr p1, v0

    add-float/2addr p0, p1

    invoke-static {p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0

    .line 813
    :cond_4
    const/4 v1, 0x3

    if-ne p1, v1, :cond_5

    .line 815
    const p1, 0x3c9374bc    # 0.018f

    mul-float/2addr p1, p0

    sub-float/2addr v0, p0

    mul-float/2addr p1, v0

    const v0, 0x3df5c28f    # 0.12f

    sub-float v0, p0, v0

    mul-float/2addr p1, v0

    const v0, 0x404ccccd    # 3.2f

    mul-float/2addr p1, v0

    add-float/2addr p0, p1

    invoke-static {p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0

    .line 818
    :cond_5
    const p1, 0x3e3851ec    # 0.18f

    const v1, 0x3ee66666    # 0.45f

    invoke-static {p1, v1, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p1

    const v1, 0x3c449ba6    # 0.012f

    mul-float/2addr p1, v1

    sub-float/2addr v0, p0

    mul-float/2addr p1, v0

    const v0, 0x3f0ccccd    # 0.55f

    sub-float/2addr v0, p0

    mul-float/2addr p1, v0

    const/high16 v0, 0x40000000    # 2.0f

    mul-float/2addr p1, v0

    add-float/2addr p0, p1

    invoke-static {p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0
.end method

.method public static applyToArgbPixels([IIII)V
    .locals 7

    .line 38
    const/4 v6, 0x0

    move v4, p1

    move v5, p2

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIIIIII)V

    .line 39
    return-void
.end method

.method public static applyToArgbPixels([IIIIIII)V
    .locals 35

    .line 47
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v8, p3

    move/from16 v3, p4

    move/from16 v4, p5

    if-eqz v0, :cond_11

    if-lez v1, :cond_11

    if-gtz v2, :cond_0

    goto/16 :goto_e

    .line 50
    :cond_0
    const/4 v13, 0x1

    if-lt v8, v13, :cond_10

    const/4 v5, 0x3

    if-le v8, v5, :cond_1

    goto/16 :goto_d

    .line 53
    :cond_1
    int-to-long v6, v1

    int-to-long v9, v2

    mul-long/2addr v6, v9

    .line 54
    array-length v2, v0

    int-to-long v9, v2

    invoke-static {v9, v10, v6, v7}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    long-to-int v2, v6

    .line 55
    div-int v14, v2, v1

    .line 56
    if-gtz v14, :cond_2

    .line 57
    return-void

    .line 59
    :cond_2
    const/16 v2, 0x40

    const/4 v15, 0x0

    if-lt v3, v2, :cond_3

    if-lt v4, v2, :cond_3

    move v10, v13

    goto :goto_0

    :cond_3
    move v10, v15

    .line 60
    :goto_0
    const/high16 v2, 0x40000000    # 2.0f

    const/4 v6, 0x0

    if-eqz v10, :cond_4

    int-to-float v3, v3

    div-float v3, v2, v3

    move/from16 v16, v3

    goto :goto_1

    :cond_4
    move/from16 v16, v6

    .line 61
    :goto_1
    if-eqz v10, :cond_5

    int-to-float v3, v4

    div-float/2addr v2, v3

    move/from16 v17, v2

    goto :goto_2

    :cond_5
    move/from16 v17, v6

    .line 62
    :goto_2
    const/4 v2, 0x2

    if-ne v8, v5, :cond_6

    const v3, 0x3e23d70a    # 0.16f

    move/from16 v18, v3

    goto :goto_4

    .line 63
    :cond_6
    if-ne v8, v2, :cond_7

    const v3, 0x3df5c28f    # 0.12f

    goto :goto_3

    :cond_7
    const v3, 0x3d4ccccd    # 0.05f

    :goto_3
    move/from16 v18, v3

    .line 65
    :goto_4
    nop

    .line 66
    nop

    .line 67
    nop

    .line 68
    const/16 v3, 0x10

    if-lt v1, v3, :cond_8

    if-lt v14, v3, :cond_8

    .line 69
    add-int/lit8 v3, v1, 0x8

    sub-int/2addr v3, v13

    div-int/lit8 v3, v3, 0x8

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 70
    add-int/lit8 v4, v14, 0x8

    sub-int/2addr v4, v13

    div-int/lit8 v4, v4, 0x8

    invoke-static {v2, v4}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 71
    invoke-static {v0, v1, v14, v3, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->buildEdgeAwareBaseGrid([IIIII)[F

    move-result-object v4

    move-object/from16 v19, v4

    goto :goto_5

    .line 74
    :cond_8
    const/4 v4, 0x0

    move v2, v15

    move v3, v2

    move-object/from16 v19, v4

    :goto_5
    move v4, v15

    :goto_6
    if-ge v4, v14, :cond_f

    .line 75
    const v20, 0x3f800347    # 1.0001f

    const/high16 v21, 0x41000000    # 8.0f

    const/high16 v22, 0x3f000000    # 0.5f

    if-eqz v19, :cond_9

    int-to-float v5, v4

    add-float v5, v5, v22

    div-float v5, v5, v21

    sub-float v5, v5, v22

    int-to-float v7, v2

    sub-float v7, v7, v20

    invoke-static {v5, v6, v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v5

    goto :goto_7

    :cond_9
    move v5, v6

    .line 76
    :goto_7
    float-to-int v7, v5

    .line 77
    add-int/lit8 v9, v7, 0x1

    add-int/lit8 v11, v2, -0x1

    invoke-static {v15, v11}, Ljava/lang/Math;->max(II)I

    move-result v11

    invoke-static {v9, v11}, Ljava/lang/Math;->min(II)I

    move-result v23

    .line 78
    int-to-float v9, v7

    sub-float v24, v5, v9

    .line 79
    mul-int v25, v4, v1

    .line 80
    add-int v12, p6, v4

    .line 81
    const/high16 v26, 0x3f800000    # 1.0f

    if-eqz v10, :cond_a

    int-to-float v5, v12

    add-float v5, v5, v22

    mul-float v5, v5, v17

    sub-float v5, v5, v26

    goto :goto_8

    :cond_a
    move v5, v6

    .line 82
    :goto_8
    mul-float v27, v5, v5

    .line 84
    move v11, v15

    :goto_9
    if-ge v11, v1, :cond_e

    .line 85
    add-int v28, v25, v11

    .line 86
    aget v5, v0, v28

    .line 87
    const/high16 v9, -0x1000000

    and-int/2addr v9, v5

    .line 88
    ushr-int/lit8 v13, v5, 0x10

    and-int/lit16 v13, v13, 0xff

    .line 89
    ushr-int/lit8 v15, v5, 0x8

    and-int/lit16 v15, v15, 0xff

    .line 90
    and-int/lit16 v5, v5, 0xff

    .line 92
    sget-object v29, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v29, v29, v13

    .line 93
    sget-object v30, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v30, v30, v15

    .line 94
    sget-object v31, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v31, v31, v5

    .line 95
    if-ne v13, v15, :cond_b

    if-ne v15, v5, :cond_b

    const/4 v5, 0x1

    goto :goto_a

    :cond_b
    const/4 v5, 0x0

    .line 97
    :goto_a
    nop

    .line 98
    if-eqz v19, :cond_c

    .line 99
    int-to-float v13, v11

    add-float v13, v13, v22

    div-float v13, v13, v21

    sub-float v13, v13, v22

    int-to-float v15, v3

    sub-float v15, v15, v20

    invoke-static {v13, v6, v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v13

    .line 100
    float-to-int v15, v13

    .line 101
    add-int/lit8 v6, v15, 0x1

    add-int/lit8 v0, v3, -0x1

    invoke-static {v6, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 102
    int-to-float v6, v15

    sub-float/2addr v13, v6

    .line 103
    mul-int v6, v7, v3

    add-int v33, v6, v15

    aget v33, v19, v33

    .line 104
    add-int/2addr v6, v0

    aget v6, v19, v6

    .line 105
    mul-int v34, v23, v3

    add-int v15, v34, v15

    aget v15, v19, v15

    .line 106
    add-int v34, v34, v0

    aget v0, v19, v34

    .line 107
    sub-float v6, v6, v33

    mul-float/2addr v6, v13

    add-float v33, v33, v6

    .line 108
    sub-float/2addr v0, v15

    mul-float/2addr v0, v13

    add-float/2addr v15, v0

    .line 109
    sub-float v15, v15, v33

    mul-float v15, v15, v24

    add-float v33, v33, v15

    goto :goto_b

    .line 98
    :cond_c
    const/high16 v33, -0x40800000    # -1.0f

    .line 112
    :goto_b
    nop

    .line 113
    if-eqz v10, :cond_d

    .line 114
    int-to-float v0, v11

    add-float v0, v0, v22

    mul-float v0, v0, v16

    sub-float v0, v0, v26

    .line 116
    mul-float/2addr v0, v0

    const v6, 0x3f51eb85    # 0.82f

    mul-float/2addr v0, v6

    add-float v0, v0, v27

    .line 117
    const v6, 0x3e8f5c29    # 0.28f

    const v13, 0x3fb0a3d7    # 1.38f

    invoke-static {v6, v13, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v0

    mul-float v0, v0, v18

    goto :goto_c

    .line 113
    :cond_d
    const/4 v0, 0x0

    .line 120
    :goto_c
    move/from16 v6, v29

    move/from16 v29, v3

    move v3, v6

    move v13, v2

    move v15, v4

    move v6, v5

    move v2, v9

    move/from16 v4, v30

    move/from16 v5, v31

    const/16 v32, 0x0

    move v9, v0

    move v0, v7

    move/from16 v7, v33

    invoke-static/range {v2 .. v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gradePixel(IFFFZFIFZII)I

    move-result v2

    aput v2, p0, v28

    .line 84
    add-int/lit8 v11, v11, 0x1

    move/from16 v8, p3

    move v7, v0

    move v2, v13

    move v4, v15

    move/from16 v3, v29

    move/from16 v6, v32

    const/4 v13, 0x1

    const/4 v15, 0x0

    move-object/from16 v0, p0

    goto/16 :goto_9

    .line 74
    :cond_e
    move v13, v2

    move/from16 v29, v3

    move v15, v4

    move/from16 v32, v6

    add-int/lit8 v4, v15, 0x1

    move-object/from16 v0, p0

    move/from16 v8, p3

    const/4 v13, 0x1

    const/4 v15, 0x0

    goto/16 :goto_6

    .line 123
    :cond_f
    return-void

    .line 51
    :cond_10
    :goto_d
    return-void

    .line 48
    :cond_11
    :goto_e
    return-void
.end method

.method public static autoLtmGridStep()I
    .locals 1

    .line 273
    const/16 v0, 0x8

    return v0
.end method

.method private static bilateralSmoothLogGrid([FIIF)[F
    .locals 20

    .line 157
    move/from16 v0, p1

    move/from16 v1, p2

    mul-int v2, v0, v1

    new-array v3, v2, [F

    .line 158
    new-array v2, v2, [F

    .line 159
    const/high16 v4, 0x40000000    # 2.0f

    mul-float v4, v4, p3

    mul-float v4, v4, p3

    const/high16 v5, 0x3f800000    # 1.0f

    div-float/2addr v5, v4

    .line 160
    const/4 v4, 0x5

    new-array v4, v4, [F

    fill-array-data v4, :array_0

    .line 162
    const/4 v6, 0x0

    move v7, v6

    :goto_0
    const/4 v9, 0x2

    if-ge v7, v1, :cond_3

    .line 163
    mul-int v11, v7, v0

    .line 164
    move v12, v6

    :goto_1
    if-ge v12, v0, :cond_2

    .line 165
    add-int v13, v11, v12

    aget v14, p0, v13

    .line 166
    nop

    .line 167
    nop

    .line 168
    const/4 v15, -0x2

    const/16 v16, 0x0

    const/16 v17, 0x0

    :goto_2
    if-gt v15, v9, :cond_0

    .line 169
    add-int/lit8 v8, v0, -0x1

    const/16 v18, 0x0

    add-int v10, v12, v15

    invoke-static {v8, v10}, Ljava/lang/Math;->min(II)I

    move-result v8

    invoke-static {v6, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    .line 170
    add-int/2addr v8, v11

    aget v8, p0, v8

    .line 171
    sub-float v10, v8, v14

    .line 172
    add-int/lit8 v19, v15, 0x2

    aget v19, v4, v19

    mul-float/2addr v10, v10

    mul-float/2addr v10, v5

    invoke-static {v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result v10

    mul-float v19, v19, v10

    .line 173
    mul-float v8, v8, v19

    add-float v17, v17, v8

    .line 174
    add-float v16, v16, v19

    .line 168
    add-int/lit8 v15, v15, 0x1

    goto :goto_2

    .line 176
    :cond_0
    const/16 v18, 0x0

    cmpl-float v8, v16, v18

    if-lez v8, :cond_1

    div-float v14, v17, v16

    :cond_1
    aput v14, v3, v13

    .line 164
    add-int/lit8 v12, v12, 0x1

    goto :goto_1

    .line 162
    :cond_2
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 179
    :cond_3
    const/16 v18, 0x0

    move v7, v6

    :goto_3
    if-ge v7, v1, :cond_7

    .line 180
    mul-int v8, v7, v0

    .line 181
    move v10, v6

    :goto_4
    if-ge v10, v0, :cond_6

    .line 182
    add-int v11, v8, v10

    aget v12, v3, v11

    .line 183
    nop

    .line 184
    nop

    .line 185
    move/from16 v14, v18

    move v15, v14

    const/4 v13, -0x2

    :goto_5
    if-gt v13, v9, :cond_4

    .line 186
    add-int/lit8 v9, v1, -0x1

    add-int v0, v7, v13

    invoke-static {v9, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v6, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 187
    mul-int v0, v0, p1

    add-int/2addr v0, v10

    aget v0, v3, v0

    .line 188
    sub-float v9, v0, v12

    .line 189
    add-int/lit8 v17, v13, 0x2

    aget v17, v4, v17

    mul-float/2addr v9, v9

    mul-float/2addr v9, v5

    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result v9

    mul-float v17, v17, v9

    .line 190
    mul-float v0, v0, v17

    add-float/2addr v15, v0

    .line 191
    add-float v14, v14, v17

    .line 185
    add-int/lit8 v13, v13, 0x1

    move/from16 v0, p1

    const/4 v9, 0x2

    goto :goto_5

    .line 193
    :cond_4
    cmpl-float v0, v14, v18

    if-lez v0, :cond_5

    div-float v12, v15, v14

    :cond_5
    aput v12, v2, v11

    .line 181
    add-int/lit8 v10, v10, 0x1

    move/from16 v0, p1

    const/4 v9, 0x2

    goto :goto_4

    .line 179
    :cond_6
    add-int/lit8 v7, v7, 0x1

    move/from16 v0, p1

    const/4 v9, 0x2

    goto :goto_3

    .line 196
    :cond_7
    return-object v2

    nop

    :array_0
    .array-data 4
        0x3e800000    # 0.25f
        0x3f1c28f6    # 0.61f
        0x3f800000    # 1.0f
        0x3f1c28f6    # 0.61f
        0x3e800000    # 0.25f
    .end array-data
.end method

.method public static buildAutoLtmGrid([III)[[F
    .locals 11

    .line 326
    if-eqz p0, :cond_1

    const/16 v0, 0x10

    if-lt p1, v0, :cond_1

    if-lt p2, v0, :cond_1

    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 329
    :cond_0
    add-int/lit8 v0, p1, 0x8

    add-int/lit8 v0, v0, -0x1

    div-int/lit8 v0, v0, 0x8

    const/4 v1, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 330
    add-int/lit8 v0, p2, 0x8

    add-int/lit8 v0, v0, -0x1

    div-int/lit8 v0, v0, 0x8

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 331
    mul-int v0, v9, v10

    new-array v7, v0, [F

    .line 332
    new-array v8, v0, [F

    .line 333
    const/4 v5, 0x0

    move v6, p2

    move-object v2, p0

    move v3, p1

    move v4, p2

    invoke-static/range {v2 .. v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    .line 334
    invoke-static {v7, v9, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object p0

    filled-new-array {p0, v8}, [[F

    move-result-object p0

    return-object p0

    .line 327
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static buildEdgeAwareBaseGrid([IIIII)[F
    .locals 20

    .line 127
    move/from16 v0, p1

    move/from16 v1, p3

    move/from16 v2, p4

    mul-int v3, v1, v2

    new-array v3, v3, [F

    .line 128
    const/4 v5, 0x0

    :goto_0
    if-ge v5, v2, :cond_4

    .line 129
    mul-int/lit8 v6, v5, 0x8

    .line 130
    add-int/lit8 v7, v6, 0x8

    move/from16 v8, p2

    invoke-static {v8, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 131
    const/4 v9, 0x0

    :goto_1
    if-ge v9, v1, :cond_3

    .line 132
    mul-int/lit8 v10, v9, 0x8

    .line 133
    add-int/lit8 v11, v10, 0x8

    invoke-static {v0, v11}, Ljava/lang/Math;->min(II)I

    move-result v11

    .line 134
    nop

    .line 135
    nop

    .line 136
    const-wide/16 v12, 0x0

    move v14, v6

    const/4 v15, 0x0

    :goto_2
    if-ge v14, v7, :cond_1

    .line 137
    mul-int v16, v14, v0

    .line 138
    move v4, v10

    :goto_3
    if-ge v4, v11, :cond_0

    .line 139
    add-int v17, v16, v4

    aget v0, p0, v17

    .line 140
    sget-object v17, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    move/from16 v18, v4

    ushr-int/lit8 v4, v0, 0x10

    and-int/lit16 v4, v4, 0xff

    aget v4, v17, v4

    const v17, 0x3e59b3d0    # 0.2126f

    mul-float v4, v4, v17

    sget-object v17, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    move/from16 v19, v4

    ushr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    aget v4, v17, v4

    const v17, 0x3f371759    # 0.7152f

    mul-float v4, v4, v17

    add-float v4, v19, v4

    sget-object v17, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v17, v0

    const v17, 0x3d93dd98    # 0.0722f

    mul-float v0, v0, v17

    add-float/2addr v4, v0

    .line 143
    move v0, v5

    float-to-double v4, v4

    add-double/2addr v12, v4

    .line 144
    add-int/lit8 v15, v15, 0x1

    .line 138
    add-int/lit8 v4, v18, 0x2

    move v5, v0

    move/from16 v0, p1

    goto :goto_3

    .line 136
    :cond_0
    move v0, v5

    add-int/lit8 v14, v14, 0x2

    move/from16 v0, p1

    goto :goto_2

    .line 147
    :cond_1
    move v0, v5

    if-lez v15, :cond_2

    int-to-double v4, v15

    div-double/2addr v12, v4

    double-to-float v4, v12

    goto :goto_4

    :cond_2
    const/4 v4, 0x0

    .line 148
    :goto_4
    mul-int v5, v0, v1

    add-int/2addr v5, v9

    const v10, 0x3b03126f    # 0.002f

    add-float/2addr v4, v10

    float-to-double v10, v4

    invoke-static {v10, v11}, Ljava/lang/Math;->log(D)D

    move-result-wide v10

    double-to-float v4, v10

    aput v4, v3, v5

    .line 131
    add-int/lit8 v9, v9, 0x1

    move v5, v0

    move/from16 v0, p1

    goto :goto_1

    .line 128
    :cond_3
    move v0, v5

    add-int/lit8 v5, v0, 0x1

    move/from16 v0, p1

    goto/16 :goto_0

    .line 153
    :cond_4
    const v0, 0x3ecccccd    # 0.4f

    invoke-static {v3, v1, v2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->bilateralSmoothLogGrid([FIIF)[F

    move-result-object v0

    return-object v0
.end method

.method private static clamp(FFF)F
    .locals 1

    .line 877
    cmpg-float v0, p0, p1

    if-gez v0, :cond_0

    move p0, p1

    goto :goto_0

    :cond_0
    cmpl-float p1, p0, p2

    if-lez p1, :cond_1

    move p0, p2

    :cond_1
    :goto_0
    return p0
.end method

.method private static clamp01(F)F
    .locals 2

    .line 873
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

.method private static clampByte(I)I
    .locals 1

    .line 590
    if-gez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    const/16 v0, 0xff

    invoke-static {v0, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    :goto_0
    return p0
.end method

.method private static countWords(Ljava/lang/String;II)I
    .locals 2

    .line 1046
    nop

    .line 1047
    const/4 v0, 0x0

    .line 1048
    :goto_0
    if-ge p1, p2, :cond_2

    .line 1049
    :goto_1
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1050
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 1052
    :cond_0
    if-lt p1, p2, :cond_1

    .line 1053
    goto :goto_2

    .line 1055
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 1056
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    goto :goto_0

    .line 1058
    :cond_2
    :goto_2
    return v0
.end method

.method private static deterministicGrain6(II)F
    .locals 1

    .line 855
    const v0, -0x61c8864f

    mul-int/2addr p0, v0

    const v0, -0x7a143589

    mul-int/2addr p1, v0

    xor-int/2addr p0, p1

    .line 856
    ushr-int/lit8 p1, p0, 0xf

    xor-int/2addr p0, p1

    .line 857
    const p1, 0x2c1b3c6d

    mul-int/2addr p0, p1

    .line 858
    ushr-int/lit8 p1, p0, 0xc

    xor-int/2addr p0, p1

    .line 860
    and-int/lit16 p1, p0, 0xff

    ushr-int/lit8 v0, p0, 0x8

    and-int/lit16 v0, v0, 0xff

    add-int/2addr p1, v0

    .line 861
    ushr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    ushr-int/lit8 p0, p0, 0x18

    and-int/lit16 p0, p0, 0xff

    add-int/2addr v0, p0

    .line 862
    add-int/2addr p1, v0

    int-to-float p0, p1

    const/high16 p1, 0x43ff0000    # 510.0f

    sub-float/2addr p0, p1

    const p1, 0x3b008081

    mul-float/2addr p0, p1

    return p0
.end method

.method private static eqKey(Ljava/lang/String;IILjava/lang/String;)Z
    .locals 7

    .line 1070
    sub-int/2addr p2, p1

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v0

    if-ne p2, v0, :cond_0

    const/4 v5, 0x0

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v6

    const/4 v2, 0x1

    move-object v1, p0

    move v3, p1

    move-object v4, p3

    invoke-virtual/range {v1 .. v6}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static evaluateAutoHighlightGate([II)Z
    .locals 8

    .line 252
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    if-gtz p1, :cond_0

    goto :goto_1

    .line 255
    :cond_0
    array-length v1, p0

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    .line 256
    if-gtz p1, :cond_1

    .line 257
    return v0

    .line 259
    :cond_1
    nop

    .line 260
    const v1, 0x3ba3d70a    # 0.005f

    int-to-float v2, p1

    mul-float/2addr v2, v1

    float-to-double v1, v2

    invoke-static {v1, v2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v1

    double-to-int v1, v1

    const/4 v2, 0x1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 261
    move v3, v0

    move v4, v3

    :goto_0
    if-ge v3, p1, :cond_3

    .line 262
    aget v5, p0, v3

    .line 263
    ushr-int/lit8 v6, v5, 0x10

    and-int/lit16 v6, v6, 0xff

    mul-int/lit8 v6, v6, 0x4d

    ushr-int/lit8 v7, v5, 0x8

    and-int/lit16 v7, v7, 0xff

    mul-int/lit16 v7, v7, 0x96

    add-int/2addr v6, v7

    and-int/lit16 v5, v5, 0xff

    mul-int/lit8 v5, v5, 0x1d

    add-int/2addr v6, v5

    ushr-int/lit8 v5, v6, 0x8

    .line 264
    const/16 v6, 0xfa

    if-lt v5, v6, :cond_2

    add-int/lit8 v4, v4, 0x1

    if-lt v4, v1, :cond_2

    .line 265
    return v2

    .line 261
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 268
    :cond_3
    return v0

    .line 253
    :cond_4
    :goto_1
    return v0
.end method

.method public static evaluateAutoLtmGate([II)Z
    .locals 14

    .line 204
    const/4 v0, 0x0

    if-eqz p0, :cond_a

    if-gtz p1, :cond_0

    goto/16 :goto_4

    .line 207
    :cond_0
    array-length v1, p0

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    .line 208
    if-gtz p1, :cond_1

    .line 209
    return v0

    .line 211
    :cond_1
    const/16 v1, 0x100

    new-array v2, v1, [I

    .line 212
    nop

    .line 213
    nop

    .line 214
    nop

    .line 215
    move v3, v0

    move v4, v3

    move v5, v4

    move v6, v5

    :goto_0
    const/16 v7, 0xff

    const/4 v8, 0x1

    if-ge v3, p1, :cond_5

    .line 216
    aget v9, p0, v3

    .line 217
    ushr-int/lit8 v10, v9, 0x10

    and-int/2addr v10, v7

    mul-int/lit8 v10, v10, 0x4d

    ushr-int/lit8 v11, v9, 0x8

    and-int/2addr v11, v7

    mul-int/lit16 v11, v11, 0x96

    add-int/2addr v10, v11

    and-int/2addr v7, v9

    mul-int/lit8 v7, v7, 0x1d

    add-int/2addr v10, v7

    ushr-int/lit8 v7, v10, 0x8

    .line 218
    aget v9, v2, v7

    add-int/2addr v9, v8

    aput v9, v2, v7

    .line 219
    const/16 v8, 0x20

    if-ge v7, v8, :cond_2

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 220
    :cond_2
    const/16 v8, 0xec

    if-le v7, v8, :cond_3

    add-int/lit8 v5, v5, 0x1

    .line 221
    :cond_3
    :goto_1
    const/16 v8, 0x30

    if-lt v7, v8, :cond_4

    const/16 v8, 0xc8

    if-gt v7, v8, :cond_4

    add-int/lit8 v6, v6, 0x1

    .line 215
    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 223
    :cond_5
    mul-int/lit8 p0, p1, 0x5

    div-int/lit8 p0, p0, 0x64

    invoke-static {v8, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    .line 224
    mul-int/lit8 v3, p1, 0x5f

    div-int/lit8 v3, v3, 0x64

    invoke-static {p0, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 225
    nop

    .line 226
    nop

    .line 227
    nop

    .line 228
    nop

    .line 229
    move v9, v0

    move v10, v9

    move v11, v10

    move v12, v11

    :goto_2
    if-ge v9, v1, :cond_8

    .line 230
    aget v13, v2, v9

    add-int/2addr v10, v13

    .line 231
    if-nez v11, :cond_6

    if-lt v10, p0, :cond_6

    .line 232
    nop

    .line 233
    move v11, v8

    move v12, v9

    .line 235
    :cond_6
    if-lt v10, v3, :cond_7

    .line 236
    nop

    .line 237
    move v7, v9

    goto :goto_3

    .line 229
    :cond_7
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    .line 240
    :cond_8
    :goto_3
    sub-int/2addr v7, v12

    const/16 p0, 0xa5

    if-lt v7, p0, :cond_9

    int-to-float p0, v4

    int-to-float p1, p1

    const v1, 0x3dcccccd    # 0.1f

    mul-float/2addr v1, p1

    cmpl-float p0, p0, v1

    if-ltz p0, :cond_9

    int-to-float p0, v5

    const v1, 0x3ca3d70a    # 0.02f

    mul-float/2addr v1, p1

    cmpl-float p0, p0, v1

    if-ltz p0, :cond_9

    int-to-float p0, v6

    const v1, 0x3f1eb852    # 0.62f

    mul-float/2addr p1, v1

    cmpg-float p0, p0, p1

    if-gtz p0, :cond_9

    move v0, v8

    :cond_9
    return v0

    .line 205
    :cond_a
    :goto_4
    return v0
.end method

.method private static fastCbrtPos(F)F
    .locals 5

    .line 837
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 838
    :cond_0
    invoke-static {p0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    .line 839
    div-int/lit8 v0, v0, 0x3

    const v1, 0x2a5137a0

    add-int/2addr v0, v1

    .line 840
    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    .line 842
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 843
    const/high16 v2, 0x40000000    # 2.0f

    mul-float v3, p0, v2

    add-float v4, v1, v3

    mul-float/2addr v0, v4

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    .line 844
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 845
    add-float/2addr v3, v1

    mul-float/2addr v0, v3

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    return v0
.end method

.method private static fastExpNeg(F)F
    .locals 2

    .line 831
    const/high16 v0, 0x41200000    # 10.0f

    cmpl-float v0, p0, v0

    const/4 v1, 0x0

    if-ltz v0, :cond_0

    return v1

    .line 832
    :cond_0
    cmpg-float v0, p0, v1

    if-gtz v0, :cond_1

    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 833
    :cond_1
    neg-float p0, p0

    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float p0, v0

    return p0
.end method

.method public static finalizeAutoLtmBaseGrid([FII)[F
    .locals 1

    .line 318
    if-eqz p0, :cond_1

    const/4 v0, 0x2

    if-lt p1, v0, :cond_1

    if-ge p2, v0, :cond_0

    goto :goto_0

    .line 321
    :cond_0
    const v0, 0x3eb33333    # 0.35f

    invoke-static {p0, p1, p2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->bilateralSmoothLogGrid([FIIF)[F

    move-result-object p0

    return-object p0

    .line 319
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static gaussianHueWeight(FFF)F
    .locals 0

    .line 822
    sub-float/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result p0

    .line 823
    const/high16 p1, 0x43340000    # 180.0f

    cmpl-float p1, p0, p1

    if-lez p1, :cond_0

    .line 824
    const/high16 p1, 0x43b40000    # 360.0f

    sub-float p0, p1, p0

    .line 826
    :cond_0
    div-float/2addr p0, p2

    .line 827
    const/high16 p1, 0x3f000000    # 0.5f

    mul-float/2addr p1, p0

    mul-float/2addr p1, p0

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result p0

    return p0
.end method

.method private static gradePixel(IFFFZFIFZII)I
    .locals 18

    .line 596
    move/from16 v0, p1

    move/from16 v1, p5

    move/from16 v2, p6

    const/4 v3, 0x0

    cmpg-float v4, v0, v3

    if-gtz v4, :cond_0

    cmpg-float v4, p2, v3

    if-gtz v4, :cond_0

    cmpg-float v4, p3, v3

    if-gtz v4, :cond_0

    .line 597
    return p0

    .line 599
    :cond_0
    const/high16 v4, 0x3f800000    # 1.0f

    cmpl-float v5, v0, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p2, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p3, v4

    if-ltz v5, :cond_1

    .line 600
    const v0, 0xffffff

    or-int v0, p0, v0

    return v0

    .line 604
    :cond_1
    const v5, 0x3e59b3d0    # 0.2126f

    mul-float v6, v0, v5

    const v7, 0x3f371759    # 0.7152f

    mul-float v8, p2, v7

    add-float/2addr v6, v8

    const v8, 0x3d93dd98    # 0.0722f

    mul-float v9, p3, v8

    add-float/2addr v6, v9

    .line 605
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v0, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v6, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 606
    const v10, 0x3f1eb852    # 0.62f

    cmpl-float v11, v9, v10

    const v12, 0x3e0f5c29    # 0.14f

    const v13, 0x3ec28f5c    # 0.38f

    if-lez v11, :cond_4

    .line 607
    sub-float v6, v9, v10

    div-float/2addr v6, v13

    .line 608
    const v11, 0x3f91eb85    # 1.14f

    mul-float/2addr v11, v6

    const v14, 0x3e8f5c29    # 0.28f

    sub-float v15, v4, v6

    mul-float/2addr v15, v14

    add-float/2addr v15, v4

    mul-float v14, v6, v12

    mul-float/2addr v14, v6

    add-float/2addr v15, v14

    div-float/2addr v11, v15

    mul-float/2addr v11, v13

    add-float/2addr v11, v10

    .line 609
    const/4 v6, 0x1

    if-ne v2, v6, :cond_2

    cmpl-float v6, v11, v9

    if-lez v6, :cond_2

    .line 610
    move v11, v9

    .line 612
    :cond_2
    div-float/2addr v11, v9

    .line 613
    mul-float/2addr v0, v11

    .line 614
    mul-float v6, p2, v11

    .line 615
    mul-float v11, v11, p3

    .line 617
    const v14, 0x3f5c28f6    # 0.86f

    cmpl-float v15, v9, v14

    if-lez v15, :cond_3

    if-nez p4, :cond_3

    .line 618
    invoke-static {v14, v4, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v9

    const v14, 0x3e75c28f    # 0.24f

    mul-float/2addr v9, v14

    .line 619
    mul-float v14, v0, v5

    mul-float v15, v6, v7

    add-float/2addr v14, v15

    mul-float v15, v11, v8

    add-float/2addr v14, v15

    .line 620
    sub-float v15, v14, v0

    mul-float/2addr v15, v9

    add-float/2addr v0, v15

    .line 621
    sub-float v15, v14, v6

    mul-float/2addr v15, v9

    add-float/2addr v6, v15

    .line 622
    sub-float/2addr v14, v11

    mul-float/2addr v14, v9

    add-float/2addr v11, v14

    .line 624
    :cond_3
    mul-float/2addr v5, v0

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    mul-float/2addr v8, v11

    add-float/2addr v5, v8

    goto :goto_0

    .line 606
    :cond_4
    move/from16 v11, p3

    move v5, v6

    move/from16 v6, p2

    .line 628
    :goto_0
    const/high16 v7, -0x3ef00000    # -9.0f

    cmpl-float v7, v1, v7

    const v8, 0x3b03126f    # 0.002f

    if-lez v7, :cond_5

    if-nez p4, :cond_5

    .line 629
    float-to-double v14, v1

    invoke-static {v14, v15}, Ljava/lang/Math;->exp(D)D

    move-result-wide v14

    double-to-float v1, v14

    sub-float/2addr v1, v8

    const v7, 0x3a03126f    # 5.0E-4f

    invoke-static {v7, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 630
    invoke-static {v1, v5, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->localBaseGain(FFI)F

    move-result v1

    .line 631
    mul-float/2addr v0, v1

    invoke-static {v3, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 632
    mul-float/2addr v6, v1

    invoke-static {v3, v6}, Ljava/lang/Math;->max(FF)F

    move-result v6

    .line 633
    mul-float/2addr v11, v1

    invoke-static {v3, v11}, Ljava/lang/Math;->max(FF)F

    move-result v11

    .line 637
    :cond_5
    const v1, 0x3ed30eb1

    mul-float/2addr v1, v0

    const v5, 0x3f094d17

    mul-float/2addr v5, v6

    add-float/2addr v1, v5

    const v5, 0x3d52b909

    mul-float/2addr v5, v11

    add-float/2addr v1, v5

    .line 638
    const v5, 0x3e58fd3b

    mul-float/2addr v5, v0

    const v7, 0x3f2e4253

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    const v7, 0x3ddbf2f0

    mul-float/2addr v7, v11

    add-float/2addr v5, v7

    .line 639
    const v7, 0x3db4d7ec

    mul-float/2addr v0, v7

    const v7, 0x3e903d74

    mul-float/2addr v6, v7

    add-float/2addr v0, v6

    const v6, 0x3f214649

    mul-float/2addr v11, v6

    add-float/2addr v0, v11

    .line 641
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v1

    .line 642
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v5

    .line 643
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v0

    .line 645
    const v6, 0x3e578152

    mul-float/2addr v6, v1

    const v7, 0x3f4b2a89

    mul-float/2addr v7, v5

    add-float/2addr v6, v7

    const v7, 0x3b856ece

    mul-float/2addr v7, v0

    sub-float/2addr v6, v7

    .line 646
    const v7, 0x3ffd2f0e

    mul-float/2addr v7, v1

    const v9, 0x401b6e0e

    mul-float/2addr v9, v5

    sub-float/2addr v7, v9

    const v9, 0x3ee6b438

    mul-float/2addr v9, v0

    add-float/2addr v7, v9

    .line 647
    const v9, 0x3cd434b4

    mul-float/2addr v1, v9

    const v9, 0x3f4863bb

    mul-float/2addr v5, v9

    add-float/2addr v1, v5

    const v5, 0x3f4f0560

    mul-float/2addr v0, v5

    sub-float/2addr v1, v0

    .line 650
    invoke-static {v6, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyLightnessCurve(FI)F

    move-result v0

    .line 652
    const v5, 0x3f6b851f    # 0.92f

    const/4 v9, 0x3

    if-eqz p8, :cond_7

    .line 654
    cmpl-float v11, p7, v3

    if-lez v11, :cond_6

    .line 655
    const v11, 0x3f147ae1    # 0.58f

    invoke-static {v11, v5, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v11

    sub-float v11, v4, v11

    .line 656
    mul-float v11, v11, p7

    sub-float v11, v4, v11

    mul-float/2addr v0, v11

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 659
    :cond_6
    if-ne v2, v9, :cond_7

    .line 660
    const v11, 0x3d75c28f    # 0.06f

    const v14, 0x3e4ccccd    # 0.2f

    invoke-static {v11, v14, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v11

    const/high16 v14, 0x3f400000    # 0.75f

    const v15, 0x3f75c28f    # 0.96f

    invoke-static {v14, v15, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v14

    sub-float v14, v4, v14

    mul-float/2addr v11, v14

    .line 661
    cmpl-float v14, v11, v3

    if-lez v14, :cond_7

    .line 662
    invoke-static/range {p9 .. p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->deterministicGrain6(II)F

    move-result v14

    const v15, 0x3b51b717    # 0.0032f

    mul-float/2addr v14, v15

    mul-float/2addr v14, v11

    add-float/2addr v0, v14

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 667
    :cond_7
    if-eqz p4, :cond_8

    .line 668
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 669
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    .line 670
    shl-int/lit8 v1, v0, 0x10

    or-int v1, p0, v1

    shl-int/lit8 v2, v0, 0x8

    or-int/2addr v1, v2

    or-int/2addr v0, v1

    return v0

    .line 673
    :cond_8
    mul-float v11, v7, v7

    mul-float v14, v1, v1

    add-float/2addr v11, v14

    float-to-double v14, v11

    invoke-static {v14, v15}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v14

    double-to-float v11, v14

    .line 674
    nop

    .line 675
    nop

    .line 677
    const v14, 0x38d1b717    # 1.0E-4f

    cmpl-float v14, v11, v14

    const v15, 0x3d4ccccd    # 0.05f

    if-lez v14, :cond_f

    .line 678
    move v14, v3

    move/from16 v16, v4

    float-to-double v3, v1

    move/from16 p1, v8

    float-to-double v8, v7

    invoke-static {v3, v4, v8, v9}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v3

    double-to-float v3, v3

    .line 679
    cmpg-float v4, v3, v14

    if-gez v4, :cond_9

    .line 680
    const/high16 v4, 0x43b40000    # 360.0f

    add-float/2addr v3, v4

    .line 683
    :cond_9
    const v4, 0x3c449ba6    # 0.012f

    invoke-static {v4, v15, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    .line 686
    const/high16 v8, 0x43080000    # 136.0f

    const/high16 v9, 0x41b00000    # 22.0f

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v8

    mul-float/2addr v8, v4

    .line 687
    const v9, 0x3c23d70a    # 0.01f

    cmpl-float v17, v8, v9

    if-lez v17, :cond_a

    .line 688
    mul-float/2addr v12, v8

    sub-float v12, v16, v12

    .line 689
    const v17, 0x3d8efa35

    mul-float v8, v8, v17

    .line 690
    neg-float v8, v8

    move/from16 p4, v14

    move/from16 p3, v15

    float-to-double v14, v8

    move/from16 p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->cos(D)D

    move-result-wide v5

    double-to-float v5, v5

    .line 691
    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v6, v14

    .line 692
    mul-float v14, v7, v5

    mul-float v15, v1, v6

    sub-float/2addr v14, v15

    mul-float/2addr v14, v12

    .line 693
    mul-float/2addr v7, v6

    mul-float/2addr v1, v5

    add-float/2addr v7, v1

    mul-float v1, v7, v12

    .line 694
    nop

    .line 695
    move v7, v14

    goto :goto_1

    .line 687
    :cond_a
    move/from16 p5, v6

    move/from16 p4, v14

    move/from16 p3, v15

    .line 699
    :goto_1
    const/high16 v5, 0x435c0000    # 220.0f

    const/high16 v6, 0x41d00000    # 26.0f

    invoke-static {v3, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v5

    move/from16 v6, p5

    invoke-static {v13, v10, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v10

    mul-float/2addr v5, v10

    mul-float/2addr v5, v4

    .line 700
    cmpl-float v9, v5, v9

    const/4 v10, 0x2

    if-lez v9, :cond_c

    .line 701
    const v9, 0x3e17e9d8

    mul-float/2addr v9, v5

    .line 702
    float-to-double v12, v9

    invoke-static {v12, v13}, Ljava/lang/Math;->cos(D)D

    move-result-wide v14

    double-to-float v9, v14

    .line 703
    invoke-static {v12, v13}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    double-to-float v12, v12

    .line 704
    if-ne v2, v10, :cond_b

    const v13, 0x3db851ec    # 0.09f

    goto :goto_2

    :cond_b
    move/from16 v13, p3

    :goto_2
    mul-float/2addr v13, v5

    add-float v13, v13, v16

    .line 705
    mul-float v5, v7, v9

    mul-float v14, v1, v12

    sub-float/2addr v5, v14

    mul-float/2addr v5, v13

    .line 706
    mul-float/2addr v7, v12

    mul-float/2addr v1, v9

    add-float/2addr v7, v1

    mul-float v1, v7, v13

    .line 707
    nop

    .line 708
    move v7, v5

    .line 712
    :cond_c
    const/high16 v5, 0x42280000    # 42.0f

    const/high16 v9, 0x41c00000    # 24.0f

    invoke-static {v3, v5, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v3

    .line 713
    const v5, 0x3e3851ec    # 0.18f

    const v9, 0x3e99999a    # 0.3f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    mul-float/2addr v3, v5

    .line 714
    const v5, 0x3f570a3d    # 0.84f

    const v9, 0x3f70a3d7    # 0.94f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 715
    const v5, 0x3de147ae    # 0.11f

    const v9, 0x3e6147ae    # 0.22f

    invoke-static {v5, v9, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 717
    const v5, 0x3b83126f    # 0.004f

    if-ne v2, v10, :cond_d

    .line 719
    sub-float v2, v6, v0

    const v4, 0x3ef5c28f    # 0.48f

    mul-float/2addr v4, v3

    mul-float/2addr v2, v4

    add-float/2addr v0, v2

    .line 720
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 721
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 722
    :cond_d
    const/4 v9, 0x3

    if-ne v2, v9, :cond_e

    .line 724
    const v2, 0x3f0ccccd    # 0.55f

    const v5, 0x3f59999a    # 0.85f

    invoke-static {v2, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    move/from16 v5, v16

    const v8, 0x3f6b851f    # 0.92f

    invoke-static {v8, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v8

    sub-float v8, v5, v8

    mul-float/2addr v2, v8

    mul-float/2addr v2, v4

    .line 725
    const v4, 0x3c75c28f    # 0.015f

    const v5, 0x3d23d70a    # 0.04f

    invoke-static {v4, v5, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    mul-float/2addr v4, v3

    .line 726
    const v5, 0x3c0b4396    # 0.0085f

    mul-float/2addr v5, v4

    const v8, 0x3b23d70a    # 0.0025f

    mul-float/2addr v8, v2

    add-float/2addr v5, v8

    add-float/2addr v7, v5

    .line 727
    const v5, 0x3c978d50    # 0.0185f

    mul-float/2addr v4, v5

    const v5, 0x3c03126f    # 0.008f

    mul-float/2addr v2, v5

    add-float/2addr v4, v2

    add-float/2addr v1, v4

    .line 728
    mul-float/2addr v3, v5

    add-float/2addr v0, v3

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 729
    goto :goto_3

    .line 731
    :cond_e
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 732
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 677
    :cond_f
    move/from16 p4, v3

    move/from16 p3, v15

    .line 737
    :goto_3
    cmpl-float v2, v0, v6

    if-lez v2, :cond_10

    cmpl-float v2, v6, p3

    if-lez v2, :cond_10

    const v2, 0x3f3851ec    # 0.72f

    cmpl-float v3, v0, v2

    if-lez v3, :cond_10

    .line 738
    const v3, 0x3f7ae148    # 0.98f

    invoke-static {v2, v3, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    const v3, 0x3e19999a    # 0.15f

    mul-float/2addr v2, v3

    const/high16 v16, 0x3f800000    # 1.0f

    sub-float v4, v16, v2

    .line 739
    mul-float/2addr v7, v4

    .line 740
    mul-float/2addr v1, v4

    .line 744
    :cond_10
    const v2, 0x3ecaecc9

    mul-float/2addr v2, v7

    add-float/2addr v2, v0

    const v3, 0x3e5cfba9

    mul-float/2addr v3, v1

    add-float/2addr v2, v3

    .line 745
    const v3, 0x3dd8308c

    mul-float/2addr v3, v7

    sub-float v3, v0, v3

    const v4, 0x3d82c5fa

    mul-float/2addr v4, v1

    sub-float/2addr v3, v4

    .line 746
    const v4, 0x3db7437b

    mul-float/2addr v7, v4

    sub-float v4, v0, v7

    const v5, 0x3fa54f66

    mul-float/2addr v1, v5

    sub-float/2addr v4, v1

    .line 748
    mul-float v1, v2, v2

    mul-float/2addr v1, v2

    .line 749
    mul-float v2, v3, v3

    mul-float/2addr v2, v3

    .line 750
    mul-float v3, v4, v4

    mul-float/2addr v3, v4

    .line 752
    const v4, 0x408274ab

    mul-float/2addr v4, v1

    const v5, 0x4053b18c

    mul-float/2addr v5, v2

    sub-float/2addr v4, v5

    const v5, 0x3e6c8362

    mul-float/2addr v5, v3

    add-float/2addr v4, v5

    .line 753
    const v5, -0x405da3d3

    mul-float/2addr v5, v1

    const v6, 0x40270644

    mul-float/2addr v6, v2

    add-float/2addr v5, v6

    const v6, 0x3eaec16a

    mul-float/2addr v6, v3

    sub-float/2addr v5, v6

    .line 754
    const v6, -0x447680ad

    mul-float/2addr v1, v6

    const v6, 0x3f34133e

    mul-float/2addr v2, v6

    sub-float/2addr v1, v2

    const v2, 0x3fda931e

    mul-float/2addr v3, v2

    add-float/2addr v1, v3

    .line 757
    invoke-static {v5, v1}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-static {v4, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    .line 758
    invoke-static {v5, v1}, Ljava/lang/Math;->min(FF)F

    move-result v3

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    .line 759
    cmpg-float v6, v3, p4

    if-ltz v6, :cond_11

    const/high16 v16, 0x3f800000    # 1.0f

    cmpl-float v7, v2, v16

    if-lez v7, :cond_14

    .line 760
    :cond_11
    mul-float v7, v0, v0

    mul-float/2addr v7, v0

    .line 761
    nop

    .line 762
    if-gez v6, :cond_12

    cmpl-float v0, v7, v3

    if-lez v0, :cond_12

    .line 763
    sub-float v0, v7, v3

    div-float v0, v7, v0

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    goto :goto_4

    .line 762
    :cond_12
    const/high16 v3, 0x3f800000    # 1.0f

    .line 765
    move v0, v3

    :goto_4
    cmpl-float v6, v2, v3

    if-lez v6, :cond_13

    cmpl-float v6, v2, v7

    if-lez v6, :cond_13

    .line 766
    sub-float/2addr v3, v7

    sub-float/2addr v2, v7

    div-float/2addr v3, v2

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 768
    :cond_13
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 769
    sub-float/2addr v4, v7

    mul-float/2addr v4, v0

    add-float/2addr v4, v7

    .line 770
    sub-float/2addr v5, v7

    mul-float/2addr v5, v0

    add-float/2addr v5, v7

    .line 771
    sub-float/2addr v1, v7

    mul-float/2addr v1, v0

    add-float/2addr v1, v7

    .line 774
    :cond_14
    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    shl-int/lit8 v0, v0, 0x10

    or-int v0, p0, v0

    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v2

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v0, v2

    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v1

    or-int/2addr v0, v1

    return v0
.end method

.method private static isSpace(C)Z
    .locals 1

    .line 1074
    const/16 v0, 0x20

    if-eq p0, v0, :cond_1

    const/16 v0, 0x9

    if-ne p0, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method private static localBaseGain(FFI)F
    .locals 5

    .line 779
    const v0, 0x38d1b717    # 1.0E-4f

    cmpg-float p1, p1, v0

    const/high16 v1, 0x3f800000    # 1.0f

    if-gtz p1, :cond_0

    .line 780
    return v1

    .line 782
    :cond_0
    const p1, 0x3ca3d70a    # 0.02f

    const v2, 0x3e0f5c29    # 0.14f

    invoke-static {p1, v2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p1

    const v2, 0x3f0ccccd    # 0.55f

    const v3, 0x3f6147ae    # 0.88f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    sub-float v2, v1, v2

    mul-float/2addr p1, v2

    .line 783
    nop

    .line 784
    const/4 v2, 0x2

    const v3, 0x3da3d70a    # 0.08f

    const v4, 0x3d4ccccd    # 0.05f

    if-ne p2, v2, :cond_1

    .line 786
    const p2, 0x3ed70a3d    # 0.42f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3c23d70a    # 0.01f

    invoke-static {v2, v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 787
    const v2, 0x3df5c28f    # 0.12f

    mul-float/2addr p2, v2

    sub-float p2, v1, p2

    mul-float/2addr p2, p0

    .line 788
    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    if-ne p2, v2, :cond_2

    .line 789
    const/high16 p2, 0x3e800000    # 0.25f

    invoke-static {v4, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3ba3d70a    # 0.005f

    const v3, 0x3cf5c28f    # 0.03f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 790
    mul-float/2addr p2, v4

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    .line 791
    goto :goto_0

    :cond_2
    const/4 v2, 0x3

    if-ne p2, v2, :cond_3

    .line 792
    const p2, 0x3eb33333    # 0.35f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    const v2, 0x3ee66666    # 0.45f

    const v3, 0x3f47ae14    # 0.78f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    sub-float v2, v1, v2

    mul-float/2addr p2, v2

    .line 793
    const v2, 0x3d23d70a    # 0.04f

    mul-float/2addr p2, v2

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    goto :goto_0

    .line 791
    :cond_3
    move p2, p0

    .line 795
    :goto_0
    invoke-static {v0, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    div-float/2addr p2, p0

    sub-float/2addr p2, v1

    const p0, 0x3f19999a    # 0.6f

    mul-float/2addr p1, p0

    const p0, 0x3ecccccd    # 0.4f

    add-float/2addr p1, p0

    mul-float/2addr p2, p1

    add-float/2addr p2, v1

    .line 796
    const p0, 0x3f51eb85    # 0.82f

    const p1, 0x3f947ae1    # 1.16f

    invoke-static {p2, p0, p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p0

    return p0
.end method

.method public static parseCubeLut(Ljava/lang/String;[I)[F
    .locals 19

    .line 886
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-eqz v0, :cond_1d

    .line 889
    nop

    .line 890
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const v5, 0xfeff

    if-ne v2, v5, :cond_0

    .line 891
    const/4 v2, 0x1

    goto :goto_0

    .line 893
    :cond_0
    move v2, v3

    :goto_0
    nop

    .line 894
    nop

    .line 895
    nop

    .line 896
    nop

    .line 897
    nop

    .line 898
    nop

    .line 899
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, -0x1

    const/4 v7, 0x0

    move v10, v3

    move-object v8, v7

    move-object v9, v8

    .line 900
    :goto_1
    const/4 v11, 0x2

    if-gt v2, v5, :cond_18

    .line 901
    move v13, v2

    .line 902
    :goto_2
    const/16 v14, 0xd

    const/16 v15, 0xa

    if-ge v13, v5, :cond_2

    .line 903
    const/16 v16, 0x1

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 904
    if-eq v4, v15, :cond_3

    if-ne v4, v14, :cond_1

    .line 905
    goto :goto_3

    .line 907
    :cond_1
    add-int/lit8 v13, v13, 0x1

    .line 908
    goto :goto_2

    .line 902
    :cond_2
    const/16 v16, 0x1

    .line 909
    :cond_3
    :goto_3
    nop

    .line 910
    :goto_4
    if-ge v2, v13, :cond_4

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 911
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 913
    :cond_4
    move v4, v13

    .line 914
    :goto_5
    if-le v4, v2, :cond_5

    add-int/lit8 v15, v4, -0x1

    invoke-virtual {v0, v15}, Ljava/lang/String;->charAt(I)C

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v15

    if-eqz v15, :cond_5

    .line 915
    add-int/lit8 v4, v4, -0x1

    const/16 v15, 0xa

    goto :goto_5

    .line 917
    :cond_5
    if-ge v2, v4, :cond_15

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v15

    const/16 v14, 0x23

    if-eq v15, v14, :cond_15

    .line 918
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->countWords(Ljava/lang/String;II)I

    move-result v14

    .line 919
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v15

    .line 920
    const-string v3, "TITLE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_14

    .line 921
    const-string v3, "LUT_IN_VIDEO_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    move/from16 v12, v16

    goto/16 :goto_8

    .line 923
    :cond_6
    const-string v3, "DOMAIN_MIN"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_11

    .line 924
    const-string v12, "DOMAIN_MAX"

    invoke-static {v0, v2, v15, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_7

    goto/16 :goto_6

    .line 934
    :cond_7
    const-string v3, "LUT_1D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 935
    const-string v3, "LUT_1D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 937
    const-string v3, "LUT_3D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 938
    if-ne v14, v11, :cond_9

    if-nez v9, :cond_9

    .line 941
    invoke-static {v0, v15, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->word(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseSize(Ljava/lang/String;)I

    move-result v2

    .line 942
    int-to-long v3, v2

    mul-long v14, v3, v3

    mul-long/2addr v14, v3

    const-wide/16 v3, 0x3

    mul-long/2addr v14, v3

    .line 943
    const-wide/32 v3, 0x7fffffff

    cmp-long v3, v14, v3

    if-gtz v3, :cond_8

    .line 946
    long-to-int v3, v14

    new-array v3, v3, [F

    .line 947
    move v6, v2

    move-object v9, v3

    move/from16 v12, v16

    goto/16 :goto_8

    .line 944
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 939
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE must appear once before samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 947
    :cond_a
    const-string v3, "LUT_3D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 948
    const/4 v3, 0x3

    if-ne v14, v3, :cond_b

    move/from16 v12, v16

    goto/16 :goto_8

    .line 949
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_INPUT_RANGE needs two finite bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 952
    :cond_c
    const/4 v3, 0x3

    if-eqz v9, :cond_f

    .line 955
    if-ne v14, v3, :cond_e

    .line 958
    add-int/lit8 v3, v10, 0x3

    array-length v12, v9

    if-gt v3, v12, :cond_d

    .line 961
    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v2

    .line 962
    add-int/lit8 v4, v10, 0x1

    aget v12, v2, v3

    aput v12, v9, v10

    .line 963
    add-int/lit8 v3, v4, 0x1

    aget v10, v2, v16

    aput v10, v9, v4

    .line 964
    add-int/lit8 v4, v3, 0x1

    aget v2, v2, v11

    aput v2, v9, v3

    move v10, v4

    move/from16 v12, v16

    goto :goto_8

    .line 959
    :cond_d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "too many RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 956
    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "RGB sample must contain 3 values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 953
    :cond_f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "sample appears before LUT_3D_SIZE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 936
    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1D cube is not a 3D LUT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 925
    :cond_11
    :goto_6
    const/4 v12, 0x4

    if-ne v14, v12, :cond_13

    .line 928
    move/from16 v12, v16

    invoke-static {v0, v2, v4, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v4

    .line 929
    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 930
    move-object v7, v4

    goto :goto_7

    .line 932
    :cond_12
    move-object v8, v4

    .line 934
    :goto_7
    goto :goto_8

    .line 926
    :cond_13
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN line needs 3 finite components"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 920
    :cond_14
    move/from16 v12, v16

    goto :goto_8

    .line 917
    :cond_15
    move/from16 v12, v16

    .line 967
    :goto_8
    if-lt v13, v5, :cond_16

    .line 968
    goto :goto_9

    .line 970
    :cond_16
    add-int/lit8 v2, v13, 0x1

    .line 971
    if-ge v13, v5, :cond_17

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xd

    if-ne v3, v4, :cond_17

    if-ge v2, v5, :cond_17

    .line 972
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_17

    .line 973
    add-int/lit8 v2, v2, 0x1

    .line 975
    :cond_17
    const/4 v3, 0x0

    goto/16 :goto_1

    .line 976
    :cond_18
    :goto_9
    if-lt v6, v11, :cond_1c

    if-eqz v9, :cond_1c

    array-length v0, v9

    if-ne v10, v0, :cond_1c

    .line 979
    if-eqz v7, :cond_1a

    if-eqz v8, :cond_1a

    .line 980
    const/4 v3, 0x0

    :goto_a
    const/4 v0, 0x3

    if-ge v3, v0, :cond_1a

    .line 981
    aget v2, v7, v3

    aget v4, v8, v3

    cmpg-float v2, v2, v4

    if-gez v2, :cond_19

    .line 980
    add-int/lit8 v3, v3, 0x1

    goto :goto_a

    .line 982
    :cond_19
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN_MIN must be below DOMAIN_MAX"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 986
    :cond_1a
    if-eqz v1, :cond_1b

    array-length v0, v1

    if-lez v0, :cond_1b

    .line 987
    const/16 v17, 0x0

    aput v6, v1, v17

    .line 989
    :cond_1b
    return-object v9

    .line 977
    :cond_1c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube is missing LUT_3D_SIZE or the N^3 RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 887
    :cond_1d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube text is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static parseFinite(Ljava/lang/String;)F
    .locals 1

    .line 1028
    :try_start_0
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1031
    nop

    .line 1032
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1035
    return p0

    .line 1033
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not finite"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1029
    :catch_0
    move-exception p0

    .line 1030
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not a number"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static parseSize(Ljava/lang/String;)I
    .locals 4

    .line 993
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const-string v1, "LUT_3D_SIZE must be an integer from 2 to 64"

    if-nez v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2b

    if-eq v2, v3, :cond_1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x2d

    if-eq v0, v2, :cond_1

    .line 998
    :try_start_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1001
    nop

    .line 1002
    const/4 v0, 0x2

    if-lt p0, v0, :cond_0

    const/16 v0, 0x40

    if-gt p0, v0, :cond_0

    .line 1005
    return p0

    .line 1003
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 999
    :catch_0
    move-exception p0

    .line 1000
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 994
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static readTriple(Ljava/lang/String;IIZ)[F
    .locals 3

    .line 1009
    nop

    .line 1010
    if-eqz p3, :cond_0

    .line 1011
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    .line 1013
    :cond_0
    const/4 p3, 0x3

    new-array v0, p3, [F

    .line 1014
    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_2

    .line 1015
    :goto_1
    if-ge p1, p2, :cond_1

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1016
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 1018
    :cond_1
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v2

    .line 1019
    invoke-virtual {p0, p1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseFinite(Ljava/lang/String;)F

    move-result p1

    aput p1, v0, v1

    .line 1020
    nop

    .line 1014
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 1022
    :cond_2
    return-object v0
.end method

.method private static sampleBilinearY([FIIFF)F
    .locals 4

    .line 572
    int-to-float v0, p1

    const v1, 0x3f800347    # 1.0001f

    sub-float/2addr v0, v1

    const/4 v2, 0x0

    invoke-static {p3, v2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p3

    .line 573
    int-to-float v0, p2

    sub-float/2addr v0, v1

    invoke-static {p4, v2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p4

    .line 574
    float-to-int v0, p3

    .line 575
    float-to-int v1, p4

    .line 576
    add-int/lit8 v2, v0, 0x1

    add-int/lit8 v3, p1, -0x1

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 577
    add-int/lit8 v3, v1, 0x1

    add-int/lit8 p2, p2, -0x1

    invoke-static {v3, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    .line 578
    int-to-float v3, v0

    sub-float/2addr p3, v3

    .line 579
    int-to-float v3, v1

    sub-float/2addr p4, v3

    .line 580
    mul-int/2addr v1, p1

    add-int v3, v1, v0

    aget v3, p0, v3

    .line 581
    add-int/2addr v1, v2

    aget v1, p0, v1

    .line 582
    mul-int/2addr p2, p1

    add-int/2addr v0, p2

    aget p1, p0, v0

    .line 583
    add-int/2addr p2, v2

    aget p0, p0, p2

    .line 584
    sub-float/2addr v1, v3

    mul-float/2addr v1, p3

    add-float/2addr v3, v1

    .line 585
    sub-float/2addr p0, p1

    mul-float/2addr p0, p3

    add-float/2addr p1, p0

    .line 586
    sub-float/2addr p1, v3

    mul-float/2addr p1, p4

    add-float/2addr v3, p1

    return v3
.end method

.method private static smoothstep(FFF)F
    .locals 0

    .line 849
    sub-float/2addr p2, p0

    sub-float/2addr p1, p0

    div-float/2addr p2, p1

    invoke-static {p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    .line 850
    mul-float p1, p0, p0

    const/high16 p2, 0x40000000    # 2.0f

    mul-float/2addr p0, p2

    const/high16 p2, 0x40400000    # 3.0f

    sub-float/2addr p2, p0

    mul-float/2addr p1, p2

    return p1
.end method

.method private static toSrgbByte(F)I
    .locals 2

    .line 866
    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gtz v0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 867
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_1

    const/16 p0, 0xff

    return p0

    .line 868
    :cond_1
    const/high16 v0, 0x45800000    # 4096.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p0, v0

    float-to-int p0, p0

    .line 869
    sget-object v0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->LIN_TO_SRGB_BYTE:[I

    const/16 v1, 0x1000

    if-lt p0, v1, :cond_2

    move p0, v1

    :cond_2
    aget p0, v0, p0

    return p0
.end method

.method private static word(Ljava/lang/String;II)Ljava/lang/String;
    .locals 1

    .line 1039
    nop

    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1040
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 1042
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static wordEnd(Ljava/lang/String;II)I
    .locals 1

    .line 1062
    nop

    .line 1063
    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1064
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 1066
    :cond_0
    return p1
.end method
