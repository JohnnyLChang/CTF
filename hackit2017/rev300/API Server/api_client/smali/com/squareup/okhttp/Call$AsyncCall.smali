.class final Lcom/squareup/okhttp/Call$AsyncCall;
.super Lcom/squareup/okhttp/internal/NamedRunnable;
.source "Call.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/Call;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x10
    name = "AsyncCall"
.end annotation


# instance fields
.field private final forWebSocket:Z

.field private final responseCallback:Lcom/squareup/okhttp/Callback;

.field final synthetic this$0:Lcom/squareup/okhttp/Call;


# direct methods
.method private constructor <init>(Lcom/squareup/okhttp/Call;Lcom/squareup/okhttp/Callback;Z)V
    .locals 4
    .param p1, "this$0"    # Lcom/squareup/okhttp/Call;
    .param p2, "responseCallback"    # Lcom/squareup/okhttp/Callback;
    .param p3, "forWebSocket"    # Z

    .prologue
    .line 142
    iput-object p1, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    .line 143
    const-string v0, "OkHttp %s"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p1, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-virtual {v3}, Lcom/squareup/okhttp/Request;->urlString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/squareup/okhttp/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 144
    iput-object p2, p0, Lcom/squareup/okhttp/Call$AsyncCall;->responseCallback:Lcom/squareup/okhttp/Callback;

    .line 145
    iput-boolean p3, p0, Lcom/squareup/okhttp/Call$AsyncCall;->forWebSocket:Z

    .line 146
    return-void
.end method

.method synthetic constructor <init>(Lcom/squareup/okhttp/Call;Lcom/squareup/okhttp/Callback;ZLcom/squareup/okhttp/Call$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/squareup/okhttp/Call;
    .param p2, "x1"    # Lcom/squareup/okhttp/Callback;
    .param p3, "x2"    # Z
    .param p4, "x3"    # Lcom/squareup/okhttp/Call$1;

    .prologue
    .line 138
    invoke-direct {p0, p1, p2, p3}, Lcom/squareup/okhttp/Call$AsyncCall;-><init>(Lcom/squareup/okhttp/Call;Lcom/squareup/okhttp/Callback;Z)V

    return-void
.end method


# virtual methods
.method cancel()V
    .locals 1

    .prologue
    .line 161
    iget-object v0, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    invoke-virtual {v0}, Lcom/squareup/okhttp/Call;->cancel()V

    .line 162
    return-void
.end method

.method protected execute()V
    .locals 8

    .prologue
    .line 169
    const/4 v3, 0x0

    .line 171
    .local v3, "signalledCallback":Z
    :try_start_0
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-boolean v5, p0, Lcom/squareup/okhttp/Call$AsyncCall;->forWebSocket:Z

    invoke-static {v4, v5}, Lcom/squareup/okhttp/Call;->access$100(Lcom/squareup/okhttp/Call;Z)Lcom/squareup/okhttp/Response;

    move-result-object v2

    .line 172
    .local v2, "response":Lcom/squareup/okhttp/Response;
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-boolean v4, v4, Lcom/squareup/okhttp/Call;->canceled:Z

    if-eqz v4, :cond_0

    .line 173
    const/4 v3, 0x1

    .line 174
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->responseCallback:Lcom/squareup/okhttp/Callback;

    iget-object v5, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v5, v5, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    new-instance v6, Ljava/io/IOException;

    const-string v7, "Canceled"

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    invoke-interface {v4, v5, v6}, Lcom/squareup/okhttp/Callback;->onFailure(Lcom/squareup/okhttp/Request;Ljava/io/IOException;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 188
    :goto_0
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v4}, Lcom/squareup/okhttp/Call;->access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v4

    invoke-virtual {v4}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v4

    invoke-virtual {v4, p0}, Lcom/squareup/okhttp/Dispatcher;->finished(Lcom/squareup/okhttp/Call$AsyncCall;)V

    .line 190
    .end local v2    # "response":Lcom/squareup/okhttp/Response;
    :goto_1
    return-void

    .line 176
    .restart local v2    # "response":Lcom/squareup/okhttp/Response;
    :cond_0
    const/4 v3, 0x1

    .line 177
    :try_start_1
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->responseCallback:Lcom/squareup/okhttp/Callback;

    invoke-interface {v4, v2}, Lcom/squareup/okhttp/Callback;->onResponse(Lcom/squareup/okhttp/Response;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 179
    .end local v2    # "response":Lcom/squareup/okhttp/Response;
    :catch_0
    move-exception v0

    .line 180
    .local v0, "e":Ljava/io/IOException;
    if-eqz v3, :cond_1

    .line 182
    :try_start_2
    sget-object v4, Lcom/squareup/okhttp/internal/Internal;->logger:Ljava/util/logging/Logger;

    sget-object v5, Ljava/util/logging/Level;->INFO:Ljava/util/logging/Level;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Callback failure for "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v7}, Lcom/squareup/okhttp/Call;->access$200(Lcom/squareup/okhttp/Call;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6, v0}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 188
    :goto_2
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v4}, Lcom/squareup/okhttp/Call;->access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v4

    invoke-virtual {v4}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v4

    invoke-virtual {v4, p0}, Lcom/squareup/okhttp/Dispatcher;->finished(Lcom/squareup/okhttp/Call$AsyncCall;)V

    goto :goto_1

    .line 184
    :cond_1
    :try_start_3
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v4, v4, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v1, v4, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    .line 185
    .local v1, "request":Lcom/squareup/okhttp/Request;
    :goto_3
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->responseCallback:Lcom/squareup/okhttp/Callback;

    invoke-interface {v4, v1, v0}, Lcom/squareup/okhttp/Callback;->onFailure(Lcom/squareup/okhttp/Request;Ljava/io/IOException;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_2

    .line 188
    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "request":Lcom/squareup/okhttp/Request;
    :catchall_0
    move-exception v4

    iget-object v5, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v5}, Lcom/squareup/okhttp/Call;->access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/OkHttpClient;->getDispatcher()Lcom/squareup/okhttp/Dispatcher;

    move-result-object v5

    invoke-virtual {v5, p0}, Lcom/squareup/okhttp/Dispatcher;->finished(Lcom/squareup/okhttp/Call$AsyncCall;)V

    throw v4

    .line 184
    .restart local v0    # "e":Ljava/io/IOException;
    :cond_2
    :try_start_4
    iget-object v4, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v4, v4, Lcom/squareup/okhttp/Call;->engine:Lcom/squareup/okhttp/internal/http/HttpEngine;

    invoke-virtual {v4}, Lcom/squareup/okhttp/internal/http/HttpEngine;->getRequest()Lcom/squareup/okhttp/Request;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-result-object v1

    goto :goto_3
.end method

.method get()Lcom/squareup/okhttp/Call;
    .locals 1

    .prologue
    .line 165
    iget-object v0, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    return-object v0
.end method

.method host()Ljava/lang/String;
    .locals 1

    .prologue
    .line 149
    iget-object v0, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v0, v0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-virtual {v0}, Lcom/squareup/okhttp/Request;->httpUrl()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method request()Lcom/squareup/okhttp/Request;
    .locals 1

    .prologue
    .line 153
    iget-object v0, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v0, v0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    return-object v0
.end method

.method tag()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 157
    iget-object v0, p0, Lcom/squareup/okhttp/Call$AsyncCall;->this$0:Lcom/squareup/okhttp/Call;

    iget-object v0, v0, Lcom/squareup/okhttp/Call;->originalRequest:Lcom/squareup/okhttp/Request;

    invoke-virtual {v0}, Lcom/squareup/okhttp/Request;->tag()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
