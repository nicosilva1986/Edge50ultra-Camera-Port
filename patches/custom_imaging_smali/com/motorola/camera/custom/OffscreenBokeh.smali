.class final Lcom/motorola/camera/custom/OffscreenBokeh;
.super Ljava/lang/Object;
.source "OffscreenBokeh.java"


# static fields
.field private static final FRAGMENT:Ljava/lang/String;

.field private static final VERTEX:Ljava/lang/String; = "#version 300 es\nout vec2 uv;\nvoid main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }"


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 19
    const/16 v0, 0x35

    new-array v0, v0, [Ljava/lang/CharSequence;

    const/4 v1, 0x0

    const-string v2, "#version 300 es"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "precision highp float;"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "precision highp int;"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "in vec2 uv;"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "out vec4 outputColor;"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "uniform sampler2D image, depth;"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "uniform vec2 radius;"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "uniform float focus;"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "uniform int style;"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "uniform vec3 taps[32];"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "vec3 toLin(vec3 s){ bvec3 lo=lessThanEqual(s,vec3(0.04045)); return mix(pow((s+0.055)/1.055,vec3(2.4)),s/12.92,lo); }"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "vec3 toSrgb(vec3 l){ l=clamp(l,0.0,1.0); bvec3 lo=lessThanEqual(l,vec3(0.0031308)); return mix(1.055*pow(l,vec3(1.0/2.4))-0.055,12.92*l,lo); }"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "float coc(float d){return smoothstep(3.0/255.0,71.0/255.0,abs(d-focus));}"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "float dweight(float d,float ds,float c){return (1.0-smoothstep(18.0/255.0,46.0/255.0,abs(d-ds)))*step(c*0.38,coc(ds));}"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "void main(){"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, " float d=texture(depth,uv).r; float c=coc(d);"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, " vec3 origSrgb=texture(image,uv).rgb;"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, " if(c<0.02){outputColor=vec4(origSrgb,1.0);return;}"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, " vec2 radial=uv-0.5; float edge=length(radial); vec2 n=radial/max(edge,0.0001);"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, " float a=1.7*edge*c; mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, " vec3 rgb=vec3(0.0); float sum=0.0;"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, " for(int i=0;i<32;++i){"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "   vec2 p=taps[i].xy;"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "   if(style==1){p=rot*p; p-=n*dot(n,p)*edge*0.8;}"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "   else if(style!=4){p-=n*dot(n,p)*edge*edge*0.22;}"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "   vec2 at=clamp(uv+p*radius*c,vec2(0.0),vec2(1.0)); float ds=texture(depth,at).r;"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "   float dw=dweight(d,ds,c);"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "   if(dw<=0.0) continue;"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "   vec3 lin=toLin(texture(image,at).rgb);"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "   float luma=dot(lin,vec3(0.2126,0.7152,0.0722));"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "   float spec=1.0+1.35*smoothstep(0.72,1.0,luma)*c;"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "   float w=taps[i].z*dw;"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "   rgb+=lin*spec*w; sum+=w;"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, " }"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v3, " rgb=sum>0.0?rgb/sum:toLin(origSrgb);"

    aput-object v3, v0, v1

    const/16 v1, 0x23

    const-string v3, " if(style==4){"

    aput-object v3, v0, v1

    const/16 v1, 0x24

    const-string v3, "   vec2 streak=vec2(radius.x*c,0.0);"

    aput-object v3, v0, v1

    const/16 v1, 0x25

    const-string v3, "   vec3 sSum=vec3(0.0); float sW=0.0;"

    aput-object v3, v0, v1

    const/16 v1, 0x26

    const-string v3, "   for(int k=-1;k<=1;k+=2){"

    aput-object v3, v0, v1

    const/16 v1, 0x27

    const-string v3, "     vec2 sat=clamp(uv+float(k)*streak,vec2(0.0),vec2(1.0));"

    aput-object v3, v0, v1

    const/16 v1, 0x28

    const-string v3, "     float sds=texture(depth,sat).r;"

    aput-object v3, v0, v1

    const/16 v1, 0x29

    const-string v3, "     float dw=dweight(d,sds,c);"

    aput-object v3, v0, v1

    const/16 v1, 0x2a

    const-string v3, "     if(dw>0.0){"

    aput-object v3, v0, v1

    const/16 v1, 0x2b

    const-string v3, "       sSum+=toLin(texture(image,sat).rgb)*dw; sW+=dw;"

    aput-object v3, v0, v1

    const/16 v1, 0x2c

    const-string v3, "     }"

    aput-object v3, v0, v1

    const/16 v1, 0x2d

    const-string v3, "   }"

    aput-object v3, v0, v1

    const/16 v1, 0x2e

    const-string v4, "   if(sW>0.0){"

    aput-object v4, v0, v1

    const/16 v1, 0x2f

    const-string v4, "     vec3 b=sSum/sW;"

    aput-object v4, v0, v1

    const/16 v1, 0x30

    const-string v4, "     rgb+=0.18*c*vec3(0.45,0.85,1.0)*max(0.0,max(b.r,max(b.g,b.b))-0.68);"

    aput-object v4, v0, v1

    const/16 v1, 0x31

    aput-object v3, v0, v1

    const/16 v1, 0x32

    aput-object v2, v0, v1

    const/16 v1, 0x33

    const-string v2, " outputColor=vec4(toSrgb(rgb),1.0);"

    aput-object v2, v0, v1

    const/16 v1, 0x34

    const-string v2, "}"

    aput-object v2, v0, v1

    const-string v1, "\n"

    invoke-static {v1, v0}, Ljava/lang/String;->join(Ljava/lang/CharSequence;[Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/motorola/camera/custom/OffscreenBokeh;->FRAGMENT:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static compile(ILjava/lang/String;)I
    .locals 2

    .line 179
    invoke-static {p0}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result p0

    .line 180
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 181
    :cond_0
    invoke-static {p0, p1}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    .line 182
    invoke-static {p0}, Landroid/opengl/GLES20;->glCompileShader(I)V

    .line 183
    const/4 p1, 0x1

    new-array p1, p1, [I

    .line 184
    const v1, 0x8b81

    invoke-static {p0, v1, p1, v0}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    .line 185
    aget p1, p1, v0

    if-nez p1, :cond_1

    .line 186
    invoke-static {p0}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 187
    return v0

    .line 189
    :cond_1
    return p0
.end method

.method private static drawFbo([I[BIIIIF)[I
    .locals 21

    .line 97
    move-object/from16 v0, p0

    .line 98
    const/4 v10, 0x3

    new-array v11, v10, [I

    .line 99
    const/4 v12, 0x1

    new-array v13, v12, [I

    .line 101
    const/4 v14, 0x2

    const v15, 0x8d40

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "#version 300 es\nout vec2 uv;\nvoid main(){ uv=vec2(float((gl_VertexID<<1)&2),float(gl_VertexID&2));gl_Position=vec4(uv*2.0-1.0,0.0,1.0); }"

    const v3, 0x8b31

    invoke-static {v3, v2}, Lcom/motorola/camera/custom/OffscreenBokeh;->compile(ILjava/lang/String;)I

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_7

    .line 102
    :try_start_1
    sget-object v3, Lcom/motorola/camera/custom/OffscreenBokeh;->FRAGMENT:Ljava/lang/String;

    const v4, 0x8b30

    invoke-static {v4, v3}, Lcom/motorola/camera/custom/OffscreenBokeh;->compile(ILjava/lang/String;)I

    move-result v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_6

    .line 103
    const/16 v16, 0x0

    if-eqz v2, :cond_2e

    if-nez v3, :cond_0

    move/from16 v19, v2

    move/from16 v17, v3

    move/from16 v20, v14

    move v14, v1

    goto/16 :goto_b

    .line 104
    :cond_0
    :try_start_2
    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_5

    .line 105
    if-nez v4, :cond_7

    .line 167
    :try_start_3
    invoke-static {v15, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v1}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v1

    if-eqz v0, :cond_1

    invoke-static {v12, v13, v1}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_1
    aget v0, v11, v1

    if-nez v0, :cond_2

    aget v0, v11, v12

    if-nez v0, :cond_2

    aget v0, v11, v14

    if-eqz v0, :cond_3

    :cond_2
    invoke-static {v10, v11, v1}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_3
    if-eqz v4, :cond_4

    invoke-static {v4}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_4
    if-eqz v2, :cond_5

    invoke-static {v2}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_5
    if-eqz v3, :cond_6

    invoke-static {v3}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    .line 174
    :catch_0
    move-exception v0

    :cond_6
    :goto_0
    nop

    .line 105
    return-object v16

    .line 106
    :cond_7
    :try_start_4
    invoke-static {v4, v2}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 107
    invoke-static {v4, v3}, Landroid/opengl/GLES20;->glAttachShader(II)V

    .line 108
    invoke-static {v4}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    .line 109
    new-array v5, v12, [I

    .line 110
    const v6, 0x8b82

    invoke-static {v4, v6, v5, v1}, Landroid/opengl/GLES20;->glGetProgramiv(II[II)V

    .line 111
    aget v5, v5, v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    if-nez v5, :cond_e

    .line 167
    :try_start_5
    invoke-static {v15, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v1}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v1

    if-eqz v0, :cond_8

    invoke-static {v12, v13, v1}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_8
    aget v0, v11, v1

    if-nez v0, :cond_9

    aget v0, v11, v12

    if-nez v0, :cond_9

    aget v0, v11, v14

    if-eqz v0, :cond_a

    :cond_9
    invoke-static {v10, v11, v1}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_a
    if-eqz v4, :cond_b

    invoke-static {v4}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_b
    if-eqz v2, :cond_c

    invoke-static {v2}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_c
    if-eqz v3, :cond_d

    invoke-static {v3}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/LinkageError; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_1

    .line 174
    :catch_1
    move-exception v0

    :cond_d
    :goto_1
    nop

    .line 111
    return-object v16

    .line 113
    :cond_e
    :try_start_6
    invoke-static {v10, v11, v1}, Landroid/opengl/GLES20;->glGenTextures(I[II)V

    .line 114
    invoke-static {v12, v13, v1}, Landroid/opengl/GLES20;->glGenFramebuffers(I[II)V

    .line 115
    aget v5, v11, v1

    if-eqz v5, :cond_27

    aget v5, v11, v12

    if-eqz v5, :cond_27

    aget v5, v11, v14

    if-eqz v5, :cond_27

    aget v5, v13, v1

    if-nez v5, :cond_f

    move/from16 v19, v2

    move/from16 v17, v3

    move v8, v4

    move/from16 v20, v14

    move v14, v1

    goto/16 :goto_8

    .line 118
    :cond_f
    aget v5, v11, v14

    const/16 v6, 0xde1

    invoke-static {v6, v5}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 119
    const/16 v5, 0x2801

    const/16 v7, 0x2600

    invoke-static {v6, v5, v7}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 120
    const/16 v5, 0x2800

    invoke-static {v6, v5, v7}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 121
    const/16 v5, 0x2802

    const v7, 0x812f

    invoke-static {v6, v5, v7}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 122
    const/16 v5, 0x2803

    invoke-static {v6, v5, v7}, Landroid/opengl/GLES20;->glTexParameteri(III)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    .line 123
    const/16 v8, 0x1401

    const/4 v9, 0x0

    move v5, v1

    const/16 v1, 0xde1

    move v7, v2

    const/4 v2, 0x0

    move/from16 v17, v3

    const/16 v3, 0x1908

    move/from16 v18, v6

    const/4 v6, 0x0

    move/from16 v19, v7

    const/16 v7, 0x1908

    move/from16 v20, v14

    move/from16 v10, v18

    move/from16 v18, v4

    move v14, v5

    move/from16 v4, p2

    move/from16 v5, p3

    :try_start_7
    invoke-static/range {v1 .. v9}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 125
    aget v1, v13, v14

    invoke-static {v15, v1}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 126
    aget v1, v11, v20

    const v2, 0x8ce0

    invoke-static {v15, v2, v10, v1, v14}, Landroid/opengl/GLES20;->glFramebufferTexture2D(IIIII)V

    .line 128
    invoke-static {v15}, Landroid/opengl/GLES20;->glCheckFramebufferStatus(I)I

    move-result v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    const v2, 0x8cd5

    if-eq v1, v2, :cond_16

    .line 129
    nop

    .line 167
    :try_start_8
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_10

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_10
    aget v0, v11, v14

    if-nez v0, :cond_11

    aget v0, v11, v12

    if-nez v0, :cond_11

    aget v0, v11, v20

    if-eqz v0, :cond_12

    :cond_11
    const/4 v1, 0x3

    invoke-static {v1, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_12
    if-eqz v18, :cond_13

    invoke-static/range {v18 .. v18}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_13
    if-eqz v19, :cond_14

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_14
    if-eqz v17, :cond_15

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_8
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/lang/LinkageError; {:try_start_8 .. :try_end_8} :catch_2

    goto :goto_2

    .line 174
    :catch_2
    move-exception v0

    :cond_15
    :goto_2
    nop

    .line 129
    return-object v16

    .line 132
    :cond_16
    :try_start_9
    array-length v1, v0

    const/4 v9, 0x4

    mul-int/2addr v1, v9

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    .line 133
    array-length v1, v0

    mul-int/2addr v1, v9

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v10

    .line 134
    move v1, v14

    :goto_3
    array-length v2, v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    if-ge v1, v2, :cond_17

    .line 135
    :try_start_a
    aget v2, v0, v1

    .line 136
    ushr-int/lit8 v3, v2, 0x10

    int-to-byte v3, v3

    invoke-virtual {v4, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v3

    ushr-int/lit8 v5, v2, 0x8

    int-to-byte v5, v5

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v3

    int-to-byte v2, v2

    invoke-virtual {v3, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v2

    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 137
    aget-byte v2, p1, v1

    invoke-virtual {v10, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 134
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 166
    :catchall_0
    move-exception v0

    move-object v1, v0

    move/from16 v8, v18

    goto/16 :goto_d

    .line 139
    :cond_17
    :try_start_b
    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 140
    invoke-virtual {v10}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/ByteBuffer;

    .line 142
    invoke-static/range {v18 .. v18}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 143
    const-string v2, "image"

    aget v3, v11, v14
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_3

    const/4 v7, 0x0

    const/16 v8, 0x2601

    move/from16 v5, p2

    move/from16 v6, p3

    move/from16 v1, v18

    :try_start_c
    invoke-static/range {v1 .. v8}, Lcom/motorola/camera/custom/OffscreenBokeh;->uploadTexture(ILjava/lang/String;ILjava/nio/ByteBuffer;IIII)V

    move-object/from16 v18, v4

    .line 144
    const-string v2, "depth"

    aget v3, v11, v12

    const/4 v7, 0x1

    const/16 v8, 0x2600

    move/from16 v5, p2

    move/from16 v6, p3

    move-object v4, v10

    invoke-static/range {v1 .. v8}, Lcom/motorola/camera/custom/OffscreenBokeh;->uploadTexture(ILjava/lang/String;ILjava/nio/ByteBuffer;IIII)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_2

    move v8, v1

    .line 145
    :try_start_d
    const-string v1, "style"

    invoke-static {v8, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    move/from16 v2, p5

    invoke-static {v1, v2}, Landroid/opengl/GLES20;->glUniform1i(II)V

    .line 146
    const-string v1, "focus"

    invoke-static {v8, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    move/from16 v3, p4

    int-to-float v3, v3

    const/high16 v4, 0x437f0000    # 255.0f

    div-float/2addr v3, v4

    invoke-static {v1, v3}, Landroid/opengl/GLES20;->glUniform1f(IF)V

    .line 147
    invoke-static/range {p6 .. p6}, Ljava/lang/Float;->isFinite(F)Z

    move-result v1

    if-eqz v1, :cond_18

    move/from16 v1, p6

    goto :goto_4

    :cond_18
    const/high16 v1, 0x3f800000    # 1.0f

    :goto_4
    const v3, 0x3fb9999a    # 1.45f

    invoke-static {v3, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    const v3, 0x3f333333    # 0.7f

    invoke-static {v3, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 148
    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->min(II)I

    move-result v3

    int-to-float v3, v3

    const v4, 0x3cdd2f1b    # 0.027f

    mul-float/2addr v3, v4

    mul-float/2addr v3, v1

    const/high16 v1, 0x40000000    # 2.0f

    invoke-static {v1, v3}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 149
    const-string v3, "radius"

    invoke-static {v8, v3}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v3

    int-to-float v4, v5

    div-float v4, v1, v4

    int-to-float v7, v6

    div-float/2addr v1, v7

    invoke-static {v3, v4, v1}, Landroid/opengl/GLES20;->glUniform2f(IFF)V

    .line 150
    const-string v1, "taps[0]"

    invoke-static {v8, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v1

    .line 151
    invoke-static {v2}, Lcom/motorola/camera/custom/BokehKernel;->aperture(I)[F

    move-result-object v2

    .line 150
    const/16 v3, 0x20

    invoke-static {v1, v3, v2, v14}, Landroid/opengl/GLES20;->glUniform3fv(II[FI)V

    .line 152
    invoke-static {v14, v14, v5, v6}, Landroid/opengl/GLES20;->glViewport(IIII)V

    .line 153
    const/4 v1, 0x3

    invoke-static {v9, v14, v1}, Landroid/opengl/GLES20;->glDrawArrays(III)V

    .line 154
    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/ByteBuffer;

    .line 155
    const/16 v5, 0x1908

    const/16 v6, 0x1401

    const/4 v1, 0x0

    const/4 v2, 0x0

    move/from16 v3, p2

    move/from16 v4, p3

    move-object/from16 v7, v18

    invoke-static/range {v1 .. v7}, Landroid/opengl/GLES20;->glReadPixels(IIIIIILjava/nio/Buffer;)V

    .line 156
    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result v1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    if-eqz v1, :cond_1f

    .line 167
    :try_start_e
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_19

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_19
    aget v0, v11, v14

    if-nez v0, :cond_1a

    aget v0, v11, v12

    if-nez v0, :cond_1a

    aget v0, v11, v20

    if-eqz v0, :cond_1b

    :cond_1a
    const/4 v1, 0x3

    invoke-static {v1, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_1b
    if-eqz v8, :cond_1c

    invoke-static {v8}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_1c
    if-eqz v19, :cond_1d

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_1d
    if-eqz v17, :cond_1e

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_e
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_e} :catch_3
    .catch Ljava/lang/LinkageError; {:try_start_e .. :try_end_e} :catch_3

    goto :goto_5

    .line 174
    :catch_3
    move-exception v0

    :cond_1e
    :goto_5
    nop

    .line 156
    return-object v16

    .line 157
    :cond_1f
    :try_start_f
    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/ByteBuffer;

    .line 158
    array-length v0, v0

    new-array v1, v0, [I

    .line 159
    move v2, v14

    :goto_6
    if-ge v2, v0, :cond_20

    .line 160
    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->get()B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    shl-int/lit8 v3, v3, 0x10

    const/high16 v4, -0x1000000

    or-int/2addr v3, v4

    .line 161
    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->get()B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v3, v4

    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->get()B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    or-int/2addr v3, v4

    aput v3, v1, v2

    .line 162
    invoke-virtual/range {v18 .. v18}, Ljava/nio/ByteBuffer;->get()B
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_1

    .line 159
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 164
    :cond_20
    nop

    .line 167
    :try_start_10
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_21

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_21
    aget v0, v11, v14

    if-nez v0, :cond_22

    aget v0, v11, v12

    if-nez v0, :cond_22

    aget v0, v11, v20

    if-eqz v0, :cond_23

    :cond_22
    const/4 v2, 0x3

    invoke-static {v2, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_23
    if-eqz v8, :cond_24

    invoke-static {v8}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_24
    if-eqz v19, :cond_25

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_25
    if-eqz v17, :cond_26

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_10
    .catch Ljava/lang/RuntimeException; {:try_start_10 .. :try_end_10} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_10 .. :try_end_10} :catch_4

    goto :goto_7

    .line 174
    :catch_4
    move-exception v0

    :cond_26
    :goto_7
    nop

    .line 164
    return-object v1

    .line 166
    :catchall_1
    move-exception v0

    goto :goto_a

    :catchall_2
    move-exception v0

    move v8, v1

    goto :goto_a

    :catchall_3
    move-exception v0

    move/from16 v8, v18

    goto :goto_a

    .line 115
    :cond_27
    move/from16 v19, v2

    move/from16 v17, v3

    move v8, v4

    move/from16 v20, v14

    move v14, v1

    .line 167
    :goto_8
    :try_start_11
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_28

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_28
    aget v0, v11, v14

    if-nez v0, :cond_29

    aget v0, v11, v12

    if-nez v0, :cond_29

    aget v0, v11, v20

    if-eqz v0, :cond_2a

    :cond_29
    const/4 v1, 0x3

    invoke-static {v1, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_2a
    if-eqz v8, :cond_2b

    invoke-static {v8}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_2b
    if-eqz v19, :cond_2c

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_2c
    if-eqz v17, :cond_2d

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_11
    .catch Ljava/lang/RuntimeException; {:try_start_11 .. :try_end_11} :catch_5
    .catch Ljava/lang/LinkageError; {:try_start_11 .. :try_end_11} :catch_5

    goto :goto_9

    .line 174
    :catch_5
    move-exception v0

    :cond_2d
    :goto_9
    nop

    .line 115
    return-object v16

    .line 166
    :catchall_4
    move-exception v0

    move/from16 v19, v2

    move/from16 v17, v3

    move v8, v4

    move/from16 v20, v14

    move v14, v1

    :goto_a
    move-object v1, v0

    goto/16 :goto_d

    :catchall_5
    move-exception v0

    move/from16 v19, v2

    move/from16 v17, v3

    move/from16 v20, v14

    move v14, v1

    move-object v1, v0

    move v8, v14

    goto :goto_d

    .line 103
    :cond_2e
    move/from16 v19, v2

    move/from16 v17, v3

    move/from16 v20, v14

    move v14, v1

    .line 167
    :goto_b
    :try_start_12
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_2f

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_2f
    aget v0, v11, v14

    if-nez v0, :cond_30

    aget v0, v11, v12

    if-nez v0, :cond_30

    aget v0, v11, v20

    if-eqz v0, :cond_31

    :cond_30
    const/4 v1, 0x3

    invoke-static {v1, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_31
    nop

    .line 172
    if-eqz v19, :cond_32

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_32
    if-eqz v17, :cond_33

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_12
    .catch Ljava/lang/RuntimeException; {:try_start_12 .. :try_end_12} :catch_6
    .catch Ljava/lang/LinkageError; {:try_start_12 .. :try_end_12} :catch_6

    goto :goto_c

    .line 174
    :catch_6
    move-exception v0

    :cond_33
    :goto_c
    nop

    .line 103
    return-object v16

    .line 166
    :catchall_6
    move-exception v0

    move/from16 v19, v2

    move/from16 v20, v14

    move v14, v1

    move-object v1, v0

    move v8, v14

    move/from16 v17, v8

    goto :goto_d

    :catchall_7
    move-exception v0

    move/from16 v20, v14

    move v14, v1

    move-object v1, v0

    move v8, v14

    move/from16 v17, v8

    move/from16 v19, v17

    .line 167
    :goto_d
    :try_start_13
    invoke-static {v15, v14}, Landroid/opengl/GLES20;->glBindFramebuffer(II)V

    .line 168
    invoke-static {v14}, Landroid/opengl/GLES20;->glUseProgram(I)V

    .line 169
    aget v0, v13, v14

    if-eqz v0, :cond_34

    invoke-static {v12, v13, v14}, Landroid/opengl/GLES20;->glDeleteFramebuffers(I[II)V

    .line 170
    :cond_34
    aget v0, v11, v14

    if-nez v0, :cond_35

    aget v0, v11, v12

    if-nez v0, :cond_35

    aget v0, v11, v20

    if-eqz v0, :cond_36

    :cond_35
    const/4 v2, 0x3

    invoke-static {v2, v11, v14}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 171
    :cond_36
    if-eqz v8, :cond_37

    invoke-static {v8}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    .line 172
    :cond_37
    if-eqz v19, :cond_38

    invoke-static/range {v19 .. v19}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    .line 173
    :cond_38
    if-eqz v17, :cond_39

    invoke-static/range {v17 .. v17}, Landroid/opengl/GLES20;->glDeleteShader(I)V
    :try_end_13
    .catch Ljava/lang/RuntimeException; {:try_start_13 .. :try_end_13} :catch_7
    .catch Ljava/lang/LinkageError; {:try_start_13 .. :try_end_13} :catch_7

    goto :goto_e

    .line 174
    :catch_7
    move-exception v0

    :cond_39
    :goto_e
    nop

    .line 175
    throw v1
.end method

.method static render([I[BIIII)[I
    .locals 7

    .line 77
    const/high16 v6, 0x3f800000    # 1.0f

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Lcom/motorola/camera/custom/OffscreenBokeh;->render([I[BIIIIF)[I

    move-result-object p0

    return-object p0
.end method

.method static render([I[BIIIIF)[I
    .locals 3

    .line 81
    const/4 v1, 0x0

    if-eqz p0, :cond_6

    if-eqz p1, :cond_6

    if-lez p2, :cond_6

    if-lez p3, :cond_6

    array-length v0, p0

    mul-int v2, p2, p3

    if-lt v0, v2, :cond_6

    array-length v0, p1

    if-ge v0, v2, :cond_0

    goto :goto_1

    .line 86
    :cond_0
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetCurrentContext()Landroid/opengl/EGLContext;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    return-object v1

    .line 87
    :cond_1
    :try_start_0
    invoke-static {}, Lcom/motorola/camera/custom/GpuComputeContext;->acquire()Lcom/motorola/camera/custom/GpuComputeContext$Scope;

    move-result-object v2

    .line 88
    if-nez v2, :cond_3

    .line 90
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->close()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    :cond_2
    return-object v1

    .line 89
    :cond_3
    :try_start_1
    invoke-static/range {p0 .. p6}, Lcom/motorola/camera/custom/OffscreenBokeh;->drawFbo([I[BIIIIF)[I

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 90
    if-eqz v2, :cond_4

    :try_start_2
    invoke-virtual {v2}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->close()V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_2 .. :try_end_2} :catch_0

    .line 89
    :cond_4
    return-object p0

    .line 87
    :catchall_0
    move-exception v0

    move-object p0, v0

    if-eqz v2, :cond_5

    :try_start_3
    invoke-virtual {v2}, Lcom/motorola/camera/custom/GpuComputeContext$Scope;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v0

    move-object p1, v0

    :try_start_4
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_5
    :goto_0
    throw p0
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_4 .. :try_end_4} :catch_0

    .line 90
    :catch_0
    move-exception v0

    .line 91
    return-object v1

    .line 83
    :cond_6
    :goto_1
    return-object v1
.end method

.method private static uploadTexture(ILjava/lang/String;ILjava/nio/ByteBuffer;IIII)V
    .locals 12

    .line 194
    move/from16 v0, p6

    move/from16 v1, p7

    const v2, 0x84c0

    add-int/2addr v2, v0

    invoke-static {v2}, Landroid/opengl/GLES20;->glActiveTexture(I)V

    .line 195
    const/16 v2, 0xde1

    invoke-static {v2, p2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    .line 196
    const/16 p2, 0x2801

    invoke-static {v2, p2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 197
    const/16 p2, 0x2800

    invoke-static {v2, p2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 198
    const/16 p2, 0x2802

    const v1, 0x812f

    invoke-static {v2, p2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 199
    const/16 p2, 0x2803

    invoke-static {v2, p2, v1}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    .line 200
    const/16 v9, 0x1908

    const/16 v10, 0x1401

    const/16 v3, 0xde1

    const/4 v4, 0x0

    const/16 v5, 0x1908

    const/4 v8, 0x0

    move-object v11, p3

    move/from16 v6, p4

    move/from16 v7, p5

    invoke-static/range {v3 .. v11}, Landroid/opengl/GLES20;->glTexImage2D(IIIIIIIILjava/nio/Buffer;)V

    .line 202
    invoke-static/range {p0 .. p1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result p0

    invoke-static {p0, v0}, Landroid/opengl/GLES20;->glUniform1i(II)V

    .line 203
    return-void
.end method
