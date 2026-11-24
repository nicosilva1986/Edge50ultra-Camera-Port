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

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->captureMode:I

    .line 56
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->frameCount:I

    .line 57
    iput-object p3, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->evOffsets:[F

    .line 58
    iput-object p4, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->focusDistances:[F

    .line 59
    iput-wide p5, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->anchorSeqId:J

    .line 60
    iput-object p7, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->fallbackReason:Ljava/lang/String;

    .line 61
    iput-boolean p8, p0, Lcom/motorola/camera/custom/MultiFrameBurstController$Plan;->singleRaw:Z

    .line 62
    return-void
.end method
