.class final Lcom/motorola/camera/custom/LiveLookPreview$GlState;
.super Ljava/lang/Object;
.source "LiveLookPreview.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/camera/custom/LiveLookPreview;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "GlState"
.end annotation


# instance fields
.field final context:Landroid/opengl/EGLContext;

.field final programs:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/motorola/camera/ui/widgets/gl/Shader;",
            "[I>;"
        }
    .end annotation
.end field

.field final scratch:[I

.field texture:I

.field uploaded:Lcom/motorola/camera/custom/LiveLookPreview$LookTexture;


# direct methods
.method constructor <init>(Landroid/opengl/EGLContext;)V
    .locals 1

    .line 132
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 127
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    iput-object v0, p0, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->programs:Ljava/util/Map;

    .line 128
    const/4 v0, 0x1

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->scratch:[I

    .line 133
    iput-object p1, p0, Lcom/motorola/camera/custom/LiveLookPreview$GlState;->context:Landroid/opengl/EGLContext;

    .line 134
    return-void
.end method
