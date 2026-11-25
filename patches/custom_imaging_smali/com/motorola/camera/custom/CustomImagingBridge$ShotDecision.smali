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
.field final bokeh:I

.field final intensity:I

.field final look:I

.field final lookPaused:Z

.field final lux:F

.field final profile:I

.field final resolved:[I

.field final summary:Ljava/lang/String;

.field final zoom:F


# direct methods
.method constructor <init>([ILjava/lang/String;IFFIIIZ)V
    .locals 0

    .line 194
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 195
    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 196
    iput-object p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 197
    iput p3, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->profile:I

    .line 198
    iput p4, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->zoom:F

    .line 199
    iput p5, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lux:F

    .line 200
    iput p6, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->look:I

    .line 201
    iput p7, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->intensity:I

    .line 202
    iput p8, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->bokeh:I

    .line 203
    iput-boolean p9, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->lookPaused:Z

    .line 204
    return-void
.end method
