.class final Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;
.super Ljava/lang/Object;
.source "CustomImagingBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CustomImagingBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "ShotDecision"
.end annotation


# instance fields
.field final lux:F

.field final profile:I

.field final resolved:[I

.field final summary:Ljava/lang/String;

.field final zoom:F


# direct methods
.method constructor <init>([ILjava/lang/String;IFF)V
    .locals 0

    .line 125
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 126
    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 127
    iput-object p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 128
    iput p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    .line 129
    iput p4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    .line 130
    iput p5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    .line 131
    return-void
.end method
