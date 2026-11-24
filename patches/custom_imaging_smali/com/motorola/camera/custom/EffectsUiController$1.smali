.class Lcom/motorola/camera/custom/EffectsUiController$1;
.super Ljava/lang/Object;
.source "EffectsUiController.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

.field final synthetic val$context:Landroid/content/Context;

.field final synthetic val$intensityText:Landroid/widget/TextView;

.field final synthetic val$preferences:Landroid/content/SharedPreferences;

.field final synthetic val$statusView:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/widget/TextView;Landroid/content/Context;Landroid/content/SharedPreferences;Landroid/widget/TextView;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 238
    iput-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$intensityText:Landroid/widget/TextView;

    iput-object p2, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$context:Landroid/content/Context;

    iput-object p3, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$preferences:Landroid/content/SharedPreferences;

    iput-object p4, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$statusView:Landroid/widget/TextView;

    iput p5, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$accent:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    .line 240
    iget-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$intensityText:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$context:Landroid/content/Context;

    invoke-static {v0, p2}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$smformatIntensity(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 241
    if-eqz p3, :cond_0

    .line 242
    iget-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$preferences:Landroid/content/SharedPreferences;

    const-string p3, "com.motorola.camera.look_intensity"

    invoke-static {p1, p3, p2}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$smstore(Landroid/content/SharedPreferences;Ljava/lang/String;I)V

    .line 243
    iget-object p1, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$context:Landroid/content/Context;

    iget-object p2, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$statusView:Landroid/widget/TextView;

    iget p3, p0, Lcom/motorola/camera/custom/EffectsUiController$1;->val$accent:I

    invoke-static {p1, p2, p3}, Lcom/motorola/camera/custom/EffectsUiController;->-$$Nest$smupdateStatus(Landroid/content/Context;Landroid/widget/TextView;I)V

    .line 245
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 246
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .line 247
    return-void
.end method
