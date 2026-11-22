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

.method private static applyLightnessCurve(FI)F
    .locals 4

    .line 402
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 403
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    return v0

    .line 404
    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_4

    .line 406
    const p1, 0x3e6147ae    # 0.22f

    cmpg-float v1, p0, p1

    if-gez v1, :cond_2

    .line 407
    float-to-double p0, p0

    const-wide v0, 0x3fcc28f5c28f5c29L    # 0.22

    div-double/2addr p0, v0

    const-wide v2, 0x3ff2e147ae147ae1L    # 1.18

    invoke-static {p0, p1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide p0

    mul-double/2addr p0, v0

    double-to-float p0, p0

    return p0

    .line 409
    :cond_2
    const v1, 0x3f3851ec    # 0.72f

    cmpg-float v2, p0, v1

    if-gez v2, :cond_3

    .line 410
    sub-float p1, p0, p1

    const/high16 v0, 0x3f000000    # 0.5f

    div-float/2addr p1, v0

    .line 411
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

    .line 413
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

    .line 415
    :cond_4
    const/4 v1, 0x3

    if-ne p1, v1, :cond_5

    .line 417
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

    .line 420
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

.method private static buildEdgeAwareBaseGrid([IIIII)[F
    .locals 23

    .line 127
    move/from16 v0, p1

    move/from16 v1, p3

    move/from16 v2, p4

    mul-int v3, v1, v2

    new-array v4, v3, [F

    .line 128
    const/4 v6, 0x0

    :goto_0
    if-ge v6, v2, :cond_4

    .line 129
    mul-int/lit8 v8, v6, 0x8

    .line 130
    add-int/lit8 v9, v8, 0x8

    move/from16 v10, p2

    invoke-static {v10, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 131
    const/4 v11, 0x0

    :goto_1
    if-ge v11, v1, :cond_3

    .line 132
    mul-int/lit8 v12, v11, 0x8

    .line 133
    add-int/lit8 v13, v12, 0x8

    invoke-static {v0, v13}, Ljava/lang/Math;->min(II)I

    move-result v13

    .line 134
    nop

    .line 135
    nop

    .line 136
    const-wide/16 v14, 0x0

    move v7, v8

    const/4 v5, 0x0

    const/16 v16, 0x0

    :goto_2
    if-ge v7, v9, :cond_1

    .line 137
    mul-int v18, v7, v0

    .line 138
    move v0, v12

    :goto_3
    if-ge v0, v13, :cond_0

    .line 139
    add-int v19, v18, v0

    move/from16 v20, v0

    aget v0, p0, v19

    .line 140
    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    move-object/from16 v21, v4

    ushr-int/lit8 v4, v0, 0x10

    and-int/lit16 v4, v4, 0xff

    aget v4, v19, v4

    const v19, 0x3e59b3d0    # 0.2126f

    mul-float v4, v4, v19

    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    move/from16 v22, v4

    ushr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    aget v4, v19, v4

    const v19, 0x3f371759    # 0.7152f

    mul-float v4, v4, v19

    add-float v4, v22, v4

    sget-object v19, Lcom/motorola/camera/custom/AppleStyleToneEngine;->SRGB_TO_LIN:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v19, v0

    const v19, 0x3d93dd98    # 0.0722f

    mul-float v0, v0, v19

    add-float/2addr v4, v0

    .line 143
    move v0, v5

    float-to-double v4, v4

    add-double/2addr v14, v4

    .line 144
    add-int/lit8 v5, v0, 0x1

    .line 138
    add-int/lit8 v0, v20, 0x2

    move-object/from16 v4, v21

    goto :goto_3

    .line 136
    :cond_0
    move-object/from16 v21, v4

    move v0, v5

    add-int/lit8 v7, v7, 0x2

    move/from16 v0, p1

    goto :goto_2

    .line 147
    :cond_1
    move-object/from16 v21, v4

    if-lez v5, :cond_2

    int-to-double v4, v5

    div-double/2addr v14, v4

    double-to-float v0, v14

    goto :goto_4

    :cond_2
    move/from16 v0, v16

    .line 148
    :goto_4
    mul-int v4, v6, v1

    add-int/2addr v4, v11

    const v5, 0x3b03126f    # 0.002f

    add-float/2addr v0, v5

    float-to-double v12, v0

    invoke-static {v12, v13}, Ljava/lang/Math;->log(D)D

    move-result-wide v12

    double-to-float v0, v12

    aput v0, v21, v4

    .line 131
    add-int/lit8 v11, v11, 0x1

    move/from16 v0, p1

    move-object/from16 v4, v21

    goto :goto_1

    .line 128
    :cond_3
    move-object/from16 v21, v4

    add-int/lit8 v6, v6, 0x1

    move/from16 v0, p1

    goto/16 :goto_0

    .line 153
    :cond_4
    move-object/from16 v21, v4

    const/16 v16, 0x0

    new-array v0, v3, [F

    .line 154
    new-array v3, v3, [F

    .line 156
    const/4 v4, 0x5

    new-array v4, v4, [F

    fill-array-data v4, :array_0

    .line 158
    const/4 v5, 0x0

    :goto_5
    const/4 v8, 0x2

    if-ge v5, v2, :cond_8

    .line 159
    mul-int v9, v5, v1

    .line 160
    const/4 v10, 0x0

    :goto_6
    if-ge v10, v1, :cond_7

    .line 161
    add-int v11, v9, v10

    aget v12, v21, v11

    .line 162
    nop

    .line 163
    nop

    .line 164
    move/from16 v14, v16

    move v15, v14

    const/4 v13, -0x2

    :goto_7
    if-gt v13, v8, :cond_5

    .line 165
    const p0, 0x4047ffff    # 3.1249998f

    add-int/lit8 v6, v1, -0x1

    add-int v7, v10, v13

    invoke-static {v6, v7}, Ljava/lang/Math;->min(II)I

    move-result v6

    const/4 v7, 0x0

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 166
    add-int/2addr v6, v9

    aget v6, v21, v6

    .line 167
    sub-float v7, v6, v12

    .line 168
    add-int/lit8 v18, v13, 0x2

    aget v18, v4, v18

    mul-float/2addr v7, v7

    mul-float v7, v7, p0

    invoke-static {v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result v7

    mul-float v18, v18, v7

    .line 169
    mul-float v6, v6, v18

    add-float/2addr v15, v6

    .line 170
    add-float v14, v14, v18

    .line 164
    add-int/lit8 v13, v13, 0x1

    goto :goto_7

    .line 172
    :cond_5
    const p0, 0x4047ffff    # 3.1249998f

    cmpl-float v6, v14, v16

    if-lez v6, :cond_6

    div-float v12, v15, v14

    :cond_6
    aput v12, v0, v11

    .line 160
    add-int/lit8 v10, v10, 0x1

    goto :goto_6

    .line 158
    :cond_7
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .line 175
    :cond_8
    const p0, 0x4047ffff    # 3.1249998f

    const/4 v7, 0x0

    :goto_8
    if-ge v7, v2, :cond_c

    .line 176
    mul-int v5, v7, v1

    .line 177
    const/4 v6, 0x0

    :goto_9
    if-ge v6, v1, :cond_b

    .line 178
    add-int v9, v5, v6

    aget v10, v0, v9

    .line 179
    nop

    .line 180
    nop

    .line 181
    move/from16 v12, v16

    move v13, v12

    const/4 v11, -0x2

    :goto_a
    if-gt v11, v8, :cond_9

    .line 182
    add-int/lit8 v14, v2, -0x1

    add-int v15, v7, v11

    invoke-static {v14, v15}, Ljava/lang/Math;->min(II)I

    move-result v14

    const/4 v15, 0x0

    invoke-static {v15, v14}, Ljava/lang/Math;->max(II)I

    move-result v14

    .line 183
    mul-int/2addr v14, v1

    add-int/2addr v14, v6

    aget v14, v0, v14

    .line 184
    sub-float v17, v14, v10

    .line 185
    add-int/lit8 v18, v11, 0x2

    aget v18, v4, v18

    mul-float v17, v17, v17

    mul-float v17, v17, p0

    invoke-static/range {v17 .. v17}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result v17

    mul-float v18, v18, v17

    .line 186
    mul-float v14, v14, v18

    add-float/2addr v13, v14

    .line 187
    add-float v12, v12, v18

    .line 181
    add-int/lit8 v11, v11, 0x1

    goto :goto_a

    .line 189
    :cond_9
    const/4 v15, 0x0

    cmpl-float v11, v12, v16

    if-lez v11, :cond_a

    div-float v10, v13, v12

    :cond_a
    aput v10, v3, v9

    .line 177
    add-int/lit8 v6, v6, 0x1

    goto :goto_9

    .line 175
    :cond_b
    const/4 v15, 0x0

    add-int/lit8 v7, v7, 0x1

    goto :goto_8

    .line 192
    :cond_c
    return-object v3

    :array_0
    .array-data 4
        0x3e800000    # 0.25f
        0x3f1c28f6    # 0.61f
        0x3f800000    # 1.0f
        0x3f1c28f6    # 0.61f
        0x3e800000    # 0.25f
    .end array-data
.end method

.method private static clamp(FFF)F
    .locals 1

    .line 479
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

    .line 475
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

.method private static countWords(Ljava/lang/String;II)I
    .locals 2

    .line 648
    nop

    .line 649
    const/4 v0, 0x0

    .line 650
    :goto_0
    if-ge p1, p2, :cond_2

    .line 651
    :goto_1
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 652
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 654
    :cond_0
    if-lt p1, p2, :cond_1

    .line 655
    goto :goto_2

    .line 657
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 658
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    goto :goto_0

    .line 660
    :cond_2
    :goto_2
    return v0
.end method

.method private static deterministicGrain6(II)F
    .locals 1

    .line 457
    const v0, -0x61c8864f

    mul-int/2addr p0, v0

    const v0, -0x7a143589

    mul-int/2addr p1, v0

    xor-int/2addr p0, p1

    .line 458
    ushr-int/lit8 p1, p0, 0xf

    xor-int/2addr p0, p1

    .line 459
    const p1, 0x2c1b3c6d

    mul-int/2addr p0, p1

    .line 460
    ushr-int/lit8 p1, p0, 0xc

    xor-int/2addr p0, p1

    .line 462
    and-int/lit16 p1, p0, 0xff

    ushr-int/lit8 v0, p0, 0x8

    and-int/lit16 v0, v0, 0xff

    add-int/2addr p1, v0

    .line 463
    ushr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    ushr-int/lit8 p0, p0, 0x18

    and-int/lit16 p0, p0, 0xff

    add-int/2addr v0, p0

    .line 464
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

    .line 672
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

.method private static fastCbrtPos(F)F
    .locals 5

    .line 439
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 440
    :cond_0
    invoke-static {p0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    .line 441
    div-int/lit8 v0, v0, 0x3

    const v1, 0x2a5137a0

    add-int/2addr v0, v1

    .line 442
    invoke-static {v0}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v0

    .line 444
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 445
    const/high16 v2, 0x40000000    # 2.0f

    mul-float v3, p0, v2

    add-float v4, v1, v3

    mul-float/2addr v0, v4

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    .line 446
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 447
    add-float/2addr v3, v1

    mul-float/2addr v0, v3

    mul-float/2addr v1, v2

    add-float/2addr v1, p0

    div-float/2addr v0, v1

    return v0
.end method

.method private static fastExpNeg(F)F
    .locals 2

    .line 433
    const/high16 v0, 0x41200000    # 10.0f

    cmpl-float v0, p0, v0

    const/4 v1, 0x0

    if-ltz v0, :cond_0

    return v1

    .line 434
    :cond_0
    cmpg-float v0, p0, v1

    if-gtz v0, :cond_1

    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 435
    :cond_1
    neg-float p0, p0

    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float p0, v0

    return p0
.end method

.method private static gaussianHueWeight(FFF)F
    .locals 0

    .line 424
    sub-float/2addr p0, p1

    invoke-static {p0}, Ljava/lang/Math;->abs(F)F

    move-result p0

    .line 425
    const/high16 p1, 0x43340000    # 180.0f

    cmpl-float p1, p0, p1

    if-lez p1, :cond_0

    .line 426
    const/high16 p1, 0x43b40000    # 360.0f

    sub-float p0, p1, p0

    .line 428
    :cond_0
    div-float/2addr p0, p2

    .line 429
    const/high16 p1, 0x3f000000    # 0.5f

    mul-float/2addr p1, p0

    mul-float/2addr p1, p0

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastExpNeg(F)F

    move-result p0

    return p0
.end method

.method private static gradePixel(IFFFZFIFZII)I
    .locals 18

    .line 198
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

    .line 199
    return p0

    .line 201
    :cond_0
    const/high16 v4, 0x3f800000    # 1.0f

    cmpl-float v5, v0, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p2, v4

    if-ltz v5, :cond_1

    cmpl-float v5, p3, v4

    if-ltz v5, :cond_1

    .line 202
    const v0, 0xffffff

    or-int v0, p0, v0

    return v0

    .line 206
    :cond_1
    const v5, 0x3e59b3d0    # 0.2126f

    mul-float v6, v0, v5

    const v7, 0x3f371759    # 0.7152f

    mul-float v8, p2, v7

    add-float/2addr v6, v8

    const v8, 0x3d93dd98    # 0.0722f

    mul-float v9, p3, v8

    add-float/2addr v6, v9

    .line 207
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v0, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    invoke-static {v6, v9}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 208
    const v10, 0x3f1eb852    # 0.62f

    cmpl-float v11, v9, v10

    const v12, 0x3e0f5c29    # 0.14f

    const v13, 0x3ec28f5c    # 0.38f

    if-lez v11, :cond_4

    .line 209
    sub-float v6, v9, v10

    div-float/2addr v6, v13

    .line 210
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

    .line 211
    const/4 v6, 0x1

    if-ne v2, v6, :cond_2

    cmpl-float v6, v11, v9

    if-lez v6, :cond_2

    .line 212
    move v11, v9

    .line 214
    :cond_2
    div-float/2addr v11, v9

    .line 215
    mul-float/2addr v0, v11

    .line 216
    mul-float v6, p2, v11

    .line 217
    mul-float v11, v11, p3

    .line 219
    const v14, 0x3f5c28f6    # 0.86f

    cmpl-float v15, v9, v14

    if-lez v15, :cond_3

    if-nez p4, :cond_3

    .line 220
    invoke-static {v14, v4, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v9

    const v14, 0x3e75c28f    # 0.24f

    mul-float/2addr v9, v14

    .line 221
    mul-float v14, v0, v5

    mul-float v15, v6, v7

    add-float/2addr v14, v15

    mul-float v15, v11, v8

    add-float/2addr v14, v15

    .line 222
    sub-float v15, v14, v0

    mul-float/2addr v15, v9

    add-float/2addr v0, v15

    .line 223
    sub-float v15, v14, v6

    mul-float/2addr v15, v9

    add-float/2addr v6, v15

    .line 224
    sub-float/2addr v14, v11

    mul-float/2addr v14, v9

    add-float/2addr v11, v14

    .line 226
    :cond_3
    mul-float/2addr v5, v0

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    mul-float/2addr v8, v11

    add-float/2addr v5, v8

    goto :goto_0

    .line 208
    :cond_4
    move/from16 v11, p3

    move v5, v6

    move/from16 v6, p2

    .line 230
    :goto_0
    const/high16 v7, -0x3ef00000    # -9.0f

    cmpl-float v7, v1, v7

    const v8, 0x3b03126f    # 0.002f

    if-lez v7, :cond_5

    if-nez p4, :cond_5

    .line 231
    float-to-double v14, v1

    invoke-static {v14, v15}, Ljava/lang/Math;->exp(D)D

    move-result-wide v14

    double-to-float v1, v14

    sub-float/2addr v1, v8

    const v7, 0x3a03126f    # 5.0E-4f

    invoke-static {v7, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 232
    invoke-static {v1, v5, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->localBaseGain(FFI)F

    move-result v1

    .line 233
    mul-float/2addr v0, v1

    invoke-static {v3, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 234
    mul-float/2addr v6, v1

    invoke-static {v3, v6}, Ljava/lang/Math;->max(FF)F

    move-result v6

    .line 235
    mul-float/2addr v11, v1

    invoke-static {v3, v11}, Ljava/lang/Math;->max(FF)F

    move-result v11

    .line 239
    :cond_5
    const v1, 0x3ed30eb1

    mul-float/2addr v1, v0

    const v5, 0x3f094d17

    mul-float/2addr v5, v6

    add-float/2addr v1, v5

    const v5, 0x3d52b909

    mul-float/2addr v5, v11

    add-float/2addr v1, v5

    .line 240
    const v5, 0x3e58fd3b

    mul-float/2addr v5, v0

    const v7, 0x3f2e4253

    mul-float/2addr v7, v6

    add-float/2addr v5, v7

    const v7, 0x3ddbf2f0

    mul-float/2addr v7, v11

    add-float/2addr v5, v7

    .line 241
    const v7, 0x3db4d7ec

    mul-float/2addr v0, v7

    const v7, 0x3e903d74

    mul-float/2addr v6, v7

    add-float/2addr v0, v6

    const v6, 0x3f214649

    mul-float/2addr v11, v6

    add-float/2addr v0, v11

    .line 243
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v1

    .line 244
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v5

    .line 245
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->fastCbrtPos(F)F

    move-result v0

    .line 247
    const v6, 0x3e578152

    mul-float/2addr v6, v1

    const v7, 0x3f4b2a89

    mul-float/2addr v7, v5

    add-float/2addr v6, v7

    const v7, 0x3b856ece

    mul-float/2addr v7, v0

    sub-float/2addr v6, v7

    .line 248
    const v7, 0x3ffd2f0e

    mul-float/2addr v7, v1

    const v9, 0x401b6e0e

    mul-float/2addr v9, v5

    sub-float/2addr v7, v9

    const v9, 0x3ee6b438

    mul-float/2addr v9, v0

    add-float/2addr v7, v9

    .line 249
    const v9, 0x3cd434b4

    mul-float/2addr v1, v9

    const v9, 0x3f4863bb

    mul-float/2addr v5, v9

    add-float/2addr v1, v5

    const v5, 0x3f4f0560

    mul-float/2addr v0, v5

    sub-float/2addr v1, v0

    .line 252
    invoke-static {v6, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyLightnessCurve(FI)F

    move-result v0

    .line 254
    const v5, 0x3f6b851f    # 0.92f

    const/4 v9, 0x3

    if-eqz p8, :cond_7

    .line 256
    cmpl-float v11, p7, v3

    if-lez v11, :cond_6

    .line 257
    const v11, 0x3f147ae1    # 0.58f

    invoke-static {v11, v5, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v11

    sub-float v11, v4, v11

    .line 258
    mul-float v11, v11, p7

    sub-float v11, v4, v11

    mul-float/2addr v0, v11

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 261
    :cond_6
    if-ne v2, v9, :cond_7

    .line 262
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

    .line 263
    cmpl-float v14, v11, v3

    if-lez v14, :cond_7

    .line 264
    invoke-static/range {p9 .. p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->deterministicGrain6(II)F

    move-result v14

    const v15, 0x3b51b717    # 0.0032f

    mul-float/2addr v14, v15

    mul-float/2addr v14, v11

    add-float/2addr v0, v14

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 269
    :cond_7
    if-eqz p4, :cond_8

    .line 270
    mul-float v1, v0, v0

    mul-float/2addr v1, v0

    .line 271
    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toSrgbByte(F)I

    move-result v0

    .line 272
    shl-int/lit8 v1, v0, 0x10

    or-int v1, p0, v1

    shl-int/lit8 v2, v0, 0x8

    or-int/2addr v1, v2

    or-int/2addr v0, v1

    return v0

    .line 275
    :cond_8
    mul-float v11, v7, v7

    mul-float v14, v1, v1

    add-float/2addr v11, v14

    float-to-double v14, v11

    invoke-static {v14, v15}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v14

    double-to-float v11, v14

    .line 276
    nop

    .line 277
    nop

    .line 279
    const v14, 0x38d1b717    # 1.0E-4f

    cmpl-float v14, v11, v14

    const v15, 0x3d4ccccd    # 0.05f

    if-lez v14, :cond_f

    .line 280
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

    .line 281
    cmpg-float v4, v3, v14

    if-gez v4, :cond_9

    .line 282
    const/high16 v4, 0x43b40000    # 360.0f

    add-float/2addr v3, v4

    .line 285
    :cond_9
    const v4, 0x3c449ba6    # 0.012f

    invoke-static {v4, v15, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    .line 288
    const/high16 v8, 0x43080000    # 136.0f

    const/high16 v9, 0x41b00000    # 22.0f

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v8

    mul-float/2addr v8, v4

    .line 289
    const v9, 0x3c23d70a    # 0.01f

    cmpl-float v17, v8, v9

    if-lez v17, :cond_a

    .line 290
    mul-float/2addr v12, v8

    sub-float v12, v16, v12

    .line 291
    const v17, 0x3d8efa35

    mul-float v8, v8, v17

    .line 292
    neg-float v8, v8

    move/from16 p4, v14

    move/from16 p3, v15

    float-to-double v14, v8

    move/from16 p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->cos(D)D

    move-result-wide v5

    double-to-float v5, v5

    .line 293
    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v6, v14

    .line 294
    mul-float v14, v7, v5

    mul-float v15, v1, v6

    sub-float/2addr v14, v15

    mul-float/2addr v14, v12

    .line 295
    mul-float/2addr v7, v6

    mul-float/2addr v1, v5

    add-float/2addr v7, v1

    mul-float v1, v7, v12

    .line 296
    nop

    .line 297
    move v7, v14

    goto :goto_1

    .line 289
    :cond_a
    move/from16 p5, v6

    move/from16 p4, v14

    move/from16 p3, v15

    .line 301
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

    .line 302
    cmpl-float v9, v5, v9

    const/4 v10, 0x2

    if-lez v9, :cond_c

    .line 303
    const v9, 0x3e17e9d8

    mul-float/2addr v9, v5

    .line 304
    float-to-double v12, v9

    invoke-static {v12, v13}, Ljava/lang/Math;->cos(D)D

    move-result-wide v14

    double-to-float v9, v14

    .line 305
    invoke-static {v12, v13}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    double-to-float v12, v12

    .line 306
    if-ne v2, v10, :cond_b

    const v13, 0x3db851ec    # 0.09f

    goto :goto_2

    :cond_b
    move/from16 v13, p3

    :goto_2
    mul-float/2addr v13, v5

    add-float v13, v13, v16

    .line 307
    mul-float v5, v7, v9

    mul-float v14, v1, v12

    sub-float/2addr v5, v14

    mul-float/2addr v5, v13

    .line 308
    mul-float/2addr v7, v12

    mul-float/2addr v1, v9

    add-float/2addr v7, v1

    mul-float v1, v7, v13

    .line 309
    nop

    .line 310
    move v7, v5

    .line 314
    :cond_c
    const/high16 v5, 0x42280000    # 42.0f

    const/high16 v9, 0x41c00000    # 24.0f

    invoke-static {v3, v5, v9}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->gaussianHueWeight(FFF)F

    move-result v3

    .line 315
    const v5, 0x3e3851ec    # 0.18f

    const v9, 0x3e99999a    # 0.3f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    mul-float/2addr v3, v5

    .line 316
    const v5, 0x3f570a3d    # 0.84f

    const v9, 0x3f70a3d7    # 0.94f

    invoke-static {v5, v9, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 317
    const v5, 0x3de147ae    # 0.11f

    const v9, 0x3e6147ae    # 0.22f

    invoke-static {v5, v9, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v5

    sub-float v5, v16, v5

    mul-float/2addr v3, v5

    .line 319
    const v5, 0x3b83126f    # 0.004f

    if-ne v2, v10, :cond_d

    .line 321
    sub-float v2, v6, v0

    const v4, 0x3ef5c28f    # 0.48f

    mul-float/2addr v4, v3

    mul-float/2addr v2, v4

    add-float/2addr v0, v2

    .line 322
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 323
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 324
    :cond_d
    const/4 v9, 0x3

    if-ne v2, v9, :cond_e

    .line 326
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

    .line 327
    const v4, 0x3c75c28f    # 0.015f

    const v5, 0x3d23d70a    # 0.04f

    invoke-static {v4, v5, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v4

    mul-float/2addr v4, v3

    .line 328
    const v5, 0x3c0b4396    # 0.0085f

    mul-float/2addr v5, v4

    const v8, 0x3b23d70a    # 0.0025f

    mul-float/2addr v8, v2

    add-float/2addr v5, v8

    add-float/2addr v7, v5

    .line 329
    const v5, 0x3c978d50    # 0.0185f

    mul-float/2addr v4, v5

    const v5, 0x3c03126f    # 0.008f

    mul-float/2addr v2, v5

    add-float/2addr v4, v2

    add-float/2addr v1, v4

    .line 330
    mul-float/2addr v3, v5

    add-float/2addr v0, v3

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 331
    goto :goto_3

    .line 333
    :cond_e
    mul-float v8, v3, p1

    add-float/2addr v7, v8

    .line 334
    mul-float/2addr v3, v5

    add-float/2addr v1, v3

    goto :goto_3

    .line 279
    :cond_f
    move/from16 p4, v3

    move/from16 p3, v15

    .line 339
    :goto_3
    cmpl-float v2, v0, v6

    if-lez v2, :cond_10

    cmpl-float v2, v6, p3

    if-lez v2, :cond_10

    const v2, 0x3f3851ec    # 0.72f

    cmpl-float v3, v0, v2

    if-lez v3, :cond_10

    .line 340
    const v3, 0x3f7ae148    # 0.98f

    invoke-static {v2, v3, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    const v3, 0x3e19999a    # 0.15f

    mul-float/2addr v2, v3

    const/high16 v16, 0x3f800000    # 1.0f

    sub-float v4, v16, v2

    .line 341
    mul-float/2addr v7, v4

    .line 342
    mul-float/2addr v1, v4

    .line 346
    :cond_10
    const v2, 0x3ecaecc9

    mul-float/2addr v2, v7

    add-float/2addr v2, v0

    const v3, 0x3e5cfba9

    mul-float/2addr v3, v1

    add-float/2addr v2, v3

    .line 347
    const v3, 0x3dd8308c

    mul-float/2addr v3, v7

    sub-float v3, v0, v3

    const v4, 0x3d82c5fa

    mul-float/2addr v4, v1

    sub-float/2addr v3, v4

    .line 348
    const v4, 0x3db7437b

    mul-float/2addr v7, v4

    sub-float v4, v0, v7

    const v5, 0x3fa54f66

    mul-float/2addr v1, v5

    sub-float/2addr v4, v1

    .line 350
    mul-float v1, v2, v2

    mul-float/2addr v1, v2

    .line 351
    mul-float v2, v3, v3

    mul-float/2addr v2, v3

    .line 352
    mul-float v3, v4, v4

    mul-float/2addr v3, v4

    .line 354
    const v4, 0x408274ab

    mul-float/2addr v4, v1

    const v5, 0x4053b18c

    mul-float/2addr v5, v2

    sub-float/2addr v4, v5

    const v5, 0x3e6c8362

    mul-float/2addr v5, v3

    add-float/2addr v4, v5

    .line 355
    const v5, -0x405da3d3

    mul-float/2addr v5, v1

    const v6, 0x40270644

    mul-float/2addr v6, v2

    add-float/2addr v5, v6

    const v6, 0x3eaec16a

    mul-float/2addr v6, v3

    sub-float/2addr v5, v6

    .line 356
    const v6, -0x447680ad

    mul-float/2addr v1, v6

    const v6, 0x3f34133e

    mul-float/2addr v2, v6

    sub-float/2addr v1, v2

    const v2, 0x3fda931e

    mul-float/2addr v3, v2

    add-float/2addr v1, v3

    .line 359
    invoke-static {v5, v1}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-static {v4, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    .line 360
    invoke-static {v5, v1}, Ljava/lang/Math;->min(FF)F

    move-result v3

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    .line 361
    cmpg-float v6, v3, p4

    if-ltz v6, :cond_11

    const/high16 v16, 0x3f800000    # 1.0f

    cmpl-float v7, v2, v16

    if-lez v7, :cond_14

    .line 362
    :cond_11
    mul-float v7, v0, v0

    mul-float/2addr v7, v0

    .line 363
    nop

    .line 364
    if-gez v6, :cond_12

    cmpl-float v0, v7, v3

    if-lez v0, :cond_12

    .line 365
    sub-float v0, v7, v3

    div-float v0, v7, v0

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    goto :goto_4

    .line 364
    :cond_12
    const/high16 v3, 0x3f800000    # 1.0f

    .line 367
    move v0, v3

    :goto_4
    cmpl-float v6, v2, v3

    if-lez v6, :cond_13

    cmpl-float v6, v2, v7

    if-lez v6, :cond_13

    .line 368
    sub-float/2addr v3, v7

    sub-float/2addr v2, v7

    div-float/2addr v3, v2

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 370
    :cond_13
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    .line 371
    sub-float/2addr v4, v7

    mul-float/2addr v4, v0

    add-float/2addr v4, v7

    .line 372
    sub-float/2addr v5, v7

    mul-float/2addr v5, v0

    add-float/2addr v5, v7

    .line 373
    sub-float/2addr v1, v7

    mul-float/2addr v1, v0

    add-float/2addr v1, v7

    .line 376
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

    .line 676
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

    .line 381
    const v0, 0x38d1b717    # 1.0E-4f

    cmpg-float p1, p1, v0

    const/high16 v1, 0x3f800000    # 1.0f

    if-gtz p1, :cond_0

    .line 382
    return v1

    .line 384
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

    .line 385
    nop

    .line 386
    const/4 v2, 0x2

    const v3, 0x3da3d70a    # 0.08f

    const v4, 0x3d4ccccd    # 0.05f

    if-ne p2, v2, :cond_1

    .line 388
    const p2, 0x3ed70a3d    # 0.42f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3c23d70a    # 0.01f

    invoke-static {v2, v4, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 389
    const v2, 0x3df5c28f    # 0.12f

    mul-float/2addr p2, v2

    sub-float p2, v1, p2

    mul-float/2addr p2, p0

    .line 390
    goto :goto_0

    :cond_1
    const/4 v2, 0x1

    if-ne p2, v2, :cond_2

    .line 391
    const/high16 p2, 0x3e800000    # 0.25f

    invoke-static {v4, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    sub-float p2, v1, p2

    const v2, 0x3ba3d70a    # 0.005f

    const v3, 0x3cf5c28f    # 0.03f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    mul-float/2addr p2, v2

    .line 392
    mul-float/2addr p2, v4

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    .line 393
    goto :goto_0

    :cond_2
    const/4 v2, 0x3

    if-ne p2, v2, :cond_3

    .line 394
    const p2, 0x3eb33333    # 0.35f

    invoke-static {v3, p2, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result p2

    const v2, 0x3ee66666    # 0.45f

    const v3, 0x3f47ae14    # 0.78f

    invoke-static {v2, v3, p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->smoothstep(FFF)F

    move-result v2

    sub-float v2, v1, v2

    mul-float/2addr p2, v2

    .line 395
    const v2, 0x3d23d70a    # 0.04f

    mul-float/2addr p2, v2

    add-float/2addr p2, v1

    mul-float/2addr p2, p0

    goto :goto_0

    .line 393
    :cond_3
    move p2, p0

    .line 397
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

    .line 398
    const p0, 0x3f51eb85    # 0.82f

    const p1, 0x3f947ae1    # 1.16f

    invoke-static {p2, p0, p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp(FFF)F

    move-result p0

    return p0
.end method

.method public static parseCubeLut(Ljava/lang/String;[I)[F
    .locals 19

    .line 488
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-eqz v0, :cond_1d

    .line 491
    nop

    .line 492
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const v5, 0xfeff

    if-ne v2, v5, :cond_0

    .line 493
    const/4 v2, 0x1

    goto :goto_0

    .line 495
    :cond_0
    move v2, v3

    :goto_0
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
    nop

    .line 501
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, -0x1

    const/4 v7, 0x0

    move v10, v3

    move-object v8, v7

    move-object v9, v8

    .line 502
    :goto_1
    const/4 v11, 0x2

    if-gt v2, v5, :cond_18

    .line 503
    move v13, v2

    .line 504
    :goto_2
    const/16 v14, 0xd

    const/16 v15, 0xa

    if-ge v13, v5, :cond_2

    .line 505
    const/16 v16, 0x1

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 506
    if-eq v4, v15, :cond_3

    if-ne v4, v14, :cond_1

    .line 507
    goto :goto_3

    .line 509
    :cond_1
    add-int/lit8 v13, v13, 0x1

    .line 510
    goto :goto_2

    .line 504
    :cond_2
    const/16 v16, 0x1

    .line 511
    :cond_3
    :goto_3
    nop

    .line 512
    :goto_4
    if-ge v2, v13, :cond_4

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 513
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 515
    :cond_4
    move v4, v13

    .line 516
    :goto_5
    if-le v4, v2, :cond_5

    add-int/lit8 v15, v4, -0x1

    invoke-virtual {v0, v15}, Ljava/lang/String;->charAt(I)C

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v15

    if-eqz v15, :cond_5

    .line 517
    add-int/lit8 v4, v4, -0x1

    const/16 v15, 0xa

    goto :goto_5

    .line 519
    :cond_5
    if-ge v2, v4, :cond_15

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v15

    const/16 v14, 0x23

    if-eq v15, v14, :cond_15

    .line 520
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->countWords(Ljava/lang/String;II)I

    move-result v14

    .line 521
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v15

    .line 522
    const-string v3, "TITLE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_14

    .line 523
    const-string v3, "LUT_IN_VIDEO_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    move/from16 v12, v16

    goto/16 :goto_8

    .line 525
    :cond_6
    const-string v3, "DOMAIN_MIN"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_11

    .line 526
    const-string v12, "DOMAIN_MAX"

    invoke-static {v0, v2, v15, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_7

    goto/16 :goto_6

    .line 536
    :cond_7
    const-string v3, "LUT_1D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 537
    const-string v3, "LUT_1D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 539
    const-string v3, "LUT_3D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 540
    if-ne v14, v11, :cond_9

    if-nez v9, :cond_9

    .line 543
    invoke-static {v0, v15, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->word(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseSize(Ljava/lang/String;)I

    move-result v2

    .line 544
    int-to-long v3, v2

    mul-long v14, v3, v3

    mul-long/2addr v14, v3

    const-wide/16 v3, 0x3

    mul-long/2addr v14, v3

    .line 545
    const-wide/32 v3, 0x7fffffff

    cmp-long v3, v14, v3

    if-gtz v3, :cond_8

    .line 548
    long-to-int v3, v14

    new-array v3, v3, [F

    .line 549
    move v6, v2

    move-object v9, v3

    move/from16 v12, v16

    goto/16 :goto_8

    .line 546
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 541
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE must appear once before samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 549
    :cond_a
    const-string v3, "LUT_3D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 550
    const/4 v3, 0x3

    if-ne v14, v3, :cond_b

    move/from16 v12, v16

    goto/16 :goto_8

    .line 551
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_INPUT_RANGE needs two finite bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 554
    :cond_c
    const/4 v3, 0x3

    if-eqz v9, :cond_f

    .line 557
    if-ne v14, v3, :cond_e

    .line 560
    add-int/lit8 v3, v10, 0x3

    array-length v12, v9

    if-gt v3, v12, :cond_d

    .line 563
    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v2

    .line 564
    add-int/lit8 v4, v10, 0x1

    aget v12, v2, v3

    aput v12, v9, v10

    .line 565
    add-int/lit8 v3, v4, 0x1

    aget v10, v2, v16

    aput v10, v9, v4

    .line 566
    add-int/lit8 v4, v3, 0x1

    aget v2, v2, v11

    aput v2, v9, v3

    move v10, v4

    move/from16 v12, v16

    goto :goto_8

    .line 561
    :cond_d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "too many RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 558
    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "RGB sample must contain 3 values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 555
    :cond_f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "sample appears before LUT_3D_SIZE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 538
    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1D cube is not a 3D LUT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 527
    :cond_11
    :goto_6
    const/4 v12, 0x4

    if-ne v14, v12, :cond_13

    .line 530
    move/from16 v12, v16

    invoke-static {v0, v2, v4, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v4

    .line 531
    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 532
    move-object v7, v4

    goto :goto_7

    .line 534
    :cond_12
    move-object v8, v4

    .line 536
    :goto_7
    goto :goto_8

    .line 528
    :cond_13
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN line needs 3 finite components"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 522
    :cond_14
    move/from16 v12, v16

    goto :goto_8

    .line 519
    :cond_15
    move/from16 v12, v16

    .line 569
    :goto_8
    if-lt v13, v5, :cond_16

    .line 570
    goto :goto_9

    .line 572
    :cond_16
    add-int/lit8 v2, v13, 0x1

    .line 573
    if-ge v13, v5, :cond_17

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xd

    if-ne v3, v4, :cond_17

    if-ge v2, v5, :cond_17

    .line 574
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_17

    .line 575
    add-int/lit8 v2, v2, 0x1

    .line 577
    :cond_17
    const/4 v3, 0x0

    goto/16 :goto_1

    .line 578
    :cond_18
    :goto_9
    if-lt v6, v11, :cond_1c

    if-eqz v9, :cond_1c

    array-length v0, v9

    if-ne v10, v0, :cond_1c

    .line 581
    if-eqz v7, :cond_1a

    if-eqz v8, :cond_1a

    .line 582
    const/4 v3, 0x0

    :goto_a
    const/4 v0, 0x3

    if-ge v3, v0, :cond_1a

    .line 583
    aget v2, v7, v3

    aget v4, v8, v3

    cmpg-float v2, v2, v4

    if-gez v2, :cond_19

    .line 582
    add-int/lit8 v3, v3, 0x1

    goto :goto_a

    .line 584
    :cond_19
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN_MIN must be below DOMAIN_MAX"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 588
    :cond_1a
    if-eqz v1, :cond_1b

    array-length v0, v1

    if-lez v0, :cond_1b

    .line 589
    const/16 v17, 0x0

    aput v6, v1, v17

    .line 591
    :cond_1b
    return-object v9

    .line 579
    :cond_1c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube is missing LUT_3D_SIZE or the N^3 RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 489
    :cond_1d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube text is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static parseFinite(Ljava/lang/String;)F
    .locals 1

    .line 630
    :try_start_0
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 633
    nop

    .line 634
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 637
    return p0

    .line 635
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not finite"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 631
    :catch_0
    move-exception p0

    .line 632
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not a number"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static parseSize(Ljava/lang/String;)I
    .locals 4

    .line 595
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

    .line 600
    :try_start_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 603
    nop

    .line 604
    const/4 v0, 0x2

    if-lt p0, v0, :cond_0

    const/16 v0, 0x40

    if-gt p0, v0, :cond_0

    .line 607
    return p0

    .line 605
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 601
    :catch_0
    move-exception p0

    .line 602
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 596
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static readTriple(Ljava/lang/String;IIZ)[F
    .locals 3

    .line 611
    nop

    .line 612
    if-eqz p3, :cond_0

    .line 613
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    .line 615
    :cond_0
    const/4 p3, 0x3

    new-array v0, p3, [F

    .line 616
    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_2

    .line 617
    :goto_1
    if-ge p1, p2, :cond_1

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 618
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 620
    :cond_1
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v2

    .line 621
    invoke-virtual {p0, p1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseFinite(Ljava/lang/String;)F

    move-result p1

    aput p1, v0, v1

    .line 622
    nop

    .line 616
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 624
    :cond_2
    return-object v0
.end method

.method private static smoothstep(FFF)F
    .locals 0

    .line 451
    sub-float/2addr p2, p0

    sub-float/2addr p1, p0

    div-float/2addr p2, p1

    invoke-static {p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    .line 452
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

    .line 468
    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gtz v0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 469
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_1

    const/16 p0, 0xff

    return p0

    .line 470
    :cond_1
    const/high16 v0, 0x45800000    # 4096.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p0, v0

    float-to-int p0, p0

    .line 471
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

    .line 641
    nop

    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 642
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 644
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static wordEnd(Ljava/lang/String;II)I
    .locals 1

    .line 664
    nop

    .line 665
    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-nez v0, :cond_0

    .line 666
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 668
    :cond_0
    return p1
.end method
