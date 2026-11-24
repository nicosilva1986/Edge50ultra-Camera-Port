.class public final synthetic Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$StripPixelProcessor;


# instance fields
.field public final synthetic f$0:Lcom/motorola/camera/custom/LookOptics;


# direct methods
.method public synthetic constructor <init>(Lcom/motorola/camera/custom/LookOptics;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;->f$0:Lcom/motorola/camera/custom/LookOptics;

    return-void
.end method


# virtual methods
.method public final processStrip([IIII)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$$ExternalSyntheticLambda6;->f$0:Lcom/motorola/camera/custom/LookOptics;

    invoke-static {v0, p1, p2, p3, p4}, Lcom/motorola/camera/custom/CustomImagingBridge;->lambda$applyLook$3(Lcom/motorola/camera/custom/LookOptics;[IIII)V

    return-void
.end method
