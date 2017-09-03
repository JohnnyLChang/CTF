.class final Lcom/squareup/okhttp/OkHttpClient$1;
.super Lcom/squareup/okhttp/internal/Internal;
.source "OkHttpClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/OkHttpClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 61
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/Internal;-><init>()V

    return-void
.end method


# virtual methods
.method public addLenient(Lcom/squareup/okhttp/Headers$Builder;Ljava/lang/String;)V
    .locals 0
    .param p1, "builder"    # Lcom/squareup/okhttp/Headers$Builder;
    .param p2, "line"    # Ljava/lang/String;

    .prologue
    .line 63
    invoke-virtual {p1, p2}, Lcom/squareup/okhttp/Headers$Builder;->addLenient(Ljava/lang/String;)Lcom/squareup/okhttp/Headers$Builder;

    .line 64
    return-void
.end method

.method public addLenient(Lcom/squareup/okhttp/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "builder"    # Lcom/squareup/okhttp/Headers$Builder;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "value"    # Ljava/lang/String;

    .prologue
    .line 67
    invoke-virtual {p1, p2, p3}, Lcom/squareup/okhttp/Headers$Builder;->addLenient(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Headers$Builder;

    .line 68
    return-void
.end method

.method public apply(Lcom/squareup/okhttp/ConnectionSpec;Ljavax/net/ssl/SSLSocket;Z)V
    .locals 0
    .param p1, "tlsConfiguration"    # Lcom/squareup/okhttp/ConnectionSpec;
    .param p2, "sslSocket"    # Ljavax/net/ssl/SSLSocket;
    .param p3, "isFallback"    # Z

    .prologue
    .line 107
    invoke-virtual {p1, p2, p3}, Lcom/squareup/okhttp/ConnectionSpec;->apply(Ljavax/net/ssl/SSLSocket;Z)V

    .line 108
    return-void
.end method

.method public callEngineGetStreamAllocation(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/internal/http/StreamAllocation;
    .locals 1
    .param p1, "call"    # Lcom/squareup/okhttp/Call;

    .prologue
    .line 102
    iget-object v0, p1, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    iget-object v0, v0, Lcom/squareup/okhttp/internal/http/HttpEngine;->streamAllocation:Lcom/squareup/okhttp/internal/http/StreamAllocation;

    return-object v0
.end method

.method public callEnqueue(Lcom/squareup/okhttp/Call;Lcom/squareup/okhttp/Callback;Z)V
    .locals 0
    .param p1, "call"    # Lcom/squareup/okhttp/Call;
    .param p2, "responseCallback"    # Lcom/squareup/okhttp/Callback;
    .param p3, "forWebSocket"    # Z

    .prologue
    .line 98
    invoke-virtual {p1, p2, p3}, Lcom/squareup/okhttp/Call;->enqueue(Lcom/squareup/okhttp/Callback;Z)V

    .line 99
    return-void
.end method

.method public connectionBecameIdle(Lcom/squareup/okhttp/ConnectionPool;Lcom/squareup/okhttp/internal/io/RealConnection;)Z
    .locals 1
    .param p1, "pool"    # Lcom/squareup/okhttp/ConnectionPool;
    .param p2, "connection"    # Lcom/squareup/okhttp/internal/io/RealConnection;

    .prologue
    .line 80
    invoke-virtual {p1, p2}, Lcom/squareup/okhttp/ConnectionPool;->connectionBecameIdle(Lcom/squareup/okhttp/internal/io/RealConnection;)Z

    move-result v0

    return v0
.end method

.method public get(Lcom/squareup/okhttp/ConnectionPool;Lcom/squareup/okhttp/Address;Lcom/squareup/okhttp/internal/http/StreamAllocation;)Lcom/squareup/okhttp/internal/io/RealConnection;
    .locals 1
    .param p1, "pool"    # Lcom/squareup/okhttp/ConnectionPool;
    .param p2, "address"    # Lcom/squareup/okhttp/Address;
    .param p3, "streamAllocation"    # Lcom/squareup/okhttp/internal/http/StreamAllocation;

    .prologue
    .line 85
    invoke-virtual {p1, p2, p3}, Lcom/squareup/okhttp/ConnectionPool;->get(Lcom/squareup/okhttp/Address;Lcom/squareup/okhttp/internal/http/StreamAllocation;)Lcom/squareup/okhttp/internal/io/RealConnection;

    move-result-object v0

    return-object v0
.end method

.method public getHttpUrlChecked(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;
    .locals 1
    .param p1, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/MalformedURLException;,
            Ljava/net/UnknownHostException;
        }
    .end annotation

    .prologue
    .line 112
    invoke-static {p1}, Lcom/squareup/okhttp/HttpUrl;->getChecked(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;

    move-result-object v0

    return-object v0
.end method

.method public internalCache(Lcom/squareup/okhttp/OkHttpClient;)Lcom/squareup/okhttp/internal/InternalCache;
    .locals 1
    .param p1, "client"    # Lcom/squareup/okhttp/OkHttpClient;

    .prologue
    .line 75
    invoke-virtual {p1}, Lcom/squareup/okhttp/OkHttpClient;->internalCache()Lcom/squareup/okhttp/internal/InternalCache;

    move-result-object v0

    return-object v0
.end method

.method public put(Lcom/squareup/okhttp/ConnectionPool;Lcom/squareup/okhttp/internal/io/RealConnection;)V
    .locals 0
    .param p1, "pool"    # Lcom/squareup/okhttp/ConnectionPool;
    .param p2, "connection"    # Lcom/squareup/okhttp/internal/io/RealConnection;

    .prologue
    .line 89
    invoke-virtual {p1, p2}, Lcom/squareup/okhttp/ConnectionPool;->put(Lcom/squareup/okhttp/internal/io/RealConnection;)V

    .line 90
    return-void
.end method

.method public routeDatabase(Lcom/squareup/okhttp/ConnectionPool;)Lcom/squareup/okhttp/internal/RouteDatabase;
    .locals 1
    .param p1, "connectionPool"    # Lcom/squareup/okhttp/ConnectionPool;

    .prologue
    .line 93
    iget-object v0, p1, Lcom/squareup/okhttp/ConnectionPool;->routeDatabase:Lcom/squareup/okhttp/internal/RouteDatabase;

    return-object v0
.end method

.method public setCache(Lcom/squareup/okhttp/OkHttpClient;Lcom/squareup/okhttp/internal/InternalCache;)V
    .locals 0
    .param p1, "client"    # Lcom/squareup/okhttp/OkHttpClient;
    .param p2, "internalCache"    # Lcom/squareup/okhttp/internal/InternalCache;

    .prologue
    .line 71
    invoke-virtual {p1, p2}, Lcom/squareup/okhttp/OkHttpClient;->setInternalCache(Lcom/squareup/okhttp/internal/InternalCache;)V

    .line 72
    return-void
.end method
