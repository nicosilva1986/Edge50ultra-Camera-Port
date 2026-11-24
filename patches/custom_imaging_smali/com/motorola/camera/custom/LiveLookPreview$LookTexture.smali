.class final Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;
.super Ljava/lang/Object;
.source "LiveLookPreview.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/LiveLookPreview;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LookTexture"
.end annotation


# instance fields
.field final id:I

.field final pixels:Ljava/nio/ByteBuffer;


# direct methods
.method constructor <init>(ILjava/nio/ByteBuffer;)V
    .locals 0

    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 117
    iput p1, p0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->id:I

    .line 118
    iput-object p2, p0, Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;->pixels:Ljava/nio/ByteBuffer;

    .line 119
    return-void
.end method
