.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;


# instance fields
.field public final synthetic f$0:I

.field public final synthetic f$1:I

.field public final synthetic f$2:I


# direct methods
.method public synthetic constructor <init>(III)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$0:I

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$1:I

    iput p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$2:I

    return-void
.end method


# virtual methods
.method public final processStrip([IIII)V
    .locals 7

    .line 0
    iget v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$0:I

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$1:I

    iget v2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda4;->f$2:I

    move-object v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$gradePixelBufferStrips$3(III[IIII)V

    return-void
.end method
