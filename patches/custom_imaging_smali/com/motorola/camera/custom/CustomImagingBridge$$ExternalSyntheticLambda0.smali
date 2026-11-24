.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:[B

.field public final synthetic f$1:I

.field public final synthetic f$2:I

.field public final synthetic f$3:Landroid/hardware/camera2/TotalCaptureResult;

.field public final synthetic f$4:Ljava/lang/String;

.field public final synthetic f$5:Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

.field public final synthetic f$6:Ljava/lang/String;

.field public final synthetic f$7:Lcom/motorola/camera/storage/MediaFilePath;


# direct methods
.method public synthetic constructor <init>([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$0:[B

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$1:I

    iput p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$2:I

    iput-object p4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$3:Landroid/hardware/camera2/TotalCaptureResult;

    iput-object p5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$4:Ljava/lang/String;

    iput-object p6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$5:Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    iput-object p7, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$6:Ljava/lang/String;

    iput-object p8, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$7:Lcom/motorola/camera/storage/MediaFilePath;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 8

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$0:[B

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$1:I

    iget v2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$2:I

    iget-object v3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$3:Landroid/hardware/camera2/TotalCaptureResult;

    iget-object v4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$4:Ljava/lang/String;

    iget-object v5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$5:Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;

    iget-object v6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$6:Ljava/lang/String;

    iget-object v7, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda0;->f$7:Lcom/motorola/camera/storage/MediaFilePath;

    invoke-static/range {v0 .. v7}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$exportCleanBayerJpeg$6([BIILandroid/hardware/camera2/TotalCaptureResult;Ljava/lang/String;Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;Ljava/lang/String;Lcom/motorola/camera/storage/MediaFilePath;)V

    return-void
.end method
