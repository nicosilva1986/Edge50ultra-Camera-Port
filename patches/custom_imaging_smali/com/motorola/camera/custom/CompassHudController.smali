.class public final Lcom/motorola/camera/custom/CompassHudController;
.super Ljava/lang/Object;
.source "CompassHudController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/CompassHudController$Pill;,
        Lcom/motorola/camera/custom/CompassHudController$Stream;,
        Lcom/motorola/camera/custom/CompassHudController$Roadstr;,
        Lcom/motorola/camera/custom/CompassHudController$SensorBasis;,
        Lcom/motorola/camera/custom/CompassHudController$Sdk;
    }
.end annotation


# static fields
.field private static final BACKLIT:Ljava/lang/String; = "\u2600 Contraluz"

.field private static final BORDER_SUBTLE:I = 0x29ffffff

.field private static final GEO_LOCATION_PREF:Ljava/lang/String; = "com.motorola.camera.geo_location_state"

.field private static final PREF_CHANGE:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

.field public static final PREF_KEY_ENABLED:Ljava/lang/String; = "port_compass_hud"

.field private static final PROVIDERS:[Ljava/lang/String;

.field private static final ROOT:I = 0x7f0a0283

.field private static final SURFACE_GLASS:I = -0x1ce4dfd7

.field private static final TAG:Ljava/lang/String; = "compass-hud-pill"

.field private static final TEXT_PRIMARY:I = -0xe0f0c

.field private static final TEXT_SECONDARY:I = -0x470e0f0c

.field private static final TEXT_WARN:I = -0x3380

.field private static final UI_INTERVAL_NS:J = 0x3ef1480L

.field private static current:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/motorola/camera/custom/CompassHudController$Pill;",
            ">;"
        }
    .end annotation
.end field

.field private static observedPrefs:Landroid/content/SharedPreferences;

.field private static orientation:I

.field private static resumed:Z

.field private static volatile stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

.field private static uiThread:Ljava/lang/Thread;


# direct methods
.method public static synthetic $r8$lambda$WyPVLejesuHzH_of6TMdBxJxV6w()V
    .locals 0

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->reconcile()V

    return-void
.end method

.method static bridge synthetic -$$Nest$sfgetPROVIDERS()[Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->PROVIDERS:[Ljava/lang/String;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetcurrent()Ljava/lang/ref/WeakReference;
    .locals 1

    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$sfgetorientation()I
    .locals 1

    sget v0, Lcom/motorola/camera/custom/CompassHudController;->orientation:I

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetstream()Lcom/motorola/camera/custom/CompassHudController$Stream;
    .locals 1

    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    return-object v0
.end method

.method static bridge synthetic -$$Nest$smcall(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/CompassHudController;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smisSaveLocationAllowed()Z
    .locals 1

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->isSaveLocationAllowed()Z

    move-result v0

    return v0
.end method

.method static bridge synthetic -$$Nest$smlabel(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;DLcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZD)Ljava/lang/String;
    .locals 0

    invoke-static/range {p0 .. p8}, Lcom/motorola/camera/custom/CompassHudController;->label(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;DLcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZD)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smlistener(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Runnable;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/CompassHudController;->listener(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smmethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/CompassHudController;->method(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smreconcile()V
    .locals 0

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->reconcile()V

    return-void
.end method

.method static bridge synthetic -$$Nest$smstopStream()V
    .locals 0

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    return-void
.end method

.method static bridge synthetic -$$Nest$smtype(Ljava/lang/String;)Ljava/lang/Class;
    .locals 0

    invoke-static {p0}, Lcom/motorola/camera/custom/CompassHudController;->type(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$smvalidFix(Landroid/location/Location;J)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/motorola/camera/custom/CompassHudController;->validFix(Landroid/location/Location;J)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$smwrap(D)D
    .locals 0

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide p0

    return-wide p0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 41
    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    .line 47
    new-instance v0, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda0;-><init>()V

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController;->PREF_CHANGE:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 370
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "passive"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "gps"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "network"

    aput-object v2, v0, v1

    sput-object v0, Lcom/motorola/camera/custom/CompassHudController;->PROVIDERS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized attach(Landroid/app/Activity;)V
    .locals 5

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 61
    if-nez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    const v1, 0x7f0a0283

    :try_start_0
    invoke-virtual {p0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p0

    .line 62
    :goto_0
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/custom/CompassHudController$Pill;

    .line 63
    if-eqz v1, :cond_1

    iget-object v2, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    if-ne v2, p0, :cond_1

    .line 64
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 65
    monitor-exit v0

    return-void

    .line 67
    :cond_1
    :try_start_1
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 68
    if-eqz v1, :cond_2

    .line 69
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->observeLayout(Z)V

    .line 70
    iget-object v2, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v2, v1}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    .line 72
    :cond_2
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->clear()V

    .line 73
    instance-of v1, p0, Landroid/widget/RelativeLayout;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v1, :cond_3

    monitor-exit v0

    return-void

    .line 74
    :cond_3
    :try_start_2
    check-cast p0, Landroid/widget/RelativeLayout;

    .line 75
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    sput-object v1, Lcom/motorola/camera/custom/CompassHudController;->uiThread:Ljava/lang/Thread;

    .line 76
    const-string v1, "compass-hud-pill"

    invoke-virtual {p0, v1}, Landroid/widget/RelativeLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 78
    instance-of v2, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;

    if-eqz v2, :cond_4

    .line 79
    check-cast v1, Lcom/motorola/camera/custom/CompassHudController$Pill;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 81
    :cond_4
    if-eqz v1, :cond_5

    monitor-exit v0

    return-void

    .line 82
    :cond_5
    :try_start_3
    new-instance v1, Lcom/motorola/camera/custom/CompassHudController$Pill;

    invoke-direct {v1, p0}, Lcom/motorola/camera/custom/CompassHudController$Pill;-><init>(Landroid/widget/RelativeLayout;)V

    .line 83
    new-instance v2, Landroid/widget/RelativeLayout$LayoutParams;

    const/16 v3, 0x1c

    invoke-virtual {v1, v3}, Lcom/motorola/camera/custom/CompassHudController$Pill;->dp(I)I

    move-result v3

    const/4 v4, -0x2

    invoke-direct {v2, v4, v3}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v1, v2}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 85
    :goto_1
    new-instance p0, Ljava/lang/ref/WeakReference;

    invoke-direct {p0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object p0, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    .line 86
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 87
    monitor-exit v0

    return-void

    .line 60
    :catchall_0
    move-exception p0

    :try_start_4
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw p0
.end method

.method private static varargs call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 638
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 639
    :cond_0
    :try_start_0
    invoke-virtual {p0, p1, p2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 640
    :catch_0
    move-exception p0

    return-object v0
.end method

.method public static formatHudText(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZ)Ljava/lang/String;
    .locals 11

    .line 238
    if-nez p0, :cond_0

    const-wide/high16 v0, 0x7ff8000000000000L    # Double.NaN

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->headingDeg:F

    float-to-double v0, v0

    :goto_0
    move-wide v3, v0

    .line 239
    move-wide v9, v3

    move-object v2, p0

    move-object v5, p1

    move-wide v6, p2

    move v8, p4

    invoke-static/range {v2 .. v10}, Lcom/motorola/camera/custom/CompassHudController;->label(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;DLcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZD)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static isEnabled(Landroid/content/Context;)Z
    .locals 2

    .line 126
    const-string p0, "port_compass_hud"

    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 127
    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    .line 129
    :cond_0
    :try_start_0
    invoke-interface {v0, p0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    .line 130
    :catch_0
    move-exception v1

    .line 131
    const-string v1, "true"

    invoke-interface {v0, p0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private static isSaveLocationAllowed()Z
    .locals 6

    .line 604
    const-string v0, "com.motorola.camera.geo_location_state"

    const/4 v1, 0x1

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 605
    if-eqz v2, :cond_1

    .line 607
    const/4 v3, 0x0

    :try_start_1
    invoke-interface {v2, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0
    :try_end_1
    .catch Ljava/lang/ClassCastException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    if-nez v0, :cond_0

    return v3

    .line 610
    :cond_0
    goto :goto_0

    .line 608
    :catch_0
    move-exception v4

    .line 609
    :try_start_2
    const-string v4, "false"

    const-string v5, "true"

    invoke-interface {v2, v0, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    if-eqz v0, :cond_1

    return v3

    .line 612
    :catch_1
    move-exception v0

    :cond_1
    :goto_0
    nop

    .line 613
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->SETTINGS:Ljava/lang/Class;

    const-string v3, "GEO_LOCATION_STATE"

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->-$$Nest$smsetting(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/CompassHudController;->settingValue(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    xor-int/2addr v0, v1

    return v0
.end method

.method private static label(Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;DLcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;DZD)Ljava/lang/String;
    .locals 19

    .line 244
    move-object/from16 v0, p0

    move-object/from16 v1, p3

    if-eqz v0, :cond_6

    invoke-static/range {p1 .. p2}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-nez v2, :cond_0

    goto/16 :goto_2

    .line 245
    :cond_0
    invoke-static/range {p1 .. p2}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassSolarHelper;->formatHeadingLabel(D)Ljava/lang/String;

    move-result-object v2

    .line 246
    iget v3, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->accuracy:I

    const/4 v4, 0x2

    if-ge v3, v4, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 Calibrar"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 247
    :cond_1
    if-eqz p6, :cond_5

    if-eqz v1, :cond_5

    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->azimuthDeg:D

    invoke-static {v3, v4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    .line 248
    invoke-static {v3, v4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    const-wide/high16 v5, -0x4000000000000000L    # -2.0

    cmpg-double v3, v3, v5

    if-lez v3, :cond_5

    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    const-wide v5, 0x4056800000000000L    # 90.0

    cmpl-double v3, v3, v5

    if-lez v3, :cond_2

    goto/16 :goto_1

    .line 249
    :cond_2
    invoke-static/range {p7 .. p8}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-static/range {p4 .. p5}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_3

    const-wide/high16 v3, 0x4026000000000000L    # 11.0

    cmpl-double v3, p4, v3

    if-ltz v3, :cond_3

    iget v3, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    float-to-double v3, v3

    invoke-static {v3, v4}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_3

    iget v3, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    .line 250
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/high16 v4, 0x42b40000    # 90.0f

    cmpg-float v3, v3, v4

    if-gtz v3, :cond_3

    .line 251
    iget v3, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->pitchDeg:F

    float-to-double v6, v3

    iget-wide v8, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->azimuthDeg:D

    iget-wide v10, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    move-wide/from16 v4, p7

    invoke-static/range {v4 .. v11}, Lcom/motorola/camera/custom/CompassSolarHelper;->angularSeparationDeg(DDDD)D

    move-result-wide v16

    .line 253
    invoke-static/range {v16 .. v17}, Ljava/lang/Double;->isFinite(D)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-wide v14, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    iget v0, v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;->accuracy:I

    .line 254
    move-wide/from16 v12, p4

    move/from16 v18, v0

    invoke-static/range {v12 .. v18}, Lcom/motorola/camera/custom/CompassSolarHelper;->isPhysicalOutdoorBacklit(DDDI)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 255
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " \u00b7 \u2600 Contraluz"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 257
    :cond_3
    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    const-wide/16 v5, 0x0

    cmpg-double v0, v3, v5

    if-gez v0, :cond_4

    const-string v0, "\u2198 "

    goto :goto_0

    :cond_4
    const-string v0, "\u2197 "

    :goto_0
    iget-wide v3, v1, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;->elevationDeg:D

    invoke-static {v3, v4}, Ljava/lang/Math;->round(D)J

    move-result-wide v3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \u00b7 \u2600 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u00b0"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 248
    :cond_5
    :goto_1
    return-object v2

    .line 244
    :cond_6
    :goto_2
    const-string v0, ""

    return-object v0
.end method

.method static synthetic lambda$listener$1(Ljava/lang/String;Ljava/lang/Runnable;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 526
    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p3

    .line 527
    invoke-virtual {p3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    const/4 p0, 0x0

    return-object p0

    .line 528
    :cond_0
    const-string p0, "hashCode"

    invoke-virtual {p3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-static {p2}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    .line 529
    :cond_1
    const-string p0, "equals"

    invoke-virtual {p3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_3

    const/4 p0, 0x0

    aget-object p1, p4, p0

    if-ne p2, p1, :cond_2

    const/4 p0, 0x1

    :cond_2
    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    .line 530
    :cond_3
    const-string p0, "compass-hud-pill"

    return-object p0
.end method

.method static synthetic lambda$static$0(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 2

    .line 48
    if-eqz p1, :cond_0

    const-string p0, "port_compass_hud"

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_0

    const-string p0, "com.motorola.camera.geo_location_state"

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    .line 49
    :cond_0
    sget-object p0, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    .line 50
    if-eqz p0, :cond_1

    .line 51
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastFixCheck:J

    .line 52
    iput-wide v0, p0, Lcom/motorola/camera/custom/CompassHudController$Stream;->lastPaint:J

    .line 54
    :cond_1
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V

    .line 56
    :cond_2
    return-void
.end method

.method private static listener(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Runnable;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "Ljava/lang/Runnable;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 524
    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    new-instance p0, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda1;

    invoke-direct {p0, p1, p2}, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;Ljava/lang/Runnable;)V

    invoke-static {v0, v1, p0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static varargs method(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Method;"
        }
    .end annotation

    .line 631
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 632
    :cond_0
    array-length v1, p2

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p2, v2

    if-nez v3, :cond_1

    return-object v0

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 633
    :cond_2
    :try_start_0
    invoke-virtual {p0, p1, p2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 634
    :catch_0
    move-exception p0

    return-object v0
.end method

.method public static declared-synchronized onModeChanged()V
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 107
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 108
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 109
    monitor-exit v0

    return-void

    .line 106
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized onOrientation(I)V
    .locals 2

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 112
    if-gez p0, :cond_0

    monitor-exit v0

    return-void

    .line 113
    :cond_0
    :try_start_0
    rem-int/lit16 p0, p0, 0x168

    add-int/lit8 p0, p0, 0x2d

    div-int/lit8 p0, p0, 0x5a

    mul-int/lit8 p0, p0, 0x5a

    rem-int/lit16 p0, p0, 0x168

    .line 114
    sget v1, Lcom/motorola/camera/custom/CompassHudController;->orientation:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne p0, v1, :cond_1

    monitor-exit v0

    return-void

    .line 115
    :cond_1
    :try_start_1
    sput p0, Lcom/motorola/camera/custom/CompassHudController;->orientation:I

    .line 116
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 117
    monitor-exit v0

    return-void

    .line 111
    :catchall_0
    move-exception p0

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method public static declared-synchronized onPause()V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 99
    const/4 v1, 0x0

    :try_start_0
    sput-boolean v1, Lcom/motorola/camera/custom/CompassHudController;->resumed:Z

    .line 100
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 101
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController;->PREF_CHANGE:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 102
    :cond_0
    const/4 v1, 0x0

    sput-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    .line 103
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 104
    monitor-exit v0

    return-void

    .line 98
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public static declared-synchronized onResume()V
    .locals 3

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 90
    const/4 v1, 0x1

    :try_start_0
    sput-boolean v1, Lcom/motorola/camera/custom/CompassHudController;->resumed:Z

    .line 91
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    if-nez v1, :cond_0

    .line 92
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    sput-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    .line 93
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->observedPrefs:Landroid/content/SharedPreferences;

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController;->PREF_CHANGE:Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 95
    :cond_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 96
    monitor-exit v0

    return-void

    .line 89
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private static declared-synchronized reconcile()V
    .locals 6

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 164
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/custom/CompassHudController$Pill;

    .line 165
    if-nez v1, :cond_0

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    .line 166
    :cond_0
    :try_start_1
    sget-boolean v2, Lcom/motorola/camera/custom/CompassHudController;->resumed:Z

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/CompassHudController;->isEnabled(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_1

    move v2, v3

    goto :goto_0

    :cond_1
    move v2, v4

    .line 167
    :goto_0
    invoke-virtual {v1, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->observeLayout(Z)V

    .line 168
    if-eqz v2, :cond_9

    iget-object v2, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    invoke-virtual {v2}, Landroid/widget/RelativeLayout;->isAttachedToWindow()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->previewShown()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->showsInCurrentMode()Z

    move-result v2

    if-eqz v2, :cond_9

    .line 169
    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->panelShown()Z

    move-result v2

    if-nez v2, :cond_9

    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->place()Z

    move-result v2

    if-nez v2, :cond_2

    goto :goto_1

    .line 175
    :cond_2
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isCurrentFrontCamera()Z

    move-result v2

    .line 176
    sget-object v4, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    if-eqz v4, :cond_3

    sget-object v4, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    iget-boolean v4, v4, Lcom/motorola/camera/custom/CompassHudController$Stream;->front:Z

    if-eq v4, v2, :cond_3

    .line 177
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 179
    :cond_3
    sget-object v4, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    if-nez v4, :cond_6

    iget-boolean v4, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->triedSensor:Z

    if-nez v4, :cond_6

    .line 180
    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->getContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "sensor"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    .line 181
    instance-of v5, v4, Landroid/hardware/SensorManager;

    if-eqz v5, :cond_5

    .line 182
    check-cast v4, Landroid/hardware/SensorManager;

    .line 183
    new-instance v5, Lcom/motorola/camera/custom/CompassHudController$Stream;

    invoke-direct {v5, v4, v2}, Lcom/motorola/camera/custom/CompassHudController$Stream;-><init>(Landroid/hardware/SensorManager;Z)V

    .line 184
    const/16 v2, 0xb

    invoke-virtual {v5, v2}, Lcom/motorola/camera/custom/CompassHudController$Stream;->register(I)Z

    move-result v2

    if-nez v2, :cond_4

    .line 185
    const/16 v2, 0x14

    invoke-virtual {v5, v2}, Lcom/motorola/camera/custom/CompassHudController$Stream;->register(I)Z

    move-result v2

    if-eqz v2, :cond_5

    :cond_4
    sput-object v5, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    .line 187
    :cond_5
    iput-boolean v3, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->triedSensor:Z

    .line 189
    :cond_6
    sget-object v2, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    if-eqz v2, :cond_7

    sget-object v2, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    iget-wide v2, v2, Lcom/motorola/camera/custom/CompassHudController$Stream;->heading:D

    invoke-static {v2, v3}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-nez v2, :cond_8

    :cond_7
    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->hide()V

    .line 190
    :cond_8
    sget v2, Lcom/motorola/camera/custom/CompassHudController;->orientation:I

    neg-int v2, v2

    invoke-virtual {v1, v2}, Lcom/motorola/camera/custom/CompassHudController$Pill;->rotateTo(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 191
    monitor-exit v0

    return-void

    .line 170
    :cond_9
    :goto_1
    :try_start_2
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 171
    iput-boolean v4, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->triedSensor:Z

    .line 172
    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->hide()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 173
    monitor-exit v0

    return-void

    .line 163
    :catchall_0
    move-exception v1

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v1
.end method

.method public static declared-synchronized refreshVisibility()V
    .locals 4

    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter v0

    .line 156
    :try_start_0
    sget-object v1, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/motorola/camera/custom/CompassHudController$Pill;

    .line 157
    if-nez v1, :cond_0

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-void

    .line 158
    :cond_0
    :try_start_1
    sget-boolean v2, Lcom/motorola/camera/custom/CompassHudController;->resumed:Z

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Lcom/motorola/camera/custom/CompassHudController$Pill;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/motorola/camera/custom/CompassHudController;->isEnabled(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    :cond_1
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 159
    :cond_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    sget-object v3, Lcom/motorola/camera/custom/CompassHudController;->uiThread:Ljava/lang/Thread;

    if-ne v2, v3, :cond_3

    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->reconcile()V

    goto :goto_0

    .line 160
    :cond_3
    iget-object v1, v1, Lcom/motorola/camera/custom/CompassHudController$Pill;->root:Landroid/widget/RelativeLayout;

    new-instance v2, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda2;

    invoke-direct {v2}, Lcom/motorola/camera/custom/CompassHudController$$ExternalSyntheticLambda2;-><init>()V

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 161
    :goto_0
    monitor-exit v0

    return-void

    .line 155
    :catchall_0
    move-exception v1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method static renderDue(JJ)Z
    .locals 3

    .line 204
    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-ltz v2, :cond_1

    cmp-long v0, p0, v0

    if-ltz v0, :cond_0

    cmp-long v0, p2, p0

    if-ltz v0, :cond_1

    sub-long/2addr p2, p0

    const-wide/32 p0, 0x3ef1480

    cmp-long p0, p2, p0

    if-ltz p0, :cond_1

    :cond_0
    const/4 p0, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static rotationDestination(FI)F
    .locals 3

    .line 219
    int-to-float p1, p1

    sub-float/2addr p1, p0

    const/high16 v0, 0x43340000    # 180.0f

    add-float/2addr p1, v0

    float-to-double v1, p1

    invoke-static {v1, v2}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide v1

    double-to-float p1, v1

    add-float/2addr p0, p1

    sub-float/2addr p0, v0

    return p0
.end method

.method static safeCenterY(IIIIII)I
    .locals 5

    .line 228
    const/4 v0, -0x1

    if-lez p0, :cond_3

    if-lez p1, :cond_3

    if-lez p2, :cond_3

    if-lez p3, :cond_3

    if-ltz p4, :cond_3

    if-gt p5, p1, :cond_3

    if-gt p5, p4, :cond_0

    goto :goto_1

    .line 230
    :cond_0
    int-to-double p1, p2

    int-to-double v1, p3

    invoke-static {p1, p2, v1, v2}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide p1

    const-wide/high16 v1, 0x3fe0000000000000L    # 0.5

    mul-double/2addr p1, v1

    invoke-static {p1, p2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide p1

    double-to-long p1, p1

    .line 231
    const-wide/16 v1, 0x2

    mul-long/2addr v1, p1

    int-to-long v3, p0

    cmp-long p0, v1, v3

    if-gtz p0, :cond_2

    sub-int/2addr p5, p4

    int-to-long v3, p5

    cmp-long p0, v1, v3

    if-lez p0, :cond_1

    goto :goto_0

    .line 232
    :cond_1
    int-to-long p3, p4

    add-long/2addr p3, p1

    long-to-int p0, p3

    return p0

    .line 231
    :cond_2
    :goto_0
    return v0

    .line 229
    :cond_3
    :goto_1
    return v0
.end method

.method static sensorOrientation([FIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;
    .locals 18

    .line 275
    move-object/from16 v0, p0

    if-eqz v0, :cond_5

    array-length v2, v0

    const/4 v3, 0x3

    if-ge v2, v3, :cond_0

    const/4 v11, 0x0

    goto/16 :goto_3

    .line 276
    :cond_0
    const/4 v2, 0x0

    aget v4, v0, v2

    const/4 v5, 0x1

    aget v6, v0, v5

    const/4 v7, 0x2

    aget v8, v0, v7

    .line 277
    float-to-double v9, v4

    mul-double/2addr v9, v9

    float-to-double v11, v6

    mul-double/2addr v11, v11

    add-double/2addr v9, v11

    float-to-double v11, v8

    mul-double/2addr v11, v11

    add-double/2addr v9, v11

    .line 278
    array-length v11, v0

    const-wide/high16 v12, 0x3ff0000000000000L    # 1.0

    const/4 v14, 0x4

    if-lt v11, v14, :cond_1

    aget v11, v0, v3

    move v15, v2

    move/from16 v16, v3

    move/from16 v17, v4

    move v1, v11

    const/4 v11, 0x0

    goto :goto_0

    :cond_1
    move v15, v2

    const/4 v11, 0x0

    const-wide/16 v1, 0x0

    move/from16 v16, v3

    move/from16 v17, v4

    sub-double v3, v12, v9

    invoke-static {v1, v2, v3, v4}, Ljava/lang/Math;->max(DD)D

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v1

    double-to-float v1, v1

    .line 279
    :goto_0
    float-to-double v2, v1

    mul-double/2addr v2, v2

    add-double/2addr v9, v2

    .line 280
    invoke-static {v9, v10}, Ljava/lang/Double;->isFinite(D)Z

    move-result v2

    if-eqz v2, :cond_4

    sub-double/2addr v9, v12

    invoke-static {v9, v10}, Ljava/lang/Math;->abs(D)D

    move-result-wide v2

    const-wide v9, 0x3f947ae147ae147bL    # 0.02

    cmpl-double v2, v2, v9

    if-lez v2, :cond_2

    goto :goto_2

    .line 281
    :cond_2
    sget-boolean v2, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->UPRIGHT_REFERENCE:Z

    if-eqz v2, :cond_3

    .line 283
    sget v0, Lcom/motorola/camera/custom/CompassHudController$SensorBasis;->HALF:F

    .line 284
    new-array v2, v14, [F

    sub-float v4, v17, v1

    mul-float/2addr v4, v0

    aput v4, v2, v15

    add-float v3, v6, v8

    mul-float/2addr v3, v0

    aput v3, v2, v5

    sub-float/2addr v8, v6

    mul-float/2addr v8, v0

    aput v8, v2, v7

    add-float v1, v1, v17

    mul-float/2addr v0, v1

    aput v0, v2, v16

    move-object v3, v2

    goto :goto_1

    .line 281
    :cond_3
    move-object v3, v0

    .line 286
    :goto_1
    array-length v4, v3

    move/from16 v5, p1

    move/from16 v6, p2

    move/from16 v7, p3

    move-wide/from16 v8, p4

    invoke-static/range {v3 .. v9}, Lcom/motorola/camera/custom/CompassSolarHelper;->computeOrientation([FIIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    move-result-object v0

    return-object v0

    .line 280
    :cond_4
    :goto_2
    return-object v11

    .line 275
    :cond_5
    const/4 v11, 0x0

    :goto_3
    return-object v11
.end method

.method public static declared-synchronized setEnabled(Landroid/content/Context;Z)V
    .locals 2

    const-class p0, Lcom/motorola/camera/custom/CompassHudController;

    monitor-enter p0

    .line 136
    if-nez p1, :cond_0

    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->stopStream()V

    .line 137
    :cond_0
    invoke-static {}, Lcom/motorola/camera/settings/PersistBehavior;->getPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 138
    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "port_compass_hud"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 139
    :cond_1
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController;->refreshVisibility()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 140
    monitor-exit p0

    return-void

    .line 135
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private static settingValue(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    .line 617
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 619
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "mValue"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 620
    :catch_0
    move-exception p0

    .line 621
    return-object v0
.end method

.method public static showsInCurrentMode()Z
    .locals 5

    .line 143
    invoke-static {}, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->menuOpen()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 144
    :cond_0
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPhotoMode()Z

    move-result v0

    const/4 v2, 0x1

    if-nez v0, :cond_5

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isPortraitMode()Z

    move-result v0

    if-nez v0, :cond_5

    .line 145
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isProPhotoMode()Z

    move-result v0

    if-nez v0, :cond_5

    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isNightVisionMode()Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    .line 146
    :cond_1
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController$Roadstr;->CURRENT_MODE:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v0, v3, v4}, Lcom/motorola/camera/custom/CompassHudController;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 148
    instance-of v3, v0, Ljava/lang/Integer;

    if-eqz v3, :cond_4

    .line 149
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 150
    if-eq v0, v2, :cond_2

    const/4 v3, 0x2

    if-eq v0, v3, :cond_2

    const/16 v3, 0x1d

    if-eq v0, v3, :cond_2

    const/16 v3, 0x23

    if-ne v0, v3, :cond_3

    :cond_2
    move v1, v2

    :cond_3
    return v1

    .line 152
    :cond_4
    invoke-static {}, Lcom/motorola/camera/settings/SettingsHelper;->isTenBitVideoMode()Z

    move-result v0

    return v0

    .line 145
    :cond_5
    :goto_0
    return v2
.end method

.method static smoothHeading(DD)D
    .locals 9

    .line 208
    invoke-static {p2, p3}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-nez v0, :cond_0

    return-wide p0

    .line 209
    :cond_0
    const-wide v0, 0x4076800000000000L    # 360.0

    rem-double v2, p2, v0

    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 210
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-static {p2, p3}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide p0

    return-wide p0

    .line 211
    :cond_1
    rem-double v0, p0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    .line 213
    sub-double v4, v2, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->cos(D)D

    move-result-wide v4

    const-wide v6, -0x4010000218def417L    # -0.999999

    cmpg-double v4, v4, v6

    const-wide/high16 v5, 0x3fd0000000000000L    # 0.25

    if-gez v4, :cond_2

    sub-double/2addr p2, p0

    const-wide v0, 0x4066800000000000L    # 180.0

    add-double/2addr p2, v0

    invoke-static {p2, p3}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide p2

    sub-double/2addr p2, v0

    mul-double/2addr p2, v5

    add-double/2addr p0, p2

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide p0

    return-wide p0

    .line 214
    :cond_2
    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    const-wide/high16 p2, 0x3fe8000000000000L    # 0.75

    mul-double/2addr p0, p2

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v7

    mul-double/2addr v7, v5

    add-double/2addr p0, v7

    .line 215
    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    mul-double/2addr v0, p2

    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide p2

    mul-double/2addr p2, v5

    add-double/2addr v0, p2

    .line 214
    invoke-static {p0, p1, v0, v1}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassHudController;->wrap(D)D

    move-result-wide p0

    return-wide p0
.end method

.method private static stopStream()V
    .locals 2

    .line 194
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    .line 195
    const/4 v1, 0x0

    sput-object v1, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    .line 196
    if-eqz v0, :cond_0

    .line 197
    iget-object v1, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->manager:Landroid/hardware/SensorManager;

    invoke-virtual {v1, v0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 199
    :cond_0
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/motorola/camera/custom/CompassHudController$Pill;

    .line 200
    if-eqz v0, :cond_1

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/motorola/camera/custom/CompassHudController$Pill;->triedSensor:Z

    .line 201
    :cond_1
    return-void
.end method

.method private static type(Ljava/lang/String;)Ljava/lang/Class;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    .line 626
    :try_start_0
    const-class v0, Lcom/motorola/camera/custom/CompassHudController;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v1, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 627
    :catch_0
    move-exception p0

    const/4 p0, 0x0

    return-object p0
.end method

.method public static updateLatestEv100(D)V
    .locals 2

    .line 121
    sget-object v0, Lcom/motorola/camera/custom/CompassHudController;->stream:Lcom/motorola/camera/custom/CompassHudController$Stream;

    .line 122
    if-eqz v0, :cond_1

    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const-wide/high16 p0, 0x7ff8000000000000L    # Double.NaN

    :goto_0
    iput-wide p0, v0, Lcom/motorola/camera/custom/CompassHudController$Stream;->ev100:D

    .line 123
    :cond_1
    return-void
.end method

.method private static validFix(Landroid/location/Location;J)Z
    .locals 4

    .line 373
    invoke-virtual {p0}, Landroid/location/Location;->getLatitude()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x4056800000000000L    # 90.0

    cmpg-double v0, v0, v2

    if-gtz v0, :cond_0

    invoke-virtual {p0}, Landroid/location/Location;->getLongitude()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x4066800000000000L    # 180.0

    cmpg-double v0, v0, v2

    if-gtz v0, :cond_0

    .line 374
    invoke-virtual {p0}, Landroid/location/Location;->getTime()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    invoke-virtual {p0}, Landroid/location/Location;->getTime()J

    move-result-wide v0

    cmp-long v0, v0, p1

    if-gtz v0, :cond_0

    invoke-virtual {p0}, Landroid/location/Location;->getTime()J

    move-result-wide v0

    sub-long/2addr p1, v0

    const-wide/32 v0, 0x36ee80

    cmp-long p0, p1, v0

    if-gtz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    .line 373
    :goto_0
    return p0
.end method

.method private static wrap(D)D
    .locals 2

    .line 223
    const-wide v0, 0x4076800000000000L    # 360.0

    rem-double/2addr p0, v0

    add-double/2addr p0, v0

    rem-double/2addr p0, v0

    return-wide p0
.end method
