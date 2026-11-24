.class public final synthetic Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/motorola/camera/custom/CompassHudController$Pill;


# direct methods
.method public synthetic constructor <init>(Lcom/motorola/camera/custom/CompassHudController$Pill;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda1;->f$0:Lcom/motorola/camera/custom/CompassHudController$Pill;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda1;->f$0:Lcom/motorola/camera/custom/CompassHudController$Pill;

    invoke-virtual {v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->lambda$observeLayout$1$com-motorola-camera-custom-CompassHudController$Pill()V

    return-void
.end method
