.class final enum Lcom/motorola/camera/custom/TelemetryCollector$Stream;
.super Ljava/lang/Enum;
.source "TelemetryCollector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/TelemetryCollector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "Stream"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/motorola/camera/custom/TelemetryCollector$Stream;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

.field public static final enum TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;


# direct methods
.method private static synthetic $values()[Lcom/motorola/camera/custom/TelemetryCollector$Stream;
    .locals 6

    .line 131
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v1, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v2, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v3, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v4, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    sget-object v5, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    filled-new-array/range {v0 .. v5}, [Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 131
    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "GYRO"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->GYRO:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "ACCEL"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ACCEL:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "ROTATION"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ROTATION:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "RGB"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->RGB:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "ALS"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->ALS:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    new-instance v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    const-string v1, "TOF"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->TOF:Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {}, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->$values()[Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->$VALUES:[Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 131
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/motorola/camera/custom/TelemetryCollector$Stream;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    .line 131
    const-class v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-object p0
.end method

.method public static values()[Lcom/motorola/camera/custom/TelemetryCollector$Stream;
    .locals 1

    .line 131
    sget-object v0, Lcom/motorola/camera/custom/TelemetryCollector$Stream;->$VALUES:[Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    invoke-virtual {v0}, [Lcom/motorola/camera/custom/TelemetryCollector$Stream;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/motorola/camera/custom/TelemetryCollector$Stream;

    return-object v0
.end method
