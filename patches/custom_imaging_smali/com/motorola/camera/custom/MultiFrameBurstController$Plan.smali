.class public final Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;
.super Ljava/lang/Object;
.source "MultiFrameBurstController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameBurstController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Plan"
.end annotation


# instance fields
.field public final anchorSeqId:J

.field public final captureMode:I

.field public final evOffsets:[F

.field public final fallbackReason:Ljava/lang/String;

.field public final focusDistances:[F

.field public final frameCount:I

.field public final singleRaw:Z


# direct methods
.method constructor <init>(II[F[FJLjava/lang/String;Z)V
    .locals 0

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->captureMode:I

    .line 63
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->frameCount:I

    .line 64
    iput-object p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->evOffsets:[F

    .line 65
    iput-object p4, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->focusDistances:[F

    .line 66
    iput-wide p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->anchorSeqId:J

    .line 67
    iput-object p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->fallbackReason:Ljava/lang/String;

    .line 68
    iput-boolean p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->singleRaw:Z

    .line 69
    return-void
.end method
