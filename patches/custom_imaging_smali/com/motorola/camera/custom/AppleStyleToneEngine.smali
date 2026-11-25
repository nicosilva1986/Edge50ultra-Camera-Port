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

    .line 342
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

    .line 345
    :cond_0
    div-int/lit8 v4, v1, 0x8

    .line 346
    add-int v5, v1, p2

    add-int/lit8 v6, v5, 0x8

    add-int/lit8 v6, v6, -0x1

    div-int/lit8 v6, v6, 0x8

    move/from16 v7, p8

    invoke-static {v7, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    .line 347
    nop

    :goto_0
    if-ge v4, v6, :cond_5

    .line 348
    mul-int/lit8 v7, v4, 0x8

    invoke-static {v1, v7}, Ljava/lang/Math;->max(II)I

    move-result v7

    .line 349
    invoke-static {v2, v5}, Ljava/lang/Math;->min(II)I

    move-result v8

    add-int/lit8 v9, v4, 0x1

    mul-int/lit8 v10, v9, 0x8

    invoke-static {v8, v10}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 350
    const/4 v11, 0x0

    :goto_1
    if-ge v11, v3, :cond_4

    .line 351
    mul-int/lit8 v12, v11, 0x8

    .line 352
    add-int/lit8 v13, v12, 0x8

    invoke-static {v0, v13}, Ljava/lang/Math;->min(II)I

    move-result v13

    .line 353
    nop

    .line 354
    nop

    .line 355
    nop

    .line 356
    const-wide/16 v14, 0x0

    move v10, v7

    move-wide/from16 v16, v14

    const/4 v0, 0x0

    :goto_2
    if-ge v10, v8, :cond_2

    .line 357
    sub-int v18, v10, v1

    mul-int v18, v18, p1

    .line 358
    move/from16 p8, v0

    move v0, v12

    :goto_3
    if-ge v0, v13, :cond_1

    .line 359
    add-int v19, v18, v0

    move/from16 v20, v0

    aget v0, p0, v19

    .line 360
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

    .line 363
    float-to-double v0, v1

    add-double/2addr v14, v0

    .line 364
    mul-double/2addr v0, v0

    add-double v16, v16, v0

    .line 365
    add-int/lit8 v0, p8, 0x1

    .line 358
    add-int/lit8 v1, v20, 0x2

    move/from16 p8, v0

    move v0, v1

    move/from16 v1, p3

    goto :goto_3

    .line 356
    :cond_1
    add-int/lit8 v10, v10, 0x2

    move/from16 v1, p3

    move/from16 v0, p8

    goto :goto_2

    .line 368
    :cond_2
    if-lez v0, :cond_3

    .line 369
    int-to-double v0, v0

    div-double/2addr v14, v0

    double-to-float v10, v14

    .line 370
    div-double v0, v16, v0

    double-to-float v0, v0

    mul-float v1, v10, v10

    sub-float/2addr v0, v1

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 371
    mul-int v1, v4, v3

    add-int/2addr v1, v11

    .line 372
    const v12, 0x3b03126f    # 0.002f

    add-float/2addr v10, v12

    float-to-double v12, v10

    invoke-static {v12, v13}, Ljava/lang/Math;->log(D)D

    move-result-wide v12

    double-to-float v10, v12

    aput v10, p5, v1

    .line 373
    float-to-double v12, v0

    invoke-static {v12, v13}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v12

    double-to-float v0, v12

    aput v0, p6, v1

    .line 350
    :cond_3
    add-int/lit8 v11, v11, 0x1

    move/from16 v0, p1

    move/from16 v1, p3

    goto/16 :goto_1

    .line 347
    :cond_4
    move/from16 v0, p1

    move/from16 v1, p3

    move v4, v9

    goto/16 :goto_0

    .line 377
    :cond_5
    return-void

    .line 343
    :cond_6
    :goto_4
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZ)V
    .locals 13

    .line 409
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

    .line 412
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZF)V
    .locals 14

    .line 423
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

    .line 426
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZF)V
    .locals 16

    .line 439
    const/4 v14, 0x0

    const/16 v15, 0x64

    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    move/from16 v12, p12

    move/from16 v13, p13

    invoke-static/range {v0 .. v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZFZI)V

    .line 444
    return-void
.end method

.method public static applyAutoLocalToneAndZoomAcutance([IIIIII[F[FIIZZZFZI)V
    .locals 34

    .line 457
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v7, p15

    if-eqz v0, :cond_36

    if-lez v1, :cond_36

    if-lez v2, :cond_36

    if-nez p10, :cond_0

    if-nez p11, :cond_0

    if-nez p12, :cond_0

    if-nez p14, :cond_0

    goto/16 :goto_1f

    .line 461
    :cond_0
    int-to-long v8, v1

    int-to-long v10, v2

    mul-long/2addr v8, v10

    .line 462
    array-length v2, v0

    int-to-long v10, v2

    invoke-static {v10, v11, v8, v9}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v8

    long-to-int v2, v8

    .line 463
    div-int v8, v2, v1

    .line 464
    if-gtz v8, :cond_1

    .line 465
    return-void

    .line 468
    :cond_1
    const/4 v9, 0x2

    if-eqz p10, :cond_2

    if-eqz v3, :cond_2

    if-eqz v4, :cond_2

    if-lt v5, v9, :cond_2

    if-lt v6, v9, :cond_2

    array-length v12, v3

    mul-int v13, v5, v6

    if-lt v12, v13, :cond_2

    array-length v12, v4

    if-lt v12, v13, :cond_2

    const/4 v12, 0x1

    goto :goto_0

    :cond_2
    const/4 v12, 0x0

    .line 471
    :goto_0
    if-eqz p14, :cond_3

    if-nez v12, :cond_3

    const/16 v13, 0x320

    if-ge v7, v13, :cond_3

    const/4 v13, 0x1

    goto :goto_1

    :cond_3
    const/4 v13, 0x0

    .line 472
    :goto_1
    const/16 v14, 0xc8

    if-le v7, v14, :cond_4

    const v14, 0x3f0ccccd    # 0.55f

    goto :goto_2

    :cond_4
    const v14, 0x3feccccd    # 1.85f

    .line 474
    :goto_2
    const v16, 0x3d93dd98    # 0.0722f

    const v17, 0x3f371759    # 0.7152f

    const v18, 0x3e59b3d0    # 0.2126f

    const/high16 v19, 0x41000000    # 8.0f

    const/high16 v20, 0x3e800000    # 0.25f

    const/high16 v21, 0x3f000000    # 0.5f

    const/4 v10, 0x0

    if-nez v12, :cond_5

    if-nez v13, :cond_5

    if-eqz p11, :cond_18

    .line 475
    :cond_5
    nop

    .line 476
    const/4 v15, 0x0

    :goto_3
    if-ge v15, v8, :cond_18

    .line 477
    add-int v11, p3, v15

    .line 478
    if-eqz v12, :cond_6

    int-to-float v11, v11

    add-float v11, v11, v21

    div-float v11, v11, v19

    sub-float v11, v11, v21

    const/high16 p10, 0x3f800000    # 1.0f

    int-to-float v9, v6

    const v23, 0x3f800347    # 1.0001f

    sub-float v9, v9, v23

    invoke-static {v11, v10, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v9

    goto :goto_4

    :cond_6
    const/high16 p10, 0x3f800000    # 1.0f

    move v9, v10

    .line 479
    :goto_4
    float-to-int v11, v9

    .line 480
    if-eqz v12, :cond_7

    add-int/lit8 v10, v11, 0x1

    add-int/lit8 v0, v6, -0x1

    invoke-static {v10, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    goto :goto_5

    :cond_7
    const/4 v0, 0x0

    .line 481
    :goto_5
    int-to-float v10, v11

    sub-float/2addr v9, v10

    .line 482
    mul-int v10, v15, v1

    .line 484
    move/from16 v23, v0

    const/4 v0, 0x0

    :goto_6
    if-ge v0, v1, :cond_17

    .line 485
    add-int v24, v10, v0

    .line 486
    aget v3, p0, v24

    .line 487
    const/high16 v25, -0x1000000

    and-int v25, v3, v25

    .line 488
    ushr-int/lit8 v4, v3, 0x10

    and-int/lit16 v4, v4, 0xff

    .line 489
    ushr-int/lit8 v6, v3, 0x8

    and-int/lit16 v6, v6, 0xff

    .line 490
    and-int/lit16 v3, v3, 0xff

    .line 491
    or-int v26, v4, v6

    or-int v26, v26, v3

    if-nez v26, :cond_8

    .line 492
    move/from16 v27, v0

    move/from16 v26, v9

    move/from16 v31, v10

    move/from16 v28, v11

    move/from16 v32, v12

    goto/16 :goto_d

    .line 495
    :cond_8
    nop

    .line 496
    nop

    .line 497
    nop

    .line 499
    if-eqz v12, :cond_a

    .line 500
    move/from16 v26, v9

    int-to-float v9, v0

    add-float v9, v9, v21

    div-float v9, v9, v19

    sub-float v9, v9, v21

    move/from16 v27, v0

    int-to-float v0, v5

    const v28, 0x3f800347    # 1.0001f

    sub-float v0, v0, v28

    const/4 v5, 0x0

    invoke-static {v9, v5, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v0

    .line 501
    float-to-int v5, v0

    .line 502
    add-int/lit8 v9, v5, 0x1

    move/from16 v28, v0

    add-int/lit8 v0, p8, -0x1

    invoke-static {v9, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 503
    int-to-float v9, v5

    sub-float v9, v28, v9

    .line 504
    mul-int v28, v11, p8

    add-int v29, v28, v5

    .line 505
    add-int v28, v28, v0

    .line 506
    mul-int v30, v23, p8

    add-int v5, v30, v5

    .line 507
    add-int v30, v30, v0

    .line 509
    aget v0, p6, v29

    aget v31, p6, v28

    aget v32, p6, v29

    sub-float v31, v31, v32

    mul-float v31, v31, v9

    add-float v0, v0, v31

    .line 510
    aget v31, p6, v5

    aget v32, p6, v30

    aget v33, p6, v5

    sub-float v32, v32, v33

    mul-float v32, v32, v9

    add-float v31, v31, v32

    .line 511
    sub-float v31, v31, v0

    mul-float v31, v31, v26

    add-float v0, v0, v31

    .line 512
    move/from16 v32, v9

    move/from16 v31, v10

    float-to-double v9, v0

    invoke-static {v9, v10}, Ljava/lang/Math;->exp(D)D

    move-result-wide v9

    double-to-float v0, v9

    const v9, 0x3b03126f    # 0.002f

    sub-float/2addr v0, v9

    const v9, 0x3a03126f    # 5.0E-4f

    invoke-static {v9, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 514
    aget v9, p7, v29

    aget v10, p7, v28

    aget v28, p7, v29

    sub-float v10, v10, v28

    mul-float v10, v10, v32

    add-float/2addr v9, v10

    .line 515
    aget v10, p7, v5

    aget v28, p7, v30

    aget v5, p7, v5

    sub-float v28, v28, v5

    mul-float v28, v28, v32

    add-float v10, v10, v28

    .line 516
    sub-float/2addr v10, v9

    mul-float v10, v10, v26

    add-float/2addr v9, v10

    .line 518
    const v5, 0x3b83126f    # 0.004f

    const v10, 0x3ca3d70a    # 0.02f

    invoke-static {v5, v10, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    .line 519
    const v10, 0x3d0f5c29    # 0.035f

    move/from16 v28, v5

    const v5, 0x3e0f5c29    # 0.14f

    invoke-static {v10, v5, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v0

    sub-float v0, p10, v0

    .line 520
    const v5, 0x3c03126f    # 0.008f

    const v10, 0x3d0b4396    # 0.034f

    invoke-static {v5, v10, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    .line 521
    const v9, 0x3e75c28f    # 0.24f

    mul-float v9, v9, v28

    mul-float/2addr v9, v0

    const/high16 v0, 0x3f400000    # 0.75f

    mul-float/2addr v5, v0

    add-float v5, v5, v20

    mul-float/2addr v9, v5

    add-float v9, v9, p10

    .line 522
    const v0, 0x3f8020c5    # 1.001f

    cmpl-float v0, v9, v0

    if-lez v0, :cond_9

    .line 523
    sget-object v0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v0, v0, v4

    mul-float/2addr v0, v9

    .line 524
    sget-object v5, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v5, v5, v6

    mul-float/2addr v5, v9

    .line 525
    sget-object v10, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v10, v10, v3

    mul-float/2addr v10, v9

    .line 526
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    .line 527
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v5

    .line 528
    invoke-static {v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v9

    goto :goto_7

    .line 522
    :cond_9
    move v9, v3

    move v0, v4

    move v5, v6

    .line 530
    :goto_7
    goto/16 :goto_9

    :cond_a
    move/from16 v27, v0

    move/from16 v26, v9

    move/from16 v31, v10

    if-eqz v13, :cond_e

    .line 531
    invoke-static {v6, v3}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 532
    const/16 v5, 0xe0

    if-gt v0, v5, :cond_b

    .line 533
    sget-object v0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v0, v0, v4

    .line 534
    sget-object v5, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v5, v5, v6

    .line 535
    sget-object v10, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    aget v10, v10, v3

    .line 536
    mul-float v28, v0, v18

    mul-float v29, v5, v17

    add-float v28, v28, v29

    mul-float v29, v10, v16

    const v30, 0x3e4ccccd    # 0.2f

    add-float v9, v28, v29

    .line 537
    const v28, 0x3b449ba6    # 0.003f

    cmpl-float v28, v9, v28

    if-lez v28, :cond_c

    cmpg-float v28, v9, v30

    if-gez v28, :cond_c

    .line 538
    move/from16 v28, v0

    const v0, 0x3b83126f    # 0.004f

    move/from16 v29, v5

    const v5, 0x3c656042    # 0.014f

    invoke-static {v0, v5, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v0

    const v5, 0x3d4ccccd    # 0.05f

    move/from16 v32, v0

    const v0, 0x3e428f5c    # 0.19f

    invoke-static {v5, v0, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v0

    sub-float v9, p10, v0

    mul-float v0, v32, v9

    .line 539
    mul-float/2addr v0, v14

    add-float v0, v0, p10

    .line 540
    const v5, 0x3f80a3d7    # 1.005f

    cmpl-float v5, v0, v5

    if-lez v5, :cond_c

    .line 541
    mul-float v5, v28, v0

    .line 542
    mul-float v9, v29, v0

    .line 543
    mul-float/2addr v10, v0

    .line 545
    mul-float v28, v5, v18

    mul-float v29, v9, v17

    add-float v28, v28, v29

    mul-float v29, v10, v16

    add-float v28, v28, v29

    .line 546
    sub-float v0, v0, p10

    const/high16 v29, 0x3f400000    # 0.75f

    mul-float v0, v0, v29

    move/from16 v29, v5

    move/from16 v5, p10

    invoke-static {v5, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const v32, 0x3e23d70a    # 0.16f

    mul-float v0, v0, v32

    add-float/2addr v0, v5

    .line 547
    sub-float v5, v29, v28

    mul-float/2addr v5, v0

    add-float v5, v28, v5

    move/from16 v29, v0

    const/4 v0, 0x0

    invoke-static {v0, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 548
    sub-float v9, v9, v28

    mul-float v9, v9, v29

    add-float v9, v28, v9

    invoke-static {v0, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 549
    sub-float v10, v10, v28

    mul-float v10, v10, v29

    add-float v10, v28, v10

    invoke-static {v0, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 550
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    .line 551
    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v5

    .line 552
    invoke-static {v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v9

    goto :goto_8

    .line 532
    :cond_b
    const v30, 0x3e4ccccd    # 0.2f

    .line 557
    :cond_c
    move v9, v3

    move v0, v4

    move v5, v6

    :goto_8
    invoke-static {v5, v9}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-static {v0, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 558
    move/from16 v28, v10

    invoke-static {v5, v9}, Ljava/lang/Math;->min(II)I

    move-result v10

    invoke-static {v0, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 559
    move/from16 v29, v0

    const/16 v0, 0xaa

    if-lt v10, v0, :cond_d

    sub-int v10, v28, v10

    const/16 v0, 0xe

    if-gt v10, v0, :cond_d

    if-lez v10, :cond_d

    .line 560
    mul-int/lit8 v0, v29, 0x36

    mul-int/lit16 v10, v5, 0xb7

    add-int/2addr v0, v10

    mul-int/lit8 v10, v9, 0x12

    add-int/2addr v0, v10

    ushr-int/lit8 v0, v0, 0x8

    .line 561
    sub-int v10, v0, v29

    int-to-float v10, v10

    mul-float v10, v10, v30

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v10

    add-int v10, v29, v10

    invoke-static {v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v10

    .line 562
    move/from16 v28, v0

    sub-int v0, v28, v5

    int-to-float v0, v0

    mul-float v0, v0, v30

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/2addr v5, v0

    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    .line 563
    sub-int v0, v28, v9

    int-to-float v0, v0

    mul-float v0, v0, v30

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/2addr v9, v0

    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v9

    move v0, v10

    goto :goto_9

    .line 567
    :cond_d
    move/from16 v0, v29

    goto :goto_9

    .line 530
    :cond_e
    move v9, v3

    move v0, v4

    move v5, v6

    .line 567
    :goto_9
    if-nez p11, :cond_10

    if-eqz v12, :cond_f

    goto :goto_a

    :cond_f
    move/from16 v28, v11

    move/from16 v32, v12

    goto/16 :goto_c

    .line 568
    :cond_10
    :goto_a
    invoke-static {v5, v9}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-static {v0, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 569
    move/from16 v28, v11

    invoke-static {v5, v9}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-static {v0, v11}, Ljava/lang/Math;->min(II)I

    move-result v11

    .line 570
    if-eqz p11, :cond_11

    move/from16 v29, v5

    const/16 v5, 0xb9

    if-le v10, v5, :cond_12

    sub-int v5, v10, v11

    const/16 v11, 0xe

    if-le v5, v11, :cond_12

    add-int/lit8 v5, v0, 0xc

    if-le v9, v5, :cond_12

    add-int/lit8 v5, v29, -0x6

    if-lt v9, v5, :cond_12

    .line 572
    sub-int v5, v9, v0

    const/4 v11, 0x1

    invoke-static {v11, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    int-to-float v5, v5

    .line 573
    sub-int v11, v29, v0

    int-to-float v11, v11

    div-float v5, v11, v5

    .line 574
    move/from16 v30, v11

    const v11, 0x3f3851ec    # 0.72f

    move/from16 v32, v12

    const v12, 0x3eb33333    # 0.35f

    invoke-static {v12, v11, v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    .line 575
    const/4 v11, 0x0

    cmpl-float v12, v5, v11

    if-lez v12, :cond_13

    .line 576
    const/high16 v11, 0x43700000    # 240.0f

    int-to-float v10, v10

    const/high16 v12, 0x43390000    # 185.0f

    invoke-static {v12, v11, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v10

    .line 577
    const v11, 0x3e0f5c29    # 0.14f

    mul-float/2addr v10, v11

    mul-float/2addr v10, v5

    mul-float v10, v10, v30

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v5

    .line 578
    sub-int v5, v29, v5

    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    .line 579
    invoke-static {v5, v9}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-static {v0, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    goto :goto_b

    .line 570
    :cond_11
    move/from16 v29, v5

    :cond_12
    move/from16 v32, v12

    .line 582
    :cond_13
    move/from16 v5, v29

    :goto_b
    const/16 v11, 0xe0

    if-le v10, v11, :cond_14

    .line 583
    int-to-float v10, v10

    const/high16 v11, 0x43600000    # 224.0f

    sub-float v11, v10, v11

    .line 584
    const/high16 v12, 0x43000000    # 128.0f

    mul-float/2addr v12, v11

    const/high16 v29, 0x43000000    # 128.0f

    add-float v11, v11, v29

    div-float/2addr v12, v11

    const/high16 v11, 0x43600000    # 224.0f

    add-float/2addr v12, v11

    .line 585
    div-float/2addr v12, v10

    .line 586
    int-to-float v0, v0

    mul-float/2addr v0, v12

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v0

    .line 587
    int-to-float v5, v5

    mul-float/2addr v5, v12

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    .line 588
    int-to-float v9, v9

    mul-float/2addr v9, v12

    invoke-static {v9}, Ljava/lang/Math;->round(F)I

    move-result v9

    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v9

    .line 592
    :cond_14
    :goto_c
    if-ne v0, v4, :cond_15

    if-ne v5, v6, :cond_15

    if-eq v9, v3, :cond_16

    .line 593
    :cond_15
    shl-int/lit8 v0, v0, 0x10

    or-int v0, v25, v0

    shl-int/lit8 v3, v5, 0x8

    or-int/2addr v0, v3

    or-int/2addr v0, v9

    aput v0, p0, v24

    .line 484
    :cond_16
    :goto_d
    add-int/lit8 v0, v27, 0x1

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v9, v26

    move/from16 v11, v28

    move/from16 v10, v31

    move/from16 v12, v32

    const/high16 p10, 0x3f800000    # 1.0f

    goto/16 :goto_6

    .line 476
    :cond_17
    move/from16 v32, v12

    add-int/lit8 v15, v15, 0x1

    const/4 v10, 0x0

    move-object/from16 v0, p0

    move-object/from16 v3, p6

    move-object/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    goto/16 :goto_3

    .line 599
    :cond_18
    if-eqz p12, :cond_35

    const v12, 0x3ee66666    # 0.45f

    cmpl-float v0, p13, v12

    if-ltz v0, :cond_35

    const/high16 v0, 0x41f00000    # 30.0f

    cmpg-float v0, p13, v0

    if-gtz v0, :cond_35

    const/16 v0, 0x320

    if-ge v7, v0, :cond_35

    const/4 v0, 0x6

    if-lt v1, v0, :cond_35

    if-lt v8, v0, :cond_35

    .line 600
    const/16 v0, 0xc8

    if-le v7, v0, :cond_19

    move/from16 v5, v21

    goto :goto_e

    :cond_19
    const/high16 v5, 0x3f800000    # 1.0f

    .line 601
    :goto_e
    const v0, 0x403ccccd    # 2.95f

    cmpg-float v0, p13, v0

    if-gez v0, :cond_1a

    const/4 v11, 0x1

    goto :goto_f

    :cond_1a
    const/4 v11, 0x0

    .line 605
    :goto_f
    const v3, 0x3f733333    # 0.95f

    cmpg-float v4, p13, v3

    if-gez v4, :cond_1b

    .line 606
    nop

    .line 607
    nop

    .line 608
    const v0, 0x3e75c28f    # 0.24f

    mul-float/2addr v5, v0

    const v0, 0x3d30b0b1

    move/from16 v4, v20

    goto :goto_10

    .line 609
    :cond_1b
    const v4, 0x3fd9999a    # 1.7f

    cmpg-float v4, p13, v4

    if-gez v4, :cond_1c

    .line 610
    nop

    .line 611
    nop

    .line 612
    const v0, 0x3ec28f5c    # 0.38f

    mul-float/2addr v5, v0

    const v0, 0x3d109091

    const v4, 0x3e6147ae    # 0.22f

    goto :goto_10

    .line 613
    :cond_1c
    if-gez v0, :cond_1d

    .line 614
    nop

    .line 615
    nop

    .line 616
    const v0, 0x3e8f5c29    # 0.28f

    mul-float/2addr v5, v0

    const v0, 0x3d20a0a1

    const v4, 0x3eb33333    # 0.35f

    goto :goto_10

    .line 617
    :cond_1d
    const/high16 v0, 0x40b00000    # 5.5f

    cmpg-float v0, p13, v0

    if-gez v0, :cond_1e

    .line 618
    nop

    .line 619
    nop

    .line 620
    const v0, 0x3e6147ae    # 0.22f

    mul-float/2addr v5, v0

    const v0, 0x3d20a0a1

    move v4, v12

    goto :goto_10

    .line 621
    :cond_1e
    const/high16 v0, 0x41400000    # 12.0f

    cmpg-float v0, p13, v0

    if-gez v0, :cond_1f

    .line 622
    nop

    .line 623
    nop

    .line 624
    const v0, 0x3ed70a3d    # 0.42f

    mul-float/2addr v5, v0

    const v0, 0x3d008081

    const v4, 0x3ef5c28f    # 0.48f

    goto :goto_10

    .line 626
    :cond_1f
    nop

    .line 627
    nop

    .line 628
    const v0, 0x3ea3d70a    # 0.32f

    mul-float/2addr v5, v0

    const v0, 0x3d109091

    const v4, 0x3f0ccccd    # 0.55f

    .line 630
    :goto_10
    new-array v6, v2, [F

    .line 631
    const/4 v10, 0x0

    :goto_11
    if-ge v10, v2, :cond_20

    .line 632
    aget v7, p0, v10

    .line 633
    ushr-int/lit8 v9, v7, 0x10

    and-int/lit16 v9, v9, 0xff

    int-to-float v9, v9

    mul-float v9, v9, v18

    ushr-int/lit8 v13, v7, 0x8

    and-int/lit16 v13, v13, 0xff

    int-to-float v13, v13

    mul-float v13, v13, v17

    add-float/2addr v9, v13

    and-int/lit16 v7, v7, 0xff

    int-to-float v7, v7

    mul-float v7, v7, v16

    add-float/2addr v9, v7

    const v7, 0x3b808081

    mul-float/2addr v9, v7

    aput v9, v6, v10

    .line 631
    add-int/lit8 v10, v10, 0x1

    goto :goto_11

    .line 637
    :cond_20
    mul-float/2addr v0, v0

    .line 638
    const v2, 0x3fd9999a    # 1.7f

    cmpg-float v2, p13, v2

    if-gez v2, :cond_21

    const/high16 v19, 0x41200000    # 10.0f

    :cond_21
    const/high16 v2, 0x437f0000    # 255.0f

    div-float v19, v19, v2

    .line 639
    const/4 v7, 0x2

    :goto_12
    add-int/lit8 v9, v8, -0x2

    if-ge v7, v9, :cond_35

    .line 640
    mul-int v9, v7, v1

    .line 641
    const/4 v10, 0x2

    :goto_13
    add-int/lit8 v13, v1, -0x2

    if-ge v10, v13, :cond_34

    .line 642
    nop

    .line 643
    nop

    .line 644
    nop

    .line 645
    nop

    .line 646
    nop

    .line 647
    nop

    .line 648
    const/4 v13, -0x1

    move/from16 p3, v2

    move/from16 p4, v12

    move v3, v13

    const/4 v2, 0x0

    const/high16 v12, 0x3f800000    # 1.0f

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    :goto_14
    move/from16 p7, v5

    const/4 v5, 0x1

    if-gt v3, v5, :cond_25

    .line 649
    add-int v17, v7, v3

    mul-int v17, v17, v1

    .line 650
    const/16 v18, -0x1

    move/from16 p8, v2

    move/from16 v2, v18

    :goto_15
    if-gt v2, v5, :cond_24

    .line 651
    add-int v18, v17, v10

    add-int v18, v18, v2

    .line 652
    aget v22, v6, v18

    .line 653
    add-float v16, v16, v22

    .line 654
    cmpg-float v23, v22, v12

    if-gez v23, :cond_22

    move/from16 v12, v22

    .line 655
    :cond_22
    cmpl-float v23, v22, p8

    if-lez v23, :cond_23

    goto :goto_16

    :cond_23
    move/from16 v22, p8

    .line 656
    :goto_16
    add-int/lit8 v23, v18, 0x1

    aget v23, v6, v23

    add-int/lit8 v24, v18, -0x1

    aget v24, v6, v24

    sub-float v23, v23, v24

    mul-float v23, v23, v21

    .line 657
    add-int v24, v18, v1

    aget v24, v6, v24

    sub-int v18, v18, v1

    aget v18, v6, v18

    sub-float v24, v24, v18

    mul-float v24, v24, v21

    .line 658
    mul-float v18, v23, v23

    add-float v13, v13, v18

    .line 659
    mul-float v23, v23, v24

    add-float v14, v14, v23

    .line 660
    mul-float v24, v24, v24

    add-float v15, v15, v24

    .line 650
    add-int/lit8 v2, v2, 0x1

    move/from16 p8, v22

    goto :goto_15

    .line 648
    :cond_24
    add-int/lit8 v3, v3, 0x1

    move/from16 v5, p7

    move/from16 v2, p8

    goto :goto_14

    .line 663
    :cond_25
    sub-float v3, v2, v12

    cmpg-float v3, v3, v19

    if-gez v3, :cond_26

    .line 664
    move/from16 p11, v0

    move-object v3, v6

    move/from16 p9, v9

    move v13, v10

    const v10, 0x3f733333    # 0.95f

    const/4 v14, 0x0

    goto/16 :goto_1e

    .line 666
    :cond_26
    const v3, 0x3de38e39

    mul-float/2addr v13, v3

    .line 667
    mul-float/2addr v14, v3

    .line 668
    mul-float/2addr v15, v3

    .line 669
    move/from16 p8, v3

    add-float v3, v13, v15

    .line 670
    cmpg-float v17, v3, v0

    if-gez v17, :cond_27

    .line 671
    move/from16 p11, v0

    move-object v3, v6

    move/from16 p9, v9

    move v13, v10

    const v10, 0x3f733333    # 0.95f

    const/4 v14, 0x0

    goto/16 :goto_1e

    .line 673
    :cond_27
    sub-float/2addr v13, v15

    .line 674
    mul-float v15, v13, v13

    const/high16 v17, 0x40800000    # 4.0f

    mul-float v17, v17, v14

    mul-float v17, v17, v14

    add-float v15, v15, v17

    move-object/from16 v17, v6

    float-to-double v5, v15

    invoke-static {v5, v6}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v5

    double-to-float v5, v5

    .line 675
    add-float v6, v3, v5

    mul-float v6, v6, v21

    .line 676
    sub-float v15, v3, v5

    mul-float v15, v15, v21

    .line 677
    sub-float v18, v6, v15

    add-float/2addr v6, v15

    const v15, 0x322bcc77    # 1.0E-8f

    add-float/2addr v6, v15

    div-float v6, v18, v6

    .line 678
    add-int v15, v9, v10

    aget v18, v17, v15

    .line 681
    const/high16 v23, 0x40000000    # 2.0f

    if-eqz v11, :cond_2b

    .line 684
    move/from16 v24, v5

    add-float v5, v4, p4

    move/from16 p9, v9

    const v9, 0x3f733333    # 0.95f

    invoke-static {v9, v5}, Ljava/lang/Math;->min(FF)F

    move-result v5

    invoke-static {v4, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    .line 685
    const/high16 v6, 0x40c00000    # 6.0f

    mul-float/2addr v6, v0

    invoke-static {v0, v6, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v3

    .line 686
    const/4 v6, 0x0

    cmpl-float v9, v13, v6

    if-ltz v9, :cond_28

    add-float v6, v13, v24

    goto :goto_17

    :cond_28
    mul-float v6, v14, v23

    .line 687
    :goto_17
    if-ltz v9, :cond_29

    mul-float v14, v14, v23

    goto :goto_18

    :cond_29
    sub-float v14, v24, v13

    .line 688
    :goto_18
    mul-float v9, v6, v6

    mul-float v13, v14, v14

    add-float/2addr v9, v13

    move/from16 p11, v14

    float-to-double v13, v9

    invoke-static {v13, v14}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v13

    double-to-float v9, v13

    .line 689
    nop

    .line 690
    const v13, 0x358637bd    # 1.0E-6f

    cmpl-float v13, v9, v13

    if-ltz v13, :cond_2a

    .line 691
    div-float/2addr v6, v9

    .line 692
    div-float v14, p11, v9

    .line 693
    int-to-float v9, v10

    sub-float v13, v9, v6

    move/from16 p11, v0

    int-to-float v0, v7

    move/from16 v23, v0

    sub-float v0, v23, v14

    move/from16 p12, v3

    move-object/from16 v3, v17

    invoke-static {v3, v1, v8, v13, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v0

    .line 694
    add-float/2addr v9, v6

    add-float v6, v23, v14

    invoke-static {v3, v1, v8, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v6

    .line 695
    add-float/2addr v0, v6

    mul-float v0, v0, v21

    sub-float v0, v18, v0

    goto :goto_19

    .line 690
    :cond_2a
    move/from16 p11, v0

    move/from16 p12, v3

    move-object/from16 v3, v17

    const/4 v0, 0x0

    .line 697
    :goto_19
    mul-float v16, v16, p8

    sub-float v6, v18, v16

    .line 698
    mul-float/2addr v0, v5

    const/high16 v9, 0x3f800000    # 1.0f

    sub-float v13, v9, v5

    mul-float/2addr v6, v13

    add-float/2addr v0, v6

    .line 699
    mul-float v6, p12, p4

    invoke-static {v6, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    mul-float v5, v5, p7

    .line 700
    move v6, v5

    move v13, v10

    const v5, 0x3eb33333    # 0.35f

    const v10, 0x3f733333    # 0.95f

    goto/16 :goto_1c

    .line 701
    :cond_2b
    move/from16 p11, v0

    move/from16 v24, v5

    move/from16 p9, v9

    move-object/from16 v3, v17

    const/high16 v9, 0x3f800000    # 1.0f

    cmpg-float v0, v6, v4

    if-gez v0, :cond_2c

    .line 702
    move v13, v10

    const v10, 0x3f733333    # 0.95f

    const/4 v14, 0x0

    goto/16 :goto_1e

    .line 704
    :cond_2c
    const/4 v0, 0x0

    cmpl-float v5, v13, v0

    if-ltz v5, :cond_2d

    add-float v0, v13, v24

    goto :goto_1a

    :cond_2d
    mul-float v0, v14, v23

    .line 705
    :goto_1a
    if-ltz v5, :cond_2e

    mul-float v14, v14, v23

    goto :goto_1b

    :cond_2e
    sub-float v14, v24, v13

    .line 706
    :goto_1b
    mul-float v5, v0, v0

    mul-float v13, v14, v14

    add-float/2addr v5, v13

    move v13, v10

    float-to-double v9, v5

    invoke-static {v9, v10}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v9

    double-to-float v5, v9

    .line 707
    const v9, 0x358637bd    # 1.0E-6f

    cmpg-float v9, v5, v9

    if-gez v9, :cond_2f

    .line 708
    const v10, 0x3f733333    # 0.95f

    const/4 v14, 0x0

    goto/16 :goto_1e

    .line 710
    :cond_2f
    div-float/2addr v0, v5

    .line 711
    div-float/2addr v14, v5

    .line 712
    int-to-float v5, v13

    sub-float v9, v5, v0

    int-to-float v10, v7

    move/from16 p8, v0

    sub-float v0, v10, v14

    invoke-static {v3, v1, v8, v9, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v0

    .line 713
    add-float v5, v5, p8

    add-float/2addr v10, v14

    invoke-static {v3, v1, v8, v5, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->sampleBilinearY([FIIFF)F

    move-result v5

    .line 714
    add-float/2addr v0, v5

    mul-float v0, v0, v21

    sub-float v0, v18, v0

    .line 715
    const v5, 0x3eb33333    # 0.35f

    add-float v9, v4, v5

    const v10, 0x3f733333    # 0.95f

    invoke-static {v10, v9}, Ljava/lang/Math;->min(FF)F

    move-result v9

    invoke-static {v4, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v6

    mul-float v6, v6, p7

    .line 717
    :goto_1c
    const v9, 0x3f666666    # 0.9f

    cmpl-float v9, v2, v9

    if-lez v9, :cond_30

    .line 718
    mul-float v6, v6, v20

    .line 720
    :cond_30
    mul-float/2addr v6, v0

    add-float v6, v18, v6

    invoke-static {v6, v12, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result v0

    .line 721
    sub-float v0, v0, v18

    mul-float v0, v0, p3

    .line 722
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v2

    cmpg-float v2, v2, v20

    if-gez v2, :cond_31

    .line 723
    const/4 v14, 0x0

    goto :goto_1e

    .line 725
    :cond_31
    nop

    .line 726
    aget v2, p0, v15

    .line 727
    ushr-int/lit8 v6, v2, 0x10

    and-int/lit16 v6, v6, 0xff

    .line 728
    ushr-int/lit8 v9, v2, 0x8

    and-int/lit16 v9, v9, 0xff

    .line 729
    and-int/lit16 v12, v2, 0xff

    .line 730
    const/4 v14, 0x0

    cmpl-float v16, v0, v14

    if-lez v16, :cond_32

    .line 731
    invoke-static {v9, v12}, Ljava/lang/Math;->max(II)I

    move-result v5

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    int-to-float v5, v5

    sub-float v5, p3, v5

    .line 732
    invoke-static {v0, v5}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 733
    goto :goto_1d

    .line 734
    :cond_32
    invoke-static {v9, v12}, Ljava/lang/Math;->min(II)I

    move-result v5

    invoke-static {v6, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    neg-int v5, v5

    int-to-float v5, v5

    .line 735
    invoke-static {v0, v5}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 737
    :goto_1d
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 738
    if-eqz v0, :cond_33

    .line 739
    const/high16 v5, -0x1000000

    and-int/2addr v2, v5

    add-int/2addr v6, v0

    .line 740
    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v2, v5

    add-int/2addr v9, v0

    .line 741
    invoke-static {v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v5

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v2, v5

    add-int/2addr v12, v0

    .line 742
    invoke-static {v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clampByte(I)I

    move-result v0

    or-int/2addr v0, v2

    aput v0, p0, v15

    .line 641
    :cond_33
    :goto_1e
    add-int/lit8 v0, v13, 0x1

    move/from16 v2, p3

    move/from16 v12, p4

    move/from16 v5, p7

    move/from16 v9, p9

    move-object v6, v3

    move v3, v10

    move v10, v0

    move/from16 v0, p11

    goto/16 :goto_13

    .line 639
    :cond_34
    move/from16 p11, v0

    move/from16 p3, v2

    move v10, v3

    move/from16 p7, v5

    move-object v3, v6

    move/from16 p4, v12

    const/4 v14, 0x0

    add-int/lit8 v7, v7, 0x1

    move v3, v10

    goto/16 :goto_12

    .line 747
    :cond_35
    return-void

    .line 459
    :cond_36
    :goto_1f
    return-void
.end method

.method private static applyLightnessCurve(FI)F
    .locals 4

    .line 978
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 979
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    return v0

    .line 980
    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_4

    .line 982
    const p1, 0x3e6147ae    # 0.22f

    cmpg-float v1, p0, p1

    if-gez v1, :cond_2

    .line 983
    float-to-double p0, p0

    const-wide v0, 0x3fcc28f5c28f5c29L    # 0.22

    div-double/2addr p0, v0

    const-wide v2, 0x3ff2e147ae147ae1L    # 1.18

    invoke-static {p0, p1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide p0

    mul-double/2addr p0, v0

    double-to-float p0, p0

    return p0

    .line 985
    :cond_2
    const v1, 0x3f3851ec    # 0.72f

    cmpg-float v2, p0, v1

    if-gez v2, :cond_3

    .line 986
    sub-float p1, p0, p1

    const/high16 v0, 0x3f000000    # 0.5f

    div-float/2addr p1, v0

    .line 987
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

    .line 989
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

    .line 991
    :cond_4
    const/4 v1, 0x3

    if-ne p1, v1, :cond_5

    .line 993
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

    .line 996
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

    .line 336
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

    .line 389
    if-eqz p0, :cond_1

    const/16 v0, 0x10

    if-lt p1, v0, :cond_1

    if-lt p2, v0, :cond_1

    array-length v0, p0

    mul-int v1, p1, p2

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 392
    :cond_0
    add-int/lit8 v0, p1, 0x8

    add-int/lit8 v0, v0, -0x1

    div-int/lit8 v0, v0, 0x8

    const/4 v1, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 393
    add-int/lit8 v0, p2, 0x8

    add-int/lit8 v0, v0, -0x1

    div-int/lit8 v0, v0, 0x8

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v10

    .line 394
    mul-int v0, v9, v10

    new-array v7, v0, [F

    .line 395
    new-array v8, v0, [F

    .line 396
    const/4 v5, 0x0

    move v6, p2

    move-object v2, p0

    move v3, p1

    move v4, p2

    invoke-static/range {v2 .. v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    .line 397
    invoke-static {v7, v9, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object p0

    filled-new-array {p0, v8}, [[F

    move-result-object p0

    return-object p0

    .line 390
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

    .line 1055
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

    .line 1051
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

    .line 768
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

    .line 1224
    nop

    .line 1225
    const/4 v0, 0x0

    .line 1226
    :goto_0
    if-ge p1, p2, :cond_2

    .line 1227
    :goto_1
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1228
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 1230
    :cond_0
    if-lt p1, p2, :cond_1

    .line 1231
    goto :goto_2

    .line 1233
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 1234
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    goto :goto_0

    .line 1236
    :cond_2
    :goto_2
    return v0
.end method

.method private static deterministicGrain6(II)F
    .locals 1

    .line 1033
    const v0, -0x61c8864f

    mul-int/2addr p0, v0

    const v0, -0x7a143589

    mul-int/2addr p1, v0

    xor-int/2addr p0, p1

    .line 1034
    ushr-int/lit8 p1, p0, 0xf

    xor-int/2addr p0, p1

    .line 1035
    const p1, 0x2c1b3c6d

    mul-int/2addr p0, p1

    .line 1036
    ushr-int/lit8 p1, p0, 0xc

    xor-int/2addr p0, p1

    .line 1038
    and-int/lit16 p1, p0, 0xff

    ushr-int/lit8 v0, p0, 0x8

    and-int/lit16 v0, v0, 0xff

    add-int/2addr p1, v0

    .line 1039
    ushr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    ushr-int/lit8 p0, p0, 0x18

    and-int/lit16 p0, p0, 0xff

    add-int/2addr v0, p0

    .line 1040
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

    .line 1248
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

.method public static evaluateAutoBacklitSubjectGate([II)Z
    .locals 22

    .line 277
    move-object/from16 v0, p0

    move/from16 v1, p1

    const/4 v2, 0x0

    if-eqz v0, :cond_b

    if-gtz v1, :cond_0

    move/from16 v16, v2

    goto/16 :goto_4

    .line 280
    :cond_0
    array-length v3, v0

    invoke-static {v3, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 281
    if-gtz v1, :cond_1

    .line 282
    return v2

    .line 284
    :cond_1
    const/16 v3, 0x100

    new-array v4, v3, [I

    .line 285
    nop

    .line 286
    nop

    .line 287
    nop

    .line 288
    nop

    .line 289
    const-wide/16 v5, 0x0

    move v7, v2

    move v8, v7

    move v9, v8

    move v10, v9

    :goto_0
    const/16 v11, 0xff

    const/4 v12, 0x1

    if-ge v7, v1, :cond_5

    .line 290
    aget v13, v0, v7

    .line 291
    ushr-int/lit8 v14, v13, 0x10

    and-int/2addr v14, v11

    mul-int/lit8 v14, v14, 0x4d

    ushr-int/lit8 v15, v13, 0x8

    and-int/2addr v15, v11

    mul-int/lit16 v15, v15, 0x96

    add-int/2addr v14, v15

    and-int/2addr v11, v13

    mul-int/lit8 v11, v11, 0x1d

    add-int/2addr v14, v11

    ushr-int/lit8 v11, v14, 0x8

    .line 292
    aget v13, v4, v11

    add-int/2addr v13, v12

    aput v13, v4, v11

    .line 293
    int-to-long v12, v11

    add-long/2addr v5, v12

    .line 294
    const/4 v12, 0x5

    if-gt v11, v12, :cond_2

    add-int/lit8 v8, v8, 0x1

    .line 295
    :cond_2
    const/16 v12, 0xfa

    if-lt v11, v12, :cond_3

    add-int/lit8 v9, v9, 0x1

    .line 296
    :cond_3
    const/16 v12, 0x14

    if-lt v11, v12, :cond_4

    const/16 v12, 0x6c

    if-gt v11, v12, :cond_4

    add-int/lit8 v10, v10, 0x1

    .line 289
    :cond_4
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 298
    :cond_5
    long-to-double v5, v5

    int-to-double v13, v1

    div-double/2addr v5, v13

    .line 299
    mul-int/lit8 v0, v1, 0x5

    const/16 v7, 0x64

    div-int/2addr v0, v7

    invoke-static {v12, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 300
    mul-int/lit8 v13, v1, 0x32

    div-int/2addr v13, v7

    invoke-static {v0, v13}, Ljava/lang/Math;->max(II)I

    move-result v13

    .line 301
    mul-int/lit8 v14, v1, 0x5f

    div-int/2addr v14, v7

    invoke-static {v13, v14}, Ljava/lang/Math;->max(II)I

    move-result v14

    .line 302
    nop

    .line 303
    nop

    .line 304
    nop

    .line 305
    nop

    .line 306
    nop

    .line 307
    nop

    .line 308
    const/16 v15, 0x80

    move/from16 v16, v2

    move/from16 v17, v16

    move/from16 v18, v17

    move/from16 v19, v18

    move/from16 v20, v19

    :goto_1
    if-ge v2, v3, :cond_9

    .line 309
    aget v21, v4, v2

    add-int v3, v17, v21

    .line 310
    if-nez v18, :cond_6

    if-lt v3, v0, :cond_6

    .line 311
    nop

    .line 312
    move/from16 v20, v2

    move/from16 v18, v12

    .line 314
    :cond_6
    if-nez v19, :cond_7

    if-lt v3, v13, :cond_7

    .line 315
    nop

    .line 316
    move v15, v2

    move/from16 v19, v12

    .line 318
    :cond_7
    if-lt v3, v14, :cond_8

    .line 319
    nop

    .line 320
    move v11, v2

    move/from16 v0, v20

    goto :goto_2

    .line 308
    :cond_8
    add-int/lit8 v2, v2, 0x1

    move/from16 v17, v3

    const/16 v3, 0x100

    goto :goto_1

    :cond_9
    move/from16 v0, v20

    .line 323
    :goto_2
    const/16 v2, 0xa5

    if-lt v15, v2, :cond_a

    const-wide v2, 0x4062c00000000000L    # 150.0

    cmpl-double v2, v5, v2

    if-ltz v2, :cond_a

    const/16 v2, 0xf

    if-lt v0, v2, :cond_a

    const/16 v2, 0x3c

    if-gt v0, v2, :cond_a

    sub-int/2addr v15, v0

    if-lt v15, v7, :cond_a

    const/16 v0, 0xe4

    if-gt v11, v0, :cond_a

    int-to-float v0, v10

    int-to-float v1, v1

    const v2, 0x3cf5c28f    # 0.03f

    mul-float/2addr v2, v1

    cmpl-float v2, v0, v2

    if-ltz v2, :cond_a

    const v2, 0x3e6147ae    # 0.22f

    mul-float/2addr v2, v1

    cmpg-float v0, v0, v2

    if-gtz v0, :cond_a

    int-to-float v0, v8

    const v2, 0x3ba3d70a    # 0.005f

    mul-float/2addr v1, v2

    cmpg-float v0, v0, v1

    if-gez v0, :cond_a

    int-to-float v0, v9

    cmpg-float v0, v0, v1

    if-gez v0, :cond_a

    move v2, v12

    goto :goto_3

    :cond_a
    move/from16 v2, v16

    :goto_3
    return v2

    .line 277
    :cond_b
    move/from16 v16, v2

    .line 278
    :goto_4
    return v16
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

    .line 1015
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 1016
    :cond_0
    invoke-static {p0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    .line 1017
    div-int/lit8 v0, v0, 0x3

    const v1, 0x2a5137a0

    add-int/2addr v0, v1

    .line 1018
    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    .line 1020
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 1021
    const/high16 v2, 0x40000000    # 2.0f

    mul-float v3, p0, v2

    add-float v4, v1, v3

    mul-float/2addr v0, v4

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    .line 1022
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 1023
    add-float/2addr v3, v1

    mul-float/2addr v0, v3

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    return v0
.end method

.method private static fastExpNeg(F)F
    .locals 2

    .line 1009
    const/high16 v0, 0x41200000    # 10.0f

    cmpl-float v0, p0, v0

    const/4 v1, 0x0

    if-ltz v0, :cond_0

    return v1

    .line 1010
    :cond_0
    cmpg-float v0, p0, v1

    if-gtz v0, :cond_1

    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 1011
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

    .line 381
    if-eqz p0, :cond_1

    const/4 v0, 0x2

    if-lt p1, v0, :cond_1

    if-ge p2, v0, :cond_0

    goto :goto_0

    .line 384
    :cond_0
    const v0, 0x3eb33333    # 0.35f

    invoke-static {p0, p1, p2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->bilateralSmoothLogGrid([FIIF)[F

    move-result-object p0

    return-object p0

    .line 382
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static gaussianHueWeight(FFF)F
    .locals 0

    .line 1000
    sub-float/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result p0

    .line 1001
    const/high16 p1, 0x43340000    # 180.0f

    cmpl-float p1, p0, p1

    if-lez p1, :cond_0

    .line 1002
    const/high16 p1, 0x43b40000    # 360.0f

    sub-float p0, p1, p0

    .line 1004
    :cond_0
    div-float/2addr p0, p2

    .line 1005
    const/high16 p1, 0x3f000000    # 0.5f

    mul-float/2addr p1, p0

    mul-float/2addr p1, p0

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result p0

    return p0
.end method

.method private static gradePixel(IFFFZFIFZII)I
    .locals 18

    .line 774
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

    .line 775
    return p0

    .line 777
    :cond_0
    const/high16 v4, 0x3f800000    # 1.0f

    cmpl-float v5, v0, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p2, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p3, v4

    if-ltz v5, :cond_1

    .line 778
    const v0, 0xffffff

    or-int v0, p0, v0

    return v0

    .line 782
    :cond_1
    const v5, 0x3e59b3d0    # 0.2126f

    mul-float v6, v0, v5

    const v7, 0x3f371759    # 0.7152f

    mul-float v8, p2, v7

    add-float/2addr v6, v8

    const v8, 0x3d93dd98    # 0.0722f

    mul-float v9, p3, v8

    add-float/2addr v6, v9

    .line 783
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v0, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v6, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 784
    const v10, 0x3f1eb852    # 0.62f

    cmpl-float v11, v9, v10

    const v12, 0x3e0f5c29    # 0.14f

    const v13, 0x3ec28f5c    # 0.38f

    if-lez v11, :cond_4

    .line 785
    sub-float v6, v9, v10

    div-float/2addr v6, v13

    .line 786
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

    .line 787
    const/4 v6, 0x1

    if-ne v2, v6, :cond_2

    cmpl-float v6, v11, v9

    if-lez v6, :cond_2

    .line 788
    move v11, v9

    .line 790
    :cond_2
    div-float/2addr v11, v9

    .line 791
    mul-float/2addr v0, v11

    .line 792
    mul-float v6, p2, v11

    .line 793
    mul-float v11, v11, p3

    .line 795
    const v14, 0x3f5c28f6    # 0.86f

    cmpl-float v15, v9, v14

    if-lez v15, :cond_3

    if-nez p4, :cond_3

    .line 796
    invoke-static {v14, v4, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v9

    const v14, 0x3e75c28f    # 0.24f

    mul-float/2addr v9, v14

    .line 797
    mul-float v14, v0, v5

    mul-float v15, v6, v7

    add-float/2addr v14, v15

    mul-float v15, v11, v8

    add-float/2addr v14, v15

    .line 798
    sub-float v15, v14, v0

    mul-float/2addr v15, v9

    add-float/2addr v0, v15

    .line 799
    sub-float v15, v14, v6

    mul-float/2addr v15, v9

    add-float/2addr v6, v15

    .line 800
    sub-float/2addr v14, v11

    mul-float/2addr v14, v9

    add-float/2addr v11, v14

    .line 802
    :cond_3
    mul-float/2addr v5, v0

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    mul-float/2addr v8, v11

    add-float/2addr v5, v8

    goto :goto_0

    .line 784
    :cond_4
    move/from16 v11, p3

    move v5, v6

    move/from16 v6, p2

    .line 806
    :goto_0
    const/high16 v7, -0x3ef00000    # -9.0f

    cmpl-float v7, v1, v7

    const v8, 0x3b03126f    # 0.002f

    if-lez v7, :cond_5

    if-nez p4, :cond_5

    .line 807
    float-to-double v14, v1

    invoke-static {v14, v15}, Ljava/lang/Math;->exp(D)D

    move-result-wide v14

    double-to-float v1, v14

    sub-float/2addr v1, v8

    const v7, 0x3a03126f    # 5.0E-4f

    invoke-static {v7, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 808
    invoke-static {v1, v5, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->localBaseGain(FFI)F

    move-result v1

    .line 809
    mul-float/2addr v0, v1

    invoke-static {v3, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 810
    mul-float/2addr v6, v1

    invoke-static {v3, v6}, Ljava/lang/Math;->max(FF)F

    move-result v6

    .line 811
    mul-float/2addr v11, v1

    invoke-static {v3, v11}, Ljava/lang/Math;->max(FF)F

    move-result v11

    .line 815
    :cond_5
    const v1, 0x3ed30eb1

    mul-float/2addr v1, v0

    const v5, 0x3f094d17

    mul-float/2addr v5, v6

    add-float/2addr v1, v5

    const v5, 0x3d52b909

    mul-float/2addr v5, v11

    add-float/2addr v1, v5

    .line 816
    const v5, 0x3e58fd3b

    mul-float/2addr v5, v0

    const v7, 0x3f2e4253

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    const v7, 0x3ddbf2f0

    mul-float/2addr v7, v11

    add-float/2addr v5, v7

    .line 817
    const v7, 0x3db4d7ec

    mul-float/2addr v0, v7

    const v7, 0x3e903d74

    mul-float/2addr v6, v7

    add-float/2addr v0, v6

    const v6, 0x3f214649

    mul-float/2addr v11, v6

    add-float/2addr v0, v11

    .line 819
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v1

    .line 820
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v5

    .line 821
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v0

    .line 823
    const v6, 0x3e578152

    mul-float/2addr v6, v1

    const v7, 0x3f4b2a89

    mul-float/2addr v7, v5

    add-float/2addr v6, v7

    const v7, 0x3b856ece

    mul-float/2addr v7, v0

    sub-float/2addr v6, v7

    .line 824
    const v7, 0x3ffd2f0e

    mul-float/2addr v7, v1

    const v9, 0x401b6e0e

    mul-float/2addr v9, v5

    sub-float/2addr v7, v9

    const v9, 0x3ee6b438

    mul-float/2addr v9, v0

    add-float/2addr v7, v9

    .line 825
    const v9, 0x3cd434b4

    mul-float/2addr v1, v9

    const v9, 0x3f4863bb

    mul-float/2addr v5, v9

    add-float/2addr v1, v5

    const v5, 0x3f4f0560

    mul-float/2addr v0, v5

    sub-float/2addr v1, v0

    .line 828
    invoke-static {v6, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyLightnessCurve(FI)F

    move-result v0

    .line 830
    const v5, 0x3f6b851f    # 0.92f

    const/4 v9, 0x3

    if-eqz p8, :cond_7

    .line 832
    cmpl-float v11, p7, v3

    if-lez v11, :cond_6

    .line 833
    const v11, 0x3f147ae1    # 0.58f

    invoke-static {v11, v5, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v11

    sub-float v11, v4, v11

    .line 834
    mul-float v11, v11, p7

    sub-float v11, v4, v11

    mul-float/2addr v0, v11

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 837
    :cond_6
    if-ne v2, v9, :cond_7

    .line 838
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

    .line 839
    cmpl-float v14, v11, v3

    if-lez v14, :cond_7

    .line 840
    invoke-static/range {p9 .. p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->deterministicGrain6(II)F

    move-result v14

    const v15, 0x3b51b717    # 0.0032f

    mul-float/2addr v14, v15

    mul-float/2addr v14, v11

    add-float/2addr v0, v14

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 845
    :cond_7
    if-eqz p4, :cond_8

    .line 846
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 847
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    .line 848
    shl-int/lit8 v1, v0, 0x10

    or-int v1, p0, v1

    shl-int/lit8 v2, v0, 0x8

    or-int/2addr v1, v2

    or-int/2addr v0, v1

    return v0

    .line 851
    :cond_8
    mul-float v11, v7, v7

    mul-float v14, v1, v1

    add-float/2addr v11, v14

    float-to-double v14, v11

    invoke-static {v14, v15}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v14

    double-to-float v11, v14

    .line 852
    nop

    .line 853
    nop

    .line 855
    const v14, 0x38d1b717    # 1.0E-4f

    cmpl-float v14, v11, v14

    const v15, 0x3d4ccccd    # 0.05f

    if-lez v14, :cond_f

    .line 856
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

    .line 857
    cmpg-float v4, v3, v14

    if-gez v4, :cond_9

    .line 858
    const/high16 v4, 0x43b40000    # 360.0f

    add-float/2addr v3, v4

    .line 861
    :cond_9
    const v4, 0x3c449ba6    # 0.012f

    invoke-static {v4, v15, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    .line 864
    const/high16 v8, 0x43080000    # 136.0f

    const/high16 v9, 0x41b00000    # 22.0f

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v8

    mul-float/2addr v8, v4

    .line 865
    const v9, 0x3c23d70a    # 0.01f

    cmpl-float v17, v8, v9

    if-lez v17, :cond_a

    .line 866
    mul-float/2addr v12, v8

    sub-float v12, v16, v12

    .line 867
    const v17, 0x3d8efa35

    mul-float v8, v8, v17

    .line 868
    neg-float v8, v8

    move/from16 p4, v14

    move/from16 p3, v15

    float-to-double v14, v8

    move/from16 p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->cos(D)D

    move-result-wide v5

    double-to-float v5, v5

    .line 869
    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v6, v14

    .line 870
    mul-float v14, v7, v5

    mul-float v15, v1, v6

    sub-float/2addr v14, v15

    mul-float/2addr v14, v12

    .line 871
    mul-float/2addr v7, v6

    mul-float/2addr v1, v5

    add-float/2addr v7, v1

    mul-float v1, v7, v12

    .line 872
    nop

    .line 873
    move v7, v14

    goto :goto_1

    .line 865
    :cond_a
    move/from16 p5, v6

    move/from16 p4, v14

    move/from16 p3, v15

    .line 877
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

    .line 878
    cmpl-float v9, v5, v9

    const/4 v10, 0x2

    if-lez v9, :cond_c

    .line 879
    const v9, 0x3e17e9d8

    mul-float/2addr v9, v5

    .line 880
    float-to-double v12, v9

    invoke-static {v12, v13}, Ljava/lang/Math;->cos(D)D

    move-result-wide v14

    double-to-float v9, v14

    .line 881
    invoke-static {v12, v13}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    double-to-float v12, v12

    .line 882
    if-ne v2, v10, :cond_b

    const v13, 0x3db851ec    # 0.09f

    goto :goto_2

    :cond_b
    move/from16 v13, p3

    :goto_2
    mul-float/2addr v13, v5

    add-float v13, v13, v16

    .line 883
    mul-float v5, v7, v9

    mul-float v14, v1, v12

    sub-float/2addr v5, v14

    mul-float/2addr v5, v13

    .line 884
    mul-float/2addr v7, v12

    mul-float/2addr v1, v9

    add-float/2addr v7, v1

    mul-float v1, v7, v13

    .line 885
    nop

    .line 886
    move v7, v5

    .line 890
    :cond_c
    const/high16 v5, 0x42280000    # 42.0f

    const/high16 v9, 0x41c00000    # 24.0f

    invoke-static {v3, v5, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v3

    .line 891
    const v5, 0x3e3851ec    # 0.18f

    const v9, 0x3e99999a    # 0.3f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    mul-float/2addr v3, v5

    .line 892
    const v5, 0x3f570a3d    # 0.84f

    const v9, 0x3f70a3d7    # 0.94f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 893
    const v5, 0x3de147ae    # 0.11f

    const v9, 0x3e6147ae    # 0.22f

    invoke-static {v5, v9, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 895
    const v5, 0x3b83126f    # 0.004f

    if-ne v2, v10, :cond_d

    .line 897
    sub-float v2, v6, v0

    const v4, 0x3ef5c28f    # 0.48f

    mul-float/2addr v4, v3

    mul-float/2addr v2, v4

    add-float/2addr v0, v2

    .line 898
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 899
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 900
    :cond_d
    const/4 v9, 0x3

    if-ne v2, v9, :cond_e

    .line 902
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

    .line 903
    const v4, 0x3c75c28f    # 0.015f

    const v5, 0x3d23d70a    # 0.04f

    invoke-static {v4, v5, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    mul-float/2addr v4, v3

    .line 904
    const v5, 0x3c0b4396    # 0.0085f

    mul-float/2addr v5, v4

    const v8, 0x3b23d70a    # 0.0025f

    mul-float/2addr v8, v2

    add-float/2addr v5, v8

    add-float/2addr v7, v5

    .line 905
    const v5, 0x3c978d50    # 0.0185f

    mul-float/2addr v4, v5

    const v5, 0x3c03126f    # 0.008f

    mul-float/2addr v2, v5

    add-float/2addr v4, v2

    add-float/2addr v1, v4

    .line 906
    mul-float/2addr v3, v5

    add-float/2addr v0, v3

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 907
    goto :goto_3

    .line 909
    :cond_e
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 910
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 855
    :cond_f
    move/from16 p4, v3

    move/from16 p3, v15

    .line 915
    :goto_3
    cmpl-float v2, v0, v6

    if-lez v2, :cond_10

    cmpl-float v2, v6, p3

    if-lez v2, :cond_10

    const v2, 0x3f3851ec    # 0.72f

    cmpl-float v3, v0, v2

    if-lez v3, :cond_10

    .line 916
    const v3, 0x3f7ae148    # 0.98f

    invoke-static {v2, v3, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    const v3, 0x3e19999a    # 0.15f

    mul-float/2addr v2, v3

    const/high16 v16, 0x3f800000    # 1.0f

    sub-float v4, v16, v2

    .line 917
    mul-float/2addr v7, v4

    .line 918
    mul-float/2addr v1, v4

    .line 922
    :cond_10
    const v2, 0x3ecaecc9

    mul-float/2addr v2, v7

    add-float/2addr v2, v0

    const v3, 0x3e5cfba9

    mul-float/2addr v3, v1

    add-float/2addr v2, v3

    .line 923
    const v3, 0x3dd8308c

    mul-float/2addr v3, v7

    sub-float v3, v0, v3

    const v4, 0x3d82c5fa

    mul-float/2addr v4, v1

    sub-float/2addr v3, v4

    .line 924
    const v4, 0x3db7437b

    mul-float/2addr v7, v4

    sub-float v4, v0, v7

    const v5, 0x3fa54f66

    mul-float/2addr v1, v5

    sub-float/2addr v4, v1

    .line 926
    mul-float v1, v2, v2

    mul-float/2addr v1, v2

    .line 927
    mul-float v2, v3, v3

    mul-float/2addr v2, v3

    .line 928
    mul-float v3, v4, v4

    mul-float/2addr v3, v4

    .line 930
    const v4, 0x408274ab

    mul-float/2addr v4, v1

    const v5, 0x4053b18c

    mul-float/2addr v5, v2

    sub-float/2addr v4, v5

    const v5, 0x3e6c8362

    mul-float/2addr v5, v3

    add-float/2addr v4, v5

    .line 931
    const v5, -0x405da3d3

    mul-float/2addr v5, v1

    const v6, 0x40270644

    mul-float/2addr v6, v2

    add-float/2addr v5, v6

    const v6, 0x3eaec16a

    mul-float/2addr v6, v3

    sub-float/2addr v5, v6

    .line 932
    const v6, -0x447680ad

    mul-float/2addr v1, v6

    const v6, 0x3f34133e

    mul-float/2addr v2, v6

    sub-float/2addr v1, v2

    const v2, 0x3fda931e

    mul-float/2addr v3, v2

    add-float/2addr v1, v3

    .line 935
    invoke-static {v5, v1}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-static {v4, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    .line 936
    invoke-static {v5, v1}, Ljava/lang/Math;->min(FF)F

    move-result v3

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    .line 937
    cmpg-float v6, v3, p4

    if-ltz v6, :cond_11

    const/high16 v16, 0x3f800000    # 1.0f

    cmpl-float v7, v2, v16

    if-lez v7, :cond_14

    .line 938
    :cond_11
    mul-float v7, v0, v0

    mul-float/2addr v7, v0

    .line 939
    nop

    .line 940
    if-gez v6, :cond_12

    cmpl-float v0, v7, v3

    if-lez v0, :cond_12

    .line 941
    sub-float v0, v7, v3

    div-float v0, v7, v0

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    goto :goto_4

    .line 940
    :cond_12
    const/high16 v3, 0x3f800000    # 1.0f

    .line 943
    move v0, v3

    :goto_4
    cmpl-float v6, v2, v3

    if-lez v6, :cond_13

    cmpl-float v6, v2, v7

    if-lez v6, :cond_13

    .line 944
    sub-float/2addr v3, v7

    sub-float/2addr v2, v7

    div-float/2addr v3, v2

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 946
    :cond_13
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 947
    sub-float/2addr v4, v7

    mul-float/2addr v4, v0

    add-float/2addr v4, v7

    .line 948
    sub-float/2addr v5, v7

    mul-float/2addr v5, v0

    add-float/2addr v5, v7

    .line 949
    sub-float/2addr v1, v7

    mul-float/2addr v1, v0

    add-float/2addr v1, v7

    .line 952
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

    .line 1252
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

    .line 957
    const v0, 0x38d1b717    # 1.0E-4f

    cmpg-float p1, p1, v0

    const/high16 v1, 0x3f800000    # 1.0f

    if-gtz p1, :cond_0

    .line 958
    return v1

    .line 960
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

    .line 961
    nop

    .line 962
    const/4 v2, 0x2

    const v3, 0x3da3d70a    # 0.08f

    const v4, 0x3d4ccccd    # 0.05f

    if-ne p2, v2, :cond_1

    .line 964
    const p2, 0x3ed70a3d    # 0.42f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3c23d70a    # 0.01f

    invoke-static {v2, v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 965
    const v2, 0x3df5c28f    # 0.12f

    mul-float/2addr p2, v2

    sub-float p2, v1, p2

    mul-float/2addr p2, p0

    .line 966
    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    if-ne p2, v2, :cond_2

    .line 967
    const/high16 p2, 0x3e800000    # 0.25f

    invoke-static {v4, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3ba3d70a    # 0.005f

    const v3, 0x3cf5c28f    # 0.03f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 968
    mul-float/2addr p2, v4

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    .line 969
    goto :goto_0

    :cond_2
    const/4 v2, 0x3

    if-ne p2, v2, :cond_3

    .line 970
    const p2, 0x3eb33333    # 0.35f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    const v2, 0x3ee66666    # 0.45f

    const v3, 0x3f47ae14    # 0.78f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    sub-float v2, v1, v2

    mul-float/2addr p2, v2

    .line 971
    const v2, 0x3d23d70a    # 0.04f

    mul-float/2addr p2, v2

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    goto :goto_0

    .line 969
    :cond_3
    move p2, p0

    .line 973
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

    .line 974
    const p0, 0x3f51eb85    # 0.82f

    const p1, 0x3f947ae1    # 1.16f

    invoke-static {p2, p0, p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p0

    return p0
.end method

.method public static parseCubeLut(Ljava/lang/String;[I)[F
    .locals 19

    .line 1064
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-eqz v0, :cond_1d

    .line 1067
    nop

    .line 1068
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const v5, 0xfeff

    if-ne v2, v5, :cond_0

    .line 1069
    const/4 v2, 0x1

    goto :goto_0

    .line 1071
    :cond_0
    move v2, v3

    :goto_0
    nop

    .line 1072
    nop

    .line 1073
    nop

    .line 1074
    nop

    .line 1075
    nop

    .line 1076
    nop

    .line 1077
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, -0x1

    const/4 v7, 0x0

    move v10, v3

    move-object v8, v7

    move-object v9, v8

    .line 1078
    :goto_1
    const/4 v11, 0x2

    if-gt v2, v5, :cond_18

    .line 1079
    move v13, v2

    .line 1080
    :goto_2
    const/16 v14, 0xd

    const/16 v15, 0xa

    if-ge v13, v5, :cond_2

    .line 1081
    const/16 v16, 0x1

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 1082
    if-eq v4, v15, :cond_3

    if-ne v4, v14, :cond_1

    .line 1083
    goto :goto_3

    .line 1085
    :cond_1
    add-int/lit8 v13, v13, 0x1

    .line 1086
    goto :goto_2

    .line 1080
    :cond_2
    const/16 v16, 0x1

    .line 1087
    :cond_3
    :goto_3
    nop

    .line 1088
    :goto_4
    if-ge v2, v13, :cond_4

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1089
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 1091
    :cond_4
    move v4, v13

    .line 1092
    :goto_5
    if-le v4, v2, :cond_5

    add-int/lit8 v15, v4, -0x1

    invoke-virtual {v0, v15}, Ljava/lang/String;->charAt(I)C

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v15

    if-eqz v15, :cond_5

    .line 1093
    add-int/lit8 v4, v4, -0x1

    const/16 v15, 0xa

    goto :goto_5

    .line 1095
    :cond_5
    if-ge v2, v4, :cond_15

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v15

    const/16 v14, 0x23

    if-eq v15, v14, :cond_15

    .line 1096
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->countWords(Ljava/lang/String;II)I

    move-result v14

    .line 1097
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v15

    .line 1098
    const-string v3, "TITLE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_14

    .line 1099
    const-string v3, "LUT_IN_VIDEO_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    move/from16 v12, v16

    goto/16 :goto_8

    .line 1101
    :cond_6
    const-string v3, "DOMAIN_MIN"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_11

    .line 1102
    const-string v12, "DOMAIN_MAX"

    invoke-static {v0, v2, v15, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_7

    goto/16 :goto_6

    .line 1112
    :cond_7
    const-string v3, "LUT_1D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 1113
    const-string v3, "LUT_1D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 1115
    const-string v3, "LUT_3D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 1116
    if-ne v14, v11, :cond_9

    if-nez v9, :cond_9

    .line 1119
    invoke-static {v0, v15, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->word(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseSize(Ljava/lang/String;)I

    move-result v2

    .line 1120
    int-to-long v3, v2

    mul-long v14, v3, v3

    mul-long/2addr v14, v3

    const-wide/16 v3, 0x3

    mul-long/2addr v14, v3

    .line 1121
    const-wide/32 v3, 0x7fffffff

    cmp-long v3, v14, v3

    if-gtz v3, :cond_8

    .line 1124
    long-to-int v3, v14

    new-array v3, v3, [F

    .line 1125
    move v6, v2

    move-object v9, v3

    move/from16 v12, v16

    goto/16 :goto_8

    .line 1122
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1117
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE must appear once before samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1125
    :cond_a
    const-string v3, "LUT_3D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 1126
    const/4 v3, 0x3

    if-ne v14, v3, :cond_b

    move/from16 v12, v16

    goto/16 :goto_8

    .line 1127
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_INPUT_RANGE needs two finite bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1130
    :cond_c
    const/4 v3, 0x3

    if-eqz v9, :cond_f

    .line 1133
    if-ne v14, v3, :cond_e

    .line 1136
    add-int/lit8 v3, v10, 0x3

    array-length v12, v9

    if-gt v3, v12, :cond_d

    .line 1139
    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v2

    .line 1140
    add-int/lit8 v4, v10, 0x1

    aget v12, v2, v3

    aput v12, v9, v10

    .line 1141
    add-int/lit8 v3, v4, 0x1

    aget v10, v2, v16

    aput v10, v9, v4

    .line 1142
    add-int/lit8 v4, v3, 0x1

    aget v2, v2, v11

    aput v2, v9, v3

    move v10, v4

    move/from16 v12, v16

    goto :goto_8

    .line 1137
    :cond_d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "too many RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1134
    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "RGB sample must contain 3 values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1131
    :cond_f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "sample appears before LUT_3D_SIZE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1114
    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1D cube is not a 3D LUT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1103
    :cond_11
    :goto_6
    const/4 v12, 0x4

    if-ne v14, v12, :cond_13

    .line 1106
    move/from16 v12, v16

    invoke-static {v0, v2, v4, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v4

    .line 1107
    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 1108
    move-object v7, v4

    goto :goto_7

    .line 1110
    :cond_12
    move-object v8, v4

    .line 1112
    :goto_7
    goto :goto_8

    .line 1104
    :cond_13
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN line needs 3 finite components"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1098
    :cond_14
    move/from16 v12, v16

    goto :goto_8

    .line 1095
    :cond_15
    move/from16 v12, v16

    .line 1145
    :goto_8
    if-lt v13, v5, :cond_16

    .line 1146
    goto :goto_9

    .line 1148
    :cond_16
    add-int/lit8 v2, v13, 0x1

    .line 1149
    if-ge v13, v5, :cond_17

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xd

    if-ne v3, v4, :cond_17

    if-ge v2, v5, :cond_17

    .line 1150
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_17

    .line 1151
    add-int/lit8 v2, v2, 0x1

    .line 1153
    :cond_17
    const/4 v3, 0x0

    goto/16 :goto_1

    .line 1154
    :cond_18
    :goto_9
    if-lt v6, v11, :cond_1c

    if-eqz v9, :cond_1c

    array-length v0, v9

    if-ne v10, v0, :cond_1c

    .line 1157
    if-eqz v7, :cond_1a

    if-eqz v8, :cond_1a

    .line 1158
    const/4 v3, 0x0

    :goto_a
    const/4 v0, 0x3

    if-ge v3, v0, :cond_1a

    .line 1159
    aget v2, v7, v3

    aget v4, v8, v3

    cmpg-float v2, v2, v4

    if-gez v2, :cond_19

    .line 1158
    add-int/lit8 v3, v3, 0x1

    goto :goto_a

    .line 1160
    :cond_19
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN_MIN must be below DOMAIN_MAX"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1164
    :cond_1a
    if-eqz v1, :cond_1b

    array-length v0, v1

    if-lez v0, :cond_1b

    .line 1165
    const/16 v17, 0x0

    aput v6, v1, v17

    .line 1167
    :cond_1b
    return-object v9

    .line 1155
    :cond_1c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube is missing LUT_3D_SIZE or the N^3 RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1065
    :cond_1d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube text is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static parseFinite(Ljava/lang/String;)F
    .locals 1

    .line 1206
    :try_start_0
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1209
    nop

    .line 1210
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1213
    return p0

    .line 1211
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not finite"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1207
    :catch_0
    move-exception p0

    .line 1208
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not a number"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static parseSize(Ljava/lang/String;)I
    .locals 4

    .line 1171
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

    .line 1176
    :try_start_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1179
    nop

    .line 1180
    const/4 v0, 0x2

    if-lt p0, v0, :cond_0

    const/16 v0, 0x40

    if-gt p0, v0, :cond_0

    .line 1183
    return p0

    .line 1181
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1177
    :catch_0
    move-exception p0

    .line 1178
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 1172
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static readTriple(Ljava/lang/String;IIZ)[F
    .locals 3

    .line 1187
    nop

    .line 1188
    if-eqz p3, :cond_0

    .line 1189
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    .line 1191
    :cond_0
    const/4 p3, 0x3

    new-array v0, p3, [F

    .line 1192
    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_2

    .line 1193
    :goto_1
    if-ge p1, p2, :cond_1

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1194
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 1196
    :cond_1
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v2

    .line 1197
    invoke-virtual {p0, p1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseFinite(Ljava/lang/String;)F

    move-result p1

    aput p1, v0, v1

    .line 1198
    nop

    .line 1192
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 1200
    :cond_2
    return-object v0
.end method

.method private static sampleBilinearY([FIIFF)F
    .locals 4

    .line 750
    int-to-float v0, p1

    const v1, 0x3f800347    # 1.0001f

    sub-float/2addr v0, v1

    const/4 v2, 0x0

    invoke-static {p3, v2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p3

    .line 751
    int-to-float v0, p2

    sub-float/2addr v0, v1

    invoke-static {p4, v2, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p4

    .line 752
    float-to-int v0, p3

    .line 753
    float-to-int v1, p4

    .line 754
    add-int/lit8 v2, v0, 0x1

    add-int/lit8 v3, p1, -0x1

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 755
    add-int/lit8 v3, v1, 0x1

    add-int/lit8 p2, p2, -0x1

    invoke-static {v3, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    .line 756
    int-to-float v3, v0

    sub-float/2addr p3, v3

    .line 757
    int-to-float v3, v1

    sub-float/2addr p4, v3

    .line 758
    mul-int/2addr v1, p1

    add-int v3, v1, v0

    aget v3, p0, v3

    .line 759
    add-int/2addr v1, v2

    aget v1, p0, v1

    .line 760
    mul-int/2addr p2, p1

    add-int/2addr v0, p2

    aget p1, p0, v0

    .line 761
    add-int/2addr p2, v2

    aget p0, p0, p2

    .line 762
    sub-float/2addr v1, v3

    mul-float/2addr v1, p3

    add-float/2addr v3, v1

    .line 763
    sub-float/2addr p0, p1

    mul-float/2addr p0, p3

    add-float/2addr p1, p0

    .line 764
    sub-float/2addr p1, v3

    mul-float/2addr p1, p4

    add-float/2addr v3, p1

    return v3
.end method

.method private static smoothstep(FFF)F
    .locals 0

    .line 1027
    sub-float/2addr p2, p0

    sub-float/2addr p1, p0

    div-float/2addr p2, p1

    invoke-static {p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    .line 1028
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

    .line 1044
    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gtz v0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 1045
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_1

    const/16 p0, 0xff

    return p0

    .line 1046
    :cond_1
    const/high16 v0, 0x45800000    # 4096.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p0, v0

    float-to-int p0, p0

    .line 1047
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

    .line 1217
    nop

    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1218
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 1220
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static wordEnd(Ljava/lang/String;II)I
    .locals 1

    .line 1240
    nop

    .line 1241
    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1242
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 1244
    :cond_0
    return p1
.end method
