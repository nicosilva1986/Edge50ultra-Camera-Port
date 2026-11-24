.class final Lcom/motorola/camera/custom/LookOptics;
.super Ljava/lang/Object;
.source "LookOptics.java"


# static fields
.field private static final GAUSSIAN:[I

.field private static final LINEAR:[F

.field private static final SRGB:[I


# instance fields
.field private final clarityScale:F

.field private final grid:[F

.field private final gridHeight:I

.field private final gridWidth:I

.field private final height:I

.field private final look:I

.field private final ltmScale:F

.field private final step:I

.field private final strength:F

.field private final width:I


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 5
    const/16 v0, 0x100

    new-array v0, v0, [F

    sput-object v0, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    .line 6
    const/16 v0, 0x1001

    new-array v0, v0, [I

    sput-object v0, Lcom/motorola/camera/custom/LookOptics;->SRGB:[I

    .line 7
    const/4 v0, 0x4

    const/4 v1, 0x6

    const/4 v2, 0x1

    filled-new-array {v2, v0, v1, v0, v2}, [I

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/LookOptics;->GAUSSIAN:[I

    .line 10
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    sget-object v2, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    array-length v2, v2

    const-wide v3, 0x4029d70a3d70a3d7L    # 12.92

    const-wide v5, 0x3ff0e147ae147ae1L    # 1.055

    const-wide v7, 0x3fac28f5c28f5c29L    # 0.055

    const-wide v9, 0x406fe00000000000L    # 255.0

    if-ge v1, v2, :cond_1

    .line 11
    int-to-double v11, v1

    div-double/2addr v11, v9

    .line 12
    sget-object v2, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

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

    .line 10
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 14
    :cond_1
    nop

    :goto_2
    sget-object v1, Lcom/motorola/camera/custom/LookOptics;->SRGB:[I

    array-length v1, v1

    if-ge v0, v1, :cond_3

    .line 15
    int-to-double v1, v0

    const-wide/high16 v11, 0x40b0000000000000L    # 4096.0

    div-double/2addr v1, v11

    .line 16
    sget-object v11, Lcom/motorola/camera/custom/LookOptics;->SRGB:[I

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

    .line 14
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 18
    :cond_3
    return-void
.end method

.method private constructor <init>(IIIIFFIII[F)V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput p1, p0, Lcom/motorola/camera/custom/LookOptics;->width:I

    .line 29
    iput p2, p0, Lcom/motorola/camera/custom/LookOptics;->height:I

    .line 30
    iput p3, p0, Lcom/motorola/camera/custom/LookOptics;->look:I

    .line 31
    int-to-float p1, p4

    const/high16 p2, 0x42c80000    # 100.0f

    div-float/2addr p1, p2

    iput p1, p0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    .line 32
    iput p5, p0, Lcom/motorola/camera/custom/LookOptics;->clarityScale:F

    .line 33
    iput p6, p0, Lcom/motorola/camera/custom/LookOptics;->ltmScale:F

    .line 34
    iput p7, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    .line 35
    iput p8, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    .line 36
    iput p9, p0, Lcom/motorola/camera/custom/LookOptics;->gridHeight:I

    .line 37
    iput-object p10, p0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    .line 38
    return-void
.end method

.method private static encode(F)I
    .locals 2

    .line 167
    sget-object v0, Lcom/motorola/camera/custom/LookOptics;->SRGB:[I

    const/high16 v1, 0x45800000    # 4096.0f

    mul-float/2addr p0, v1

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    const/4 v1, 0x0

    invoke-static {v1, p0}, Ljava/lang/Math;->max(II)I

    move-result p0

    const/16 v1, 0x1000

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    aget p0, v0, p0

    return p0
.end method

.method private static gaussian([FII)[F
    .locals 18

    .line 143
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    array-length v3, v0

    new-array v3, v3, [F

    .line 144
    const/4 v4, 0x0

    move v5, v4

    :goto_0
    const/4 v7, -0x2

    const/4 v8, 0x0

    const/4 v9, 0x2

    if-ge v5, v2, :cond_2

    .line 145
    move v10, v4

    :goto_1
    if-ge v10, v1, :cond_1

    .line 146
    nop

    .line 147
    move v11, v7

    move v12, v8

    :goto_2
    if-gt v11, v9, :cond_0

    .line 148
    sget-object v13, Lcom/motorola/camera/custom/LookOptics;->GAUSSIAN:[I

    add-int/lit8 v14, v11, 0x2

    aget v13, v13, v14

    int-to-float v13, v13

    mul-int v14, v5, v1

    add-int/lit8 v15, v1, -0x1

    mul-int/lit8 v16, v11, 0x2

    const/high16 v17, 0x41800000    # 16.0f

    add-int v6, v10, v16

    invoke-static {v15, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    invoke-static {v4, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    add-int/2addr v14, v6

    aget v6, v0, v14

    mul-float/2addr v13, v6

    add-float/2addr v12, v13

    .line 147
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .line 150
    :cond_0
    const/high16 v17, 0x41800000    # 16.0f

    mul-int v6, v5, v1

    add-int/2addr v6, v10

    div-float v12, v12, v17

    aput v12, v3, v6

    .line 145
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    .line 144
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 153
    :cond_2
    const/high16 v17, 0x41800000    # 16.0f

    move v5, v4

    :goto_3
    if-ge v5, v2, :cond_5

    .line 154
    move v6, v4

    :goto_4
    if-ge v6, v1, :cond_4

    .line 155
    nop

    .line 156
    move v10, v7

    move v11, v8

    :goto_5
    if-gt v10, v9, :cond_3

    .line 157
    sget-object v12, Lcom/motorola/camera/custom/LookOptics;->GAUSSIAN:[I

    add-int/lit8 v13, v10, 0x2

    aget v12, v12, v13

    int-to-float v12, v12

    add-int/lit8 v13, v2, -0x1

    mul-int/lit8 v14, v10, 0x2

    add-int/2addr v14, v5

    invoke-static {v13, v14}, Ljava/lang/Math;->min(II)I

    move-result v13

    invoke-static {v4, v13}, Ljava/lang/Math;->max(II)I

    move-result v13

    mul-int/2addr v13, v1

    add-int/2addr v13, v6

    aget v13, v3, v13

    mul-float/2addr v12, v13

    add-float/2addr v11, v12

    .line 156
    add-int/lit8 v10, v10, 0x1

    goto :goto_5

    .line 159
    :cond_3
    mul-int v10, v5, v1

    add-int/2addr v10, v6

    div-float v11, v11, v17

    aput v11, v0, v10

    .line 154
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 153
    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 162
    :cond_5
    return-object v0
.end method

.method private static luma(FFF)F
    .locals 1

    .line 166
    const v0, 0x3e59b3d0    # 0.2126f

    mul-float/2addr p0, v0

    const v0, 0x3f371759    # 0.7152f

    mul-float/2addr p1, v0

    add-float/2addr p0, p1

    const p1, 0x3d93dd98    # 0.0722f

    mul-float/2addr p2, p1

    add-float/2addr p0, p2

    return p0
.end method

.method private static mix(FFF)F
    .locals 0

    .line 165
    sub-float/2addr p1, p0

    mul-float/2addr p1, p2

    add-float/2addr p0, p1

    return p0
.end method

.method static needsPass(I)Z
    .locals 2

    .line 41
    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    const/4 v1, 0x2

    if-eq p0, v1, :cond_1

    const/4 v1, 0x3

    if-eq p0, v1, :cond_1

    const/4 v1, 0x5

    if-lt p0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :goto_0
    return v0
.end method

.method static prepare(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIII)Lcom/motorola/camera/custom/LookOptics;
    .locals 7

    .line 46
    const/high16 v5, 0x3f800000    # 1.0f

    const/high16 v6, 0x3f800000    # 1.0f

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/LookOptics;->prepare(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIIFF)Lcom/motorola/camera/custom/LookOptics;

    move-result-object p0

    return-object p0
.end method

.method static prepare(Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;IIIIFF)Lcom/motorola/camera/custom/LookOptics;
    .locals 22

    .line 51
    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v9, p3

    const/4 v0, 0x5

    const/4 v3, 0x1

    const/4 v10, 0x0

    if-eq v9, v0, :cond_0

    const/4 v0, 0x6

    if-ne v9, v0, :cond_1

    :cond_0
    const/16 v0, 0x10

    if-lt v1, v0, :cond_1

    if-lt v2, v0, :cond_1

    move v11, v3

    goto :goto_0

    :cond_1
    move v11, v10

    .line 52
    :goto_0
    const/4 v0, 0x7

    const/16 v12, 0x8

    if-eq v9, v0, :cond_3

    if-ne v9, v12, :cond_2

    goto :goto_1

    :cond_2
    move v0, v10

    goto :goto_2

    :cond_3
    :goto_1
    move v0, v3

    .line 53
    :goto_2
    if-eqz v0, :cond_4

    const/4 v4, 0x4

    goto :goto_3

    :cond_4
    invoke-static {}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->autoLtmGridStep()I

    move-result v4

    :goto_3
    move v13, v4

    .line 54
    add-int v4, v1, v13

    sub-int/2addr v4, v3

    div-int v7, v4, v13

    .line 55
    add-int v4, v2, v13

    sub-int/2addr v4, v3

    div-int v8, v4, v13

    .line 56
    nop

    .line 57
    const/4 v3, 0x0

    if-nez v11, :cond_6

    if-eqz v0, :cond_5

    goto :goto_4

    :cond_5
    move-object v10, v3

    goto/16 :goto_c

    .line 58
    :cond_6
    :goto_4
    mul-int v0, v7, v8

    new-array v5, v0, [F

    .line 59
    if-eqz v11, :cond_7

    new-array v3, v0, [F

    :cond_7
    move-object v6, v3

    .line 60
    mul-int v0, v1, v13

    new-array v0, v0, [I

    .line 61
    move v3, v10

    :goto_5
    if-ge v3, v2, :cond_d

    .line 62
    sub-int v4, v2, v3

    invoke-static {v13, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 63
    move-object/from16 v14, p0

    invoke-interface {v14, v3, v4, v0, v10}, Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;->readRows(II[II)V

    .line 64
    if-eqz v11, :cond_8

    .line 65
    move/from16 v21, v4

    move v4, v2

    move/from16 v2, v21

    invoke-static/range {v0 .. v8}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->accumulateAutoLtmBand([IIIII[F[FII)V

    .line 66
    move-object/from16 v18, v0

    move v2, v12

    goto/16 :goto_a

    .line 68
    :cond_8
    move v2, v4

    move v1, v10

    :goto_6
    if-ge v1, v7, :cond_c

    .line 69
    nop

    .line 70
    mul-int v4, v1, v13

    sub-int v15, p1, v4

    invoke-static {v13, v15}, Ljava/lang/Math;->min(II)I

    move-result v15

    .line 71
    const/4 v10, 0x0

    const/16 v16, 0x0

    :goto_7
    if-ge v10, v2, :cond_b

    .line 72
    const/4 v12, 0x0

    :goto_8
    if-ge v12, v15, :cond_a

    .line 73
    mul-int v17, v10, p1

    add-int v17, v17, v4

    add-int v17, v17, v12

    move-object/from16 v18, v0

    aget v0, v18, v17

    .line 74
    sget-object v17, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    move/from16 v19, v1

    ushr-int/lit8 v1, v0, 0x10

    and-int/lit16 v1, v1, 0xff

    aget v1, v17, v1

    .line 75
    sget-object v17, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    move/from16 v20, v2

    ushr-int/lit8 v2, v0, 0x8

    and-int/lit16 v2, v2, 0xff

    aget v2, v17, v2

    sget-object v17, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    and-int/lit16 v0, v0, 0xff

    aget v0, v17, v0

    invoke-static {v1, v2, v0}, Lcom/motorola/camera/custom/LookOptics;->luma(FFF)F

    move-result v0

    .line 76
    const/16 v2, 0x8

    if-ne v9, v2, :cond_9

    goto :goto_9

    :cond_9
    move v1, v0

    :goto_9
    const v0, 0x3f147ae1    # 0.58f

    sub-float/2addr v1, v0

    const/4 v0, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    add-float v16, v16, v1

    .line 72
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v0, v18

    move/from16 v1, v19

    move/from16 v2, v20

    goto :goto_8

    .line 71
    :cond_a
    move-object/from16 v18, v0

    move/from16 v19, v1

    move/from16 v20, v2

    const/4 v0, 0x0

    const/16 v2, 0x8

    add-int/lit8 v10, v10, 0x1

    move v12, v2

    move-object/from16 v0, v18

    move/from16 v2, v20

    goto :goto_7

    .line 79
    :cond_b
    move-object/from16 v18, v0

    move/from16 v19, v1

    move/from16 v20, v2

    move v2, v12

    div-int v0, v3, v13

    mul-int/2addr v0, v7

    add-int v0, v0, v19

    mul-int v4, v20, v15

    int-to-float v1, v4

    div-float v16, v16, v1

    aput v16, v5, v0

    .line 68
    add-int/lit8 v1, v19, 0x1

    move-object/from16 v0, v18

    move/from16 v2, v20

    const/4 v10, 0x0

    goto/16 :goto_6

    :cond_c
    move-object/from16 v18, v0

    move v2, v12

    .line 61
    :goto_a
    add-int/2addr v3, v13

    move/from16 v1, p1

    move v12, v2

    move-object/from16 v0, v18

    const/4 v10, 0x0

    move/from16 v2, p2

    goto/16 :goto_5

    .line 82
    :cond_d
    if-eqz v11, :cond_f

    .line 83
    invoke-static {v5, v7, v8}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->finalizeAutoLtmBaseGrid([FII)[F

    move-result-object v3

    .line 84
    if-eqz v3, :cond_e

    const/4 v10, 0x0

    :goto_b
    array-length v0, v3

    if-ge v10, v0, :cond_e

    aget v0, v3, v10

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->exp(D)D

    move-result-wide v0

    double-to-float v0, v0

    const v1, 0x3b03126f    # 0.002f

    sub-float/2addr v0, v1

    aput v0, v3, v10

    add-int/lit8 v10, v10, 0x1

    goto :goto_b

    .line 89
    :cond_e
    move-object v10, v3

    goto :goto_c

    .line 86
    :cond_f
    invoke-static {v5, v7, v8}, Lcom/motorola/camera/custom/LookOptics;->gaussian([FII)[F

    move-result-object v3

    move-object v10, v3

    .line 89
    :goto_c
    new-instance v0, Lcom/motorola/camera/custom/LookOptics;

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move v3, v9

    move v9, v8

    move v8, v7

    move v7, v13

    invoke-direct/range {v0 .. v10}, Lcom/motorola/camera/custom/LookOptics;-><init>(IIIIFFIII[F)V

    return-object v0
.end method

.method private sample(II)F
    .locals 7

    .line 134
    iget v0, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    div-int v0, p1, v0

    iget v1, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    div-int v1, p2, v1

    .line 135
    add-int/lit8 v2, v0, 0x1

    iget v3, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    add-int/lit8 v3, v3, -0x1

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    add-int/lit8 v3, v1, 0x1

    iget v4, p0, Lcom/motorola/camera/custom/LookOptics;->gridHeight:I

    add-int/lit8 v4, v4, -0x1

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 136
    iget v4, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    rem-int/2addr p1, v4

    int-to-float p1, p1

    iget v4, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    int-to-float v4, v4

    div-float/2addr p1, v4

    iget v4, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    rem-int/2addr p2, v4

    int-to-float p2, p2

    iget v4, p0, Lcom/motorola/camera/custom/LookOptics;->step:I

    int-to-float v4, v4

    div-float/2addr p2, v4

    .line 137
    iget-object v4, p0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    iget v5, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    mul-int/2addr v5, v1

    add-int/2addr v5, v0

    aget v4, v4, v5

    iget-object v5, p0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    iget v6, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    mul-int/2addr v1, v6

    add-int/2addr v1, v2

    aget v1, v5, v1

    invoke-static {v4, v1, p1}, Lcom/motorola/camera/custom/LookOptics;->mix(FFF)F

    move-result v1

    .line 138
    iget-object v4, p0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    iget v5, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    mul-int/2addr v5, v3

    add-int/2addr v5, v0

    aget v0, v4, v5

    iget-object v4, p0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    iget v5, p0, Lcom/motorola/camera/custom/LookOptics;->gridWidth:I

    mul-int/2addr v3, v5

    add-int/2addr v3, v2

    aget v2, v4, v3

    invoke-static {v0, v2, p1}, Lcom/motorola/camera/custom/LookOptics;->mix(FFF)F

    move-result p1

    .line 139
    invoke-static {v1, p1, p2}, Lcom/motorola/camera/custom/LookOptics;->mix(FFF)F

    move-result p1

    return p1
.end method

.method private static smooth(F)F
    .locals 2

    .line 169
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p0}, Ljava/lang/Math;->min(FF)F

    move-result p0

    const/4 v0, 0x0

    invoke-static {v0, p0}, Ljava/lang/Math;->max(FF)F

    move-result p0

    .line 170
    mul-float v0, p0, p0

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr p0, v1

    const/high16 v1, 0x40400000    # 3.0f

    sub-float/2addr v1, p0

    mul-float/2addr v0, v1

    return v0
.end method


# virtual methods
.method apply([III)V
    .locals 20

    .line 93
    move-object/from16 v0, p0

    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne v1, v2, :cond_0

    const v1, 0x3e8a3d71    # 0.27f

    goto :goto_0

    :cond_0
    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_1

    const v1, 0x3e051eb8    # 0.13f

    goto :goto_0

    :cond_1
    move v1, v3

    .line 94
    :goto_0
    iget v2, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v4, 0x3

    const/16 v5, 0xd

    if-ne v2, v4, :cond_2

    const v2, 0x3ca3d70a    # 0.02f

    goto :goto_1

    :cond_2
    iget v2, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    if-ne v2, v5, :cond_3

    const v2, 0x3c83126f    # 0.016f

    goto :goto_1

    :cond_3
    iget v2, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/16 v4, 0x9

    if-lt v2, v4, :cond_4

    const v2, 0x3c23d70a    # 0.01f

    goto :goto_1

    :cond_4
    move v2, v3

    .line 95
    :goto_1
    cmpl-float v4, v1, v3

    if-nez v4, :cond_5

    cmpl-float v6, v2, v3

    if-nez v6, :cond_5

    iget-object v6, v0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    if-nez v6, :cond_5

    return-void

    .line 96
    :cond_5
    const/4 v6, 0x0

    :goto_2
    iget v7, v0, Lcom/motorola/camera/custom/LookOptics;->width:I

    mul-int v7, v7, p2

    if-ge v6, v7, :cond_e

    .line 97
    iget v7, v0, Lcom/motorola/camera/custom/LookOptics;->width:I

    rem-int v7, v6, v7

    iget v8, v0, Lcom/motorola/camera/custom/LookOptics;->width:I

    div-int v8, v6, v8

    add-int v8, p3, v8

    .line 98
    aget v9, p1, v6

    .line 99
    sget-object v10, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    ushr-int/lit8 v11, v9, 0x10

    and-int/lit16 v11, v11, 0xff

    aget v10, v10, v11

    sget-object v11, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    ushr-int/lit8 v12, v9, 0x8

    and-int/lit16 v12, v12, 0xff

    aget v11, v11, v12

    sget-object v12, Lcom/motorola/camera/custom/LookOptics;->LINEAR:[F

    and-int/lit16 v13, v9, 0xff

    aget v12, v12, v13

    .line 100
    invoke-static {v10, v11, v12}, Lcom/motorola/camera/custom/LookOptics;->luma(FFF)F

    move-result v13

    .line 101
    nop

    .line 102
    const/high16 v15, 0x3f800000    # 1.0f

    if-eqz v4, :cond_6

    .line 103
    int-to-float v3, v7

    const/high16 v16, 0x3f000000    # 0.5f

    add-float v3, v3, v16

    const/high16 v17, 0x40000000    # 2.0f

    mul-float v3, v3, v17

    const v18, 0x3e3851ec    # 0.18f

    iget v14, v0, Lcom/motorola/camera/custom/LookOptics;->width:I

    int-to-float v14, v14

    div-float/2addr v3, v14

    sub-float/2addr v3, v15

    const v14, 0x3f666666    # 0.9f

    mul-float/2addr v3, v14

    .line 104
    int-to-float v14, v8

    add-float v14, v14, v16

    mul-float v14, v14, v17

    move/from16 v16, v15

    iget v15, v0, Lcom/motorola/camera/custom/LookOptics;->height:I

    int-to-float v15, v15

    div-float/2addr v14, v15

    sub-float v14, v14, v16

    .line 105
    iget v15, v0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    mul-float/2addr v15, v1

    mul-float/2addr v3, v3

    mul-float/2addr v14, v14

    add-float/2addr v3, v14

    sub-float v3, v3, v18

    const v14, 0x3fc66666    # 1.55f

    div-float/2addr v3, v14

    invoke-static {v3}, Lcom/motorola/camera/custom/LookOptics;->smooth(F)F

    move-result v3

    mul-float/2addr v15, v3

    const v3, 0x3e6147ae    # 0.22f

    sub-float v3, v13, v3

    const v14, 0x3f47ae14    # 0.78f

    div-float/2addr v3, v14

    .line 106
    invoke-static {v3}, Lcom/motorola/camera/custom/LookOptics;->smooth(F)F

    move-result v3

    sub-float v3, v16, v3

    mul-float/2addr v15, v3

    sub-float v15, v16, v15

    goto :goto_3

    .line 102
    :cond_6
    move/from16 v16, v15

    const v18, 0x3e3851ec    # 0.18f

    .line 108
    :goto_3
    nop

    .line 109
    iget-object v3, v0, Lcom/motorola/camera/custom/LookOptics;->grid:[F

    if-eqz v3, :cond_a

    .line 110
    invoke-direct {v0, v7, v8}, Lcom/motorola/camera/custom/LookOptics;->sample(II)F

    move-result v3

    .line 111
    const/high16 v17, 0x3e800000    # 0.25f

    iget v14, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v5, 0x6

    if-ne v14, v5, :cond_7

    .line 112
    sub-float v5, v10, v11

    const/high16 v14, 0x41400000    # 12.0f

    mul-float/2addr v5, v14

    invoke-static {v5}, Lcom/motorola/camera/custom/LookOptics;->smooth(F)F

    move-result v5

    sub-float v14, v11, v12

    const/high16 v19, 0x41800000    # 16.0f

    mul-float v14, v14, v19

    invoke-static {v14}, Lcom/motorola/camera/custom/LookOptics;->smooth(F)F

    move-result v14

    mul-float/2addr v5, v14

    .line 113
    iget v14, v0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    const v19, 0x3ecccccd    # 0.4f

    mul-float v14, v14, v19

    move/from16 v19, v1

    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->ltmScale:F

    mul-float/2addr v14, v1

    const v1, 0x3e8f5c29    # 0.28f

    div-float/2addr v3, v1

    invoke-static {v3}, Lcom/motorola/camera/custom/LookOptics;->smooth(F)F

    move-result v1

    sub-float v1, v16, v1

    mul-float/2addr v14, v1

    const v1, 0x3f1eb852    # 0.62f

    mul-float/2addr v5, v1

    sub-float v1, v16, v5

    mul-float/2addr v14, v1

    add-float/2addr v15, v14

    .line 114
    const/4 v1, 0x0

    goto :goto_5

    :cond_7
    move/from16 v19, v1

    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v5, 0x5

    if-ne v1, v5, :cond_8

    .line 115
    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    const v5, 0x3e23d70a    # 0.16f

    mul-float/2addr v1, v5

    iget v5, v0, Lcom/motorola/camera/custom/LookOptics;->clarityScale:F

    mul-float/2addr v1, v5

    const v5, 0x3e4ccccd    # 0.2f

    sub-float v3, v13, v3

    invoke-static {v5, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const v5, -0x41b33333    # -0.2f

    invoke-static {v5, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    mul-float/2addr v1, v3

    goto :goto_5

    .line 117
    :cond_8
    iget v1, v0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    mul-float/2addr v1, v3

    iget v3, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/4 v5, 0x7

    if-ne v3, v5, :cond_9

    move/from16 v3, v17

    goto :goto_4

    :cond_9
    const v3, 0x3eae147b    # 0.34f

    :goto_4
    mul-float/2addr v1, v3

    goto :goto_5

    .line 109
    :cond_a
    move/from16 v19, v1

    const/high16 v17, 0x3e800000    # 0.25f

    const/4 v1, 0x0

    .line 120
    :goto_5
    const v3, 0x5bd1e995

    mul-int/2addr v7, v3

    const v3, 0x27d4eb2d

    mul-int/2addr v8, v3

    xor-int v3, v7, v8

    .line 121
    ushr-int/lit8 v5, v3, 0xf

    xor-int/2addr v3, v5

    .line 122
    const v5, -0x7a143595

    mul-int/2addr v3, v5

    .line 123
    iget v5, v0, Lcom/motorola/camera/custom/LookOptics;->strength:F

    mul-float/2addr v5, v2

    sub-float v7, v16, v13

    mul-float/2addr v5, v7

    and-int/lit16 v7, v3, 0xff

    const/16 v8, 0x8

    ushr-int/2addr v3, v8

    and-int/lit16 v3, v3, 0xff

    add-int/2addr v7, v3

    int-to-float v3, v7

    const/high16 v7, 0x437f0000    # 255.0f

    div-float/2addr v3, v7

    sub-float v3, v3, v16

    mul-float/2addr v5, v3

    .line 124
    iget v3, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    if-ne v3, v8, :cond_b

    move/from16 v14, v18

    goto :goto_6

    :cond_b
    move/from16 v14, v16

    .line 125
    :goto_6
    iget v3, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    if-ne v3, v8, :cond_c

    const v3, 0x3d23d70a    # 0.04f

    move/from16 v16, v3

    .line 126
    :cond_c
    iget v3, v0, Lcom/motorola/camera/custom/LookOptics;->look:I

    const/16 v7, 0xd

    if-ne v3, v7, :cond_d

    mul-float v3, v5, v17

    goto :goto_7

    :cond_d
    const/4 v3, 0x0

    .line 127
    :goto_7
    const/high16 v13, -0x1000000

    and-int/2addr v9, v13

    mul-float/2addr v10, v15

    add-float/2addr v10, v1

    add-float/2addr v10, v5

    add-float/2addr v10, v3

    invoke-static {v10}, Lcom/motorola/camera/custom/LookOptics;->encode(F)I

    move-result v10

    shl-int/lit8 v10, v10, 0x10

    or-int/2addr v9, v10

    mul-float/2addr v11, v15

    mul-float/2addr v14, v1

    add-float/2addr v11, v14

    add-float/2addr v11, v5

    .line 128
    invoke-static {v11}, Lcom/motorola/camera/custom/LookOptics;->encode(F)I

    move-result v10

    shl-int/lit8 v8, v10, 0x8

    or-int/2addr v8, v9

    mul-float/2addr v12, v15

    mul-float v1, v1, v16

    add-float/2addr v12, v1

    add-float/2addr v12, v5

    sub-float/2addr v12, v3

    .line 129
    invoke-static {v12}, Lcom/motorola/camera/custom/LookOptics;->encode(F)I

    move-result v1

    or-int/2addr v1, v8

    aput v1, p1, v6

    .line 96
    add-int/lit8 v6, v6, 0x1

    move v5, v7

    move/from16 v1, v19

    const/4 v3, 0x0

    goto/16 :goto_2

    .line 131
    :cond_e
    return-void
.end method
