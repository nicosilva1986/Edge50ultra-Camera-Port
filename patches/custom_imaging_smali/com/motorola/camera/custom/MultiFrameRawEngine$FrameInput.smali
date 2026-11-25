.class public final Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FrameInput"
.end annotation


# instance fields
.field public final blackLevel4:[F

.field public final cfaPattern:I

.field public final exposureNs:J

.field public final focalLengthPx:F

.field public final gyroExcursionRad:F

.field public final gyroShiftX:F

.field public final gyroShiftY:F

.field public final height:I

.field public final iso:I

.field public final noiseOffset4:[F

.field public final noiseScale4:[F

.field public final raw:[I

.field public final timestampNs:J

.field public final whiteLevel:F

.field public final width:I


# direct methods
.method public constructor <init>([IIII[FFJJIFF)V
    .locals 18

    .line 33
    const/16 v16, 0x0

    const/16 v17, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move-object/from16 v5, p5

    move/from16 v6, p6

    move-wide/from16 v7, p7

    move-wide/from16 v9, p9

    move/from16 v11, p11

    move/from16 v12, p12

    move/from16 v13, p13

    invoke-direct/range {v0 .. v17}, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;-><init>([IIII[FFJJIFFFF[F[F)V

    .line 35
    return-void
.end method

.method public constructor <init>([IIII[FFJJIFFFF[F[F)V
    .locals 2

    .line 41
    move-object/from16 v0, p16

    move-object/from16 v1, p17

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    .line 43
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    .line 44
    iput p3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    .line 45
    iput p4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    .line 46
    iput-object p5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    .line 47
    iput p6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    .line 48
    iput-wide p7, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    .line 49
    iput-wide p9, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->exposureNs:J

    .line 50
    iput p11, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->iso:I

    .line 51
    iput p12, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    .line 52
    iput p13, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    .line 53
    invoke-static/range {p14 .. p14}, Ljava/lang/Float;->isFinite(F)Z

    move-result p1

    const/4 p2, 0x0

    if-eqz p1, :cond_0

    move/from16 p1, p14

    goto :goto_0

    :cond_0
    move p1, p2

    :goto_0
    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroShiftX:F

    .line 54
    invoke-static/range {p15 .. p15}, Ljava/lang/Float;->isFinite(F)Z

    move-result p1

    if-eqz p1, :cond_1

    move/from16 p2, p15

    :cond_1
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroShiftY:F

    .line 55
    const/4 p1, 0x4

    const/4 p2, 0x0

    if-eqz v0, :cond_2

    array-length p3, v0

    if-ne p3, p1, :cond_2

    invoke-virtual {v0}, [F->clone()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, [F

    goto :goto_1

    :cond_2
    move-object p3, p2

    :goto_1
    iput-object p3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseScale4:[F

    .line 56
    if-eqz v1, :cond_3

    array-length p3, v1

    if-ne p3, p1, :cond_3

    invoke-virtual {v1}, [F->clone()Ljava/lang/Object;

    move-result-object p1

    move-object p2, p1

    check-cast p2, [F

    :cond_3
    iput-object p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->noiseOffset4:[F

    .line 57
    return-void
.end method
