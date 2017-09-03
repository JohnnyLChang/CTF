.class public Lcom/squareup/okhttp/Call;
.super Ljava/lang/Object;
.source "Call.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;,
        Lcom/squareup/okhttp/Call$AsyncCall;
    }
.end annotation


# instance fields
.field volatile canceled:Z

.field private final client:Lcom/squareup/okhttp/OkHttpClient;

.field engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

.field private executed:Z

.field originalRequest:Lcom/squareup/okhttp/Request;


# direct methods
.method protected constructor <init>(Lcom/squareup/okhttp/OkHttpClient;Lcom/squareup/okhttp/Request;)V
    .locals 1
    .param p1, "client"    # Lcom/squareup/okhttp/OkHttpClient;
    .param p2, "originalRequest"    # Lcom/squareup/okhttp/Request;

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    invoke-virtual {p1}, Lcom/squareup/okhttp/OkHttpClient;->copyWithDefaults()Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    .line 50
    iput-object p2, p0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    .line 51
    return-void
.end method

.method static synthetic access$100(Lcom/squareup/okhttp/Call;Z)Lcom/squareup/okhttp/Response;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/Call;
    .param p1, "x1"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/squareup/okhttp/Call;->getResponseWithInterceptorChain(Z)Lcom/squareup/okhttp/Response;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200(Lcom/squareup/okhttp/Call;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/Call;

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/squareup/okhttp/Call;->toLoggableString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/Call;

    .prologue
    .line 35
    iget-object v0, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    return-object v0
.end method

.method private getResponseWithInterceptorChain(Z)Lcom/squareup/okhttp/Response;
    .locals 3
    .param p1, "forWebSocket"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 204
    new-instance v0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-direct {v0, p0, v1, v2, p1}, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;-><init>(Lcom/squareup/okhttp/Call;ILcom/squareup/okhttp/Request;Z)V

    .line 205
    .local v0, "chain":Lcom/squareup/okhttp/Interceptor$Chain;
    iget-object v1, p0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-interface {v0, v1}, Lcom/squareup/okhttp/Interceptor$Chain;->proceed(Lcom/squareup/okhttp/Request;)Lcom/squareup/okhttp/Response;

    move-result-object v1

    return-object v1
.end method

.method private toLoggableString()Ljava/lang/String;
    .locals 4

    .prologue
    .line 198
    iget-boolean v2, p0, Lcom/squareup/okhttp/Call;->canceled:Z

    if-eqz v2, :cond_0

    const-string v1, "canceled call"

    .line 199
    .local v1, "string":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-virtual {v2}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v2

    const-string v3, "/..."

    invoke-virtual {v2, v3}, Lcom/squareup/okhttp/HttpUrl;->resolve(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;

    move-result-object v0

    .line 200
    .local v0, "redactedUrl":Lcom/squareup/okhttp/HttpUrl;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 198
    .end local v0    # "redactedUrl":Lcom/squareup/okhttp/HttpUrl;
    .end local v1    # "string":Ljava/lang/String;
    :cond_0
    const-string v1, "call"

    goto :goto_0
.end method


# virtual methods
.method public cancel()V
    .locals 1

    .prologue
    .line 122
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/squareup/okhttp/Call;->canceled:Z

    .line 123
    iget-object v0, p0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/http/HttpEngine;->cancel()V

    .line 124
    :cond_0
    return-void
.end method

.method public enqueue(Lcom/squareup/okhttp/Callback;)V
    .locals 1
    .param p1, "responseCallback"    # Lcom/squareup/okhttp/Callback;

    .prologue
    .line 106
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/squareup/okhttp/Call;->enqueue(Lcom/squareup/okhttp/Callback;Z)V

    .line 107
    return-void
.end method

.method enqueue(Lcom/squareup/okhttp/Callback;Z)V
    .locals 3
    .param p1, "responseCallback"    # Lcom/squareup/okhttp/Callback;
    .param p2, "forWebSocket"    # Z

    .prologue
    .line 110
    monitor-enter p0

    .line 111
    :try_start_0
    iget-boolean v0, p0, Lcom/squareup/okhttp/Call;->executed:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Already Executed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 113
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 112
    :cond_0
    const/4 v0, 0x1

    :try_start_1
    iput-boolean v0, p0, Lcom/squareup/okhttp/Call;->executed:Z

    .line 113
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 114
    iget-object v0, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v0}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v0

    new-instance v1, Lcom/squareup/okhttp/Call$AsyncCall;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, p2, v2}, Lcom/squareup/okhttp/Call$AsyncCall;-><init>(Lcom/squareup/okhttp/Call;Lcom/squareup/okhttp/Callback;ZLcom/squareup/okhttp/Call$1;)V

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/Dispatcher;->enqueue(Lcom/squareup/okhttp/Call$AsyncCall;)V

    .line 115
    return-void
.end method

.method public execute()Lcom/squareup/okhttp/Response;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 74
    monitor-enter p0

    .line 75
    :try_start_0
    iget-boolean v1, p0, Lcom/squareup/okhttp/Call;->executed:Z

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Already Executed"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 77
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 76
    :cond_0
    const/4 v1, 0x1

    :try_start_1
    iput-boolean v1, p0, Lcom/squareup/okhttp/Call;->executed:Z

    .line 77
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 79
    :try_start_2
    iget-object v1, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v1}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/squareup/okhttp/Dispatcher;->executed(Lcom/squareup/okhttp/Call;)V

    .line 80
    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/squareup/okhttp/Call;->getResponseWithInterceptorChain(Z)Lcom/squareup/okhttp/Response;

    move-result-object v0

    .line 81
    .local v0, "result":Lcom/squareup/okhttp/Response;
    if-nez v0, :cond_1

    new-instance v1, Ljava/io/IOException;

    const-string v2, "Canceled"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 84
    .end local v0    # "result":Lcom/squareup/okhttp/Response;
    :catchall_1
    move-exception v1

    iget-object v2, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v2}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v2

    invoke-virtual {v2, p0}, Lcom/squareup/okhttp/Dispatcher;->finished(Lcom/squareup/okhttp/Call;)V

    throw v1

    .restart local v0    # "result":Lcom/squareup/okhttp/Response;
    :cond_1
    iget-object v1, p0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    invoke-virtual {v1}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/squareup/okhttp/Dispatcher;->finished(Lcom/squareup/okhttp/Call;)V

    return-object v0
.end method

.method getResponse(Lcom/squareup/okhttp/Request;Z)Lcom/squareup/okhttp/Response;
    .locals 21
    .param p1, "request"    # Lcom/squareup/okhttp/Request;
    .param p2, "forWebSocket"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 253
    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/Request;->body()Lcom/squareup/okhttp/RequestBody;

    move-result-object v11

    .line 254
    .local v11, "body":Lcom/squareup/okhttp/RequestBody;
    if-eqz v11, :cond_1

    .line 255
    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/Request;->newBuilder()Lcom/squareup/okhttp/Request$Builder;

    move-result-object v19

    .line 257
    .local v19, "requestBuilder":Lcom/squareup/okhttp/Request$Builder;
    invoke-virtual {v11}, Lcom/squareup/okhttp/RequestBody;->contentType()Lcom/squareup/okhttp/MediaType;

    move-result-object v14

    .line 258
    .local v14, "contentType":Lcom/squareup/okhttp/MediaType;
    if-eqz v14, :cond_0

    .line 259
    const-string v2, "Content-Type"

    invoke-virtual {v14}, Lcom/squareup/okhttp/MediaType;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v3}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    .line 262
    :cond_0
    invoke-virtual {v11}, Lcom/squareup/okhttp/RequestBody;->contentLength()J

    move-result-wide v12

    .line 263
    .local v12, "contentLength":J
    const-wide/16 v2, -0x1

    cmp-long v2, v12, v2

    if-eqz v2, :cond_3

    .line 264
    const-string v2, "Content-Length"

    invoke-static {v12, v13}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v3}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    .line 265
    const-string v2, "Transfer-Encoding"

    move-object/from16 v0, v19

    invoke-virtual {v0, v2}, Lcom/squareup/okhttp/Request$Builder;->removeHeader(Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    .line 271
    :goto_0
    invoke-virtual/range {v19 .. v19}, Lcom/squareup/okhttp/Request$Builder;->build()Lcom/squareup/okhttp/Request;

    move-result-object p1

    .line 275
    .end local v12    # "contentLength":J
    .end local v14    # "contentType":Lcom/squareup/okhttp/MediaType;
    .end local v19    # "requestBuilder":Lcom/squareup/okhttp/Request$Builder;
    :cond_1
    new-instance v2, Lcom/squareup/okhttp/internal/http/HttpEngine;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object/from16 v4, p1

    move/from16 v7, p2

    invoke-direct/range {v2 .. v10}, Lcom/squareup/okhttp/internal/http/HttpEngine;-><init>(Lcom/squareup/okhttp/OkHttpClient;Lcom/squareup/okhttp/Request;ZZZLcom/squareup/okhttp/internal/http/StreamAllocation;Lcom/squareup/okhttp/internal/http/RetryableSink;Lcom/squareup/okhttp/Response;)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    .line 277
    const/16 v17, 0x0

    .line 279
    .local v17, "followUpCount":I
    :cond_2
    :goto_1
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/squareup/okhttp/Call;->canceled:Z

    if-eqz v2, :cond_4

    .line 280
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->releaseStreamAllocation()V

    .line 281
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Canceled"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 267
    .end local v17    # "followUpCount":I
    .restart local v12    # "contentLength":J
    .restart local v14    # "contentType":Lcom/squareup/okhttp/MediaType;
    .restart local v19    # "requestBuilder":Lcom/squareup/okhttp/Request$Builder;
    :cond_3
    const-string v2, "Transfer-Encoding"

    const-string v3, "chunked"

    move-object/from16 v0, v19

    invoke-virtual {v0, v2, v3}, Lcom/squareup/okhttp/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    .line 268
    const-string v2, "Content-Length"

    move-object/from16 v0, v19

    invoke-virtual {v0, v2}, Lcom/squareup/okhttp/Request$Builder;->removeHeader(Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    goto :goto_0

    .line 284
    .end local v12    # "contentLength":J
    .end local v14    # "contentType":Lcom/squareup/okhttp/MediaType;
    .end local v19    # "requestBuilder":Lcom/squareup/okhttp/Request$Builder;
    .restart local v17    # "followUpCount":I
    :cond_4
    const/16 v18, 0x1

    .line 286
    .local v18, "releaseConnection":Z
    :try_start_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->sendRequest()V

    .line 287
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->readResponse()V
    :try_end_0
    .catch Lcom/squareup/okhttp/internal/http/RequestException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lcom/squareup/okhttp/internal/http/RouteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 288
    const/16 v18, 0x0

    .line 315
    if-eqz v18, :cond_5

    .line 316
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->close()Lcom/squareup/okhttp/internal/http/StreamAllocation;

    move-result-object v8

    .line 317
    .local v8, "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    .line 321
    .end local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    :cond_5
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->getResponse()Lcom/squareup/okhttp/Response;

    move-result-object v10

    .line 322
    .local v10, "response":Lcom/squareup/okhttp/Response;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->followUpRequest()Lcom/squareup/okhttp/Request;

    move-result-object v16

    .line 324
    .local v16, "followUp":Lcom/squareup/okhttp/Request;
    if-nez v16, :cond_a

    .line 325
    if-nez p2, :cond_6

    .line 326
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->releaseStreamAllocation()V

    .line 328
    :cond_6
    return-object v10

    .line 289
    .end local v10    # "response":Lcom/squareup/okhttp/Response;
    .end local v16    # "followUp":Lcom/squareup/okhttp/Request;
    :catch_0
    move-exception v15

    .line 291
    .local v15, "e":Lcom/squareup/okhttp/internal/http/RequestException;
    :try_start_1
    invoke-virtual {v15}, Lcom/squareup/okhttp/internal/http/RequestException;->getCause()Ljava/io/IOException;

    move-result-object v2

    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 315
    .end local v15    # "e":Lcom/squareup/okhttp/internal/http/RequestException;
    :catchall_0
    move-exception v2

    if-eqz v18, :cond_7

    .line 316
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v3}, Lcom/squareup/okhttp/internal/http/HttpEngine;->close()Lcom/squareup/okhttp/internal/http/StreamAllocation;

    move-result-object v8

    .line 317
    .restart local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    .line 318
    .end local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    :cond_7
    throw v2

    .line 292
    :catch_1
    move-exception v15

    .line 294
    .local v15, "e":Lcom/squareup/okhttp/internal/http/RouteException;
    :try_start_2
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2, v15}, Lcom/squareup/okhttp/internal/http/HttpEngine;->recover(Lcom/squareup/okhttp/internal/http/RouteException;)Lcom/squareup/okhttp/internal/http/HttpEngine;

    move-result-object v20

    .line 295
    .local v20, "retryEngine":Lcom/squareup/okhttp/internal/http/HttpEngine;
    if-eqz v20, :cond_8

    .line 296
    const/16 v18, 0x0

    .line 297
    move-object/from16 v0, v20

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 315
    if-eqz v18, :cond_2

    .line 316
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->close()Lcom/squareup/okhttp/internal/http/StreamAllocation;

    move-result-object v8

    .line 317
    .restart local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    goto/16 :goto_1

    .line 301
    .end local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    :cond_8
    :try_start_3
    invoke-virtual {v15}, Lcom/squareup/okhttp/internal/http/RouteException;->getLastConnectException()Ljava/io/IOException;

    move-result-object v2

    throw v2

    .line 302
    .end local v15    # "e":Lcom/squareup/okhttp/internal/http/RouteException;
    .end local v20    # "retryEngine":Lcom/squareup/okhttp/internal/http/HttpEngine;
    :catch_2
    move-exception v15

    .line 304
    .local v15, "e":Ljava/io/IOException;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    const/4 v3, 0x0

    invoke-virtual {v2, v15, v3}, Lcom/squareup/okhttp/internal/http/HttpEngine;->recover(Ljava/io/IOException;Lokio/Sink;)Lcom/squareup/okhttp/internal/http/HttpEngine;

    move-result-object v20

    .line 305
    .restart local v20    # "retryEngine":Lcom/squareup/okhttp/internal/http/HttpEngine;
    if-eqz v20, :cond_9

    .line 306
    const/16 v18, 0x0

    .line 307
    move-object/from16 v0, v20

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 315
    if-eqz v18, :cond_2

    .line 316
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->close()Lcom/squareup/okhttp/internal/http/StreamAllocation;

    move-result-object v8

    .line 317
    .restart local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    goto/16 :goto_1

    .line 312
    .end local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    :cond_9
    :try_start_4
    throw v15
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 331
    .end local v15    # "e":Ljava/io/IOException;
    .end local v20    # "retryEngine":Lcom/squareup/okhttp/internal/http/HttpEngine;
    .restart local v10    # "response":Lcom/squareup/okhttp/Response;
    .restart local v16    # "followUp":Lcom/squareup/okhttp/Request;
    :cond_a
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/http/HttpEngine;->close()Lcom/squareup/okhttp/internal/http/StreamAllocation;

    move-result-object v8

    .line 333
    .restart local v8    # "streamAllocation":Lcom/squareup/okhttp/internal/http/StreamAllocation;
    add-int/lit8 v17, v17, 0x1

    const/16 v2, 0x14

    move/from16 v0, v17

    if-le v0, v2, :cond_b

    .line 334
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    .line 335
    new-instance v2, Ljava/net/ProtocolException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Too many follow-up requests: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 338
    :cond_b
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual/range {v16 .. v16}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/squareup/okhttp/internal/http/HttpEngine;->sameConnection(Lcom/squareup/okhttp/HttpUrl;)Z

    move-result v2

    if-nez v2, :cond_c

    .line 339
    invoke-virtual {v8}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->release()V

    .line 340
    const/4 v8, 0x0

    .line 343
    :cond_c
    move-object/from16 p1, v16

    .line 344
    new-instance v2, Lcom/squareup/okhttp/internal/http/HttpEngine;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/Call;->client:Lcom/squareup/okhttp/OkHttpClient;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object/from16 v4, p1

    move/from16 v7, p2

    invoke-direct/range {v2 .. v10}, Lcom/squareup/okhttp/internal/http/HttpEngine;-><init>(Lcom/squareup/okhttp/OkHttpClient;Lcom/squareup/okhttp/Request;ZZZLcom/squareup/okhttp/internal/http/StreamAllocation;Lcom/squareup/okhttp/internal/http/RetryableSink;Lcom/squareup/okhttp/Response;)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    goto/16 :goto_1
.end method

.method public isCanceled()Z
    .locals 1

    .prologue
    .line 135
    iget-boolean v0, p0, Lcom/squareup/okhttp/Call;->canceled:Z

    return v0
.end method

.method public declared-synchronized isExecuted()Z
    .locals 1

    .prologue
    .line 131
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/squareup/okhttp/Call;->executed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method tag()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 89
    iget-object v0, p0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-virtual {v0}, Lcom/squareup/okhttp/Request;->tag()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
