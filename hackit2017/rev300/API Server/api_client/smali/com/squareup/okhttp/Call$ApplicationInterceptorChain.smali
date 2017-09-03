.class Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;
.super Ljava/lang/Object;
.source "Call.java"

# interfaces
.implements Lcom/squareup/okhttp/Interceptor$Chain;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/Call;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ApplicationInterceptorChain"
.end annotation


# instance fields
.field private final forWebSocket:Z

.field private final index:I

.field private final request:Lcom/squareup/okhttp/Request;

.field final synthetic this$0:Lcom/squareup/okhttp/Call;


# direct methods
.method constructor <init>(Lcom/squareup/okhttp/Call;ILcom/squareup/okhttp/Request;Z)V
    .locals 0
    .param p1, "this$0"    # Lcom/squareup/okhttp/Call;
    .param p2, "index"    # I
    .param p3, "request"    # Lcom/squareup/okhttp/Request;
    .param p4, "forWebSocket"    # Z

    .prologue
    .line 213
    iput-object p1, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->this$0:Lcom/squareup/okhttp/Call;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 214
    iput p2, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->index:I

    .line 215
    iput-object p3, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->request:Lcom/squareup/okhttp/Request;

    .line 216
    iput-boolean p4, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->forWebSocket:Z

    .line 217
    return-void
.end method


# virtual methods
.method public connection()Lcom/squareup/okhttp/Connection;
    .locals 1

    .prologue
    .line 220
    const/4 v0, 0x0

    return-object v0
.end method

.method public proceed(Lcom/squareup/okhttp/Request;)Lcom/squareup/okhttp/Response;
    .locals 6
    .param p1, "request"    # Lcom/squareup/okhttp/Request;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 229
    iget v3, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->index:I

    iget-object v4, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v4}, Lcom/squareup/okhttp/Call;->access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v4

    invoke-virtual {v4}, Lcom/squareup/okhttp/OkHttpClient;->interceptors()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 230
    new-instance v0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;

    iget-object v3, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->this$0:Lcom/squareup/okhttp/Call;

    iget v4, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->index:I

    add-int/lit8 v4, v4, 0x1

    iget-boolean v5, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->forWebSocket:Z

    invoke-direct {v0, v3, v4, p1, v5}, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;-><init>(Lcom/squareup/okhttp/Call;ILcom/squareup/okhttp/Request;Z)V

    .line 231
    .local v0, "chain":Lcom/squareup/okhttp/Interceptor$Chain;
    iget-object v3, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->this$0:Lcom/squareup/okhttp/Call;

    invoke-static {v3}, Lcom/squareup/okhttp/Call;->access$300(Lcom/squareup/okhttp/Call;)Lcom/squareup/okhttp/OkHttpClient;

    move-result-object v3

    invoke-virtual {v3}, Lcom/squareup/okhttp/OkHttpClient;->interceptors()Ljava/util/List;

    move-result-object v3

    iget v4, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->index:I

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/squareup/okhttp/Interceptor;

    .line 232
    .local v2, "interceptor":Lcom/squareup/okhttp/Interceptor;
    invoke-interface {v2, v0}, Lcom/squareup/okhttp/Interceptor;->intercept(Lcom/squareup/okhttp/Interceptor$Chain;)Lcom/squareup/okhttp/Response;

    move-result-object v1

    .line 234
    .local v1, "interceptedResponse":Lcom/squareup/okhttp/Response;
    if-nez v1, :cond_1

    .line 235
    new-instance v3, Ljava/lang/NullPointerException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "application interceptor "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " returned null"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 243
    .end local v0    # "chain":Lcom/squareup/okhttp/Interceptor$Chain;
    .end local v1    # "interceptedResponse":Lcom/squareup/okhttp/Response;
    .end local v2    # "interceptor":Lcom/squareup/okhttp/Interceptor;
    :cond_0
    iget-object v3, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->this$0:Lcom/squareup/okhttp/Call;

    iget-boolean v4, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->forWebSocket:Z

    invoke-virtual {v3, p1, v4}, Lcom/squareup/okhttp/Call;->getResponse(Lcom/squareup/okhttp/Request;Z)Lcom/squareup/okhttp/Response;

    move-result-object v1

    :cond_1
    return-object v1
.end method

.method public request()Lcom/squareup/okhttp/Request;
    .locals 1

    .prologue
    .line 224
    iget-object v0, p0, Lcom/squareup/okhttp/Call$ApplicationInterceptorChain;->request:Lcom/squareup/okhttp/Request;

    return-object v0
.end method
