.class public final Lcom/squareup/okhttp/internal/http/Http2xStream;
.super Ljava/lang/Object;
.source "Http2xStream.java"

# interfaces
.implements Lcom/squareup/okhttp/internal/http/HttpStream;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/squareup/okhttp/internal/http/Http2xStream$StreamFinishingSource;
    }
.end annotation


# static fields
.field private static final CONNECTION:Lokio/ByteString;

.field private static final ENCODING:Lokio/ByteString;

.field private static final HOST:Lokio/ByteString;

.field private static final HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lokio/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static final HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lokio/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static final KEEP_ALIVE:Lokio/ByteString;

.field private static final PROXY_CONNECTION:Lokio/ByteString;

.field private static final SPDY_3_SKIPPED_REQUEST_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lokio/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static final SPDY_3_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lokio/ByteString;",
            ">;"
        }
    .end annotation
.end field

.field private static final TE:Lokio/ByteString;

.field private static final TRANSFER_ENCODING:Lokio/ByteString;

.field private static final UPGRADE:Lokio/ByteString;


# instance fields
.field private final framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

.field private httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

.field private stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

.field private final streamAllocation:Lcom/squareup/okhttp/internal/http/StreamAllocation;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 53
    const-string v0, "connection"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->CONNECTION:Lokio/ByteString;

    .line 54
    const-string v0, "host"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->HOST:Lokio/ByteString;

    .line 55
    const-string v0, "keep-alive"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->KEEP_ALIVE:Lokio/ByteString;

    .line 56
    const-string v0, "proxy-connection"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->PROXY_CONNECTION:Lokio/ByteString;

    .line 57
    const-string v0, "transfer-encoding"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->TRANSFER_ENCODING:Lokio/ByteString;

    .line 58
    const-string v0, "te"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->TE:Lokio/ByteString;

    .line 59
    const-string v0, "encoding"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->ENCODING:Lokio/ByteString;

    .line 60
    const-string v0, "upgrade"

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->UPGRADE:Lokio/ByteString;

    .line 63
    const/16 v0, 0xb

    new-array v0, v0, [Lokio/ByteString;

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v3

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->HOST:Lokio/ByteString;

    aput-object v1, v0, v4

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->KEEP_ALIVE:Lokio/ByteString;

    aput-object v1, v0, v5

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->PROXY_CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v6

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->TRANSFER_ENCODING:Lokio/ByteString;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_METHOD:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_PATH:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_SCHEME:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_AUTHORITY:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_HOST:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0xa

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->VERSION:Lokio/ByteString;

    aput-object v2, v0, v1

    invoke-static {v0}, Lcom/squareup/okhttp/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->SPDY_3_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    .line 75
    const/4 v0, 0x5

    new-array v0, v0, [Lokio/ByteString;

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v3

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->HOST:Lokio/ByteString;

    aput-object v1, v0, v4

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->KEEP_ALIVE:Lokio/ByteString;

    aput-object v1, v0, v5

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->PROXY_CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v6

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->TRANSFER_ENCODING:Lokio/ByteString;

    aput-object v1, v0, v7

    invoke-static {v0}, Lcom/squareup/okhttp/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->SPDY_3_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    .line 83
    const/16 v0, 0xe

    new-array v0, v0, [Lokio/ByteString;

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v3

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->HOST:Lokio/ByteString;

    aput-object v1, v0, v4

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->KEEP_ALIVE:Lokio/ByteString;

    aput-object v1, v0, v5

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->PROXY_CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v6

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->TE:Lokio/ByteString;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->TRANSFER_ENCODING:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->ENCODING:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->UPGRADE:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0x8

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_METHOD:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0x9

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_PATH:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0xa

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_SCHEME:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0xb

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_AUTHORITY:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0xc

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_HOST:Lokio/ByteString;

    aput-object v2, v0, v1

    const/16 v1, 0xd

    sget-object v2, Lcom/squareup/okhttp/internal/framed/Header;->VERSION:Lokio/ByteString;

    aput-object v2, v0, v1

    invoke-static {v0}, Lcom/squareup/okhttp/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    .line 98
    const/16 v0, 0x8

    new-array v0, v0, [Lokio/ByteString;

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v3

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->HOST:Lokio/ByteString;

    aput-object v1, v0, v4

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->KEEP_ALIVE:Lokio/ByteString;

    aput-object v1, v0, v5

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->PROXY_CONNECTION:Lokio/ByteString;

    aput-object v1, v0, v6

    sget-object v1, Lcom/squareup/okhttp/internal/http/Http2xStream;->TE:Lokio/ByteString;

    aput-object v1, v0, v7

    const/4 v1, 0x5

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->TRANSFER_ENCODING:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x6

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->ENCODING:Lokio/ByteString;

    aput-object v2, v0, v1

    const/4 v1, 0x7

    sget-object v2, Lcom/squareup/okhttp/internal/http/Http2xStream;->UPGRADE:Lokio/ByteString;

    aput-object v2, v0, v1

    invoke-static {v0}, Lcom/squareup/okhttp/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/squareup/okhttp/internal/http/Http2xStream;->HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    return-void
.end method

.method public constructor <init>(Lcom/squareup/okhttp/internal/http/StreamAllocation;Lcom/squareup/okhttp/internal/framed/FramedConnection;)V
    .locals 0
    .param p1, "streamAllocation"    # Lcom/squareup/okhttp/internal/http/StreamAllocation;
    .param p2, "framedConnection"    # Lcom/squareup/okhttp/internal/framed/FramedConnection;

    .prologue
    .line 113
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 114
    iput-object p1, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->streamAllocation:Lcom/squareup/okhttp/internal/http/StreamAllocation;

    .line 115
    iput-object p2, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    .line 116
    return-void
.end method

.method static synthetic access$000(Lcom/squareup/okhttp/internal/http/Http2xStream;)Lcom/squareup/okhttp/internal/http/StreamAllocation;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/http/Http2xStream;

    .prologue
    .line 52
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->streamAllocation:Lcom/squareup/okhttp/internal/http/StreamAllocation;

    return-object v0
.end method

.method public static http2HeadersList(Lcom/squareup/okhttp/Request;)Ljava/util/List;
    .locals 8
    .param p0, "request"    # Lcom/squareup/okhttp/Request;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/squareup/okhttp/Request;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/internal/framed/Header;",
            ">;"
        }
    .end annotation

    .prologue
    .line 200
    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object v0

    .line 201
    .local v0, "headers":Lcom/squareup/okhttp/Headers;
    new-instance v3, Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/squareup/okhttp/Headers;->size()I

    move-result v5

    add-int/lit8 v5, v5, 0x4

    invoke-direct {v3, v5}, Ljava/util/ArrayList;-><init>(I)V

    .line 202
    .local v3, "result":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    new-instance v5, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v6, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_METHOD:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->method()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v6, v7}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 203
    new-instance v5, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v6, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_PATH:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v7

    invoke-static {v7}, Lcom/squareup/okhttp/internal/http/RequestLine;->requestPath(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v6, v7}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 204
    new-instance v5, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v6, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_AUTHORITY:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v7

    invoke-static {v7}, Lcom/squareup/okhttp/internal/Util;->hostHeader(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v6, v7}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 205
    new-instance v5, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v6, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_SCHEME:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v7

    invoke-virtual {v7}, Lcom/squareup/okhttp/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v6, v7}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 207
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {v0}, Lcom/squareup/okhttp/Headers;->size()I

    move-result v4

    .local v4, "size":I
    :goto_0
    if-ge v1, v4, :cond_1

    .line 209
    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/Headers;->name(I)Ljava/lang/String;

    move-result-object v5

    sget-object v6, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v5, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v2

    .line 210
    .local v2, "name":Lokio/ByteString;
    sget-object v5, Lcom/squareup/okhttp/internal/http/Http2xStream;->HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    invoke-interface {v5, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 211
    new-instance v5, Lcom/squareup/okhttp/internal/framed/Header;

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/Headers;->value(I)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v2, v6}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 207
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 214
    .end local v2    # "name":Lokio/ByteString;
    :cond_1
    return-object v3
.end method

.method private static joinOnNull(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "first"    # Ljava/lang/String;
    .param p1, "second"    # Ljava/lang/String;

    .prologue
    .line 196
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, p0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static readHttp2HeadersList(Ljava/util/List;)Lcom/squareup/okhttp/Response$Builder;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/internal/framed/Header;",
            ">;)",
            "Lcom/squareup/okhttp/Response$Builder;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 254
    .local p0, "headerBlock":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    const/4 v4, 0x0

    .line 256
    .local v4, "status":Ljava/lang/String;
    new-instance v0, Lcom/squareup/okhttp/Headers$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/Headers$Builder;-><init>()V

    .line 257
    .local v0, "headersBuilder":Lcom/squareup/okhttp/Headers$Builder;
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    .local v3, "size":I
    :goto_0
    if-ge v1, v3, :cond_2

    .line 258
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v2, v7, Lcom/squareup/okhttp/internal/framed/Header;->name:Lokio/ByteString;

    .line 260
    .local v2, "name":Lokio/ByteString;
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v7, v7, Lcom/squareup/okhttp/internal/framed/Header;->value:Lokio/ByteString;

    invoke-virtual {v7}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v6

    .line 261
    .local v6, "value":Ljava/lang/String;
    sget-object v7, Lcom/squareup/okhttp/internal/framed/Header;->RESPONSE_STATUS:Lokio/ByteString;

    invoke-virtual {v2, v7}, Lokio/ByteString;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 262
    move-object v4, v6

    .line 257
    :cond_0
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 263
    :cond_1
    sget-object v7, Lcom/squareup/okhttp/internal/http/Http2xStream;->HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    invoke-interface {v7, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 264
    invoke-virtual {v2}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7, v6}, Lcom/squareup/okhttp/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Headers$Builder;

    goto :goto_1

    .line 267
    .end local v2    # "name":Lokio/ByteString;
    .end local v6    # "value":Ljava/lang/String;
    :cond_2
    if-nez v4, :cond_3

    new-instance v7, Ljava/net/ProtocolException;

    const-string v8, "Expected \':status\' header not present"

    invoke-direct {v7, v8}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 269
    :cond_3
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "HTTP/1.1 "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/squareup/okhttp/internal/http/StatusLine;->parse(Ljava/lang/String;)Lcom/squareup/okhttp/internal/http/StatusLine;

    move-result-object v5

    .line 270
    .local v5, "statusLine":Lcom/squareup/okhttp/internal/http/StatusLine;
    new-instance v7, Lcom/squareup/okhttp/Response$Builder;

    invoke-direct {v7}, Lcom/squareup/okhttp/Response$Builder;-><init>()V

    sget-object v8, Lcom/squareup/okhttp/Protocol;->HTTP_2:Lcom/squareup/okhttp/Protocol;

    .line 271
    invoke-virtual {v7, v8}, Lcom/squareup/okhttp/Response$Builder;->protocol(Lcom/squareup/okhttp/Protocol;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v7

    iget v8, v5, Lcom/squareup/okhttp/internal/http/StatusLine;->code:I

    .line 272
    invoke-virtual {v7, v8}, Lcom/squareup/okhttp/Response$Builder;->code(I)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v7

    iget-object v8, v5, Lcom/squareup/okhttp/internal/http/StatusLine;->message:Ljava/lang/String;

    .line 273
    invoke-virtual {v7, v8}, Lcom/squareup/okhttp/Response$Builder;->message(Ljava/lang/String;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v7

    .line 274
    invoke-virtual {v0}, Lcom/squareup/okhttp/Headers$Builder;->build()Lcom/squareup/okhttp/Headers;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/squareup/okhttp/Response$Builder;->headers(Lcom/squareup/okhttp/Headers;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v7

    return-object v7
.end method

.method public static readSpdy3HeadersList(Ljava/util/List;)Lcom/squareup/okhttp/Response$Builder;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/internal/framed/Header;",
            ">;)",
            "Lcom/squareup/okhttp/Response$Builder;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 219
    .local p0, "headerBlock":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    const/4 v6, 0x0

    .line 220
    .local v6, "status":Ljava/lang/String;
    const-string v10, "HTTP/1.1"

    .line 221
    .local v10, "version":Ljava/lang/String;
    new-instance v1, Lcom/squareup/okhttp/Headers$Builder;

    invoke-direct {v1}, Lcom/squareup/okhttp/Headers$Builder;-><init>()V

    .line 222
    .local v1, "headersBuilder":Lcom/squareup/okhttp/Headers$Builder;
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v4

    .local v4, "size":I
    :goto_0
    if-ge v2, v4, :cond_5

    .line 223
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v3, v11, Lcom/squareup/okhttp/internal/framed/Header;->name:Lokio/ByteString;

    .line 225
    .local v3, "name":Lokio/ByteString;
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v11, v11, Lcom/squareup/okhttp/internal/framed/Header;->value:Lokio/ByteString;

    invoke-virtual {v11}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v9

    .line 226
    .local v9, "values":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "start":I
    :goto_1
    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v11

    if-ge v5, v11, :cond_4

    .line 227
    const/4 v11, 0x0

    invoke-virtual {v9, v11, v5}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 228
    .local v0, "end":I
    const/4 v11, -0x1

    if-ne v0, v11, :cond_0

    .line 229
    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v0

    .line 231
    :cond_0
    invoke-virtual {v9, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 232
    .local v8, "value":Ljava/lang/String;
    sget-object v11, Lcom/squareup/okhttp/internal/framed/Header;->RESPONSE_STATUS:Lokio/ByteString;

    invoke-virtual {v3, v11}, Lokio/ByteString;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_2

    .line 233
    move-object v6, v8

    .line 239
    :cond_1
    :goto_2
    add-int/lit8 v5, v0, 0x1

    .line 240
    goto :goto_1

    .line 234
    :cond_2
    sget-object v11, Lcom/squareup/okhttp/internal/framed/Header;->VERSION:Lokio/ByteString;

    invoke-virtual {v3, v11}, Lokio/ByteString;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_3

    .line 235
    move-object v10, v8

    goto :goto_2

    .line 236
    :cond_3
    sget-object v11, Lcom/squareup/okhttp/internal/http/Http2xStream;->SPDY_3_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    invoke-interface {v11, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_1

    .line 237
    invoke-virtual {v3}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v1, v11, v8}, Lcom/squareup/okhttp/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Headers$Builder;

    goto :goto_2

    .line 222
    .end local v0    # "end":I
    .end local v8    # "value":Ljava/lang/String;
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 242
    .end local v3    # "name":Lokio/ByteString;
    .end local v5    # "start":I
    .end local v9    # "values":Ljava/lang/String;
    :cond_5
    if-nez v6, :cond_6

    new-instance v11, Ljava/net/ProtocolException;

    const-string v12, "Expected \':status\' header not present"

    invoke-direct {v11, v12}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v11

    .line 244
    :cond_6
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Lcom/squareup/okhttp/internal/http/StatusLine;->parse(Ljava/lang/String;)Lcom/squareup/okhttp/internal/http/StatusLine;

    move-result-object v7

    .line 245
    .local v7, "statusLine":Lcom/squareup/okhttp/internal/http/StatusLine;
    new-instance v11, Lcom/squareup/okhttp/Response$Builder;

    invoke-direct {v11}, Lcom/squareup/okhttp/Response$Builder;-><init>()V

    sget-object v12, Lcom/squareup/okhttp/Protocol;->SPDY_3:Lcom/squareup/okhttp/Protocol;

    .line 246
    invoke-virtual {v11, v12}, Lcom/squareup/okhttp/Response$Builder;->protocol(Lcom/squareup/okhttp/Protocol;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v11

    iget v12, v7, Lcom/squareup/okhttp/internal/http/StatusLine;->code:I

    .line 247
    invoke-virtual {v11, v12}, Lcom/squareup/okhttp/Response$Builder;->code(I)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v11

    iget-object v12, v7, Lcom/squareup/okhttp/internal/http/StatusLine;->message:Ljava/lang/String;

    .line 248
    invoke-virtual {v11, v12}, Lcom/squareup/okhttp/Response$Builder;->message(Ljava/lang/String;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v11

    .line 249
    invoke-virtual {v1}, Lcom/squareup/okhttp/Headers$Builder;->build()Lcom/squareup/okhttp/Headers;

    move-result-object v12

    invoke-virtual {v11, v12}, Lcom/squareup/okhttp/Response$Builder;->headers(Lcom/squareup/okhttp/Headers;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v11

    return-object v11
.end method

.method public static spdy3HeadersList(Lcom/squareup/okhttp/Request;)Ljava/util/List;
    .locals 12
    .param p0, "request"    # Lcom/squareup/okhttp/Request;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/squareup/okhttp/Request;",
            ")",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/internal/framed/Header;",
            ">;"
        }
    .end annotation

    .prologue
    .line 160
    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object v1

    .line 161
    .local v1, "headers":Lcom/squareup/okhttp/Headers;
    new-instance v6, Ljava/util/ArrayList;

    invoke-virtual {v1}, Lcom/squareup/okhttp/Headers;->size()I

    move-result v9

    add-int/lit8 v9, v9, 0x5

    invoke-direct {v6, v9}, Ljava/util/ArrayList;-><init>(I)V

    .line 162
    .local v6, "result":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v10, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_METHOD:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->method()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 163
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v10, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_PATH:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v11

    invoke-static {v11}, Lcom/squareup/okhttp/internal/http/RequestLine;->requestPath(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 164
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v10, Lcom/squareup/okhttp/internal/framed/Header;->VERSION:Lokio/ByteString;

    const-string v11, "HTTP/1.1"

    invoke-direct {v9, v10, v11}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 165
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v10, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_HOST:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v11

    invoke-static {v11}, Lcom/squareup/okhttp/internal/Util;->hostHeader(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 166
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    sget-object v10, Lcom/squareup/okhttp/internal/framed/Header;->TARGET_SCHEME:Lokio/ByteString;

    invoke-virtual {p0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v11

    invoke-virtual {v11}, Lcom/squareup/okhttp/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 168
    new-instance v5, Ljava/util/LinkedHashSet;

    invoke-direct {v5}, Ljava/util/LinkedHashSet;-><init>()V

    .line 169
    .local v5, "names":Ljava/util/Set;, "Ljava/util/Set<Lokio/ByteString;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-virtual {v1}, Lcom/squareup/okhttp/Headers;->size()I

    move-result v7

    .local v7, "size":I
    :goto_0
    if-ge v2, v7, :cond_4

    .line 171
    invoke-virtual {v1, v2}, Lcom/squareup/okhttp/Headers;->name(I)Ljava/lang/String;

    move-result-object v9

    sget-object v10, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v4

    .line 174
    .local v4, "name":Lokio/ByteString;
    sget-object v9, Lcom/squareup/okhttp/internal/http/Http2xStream;->SPDY_3_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    invoke-interface {v9, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 169
    :cond_0
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 177
    :cond_1
    invoke-virtual {v1, v2}, Lcom/squareup/okhttp/Headers;->value(I)Ljava/lang/String;

    move-result-object v8

    .line 178
    .local v8, "value":Ljava/lang/String;
    invoke-interface {v5, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 179
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    invoke-direct {v9, v4, v8}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 184
    :cond_2
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_2
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v9

    if-ge v3, v9, :cond_0

    .line 185
    invoke-interface {v6, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v9, v9, Lcom/squareup/okhttp/internal/framed/Header;->name:Lokio/ByteString;

    invoke-virtual {v9, v4}, Lokio/ByteString;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 186
    invoke-interface {v6, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/squareup/okhttp/internal/framed/Header;

    iget-object v9, v9, Lcom/squareup/okhttp/internal/framed/Header;->value:Lokio/ByteString;

    invoke-virtual {v9}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v8}, Lcom/squareup/okhttp/internal/http/Http2xStream;->joinOnNull(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 187
    .local v0, "concatenated":Ljava/lang/String;
    new-instance v9, Lcom/squareup/okhttp/internal/framed/Header;

    invoke-direct {v9, v4, v0}, Lcom/squareup/okhttp/internal/framed/Header;-><init>(Lokio/ByteString;Ljava/lang/String;)V

    invoke-interface {v6, v3, v9}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 184
    .end local v0    # "concatenated":Ljava/lang/String;
    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 192
    .end local v3    # "j":I
    .end local v4    # "name":Lokio/ByteString;
    .end local v8    # "value":Ljava/lang/String;
    :cond_4
    return-object v6
.end method


# virtual methods
.method public cancel()V
    .locals 2

    .prologue
    .line 283
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    sget-object v1, Lcom/squareup/okhttp/internal/framed/ErrorCode;->CANCEL:Lcom/squareup/okhttp/internal/framed/ErrorCode;

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->closeLater(Lcom/squareup/okhttp/internal/framed/ErrorCode;)V

    .line 284
    :cond_0
    return-void
.end method

.method public createRequestBody(Lcom/squareup/okhttp/Request;J)Lokio/Sink;
    .locals 1
    .param p1, "request"    # Lcom/squareup/okhttp/Request;
    .param p2, "contentLength"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 123
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getSink()Lokio/Sink;

    move-result-object v0

    return-object v0
.end method

.method public finishRequest()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 145
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getSink()Lokio/Sink;

    move-result-object v0

    invoke-interface {v0}, Lokio/Sink;->close()V

    .line 146
    return-void
.end method

.method public openResponseBody(Lcom/squareup/okhttp/Response;)Lcom/squareup/okhttp/ResponseBody;
    .locals 4
    .param p1, "response"    # Lcom/squareup/okhttp/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 278
    new-instance v0, Lcom/squareup/okhttp/internal/http/Http2xStream$StreamFinishingSource;

    iget-object v1, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getSource()Lokio/Source;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/squareup/okhttp/internal/http/Http2xStream$StreamFinishingSource;-><init>(Lcom/squareup/okhttp/internal/http/Http2xStream;Lokio/Source;)V

    .line 279
    .local v0, "source":Lokio/Source;
    new-instance v1, Lcom/squareup/okhttp/internal/http/RealResponseBody;

    invoke-virtual {p1}, Lcom/squareup/okhttp/Response;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object v2

    invoke-static {v0}, Lokio/Okio;->buffer(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Lcom/squareup/okhttp/internal/http/RealResponseBody;-><init>(Lcom/squareup/okhttp/Headers;Lokio/BufferedSource;)V

    return-object v1
.end method

.method public readResponseHeaders()Lcom/squareup/okhttp/Response$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 149
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->getProtocol()Lcom/squareup/okhttp/Protocol;

    move-result-object v0

    sget-object v1, Lcom/squareup/okhttp/Protocol;->HTTP_2:Lcom/squareup/okhttp/Protocol;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    .line 150
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getResponseHeaders()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/okhttp/internal/http/Http2xStream;->readHttp2HeadersList(Ljava/util/List;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v0

    .line 151
    :goto_0
    return-object v0

    .line 150
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    .line 151
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getResponseHeaders()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/okhttp/internal/http/Http2xStream;->readSpdy3HeadersList(Ljava/util/List;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v0

    goto :goto_0
.end method

.method public setHttpEngine(Lcom/squareup/okhttp/internal/http/HttpEngine;)V
    .locals 0
    .param p1, "httpEngine"    # Lcom/squareup/okhttp/internal/http/HttpEngine;

    .prologue
    .line 119
    iput-object p1, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    .line 120
    return-void
.end method

.method public writeRequestBody(Lcom/squareup/okhttp/internal/http/RetryableSink;)V
    .locals 1
    .param p1, "requestBody"    # Lcom/squareup/okhttp/internal/http/RetryableSink;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 141
    iget-object v0, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->getSink()Lokio/Sink;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/squareup/okhttp/internal/http/RetryableSink;->writeToSocket(Lokio/Sink;)V

    .line 142
    return-void
.end method

.method public writeRequestHeaders(Lcom/squareup/okhttp/Request;)V
    .locals 7
    .param p1, "request"    # Lcom/squareup/okhttp/Request;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 127
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    if-eqz v3, :cond_0

    .line 138
    :goto_0
    return-void

    .line 129
    :cond_0
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v3}, Lcom/squareup/okhttp/internal/http/HttpEngine;->writingRequestHeaders()V

    .line 130
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v3, p1}, Lcom/squareup/okhttp/internal/http/HttpEngine;->permitsRequestBody(Lcom/squareup/okhttp/Request;)Z

    move-result v1

    .line 131
    .local v1, "permitsRequestBody":Z
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-virtual {v3}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->getProtocol()Lcom/squareup/okhttp/Protocol;

    move-result-object v3

    sget-object v4, Lcom/squareup/okhttp/Protocol;->HTTP_2:Lcom/squareup/okhttp/Protocol;

    if-ne v3, v4, :cond_1

    .line 132
    invoke-static {p1}, Lcom/squareup/okhttp/internal/http/Http2xStream;->http2HeadersList(Lcom/squareup/okhttp/Request;)Ljava/util/List;

    move-result-object v2

    .line 134
    .local v2, "requestHeaders":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    :goto_1
    const/4 v0, 0x1

    .line 135
    .local v0, "hasResponseBody":Z
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-virtual {v3, v2, v1, v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->newStream(Ljava/util/List;ZZ)Lcom/squareup/okhttp/internal/framed/FramedStream;

    move-result-object v3

    iput-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    .line 136
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v3}, Lcom/squareup/okhttp/internal/framed/FramedStream;->readTimeout()Lokio/Timeout;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    iget-object v4, v4, Lcom/squareup/okhttp/internal/http/HttpEngine;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v4}, Lcom/squareup/okhttp/OkHttpClient;->getReadTimeout()I

    move-result v4

    int-to-long v4, v4

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v4, v5, v6}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    .line 137
    iget-object v3, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->stream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v3}, Lcom/squareup/okhttp/internal/framed/FramedStream;->writeTimeout()Lokio/Timeout;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/internal/http/Http2xStream;->httpEngine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    iget-object v4, v4, Lcom/squareup/okhttp/internal/http/HttpEngine;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v4}, Lcom/squareup/okhttp/OkHttpClient;->getWriteTimeout()I

    move-result v4

    int-to-long v4, v4

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v4, v5, v6}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    goto :goto_0

    .line 133
    .end local v0    # "hasResponseBody":Z
    .end local v2    # "requestHeaders":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/framed/Header;>;"
    :cond_1
    invoke-static {p1}, Lcom/squareup/okhttp/internal/http/Http2xStream;->spdy3HeadersList(Lcom/squareup/okhttp/Request;)Ljava/util/List;

    move-result-object v2

    goto :goto_1
.end method
