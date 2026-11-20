.class public final Lcom/motorola/camera/shared/ai/model/LocalAiModelFallback;
.super Ljava/lang/Object;
.source "LocalAiModelFallback.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "LocalAiModelFallback"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static assetPathFor(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 11
    const-string v0, "GESTURE_AUTO_CAPTURE_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "ai_models/gesture_auto_capture_tflite_model-2.2.bin"

    return-object p0

    .line 12
    :cond_0
    const-string v0, "SCENE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p0, "ai_models/scene_detection_tflite_model-2.93.bin"

    return-object p0

    .line 13
    :cond_1
    const-string v0, "MOT_SCENE_DETECTION"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string p0, "ai_models/mot_scene_detection_model-8c8a2.bin"

    return-object p0

    .line 14
    :cond_2
    const-string v0, "SMILE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p0, "ai_models/smile_detection_tflite_model-1.2.bin"

    return-object p0

    .line 15
    :cond_3
    const-string v0, "EYE_CONTOUR_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string p0, "ai_models/eye_contour_tflite_model-1.3.bin"

    return-object p0

    .line 16
    :cond_4
    const-string v0, "DOC_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const-string p0, "ai_models/doc_scan_model-1.2.bin"

    return-object p0

    .line 17
    :cond_5
    const-string v0, "DOC_SHADOW_REMOVAL_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const-string p0, "ai_models/doc_shadow_removal_model-1.0.bin"

    return-object p0

    .line 18
    :cond_6
    const-string v0, "SLIDE_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const-string p0, "ai_models/slide_scan_model-1.0.bin"

    return-object p0

    .line 19
    :cond_7
    const-string v0, "SLIDE_AUTO_CAPTURE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_8

    const-string p0, "ai_models/slide_auto_capture_model-1.0.bin"

    return-object p0

    .line 20
    :cond_8
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getHash(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 38
    const-string v0, "GESTURE_AUTO_CAPTURE_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "7090b"

    return-object p0

    .line 39
    :cond_0
    const-string v0, "SCENE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p0, "ec3f9"

    return-object p0

    .line 40
    :cond_1
    const-string v0, "MOT_SCENE_DETECTION"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string p0, "8c8a2"

    return-object p0

    .line 41
    :cond_2
    const-string v0, "SMILE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p0, "fbb4e"

    return-object p0

    .line 42
    :cond_3
    const-string v0, "EYE_CONTOUR_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string p0, "9c758"

    return-object p0

    .line 43
    :cond_4
    const-string v0, "DOC_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    const-string p0, "00e24"

    return-object p0

    .line 44
    :cond_5
    const-string v0, "DOC_SHADOW_REMOVAL_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    const-string p0, "f8be3"

    return-object p0

    .line 45
    :cond_6
    const-string v0, "SLIDE_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const-string p0, "a4d7d"

    return-object p0

    .line 46
    :cond_7
    const-string v0, "SLIDE_AUTO_CAPTURE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_8

    const-string p0, "2a81c"

    return-object p0

    .line 47
    :cond_8
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getVersion(Ljava/lang/String;I)I
    .locals 2

    .line 51
    const-string v0, "GESTURE_AUTO_CAPTURE_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 p0, 0xca

    return p0

    .line 52
    :cond_0
    const-string v0, "SCENE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/16 p0, 0x125

    return p0

    .line 53
    :cond_1
    const-string v0, "MOT_SCENE_DETECTION"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 p0, 0x12e

    return p0

    .line 54
    :cond_2
    const-string v0, "SMILE_DETECTION_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/16 v1, 0x66

    if-eqz v0, :cond_3

    return v1

    .line 55
    :cond_3
    const-string v0, "EYE_CONTOUR_TFLITE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/16 p0, 0x67

    return p0

    .line 56
    :cond_4
    const-string v0, "DOC_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    return v1

    .line 57
    :cond_5
    const-string v0, "DOC_SHADOW_REMOVAL_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/16 v1, 0x64

    if-eqz v0, :cond_6

    return v1

    .line 58
    :cond_6
    const-string v0, "SLIDE_SCAN_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    return v1

    .line 59
    :cond_7
    const-string v0, "SLIDE_AUTO_CAPTURE_MODEL"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_8

    return v1

    .line 60
    :cond_8
    return p1
.end method

.method public static openAssetFd(Landroid/content/Context;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    .locals 5

    .line 24
    const-string v0, "LocalAiModelFallback"

    const/4 v1, 0x0

    if-eqz p0, :cond_2

    if-nez p1, :cond_0

    goto :goto_0

    .line 25
    :cond_0
    invoke-static {p1}, Lcom/motorola/camera/shared/ai/model/LocalAiModelFallback;->assetPathFor(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 26
    if-nez v2, :cond_1

    return-object v1

    .line 28
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    invoke-virtual {p0, v2}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object p0

    .line 29
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Loaded local AI model asset: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    return-object p0

    .line 31
    :catchall_0
    move-exception p0

    .line 32
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed opening local AI model asset: "

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 33
    return-object v1

    .line 24
    :cond_2
    :goto_0
    return-object v1
.end method
