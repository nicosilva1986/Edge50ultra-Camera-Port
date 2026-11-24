.class Lcom/motorola/camera/custom/CustomImagingBridge$3;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"

# interfaces
.implements Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/motorola/camera/custom/CustomImagingBridge;->arraySurface([II)Lcom/motorola/camera/custom/CustomImagingBridge$PixelSurface;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$pixels:[I

.field final synthetic val$width:I


# direct methods
.method constructor <init>([II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1195
    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$pixels:[I

    iput p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$width:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public readRows(II[II)V
    .locals 2

    .line 1197
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$pixels:[I

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$width:I

    mul-int/2addr p1, v1

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$width:I

    mul-int/2addr p2, v1

    invoke-static {v0, p1, p3, p4, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1198
    return-void
.end method

.method public writeRows(II[II)V
    .locals 2

    .line 1200
    iget-object v0, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$pixels:[I

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$width:I

    mul-int/2addr p1, v1

    iget v1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$3;->val$width:I

    mul-int/2addr p2, v1

    invoke-static {p3, p4, v0, p1, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1201
    return-void
.end method
