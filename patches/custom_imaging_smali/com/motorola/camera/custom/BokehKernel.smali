.class final Lcom/motorola/camera/custom/BokehKernel;
.super Ljava/lang/Object;
.source "BokehKernel.java"


# static fields
.field private static final LINEAR:[F

.field private static final SRGB:[I

.field static final TAPS:I = 0x20


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 7
    const/16 v0, 0x100

    new-array v0, v0, [F

    sput-object v0, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    .line 8
    const/16 v0, 0x1001

    new-array v0, v0, [I

    sput-object v0, Lcom/motorola/camera/custom/BokehKernel;->SRGB:[I

    .line 11
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    sget-object v2, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    array-length v2, v2

    const-wide v3, 0x4029d70a3d70a3d7L    # 12.92

    const-wide v5, 0x3ff0e147ae147ae1L    # 1.055

    const-wide v7, 0x3fac28f5c28f5c29L    # 0.055

    const-wide v9, 0x406fe00000000000L    # 255.0

    if-ge v1, v2, :cond_1

    .line 12
    int-to-double v11, v1

    div-double/2addr v11, v9

    .line 13
    sget-object v2, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    const-wide v9, 0x3fa4b5dcc63f1412L    # 0.04045

    cmpg-double v9, v11, v9

    if-gtz v9, :cond_0

    div-double/2addr v11, v3

    goto :goto_1

    :cond_0
    add-double/2addr v11, v7

    div-double/2addr v11, v5

    const-wide v3, 0x4003333333333333L    # 2.4

    invoke-static {v11, v12, v3, v4}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v11

    :goto_1
    double-to-float v3, v11

    aput v3, v2, v1

    .line 11
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 15
    :cond_1
    nop

    :goto_2
    sget-object v1, Lcom/motorola/camera/custom/BokehKernel;->SRGB:[I

    array-length v1, v1

    if-ge v0, v1, :cond_3

    .line 16
    int-to-double v1, v0

    const-wide/high16 v11, 0x40b0000000000000L    # 4096.0

    div-double/2addr v1, v11

    .line 17
    sget-object v11, Lcom/motorola/camera/custom/BokehKernel;->SRGB:[I

    const-wide v12, 0x3f69a5c37387b719L    # 0.0031308

    cmpg-double v12, v1, v12

    if-gtz v12, :cond_2

    mul-double/2addr v1, v3

    goto :goto_3

    :cond_2
    const-wide v12, 0x3fdaaaaaaaaaaaabL    # 0.4166666666666667

    invoke-static {v1, v2, v12, v13}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v1

    mul-double/2addr v1, v5

    sub-double/2addr v1, v7

    :goto_3
    mul-double/2addr v1, v9

    invoke-static {v1, v2}, Ljava/lang/Math;->round(D)J

    move-result-wide v1

    long-to-int v1, v1

    aput v1, v11, v0

    .line 15
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 19
    :cond_3
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static aperture(I)[F
    .locals 18

    .line 24
    move/from16 v0, p0

    const/16 v1, 0x60

    new-array v1, v1, [F

    .line 25
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

    .line 26
    :goto_0
    nop

    :goto_1
    const/16 v6, 0x20

    if-ge v3, v6, :cond_6

    .line 27
    int-to-double v6, v3

    const-wide v8, 0x400921fb54442d18L    # Math.PI

    mul-double/2addr v8, v6

    const-wide/high16 v10, 0x4014000000000000L    # 5.0

    invoke-static {v10, v11}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v10

    const-wide/high16 v12, 0x4008000000000000L    # 3.0

    sub-double/2addr v12, v10

    mul-double/2addr v8, v12

    .line 28
    const-wide/high16 v10, 0x3fe0000000000000L    # 0.5

    add-double/2addr v6, v10

    const-wide/high16 v12, 0x4040000000000000L    # 32.0

    div-double/2addr v6, v12

    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v6

    .line 29
    if-lez v2, :cond_2

    .line 30
    const-wide v12, 0x401921fb54442d18L    # 6.283185307179586

    int-to-double v14, v2

    div-double/2addr v12, v14

    .line 31
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

    .line 33
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

    .line 34
    add-int/lit8 v10, v12, 0x1

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    mul-double/2addr v8, v6

    double-to-float v8, v8

    aput v8, v1, v10

    .line 35
    add-int/2addr v12, v4

    const/4 v8, 0x1

    if-ne v0, v8, :cond_4

    const-wide v8, 0x3fe6666666666666L    # 0.7

    mul-double v10, v6, v8

    mul-double/2addr v10, v6

    add-double/2addr v10, v8

    double-to-float v6, v10

    goto :goto_3

    .line 36
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

    .line 26
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 38
    :cond_6
    return-object v1
.end method

.method private static clamp(II)I
    .locals 1

    .line 159
    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    invoke-static {p1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    return p0
.end method

.method static coc(II)F
    .locals 2

    .line 42
    sub-int/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(I)I

    move-result p0

    int-to-float p0, p0

    const/high16 p1, 0x40400000    # 3.0f

    sub-float/2addr p0, p1

    const/high16 v0, 0x42880000    # 68.0f

    div-float/2addr p0, v0

    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    .line 43
    mul-float v0, p0, p0

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr p0, v1

    sub-float/2addr p1, p0

    mul-float/2addr v0, p1

    return v0
.end method

.method private static depthWeight(IIIF)F
    .locals 1

    .line 47
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result p2

    const v0, 0x3ec28f5c    # 0.38f

    mul-float/2addr p3, v0

    cmpg-float p2, p2, p3

    const/4 p3, 0x0

    if-gez p2, :cond_0

    .line 48
    return p3

    .line 50
    :cond_0
    sub-int/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(I)I

    move-result p0

    int-to-float p0, p0

    .line 51
    const/high16 p1, 0x41900000    # 18.0f

    cmpg-float p2, p0, p1

    const/high16 v0, 0x3f800000    # 1.0f

    if-gtz p2, :cond_1

    return v0

    .line 52
    :cond_1
    const/high16 p2, 0x42380000    # 46.0f

    cmpl-float p2, p0, p2

    if-ltz p2, :cond_2

    return p3

    .line 53
    :cond_2
    sub-float/2addr p0, p1

    const/high16 p1, 0x41e00000    # 28.0f

    div-float/2addr p0, p1

    .line 54
    mul-float p1, p0, p0

    const/high16 p2, 0x40000000    # 2.0f

    mul-float/2addr p0, p2

    const/high16 p2, 0x40400000    # 3.0f

    sub-float/2addr p2, p0

    mul-float/2addr p1, p2

    sub-float/2addr v0, p1

    return v0
.end method

.method private static encodeLinear(F)I
    .locals 2

    .line 155
    sget-object v0, Lcom/motorola/camera/custom/BokehKernel;->SRGB:[I

    const/high16 v1, 0x45800000    # 4096.0f

    mul-float/2addr p0, v1

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    const/16 v1, 0x1000

    invoke-static {p0, v1}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result p0

    aget p0, v0, p0

    return p0
.end method

.method static gather([I[BIIII)[I
    .locals 7

    .line 58
    const/high16 v6, 0x3f800000    # 1.0f

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/BokehKernel;->gather([I[BIIIIF)[I

    move-result-object p0

    return-object p0
.end method

.method static gather([I[BIIIIF)[I
    .locals 33

    .line 62
    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    move/from16 v3, p4

    move/from16 v4, p5

    invoke-static {v4}, Lcom/motorola/camera/custom/BokehKernel;->aperture(I)[F

    move-result-object v5

    .line 63
    array-length v6, v0

    new-array v6, v6, [I

    .line 64
    invoke-static/range {p6 .. p6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v7

    if-eqz v7, :cond_0

    move/from16 v7, p6

    goto :goto_0

    :cond_0
    const/high16 v7, 0x3f800000    # 1.0f

    :goto_0
    const v9, 0x3fb9999a    # 1.45f

    invoke-static {v9, v7}, Ljava/lang/Math;->min(FF)F

    move-result v7

    const v9, 0x3f333333    # 0.7f

    invoke-static {v9, v7}, Ljava/lang/Math;->max(FF)F

    move-result v7

    .line 65
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->min(II)I

    move-result v9

    int-to-float v9, v9

    const v10, 0x3cdd2f1b    # 0.027f

    mul-float/2addr v9, v10

    mul-float/2addr v9, v7

    const/high16 v7, 0x40000000    # 2.0f

    invoke-static {v7, v9}, Ljava/lang/Math;->max(FF)F

    move-result v7

    .line 66
    const/4 v10, 0x0

    :goto_1
    if-ge v10, v2, :cond_12

    .line 67
    const/4 v11, 0x0

    :goto_2
    if-ge v11, v1, :cond_11

    .line 68
    mul-int v12, v10, v1

    add-int v13, v12, v11

    .line 69
    aget-byte v14, p1, v13

    and-int/lit16 v14, v14, 0xff

    .line 70
    invoke-static {v14, v3}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result v15

    .line 71
    const v16, 0x3ca3d70a    # 0.02f

    cmpg-float v16, v15, v16

    if-gez v16, :cond_1

    .line 72
    aget v12, v0, v13

    aput v12, v6, v13

    .line 73
    const/high16 v18, 0x3f800000    # 1.0f

    goto/16 :goto_12

    .line 75
    :cond_1
    int-to-float v9, v11

    const/high16 v16, 0x3f000000    # 0.5f

    add-float v17, v9, v16

    int-to-float v8, v1

    div-float v17, v17, v8

    sub-float v17, v17, v16

    .line 76
    int-to-float v8, v10

    add-float v19, v8, v16

    int-to-float v0, v2

    div-float v19, v19, v0

    sub-float v19, v19, v16

    .line 77
    mul-float v0, v17, v17

    mul-float v16, v19, v19

    add-float v0, v0, v16

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    .line 78
    const/4 v1, 0x0

    cmpl-float v16, v0, v1

    if-lez v16, :cond_2

    div-float v17, v17, v0

    goto :goto_3

    :cond_2
    move/from16 v17, v1

    .line 79
    :goto_3
    if-lez v16, :cond_3

    div-float v19, v19, v0

    goto :goto_4

    :cond_3
    move/from16 v19, v1

    .line 80
    :goto_4
    const v16, 0x3fd9999a    # 1.7f

    move/from16 v20, v1

    const/4 v1, 0x1

    if-ne v4, v1, :cond_4

    mul-float v21, v0, v16

    mul-float v1, v21, v15

    move/from16 v21, v0

    float-to-double v0, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_5

    :cond_4
    move/from16 v21, v0

    const/high16 v0, 0x3f800000    # 1.0f

    .line 81
    :goto_5
    const/4 v1, 0x1

    if-ne v4, v1, :cond_5

    mul-float v1, v21, v16

    mul-float/2addr v1, v15

    move/from16 v16, v0

    float-to-double v0, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_6

    :cond_5
    move/from16 v16, v0

    move/from16 v0, v20

    .line 82
    :goto_6
    nop

    .line 83
    move/from16 v23, v20

    move/from16 v24, v23

    move/from16 v25, v24

    move/from16 v26, v25

    const/4 v1, 0x0

    :goto_7
    move/from16 v27, v0

    array-length v0, v5

    if-ge v1, v0, :cond_9

    .line 84
    aget v0, v5, v1

    mul-float v0, v0, v16

    add-int/lit8 v28, v1, 0x1

    aget v29, v5, v28

    mul-float v29, v29, v27

    sub-float v0, v0, v29

    .line 85
    aget v29, v5, v1

    mul-float v29, v29, v27

    aget v28, v5, v28

    mul-float v28, v28, v16

    add-float v29, v29, v28

    .line 86
    const/4 v2, 0x1

    if-ne v4, v2, :cond_6

    .line 87
    mul-float v2, v17, v0

    mul-float v28, v19, v29

    add-float v2, v2, v28

    mul-float v2, v2, v21

    const v28, 0x3f4ccccd    # 0.8f

    mul-float v2, v2, v28

    .line 88
    mul-float v28, v2, v17

    sub-float v0, v0, v28

    .line 89
    mul-float v2, v2, v19

    sub-float v29, v29, v2

    goto :goto_8

    .line 90
    :cond_6
    const/4 v2, 0x4

    if-eq v4, v2, :cond_7

    .line 91
    mul-float v2, v17, v0

    mul-float v28, v19, v29

    add-float v2, v2, v28

    mul-float v2, v2, v21

    mul-float v2, v2, v21

    const v28, 0x3e6147ae    # 0.22f

    mul-float v2, v2, v28

    .line 92
    mul-float v28, v2, v17

    sub-float v0, v0, v28

    .line 93
    mul-float v2, v2, v19

    sub-float v29, v29, v2

    goto :goto_9

    .line 90
    :cond_7
    :goto_8
    nop

    .line 95
    :goto_9
    mul-float/2addr v0, v7

    mul-float/2addr v0, v15

    add-float/2addr v0, v9

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/lit8 v2, p2, -0x1

    invoke-static {v0, v2}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 96
    mul-float v29, v29, v7

    mul-float v29, v29, v15

    add-float v29, v8, v29

    invoke-static/range {v29 .. v29}, Ljava/lang/Math;->round(F)I

    move-result v2

    move/from16 v28, v0

    add-int/lit8 v0, p3, -0x1

    invoke-static {v2, v0}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 97
    mul-int v0, v0, p2

    add-int v0, v0, v28

    .line 98
    aget-byte v2, p1, v0

    and-int/lit16 v2, v2, 0xff

    .line 99
    invoke-static {v14, v2, v3, v15}, Lcom/motorola/camera/custom/BokehKernel;->depthWeight(IIIF)F

    move-result v2

    .line 100
    cmpg-float v28, v2, v20

    if-gtz v28, :cond_8

    move/from16 v29, v1

    goto :goto_a

    .line 101
    :cond_8
    aget v0, p0, v0

    .line 102
    sget-object v28, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    move/from16 v29, v1

    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    aget v1, v28, v1

    .line 103
    sget-object v28, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    move/from16 v30, v1

    ushr-int/lit8 v1, v0, 0x8

    and-int/lit16 v1, v1, 0xff

    aget v1, v28, v1

    .line 104
    sget-object v28, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v28, v0

    .line 105
    const v28, 0x3e59b3d0    # 0.2126f

    mul-float v28, v28, v30

    const v31, 0x3f371759    # 0.7152f

    mul-float v31, v31, v1

    add-float v28, v28, v31

    const v31, 0x3d93dd98    # 0.0722f

    mul-float v31, v31, v0

    move/from16 v32, v0

    add-float v0, v28, v31

    .line 106
    move/from16 v28, v1

    const v1, 0x3f3851ec    # 0.72f

    move/from16 v31, v2

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v1, v2, v0}, Lcom/motorola/camera/custom/BokehKernel;->smoothstep(FFF)F

    move-result v0

    const v1, 0x3faccccd    # 1.35f

    mul-float/2addr v0, v1

    mul-float/2addr v0, v15

    add-float/2addr v0, v2

    .line 107
    add-int/lit8 v1, v29, 0x2

    aget v1, v5, v1

    mul-float v1, v1, v31

    .line 108
    mul-float v2, v30, v0

    mul-float/2addr v2, v1

    add-float v24, v24, v2

    .line 109
    mul-float v2, v28, v0

    mul-float/2addr v2, v1

    add-float v25, v25, v2

    .line 110
    mul-float v0, v0, v32

    mul-float/2addr v0, v1

    add-float v26, v26, v0

    .line 111
    add-float v23, v23, v1

    .line 83
    :goto_a
    add-int/lit8 v1, v29, 0x3

    move/from16 v2, p3

    move/from16 v0, v27

    goto/16 :goto_7

    .line 113
    :cond_9
    aget v0, p0, v13

    .line 114
    cmpg-float v1, v23, v20

    if-gtz v1, :cond_a

    sget-object v2, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    ushr-int/lit8 v8, v0, 0x10

    and-int/lit16 v8, v8, 0xff

    aget v2, v2, v8

    goto :goto_b

    :cond_a
    div-float v2, v24, v23

    .line 115
    :goto_b
    if-gtz v1, :cond_b

    sget-object v8, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    ushr-int/lit8 v9, v0, 0x8

    and-int/lit16 v9, v9, 0xff

    aget v8, v8, v9

    goto :goto_c

    :cond_b
    div-float v8, v25, v23

    .line 116
    :goto_c
    if-gtz v1, :cond_c

    sget-object v1, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v1, v0

    goto :goto_d

    :cond_c
    div-float v0, v26, v23

    .line 117
    :goto_d
    const/4 v1, 0x4

    if-ne v4, v1, :cond_10

    .line 118
    mul-float v1, v7, v15

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    const/4 v9, 0x1

    invoke-static {v9, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 119
    nop

    .line 120
    nop

    .line 121
    const/16 v16, -0x1

    move/from16 v17, v0

    move/from16 v0, v16

    move/from16 v16, v20

    move/from16 v19, v16

    move/from16 v21, v19

    move/from16 v22, v21

    :goto_e
    if-gt v0, v9, :cond_e

    .line 122
    mul-int v23, v0, v1

    add-int v9, v11, v23

    move/from16 v23, v0

    add-int/lit8 v0, p2, -0x1

    invoke-static {v9, v0}, Lcom/motorola/camera/custom/BokehKernel;->clamp(II)I

    move-result v0

    .line 123
    add-int/2addr v0, v12

    .line 124
    aget-byte v9, p1, v0

    and-int/lit16 v9, v9, 0xff

    .line 125
    invoke-static {v14, v9, v3, v15}, Lcom/motorola/camera/custom/BokehKernel;->depthWeight(IIIF)F

    move-result v9

    .line 126
    cmpl-float v25, v9, v20

    if-lez v25, :cond_d

    .line 127
    aget v0, p0, v0

    .line 128
    sget-object v25, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    move/from16 v26, v1

    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    aget v1, v25, v1

    mul-float/2addr v1, v9

    add-float v19, v19, v1

    .line 129
    sget-object v1, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    move-object/from16 v25, v1

    ushr-int/lit8 v1, v0, 0x8

    and-int/lit16 v1, v1, 0xff

    aget v1, v25, v1

    mul-float/2addr v1, v9

    add-float v21, v21, v1

    .line 130
    sget-object v1, Lcom/motorola/camera/custom/BokehKernel;->LINEAR:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v1, v0

    mul-float/2addr v0, v9

    add-float v22, v22, v0

    .line 131
    add-float v16, v16, v9

    goto :goto_f

    .line 126
    :cond_d
    move/from16 v26, v1

    .line 121
    :goto_f
    add-int/lit8 v0, v23, 0x2

    move/from16 v1, v26

    const/4 v9, 0x1

    goto :goto_e

    .line 134
    :cond_e
    cmpl-float v0, v16, v20

    if-lez v0, :cond_f

    .line 135
    div-float v0, v19, v16

    div-float v1, v21, v16

    div-float v9, v22, v16

    invoke-static {v1, v9}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 136
    const v1, 0x3e3851ec    # 0.18f

    mul-float/2addr v15, v1

    const v1, 0x3f2e147b    # 0.68f

    sub-float/2addr v0, v1

    move/from16 v1, v20

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    mul-float/2addr v15, v0

    .line 137
    const v0, 0x3ee66666    # 0.45f

    mul-float/2addr v0, v15

    add-float/2addr v2, v0

    .line 138
    const v0, 0x3f59999a    # 0.85f

    mul-float/2addr v0, v15

    add-float/2addr v8, v0

    .line 139
    const/high16 v18, 0x3f800000    # 1.0f

    mul-float v15, v15, v18

    add-float v0, v17, v15

    goto :goto_11

    .line 134
    :cond_f
    const/high16 v18, 0x3f800000    # 1.0f

    goto :goto_10

    .line 117
    :cond_10
    move/from16 v17, v0

    const/high16 v18, 0x3f800000    # 1.0f

    .line 142
    :goto_10
    move/from16 v0, v17

    :goto_11
    invoke-static {v2}, Lcom/motorola/camera/custom/BokehKernel;->encodeLinear(F)I

    move-result v1

    shl-int/lit8 v1, v1, 0x10

    const/high16 v2, -0x1000000

    or-int/2addr v1, v2

    .line 143
    invoke-static {v8}, Lcom/motorola/camera/custom/BokehKernel;->encodeLinear(F)I

    move-result v2

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v1, v2

    invoke-static {v0}, Lcom/motorola/camera/custom/BokehKernel;->encodeLinear(F)I

    move-result v0

    or-int/2addr v0, v1

    aput v0, v6, v13

    .line 67
    :goto_12
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    goto/16 :goto_2

    .line 66
    :cond_11
    const/high16 v18, 0x3f800000    # 1.0f

    add-int/lit8 v10, v10, 0x1

    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    goto/16 :goto_1

    .line 146
    :cond_12
    return-object v6
.end method

.method private static smoothstep(FFF)F
    .locals 0

    .line 150
    sub-float/2addr p2, p0

    sub-float/2addr p1, p0

    div-float/2addr p2, p1

    const/high16 p0, 0x3f800000    # 1.0f

    invoke-static {p0, p2}, Ljava/lang/Math;->min(FF)F

    move-result p0

    const/4 p1, 0x0

    invoke-static {p1, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    .line 151
    mul-float p1, p0, p0

    const/high16 p2, 0x40000000    # 2.0f

    mul-float/2addr p0, p2

    const/high16 p2, 0x40400000    # 3.0f

    sub-float/2addr p2, p0

    mul-float/2addr p1, p2

    return p1
.end method
