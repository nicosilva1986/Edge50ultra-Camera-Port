.class final Lcom/motorola/camera/custom/CompassHudController$Sdk;
.super Ljava/lang/Object;
.source "CompassHudController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassHudController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Sdk"
.end annotation


# static fields
.field static final ADD_LAYOUT:Ljava/lang/reflect/Method;

.field static final ANIMATE:Ljava/lang/reflect/Method;

.field static final ANIMATE_TO:Ljava/lang/reflect/Method;

.field static final ANIMATOR:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final DURATION:Ljava/lang/reflect/Method;

.field static final FONT_FEATURES:Ljava/lang/reflect/Method;

.field static final IS_SHOWN:Ljava/lang/reflect/Method;

.field static final LAYOUT_EVENT:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final MAX_WIDTH:Ljava/lang/reflect/Method;

.field static final OBSERVER:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final RECT:Ljava/lang/reflect/Method;

.field static final REMOVE_LAYOUT:Ljava/lang/reflect/Method;

.field static final ROTATION:Ljava/lang/reflect/Method;

.field static final TREE:Ljava/lang/reflect/Method;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 536
    const-class v0, Landroid/view/View;

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/Class;

    const-class v3, Landroid/graphics/Rect;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, "getGlobalVisibleRect"

    invoke-static {v0, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->RECT:Ljava/lang/reflect/Method;

    .line 537
    const-class v0, Landroid/view/View;

    const-string v2, "isShown"

    new-array v3, v4, [Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->IS_SHOWN:Ljava/lang/reflect/Method;

    .line 538
    const-class v0, Landroid/widget/TextView;

    new-array v2, v1, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    aput-object v3, v2, v4

    const-string v3, "setFontFeatureSettings"

    invoke-static {v0, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->FONT_FEATURES:Ljava/lang/reflect/Method;

    .line 539
    const-class v0, Landroid/widget/TextView;

    new-array v2, v1, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v4

    const-string v3, "setMaxWidth"

    invoke-static {v0, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->MAX_WIDTH:Ljava/lang/reflect/Method;

    .line 540
    const-class v0, Landroid/view/View;

    const-string v2, "getRotation"

    new-array v3, v4, [Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ROTATION:Ljava/lang/reflect/Method;

    .line 541
    const-class v0, Landroid/view/View;

    const-string v2, "animate"

    new-array v3, v4, [Ljava/lang/Class;

    invoke-static {v0, v2, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE:Ljava/lang/reflect/Method;

    .line 542
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    if-nez v0, :cond_0

    move-object v0, v2

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE:Ljava/lang/reflect/Method;

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v0

    :goto_0
    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATOR:Ljava/lang/Class;

    .line 543
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATOR:Ljava/lang/Class;

    new-array v3, v1, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const-string v5, "rotation"

    invoke-static {v0, v5, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE_TO:Ljava/lang/reflect/Method;

    .line 544
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATOR:Ljava/lang/Class;

    new-array v3, v1, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const-string v5, "setDuration"

    invoke-static {v0, v5, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->DURATION:Ljava/lang/reflect/Method;

    .line 545
    const-class v0, Landroid/view/View;

    const-string v3, "getViewTreeObserver"

    new-array v5, v4, [Ljava/lang/Class;

    invoke-static {v0, v3, v5}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->TREE:Ljava/lang/reflect/Method;

    .line 546
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->TREE:Ljava/lang/reflect/Method;

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->TREE:Ljava/lang/reflect/Method;

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v2

    :goto_1
    sput-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->OBSERVER:Ljava/lang/Class;

    .line 547
    const-string v0, "android.view.ViewTreeObserver$OnGlobalLayoutListener"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->LAYOUT_EVENT:Ljava/lang/Class;

    .line 548
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->OBSERVER:Ljava/lang/Class;

    new-array v2, v1, [Ljava/lang/Class;

    sget-object v3, Lcom/motorola/camera/custom/CompassHudController$Sdk;->LAYOUT_EVENT:Ljava/lang/Class;

    aput-object v3, v2, v4

    const-string v3, "addOnGlobalLayoutListener"

    invoke-static {v0, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ADD_LAYOUT:Ljava/lang/reflect/Method;

    .line 549
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->OBSERVER:Ljava/lang/Class;

    new-array v1, v1, [Ljava/lang/Class;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->LAYOUT_EVENT:Ljava/lang/Class;

    aput-object v2, v1, v4

    const-string v2, "removeOnGlobalLayoutListener"

    invoke-static {v0, v2, v1}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->REMOVE_LAYOUT:Ljava/lang/reflect/Method;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 535
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
