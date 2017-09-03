.class public final Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;
.super Ljava/lang/Object;
.source "AuthenticatorAdapter.java"

# interfaces
.implements Lcom/squareup/okhttp/Authenticator;


# static fields
.field public static final INSTANCE:Lcom/squareup/okhttp/Authenticator;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 35
    new-instance v0, Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;

    invoke-direct {v0}, Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;-><init>()V

    sput-object v0, Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;->INSTANCE:Lcom/squareup/okhttp/Authenticator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getConnectToInetAddress(Ljava/net/Proxy;Lcom/squareup/okhttp/HttpUrl;)Ljava/net/InetAddress;
    .locals 2
    .param p1, "proxy"    # Ljava/net/Proxy;
    .param p2, "url"    # Lcom/squareup/okhttp/HttpUrl;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 83
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v0

    sget-object v1, Ljava/net/Proxy$Type;->DIRECT:Ljava/net/Proxy$Type;

    if-eq v0, v1, :cond_0

    .line 84
    invoke-virtual {p1}, Ljava/net/Proxy;->address()Ljava/net/SocketAddress;

    move-result-object v0

    check-cast v0, Ljava/net/InetSocketAddress;

    invoke-virtual {v0}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v0

    .line 85
    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p2}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    goto :goto_0
.end method


# virtual methods
.method public authenticate(Ljava/net/Proxy;Lcom/squareup/okhttp/Response;)Lcom/squareup/okhttp/Request;
    .locals 19
    .param p1, "proxy"    # Ljava/net/Proxy;
    .param p2, "response"    # Lcom/squareup/okhttp/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 38
    invoke-virtual/range {p2 .. p2}, Lcom/squareup/okhttp/Response;->challenges()Ljava/util/List;

    move-result-object v13

    .line 39
    .local v13, "challenges":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/Challenge;>;"
    invoke-virtual/range {p2 .. p2}, Lcom/squareup/okhttp/Response;->request()Lcom/squareup/okhttp/Request;

    move-result-object v16

    .line 40
    .local v16, "request":Lcom/squareup/okhttp/Request;
    invoke-virtual/range {v16 .. v16}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v18

    .line 41
    .local v18, "url":Lcom/squareup/okhttp/HttpUrl;
    const/4 v15, 0x0

    .local v15, "i":I
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v17

    .local v17, "size":I
    :goto_0
    move/from16 v0, v17

    if-ge v15, v0, :cond_2

    .line 42
    invoke-interface {v13, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/squareup/okhttp/Challenge;

    .line 43
    .local v12, "challenge":Lcom/squareup/okhttp/Challenge;
    const-string v3, "Basic"

    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getScheme()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 41
    :cond_0
    add-int/lit8 v15, v15, 0x1

    goto :goto_0

    .line 46
    :cond_1
    invoke-virtual/range {v18 .. v18}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v18

    invoke-direct {v0, v1, v2}, Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;->getConnectToInetAddress(Ljava/net/Proxy;Lcom/squareup/okhttp/HttpUrl;)Ljava/net/InetAddress;

    move-result-object v4

    invoke-virtual/range {v18 .. v18}, Lcom/squareup/okhttp/HttpUrl;->port()I

    move-result v5

    invoke-virtual/range {v18 .. v18}, Lcom/squareup/okhttp/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v6

    .line 47
    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getRealm()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getScheme()Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {v18 .. v18}, Lcom/squareup/okhttp/HttpUrl;->url()Ljava/net/URL;

    move-result-object v9

    sget-object v10, Ljava/net/Authenticator$RequestorType;->SERVER:Ljava/net/Authenticator$RequestorType;

    .line 45
    invoke-static/range {v3 .. v10}, Ljava/net/Authenticator;->requestPasswordAuthentication(Ljava/lang/String;Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/net/URL;Ljava/net/Authenticator$RequestorType;)Ljava/net/PasswordAuthentication;

    move-result-object v11

    .line 48
    .local v11, "auth":Ljava/net/PasswordAuthentication;
    if-eqz v11, :cond_0

    .line 50
    invoke-virtual {v11}, Ljava/net/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/String;

    invoke-virtual {v11}, Ljava/net/PasswordAuthentication;->getPassword()[C

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/String;-><init>([C)V

    invoke-static {v3, v4}, Lcom/squareup/okhttp/Credentials;->basic(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 51
    .local v14, "credential":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Lcom/squareup/okhttp/Request;->newBuilder()Lcom/squareup/okhttp/Request$Builder;

    move-result-object v3

    const-string v4, "Authorization"

    .line 52
    invoke-virtual {v3, v4, v14}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v3

    .line 53
    invoke-virtual {v3}, Lcom/squareup/okhttp/Request$Builder;->build()Lcom/squareup/okhttp/Request;

    move-result-object v3

    .line 55
    .end local v11    # "auth":Ljava/net/PasswordAuthentication;
    .end local v12    # "challenge":Lcom/squareup/okhttp/Challenge;
    .end local v14    # "credential":Ljava/lang/String;
    :goto_1
    return-object v3

    :cond_2
    const/4 v3, 0x0

    goto :goto_1
.end method

.method public authenticateProxy(Ljava/net/Proxy;Lcom/squareup/okhttp/Response;)Lcom/squareup/okhttp/Request;
    .locals 20
    .param p1, "proxy"    # Ljava/net/Proxy;
    .param p2, "response"    # Lcom/squareup/okhttp/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 60
    invoke-virtual/range {p2 .. p2}, Lcom/squareup/okhttp/Response;->challenges()Ljava/util/List;

    move-result-object v13

    .line 61
    .local v13, "challenges":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/Challenge;>;"
    invoke-virtual/range {p2 .. p2}, Lcom/squareup/okhttp/Response;->request()Lcom/squareup/okhttp/Request;

    move-result-object v17

    .line 62
    .local v17, "request":Lcom/squareup/okhttp/Request;
    invoke-virtual/range {v17 .. v17}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v19

    .line 63
    .local v19, "url":Lcom/squareup/okhttp/HttpUrl;
    const/4 v15, 0x0

    .local v15, "i":I
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v18

    .local v18, "size":I
    :goto_0
    move/from16 v0, v18

    if-ge v15, v0, :cond_2

    .line 64
    invoke-interface {v13, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/squareup/okhttp/Challenge;

    .line 65
    .local v12, "challenge":Lcom/squareup/okhttp/Challenge;
    const-string v3, "Basic"

    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getScheme()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 63
    :cond_0
    add-int/lit8 v15, v15, 0x1

    goto :goto_0

    .line 67
    :cond_1
    invoke-virtual/range {p1 .. p1}, Ljava/net/Proxy;->address()Ljava/net/SocketAddress;

    move-result-object v16

    check-cast v16, Ljava/net/InetSocketAddress;

    .line 69
    .local v16, "proxyAddress":Ljava/net/InetSocketAddress;
    invoke-virtual/range {v16 .. v16}, Ljava/net/InetSocketAddress;->getHostName()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v19

    invoke-direct {v0, v1, v2}, Lcom/squareup/okhttp/internal/http/AuthenticatorAdapter;->getConnectToInetAddress(Ljava/net/Proxy;Lcom/squareup/okhttp/HttpUrl;)Ljava/net/InetAddress;

    move-result-object v4

    invoke-virtual/range {v16 .. v16}, Ljava/net/InetSocketAddress;->getPort()I

    move-result v5

    .line 70
    invoke-virtual/range {v19 .. v19}, Lcom/squareup/okhttp/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getRealm()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v12}, Lcom/squareup/okhttp/Challenge;->getScheme()Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {v19 .. v19}, Lcom/squareup/okhttp/HttpUrl;->url()Ljava/net/URL;

    move-result-object v9

    sget-object v10, Ljava/net/Authenticator$RequestorType;->PROXY:Ljava/net/Authenticator$RequestorType;

    .line 68
    invoke-static/range {v3 .. v10}, Ljava/net/Authenticator;->requestPasswordAuthentication(Ljava/lang/String;Ljava/net/InetAddress;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/net/URL;Ljava/net/Authenticator$RequestorType;)Ljava/net/PasswordAuthentication;

    move-result-object v11

    .line 72
    .local v11, "auth":Ljava/net/PasswordAuthentication;
    if-eqz v11, :cond_0

    .line 74
    invoke-virtual {v11}, Ljava/net/PasswordAuthentication;->getUserName()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/String;

    invoke-virtual {v11}, Ljava/net/PasswordAuthentication;->getPassword()[C

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/String;-><init>([C)V

    invoke-static {v3, v4}, Lcom/squareup/okhttp/Credentials;->basic(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 75
    .local v14, "credential":Ljava/lang/String;
    invoke-virtual/range {v17 .. v17}, Lcom/squareup/okhttp/Request;->newBuilder()Lcom/squareup/okhttp/Request$Builder;

    move-result-object v3

    const-string v4, "Proxy-Authorization"

    .line 76
    invoke-virtual {v3, v4, v14}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v3

    .line 77
    invoke-virtual {v3}, Lcom/squareup/okhttp/Request$Builder;->build()Lcom/squareup/okhttp/Request;

    move-result-object v3

    .line 79
    .end local v11    # "auth":Ljava/net/PasswordAuthentication;
    .end local v12    # "challenge":Lcom/squareup/okhttp/Challenge;
    .end local v14    # "credential":Ljava/lang/String;
    .end local v16    # "proxyAddress":Ljava/net/InetSocketAddress;
    :goto_1
    return-object v3

    :cond_2
    const/4 v3, 0x0

    goto :goto_1
.end method
