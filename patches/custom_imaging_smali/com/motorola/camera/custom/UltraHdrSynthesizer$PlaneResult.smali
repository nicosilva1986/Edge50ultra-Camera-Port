.class public final Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;
.super Ljava/lang/Object;
.source "UltraHdrSynthesizer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/UltraHdrSynthesizer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "PlaneResult"
.end annotation


# instance fields
.field public final epsilonHdr:F

.field public final epsilonSdr:F

.field public final gainBytes:[B

.field public final gamma:F

.field public final height:I

.field public final ratioMax:F

.field public final ratioMin:F

.field public final width:I


# direct methods
.method constructor <init>([BIIFFFFF)V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object p1, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gainBytes:[B

    .line 47
    iput p2, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->width:I

    .line 48
    iput p3, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->height:I

    .line 49
    iput p4, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMin:F

    .line 50
    iput p5, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->ratioMax:F

    .line 51
    iput p6, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->gamma:F

    .line 52
    iput p7, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonSdr:F

    .line 53
    iput p8, p0, Lcom/motorola/camera/custom/UltraHdrSynthesizer$PlaneResult;->epsilonHdr:F

    .line 54
    return-void
.end method
