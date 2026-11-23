.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:I

.field public final synthetic f$10:Z

.field public final synthetic f$11:I

.field public final synthetic f$2:[F

.field public final synthetic f$3:[F

.field public final synthetic f$4:I

.field public final synthetic f$5:I

.field public final synthetic f$6:Z

.field public final synthetic f$7:Z

.field public final synthetic f$8:Z

.field public final synthetic f$9:F


# direct methods
.method public synthetic constructor <init>(II[F[FIIZZZFZI)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$0:I

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$1:I

    iput-object p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$2:[F

    iput-object p4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$3:[F

    iput p5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$4:I

    iput p6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$5:I

    iput-boolean p7, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$6:Z

    iput-boolean p8, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$7:Z

    iput-boolean p9, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$8:Z

    iput p10, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$9:F

    iput-boolean p11, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$10:Z

    iput p12, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$11:I

    return-void
.end method


# virtual methods
.method public final processStrip([IIII)V
    .locals 16

    .line 0
    move-object/from16 v0, p0

    iget v1, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$0:I

    move v2, v1

    iget v1, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$1:I

    move v3, v2

    iget-object v2, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$2:[F

    move v4, v3

    iget-object v3, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$3:[F

    move v5, v4

    iget v4, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$4:I

    move v6, v5

    iget v5, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$5:I

    move v7, v6

    iget-boolean v6, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$6:Z

    move v8, v7

    iget-boolean v7, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$7:Z

    move v9, v8

    iget-boolean v8, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$8:Z

    move v10, v9

    iget v9, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$9:F

    move v11, v10

    iget-boolean v10, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$10:Z

    iget v0, v0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$11:I

    move v12, v11

    move v11, v0

    move v0, v12

    move-object/from16 v12, p1

    move/from16 v13, p2

    move/from16 v14, p3

    move/from16 v15, p4

    invoke-static/range {v0 .. v15}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$applyCustomLutIfEnabled$0(II[F[FIIZZZFZI[IIII)V

    return-void
.end method
