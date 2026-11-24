.class final Lcom/motorola/camera/custom/BokehKernel;
.super Ljava/lang/Object;
.source "BokehKernel.java"


# static fields
.field static final TAPS:I = 0x20


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static aperture(I)[F
    .locals 18

    .line 11
    move/from16 v0, p0

    const/16 v1, 0x60

    new-array v1, v1, [F

    .line 12
    const/4 v2, 0x5

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x3

    if-ne v0, v2, :cond_0

    move v2, v5

    goto :goto_0

    :cond_0
    if-ne v0, v4, :cond_1

    const/4 v2, 0x7

    goto :goto_0

    :cond_1
    move v2, v3

    .line 13
    :goto_0
    nop

    :goto_1
    const/16 v6, 0x20

    if-ge v3, v6, :cond_6

    .line 14
    int-to-double v6, v3

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    mul-double/2addr v8, v6

    const-wide/high16 v10, 0x4014000000000000L    # 5.0

    invoke-static {v10, v11}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v10

    const-wide/high16 v12, 0x4008000000000000L    # 3.0

    sub-double/2addr v12, v10

    mul-double/2addr v8, v12

    .line 15
    const-wide/high16 v10, 0x3fe0000000000000L    # 0.5

    add-double/2addr v6, v10

    const-wide/high16 v12, 0x4040000000000000L    # 32.0

    div-double/2addr v6, v12

    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v6

    .line 16
    if-lez v2, :cond_2

    .line 17
    const-wide v12, 0x401921fb54442d18L    # 6.283185307179586

    int-to-double v14, v2

    div-double/2addr v12, v14

    .line 18
    const-wide/high16 v14, 0x4000000000000000L    # 2.0

    div-double v14, v12, v14

    invoke-static {v14, v15}, Ljava/lang/Math;->cos(D)D

    move-result-wide v16

    rem-double v12, v8, v12

    sub-double/2addr v12, v14

    invoke-static {v12, v13}, Ljava/lang/Math;->cos(D)D

    move-result-wide v12

    div-double v16, v16, v12

    mul-double v6, v6, v16

    .line 20
    :cond_2
    mul-int/lit8 v12, v3, 0x3

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v13

    mul-double/2addr v13, v6

    const/4 v15, 0x4

    if-ne v0, v15, :cond_3

    goto :goto_2

    :cond_3
    const-wide/high16 v10, 0x3ff0000000000000L    # 1.0

    :goto_2
    mul-double/2addr v13, v10

    double-to-float v10, v13

    aput v10, v1, v12

    .line 21
    add-int/lit8 v10, v12, 0x1

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    mul-double/2addr v8, v6

    double-to-float v8, v8

    aput v8, v1, v10

    .line 22
    add-int/2addr v12, v4

    const/4 v8, 0x1

    if-ne v0, v8, :cond_4

    const-wide v8, 0x3fe6666666666666L    # 0.7

    mul-double v10, v6, v8

    mul-double/2addr v10, v6

    add-double/2addr v10, v8

    double-to-float v6, v10

    goto :goto_3

    .line 23
    :cond_4
    if-ne v0, v5, :cond_5

    const-wide/high16 v8, -0x3ff8000000000000L    # -3.0

    mul-double/2addr v8, v6

    mul-double/2addr v8, v6

    invoke-static {v8, v9}, Ljava/lang/Math;->exp(D)D

    move-result-wide v6

    double-to-float v6, v6

    goto :goto_3

    :cond_5
    const/high16 v6, 0x3f800000    # 1.0f

    :goto_3
    aput v6, v1, v12

    .line 13
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 25
    :cond_6
    return-object v1
.end method

.method private static clamp(II)I
    .locals 1

    .line 109
    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    invoke-static {p1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    return p0
.end method

.method static coc(II)F
    .locals 1

    .line 29
    sub-int/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(I)I

    move-result p0

    int-to-float p0, p0

    const/high16 p1, 0x41100000    # 9.0f

    sub-float/2addr p0, p1

    const/high16 p1, 0x42820000    # 65.0f

    div-float/2addr p0, p1

    const/4 p1, 0x0

    invoke-static {p1, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    const/high16 p1, 0x3f800000    # 1.0f

    invoke-static {p1, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    .line 30
    mul-float p1, p0, p0

    const/high16 v0, 0x40000000    # 2.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x40400000    # 3.0f

    sub-float/2addr v0, p0

    mul-float/2addr p1, v0

    return p1
.end method

.method static gather([I[BIIII)[I
    .locals 33

    .line 34
    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    move/from16 v3, p4

    move/from16 v4, p5

    invoke-static {v4}, Lcom/motorola/camera/custom/BokehKernel;->aperture(I)[F

    move-result-object v5

    .line 35
    array-length v6, v0

    new-array v6, v6, [I

    .line 36
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->min(II)I

    move-result v7

    int-to-float v7, v7

    const v8, 0x3cdd2f1b    # 0.027f

    mul-float/2addr v7, v8

    const/high16 v8, 0x40000000    # 2.0f

    invoke-static {v8, v7}, Ljava/lang/Math;->max(FF)F

    move-result v7

    .line 37
    const/4 v9, 0x0

    :goto_0
    if-ge v9, v2, :cond_11

    .line 38
    const/4 v10, 0x0

    :goto_1
    if-ge v10, v1, :cond_10

    .line 39
    mul-int v11, v9, v1

    add-int v12, v11, v10

    .line 40
    aget-byte v13, p1, v12

    const/16 v14, 0xff

    and-int/2addr v13, v14

    .line 41
    invoke-static {v13, v3}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result v15

    .line 42
    const v16, 0x3d75c28f    # 0.06f

    cmpg-float v16, v15, v16

    if-gez v16, :cond_0

    .line 43
    aget v11, v0, v12

    aput v11, v6, v12

    .line 44
    goto/16 :goto_d

    .line 46
    :cond_0
    int-to-float v8, v10

    const/high16 v17, 0x3f000000    # 0.5f

    add-float v18, v8, v17

    int-to-float v14, v1

    div-float v18, v18, v14

    sub-float v18, v18, v17

    .line 47
    int-to-float v14, v9

    add-float v19, v14, v17

    int-to-float v0, v2

    div-float v19, v19, v0

    sub-float v19, v19, v17

    .line 48
    mul-float v0, v18, v18

    mul-float v17, v19, v19

    add-float v0, v0, v17

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    .line 49
    const/4 v1, 0x0

    cmpl-float v17, v0, v1

    if-lez v17, :cond_1

    div-float v18, v18, v0

    goto :goto_2

    :cond_1
    move/from16 v18, v1

    .line 50
    :goto_2
    if-lez v17, :cond_2

    div-float v19, v19, v0

    goto :goto_3

    :cond_2
    move/from16 v19, v1

    .line 51
    :goto_3
    const v17, 0x3fd9999a    # 1.7f

    const/high16 v20, 0x3f800000    # 1.0f

    move/from16 v21, v1

    const/4 v1, 0x1

    if-ne v4, v1, :cond_3

    mul-float v22, v0, v17

    mul-float v1, v22, v15

    move/from16 v22, v0

    float-to-double v0, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_4

    :cond_3
    move/from16 v22, v0

    move/from16 v0, v20

    .line 52
    :goto_4
    const/4 v1, 0x1

    if-ne v4, v1, :cond_4

    mul-float v1, v22, v17

    mul-float/2addr v1, v15

    move/from16 v17, v0

    float-to-double v0, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_5

    :cond_4
    move/from16 v17, v0

    move/from16 v0, v21

    .line 53
    :goto_5
    nop

    .line 54
    move/from16 v24, v21

    move/from16 v25, v24

    move/from16 v26, v25

    move/from16 v27, v26

    const/4 v1, 0x0

    :goto_6
    move/from16 v28, v0

    array-length v0, v5

    const v29, 0x3ec28f5c    # 0.38f

    if-ge v1, v0, :cond_8

    .line 55
    aget v0, v5, v1

    mul-float v0, v0, v17

    add-int/lit8 v30, v1, 0x1

    aget v31, v5, v30

    mul-float v31, v31, v28

    sub-float v0, v0, v31

    .line 56
    aget v31, v5, v1

    mul-float v31, v31, v28

    aget v30, v5, v30

    mul-float v30, v30, v17

    add-float v31, v31, v30

    .line 57
    const/4 v2, 0x1

    if-ne v4, v2, :cond_5

    .line 58
    mul-float v2, v18, v0

    mul-float v32, v19, v31

    add-float v2, v2, v32

    mul-float v2, v2, v22

    const v32, 0x3f4ccccd    # 0.8f

    mul-float v2, v2, v32

    .line 59
    mul-float v32, v2, v18

    sub-float v0, v0, v32

    .line 60
    mul-float v2, v2, v19

    sub-float v31, v31, v2

    .line 62
    :cond_5
    mul-float/2addr v0, v7

    mul-float/2addr v0, v15

    add-float/2addr v0, v8

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/lit8 v2, p2, -0x1

    invoke-static {v0, v2}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 63
    mul-float v31, v31, v7

    mul-float v31, v31, v15

    add-float v31, v14, v31

    invoke-static/range {v31 .. v31}, Ljava/lang/Math;->round(F)I

    move-result v2

    move/from16 v31, v0

    add-int/lit8 v0, p3, -0x1

    invoke-static {v2, v0}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 64
    mul-int v0, v0, p2

    add-int v0, v0, v31

    .line 65
    aget-byte v2, p1, v0

    move/from16 v31, v0

    const/16 v0, 0xff

    and-int/2addr v2, v0

    .line 66
    sub-int v0, v13, v2

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    move/from16 v32, v1

    const/16 v1, 0x22

    if-gt v0, v1, :cond_7

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result v0

    mul-float v29, v29, v15

    cmpg-float v0, v0, v29

    if-gez v0, :cond_6

    goto :goto_7

    .line 67
    :cond_6
    aget v0, p0, v31

    .line 68
    add-int/lit8 v1, v32, 0x2

    aget v1, v5, v1

    .line 69
    ushr-int/lit8 v2, v0, 0x10

    move/from16 v29, v1

    const/16 v1, 0xff

    and-int/2addr v2, v1

    int-to-float v2, v2

    mul-float v2, v2, v29

    add-float v25, v25, v2

    .line 70
    ushr-int/lit8 v2, v0, 0x8

    and-int/2addr v2, v1

    int-to-float v2, v2

    mul-float v2, v2, v29

    add-float v26, v26, v2

    .line 71
    and-int/2addr v0, v1

    int-to-float v0, v0

    mul-float v0, v0, v29

    add-float v27, v27, v0

    .line 72
    add-float v24, v24, v29

    .line 54
    :cond_7
    :goto_7
    add-int/lit8 v1, v32, 0x3

    move/from16 v2, p3

    move/from16 v0, v28

    goto/16 :goto_6

    .line 74
    :cond_8
    cmpg-float v0, v24, v21

    if-gtz v0, :cond_9

    aget v1, p0, v12

    ushr-int/lit8 v1, v1, 0x10

    const/16 v2, 0xff

    and-int/2addr v1, v2

    int-to-float v1, v1

    goto :goto_8

    :cond_9
    div-float v1, v25, v24

    .line 75
    :goto_8
    if-gtz v0, :cond_a

    aget v2, p0, v12

    ushr-int/lit8 v2, v2, 0x8

    const/16 v8, 0xff

    and-int/2addr v2, v8

    int-to-float v2, v2

    goto :goto_9

    :cond_a
    const/16 v8, 0xff

    div-float v2, v26, v24

    .line 76
    :goto_9
    if-gtz v0, :cond_b

    aget v0, p0, v12

    and-int/2addr v0, v8

    int-to-float v0, v0

    goto :goto_a

    :cond_b
    div-float v0, v27, v24

    .line 77
    :goto_a
    const/4 v8, 0x4

    if-ne v4, v8, :cond_e

    .line 78
    mul-float v8, v7, v15

    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v8

    const/4 v14, 0x1

    invoke-static {v14, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    .line 79
    nop

    .line 80
    nop

    .line 81
    const/16 v17, -0x1

    move/from16 v18, v0

    move/from16 v0, v17

    move/from16 v19, v21

    move/from16 v22, v19

    move/from16 v23, v22

    move/from16 v17, v1

    const/4 v1, 0x0

    :goto_b
    if-gt v0, v14, :cond_d

    .line 82
    mul-int v24, v0, v8

    add-int v14, v10, v24

    move/from16 v24, v0

    add-int/lit8 v0, p2, -0x1

    invoke-static {v14, v0}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 83
    add-int/2addr v0, v11

    .line 84
    aget-byte v14, p1, v0

    move/from16 v26, v0

    const/16 v0, 0xff

    and-int/2addr v14, v0

    .line 85
    sub-int v0, v13, v14

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    move/from16 v27, v2

    const/16 v2, 0x22

    if-gt v0, v2, :cond_c

    invoke-static {v14, v3}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result v0

    mul-float v14, v15, v29

    cmpl-float v0, v0, v14

    if-ltz v0, :cond_c

    .line 86
    aget v0, p0, v26

    .line 87
    ushr-int/lit8 v14, v0, 0x10

    const/16 v2, 0xff

    and-int/2addr v14, v2

    int-to-float v14, v14

    add-float v19, v19, v14

    .line 88
    ushr-int/lit8 v14, v0, 0x8

    and-int/2addr v14, v2

    int-to-float v14, v14

    add-float v22, v22, v14

    .line 89
    and-int/2addr v0, v2

    int-to-float v0, v0

    add-float v23, v23, v0

    .line 90
    add-int/lit8 v1, v1, 0x1

    .line 81
    :cond_c
    add-int/lit8 v0, v24, 0x2

    move/from16 v2, v27

    const/4 v14, 0x1

    goto :goto_b

    .line 93
    :cond_d
    move/from16 v27, v2

    if-lez v1, :cond_f

    .line 94
    int-to-float v0, v1

    div-float v1, v19, v0

    div-float v2, v22, v0

    div-float v0, v23, v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const/high16 v1, 0x437f0000    # 255.0f

    div-float/2addr v0, v1

    .line 95
    const v2, 0x3dcccccd    # 0.1f

    mul-float/2addr v15, v2

    const v2, 0x3f59999a    # 0.85f

    sub-float/2addr v0, v2

    move/from16 v2, v21

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    mul-float/2addr v15, v0

    mul-float/2addr v15, v1

    .line 96
    const v0, 0x3f19999a    # 0.6f

    mul-float/2addr v0, v15

    add-float v1, v17, v0

    .line 97
    const v0, 0x3f666666    # 0.9f

    mul-float/2addr v0, v15

    add-float v2, v27, v0

    .line 98
    mul-float v15, v15, v20

    add-float v0, v18, v15

    goto :goto_c

    .line 77
    :cond_e
    move/from16 v18, v0

    move/from16 v17, v1

    move/from16 v27, v2

    .line 101
    :cond_f
    move/from16 v1, v17

    move/from16 v0, v18

    move/from16 v2, v27

    :goto_c
    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    const/16 v8, 0xff

    invoke-static {v1, v8}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v1

    shl-int/lit8 v1, v1, 0x10

    const/high16 v11, -0x1000000

    or-int/2addr v1, v11

    .line 102
    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    invoke-static {v2, v8}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v2

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v1, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v0, v8}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    or-int/2addr v0, v1

    aput v0, v6, v12

    .line 38
    :goto_d
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    goto/16 :goto_1

    .line 37
    :cond_10
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    goto/16 :goto_0

    .line 105
    :cond_11
    return-object v6
.end method
