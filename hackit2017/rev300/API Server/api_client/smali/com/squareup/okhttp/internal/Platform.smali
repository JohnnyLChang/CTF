.class public Lcom/squareup/okhttp/internal/Platform;
.super Ljava/lang/Object;
.source "Platform.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/squareup/okhttp/internal/Platform$JettyNegoProvider;,
        Lcom/squareup/okhttp/internal/Platform$JdkWithJettyBootPlatform;,
        Lcom/squareup/okhttp/internal/Platform$JdkPlatform;,
        Lcom/squareup/okhttp/internal/Platform$Android;
    }
.end annotation


# static fields
.field private static final PLATFORM:Lcom/squareup/okhttp/internal/Platform;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 67
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->findPlatform()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/Platform;->PLATFORM:Lcom/squareup/okhttp/internal/Platform;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 412
    return-void
.end method

.method static concatLengthPrefixed(Ljava/util/List;)[B
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/Protocol;",
            ">;)[B"
        }
    .end annotation

    .prologue
    .line 462
    .local p0, "protocols":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/Protocol;>;"
    new-instance v2, Lokio/Buffer;

    invoke-direct {v2}, Lokio/Buffer;-><init>()V

    .line 463
    .local v2, "result":Lokio/Buffer;
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    .local v3, "size":I
    :goto_0
    if-ge v0, v3, :cond_1

    .line 464
    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/squareup/okhttp/Protocol;

    .line 465
    .local v1, "protocol":Lcom/squareup/okhttp/Protocol;
    sget-object v4, Lcom/squareup/okhttp/Protocol;->HTTP_1_0:Lcom/squareup/okhttp/Protocol;

    if-ne v1, v4, :cond_0

    .line 463
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 466
    :cond_0
    invoke-virtual {v1}, Lcom/squareup/okhttp/Protocol;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v2, v4}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 467
    invoke-virtual {v1}, Lcom/squareup/okhttp/Protocol;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Lokio/Buffer;->writeUtf8(Ljava/lang/String;)Lokio/Buffer;

    goto :goto_1

    .line 469
    .end local v1    # "protocol":Lcom/squareup/okhttp/Protocol;
    :cond_1
    invoke-virtual {v2}, Lokio/Buffer;->readByteArray()[B

    move-result-object v4

    return-object v4
.end method

.method private static findPlatform()Lcom/squareup/okhttp/internal/Platform;
    .locals 27

    .prologue
    .line 133
    :try_start_0
    const-string v2, "com.android.org.conscrypt.SSLParametersImpl"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 140
    .local v3, "sslParametersClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    :try_start_1
    new-instance v4, Lcom/squareup/okhttp/internal/OptionalMethod;

    const/4 v2, 0x0

    const-string v10, "setUseSessionTickets"

    const/16 v24, 0x1

    move/from16 v0, v24

    new-array v0, v0, [Ljava/lang/Class;

    move-object/from16 v24, v0

    const/16 v25, 0x0

    sget-object v26, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v26, v24, v25

    move-object/from16 v0, v24

    invoke-direct {v4, v2, v10, v0}, Lcom/squareup/okhttp/internal/OptionalMethod;-><init>(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)V

    .line 142
    .local v4, "setUseSessionTickets":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    new-instance v5, Lcom/squareup/okhttp/internal/OptionalMethod;

    const/4 v2, 0x0

    const-string v10, "setHostname"

    const/16 v24, 0x1

    move/from16 v0, v24

    new-array v0, v0, [Ljava/lang/Class;

    move-object/from16 v24, v0

    const/16 v25, 0x0

    const-class v26, Ljava/lang/String;

    aput-object v26, v24, v25

    move-object/from16 v0, v24

    invoke-direct {v5, v2, v10, v0}, Lcom/squareup/okhttp/internal/OptionalMethod;-><init>(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)V
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    .line 144
    .local v5, "setHostname":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    const/4 v6, 0x0

    .line 145
    .local v6, "trafficStatsTagSocket":Ljava/lang/reflect/Method;
    const/4 v7, 0x0

    .line 146
    .local v7, "trafficStatsUntagSocket":Ljava/lang/reflect/Method;
    const/4 v8, 0x0

    .line 147
    .local v8, "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    const/4 v9, 0x0

    .line 151
    .local v9, "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    :try_start_2
    const-string v2, "android.net.TrafficStats"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v23

    .line 152
    .local v23, "trafficStats":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v2, "tagSocket"

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Class;

    const/16 v24, 0x0

    const-class v25, Ljava/net/Socket;

    aput-object v25, v10, v24

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 153
    const-string v2, "untagSocket"

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Class;

    const/16 v24, 0x0

    const-class v25, Ljava/net/Socket;

    aput-object v25, v10, v24

    move-object/from16 v0, v23

    invoke-virtual {v0, v2, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_2
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/lang/NoSuchMethodException; {:try_start_2 .. :try_end_2} :catch_6

    move-result-object v7

    .line 157
    :try_start_3
    const-string v2, "android.net.Network"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    .line 158
    new-instance v18, Lcom/squareup/okhttp/internal/OptionalMethod;

    const-class v2, [B

    const-string v10, "getAlpnSelectedProtocol"

    const/16 v24, 0x0

    move/from16 v0, v24

    new-array v0, v0, [Ljava/lang/Class;

    move-object/from16 v24, v0

    move-object/from16 v0, v18

    move-object/from16 v1, v24

    invoke-direct {v0, v2, v10, v1}, Lcom/squareup/okhttp/internal/OptionalMethod;-><init>(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)V
    :try_end_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/lang/NoSuchMethodException; {:try_start_3 .. :try_end_3} :catch_6

    .line 159
    .end local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .local v18, "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    :try_start_4
    new-instance v22, Lcom/squareup/okhttp/internal/OptionalMethod;

    const/4 v2, 0x0

    const-string v10, "setAlpnProtocols"

    const/16 v24, 0x1

    move/from16 v0, v24

    new-array v0, v0, [Ljava/lang/Class;

    move-object/from16 v24, v0

    const/16 v25, 0x0

    const-class v26, [B

    aput-object v26, v24, v25

    move-object/from16 v0, v22

    move-object/from16 v1, v24

    invoke-direct {v0, v2, v10, v1}, Lcom/squareup/okhttp/internal/OptionalMethod;-><init>(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)V
    :try_end_4
    .catch Ljava/lang/ClassNotFoundException; {:try_start_4 .. :try_end_4} :catch_9
    .catch Ljava/lang/NoSuchMethodException; {:try_start_4 .. :try_end_4} :catch_7

    .end local v9    # "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .local v22, "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    move-object/from16 v9, v22

    .end local v22    # "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v9    # "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    move-object/from16 v8, v18

    .line 165
    .end local v18    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .end local v23    # "trafficStats":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    :goto_1
    :try_start_5
    new-instance v2, Lcom/squareup/okhttp/internal/Platform$Android;

    invoke-direct/range {v2 .. v9}, Lcom/squareup/okhttp/internal/Platform$Android;-><init>(Ljava/lang/Class;Lcom/squareup/okhttp/internal/OptionalMethod;Lcom/squareup/okhttp/internal/OptionalMethod;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Lcom/squareup/okhttp/internal/OptionalMethod;Lcom/squareup/okhttp/internal/OptionalMethod;)V

    move-object v10, v2

    .line 195
    .end local v3    # "sslParametersClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v4    # "setUseSessionTickets":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .end local v5    # "setHostname":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .end local v6    # "trafficStatsTagSocket":Ljava/lang/reflect/Method;
    .end local v7    # "trafficStatsUntagSocket":Ljava/lang/reflect/Method;
    .end local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .end local v9    # "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .local v11, "sslContextClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_2
    return-object v10

    .line 134
    .end local v11    # "sslContextClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_0
    move-exception v17

    .line 136
    .local v17, "e":Ljava/lang/ClassNotFoundException;
    const-string v2, "org.apache.harmony.xnet.provider.jsse.SSLParametersImpl"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_5
    .catch Ljava/lang/ClassNotFoundException; {:try_start_5 .. :try_end_5} :catch_1

    move-result-object v3

    .restart local v3    # "sslParametersClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    goto/16 :goto_0

    .line 168
    .end local v3    # "sslParametersClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_1
    move-exception v2

    .line 174
    .end local v17    # "e":Ljava/lang/ClassNotFoundException;
    :try_start_6
    const-string v2, "sun.security.ssl.SSLContextImpl"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_6
    .catch Ljava/lang/ClassNotFoundException; {:try_start_6 .. :try_end_6} :catch_3

    move-result-object v11

    .line 178
    .restart local v11    # "sslContextClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_7
    const-string v20, "org.eclipse.jetty.alpn.ALPN"

    .line 179
    .local v20, "negoClassName":Ljava/lang/String;
    invoke-static/range {v20 .. v20}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v19

    .line 180
    .local v19, "negoClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v10, "$Provider"

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v21

    .line 181
    .local v21, "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v10, "$ClientProvider"

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v15

    .line 182
    .local v15, "clientProviderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v10, "$ServerProvider"

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v16

    .line 183
    .local v16, "serverProviderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v2, "put"

    const/4 v10, 0x2

    new-array v10, v10, [Ljava/lang/Class;

    const/16 v24, 0x0

    const-class v25, Ljavax/net/ssl/SSLSocket;

    aput-object v25, v10, v24

    const/16 v24, 0x1

    aput-object v21, v10, v24

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v12

    .line 184
    .local v12, "putMethod":Ljava/lang/reflect/Method;
    const-string v2, "get"

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Class;

    const/16 v24, 0x0

    const-class v25, Ljavax/net/ssl/SSLSocket;

    aput-object v25, v10, v24

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v13

    .line 185
    .local v13, "getMethod":Ljava/lang/reflect/Method;
    const-string v2, "remove"

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Class;

    const/16 v24, 0x0

    const-class v25, Ljavax/net/ssl/SSLSocket;

    aput-object v25, v10, v24

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v14

    .line 186
    .local v14, "removeMethod":Ljava/lang/reflect/Method;
    new-instance v10, Lcom/squareup/okhttp/internal/Platform$JdkWithJettyBootPlatform;

    invoke-direct/range {v10 .. v16}, Lcom/squareup/okhttp/internal/Platform$JdkWithJettyBootPlatform;-><init>(Ljava/lang/Class;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/Class;Ljava/lang/Class;)V
    :try_end_7
    .catch Ljava/lang/ClassNotFoundException; {:try_start_7 .. :try_end_7} :catch_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_7 .. :try_end_7} :catch_4

    goto/16 :goto_2

    .line 188
    .end local v12    # "putMethod":Ljava/lang/reflect/Method;
    .end local v13    # "getMethod":Ljava/lang/reflect/Method;
    .end local v14    # "removeMethod":Ljava/lang/reflect/Method;
    .end local v15    # "clientProviderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v16    # "serverProviderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v19    # "negoClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v20    # "negoClassName":Ljava/lang/String;
    .end local v21    # "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_2
    move-exception v2

    .line 191
    :goto_3
    :try_start_8
    new-instance v10, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;

    invoke-direct {v10, v11}, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;-><init>(Ljava/lang/Class;)V
    :try_end_8
    .catch Ljava/lang/ClassNotFoundException; {:try_start_8 .. :try_end_8} :catch_3

    goto/16 :goto_2

    .line 192
    :catch_3
    move-exception v2

    .line 195
    new-instance v10, Lcom/squareup/okhttp/internal/Platform;

    invoke-direct {v10}, Lcom/squareup/okhttp/internal/Platform;-><init>()V

    goto/16 :goto_2

    .line 188
    :catch_4
    move-exception v2

    goto :goto_3

    .line 162
    .end local v11    # "sslContextClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v3    # "sslParametersClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v4    # "setUseSessionTickets":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v5    # "setHostname":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v6    # "trafficStatsTagSocket":Ljava/lang/reflect/Method;
    .restart local v7    # "trafficStatsUntagSocket":Ljava/lang/reflect/Method;
    .restart local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v9    # "setAlpnProtocols":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    :catch_5
    move-exception v2

    goto/16 :goto_1

    :catch_6
    move-exception v2

    goto/16 :goto_1

    .end local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v18    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v23    # "trafficStats":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_7
    move-exception v2

    move-object/from16 v8, v18

    .end local v18    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    goto/16 :goto_1

    .line 160
    :catch_8
    move-exception v2

    goto/16 :goto_1

    .end local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v18    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    :catch_9
    move-exception v2

    move-object/from16 v8, v18

    .end local v18    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    .restart local v8    # "getAlpnSelectedProtocol":Lcom/squareup/okhttp/internal/OptionalMethod;, "Lcom/squareup/okhttp/internal/OptionalMethod<Ljava/net/Socket;>;"
    goto/16 :goto_1
.end method

.method public static get()Lcom/squareup/okhttp/internal/Platform;
    .locals 1

    .prologue
    .line 70
    sget-object v0, Lcom/squareup/okhttp/internal/Platform;->PLATFORM:Lcom/squareup/okhttp/internal/Platform;

    return-object v0
.end method

.method static readFieldOrNull(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 8
    .param p0, "instance"    # Ljava/lang/Object;
    .param p2, "fieldName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            "Ljava/lang/Class",
            "<TT;>;",
            "Ljava/lang/String;",
            ")TT;"
        }
    .end annotation

    .prologue
    .local p1, "fieldType":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    const/4 v5, 0x0

    .line 473
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .local v0, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    const-class v6, Ljava/lang/Object;

    if-eq v0, v6, :cond_2

    .line 475
    :try_start_0
    invoke-virtual {v0, p2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    .line 476
    .local v3, "field":Ljava/lang/reflect/Field;
    const/4 v6, 0x1

    invoke-virtual {v3, v6}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 477
    invoke-virtual {v3, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 478
    .local v4, "value":Ljava/lang/Object;
    if-eqz v4, :cond_0

    invoke-virtual {p1, v4}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 492
    .end local v3    # "field":Ljava/lang/reflect/Field;
    .end local v4    # "value":Ljava/lang/Object;
    :cond_0
    :goto_1
    return-object v5

    .line 479
    .restart local v3    # "field":Ljava/lang/reflect/Field;
    .restart local v4    # "value":Ljava/lang/Object;
    :cond_1
    invoke-virtual {p1, v4}, Ljava/lang/Class;->cast(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    goto :goto_1

    .line 481
    .end local v3    # "field":Ljava/lang/reflect/Field;
    .end local v4    # "value":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 482
    .local v2, "e":Ljava/lang/IllegalAccessException;
    new-instance v5, Ljava/lang/AssertionError;

    invoke-direct {v5}, Ljava/lang/AssertionError;-><init>()V

    throw v5

    .line 480
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_1
    move-exception v6

    .line 473
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    .line 487
    :cond_2
    const-string v6, "delegate"

    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 488
    const-class v6, Ljava/lang/Object;

    const-string v7, "delegate"

    invoke-static {p0, v6, v7}, Lcom/squareup/okhttp/internal/Platform;->readFieldOrNull(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 489
    .local v1, "delegate":Ljava/lang/Object;
    if-eqz v1, :cond_0

    invoke-static {v1, p1, p2}, Lcom/squareup/okhttp/internal/Platform;->readFieldOrNull(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    goto :goto_1
.end method


# virtual methods
.method public afterHandshake(Ljavax/net/ssl/SSLSocket;)V
    .locals 0
    .param p1, "sslSocket"    # Ljavax/net/ssl/SSLSocket;

    .prologue
    .line 111
    return-void
.end method

.method public configureTlsExtensions(Ljavax/net/ssl/SSLSocket;Ljava/lang/String;Ljava/util/List;)V
    .locals 0
    .param p1, "sslSocket"    # Ljavax/net/ssl/SSLSocket;
    .param p2, "hostname"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/net/ssl/SSLSocket;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/Protocol;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 104
    .local p3, "protocols":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/Protocol;>;"
    return-void
.end method

.method public connectSocket(Ljava/net/Socket;Ljava/net/InetSocketAddress;I)V
    .locals 0
    .param p1, "socket"    # Ljava/net/Socket;
    .param p2, "address"    # Ljava/net/InetSocketAddress;
    .param p3, "connectTimeout"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 120
    invoke-virtual {p1, p2, p3}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 121
    return-void
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    .line 75
    const-string v0, "OkHttp"

    return-object v0
.end method

.method public getSelectedProtocol(Ljavax/net/ssl/SSLSocket;)Ljava/lang/String;
    .locals 1
    .param p1, "socket"    # Ljavax/net/ssl/SSLSocket;

    .prologue
    .line 115
    const/4 v0, 0x0

    return-object v0
.end method

.method public log(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    .line 124
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 125
    return-void
.end method

.method public logW(Ljava/lang/String;)V
    .locals 1
    .param p1, "warning"    # Ljava/lang/String;

    .prologue
    .line 79
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v0, p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 80
    return-void
.end method

.method public tagSocket(Ljava/net/Socket;)V
    .locals 0
    .param p1, "socket"    # Ljava/net/Socket;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/SocketException;
        }
    .end annotation

    .prologue
    .line 83
    return-void
.end method

.method public trustManager(Ljavax/net/ssl/SSLSocketFactory;)Ljavax/net/ssl/X509TrustManager;
    .locals 1
    .param p1, "sslSocketFactory"    # Ljavax/net/ssl/SSLSocketFactory;

    .prologue
    .line 89
    const/4 v0, 0x0

    return-object v0
.end method

.method public trustRootIndex(Ljavax/net/ssl/X509TrustManager;)Lcom/squareup/okhttp/internal/tls/TrustRootIndex;
    .locals 2
    .param p1, "trustManager"    # Ljavax/net/ssl/X509TrustManager;

    .prologue
    .line 93
    new-instance v0, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;

    invoke-interface {p1}, Ljavax/net/ssl/X509TrustManager;->getAcceptedIssuers()[Ljava/security/cert/X509Certificate;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;-><init>([Ljava/security/cert/X509Certificate;)V

    return-object v0
.end method

.method public untagSocket(Ljava/net/Socket;)V
    .locals 0
    .param p1, "socket"    # Ljava/net/Socket;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/SocketException;
        }
    .end annotation

    .prologue
    .line 86
    return-void
.end method
