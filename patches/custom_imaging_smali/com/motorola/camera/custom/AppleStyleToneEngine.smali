.class public final Lcom/motorola/camera/custom/AppleStyleToneEngine;
.super Ljava/lang/Object;
.source "AppleStyleToneEngine.java"


# static fields
.field private static final CELLS:I = 0x10

.field private static final GRID:I = 0x11

.field private static final LUT_FLOATS:I = 0x3993

.field private static final LUT_LOCK:Ljava/lang/Object;

.field private static final MAX_CUBE_SIZE:I = 0x40

.field public static final STYLE_IPHONE_AMBER:I = 0x3

.field public static final STYLE_IPHONE_NATURAL:I = 0x1

.field public static final STYLE_IPHONE_RICH_CONTRAST:I = 0x2

.field public static final STYLE_NONE:I

.field private static volatile lutAmber:[F

.field private static volatile lutNatural:[F

.field private static volatile lutRich:[F


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 19
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->LUT_LOCK:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyToArgbPixels([IIII)V
    .locals 21

    .line 27
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    if-eqz v0, :cond_9

    if-lez v1, :cond_9

    if-gtz v2, :cond_0

    goto/16 :goto_7

    .line 30
    :cond_0
    const/4 v4, 0x1

    if-lt v3, v4, :cond_8

    const/4 v5, 0x3

    if-le v3, v5, :cond_1

    goto/16 :goto_6

    .line 33
    :cond_1
    int-to-long v5, v1

    int-to-long v1, v2

    mul-long/2addr v5, v1

    .line 34
    array-length v1, v0

    int-to-long v1, v1

    invoke-static {v1, v2, v5, v6}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v1

    long-to-int v1, v1

    .line 35
    invoke-static {v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutFor(I)[F

    move-result-object v5

    .line 36
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_7

    .line 37
    aget v6, v0, v3

    .line 38
    const/high16 v7, -0x1000000

    and-int v16, v6, v7

    .line 39
    ushr-int/lit8 v7, v6, 0x10

    and-int/lit16 v7, v7, 0xff

    .line 40
    ushr-int/lit8 v8, v6, 0x8

    and-int/lit16 v8, v8, 0xff

    .line 41
    and-int/lit16 v6, v6, 0xff

    .line 42
    const/16 v9, 0x10

    if-ne v7, v8, :cond_3

    if-ne v8, v6, :cond_3

    .line 45
    invoke-static {v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisIndex(I)I

    move-result v6

    .line 46
    if-lt v6, v9, :cond_2

    move v8, v9

    goto :goto_1

    :cond_2
    add-int/lit8 v8, v6, 0x1

    .line 47
    :goto_1
    invoke-static {v7, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisFrac(II)F

    move-result v7

    .line 48
    invoke-static {v5, v6, v6, v6, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v10

    invoke-static {v5, v8, v8, v8, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v11

    invoke-static {v10, v11, v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lerp(FFF)F

    move-result v10

    invoke-static {v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v10

    .line 49
    invoke-static {v5, v6, v6, v6, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v11

    invoke-static {v5, v8, v8, v8, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v12

    invoke-static {v11, v12, v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lerp(FFF)F

    move-result v11

    invoke-static {v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v11

    .line 50
    const/4 v12, 0x2

    invoke-static {v5, v6, v6, v6, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v6

    invoke-static {v5, v8, v8, v8, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v8

    invoke-static {v6, v8, v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lerp(FFF)F

    move-result v6

    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v6

    .line 51
    shl-int/lit8 v7, v10, 0x10

    or-int v7, v16, v7

    shl-int/lit8 v8, v11, 0x8

    or-int/2addr v7, v8

    or-int/2addr v6, v7

    aput v6, v0, v3

    .line 52
    goto :goto_5

    .line 54
    :cond_3
    invoke-static {v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisIndex(I)I

    move-result v10

    .line 55
    invoke-static {v8}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisIndex(I)I

    move-result v11

    .line 56
    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisIndex(I)I

    move-result v12

    .line 57
    invoke-static {v7, v10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisFrac(II)F

    move-result v7

    .line 58
    invoke-static {v8, v11}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisFrac(II)F

    move-result v13

    .line 59
    invoke-static {v6, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->axisFrac(II)F

    move-result v14

    .line 60
    if-ne v10, v9, :cond_4

    move v6, v10

    goto :goto_2

    :cond_4
    add-int/lit8 v6, v10, 0x1

    .line 61
    :goto_2
    if-ne v11, v9, :cond_5

    move v8, v11

    goto :goto_3

    :cond_5
    add-int/lit8 v8, v11, 0x1

    .line 62
    :goto_3
    if-ne v12, v9, :cond_6

    move v15, v12

    goto :goto_4

    :cond_6
    add-int/lit8 v15, v12, 0x1

    .line 64
    :goto_4
    move/from16 v17, v9

    move v9, v8

    move v8, v11

    move v11, v15

    const/4 v15, 0x0

    move/from16 v20, v7

    move v7, v6

    move v6, v10

    move v10, v12

    move/from16 v12, v20

    invoke-static/range {v5 .. v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->trilinear([FIIIIIIFFFI)F

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v18

    .line 65
    const/4 v15, 0x1

    invoke-static/range {v5 .. v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->trilinear([FIIIIIIFFFI)F

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v19

    .line 66
    const/4 v15, 0x2

    invoke-static/range {v5 .. v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->trilinear([FIIIIIIFFFI)F

    move-result v6

    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toByte(F)I

    move-result v6

    .line 67
    shl-int/lit8 v7, v18, 0x10

    or-int v7, v16, v7

    shl-int/lit8 v8, v19, 0x8

    or-int/2addr v7, v8

    or-int/2addr v6, v7

    aput v6, v0, v3

    .line 36
    :goto_5
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    .line 69
    :cond_7
    return-void

    .line 31
    :cond_8
    :goto_6
    return-void

    .line 28
    :cond_9
    :goto_7
    return-void
.end method

.method private static at([FIIII)F
    .locals 0

    .line 376
    mul-int/lit8 p1, p1, 0x11

    add-int/2addr p1, p2

    mul-int/lit8 p1, p1, 0x11

    add-int/2addr p1, p3

    mul-int/lit8 p1, p1, 0x3

    add-int/2addr p1, p4

    aget p0, p0, p1

    return p0
.end method

.method private static axisFrac(II)F
    .locals 1

    .line 390
    if-lez p0, :cond_1

    const/16 v0, 0xff

    if-ge p0, v0, :cond_1

    const/16 v0, 0x10

    if-lt p1, v0, :cond_0

    goto :goto_0

    .line 393
    :cond_0
    int-to-float p0, p0

    const v0, 0x3d808081

    mul-float/2addr p0, v0

    int-to-float p1, p1

    sub-float/2addr p0, p1

    return p0

    .line 391
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return p0
.end method

.method private static axisIndex(I)I
    .locals 1

    .line 380
    if-gtz p0, :cond_0

    .line 381
    const/4 p0, 0x0

    return p0

    .line 383
    :cond_0
    const/16 v0, 0xff

    if-lt p0, v0, :cond_1

    .line 384
    const/16 p0, 0x10

    return p0

    .line 386
    :cond_1
    int-to-float p0, p0

    const v0, 0x3d808081

    mul-float/2addr p0, v0

    float-to-int p0, p0

    return p0
.end method

.method private static cachedLut(I)[F
    .locals 1

    .line 222
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    .line 223
    sget-object p0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutNatural:[F

    return-object p0

    .line 225
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    .line 226
    sget-object p0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutRich:[F

    return-object p0

    .line 228
    :cond_1
    sget-object p0, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutAmber:[F

    return-object p0
.end method

.method private static clamp01(F)F
    .locals 2

    .line 407
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    .line 408
    return v0

    .line 410
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_1

    .line 411
    return v0

    .line 413
    :cond_1
    return p0
.end method

.method private static countWords(Ljava/lang/String;II)I
    .locals 2

    .line 470
    nop

    .line 471
    const/4 v0, 0x0

    .line 472
    :goto_0
    if-ge p1, p2, :cond_2

    .line 473
    :goto_1
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 474
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 476
    :cond_0
    if-lt p1, p2, :cond_1

    .line 477
    goto :goto_2

    .line 479
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 480
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    goto :goto_0

    .line 482
    :cond_2
    :goto_2
    return v0
.end method

.method private static eqKey(Ljava/lang/String;IILjava/lang/String;)Z
    .locals 6

    .line 494
    sub-int v5, p2, p1

    .line 495
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result p2

    if-ne v5, p2, :cond_0

    const/4 v1, 0x1

    const/4 v4, 0x0

    move-object v0, p0

    move v2, p1

    move-object v3, p3

    invoke-virtual/range {v0 .. v5}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static grade(IFFF[F)V
    .locals 18

    .line 242
    move/from16 v0, p0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x2

    if-ne v0, v3, :cond_0

    move v4, v2

    goto :goto_0

    :cond_0
    move v4, v1

    .line 243
    :goto_0
    if-eqz v4, :cond_1

    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneRich(F)F

    move-result v5

    goto :goto_1

    :cond_1
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneNatural(F)F

    move-result v5

    .line 244
    :goto_1
    if-eqz v4, :cond_2

    invoke-static/range {p2 .. p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneRich(F)F

    move-result v6

    goto :goto_2

    :cond_2
    invoke-static/range {p2 .. p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneNatural(F)F

    move-result v6

    .line 245
    :goto_2
    if-eqz v4, :cond_3

    invoke-static/range {p3 .. p3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneRich(F)F

    move-result v7

    goto :goto_3

    :cond_3
    invoke-static/range {p3 .. p3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->toneNatural(F)F

    move-result v7

    .line 246
    :goto_3
    const v8, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v8, v5

    const v9, 0x3f371759    # 0.7152f

    mul-float/2addr v9, v6

    add-float/2addr v8, v9

    const v9, 0x3d93dd98    # 0.0722f

    mul-float/2addr v9, v7

    add-float/2addr v8, v9

    .line 247
    sub-float v9, v5, v8

    .line 248
    sub-float v10, v6, v8

    .line 249
    sub-float v11, v7, v8

    .line 250
    invoke-static {v9}, Ljava/lang/Math;->abs(F)F

    move-result v12

    invoke-static {v10}, Ljava/lang/Math;->abs(F)F

    move-result v13

    add-float/2addr v12, v13

    invoke-static {v11}, Ljava/lang/Math;->abs(F)F

    move-result v13

    add-float/2addr v12, v13

    .line 253
    const v13, 0x3df5c28f    # 0.12f

    sub-float v13, v12, v13

    const/high16 v14, 0x41200000    # 10.0f

    mul-float/2addr v13, v14

    .line 254
    const/4 v14, 0x0

    cmpl-float v15, v13, v14

    if-lez v15, :cond_b

    .line 255
    const/high16 v15, 0x3f800000    # 1.0f

    cmpl-float v16, v13, v15

    if-lez v16, :cond_4

    .line 256
    move v13, v15

    .line 258
    :cond_4
    nop

    .line 259
    cmpl-float v16, v10, v14

    if-lez v16, :cond_5

    .line 261
    const v17, 0x3e99999a    # 0.3f

    div-float v12, v10, v12

    mul-float v12, v12, v17

    sub-float v12, v15, v12

    mul-float/2addr v15, v12

    .line 263
    :cond_5
    cmpg-float v12, v9, v14

    const v17, 0x3f6147ae    # 0.88f

    if-gez v12, :cond_6

    if-lez v16, :cond_6

    cmpl-float v14, v11, v14

    if-lez v14, :cond_6

    .line 264
    mul-float v15, v15, v17

    .line 266
    :cond_6
    nop

    .line 267
    nop

    .line 268
    const v14, 0x3ca3d70a    # 0.02f

    cmpl-float v14, v11, v14

    if-lez v14, :cond_7

    if-gez v12, :cond_7

    cmpl-float v12, v7, v6

    if-lez v12, :cond_7

    cmpl-float v12, v7, v5

    if-lez v12, :cond_7

    .line 269
    const v12, 0x3f47ae14    # 0.78f

    mul-float/2addr v10, v12

    .line 270
    const v12, 0x3f8a3d71    # 1.08f

    mul-float/2addr v11, v12

    .line 272
    :cond_7
    if-nez v4, :cond_8

    cmpl-float v4, v5, v6

    if-lez v4, :cond_8

    cmpl-float v4, v6, v7

    if-lez v4, :cond_8

    const v4, 0x3e6147ae    # 0.22f

    cmpl-float v4, v8, v4

    if-lez v4, :cond_8

    cmpg-float v4, v8, v17

    if-gez v4, :cond_8

    .line 273
    const v4, 0x3c449ba6    # 0.012f

    add-float/2addr v9, v4

    .line 274
    const v4, 0x3c03126f    # 0.008f

    sub-float/2addr v11, v4

    .line 276
    :cond_8
    mul-float/2addr v9, v15

    add-float/2addr v9, v8

    .line 277
    mul-float/2addr v10, v15

    add-float/2addr v10, v8

    .line 278
    mul-float/2addr v15, v11

    add-float/2addr v15, v8

    .line 279
    invoke-static {v8}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->warmth(F)F

    move-result v4

    .line 280
    if-ne v0, v2, :cond_9

    .line 281
    const v0, 0x3c83126f    # 0.016f

    mul-float/2addr v0, v4

    add-float/2addr v9, v0

    .line 282
    const v0, 0x3ba3d70a    # 0.005f

    mul-float/2addr v0, v4

    add-float/2addr v10, v0

    .line 283
    const v0, 0x3c23d70a    # 0.01f

    mul-float/2addr v4, v0

    sub-float/2addr v15, v4

    goto :goto_4

    .line 284
    :cond_9
    const/4 v8, 0x3

    if-ne v0, v8, :cond_a

    .line 286
    const v0, 0x3d54fdf4    # 0.052f

    mul-float/2addr v0, v4

    add-float/2addr v9, v0

    .line 287
    const v0, 0x3cb43958    # 0.022f

    mul-float/2addr v0, v4

    add-float/2addr v10, v0

    .line 288
    const v0, 0x3d23d70a    # 0.04f

    mul-float/2addr v4, v0

    sub-float/2addr v15, v4

    .line 290
    :cond_a
    :goto_4
    sub-float/2addr v9, v5

    mul-float/2addr v9, v13

    add-float/2addr v5, v9

    .line 291
    sub-float/2addr v10, v6

    mul-float/2addr v10, v13

    add-float/2addr v6, v10

    .line 292
    sub-float/2addr v15, v7

    mul-float/2addr v15, v13

    add-float/2addr v7, v15

    .line 294
    :cond_b
    invoke-static {v5}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    aput v0, p4, v1

    .line 295
    invoke-static {v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    aput v0, p4, v2

    .line 296
    invoke-static {v7}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result v0

    aput v0, p4, v3

    .line 297
    return-void
.end method

.method private static isSpace(C)Z
    .locals 1

    .line 499
    const/16 v0, 0x20

    if-eq p0, v0, :cond_1

    const/16 v0, 0x9

    if-eq p0, v0, :cond_1

    const/16 v0, 0xc

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

.method private static lerp(FFF)F
    .locals 0

    .line 353
    sub-float/2addr p1, p0

    mul-float/2addr p1, p2

    add-float/2addr p0, p1

    return p0
.end method

.method private static lutFor(I)[F
    .locals 18

    .line 184
    move/from16 v0, p0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->cachedLut(I)[F

    move-result-object v1

    .line 185
    if-eqz v1, :cond_0

    .line 186
    return-object v1

    .line 188
    :cond_0
    sget-object v1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->LUT_LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 189
    :try_start_0
    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->cachedLut(I)[F

    move-result-object v2

    .line 190
    if-eqz v2, :cond_1

    .line 191
    monitor-exit v1

    return-object v2

    .line 193
    :cond_1
    const/16 v2, 0x3993

    new-array v2, v2, [F

    .line 194
    const/4 v3, 0x3

    new-array v4, v3, [F

    .line 195
    const/4 v5, 0x0

    move v6, v5

    :goto_0
    const/4 v7, 0x2

    const/16 v8, 0x11

    const/4 v9, 0x1

    if-ge v6, v8, :cond_4

    .line 196
    int-to-float v10, v6

    const/high16 v11, 0x41800000    # 16.0f

    div-float/2addr v10, v11

    .line 197
    move v12, v5

    :goto_1
    if-ge v12, v8, :cond_3

    .line 198
    int-to-float v13, v12

    div-float/2addr v13, v11

    .line 199
    move v14, v5

    :goto_2
    if-ge v14, v8, :cond_2

    .line 200
    int-to-float v15, v14

    div-float/2addr v15, v11

    invoke-static {v0, v10, v13, v15, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->grade(IFFF[F)V

    .line 201
    mul-int/lit8 v15, v6, 0x11

    add-int/2addr v15, v12

    mul-int/2addr v15, v8

    add-int/2addr v15, v14

    mul-int/2addr v15, v3

    .line 202
    aget v16, v4, v5

    aput v16, v2, v15

    .line 203
    add-int/lit8 v16, v15, 0x1

    aget v17, v4, v9

    aput v17, v2, v16

    .line 204
    add-int/lit8 v15, v15, 0x2

    aget v16, v4, v7

    aput v16, v2, v15

    .line 199
    add-int/lit8 v14, v14, 0x1

    goto :goto_2

    .line 197
    :cond_2
    add-int/lit8 v12, v12, 0x1

    goto :goto_1

    .line 195
    :cond_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 209
    :cond_4
    const/4 v3, 0x0

    aput v3, v2, v5

    .line 210
    aput v3, v2, v9

    .line 211
    aput v3, v2, v7

    .line 212
    nop

    .line 213
    const/high16 v3, 0x3f800000    # 1.0f

    const/16 v4, 0x3990

    aput v3, v2, v4

    .line 214
    const/16 v4, 0x3991

    aput v3, v2, v4

    .line 215
    const/16 v4, 0x3992

    aput v3, v2, v4

    .line 216
    invoke-static {v0, v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->storeLut(I[F)V

    .line 217
    monitor-exit v1

    return-object v2

    .line 218
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static parseCubeLut(Ljava/lang/String;[I)[F
    .locals 19

    .line 77
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-eqz v0, :cond_1d

    .line 80
    nop

    .line 81
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_0

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const v5, 0xfeff

    if-ne v2, v5, :cond_0

    .line 82
    const/4 v2, 0x1

    goto :goto_0

    .line 84
    :cond_0
    move v2, v3

    :goto_0
    nop

    .line 85
    nop

    .line 86
    nop

    .line 87
    nop

    .line 88
    nop

    .line 89
    nop

    .line 90
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, -0x1

    const/4 v7, 0x0

    move v10, v3

    move-object v8, v7

    move-object v9, v8

    .line 91
    :goto_1
    const/4 v11, 0x2

    if-gt v2, v5, :cond_18

    .line 92
    move v13, v2

    .line 93
    :goto_2
    const/16 v14, 0xd

    const/16 v15, 0xa

    if-ge v13, v5, :cond_2

    .line 94
    const/16 v16, 0x1

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 95
    if-eq v4, v15, :cond_3

    if-ne v4, v14, :cond_1

    .line 96
    goto :goto_3

    .line 98
    :cond_1
    add-int/lit8 v13, v13, 0x1

    .line 99
    goto :goto_2

    .line 93
    :cond_2
    const/16 v16, 0x1

    .line 100
    :cond_3
    :goto_3
    nop

    .line 101
    :goto_4
    if-ge v2, v13, :cond_4

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 102
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 104
    :cond_4
    move v4, v13

    .line 105
    :goto_5
    if-le v4, v2, :cond_5

    add-int/lit8 v15, v4, -0x1

    invoke-virtual {v0, v15}, Ljava/lang/String;->charAt(I)C

    move-result v15

    invoke-static {v15}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v15

    if-eqz v15, :cond_5

    .line 106
    add-int/lit8 v4, v4, -0x1

    const/16 v15, 0xa

    goto :goto_5

    .line 108
    :cond_5
    if-ge v2, v4, :cond_15

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v15

    const/16 v14, 0x23

    if-eq v15, v14, :cond_15

    .line 109
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->countWords(Ljava/lang/String;II)I

    move-result v14

    .line 110
    invoke-static {v0, v2, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v15

    .line 111
    const-string v3, "TITLE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_14

    .line 112
    const-string v3, "LUT_IN_VIDEO_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    move/from16 v12, v16

    goto/16 :goto_8

    .line 114
    :cond_6
    const-string v3, "DOMAIN_MIN"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v18

    if-nez v18, :cond_11

    .line 115
    const-string v12, "DOMAIN_MAX"

    invoke-static {v0, v2, v15, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_7

    goto/16 :goto_6

    .line 125
    :cond_7
    const-string v3, "LUT_1D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 126
    const-string v3, "LUT_1D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    .line 128
    const-string v3, "LUT_3D_SIZE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 129
    if-ne v14, v11, :cond_9

    if-nez v9, :cond_9

    .line 132
    invoke-static {v0, v15, v4}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->word(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseSize(Ljava/lang/String;)I

    move-result v2

    .line 133
    int-to-long v3, v2

    mul-long v14, v3, v3

    mul-long/2addr v14, v3

    const-wide/16 v3, 0x3

    mul-long/2addr v14, v3

    .line 134
    const-wide/32 v3, 0x7fffffff

    cmp-long v3, v14, v3

    if-gtz v3, :cond_8

    .line 137
    long-to-int v3, v14

    new-array v3, v3, [F

    .line 138
    move v6, v2

    move-object v9, v3

    move/from16 v12, v16

    goto/16 :goto_8

    .line 135
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 130
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_SIZE must appear once before samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 138
    :cond_a
    const-string v3, "LUT_3D_INPUT_RANGE"

    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 139
    const/4 v3, 0x3

    if-ne v14, v3, :cond_b

    move/from16 v12, v16

    goto/16 :goto_8

    .line 140
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LUT_3D_INPUT_RANGE needs two finite bounds"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 143
    :cond_c
    const/4 v3, 0x3

    if-eqz v9, :cond_f

    .line 146
    if-ne v14, v3, :cond_e

    .line 149
    add-int/lit8 v3, v10, 0x3

    array-length v12, v9

    if-gt v3, v12, :cond_d

    .line 152
    const/4 v3, 0x0

    invoke-static {v0, v2, v4, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v2

    .line 153
    add-int/lit8 v4, v10, 0x1

    aget v12, v2, v3

    aput v12, v9, v10

    .line 154
    add-int/lit8 v3, v4, 0x1

    aget v10, v2, v16

    aput v10, v9, v4

    .line 155
    add-int/lit8 v4, v3, 0x1

    aget v2, v2, v11

    aput v2, v9, v3

    move v10, v4

    move/from16 v12, v16

    goto :goto_8

    .line 150
    :cond_d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "too many RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 147
    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "RGB sample must contain 3 values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 144
    :cond_f
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "sample appears before LUT_3D_SIZE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 127
    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1D cube is not a 3D LUT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 116
    :cond_11
    :goto_6
    const/4 v12, 0x4

    if-ne v14, v12, :cond_13

    .line 119
    move/from16 v12, v16

    invoke-static {v0, v2, v4, v12}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->readTriple(Ljava/lang/String;IIZ)[F

    move-result-object v4

    .line 120
    invoke-static {v0, v2, v15, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->eqKey(Ljava/lang/String;IILjava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 121
    move-object v7, v4

    goto :goto_7

    .line 123
    :cond_12
    move-object v8, v4

    .line 125
    :goto_7
    goto :goto_8

    .line 117
    :cond_13
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN line needs 3 finite components"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 111
    :cond_14
    move/from16 v12, v16

    goto :goto_8

    .line 108
    :cond_15
    move/from16 v12, v16

    .line 158
    :goto_8
    if-lt v13, v5, :cond_16

    .line 159
    goto :goto_9

    .line 161
    :cond_16
    add-int/lit8 v2, v13, 0x1

    .line 162
    if-ge v13, v5, :cond_17

    invoke-virtual {v0, v13}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xd

    if-ne v3, v4, :cond_17

    if-ge v2, v5, :cond_17

    .line 163
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_17

    .line 164
    add-int/lit8 v2, v2, 0x1

    .line 166
    :cond_17
    const/4 v3, 0x0

    goto/16 :goto_1

    .line 167
    :cond_18
    :goto_9
    if-lt v6, v11, :cond_1c

    if-eqz v9, :cond_1c

    array-length v0, v9

    if-ne v10, v0, :cond_1c

    .line 170
    if-eqz v7, :cond_1a

    if-eqz v8, :cond_1a

    .line 171
    const/4 v3, 0x0

    :goto_a
    const/4 v0, 0x3

    if-ge v3, v0, :cond_1a

    .line 172
    aget v2, v7, v3

    aget v4, v8, v3

    cmpg-float v2, v2, v4

    if-gez v2, :cond_19

    .line 171
    add-int/lit8 v3, v3, 0x1

    goto :goto_a

    .line 173
    :cond_19
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "DOMAIN_MIN must be below DOMAIN_MAX"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 177
    :cond_1a
    if-eqz v1, :cond_1b

    array-length v0, v1

    if-lez v0, :cond_1b

    .line 178
    const/16 v17, 0x0

    aput v6, v1, v17

    .line 180
    :cond_1b
    return-object v9

    .line 168
    :cond_1c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube is missing LUT_3D_SIZE or the N^3 RGB samples"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 78
    :cond_1d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cube text is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static parseFinite(Ljava/lang/String;)F
    .locals 1

    .line 452
    :try_start_0
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 455
    nop

    .line 456
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 459
    return p0

    .line 457
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not finite"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 453
    :catch_0
    move-exception p0

    .line 454
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "cube sample is not a number"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static parseSize(Ljava/lang/String;)I
    .locals 4

    .line 417
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

    .line 422
    :try_start_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 425
    nop

    .line 426
    const/4 v0, 0x2

    if-lt p0, v0, :cond_0

    const/16 v0, 0x40

    if-gt p0, v0, :cond_0

    .line 429
    return p0

    .line 427
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 423
    :catch_0
    move-exception p0

    .line 424
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 418
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static readTriple(Ljava/lang/String;IIZ)[F
    .locals 3

    .line 433
    nop

    .line 434
    if-eqz p3, :cond_0

    .line 435
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p1

    .line 437
    :cond_0
    const/4 p3, 0x3

    new-array v0, p3, [F

    .line 438
    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_2

    .line 439
    :goto_1
    if-ge p1, p2, :cond_1

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 440
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .line 442
    :cond_1
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result v2

    .line 443
    invoke-virtual {p0, p1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->parseFinite(Ljava/lang/String;)F

    move-result p1

    aput p1, v0, v1

    .line 444
    nop

    .line 438
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 446
    :cond_2
    return-object v0
.end method

.method private static shoulderShape(FF)F
    .locals 5

    .line 337
    mul-float v0, p0, p0

    .line 338
    mul-float v1, p1, p0

    const/high16 v2, 0x40000000    # 2.0f

    mul-float v3, p1, v2

    const/high16 v4, 0x40400000    # 3.0f

    sub-float/2addr v4, v3

    mul-float/2addr v4, v0

    add-float/2addr v1, v4

    sub-float/2addr p1, v2

    mul-float/2addr p1, v0

    mul-float/2addr p1, p0

    add-float/2addr v1, p1

    return v1
.end method

.method private static storeLut(I[F)V
    .locals 1

    .line 232
    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    .line 233
    sput-object p1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutNatural:[F

    goto :goto_0

    .line 234
    :cond_0
    const/4 v0, 0x2

    if-ne p0, v0, :cond_1

    .line 235
    sput-object p1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutRich:[F

    goto :goto_0

    .line 237
    :cond_1
    sput-object p1, Lcom/motorola/camera/custom/AppleStyleToneEngine;->lutAmber:[F

    .line 239
    :goto_0
    return-void
.end method

.method private static toByte(F)I
    .locals 1

    .line 397
    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gtz v0, :cond_0

    .line 398
    const/4 p0, 0x0

    return p0

    .line 400
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_1

    .line 401
    const/16 p0, 0xff

    return p0

    .line 403
    :cond_1
    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p0, v0

    float-to-int p0, p0

    return p0
.end method

.method private static toneNatural(F)F
    .locals 4

    .line 301
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    .line 302
    return v0

    .line 304
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    .line 305
    return v0

    .line 307
    :cond_1
    const v1, 0x3f3851ec    # 0.72f

    cmpg-float v2, p0, v1

    if-gtz v2, :cond_2

    .line 308
    const v0, 0x3d3851ec    # 0.045f

    mul-float/2addr v0, p0

    neg-float v1, p0

    const v2, 0x3e3851ec    # 0.18f

    div-float/2addr v1, v2

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->exp(D)D

    move-result-wide v1

    double-to-float v1, v1

    mul-float/2addr v0, v1

    add-float/2addr p0, v0

    invoke-static {p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0

    .line 310
    :cond_2
    const-wide/high16 v2, -0x3ff0000000000000L    # -4.0

    invoke-static {v2, v3}, Ljava/lang/Math;->exp(D)D

    move-result-wide v2

    double-to-float v2, v2

    const v3, 0x3d04b5dd    # 0.0324f

    mul-float/2addr v2, v3

    add-float/2addr v2, v1

    .line 311
    sub-float/2addr p0, v1

    const v1, 0x3e8f5c29    # 0.28f

    div-float/2addr p0, v1

    .line 312
    sub-float/2addr v0, v2

    const v1, 0x3f4ccccd    # 0.8f

    invoke-static {p0, v1}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->shoulderShape(FF)F

    move-result p0

    mul-float/2addr v0, p0

    add-float/2addr v2, v0

    invoke-static {v2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0
.end method

.method private static toneRich(F)F
    .locals 5

    .line 317
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    .line 318
    return v0

    .line 320
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    .line 321
    return v0

    .line 323
    :cond_1
    const v0, 0x3e4ccccd    # 0.2f

    cmpg-float v1, p0, v0

    const v2, 0x3e23d70a    # 0.16f

    if-gez v1, :cond_2

    .line 324
    div-float/2addr p0, v0

    .line 325
    float-to-double v0, p0

    const-wide v3, 0x3ffa666666666666L    # 1.65

    invoke-static {v0, v1, v3, v4}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    double-to-float p0, v0

    mul-float/2addr p0, v2

    return p0

    .line 327
    :cond_2
    const v1, 0x3f333333    # 0.7f

    cmpg-float v3, p0, v1

    if-gez v3, :cond_3

    .line 328
    sub-float/2addr p0, v0

    const/high16 v0, 0x3f000000    # 0.5f

    div-float/2addr p0, v0

    .line 329
    const v0, 0x3f1eb852    # 0.62f

    mul-float/2addr p0, v0

    add-float/2addr p0, v2

    return p0

    .line 331
    :cond_3
    sub-float/2addr p0, v1

    const v0, 0x3e99999a    # 0.3f

    div-float/2addr p0, v0

    .line 332
    const v0, 0x3f0ccccd    # 0.55f

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->shoulderShape(FF)F

    move-result p0

    const v0, 0x3e6147ae    # 0.22f

    mul-float/2addr p0, v0

    const v0, 0x3f47ae14    # 0.78f

    add-float/2addr p0, v0

    invoke-static {p0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->clamp01(F)F

    move-result p0

    return p0
.end method

.method private static trilinear([FIIIIIIFFFI)F
    .locals 4

    .line 358
    invoke-static {p0, p1, p3, p5, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v0

    .line 359
    invoke-static {p0, p2, p3, p5, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v1

    .line 360
    invoke-static {p0, p1, p4, p5, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v2

    .line 361
    invoke-static {p0, p2, p4, p5, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result p5

    .line 362
    invoke-static {p0, p1, p3, p6, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result v3

    .line 363
    invoke-static {p0, p2, p3, p6, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result p3

    .line 364
    invoke-static {p0, p1, p4, p6, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result p1

    .line 365
    invoke-static {p0, p2, p4, p6, p10}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->at([FIIII)F

    move-result p0

    .line 366
    sub-float/2addr v1, v0

    mul-float/2addr v1, p7

    add-float/2addr v0, v1

    .line 367
    sub-float/2addr p5, v2

    mul-float/2addr p5, p7

    add-float/2addr v2, p5

    .line 368
    sub-float/2addr p3, v3

    mul-float/2addr p3, p7

    add-float/2addr v3, p3

    .line 369
    sub-float/2addr p0, p1

    mul-float/2addr p0, p7

    add-float/2addr p1, p0

    .line 370
    sub-float/2addr v2, v0

    mul-float/2addr v2, p8

    add-float/2addr v0, v2

    .line 371
    sub-float/2addr p1, v3

    mul-float/2addr p1, p8

    add-float/2addr v3, p1

    .line 372
    sub-float/2addr v3, v0

    mul-float/2addr v3, p9

    add-float/2addr v0, v3

    return v0
.end method

.method private static warmth(F)F
    .locals 3

    .line 343
    const v0, 0x3df5c28f    # 0.12f

    cmpg-float v1, p0, v0

    if-lez v1, :cond_2

    const/high16 v1, 0x3f800000    # 1.0f

    cmpl-float v2, p0, v1

    if-ltz v2, :cond_0

    goto :goto_1

    .line 346
    :cond_0
    sub-float v0, p0, v0

    .line 347
    mul-float/2addr v0, v0

    sub-float p0, v1, p0

    mul-float/2addr v0, p0

    .line 348
    const p0, 0x411e7b01

    mul-float/2addr v0, p0

    .line 349
    cmpl-float p0, v0, v1

    if-lez p0, :cond_1

    goto :goto_0

    :cond_1
    move v1, v0

    :goto_0
    return v1

    .line 344
    :cond_2
    :goto_1
    const/4 p0, 0x0

    return p0
.end method

.method private static word(Ljava/lang/String;II)Ljava/lang/String;
    .locals 1

    .line 463
    nop

    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 464
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 466
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->wordEnd(Ljava/lang/String;II)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static wordEnd(Ljava/lang/String;II)I
    .locals 1

    .line 486
    nop

    .line 487
    :goto_0
    if-ge p1, p2, :cond_0

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->isSpace(C)Z

    move-result v0

    if-nez v0, :cond_0

    .line 488
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 490
    :cond_0
    return p1
.end method
