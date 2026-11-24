.class final Lcom/motorola/camera/custom/GainmapJpeg;
.super Ljava/lang/Object;
.source "GainmapJpeg.java"


# static fields
.field private static final EXIF:[B

.field private static final MPF:[B


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 11
    const-string v0, "Exif\u0000\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/GainmapJpeg;->EXIF:[B

    .line 12
    const-string v0, "MPF\u0000"

    sget-object v1, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/GainmapJpeg;->MPF:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static find([BI[B)I
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 90
    array-length v0, p0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_8

    const/4 v0, 0x0

    aget-byte v2, p0, v0

    const/16 v3, 0xff

    and-int/2addr v2, v3

    if-ne v2, v3, :cond_8

    const/4 v2, 0x1

    aget-byte v2, p0, v2

    and-int/2addr v2, v3

    const/16 v4, 0xd8

    if-ne v2, v4, :cond_8

    .line 93
    const/4 v2, 0x2

    move v4, v2

    :goto_0
    array-length v5, p0

    sub-int/2addr v5, v2

    if-gt v4, v5, :cond_7

    .line 94
    aget-byte v5, p0, v4

    and-int/2addr v5, v3

    if-ne v5, v3, :cond_6

    .line 95
    add-int/lit8 v5, v4, 0x1

    aget-byte v6, p0, v5

    and-int/2addr v6, v3

    .line 96
    const/16 v7, 0xda

    if-eq v6, v7, :cond_7

    const/16 v7, 0xd9

    if-ne v6, v7, :cond_0

    goto :goto_2

    .line 97
    :cond_0
    if-ne v6, v3, :cond_1

    move v4, v5

    goto :goto_0

    .line 98
    :cond_1
    array-length v5, p0

    sub-int/2addr v5, v1

    if-gt v4, v5, :cond_5

    .line 99
    invoke-static {p0, v4}, Lcom/motorola/camera/custom/GainmapJpeg;->segmentSize([BI)I

    move-result v5

    .line 100
    if-lt v5, v1, :cond_4

    array-length v7, p0

    sub-int/2addr v7, v4

    if-gt v5, v7, :cond_4

    .line 101
    if-ne v6, p1, :cond_3

    array-length v6, p2

    add-int/2addr v6, v1

    if-lt v5, v6, :cond_3

    .line 102
    move v6, v0

    .line 103
    :goto_1
    array-length v7, p2

    if-ge v6, v7, :cond_2

    add-int/lit8 v7, v4, 0x4

    add-int/2addr v7, v6

    aget-byte v7, p0, v7

    aget-byte v8, p2, v6

    if-ne v7, v8, :cond_2

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 104
    :cond_2
    array-length v7, p2

    if-ne v6, v7, :cond_3

    return v4

    .line 106
    :cond_3
    add-int/2addr v4, v5

    .line 107
    goto :goto_0

    .line 100
    :cond_4
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Invalid JPEG segment"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 98
    :cond_5
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Truncated JPEG marker"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 94
    :cond_6
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Invalid JPEG marker"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 108
    :cond_7
    :goto_2
    const/4 p0, -0x1

    return p0

    .line 91
    :cond_8
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Missing JPEG SOI"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static hasMarker([BII)Z
    .locals 2

    .line 82
    aget-byte v0, p0, p1

    const/16 v1, 0xff

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    add-int/2addr p1, v0

    aget-byte p0, p0, p1

    and-int/2addr p0, v1

    if-ne p0, p2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static segmentSize([BI)I
    .locals 1

    .line 86
    add-int/lit8 v0, p1, 0x2

    aget-byte v0, p0, v0

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x8

    add-int/lit8 v0, v0, 0x2

    add-int/lit8 p1, p1, 0x3

    aget-byte p0, p0, p1

    and-int/lit16 p0, p0, 0xff

    add-int/2addr v0, p0

    return v0
.end method

.method static withExif([B[B)[B
    .locals 20
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 17
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    sget-object v2, Lcom/motorola/camera/custom/GainmapJpeg;->EXIF:[B

    const/16 v3, 0xe1

    invoke-static {v1, v3, v2}, Lcom/motorola/camera/custom/GainmapJpeg;->find([BI[B)I

    move-result v2

    .line 18
    if-ltz v2, :cond_12

    .line 19
    const/16 v4, 0xe2

    sget-object v5, Lcom/motorola/camera/custom/GainmapJpeg;->MPF:[B

    invoke-static {v0, v4, v5}, Lcom/motorola/camera/custom/GainmapJpeg;->find([BI[B)I

    move-result v4

    .line 20
    if-ltz v4, :cond_11

    .line 22
    sget-object v5, Lcom/motorola/camera/custom/GainmapJpeg;->EXIF:[B

    invoke-static {v0, v3, v5}, Lcom/motorola/camera/custom/GainmapJpeg;->find([BI[B)I

    move-result v3

    .line 23
    invoke-static {v1, v2}, Lcom/motorola/camera/custom/GainmapJpeg;->segmentSize([BI)I

    move-result v5

    .line 24
    const/4 v6, 0x2

    if-ltz v3, :cond_0

    move v7, v3

    goto :goto_0

    :cond_0
    move v7, v6

    .line 25
    :goto_0
    const/4 v8, 0x0

    if-ltz v3, :cond_1

    invoke-static {v0, v3}, Lcom/motorola/camera/custom/GainmapJpeg;->segmentSize([BI)I

    move-result v9

    goto :goto_1

    :cond_1
    move v9, v8

    .line 26
    :goto_1
    sub-int v10, v5, v9

    .line 27
    array-length v11, v0

    invoke-static {v11, v10}, Ljava/lang/Math;->addExact(II)I

    move-result v11

    new-array v11, v11, [B

    .line 28
    invoke-static {v0, v8, v11, v8, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 29
    invoke-static {v1, v2, v11, v7, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 30
    add-int/2addr v9, v7

    .line 31
    add-int/2addr v5, v7

    array-length v1, v0

    sub-int/2addr v1, v9

    invoke-static {v0, v9, v11, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 35
    if-ltz v3, :cond_3

    if-ge v3, v4, :cond_2

    goto :goto_2

    :cond_2
    move v1, v8

    goto :goto_3

    :cond_3
    :goto_2
    move v1, v10

    .line 36
    :goto_3
    add-int/lit8 v2, v4, 0x8

    add-int v3, v2, v1

    .line 37
    invoke-static {v0, v4}, Lcom/motorola/camera/custom/GainmapJpeg;->segmentSize([BI)I

    move-result v5

    const/16 v9, 0x8

    sub-int/2addr v5, v9

    .line 38
    if-lt v5, v9, :cond_10

    .line 39
    invoke-static {v11, v3, v5}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 40
    invoke-virtual {v3, v8}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result v12

    const v13, 0xffff

    and-int/2addr v12, v13

    .line 41
    const/16 v14, 0x4949

    if-ne v12, v14, :cond_4

    sget-object v12, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v3, v12}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    goto :goto_4

    .line 42
    :cond_4
    const/16 v14, 0x4d4d

    if-ne v12, v14, :cond_f

    .line 43
    :goto_4
    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result v12

    const/16 v14, 0x2a

    if-ne v12, v14, :cond_e

    .line 44
    const/4 v12, 0x4

    invoke-virtual {v3, v12}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v14

    .line 45
    if-lt v14, v9, :cond_d

    add-int/lit8 v9, v5, -0x2

    if-gt v14, v9, :cond_d

    .line 46
    invoke-virtual {v3, v14}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result v9

    and-int/2addr v9, v13

    .line 47
    nop

    :goto_5
    if-ge v8, v9, :cond_c

    .line 48
    add-int/lit8 v15, v14, 0x2

    mul-int/lit8 v16, v8, 0xc

    add-int v15, v15, v16

    .line 49
    move/from16 v16, v6

    add-int/lit8 v6, v5, -0xc

    if-gt v15, v6, :cond_b

    .line 50
    invoke-virtual {v3, v15}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result v6

    and-int/2addr v6, v13

    const v13, 0xb002

    if-eq v6, v13, :cond_5

    .line 47
    add-int/lit8 v8, v8, 0x1

    move/from16 v6, v16

    const v13, 0xffff

    goto :goto_5

    .line 51
    :cond_5
    add-int/lit8 v6, v15, 0x8

    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v6

    .line 52
    add-int/lit8 v8, v15, 0x2

    invoke-virtual {v3, v8}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result v8

    const/4 v9, 0x7

    if-ne v8, v9, :cond_a

    add-int/2addr v15, v12

    invoke-virtual {v3, v15}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v8

    const/16 v9, 0x20

    if-lt v8, v9, :cond_a

    if-ltz v6, :cond_a

    add-int/lit8 v8, v5, -0x20

    if-gt v6, v8, :cond_a

    .line 56
    add-int/lit8 v8, v6, 0x4

    invoke-virtual {v3, v8}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v9

    .line 57
    add-int/lit8 v13, v6, 0x14

    invoke-virtual {v3, v13}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v13

    .line 58
    add-int/lit8 v6, v6, 0x18

    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v14

    .line 59
    move/from16 p1, v12

    move v15, v13

    int-to-long v12, v4

    const-wide/16 v17, 0x8

    add-long v12, v12, v17

    move/from16 v17, v1

    move/from16 v18, v2

    int-to-long v1, v14

    add-long/2addr v12, v1

    .line 60
    const-string v1, "Invalid JPEG/R image boundaries"

    if-lez v14, :cond_9

    array-length v2, v0

    add-int/lit8 v2, v2, -0x4

    move-object/from16 v19, v1

    int-to-long v1, v2

    cmp-long v1, v12, v1

    if-gtz v1, :cond_8

    .line 63
    long-to-int v1, v12

    .line 64
    add-int v2, v18, v5

    add-int/lit8 v2, v2, 0x2

    if-lt v9, v2, :cond_7

    if-gt v9, v1, :cond_7

    if-lt v1, v2, :cond_7

    move/from16 v2, p1

    if-lt v15, v2, :cond_7

    array-length v2, v0

    sub-int/2addr v2, v1

    if-gt v15, v2, :cond_7

    add-int/lit8 v2, v9, -0x2

    .line 67
    const/16 v5, 0xd9

    invoke-static {v0, v2, v5}, Lcom/motorola/camera/custom/GainmapJpeg;->hasMarker([BII)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 68
    const/16 v2, 0xd8

    invoke-static {v0, v1, v2}, Lcom/motorola/camera/custom/GainmapJpeg;->hasMarker([BII)Z

    move-result v2

    if-eqz v2, :cond_7

    add-int v13, v1, v15

    add-int/lit8 v13, v13, -0x2

    .line 69
    invoke-static {v0, v13, v5}, Lcom/motorola/camera/custom/GainmapJpeg;->hasMarker([BII)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 72
    invoke-static {v9, v10}, Ljava/lang/Math;->addExact(II)I

    move-result v0

    invoke-virtual {v3, v8, v0}, Ljava/nio/ByteBuffer;->putInt(II)Ljava/nio/ByteBuffer;

    .line 73
    if-nez v17, :cond_6

    if-le v7, v4, :cond_6

    if-ge v7, v1, :cond_6

    .line 74
    invoke-static {v14, v10}, Ljava/lang/Math;->addExact(II)I

    move-result v0

    invoke-virtual {v3, v6, v0}, Ljava/nio/ByteBuffer;->putInt(II)Ljava/nio/ByteBuffer;

    .line 76
    :cond_6
    return-object v11

    .line 70
    :cond_7
    new-instance v0, Ljava/io/IOException;

    move-object/from16 v1, v19

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 60
    :cond_8
    move-object/from16 v1, v19

    .line 61
    :cond_9
    new-instance v0, Ljava/io/IOException;

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 54
    :cond_a
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid MP entries"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 49
    :cond_b
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Truncated MPF directory"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 78
    :cond_c
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Missing MP entries"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 45
    :cond_d
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid MPF directory"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 43
    :cond_e
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid MPF TIFF header"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 42
    :cond_f
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid MPF byte order"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 38
    :cond_10
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Truncated MPF"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 20
    :cond_11
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Unexpected native JPEG/R headers"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 18
    :cond_12
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Missing rewritten EXIF"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
