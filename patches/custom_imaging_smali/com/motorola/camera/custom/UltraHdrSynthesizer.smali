.class public final Lcom/motorola/camera/custom/UltraHdrSynthesizer;
.super Ljava/lang/Object;
.source "UltraHdrSynthesizer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
    }
.end annotation


# static fields
.field public static final DEFAULT_SDR_SHOULDER_HEADROOM:F = 2.85f

.field public static final EPSILON:F = 0.015625f

.field public static final MAX_ALLOWED_HEADROOM:F = 8.0f

.field public static final MIN_MEANINGFUL_HEADROOM:F = 1.06f

.field private static final SRGB_TO_LIN:[F


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 23
    const/16 v0, 0x100

    new-array v1, v0, [F

    sput-object v1, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    .line 26
    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    .line 27
    int-to-double v2, v1

    const-wide v4, 0x406fe00000000000L    # 255.0

    div-double/2addr v2, v4

    .line 28
    sget-object v4, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    const-wide v5, 0x3fa4b5dcc63f1412L    # 0.04045

    cmpg-double v5, v2, v5

    if-gtz v5, :cond_0

    const-wide v5, 0x4029d70a3d70a3d7L    # 12.92

    div-double/2addr v2, v5

    goto :goto_1

    :cond_0
    const-wide v5, 0x3fac28f5c28f5c29L    # 0.055

    add-double/2addr v2, v5

    const-wide v5, 0x3ff0e147ae147ae1L    # 1.055

    div-double/2addr v2, v5

    const-wide v5, 0x4003333333333333L    # 2.4

    invoke-static {v2, v3, v5, v6}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    :goto_1
    double-to-float v2, v2

    aput v2, v4, v1

    .line 26
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 30
    :cond_1
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static cellHighlightRatio(IIF)F
    .locals 3

    .line 259
    sget-object v0, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    aget v0, v0, p0

    .line 260
    sget-object v1, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    aget p1, v1, p1

    .line 261
    const/16 v1, 0xcc

    if-gt p0, v1, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    sub-int/2addr p0, v1

    int-to-float p0, p0

    const/high16 v1, 0x424c0000    # 51.0f

    div-float/2addr p0, v1

    .line 262
    :goto_0
    mul-float v1, p0, p0

    const/high16 v2, 0x40000000    # 2.0f

    mul-float/2addr p0, v2

    const/high16 v2, 0x40400000    # 3.0f

    sub-float/2addr v2, p0

    mul-float/2addr v1, v2

    .line 263
    const/high16 p0, 0x3f800000    # 1.0f

    sub-float v2, p2, p0

    mul-float/2addr v2, v1

    add-float/2addr v2, p0

    mul-float/2addr v2, v0

    invoke-static {v0, v2}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 264
    const/high16 v1, 0x3c800000    # 0.015625f

    add-float/2addr v0, v1

    add-float/2addr p1, v1

    div-float/2addr v0, p1

    .line 265
    invoke-static {p2, v0}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-static {p0, p1}, Ljava/lang/Math;->max(FF)F

    move-result p0

    return p0
.end method

.method public static computeFromLinearAndSdr([F[IIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
    .locals 28

    .line 63
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    if-eqz v0, :cond_12

    if-eqz v1, :cond_12

    const/4 v5, 0x4

    if-lt v2, v5, :cond_12

    if-ge v3, v5, :cond_0

    const/16 v16, 0x0

    goto/16 :goto_8

    .line 64
    :cond_0
    mul-int v6, v2, v3

    .line 65
    array-length v7, v0

    if-lt v7, v6, :cond_11

    array-length v7, v1

    if-ge v7, v6, :cond_1

    const/16 v16, 0x0

    goto/16 :goto_7

    .line 67
    :cond_1
    add-int/lit8 v6, v2, 0x3

    div-int/2addr v6, v5

    const/4 v7, 0x1

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 68
    add-int/lit8 v8, v3, 0x3

    div-int/2addr v8, v5

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 69
    mul-int v7, v6, v5

    new-array v7, v7, [F

    .line 70
    nop

    .line 71
    invoke-static/range {p4 .. p4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v8

    if-eqz v8, :cond_2

    move/from16 v8, p4

    goto :goto_0

    :cond_2
    const v8, 0x40366666    # 2.85f

    .line 70
    :goto_0
    const/high16 v9, 0x41000000    # 8.0f

    invoke-static {v9, v8}, Ljava/lang/Math;->min(FF)F

    move-result v8

    const v9, 0x3f8ccccd    # 1.1f

    invoke-static {v9, v8}, Ljava/lang/Math;->max(FF)F

    move-result v8

    .line 72
    nop

    .line 73
    nop

    .line 75
    const/4 v11, 0x0

    const/high16 v12, 0x3f800000    # 1.0f

    const/4 v13, 0x0

    :goto_1
    if-ge v11, v5, :cond_e

    .line 76
    mul-int/lit8 v15, v11, 0x4

    .line 77
    const/16 v16, 0x0

    add-int/lit8 v4, v15, 0x4

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 78
    const/4 v9, 0x0

    :goto_2
    if-ge v9, v6, :cond_d

    .line 79
    mul-int/lit8 v17, v9, 0x4

    .line 80
    const/high16 v18, 0x3f800000    # 1.0f

    add-int/lit8 v10, v17, 0x4

    invoke-static {v2, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 81
    nop

    .line 82
    nop

    .line 83
    nop

    .line 84
    const/16 v19, 0x0

    move v14, v15

    move/from16 v22, v18

    move/from16 v21, v19

    const/4 v0, 0x0

    const v20, 0x3f87ae14    # 1.06f

    :goto_3
    if-ge v14, v4, :cond_9

    .line 85
    mul-int v23, v14, v2

    .line 86
    move/from16 v24, v0

    move/from16 v0, v17

    :goto_4
    if-ge v0, v10, :cond_8

    .line 87
    add-int v25, v23, v0

    .line 88
    aget v26, p0, v25

    .line 89
    invoke-static/range {v26 .. v26}, Ljava/lang/Float;->isFinite(F)Z

    move-result v27

    if-eqz v27, :cond_3

    cmpg-float v27, v26, v19

    if-gtz v27, :cond_4

    :cond_3
    move/from16 v26, v19

    .line 90
    :cond_4
    move/from16 v27, v0

    aget v0, v1, v25

    .line 91
    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    .line 92
    ushr-int/lit8 v2, v0, 0x8

    and-int/lit16 v2, v2, 0xff

    .line 93
    and-int/lit16 v0, v0, 0xff

    .line 94
    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 95
    sget-object v1, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    aget v0, v1, v0

    .line 96
    const/high16 v1, 0x3c800000    # 0.015625f

    add-float v26, v26, v1

    add-float/2addr v0, v1

    div-float v26, v26, v0

    .line 97
    cmpg-float v0, v26, v18

    if-gez v0, :cond_5

    move/from16 v26, v18

    .line 98
    :cond_5
    cmpl-float v0, v26, v8

    if-lez v0, :cond_6

    move/from16 v26, v8

    .line 99
    :cond_6
    cmpl-float v0, v26, v22

    if-lez v0, :cond_7

    move/from16 v22, v26

    .line 100
    :cond_7
    add-float v21, v21, v26

    .line 101
    add-int/lit8 v24, v24, 0x1

    .line 86
    add-int/lit8 v0, v27, 0x1

    move-object/from16 v1, p1

    move/from16 v2, p2

    goto :goto_4

    .line 84
    :cond_8
    add-int/lit8 v14, v14, 0x1

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v0, v24

    goto :goto_3

    .line 104
    :cond_9
    if-lez v0, :cond_a

    int-to-float v0, v0

    div-float v21, v21, v0

    goto :goto_5

    :cond_a
    move/from16 v21, v18

    .line 106
    :goto_5
    const v0, 0x3f266666    # 0.65f

    mul-float v21, v21, v0

    const v0, 0x3eb33333    # 0.35f

    mul-float v22, v22, v0

    add-float v21, v21, v22

    .line 107
    mul-int v0, v11, v6

    add-int/2addr v0, v9

    aput v21, v7, v0

    .line 108
    cmpl-float v0, v21, v12

    if-lez v0, :cond_b

    move/from16 v12, v21

    .line 109
    :cond_b
    cmpl-float v0, v21, v20

    if-ltz v0, :cond_c

    add-int/lit8 v13, v13, 0x1

    .line 78
    :cond_c
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    goto/16 :goto_2

    .line 75
    :cond_d
    const/high16 v18, 0x3f800000    # 1.0f

    add-int/lit8 v11, v11, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    goto/16 :goto_1

    .line 113
    :cond_e
    const/16 v16, 0x0

    const v20, 0x3f87ae14    # 1.06f

    cmpg-float v0, v12, v20

    if-ltz v0, :cond_10

    if-nez v13, :cond_f

    goto :goto_6

    .line 116
    :cond_f
    invoke-static {v7, v6, v5, v12}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->encodeLog2Plane([FIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    move-result-object v0

    return-object v0

    .line 114
    :cond_10
    :goto_6
    return-object v16

    .line 65
    :cond_11
    const/16 v16, 0x0

    :goto_7
    return-object v16

    .line 63
    :cond_12
    const/16 v16, 0x0

    :goto_8
    return-object v16
.end method

.method public static computeFromPreAndPostSdr([I[IIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
    .locals 28

    .line 126
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    if-eqz v0, :cond_11

    if-eqz v1, :cond_11

    const/4 v5, 0x4

    if-lt v2, v5, :cond_11

    if-ge v3, v5, :cond_0

    const/16 v18, 0x0

    goto/16 :goto_9

    .line 127
    :cond_0
    mul-int v6, v2, v3

    .line 128
    array-length v7, v0

    if-lt v7, v6, :cond_10

    array-length v7, v1

    if-ge v7, v6, :cond_1

    const/16 v18, 0x0

    goto/16 :goto_8

    .line 130
    :cond_1
    add-int/lit8 v6, v2, 0x3

    div-int/2addr v6, v5

    const/4 v7, 0x1

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 131
    add-int/lit8 v8, v3, 0x3

    div-int/2addr v8, v5

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 132
    mul-int v8, v6, v5

    new-array v9, v8, [F

    .line 133
    nop

    .line 134
    invoke-static/range {p4 .. p4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v10

    if-eqz v10, :cond_2

    move/from16 v10, p4

    goto :goto_0

    :cond_2
    const v10, 0x40366666    # 2.85f

    .line 133
    :goto_0
    const/high16 v11, 0x40800000    # 4.0f

    invoke-static {v11, v10}, Ljava/lang/Math;->min(FF)F

    move-result v10

    const/high16 v11, 0x3fa00000    # 1.25f

    invoke-static {v11, v10}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 135
    nop

    .line 136
    nop

    .line 138
    const/4 v13, 0x0

    const/high16 v14, 0x3f800000    # 1.0f

    const/4 v15, 0x0

    :goto_1
    const v16, 0x3f87ae14    # 1.06f

    if-ge v13, v5, :cond_d

    .line 139
    mul-int/lit8 v17, v13, 0x4

    .line 140
    const/16 v18, 0x0

    add-int/lit8 v4, v17, 0x4

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 141
    const/4 v11, 0x0

    :goto_2
    if-ge v11, v6, :cond_c

    .line 142
    mul-int/lit8 v19, v11, 0x4

    .line 143
    const/high16 v20, 0x3f800000    # 1.0f

    add-int/lit8 v12, v19, 0x4

    invoke-static {v2, v12}, Ljava/lang/Math;->min(II)I

    move-result v12

    .line 144
    nop

    .line 145
    nop

    .line 146
    nop

    .line 147
    const/16 v21, 0x0

    move/from16 v7, v17

    move/from16 v23, v20

    move/from16 v22, v21

    const/4 v0, 0x0

    :goto_3
    if-ge v7, v4, :cond_8

    .line 148
    mul-int v24, v7, v2

    .line 149
    move/from16 v25, v0

    move/from16 v0, v19

    :goto_4
    if-ge v0, v12, :cond_7

    .line 150
    add-int v26, v24, v0

    .line 151
    move/from16 v27, v0

    aget v0, p0, v26

    .line 152
    aget v1, p1, v26

    .line 153
    ushr-int/lit8 v2, v0, 0x10

    and-int/lit16 v2, v2, 0xff

    ushr-int/lit8 v3, v0, 0x8

    and-int/lit16 v3, v3, 0xff

    and-int/lit16 v0, v0, 0xff

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 154
    ushr-int/lit8 v2, v1, 0x10

    and-int/lit16 v2, v2, 0xff

    ushr-int/lit8 v3, v1, 0x8

    and-int/lit16 v3, v3, 0xff

    and-int/lit16 v1, v1, 0xff

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 155
    sget-object v2, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    aget v2, v2, v0

    .line 156
    sget-object v3, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->SRGB_TO_LIN:[F

    aget v1, v3, v1

    .line 158
    const/16 v3, 0xcc

    if-gt v0, v3, :cond_3

    move/from16 v0, v21

    goto :goto_5

    :cond_3
    add-int/lit16 v0, v0, -0xcc

    int-to-float v0, v0

    const/high16 v3, 0x424c0000    # 51.0f

    div-float/2addr v0, v3

    .line 159
    :goto_5
    mul-float v3, v0, v0

    const/high16 v26, 0x40000000    # 2.0f

    mul-float v0, v0, v26

    const/high16 v26, 0x40400000    # 3.0f

    sub-float v26, v26, v0

    mul-float v3, v3, v26

    .line 160
    sub-float v0, v10, v20

    mul-float/2addr v0, v3

    add-float v0, v0, v20

    mul-float/2addr v0, v2

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 161
    const/high16 v2, 0x3c800000    # 0.015625f

    add-float/2addr v0, v2

    add-float/2addr v1, v2

    div-float/2addr v0, v1

    .line 162
    cmpg-float v1, v0, v20

    if-gez v1, :cond_4

    move/from16 v0, v20

    .line 163
    :cond_4
    cmpl-float v1, v0, v10

    if-lez v1, :cond_5

    move v0, v10

    .line 164
    :cond_5
    add-float v22, v22, v0

    .line 165
    cmpl-float v1, v0, v23

    if-lez v1, :cond_6

    move/from16 v23, v0

    .line 166
    :cond_6
    add-int/lit8 v25, v25, 0x1

    .line 149
    add-int/lit8 v0, v27, 0x1

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    goto :goto_4

    .line 147
    :cond_7
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v0, v25

    goto/16 :goto_3

    .line 169
    :cond_8
    if-lez v0, :cond_9

    int-to-float v0, v0

    div-float v22, v22, v0

    const v0, 0x3f333333    # 0.7f

    mul-float v22, v22, v0

    const v0, 0x3e99999a    # 0.3f

    mul-float v23, v23, v0

    add-float v22, v22, v23

    goto :goto_6

    :cond_9
    move/from16 v22, v20

    .line 170
    :goto_6
    mul-int v0, v13, v6

    add-int/2addr v0, v11

    aput v22, v9, v0

    .line 171
    cmpl-float v0, v22, v14

    if-lez v0, :cond_a

    move/from16 v14, v22

    .line 172
    :cond_a
    cmpl-float v0, v22, v16

    if-ltz v0, :cond_b

    add-int/lit8 v15, v15, 0x1

    .line 141
    :cond_b
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    const/4 v7, 0x1

    goto/16 :goto_2

    .line 138
    :cond_c
    const/high16 v20, 0x3f800000    # 1.0f

    add-int/lit8 v13, v13, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    const/4 v7, 0x1

    goto/16 :goto_1

    .line 177
    :cond_d
    const/16 v18, 0x0

    div-int/lit16 v8, v8, 0x1f4

    const/4 v0, 0x1

    invoke-static {v0, v8}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 178
    cmpg-float v1, v14, v16

    if-ltz v1, :cond_f

    if-ge v15, v0, :cond_e

    goto :goto_7

    .line 181
    :cond_e
    invoke-static {v9, v6, v5, v14}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->encodeLog2Plane([FIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    move-result-object v0

    return-object v0

    .line 179
    :cond_f
    :goto_7
    return-object v18

    .line 128
    :cond_10
    const/16 v18, 0x0

    :goto_8
    return-object v18

    .line 126
    :cond_11
    const/16 v18, 0x0

    :goto_9
    return-object v18
.end method

.method public static computeFromQuarterPeakStats([B[BIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
    .locals 17

    .line 228
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    if-eqz v0, :cond_9

    if-eqz v1, :cond_9

    const/4 v5, 0x4

    if-lt v2, v5, :cond_9

    if-ge v3, v5, :cond_0

    const/16 v16, 0x0

    goto/16 :goto_4

    .line 229
    :cond_0
    add-int/lit8 v2, v2, 0x3

    div-int/2addr v2, v5

    const/4 v6, 0x1

    invoke-static {v6, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 230
    add-int/lit8 v3, v3, 0x3

    div-int/2addr v3, v5

    invoke-static {v6, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 231
    mul-int v5, v2, v3

    .line 232
    array-length v7, v0

    mul-int/lit8 v8, v5, 0x2

    if-lt v7, v8, :cond_8

    array-length v7, v1

    if-ge v7, v8, :cond_1

    const/16 v16, 0x0

    goto/16 :goto_3

    .line 233
    :cond_1
    new-array v7, v5, [F

    .line 234
    nop

    .line 235
    invoke-static/range {p4 .. p4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v8

    if-eqz v8, :cond_2

    move/from16 v8, p4

    goto :goto_0

    :cond_2
    const v8, 0x40366666    # 2.85f

    .line 234
    :goto_0
    const/high16 v9, 0x40800000    # 4.0f

    invoke-static {v9, v8}, Ljava/lang/Math;->min(FF)F

    move-result v8

    const/high16 v9, 0x3fa00000    # 1.25f

    invoke-static {v9, v8}, Ljava/lang/Math;->max(FF)F

    move-result v8

    .line 236
    nop

    .line 237
    nop

    .line 238
    const/4 v9, 0x0

    const/high16 v10, 0x3f800000    # 1.0f

    move v11, v10

    move v10, v9

    :goto_1
    const v12, 0x3f87ae14    # 1.06f

    if-ge v9, v5, :cond_5

    .line 239
    mul-int/lit8 v13, v9, 0x2

    aget-byte v14, v0, v13

    and-int/lit16 v14, v14, 0xff

    .line 240
    add-int/lit8 v15, v13, 0x1

    const/16 v16, 0x0

    aget-byte v4, v0, v15

    and-int/lit16 v4, v4, 0xff

    .line 241
    aget-byte v13, v1, v13

    and-int/lit16 v13, v13, 0xff

    .line 242
    aget-byte v15, v1, v15

    and-int/lit16 v15, v15, 0xff

    .line 244
    invoke-static {v14, v13, v8}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->cellHighlightRatio(IIF)F

    move-result v13

    .line 245
    invoke-static {v4, v15, v8}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->cellHighlightRatio(IIF)F

    move-result v4

    .line 246
    const v14, 0x3f333333    # 0.7f

    mul-float/2addr v13, v14

    const v14, 0x3e99999a    # 0.3f

    mul-float/2addr v4, v14

    add-float/2addr v13, v4

    .line 247
    aput v13, v7, v9

    .line 248
    cmpl-float v4, v13, v11

    if-lez v4, :cond_3

    move v11, v13

    .line 249
    :cond_3
    cmpl-float v4, v13, v12

    if-ltz v4, :cond_4

    add-int/lit8 v10, v10, 0x1

    .line 238
    :cond_4
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 251
    :cond_5
    const/16 v16, 0x0

    div-int/lit16 v5, v5, 0x1f4

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 252
    cmpg-float v1, v11, v12

    if-ltz v1, :cond_7

    if-ge v10, v0, :cond_6

    goto :goto_2

    .line 255
    :cond_6
    invoke-static {v7, v2, v3, v11}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->encodeLog2Plane([FIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    move-result-object v0

    return-object v0

    .line 253
    :cond_7
    :goto_2
    return-object v16

    .line 232
    :cond_8
    const/16 v16, 0x0

    :goto_3
    return-object v16

    .line 228
    :cond_9
    const/16 v16, 0x0

    :goto_4
    return-object v16
.end method

.method private static encodeLog2Plane([FIIF)Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
    .locals 12

    .line 270
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/UltraHdrSynthesizer;->smoothGrid3x3([FII)[F

    move-result-object p0

    .line 271
    float-to-double v0, p3

    invoke-static {v0, v1}, Ljava/lang/Math;->log(D)D

    move-result-wide v0

    .line 272
    const-wide v2, 0x3ee4f8b588e368f1L    # 1.0E-5

    cmpl-double v2, v0, v2

    if-gtz v2, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 273
    :cond_0
    mul-int v2, p1, p2

    new-array v4, v2, [B

    .line 274
    const/4 v2, 0x0

    :goto_0
    array-length v3, p0

    if-ge v2, v3, :cond_1

    .line 275
    aget v3, p0, v2

    invoke-static {p3, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-static {v5, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    .line 276
    float-to-double v5, v3

    invoke-static {v5, v6}, Ljava/lang/Math;->log(D)D

    move-result-wide v5

    div-double/2addr v5, v0

    .line 277
    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->min(DD)D

    move-result-wide v5

    const-wide/16 v7, 0x0

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    const-wide v7, 0x406fe00000000000L    # 255.0

    mul-double/2addr v5, v7

    invoke-static {v5, v6}, Ljava/lang/Math;->round(D)J

    move-result-wide v5

    long-to-int v3, v5

    .line 278
    int-to-byte v3, v3

    aput-byte v3, v4, v2

    .line 274
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 280
    :cond_1
    new-instance v3, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;

    const/high16 v10, 0x3c800000    # 0.015625f

    const/high16 v11, 0x3c800000    # 0.015625f

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v9, 0x3f800000    # 1.0f

    move v5, p1

    move v6, p2

    move v8, p3

    invoke-direct/range {v3 .. v11}, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;-><init>([BIIFFFFF)V

    return-object v3
.end method

.method public static preserveDisplayP3IfWide(Landroid/graphics/Bitmap;Landroid/graphics/ColorSpace;)Z
    .locals 1

    .line 355
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    if-nez p1, :cond_0

    goto :goto_0

    .line 357
    :cond_0
    :try_start_0
    invoke-virtual {p1}, Landroid/graphics/ColorSpace;->isWideGamut()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 358
    sget-object p1, Landroid/graphics/ColorSpace$Named;->DISPLAY_P3:Landroid/graphics/ColorSpace$Named;

    invoke-static {p1}, Landroid/graphics/ColorSpace;->get(Landroid/graphics/ColorSpace$Named;)Landroid/graphics/ColorSpace;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/graphics/Bitmap;->setColorSpace(Landroid/graphics/ColorSpace;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 359
    const/4 p0, 0x1

    return p0

    .line 361
    :catchall_0
    move-exception p0

    :cond_1
    nop

    .line 362
    return v0

    .line 355
    :cond_2
    :goto_0
    return v0
.end method

.method public static reconstructLinearPeak(FLcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;I)F
    .locals 6

    .line 309
    if-eqz p1, :cond_1

    if-ltz p2, :cond_1

    iget-object v0, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    array-length v0, v0

    if-lt p2, v0, :cond_0

    goto :goto_0

    .line 310
    :cond_0
    iget-object v0, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    aget-byte p2, v0, p2

    and-int/lit16 p2, p2, 0xff

    int-to-float p2, p2

    const/high16 v0, 0x437f0000    # 255.0f

    div-float/2addr p2, v0

    .line 311
    float-to-double v0, p2

    const-wide/high16 v2, 0x3ff0000000000000L    # 1.0

    sub-double/2addr v2, v0

    iget p2, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMin:F

    float-to-double v4, p2

    invoke-static {v4, v5}, Ljava/lang/Math;->log(D)D

    move-result-wide v4

    mul-double/2addr v2, v4

    iget p2, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    float-to-double v4, p2

    invoke-static {v4, v5}, Ljava/lang/Math;->log(D)D

    move-result-wide v4

    mul-double/2addr v0, v4

    add-double/2addr v2, v0

    .line 312
    invoke-static {v2, v3}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float p2, v0

    .line 313
    iget v0, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonSdr:F

    add-float/2addr p0, v0

    mul-float/2addr p0, p2

    iget p1, p1, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonHdr:F

    sub-float/2addr p0, p1

    return p0

    .line 309
    :cond_1
    :goto_0
    return p0
.end method

.method public static sampleQuarterPeakStats(Landroid/graphics/Bitmap;)[B
    .locals 21

    .line 189
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 190
    :cond_0
    invoke-virtual/range {p0 .. p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    .line 191
    invoke-virtual/range {p0 .. p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v9

    .line 192
    const/4 v10, 0x4

    if-lt v4, v10, :cond_8

    if-ge v9, v10, :cond_1

    goto/16 :goto_5

    .line 193
    :cond_1
    add-int/lit8 v0, v4, 0x3

    div-int/2addr v0, v10

    const/4 v11, 0x1

    invoke-static {v11, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 194
    add-int/lit8 v1, v9, 0x3

    div-int/2addr v1, v10

    invoke-static {v11, v1}, Ljava/lang/Math;->max(II)I

    move-result v12

    .line 195
    mul-int v1, v0, v12

    mul-int/lit8 v1, v1, 0x2

    new-array v13, v1, [B

    .line 196
    mul-int/lit8 v1, v4, 0x4

    new-array v2, v1, [I

    .line 197
    const/4 v15, 0x0

    :goto_0
    if-ge v15, v12, :cond_7

    .line 198
    mul-int/lit8 v6, v15, 0x4

    .line 199
    sub-int v1, v9, v6

    invoke-static {v10, v1}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 200
    const/4 v3, 0x0

    const/4 v5, 0x0

    move v7, v4

    move-object/from16 v1, p0

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 201
    const/4 v1, 0x0

    :goto_1
    if-ge v1, v0, :cond_6

    .line 202
    mul-int/lit8 v3, v1, 0x4

    .line 203
    sub-int v5, v4, v3

    invoke-static {v10, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 204
    nop

    .line 205
    nop

    .line 206
    nop

    .line 207
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v10, 0x0

    const/16 v16, 0x0

    :goto_2
    if-ge v6, v8, :cond_4

    .line 208
    mul-int v17, v6, v4

    add-int v17, v17, v3

    .line 209
    move/from16 v18, v11

    const/4 v11, 0x0

    :goto_3
    if-ge v11, v5, :cond_3

    .line 210
    add-int v19, v17, v11

    aget v14, v2, v19

    .line 211
    move/from16 v19, v0

    ushr-int/lit8 v0, v14, 0x10

    and-int/lit16 v0, v0, 0xff

    move/from16 v20, v1

    ushr-int/lit8 v1, v14, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v14, v14, 0xff

    invoke-static {v1, v14}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 212
    add-int v16, v16, v0

    .line 213
    if-le v0, v10, :cond_2

    move v10, v0

    .line 214
    :cond_2
    add-int/lit8 v7, v7, 0x1

    .line 209
    add-int/lit8 v11, v11, 0x1

    move/from16 v0, v19

    move/from16 v1, v20

    goto :goto_3

    .line 207
    :cond_3
    move/from16 v19, v0

    move/from16 v20, v1

    add-int/lit8 v6, v6, 0x1

    move/from16 v11, v18

    goto :goto_2

    .line 217
    :cond_4
    move/from16 v19, v0

    move/from16 v20, v1

    move/from16 v18, v11

    mul-int v0, v15, v19

    add-int v0, v0, v20

    mul-int/lit8 v0, v0, 0x2

    .line 218
    if-lez v7, :cond_5

    shr-int/lit8 v1, v7, 0x1

    add-int v16, v16, v1

    div-int v16, v16, v7

    move/from16 v1, v16

    goto :goto_4

    :cond_5
    const/4 v1, 0x0

    :goto_4
    int-to-byte v1, v1

    aput-byte v1, v13, v0

    .line 219
    add-int/lit8 v0, v0, 0x1

    int-to-byte v1, v10

    aput-byte v1, v13, v0

    .line 201
    add-int/lit8 v1, v20, 0x1

    move/from16 v11, v18

    move/from16 v0, v19

    const/4 v10, 0x4

    goto :goto_1

    .line 197
    :cond_6
    move/from16 v19, v0

    move/from16 v18, v11

    add-int/lit8 v15, v15, 0x1

    const/4 v10, 0x4

    goto/16 :goto_0

    .line 222
    :cond_7
    return-object v13

    .line 192
    :cond_8
    :goto_5
    return-object v0
.end method

.method private static smoothGrid3x3([FII)[F
    .locals 12

    .line 284
    const/4 v0, 0x3

    if-lt p1, v0, :cond_5

    if-ge p2, v0, :cond_0

    goto :goto_4

    .line 285
    :cond_0
    array-length v0, p0

    new-array v0, v0, [F

    .line 286
    array-length v1, p0

    new-array v1, v1, [F

    .line 287
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/high16 v4, 0x3f000000    # 0.5f

    const/high16 v5, 0x3e800000    # 0.25f

    if-ge v3, p2, :cond_2

    .line 288
    mul-int v6, v3, p1

    .line 289
    move v7, v2

    :goto_1
    if-ge v7, p1, :cond_1

    .line 290
    add-int/lit8 v8, v7, -0x1

    invoke-static {v2, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    add-int/2addr v8, v6

    aget v8, p0, v8

    .line 291
    add-int v9, v6, v7

    aget v10, p0, v9

    .line 292
    add-int/lit8 v11, p1, -0x1

    add-int/lit8 v7, v7, 0x1

    invoke-static {v11, v7}, Ljava/lang/Math;->min(II)I

    move-result v11

    add-int/2addr v11, v6

    aget v11, p0, v11

    .line 293
    mul-float/2addr v8, v5

    mul-float/2addr v10, v4

    add-float/2addr v8, v10

    mul-float/2addr v11, v5

    add-float/2addr v8, v11

    aput v8, v0, v9

    .line 289
    goto :goto_1

    .line 287
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 296
    :cond_2
    move p0, v2

    :goto_2
    if-ge p0, p2, :cond_4

    .line 297
    add-int/lit8 v3, p0, -0x1

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    mul-int/2addr v3, p1

    .line 298
    mul-int v6, p0, p1

    .line 299
    add-int/lit8 v7, p2, -0x1

    add-int/lit8 p0, p0, 0x1

    invoke-static {v7, p0}, Ljava/lang/Math;->min(II)I

    move-result v7

    mul-int/2addr v7, p1

    .line 300
    move v8, v2

    :goto_3
    if-ge v8, p1, :cond_3

    .line 301
    add-int v9, v6, v8

    add-int v10, v3, v8

    aget v10, v0, v10

    mul-float/2addr v10, v5

    aget v11, v0, v9

    mul-float/2addr v11, v4

    add-float/2addr v10, v11

    add-int v11, v7, v8

    aget v11, v0, v11

    mul-float/2addr v11, v5

    add-float/2addr v10, v11

    aput v10, v1, v9

    .line 300
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 296
    :cond_3
    goto :goto_2

    .line 304
    :cond_4
    return-object v1

    .line 284
    :cond_5
    :goto_4
    return-object p0
.end method

.method public static toAndroidGainmap(Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;)Landroid/graphics/Gainmap;
    .locals 7

    .line 318
    const/4 v0, 0x0

    if-eqz p0, :cond_5

    iget-object v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    if-eqz v1, :cond_5

    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->width:I

    if-lez v1, :cond_5

    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->height:I

    if-gtz v1, :cond_0

    goto/16 :goto_2

    .line 322
    :cond_0
    nop

    .line 323
    :try_start_0
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->width:I

    and-int/lit8 v1, v1, 0x3

    if-nez v1, :cond_1

    .line 324
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->width:I

    iget v2, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->height:I

    sget-object v3, Landroid/graphics/Bitmap$Config;->ALPHA_8:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v2, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 325
    if-eqz v1, :cond_1

    .line 326
    iget-object v2, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/graphics/Bitmap;->copyPixelsFromBuffer(Ljava/nio/Buffer;)V

    .line 327
    goto :goto_0

    .line 330
    :cond_1
    move-object v1, v0

    :goto_0
    if-nez v1, :cond_3

    .line 331
    iget-object v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    array-length v1, v1

    new-array v2, v1, [I

    .line 332
    const/4 v3, 0x0

    :goto_1
    if-ge v3, v1, :cond_2

    .line 333
    iget-object v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    aget-byte v4, v4, v3

    and-int/lit16 v4, v4, 0xff

    .line 334
    shl-int/lit8 v5, v4, 0x10

    const/high16 v6, -0x1000000

    or-int/2addr v5, v6

    shl-int/lit8 v6, v4, 0x8

    or-int/2addr v5, v6

    or-int/2addr v4, v5

    aput v4, v2, v3

    .line 332
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 336
    :cond_2
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->width:I

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->height:I

    sget-object v4, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v2, v1, v3, v4}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 338
    :cond_3
    if-nez v1, :cond_4

    return-object v0

    .line 339
    :cond_4
    new-instance v2, Landroid/graphics/Gainmap;

    invoke-direct {v2, v1}, Landroid/graphics/Gainmap;-><init>(Landroid/graphics/Bitmap;)V

    .line 340
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMin:F

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMin:F

    iget v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMin:F

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Gainmap;->setRatioMin(FFF)V

    .line 341
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    iget v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Gainmap;->setRatioMax(FFF)V

    .line 342
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gamma:F

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gamma:F

    iget v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gamma:F

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Gainmap;->setGamma(FFF)V

    .line 343
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonSdr:F

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonSdr:F

    iget v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonSdr:F

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Gainmap;->setEpsilonSdr(FFF)V

    .line 344
    iget v1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonHdr:F

    iget v3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonHdr:F

    iget v4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonHdr:F

    invoke-virtual {v2, v1, v3, v4}, Landroid/graphics/Gainmap;->setEpsilonHdr(FFF)V

    .line 345
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v2, v1}, Landroid/graphics/Gainmap;->setMinDisplayRatioForHdrTransition(F)V

    .line 346
    iget p0, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    invoke-virtual {v2, p0}, Landroid/graphics/Gainmap;->setDisplayRatioForFullHdr(F)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 347
    return-object v2

    .line 348
    :catchall_0
    move-exception p0

    .line 349
    return-object v0

    .line 319
    :cond_5
    :goto_2
    return-object v0
.end method
