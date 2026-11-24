.class public final Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;
.super Ljava/lang/Object;
.source "MultiFrameRawEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/MultiFrameRawEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Result"
.end annotation


# instance fields
.field public final acceptedFrames:I

.field public final anchorTimestampNs:J

.field public final blackLevel4:[F

.field public final cfaPattern:I

.field public final headroom:D

.field public final height:I

.field public final raw:[I

.field public final superResolved:Z

.field public final usedGlGuide:Z

.field public final whiteLevel:F

.field public final width:I


# direct methods
.method private constructor <init>([IIILcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IDFZZ)V
    .locals 0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->raw:[I

    .line 61
    iput p2, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->width:I

    .line 62
    iput p3, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->height:I

    .line 63
    iget p1, p4, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->cfa:I

    iput p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->cfaPattern:I

    .line 64
    iget-object p1, p4, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->black:[F

    invoke-virtual {p1}, [F->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [F

    iput-object p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->blackLevel4:[F

    .line 65
    iput p8, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->whiteLevel:F

    .line 66
    iget-wide p1, p4, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;->time:J

    iput-wide p1, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->anchorTimestampNs:J

    .line 67
    iput p5, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->acceptedFrames:I

    .line 68
    iput-wide p6, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->headroom:D

    .line 69
    iput-boolean p9, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->superResolved:Z

    .line 70
    iput-boolean p10, p0, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;->usedGlGuide:Z

    .line 71
    return-void
.end method

.method synthetic constructor <init>([IIILcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IDFZZLcom/motorola/camera/custom/MultiFrameRawEngine-IA;)V
    .locals 0

    invoke-direct/range {p0 .. p10}, Lcom/motorola/camera/custom/MultiFrameRawEngine$Result;-><init>([IIILcom/motorola/camera/custom/MultiFrameRawEngine$Frame;IDFZZ)V

    return-void
.end method
