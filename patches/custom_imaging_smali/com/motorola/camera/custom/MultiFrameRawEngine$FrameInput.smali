.class public final Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FrameInput"
.end annotation


# instance fields
.field public final blackLevel4:[F

.field public final cfaPattern:I

.field public final exposureNs:J

.field public final focalLengthPx:F

.field public final gyroExcursionRad:F

.field public final height:I

.field public final iso:I

.field public final raw:[I

.field public final timestampNs:J

.field public final whiteLevel:F

.field public final width:I


# direct methods
.method public constructor <init>([IIII[FFJJIFF)V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->raw:[I

    .line 34
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->width:I

    .line 35
    iput p3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->height:I

    .line 36
    iput p4, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->cfaPattern:I

    .line 37
    iput-object p5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->blackLevel4:[F

    .line 38
    iput p6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->whiteLevel:F

    .line 39
    iput-wide p7, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->timestampNs:J

    .line 40
    iput-wide p9, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->exposureNs:J

    .line 41
    iput p11, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->iso:I

    .line 42
    iput p12, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->gyroExcursionRad:F

    .line 43
    iput p13, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$FrameInput;->focalLengthPx:F

    .line 44
    return-void
.end method
