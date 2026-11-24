.class public final Lcom/motorola/camera/custom/CompassSolarHelper;
.super Ljava/lang/Object;
.source "CompassSolarHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;,
        Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;
    }
.end annotation


# static fields
.field private static final CARDINALS:[Ljava/lang/String;

.field public static final DEFAULT_OUTDOOR_EV100:D = 11.0


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 16
    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "N"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "NE"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "E"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "SE"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "S"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "SW"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "W"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "NW"

    aput-object v2, v0, v1

    sput-object v0, Lcom/motorola/camera/custom/CompassSolarHelper;->CARDINALS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static angularSeparationDeg(DDDD)D
    .locals 6

    .line 205
    invoke-static {p2, p3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->cos(D)D

    move-result-wide v0

    invoke-static {p0, p1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    mul-double/2addr v0, v2

    .line 206
    invoke-static {p2, p3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v2

    invoke-static {p0, p1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->cos(D)D

    move-result-wide p0

    mul-double/2addr v2, p0

    .line 207
    invoke-static {p2, p3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    .line 208
    invoke-static {p6, p7}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p2

    invoke-static {p2, p3}, Ljava/lang/Math;->cos(D)D

    move-result-wide p2

    invoke-static {p4, p5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Math;->sin(D)D

    move-result-wide v4

    mul-double/2addr p2, v4

    .line 209
    invoke-static {p6, p7}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Math;->cos(D)D

    move-result-wide v4

    invoke-static {p4, p5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p4

    invoke-static {p4, p5}, Ljava/lang/Math;->cos(D)D

    move-result-wide p4

    mul-double/2addr v4, p4

    .line 210
    invoke-static {p6, p7}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p4

    invoke-static {p4, p5}, Ljava/lang/Math;->sin(D)D

    move-result-wide p4

    .line 211
    mul-double/2addr v0, p2

    mul-double/2addr v2, v4

    add-double/2addr v0, v2

    mul-double/2addr p0, p4

    add-double/2addr v0, p0

    .line 212
    const-wide/high16 p0, 0x3ff0000000000000L    # 1.0

    cmpl-double p2, v0, p0

    if-lez p2, :cond_0

    move-wide v0, p0

    .line 213
    :cond_0
    const-wide/high16 p0, -0x4010000000000000L    # -1.0

    cmpg-double p2, v0, p0

    if-gez p2, :cond_1

    move-wide v0, p0

    .line 214
    :cond_1
    invoke-static {v0, v1}, Ljava/lang/Math;->acos(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide p0

    return-wide p0
.end method

.method public static computeEv100(JIF)D
    .locals 5

    .line 225
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    const-wide/high16 v1, 0x7ff8000000000000L    # Double.NaN

    if-lez v0, :cond_3

    if-lez p2, :cond_3

    const/4 v0, 0x0

    cmpl-float v0, p3, v0

    if-lez v0, :cond_3

    .line 226
    invoke-static {p3}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 229
    :cond_0
    long-to-double p0, p0

    const-wide v3, 0x3e112e0be826d695L    # 1.0E-9

    mul-double/2addr p0, v3

    .line 230
    mul-float/2addr p3, p3

    float-to-double v3, p3

    div-double/2addr v3, p0

    const-wide/high16 p0, 0x4059000000000000L    # 100.0

    int-to-double p2, p2

    div-double/2addr p0, p2

    mul-double/2addr v3, p0

    .line 231
    const-wide/16 p0, 0x0

    cmpl-double p0, v3, p0

    if-lez p0, :cond_2

    invoke-static {v3, v4}, Ljava/lang/Double;->isInfinite(D)Z

    move-result p0

    if-eqz p0, :cond_1

    goto :goto_0

    .line 232
    :cond_1
    invoke-static {v3, v4}, Ljava/lang/Math;->log(D)D

    move-result-wide p0

    const-wide/high16 p2, 0x4000000000000000L    # 2.0

    invoke-static {p2, p3}, Ljava/lang/Math;->log(D)D

    move-result-wide p2

    div-double/2addr p0, p2

    return-wide p0

    .line 231
    :cond_2
    :goto_0
    return-wide v1

    .line 227
    :cond_3
    :goto_1
    return-wide v1
.end method

.method public static computeOrientation([FIIZIJ)Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;
    .locals 23

    .line 56
    move-object/from16 v0, p0

    move/from16 v1, p1

    if-eqz v0, :cond_d

    const/4 v2, 0x3

    if-lt v1, v2, :cond_d

    array-length v3, v0

    if-lt v3, v2, :cond_d

    array-length v3, v0

    if-ge v3, v1, :cond_0

    goto/16 :goto_6

    .line 60
    :cond_0
    const/4 v3, 0x0

    aget v3, v0, v3

    .line 61
    const/4 v4, 0x1

    aget v4, v0, v4

    .line 62
    const/4 v5, 0x2

    aget v5, v0, v5

    .line 64
    const/4 v6, 0x4

    const/high16 v7, 0x3f800000    # 1.0f

    const/4 v8, 0x0

    if-lt v1, v6, :cond_1

    .line 65
    aget v0, v0, v2

    goto :goto_0

    .line 67
    :cond_1
    mul-float v0, v3, v3

    mul-float v1, v4, v4

    add-float/2addr v0, v1

    mul-float v1, v5, v5

    add-float/2addr v0, v1

    .line 68
    cmpg-float v1, v0, v7

    if-gez v1, :cond_2

    const-wide/high16 v1, 0x3ff0000000000000L    # 1.0

    float-to-double v9, v0

    sub-double/2addr v1, v9

    invoke-static {v1, v2}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    goto :goto_0

    :cond_2
    move v0, v8

    .line 70
    :goto_0
    mul-float v1, v0, v0

    mul-float v2, v3, v3

    add-float/2addr v1, v2

    mul-float v2, v4, v4

    add-float/2addr v1, v2

    mul-float v2, v5, v5

    add-float/2addr v1, v2

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v1

    double-to-float v1, v1

    .line 71
    const v2, 0x358637bd    # 1.0E-6f

    cmpl-float v2, v1, v2

    if-lez v2, :cond_3

    .line 72
    div-float v1, v7, v1

    .line 73
    mul-float/2addr v0, v1

    .line 74
    mul-float/2addr v3, v1

    .line 75
    mul-float/2addr v4, v1

    .line 76
    mul-float/2addr v5, v1

    .line 79
    :cond_3
    const/high16 v1, 0x40000000    # 2.0f

    mul-float v2, v3, v1

    mul-float/2addr v3, v2

    .line 80
    mul-float v6, v4, v1

    mul-float v9, v6, v4

    .line 81
    mul-float/2addr v1, v5

    mul-float v10, v1, v5

    .line 82
    mul-float/2addr v4, v2

    .line 83
    mul-float/2addr v1, v0

    .line 84
    mul-float v11, v2, v5

    .line 85
    mul-float v12, v6, v0

    .line 86
    mul-float/2addr v6, v5

    .line 87
    mul-float/2addr v2, v0

    .line 88
    nop

    .line 89
    sub-float/2addr v4, v1

    .line 90
    add-float v0, v11, v12

    .line 91
    nop

    .line 92
    sub-float v1, v7, v3

    sub-float v3, v1, v10

    .line 93
    sub-float v5, v6, v2

    .line 94
    sub-float/2addr v11, v12

    .line 95
    add-float/2addr v6, v2

    .line 96
    sub-float/2addr v1, v9

    .line 98
    const/high16 v2, -0x40800000    # -1.0f

    if-eqz p3, :cond_4

    move v9, v7

    goto :goto_1

    :cond_4
    move v9, v2

    .line 99
    :goto_1
    mul-float/2addr v0, v9

    .line 100
    mul-float/2addr v5, v9

    .line 101
    mul-float/2addr v1, v9

    .line 102
    float-to-double v9, v0

    float-to-double v12, v5

    invoke-static {v9, v10, v12, v13}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v14

    .line 104
    const-wide v16, 0x3f50624dd2f1a9fcL    # 0.001

    cmpg-double v0, v14, v16

    if-gez v0, :cond_6

    .line 106
    float-to-double v4, v4

    float-to-double v9, v3

    invoke-static {v4, v5, v9, v10}, Ljava/lang/Math;->hypot(DD)D

    move-result-wide v12

    .line 107
    const-wide v16, 0x3f1a36e2eb1c432dL    # 1.0E-4

    cmpl-double v0, v12, v16

    if-lez v0, :cond_5

    invoke-static {v4, v5, v9, v10}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v3

    double-to-float v0, v3

    goto :goto_2

    :cond_5
    move v0, v8

    .line 108
    :goto_2
    goto :goto_3

    .line 109
    :cond_6
    invoke-static {v9, v10, v12, v13}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v3

    double-to-float v0, v3

    .line 111
    :goto_3
    cmpg-float v3, v0, v8

    const/high16 v4, 0x43b40000    # 360.0f

    if-gez v3, :cond_7

    add-float/2addr v0, v4

    .line 112
    :cond_7
    cmpl-float v3, v0, v4

    if-ltz v3, :cond_8

    move/from16 v17, v8

    goto :goto_4

    :cond_8
    move/from16 v17, v0

    .line 113
    :goto_4
    float-to-double v0, v1

    invoke-static {v0, v1, v14, v15}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v0

    double-to-float v0, v0

    .line 115
    move/from16 v1, p2

    rem-int/lit16 v1, v1, 0x168

    .line 116
    if-gez v1, :cond_9

    add-int/lit16 v1, v1, 0x168

    .line 121
    :cond_9
    const/16 v3, 0x5a

    if-ne v1, v3, :cond_a

    .line 122
    nop

    .line 123
    nop

    .line 124
    nop

    .line 125
    move v1, v8

    move v8, v7

    move v7, v1

    goto :goto_5

    .line 126
    :cond_a
    const/16 v3, 0xb4

    if-ne v1, v3, :cond_b

    .line 127
    nop

    .line 128
    nop

    .line 129
    nop

    .line 130
    move v1, v2

    move v7, v1

    move v2, v8

    goto :goto_5

    .line 131
    :cond_b
    const/16 v3, 0x10e

    if-ne v1, v3, :cond_c

    .line 132
    nop

    .line 133
    nop

    .line 134
    nop

    .line 135
    move v1, v8

    move v8, v2

    move v2, v7

    move v7, v1

    goto :goto_5

    .line 137
    :cond_c
    nop

    .line 138
    nop

    .line 139
    nop

    .line 140
    move v1, v7

    move v2, v8

    .line 142
    :goto_5
    nop

    .line 143
    nop

    .line 144
    mul-float/2addr v7, v11

    mul-float/2addr v8, v6

    add-float/2addr v7, v8

    float-to-double v3, v7

    mul-float/2addr v11, v2

    mul-float/2addr v6, v1

    add-float/2addr v11, v6

    float-to-double v1, v11

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v1

    double-to-float v1, v1

    .line 147
    new-instance v16, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    move/from16 v20, p4

    move-wide/from16 v21, p5

    move/from16 v18, v0

    move/from16 v19, v1

    invoke-direct/range {v16 .. v22}, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;-><init>(FFFIJ)V

    return-object v16

    .line 58
    :cond_d
    :goto_6
    new-instance v0, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;

    const/high16 v2, 0x7fc00000    # Float.NaN

    const/high16 v3, 0x7fc00000    # Float.NaN

    const/high16 v1, 0x7fc00000    # Float.NaN

    move/from16 v4, p4

    move-wide/from16 v5, p5

    invoke-direct/range {v0 .. v6}, Lcom/motorola/camera/custom/CompassSolarHelper$OrientationReading;-><init>(FFFIJ)V

    return-object v0
.end method

.method public static computeSolarPosition(DDJ)Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;
    .locals 21

    .line 151
    move-wide/from16 v0, p4

    long-to-double v2, v0

    const-wide v4, 0x4194997000000000L    # 8.64E7

    div-double/2addr v2, v4

    const-wide v4, 0x41429ec5c0000000L    # 2440587.5

    add-double/2addr v2, v4

    .line 152
    const-wide v4, 0x4142b42c80000000L    # 2451545.0

    sub-double/2addr v2, v4

    const-wide v4, 0x40e1d5a000000000L    # 36525.0

    div-double/2addr v2, v4

    .line 153
    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassSolarHelper;->equationOfTimeMinutes(D)D

    move-result-wide v4

    .line 154
    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassSolarHelper;->sunDeclinationDeg(D)D

    move-result-wide v2

    .line 155
    const-wide/32 v6, 0x5265c00

    rem-long/2addr v0, v6

    add-long/2addr v0, v6

    rem-long/2addr v0, v6

    long-to-double v0, v0

    const-wide v6, 0x40ed4c0000000000L    # 60000.0

    div-double/2addr v0, v6

    .line 156
    add-double/2addr v0, v4

    const-wide/high16 v4, 0x4010000000000000L    # 4.0

    mul-double v6, p2, v4

    add-double/2addr v0, v6

    .line 157
    const-wide v6, 0x4096800000000000L    # 1440.0

    div-double v8, v0, v6

    invoke-static {v8, v9}, Ljava/lang/Math;->floor(D)D

    move-result-wide v8

    mul-double/2addr v8, v6

    sub-double/2addr v0, v8

    .line 158
    div-double/2addr v0, v4

    const-wide v4, 0x4066800000000000L    # 180.0

    sub-double/2addr v0, v4

    .line 160
    invoke-static/range {p0 .. p1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v6

    .line 161
    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 162
    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v8

    .line 163
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    mul-double/2addr v10, v12

    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v12

    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v14

    mul-double/2addr v12, v14

    invoke-static {v8, v9}, Ljava/lang/Math;->cos(D)D

    move-result-wide v8

    mul-double/2addr v12, v8

    add-double/2addr v10, v12

    .line 164
    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    cmpl-double v12, v10, v8

    if-lez v12, :cond_0

    move-wide v10, v8

    .line 165
    :cond_0
    const-wide/high16 v12, -0x4010000000000000L    # -1.0

    cmpg-double v14, v10, v12

    if-gez v14, :cond_1

    move-wide v10, v12

    .line 166
    :cond_1
    invoke-static {v10, v11}, Ljava/lang/Math;->acos(D)D

    move-result-wide v10

    invoke-static {v10, v11}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v10

    .line 167
    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v14

    invoke-static {v10, v11}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v16

    invoke-static/range {v16 .. v17}, Ljava/lang/Math;->sin(D)D

    move-result-wide v16

    mul-double v14, v14, v16

    .line 169
    invoke-static {v14, v15}, Ljava/lang/Math;->abs(D)D

    move-result-wide v16

    const-wide v18, 0x3f50624dd2f1a9fcL    # 0.001

    cmpl-double v16, v16, v18

    const-wide/16 v17, 0x0

    if-lez v16, :cond_5

    .line 170
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v6

    invoke-static {v10, v11}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v19

    invoke-static/range {v19 .. v20}, Ljava/lang/Math;->cos(D)D

    move-result-wide v19

    mul-double v6, v6, v19

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    sub-double/2addr v6, v2

    div-double/2addr v6, v14

    .line 171
    cmpg-double v2, v6, v12

    if-gez v2, :cond_2

    goto :goto_0

    :cond_2
    move-wide v12, v6

    .line 172
    :goto_0
    cmpl-double v2, v12, v8

    if-lez v2, :cond_3

    goto :goto_1

    :cond_3
    move-wide v8, v12

    .line 173
    :goto_1
    invoke-static {v8, v9}, Ljava/lang/Math;->acos(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v2

    sub-double/2addr v4, v2

    .line 174
    cmpl-double v0, v0, v17

    if-lez v0, :cond_4

    neg-double v0, v4

    move-wide v4, v0

    .line 175
    :cond_4
    goto :goto_2

    :cond_5
    cmpl-double v0, p0, v17

    if-lez v0, :cond_6

    .line 176
    goto :goto_2

    .line 178
    :cond_6
    move-wide/from16 v4, v17

    .line 180
    :goto_2
    cmpg-double v0, v4, v17

    const-wide v1, 0x4076800000000000L    # 360.0

    if-gez v0, :cond_7

    add-double/2addr v4, v1

    .line 181
    :cond_7
    cmpl-double v0, v4, v1

    if-ltz v0, :cond_8

    sub-double/2addr v4, v1

    .line 183
    :cond_8
    const-wide v0, 0x4056800000000000L    # 90.0

    sub-double v2, v0, v10

    .line 184
    invoke-static {v2, v3}, Lcom/motorola/camera/custom/CompassSolarHelper;->refractionDeg(D)D

    move-result-wide v6

    add-double/2addr v2, v6

    .line 185
    cmpl-double v6, v2, v0

    if-lez v6, :cond_9

    goto :goto_3

    :cond_9
    move-wide v0, v2

    .line 186
    :goto_3
    const-wide v2, -0x3fa9800000000000L    # -90.0

    cmpg-double v6, v0, v2

    if-gez v6, :cond_a

    move-wide v0, v2

    .line 187
    :cond_a
    new-instance v2, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;

    invoke-direct {v2, v4, v5, v0, v1}, Lcom/motorola/camera/custom/CompassSolarHelper$SolarPosition;-><init>(DD)V

    return-object v2
.end method

.method private static eccentricityEarthOrbit(D)D
    .locals 4

    .line 315
    const-wide v0, 0x3e810160fc64d800L    # 1.267E-7

    mul-double/2addr v0, p0

    const-wide v2, 0x3f060a1c525fe303L    # 4.2037E-5

    add-double/2addr v0, v2

    mul-double/2addr p0, v0

    const-wide v0, 0x3f911c11725d0380L    # 0.016708634

    sub-double/2addr v0, p0

    return-wide v0
.end method

.method private static equationOfTimeMinutes(D)D
    .locals 20

    .line 266
    invoke-static/range {p0 .. p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->obliquityCorrectionDeg(D)D

    move-result-wide v0

    .line 267
    invoke-static/range {p0 .. p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->geomMeanLongitudeDeg(D)D

    move-result-wide v2

    .line 268
    invoke-static/range {p0 .. p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->eccentricityEarthOrbit(D)D

    move-result-wide v4

    .line 269
    invoke-static/range {p0 .. p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->geomMeanAnomalyDeg(D)D

    move-result-wide v6

    .line 270
    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    const-wide/high16 v8, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v8

    invoke-static {v0, v1}, Ljava/lang/Math;->tan(D)D

    move-result-wide v0

    .line 271
    mul-double/2addr v0, v0

    .line 272
    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 273
    invoke-static {v6, v7}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v6

    .line 274
    mul-double v10, v2, v8

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    mul-double/2addr v12, v0

    mul-double v14, v4, v8

    .line 275
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v16

    mul-double v14, v14, v16

    sub-double/2addr v12, v14

    const-wide/high16 v14, 0x4010000000000000L    # 4.0

    mul-double v16, v4, v14

    mul-double v16, v16, v0

    .line 276
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v18

    mul-double v16, v16, v18

    invoke-static {v10, v11}, Ljava/lang/Math;->cos(D)D

    move-result-wide v10

    mul-double v16, v16, v10

    add-double v12, v12, v16

    const-wide/high16 v10, 0x3fe0000000000000L    # 0.5

    mul-double/2addr v10, v0

    mul-double/2addr v10, v0

    mul-double/2addr v2, v14

    .line 277
    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    mul-double/2addr v10, v0

    sub-double/2addr v12, v10

    const-wide/high16 v0, 0x3ff4000000000000L    # 1.25

    mul-double/2addr v0, v4

    mul-double/2addr v0, v4

    mul-double/2addr v6, v8

    .line 278
    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    mul-double/2addr v0, v2

    sub-double/2addr v12, v0

    .line 279
    invoke-static {v12, v13}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v0

    mul-double/2addr v0, v14

    return-wide v0
.end method

.method public static formatCardinal(D)Ljava/lang/String;
    .locals 2

    .line 191
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-nez v0, :cond_0

    const-string p0, "N"

    return-object p0

    .line 192
    :cond_0
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->wrap360(D)D

    move-result-wide p0

    .line 193
    const-wide v0, 0x4036800000000000L    # 22.5

    add-double/2addr p0, v0

    const-wide v0, 0x4046800000000000L    # 45.0

    div-double/2addr p0, v0

    invoke-static {p0, p1}, Ljava/lang/Math;->floor(D)D

    move-result-wide p0

    double-to-int p0, p0

    rem-int/lit8 p0, p0, 0x8

    .line 194
    sget-object p1, Lcom/motorola/camera/custom/CompassSolarHelper;->CARDINALS:[Ljava/lang/String;

    aget-object p0, p1, p0

    return-object p0
.end method

.method public static formatExifDirection(D)Ljava/lang/String;
    .locals 3

    .line 245
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 246
    :cond_0
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->wrap360(D)D

    move-result-wide p0

    const-wide/high16 v0, 0x4059000000000000L    # 100.0

    mul-double/2addr p0, v0

    invoke-static {p0, p1}, Ljava/lang/Math;->round(D)J

    move-result-wide p0

    .line 247
    const-wide/32 v0, 0x8ca0

    cmp-long v0, p0, v0

    const-wide/16 v1, 0x0

    if-gez v0, :cond_1

    cmp-long v0, p0, v1

    if-gez v0, :cond_2

    :cond_1
    move-wide p0, v1

    .line 248
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "/100"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static formatHeadingLabel(D)Ljava/lang/String;
    .locals 2

    .line 198
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-nez v0, :cond_0

    const-string p0, "N 0\u00b0"

    return-object p0

    .line 199
    :cond_0
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->wrap360(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->round(D)J

    move-result-wide p0

    long-to-int p0, p0

    .line 200
    const/16 p1, 0x168

    if-lt p0, p1, :cond_1

    const/4 p0, 0x0

    .line 201
    :cond_1
    int-to-double v0, p0

    invoke-static {v0, v1}, Lcom/motorola/camera/custom/CompassSolarHelper;->formatCardinal(D)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "\u00b0"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static geomMeanAnomalyDeg(D)D
    .locals 4

    .line 311
    const-wide v0, 0x3f242550f260db0cL    # 1.537E-4

    mul-double/2addr v0, p0

    const-wide v2, 0x40e193e19bf9c62aL    # 35999.05029

    sub-double/2addr v2, v0

    mul-double/2addr p0, v2

    const-wide v0, 0x407658773c0c1fc9L    # 357.52911

    add-double/2addr p0, v0

    return-wide p0
.end method

.method private static geomMeanLongitudeDeg(D)D
    .locals 4

    .line 304
    const-wide v0, 0x3f33deda158aabc0L    # 3.032E-4

    mul-double/2addr v0, p0

    const-wide v2, 0x40e19418a272862fL    # 36000.76983

    add-double/2addr v0, v2

    mul-double/2addr p0, v0

    const-wide v0, 0x407187769ec2ce46L    # 280.46646

    add-double/2addr p0, v0

    .line 305
    const-wide v0, 0x4076800000000000L    # 360.0

    rem-double/2addr p0, v0

    .line 306
    const-wide/16 v2, 0x0

    cmpg-double v2, p0, v2

    if-gez v2, :cond_0

    add-double/2addr p0, v0

    .line 307
    :cond_0
    return-wide p0
.end method

.method public static horizontalAzimuthDeltaDeg(DD)D
    .locals 2

    .line 218
    sub-double/2addr p2, p0

    const-wide p0, 0x4076800000000000L    # 360.0

    rem-double/2addr p2, p0

    .line 219
    const-wide v0, 0x4066800000000000L    # 180.0

    cmpl-double v0, p2, v0

    if-lez v0, :cond_0

    sub-double/2addr p2, p0

    .line 220
    :cond_0
    const-wide v0, -0x3f99800000000000L    # -180.0

    cmpg-double v0, p2, v0

    if-gtz v0, :cond_1

    add-double/2addr p2, p0

    .line 221
    :cond_1
    return-wide p2
.end method

.method public static isPhysicalOutdoorBacklit(DDDI)Z
    .locals 2

    .line 237
    invoke-static {p0, p1}, Ljava/lang/Double;->isFinite(D)Z

    move-result v0

    if-eqz v0, :cond_0

    const-wide/high16 v0, 0x4026000000000000L    # 11.0

    cmpl-double p0, p0, v0

    if-ltz p0, :cond_0

    const/4 p0, 0x2

    if-lt p6, p0, :cond_0

    const-wide/high16 p0, 0x4014000000000000L    # 5.0

    cmpl-double p0, p2, p0

    if-ltz p0, :cond_0

    const-wide p0, 0x4046800000000000L    # 45.0

    cmpg-double p0, p4, p0

    if-gtz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static obliquityCorrectionDeg(D)D
    .locals 6

    .line 297
    const-wide v0, 0x3f5db445ed4a1ad6L    # 0.001813

    mul-double/2addr v0, p0

    const-wide v2, 0x3f4355475a31a4beL    # 5.9E-4

    sub-double/2addr v2, v0

    mul-double/2addr v2, p0

    const-wide v0, 0x40476851eb851eb8L    # 46.815

    add-double/2addr v2, v0

    mul-double/2addr v2, p0

    const-wide v0, 0x403572b020c49ba6L    # 21.448

    sub-double/2addr v0, v2

    .line 298
    const-wide/high16 v2, 0x404e000000000000L    # 60.0

    div-double/2addr v0, v2

    const-wide/high16 v4, 0x403a000000000000L    # 26.0

    add-double/2addr v0, v4

    div-double/2addr v0, v2

    const-wide/high16 v2, 0x4037000000000000L    # 23.0

    add-double/2addr v0, v2

    .line 299
    const-wide v2, 0x409e388b43958106L    # 1934.136

    mul-double/2addr p0, v2

    const-wide v2, 0x405f428f5c28f5c3L    # 125.04

    sub-double/2addr v2, p0

    .line 300
    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->cos(D)D

    move-result-wide p0

    const-wide v2, 0x3f64f8b588e368f1L    # 0.00256

    mul-double/2addr p0, v2

    add-double/2addr v0, p0

    return-wide v0
.end method

.method private static refractionDeg(D)D
    .locals 6

    .line 319
    const-wide v0, 0x4055400000000000L    # 85.0

    cmpl-double v0, p0, v0

    if-lez v0, :cond_0

    const-wide/16 p0, 0x0

    return-wide p0

    .line 320
    :cond_0
    invoke-static {p0, p1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->tan(D)D

    move-result-wide v0

    .line 322
    const-wide/high16 v2, 0x4014000000000000L    # 5.0

    cmpl-double v2, p0, v2

    if-lez v2, :cond_1

    .line 323
    mul-double p0, v0, v0

    .line 324
    mul-double v2, p0, v0

    .line 325
    mul-double/2addr p0, v2

    .line 326
    const-wide v4, 0x404d0ccccccccccdL    # 58.1

    div-double/2addr v4, v0

    const-wide v0, 0x3fb1eb851eb851ecL    # 0.07

    div-double/2addr v0, v2

    sub-double/2addr v4, v0

    const-wide v0, 0x3f168b5cbff47736L    # 8.6E-5

    div-double/2addr v0, p0

    add-double/2addr v4, v0

    .line 327
    goto :goto_0

    :cond_1
    const-wide v2, -0x401d99999999999aL    # -0.575

    cmpl-double v2, p0, v2

    if-lez v2, :cond_2

    .line 328
    const-wide v0, 0x3fe6c083126e978dL    # 0.711

    mul-double/2addr v0, p0

    const-wide v2, -0x3fd66b851eb851ecL    # -12.79

    add-double/2addr v0, v2

    mul-double/2addr v0, p0

    const-wide v2, 0x4059d9999999999aL    # 103.4

    add-double/2addr v0, v2

    mul-double/2addr v0, p0

    const-wide v2, -0x3f7fce6666666666L    # -518.2

    add-double/2addr v0, v2

    mul-double/2addr p0, v0

    const-wide v0, 0x409b1c0000000000L    # 1735.0

    add-double v4, p0, v0

    goto :goto_0

    .line 331
    :cond_2
    const-wide p0, -0x3fcb39db22d0e560L    # -20.774

    div-double v4, p0, v0

    .line 333
    :goto_0
    const-wide p0, 0x40ac200000000000L    # 3600.0

    div-double/2addr v4, p0

    return-wide v4
.end method

.method private static sunApparentLongitudeDeg(D)D
    .locals 4

    .line 283
    const-wide v0, 0x409e388b43958106L    # 1934.136

    mul-double/2addr v0, p0

    const-wide v2, 0x405f428f5c28f5c3L    # 125.04

    sub-double/2addr v2, v0

    .line 284
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->geomMeanLongitudeDeg(D)D

    move-result-wide v0

    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->sunEquationOfCenterDeg(D)D

    move-result-wide p0

    add-double/2addr v0, p0

    const-wide p0, 0x3f774e65bea0ba1fL    # 0.00569

    sub-double/2addr v0, p0

    .line 285
    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    const-wide v2, 0x3f7394317acc4ef9L    # 0.00478

    mul-double/2addr p0, v2

    sub-double/2addr v0, p0

    .line 284
    return-wide v0
.end method

.method private static sunDeclinationDeg(D)D
    .locals 2

    .line 259
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->sunApparentLongitudeDeg(D)D

    move-result-wide v0

    .line 260
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->obliquityCorrectionDeg(D)D

    move-result-wide p0

    .line 261
    nop

    .line 262
    invoke-static {p0, p1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v0

    mul-double/2addr p0, v0

    .line 261
    invoke-static {p0, p1}, Ljava/lang/Math;->asin(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide p0

    return-wide p0
.end method

.method private static sunEquationOfCenterDeg(D)D
    .locals 10

    .line 289
    invoke-static {p0, p1}, Lcom/motorola/camera/custom/CompassSolarHelper;->geomMeanAnomalyDeg(D)D

    move-result-wide v0

    .line 290
    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v0

    .line 291
    invoke-static {v0, v1}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    const-wide v4, 0x3eed5c31593e5fb7L    # 1.4E-5

    mul-double/2addr v4, p0

    const-wide v6, 0x3f73bafd976ff3aeL    # 0.004817

    add-double/2addr v4, v6

    mul-double/2addr v4, p0

    const-wide v6, 0x3ffea235b4edb2f6L    # 1.914602

    sub-double/2addr v6, v4

    mul-double/2addr v2, v6

    add-double v4, v0, v0

    .line 292
    invoke-static {v4, v5}, Ljava/lang/Math;->sin(D)D

    move-result-wide v6

    const-wide v8, 0x3f1a79fec99f1ae3L    # 1.01E-4

    mul-double/2addr p0, v8

    const-wide v8, 0x3f94790b84988095L    # 0.019993

    sub-double/2addr v8, p0

    mul-double/2addr v6, v8

    add-double/2addr v2, v6

    add-double/2addr v4, v0

    .line 293
    invoke-static {v4, v5}, Ljava/lang/Math;->sin(D)D

    move-result-wide p0

    const-wide v0, 0x3f32f09d8c6d612cL    # 2.89E-4

    mul-double/2addr p0, v0

    add-double/2addr v2, p0

    .line 291
    return-wide v2
.end method

.method private static wrap360(D)D
    .locals 5

    .line 252
    const-wide v0, 0x4076800000000000L    # 360.0

    rem-double/2addr p0, v0

    .line 253
    const-wide/16 v2, 0x0

    cmpg-double v4, p0, v2

    if-gez v4, :cond_0

    add-double/2addr p0, v0

    .line 254
    :cond_0
    cmpl-double v0, p0, v0

    if-ltz v0, :cond_1

    goto :goto_0

    :cond_1
    move-wide v2, p0

    .line 255
    :goto_0
    return-wide v2
.end method
