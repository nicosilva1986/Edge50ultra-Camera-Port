.class public final synthetic Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public final synthetic f$0:Z

.field public final synthetic f$1:I

.field public final synthetic f$2:Landroid/content/SharedPreferences;

.field public final synthetic f$3:Ljava/lang/String;

.field public final synthetic f$4:Landroid/widget/LinearLayout;

.field public final synthetic f$5:I

.field public final synthetic f$6:I

.field public final synthetic f$7:Landroid/widget/TextView;

.field public final synthetic f$8:Landroid/widget/TextView;

.field public final synthetic f$9:Landroid/widget/LinearLayout;


# direct methods
.method public synthetic constructor <init>(ZILandroid/content/SharedPreferences;Ljava/lang/String;Landroid/widget/LinearLayout;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$0:Z

    iput p2, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$1:I

    iput-object p3, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$2:Landroid/content/SharedPreferences;

    iput-object p4, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$3:Ljava/lang/String;

    iput-object p5, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$4:Landroid/widget/LinearLayout;

    iput p6, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$5:I

    iput p7, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$6:I

    iput-object p8, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$7:Landroid/widget/TextView;

    iput-object p9, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$8:Landroid/widget/TextView;

    iput-object p10, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$9:Landroid/widget/LinearLayout;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 11

    .line 0
    iget-boolean v0, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$0:Z

    iget v1, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$1:I

    iget-object v2, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$2:Landroid/content/SharedPreferences;

    iget-object v3, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$3:Ljava/lang/String;

    iget-object v4, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$4:Landroid/widget/LinearLayout;

    iget v5, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$5:I

    iget v6, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$6:I

    iget-object v7, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$7:Landroid/widget/TextView;

    iget-object v8, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$8:Landroid/widget/TextView;

    iget-object v9, p0, Lcom/motorola/camera/custom/EffectsUiController$$ExternalSyntheticLambda8;->f$9:Landroid/widget/LinearLayout;

    move-object v10, p1

    invoke-static/range {v0 .. v10}, Lcom/motorola/camera/custom/EffectsUiController;->lambda$populate$8(ZILandroid/content/SharedPreferences;Ljava/lang/String;Landroid/widget/LinearLayout;IILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/view/View;)V

    return-void
.end method
