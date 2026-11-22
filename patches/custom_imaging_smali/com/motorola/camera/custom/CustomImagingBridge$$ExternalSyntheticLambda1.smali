.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:[I

.field public final synthetic f$1:I

.field public final synthetic f$2:I

.field public final synthetic f$3:I

.field public final synthetic f$4:I

.field public final synthetic f$5:I


# direct methods
.method public synthetic constructor <init>([IIIIII)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$0:[I

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$1:I

    iput p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$2:I

    iput p4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$3:I

    iput p5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$4:I

    iput p6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$5:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 6

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$0:[I

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$1:I

    iget v2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$2:I

    iget v3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$3:I

    iget v4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$4:I

    iget v5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda1;->f$5:I

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$gradeSurfaceInBatches$0([IIIIII)V

    return-void
.end method
