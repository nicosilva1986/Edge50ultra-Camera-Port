.class public final Lcom/motorola/camera/custom/ScenePostProcSelector;
.super Ljava/lang/Object;
.source "ScenePostProcSelector.java"


# static fields
.field public static final EDGE_FAST:I = 0x1

.field public static final EDGE_OFF:I = 0x0

.field public static final EDGE_ZSL:I = 0x3

.field private static final EXTREME_ZOOM:F = 12.0f

.field private static final LOW_LIGHT_LUX:F = 280.0f

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

.field public static final SCENE_HAL_FRAME_STACK:I = 0x1

.field public static final SCENE_KEEP:I = 0x0

.field public static final SCENE_RAW_HDR:I = 0x2

.field private static final TELE_ZOOM:F = 2.95f


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static hold()[I
    .locals 7

    .line 139
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

.method public static isPreservedSceneName(Ljava/lang/String;)Z
    .locals 2

    .line 44
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 47
    :cond_0
    const-string v1, "FLASH"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 48
    const-string v1, "PORTRAIT"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 49
    const-string v1, "BOKEH"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 50
    const-string v1, "DEPTH"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 51
    const-string v1, "NIGHT"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 52
    const-string v1, "_SN_"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 53
    const-string v1, "LRNV"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 54
    const-string v1, "DEDICATED"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 55
    const-string v1, "REMOSAIC"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 56
    const-string v1, "SUPER_RESOLUTION"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 57
    const-string v1, "MOTION"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 47
    :cond_2
    return v0

    .line 45
    :cond_3
    :goto_0
    return v0
.end method

.method private static pack(IIIIIII)[I
    .locals 0

    .line 144
    filled-new-array/range {p0 .. p6}, [I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;Z)[I
    .locals 6

    .line 62
    const/4 v5, 0x0

    move v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFLjava/lang/String;ZZ)[I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFLjava/lang/String;ZZ)[I
    .locals 8

    .line 67
    const/16 v0, 0x9

    if-ne p0, v0, :cond_0

    .line 69
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

    .line 71
    :cond_0
    if-nez p4, :cond_3

    if-nez p5, :cond_3

    invoke-static {p3}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isPreservedSceneName(Ljava/lang/String;)Z

    move-result p4

    if-eqz p4, :cond_1

    goto :goto_1

    .line 74
    :cond_1
    if-eqz p3, :cond_2

    const-string p4, "HDR"

    invoke-virtual {p3, p4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p3

    if-eqz p3, :cond_2

    const/4 p3, 0x1

    goto :goto_0

    :cond_2
    const/4 p3, 0x0

    :goto_0
    move v3, p3

    .line 75
    const/4 v4, 0x0

    const/4 v5, 0x0

    move v0, p0

    move v1, p1

    move v2, p2

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolve(IFFZZZ)[I

    move-result-object p0

    return-object p0

    .line 72
    :cond_3
    :goto_1
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->hold()[I

    move-result-object p0

    return-object p0
.end method

.method public static resolve(IFFZZZ)[I
    .locals 8

    .line 80
    const/16 v0, 0x9

    if-ne p0, v0, :cond_0

    .line 81
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

    .line 84
    :cond_0
    if-nez p5, :cond_3

    if-eqz p4, :cond_1

    goto :goto_0

    .line 87
    :cond_1
    if-nez p0, :cond_2

    .line 88
    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/ScenePostProcSelector;->resolveAuto(FFZ)[I

    move-result-object p0

    return-object p0

    .line 90
    :cond_2
    packed-switch p0, :pswitch_data_0

    .line 109
    invoke-static {}, Lcom/motorola/camera/custom/ScenePostProcSelector;->hold()[I

    move-result-object p0

    return-object p0

    .line 107
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

    .line 104
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

    .line 102
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

    .line 100
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

    .line 98
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

    .line 96
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

    .line 94
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

    .line 92
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

    .line 85
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

    .line 114
    invoke-static {p0}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    cmpg-float v0, p0, v1

    if-gez v0, :cond_1

    .line 115
    :cond_0
    const/high16 p0, 0x3f800000    # 1.0f

    .line 117
    :cond_1
    invoke-static {p1}, Ljava/lang/Float;->isFinite(F)Z

    move-result v0

    if-eqz v0, :cond_2

    cmpg-float v0, p1, v1

    if-gez v0, :cond_3

    .line 118
    :cond_2
    const/high16 p1, 0x42480000    # 50.0f

    .line 120
    :cond_3
    const/high16 v0, 0x41400000    # 12.0f

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_4

    .line 121
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

    .line 125
    :cond_4
    const v0, 0x403ccccd    # 2.95f

    cmpl-float p0, p0, v0

    const/high16 v0, 0x438c0000    # 280.0f

    if-ltz p0, :cond_5

    cmpg-float p0, p1, v0

    if-gez p0, :cond_5

    .line 126
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

    .line 128
    :cond_5
    cmpl-float p0, p1, v0

    if-ltz p0, :cond_6

    .line 129
    nop

    .line 130
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

    .line 132
    :cond_6
    if-eqz p2, :cond_7

    .line 133
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

    .line 135
    :cond_7
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
