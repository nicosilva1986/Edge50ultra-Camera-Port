.class public final synthetic Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# instance fields
.field public final synthetic f$0:[Z

.field public final synthetic f$1:[Z

.field public final synthetic f$2:Ljava/lang/Runnable;


# direct methods
.method public synthetic constructor <init>([Z[ZLjava/lang/Runnable;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$0:[Z

    iput-object p2, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$1:[Z

    iput-object p3, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$2:Ljava/lang/Runnable;

    return-void
.end method


# virtual methods
.method public final onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$0:[Z

    iget-object v1, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$1:[Z

    iget-object v2, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;->f$2:Ljava/lang/Runnable;

    invoke-static {v0, v1, v2, p1, p2}, Lcom/motorola/camera/custom/EffectsUiController;->lambda$show$5([Z[ZLjava/lang/Runnable;Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
