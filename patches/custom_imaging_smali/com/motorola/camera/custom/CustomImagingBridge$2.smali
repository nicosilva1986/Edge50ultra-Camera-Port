.class Lcom/motorola/camera/custom/CustomImagingBridge$2;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/motorola/camera/custom/CustomImagingBridge;->applyCustomLutIfEnabled(Lcom/motorola/camera/saving/SaveImageService$ImageContainer;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$bmp:Landroid/graphics/Bitmap;

.field final synthetic val$w:I


# direct methods
.method constructor <init>(Landroid/graphics/Bitmap;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 616
    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$bmp:Landroid/graphics/Bitmap;

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$w:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public readRows(II[II)V
    .locals 8

    .line 619
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$bmp:Landroid/graphics/Bitmap;

    iget v3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$w:I

    const/4 v4, 0x0

    iget v6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$w:I

    move v5, p1

    move v7, p2

    move-object v1, p3

    move v2, p4

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 620
    return-void
.end method

.method public writeRows(II[II)V
    .locals 8

    .line 624
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$bmp:Landroid/graphics/Bitmap;

    iget v3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$w:I

    const/4 v4, 0x0

    iget v6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$2;->val$w:I

    move v5, p1

    move v7, p2

    move-object v1, p3

    move v2, p4

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Bitmap;->setPixels([IIIIIII)V

    .line 625
    return-void
.end method
