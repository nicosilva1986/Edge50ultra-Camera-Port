.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:I

.field public final synthetic f$2:[F

.field public final synthetic f$3:[F

.field public final synthetic f$4:I

.field public final synthetic f$5:I

.field public final synthetic f$6:Z

.field public final synthetic f$7:Z

.field public final synthetic f$8:Z

.field public final synthetic f$9:F


# direct methods
.method public synthetic constructor <init>(II[F[FIIZZZF)V
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

    return-void
.end method


# virtual methods
.method public final processStrip([IIII)V
    .locals 14

    .line 0
    iget v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$0:I

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$1:I

    iget-object v2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$2:[F

    iget-object v3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$3:[F

    iget v4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$4:I

    iget v5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$5:I

    iget-boolean v6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$6:Z

    iget-boolean v7, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$7:Z

    iget-boolean v8, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$8:Z

    iget v9, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda2;->f$9:F

    move-object v10, p1

    move/from16 v11, p2

    move/from16 v12, p3

    move/from16 v13, p4

    invoke-static/range {v0 .. v13}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$applyCustomLutIfEnabled$0(II[F[FIIZZZF[IIII)V

    return-void
.end method
