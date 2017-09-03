.class public final Lcom/squareup/okhttp/internal/io/RealConnection;
.super Ljava/lang/Object;
.source "RealConnection.java"

# interfaces
.implements Lcom/squareup/okhttp/Connection;


# static fields
.field private static lastSslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

.field private static lastTrustRootIndex:Lcom/squareup/okhttp/internal/tls/TrustRootIndex;


# instance fields
.field public final allocations:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/ref/Reference",
            "<",
            "Lcom/squareup/okhttp/internal/http/StreamAllocation;",
            ">;>;"
        }
    .end annotation
.end field

.field public volatile framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

.field private handshake:Lcom/squareup/okhttp/Handshake;

.field public idleAtNanos:J

.field public noNewStreams:Z

.field private protocol:Lcom/squareup/okhttp/Protocol;

.field private rawSocket:Ljava/net/Socket;

.field private final route:Lcom/squareup/okhttp/Route;

.field public sink:Lokio/BufferedSink;

.field public socket:Ljava/net/Socket;

.field public source:Lokio/BufferedSource;

.field public streamCount:I


# direct methods
.method public constructor <init>(Lcom/squareup/okhttp/Route;)V
    .locals 2
    .param p1, "route"    # Lcom/squareup/okhttp/Route;

    .prologue
    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 84
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->allocations:Ljava/util/List;

    .line 86
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->idleAtNanos:J

    .line 89
    iput-object p1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 90
    return-void
.end method

.method private connectSocket(IIILcom/squareup/okhttp/internal/ConnectionSpecSelector;)V
    .locals 7
    .param p1, "connectTimeout"    # I
    .param p2, "readTimeout"    # I
    .param p3, "writeTimeout"    # I
    .param p4, "connectionSpecSelector"    # Lcom/squareup/okhttp/internal/ConnectionSpecSelector;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 139
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    invoke-virtual {v2, p2}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 141
    :try_start_0
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v2

    iget-object v3, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v4}, Lcom/squareup/okhttp/Route;->getSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v4

    invoke-virtual {v2, v3, v4, p1}, Lcom/squareup/okhttp/internal/Platform;->connectSocket(Ljava/net/Socket;Ljava/net/InetSocketAddress;I)V
    :try_end_0
    .catch Ljava/net/ConnectException; {:try_start_0 .. :try_end_0} :catch_0

    .line 145
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    invoke-static {v2}, Lokio/Okio;->source(Ljava/net/Socket;)Lokio/Source;

    move-result-object v2

    invoke-static {v2}, Lokio/Okio;->buffer(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v2

    iput-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    .line 146
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    invoke-static {v2}, Lokio/Okio;->sink(Ljava/net/Socket;)Lokio/Sink;

    move-result-object v2

    invoke-static {v2}, Lokio/Okio;->buffer(Lokio/Sink;)Lokio/BufferedSink;

    move-result-object v2

    iput-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    .line 148
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v2}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v2

    invoke-virtual {v2}, Lcom/squareup/okhttp/Address;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 149
    invoke-direct {p0, p2, p3, p4}, Lcom/squareup/okhttp/internal/io/RealConnection;->connectTls(IILcom/squareup/okhttp/internal/ConnectionSpecSelector;)V

    .line 155
    :goto_0
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    sget-object v3, Lcom/squareup/okhttp/Protocol;->SPDY_3:Lcom/squareup/okhttp/Protocol;

    if-eq v2, v3, :cond_0

    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    sget-object v3, Lcom/squareup/okhttp/Protocol;->HTTP_2:Lcom/squareup/okhttp/Protocol;

    if-ne v2, v3, :cond_1

    .line 156
    :cond_0
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 158
    new-instance v2, Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;-><init>(Z)V

    iget-object v3, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 159
    invoke-virtual {v4}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v4

    invoke-virtual {v4}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v4

    invoke-virtual {v4}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    iget-object v6, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;->socket(Ljava/net/Socket;Ljava/lang/String;Lokio/BufferedSource;Lokio/BufferedSink;)Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;

    move-result-object v2

    iget-object v3, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    .line 160
    invoke-virtual {v2, v3}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;->protocol(Lcom/squareup/okhttp/Protocol;)Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;

    move-result-object v2

    .line 161
    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Builder;->build()Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v1

    .line 162
    .local v1, "framedConnection":Lcom/squareup/okhttp/internal/framed/FramedConnection;
    invoke-virtual {v1}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->sendConnectionPreface()V

    .line 165
    iput-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    .line 167
    .end local v1    # "framedConnection":Lcom/squareup/okhttp/internal/framed/FramedConnection;
    :cond_1
    return-void

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Ljava/net/ConnectException;
    new-instance v2, Ljava/net/ConnectException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed to connect to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v4}, Lcom/squareup/okhttp/Route;->getSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/ConnectException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 151
    .end local v0    # "e":Ljava/net/ConnectException;
    :cond_2
    sget-object v2, Lcom/squareup/okhttp/Protocol;->HTTP_1_1:Lcom/squareup/okhttp/Protocol;

    iput-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    .line 152
    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    iput-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    goto :goto_0
.end method

.method private connectTls(IILcom/squareup/okhttp/internal/ConnectionSpecSelector;)V
    .locals 16
    .param p1, "readTimeout"    # I
    .param p2, "writeTimeout"    # I
    .param p3, "connectionSpecSelector"    # Lcom/squareup/okhttp/internal/ConnectionSpecSelector;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 171
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v12}, Lcom/squareup/okhttp/Route;->requiresTunnel()Z

    move-result v12

    if-eqz v12, :cond_0

    .line 172
    invoke-direct/range {p0 .. p2}, Lcom/squareup/okhttp/internal/io/RealConnection;->createTunnel(II)V

    .line 175
    :cond_0
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v12}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v1

    .line 176
    .local v1, "address":Lcom/squareup/okhttp/Address;
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v8

    .line 177
    .local v8, "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    const/4 v9, 0x0

    .line 178
    .local v9, "success":Z
    const/4 v7, 0x0

    .line 181
    .local v7, "sslSocket":Ljavax/net/ssl/SSLSocket;
    :try_start_0
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    .line 182
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriPort()I

    move-result v14

    const/4 v15, 0x1

    .line 181
    invoke-virtual {v8, v12, v13, v14, v15}, Ljavax/net/ssl/SSLSocketFactory;->createSocket(Ljava/net/Socket;Ljava/lang/String;IZ)Ljava/net/Socket;

    move-result-object v12

    move-object v0, v12

    check-cast v0, Ljavax/net/ssl/SSLSocket;

    move-object v7, v0

    .line 185
    move-object/from16 v0, p3

    invoke-virtual {v0, v7}, Lcom/squareup/okhttp/internal/ConnectionSpecSelector;->configureSecureSocket(Ljavax/net/ssl/SSLSocket;)Lcom/squareup/okhttp/ConnectionSpec;

    move-result-object v4

    .line 186
    .local v4, "connectionSpec":Lcom/squareup/okhttp/ConnectionSpec;
    invoke-virtual {v4}, Lcom/squareup/okhttp/ConnectionSpec;->supportsTlsExtensions()Z

    move-result v12

    if-eqz v12, :cond_1

    .line 187
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v12

    .line 188
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getProtocols()Ljava/util/List;

    move-result-object v14

    .line 187
    invoke-virtual {v12, v7, v13, v14}, Lcom/squareup/okhttp/internal/Platform;->configureTlsExtensions(Ljavax/net/ssl/SSLSocket;Ljava/lang/String;Ljava/util/List;)V

    .line 192
    :cond_1
    invoke-virtual {v7}, Ljavax/net/ssl/SSLSocket;->startHandshake()V

    .line 193
    invoke-virtual {v7}, Ljavax/net/ssl/SSLSocket;->getSession()Ljavax/net/ssl/SSLSession;

    move-result-object v12

    invoke-static {v12}, Lcom/squareup/okhttp/Handshake;->get(Ljavax/net/ssl/SSLSession;)Lcom/squareup/okhttp/Handshake;

    move-result-object v11

    .line 196
    .local v11, "unverifiedHandshake":Lcom/squareup/okhttp/Handshake;
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v12

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v7}, Ljavax/net/ssl/SSLSocket;->getSession()Ljavax/net/ssl/SSLSession;

    move-result-object v14

    invoke-interface {v12, v13, v14}, Ljavax/net/ssl/HostnameVerifier;->verify(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z

    move-result v12

    if-nez v12, :cond_4

    .line 197
    invoke-virtual {v11}, Lcom/squareup/okhttp/Handshake;->peerCertificates()Ljava/util/List;

    move-result-object v12

    const/4 v13, 0x0

    invoke-interface {v12, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/security/cert/X509Certificate;

    .line 198
    .local v2, "cert":Ljava/security/cert/X509Certificate;
    new-instance v12, Ljavax/net/ssl/SSLPeerUnverifiedException;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "Hostname "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " not verified:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n    certificate: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 199
    invoke-static {v2}, Lcom/squareup/okhttp/CertificatePinner;->pin(Ljava/security/cert/Certificate;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n    DN: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 200
    invoke-virtual {v2}, Ljava/security/cert/X509Certificate;->getSubjectDN()Ljava/security/Principal;

    move-result-object v14

    invoke-interface {v14}, Ljava/security/Principal;->getName()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n    subjectAltNames: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 201
    invoke-static {v2}, Lcom/squareup/okhttp/internal/tls/OkHostnameVerifier;->allSubjectAltNames(Ljava/security/cert/X509Certificate;)Ljava/util/List;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Ljavax/net/ssl/SSLPeerUnverifiedException;-><init>(Ljava/lang/String;)V

    throw v12
    :try_end_0
    .catch Ljava/lang/AssertionError; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 224
    .end local v2    # "cert":Ljava/security/cert/X509Certificate;
    .end local v4    # "connectionSpec":Lcom/squareup/okhttp/ConnectionSpec;
    .end local v11    # "unverifiedHandshake":Lcom/squareup/okhttp/Handshake;
    :catch_0
    move-exception v5

    .line 225
    .local v5, "e":Ljava/lang/AssertionError;
    :try_start_1
    invoke-static {v5}, Lcom/squareup/okhttp/internal/Util;->isAndroidGetsocknameError(Ljava/lang/AssertionError;)Z

    move-result v12

    if-eqz v12, :cond_a

    new-instance v12, Ljava/io/IOException;

    invoke-direct {v12, v5}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v12
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 228
    .end local v5    # "e":Ljava/lang/AssertionError;
    :catchall_0
    move-exception v12

    if-eqz v7, :cond_2

    .line 229
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v13

    invoke-virtual {v13, v7}, Lcom/squareup/okhttp/internal/Platform;->afterHandshake(Ljavax/net/ssl/SSLSocket;)V

    .line 231
    :cond_2
    if-nez v9, :cond_3

    .line 232
    invoke-static {v7}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    :cond_3
    throw v12

    .line 205
    .restart local v4    # "connectionSpec":Lcom/squareup/okhttp/ConnectionSpec;
    .restart local v11    # "unverifiedHandshake":Lcom/squareup/okhttp/Handshake;
    :cond_4
    :try_start_2
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getCertificatePinner()Lcom/squareup/okhttp/CertificatePinner;

    move-result-object v12

    sget-object v13, Lcom/squareup/okhttp/CertificatePinner;->DEFAULT:Lcom/squareup/okhttp/CertificatePinner;

    if-eq v12, v13, :cond_5

    .line 206
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v12

    invoke-static {v12}, Lcom/squareup/okhttp/internal/io/RealConnection;->trustRootIndex(Ljavax/net/ssl/SSLSocketFactory;)Lcom/squareup/okhttp/internal/tls/TrustRootIndex;

    move-result-object v10

    .line 207
    .local v10, "trustRootIndex":Lcom/squareup/okhttp/internal/tls/TrustRootIndex;
    new-instance v12, Lcom/squareup/okhttp/internal/tls/CertificateChainCleaner;

    invoke-direct {v12, v10}, Lcom/squareup/okhttp/internal/tls/CertificateChainCleaner;-><init>(Lcom/squareup/okhttp/internal/tls/TrustRootIndex;)V

    .line 208
    invoke-virtual {v11}, Lcom/squareup/okhttp/Handshake;->peerCertificates()Ljava/util/List;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/squareup/okhttp/internal/tls/CertificateChainCleaner;->clean(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    .line 209
    .local v3, "certificates":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/Certificate;>;"
    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getCertificatePinner()Lcom/squareup/okhttp/CertificatePinner;

    move-result-object v12

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->getUriHost()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13, v3}, Lcom/squareup/okhttp/CertificatePinner;->check(Ljava/lang/String;Ljava/util/List;)V

    .line 213
    .end local v3    # "certificates":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/Certificate;>;"
    .end local v10    # "trustRootIndex":Lcom/squareup/okhttp/internal/tls/TrustRootIndex;
    :cond_5
    invoke-virtual {v4}, Lcom/squareup/okhttp/ConnectionSpec;->supportsTlsExtensions()Z

    move-result v12

    if-eqz v12, :cond_8

    .line 214
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v12

    invoke-virtual {v12, v7}, Lcom/squareup/okhttp/internal/Platform;->getSelectedProtocol(Ljavax/net/ssl/SSLSocket;)Ljava/lang/String;

    move-result-object v6

    .line 216
    .local v6, "maybeProtocol":Ljava/lang/String;
    :goto_0
    move-object/from16 v0, p0

    iput-object v7, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    .line 217
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-static {v12}, Lokio/Okio;->source(Ljava/net/Socket;)Lokio/Source;

    move-result-object v12

    invoke-static {v12}, Lokio/Okio;->buffer(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v12

    move-object/from16 v0, p0

    iput-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    .line 218
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-static {v12}, Lokio/Okio;->sink(Ljava/net/Socket;)Lokio/Sink;

    move-result-object v12

    invoke-static {v12}, Lokio/Okio;->buffer(Lokio/Sink;)Lokio/BufferedSink;

    move-result-object v12

    move-object/from16 v0, p0

    iput-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    .line 219
    move-object/from16 v0, p0

    iput-object v11, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->handshake:Lcom/squareup/okhttp/Handshake;

    .line 220
    if-eqz v6, :cond_9

    .line 221
    invoke-static {v6}, Lcom/squareup/okhttp/Protocol;->get(Ljava/lang/String;)Lcom/squareup/okhttp/Protocol;

    move-result-object v12

    :goto_1
    move-object/from16 v0, p0

    iput-object v12, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;
    :try_end_2
    .catch Ljava/lang/AssertionError; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 223
    const/4 v9, 0x1

    .line 228
    if-eqz v7, :cond_6

    .line 229
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v12

    invoke-virtual {v12, v7}, Lcom/squareup/okhttp/internal/Platform;->afterHandshake(Ljavax/net/ssl/SSLSocket;)V

    .line 231
    :cond_6
    if-nez v9, :cond_7

    .line 232
    invoke-static {v7}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 235
    :cond_7
    return-void

    .line 214
    .end local v6    # "maybeProtocol":Ljava/lang/String;
    :cond_8
    const/4 v6, 0x0

    goto :goto_0

    .line 221
    .restart local v6    # "maybeProtocol":Ljava/lang/String;
    :cond_9
    :try_start_3
    sget-object v12, Lcom/squareup/okhttp/Protocol;->HTTP_1_1:Lcom/squareup/okhttp/Protocol;
    :try_end_3
    .catch Ljava/lang/AssertionError; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 226
    .end local v4    # "connectionSpec":Lcom/squareup/okhttp/ConnectionSpec;
    .end local v6    # "maybeProtocol":Ljava/lang/String;
    .end local v11    # "unverifiedHandshake":Lcom/squareup/okhttp/Handshake;
    .restart local v5    # "e":Ljava/lang/AssertionError;
    :cond_a
    :try_start_4
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0
.end method

.method private createTunnel(II)V
    .locals 12
    .param p1, "readTimeout"    # I
    .param p2, "writeTimeout"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 261
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/io/RealConnection;->createTunnelRequest()Lcom/squareup/okhttp/Request;

    move-result-object v6

    .line 262
    .local v6, "tunnelRequest":Lcom/squareup/okhttp/Request;
    invoke-virtual {v6}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v7

    .line 263
    .local v7, "url":Lcom/squareup/okhttp/HttpUrl;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "CONNECT "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v7}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ":"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v7}, Lcom/squareup/okhttp/HttpUrl;->port()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " HTTP/1.1"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 265
    .local v1, "requestLine":Ljava/lang/String;
    :cond_0
    new-instance v5, Lcom/squareup/okhttp/internal/http/Http1xStream;

    const/4 v8, 0x0

    iget-object v9, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    iget-object v10, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    invoke-direct {v5, v8, v9, v10}, Lcom/squareup/okhttp/internal/http/Http1xStream;-><init>(Lcom/squareup/okhttp/internal/http/StreamAllocation;Lokio/BufferedSource;Lokio/BufferedSink;)V

    .line 266
    .local v5, "tunnelConnection":Lcom/squareup/okhttp/internal/http/Http1xStream;
    iget-object v8, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    invoke-interface {v8}, Lokio/BufferedSource;->timeout()Lokio/Timeout;

    move-result-object v8

    int-to-long v10, p1

    sget-object v9, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v8, v10, v11, v9}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    .line 267
    iget-object v8, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    invoke-interface {v8}, Lokio/BufferedSink;->timeout()Lokio/Timeout;

    move-result-object v8

    int-to-long v10, p2

    sget-object v9, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v8, v10, v11, v9}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    .line 268
    invoke-virtual {v6}, Lcom/squareup/okhttp/Request;->headers()Lcom/squareup/okhttp/Headers;

    move-result-object v8

    invoke-virtual {v5, v8, v1}, Lcom/squareup/okhttp/internal/http/Http1xStream;->writeRequest(Lcom/squareup/okhttp/Headers;Ljava/lang/String;)V

    .line 269
    invoke-virtual {v5}, Lcom/squareup/okhttp/internal/http/Http1xStream;->finishRequest()V

    .line 270
    invoke-virtual {v5}, Lcom/squareup/okhttp/internal/http/Http1xStream;->readResponse()Lcom/squareup/okhttp/Response$Builder;

    move-result-object v8

    invoke-virtual {v8, v6}, Lcom/squareup/okhttp/Response$Builder;->request(Lcom/squareup/okhttp/Request;)Lcom/squareup/okhttp/Response$Builder;

    move-result-object v8

    invoke-virtual {v8}, Lcom/squareup/okhttp/Response$Builder;->build()Lcom/squareup/okhttp/Response;

    move-result-object v4

    .line 273
    .local v4, "response":Lcom/squareup/okhttp/Response;
    invoke-static {v4}, Lcom/squareup/okhttp/internal/http/OkHeaders;->contentLength(Lcom/squareup/okhttp/Response;)J

    move-result-wide v2

    .line 274
    .local v2, "contentLength":J
    const-wide/16 v8, -0x1

    cmp-long v8, v2, v8

    if-nez v8, :cond_1

    .line 275
    const-wide/16 v2, 0x0

    .line 277
    :cond_1
    invoke-virtual {v5, v2, v3}, Lcom/squareup/okhttp/internal/http/Http1xStream;->newFixedLengthSource(J)Lokio/Source;

    move-result-object v0

    .line 278
    .local v0, "body":Lokio/Source;
    const v8, 0x7fffffff

    sget-object v9, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {v0, v8, v9}, Lcom/squareup/okhttp/internal/Util;->skipAll(Lokio/Source;ILjava/util/concurrent/TimeUnit;)Z

    .line 279
    invoke-interface {v0}, Lokio/Source;->close()V

    .line 281
    invoke-virtual {v4}, Lcom/squareup/okhttp/Response;->code()I

    move-result v8

    sparse-switch v8, :sswitch_data_0

    .line 299
    new-instance v8, Ljava/io/IOException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Unexpected response code for CONNECT: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    .line 300
    invoke-virtual {v4}, Lcom/squareup/okhttp/Response;->code()I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 287
    :sswitch_0
    iget-object v8, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    invoke-interface {v8}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v8

    invoke-virtual {v8}, Lokio/Buffer;->exhausted()Z

    move-result v8

    if-eqz v8, :cond_2

    iget-object v8, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    invoke-interface {v8}, Lokio/BufferedSink;->buffer()Lokio/Buffer;

    move-result-object v8

    invoke-virtual {v8}, Lokio/Buffer;->exhausted()Z

    move-result v8

    if-nez v8, :cond_3

    .line 288
    :cond_2
    new-instance v8, Ljava/io/IOException;

    const-string v9, "TLS tunnel buffered too many bytes!"

    invoke-direct {v8, v9}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 293
    :sswitch_1
    iget-object v8, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 294
    invoke-virtual {v8}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v8

    invoke-virtual {v8}, Lcom/squareup/okhttp/Address;->getAuthenticator()Lcom/squareup/okhttp/Authenticator;

    move-result-object v8

    iget-object v9, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v9}, Lcom/squareup/okhttp/Route;->getProxy()Ljava/net/Proxy;

    move-result-object v9

    .line 293
    invoke-static {v8, v4, v9}, Lcom/squareup/okhttp/internal/http/OkHeaders;->processAuthHeader(Lcom/squareup/okhttp/Authenticator;Lcom/squareup/okhttp/Response;Ljava/net/Proxy;)Lcom/squareup/okhttp/Request;

    move-result-object v6

    .line 295
    if-nez v6, :cond_0

    .line 296
    new-instance v8, Ljava/io/IOException;

    const-string v9, "Failed to authenticate with proxy"

    invoke-direct {v8, v9}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 290
    :cond_3
    return-void

    .line 281
    nop

    :sswitch_data_0
    .sparse-switch
        0xc8 -> :sswitch_0
        0x197 -> :sswitch_1
    .end sparse-switch
.end method

.method private createTunnelRequest()Lcom/squareup/okhttp/Request;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 313
    new-instance v0, Lcom/squareup/okhttp/Request$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/Request$Builder;-><init>()V

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 314
    invoke-virtual {v1}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/Request$Builder;->url(Lcom/squareup/okhttp/HttpUrl;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v0

    const-string v1, "Host"

    iget-object v2, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 315
    invoke-virtual {v2}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v2

    invoke-virtual {v2}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v2

    invoke-static {v2}, Lcom/squareup/okhttp/internal/Util;->hostHeader(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v0

    const-string v1, "Proxy-Connection"

    const-string v2, "Keep-Alive"

    .line 316
    invoke-virtual {v0, v1, v2}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v0

    const-string v1, "User-Agent"

    .line 317
    invoke-static {}, Lcom/squareup/okhttp/internal/Version;->userAgent()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v0

    .line 318
    invoke-virtual {v0}, Lcom/squareup/okhttp/Request$Builder;->build()Lcom/squareup/okhttp/Request;

    move-result-object v0

    return-object v0
.end method

.method private static declared-synchronized trustRootIndex(Ljavax/net/ssl/SSLSocketFactory;)Lcom/squareup/okhttp/internal/tls/TrustRootIndex;
    .locals 3
    .param p0, "sslSocketFactory"    # Ljavax/net/ssl/SSLSocketFactory;

    .prologue
    .line 246
    const-class v2, Lcom/squareup/okhttp/internal/io/RealConnection;

    monitor-enter v2

    :try_start_0
    sget-object v1, Lcom/squareup/okhttp/internal/io/RealConnection;->lastSslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    if-eq p0, v1, :cond_0

    .line 247
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/squareup/okhttp/internal/Platform;->trustManager(Ljavax/net/ssl/SSLSocketFactory;)Ljavax/net/ssl/X509TrustManager;

    move-result-object v0

    .line 248
    .local v0, "trustManager":Ljavax/net/ssl/X509TrustManager;
    invoke-static {}, Lcom/squareup/okhttp/internal/Platform;->get()Lcom/squareup/okhttp/internal/Platform;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/squareup/okhttp/internal/Platform;->trustRootIndex(Ljavax/net/ssl/X509TrustManager;)Lcom/squareup/okhttp/internal/tls/TrustRootIndex;

    move-result-object v1

    sput-object v1, Lcom/squareup/okhttp/internal/io/RealConnection;->lastTrustRootIndex:Lcom/squareup/okhttp/internal/tls/TrustRootIndex;

    .line 249
    sput-object p0, Lcom/squareup/okhttp/internal/io/RealConnection;->lastSslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 251
    .end local v0    # "trustManager":Ljavax/net/ssl/X509TrustManager;
    :cond_0
    sget-object v1, Lcom/squareup/okhttp/internal/io/RealConnection;->lastTrustRootIndex:Lcom/squareup/okhttp/internal/tls/TrustRootIndex;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v2

    return-object v1

    .line 246
    :catchall_0
    move-exception v1

    monitor-exit v2

    throw v1
.end method


# virtual methods
.method public allocationLimit()I
    .locals 2

    .prologue
    .line 340
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    .line 341
    .local v0, "framedConnection":Lcom/squareup/okhttp/internal/framed/FramedConnection;
    if-eqz v0, :cond_0

    .line 342
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->maxConcurrentStreams()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public cancel()V
    .locals 1

    .prologue
    .line 332
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 333
    return-void
.end method

.method public connect(IIILjava/util/List;Z)V
    .locals 9
    .param p1, "connectTimeout"    # I
    .param p2, "readTimeout"    # I
    .param p3, "writeTimeout"    # I
    .param p5, "connectionRetryEnabled"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(III",
            "Ljava/util/List",
            "<",
            "Lcom/squareup/okhttp/ConnectionSpec;",
            ">;Z)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/squareup/okhttp/internal/http/RouteException;
        }
    .end annotation

    .prologue
    .local p4, "connectionSpecs":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/ConnectionSpec;>;"
    const/4 v7, 0x0

    .line 94
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    if-eqz v5, :cond_0

    new-instance v5, Ljava/lang/IllegalStateException;

    const-string v6, "already connected"

    invoke-direct {v5, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 96
    :cond_0
    const/4 v4, 0x0

    .line 97
    .local v4, "routeException":Lcom/squareup/okhttp/internal/http/RouteException;
    new-instance v1, Lcom/squareup/okhttp/internal/ConnectionSpecSelector;

    invoke-direct {v1, p4}, Lcom/squareup/okhttp/internal/ConnectionSpecSelector;-><init>(Ljava/util/List;)V

    .line 98
    .local v1, "connectionSpecSelector":Lcom/squareup/okhttp/internal/ConnectionSpecSelector;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v5}, Lcom/squareup/okhttp/Route;->getProxy()Ljava/net/Proxy;

    move-result-object v3

    .line 99
    .local v3, "proxy":Ljava/net/Proxy;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v5}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v0

    .line 101
    .local v0, "address":Lcom/squareup/okhttp/Address;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v5}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/Address;->getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v5

    if-nez v5, :cond_2

    sget-object v5, Lcom/squareup/okhttp/ConnectionSpec;->CLEARTEXT:Lcom/squareup/okhttp/ConnectionSpec;

    .line 102
    invoke-interface {p4, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 103
    new-instance v5, Lcom/squareup/okhttp/internal/http/RouteException;

    new-instance v6, Ljava/net/UnknownServiceException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "CLEARTEXT communication not supported: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/net/UnknownServiceException;-><init>(Ljava/lang/String;)V

    invoke-direct {v5, v6}, Lcom/squareup/okhttp/internal/http/RouteException;-><init>(Ljava/io/IOException;)V

    throw v5

    .line 110
    :cond_1
    :try_start_0
    new-instance v5, Ljava/net/Socket;

    invoke-direct {v5, v3}, Ljava/net/Socket;-><init>(Ljava/net/Proxy;)V

    :goto_0
    iput-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    .line 112
    invoke-direct {p0, p1, p2, p3, v1}, Lcom/squareup/okhttp/internal/io/RealConnection;->connectSocket(IIILcom/squareup/okhttp/internal/ConnectionSpecSelector;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 107
    :cond_2
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    if-nez v5, :cond_6

    .line 109
    :try_start_1
    invoke-virtual {v3}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v5

    sget-object v6, Ljava/net/Proxy$Type;->DIRECT:Ljava/net/Proxy$Type;

    if-eq v5, v6, :cond_3

    invoke-virtual {v3}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v5

    sget-object v6, Ljava/net/Proxy$Type;->HTTP:Ljava/net/Proxy$Type;

    if-ne v5, v6, :cond_1

    .line 110
    :cond_3
    invoke-virtual {v0}, Lcom/squareup/okhttp/Address;->getSocketFactory()Ljavax/net/SocketFactory;

    move-result-object v5

    invoke-virtual {v5}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v5

    goto :goto_0

    .line 113
    :catch_0
    move-exception v2

    .line 114
    .local v2, "e":Ljava/io/IOException;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-static {v5}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 115
    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    invoke-static {v5}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 116
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    .line 117
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->rawSocket:Ljava/net/Socket;

    .line 118
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    .line 119
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->sink:Lokio/BufferedSink;

    .line 120
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->handshake:Lcom/squareup/okhttp/Handshake;

    .line 121
    iput-object v7, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    .line 123
    if-nez v4, :cond_5

    .line 124
    new-instance v4, Lcom/squareup/okhttp/internal/http/RouteException;

    .end local v4    # "routeException":Lcom/squareup/okhttp/internal/http/RouteException;
    invoke-direct {v4, v2}, Lcom/squareup/okhttp/internal/http/RouteException;-><init>(Ljava/io/IOException;)V

    .line 129
    .restart local v4    # "routeException":Lcom/squareup/okhttp/internal/http/RouteException;
    :goto_1
    if-eqz p5, :cond_4

    invoke-virtual {v1, v2}, Lcom/squareup/okhttp/internal/ConnectionSpecSelector;->connectionFailed(Ljava/io/IOException;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 130
    :cond_4
    throw v4

    .line 126
    :cond_5
    invoke-virtual {v4, v2}, Lcom/squareup/okhttp/internal/http/RouteException;->addConnectException(Ljava/io/IOException;)V

    goto :goto_1

    .line 134
    .end local v2    # "e":Ljava/io/IOException;
    :cond_6
    return-void
.end method

.method public getHandshake()Lcom/squareup/okhttp/Handshake;
    .locals 1

    .prologue
    .line 379
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->handshake:Lcom/squareup/okhttp/Handshake;

    return-object v0
.end method

.method public getProtocol()Lcom/squareup/okhttp/Protocol;
    .locals 1

    .prologue
    .line 391
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Lcom/squareup/okhttp/Protocol;->HTTP_1_1:Lcom/squareup/okhttp/Protocol;

    goto :goto_0
.end method

.method public getRoute()Lcom/squareup/okhttp/Route;
    .locals 1

    .prologue
    .line 327
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    return-object v0
.end method

.method public getSocket()Ljava/net/Socket;
    .locals 1

    .prologue
    .line 336
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    return-object v0
.end method

.method isConnected()Z
    .locals 1

    .prologue
    .line 323
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isHealthy(Z)Z
    .locals 6
    .param p1, "doExtensiveChecks"    # Z

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 348
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->isClosed()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->isInputShutdown()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->isOutputShutdown()Z

    move-result v4

    if-eqz v4, :cond_2

    :cond_0
    move v2, v3

    .line 375
    :cond_1
    :goto_0
    return v2

    .line 352
    :cond_2
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    if-nez v4, :cond_1

    .line 356
    if-eqz p1, :cond_1

    .line 358
    :try_start_0
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4}, Ljava/net/Socket;->getSoTimeout()I
    :try_end_0
    .catch Ljava/net/SocketTimeoutException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 360
    .local v1, "readTimeout":I
    :try_start_1
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 361
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->source:Lokio/BufferedSource;

    invoke-interface {v4}, Lokio/BufferedSource;->exhausted()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v4

    if-eqz v4, :cond_3

    .line 366
    :try_start_2
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4, v1}, Ljava/net/Socket;->setSoTimeout(I)V

    move v2, v3

    goto :goto_0

    :cond_3
    iget-object v4, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v4, v1}, Ljava/net/Socket;->setSoTimeout(I)V

    goto :goto_0

    .line 368
    .end local v1    # "readTimeout":I
    :catch_0
    move-exception v3

    goto :goto_0

    .line 366
    .restart local v1    # "readTimeout":I
    :catchall_0
    move-exception v4

    iget-object v5, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->socket:Ljava/net/Socket;

    invoke-virtual {v5, v1}, Ljava/net/Socket;->setSoTimeout(I)V

    throw v4
    :try_end_2
    .catch Ljava/net/SocketTimeoutException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 370
    .end local v1    # "readTimeout":I
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/io/IOException;
    move v2, v3

    .line 371
    goto :goto_0
.end method

.method public isMultiplexed()Z
    .locals 1

    .prologue
    .line 387
    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->framedConnection:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 395
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Connection{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 396
    invoke-virtual {v1}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    invoke-virtual {v1}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/HttpUrl;->port()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", proxy="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 398
    invoke-virtual {v1}, Lcom/squareup/okhttp/Route;->getProxy()Ljava/net/Proxy;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " hostAddress="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->route:Lcom/squareup/okhttp/Route;

    .line 400
    invoke-virtual {v1}, Lcom/squareup/okhttp/Route;->getSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " cipherSuite="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->handshake:Lcom/squareup/okhttp/Handshake;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->handshake:Lcom/squareup/okhttp/Handshake;

    .line 402
    invoke-virtual {v0}, Lcom/squareup/okhttp/Handshake;->cipherSuite()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " protocol="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/io/RealConnection;->protocol:Lcom/squareup/okhttp/Protocol;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "none"

    goto :goto_0
.end method
