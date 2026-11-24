.class public final Lcom/motorola/camera/custom/ScenePostProcSelector;
.super Ljava/lang/Object;
.source "ScenePostProcSelector.java"


# static fields
.field private static final BRIGHT_DAYLIGHT_LUX:F = 145.0f

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

.field public static final PROFILE_AUTO_STOCK:I = 0xa

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

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static hold()[I
    .locals 7

    .line 342
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

    .line 346
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

.method public static isContrastFilmLook(I)Z
    .locals 2

    .line 131
    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    const/4 v1, 0x3

    if-eq p0, v1, :cond_1

    const/16 v1, 0x9

    if-lt p0, v1, :cond_0

    const/16 v1, 0xd

    if-gt p0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :goto_0
    return v0
.end method

.method public static isDiffusionLook(I)Z
    .locals 1

    .line 127
    const/4 v0, 0x7

    if-eq p0, v0, :cond_1

    const/16 v0, 0x8

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

.method public static isPreservedSceneName(Ljava/lang/String;)Z
    .locals 2

    .line 73
    const/4 v0, 0x1

    const/16 v1, 0xa

    invoke-static {p0, v0, v1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;ZI)Z

    move-result p0

    return p0
.end method

.method public static isPreservedSceneName(Ljava/lang/String;Z)Z
    .locals 1

    .line 77
    const/16 v0, 0xa

    invoke-static {p0, p1, v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;ZI)Z

    move-result p0

    return p0
.end method

.method public static isPreservedSceneName(Ljava/lang/String;ZI)Z
    .locals 2

    .line 81
    const/4 v0, 0x0

    if-eqz p0, :cond_5

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_1

    .line 84
    :cond_0
    if-nez p1, :cond_1

    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isRawHtpSceneName(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 85
    return v0

    .line 87
    :cond_1
    const/16 p1, 0xa

    if-ne p2, p1, :cond_2

    .line 88
    const-string p1, "SUPER_RESOLUTION"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    goto :goto_0

    .line 89
    :cond_2
    const-string p1, "RAW_SUPER_RESOLUTION"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    .line 90
    :goto_0
    if-nez p1, :cond_3

    .line 91
    const-string p1, "FLASH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 92
    const-string p1, "PORTRAIT"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 93
    const-string p1, "BOKEH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 94
    const-string p1, "DEPTH"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 95
    const-string p1, "NIGHT"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 96
    const-string p1, "_SN_"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 97
    const-string p1, "LRNV"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 98
    const-string p1, "DEDICATED"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 99
    const-string p1, "REMOSAIC"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 100
    const-string p1, "MOTION"

    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_4

    :cond_3
    const/4 v0, 0x1

    .line 90
    :cond_4
    return v0

    .line 82
    :cond_5
    :goto_1
    return v0
.end method

.method public static isProtectedProfile(I)Z
    .locals 1

    .line 121
    const/4 v0, 0x4

    if-eq p0, v0, :cond_1

    const/16 v0, 0x9

    if-eq p0, v0, :cond_1

    const/16 v0, 0xa

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

.method public static isRawHtpSceneName(Ljava/lang/String;)Z
    .locals 2

    .line 59
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 62
    :cond_0
    const-string v1, "RAW_SUPER_NIGHT"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 63
    const-string v1, "RAW_SUPER_NIGHT_DEDICATED"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 64
    const-string v1, "RAW_HDR"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 65
    const-string v1, "RAW_SN_AUTO"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 66
    const-string v1, "RAW_SN_DEDICATED"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 67
    const-string v1, "RAW_SUPER_RESOLUTION"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 68
    const-string v1, "SUPER_RESOLUTION_HDR"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 69
    const-string v1, "MOTION_CAPTURE"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 62
    :cond_2
    return v0

    .line 60
    :cond_3
    :goto_0
    return v0
.end method

.method private static pack(IIIIIII)[I
    .locals 0

    .line 351
    filled-new-array/range {p0 .. p6}, [I

    move-result-object p0

    return-object p0
.end method

.method private static packExtended(IIIIIIIIIIIII)[I
    .locals 0

    .line 358
    filled-new-array/range {p0 .. p12}, [I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;Z)[I
    .locals 7

    .line 105
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

    .line 110
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

    .line 116
    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtended(IFFLjava/lang/String;ZZZ)[I

    move-result-object p0

    .line 117
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

    .line 269
    const/16 v0, 0x9

    if-ne p0, v0, :cond_0

    .line 270
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

    .line 273
    :cond_0
    if-nez p5, :cond_3

    if-eqz p4, :cond_1

    goto :goto_0

    .line 276
    :cond_1
    if-nez p0, :cond_2

    .line 277
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveAuto(FFZ)[I

    move-result-object p0

    return-object p0

    .line 279
    :cond_2
    packed-switch p0, :pswitch_data_0

    .line 298
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->hold()[I

    move-result-object p0

    return-object p0

    .line 296
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

    .line 293
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

    .line 291
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

    .line 289
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

    .line 287
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

    .line 285
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

    .line 283
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

    .line 281
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

    .line 274
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
    .locals 11

    .line 311
    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeZoom(F)F

    move-result p0

    .line 312
    invoke-static {p1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeLux(F)F

    move-result p1

    .line 313
    const/high16 v0, 0x41f00000    # 30.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 314
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

    .line 316
    :cond_0
    const/high16 v0, 0x41400000    # 12.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_1

    .line 317
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

    .line 321
    :cond_1
    const v0, 0x3f733333    # 0.95f

    cmpg-float v0, p0, v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/high16 v3, 0x438c0000    # 280.0f

    if-gez v0, :cond_3

    .line 322
    cmpg-float p0, p1, v3

    if-gez p0, :cond_2

    move v5, v2

    goto :goto_0

    :cond_2
    move v5, v1

    .line 323
    :goto_0
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x2

    const/4 v6, 0x1

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 327
    :cond_3
    const v0, 0x403ccccd    # 2.95f

    cmpl-float p0, p0, v0

    if-ltz p0, :cond_4

    cmpg-float p0, p1, v3

    if-gez p0, :cond_4

    .line 328
    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x2

    const/4 v6, 0x0

    const/4 v7, 0x1

    const/4 v8, 0x0

    invoke-static/range {v4 .. v10}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 330
    :cond_4
    cmpl-float p0, p1, v3

    if-ltz p0, :cond_5

    .line 331
    nop

    .line 332
    xor-int/lit8 v3, p2, 0x1

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x0

    const/4 v6, 0x1

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 334
    :cond_5
    const/high16 p0, 0x43110000    # 145.0f

    cmpg-float p0, p1, p0

    if-gtz p0, :cond_6

    move v5, v2

    goto :goto_1

    :cond_6
    move v5, v1

    .line 335
    :goto_1
    if-eqz p2, :cond_7

    .line 336
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x2

    const/4 v6, 0x1

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0

    .line 338
    :cond_7
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v3, 0x1

    const/4 v4, 0x2

    const/4 v6, 0x1

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/ScenePostProcSelector;->pack(IIIIIII)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolveExtended(IFFLjava/lang/String;ZZZ)[I
    .locals 32

    .line 163
    move/from16 v0, p0

    move-object/from16 v6, p3

    move/from16 v7, p6

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    .line 165
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

    .line 168
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

    .line 169
    :goto_0
    const/16 v1, 0xa

    if-ne v0, v1, :cond_6

    .line 170
    if-nez p4, :cond_5

    if-eqz p5, :cond_2

    if-eqz v10, :cond_5

    .line 171
    :cond_2
    invoke-static {v6, v7, v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;ZI)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_1

    .line 174
    :cond_3
    if-eqz v10, :cond_4

    .line 175
    const/16 v22, -0x1

    const/16 v23, -0x1

    const/4 v11, 0x1

    const/4 v12, -0x1

    const/4 v13, -0x1

    const/4 v14, 0x1

    const/4 v15, -0x1

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/16 v18, -0x1

    const/16 v19, -0x1

    const/16 v20, -0x1

    const/16 v21, -0x1

    invoke-static/range {v11 .. v23}, Lcom/motorola/camera/custom/ScenePostProcSelector;->packExtended(IIIIIIIIIIIII)[I

    move-result-object v0

    return-object v0

    .line 178
    :cond_4
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0

    .line 172
    :cond_5
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0

    .line 180
    :cond_6
    if-nez p4, :cond_29

    if-eqz p5, :cond_7

    if-eqz v10, :cond_29

    .line 181
    :cond_7
    invoke-static {v6, v7, v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;ZI)Z

    move-result v1

    if-eqz v1, :cond_8

    goto/16 :goto_11

    .line 184
    :cond_8
    invoke-static/range {p1 .. p1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeZoom(F)F

    move-result v1

    .line 185
    invoke-static/range {p2 .. p2}, Lcom/motorola/camera/custom/ScenePostProcSelector;->sanitizeLux(F)F

    move-result v2

    .line 186
    if-eqz v6, :cond_9

    const-string v3, "HDR"

    invoke-virtual {v6, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_9

    move v3, v8

    goto :goto_2

    :cond_9
    move v3, v9

    .line 187
    :goto_2
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFZZZ)[I

    move-result-object v3

    .line 188
    aget v4, v3, v8

    const/4 v5, 0x3

    const/4 v11, -0x1

    if-ne v4, v11, :cond_a

    aget v4, v3, v5

    if-ne v4, v11, :cond_a

    .line 189
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0

    .line 191
    :cond_a
    const/4 v4, 0x2

    if-nez v7, :cond_c

    aget v7, v3, v9

    if-eq v7, v4, :cond_b

    aget v7, v3, v9

    if-nez v7, :cond_c

    if-eqz v10, :cond_c

    .line 194
    :cond_b
    aput v8, v3, v9

    .line 196
    :cond_c
    const/high16 v7, 0x438c0000    # 280.0f

    if-nez v0, :cond_d

    if-eqz v10, :cond_d

    cmpl-float v12, v2, v7

    if-ltz v12, :cond_d

    .line 199
    aput v4, v3, v8

    .line 200
    aput v8, v3, v4

    .line 203
    :cond_d
    nop

    .line 204
    const/high16 v12, 0x43820000    # 260.0f

    const v13, 0x403ccccd    # 2.95f

    const/high16 v14, 0x41400000    # 12.0f

    const/high16 v15, 0x40b00000    # 5.5f

    move/from16 p1, v7

    const/4 v7, 0x7

    move/from16 v16, v8

    const/4 v8, 0x5

    move/from16 v17, v9

    const/4 v9, 0x4

    if-ne v0, v9, :cond_e

    .line 205
    move/from16 v26, v17

    goto :goto_5

    .line 206
    :cond_e
    if-eqz v0, :cond_f

    if-eq v0, v5, :cond_f

    if-lt v0, v8, :cond_13

    if-gt v0, v7, :cond_13

    .line 209
    :cond_f
    const v18, 0x3fd9999a    # 1.7f

    cmpl-float v18, v1, v18

    if-ltz v18, :cond_11

    cmpg-float v18, v1, v13

    if-gez v18, :cond_11

    .line 210
    const/high16 v18, 0x439b0000    # 310.0f

    cmpg-float v18, v2, v18

    if-gez v18, :cond_10

    move/from16 v18, v16

    goto :goto_3

    :cond_10
    move/from16 v18, v17

    :goto_3
    move/from16 v26, v18

    goto :goto_5

    .line 211
    :cond_11
    cmpl-float v18, v1, v15

    if-ltz v18, :cond_13

    cmpg-float v18, v1, v14

    if-gez v18, :cond_13

    .line 212
    cmpg-float v18, v2, v12

    if-gez v18, :cond_12

    move/from16 v18, v16

    goto :goto_4

    :cond_12
    move/from16 v18, v17

    :goto_4
    move/from16 v26, v18

    goto :goto_5

    .line 216
    :cond_13
    move/from16 v26, v11

    :goto_5
    nop

    .line 217
    if-eq v0, v9, :cond_1c

    if-ne v0, v4, :cond_14

    goto :goto_a

    .line 219
    :cond_14
    if-nez v0, :cond_18

    .line 220
    cmpl-float v18, v2, p1

    if-gez v18, :cond_17

    cmpl-float v18, v1, v15

    if-ltz v18, :cond_15

    cmpg-float v18, v1, v14

    if-gez v18, :cond_15

    cmpl-float v12, v2, v12

    if-gez v12, :cond_17

    :cond_15
    cmpl-float v12, v1, v14

    if-ltz v12, :cond_16

    const/high16 v12, 0x43700000    # 240.0f

    cmpl-float v12, v2, v12

    if-ltz v12, :cond_16

    goto :goto_6

    :cond_16
    move/from16 v12, v17

    goto :goto_7

    :cond_17
    :goto_6
    move/from16 v12, v16

    .line 223
    :goto_7
    nop

    .line 224
    move/from16 v27, v12

    goto :goto_b

    :cond_18
    if-eq v0, v5, :cond_1a

    if-lt v0, v8, :cond_19

    if-gt v0, v7, :cond_19

    goto :goto_8

    .line 229
    :cond_19
    move/from16 v27, v11

    goto :goto_b

    .line 226
    :cond_1a
    :goto_8
    cmpl-float v12, v2, p1

    if-ltz v12, :cond_1b

    move/from16 v12, v16

    goto :goto_9

    :cond_1b
    move/from16 v12, v17

    :goto_9
    move/from16 v27, v12

    goto :goto_b

    .line 218
    :cond_1c
    :goto_a
    move/from16 v27, v17

    .line 229
    :goto_b
    nop

    .line 230
    if-eq v0, v9, :cond_20

    if-ne v0, v4, :cond_1d

    goto :goto_c

    .line 232
    :cond_1d
    if-eqz v0, :cond_1e

    if-eq v0, v5, :cond_1e

    if-lt v0, v8, :cond_1f

    if-gt v0, v7, :cond_1f

    :cond_1e
    cmpl-float v12, v1, v15

    if-ltz v12, :cond_1f

    .line 235
    move/from16 v28, v4

    goto :goto_d

    .line 238
    :cond_1f
    move/from16 v28, v11

    goto :goto_d

    .line 231
    :cond_20
    :goto_c
    move/from16 v28, v17

    .line 238
    :goto_d
    nop

    .line 239
    if-ne v0, v9, :cond_21

    .line 240
    move/from16 v29, v17

    goto :goto_e

    .line 241
    :cond_21
    if-ne v0, v5, :cond_22

    .line 242
    move/from16 v29, v4

    goto :goto_e

    .line 243
    :cond_22
    if-nez v0, :cond_24

    .line 244
    if-eqz v10, :cond_23

    const-string v7, "RAW_HDR"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_23

    .line 245
    move/from16 v29, v4

    goto :goto_e

    .line 246
    :cond_23
    aget v6, v3, v17

    if-ne v6, v4, :cond_25

    .line 247
    move/from16 v29, v16

    goto :goto_e

    .line 249
    :cond_24
    if-lt v0, v8, :cond_25

    if-gt v0, v7, :cond_25

    .line 250
    aget v6, v3, v17

    if-ne v6, v4, :cond_25

    .line 251
    move/from16 v29, v16

    goto :goto_e

    .line 255
    :cond_25
    move/from16 v29, v11

    :goto_e
    cmpl-float v6, v1, v13

    if-ltz v6, :cond_26

    const/high16 v6, 0x41200000    # 10.0f

    cmpg-float v1, v1, v6

    if-gez v1, :cond_26

    const/high16 v1, 0x43c80000    # 400.0f

    cmpg-float v1, v2, v1

    if-gez v1, :cond_26

    move/from16 v30, v16

    goto :goto_f

    :cond_26
    move/from16 v30, v11

    .line 256
    :goto_f
    nop

    .line 257
    if-ne v0, v9, :cond_27

    .line 258
    move/from16 v31, v17

    goto :goto_10

    .line 259
    :cond_27
    if-nez v0, :cond_28

    const/high16 v0, 0x43be0000    # 380.0f

    cmpl-float v0, v2, v0

    if-ltz v0, :cond_28

    .line 260
    move/from16 v31, v16

    goto :goto_10

    .line 263
    :cond_28
    move/from16 v31, v11

    :goto_10
    aget v19, v3, v17

    aget v20, v3, v16

    aget v21, v3, v4

    aget v22, v3, v5

    aget v23, v3, v9

    aget v24, v3, v8

    const/4 v0, 0x6

    aget v25, v3, v0

    invoke-static/range {v19 .. v31}, Lcom/motorola/camera/custom/ScenePostProcSelector;->packExtended(IIIIIIIIIIIII)[I

    move-result-object v0

    return-object v0

    .line 182
    :cond_29
    :goto_11
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->holdExtended()[I

    move-result-object v0

    return-object v0
.end method

.method public static resolveExtendedWithLook(IFFLjava/lang/String;ZZZII)[I
    .locals 0

    .line 138
    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveExtended(IFFLjava/lang/String;ZZZ)[I

    move-result-object p1

    .line 139
    const/16 p2, 0x8

    const/4 p3, 0x0

    if-ne p0, p2, :cond_0

    .line 141
    const/4 p2, 0x5

    aput p3, p1, p2

    .line 143
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result p2

    if-eqz p2, :cond_1

    .line 144
    return-object p1

    .line 146
    :cond_1
    const/16 p2, 0x64

    invoke-static {p2, p8}, Ljava/lang/Math;->min(II)I

    move-result p2

    invoke-static {p3, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 147
    if-nez p0, :cond_2

    .line 148
    invoke-static {p7}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isDiffusionLook(I)Z

    move-result p0

    if-eqz p0, :cond_2

    const/16 p0, 0x32

    if-lt p2, p0, :cond_2

    const/4 p0, 0x2

    aget p2, p1, p0

    const/4 p4, 0x1

    if-ne p2, p4, :cond_2

    .line 150
    aput p3, p1, p0

    .line 152
    :cond_2
    return-object p1
.end method

.method private static sanitizeLux(F)F
    .locals 1

    .line 307
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

    .line 303
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
