.class Lcom/motorola/camera/custom/CustomImagingBridge$6;
.super Ljava/util/LinkedHashMap;
.source "CustomImagingBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/CustomImagingBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedHashMap<",
        "Ljava/lang/String;",
        "Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>(IFZ)V
    .locals 0

    .line 2238
    invoke-direct {p0, p1, p2, p3}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    return-void
.end method


# virtual methods
.method protected removeEldestEntry(Ljava/util/Map$Entry;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry<",
            "Ljava/lang/String;",
            "Lcom/motorola/camera/custom/TelemetryCollector$CompassSnapshot;",
            ">;)Z"
        }
    .end annotation

    .line 2241
    invoke-virtual {p0}, Lcom/motorola/camera/custom/CustomImagingBridge$6;->size()I

    move-result p1

    const/16 v0, 0x10

    if-le p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
