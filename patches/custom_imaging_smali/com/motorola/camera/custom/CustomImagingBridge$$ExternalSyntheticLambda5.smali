.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;


# instance fields
.field public final synthetic f$0:Lcom/motorola/camera/custom/LookFilterEngine;

.field public final synthetic f$1:I


# direct methods
.method public synthetic constructor <init>(Lcom/motorola/camera/custom/LookFilterEngine;I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;->f$0:Lcom/motorola/camera/custom/LookFilterEngine;

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;->f$1:I

    return-void
.end method


# virtual methods
.method public final processStrip([IIII)V
    .locals 6

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;->f$0:Lcom/motorola/camera/custom/LookFilterEngine;

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda5;->f$1:I

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$applyLook$2(Lcom/motorola/camera/custom/LookFilterEngine;I[IIII)V

    return-void
.end method
