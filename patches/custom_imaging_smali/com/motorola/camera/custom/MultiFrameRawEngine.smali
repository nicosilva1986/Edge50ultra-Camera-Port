.class public final Lcom/motorola/camera/custom/MultiFrameRawEngine;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;,
        Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;,
        Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;,
        Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;,
        Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;
    }
.end annotation


# static fields
.field private static final BLUR_LIMIT:D = 0.75

.field private static final GAUSSIAN:[D

.field private static final MIB:J = 0x100000L

.field public static final MODE_FOCUS_STACK:I = 0x4

.field public static final MODE_HDR_PLUS:I = 0x1

.field public static final MODE_RAW_AEB:I = 0x2

.field public static final MODE_SUPER_RES:I = 0x3

.field public static final MODE_SYNTHETIC_ND:I = 0x5

.field private static final SEARCH:I = 0x3

.field private static final TILE:I = 0x10


# instance fields
.field private final mode:I

.field private oldest:I

.field private final ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

.field private size:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 493
    const/16 v0, 0x201

    new-array v0, v0, [D

    sput-object v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->GAUSSIAN:[D

    .line 495
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lcom/motorola/camera/custom/MultiFrameRawEngine;->GAUSSIAN:[D

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 496
    int-to-double v1, v0

    const-wide/high16 v3, 0x4070000000000000L    # 256.0

    div-double/2addr v1, v3

    .line 497
    sget-object v3, Lcom/motorola/camera/custom/MultiFrameRawEngine;->GAUSSIAN:[D

    neg-double v4, v1

    mul-double/2addr v4, v1

    const-wide v1, 0x3fdebb98c7e28240L    # 0.48019999999999996

    div-double/2addr v4, v1

    invoke-static {v4, v5}, Ljava/lang/Math;->exp(D)D

    move-result-wide v1

    aput-wide v1, v3, v0

    .line 495
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 499
    :cond_0
    return-void
.end method

.method public constructor <init>(II)V
    .locals 0

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->checkConfig(II)V

    .line 108
    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    .line 109
    new-array p1, p2, [Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 110
    return-void
.end method

.method private anchor()Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;
    .locals 10

    .line 181
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    if-eqz v0, :cond_8

    .line 182
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    new-array v0, v0, [Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 183
    nop

    .line 184
    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->at(I)Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-result-object v2

    .line 185
    move v3, v1

    move v4, v3

    :goto_0
    iget v5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    if-ge v3, v5, :cond_2

    .line 186
    invoke-direct {p0, v3}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->at(I)Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-result-object v5

    .line 187
    iget-wide v6, v5, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    const-wide/high16 v8, 0x3fe8000000000000L    # 0.75

    cmpl-double v6, v6, v8

    if-gtz v6, :cond_0

    add-int/lit8 v6, v4, 0x1

    aput-object v5, v0, v4

    move v4, v6

    .line 188
    :cond_0
    iget-wide v6, v5, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    iget-wide v8, v2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    cmpg-double v6, v6, v8

    if-gez v6, :cond_1

    move-object v2, v5

    .line 185
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 190
    :cond_2
    if-nez v4, :cond_3

    return-object v2

    .line 191
    :cond_3
    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_4

    .line 192
    new-instance v2, Lcom/motorola/camera/custom/MultiFrameRawEngine$$ExternalSyntheticLambda0;

    invoke-direct {v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v0, v1, v4, v2}, Ljava/util/Arrays;->sort([Ljava/lang/Object;IILjava/util/Comparator;)V

    .line 193
    div-int/2addr v4, v3

    aget-object v0, v0, v4

    return-object v0

    .line 196
    :cond_4
    aget-object v1, v0, v1

    .line 197
    const/4 v2, 0x1

    :goto_1
    if-ge v2, v4, :cond_7

    .line 198
    aget-object v3, v0, v2

    iget-wide v5, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    .line 199
    invoke-static {v5, v6}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_6

    iget-wide v7, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    invoke-static {v7, v8}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-wide v7, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    cmpg-double v3, v5, v7

    if-gez v3, :cond_6

    :cond_5
    aget-object v1, v0, v2

    .line 197
    :cond_6
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 201
    :cond_7
    return-object v1

    .line 181
    :cond_8
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Empty burst"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private at(I)Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;
    .locals 2

    .line 171
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->oldest:I

    add-int/2addr v1, p1

    iget-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    array-length p1, p1

    rem-int/2addr v1, p1

    aget-object p1, v0, v1

    return-object p1
.end method

.method private static blurLine([FIII)V
    .locals 5

    .line 414
    aget v0, p0, p1

    .line 415
    const/4 v1, 0x0

    move v2, v1

    move v1, v0

    :goto_0
    if-ge v2, p3, :cond_1

    .line 416
    add-int/lit8 v2, v2, 0x1

    if-ge v2, p3, :cond_0

    add-int v3, p1, p2

    aget v3, p0, v3

    goto :goto_1

    :cond_0
    move v3, v0

    .line 417
    :goto_1
    const/high16 v4, 0x40000000    # 2.0f

    mul-float/2addr v4, v0

    add-float/2addr v1, v4

    add-float/2addr v1, v3

    const/high16 v4, 0x3e800000    # 0.25f

    mul-float/2addr v1, v4

    aput v1, p0, p1

    .line 418
    nop

    .line 419
    nop

    .line 415
    add-int/2addr p1, p2

    move v1, v0

    move v0, v3

    goto :goto_0

    .line 421
    :cond_1
    return-void
.end method

.method private static checkConfig(II)V
    .locals 2

    .line 113
    const/4 v0, 0x1

    if-lt p0, v0, :cond_0

    const/4 v1, 0x5

    if-gt p0, v1, :cond_0

    if-lt p1, v0, :cond_0

    const/16 p0, 0x8

    if-gt p1, p0, :cond_0

    .line 115
    return-void

    .line 114
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid mode or frame count"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static cost([F[FIIIIIIIIID)D
    .locals 19

    .line 293
    move/from16 v0, p2

    move-wide/from16 v1, p11

    const-wide/high16 v3, 0x3ff0000000000000L    # 1.0

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->min(DD)D

    move-result-wide v3

    .line 294
    nop

    .line 295
    const-wide/16 v5, 0x0

    const/4 v7, 0x0

    move v8, v7

    move-wide v6, v5

    move/from16 v5, p5

    :goto_0
    move/from16 v9, p7

    if-ge v5, v9, :cond_3

    move/from16 v10, p4

    :goto_1
    move/from16 v11, p6

    if-ge v10, v11, :cond_2

    .line 296
    add-int v12, v10, p8

    add-int v13, v5, p9

    .line 297
    if-ltz v12, :cond_1

    if-ltz v13, :cond_1

    if-ge v12, v0, :cond_1

    move/from16 v14, p3

    if-lt v13, v14, :cond_0

    goto :goto_2

    .line 298
    :cond_0
    mul-int v15, v5, v0

    add-int/2addr v15, v10

    aget v15, p0, v15

    float-to-double v0, v15

    invoke-static {v3, v4, v0, v1}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    mul-int v13, v13, p2

    add-int/2addr v13, v12

    aget v2, p1, v13

    float-to-double v12, v2

    mul-double v12, v12, p11

    invoke-static {v3, v4, v12, v13}, Ljava/lang/Math;->min(DD)D

    move-result-wide v12

    .line 299
    const-wide v15, 0x3fb999999999999aL    # 0.1

    move-wide/from16 v17, v0

    mul-double v0, v3, v15

    sub-double v12, v17, v12

    invoke-static {v12, v13}, Ljava/lang/Math;->abs(D)D

    move-result-wide v12

    invoke-static {v0, v1, v12, v13}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    add-double/2addr v6, v0

    .line 300
    add-int/lit8 v8, v8, 0x1

    goto :goto_2

    .line 297
    :cond_1
    move/from16 v14, p3

    .line 295
    :goto_2
    add-int v10, v10, p10

    move/from16 v0, p2

    move-wide/from16 v1, p11

    goto :goto_1

    :cond_2
    move/from16 v14, p3

    add-int v5, v5, p10

    move/from16 v0, p2

    move-wide/from16 v1, p11

    goto :goto_0

    .line 302
    :cond_3
    if-nez v8, :cond_4

    const-wide/high16 v0, 0x7ff0000000000000L    # Double.POSITIVE_INFINITY

    goto :goto_3

    :cond_4
    int-to-double v0, v8

    div-double v0, v6, v0

    :goto_3
    return-wide v0
.end method

.method private static dimensions(II)V
    .locals 2

    .line 118
    const/4 v0, 0x4

    if-lt p0, v0, :cond_0

    const/4 v0, 0x2

    if-lt p1, v0, :cond_0

    and-int/lit8 v0, p1, 0x1

    if-nez v0, :cond_0

    int-to-long v0, p0

    int-to-long p0, p1

    mul-long/2addr v0, p0

    const-wide/32 p0, 0x7ffffff7

    cmp-long p0, v0, p0

    if-gtz p0, :cond_0

    .line 120
    return-void

    .line 119
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Invalid Bayer dimensions"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static displacement(D)F
    .locals 4

    .line 348
    const-wide/high16 v0, 0x4000000000000000L    # 2.0

    mul-double/2addr p0, v0

    const-wide/high16 v0, 0x4018000000000000L    # 6.0

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->min(DD)D

    move-result-wide p0

    const-wide/high16 v0, -0x3fe8000000000000L    # -6.0

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->max(DD)D

    move-result-wide p0

    .line 349
    invoke-static {p0, p1}, Ljava/lang/Math;->rint(D)D

    move-result-wide v0

    sub-double v0, p0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x3fb1eb851eb851ecL    # 0.07

    cmpg-double v0, v0, v2

    if-gez v0, :cond_0

    invoke-static {p0, p1}, Ljava/lang/Math;->rint(D)D

    move-result-wide p0

    :cond_0
    double-to-float p0, p0

    return p0
.end method

.method private static diverse([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;II)Z
    .locals 10

    .line 484
    const/4 v0, 0x1

    move v1, v0

    :goto_0
    if-ge v1, p1, :cond_1

    .line 485
    aget-object v2, p0, v1

    iget-object v2, v2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    aget v2, v2, p2

    float-to-double v2, v2

    aget-object v4, p0, v1

    iget-object v4, v4, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget v4, v4, p2

    float-to-double v4, v4

    .line 486
    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    div-double v8, v2, v6

    invoke-static {v8, v9}, Ljava/lang/Math;->rint(D)D

    move-result-wide v8

    mul-double/2addr v8, v6

    sub-double/2addr v2, v8

    div-double v8, v4, v6

    invoke-static {v8, v9}, Ljava/lang/Math;->rint(D)D

    move-result-wide v8

    mul-double/2addr v8, v6

    sub-double/2addr v4, v8

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v2

    const-wide v4, 0x3fc999999999999aL    # 0.2

    cmpl-double v2, v2, v4

    if-lez v2, :cond_0

    return v0

    .line 484
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 488
    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private static edge(III)I
    .locals 2

    .line 279
    int-to-long v0, p0

    int-to-long p0, p1

    mul-long/2addr v0, p0

    div-int/lit8 p0, p2, 0x2

    int-to-long p0, p0

    add-long/2addr v0, p0

    int-to-long p0, p2

    div-long/2addr v0, p0

    long-to-int p0, v0

    return p0
.end method

.method private static estimateNoise(Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;[F[FI)V
    .locals 20

    .line 385
    move-object/from16 v0, p0

    const/16 v1, 0x100

    new-array v1, v1, [I

    .line 386
    iget-object v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v2, v2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/lit8 v2, v2, 0x2

    iget-object v3, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v3, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    div-int/lit8 v3, v3, 0x2

    .line 387
    int-to-double v4, v2

    int-to-double v6, v3

    mul-double/2addr v4, v6

    const-wide/high16 v6, 0x40b0000000000000L    # 4096.0

    div-double/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v4

    double-to-int v4, v4

    const/4 v5, 0x1

    invoke-static {v5, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 388
    const/4 v9, 0x0

    const/4 v10, 0x0

    :goto_0
    const/16 v11, 0xff

    const/high16 v12, 0x40000000    # 2.0f

    if-ge v9, v3, :cond_3

    const/4 v13, 0x0

    :goto_1
    if-ge v13, v2, :cond_2

    .line 389
    mul-int/lit8 v14, v9, 0x2

    div-int/lit8 v14, v14, 0x10

    mul-int v14, v14, p3

    mul-int/lit8 v15, v13, 0x2

    div-int/lit8 v15, v15, 0x10

    add-int/2addr v14, v15

    .line 390
    iget-object v15, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    aget v15, v15, v14

    div-float/2addr v15, v12

    invoke-static {v15}, Ljava/lang/Math;->round(F)I

    move-result v15

    add-int/2addr v15, v13

    move/from16 v16, v5

    iget-object v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget v5, v5, v14

    div-float/2addr v5, v12

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    add-int/2addr v5, v9

    .line 391
    if-ltz v15, :cond_1

    if-ltz v5, :cond_1

    if-ge v15, v2, :cond_1

    if-lt v5, v3, :cond_0

    move-wide/from16 v17, v6

    move/from16 v19, v9

    goto :goto_2

    .line 392
    :cond_0
    mul-int v14, v9, v2

    add-int/2addr v14, v13

    aget v14, p1, v14

    move-wide/from16 v17, v6

    float-to-double v6, v14

    mul-int/2addr v5, v2

    add-int/2addr v5, v15

    aget v5, p2, v5

    float-to-double v14, v5

    move/from16 v19, v9

    iget-wide v8, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    mul-double/2addr v14, v8

    sub-double/2addr v6, v14

    invoke-static {v6, v7}, Ljava/lang/Math;->abs(D)D

    move-result-wide v6

    .line 393
    mul-double v6, v6, v17

    double-to-int v6, v6

    invoke-static {v11, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    aget v7, v1, v6

    add-int/lit8 v7, v7, 0x1

    aput v7, v1, v6

    .line 394
    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    .line 391
    :cond_1
    move-wide/from16 v17, v6

    move/from16 v19, v9

    .line 388
    :goto_2
    add-int/2addr v13, v4

    move/from16 v5, v16

    move-wide/from16 v6, v17

    move/from16 v9, v19

    goto :goto_1

    :cond_2
    move/from16 v16, v5

    move-wide/from16 v17, v6

    move/from16 v19, v9

    add-int v9, v19, v4

    goto :goto_0

    .line 396
    :cond_3
    move-wide/from16 v17, v6

    const/4 v5, 0x0

    const/4 v8, 0x0

    .line 397
    :goto_3
    if-ge v8, v11, :cond_5

    aget v2, v1, v8

    add-int/2addr v5, v2

    mul-int/lit8 v2, v5, 0x2

    if-lt v2, v10, :cond_4

    goto :goto_4

    :cond_4
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 398
    :cond_5
    :goto_4
    int-to-double v1, v8

    const-wide/high16 v3, 0x3fe0000000000000L    # 0.5

    add-double/2addr v1, v3

    const-wide v3, 0x4007b8bac710cb29L    # 2.9652

    mul-double/2addr v1, v3

    div-double v1, v1, v17

    const-wide v3, 0x3fa47ae147ae147bL    # 0.04

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->min(DD)D

    move-result-wide v1

    .line 399
    iget-object v3, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v3, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    div-float/2addr v12, v3

    float-to-double v3, v12

    const-wide v5, 0x3f50624dd2f1a9fcL    # 0.001

    invoke-static {v3, v4, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v3

    .line 400
    const-wide/high16 v5, 0x4018000000000000L    # 6.0

    mul-double/2addr v5, v1

    mul-double/2addr v5, v1

    mul-double/2addr v3, v3

    add-double/2addr v5, v3

    iput-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->noiseVariance:D

    .line 401
    return-void
.end method

.method public static estimatedPeakBytes(IIII)J
    .locals 10

    .line 130
    invoke-static {p0, p3}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->checkConfig(II)V

    .line 131
    invoke-static {p1, p2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->dimensions(II)V

    .line 132
    int-to-long v0, p1

    int-to-long v2, p2

    mul-long v4, v0, v2

    .line 133
    const/4 v6, 0x3

    if-ne p0, v6, :cond_0

    const/4 p0, 0x4

    invoke-static {p1, p0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->outputDimension(II)I

    move-result p0

    int-to-long p0, p0

    const/4 v6, 0x2

    invoke-static {p2, v6}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->outputDimension(II)I

    move-result p2

    int-to-long v6, p2

    mul-long/2addr p0, v6

    goto :goto_0

    :cond_0
    move-wide p0, v4

    .line 134
    :goto_0
    const-wide/32 v6, 0x7ffffff7

    cmp-long p2, p0, v6

    if-gtz p2, :cond_1

    .line 135
    const-wide/16 v6, 0xf

    add-long/2addr v0, v6

    const-wide/16 v8, 0x10

    div-long/2addr v0, v8

    add-long/2addr v2, v6

    div-long/2addr v2, v8

    mul-long/2addr v0, v2

    .line 136
    const-wide/16 v2, 0x2

    mul-long/2addr v2, v4

    int-to-long p2, p3

    mul-long v6, v2, p2

    .line 137
    const-wide/16 v8, 0x6

    mul-long/2addr v4, v8

    add-long/2addr v4, v6

    .line 138
    const-wide/16 v8, 0x4

    mul-long/2addr p0, v8

    add-long/2addr v6, p0

    add-long/2addr v6, v2

    const-wide/16 p0, 0xc

    mul-long/2addr p2, p0

    const-wide/16 p0, 0x8

    add-long/2addr p2, p0

    mul-long/2addr v0, p2

    add-long/2addr v6, v0

    .line 139
    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p0

    const-wide/32 p2, 0x100000

    add-long/2addr p0, p2

    return-wide p0

    .line 134
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Output too large"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private fuse([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;IIIIII)D
    .locals 30

    .line 454
    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p4

    move/from16 v3, p5

    move/from16 v9, p6

    move/from16 v10, p7

    const/4 v4, 0x0

    aget-object v5, p1, v4

    iget-object v11, v5, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 455
    invoke-virtual {v11, v2, v3, v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v12

    .line 456
    const/4 v14, 0x1

    if-eq v1, v14, :cond_d

    iget v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v15, 0x4

    if-ne v5, v15, :cond_0

    if-nez v10, :cond_0

    goto/16 :goto_7

    .line 457
    :cond_0
    nop

    .line 458
    move-wide v7, v12

    const-wide/16 v16, 0x0

    const-wide/16 v18, 0x0

    :goto_0
    move/from16 v20, v14

    if-ge v4, v1, :cond_a

    .line 459
    aget-object v14, p1, v4

    .line 460
    const-wide/16 v22, 0x0

    int-to-float v5, v2

    iget-object v6, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    aget v6, v6, p3

    add-float/2addr v5, v6

    float-to-double v5, v5

    int-to-float v15, v3

    iget-object v1, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget v1, v1, p3

    add-float/2addr v15, v1

    float-to-double v1, v15

    .line 461
    cmpg-double v15, v5, v22

    if-ltz v15, :cond_8

    cmpg-double v15, v1, v22

    if-ltz v15, :cond_8

    iget v15, v11, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/lit8 v15, v15, -0x1

    move-wide/from16 v24, v1

    int-to-double v1, v15

    cmpl-double v1, v5, v1

    if-gtz v1, :cond_8

    iget v1, v11, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    add-int/lit8 v1, v1, -0x1

    int-to-double v1, v1

    cmpl-double v1, v24, v1

    if-lez v1, :cond_1

    move v15, v4

    move-wide v1, v7

    goto/16 :goto_4

    .line 462
    :cond_1
    if-nez v4, :cond_2

    move v15, v4

    move-wide v1, v7

    move-wide v4, v12

    goto :goto_1

    :cond_2
    move v1, v4

    iget-object v4, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move v15, v1

    move-wide v1, v7

    move-wide/from16 v7, v24

    invoke-static/range {v4 .. v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->sample(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;DDI)D

    move-result-wide v4

    .line 463
    :goto_1
    iget-wide v6, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    mul-double/2addr v6, v4

    .line 464
    iget v8, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v9, 0x4

    if-ne v8, v9, :cond_3

    .line 465
    if-ne v15, v10, :cond_9

    return-wide v6

    .line 468
    :cond_3
    iget v8, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v9, 0x2

    const-wide/high16 v24, 0x3ff0000000000000L    # 1.0

    if-ne v8, v9, :cond_5

    .line 469
    invoke-static {v1, v2, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    .line 470
    sub-double v9, v24, v4

    const-wide v26, 0x3fb47ae147ae147bL    # 0.08

    div-double v9, v9, v26

    move-wide/from16 v26, v1

    move-wide/from16 v1, v24

    invoke-static {v1, v2, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v8

    const-wide/16 v1, 0x0

    invoke-static {v1, v2, v8, v9}, Ljava/lang/Math;->max(DD)D

    move-result-wide v8

    .line 471
    iget-object v1, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget-object v1, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->inv:[F

    aget v1, v1, p6

    float-to-double v1, v1

    const-wide/high16 v28, 0x3fe0000000000000L    # 0.5

    mul-double v1, v1, v28

    sub-double v1, v24, v1

    cmpl-double v1, v4, v1

    if-ltz v1, :cond_4

    const-wide/16 v8, 0x0

    .line 472
    :cond_4
    mul-double/2addr v8, v8

    iget-wide v1, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    iget-wide v4, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    mul-double/2addr v1, v4

    div-double v9, v8, v1

    .line 473
    move-wide/from16 v20, v6

    move-wide/from16 v7, v26

    goto :goto_3

    :cond_5
    iget v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    move/from16 v5, v20

    if-ne v4, v5, :cond_7

    if-eqz v15, :cond_7

    .line 474
    sub-double v8, v6, v12

    mul-double/2addr v8, v8

    move-wide/from16 v20, v6

    iget-wide v5, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->noiseVariance:D

    div-double/2addr v8, v5

    .line 475
    const-wide/high16 v5, 0x4039000000000000L    # 25.0

    cmpl-double v5, v8, v5

    if-lez v5, :cond_6

    const-wide/16 v5, 0x0

    goto :goto_2

    :cond_6
    const-wide/high16 v24, 0x3ff0000000000000L    # 1.0

    add-double v8, v8, v24

    div-double v5, v24, v8

    :goto_2
    move-wide v7, v1

    move-wide v9, v5

    goto :goto_3

    .line 473
    :cond_7
    move-wide/from16 v20, v6

    const-wide/high16 v24, 0x3ff0000000000000L    # 1.0

    .line 477
    move-wide v7, v1

    move-wide/from16 v9, v24

    :goto_3
    mul-double v1, v9, v20

    add-double v18, v18, v1

    .line 478
    add-double v16, v16, v9

    goto :goto_5

    .line 461
    :cond_8
    move v15, v4

    move-wide v1, v7

    .line 458
    :cond_9
    :goto_4
    move-wide v7, v1

    :goto_5
    add-int/lit8 v1, v15, 0x1

    move/from16 v2, p4

    move/from16 v9, p6

    move/from16 v10, p7

    move v4, v1

    const/4 v14, 0x1

    const/4 v15, 0x4

    move/from16 v1, p2

    goto/16 :goto_0

    .line 480
    :cond_a
    move-wide v1, v7

    const-wide/16 v22, 0x0

    cmpl-double v3, v16, v22

    if-lez v3, :cond_b

    div-double v12, v18, v16

    goto :goto_6

    :cond_b
    iget v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v9, 0x2

    if-ne v0, v9, :cond_c

    move-wide v12, v1

    :cond_c
    :goto_6
    return-wide v12

    .line 456
    :cond_d
    :goto_7
    return-wide v12
.end method

.method private static guide(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;[FLcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;)Z
    .locals 11

    .line 281
    const/4 v0, 0x1

    if-eqz p2, :cond_0

    invoke-virtual {p2, p0, p1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->fill(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;[F)Z

    move-result p2

    if-eqz p2, :cond_0

    return v0

    .line 282
    :cond_0
    nop

    .line 283
    const/4 p2, 0x0

    move v1, p2

    move v2, v1

    :goto_0
    iget v3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    if-ge v1, v3, :cond_2

    move v3, p2

    :goto_1
    add-int/lit8 v4, v3, 0x1

    iget v5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    if-ge v4, v5, :cond_1

    .line 284
    add-int/lit8 v5, v2, 0x1

    invoke-virtual {p0, v3, v1, p2}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v6

    invoke-virtual {p0, v4, v1, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v8

    add-double/2addr v6, v8

    add-int/lit8 v8, v1, 0x1

    .line 285
    const/4 v9, 0x2

    invoke-virtual {p0, v3, v8, v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v9

    add-double/2addr v6, v9

    const/4 v9, 0x3

    invoke-virtual {p0, v4, v8, v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v8

    add-double/2addr v6, v8

    const-wide/high16 v8, 0x3fd0000000000000L    # 0.25

    mul-double/2addr v6, v8

    double-to-float v4, v6

    aput v4, p1, v2

    .line 283
    add-int/lit8 v3, v3, 0x2

    move v2, v5

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, 0x2

    goto :goto_0

    .line 286
    :cond_2
    return p2
.end method

.method private static kernel(D)D
    .locals 3

    .line 500
    sget-object v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->GAUSSIAN:[D

    invoke-static {p0, p1}, Ljava/lang/Math;->abs(D)D

    move-result-wide p0

    const-wide/high16 v1, 0x4070000000000000L    # 256.0

    mul-double/2addr p0, v1

    const-wide/high16 v1, 0x3fe0000000000000L    # 0.5

    add-double/2addr p0, v1

    double-to-int p0, p0

    const/16 p1, 0x200

    invoke-static {p1, p0}, Ljava/lang/Math;->min(II)I

    move-result p0

    aget-wide p0, v0, p0

    return-wide p0
.end method

.method static synthetic lambda$anchor$0(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;)I
    .locals 2

    .line 192
    iget-wide v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    iget-wide p0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->exposureGain:D

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Double;->compare(DD)I

    move-result p0

    return p0
.end method

.method private mergeInternal(Z)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
    .locals 39

    .line 219
    move-object/from16 v0, p0

    invoke-direct {v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->anchor()Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-result-object v1

    .line 220
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/lit8 v2, v2, 0x10

    const/4 v8, 0x1

    sub-int/2addr v2, v8

    div-int/lit8 v9, v2, 0x10

    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    add-int/lit8 v2, v2, 0x10

    sub-int/2addr v2, v8

    div-int/lit8 v2, v2, 0x10

    mul-int v10, v9, v2

    .line 221
    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v11, 0x0

    const/4 v3, 0x4

    if-ne v2, v3, :cond_0

    move v12, v8

    goto :goto_0

    :cond_0
    move v12, v11

    :goto_0
    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v4, 0x3

    if-ne v2, v4, :cond_1

    move v13, v8

    goto :goto_1

    :cond_1
    move v13, v11

    .line 222
    :goto_1
    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    new-array v14, v2, [Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;

    .line 223
    new-instance v2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;

    invoke-direct {v2, v1, v1, v10, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;-><init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IZ)V

    aput-object v2, v14, v11

    .line 224
    nop

    .line 225
    move v15, v8

    move v2, v11

    :goto_2
    iget v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    if-ge v2, v4, :cond_3

    .line 226
    invoke-direct {v0, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->at(I)Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-result-object v4

    .line 227
    if-eq v4, v1, :cond_2

    iget-wide v5, v4, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->blur:D

    const-wide/high16 v16, 0x3fe8000000000000L    # 0.75

    cmpl-double v5, v5, v16

    if-gtz v5, :cond_2

    add-int/lit8 v5, v15, 0x1

    new-instance v6, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;

    invoke-direct {v6, v4, v1, v10, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;-><init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IZ)V

    aput-object v6, v14, v15

    move v15, v5

    .line 225
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 229
    :cond_3
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    if-eqz v13, :cond_4

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->outputDimension(II)I

    move-result v2

    :cond_4
    move v7, v2

    const/4 v2, 0x2

    iget v4, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    if-eqz v13, :cond_5

    invoke-static {v4, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->outputDimension(II)I

    move-result v4

    .line 230
    :cond_5
    nop

    .line 231
    if-le v15, v8, :cond_10

    .line 232
    iget v5, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/2addr v5, v2

    iget v6, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    div-int/2addr v6, v2

    mul-int/2addr v5, v6

    new-array v6, v5, [F

    new-array v5, v5, [F

    .line 233
    if-eqz p1, :cond_6

    invoke-static {}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->open()Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;

    move-result-object v16

    goto :goto_3

    :cond_6
    const/16 v16, 0x0

    :goto_3
    move/from16 v22, v11

    move-object/from16 v11, v16

    .line 234
    :try_start_0
    invoke-static {v1, v6, v11}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->guide(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;[FLcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;)Z

    move-result v16

    .line 235
    if-nez v13, :cond_7

    if-eqz v12, :cond_8

    :cond_7
    iget v8, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/2addr v8, v2

    invoke-static {v6, v8}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->registrationBand([FI)V

    .line 236
    :cond_8
    if-eqz v12, :cond_9

    aget-object v8, v14, v22

    invoke-static {v8, v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->sharpness(Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;I)V

    .line 237
    :cond_9
    const/4 v8, 0x1

    :goto_4
    if-ge v8, v15, :cond_d

    .line 238
    aget-object v3, v14, v8

    .line 239
    move/from16 v24, v2

    iget-object v2, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    invoke-static {v2, v5, v11}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->guide(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;[FLcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;)Z

    move-result v2

    or-int v16, v16, v2

    .line 240
    if-nez v13, :cond_a

    if-eqz v12, :cond_b

    :cond_a
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    div-int/lit8 v2, v2, 0x2

    invoke-static {v5, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->registrationBand([FI)V

    .line 241
    :cond_b
    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    invoke-static {v6, v5, v3, v9, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->register([F[FLcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;II)V

    .line 242
    if-eqz v12, :cond_c

    invoke-static {v3, v9}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->sharpness(Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 237
    :cond_c
    add-int/lit8 v8, v8, 0x1

    move/from16 v2, v24

    const/4 v3, 0x4

    goto :goto_4

    .line 244
    :cond_d
    move/from16 v24, v2

    if-eqz v11, :cond_e

    invoke-virtual {v11}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->close()V

    .line 246
    :cond_e
    move/from16 v8, v16

    goto :goto_6

    .line 233
    :catchall_0
    move-exception v0

    move-object v1, v0

    if-eqz v11, :cond_f

    :try_start_1
    invoke-virtual {v11}, Lcom/motorola/camera/custom/MultiFrameRawEngine$GuideCompute;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_5

    :catchall_1
    move-exception v0

    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_f
    :goto_5
    throw v1

    .line 231
    :cond_10
    move/from16 v24, v2

    move/from16 v22, v11

    move/from16 v8, v22

    .line 246
    :goto_6
    nop

    .line 247
    iget v2, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    move/from16 v3, v24

    if-ne v2, v3, :cond_12

    const/4 v2, 0x1

    const-wide/high16 v5, 0x3ff0000000000000L    # 1.0

    :goto_7
    if-ge v2, v15, :cond_11

    aget-object v3, v14, v2

    move v11, v2

    iget-wide v2, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    invoke-static {v5, v6, v2, v3}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    add-int/lit8 v2, v11, 0x1

    goto :goto_7

    :cond_11
    move-wide/from16 v25, v5

    goto :goto_8

    :cond_12
    const-wide/high16 v25, 0x3ff0000000000000L    # 1.0

    .line 248
    :goto_8
    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->white:F

    float-to-double v2, v2

    mul-double v2, v2, v25

    const-wide v5, 0x416fffffe0000000L    # 1.6777215E7

    invoke-static {v5, v6, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    double-to-float v11, v2

    .line 249
    mul-int v2, v7, v4

    new-array v2, v2, [I

    const/4 v3, 0x4

    new-array v5, v3, [I

    .line 250
    move/from16 v6, v22

    :goto_9
    if-ge v6, v3, :cond_13

    iget-object v3, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget v3, v3, v6

    move-object/from16 p1, v2

    float-to-double v2, v3

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v2, v2

    aput v2, v5, v6

    add-int/lit8 v6, v6, 0x1

    move-object/from16 v2, p1

    const/4 v3, 0x4

    goto :goto_9

    .line 251
    :cond_13
    move-object/from16 p1, v2

    float-to-double v2, v11

    invoke-static {v2, v3}, Ljava/lang/Math;->floor(D)D

    move-result-wide v2

    double-to-int v2, v2

    .line 252
    nop

    .line 253
    move/from16 v27, v9

    move/from16 v3, v22

    move v9, v3

    :goto_a
    if-ge v3, v10, :cond_1c

    .line 254
    if-eqz v13, :cond_14

    invoke-static {v14, v15, v3}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->diverse([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;II)Z

    move-result v6

    if-eqz v6, :cond_14

    const/16 v28, 0x1

    goto :goto_b

    :cond_14
    move/from16 v28, v22

    .line 255
    :goto_b
    or-int v9, v9, v28

    .line 256
    nop

    .line 257
    if-eqz v12, :cond_17

    const/4 v6, 0x1

    if-le v15, v6, :cond_17

    move/from16 v16, v22

    :goto_c
    if-ge v6, v15, :cond_16

    .line 258
    aget-object v0, v14, v6

    iget-object v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->sharpness:[F

    aget v0, v0, v3

    move/from16 v17, v0

    aget-object v0, v14, v16

    iget-object v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->sharpness:[F

    aget v0, v0, v3

    cmpl-float v0, v17, v0

    if-lez v0, :cond_15

    move/from16 v16, v6

    .line 257
    :cond_15
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v0, p0

    goto :goto_c

    :cond_16
    move/from16 v0, v16

    goto :goto_d

    .line 259
    :cond_17
    move/from16 v0, v22

    :goto_d
    rem-int v6, v3, v27

    mul-int/lit8 v6, v6, 0x10

    div-int v16, v3, v27

    move/from16 v29, v0

    mul-int/lit8 v0, v16, 0x10

    .line 260
    move/from16 v30, v2

    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    invoke-static {v6, v7, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->edge(III)I

    move-result v31

    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    invoke-static {v0, v4, v2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->edge(III)I

    move-result v2

    .line 261
    add-int/lit8 v6, v6, 0x10

    move/from16 v16, v0

    iget v0, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    invoke-static {v6, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iget v6, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    invoke-static {v0, v7, v6}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->edge(III)I

    move-result v0

    add-int/lit8 v6, v16, 0x10

    move/from16 v16, v2

    iget v2, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    invoke-static {v6, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    iget v6, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    invoke-static {v2, v4, v6}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->edge(III)I

    move-result v2

    .line 262
    move/from16 v6, v16

    :goto_e
    if-ge v6, v2, :cond_1b

    move/from16 v32, v8

    move/from16 v8, v31

    :goto_f
    if-ge v8, v0, :cond_1a

    .line 263
    and-int/lit8 v16, v6, 0x1

    const/16 v24, 0x2

    mul-int/lit8 v16, v16, 0x2

    and-int/lit8 v17, v8, 0x1

    add-int v21, v16, v17

    .line 265
    if-eqz v13, :cond_19

    .line 266
    move/from16 v33, v2

    move/from16 v16, v3

    int-to-double v2, v8

    const-wide/high16 v17, 0x3fe0000000000000L    # 0.5

    add-double v2, v2, v17

    move/from16 v34, v0

    iget v0, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    move-wide/from16 v19, v2

    int-to-double v2, v0

    mul-double v2, v2, v19

    move-wide/from16 v19, v2

    int-to-double v2, v7

    div-double v2, v19, v2

    sub-double v2, v2, v17

    move-wide/from16 v19, v2

    int-to-double v2, v6

    add-double v2, v2, v17

    iget v0, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    move-object/from16 v35, v1

    int-to-double v0, v0

    mul-double/2addr v2, v0

    int-to-double v0, v4

    div-double/2addr v2, v0

    sub-double v2, v2, v17

    .line 267
    if-eqz v28, :cond_18

    move-wide/from16 v17, v19

    move-wide/from16 v19, v2

    invoke-static/range {v14 .. v21}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->reconstruct([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;IIDDI)D

    move-result-wide v0

    move-object/from16 v18, p1

    move-wide v2, v0

    move/from16 v17, v4

    move-object/from16 v19, v5

    move v0, v6

    move/from16 v20, v8

    move/from16 p1, v9

    move-object/from16 v1, v35

    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    const/16 v23, 0x1

    goto :goto_10

    :cond_18
    move-wide/from16 v17, v19

    move-wide/from16 v19, v2

    move v0, v6

    move-wide/from16 v2, v17

    move/from16 v6, v21

    move-object/from16 v1, v35

    const/16 v23, 0x1

    move-object/from16 v18, p1

    move/from16 v17, v4

    move/from16 p1, v9

    move-wide/from16 v37, v19

    move-object/from16 v19, v5

    move/from16 v20, v8

    move-wide/from16 v4, v37

    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    invoke-static/range {v1 .. v6}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->sample(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;DDI)D

    move-result-wide v2

    .line 268
    :goto_10
    move-object v4, v14

    move-object v14, v1

    move-object v1, v4

    move/from16 v4, v20

    move/from16 v6, v21

    move/from16 v36, v30

    move-wide/from16 v20, v2

    move v2, v15

    move v15, v7

    goto :goto_11

    .line 269
    :cond_19
    move-object/from16 v18, p1

    move/from16 v34, v0

    move/from16 v33, v2

    move/from16 v16, v3

    move/from16 v17, v4

    move-object/from16 v19, v5

    move v0, v6

    move/from16 v20, v8

    move/from16 p1, v9

    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    const/16 v23, 0x1

    move-object v2, v14

    move-object v14, v1

    move-object v1, v2

    move v5, v0

    move v2, v15

    move/from16 v4, v20

    move/from16 v6, v21

    move/from16 v36, v30

    move-object/from16 v0, p0

    move v15, v7

    move/from16 v7, v29

    invoke-direct/range {v0 .. v7}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->fuse([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;IIIIII)D

    move-result-wide v20

    move v0, v5

    .line 271
    :goto_11
    move v5, v0

    move-object v3, v1

    div-double v0, v20, v25

    invoke-static {v8, v9, v0, v1}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    const-wide/16 v8, 0x0

    invoke-static {v8, v9, v0, v1}, Ljava/lang/Math;->max(DD)D

    move-result-wide v0

    .line 272
    iget-object v7, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget v7, v7, v6

    float-to-double v7, v7

    iget-object v9, v14, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    aget v9, v9, v6

    sub-float v9, v11, v9

    move-wide/from16 v20, v0

    float-to-double v0, v9

    mul-double v0, v0, v20

    add-double/2addr v7, v0

    invoke-static {v7, v8}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v0, v0

    .line 273
    mul-int v1, v5, v15

    add-int/2addr v1, v4

    aget v6, v19, v6

    move/from16 v7, v36

    invoke-static {v7, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v6, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    aput v0, v18, v1

    .line 262
    add-int/lit8 v8, v4, 0x1

    move/from16 v9, p1

    move v6, v5

    move/from16 v30, v7

    move-object v1, v14

    move v7, v15

    move/from16 v4, v17

    move-object/from16 p1, v18

    move-object/from16 v5, v19

    move/from16 v0, v34

    move v15, v2

    move-object v14, v3

    move/from16 v3, v16

    move/from16 v2, v33

    goto/16 :goto_f

    :cond_1a
    move-object/from16 v18, p1

    move/from16 v34, v0

    move/from16 v33, v2

    move/from16 v16, v3

    move/from16 v17, v4

    move-object/from16 v19, v5

    move v5, v6

    move/from16 p1, v9

    move-object v3, v14

    move v2, v15

    const/16 v23, 0x1

    const/16 v24, 0x2

    move-object v14, v1

    move v15, v7

    move/from16 v7, v30

    add-int/lit8 v6, v5, 0x1

    move v7, v15

    move-object/from16 p1, v18

    move-object/from16 v5, v19

    move/from16 v8, v32

    move v15, v2

    move-object v14, v3

    move/from16 v3, v16

    move/from16 v2, v33

    goto/16 :goto_e

    .line 253
    :cond_1b
    move-object/from16 v18, p1

    move/from16 v16, v3

    move/from16 v17, v4

    move-object/from16 v19, v5

    move/from16 v32, v8

    move/from16 p1, v9

    move-object v3, v14

    move v2, v15

    const/16 v23, 0x1

    const/16 v24, 0x2

    move-object v14, v1

    move v15, v7

    move/from16 v7, v30

    add-int/lit8 v0, v16, 0x1

    move v1, v15

    move v15, v2

    move v2, v7

    move v7, v1

    move-object v1, v14

    move-object/from16 p1, v18

    move-object v14, v3

    move v3, v0

    move-object/from16 v0, p0

    goto/16 :goto_a

    .line 276
    :cond_1c
    move-object/from16 v18, p1

    move-object v14, v1

    move/from16 v17, v4

    move/from16 v32, v8

    move v2, v15

    move v15, v7

    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move v8, v11

    const/4 v11, 0x0

    move v5, v2

    move-object v4, v14

    move v2, v15

    move/from16 v3, v17

    move-object/from16 v1, v18

    move-wide/from16 v6, v25

    move/from16 v10, v32

    invoke-direct/range {v0 .. v11}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;-><init>([IIILcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IDFZZLcom/motorola/camera/custom/MultiFrameRawEngine-IA;)V

    return-object v0
.end method

.method private static outputDimension(II)I
    .locals 4

    .line 123
    int-to-long v0, p1

    const-wide/16 v2, 0x3

    int-to-long p0, p0

    mul-long/2addr p0, v2

    const-wide/16 v2, 0x2

    div-long/2addr p0, v2

    div-long/2addr p0, v0

    mul-long/2addr p0, v0

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toIntExact(J)I

    move-result p0

    return p0
.end method

.method private static reconstruct([Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;IIDDI)D
    .locals 28

    .line 503
    and-int/lit8 v0, p7, 0x1

    shr-int/lit8 v1, p7, 0x1

    .line 504
    nop

    .line 505
    const/4 v6, 0x0

    const-wide/16 v7, 0x0

    const-wide/16 v9, 0x0

    :goto_0
    move/from16 v11, p1

    if-ge v6, v11, :cond_6

    .line 506
    aget-object v12, p0, v6

    .line 507
    iget-object v13, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    aget v13, v13, p2

    float-to-double v13, v13

    add-double v13, p3, v13

    iget-object v15, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget v15, v15, p2

    const-wide/16 v16, 0x0

    float-to-double v2, v15

    add-double v2, p5, v2

    .line 508
    const/4 v15, 0x0

    int-to-double v4, v0

    sub-double v4, v13, v4

    const-wide/high16 v18, 0x4000000000000000L    # 2.0

    div-double v4, v4, v18

    invoke-static {v4, v5}, Ljava/lang/Math;->floor(D)D

    move-result-wide v4

    double-to-int v4, v4

    mul-int/lit8 v4, v4, 0x2

    add-int/2addr v4, v0

    move-wide/from16 v20, v2

    int-to-double v2, v1

    sub-double v2, v20, v2

    div-double v2, v2, v18

    invoke-static {v2, v3}, Ljava/lang/Math;->floor(D)D

    move-result-wide v2

    double-to-int v2, v2

    mul-int/lit8 v2, v2, 0x2

    add-int/2addr v2, v1

    .line 509
    move v3, v2

    :goto_1
    add-int/lit8 v5, v2, 0x2

    if-gt v3, v5, :cond_5

    .line 510
    if-ltz v3, :cond_3

    iget-object v5, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v5, v5, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    if-lt v3, v5, :cond_0

    move v5, v0

    move/from16 v18, v1

    move/from16 v19, v15

    goto :goto_4

    .line 511
    :cond_0
    move v5, v0

    move/from16 v18, v1

    int-to-double v0, v3

    sub-double v0, v0, v20

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->kernel(D)D

    move-result-wide v0

    .line 512
    move/from16 v19, v15

    move v15, v4

    :goto_2
    move-wide/from16 v22, v0

    add-int/lit8 v0, v4, 0x2

    if-gt v15, v0, :cond_4

    .line 513
    if-ltz v15, :cond_2

    iget-object v0, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    if-lt v15, v0, :cond_1

    goto :goto_3

    .line 514
    :cond_1
    int-to-double v0, v15

    sub-double/2addr v0, v13

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->kernel(D)D

    move-result-wide v0

    mul-double v0, v0, v22

    .line 515
    move-wide/from16 v24, v0

    iget-object v0, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move/from16 v1, p7

    invoke-virtual {v0, v15, v3, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v26

    mul-double v26, v26, v24

    iget-wide v0, v12, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    mul-double v26, v26, v0

    add-double v9, v9, v26

    .line 516
    add-double v7, v7, v24

    .line 512
    :cond_2
    :goto_3
    add-int/lit8 v15, v15, 0x2

    move-wide/from16 v0, v22

    goto :goto_2

    .line 510
    :cond_3
    move v5, v0

    move/from16 v18, v1

    move/from16 v19, v15

    .line 509
    :cond_4
    :goto_4
    add-int/lit8 v3, v3, 0x2

    move v0, v5

    move/from16 v1, v18

    move/from16 v15, v19

    goto :goto_1

    .line 505
    :cond_5
    move v5, v0

    move/from16 v18, v1

    move/from16 v19, v15

    add-int/lit8 v6, v6, 0x1

    goto/16 :goto_0

    .line 520
    :cond_6
    const-wide/16 v16, 0x0

    const/16 v19, 0x0

    cmpl-double v0, v7, v16

    if-lez v0, :cond_7

    div-double/2addr v9, v7

    goto :goto_5

    :cond_7
    aget-object v0, p0, v19

    iget-object v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-wide/from16 v1, p3

    move-wide/from16 v3, p5

    move/from16 v5, p7

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->sample(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;DDI)D

    move-result-wide v9

    :goto_5
    return-wide v9
.end method

.method private static refine([F[FIIIIIIID[D)V
    .locals 46

    .line 355
    move/from16 v0, p2

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    const/4 v3, 0x4

    if-ge v2, v3, :cond_8

    .line 356
    nop

    .line 357
    aget-wide v3, p11, v1

    invoke-static {v3, v4}, Ljava/lang/Math;->floor(D)D

    move-result-wide v3

    double-to-int v3, v3

    const/4 v4, 0x1

    aget-wide v5, p11, v4

    invoke-static {v5, v6}, Ljava/lang/Math;->floor(D)D

    move-result-wide v5

    double-to-int v5, v5

    .line 358
    aget-wide v6, p11, v1

    int-to-double v8, v3

    sub-double/2addr v6, v8

    aget-wide v8, p11, v4

    int-to-double v10, v5

    sub-double/2addr v8, v10

    .line 359
    const-wide v10, 0x3eb0c6f7a0b5ed8dL    # 1.0E-6

    const-wide/16 v12, 0x0

    move/from16 v20, v1

    move-wide v14, v12

    move-wide/from16 v16, v14

    move-wide/from16 v18, v16

    move/from16 v1, p5

    move-wide v12, v10

    :goto_1
    move/from16 v21, v4

    move/from16 v4, p7

    if-ge v1, v4, :cond_5

    move/from16 v22, v1

    move/from16 v1, p4

    :goto_2
    move/from16 v23, v2

    move/from16 v2, p6

    if-ge v1, v2, :cond_4

    .line 360
    add-int v24, v1, v3

    add-int v25, v22, v5

    .line 361
    if-ltz v24, :cond_2

    if-ltz v25, :cond_2

    move/from16 v26, v1

    add-int/lit8 v1, v24, 0x1

    if-ge v1, v0, :cond_3

    add-int/lit8 v1, v25, 0x1

    move/from16 v0, p3

    if-lt v1, v0, :cond_0

    goto/16 :goto_3

    .line 362
    :cond_0
    mul-int v25, v25, p2

    add-int v25, v25, v24

    .line 363
    aget v1, p1, v25

    float-to-double v0, v1

    add-int/lit8 v24, v25, 0x1

    move-wide/from16 v27, v0

    aget v0, p1, v24

    float-to-double v0, v0

    add-int v25, v25, p2

    move-wide/from16 v29, v0

    aget v0, p1, v25

    float-to-double v0, v0

    add-int/lit8 v25, v25, 0x1

    move-wide/from16 v31, v0

    aget v0, p1, v25

    float-to-double v0, v0

    .line 364
    sub-double v24, v29, v27

    mul-double v33, v24, v6

    add-double v33, v27, v33

    const-wide/high16 v35, 0x3ff0000000000000L    # 1.0

    sub-double v37, v35, v8

    mul-double v33, v33, v37

    sub-double v39, v0, v31

    mul-double v41, v39, v6

    add-double v41, v31, v41

    mul-double v41, v41, v8

    add-double v33, v33, v41

    .line 365
    mul-int v41, v22, p2

    add-int v41, v41, v26

    move-wide/from16 v42, v0

    aget v0, p0, v41

    float-to-double v0, v0

    .line 366
    const-wide v44, 0x3fee666666666666L    # 0.95

    cmpl-double v41, v0, v44

    if-gez v41, :cond_3

    cmpl-double v41, v33, v44

    if-ltz v41, :cond_1

    goto :goto_3

    .line 367
    :cond_1
    mul-double v33, v33, p9

    sub-double v0, v0, v33

    .line 368
    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v33

    const-wide v44, 0x3f9999999999999aL    # 0.025

    div-double v33, v33, v44

    add-double v33, v33, v35

    div-double v33, v35, v33

    .line 369
    mul-double v24, v24, v37

    mul-double v39, v39, v8

    add-double v24, v24, v39

    mul-double v24, v24, p9

    .line 370
    sub-double v27, v31, v27

    sub-double v35, v35, v6

    mul-double v27, v27, v35

    sub-double v29, v42, v29

    mul-double v29, v29, v6

    add-double v27, v27, v29

    mul-double v27, v27, p9

    .line 371
    mul-double v29, v33, v24

    mul-double v24, v24, v29

    add-double v10, v10, v24

    mul-double v33, v33, v27

    mul-double v24, v33, v27

    add-double v12, v12, v24

    mul-double v27, v27, v29

    add-double v14, v14, v27

    .line 372
    mul-double v29, v29, v0

    add-double v16, v16, v29

    mul-double v33, v33, v0

    add-double v18, v18, v33

    goto :goto_3

    .line 361
    :cond_2
    move/from16 v26, v1

    .line 359
    :cond_3
    :goto_3
    add-int v1, v26, p8

    move/from16 v0, p2

    move/from16 v2, v23

    goto/16 :goto_2

    :cond_4
    add-int v1, v22, p8

    move/from16 v0, p2

    move/from16 v4, v21

    move/from16 v2, v23

    goto/16 :goto_1

    .line 374
    :cond_5
    move/from16 v23, v2

    move/from16 v2, p6

    mul-double v0, v10, v12

    mul-double v5, v14, v14

    sub-double/2addr v0, v5

    .line 375
    const-wide v5, 0x3ddb7cdfd9d7bdbbL    # 1.0E-10

    cmpg-double v3, v0, v5

    if-gez v3, :cond_6

    goto :goto_4

    .line 376
    :cond_6
    mul-double v12, v12, v16

    mul-double v5, v14, v18

    sub-double/2addr v12, v5

    div-double/2addr v12, v0

    const-wide v5, 0x3fdccccccccccccdL    # 0.45

    invoke-static {v5, v6, v12, v13}, Ljava/lang/Math;->min(DD)D

    move-result-wide v7

    const-wide v12, -0x4023333333333333L    # -0.45

    invoke-static {v12, v13, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    .line 377
    mul-double v10, v10, v18

    mul-double v14, v14, v16

    sub-double/2addr v10, v14

    div-double/2addr v10, v0

    invoke-static {v5, v6, v10, v11}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    invoke-static {v12, v13, v0, v1}, Ljava/lang/Math;->max(DD)D

    move-result-wide v0

    .line 378
    aget-wide v5, p11, v20

    add-double/2addr v5, v7

    aput-wide v5, p11, v20

    aget-wide v5, p11, v21

    add-double/2addr v5, v0

    aput-wide v5, p11, v21

    .line 379
    mul-double/2addr v7, v7

    mul-double/2addr v0, v0

    add-double/2addr v7, v0

    const-wide v0, 0x3f1a36e2eb1c432dL    # 1.0E-4

    cmpg-double v0, v7, v0

    if-gez v0, :cond_7

    goto :goto_4

    .line 355
    :cond_7
    add-int/lit8 v0, v23, 0x1

    move v2, v0

    move/from16 v1, v20

    move/from16 v0, p2

    goto/16 :goto_0

    .line 381
    :cond_8
    :goto_4
    return-void
.end method

.method private static register([F[FLcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;II)V
    .locals 31

    .line 306
    move-object/from16 v0, p2

    move/from16 v1, p3

    move/from16 v2, p4

    iget-object v3, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v3, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    const/4 v4, 0x2

    div-int/lit8 v7, v3, 0x2

    iget-object v3, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v3, v3, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    div-int/lit8 v8, v3, 0x2

    .line 307
    int-to-double v5, v7

    int-to-double v9, v8

    mul-double/2addr v5, v9

    const-wide/high16 v9, 0x40a2000000000000L    # 2304.0

    div-double/2addr v5, v9

    invoke-static {v5, v6}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v5

    double-to-int v3, v5

    const/4 v5, 0x1

    invoke-static {v5, v3}, Ljava/lang/Math;->max(II)I

    move-result v13

    .line 308
    add-int/lit8 v3, v7, -0x1

    const/4 v6, 0x3

    div-int/2addr v3, v6

    add-int/lit8 v9, v8, -0x1

    div-int/2addr v9, v6

    invoke-static {v3, v9}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v6, v3}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 309
    nop

    .line 310
    nop

    .line 312
    const-wide/high16 v10, 0x7ff0000000000000L    # Double.POSITIVE_INFINITY

    const/4 v12, -0x3

    move v14, v12

    const/4 v3, 0x0

    const/4 v15, 0x0

    const/16 v18, 0x0

    :goto_0
    if-gt v14, v6, :cond_2

    move-wide/from16 v19, v10

    move/from16 v21, v15

    move v15, v13

    move v13, v12

    :goto_1
    if-gt v13, v6, :cond_1

    .line 313
    sub-int v11, v7, v9

    move v10, v12

    sub-int v12, v8, v9

    iget-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    move/from16 v22, v10

    move v10, v9

    move-wide/from16 v16, v5

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->cost([F[FIIIIIIIIID)D

    move-result-wide v10

    move v12, v13

    move v13, v15

    mul-int v5, v12, v12

    mul-int v6, v14, v14

    add-int/2addr v5, v6

    int-to-double v5, v5

    const-wide v15, 0x3eb0c6f7a0b5ed8dL    # 1.0E-6

    mul-double/2addr v5, v15

    add-double/2addr v10, v5

    .line 315
    cmpg-double v5, v10, v19

    if-gez v5, :cond_0

    move-wide/from16 v19, v10

    move/from16 v21, v12

    move v3, v14

    .line 312
    :cond_0
    add-int/lit8 v5, v12, 0x1

    move v15, v13

    const/4 v6, 0x3

    const/4 v12, -0x3

    move v13, v5

    const/4 v5, 0x1

    goto :goto_1

    :cond_1
    move v13, v15

    add-int/lit8 v14, v14, 0x1

    move-wide/from16 v10, v19

    move/from16 v15, v21

    const/4 v5, 0x1

    const/4 v6, 0x3

    const/4 v12, -0x3

    goto :goto_0

    .line 317
    :cond_2
    int-to-double v5, v15

    int-to-double v10, v3

    new-array v12, v4, [D

    aput-wide v5, v12, v18

    const/16 v16, 0x1

    aput-wide v10, v12, v16

    .line 318
    sub-int v11, v7, v9

    move/from16 v23, v16

    move-object/from16 v16, v12

    sub-int v12, v8, v9

    move/from16 v21, v15

    iget-wide v14, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    move v10, v9

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v16}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->refine([F[FIIIIIIID[D)V

    .line 319
    move-object/from16 v19, v16

    new-array v5, v4, [D

    .line 320
    move/from16 v6, v18

    :goto_2
    iget-object v9, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    array-length v9, v9

    if-ge v6, v9, :cond_9

    .line 321
    rem-int v9, v6, v1

    mul-int/lit8 v9, v9, 0x10

    div-int/2addr v9, v4

    div-int v10, v6, v1

    mul-int/lit8 v10, v10, 0x10

    div-int/2addr v10, v4

    .line 322
    add-int/lit8 v11, v9, -0x3

    move/from16 v12, v18

    invoke-static {v12, v11}, Ljava/lang/Math;->max(II)I

    move-result v11

    add-int/lit8 v13, v10, -0x3

    invoke-static {v12, v13}, Ljava/lang/Math;->max(II)I

    move-result v13

    .line 323
    add-int/lit8 v9, v9, 0x8

    const/16 v17, 0x3

    add-int/lit8 v9, v9, 0x3

    invoke-static {v7, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    add-int/lit8 v10, v10, 0x8

    add-int/lit8 v10, v10, 0x3

    invoke-static {v8, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 324
    aget-wide v14, v19, v12

    aput-wide v14, v5, v12

    const/16 v16, 0x1

    aget-wide v14, v19, v16

    aput-wide v14, v5, v16

    .line 326
    const/4 v12, 0x5

    if-eq v2, v12, :cond_8

    .line 327
    const/4 v15, 0x1

    move-object v12, v5

    iget-wide v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    move v14, v11

    move v11, v9

    move v9, v14

    move-object v14, v12

    move v12, v10

    move v10, v13

    move/from16 v13, v21

    move-object/from16 v21, v14

    move v14, v3

    move/from16 v23, v16

    move/from16 v3, v17

    move-wide/from16 v16, v4

    move v4, v6

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->cost([F[FIIIIIIIIID)D

    move-result-wide v15

    .line 328
    nop

    .line 329
    nop

    .line 330
    add-int/lit8 v5, v14, -0x1

    const/4 v6, -0x3

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    move/from16 v22, v14

    move-wide/from16 v16, v15

    move v14, v5

    move v15, v13

    move/from16 v5, v22

    :goto_3
    add-int/lit8 v6, v22, 0x1

    invoke-static {v3, v6}, Ljava/lang/Math;->min(II)I

    move-result v6

    if-gt v14, v6, :cond_5

    .line 331
    add-int/lit8 v6, v13, -0x1

    const/4 v3, -0x3

    invoke-static {v3, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    move/from16 v25, v5

    move/from16 v26, v15

    move-wide/from16 v27, v16

    :goto_4
    add-int/lit8 v15, v13, 0x1

    const/4 v5, 0x3

    invoke-static {v5, v15}, Ljava/lang/Math;->min(II)I

    move-result v15

    if-gt v6, v15, :cond_4

    .line 332
    const/4 v15, 0x1

    move/from16 v24, v4

    iget-wide v3, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    move-wide/from16 v16, v3

    move v3, v13

    move/from16 v4, v22

    const/16 v29, -0x3

    move/from16 v22, v5

    move v13, v6

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->cost([F[FIIIIIIIIID)D

    move-result-wide v15

    iget-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    .line 333
    move/from16 v17, v7

    move/from16 v30, v8

    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->min(DD)D

    move-result-wide v5

    const-wide v7, 0x3f70624dd2f1a9fcL    # 0.004

    mul-double/2addr v5, v7

    sub-int v7, v13, v3

    invoke-static {v7}, Ljava/lang/Math;->abs(I)I

    move-result v7

    sub-int v8, v14, v4

    invoke-static {v8}, Ljava/lang/Math;->abs(I)I

    move-result v8

    add-int/2addr v7, v8

    int-to-double v7, v7

    mul-double/2addr v5, v7

    add-double/2addr v15, v5

    .line 334
    cmpg-double v5, v15, v27

    if-gez v5, :cond_3

    move/from16 v26, v13

    move/from16 v25, v14

    move-wide/from16 v27, v15

    .line 331
    :cond_3
    add-int/lit8 v6, v13, 0x1

    move v13, v3

    move/from16 v22, v4

    move/from16 v7, v17

    move/from16 v4, v24

    move/from16 v3, v29

    move/from16 v8, v30

    goto :goto_4

    .line 330
    :cond_4
    move/from16 v29, v3

    move/from16 v24, v4

    move/from16 v17, v7

    move/from16 v30, v8

    move v3, v13

    move/from16 v4, v22

    move/from16 v22, v5

    add-int/lit8 v14, v14, 0x1

    move/from16 v3, v22

    move/from16 v5, v25

    move/from16 v15, v26

    move-wide/from16 v16, v27

    move/from16 v6, v29

    move/from16 v22, v4

    move/from16 v4, v24

    goto/16 :goto_3

    .line 336
    :cond_5
    move/from16 v24, v4

    move/from16 v17, v7

    move/from16 v30, v8

    move/from16 v4, v22

    const/16 v29, -0x3

    move/from16 v22, v3

    move v3, v13

    if-ne v15, v3, :cond_7

    if-eq v5, v4, :cond_6

    goto :goto_5

    :cond_6
    move/from16 v7, v17

    move-object/from16 v12, v21

    move/from16 v8, v30

    goto :goto_6

    .line 337
    :cond_7
    :goto_5
    int-to-double v6, v15

    const/16 v18, 0x0

    aput-wide v6, v21, v18

    int-to-double v5, v5

    aput-wide v5, v21, v23

    .line 338
    const/4 v13, 0x1

    iget-wide v14, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    move/from16 v7, v17

    move-object/from16 v16, v21

    move/from16 v8, v30

    invoke-static/range {v5 .. v16}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->refine([F[FIIIIIIID[D)V

    move-object/from16 v12, v16

    goto :goto_6

    .line 326
    :cond_8
    move v4, v3

    move-object v12, v5

    move/from16 v24, v6

    move/from16 v23, v16

    move/from16 v22, v17

    move/from16 v3, v21

    const/16 v29, -0x3

    .line 341
    :goto_6
    iget-object v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    const/16 v18, 0x0

    aget-wide v9, v12, v18

    invoke-static {v9, v10}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->displacement(D)F

    move-result v6

    aput v6, v5, v24

    .line 342
    iget-object v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget-wide v9, v12, v23

    invoke-static {v9, v10}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->displacement(D)F

    move-result v6

    aput v6, v5, v24

    .line 320
    add-int/lit8 v6, v24, 0x1

    move/from16 v21, v3

    move v3, v4

    move-object v5, v12

    const/4 v4, 0x2

    goto/16 :goto_2

    .line 344
    :cond_9
    const/16 v23, 0x1

    move/from16 v3, v23

    if-ne v2, v3, :cond_a

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static {v0, v5, v6, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->estimateNoise(Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;[F[FI)V

    .line 345
    :cond_a
    return-void
.end method

.method private static registrationBand([FI)V
    .locals 6

    .line 406
    array-length v0, p0

    div-int/2addr v0, p1

    .line 407
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    const/4 v3, 0x4

    if-ge v2, v3, :cond_2

    .line 408
    move v3, v1

    :goto_1
    if-ge v3, v0, :cond_0

    mul-int v4, v3, p1

    const/4 v5, 0x1

    invoke-static {p0, v4, v5, p1}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->blurLine([FIII)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 409
    :cond_0
    move v3, v1

    :goto_2
    if-ge v3, p1, :cond_1

    invoke-static {p0, v3, p1, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->blurLine([FIII)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 407
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 411
    :cond_2
    return-void
.end method

.method private static sample(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;DDI)D
    .locals 18

    .line 442
    move-object/from16 v0, p0

    move/from16 v1, p5

    and-int/lit8 v2, v1, 0x1

    shr-int/lit8 v3, v1, 0x1

    .line 443
    iget v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/lit8 v4, v4, -0x1

    iget v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    add-int/lit8 v5, v5, -0x1

    sub-int/2addr v5, v2

    and-int/lit8 v5, v5, 0x1

    sub-int/2addr v4, v5

    .line 444
    sub-int v5, v4, v2

    div-int/lit8 v5, v5, 0x2

    int-to-double v5, v5

    int-to-double v7, v2

    sub-double v7, p1, v7

    const-wide/high16 v9, 0x4000000000000000L    # 2.0

    div-double/2addr v7, v9

    invoke-static {v5, v6, v7, v8}, Ljava/lang/Math;->min(DD)D

    move-result-wide v5

    const-wide/16 v7, 0x0

    invoke-static {v7, v8, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    iget v11, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    div-int/lit8 v11, v11, 0x2

    add-int/lit8 v11, v11, -0x1

    int-to-double v11, v11

    int-to-double v13, v3

    sub-double v13, p3, v13

    div-double/2addr v13, v9

    invoke-static {v11, v12, v13, v14}, Ljava/lang/Math;->min(DD)D

    move-result-wide v9

    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    .line 445
    double-to-int v9, v5

    double-to-int v10, v7

    mul-int/lit8 v11, v9, 0x2

    add-int/2addr v11, v2

    mul-int/lit8 v2, v10, 0x2

    add-int/2addr v2, v3

    .line 446
    add-int/lit8 v12, v11, 0x2

    invoke-static {v12, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    add-int/lit8 v12, v2, 0x2

    iget v13, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    add-int/lit8 v13, v13, -0x2

    add-int/2addr v13, v3

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v3

    .line 447
    int-to-double v12, v9

    sub-double/2addr v5, v12

    int-to-double v9, v10

    sub-double/2addr v7, v9

    .line 448
    invoke-virtual {v0, v11, v2, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v9

    const-wide/high16 v12, 0x3ff0000000000000L    # 1.0

    sub-double v14, v12, v5

    mul-double/2addr v9, v14

    invoke-virtual {v0, v4, v2, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v16

    mul-double v16, v16, v5

    add-double v9, v9, v16

    .line 449
    invoke-virtual {v0, v11, v3, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v16

    mul-double v16, v16, v14

    invoke-virtual {v0, v4, v3, v1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v0

    mul-double/2addr v0, v5

    add-double v16, v16, v0

    .line 450
    sub-double/2addr v12, v7

    mul-double/2addr v9, v12

    mul-double v16, v16, v7

    add-double v9, v9, v16

    return-wide v9
.end method

.method private static sharpness(Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;I)V
    .locals 17

    .line 424
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->f:Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    .line 425
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    iget-object v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    array-length v4, v4

    if-ge v3, v4, :cond_3

    .line 426
    rem-int v4, v3, p1

    mul-int/lit8 v4, v4, 0x10

    iget-object v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dx:[F

    aget v5, v5, v3

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    add-int/2addr v4, v5

    div-int v5, v3, p1

    mul-int/lit8 v5, v5, 0x10

    iget-object v6, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->dy:[F

    aget v6, v6, v3

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    add-int/2addr v5, v6

    .line 427
    nop

    .line 428
    nop

    .line 429
    const/4 v6, 0x2

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v7

    const-wide/16 v8, 0x0

    move v10, v2

    :goto_1
    iget v11, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    sub-int/2addr v11, v6

    add-int/lit8 v12, v5, 0x10

    invoke-static {v11, v12}, Ljava/lang/Math;->min(II)I

    move-result v11

    if-ge v7, v11, :cond_1

    .line 430
    invoke-static {v6, v4}, Ljava/lang/Math;->max(II)I

    move-result v11

    :goto_2
    iget v12, v1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    sub-int/2addr v12, v6

    add-int/lit8 v13, v4, 0x10

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    if-ge v11, v12, :cond_0

    .line 431
    and-int/lit8 v12, v7, 0x1

    mul-int/2addr v12, v6

    and-int/lit8 v13, v11, 0x1

    add-int/2addr v12, v13

    .line 432
    const-wide/high16 v13, 0x4010000000000000L    # 4.0

    invoke-virtual {v1, v11, v7, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v15

    mul-double/2addr v15, v13

    add-int/lit8 v13, v11, -0x2

    invoke-virtual {v1, v13, v7, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v13

    sub-double/2addr v15, v13

    add-int/lit8 v13, v11, 0x2

    invoke-virtual {v1, v13, v7, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v13

    sub-double/2addr v15, v13

    add-int/lit8 v13, v7, -0x2

    .line 433
    invoke-virtual {v1, v11, v13, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v13

    sub-double/2addr v15, v13

    add-int/lit8 v13, v7, 0x2

    invoke-virtual {v1, v11, v13, v12}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->linear(III)D

    move-result-wide v12

    sub-double/2addr v15, v12

    .line 432
    invoke-static/range {v15 .. v16}, Ljava/lang/Math;->abs(D)D

    move-result-wide v12

    add-double/2addr v8, v12

    .line 434
    add-int/lit8 v10, v10, 0x1

    .line 430
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .line 429
    :cond_0
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 436
    :cond_1
    iget-object v4, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->sharpness:[F

    if-nez v10, :cond_2

    const/4 v5, 0x0

    goto :goto_3

    :cond_2
    iget-wide v5, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Aligned;->scale:D

    mul-double/2addr v5, v8

    int-to-double v7, v10

    div-double/2addr v5, v7

    double-to-float v5, v5

    :goto_3
    aput v5, v4, v3

    .line 425
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    .line 438
    :cond_3
    return-void
.end method


# virtual methods
.method public declared-synchronized addFrame(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V
    .locals 14

    monitor-enter p0

    .line 143
    if-eqz p1, :cond_8

    :try_start_0
    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    if-eqz v0, :cond_8

    .line 144
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    add-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    array-length v1, v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 145
    iget v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    iget v3, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    invoke-static {v1, v2, v3, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->estimatedPeakBytes(IIII)J

    move-result-wide v0

    .line 146
    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    int-to-long v2, v2

    iget v4, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    int-to-long v4, v4

    mul-long/2addr v2, v4

    .line 147
    iget v4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mode:I

    const/4 v5, 0x3

    if-ne v4, v5, :cond_0

    const-wide/16 v6, 0x1a4

    goto :goto_0

    :cond_0
    const-wide/16 v6, 0x140

    :goto_0
    const-wide/32 v8, 0x100000

    mul-long/2addr v6, v8

    .line 148
    cmp-long v0, v0, v6

    if-gtz v0, :cond_7

    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    int-to-long v0, v0

    const-wide/16 v10, 0x2

    mul-long/2addr v0, v10

    add-long/2addr v0, v10

    mul-long/2addr v0, v2

    iget-object v4, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    array-length v4, v4

    int-to-long v10, v4

    const-wide/16 v12, 0x4

    mul-long/2addr v10, v12

    add-long/2addr v0, v10

    add-long/2addr v0, v8

    cmp-long v0, v0, v6

    if-gtz v0, :cond_7

    .line 150
    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    array-length v0, v0

    int-to-long v0, v0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_6

    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    if-eqz v0, :cond_6

    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    array-length v0, v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    if-ltz v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    if-gt v0, v5, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    .line 152
    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    const v1, 0x477fff00    # 65535.0f

    cmpl-float v0, v0, v1

    if-gtz v0, :cond_6

    iget-wide v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_6

    iget-wide v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->exposureNs:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->iso:I

    if-lez v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    .line 153
    invoke-static {v0}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-nez v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    .line 154
    invoke-static {v0}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-nez v0, :cond_6

    iget v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-ltz v0, :cond_6

    .line 156
    iget-object v0, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    array-length v2, v0

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v2, :cond_2

    aget v4, v0, v3

    .line 157
    invoke-static {v4}, Ljava/lang/Float;->isFinite(F)Z

    move-result v5

    if-eqz v5, :cond_1

    cmpg-float v5, v4, v1

    if-ltz v5, :cond_1

    iget v5, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    sub-float/2addr v5, v4

    const/high16 v4, 0x3f800000    # 1.0f

    cmpg-float v4, v5, v4

    if-ltz v4, :cond_1

    .line 156
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 158
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid black/white levels"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 160
    :cond_2
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    if-lez v0, :cond_4

    .line 161
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    add-int/lit8 v0, v0, -0x1

    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->at(I)Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    move-result-object v0

    .line 162
    iget v1, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->w:I

    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    if-ne v1, v2, :cond_3

    iget v1, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->h:I

    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    if-ne v1, v2, :cond_3

    iget v1, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->cfa:I

    iget v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    if-ne v1, v2, :cond_3

    iget-wide v0, v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->time:J

    iget-wide v2, p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_3

    goto :goto_2

    .line 163
    :cond_3
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Incompatible geometry, CFA or capture order"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 165
    :cond_4
    :goto_2
    new-instance v0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    invoke-direct {v0, p1}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;-><init>(Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;)V

    .line 166
    iget-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    iget v1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->oldest:I

    iget v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    array-length v2, v2

    rem-int/2addr v1, v2

    aput-object v0, p1, v1

    .line 167
    iget p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    array-length v0, v0

    if-ne p1, v0, :cond_5

    iget p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->oldest:I

    add-int/lit8 p1, p1, 0x1

    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    array-length v0, v0

    rem-int/2addr p1, v0

    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->oldest:I

    goto :goto_3

    .line 168
    :cond_5
    iget p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 169
    :goto_3
    monitor-exit p0

    return-void

    .line 155
    :cond_6
    :try_start_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid RAW descriptor"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 149
    :cond_7
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Burst exceeds working memory cap"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 143
    :cond_8
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Missing input"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 142
    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public declared-synchronized clear()V
    .locals 2

    monitor-enter p0

    .line 173
    :try_start_0
    iget-object v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->ring:[Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([Ljava/lang/Object;Ljava/lang/Object;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I

    iput v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->oldest:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    .line 173
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public declared-synchronized merge()Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
    .locals 1

    monitor-enter p0

    .line 175
    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mergeInternal(Z)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 175
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public declared-synchronized mergeOnCurrentGlContext()Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
    .locals 1

    monitor-enter p0

    .line 178
    const/4 v0, 0x1

    :try_start_0
    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->mergeInternal(Z)Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 178
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public declared-synchronized size()I
    .locals 1

    monitor-enter p0

    .line 172
    :try_start_0
    iget v0, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine;->size:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 172
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
