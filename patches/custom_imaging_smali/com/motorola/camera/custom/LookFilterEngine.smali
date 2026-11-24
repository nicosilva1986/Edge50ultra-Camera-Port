.class public final Lcom/motorola/camera/custom/LookFilterEngine;
.super Ljava/lang/Object;
.source "LookFilterEngine.java"


# static fields
.field private static final BLUE_STRIDE:I = 0xcc3

.field private static final BYTES:I = 0x1a523

.field private static final GREEN_STRIDE:I = 0x63

.field private static final RED_STRIDE:I = 0x3

.field private static final SIZE:I = 0x21


# instance fields
.field private final cube:[B


# direct methods
.method private constructor <init>([B)V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    iput-object p1, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    .line 17
    return-void
.end method

.method private blend(IIIIIIIII)I
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    aget-byte p3, v0, p3

    and-int/lit16 p3, p3, 0xff

    rsub-int v0, p7, 0xff

    mul-int/2addr p3, v0

    iget-object v0, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    aget-byte p4, v0, p4

    and-int/lit16 p4, p4, 0xff

    sub-int/2addr p7, p8

    mul-int/2addr p4, p7

    add-int/2addr p3, p4

    iget-object p4, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    aget-byte p4, p4, p5

    and-int/lit16 p4, p4, 0xff

    sub-int/2addr p8, p9

    mul-int/2addr p4, p8

    add-int/2addr p3, p4

    iget-object p4, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    aget-byte p4, p4, p6

    and-int/lit16 p4, p4, 0xff

    mul-int/2addr p4, p9

    add-int/2addr p3, p4

    .line 91
    mul-int/2addr p3, p2

    rsub-int/lit8 p2, p2, 0x64

    mul-int/2addr p1, p2

    mul-int/lit16 p1, p1, 0xff

    add-int/2addr p3, p1

    add-int/lit16 p3, p3, 0x31ce

    div-int/lit16 p3, p3, 0x639c

    return p3
.end method

.method public static read(Ljava/io/InputStream;)Lcom/motorola/camera/custom/LookFilterEngine;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 20
    const v0, 0x1a523

    new-array v1, v0, [B

    .line 21
    const/4 v2, 0x0

    .line 22
    :goto_0
    if-ge v2, v0, :cond_3

    .line 23
    sub-int v3, v0, v2

    invoke-virtual {p0, v1, v2, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 24
    const-string v4, "Truncated look cube"

    if-ltz v3, :cond_2

    .line 25
    if-nez v3, :cond_1

    .line 26
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v3

    .line 27
    if-ltz v3, :cond_0

    .line 28
    add-int/lit8 v4, v2, 0x1

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 29
    move v2, v4

    goto :goto_1

    .line 27
    :cond_0
    new-instance p0, Ljava/io/IOException;

    invoke-direct {p0, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 30
    :cond_1
    add-int/2addr v2, v3

    .line 32
    :goto_1
    goto :goto_0

    .line 24
    :cond_2
    new-instance p0, Ljava/io/IOException;

    invoke-direct {p0, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 33
    :cond_3
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result p0

    const/4 v0, -0x1

    if-ne p0, v0, :cond_4

    .line 34
    new-instance p0, Lcom/motorola/camera/custom/LookFilterEngine;

    invoke-direct {p0, v1}, Lcom/motorola/camera/custom/LookFilterEngine;-><init>([B)V

    return-object p0

    .line 33
    :cond_4
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Oversized look cube"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public apply([IIII)V
    .locals 20

    .line 45
    const/16 v0, 0x64

    move/from16 v1, p4

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 46
    if-nez v4, :cond_0

    return-void

    .line 47
    :cond_0
    move/from16 v0, p2

    :goto_0
    add-int v1, p2, p3

    if-ge v0, v1, :cond_4

    .line 48
    aget v1, p1, v0

    .line 49
    ushr-int/lit8 v2, v1, 0x10

    and-int/lit16 v3, v2, 0xff

    .line 50
    ushr-int/lit8 v2, v1, 0x8

    and-int/lit16 v12, v2, 0xff

    .line 51
    and-int/lit16 v13, v1, 0xff

    .line 53
    mul-int/lit8 v2, v3, 0x20

    .line 54
    mul-int/lit8 v5, v12, 0x20

    .line 55
    mul-int/lit8 v6, v13, 0x20

    .line 56
    div-int/lit16 v7, v2, 0xff

    const/16 v8, 0x1f

    invoke-static {v7, v8}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 57
    div-int/lit16 v9, v5, 0xff

    invoke-static {v9, v8}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 58
    div-int/lit16 v10, v6, 0xff

    invoke-static {v10, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 59
    mul-int/lit8 v10, v7, 0x3

    mul-int/lit8 v11, v9, 0x63

    add-int/2addr v10, v11

    mul-int/lit16 v11, v8, 0xcc3

    add-int/2addr v10, v11

    .line 60
    mul-int/lit16 v7, v7, 0xff

    sub-int/2addr v2, v7

    .line 61
    mul-int/lit16 v9, v9, 0xff

    sub-int/2addr v5, v9

    .line 62
    mul-int/lit16 v8, v8, 0xff

    sub-int/2addr v6, v8

    .line 63
    nop

    .line 64
    nop

    .line 65
    nop

    .line 66
    const/16 v7, 0x63

    const/4 v8, 0x3

    if-ge v2, v5, :cond_1

    .line 67
    nop

    .line 68
    move/from16 v19, v8

    move v8, v7

    move/from16 v7, v19

    goto :goto_1

    .line 66
    :cond_1
    move/from16 v19, v5

    move v5, v2

    move/from16 v2, v19

    .line 70
    :goto_1
    const/16 v9, 0xcc3

    if-ge v2, v6, :cond_2

    .line 71
    nop

    .line 72
    move v11, v9

    move v9, v7

    move v7, v11

    move v11, v2

    goto :goto_2

    .line 70
    :cond_2
    move v11, v6

    move v6, v2

    .line 74
    :goto_2
    if-ge v5, v6, :cond_3

    .line 75
    nop

    .line 76
    move v2, v8

    move v8, v7

    move v7, v2

    move v2, v10

    move v10, v5

    move v5, v6

    goto :goto_3

    .line 74
    :cond_3
    move v2, v10

    move v10, v6

    .line 78
    :goto_3
    add-int v6, v2, v8

    .line 79
    add-int/2addr v7, v6

    .line 80
    add-int v8, v7, v9

    .line 81
    move v9, v5

    move v5, v2

    move-object/from16 v2, p0

    invoke-direct/range {v2 .. v11}, Lcom/motorola/camera/custom/LookFilterEngine;->blend(IIIIIIIII)I

    move-result v14

    .line 82
    move v15, v5

    move/from16 v16, v6

    move/from16 v17, v7

    move/from16 v18, v8

    add-int/lit8 v5, v15, 0x1

    add-int/lit8 v6, v16, 0x1

    add-int/lit8 v7, v17, 0x1

    add-int/lit8 v8, v18, 0x1

    move v3, v12

    invoke-direct/range {v2 .. v11}, Lcom/motorola/camera/custom/LookFilterEngine;->blend(IIIIIIIII)I

    move-result v12

    .line 83
    add-int/lit8 v5, v15, 0x2

    add-int/lit8 v6, v16, 0x2

    add-int/lit8 v7, v17, 0x2

    add-int/lit8 v8, v18, 0x2

    move v3, v13

    invoke-direct/range {v2 .. v11}, Lcom/motorola/camera/custom/LookFilterEngine;->blend(IIIIIIIII)I

    move-result v3

    .line 84
    const/high16 v2, -0x1000000

    and-int/2addr v1, v2

    shl-int/lit8 v2, v14, 0x10

    or-int/2addr v1, v2

    shl-int/lit8 v2, v12, 0x8

    or-int/2addr v1, v2

    or-int/2addr v1, v3

    aput v1, p1, v0

    .line 47
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    .line 86
    :cond_4
    return-void
.end method

.method texturePixels()Ljava/nio/ByteBuffer;
    .locals 2

    .line 38
    iget-object v0, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    array-length v0, v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 39
    iget-object v1, p0, Lcom/motorola/camera/custom/LookFilterEngine;->cube:[B

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 40
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 41
    return-object v0
.end method
