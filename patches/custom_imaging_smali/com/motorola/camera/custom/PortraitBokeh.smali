.class final Lcom/motorola/camera/custom/PortraitBokeh;
.super Ljava/lang/Object;
.source "PortraitBokeh.java"


# static fields
.field private static final BG_DEPTH:I = 0x28

.field private static final MAX_SIDE:I = 0x3c0

.field private static final SUBJECT_DEPTH:I = 0xd2


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static buildFaceDepthMap(Landroid/hardware/camera2/TotalCaptureResult;Landroid/hardware/camera2/CameraCharacteristics;IIZ)[B
    .locals 29

    .line 126
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v3, p2

    move/from16 v4, p3

    const/4 v5, 0x0

    if-nez v1, :cond_0

    return-object v5

    .line 127
    :cond_0
    nop

    .line 129
    :try_start_0
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->STATISTICS_FACES:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroid/hardware/camera2/params/Face;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 130
    move-object v6, v0

    goto :goto_0

    :catchall_0
    move-exception v0

    move-object v6, v5

    .line 131
    :goto_0
    if-eqz v6, :cond_18

    array-length v0, v6

    if-nez v0, :cond_1

    move-object/from16 v16, v5

    goto/16 :goto_11

    .line 133
    :cond_1
    nop

    .line 135
    :try_start_1
    sget-object v0, Landroid/hardware/camera2/CaptureResult;->SCALER_CROP_REGION:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v1, v0}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 136
    move-object v1, v0

    goto :goto_1

    :catchall_1
    move-exception v0

    move-object v1, v5

    .line 137
    :goto_1
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v0

    if-lez v0, :cond_2

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v0

    if-gtz v0, :cond_3

    :cond_2
    if-eqz v2, :cond_3

    .line 139
    :try_start_2
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_ACTIVE_ARRAY_SIZE:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v2, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 140
    move-object v1, v0

    goto :goto_2

    :catchall_2
    move-exception v0

    .line 142
    :cond_3
    :goto_2
    if-eqz v1, :cond_17

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v0

    if-lez v0, :cond_17

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v0

    if-gtz v0, :cond_4

    move-object/from16 v16, v5

    goto/16 :goto_10

    .line 144
    :cond_4
    if-eqz p4, :cond_5

    const/16 v8, 0x10e

    goto :goto_3

    :cond_5
    const/16 v0, 0x5a

    move v8, v0

    .line 145
    :goto_3
    if-eqz v2, :cond_7

    .line 147
    :try_start_3
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_ORIENTATION:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v2, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 148
    if-eqz v0, :cond_6

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    rem-int/lit16 v0, v0, 0x168

    add-int/lit16 v0, v0, 0x168

    rem-int/lit16 v8, v0, 0x168
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 149
    :cond_6
    :goto_4
    goto :goto_5

    :catchall_3
    move-exception v0

    goto :goto_4

    .line 152
    :cond_7
    :goto_5
    const/4 v0, 0x1

    if-le v4, v3, :cond_8

    move v9, v0

    goto :goto_6

    :cond_8
    const/4 v9, 0x0

    .line 153
    :goto_6
    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v10

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v11

    if-le v10, v11, :cond_9

    goto :goto_7

    :cond_9
    const/4 v0, 0x0

    .line 154
    :goto_7
    array-length v10, v6

    const/4 v11, 0x4

    invoke-static {v10, v11}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 155
    new-array v11, v10, [D

    new-array v12, v10, [D

    new-array v13, v10, [D

    new-array v14, v10, [D

    .line 156
    nop

    .line 157
    const/4 v2, 0x0

    const/4 v15, 0x0

    :goto_8
    move-object/from16 v16, v5

    array-length v5, v6

    if-ge v15, v5, :cond_11

    if-ge v2, v10, :cond_11

    .line 158
    aget-object v5, v6, v15

    .line 159
    if-eqz v5, :cond_10

    invoke-virtual {v5}, Landroid/hardware/camera2/params/Face;->getBounds()Landroid/graphics/Rect;

    move-result-object v17

    if-nez v17, :cond_a

    move-object/from16 v24, v1

    move/from16 v18, v2

    move-object/from16 v17, v6

    move/from16 v20, v8

    move/from16 p1, v10

    move-object/from16 v23, v11

    goto/16 :goto_b

    .line 160
    :cond_a
    invoke-virtual {v5}, Landroid/hardware/camera2/params/Face;->getBounds()Landroid/graphics/Rect;

    move-result-object v5

    .line 161
    invoke-virtual {v5}, Landroid/graphics/Rect;->centerX()I

    move-result v17

    iget v7, v1, Landroid/graphics/Rect;->left:I

    sub-int v7, v17, v7

    move-object/from16 p1, v5

    move-object/from16 v17, v6

    int-to-double v5, v7

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v7

    move-wide/from16 v19, v5

    int-to-double v5, v7

    div-double v5, v19, v5

    .line 162
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Rect;->centerY()I

    move-result v7

    move-wide/from16 v19, v5

    iget v5, v1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v7, v5

    int-to-double v5, v7

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v7

    move-wide/from16 v21, v5

    int-to-double v5, v7

    div-double v5, v21, v5

    .line 163
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Rect;->width()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Math;->abs(I)I

    move-result v7

    move-wide/from16 v21, v5

    int-to-double v5, v7

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v7

    move-wide/from16 v23, v5

    int-to-double v5, v7

    div-double v5, v23, v5

    move v7, v10

    move-object/from16 v23, v11

    const-wide v10, 0x3faeb851eb851eb8L    # 0.06

    invoke-static {v10, v11, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    .line 164
    invoke-virtual/range {p1 .. p1}, Landroid/graphics/Rect;->height()I

    move-result v24

    invoke-static/range {v24 .. v24}, Ljava/lang/Math;->abs(I)I

    move-result v10

    int-to-double v10, v10

    move-object/from16 v24, v1

    invoke-virtual/range {v24 .. v24}, Landroid/graphics/Rect;->height()I

    move-result v1

    move-wide/from16 v27, v5

    int-to-double v5, v1

    div-double/2addr v10, v5

    const-wide v5, 0x3faeb851eb851eb8L    # 0.06

    invoke-static {v5, v6, v10, v11}, Ljava/lang/Math;->max(DD)D

    move-result-wide v5

    .line 167
    const-wide/high16 v10, 0x3ff0000000000000L    # 1.0

    if-ne v9, v0, :cond_e

    .line 168
    const/16 v1, 0x10e

    if-ne v8, v1, :cond_b

    .line 169
    nop

    .line 170
    sub-double v18, v10, v19

    .line 171
    if-eqz p4, :cond_d

    sub-double v10, v10, v21

    move-wide/from16 v21, v10

    goto :goto_9

    .line 173
    :cond_b
    sub-double v21, v10, v21

    .line 174
    nop

    .line 175
    if-eqz p4, :cond_c

    sub-double v10, v10, v21

    move-wide/from16 v21, v10

    :cond_c
    move-wide/from16 v18, v19

    .line 177
    :cond_d
    :goto_9
    nop

    .line 178
    move-wide/from16 v10, v27

    move-wide/from16 v27, v5

    move-wide/from16 v5, v18

    move/from16 v18, v2

    move-wide/from16 v1, v21

    goto :goto_a

    .line 180
    :cond_e
    const/16 v1, 0x10e

    if-eqz p4, :cond_f

    sub-double v10, v10, v19

    move-wide/from16 v19, v10

    .line 181
    :cond_f
    nop

    .line 182
    nop

    .line 183
    move/from16 v18, v2

    move-wide v10, v5

    move-wide/from16 v1, v19

    move-wide/from16 v5, v21

    .line 185
    :goto_a
    move/from16 p1, v7

    move/from16 v20, v8

    const-wide v7, 0x3fee666666666666L    # 0.95

    invoke-static {v7, v8, v1, v2}, Ljava/lang/Math;->min(DD)D

    move-result-wide v1

    const-wide v7, 0x3fa999999999999aL    # 0.05

    invoke-static {v7, v8, v1, v2}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    int-to-double v7, v3

    mul-double/2addr v1, v7

    aput-wide v1, v23, v18

    .line 186
    const-wide v1, 0x3fee666666666666L    # 0.95

    invoke-static {v1, v2, v5, v6}, Ljava/lang/Math;->min(DD)D

    move-result-wide v5

    move-wide/from16 v21, v1

    const-wide v1, 0x3fa999999999999aL    # 0.05

    invoke-static {v1, v2, v5, v6}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    int-to-double v5, v4

    mul-double/2addr v1, v5

    aput-wide v1, v12, v18

    .line 187
    const-wide v25, 0x3fc1eb851eb851ecL    # 0.14

    mul-double v1, v7, v25

    mul-double v27, v27, v7

    mul-double v7, v27, v21

    invoke-static {v1, v2, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    aput-wide v1, v13, v18

    .line 188
    mul-double v1, v5, v25

    mul-double/2addr v10, v5

    const-wide v5, 0x3ff2666666666666L    # 1.15

    mul-double/2addr v10, v5

    invoke-static {v1, v2, v10, v11}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    aput-wide v1, v14, v18

    .line 189
    add-int/lit8 v2, v18, 0x1

    goto :goto_c

    .line 159
    :cond_10
    move-object/from16 v24, v1

    move/from16 v18, v2

    move-object/from16 v17, v6

    move/from16 v20, v8

    move/from16 p1, v10

    move-object/from16 v23, v11

    .line 157
    :goto_b
    move/from16 v2, v18

    :goto_c
    add-int/lit8 v15, v15, 0x1

    move/from16 v10, p1

    move-object/from16 v5, v16

    move-object/from16 v6, v17

    move/from16 v8, v20

    move-object/from16 v11, v23

    move-object/from16 v1, v24

    goto/16 :goto_8

    :cond_11
    move/from16 v18, v2

    move-object/from16 v23, v11

    .line 191
    if-nez v18, :cond_12

    return-object v16

    .line 193
    :cond_12
    mul-int v0, v3, v4

    new-array v0, v0, [B

    .line 194
    const/4 v1, 0x0

    :goto_d
    if-ge v1, v4, :cond_16

    .line 195
    mul-int v2, v1, v3

    .line 196
    const/4 v5, 0x0

    :goto_e
    if-ge v5, v3, :cond_15

    .line 197
    nop

    .line 198
    const-wide v6, 0x4058c00000000000L    # 99.0

    const/4 v8, 0x0

    :goto_f
    move/from16 v9, v18

    if-ge v8, v9, :cond_14

    .line 199
    int-to-double v10, v5

    aget-wide v15, v23, v8

    sub-double v15, v10, v15

    aget-wide v17, v13, v8

    div-double v15, v15, v17

    .line 200
    move/from16 p1, v2

    int-to-double v2, v1

    aget-wide v17, v12, v8

    sub-double v17, v2, v17

    aget-wide v19, v14, v8

    div-double v17, v17, v19

    .line 201
    mul-double/2addr v15, v15

    mul-double v17, v17, v17

    add-double v15, v15, v17

    move-object/from16 v17, v0

    move/from16 v18, v1

    invoke-static/range {v15 .. v16}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    .line 202
    aget-wide v15, v23, v8

    sub-double/2addr v10, v15

    aget-wide v15, v13, v8

    const-wide v19, 0x3ffa666666666666L    # 1.65

    mul-double v15, v15, v19

    div-double/2addr v10, v15

    .line 203
    aget-wide v15, v12, v8

    aget-wide v19, v14, v8

    const-wide v21, 0x3ff7333333333333L    # 1.45

    mul-double v19, v19, v21

    add-double v15, v15, v19

    sub-double/2addr v2, v15

    aget-wide v15, v14, v8

    const-wide v19, 0x3ffd99999999999aL    # 1.85

    mul-double v15, v15, v19

    div-double/2addr v2, v15

    .line 204
    mul-double/2addr v10, v10

    mul-double/2addr v2, v2

    add-double/2addr v10, v2

    invoke-static {v10, v11}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    .line 205
    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    .line 206
    cmpg-double v2, v0, v6

    if-gez v2, :cond_13

    move-wide v6, v0

    .line 198
    :cond_13
    add-int/lit8 v8, v8, 0x1

    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v0, v17

    move/from16 v1, v18

    move/from16 v18, v9

    goto :goto_f

    .line 208
    :cond_14
    move-object/from16 v17, v0

    move/from16 v18, v1

    move/from16 p1, v2

    add-int v2, p1, v5

    invoke-static {v6, v7}, Lcom/motorola/camera/custom/PortraitBokeh;->smoothFocusByte(D)B

    move-result v0

    aput-byte v0, v17, v2

    .line 196
    add-int/lit8 v5, v5, 0x1

    move/from16 v2, p1

    move/from16 v3, p2

    move-object/from16 v0, v17

    move/from16 v18, v9

    goto/16 :goto_e

    .line 194
    :cond_15
    move-object/from16 v17, v0

    move/from16 v9, v18

    move/from16 v18, v1

    add-int/lit8 v1, v18, 0x1

    move/from16 v3, p2

    move/from16 v18, v9

    goto/16 :goto_d

    .line 211
    :cond_16
    move-object/from16 v17, v0

    return-object v17

    .line 142
    :cond_17
    move-object/from16 v16, v5

    :goto_10
    return-object v16

    .line 131
    :cond_18
    move-object/from16 v16, v5

    :goto_11
    return-object v16
.end method

.method private static buildRadialDepthMap(II)[B
    .locals 19

    .line 215
    move/from16 v0, p0

    move/from16 v1, p1

    mul-int v2, v0, v1

    new-array v2, v2, [B

    .line 216
    int-to-double v3, v0

    const-wide/high16 v5, 0x3fe0000000000000L    # 0.5

    mul-double/2addr v5, v3

    .line 217
    int-to-double v7, v1

    const-wide v9, 0x3fdccccccccccccdL    # 0.45

    mul-double/2addr v9, v7

    .line 218
    const-wide v11, 0x3fd147ae147ae148L    # 0.27

    mul-double/2addr v3, v11

    const-wide/high16 v11, 0x4000000000000000L    # 2.0

    invoke-static {v11, v12, v3, v4}, Ljava/lang/Math;->max(DD)D

    move-result-wide v3

    .line 219
    const-wide v13, 0x3fd5c28f5c28f5c3L    # 0.34

    mul-double/2addr v7, v13

    invoke-static {v11, v12, v7, v8}, Ljava/lang/Math;->max(DD)D

    move-result-wide v7

    .line 220
    const/4 v12, 0x0

    :goto_0
    if-ge v12, v1, :cond_1

    .line 221
    int-to-double v13, v12

    sub-double/2addr v13, v9

    div-double/2addr v13, v7

    .line 222
    mul-int v15, v12, v0

    .line 223
    const/4 v11, 0x0

    :goto_1
    if-ge v11, v0, :cond_0

    .line 224
    int-to-double v0, v11

    sub-double/2addr v0, v5

    div-double/2addr v0, v3

    .line 225
    add-int v16, v15, v11

    mul-double/2addr v0, v0

    mul-double v17, v13, v13

    add-double v0, v0, v17

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/PortraitBokeh;->smoothFocusByte(D)B

    move-result v0

    aput-byte v0, v2, v16

    .line 223
    add-int/lit8 v11, v11, 0x1

    move/from16 v0, p0

    move/from16 v1, p1

    goto :goto_1

    .line 220
    :cond_0
    add-int/lit8 v12, v12, 0x1

    move/from16 v0, p0

    move/from16 v1, p1

    goto :goto_0

    .line 228
    :cond_1
    return-object v2
.end method

.method private static focus([BII)I
    .locals 9

    .line 239
    const/16 v0, 0x31

    new-array v0, v0, [I

    .line 240
    nop

    .line 241
    const/4 v1, 0x0

    const/4 v2, -0x3

    move v3, v2

    :goto_0
    const/4 v4, 0x3

    if-gt v3, v4, :cond_1

    .line 242
    move v5, v2

    :goto_1
    if-gt v5, v4, :cond_0

    .line 243
    add-int/lit8 v6, v1, 0x1

    div-int/lit8 v7, p2, 0x2

    mul-int v8, v3, p2

    div-int/lit8 v8, v8, 0x20

    add-int/2addr v7, v8

    mul-int/2addr v7, p1

    div-int/lit8 v8, p1, 0x2

    add-int/2addr v7, v8

    mul-int v8, v5, p1

    div-int/lit8 v8, v8, 0x20

    add-int/2addr v7, v8

    aget-byte v7, p0, v7

    and-int/lit16 v7, v7, 0xff

    aput v7, v0, v1

    .line 242
    add-int/lit8 v5, v5, 0x1

    move v1, v6

    goto :goto_1

    .line 241
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 247
    :cond_1
    invoke-static {v0}, Ljava/util/Arrays;->sort([I)V

    .line 248
    const/16 p0, 0x18

    aget p0, v0, p0

    return p0
.end method

.method private static mix(III)I
    .locals 4

    .line 322
    ushr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    rsub-int v1, p2, 0x100

    mul-int/2addr v0, v1

    ushr-int/lit8 v2, p1, 0x10

    and-int/lit16 v2, v2, 0xff

    mul-int/2addr v2, p2

    add-int/2addr v0, v2

    add-int/lit16 v0, v0, 0x80

    ushr-int/lit8 v0, v0, 0x8

    shl-int/lit8 v0, v0, 0x10

    .line 323
    ushr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    mul-int/2addr v2, v1

    ushr-int/lit8 v3, p1, 0x8

    and-int/lit16 v3, v3, 0xff

    mul-int/2addr v3, p2

    add-int/2addr v2, v3

    add-int/lit16 v2, v2, 0x80

    ushr-int/lit8 v2, v2, 0x8

    shl-int/lit8 v2, v2, 0x8

    .line 324
    and-int/lit16 p0, p0, 0xff

    mul-int/2addr p0, v1

    and-int/lit16 p1, p1, 0xff

    mul-int/2addr p1, p2

    add-int/2addr p0, p1

    add-int/lit16 p0, p0, 0x80

    ushr-int/lit8 p0, p0, 0x8

    .line 325
    const/high16 p1, -0x1000000

    or-int/2addr p1, v0

    or-int/2addr p1, v2

    or-int/2addr p0, p1

    return p0
.end method

.method static original(Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;)Ljava/nio/ByteBuffer;
    .locals 3

    .line 29
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mAuxImages:Ljava/util/HashMap;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    if-nez v1, :cond_0

    goto :goto_1

    .line 30
    :cond_0
    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    sget-object v2, Lcom/motorola/camera/mcf/McfAuxiliaryData;->DEPTHMAP:Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;

    invoke-virtual {v1, v2}, Lcom/motorola/camera/mcf/McfAuxiliaryData;->get(Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;)Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Lcom/motorola/camera/mcf/McfAuxFrameData;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    sget-object v2, Lcom/motorola/camera/mcf/McfAuxiliaryData;->IMAGING_MODEL:Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;

    .line 31
    invoke-virtual {v1, v2}, Lcom/motorola/camera/mcf/McfAuxiliaryData;->get(Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;)Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Lcom/motorola/camera/mcf/McfImagingModelAuxData;

    if-nez v1, :cond_1

    goto :goto_0

    .line 32
    :cond_1
    iget-object p0, p0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mAuxImages:Ljava/util/HashMap;

    sget-object v0, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;->DEPTH_RENDER_ORIGINAL:Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord$AuxiliaryImage;

    invoke-virtual {p0, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/nio/ByteBuffer;

    return-object p0

    .line 31
    :cond_2
    :goto_0
    return-object v0

    .line 29
    :cond_3
    :goto_1
    return-object v0
.end method

.method private static readDepth(Lcom/motorola/camera/mcf/McfAuxFrameData;II)[B
    .locals 29

    .line 263
    move/from16 v4, p1

    move/from16 v8, p2

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getData()[B

    move-result-object v0

    .line 264
    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getWidth()I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getHeight()I

    move-result v2

    .line 265
    if-eqz v0, :cond_24

    const/4 v5, 0x2

    if-lt v1, v5, :cond_24

    if-lt v2, v5, :cond_24

    int-to-long v6, v1

    int-to-long v9, v2

    mul-long/2addr v9, v6

    const-wide/32 v11, 0x1312d00

    cmp-long v9, v9, v11

    if-lez v9, :cond_0

    const/16 v19, 0x0

    goto/16 :goto_11

    .line 266
    :cond_0
    int-to-double v9, v4

    int-to-double v11, v8

    div-double/2addr v9, v11

    .line 267
    int-to-double v11, v1

    int-to-double v13, v2

    div-double v15, v11, v13

    div-double/2addr v15, v9

    const-wide/high16 v17, 0x3ff0000000000000L    # 1.0

    sub-double v15, v15, v17

    invoke-static/range {v15 .. v16}, Ljava/lang/Math;->abs(D)D

    move-result-wide v15

    .line 268
    div-double/2addr v13, v11

    div-double/2addr v13, v9

    sub-double v13, v13, v17

    invoke-static {v13, v14}, Ljava/lang/Math;->abs(D)D

    move-result-wide v11

    .line 269
    const/4 v13, 0x0

    if-le v1, v2, :cond_1

    const/4 v3, 0x1

    goto :goto_0

    :cond_1
    move v3, v13

    :goto_0
    const/16 v19, 0x0

    if-le v4, v8, :cond_2

    const/4 v14, 0x1

    goto :goto_1

    :cond_2
    move v14, v13

    :goto_1
    const-wide v20, 0x3fbeb851eb851eb8L    # 0.12

    if-eq v3, v14, :cond_3

    cmpl-double v3, v15, v20

    if-lez v3, :cond_3

    cmpg-double v3, v11, v20

    if-gtz v3, :cond_3

    const/4 v3, 0x1

    goto :goto_2

    :cond_3
    move v3, v13

    .line 270
    :goto_2
    if-nez v3, :cond_4

    cmpl-double v11, v15, v20

    if-lez v11, :cond_4

    return-object v19

    .line 271
    :cond_4
    mul-int v11, v4, v8

    new-array v12, v11, [B

    .line 272
    const-string v14, "NV21"

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getFormat()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_b

    .line 273
    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getStride()I

    move-result v5

    .line 274
    if-lt v5, v1, :cond_a

    int-to-long v9, v5

    add-int/lit8 v11, v2, -0x1

    int-to-long v14, v11

    mul-long/2addr v9, v14

    add-long/2addr v9, v6

    array-length v6, v0

    int-to-long v6, v6

    cmp-long v6, v9, v6

    if-lez v6, :cond_5

    goto :goto_7

    .line 275
    :cond_5
    move v6, v13

    :goto_3
    if-ge v6, v8, :cond_9

    .line 276
    if-eqz v3, :cond_7

    .line 277
    add-int/lit8 v7, v1, -0x1

    mul-int v9, v6, v1

    div-int/2addr v9, v8

    invoke-static {v7, v9}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 278
    move v9, v13

    :goto_4
    if-ge v9, v4, :cond_6

    .line 279
    add-int/lit8 v10, v4, -0x1

    sub-int/2addr v10, v9

    mul-int/2addr v10, v2

    div-int/2addr v10, v4

    invoke-static {v11, v10}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 280
    mul-int v14, v6, v4

    add-int/2addr v14, v9

    mul-int/2addr v10, v5

    add-int/2addr v10, v7

    aget-byte v10, v0, v10

    aput-byte v10, v12, v14

    .line 278
    add-int/lit8 v9, v9, 0x1

    goto :goto_4

    .line 282
    :cond_6
    goto :goto_6

    .line 283
    :cond_7
    mul-int v7, v6, v2

    div-int/2addr v7, v8

    mul-int/2addr v7, v5

    .line 284
    move v9, v13

    :goto_5
    if-ge v9, v4, :cond_8

    mul-int v10, v6, v4

    add-int/2addr v10, v9

    mul-int v14, v9, v1

    div-int/2addr v14, v4

    add-int/2addr v14, v7

    aget-byte v14, v0, v14

    aput-byte v14, v12, v10

    add-int/lit8 v9, v9, 0x1

    goto :goto_5

    .line 275
    :cond_8
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 287
    :cond_9
    return-object v12

    .line 274
    :cond_a
    :goto_7
    return-object v19

    .line 289
    :cond_b
    const-string v3, "JPEG"

    invoke-virtual/range {p0 .. p0}, Lcom/motorola/camera/mcf/McfAuxFrameData;->getFormat()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_c

    return-object v19

    .line 290
    :cond_c
    array-length v3, v0

    invoke-static {v0, v13, v3}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v22

    .line 291
    if-nez v22, :cond_d

    return-object v19

    .line 292
    :cond_d
    nop

    .line 293
    nop

    .line 295
    :try_start_0
    invoke-virtual/range {v22 .. v22}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual/range {v22 .. v22}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v6

    .line 296
    if-ne v3, v1, :cond_e

    if-eq v6, v2, :cond_f

    :cond_e
    if-ne v3, v2, :cond_10

    if-ne v6, v1, :cond_10

    :cond_f
    const/4 v1, 0x1

    goto :goto_8

    :cond_10
    move v1, v13

    .line 297
    :goto_8
    if-eqz v1, :cond_21

    if-lt v3, v5, :cond_21

    if-ge v6, v5, :cond_11

    move-object/from16 v14, v22

    goto/16 :goto_e

    .line 298
    :cond_11
    invoke-static {v0}, Lcom/motorola/camera/custom/PortraitBokeh;->readExifRotation([B)I

    move-result v0

    .line 299
    if-eqz v0, :cond_12

    goto :goto_b

    :cond_12
    if-le v3, v6, :cond_13

    const/4 v0, 0x1

    goto :goto_9

    :cond_13
    move v0, v13

    :goto_9
    if-le v4, v8, :cond_14

    const/4 v1, 0x1

    goto :goto_a

    :cond_14
    move v1, v13

    :goto_a
    if-eq v0, v1, :cond_15

    const/16 v0, 0x5a

    goto :goto_b

    :cond_15
    move v0, v13

    .line 300
    :goto_b
    if-eqz v0, :cond_18

    .line 301
    new-instance v1, Landroid/graphics/Matrix;

    invoke-direct {v1}, Landroid/graphics/Matrix;-><init>()V

    .line 302
    int-to-float v0, v0

    invoke-virtual {v1, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 303
    const/16 v24, 0x0

    const/16 v28, 0x1

    const/16 v23, 0x0

    move-object/from16 v27, v1

    move/from16 v25, v3

    move/from16 v26, v6

    invoke-static/range {v22 .. v28}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-object/from16 v14, v22

    .line 304
    if-nez v0, :cond_17

    .line 315
    nop

    .line 316
    if-eqz v0, :cond_16

    if-eq v0, v14, :cond_16

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    .line 317
    :cond_16
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 304
    return-object v19

    :cond_17
    move-object v15, v0

    goto :goto_c

    .line 300
    :cond_18
    move-object/from16 v14, v22

    move-object v15, v14

    .line 306
    :goto_c
    :try_start_1
    invoke-virtual {v15}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-double v0, v0

    invoke-virtual {v15}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-double v2, v2

    div-double/2addr v0, v2

    div-double/2addr v0, v9

    sub-double v0, v0, v17

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 307
    cmpl-double v0, v0, v20

    if-lez v0, :cond_1a

    .line 315
    nop

    .line 316
    if-eqz v15, :cond_19

    if-eq v15, v14, :cond_19

    invoke-virtual {v15}, Landroid/graphics/Bitmap;->recycle()V

    .line 317
    :cond_19
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 307
    return-object v19

    .line 308
    :cond_1a
    const/4 v0, 0x1

    :try_start_2
    invoke-static {v15, v4, v8, v0}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 309
    if-nez v1, :cond_1d

    .line 315
    if-eqz v1, :cond_1b

    if-eq v1, v15, :cond_1b

    if-eq v1, v14, :cond_1b

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 316
    :cond_1b
    if-eqz v15, :cond_1c

    if-eq v15, v14, :cond_1c

    invoke-virtual {v15}, Landroid/graphics/Bitmap;->recycle()V

    .line 317
    :cond_1c
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 309
    return-object v19

    .line 310
    :cond_1d
    :try_start_3
    new-array v2, v11, [I

    .line 311
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move/from16 v7, p1

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 312
    nop

    :goto_d
    if-ge v13, v11, :cond_1e

    aget v0, v2, v13

    ushr-int/lit8 v0, v0, 0x10

    int-to-byte v0, v0

    aput-byte v0, v12, v13
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    add-int/lit8 v13, v13, 0x1

    goto :goto_d

    .line 313
    :cond_1e
    nop

    .line 315
    if-eqz v1, :cond_1f

    if-eq v1, v15, :cond_1f

    if-eq v1, v14, :cond_1f

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 316
    :cond_1f
    if-eqz v15, :cond_20

    if-eq v15, v14, :cond_20

    invoke-virtual {v15}, Landroid/graphics/Bitmap;->recycle()V

    .line 317
    :cond_20
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 313
    return-object v12

    .line 315
    :catchall_0
    move-exception v0

    move-object v3, v1

    goto :goto_10

    :catchall_1
    move-exception v0

    goto :goto_f

    .line 297
    :cond_21
    move-object/from16 v14, v22

    .line 315
    :goto_e
    nop

    .line 316
    nop

    .line 317
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 297
    return-object v19

    .line 315
    :catchall_2
    move-exception v0

    move-object/from16 v14, v22

    move-object v15, v14

    :goto_f
    move-object/from16 v3, v19

    :goto_10
    if-eqz v3, :cond_22

    if-eq v3, v15, :cond_22

    if-eq v3, v14, :cond_22

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 316
    :cond_22
    if-eqz v15, :cond_23

    if-eq v15, v14, :cond_23

    invoke-virtual {v15}, Landroid/graphics/Bitmap;->recycle()V

    .line 317
    :cond_23
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 318
    throw v0

    .line 265
    :cond_24
    const/16 v19, 0x0

    :goto_11
    return-object v19
.end method

.method private static readExifRotation([B)I
    .locals 2

    .line 253
    :try_start_0
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v1}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V

    .line 254
    const-string p0, "Orientation"

    invoke-virtual {v0, p0}, Lcom/motorola/camera/photometadata/PhotoMetadata;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 255
    const-string v0, "6"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 p0, 0x5a

    return p0

    .line 256
    :cond_0
    const-string v0, "3"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/16 p0, 0xb4

    return p0

    .line 257
    :cond_1
    const-string v0, "8"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_2

    const/16 p0, 0x10e

    return p0

    .line 258
    :catchall_0
    move-exception p0

    :cond_2
    nop

    .line 259
    const/4 p0, 0x0

    return p0
.end method

.method static render(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;I)Z
    .locals 12

    .line 36
    const/4 v0, 0x0

    if-eqz p0, :cond_6

    if-eqz p1, :cond_6

    iget-object v1, p1, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    if-nez v1, :cond_0

    goto :goto_2

    .line 37
    :cond_0
    iget-object v1, p1, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    sget-object v2, Lcom/motorola/camera/mcf/McfAuxiliaryData;->DEPTHMAP:Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;

    invoke-virtual {v1, v2}, Lcom/motorola/camera/mcf/McfAuxiliaryData;->get(Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;)Ljava/lang/Object;

    move-result-object v1

    .line 38
    iget-object p1, p1, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    sget-object v2, Lcom/motorola/camera/mcf/McfAuxiliaryData;->IMAGING_MODEL:Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;

    invoke-virtual {p1, v2}, Lcom/motorola/camera/mcf/McfAuxiliaryData;->get(Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;)Ljava/lang/Object;

    move-result-object p1

    .line 39
    instance-of v2, v1, Lcom/motorola/camera/mcf/McfAuxFrameData;

    if-eqz v2, :cond_5

    instance-of v2, p1, Lcom/motorola/camera/mcf/McfImagingModelAuxData;

    if-nez v2, :cond_1

    goto :goto_1

    .line 40
    :cond_1
    check-cast v1, Lcom/motorola/camera/mcf/McfAuxFrameData;

    .line 41
    check-cast p1, Lcom/motorola/camera/mcf/McfImagingModelAuxData;

    .line 42
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    .line 43
    invoke-virtual {p1}, Lcom/motorola/camera/mcf/McfImagingModelAuxData;->getWidth()I

    move-result v4

    if-lez v4, :cond_4

    invoke-virtual {p1}, Lcom/motorola/camera/mcf/McfImagingModelAuxData;->getHeight()I

    move-result p1

    if-lez p1, :cond_4

    const/4 p1, 0x2

    if-lt v2, p1, :cond_4

    if-ge v3, p1, :cond_2

    goto :goto_0

    .line 44
    :cond_2
    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v4

    int-to-double v4, v4

    const-wide/high16 v6, 0x408e000000000000L    # 960.0

    div-double/2addr v6, v4

    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->min(DD)D

    move-result-wide v4

    .line 45
    int-to-double v6, v2

    mul-double/2addr v6, v4

    double-to-int v2, v6

    invoke-static {p1, v2}, Ljava/lang/Math;->max(II)I

    move-result v8

    int-to-double v2, v3

    mul-double/2addr v2, v4

    double-to-int v2, v2

    invoke-static {p1, v2}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 46
    invoke-static {v1, v8, v9}, Lcom/motorola/camera/custom/PortraitBokeh;->readDepth(Lcom/motorola/camera/mcf/McfAuxFrameData;II)[B

    move-result-object v7

    .line 47
    if-nez v7, :cond_3

    return v0

    .line 48
    :cond_3
    invoke-static {v7, v8, v9}, Lcom/motorola/camera/custom/PortraitBokeh;->focus([BII)I

    move-result v10

    move-object v6, p0

    move v11, p2

    invoke-static/range {v6 .. v11}, Lcom/motorola/camera/custom/PortraitBokeh;->renderWithDepth(Landroid/graphics/Bitmap;[BIIII)Z

    move-result p0

    return p0

    .line 43
    :cond_4
    :goto_0
    return v0

    .line 39
    :cond_5
    :goto_1
    return v0

    .line 36
    :cond_6
    :goto_2
    return v0
.end method

.method static renderSingleCam(Landroid/graphics/Bitmap;Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;Landroid/hardware/camera2/TotalCaptureResult;Landroid/hardware/camera2/CameraCharacteristics;ZI)Ljava/lang/String;
    .locals 8

    .line 60
    const/4 v0, 0x0

    if-eqz p0, :cond_9

    if-gtz p5, :cond_0

    goto/16 :goto_3

    .line 61
    :cond_0
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    .line 62
    const/4 v3, 0x2

    if-lt v1, v3, :cond_8

    if-ge v2, v3, :cond_1

    goto/16 :goto_2

    .line 63
    :cond_1
    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v4

    int-to-double v4, v4

    const-wide/high16 v6, 0x408e000000000000L    # 960.0

    div-double/2addr v6, v4

    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->min(DD)D

    move-result-wide v4

    .line 64
    int-to-double v6, v1

    mul-double/2addr v6, v4

    double-to-int v1, v6

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    int-to-double v6, v2

    mul-double/2addr v6, v4

    double-to-int v2, v6

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 66
    nop

    .line 67
    nop

    .line 68
    const-string v3, "hw"

    if-eqz p1, :cond_3

    iget-object v4, p1, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    if-eqz v4, :cond_3

    .line 69
    iget-object p1, p1, Lcom/motorola/camera/fsm/camera/record/ImageCaptureRecord;->mMcfAuxData:Lcom/motorola/camera/mcf/McfAuxiliaryData;

    sget-object v4, Lcom/motorola/camera/mcf/McfAuxiliaryData;->DEPTHMAP:Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;

    invoke-virtual {p1, v4}, Lcom/motorola/camera/mcf/McfAuxiliaryData;->get(Lcom/motorola/camera/mcf/McfAuxiliaryData$Key;)Ljava/lang/Object;

    move-result-object p1

    .line 70
    instance-of v4, p1, Lcom/motorola/camera/mcf/McfAuxFrameData;

    if-eqz v4, :cond_3

    .line 71
    check-cast p1, Lcom/motorola/camera/mcf/McfAuxFrameData;

    invoke-static {p1, v1, v2}, Lcom/motorola/camera/custom/PortraitBokeh;->readDepth(Lcom/motorola/camera/mcf/McfAuxFrameData;II)[B

    move-result-object p1

    .line 72
    if-eqz p1, :cond_2

    move-object v4, v3

    goto :goto_0

    :cond_2
    move-object v4, v0

    goto :goto_0

    .line 75
    :cond_3
    move-object p1, v0

    move-object v4, p1

    :goto_0
    if-nez p1, :cond_4

    .line 76
    invoke-static {p2, p3, v1, v2, p4}, Lcom/motorola/camera/custom/PortraitBokeh;->buildFaceDepthMap(Landroid/hardware/camera2/TotalCaptureResult;Landroid/hardware/camera2/CameraCharacteristics;IIZ)[B

    move-result-object p1

    .line 77
    if-eqz p1, :cond_4

    const-string v4, "face"

    .line 79
    :cond_4
    if-nez p1, :cond_5

    .line 80
    invoke-static {v1, v2}, Lcom/motorola/camera/custom/PortraitBokeh;->buildRadialDepthMap(II)[B

    move-result-object p1

    .line 81
    const-string v4, "radial"

    .line 83
    :cond_5
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_6

    invoke-static {p1, v1, v2}, Lcom/motorola/camera/custom/PortraitBokeh;->focus([BII)I

    move-result p2

    goto :goto_1

    :cond_6
    const/16 p2, 0xd2

    :goto_1
    move p4, p2

    .line 84
    move p2, v1

    move p3, v2

    invoke-static/range {p0 .. p5}, Lcom/motorola/camera/custom/PortraitBokeh;->renderWithDepth(Landroid/graphics/Bitmap;[BIIII)Z

    move-result p0

    if-eqz p0, :cond_7

    move-object v0, v4

    :cond_7
    return-object v0

    .line 62
    :cond_8
    :goto_2
    return-object v0

    .line 60
    :cond_9
    :goto_3
    return-object v0
.end method

.method private static renderWithDepth(Landroid/graphics/Bitmap;[BIIII)Z
    .locals 20

    .line 88
    move-object/from16 v1, p0

    move/from16 v4, p2

    move/from16 v5, p3

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v10

    .line 89
    const/4 v11, 0x1

    invoke-static {v1, v4, v5, v11}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 90
    mul-int v3, v4, v5

    new-array v3, v3, [I

    .line 92
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v4, 0x0

    move/from16 v8, p2

    move v9, v5

    move/from16 v5, p2

    :try_start_0
    invoke-virtual/range {v2 .. v9}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 94
    if-eq v2, v1, :cond_0

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 96
    :cond_0
    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v6, p4

    move/from16 v7, p5

    move-object v2, v3

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/OffscreenBokeh;->render([I[BIIII)[I

    move-result-object v8

    .line 97
    if-nez v8, :cond_1

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v6, p4

    move/from16 v7, p5

    invoke-static/range {v2 .. v7}, Lcom/motorola/camera/custom/BokehKernel;->gather([I[BIIII)[I

    move-result-object v8

    move v9, v4

    move v12, v5

    goto :goto_0

    :cond_1
    move/from16 v9, p2

    move/from16 v12, p3

    .line 98
    :goto_0
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v8, v9, v12, v2}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v13

    .line 99
    nop

    .line 101
    :try_start_1
    invoke-static {v13, v0, v10, v11}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v14
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 102
    :try_start_2
    new-array v2, v0, [I

    new-array v15, v0, [I

    .line 103
    new-array v3, v0, [I

    .line 104
    const/16 v16, 0x0

    move/from16 v4, v16

    :goto_1
    if-ge v4, v0, :cond_2

    mul-int v5, v4, v9

    div-int/2addr v5, v0

    aput v5, v3, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 105
    :cond_2
    const/16 v4, 0x100

    new-array v5, v4, [I

    .line 106
    move/from16 v6, v16

    :goto_2
    if-ge v6, v4, :cond_3

    move/from16 v7, p4

    invoke-static {v6, v7}, Lcom/motorola/camera/custom/BokehKernel;->coc(II)F

    move-result v8

    const/high16 v17, 0x40400000    # 3.0f

    mul-float v8, v8, v17

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v4, v8}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/high16 v8, 0x43800000    # 256.0f

    mul-float/2addr v4, v8

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    aput v4, v5, v6

    add-int/lit8 v6, v6, 0x1

    const/16 v4, 0x100

    goto :goto_2

    .line 107
    :cond_3
    move/from16 v6, v16

    :goto_3
    if-ge v6, v10, :cond_6

    .line 108
    move-object v4, v5

    const/4 v5, 0x0

    const/4 v8, 0x1

    move-object v7, v3

    const/4 v3, 0x0

    move-object/from16 v17, v7

    move v7, v0

    move-object/from16 v19, v4

    move v4, v0

    move-object/from16 v0, v19

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object/from16 v18, v2

    .line 109
    const/4 v5, 0x0

    const/4 v8, 0x1

    const/4 v3, 0x0

    move v7, v4

    move-object v1, v14

    move-object v2, v15

    :try_start_3
    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 110
    mul-int v1, v6, v12

    :try_start_4
    div-int/2addr v1, v10

    mul-int/2addr v1, v9

    .line 111
    move/from16 v2, v16

    :goto_4
    if-ge v2, v4, :cond_5

    .line 112
    aget v3, v17, v2

    add-int/2addr v3, v1

    aget-byte v3, p1, v3

    and-int/lit16 v3, v3, 0xff

    aget v3, v0, v3

    .line 113
    if-eqz v3, :cond_4

    aget v5, v18, v2

    aget v7, v15, v2

    invoke-static {v5, v7, v3}, Lcom/motorola/camera/custom/PortraitBokeh;->mix(III)I

    move-result v3

    aput v3, v18, v2

    .line 111
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 115
    :cond_5
    const/4 v5, 0x0

    const/4 v8, 0x1

    const/4 v3, 0x0

    move v7, v4

    move-object/from16 v1, p0

    move-object/from16 v2, v18

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Bitmap;->setPixels([IIIIIII)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 107
    add-int/lit8 v6, v6, 0x1

    move-object v5, v0

    move v0, v4

    move-object/from16 v3, v17

    goto :goto_3

    .line 118
    :catchall_0
    move-exception v0

    move-object v14, v1

    goto :goto_5

    :cond_6
    if-eq v14, v13, :cond_7

    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 119
    :cond_7
    invoke-virtual {v13}, Landroid/graphics/Bitmap;->recycle()V

    .line 120
    nop

    .line 121
    return v11

    .line 118
    :catchall_1
    move-exception v0

    goto :goto_5

    :catchall_2
    move-exception v0

    move-object v14, v13

    :goto_5
    if-eq v14, v13, :cond_8

    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 119
    :cond_8
    invoke-virtual {v13}, Landroid/graphics/Bitmap;->recycle()V

    .line 120
    throw v0

    .line 94
    :catchall_3
    move-exception v0

    if-eq v2, v1, :cond_9

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 95
    :cond_9
    throw v0
.end method

.method private static smoothFocusByte(D)B
    .locals 4

    .line 232
    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpg-double v2, p0, v0

    if-gtz v2, :cond_0

    const/16 p0, -0x2e

    return p0

    .line 233
    :cond_0
    sub-double/2addr p0, v0

    const-wide v2, 0x3ff599999999999aL    # 1.35

    div-double/2addr p0, v2

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->min(DD)D

    move-result-wide p0

    .line 234
    mul-double v0, p0, p0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    mul-double/2addr p0, v2

    const-wide/high16 v2, 0x4008000000000000L    # 3.0

    sub-double/2addr v2, p0

    mul-double/2addr v0, v2

    .line 235
    const-wide p0, 0x4065400000000000L    # 170.0

    mul-double/2addr v0, p0

    const-wide p0, 0x406a400000000000L    # 210.0

    sub-double/2addr p0, v0

    invoke-static {p0, p1}, Ljava/lang/Math;->round(D)J

    move-result-wide p0

    long-to-int p0, p0

    int-to-byte p0, p0

    return p0
.end method
