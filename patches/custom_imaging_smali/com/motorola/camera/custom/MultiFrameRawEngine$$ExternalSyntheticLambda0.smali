.class public final synthetic Lcom/motorola/camera/custom/MultiFrameRawEngine$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/Comparator;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 0
    check-cast p1, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    check-cast p2, Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;

    invoke-static {p1, p2}, Lcom/motorola/camera/custom/MultiFrameRawEngine;->lambda$anchor$0(Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;Lcom/motorola/camera/custom/MultiFrameRawEngine$Frame;)I

    move-result p1

    return p1
.end method
