.class public final Lcom/motorola/camera/custom/ScenePostProcSelector;
.super Ljava/lang/Object;
.source "ScenePostProcSelector.java"


# static fields
.field private static final DUSK_HDR_MIN_LUX:F = 140.0f

.field public static final EDGE_FAST:I = 0x1

.field public static final EDGE_OFF:I = 0x0

.field public static final EDGE_ZSL:I = 0x3

.field private static final EXTREME_ZOOM:F = 12.0f

.field private static final LOW_LIGHT_LUX:F = 280.0f

.field public static final NR_FAST:I = 0x1

.field public static final NR_HIGH_QUALITY:I = 0x2

.field public static final NR_MINIMAL:I = 0x3

.field public static final NR_OFF:I = 0x0

.field public static final NR_ZSL:I = 0x4

.field public static final PROFILE_AUTO_SCENE_ADAPTIVE:I = 0x0

.field public static final PROFILE_CLEAN_RAW_BAYER:I = 0x8

.field public static final PROFILE_DETAIL_HDR:I = 0x3

.field public static final PROFILE_DISABLE_POST_PROCESSING:I = 0x9

.field public static final PROFILE_IPHONE_AMBER:I = 0x7

.field public static final PROFILE_IPHONE_NATURAL:I = 0x5

.field public static final PROFILE_IPHONE_RICH_CONTRAST:I = 0x6

.field public static final PROFILE_MINIMAL_ISP:I = 0x2

.field public static final PROFILE_NATURAL_ZSL:I = 0x1

.field public static final PROFILE_PURE_ISP:I = 0x4

.field private static final QLL_MIN_LUX:F = 380.0f

.field public static final SCENE_HAL_FRAME_STACK:I = 0x1

.field public static final SCENE_KEEP:I = 0x0

.field public static final SCENE_RAW_HDR:I = 0x2

.field private static final TELE_FALLBACK_MAX:F = 10.0f

.field private static final TELE_FALLBACK_MAX_LUX:F = 400.0f

.field private static final TELE_ISZ_MAX_LUX:F = 260.0f

.field private static final TELE_ISZ_MIN:F = 5.5f

.field private static final TELE_ZOOM:F = 2.95f

.field private static final UW_LOW_LIGHT_LUX:F = 180.0f

.field private static final UW_ZOOM_MAX:F = 0.95f

.field private static final WIDE_ISZ_MAX_LUX:F = 310.0f

.field private static final WIDE_ISZ_MIN:F = 1.7f


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static hold()[I
    .locals 7

    .line 280
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x0

    const/4 v1, -0x1

    const/4 v2, -0x1

    const/4 v3, -0x1

    const/4 v4, -0x1

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object v0

    return-object v0
.end method

.method private static holdExtended()[I
    .locals 13

    .line 284
    const/4 v11, -0x1

    const/4 v12, -0x1

    const/4 v0, 0x0

    const/4 v1, -0x1

    const/4 v2, -0x1

    const/4 v3, -0x1

    const/4 v4, -0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, -0x1

    const/4 v8, -0x1

    const/4 v9, -0x1

    const/4 v10, -0x1

    invoke-static/range {v0 .. v12}, Lcom/motorola/camera/custom/ScenePostProcSelector;->packExtended(IIIIIIIIIIIII)[I

    move-result-object v0

    return-object v0
.end method

.method public static isPreservedSceneName(Ljava/lang/String;)Z
    .locals 1

    .line 69
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method public static isPreservedSceneName(Ljava/lang/String;Z)Z
    .locals 2

    .line 73
    const/4 v0, 0x0

    if-eqz p0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 76
    :cond_0
    if-nez p1, :cond_1

    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isRawHtpSceneName(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 77
    return v0

    .line 79
    :cond_1
    const-string p1, "FLASH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 80
    const-string p1, "PORTRAIT"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 81
    const-string p1, "BOKEH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 82
    const-string p1, "DEPTH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 83
    const-string p1, "NIGHT"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 84
    const-string p1, "_SN_"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 85
    const-string p1, "LRNV"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 86
    const-string p1, "DEDICATED"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 87
    const-string p1, "REMOSAIC"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 88
    const-string p1, "SUPER_RESOLUTION"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 89
    const-string p1, "MOTION"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_3

    :cond_2
    const/4 v0, 0x1

    .line 79
    :cond_3
    return v0

    .line 74
    :cond_4
    :goto_0
    return v0
.end method

.method public static isRawHtpSceneName(Ljava/lang/String;)Z
    .locals 2

    .line 57
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 60
    :cond_0
    const-string v1, "RAW_SUPER_NIGHT"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 61
    const-string v1, "RAW_SUPER_NIGHT_DEDICATED"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 62
    const-string v1, "RAW_HDR"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 63
    const-string v1, "RAW_SN_AUTO"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 64
    const-string v1, "RAW_SN_DEDICATED"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 65
    const-string v1, "MOTION_CAPTURE"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 60
    :cond_2
    return v0

    .line 58
    :cond_3
    :goto_0
    return v0
.end method

.method private static pack(IIIIIII)[I
    .locals 0

    .line 289
    filled-new-array/range {p0 .. p6}, [I

    move-result-object p0

    return-object p0
.end method

.method private static packExtended(IIIIIIIIIIIII)[I
    .locals 0

    .line 296
    filled-new-array/range {p0 .. p12}, [I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;Z)[I
    .locals 7

    .line 94
    const/4 v5, 0x0

    const/4 v6, 0x1

    move v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFLjava/lang/String;ZZZ)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;ZZ)[I
    .locals 7

    .line 99
    const/4 v6, 0x1

    move v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFLjava/lang/String;ZZZ)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;ZZZ)[I
    .locals 7

    .line 105
    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtended(IFFLjava/lang/String;ZZZ)[I

    move-result-object p0

    .line 106
    const/4 p1, 0x0

    aget v0, p0, p1

    const/4 p1, 0x1

    aget v1, p0, p1

    const/4 p1, 0x2

    aget v2, p0, p1

    const/4 p1, 0x3

    aget v3, p0, p1

    const/4 p1, 0x4

    aget v4, p0, p1

    const/4 p1, 0x5

    aget v5, p0, p1

    const/4 p1, 0x6

    aget v6, p0, p1

    filled-new-array/range {v0 .. v6}, [I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFZZZ)[I
    .locals 8

    .line 213
    const/16 v0, 0x9

    if-ne p0, v0, :cond_0

    .line 214
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v1 .. v7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 217
    :cond_0
    if-nez p5, :cond_3

    if-eqz p4, :cond_1

    goto :goto_0

    .line 220
    :cond_1
    if-nez p0, :cond_2

    .line 221
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveAuto(FFZ)[I

    move-result-object p0

    return-object p0

    .line 223
    :cond_2
    packed-switch p0, :pswitch_data_0

    .line 242
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->hold()[I

    move-result-object p0

    return-object p0

    .line 240
    :pswitch_0
    const/4 v5, 0x1

    const/4 v6, 0x1

    const/4 v0, 0x0

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 237
    :pswitch_1
    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 235
    :pswitch_2
    const/4 v5, 0x2

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 233
    :pswitch_3
    const/4 v5, 0x1

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 231
    :pswitch_4
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 229
    :pswitch_5
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x2

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 227
    :pswitch_6
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 225
    :pswitch_7
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x4

    const/4 v2, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 218
    :cond_3
    :goto_0
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->hold()[I

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static resolveAuto(FFZ)[I
    .locals 8

    .line 255
    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeZoom(F)F

    move-result p0

    .line 256
    invoke-static {p1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeLux(F)F

    move-result p1

    .line 257
    const/high16 v0, 0x41400000    # 12.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 258
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x1

    const/4 v5, 0x0

    invoke-static/range {v1 .. v7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 261
    :cond_0
    const v0, 0x3f733333    # 0.95f

    cmpg-float v0, p0, v0

    if-gez v0, :cond_1

    const/high16 v0, 0x43340000    # 180.0f

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_1

    .line 262
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    invoke-static/range {v1 .. v7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 266
    :cond_1
    const v0, 0x403ccccd    # 2.95f

    cmpl-float p0, p0, v0

    const/high16 v0, 0x438c0000    # 280.0f

    if-ltz p0, :cond_2

    cmpg-float p0, p1, v0

    if-gez p0, :cond_2

    .line 267
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x3

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    invoke-static/range {v1 .. v7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 269
    :cond_2
    cmpl-float p0, p1, v0

    if-ltz p0, :cond_3

    .line 270
    nop

    .line 271
    xor-int/lit8 v0, p2, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 273
    :cond_3
    if-eqz p2, :cond_4

    .line 274
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x2

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 276
    :cond_4
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolveExtended(IFFLjava/lang/String;ZZZ)[I
    .locals 33

    .line 117
    move/from16 v0, p0

    move-object/from16 v6, p3

    move/from16 v7, p6

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 119
    const/4 v13, -0x1

    const/4 v14, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static/range {v2 .. v14}, Lcom/motorola/camera/custom/ScenePostProcSelector;->packExtended(IIIIIIIIIIIII)[I

    move-result-object v0

    return-object v0

    .line 122
    :cond_0
    const/4 v8, 0x1

    const/4 v9, 0x0

    if-nez v7, :cond_1

    invoke-static {v6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isRawHtpSceneName(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    move v10, v8

    goto :goto_0

    :cond_1
    move v10, v9

    .line 123
    :goto_0
    if-nez p4, :cond_29

    if-eqz p5, :cond_2

    if-eqz v10, :cond_29

    :cond_2
    invoke-static {v6, v7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_3

    goto/16 :goto_11

    .line 126
    :cond_3
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeZoom(F)F

    move-result v1

    .line 127
    invoke-static/range {p2 .. p2}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeLux(F)F

    move-result v2

    .line 128
    if-eqz v6, :cond_4

    const-string v3, "HDR"

    invoke-virtual {v6, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    move v3, v8

    goto :goto_1

    :cond_4
    move v3, v9

    .line 129
    :goto_1
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFZZZ)[I

    move-result-object v4

    .line 130
    aget v5, v4, v8

    const/4 v11, 0x3

    const/4 v12, -0x1

    if-ne v5, v12, :cond_5

    aget v5, v4, v11

    if-ne v5, v12, :cond_5

    .line 131
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0

    .line 133
    :cond_5
    const/4 v5, 0x2

    if-nez v7, :cond_7

    aget v7, v4, v9

    if-eq v7, v5, :cond_6

    aget v7, v4, v9

    if-nez v7, :cond_7

    if-eqz v10, :cond_7

    .line 136
    :cond_6
    aput v8, v4, v9

    .line 138
    :cond_7
    const/high16 v7, 0x438c0000    # 280.0f

    if-nez v0, :cond_8

    if-eqz v10, :cond_8

    cmpl-float v13, v2, v7

    if-ltz v13, :cond_8

    .line 141
    aput v5, v4, v8

    .line 142
    aput v8, v4, v5

    .line 145
    :cond_8
    nop

    .line 146
    const/high16 v13, 0x43820000    # 260.0f

    const v14, 0x403ccccd    # 2.95f

    const/high16 v15, 0x40b00000    # 5.5f

    move/from16 p1, v7

    const/4 v7, 0x7

    const/high16 v16, 0x41400000    # 12.0f

    move/from16 v17, v8

    const/4 v8, 0x5

    move/from16 v18, v9

    const/4 v9, 0x4

    if-ne v0, v9, :cond_9

    .line 147
    move/from16 v27, v18

    goto :goto_4

    .line 148
    :cond_9
    if-eqz v0, :cond_a

    if-eq v0, v11, :cond_a

    if-lt v0, v8, :cond_e

    if-gt v0, v7, :cond_e

    .line 151
    :cond_a
    const v19, 0x3fd9999a    # 1.7f

    cmpl-float v19, v1, v19

    if-ltz v19, :cond_c

    cmpg-float v19, v1, v14

    if-gez v19, :cond_c

    .line 152
    const/high16 v19, 0x439b0000    # 310.0f

    cmpg-float v19, v2, v19

    if-gez v19, :cond_b

    move/from16 v19, v17

    goto :goto_2

    :cond_b
    move/from16 v19, v18

    :goto_2
    move/from16 v27, v19

    goto :goto_4

    .line 153
    :cond_c
    cmpl-float v19, v1, v15

    if-ltz v19, :cond_e

    cmpg-float v19, v1, v16

    if-gez v19, :cond_e

    .line 154
    cmpg-float v19, v2, v13

    if-gez v19, :cond_d

    move/from16 v19, v17

    goto :goto_3

    :cond_d
    move/from16 v19, v18

    :goto_3
    move/from16 v27, v19

    goto :goto_4

    .line 158
    :cond_e
    move/from16 v27, v12

    :goto_4
    nop

    .line 159
    if-eq v0, v9, :cond_1a

    if-ne v0, v5, :cond_f

    goto/16 :goto_a

    .line 161
    :cond_f
    const/high16 v19, 0x43340000    # 180.0f

    const v20, 0x3f733333    # 0.95f

    if-nez v0, :cond_15

    .line 162
    if-eqz v10, :cond_10

    cmpl-float v21, v2, p1

    if-gez v21, :cond_14

    :cond_10
    cmpl-float v21, v2, p1

    if-gez v21, :cond_14

    cmpg-float v20, v1, v20

    if-gez v20, :cond_11

    cmpl-float v19, v2, v19

    if-gez v19, :cond_14

    :cond_11
    cmpl-float v19, v1, v15

    if-ltz v19, :cond_12

    cmpg-float v19, v1, v16

    if-gez v19, :cond_12

    cmpl-float v13, v2, v13

    if-gez v13, :cond_14

    :cond_12
    cmpl-float v13, v1, v16

    if-ltz v13, :cond_13

    const/high16 v13, 0x43700000    # 240.0f

    cmpl-float v13, v2, v13

    if-ltz v13, :cond_13

    goto :goto_5

    :cond_13
    move/from16 v13, v18

    goto :goto_6

    :cond_14
    :goto_5
    move/from16 v13, v17

    .line 167
    :goto_6
    nop

    .line 168
    move/from16 v28, v13

    goto :goto_b

    :cond_15
    if-eq v0, v11, :cond_17

    if-lt v0, v8, :cond_16

    if-gt v0, v7, :cond_16

    goto :goto_7

    .line 173
    :cond_16
    move/from16 v28, v12

    goto :goto_b

    .line 170
    :cond_17
    :goto_7
    cmpl-float v13, v2, p1

    if-gez v13, :cond_19

    cmpg-float v13, v1, v20

    if-gez v13, :cond_18

    cmpl-float v13, v2, v19

    if-ltz v13, :cond_18

    goto :goto_8

    :cond_18
    move/from16 v13, v18

    goto :goto_9

    :cond_19
    :goto_8
    move/from16 v13, v17

    :goto_9
    move/from16 v28, v13

    goto :goto_b

    .line 160
    :cond_1a
    :goto_a
    move/from16 v28, v18

    .line 173
    :goto_b
    nop

    .line 174
    if-eq v0, v9, :cond_1e

    if-ne v0, v5, :cond_1b

    goto :goto_c

    .line 176
    :cond_1b
    if-eqz v0, :cond_1c

    if-eq v0, v11, :cond_1c

    if-lt v0, v8, :cond_1d

    if-gt v0, v7, :cond_1d

    :cond_1c
    cmpl-float v13, v1, v15

    if-ltz v13, :cond_1d

    .line 179
    move/from16 v29, v5

    goto :goto_d

    .line 182
    :cond_1d
    move/from16 v29, v12

    goto :goto_d

    .line 175
    :cond_1e
    :goto_c
    move/from16 v29, v18

    .line 182
    :goto_d
    nop

    .line 183
    const/high16 v13, 0x43c80000    # 400.0f

    if-ne v0, v9, :cond_1f

    .line 184
    move/from16 v30, v18

    goto :goto_e

    .line 185
    :cond_1f
    if-ne v0, v11, :cond_20

    .line 186
    move/from16 v30, v5

    goto :goto_e

    .line 187
    :cond_20
    const/high16 v15, 0x430c0000    # 140.0f

    if-nez v0, :cond_23

    .line 188
    if-eqz v10, :cond_21

    const-string v7, "RAW_HDR"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_21

    .line 189
    move/from16 v30, v5

    goto :goto_e

    .line 190
    :cond_21
    if-nez v3, :cond_22

    cmpl-float v3, v2, v15

    if-ltz v3, :cond_25

    cmpg-float v3, v2, v13

    if-gez v3, :cond_25

    cmpg-float v3, v1, v16

    if-gez v3, :cond_25

    .line 191
    :cond_22
    move/from16 v30, v17

    goto :goto_e

    .line 193
    :cond_23
    if-lt v0, v8, :cond_25

    if-gt v0, v7, :cond_25

    .line 194
    if-nez v3, :cond_24

    cmpl-float v3, v2, v15

    if-ltz v3, :cond_25

    cmpg-float v3, v2, v13

    if-gez v3, :cond_25

    cmpg-float v3, v1, v16

    if-gez v3, :cond_25

    .line 195
    :cond_24
    move/from16 v30, v17

    goto :goto_e

    .line 199
    :cond_25
    move/from16 v30, v12

    :goto_e
    cmpl-float v3, v1, v14

    if-ltz v3, :cond_26

    const/high16 v3, 0x41200000    # 10.0f

    cmpg-float v1, v1, v3

    if-gez v1, :cond_26

    cmpg-float v1, v2, v13

    if-gez v1, :cond_26

    move/from16 v31, v17

    goto :goto_f

    :cond_26
    move/from16 v31, v12

    .line 200
    :goto_f
    nop

    .line 201
    if-ne v0, v9, :cond_27

    .line 202
    move/from16 v32, v18

    goto :goto_10

    .line 203
    :cond_27
    if-nez v0, :cond_28

    const/high16 v0, 0x43be0000    # 380.0f

    cmpl-float v0, v2, v0

    if-ltz v0, :cond_28

    .line 204
    move/from16 v32, v17

    goto :goto_10

    .line 207
    :cond_28
    move/from16 v32, v12

    :goto_10
    aget v20, v4, v18

    aget v21, v4, v17

    aget v22, v4, v5

    aget v23, v4, v11

    aget v24, v4, v9

    aget v25, v4, v8

    const/4 v0, 0x6

    aget v26, v4, v0

    invoke-static/range {v20 .. v32}, Lcom/motorola/camera/custom/ScenePostProcSelector;->packExtended(IIIIIIIIIIIII)[I

    move-result-object v0

    return-object v0

    .line 124
    :cond_29
    :goto_11
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0
.end method

.method private static sanitizeLux(F)F
    .locals 1

    .line 251
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gez v0, :cond_1

    :cond_0
    const/high16 p0, 0x42480000    # 50.0f

    :cond_1
    return p0
.end method

.method private static sanitizeZoom(F)F
    .locals 1

    .line 247
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    cmpg-float v0, p0, v0

    if-gez v0, :cond_1

    :cond_0
    const/high16 p0, 0x3f800000    # 1.0f

    :cond_1
    return p0
.end method
