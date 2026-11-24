.class final Lcom/motorola/camera/custom/CompassHudController$Roadstr;
.super Ljava/lang/Object;
.source "CompassHudController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CompassHudController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Roadstr"
.end annotation


# static fields
.field static final CHANGE:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final CURRENT_MODE:Ljava/lang/reflect/Method;

.field static final EFFECTS:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final FAST:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final MORE:Ljava/lang/Object;

.field static final QUICK_OPEN:Ljava/lang/reflect/Method;

.field static final SETTINGS:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field static final VALUE:Ljava/lang/reflect/Field;


# direct methods
.method static bridge synthetic -$$Nest$smsetting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 554
    const-class v0, Lcom/motorola/camera/settings/SettingsHelper;

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Class;

    const-string v3, "getCurrentMode"

    invoke-static {v0, v3, v2}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->CURRENT_MODE:Ljava/lang/reflect/Method;

    .line 555
    const-string v0, "com.motorola.camera.custom.EffectsUiController"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->EFFECTS:Ljava/lang/Class;

    .line 556
    const-string v0, "com.google.android.gms.internal.mlkit_vision_common.zzkj"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v2, "isControlPanelOpen"

    new-array v1, v1, [Ljava/lang/Class;

    invoke-static {v0, v2, v1}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->QUICK_OPEN:Ljava/lang/reflect/Method;

    .line 558
    const-string v0, "com.motorola.camera.settings.FastSettingsManager"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->FAST:Ljava/lang/Class;

    .line 559
    const-string v0, "com.motorola.camera.settings.SettingsManager"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->SETTINGS:Ljava/lang/Class;

    .line 560
    const-string v0, "com.motorola.camera.settings.SettingChangeListener"

    invoke-static {v0}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->CHANGE:Ljava/lang/Class;

    .line 561
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->FAST:Ljava/lang/Class;

    const-string v1, "MODE_MENU_SHOW"

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->MORE:Ljava/lang/Object;

    .line 562
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->moreValue()Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->VALUE:Ljava/lang/reflect/Field;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 553
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static menuOpen()Z
    .locals 5

    .line 565
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->QUICK_OPEN:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v1, v4, v3}, Lcom/motorola/camera/custom/CompassHudController;->-$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    .line 566
    :cond_0
    :try_start_0
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->VALUE:Ljava/lang/reflect/Field;

    if-eqz v0, :cond_1

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    sget-object v3, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->VALUE:Ljava/lang/reflect/Field;

    sget-object v4, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->MORE:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_1

    move v2, v1

    :cond_1
    return v2

    .line 567
    :catch_0
    move-exception v0

    return v2
.end method

.method private static moreValue()Ljava/lang/reflect/Field;
    .locals 3

    .line 596
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->MORE:Ljava/lang/Object;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 597
    :cond_0
    :try_start_0
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->MORE:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v2, "mValue"

    invoke-virtual {v0, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 598
    :catch_0
    move-exception v0

    return-object v1
.end method

.method static observeMenus(Ljava/lang/Object;Z)V
    .locals 5

    .line 574
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->MORE:Ljava/lang/Object;

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->SETTINGS:Ljava/lang/Class;

    const-string v2, "CONTROL_PANEL"

    invoke-static {v1, v2}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->SETTINGS:Ljava/lang/Class;

    const-string v3, "VIDEO_RESOLUTION_AND_FRAME_RATE"

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    sget-object v3, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->SETTINGS:Ljava/lang/Class;

    const-string v4, "VIDEO_SLOW_MO_RES_AND_FRAME_RATE"

    .line 575
    invoke-static {v3, v4}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    .line 576
    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x4

    if-ge v1, v2, :cond_2

    aget-object v2, v0, v1

    .line 577
    if-nez v2, :cond_0

    goto :goto_3

    .line 579
    :cond_0
    :try_start_0
    monitor-enter v2
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    .line 580
    :try_start_1
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "mListeners"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Set;

    .line 581
    if-eqz p1, :cond_1

    invoke-interface {v3, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    invoke-interface {v3, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 582
    :goto_1
    monitor-exit v2

    goto :goto_2

    :catchall_0
    move-exception v3

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v3
    :try_end_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_2 .. :try_end_2} :catch_0

    .line 583
    :catch_0
    move-exception v2

    :goto_2
    nop

    .line 576
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 585
    :cond_2
    return-void
.end method

.method private static setting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 588
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 590
    :cond_0
    :try_start_0
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    .line 591
    const-string v1, "get"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {p1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {p0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    invoke-virtual {p1, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 592
    :catch_0
    move-exception p0

    return-object v0
.end method
