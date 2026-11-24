.class final Lcom/motorola/camera/custom/CompassHudController$Pill;
.super Landroid/widget/TextView;
.source "CompassHudController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassHudController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Pill"
.end annotation


# instance fields
.field final bounds:Landroid/graphics/Rect;

.field color:I

.field lastText:Ljava/lang/String;

.field layoutListener:Ljava/lang/Object;

.field maximumWidth:I

.field menuListener:Ljava/lang/Object;

.field final root:Landroid/widget/RelativeLayout;

.field final rootBounds:Landroid/graphics/Rect;

.field rotationTarget:I

.field topMargin:I

.field triedSensor:Z

.field visible:Z


# direct methods
.method constructor <init>(Landroid/widget/RelativeLayout;)V
    .locals 4

    .line 387
    invoke-virtual {p1}, Landroid/widget/RelativeLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 379
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rootBounds:Landroid/graphics/Rect;

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    .line 381
    const/4 v0, -0x1

    iput v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->topMargin:I

    iput v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->maximumWidth:I

    const/high16 v0, -0x80000000

    iput v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rotationTarget:I

    .line 384
    const-string v0, ""

    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->lastText:Ljava/lang/String;

    .line 388
    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    .line 389
    const-string p1, "compass-hud-pill"

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setTag(Ljava/lang/Object;)V

    .line 390
    const/16 p1, 0x8

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setVisibility(I)V

    .line 391
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setClickable(Z)V

    .line 392
    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setFocusable(Z)V

    .line 393
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setSingleLine(Z)V

    .line 394
    sget-object v2, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {p0, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 395
    const/high16 v2, 0x41300000    # 11.0f

    invoke-virtual {p0, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setTextSize(F)V

    .line 396
    sget-object v2, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    invoke-virtual {p0, v2, v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 397
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->FONT_FEATURES:Ljava/lang/reflect/Method;

    const-string v3, "tnum"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, p0, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 398
    const/16 v2, 0x11

    invoke-virtual {p0, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setGravity(I)V

    .line 399
    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v2

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result p1

    invoke-virtual {p0, v2, v0, p1, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setPadding(IIII)V

    .line 400
    new-instance p1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {p1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 401
    const v0, -0x1ce4dfd7

    invoke-virtual {p1, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 402
    const/16 v0, 0xe

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p1, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 403
    invoke-virtual {p0, v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    const v1, 0x29ffffff

    invoke-virtual {p1, v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 404
    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 405
    return-void
.end method

.method static synthetic lambda$observeLayout$0()V
    .locals 0

    .line 503
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smreconcile()V

    return-void
.end method

.method static synthetic lambda$observeLayout$2()V
    .locals 0

    .line 518
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smreconcile()V

    return-void
.end method

.method private shown(Landroid/view/View;)Z
    .locals 4

    .line 437
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->IS_SHOWN:Ljava/lang/reflect/Method;

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v2, p1, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method private visibleBounds(Landroid/view/View;)Z
    .locals 3

    .line 481
    invoke-direct {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->RECT:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method


# virtual methods
.method display(Ljava/lang/String;I)V
    .locals 1

    .line 417
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->lastText:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setText(Ljava/lang/CharSequence;)V

    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->lastText:Ljava/lang/String;

    .line 418
    :cond_0
    iget p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->color:I

    if-eq p1, p2, :cond_1

    invoke-virtual {p0, p2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setTextColor(I)V

    iput p2, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->color:I

    .line 419
    :cond_1
    iget-boolean p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->visible:Z

    if-nez p1, :cond_2

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->visible:Z

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setVisibility(I)V

    .line 420
    :cond_2
    return-void
.end method

.method dp(I)I
    .locals 1

    .line 407
    int-to-float p1, p1

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method hide()V
    .locals 1

    .line 410
    iget-boolean v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->visible:Z

    if-eqz v0, :cond_0

    .line 411
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->visible:Z

    .line 412
    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setVisibility(I)V

    .line 414
    :cond_0
    return-void
.end method

.method synthetic lambda$observeLayout$1$com-motorola-camera-custom-CompassHudController$Pill()V
    .locals 2

    .line 503
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    new-instance v1, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda0;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method observeLayout(Z)V
    .locals 6

    .line 501
    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz p1, :cond_0

    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    if-nez v3, :cond_0

    sget-object v3, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->CHANGE:Ljava/lang/Class;

    if-eqz v3, :cond_0

    .line 503
    sget-object v3, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->CHANGE:Ljava/lang/Class;

    new-instance v4, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda1;

    invoke-direct {v4, p0}, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda1;-><init>(Lcom/motorola/camera/custom/CompassHudController$Pill;)V

    const-string v5, "onChange"

    invoke-static {v3, v5, v4}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smlistener(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v3

    iput-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    .line 504
    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    invoke-static {v3, v1}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->observeMenus(Ljava/lang/Object;Z)V

    goto :goto_0

    .line 505
    :cond_0
    if-nez p1, :cond_1

    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    if-eqz v3, :cond_1

    .line 506
    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    invoke-static {v3, v2}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->observeMenus(Ljava/lang/Object;Z)V

    .line 507
    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->menuListener:Ljava/lang/Object;

    .line 509
    :cond_1
    :goto_0
    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->layoutListener:Ljava/lang/Object;

    if-eqz v3, :cond_2

    goto :goto_1

    :cond_2
    move v1, v2

    :goto_1
    if-eq p1, v1, :cond_6

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->LAYOUT_EVENT:Ljava/lang/Class;

    if-nez v1, :cond_3

    goto :goto_2

    .line 510
    :cond_3
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->TREE:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 511
    if-nez v1, :cond_4

    return-void

    .line 512
    :cond_4
    if-nez p1, :cond_5

    .line 513
    sget-object p1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->REMOVE_LAYOUT:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->layoutListener:Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {p1, v1, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 514
    iput-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->layoutListener:Ljava/lang/Object;

    .line 515
    return-void

    .line 518
    :cond_5
    sget-object p1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->LAYOUT_EVENT:Ljava/lang/Class;

    new-instance v0, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lcom/motorola/camera/custom/CompassHudController$Pill$$ExternalSyntheticLambda2;-><init>()V

    const-string v2, "onGlobalLayout"

    invoke-static {p1, v2, v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smlistener(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->layoutListener:Ljava/lang/Object;

    .line 519
    sget-object p1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ADD_LAYOUT:Ljava/lang/reflect/Method;

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->layoutListener:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 520
    return-void

    .line 509
    :cond_6
    :goto_2
    return-void
.end method

.method panelShown()Z
    .locals 2

    .line 431
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->EFFECTS:Ljava/lang/Class;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->EFFECTS:Ljava/lang/Class;

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_2

    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    .line 432
    const v1, 0x7f0a0102

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    .line 433
    const v1, 0x7f0a03ca

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    .line 431
    :goto_1
    return v0
.end method

.method place()Z
    .locals 12

    .line 441
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getWidth()I

    move-result v1

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v2

    const/16 v0, 0x1c

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v4

    .line 443
    const/16 v3, 0x7c

    invoke-virtual {p0, v3}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v3

    if-le v1, v2, :cond_0

    const/16 v5, 0x84

    goto :goto_0

    :cond_0
    const/16 v5, 0xd2

    :goto_0
    invoke-virtual {p0, v5}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v5

    sub-int v5, v2, v5

    .line 444
    sget-object v6, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v7, Lcom/motorola/camera/custom/CompassHudController$Sdk;->RECT:Ljava/lang/reflect/Method;

    iget-object v8, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    iget-object v9, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rootBounds:Landroid/graphics/Rect;

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v7, v8, v9}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 445
    iget-object v6, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const-string v7, "effects-hdr-badge"

    invoke-virtual {v6, v7}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v6

    .line 446
    invoke-direct {p0, v6}, Lcom/motorola/camera/custom/CompassHudController$Pill;->visibleBounds(Landroid/view/View;)Z

    move-result v7

    const/4 v8, 0x4

    if-eqz v7, :cond_1

    .line 447
    invoke-virtual {v6}, Landroid/view/View;->getWidth()I

    move-result v7

    int-to-double v9, v7

    invoke-virtual {v6}, Landroid/view/View;->getHeight()I

    move-result v6

    int-to-double v6, v6

    invoke-static {v9, v10, v6, v7}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v6

    const-wide/high16 v9, 0x3fe0000000000000L    # 0.5

    mul-double/2addr v6, v9

    invoke-static {v6, v7}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v6

    double-to-int v6, v6

    .line 448
    iget-object v7, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->bottom:I

    iget-object v9, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    invoke-virtual {v9}, Landroid/graphics/Rect;->centerY()I

    move-result v9

    add-int/2addr v9, v6

    invoke-static {v7, v9}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 449
    iget-object v7, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rootBounds:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->top:I

    sub-int/2addr v6, v7

    invoke-virtual {p0, v8}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v7

    add-int/2addr v6, v7

    invoke-static {v3, v6}, Ljava/lang/Math;->max(II)I

    move-result v3

    .line 451
    :cond_1
    iget-object v6, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const v7, 0x7f0a00bf

    invoke-virtual {v6, v7}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v6

    .line 452
    invoke-direct {p0, v6}, Lcom/motorola/camera/custom/CompassHudController$Pill;->visibleBounds(Landroid/view/View;)Z

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->top:I

    iget-object v7, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rootBounds:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->top:I

    sub-int/2addr v6, v7

    const/16 v7, 0x36

    invoke-virtual {p0, v7}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v7

    sub-int/2addr v6, v7

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 454
    :cond_2
    iget-object v6, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const v7, 0x7f0a020f

    invoke-virtual {v6, v7}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v6

    .line 455
    if-eqz v6, :cond_3

    invoke-virtual {v6}, Landroid/view/View;->getTop()I

    move-result v7

    if-lez v7, :cond_3

    invoke-virtual {v6}, Landroid/view/View;->getTop()I

    move-result v6

    invoke-virtual {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v0

    sub-int/2addr v6, v0

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v0

    move v5, v0

    .line 456
    :cond_3
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const v6, 0x7f0a050b

    invoke-virtual {v0, v6}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 457
    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->visibleBounds(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->bounds:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    iget-object v6, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rootBounds:Landroid/graphics/Rect;

    iget v6, v6, Landroid/graphics/Rect;->top:I

    sub-int/2addr v0, v6

    invoke-virtual {p0, v8}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v6

    sub-int/2addr v0, v6

    invoke-static {v5, v0}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 460
    :cond_4
    sub-int v0, v5, v3

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    add-int/lit8 v0, v0, -0x2

    .line 461
    const/4 v7, 0x0

    if-gt v0, v4, :cond_5

    return v7

    .line 462
    :cond_5
    const/16 v6, 0xa4

    invoke-virtual {p0, v6}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v6

    int-to-double v8, v0

    mul-double/2addr v8, v8

    int-to-double v10, v4

    mul-double/2addr v10, v10

    sub-double/2addr v8, v10

    invoke-static {v8, v9}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v8

    double-to-int v0, v8

    invoke-static {v6, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 463
    const/16 v6, 0x3c

    invoke-virtual {p0, v6}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v6

    if-ge v0, v6, :cond_6

    return v7

    .line 464
    :cond_6
    const/4 v8, 0x1

    add-int/2addr v3, v8

    add-int/lit8 v6, v5, -0x1

    move v5, v3

    move v3, v0

    invoke-static/range {v1 .. v6}, Lcom/motorola/camera/custom/CompassHudController;->safeCenterY(IIIIII)I

    move-result v0

    .line 465
    if-gez v0, :cond_7

    return v7

    .line 466
    :cond_7
    div-int/lit8 v1, v4, 0x2

    sub-int/2addr v0, v1

    .line 467
    iget v1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->topMargin:I

    if-ne v0, v1, :cond_8

    iget v1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->maximumWidth:I

    if-eq v3, v1, :cond_a

    .line 468
    :cond_8
    iput v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->topMargin:I

    .line 469
    iput v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->maximumWidth:I

    .line 470
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Sdk;->MAX_WIDTH:Ljava/lang/reflect/Method;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, p0, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 471
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->MAX_WIDTH:Ljava/lang/reflect/Method;

    if-nez v2, :cond_9

    move v2, v3

    goto :goto_1

    :cond_9
    const/4 v2, -0x2

    :goto_1
    invoke-direct {v1, v2, v4}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 472
    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 473
    const/16 v2, 0xe

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 474
    invoke-virtual {v1, v7, v0, v7, v7}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 475
    invoke-virtual {p0, v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 477
    :cond_a
    return v8
.end method

.method previewShown()Z
    .locals 5

    .line 423
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->IS_SHOWN:Ljava/lang/reflect/Method;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    .line 424
    :cond_0
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_1

    return v2

    .line 425
    :cond_1
    iget-object v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const v3, 0x7f0a0349

    invoke-virtual {v0, v3}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 426
    iget-object v3, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    const v4, 0x7f0a034a

    invoke-virtual {v3, v4}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v3

    .line 427
    if-nez v0, :cond_2

    if-eqz v3, :cond_4

    :cond_2
    invoke-direct {p0, v0}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-direct {p0, v3}, Lcom/motorola/camera/custom/CompassHudController$Pill;->shown(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_0

    :cond_3
    move v1, v2

    :cond_4
    :goto_0
    return v1
.end method

.method rotateTo(I)V
    .locals 5

    .line 485
    iget v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rotationTarget:I

    if-ne p1, v0, :cond_0

    return-void

    .line 486
    :cond_0
    iget-boolean v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->visible:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rotationTarget:I

    const/high16 v2, -0x80000000

    if-eq v0, v2, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    .line 487
    :goto_0
    iput p1, p0, Lcom/motorola/camera/custom/CompassHudController$Pill;->rotationTarget:I

    .line 488
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ROTATION:Ljava/lang/reflect/Method;

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v2, p0, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 489
    if-eqz v0, :cond_2

    instance-of v0, v2, Ljava/lang/Number;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE_TO:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_2

    .line 490
    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->floatValue()F

    move-result v0

    .line 491
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE:Ljava/lang/reflect/Method;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, p0, v1}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 492
    if-eqz v1, :cond_2

    .line 493
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->DURATION:Ljava/lang/reflect/Method;

    const-wide/16 v3, 0xa0

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v1, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 494
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Sdk;->ANIMATE_TO:Ljava/lang/reflect/Method;

    invoke-static {v0, p1}, Lcom/motorola/camera/custom/CompassHudController;->rotationDestination(FI)F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, v1, v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_2

    return-void

    .line 497
    :cond_2
    int-to-float p1, p1

    invoke-virtual {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->setRotation(F)V

    .line 498
    return-void
.end method
