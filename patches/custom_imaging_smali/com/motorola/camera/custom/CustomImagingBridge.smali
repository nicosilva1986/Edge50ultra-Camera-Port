.class public final Lcom/motorola/camera/custom/CustomImagingBridge;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"


# static fields
.field private static final MAX_BAYER_PIXELS:I = 0x1312d00

.field public static final PREF_KEY:Ljava/lang/String; = "com.motorola.camera.post_processing_profile"

.field private static final PROFILE_LABELS:[Ljava/lang/CharSequence;

.field private static final PROFILE_VALUES:[Ljava/lang/CharSequence;

.field private static final STRIP_HEIGHT:I = 0x200

.field private static final TAG:Ljava/lang/String; = "CustomImagingBridge"


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 50
    const/16 v0, 0x9

    new-array v1, v0, [Ljava/lang/CharSequence;

    const-string v2, "Auto (Scene-Adaptive)"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "Natural ZSL (NR ZSL / Edge ZSL)"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "Minimal ISP (NR Minimal / Edge Off)"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "Detail HDR (RAW HDR / Low Halo)"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-string v2, "Pure ISP (MFNR Off / NR Off)"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    const-string v2, "iPhone Natural (Apple Style LUT)"

    const/4 v8, 0x5

    aput-object v2, v1, v8

    const-string v2, "iPhone Rich Contrast (Apple Style)"

    const/4 v9, 0x6

    aput-object v2, v1, v9

    const-string v2, "iPhone Amber (Warm Photonic LUT)"

    const/4 v10, 0x7

    aput-object v2, v1, v10

    const-string v2, "Clean RAW Bayer (DNG -> Clean JPG)"

    const/16 v11, 0x8

    aput-object v2, v1, v11

    sput-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    .line 62
    new-array v0, v0, [Ljava/lang/CharSequence;

    const-string v1, "0"

    aput-object v1, v0, v3

    const-string v1, "1"

    aput-object v1, v0, v4

    const-string v1, "2"

    aput-object v1, v0, v5

    const-string v1, "3"

    aput-object v1, v0, v6

    const-string v1, "4"

    aput-object v1, v0, v7

    const-string v1, "5"

    aput-object v1, v0, v8

    const-string v1, "6"

    aput-object v1, v0, v9

    const-string v1, "7"

    aput-object v1, v0, v10

    const-string v1, "8"

    aput-object v1, v0, v11

    sput-object v0, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyCaptureRequestOverrides(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;)V
    .locals 7

    .line 172
    if-eqz p1, :cond_6

    if-nez p0, :cond_0

    goto/16 :goto_2

    .line 174
    :cond_0
    nop

    .line 175
    :try_start_0
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->FLASH_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 176
    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eqz v0, :cond_1

    .line 177
    move v0, v3

    goto :goto_0

    .line 179
    :cond_1
    sget-object v0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 180
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v1, :cond_2

    .line 181
    move v0, v3

    goto :goto_0

    .line 184
    :cond_2
    move v0, v2

    :goto_0
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v4

    .line 185
    aget v3, v4, v3

    .line 186
    const/4 v5, 0x2

    aget v5, v4, v5

    .line 187
    aget v1, v4, v1

    .line 189
    invoke-static {p0}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v4

    .line 190
    if-eqz v4, :cond_4

    .line 191
    if-ltz v3, :cond_3

    .line 192
    sget-object v6, Landroid/hardware/camera2/CameraCharacteristics;->NOISE_REDUCTION_AVAILABLE_NOISE_REDUCTION_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v6}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [I

    .line 193
    invoke-static {v6, v3}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 194
    sget-object v6, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p1, v6, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 197
    :cond_3
    if-ltz v5, :cond_4

    .line 198
    sget-object v3, Landroid/hardware/camera2/CameraCharacteristics;->EDGE_AVAILABLE_EDGE_MODES:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v4, v3}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [I

    .line 199
    invoke-static {v3, v5}, Lcom/motorola/camera/settings/SettingsHelper;->isContainedInArray([II)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 200
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {p1, v3, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V

    .line 204
    :cond_4
    if-nez v1, :cond_5

    .line 205
    invoke-static {p0, p1, v2, v0}, Lcom/motorola/camera/fsm/camera/modes/RequestBuilderHelper;->setMfnr(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Builder;ZZ)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 209
    :cond_5
    goto :goto_1

    .line 207
    :catchall_0
    move-exception p0

    .line 208
    const-string p1, "CustomImagingBridge"

    const-string v0, "applyCaptureRequestOverrides failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 210
    :goto_1
    return-void

    .line 172
    :cond_6
    :goto_2
    return-void
.end method

.method public static applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 15

    .line 213
    const-string v1, "CustomImagingBridge"

    if-eqz p0, :cond_b

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->isRawData()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_4

    .line 216
    :cond_0
    const/4 v2, 0x0

    invoke-static {v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v3, 0x5

    aget v3, v0, v3

    .line 217
    if-gtz v3, :cond_1

    .line 218
    return-void

    .line 220
    :cond_1
    iget-object v0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-virtual {v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->getByteBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 221
    if-nez v0, :cond_2

    .line 222
    return-void

    .line 225
    :cond_2
    :try_start_0
    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v4

    .line 226
    array-length v0, v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/16 v5, 0x10

    if-ge v0, v5, :cond_3

    return-void

    .line 228
    :cond_3
    nop

    .line 230
    :try_start_1
    new-instance v0, Lcom/motorola/camera/photometadata/PhotoMetadata;

    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-direct {v5, v4}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v0, v5}, Lcom/motorola/camera/photometadata/PhotoMetadata;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 231
    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v0, 0x0

    .line 233
    :goto_0
    :try_start_2
    new-instance v5, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v5}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 234
    const/4 v6, 0x1

    iput-boolean v6, v5, Landroid/graphics/BitmapFactory$Options;->inMutable:Z

    .line 235
    sget-object v6, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    iput-object v6, v5, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 236
    array-length v6, v4

    invoke-static {v4, v2, v6, v5}, Landroid/graphics/BitmapFactory;->decodeByteArray([BIILandroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 237
    if-nez v7, :cond_4

    return-void

    .line 240
    :cond_4
    :try_start_3
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-nez v5, :cond_5

    .line 266
    :try_start_4
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 240
    return-void

    .line 241
    :cond_5
    :try_start_5
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v10

    .line 242
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    .line 243
    if-lez v10, :cond_a

    if-gtz v5, :cond_6

    goto/16 :goto_2

    .line 245
    :cond_6
    const/16 v6, 0x200

    invoke-static {v6, v5}, Ljava/lang/Math;->min(II)I

    move-result v8

    mul-int/2addr v8, v10

    new-array v8, v8, [I

    .line 246
    move v12, v2

    :goto_1
    if-ge v12, v5, :cond_7

    .line 247
    sub-int v9, v5, v12

    invoke-static {v6, v9}, Ljava/lang/Math;->min(II)I

    move-result v14

    .line 248
    const/4 v9, 0x0

    const/4 v11, 0x0

    move v13, v10

    invoke-virtual/range {v7 .. v14}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 249
    invoke-static {v8, v10, v14, v3}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIII)V

    .line 250
    const/4 v9, 0x0

    const/4 v11, 0x0

    move v13, v10

    invoke-virtual/range {v7 .. v14}, Landroid/graphics/Bitmap;->setPixels([IIIIIII)V

    .line 246
    add-int/lit16 v12, v12, 0x200

    goto :goto_1

    .line 253
    :cond_7
    new-instance v5, Ljava/io/ByteArrayOutputStream;

    array-length v4, v4

    invoke-direct {v5, v4}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 254
    sget-object v4, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v6, 0x60

    invoke-virtual {v7, v4, v6, v5}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v4
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-nez v4, :cond_8

    .line 266
    :try_start_6
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 255
    return-void

    .line 257
    :cond_8
    :try_start_7
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    .line 258
    if-eqz v0, :cond_9

    .line 259
    new-instance v5, Ljava/io/ByteArrayOutputStream;

    array-length v6, v4

    const/high16 v8, 0x10000

    add-int/2addr v6, v8

    invoke-direct {v5, v6}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 260
    new-instance v6, Ljava/io/ByteArrayInputStream;

    invoke-direct {v6, v4}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v0, v6, v5, v2}, Lcom/motorola/camera/photometadata/PhotoMetadata;->saveJpegAttributes(Ljava/io/InputStream;Ljava/io/OutputStream;Z)V

    .line 261
    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    .line 263
    :cond_9
    iget-object p0, p0, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    invoke-static {v4}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->setByteBuffer(Ljava/nio/ByteBuffer;)V

    .line 264
    array-length p0, v4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Applied AppleStyle LUT="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " bytes="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 266
    :try_start_8
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 267
    nop

    .line 270
    goto :goto_3

    .line 266
    :cond_a
    :goto_2
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 243
    return-void

    .line 266
    :catchall_1
    move-exception v0

    move-object p0, v0

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    .line 267
    throw p0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .line 268
    :catchall_2
    move-exception v0

    move-object p0, v0

    .line 269
    const-string v0, "applyCustomLutIfEnabled failed, keeping original JPEG"

    invoke-static {v1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 271
    :goto_3
    return-void

    .line 214
    :cond_b
    :goto_4
    return-void
.end method

.method public static exportCleanBayerJpeg(Ljava/nio/ByteBuffer;Landroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
    .locals 22

    .line 275
    move-object/from16 v0, p1

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    if-eqz p0, :cond_17

    if-eqz v0, :cond_17

    if-eqz v2, :cond_17

    if-nez v1, :cond_0

    goto/16 :goto_b

    .line 276
    :cond_0
    iget v4, v2, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mWidth:I

    .line 277
    iget v5, v2, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mHeight:I

    .line 278
    const/4 v12, 0x0

    invoke-static {v12}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v13

    .line 279
    const/4 v3, 0x6

    aget v3, v13, v3

    if-nez v3, :cond_1

    return-void

    .line 280
    :cond_1
    const-string v14, "CustomImagingBridge"

    if-lez v4, :cond_16

    if-lez v5, :cond_16

    int-to-long v6, v4

    int-to-long v8, v5

    mul-long/2addr v6, v8

    const-wide/32 v8, 0x1312d00

    cmp-long v3, v6, v8

    if-lez v3, :cond_2

    goto/16 :goto_a

    .line 285
    :cond_2
    :try_start_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v15

    .line 286
    invoke-static/range {p0 .. p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->toByteArray(Ljava/nio/ByteBuffer;)[B

    move-result-object v3

    .line 287
    const-wide/16 v8, 0x5

    mul-long/2addr v8, v6

    const-wide/16 v10, 0x4

    div-long/2addr v8, v10

    .line 288
    const-wide/16 v10, 0x2

    mul-long/2addr v6, v10

    .line 290
    array-length v10, v3

    int-to-long v10, v10

    cmp-long v6, v10, v6

    const/4 v7, 0x1

    if-ltz v6, :cond_3

    .line 291
    array-length v6, v3

    div-int/2addr v6, v5

    invoke-static {v3, v4, v5, v6, v7}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw16ToInt([BIIIZ)[I

    move-result-object v3

    goto :goto_0

    .line 292
    :cond_3
    array-length v6, v3

    int-to-long v10, v6

    cmp-long v6, v10, v8

    if-ltz v6, :cond_15

    .line 293
    array-length v6, v3

    div-int/2addr v6, v5

    invoke-static {v3, v4, v5, v6}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->unpackRaw10ToInt([BIII)[I

    move-result-object v3

    .line 299
    :goto_0
    invoke-static {v1}, Lcom/motorola/camera/settings/SettingsManager;->getCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v6

    .line 300
    nop

    .line 301
    const/4 v8, 0x4

    new-array v9, v8, [F

    const/high16 v10, 0x42800000    # 64.0f

    aput v10, v9, v12

    aput v10, v9, v7

    const/4 v11, 0x2

    aput v10, v9, v11

    const/4 v8, 0x3

    aput v10, v9, v8

    .line 302
    nop

    .line 303
    nop

    .line 305
    const v17, 0x447fc000    # 1023.0f

    if-eqz v6, :cond_7

    .line 306
    sget-object v10, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_COLOR_FILTER_ARRANGEMENT:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v6, v10}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Integer;

    .line 307
    if-eqz v10, :cond_4

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    goto :goto_1

    :cond_4
    move v10, v12

    .line 308
    :goto_1
    move/from16 v19, v11

    sget-object v11, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_BLACK_LEVEL_PATTERN:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v6, v11}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/hardware/camera2/params/BlackLevelPattern;

    .line 309
    if-eqz v11, :cond_5

    .line 310
    move/from16 v20, v8

    invoke-virtual {v11, v12, v12}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v9, v12

    .line 311
    invoke-virtual {v11, v7, v12}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v9, v7

    .line 312
    invoke-virtual {v11, v12, v7}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v9, v19

    .line 313
    invoke-virtual {v11, v7, v7}, Landroid/hardware/camera2/params/BlackLevelPattern;->getOffsetForIndex(II)I

    move-result v8

    int-to-float v8, v8

    aput v8, v9, v20

    goto :goto_2

    .line 309
    :cond_5
    move/from16 v20, v8

    .line 315
    :goto_2
    sget-object v8, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_INFO_WHITE_LEVEL:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v6, v8}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Integer;

    .line 316
    if-eqz v8, :cond_6

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v11

    if-lez v11, :cond_6

    .line 317
    invoke-virtual {v8}, Ljava/lang/Integer;->floatValue()F

    move-result v17

    .line 319
    :cond_6
    sget-object v8, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_COLOR_TRANSFORM1:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v6, v8}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/hardware/camera2/params/ColorSpaceTransform;

    invoke-static {v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v6

    move/from16 v8, v17

    goto :goto_3

    .line 305
    :cond_7
    move/from16 v20, v8

    move/from16 v19, v11

    move v10, v12

    const/4 v6, 0x0

    move/from16 v8, v17

    .line 322
    :goto_3
    sget-object v11, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_TRANSFORM:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v11}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/hardware/camera2/params/ColorSpaceTransform;

    .line 323
    if-eqz v11, :cond_8

    .line 324
    invoke-static {v11}, Lcom/motorola/camera/custom/CustomImagingBridge;->extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F

    move-result-object v11

    .line 325
    if-eqz v11, :cond_8

    move-object v6, v11

    .line 328
    :cond_8
    move/from16 v11, v20

    new-array v11, v11, [F

    const v17, 0x3fe66666    # 1.8f

    aput v17, v11, v12

    const/high16 v17, 0x3f800000    # 1.0f

    aput v17, v11, v7

    const v17, 0x3fcccccd    # 1.6f

    aput v17, v11, v19

    .line 329
    move/from16 v17, v7

    sget-object v7, Landroid/hardware/camera2/CaptureResult;->COLOR_CORRECTION_GAINS:Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {v0, v7}, Landroid/hardware/camera2/TotalCaptureResult;->get(Landroid/hardware/camera2/CaptureResult$Key;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/hardware/camera2/params/RggbChannelVector;

    .line 330
    if-eqz v7, :cond_9

    .line 331
    invoke-virtual {v7}, Landroid/hardware/camera2/params/RggbChannelVector;->getRed()F

    move-result v20

    aput v20, v11, v12

    .line 332
    invoke-virtual {v7}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenEven()F

    move-result v20

    invoke-virtual {v7}, Landroid/hardware/camera2/params/RggbChannelVector;->getGreenOdd()F

    move-result v21

    add-float v20, v20, v21

    const/high16 v21, 0x3f000000    # 0.5f

    mul-float v20, v20, v21

    aput v20, v11, v17

    .line 333
    invoke-virtual {v7}, Landroid/hardware/camera2/params/RggbChannelVector;->getBlue()F

    move-result v7

    aput v7, v11, v19

    .line 336
    :cond_9
    move-object v7, v9

    move-object v9, v11

    const/high16 v11, 0x3e800000    # 0.25f

    move v12, v10

    move-object v10, v6

    move v6, v12

    const/4 v12, 0x0

    const/16 v18, 0x4

    invoke-static/range {v3 .. v11}, Lcom/motorola/camera/custom/CleanBayerRawProcessor;->processRawToArgb([IIII[FF[F[FF)[I

    move-result-object v3

    .line 338
    const/4 v6, 0x5

    aget v6, v13, v6

    .line 339
    if-lez v6, :cond_a

    .line 340
    invoke-static {v3, v4, v5, v6}, Lcom/motorola/camera/custom/AppleStyleToneEngine;->applyToArgbPixels([IIII)V

    .line 343
    :cond_a
    sget-object v6, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v3, v4, v5, v6}, Landroid/graphics/Bitmap;->createBitmap([IIILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 344
    if-nez v3, :cond_b

    return-void

    .line 347
    :cond_b
    :try_start_1
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    mul-int/2addr v4, v5

    div-int/lit8 v4, v4, 0x4

    invoke-direct {v6, v4}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 348
    sget-object v4, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v5, 0x60

    invoke-virtual {v3, v4, v5, v6}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    if-nez v4, :cond_c

    .line 351
    :try_start_2
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 348
    return-void

    .line 349
    :cond_c
    :try_start_3
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 351
    :try_start_4
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 352
    nop

    .line 354
    invoke-static {v4, v0, v12, v1, v12}, Lcom/motorola/camera/utility/ExifUtility;->appendExifToJpeg([BLandroid/hardware/camera2/TotalCaptureResult;Lcom/motorola/camera/mcf/McfMetadata;Ljava/lang/String;[B)[B

    move-result-object v0

    .line 355
    iget-object v1, v2, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mMediaData:Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;

    .line 356
    if-eqz v1, :cond_14

    iget-object v3, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    if-eqz v3, :cond_14

    iget-object v3, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v3, v3, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    if-nez v3, :cond_d

    goto/16 :goto_8

    .line 357
    :cond_d
    iget-object v1, v1, Lcom/motorola/camera/capturedmediadata/CapturedImageMediaData;->mCaptureRecord:Lcom/motorola/camera/fsm/camera/record/CaptureRecord;

    iget-object v1, v1, Lcom/motorola/camera/fsm/camera/record/CaptureRecord;->mMediaFile:Lcom/motorola/camera/storage/MediaFile;

    invoke-interface {v1}, Lcom/motorola/camera/storage/MediaFile;->asSharedMediaFile()Lcom/motorola/camera/storage/backend/MediaStoreFile;

    move-result-object v1

    .line 358
    if-eqz v1, :cond_13

    iget-object v3, v1, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    if-nez v3, :cond_e

    goto/16 :goto_7

    .line 360
    :cond_e
    iget-object v3, v2, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    if-eqz v3, :cond_f

    iget-object v2, v2, Lcom/motorola/camera/saving/SaveImageService$ImageContainer;->mFileName:Lcom/motorola/camera/saving/FileName;

    invoke-virtual {v2}, Lcom/motorola/camera/saving/FileName;->getName()Ljava/lang/String;

    move-result-object v2

    goto :goto_4

    :cond_f
    const-string v2, "IMG_CLEAN"

    .line 361
    :goto_4
    const-string v3, ".dng"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    const-string v4, "_CLEAN.jpg"

    if-eqz v3, :cond_10

    .line 362
    :try_start_5
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x4

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_5

    .line 363
    :cond_10
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 365
    :goto_5
    iget-object v1, v1, Lcom/motorola/camera/storage/backend/MediaStoreFile;->mediaFilePath:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-virtual {v1, v2}, Lcom/motorola/camera/storage/MediaFilePath;->withFileName(Ljava/lang/String;)Lcom/motorola/camera/storage/MediaFilePath;

    move-result-object v1

    .line 366
    invoke-static {v1}, Lcom/motorola/camera/storage/MediaFile;->fromMediaFilePath(Lcom/motorola/camera/storage/MediaFilePath;)Lcom/motorola/camera/storage/backend/MediaStoreMediaFile;

    move-result-object v1

    invoke-static {v1}, Lcom/motorola/camera/storage/StorageUtils;->createMediaFileWithFallback(Lcom/motorola/camera/storage/MediaFile;)Lcom/motorola/camera/storage/MediaFile;

    move-result-object v1

    .line 367
    if-nez v1, :cond_11

    return-void

    .line 368
    :cond_11
    invoke-interface {v1}, Lcom/motorola/camera/storage/MediaFile;->getWriteFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v3

    .line 369
    if-nez v3, :cond_12

    return-void

    .line 370
    :cond_12
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 371
    :try_start_6
    invoke-virtual {v4, v0}, Ljava/io/FileOutputStream;->write([B)V

    .line 372
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->flush()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 373
    :try_start_7
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    .line 374
    invoke-interface {v1}, Lcom/motorola/camera/storage/MediaFile;->finish()V

    .line 375
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v3

    sub-long/2addr v3, v15

    const-wide/32 v5, 0xf4240

    div-long/2addr v3, v5

    .line 376
    array-length v0, v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "CleanBayerRaw saved "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "B) in "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v14, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 379
    goto :goto_9

    .line 370
    :catchall_0
    move-exception v0

    move-object v1, v0

    :try_start_8
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_6

    :catchall_1
    move-exception v0

    :try_start_9
    invoke-virtual {v1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_6
    throw v1

    .line 358
    :cond_13
    :goto_7
    return-void

    .line 356
    :cond_14
    :goto_8
    return-void

    .line 351
    :catchall_2
    move-exception v0

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 352
    throw v0

    .line 295
    :cond_15
    array-length v0, v3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Raw buffer too small: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v14, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    .line 296
    return-void

    .line 377
    :catchall_3
    move-exception v0

    .line 378
    const-string v1, "exportCleanBayerJpeg failed cleanly (DNG unaffected)"

    invoke-static {v14, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 380
    :goto_9
    return-void

    .line 281
    :cond_16
    :goto_a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Skip CleanBayerRaw for unsupported size "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v14, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 282
    return-void

    .line 275
    :cond_17
    :goto_b
    return-void
.end method

.method private static extractCcm(Landroid/hardware/camera2/params/ColorSpaceTransform;)[F
    .locals 4

    .line 383
    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 384
    :cond_0
    const/16 v0, 0x9

    new-array v1, v0, [Landroid/util/Rational;

    .line 385
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/hardware/camera2/params/ColorSpaceTransform;->copyElements([Landroid/util/Rational;I)V

    .line 386
    new-array p0, v0, [F

    .line 387
    nop

    :goto_0
    if-ge v2, v0, :cond_3

    .line 388
    aget-object v3, v1, v2

    if-eqz v3, :cond_1

    aget-object v3, v1, v2

    invoke-virtual {v3}, Landroid/util/Rational;->floatValue()F

    move-result v3

    goto :goto_1

    :cond_1
    rem-int/lit8 v3, v2, 0x4

    if-nez v3, :cond_2

    const/high16 v3, 0x3f800000    # 1.0f

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    aput v3, p0, v2

    .line 387
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 390
    :cond_3
    return-object p0
.end method

.method public static getSelectedProfile()I
    .locals 4

    .line 88
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    .line 89
    if-nez v1, :cond_0

    return v0

    .line 90
    :cond_0
    const-string v2, "com.motorola.camera.post_processing_profile"

    const-string v3, "0"

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 91
    if-nez v1, :cond_1

    return v0

    .line 92
    :cond_1
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 93
    if-ltz v1, :cond_2

    const/16 v2, 0x8

    if-gt v1, v2, :cond_2

    move v0, v1

    :cond_2
    return v0

    .line 94
    :catchall_0
    move-exception v1

    .line 95
    return v0
.end method

.method public static initPostProcPreference(Landroidx/preference/PreferenceFragmentCompat;)V
    .locals 5

    .line 69
    const-string v0, "com.motorola.camera.post_processing_profile"

    if-nez p0, :cond_0

    return-void

    .line 71
    :cond_0
    :try_start_0
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object p0

    check-cast p0, Landroidx/preference/ListPreference;

    .line 72
    if-nez p0, :cond_1

    return-void

    .line 73
    :cond_1
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_LABELS:[Ljava/lang/CharSequence;

    invoke-virtual {p0, v1}, Landroidx/preference/ListPreference;->setEntries([Ljava/lang/CharSequence;)V

    .line 74
    sget-object v1, Lcom/motorola/camera/custom/CustomImagingBridge;->PROFILE_VALUES:[Ljava/lang/CharSequence;

    iput-object v1, p0, Landroidx/preference/ListPreference;->mEntryValues:[Ljava/lang/CharSequence;

    .line 75
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 76
    const-string v2, "0"

    if-eqz v1, :cond_2

    :try_start_1
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    move-object v0, v2

    .line 77
    :goto_0
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_4

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x30

    if-lt v3, v4, :cond_4

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v3, 0x38

    if-le v1, v3, :cond_3

    goto :goto_1

    :cond_3
    move-object v2, v0

    goto :goto_2

    .line 78
    :cond_4
    :goto_1
    nop

    .line 80
    :goto_2
    invoke-virtual {p0, v2}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 83
    goto :goto_3

    .line 81
    :catchall_0
    move-exception p0

    .line 82
    const-string v0, "CustomImagingBridge"

    const-string v1, "initPostProcPreference failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 84
    :goto_3
    return-void
.end method

.method public static overrideSceneMode(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)Lcom/motorola/camera/mcf/Mcf$SceneMode;
    .locals 3

    .line 133
    :try_start_0
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveForScene(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)[I

    move-result-object p1

    .line 134
    const/4 v0, 0x0

    aget v1, p1, v0

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 135
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->HAL_FRAME_STACK:Lcom/motorola/camera/mcf/Mcf$SceneMode;

    return-object p0

    .line 137
    :cond_0
    aget p1, p1, v0

    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    .line 138
    sget-object p0, Lcom/motorola/camera/mcf/Mcf$SceneMode;->RAW_HDR:Lcom/motorola/camera/mcf/Mcf$SceneMode;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 142
    :cond_1
    goto :goto_0

    .line 140
    :catchall_0
    move-exception p1

    .line 141
    const-string v0, "CustomImagingBridge"

    const-string v1, "overrideSceneMode fallback"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 143
    :goto_0
    return-object p0
.end method

.method private static resolveActiveScene(Z)[I
    .locals 1

    .line 124
    nop

    .line 126
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/mcfmanagers/SceneModeManager;->getCurrentScene()Lcom/motorola/camera/mcf/Mcf$SceneMode;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 127
    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v0, 0x0

    .line 128
    :goto_0
    invoke-static {v0, p0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveForScene(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolveEdgeMode(I)I
    .locals 2

    .line 152
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x2

    aget v0, v0, v1

    .line 153
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveEnableMfnr(Z)Z
    .locals 3

    .line 162
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v1

    const/4 v2, 0x3

    aget v1, v1, v2

    .line 163
    if-ltz v1, :cond_1

    if-eqz v1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    move p0, v0

    :cond_1
    :goto_0
    return p0
.end method

.method private static resolveForScene(Lcom/motorola/camera/mcf/Mcf$SceneMode;Z)[I
    .locals 9

    .line 100
    nop

    .line 101
    nop

    .line 103
    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsManager;->getCurrentCameraType()Lcom/motorola/camera/settings/CameraType;

    move-result-object v0

    .line 104
    if-eqz v0, :cond_0

    .line 105
    invoke-static {v0}, Lcom/motorola/camera/settings/SettingsManager;->getZoomValue(Lcom/motorola/camera/settings/CameraType;)F

    move-result v0

    .line 106
    invoke-static {v0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_0

    cmpl-float v3, v0, v1

    if-lez v3, :cond_0

    move v2, v0

    goto :goto_0

    .line 108
    :catchall_0
    move-exception v0

    :cond_0
    :goto_0
    move v4, v2

    .line 110
    const/high16 v2, 0x42480000    # 50.0f

    :try_start_1
    invoke-static {}, Lcom/motorola/camera/IqConfigManager;->getInstance()Lcom/motorola/camera/IqConfigManager;

    move-result-object v0

    .line 111
    if-eqz v0, :cond_1

    iget v3, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    invoke-static {v3}, Ljava/lang/Float;->isFinite(F)Z

    move-result v3

    if-eqz v3, :cond_1

    iget v3, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F

    cmpl-float v1, v3, v1

    if-ltz v1, :cond_1

    .line 112
    iget v2, v0, Lcom/motorola/camera/IqConfigManager;->mLastLuxIdx:F
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    .line 114
    :catchall_1
    move-exception v0

    :cond_1
    :goto_1
    move v5, v2

    .line 116
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Lcom/motorola/camera/mcf/Mcf$SceneMode;->name()Ljava/lang/String;

    move-result-object p0

    goto :goto_2

    :cond_2
    const-string p0, ""

    .line 117
    :goto_2
    const-string v0, "HDR"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    .line 118
    const-string v0, "DEDICATED"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_4

    const-string v0, "SUPER_NIGHT"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_3

    :cond_3
    move v7, v1

    goto :goto_4

    :cond_4
    :goto_3
    move v7, v2

    .line 119
    :goto_4
    if-nez p1, :cond_6

    const-string p1, "FLASH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_5

    goto :goto_5

    :cond_5
    move v8, v1

    goto :goto_6

    :cond_6
    :goto_5
    move v8, v2

    .line 120
    :goto_6
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v3

    invoke-static/range {v3 .. v8}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFZZZ)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolveNoiseReduction(I)I
    .locals 2

    .line 147
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    .line 148
    if-ltz v0, :cond_0

    move p0, v0

    :cond_0
    return p0
.end method

.method public static resolveSuperZoom(B)B
    .locals 2

    .line 157
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v0

    const/4 v1, 0x4

    aget v0, v0, v1

    .line 158
    if-ltz v0, :cond_0

    int-to-byte p0, v0

    :cond_0
    return p0
.end method

.method public static shouldAllowInSensorCrop()Z
    .locals 3

    .line 167
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->resolveActiveScene(Z)[I

    move-result-object v1

    const/4 v2, 0x3

    aget v1, v1, v2

    .line 168
    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method private static toByteArray(Ljava/nio/ByteBuffer;)[B
    .locals 1

    .line 394
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 395
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 396
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 397
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 398
    return-object v0
.end method
