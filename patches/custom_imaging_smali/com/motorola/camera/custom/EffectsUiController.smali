.class public final Lcom/motorola/camera/custom/EffectsUiController;
.super Ljava/lang/Object;
.source "EffectsUiController.java"


# static fields
.field private static final BOKEH:[Ljava/lang/String;

.field private static final BOKEH_BADGES:[Ljava/lang/String;

.field private static final BORDER_SUBTLE:I = 0x29ffffff

.field private static final CATEGORY_FALLBACKS:[Ljava/lang/String;

.field private static final CATEGORY_KEYS:[Ljava/lang/String;

.field private static final HDR_BADGE:Ljava/lang/String; = "effects-hdr-badge"

.field private static final LOOKS:[Ljava/lang/String;

.field private static final LOOK_BADGES:[Ljava/lang/String;

.field private static final RIPPLE_LIGHT:I = 0x38ffffff

.field private static final SURFACE_CARD:I = -0xd9d5ce

.field private static final SURFACE_GLASS:I = -0x1ce4dfd7

.field private static final SURFACE_PILL:I = -0xcfcbc5

.field private static final TEXT_DARK_INK:I = -0xeeece8

.field private static final TEXT_PRIMARY:I = -0xe0f0c

.field private static final TEXT_SECONDARY:I = -0x470e0f0c

.field private static final TEXT_WARN:I = -0x3380

.field private static activeCategory:I

.field private static hostActivity:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field

.field private static orientation:I

.field private static root:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/widget/RelativeLayout;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static bridge synthetic -$$Nest$sfgetactiveCategory()I
    .locals 1

    sget v0, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    return v0
.end method

.method static bridge synthetic -$$Nest$smbuildCategories(Landroid/content/Context;Landroid/widget/LinearLayout;ILjava/lang/Runnable;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/motorola/camera/custom/EffectsUiController;->buildCategories(Landroid/content/Context;Landroid/widget/LinearLayout;ILjava/lang/Runnable;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smformatIntensity(Landroid/content/Context;I)Ljava/lang/String;
    .locals 0

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/EffectsUiController;->formatIntensity(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smpopulate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V
    .locals 0

    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/EffectsUiController;->populate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smstore(Landroid/content/SharedPreferences;Ljava/lang/String;I)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/EffectsUiController;->store(Landroid/content/SharedPreferences;Ljava/lang/String;I)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smupdateStatus(Landroid/content/Context;Landroid/widget/TextView;I)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/EffectsUiController;->updateStatus(Landroid/content/Context;Landroid/widget/TextView;I)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 17

    .line 30
    const/16 v0, 0xe

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "Original"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "Leica Authentic"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "Leica Vibrant"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "Leica B&W HC"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-string v2, "Zeiss Natural"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    const-string v2, "Zeiss T* Textured"

    const/4 v8, 0x5

    aput-object v2, v1, v8

    const-string v2, "Google HDR+"

    const/4 v9, 0x6

    aput-object v2, v1, v9

    const-string v2, "Black Pro-Mist 1/4"

    const/4 v10, 0x7

    aput-object v2, v1, v10

    const-string v2, "CineStill 800T"

    const/16 v11, 0x8

    aput-object v2, v1, v11

    const-string v2, "Fujifilm Classic Chrome"

    const/16 v12, 0x9

    aput-object v2, v1, v12

    const-string v2, "Fujifilm Nostalgic Neg."

    const/16 v13, 0xa

    aput-object v2, v1, v13

    const-string v2, "Kodak Portra 400"

    const/16 v14, 0xb

    aput-object v2, v1, v14

    const-string v2, "Ricoh GR Positive"

    const/16 v15, 0xc

    aput-object v2, v1, v15

    const-string v2, "2000s Y2K CCD"

    const/16 v16, 0xd

    aput-object v2, v1, v16

    sput-object v1, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    .line 36
    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "port_logo_none"

    aput-object v1, v0, v3

    const-string v1, "port_logo_leica"

    aput-object v1, v0, v4

    aput-object v1, v0, v5

    aput-object v1, v0, v6

    const-string v1, "port_logo_zeiss"

    aput-object v1, v0, v7

    aput-object v1, v0, v8

    const-string v1, "port_logo_google"

    aput-object v1, v0, v9

    const-string v1, "port_logo_promist"

    aput-object v1, v0, v10

    const-string v1, "port_logo_cinestill"

    aput-object v1, v0, v11

    const-string v1, "port_logo_fujifilm"

    aput-object v1, v0, v12

    aput-object v1, v0, v13

    const-string v1, "port_logo_kodak"

    aput-object v1, v0, v14

    const-string v1, "port_logo_ricoh"

    aput-object v1, v0, v15

    const-string v1, "port_logo_ccd"

    aput-object v1, v0, v16

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->LOOK_BADGES:[Ljava/lang/String;

    .line 42
    new-array v0, v8, [Ljava/lang/String;

    const-string v1, "port_cat_all"

    aput-object v1, v0, v3

    const-string v1, "port_cat_optical"

    aput-object v1, v0, v4

    const-string v1, "port_cat_hdr"

    aput-object v1, v0, v5

    const-string v1, "port_cat_film"

    aput-object v1, v0, v6

    const-string v1, "port_cat_bokeh"

    aput-object v1, v0, v7

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_KEYS:[Ljava/lang/String;

    .line 45
    new-array v0, v8, [Ljava/lang/String;

    const-string v1, "All"

    aput-object v1, v0, v3

    const-string v1, "Optical"

    aput-object v1, v0, v4

    const-string v1, "HDR+"

    aput-object v1, v0, v5

    const-string v1, "Film"

    aput-object v1, v0, v6

    const-string v1, "Bokeh"

    aput-object v1, v0, v7

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_FALLBACKS:[Ljava/lang/String;

    .line 48
    new-array v0, v9, [Ljava/lang/String;

    const-string v1, "Stock"

    aput-object v1, v0, v3

    const-string v1, "Biotar Swirl"

    aput-object v1, v0, v4

    const-string v1, "Planar"

    aput-object v1, v0, v5

    const-string v1, "Sonnar Creamy"

    aput-object v1, v0, v6

    const-string v1, "Anamorphic Oval"

    aput-object v1, v0, v7

    const-string v1, "Triangular B-Speed"

    aput-object v1, v0, v8

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH:[Ljava/lang/String;

    .line 51
    new-array v0, v9, [Ljava/lang/String;

    const-string v1, "port_logo_bokeh"

    aput-object v1, v0, v3

    const-string v1, "port_logo_bokeh_biotar"

    aput-object v1, v0, v4

    const-string v1, "port_logo_bokeh_planar"

    aput-object v1, v0, v5

    const-string v1, "port_logo_bokeh_sonnar"

    aput-object v1, v0, v6

    const-string v1, "port_logo_bokeh_anamorphic"

    aput-object v1, v0, v7

    const-string v1, "port_logo_bokeh_bspeed"

    aput-object v1, v0, v8

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH_BADGES:[Ljava/lang/String;

    .line 68
    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->hostActivity:Ljava/lang/ref/WeakReference;

    .line 69
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->root:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static attach(Landroid/app/Activity;)V
    .locals 2

    .line 74
    if-eqz p0, :cond_0

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/motorola/camera/custom/EffectsUiController;->hostActivity:Ljava/lang/ref/WeakReference;

    .line 75
    :cond_0
    if-eqz p0, :cond_1

    const v0, 0x7f0a0283

    invoke-virtual {p0, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 76
    :goto_0
    instance-of v1, v0, Landroid/widget/RelativeLayout;

    if-eqz v1, :cond_2

    new-instance v1, Ljava/lang/ref/WeakReference;

    check-cast v0, Landroid/widget/RelativeLayout;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/motorola/camera/custom/EffectsUiController;->root:Ljava/lang/ref/WeakReference;

    .line 77
    :cond_2
    invoke-static {p0}, Lcom/motorola/camera/custom/CompassHudController;->attach(Landroid/app/Activity;)V

    .line 78
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->refreshPreview()V

    .line 79
    return-void
.end method

.method private static buildCategories(Landroid/content/Context;Landroid/widget/LinearLayout;ILjava/lang/Runnable;)V
    .locals 11

    .line 335
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 336
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v0

    .line 337
    const/16 v1, 0x22

    invoke-static {p1, v1}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v1

    .line 338
    const/16 v2, 0xe

    invoke-static {p1, v2}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    .line 339
    const/4 v3, 0x6

    invoke-static {p1, v3}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v3

    .line 340
    const/4 v4, 0x0

    move v5, v4

    :goto_0
    sget-object v6, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_KEYS:[Ljava/lang/String;

    array-length v6, v6

    if-ge v5, v6, :cond_4

    .line 341
    const/4 v6, 0x4

    if-ne v5, v6, :cond_0

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 342
    :cond_0
    nop

    .line 343
    sget v6, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    const/4 v7, 0x1

    if-ne v5, v6, :cond_1

    move v6, v7

    goto :goto_1

    :cond_1
    move v6, v4

    .line 344
    :goto_1
    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 345
    sget-object v9, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_KEYS:[Ljava/lang/String;

    aget-object v9, v9, v5

    sget-object v10, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_FALLBACKS:[Ljava/lang/String;

    aget-object v10, v10, v5

    invoke-static {p0, v9, v10}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 346
    const/high16 v9, 0x41480000    # 12.5f

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 347
    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 348
    const/16 v9, 0x11

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setGravity(I)V

    .line 349
    invoke-virtual {v8, v1}, Landroid/widget/TextView;->setMinimumHeight(I)V

    .line 350
    invoke-virtual {v8, v2, v4, v2, v4}, Landroid/widget/TextView;->setPaddingRelative(IIII)V

    .line 351
    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setClickable(Z)V

    .line 352
    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setFocusable(Z)V

    .line 353
    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setSelected(Z)V

    .line 354
    if-eqz v6, :cond_2

    .line 355
    const v6, -0xeeece8

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 356
    sget-object v6, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    invoke-virtual {v8, v6, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 357
    invoke-static {p2, v1, v4, v4}, Lcom/motorola/camera/custom/EffectsUiController;->pillRipple(IIII)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_2

    .line 359
    :cond_2
    const v6, -0xe0f0c

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 360
    sget-object v6, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    invoke-virtual {v8, v6, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 361
    invoke-static {p1, v7}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v6

    const v9, 0x29ffffff

    const v10, -0xcfcbc5

    invoke-static {v10, v1, v6, v9}, Lcom/motorola/camera/custom/EffectsUiController;->pillRipple(IIII)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 363
    :goto_2
    new-instance v6, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda1;

    invoke-direct {v6, v5, p3}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda1;-><init>(ILjava/lang/Runnable;)V

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 368
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x2

    invoke-direct {v6, v9, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 369
    sget-object v9, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_KEYS:[Ljava/lang/String;

    array-length v9, v9

    sub-int/2addr v9, v7

    if-ge v5, v9, :cond_3

    invoke-virtual {v6, v4, v4, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 370
    :cond_3
    invoke-virtual {p1, v8, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 340
    :goto_3
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_0

    .line 372
    :cond_4
    return-void
.end method

.method private static computeBottomMargin(Landroid/widget/RelativeLayout;)I
    .locals 13

    .line 546
    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    .line 547
    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    if-ne v0, v1, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v3

    .line 548
    :goto_0
    const/16 v4, 0x84

    if-eqz v0, :cond_1

    move v5, v4

    goto :goto_1

    :cond_1
    const/16 v5, 0xd2

    :goto_1
    invoke-static {p0, v5}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v5

    .line 549
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isProPhotoMode()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 550
    if-eqz v0, :cond_2

    const/16 v0, 0xb4

    goto :goto_2

    :cond_2
    const/16 v0, 0x195

    :goto_2
    invoke-static {p0, v0}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v0

    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 552
    :cond_3
    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 553
    if-eqz v0, :cond_b

    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v6

    if-lez v6, :cond_b

    .line 554
    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v6

    .line 555
    sget-object v7, Lcom/motorola/camera/custom/EffectsUiController;->hostActivity:Ljava/lang/ref/WeakReference;

    invoke-virtual {v7}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/app/Activity;

    .line 556
    const-string v8, "capture_bar_layout"

    const-string v9, "id"

    invoke-virtual {v0, v8, v9, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 557
    const/4 v10, 0x0

    if-eqz v8, :cond_4

    invoke-virtual {p0, v8}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v11

    goto :goto_3

    :cond_4
    move-object v11, v10

    .line 558
    :goto_3
    if-nez v11, :cond_5

    if-eqz v7, :cond_5

    if-eqz v8, :cond_5

    invoke-virtual {v7, v8}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v11

    .line 559
    :cond_5
    if-eqz v11, :cond_6

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v8

    if-lez v8, :cond_6

    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v8

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v12

    if-le v8, v12, :cond_6

    .line 560
    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v8

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v11

    sub-int/2addr v8, v11

    const/16 v11, 0x36

    invoke-static {p0, v11}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v11

    add-int/2addr v8, v11

    .line 561
    const/16 v11, 0xfa

    invoke-static {p0, v11}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v11

    invoke-static {v11, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    invoke-static {v5, v8}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 563
    :cond_6
    new-array v8, v1, [Ljava/lang/String;

    const-string v11, "pro_mode_slider_bar_layout"

    aput-object v11, v8, v3

    const-string v11, "portrait_bokeh_slider_bar_layout"

    aput-object v11, v8, v2

    :goto_4
    if-ge v3, v1, :cond_a

    aget-object v2, v8, v3

    .line 564
    invoke-virtual {v0, v2, v9, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 565
    if-eqz v2, :cond_7

    invoke-virtual {p0, v2}, Landroid/widget/RelativeLayout;->findViewById(I)Landroid/view/View;

    move-result-object v11

    goto :goto_5

    :cond_7
    move-object v11, v10

    .line 566
    :goto_5
    if-nez v11, :cond_8

    if-eqz v7, :cond_8

    if-eqz v2, :cond_8

    invoke-virtual {v7, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v11

    .line 567
    :cond_8
    if-eqz v11, :cond_9

    invoke-virtual {v11}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-nez v2, :cond_9

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v2

    if-lez v2, :cond_9

    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v2

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v12

    if-le v2, v12, :cond_9

    .line 568
    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v2

    invoke-virtual {v11}, Landroid/view/View;->getTop()I

    move-result v11

    sub-int/2addr v2, v11

    const/16 v11, 0xc

    invoke-static {p0, v11}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v11

    add-int/2addr v2, v11

    invoke-static {v5, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    move v5, v2

    .line 563
    :cond_9
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 571
    :cond_a
    invoke-static {p0, v4}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v0

    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v1

    const/16 v2, 0x140

    invoke-static {p0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result p0

    sub-int/2addr v1, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result p0

    .line 572
    invoke-static {v5, p0}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 574
    :cond_b
    return v5
.end method

.method public static dismiss()V
    .locals 2

    .line 111
    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->root:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    .line 112
    if-eqz v0, :cond_0

    new-instance v1, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda7;

    invoke-direct {v1, v0}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda7;-><init>(Landroid/widget/RelativeLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->post(Ljava/lang/Runnable;)Z

    .line 113
    :cond_0
    return-void
.end method

.method public static dispatchTransition(Ljava/lang/String;)V
    .locals 1

    .line 105
    const-string v0, "SHUTTER_BUTTON_DOWN"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "SETTINGS_LIST_OPENED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 106
    const-string v0, "CAPTURE"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "VIDEO_CAPTURE"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    :cond_0
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->dismiss()V

    .line 107
    :cond_1
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V

    .line 108
    return-void
.end method

.method private static dp(Landroid/view/View;I)I
    .locals 0

    .line 651
    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method private static dpRadius(I)I
    .locals 0

    .line 643
    return p0
.end method

.method private static formatIntensity(Landroid/content/Context;I)Ljava/lang/String;
    .locals 2

    .line 622
    const-string v0, "Intensity %1$d%%"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v1, "port_intensity_fmt"

    invoke-static {p0, v1, v0, p1}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static includes(II)Z
    .locals 2

    .line 375
    const/4 v0, 0x1

    if-eqz p1, :cond_3

    if-eqz p0, :cond_3

    if-ne p0, v0, :cond_0

    const/4 v1, 0x5

    if-le p1, v1, :cond_3

    :cond_0
    const/4 v1, 0x2

    if-ne p0, v1, :cond_1

    const/4 v1, 0x6

    if-eq p1, v1, :cond_3

    :cond_1
    const/4 v1, 0x3

    if-ne p0, v1, :cond_2

    const/4 p0, 0x7

    if-lt p1, p0, :cond_2

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :cond_3
    :goto_0
    return v0
.end method

.method static synthetic lambda$buildCategories$7(ILjava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    .line 364
    sget p2, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    if-ne p2, p0, :cond_0

    return-void

    .line 365
    :cond_0
    sput p0, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    .line 366
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 367
    return-void
.end method

.method static synthetic lambda$dismiss$1(Landroid/widget/RelativeLayout;)V
    .locals 0

    .line 112
    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->removeSheet(Landroid/widget/RelativeLayout;)Z

    return-void
.end method

.method static synthetic lambda$onOrientation$0(Landroid/widget/RelativeLayout;)V
    .locals 4

    .line 92
    const-string v0, "effects-hdr-badge"

    invoke-virtual {p0, v0}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 93
    if-eqz v0, :cond_0

    sget v1, Lcom/motorola/camera/custom/EffectsUiController;->orientation:I

    neg-int v1, v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setRotation(F)V

    .line 94
    :cond_0
    const-class v0, Lcom/motorola/camera/custom/EffectsUiController;

    invoke-virtual {p0, v0}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 95
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    instance-of v1, v1, Landroid/widget/RelativeLayout$LayoutParams;

    if-eqz v1, :cond_1

    .line 96
    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/widget/RelativeLayout$LayoutParams;

    .line 97
    const/16 v2, 0xc

    invoke-static {p0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    .line 98
    const/4 v3, 0x0

    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->computeBottomMargin(Landroid/widget/RelativeLayout;)I

    move-result p0

    invoke-virtual {v1, v2, v3, v2, p0}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 99
    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 101
    :cond_1
    return-void
.end method

.method static synthetic lambda$populate$8(ZILandroid/content/SharedPreferences;Ljava/lang/String;Landroid/widget/LinearLayout;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/view/View;)V
    .locals 0

    .line 441
    if-nez p0, :cond_0

    if-lez p1, :cond_0

    .line 442
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->clearStockMeishePhotoFilter()V

    .line 444
    :cond_0
    invoke-static {p2, p3, p1}, Lcom/motorola/camera/custom/EffectsUiController;->store(Landroid/content/SharedPreferences;Ljava/lang/String;I)V

    .line 445
    move-object p1, p2

    move-object p0, p4

    move p2, p5

    move p3, p6

    move-object p4, p7

    move-object p5, p8

    move-object p6, p9

    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/EffectsUiController;->populate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V

    .line 446
    return-void
.end method

.method static synthetic lambda$show$3(Landroid/widget/RelativeLayout;Landroid/view/View;)V
    .locals 0

    .line 179
    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->removeSheet(Landroid/widget/RelativeLayout;)Z

    return-void
.end method

.method static synthetic lambda$show$4([ZLandroid/widget/TextView;IILandroid/widget/RelativeLayout;)V
    .locals 2

    .line 274
    const/4 v0, 0x0

    aget-boolean p0, p0, v0

    .line 275
    if-eqz p0, :cond_0

    const/16 v0, 0x33

    invoke-static {p2, v0}, Lcom/motorola/camera/custom/EffectsUiController;->withAlpha(II)I

    move-result v0

    goto :goto_0

    :cond_0
    const v0, -0xcfcbc5

    .line 276
    :goto_0
    const/4 v1, 0x1

    invoke-static {p4, v1}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result p4

    if-eqz p0, :cond_1

    move v1, p2

    goto :goto_1

    :cond_1
    const v1, 0x29ffffff

    .line 275
    :goto_1
    invoke-static {v0, p3, p4, v1}, Lcom/motorola/camera/custom/EffectsUiController;->pillRipple(IIII)Landroid/graphics/drawable/Drawable;

    move-result-object p3

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 277
    if-eqz p0, :cond_2

    goto :goto_2

    :cond_2
    const p2, -0xe0f0c

    :goto_2
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 278
    return-void
.end method

.method static synthetic lambda$show$5([Z[ZLjava/lang/Runnable;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 3

    .line 280
    invoke-virtual {p4}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result p4

    .line 281
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-nez p4, :cond_0

    .line 282
    aput-boolean v0, p0, v1

    .line 283
    aput-boolean v0, p1, v1

    .line 284
    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 285
    invoke-interface {p2}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 286
    :cond_0
    if-eq p4, v0, :cond_1

    const/4 v2, 0x3

    if-ne p4, v2, :cond_3

    .line 287
    :cond_1
    aput-boolean v1, p1, v1

    .line 288
    invoke-static {v1}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 289
    invoke-interface {p2}, Ljava/lang/Runnable;->run()V

    .line 290
    if-ne p4, v0, :cond_2

    .line 291
    invoke-virtual {p3}, Landroid/view/View;->performClick()Z

    .line 293
    :cond_2
    aput-boolean v1, p0, v1

    .line 295
    :cond_3
    :goto_0
    return v0
.end method

.method static synthetic lambda$show$6([Z[ZLjava/lang/Runnable;Landroid/view/View;)V
    .locals 0

    .line 298
    const/4 p3, 0x0

    aget-boolean p0, p0, p3

    if-eqz p0, :cond_0

    return-void

    .line 299
    :cond_0
    aget-boolean p0, p1, p3

    xor-int/lit8 p0, p0, 0x1

    aput-boolean p0, p1, p3

    .line 300
    aget-boolean p0, p1, p3

    invoke-static {p0}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 301
    invoke-interface {p2}, Ljava/lang/Runnable;->run()V

    .line 302
    return-void
.end method

.method static synthetic lambda$toggleSelector$2(Landroid/widget/RelativeLayout;)V
    .locals 1

    .line 127
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->showsInCurrentMode()Z

    move-result v0

    if-nez v0, :cond_0

    .line 128
    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->removeSheet(Landroid/widget/RelativeLayout;)Z

    .line 129
    return-void

    .line 131
    :cond_0
    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->removeSheet(Landroid/widget/RelativeLayout;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Landroid/widget/RelativeLayout;->isAttachedToWindow()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 132
    invoke-static {p0}, Lcom/motorola/camera/custom/EffectsUiController;->show(Landroid/widget/RelativeLayout;)V

    .line 133
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V

    .line 135
    :cond_1
    return-void
.end method

.method public static onOrientation(I)V
    .locals 1

    .line 88
    sput p0, Lcom/motorola/camera/custom/EffectsUiController;->orientation:I

    .line 89
    invoke-static {p0}, Lcom/motorola/camera/custom/CompassHudController;->onOrientation(I)V

    .line 90
    sget-object p0, Lcom/motorola/camera/custom/EffectsUiController;->root:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/widget/RelativeLayout;

    .line 91
    if-eqz p0, :cond_0

    new-instance v0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda0;-><init>(Landroid/widget/RelativeLayout;)V

    invoke-virtual {p0, v0}, Landroid/widget/RelativeLayout;->post(Ljava/lang/Runnable;)Z

    .line 102
    :cond_0
    return-void
.end method

.method private static pillRipple(IIII)Landroid/graphics/drawable/Drawable;
    .locals 2

    .line 635
    invoke-static {p1}, Lcom/motorola/camera/custom/EffectsUiController;->dpRadius(I)I

    move-result v0

    invoke-static {p1, v0}, Ljava/lang/Math;->max(II)I

    move-result p1

    .line 636
    new-instance v0, Landroid/graphics/drawable/RippleDrawable;

    .line 637
    const v1, 0x38ffffff

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    .line 638
    invoke-static {p0, p1, p2, p3}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p0

    .line 639
    const/4 p2, -0x1

    const/4 p3, 0x0

    invoke-static {p2, p1, p3, p3}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object p1

    invoke-direct {v0, v1, p0, p1}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .line 636
    return-object v0
.end method

.method private static populate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V
    .locals 27

    .line 381
    move-object/from16 v5, p0

    move/from16 v6, p2

    move/from16 v7, p3

    invoke-virtual {v5}, Landroid/widget/LinearLayout;->getContext()Landroid/content/Context;

    move-result-object v11

    .line 382
    invoke-virtual {v5}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 383
    const/4 v12, 0x1

    const/4 v13, 0x0

    const/4 v14, 0x4

    if-ne v6, v14, :cond_0

    move v1, v12

    goto :goto_0

    :cond_0
    move v1, v13

    .line 384
    :goto_0
    if-eqz v1, :cond_1

    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH:[Ljava/lang/String;

    goto :goto_1

    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    :goto_1
    move-object v15, v0

    .line 385
    if-eqz v1, :cond_2

    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH_BADGES:[Ljava/lang/String;

    goto :goto_2

    :cond_2
    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->LOOK_BADGES:[Ljava/lang/String;

    :goto_2
    move-object/from16 v16, v0

    .line 386
    if-eqz v1, :cond_3

    const-string v0, "com.motorola.camera.bokeh_style"

    goto :goto_3

    :cond_3
    const-string v0, "com.motorola.camera.look_preset"

    :goto_3
    move-object v4, v0

    .line 387
    array-length v0, v15

    sub-int/2addr v0, v12

    invoke-static {v4, v13, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v0

    .line 389
    const/16 v2, 0x60

    invoke-static {v5, v2}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    .line 390
    const/16 v3, 0x4c

    invoke-static {v5, v3}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v3

    .line 391
    const/16 v8, 0x10

    invoke-static {v5, v8}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v8

    .line 392
    const/16 v9, 0x8

    invoke-static {v5, v9}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v10

    .line 393
    const/16 v9, 0x1c

    invoke-static {v5, v9}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v9

    .line 394
    const/4 v14, 0x5

    invoke-static {v5, v14}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v14

    .line 396
    move/from16 v18, v2

    move v2, v13

    :goto_4
    array-length v13, v15

    if-ge v2, v13, :cond_d

    .line 397
    if-nez v1, :cond_4

    invoke-static {v6, v2}, Lcom/motorola/camera/custom/EffectsUiController;->includes(II)Z

    move-result v13

    if-nez v13, :cond_4

    move/from16 v21, v0

    move/from16 v24, v1

    move/from16 v23, v2

    move-object/from16 v25, v4

    move/from16 v17, v8

    move/from16 v20, v9

    move-object/from16 v19, v15

    move/from16 v13, v18

    const/16 v22, 0x8

    move-object/from16 v9, p5

    move v15, v3

    move/from16 v18, v14

    move v14, v10

    goto/16 :goto_c

    .line 398
    :cond_4
    nop

    .line 399
    if-ne v2, v0, :cond_5

    move v13, v12

    goto :goto_5

    :cond_5
    const/4 v13, 0x0

    .line 401
    :goto_5
    new-instance v12, Landroid/widget/LinearLayout;

    invoke-direct {v12, v11}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 402
    move-object/from16 v19, v15

    const/4 v15, 0x1

    invoke-virtual {v12, v15}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 403
    const/16 v15, 0x11

    invoke-virtual {v12, v15}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 404
    invoke-virtual {v12, v14, v14, v14, v14}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 405
    const/4 v15, 0x1

    invoke-virtual {v12, v15}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 406
    invoke-virtual {v12, v15}, Landroid/widget/LinearLayout;->setFocusable(Z)V

    .line 407
    invoke-virtual {v12, v13}, Landroid/widget/LinearLayout;->setSelected(Z)V

    .line 408
    if-eqz v13, :cond_6

    const/16 v15, 0x2b

    invoke-static {v7, v15}, Lcom/motorola/camera/custom/EffectsUiController;->withAlpha(II)I

    move-result v15

    goto :goto_6

    :cond_6
    const v15, -0xd9d5ce

    .line 409
    :goto_6
    move/from16 v21, v0

    if-eqz v13, :cond_7

    const/4 v0, 0x2

    goto :goto_7

    :cond_7
    const/4 v0, 0x1

    :goto_7
    invoke-static {v5, v0}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v0

    .line 410
    if-eqz v13, :cond_8

    move/from16 v24, v1

    move v1, v7

    goto :goto_8

    :cond_8
    const v23, 0x29ffffff

    move/from16 v24, v1

    move/from16 v1, v23

    .line 411
    :goto_8
    move/from16 v23, v2

    new-instance v2, Landroid/graphics/drawable/RippleDrawable;

    .line 412
    const v25, 0x38ffffff

    move/from16 v26, v3

    invoke-static/range {v25 .. v25}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v3

    .line 413
    invoke-static {v15, v8, v0, v1}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 414
    const/4 v1, -0x1

    move-object/from16 v25, v4

    const/4 v15, 0x0

    invoke-static {v1, v8, v15, v15}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-direct {v2, v3, v0, v4}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .line 411
    invoke-virtual {v12, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 416
    aget-object v0, v16, v23

    invoke-static {v11, v0}, Lcom/motorola/camera/custom/EffectsUiController;->resolveDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 417
    if-eqz v0, :cond_9

    .line 418
    new-instance v2, Landroid/widget/ImageView;

    invoke-direct {v2, v11}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 419
    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 420
    sget-object v0, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 421
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 422
    const/4 v15, 0x4

    invoke-static {v5, v15}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v0, v4, v4, v4, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 423
    invoke-virtual {v12, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_9

    .line 417
    :cond_9
    const/4 v15, 0x4

    .line 426
    :goto_9
    aget-object v0, v19, v23

    .line 427
    if-nez v24, :cond_a

    if-nez v23, :cond_a

    const-string v0, "port_look_none"

    const-string v2, "Original"

    invoke-static {v11, v0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_a

    .line 428
    :cond_a
    if-eqz v24, :cond_b

    if-nez v23, :cond_b

    const-string v0, "port_bokeh_stock"

    const-string v2, "Stock"

    invoke-static {v11, v0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 430
    :cond_b
    :goto_a
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v11}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 431
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 432
    const/high16 v0, 0x41300000    # 11.0f

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 433
    const/4 v0, 0x2

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 434
    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 435
    const/16 v0, 0x11

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 436
    if-eqz v13, :cond_c

    move v0, v7

    goto :goto_b

    :cond_c
    const v0, -0xe0f0c

    :goto_b
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 437
    sget-object v0, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    invoke-virtual {v2, v0, v13}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 438
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    invoke-direct {v0, v1, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 440
    new-instance v0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;

    move-object/from16 v3, p1

    move/from16 v17, v8

    move/from16 v20, v9

    move/from16 v13, v18

    move/from16 v2, v23

    move/from16 v1, v24

    move-object/from16 v4, v25

    move/from16 v15, v26

    const/16 v22, 0x8

    move-object/from16 v8, p4

    move-object/from16 v9, p5

    move/from16 v18, v14

    move v14, v10

    move-object/from16 v10, p6

    invoke-direct/range {v0 .. v10}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;-><init>(ZILandroid/content/SharedPreferences;Ljava/lang/String;Landroid/widget/LinearLayout;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 447
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v13, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 448
    const/4 v4, 0x0

    invoke-virtual {v0, v4, v4, v14, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 449
    invoke-virtual {v5, v12, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 396
    :goto_c
    add-int/lit8 v2, v23, 0x1

    move/from16 v6, p2

    move v10, v14

    move v3, v15

    move/from16 v8, v17

    move/from16 v14, v18

    move-object/from16 v15, v19

    move/from16 v9, v20

    move/from16 v0, v21

    move/from16 v1, v24

    move-object/from16 v4, v25

    const/4 v12, 0x1

    move/from16 v18, v13

    const/4 v13, 0x0

    goto/16 :goto_4

    .line 452
    :cond_d
    move-object/from16 v9, p5

    move/from16 v24, v1

    const/16 v22, 0x8

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v0

    const v1, -0x470e0f0c

    if-eqz v0, :cond_e

    .line 453
    const-string v0, "port_hdr10_notice"

    const-string v2, "Preview unavailable in HDR10 Video"

    invoke-static {v11, v0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 454
    invoke-virtual {v9, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 455
    const-string v0, "effects-hdr-badge"

    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 456
    sget v0, Lcom/motorola/camera/custom/EffectsUiController;->orientation:I

    neg-int v0, v0

    int-to-float v0, v0

    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setRotation(F)V

    .line 457
    const/4 v4, 0x0

    invoke-virtual {v9, v4}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_e

    .line 458
    :cond_e
    if-eqz v24, :cond_10

    .line 459
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 460
    const-string v0, "port_bokeh_portrait_active"

    const-string v2, "Applied when saving in Portrait mode"

    invoke-static {v11, v0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_d

    .line 461
    :cond_f
    const-string v0, "port_bokeh_use_portrait"

    const-string v2, "Available in Portrait mode (pre-selected for Portrait)"

    invoke-static {v11, v0, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 462
    :goto_d
    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 463
    invoke-virtual {v9, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 464
    const/4 v0, 0x0

    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 465
    const/4 v0, 0x0

    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setRotation(F)V

    .line 466
    const/4 v4, 0x0

    invoke-virtual {v9, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 467
    goto :goto_e

    .line 468
    :cond_10
    const/4 v4, 0x0

    invoke-static {v11, v9}, Lcom/motorola/camera/custom/EffectsUiController;->updatePairingNote(Landroid/content/Context;Landroid/widget/TextView;)V

    .line 471
    :goto_e
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v0

    if-nez v0, :cond_12

    if-eqz v24, :cond_11

    goto :goto_f

    :cond_11
    move v13, v4

    goto :goto_10

    :cond_12
    :goto_f
    move/from16 v13, v22

    :goto_10
    move-object/from16 v10, p6

    invoke-virtual {v10, v13}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 472
    move-object/from16 v8, p4

    invoke-static {v11, v8, v7}, Lcom/motorola/camera/custom/EffectsUiController;->updateStatus(Landroid/content/Context;Landroid/widget/TextView;I)V

    .line 473
    return-void
.end method

.method static refreshPreview()V
    .locals 3

    .line 538
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 539
    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v0

    invoke-static {v0}, Lcom/motorola/camera/custom/LiveLookPreview;->setProfilePaused(Z)V

    .line 540
    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    .line 541
    const-string v1, "com.motorola.camera.look_preset"

    const/4 v2, 0x0

    invoke-static {v1, v2, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v0

    .line 542
    const-string v1, "com.motorola.camera.look_intensity"

    const/16 v2, 0x64

    invoke-static {v1, v2, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v1

    .line 540
    invoke-static {v0, v1}, Lcom/motorola/camera/custom/LiveLookPreview;->select(II)V

    .line 543
    return-void
.end method

.method private static removeSheet(Landroid/widget/RelativeLayout;)Z
    .locals 2

    .line 116
    const-class v0, Lcom/motorola/camera/custom/EffectsUiController;

    invoke-virtual {p0, v0}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 117
    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 118
    :cond_0
    invoke-static {v1}, Lcom/motorola/camera/custom/LiveLookPreview;->setCompare(Z)V

    .line 119
    invoke-virtual {p0, v0}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    .line 120
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V

    .line 121
    const/4 p0, 0x1

    return p0
.end method

.method private static resolveAccentColor(Landroid/content/Context;)I
    .locals 3

    .line 579
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 580
    const-string v1, "primary_main"

    const-string v2, "color"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    .line 581
    if-eqz p0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Landroid/content/res/Resources;->getColor(ILandroid/content/res/Resources$Theme;)I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p0

    .line 582
    :catchall_0
    move-exception p0

    :cond_0
    nop

    .line 583
    const p0, -0x741501

    return p0
.end method

.method private static resolveDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .locals 3

    .line 587
    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 589
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    .line 590
    const-string v2, "drawable"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p1, v2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    .line 591
    if-eqz p0, :cond_1

    invoke-virtual {v1, p0, v0}, Landroid/content/res/Resources;->getDrawable(ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    return-object v0

    .line 592
    :catchall_0
    move-exception p0

    .line 593
    return-object v0
.end method

.method private static roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;
    .locals 2

    .line 626
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 627
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 628
    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 629
    int-to-float p0, p1

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 630
    if-lez p2, :cond_0

    invoke-virtual {v0, p2, p3}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 631
    :cond_0
    return-object v0
.end method

.method private static show(Landroid/widget/RelativeLayout;)V
    .locals 18

    .line 139
    move-object/from16 v5, p0

    invoke-virtual {v5}, Landroid/widget/RelativeLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 140
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v3

    .line 141
    if-nez v3, :cond_0

    return-void

    .line 142
    :cond_0
    invoke-static {v1}, Lcom/motorola/camera/custom/EffectsUiController;->resolveAccentColor(Landroid/content/Context;)I

    move-result v11

    .line 144
    new-instance v12, Landroid/widget/LinearLayout;

    invoke-direct {v12, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 145
    const-class v0, Lcom/motorola/camera/custom/EffectsUiController;

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    .line 146
    const/4 v0, 0x1

    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 147
    const/16 v2, 0x18

    invoke-static {v5, v2}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    invoke-static {v5, v0}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v4

    const v6, -0x1ce4dfd7

    const v13, 0x29ffffff

    invoke-static {v6, v2, v4, v13}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v12, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 148
    const/16 v14, 0x8

    invoke-static {v5, v14}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v12, v2}, Landroid/widget/LinearLayout;->setElevation(F)V

    .line 149
    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 150
    invoke-virtual {v12, v0}, Landroid/widget/LinearLayout;->setFocusable(Z)V

    .line 151
    const/16 v15, 0xc

    invoke-static {v5, v15}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v2

    .line 152
    const/16 v4, 0xa

    invoke-static {v5, v4}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v6

    .line 153
    invoke-static {v5, v15}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v7

    invoke-virtual {v12, v2, v6, v2, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 156
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 157
    const/4 v6, 0x0

    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 158
    const/16 v7, 0x10

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 159
    const/4 v8, 0x2

    invoke-static {v5, v8}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v9

    invoke-static {v5, v8}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v8

    const/4 v10, 0x6

    invoke-static {v5, v10}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v10

    invoke-virtual {v2, v9, v6, v8, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 161
    new-instance v10, Landroid/widget/TextView;

    invoke-direct {v10, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 162
    const/high16 v8, 0x41400000    # 12.0f

    invoke-virtual {v10, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 163
    invoke-virtual {v10, v0}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 164
    sget-object v9, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v10, v9}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 165
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x2

    const/high16 v15, 0x3f800000    # 1.0f

    invoke-direct {v9, v6, v8, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 166
    invoke-virtual {v2, v10, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 168
    new-instance v9, Landroid/widget/TextView;

    invoke-direct {v9, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 169
    const-string v15, "\u00d7"

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 170
    const/high16 v15, 0x41800000    # 16.0f

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setTextSize(F)V

    .line 171
    const v15, -0xe0f0c

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setTextColor(I)V

    .line 172
    sget-object v15, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    invoke-virtual {v9, v15, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 173
    const/16 v15, 0x11

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setGravity(I)V

    .line 174
    const-string v15, "port_close_cd"

    const-string v4, "Close effects panel"

    invoke-static {v1, v15, v4}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v9, v4}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 175
    const/16 v4, 0x1c

    invoke-static {v5, v4}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v4

    .line 176
    invoke-static {v5, v0}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v15

    const v14, -0xcfcbc5

    invoke-static {v14, v4, v15, v13}, Lcom/motorola/camera/custom/EffectsUiController;->pillRipple(IIII)Landroid/graphics/drawable/Drawable;

    move-result-object v15

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 177
    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setClickable(Z)V

    .line 178
    invoke-virtual {v9, v0}, Landroid/widget/TextView;->setFocusable(Z)V

    .line 179
    new-instance v15, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda2;

    invoke-direct {v15, v5}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda2;-><init>(Landroid/widget/RelativeLayout;)V

    invoke-virtual {v9, v15}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 180
    new-instance v15, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v15, v4, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v9, v15}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 181
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v15, -0x1

    invoke-direct {v4, v15, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 184
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 185
    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 186
    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 187
    new-instance v4, Landroid/widget/HorizontalScrollView;

    invoke-direct {v4, v1}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 188
    invoke-virtual {v4, v6}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 189
    invoke-virtual {v4, v2}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;)V

    .line 190
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v9, v15, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 191
    const/16 v13, 0x8

    invoke-static {v5, v13}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v0

    invoke-virtual {v9, v6, v6, v6, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 192
    invoke-virtual {v12, v4, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 195
    new-instance v13, Landroid/widget/LinearLayout;

    invoke-direct {v13, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 196
    invoke-virtual {v13, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 197
    invoke-virtual {v13, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 198
    new-instance v0, Landroid/widget/HorizontalScrollView;

    invoke-direct {v0, v1}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    .line 199
    invoke-virtual {v0, v6}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 200
    invoke-virtual {v0, v13}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;)V

    .line 201
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v9, v15, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 202
    const/16 v7, 0x8

    invoke-static {v5, v7}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v8

    invoke-virtual {v9, v6, v6, v6, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 203
    invoke-virtual {v12, v0, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 206
    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 207
    const/high16 v8, 0x41380000    # 11.5f

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 208
    const v8, -0x470e0f0c

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextColor(I)V

    .line 209
    const v8, 0x800003

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setGravity(I)V

    .line 210
    const/16 v8, 0xa

    invoke-static {v5, v8}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v9

    const/4 v15, 0x5

    invoke-static {v5, v15}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v6

    invoke-static {v5, v8}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v8

    invoke-static {v5, v15}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v15

    invoke-virtual {v7, v9, v6, v8, v15}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 211
    const/16 v6, 0xc

    invoke-static {v5, v6}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v8

    const/4 v6, 0x0

    invoke-static {v14, v8, v6, v6}, Lcom/motorola/camera/custom/EffectsUiController;->roundedRect(IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 212
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v15, -0x2

    invoke-direct {v8, v9, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 213
    const/16 v9, 0x8

    invoke-static {v5, v9}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v15

    invoke-virtual {v8, v6, v6, v6, v15}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 214
    invoke-virtual {v12, v7, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    new-instance v15, Landroid/widget/LinearLayout;

    invoke-direct {v15, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 218
    invoke-virtual {v15, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 219
    const/16 v6, 0x10

    invoke-virtual {v15, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 221
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 222
    const/4 v8, 0x1

    invoke-virtual {v6, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 223
    move-object v8, v7

    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, v1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 224
    const-string v9, "com.motorola.camera.look_intensity"

    const/16 v14, 0x64

    invoke-static {v9, v14, v14}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v9

    .line 225
    const v14, -0xe0f0c

    invoke-virtual {v7, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 226
    const/high16 v14, 0x41400000    # 12.0f

    invoke-virtual {v7, v14}, Landroid/widget/TextView;->setTextSize(F)V

    .line 227
    invoke-static {v1, v9}, Lcom/motorola/camera/custom/EffectsUiController;->formatIntensity(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v7, v14}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 228
    new-instance v14, Landroid/widget/LinearLayout$LayoutParams;

    move-object/from16 v17, v0

    move-object/from16 v16, v2

    const/4 v0, -0x1

    const/4 v2, -0x2

    invoke-direct {v14, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v7, v14}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 230
    new-instance v0, Landroid/widget/SeekBar;

    invoke-direct {v0, v1}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    .line 231
    const-string v14, "port_intensity_cd"

    const-string v2, "Filter intensity"

    invoke-static {v1, v14, v2}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 232
    const/16 v2, 0x64

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setMax(I)V

    .line 233
    invoke-virtual {v0, v9}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 234
    invoke-static {v11}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v2

    .line 235
    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    .line 236
    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setThumbTintList(Landroid/content/res/ColorStateList;)V

    .line 237
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setSplitTrack(Z)V

    .line 238
    move-object v9, v6

    new-instance v6, Lcom/motorola/camera/custom/EffectsUiController$1;

    move-object v14, v8

    move-object v8, v1

    move-object v1, v9

    move-object v9, v3

    const/4 v3, -0x2

    invoke-direct/range {v6 .. v11}, Lcom/motorola/camera/custom/EffectsUiController$1;-><init>(Landroid/widget/TextView;Landroid/content/Context;Landroid/content/SharedPreferences;Landroid/widget/TextView;I)V

    move-object v7, v6

    move-object v6, v10

    invoke-virtual {v0, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 249
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, -0x1

    invoke-direct {v7, v10, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 250
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v0, v2, v3, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 251
    const/16 v7, 0x8

    invoke-static {v5, v7}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v10

    invoke-virtual {v0, v2, v2, v10, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 252
    invoke-virtual {v15, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 254
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v0

    if-nez v0, :cond_1

    .line 255
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, v8}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 256
    const-string v1, "port_hold_compare"

    const-string v7, "Hold to compare"

    invoke-static {v8, v1, v7}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 257
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 258
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 259
    const v1, -0xe0f0c

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 260
    const/high16 v1, 0x41400000    # 12.0f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 261
    sget-object v1, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    const/4 v7, 0x1

    invoke-virtual {v0, v1, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 262
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 263
    invoke-virtual {v0, v7}, Landroid/widget/TextView;->setMaxLines(I)V

    .line 264
    invoke-virtual {v0, v7}, Landroid/widget/TextView;->setClickable(Z)V

    .line 265
    invoke-virtual {v0, v7}, Landroid/widget/TextView;->setFocusable(Z)V

    .line 266
    const/16 v1, 0x26

    invoke-static {v5, v1}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v1

    .line 267
    const/16 v7, 0xe

    invoke-static {v5, v7}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v7

    .line 268
    invoke-virtual {v0, v7, v2, v7, v2}, Landroid/widget/TextView;->setPaddingRelative(IIII)V

    .line 269
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMinimumHeight(I)V

    .line 270
    const/4 v7, 0x1

    invoke-static {v5, v7}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v10

    const v2, -0xcfcbc5

    const v3, 0x29ffffff

    invoke-static {v2, v1, v10, v3}, Lcom/motorola/camera/custom/EffectsUiController;->pillRipple(IIII)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 271
    new-array v10, v7, [Z

    .line 272
    new-array v2, v7, [Z

    .line 273
    move-object v3, v4

    move v4, v1

    move-object v1, v2

    move-object v2, v0

    new-instance v0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda3;

    move v7, v11

    move-object v11, v3

    move v3, v7

    const/4 v7, -0x2

    invoke-direct/range {v0 .. v5}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda3;-><init>([ZLandroid/widget/TextView;IILandroid/widget/RelativeLayout;)V

    .line 279
    new-instance v5, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;

    invoke-direct {v5, v10, v1, v0}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda4;-><init>([Z[ZLjava/lang/Runnable;)V

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 297
    new-instance v5, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda5;

    invoke-direct {v5, v10, v1, v0}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda5;-><init>([Z[ZLjava/lang/Runnable;)V

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 303
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v7, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v15, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 254
    :cond_1
    move v7, v3

    move v3, v11

    move-object v11, v4

    .line 305
    :goto_0
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, -0x1

    invoke-direct {v0, v10, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v15, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 307
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v0

    .line 308
    sget v1, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    if-ltz v1, :cond_3

    sget v1, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    sget-object v2, Lcom/motorola/camera/custom/EffectsUiController;->CATEGORY_KEYS:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_3

    if-nez v0, :cond_2

    sget v0, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v10, 0x0

    goto :goto_2

    .line 309
    :cond_3
    :goto_1
    const/4 v10, 0x0

    sput v10, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    .line 311
    :goto_2
    new-instance v0, Lcom/motorola/camera/custom/EffectsUiController$2;

    move-object v1, v8

    move-object v5, v9

    move-object v4, v13

    move-object v8, v15

    move-object/from16 v2, v16

    move-object/from16 v9, v17

    move-object/from16 v13, p0

    move v15, v7

    move-object v7, v14

    invoke-direct/range {v0 .. v9}, Lcom/motorola/camera/custom/EffectsUiController$2;-><init>(Landroid/content/Context;Landroid/widget/LinearLayout;ILandroid/widget/LinearLayout;Landroid/content/SharedPreferences;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/HorizontalScrollView;)V

    .line 320
    move-object v1, v0

    move-object v2, v4

    move-object v0, v9

    move-object v9, v5

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 321
    sget v4, Lcom/motorola/camera/custom/EffectsUiController;->activeCategory:I

    move v5, v3

    move-object v3, v9

    invoke-static/range {v2 .. v8}, Lcom/motorola/camera/custom/EffectsUiController;->populate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V

    .line 323
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 324
    const/16 v7, 0x8

    invoke-virtual {v11, v7}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 325
    invoke-virtual {v0, v7}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 327
    :cond_4
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v9, -0x1

    invoke-direct {v0, v9, v15}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 328
    const/16 v6, 0xc

    invoke-virtual {v0, v6}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 329
    invoke-static {v13, v6}, Lcom/motorola/camera/custom/EffectsUiController;->dp(Landroid/view/View;I)I

    move-result v1

    .line 330
    invoke-static {v13}, Lcom/motorola/camera/custom/EffectsUiController;->computeBottomMargin(Landroid/widget/RelativeLayout;)I

    move-result v2

    invoke-virtual {v0, v1, v10, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 331
    invoke-virtual {v13, v12, v0}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 332
    return-void
.end method

.method public static showsInCurrentMode()Z
    .locals 1

    .line 82
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPhotoMode()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v0

    if-nez v0, :cond_1

    .line 83
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isProPhotoMode()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isNightVisionMode()Z

    move-result v0

    if-nez v0, :cond_1

    .line 84
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 82
    :goto_1
    return v0
.end method

.method private static store(Landroid/content/SharedPreferences;Ljava/lang/String;I)V
    .locals 0

    .line 533
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {p0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 534
    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->refreshPreview()V

    .line 535
    return-void
.end method

.method private static str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 599
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 600
    const-string v1, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p1, v1, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    .line 601
    if-eqz p0, :cond_0

    .line 602
    invoke-virtual {v0, p0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p0

    .line 603
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez p1, :cond_0

    return-object p0

    .line 605
    :catchall_0
    move-exception p0

    :cond_0
    nop

    .line 606
    return-object p2
.end method

.method private static strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .line 611
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 612
    const-string v1, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p1, v1, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    .line 613
    if-eqz p0, :cond_0

    .line 614
    filled-new-array {p3}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, p0, p1}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 615
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez p1, :cond_0

    return-object p0

    .line 617
    :catchall_0
    move-exception p0

    :cond_0
    nop

    .line 618
    filled-new-array {p3}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {p2, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static toggleSelector()V
    .locals 2

    .line 125
    sget-object v0, Lcom/motorola/camera/custom/EffectsUiController;->root:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    .line 126
    if-eqz v0, :cond_0

    new-instance v1, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda6;

    invoke-direct {v1, v0}, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda6;-><init>(Landroid/widget/RelativeLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->post(Ljava/lang/Runnable;)Z

    .line 136
    :cond_0
    return-void
.end method

.method private static updatePairingNote(Landroid/content/Context;Landroid/widget/TextView;)V
    .locals 7

    .line 476
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 477
    sget-object v1, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    const-string v2, "com.motorola.camera.look_preset"

    const/4 v3, 0x0

    invoke-static {v2, v3, v1}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v1

    .line 478
    if-nez v1, :cond_0

    .line 479
    const/16 p0, 0x8

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 480
    return-void

    .line 482
    :cond_0
    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getProfileShortLabel(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v2

    .line 484
    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v4

    const/4 v5, 0x7

    const/4 v6, 0x5

    if-eqz v4, :cond_1

    .line 485
    const-string v1, "port_pair_paused_fmt"

    const-string v4, "Uses %1$s only \u2014 Look paused"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 486
    :cond_1
    if-lt v0, v6, :cond_2

    if-gt v0, v5, :cond_2

    .line 488
    const-string v1, "port_pair_double_lut_fmt"

    const-string v4, "2x LUT active: %1$s + Look (prefer Auto / Minimal)"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 490
    :cond_2
    invoke-static {v1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isDiffusionLook(I)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 491
    const-string v1, "port_pair_diffusion_fmt"

    const-string v4, "1x LUT + soft highlights/zoom (%1$s)"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 493
    :cond_3
    const/4 v4, 0x6

    if-ne v1, v4, :cond_4

    .line 494
    const-string v1, "port_pair_hdrplus_fmt"

    const-string v4, "1x LUT + highlight roll-off (%1$s)"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 496
    :cond_4
    invoke-static {v1}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isContrastFilmLook(I)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 497
    const-string v1, "port_pair_film_fmt"

    const-string v4, "1x LUT + crisp shadows (%1$s)"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    .line 500
    :cond_5
    const-string v1, "port_pair_active_fmt"

    const-string v4, "1x LUT paired with %1$s"

    invoke-static {p0, v1, v4, v2}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    .line 502
    :goto_0
    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 503
    nop

    .line 504
    if-lt v0, v6, :cond_6

    if-gt v0, v5, :cond_6

    const/16 p0, -0x3380

    goto :goto_1

    :cond_6
    const p0, -0x470e0f0c

    .line 503
    :goto_1
    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 505
    const/4 p0, 0x0

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 506
    const/4 p0, 0x0

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setRotation(F)V

    .line 507
    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 508
    return-void
.end method

.method private static updateStatus(Landroid/content/Context;Landroid/widget/TextView;I)V
    .locals 6

    .line 511
    invoke-static {}, Lcom/motorola/camera/custom/CustomImagingBridge;->getSelectedProfile()I

    move-result v0

    .line 512
    invoke-static {p0, v0}, Lcom/motorola/camera/custom/CustomImagingBridge;->getProfileShortLabel(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    .line 513
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v2

    .line 514
    sget-object v3, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    array-length v3, v3

    add-int/lit8 v3, v3, -0x1

    const-string v4, "com.motorola.camera.look_preset"

    const/4 v5, 0x0

    invoke-static {v4, v5, v3}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v3

    .line 515
    if-eqz v2, :cond_0

    .line 516
    sget-object v2, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH:[Ljava/lang/String;

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    const-string v4, "com.motorola.camera.bokeh_style"

    invoke-static {v4, v5, v2}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v5

    goto :goto_0

    .line 517
    :cond_0
    nop

    .line 518
    :goto_0
    const-string v2, "com.motorola.camera.look_intensity"

    const/16 v4, 0x64

    invoke-static {v2, v4, v4}, Lcom/motorola/camera/custom/CustomImagingBridge;->effectPreference(Ljava/lang/String;II)I

    move-result v2

    .line 519
    invoke-static {v0}, Lcom/motorola/camera/custom/ScenePostProcSelector;->isProtectedProfile(I)Z

    move-result v0

    if-eqz v0, :cond_2

    if-gtz v3, :cond_1

    if-lez v5, :cond_2

    .line 520
    :cond_1
    const/16 p2, -0x3380

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 521
    const-string p2, "port_look_paused_fmt"

    const-string v0, "Paused in %1$s"

    invoke-static {p0, p2, v0, v1}, Lcom/motorola/camera/custom/EffectsUiController;->strFmt(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 522
    return-void

    .line 524
    :cond_2
    if-gtz v3, :cond_4

    if-lez v5, :cond_3

    goto :goto_1

    :cond_3
    const p2, -0x470e0f0c

    :cond_4
    :goto_1
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 525
    if-nez v3, :cond_5

    const-string p2, "port_look_none"

    const-string v0, "Original"

    invoke-static {p0, p2, v0}, Lcom/motorola/camera/custom/EffectsUiController;->str(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto :goto_2

    :cond_5
    sget-object p0, Lcom/motorola/camera/custom/EffectsUiController;->LOOKS:[Ljava/lang/String;

    aget-object p0, p0, v3

    .line 526
    :goto_2
    const-string p2, " \u00b7 "

    if-nez v3, :cond_6

    if-lez v5, :cond_6

    goto :goto_3

    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 527
    :goto_3
    if-lez v3, :cond_7

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p2, "%"

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 528
    :cond_7
    if-lez v5, :cond_8

    sget-object p0, Lcom/motorola/camera/custom/EffectsUiController;->BOKEH:[Ljava/lang/String;

    aget-object p0, p0, v5

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, " \u00b7 Bokeh: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 529
    :cond_8
    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 530
    return-void
.end method

.method private static withAlpha(II)I
    .locals 1

    .line 647
    const v0, 0xffffff

    and-int/2addr p0, v0

    and-int/lit16 p1, p1, 0xff

    shl-int/lit8 p1, p1, 0x18

    or-int/2addr p0, p1

    return p0
.end method
