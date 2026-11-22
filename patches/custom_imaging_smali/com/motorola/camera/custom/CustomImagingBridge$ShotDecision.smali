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
.field final resolved:[I

.field final summary:Ljava/lang/String;


# direct methods
.method constructor <init>([ILjava/lang/String;)V
    .locals 0

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 119
    iput-object p1, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->resolved:[I

    .line 120
    iput-object p2, p0, Lcom/motorola/camera/custom/CustomImagingBridge$ShotDecision;->summary:Ljava/lang/String;

    .line 121
    return-void
.end method
