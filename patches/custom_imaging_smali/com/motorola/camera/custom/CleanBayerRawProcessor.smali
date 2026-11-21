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

.method private static encode(D)F
    .locals 5

    .line 223
    const-wide/16 v0, 0x0

    cmpg-double v0, p0, v0

    if-gtz v0, :cond_0

    .line 224
    const/4 p0, 0x0

    return p0

    .line 226
    :cond_0
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_1

    .line 227
    const/high16 p0, 0x3f800000    # 1.0f

    return p0

    .line 229
    :cond_1
    const-wide/high16 v0, 0x40b0000000000000L    # 4096.0

    mul-double/2addr p0, v0

    .line 230
    double-to-int v0, p0

    .line 231
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

    .line 206
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

    .line 207
    if-eqz p0, :cond_1

    array-length v3, p0

    if-ne v3, v0, :cond_1

    .line 208
    nop

    :goto_0
    if-ge v2, v0, :cond_1

    .line 209
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

    .line 210
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

    .line 211
    invoke-static {v9, v10}, Ljava/lang/Math;->abs(D)D

    move-result-wide v9

    add-double/2addr v7, v9

    .line 212
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

    .line 213
    aget v7, p0, v2

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v2

    .line 214
    aget v7, p0, v5

    float-to-double v7, v7

    div-double/2addr v7, v3

    aput-wide v7, v1, v5

    .line 215
    aget v5, p0, v6

    float-to-double v7, v5

    div-double/2addr v7, v3

    aput-wide v7, v1, v6

    .line 208
    :cond_0
    add-int/lit8 v2, v2, 0x3

    goto :goto_0

    .line 219
    :cond_1
    return-object v1
.end method

.method private static pack(FFF)I
    .locals 2

    .line 257
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

    .line 258
    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p1

    or-int/2addr p0, p1

    .line 257
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

    .line 89
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pixelCount(II)I

    move-result v6

    .line 90
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

    .line 94
    invoke-static/range {p5 .. p5}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    invoke-static/range {p8 .. p8}, Ljava/lang/Float;->isFinite(F)Z

    move-result v9

    if-eqz v9, :cond_1f

    .line 97
    sget-object v9, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->CFA:[[I

    aget-object v3, v9, v3

    .line 98
    new-array v9, v10, [D

    .line 99
    const/4 v12, 0x0

    :goto_0
    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    move v15, v8

    move-object/from16 p3, v9

    if-ge v12, v10, :cond_1

    .line 100
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

    .line 101
    cmpg-double v7, v11, v21

    if-lez v7, :cond_0

    invoke-static {v11, v12}, Ljava/lang/Double;->isFinite(D)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 104
    div-double/2addr v13, v11

    aput-wide v13, p3, v18

    .line 99
    add-int/lit8 v12, v18, 0x1

    move-object/from16 v9, p3

    move/from16 v10, v16

    move/from16 v8, v19

    const/4 v7, 0x2

    goto :goto_0

    .line 102
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White level must exceed each finite black level"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 106
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

    .line 107
    invoke-static {v10}, Ljava/lang/Float;->isFinite(F)Z

    move-result v11

    if-eqz v11, :cond_2

    cmpg-float v9, v10, v9

    if-ltz v9, :cond_2

    .line 106
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 108
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "White balance gains must be finite and nonnegative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 112
    :cond_3
    new-array v7, v6, [F

    .line 113
    move/from16 v8, v17

    :goto_2
    const/4 v10, 0x1

    if-ge v8, v2, :cond_5

    .line 114
    and-int/lit8 v11, v8, 0x1

    shl-int/2addr v11, v10

    .line 115
    mul-int v12, v8, v1

    move/from16 v15, v17

    :goto_3
    if-ge v15, v1, :cond_4

    .line 116
    and-int/lit8 v18, v15, 0x1

    or-int v18, v11, v18

    .line 117
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

    .line 118
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

    .line 115
    add-int/lit8 v15, v15, 0x1

    add-int/lit8 v12, v12, 0x1

    move/from16 v9, p5

    move/from16 v10, v23

    move/from16 v11, v24

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_3

    .line 113
    :cond_4
    move/from16 p5, v9

    add-int/lit8 v8, v8, 0x1

    const-wide/high16 v13, 0x3ff0000000000000L    # 1.0

    const-wide/16 v21, 0x0

    goto :goto_2

    .line 122
    :cond_5
    move/from16 p5, v9

    move/from16 v23, v10

    invoke-static/range {p7 .. p7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->normalizedMatrix([F)[D

    move-result-object v0

    .line 123
    move-object v4, v0

    new-array v0, v6, [I

    .line 125
    cmpl-float v5, p8, p5

    const/4 v8, 0x0

    if-lez v5, :cond_6

    new-array v9, v6, [F

    goto :goto_4

    :cond_6
    move-object v9, v8

    .line 126
    :goto_4
    if-lez v5, :cond_7

    new-array v10, v6, [F

    goto :goto_5

    :cond_7
    move-object v10, v8

    .line 127
    :goto_5
    if-lez v5, :cond_8

    new-array v11, v6, [F

    goto :goto_6

    :cond_8
    move-object v11, v8

    .line 128
    :goto_6
    if-lez v5, :cond_9

    new-array v8, v6, [F

    :cond_9
    move-object v6, v8

    .line 130
    move/from16 v5, v17

    :goto_7
    if-ge v5, v2, :cond_1d

    .line 131
    if-nez v5, :cond_a

    move v8, v1

    goto :goto_8

    :cond_a
    neg-int v8, v1

    .line 132
    :goto_8
    add-int/lit8 v12, v2, -0x1

    if-ne v5, v12, :cond_b

    neg-int v12, v1

    goto :goto_9

    :cond_b
    move v12, v1

    .line 133
    :goto_9
    mul-int v13, v5, v1

    move/from16 v14, v17

    :goto_a
    if-ge v14, v1, :cond_1c

    .line 134
    if-nez v14, :cond_c

    move/from16 v18, v23

    goto :goto_b

    :cond_c
    const/16 v18, -0x1

    .line 135
    :goto_b
    add-int/lit8 v15, v1, -0x1

    if-ne v14, v15, :cond_d

    const/4 v15, -0x1

    goto :goto_c

    :cond_d
    move/from16 v15, v23

    .line 136
    :goto_c
    and-int/lit8 v24, v5, 0x1

    shl-int/lit8 v24, v24, 0x1

    and-int/lit8 v25, v14, 0x1

    or-int v24, v24, v25

    .line 137
    move-object/from16 v25, v0

    aget v0, v3, v24

    .line 138
    aget v1, v7, v13

    float-to-double v1, v1

    .line 139
    add-int v26, v13, v18

    move-wide/from16 p3, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v26, v13, v15

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-double v1, p5, v1

    .line 140
    add-int v26, v13, v8

    move-wide/from16 p5, v1

    aget v1, v7, v26

    float-to-double v1, v1

    add-int v27, v13, v12

    move-wide/from16 v28, v1

    aget v1, v7, v27

    float-to-double v1, v1

    add-double v1, v28, v1

    .line 141
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

    .line 143
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

    .line 144
    :goto_d
    nop

    .line 145
    nop

    .line 146
    if-eqz v15, :cond_f

    .line 147
    add-int/lit8 v18, v13, -0x2

    move-wide/from16 v26, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-int/lit8 v18, v13, 0x2

    move-wide/from16 v31, v1

    aget v1, v7, v18

    float-to-double v1, v1

    add-double v1, v31, v1

    .line 148
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

    .line 146
    :cond_f
    move-wide/from16 v26, v1

    const-wide/16 v1, 0x0

    const-wide/16 v31, 0x0

    .line 156
    :goto_e
    const-wide/high16 v33, 0x4020000000000000L    # 8.0

    const-wide/high16 v35, 0x4000000000000000L    # 2.0

    const-wide/high16 v37, 0x4010000000000000L    # 4.0

    move-wide/from16 v39, v1

    move/from16 v1, v23

    if-ne v0, v1, :cond_15

    .line 157
    nop

    .line 158
    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    const-wide/high16 v41, 0x4014000000000000L    # 5.0

    if-eqz v15, :cond_10

    .line 159
    mul-double v43, p3, v41

    mul-double v45, p5, v37

    add-double v43, v43, v45

    sub-double v43, v43, v26

    sub-double v43, v43, v39

    mul-double v45, v31, v0

    add-double v43, v43, v45

    div-double v43, v43, v33

    goto :goto_f

    .line 160
    :cond_10
    div-double v43, p5, v35

    .line 161
    :goto_f
    if-eqz v15, :cond_11

    .line 162
    mul-double v35, p3, v41

    mul-double v28, v29, v37

    add-double v35, v35, v28

    sub-double v35, v35, v26

    sub-double v35, v35, v31

    mul-double v1, v39, v0

    add-double v35, v35, v1

    div-double v35, v35, v33

    goto :goto_10

    .line 163
    :cond_11
    div-double v35, v29, v35

    .line 164
    :goto_10
    xor-int/lit8 v0, v24, 0x1

    aget v0, v3, v0

    if-nez v0, :cond_12

    const/4 v1, 0x1

    goto :goto_11

    :cond_12
    move/from16 v1, v17

    .line 165
    :goto_11
    if-eqz v1, :cond_13

    move-wide/from16 v26, v43

    goto :goto_12

    :cond_13
    move-wide/from16 v26, v35

    .line 166
    :goto_12
    if-eqz v1, :cond_14

    move-wide/from16 v43, v35

    .line 167
    :cond_14
    move-wide/from16 v1, p3

    goto :goto_16

    .line 168
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

    .line 169
    :cond_16
    add-double v1, p5, v29

    div-double v1, v1, v37

    .line 170
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

    .line 171
    :cond_17
    div-double v28, v26, v37

    .line 172
    :goto_14
    if-nez v0, :cond_18

    move-wide/from16 v26, p3

    goto :goto_15

    :cond_18
    move-wide/from16 v26, v28

    .line 173
    :goto_15
    const/4 v15, 0x2

    if-ne v0, v15, :cond_19

    move-wide/from16 v28, p3

    :cond_19
    move-wide/from16 v43, v28

    .line 176
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

    .line 177
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

    .line 178
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

    .line 179
    move-object/from16 p3, v6

    move-object/from16 v24, v7

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    invoke-static {v0, v1, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v6

    .line 180
    nop

    .line 181
    const-wide v26, 0x3fe999999999999aL    # 0.8

    cmpl-double v28, v6, v26

    if-lez v28, :cond_1a

    .line 182
    sub-double v28, v6, v26

    .line 184
    const-wide v30, 0x3fc999999999999aL    # 0.2

    add-double v32, v28, v30

    div-double v28, v28, v32

    mul-double v28, v28, v30

    add-double v28, v28, v26

    div-double v28, v28, v6

    goto :goto_17

    .line 181
    :cond_1a
    const-wide/high16 v28, 0x3ff0000000000000L    # 1.0

    .line 186
    :goto_17
    mul-double v0, v0, v28

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v0

    .line 187
    mul-double v2, v2, v28

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v1

    .line 188
    mul-double v4, v4, v28

    invoke-static {v4, v5}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->encode(D)F

    move-result v2

    .line 189
    if-nez p3, :cond_1b

    .line 190
    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v0

    aput v0, v25, v13

    goto :goto_18

    .line 192
    :cond_1b
    aput v0, v9, v13

    .line 193
    aput v1, v10, v13

    .line 194
    aput v2, v11, v13

    .line 195
    const v3, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v0, v3

    const v3, 0x3f371759    # 0.7152f

    mul-float/2addr v1, v3

    add-float/2addr v0, v1

    const v1, 0x3d93dd98    # 0.0722f

    mul-float/2addr v2, v1

    add-float/2addr v0, v2

    aput v0, p3, v13

    .line 133
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

    .line 130
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

    .line 199
    :cond_1d
    move-object/from16 v25, v0

    move-object/from16 p3, v6

    if-eqz p3, :cond_1e

    .line 200
    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v6, p3

    move/from16 v7, p8

    move-object v3, v9

    move-object v4, v10

    move-object v5, v11

    move-object/from16 v0, v25

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->sharpen([III[F[F[F[FF)V

    .line 202
    :cond_1e
    return-object v25

    .line 95
    :cond_1f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid Bayer image or calibration"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static sharpen([III[F[F[F[FF)V
    .locals 17

    .line 236
    move/from16 v0, p1

    move/from16 v1, p2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_7

    .line 237
    if-nez v3, :cond_0

    const/4 v4, 0x0

    goto :goto_1

    :cond_0
    neg-int v4, v0

    .line 238
    :goto_1
    add-int/lit8 v5, v1, -0x1

    if-ne v3, v5, :cond_1

    const/4 v5, 0x0

    goto :goto_2

    :cond_1
    move v5, v0

    .line 239
    :goto_2
    mul-int v6, v3, v0

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v0, :cond_6

    .line 240
    if-nez v7, :cond_2

    const/4 v8, 0x0

    goto :goto_4

    :cond_2
    const/4 v8, -0x1

    .line 241
    :goto_4
    add-int/lit8 v9, v0, -0x1

    if-ne v7, v9, :cond_3

    const/4 v9, 0x0

    goto :goto_5

    :cond_3
    const/4 v9, 0x1

    .line 242
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

    .line 245
    aget v8, p6, v6

    sub-float/2addr v8, v11

    float-to-double v8, v8

    move/from16 v10, p7

    float-to-double v11, v10

    mul-double/2addr v8, v11

    .line 246
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

    .line 247
    :cond_4
    aget v13, p3, v6

    aget v14, p4, v6

    aget v15, p5, v6

    invoke-static {v14, v15}, Ljava/lang/Math;->min(FF)F

    move-result v14

    invoke-static {v13, v14}, Ljava/lang/Math;->min(FF)F

    move-result v13

    float-to-double v13, v13

    .line 249
    :goto_6
    move/from16 v16, v3

    const-wide v2, 0x3f90101010101010L    # 0.01568627450980392

    invoke-static {v13, v14, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    .line 250
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

    .line 251
    aget v3, p3, v6

    add-float/2addr v3, v2

    aget v8, p4, v6

    add-float/2addr v8, v2

    aget v9, p5, v6

    add-float/2addr v9, v2

    invoke-static {v3, v8, v9}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->pack(FFF)I

    move-result v2

    aput v2, p0, v6

    .line 239
    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v6, v6, 0x1

    move/from16 v3, v16

    goto/16 :goto_3

    .line 236
    :cond_6
    move/from16 v10, p7

    move/from16 v16, v3

    add-int/lit8 v3, v16, 0x1

    goto/16 :goto_0

    .line 254
    :cond_7
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
