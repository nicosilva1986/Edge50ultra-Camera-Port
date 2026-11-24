.class Lcom/motorola/camera/custom/EffectsUiController$2;
.super Ljava/lang/Object;
.source "EffectsUiController.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/motorola/camera/custom/EffectsUiController;->show(Landroid/widget/RelativeLayout;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$accent:I

.field final synthetic val$categories:Landroid/widget/LinearLayout;

.field final synthetic val$context:Landroid/content/Context;

.field final synthetic val$controls:Landroid/widget/LinearLayout;

.field final synthetic val$noteView:Landroid/widget/TextView;

.field final synthetic val$preferences:Landroid/content/SharedPreferences;

.field final synthetic val$presetScroll:Landroid/widget/HorizontalScrollView;

.field final synthetic val$presets:Landroid/widget/LinearLayout;

.field final synthetic val$statusView:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/widget/LinearLayout;ILandroid/widget/LinearLayout;Landroid/content/SharedPreferences;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/HorizontalScrollView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 311
    iput-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$context:Landroid/content/Context;

    iput-object p2, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$categories:Landroid/widget/LinearLayout;

    iput p3, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$accent:I

    iput-object p4, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$presets:Landroid/widget/LinearLayout;

    iput-object p5, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$preferences:Landroid/content/SharedPreferences;

    iput-object p6, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$statusView:Landroid/widget/TextView;

    iput-object p7, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$noteView:Landroid/widget/TextView;

    iput-object p8, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$controls:Landroid/widget/LinearLayout;

    iput-object p9, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$presetScroll:Landroid/widget/HorizontalScrollView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$run$0$com-motorola-camera-custom-EffectsUiController$2(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;ILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/HorizontalScrollView;)V
    .locals 1

    .line 314
    invoke-virtual {p0}, Lcom/motorola/camera/custom/EffectsUiController$2;->run()V

    .line 315
    move-object v0, p1

    move-object p1, p2

    invoke-static {}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$sfgetactiveCategory()I

    move-result p2

    move-object p0, v0

    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$smpopulate(Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V

    .line 316
    const/4 p1, 0x0

    invoke-virtual {p7, p1, p1}, Landroid/widget/HorizontalScrollView;->scrollTo(II)V

    .line 317
    return-void
.end method

.method public run()V
    .locals 12

    .line 313
    iget-object v0, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$categories:Landroid/widget/LinearLayout;

    iget v2, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$accent:I

    iget-object v5, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$presets:Landroid/widget/LinearLayout;

    iget-object v6, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$preferences:Landroid/content/SharedPreferences;

    iget v7, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$accent:I

    iget-object v8, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$statusView:Landroid/widget/TextView;

    iget-object v9, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$noteView:Landroid/widget/TextView;

    iget-object v10, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$controls:Landroid/widget/LinearLayout;

    iget-object v11, p0, Lcom/motorola/camera/custom/EffectsUiController$2;->val$presetScroll:Landroid/widget/HorizontalScrollView;

    new-instance v3, Lcom/motorola/camera/custom/EffectsUiController$2$$ExternalSyntheticLambda0;

    move-object v4, p0

    invoke-direct/range {v3 .. v11}, Lcom/motorola/camera/custom/EffectsUiController$2$$ExternalSyntheticLambda0;-><init>(Lcom/motorola/camera/custom/EffectsUiController$2;Landroid/widget/LinearLayout;Landroid/content/SharedPreferences;ILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/HorizontalScrollView;)V

    invoke-static {v0, v1, v2, v3}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$smbuildCategories(Landroid/content/Context;Landroid/widget/LinearLayout;ILjava/lang/Runnable;)V

    .line 318
    return-void
.end method
