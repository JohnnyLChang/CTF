.class public Lanative/hackit2017/com/apiclient/Client;
.super Ljava/lang/Object;
.source "Client.java"


# instance fields
.field private SERVER_API:Ljava/lang/String;

.field private method:Ljava/lang/String;

.field private post:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "method"    # Ljava/lang/String;

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lanative/hackit2017/com/apiclient/Client;->post:Ljava/util/HashMap;

    .line 26
    iput-object p1, p0, Lanative/hackit2017/com/apiclient/Client;->method:Ljava/lang/String;

    .line 27
    sget-object v0, Lanative/hackit2017/com/apiclient/MainActivity;->INSTANCE:Lanative/hackit2017/com/apiclient/MainActivity;

    invoke-virtual {v0}, Lanative/hackit2017/com/apiclient/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f060022

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanative/hackit2017/com/apiclient/Client;->SERVER_API:Ljava/lang/String;

    .line 28
    return-void
.end method

.method private buildPostArgs()Ljava/lang/String;
    .locals 13

    .prologue
    const/4 v12, 0x1

    const/4 v11, 0x0

    .line 39
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 40
    .local v0, "builder":Ljava/lang/StringBuilder;
    iget-object v6, p0, Lanative/hackit2017/com/apiclient/Client;->post:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 41
    .local v2, "key":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "="

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v6, p0, Lanative/hackit2017/com/apiclient/Client;->post:Ljava/util/HashMap;

    invoke-virtual {v6, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, "&"

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 43
    .end local v2    # "key":Ljava/lang/String;
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 44
    .local v3, "request":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v6

    invoke-static {v6}, Lanative/hackit2017/com/apiclient/MainActivity;->signature([B)[B

    move-result-object v4

    .line 45
    .local v4, "signature":[B
    const/4 v5, 0x0

    .line 47
    .local v5, "signedRequest":Ljava/lang/String;
    :try_start_0
    const-string v6, "%s.%s"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    new-instance v9, Ljava/lang/String;

    invoke-static {v4}, Lorg/apache/commons/codec/binary/Hex;->encodeHex([B)[C

    move-result-object v10

    invoke-direct {v9, v10}, Ljava/lang/String;-><init>([C)V

    aput-object v9, v7, v8

    const/4 v8, 0x1

    const-string v9, "UTF-8"

    invoke-static {v3, v9}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 53
    :goto_1
    const-string v6, "sig_body=%s&sig_version=4"

    new-array v7, v12, [Ljava/lang/Object;

    aput-object v5, v7, v11

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    return-object v6

    .line 48
    :catch_0
    move-exception v1

    .line 50
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public addPost(Ljava/lang/String;Ljava/lang/String;)Lanative/hackit2017/com/apiclient/Client;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 33
    iget-object v0, p0, Lanative/hackit2017/com/apiclient/Client;->post:Ljava/util/HashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 34
    return-object p0
.end method

.method public send()Ljava/lang/String;
    .locals 8

    .prologue
    .line 59
    new-instance v0, Lcom/squareup/okhttp/OkHttpClient;

    invoke-direct {v0}, Lcom/squareup/okhttp/OkHttpClient;-><init>()V

    .line 61
    .local v0, "client":Lcom/squareup/okhttp/OkHttpClient;
    const-string v5, "text/plain"

    invoke-static {v5}, Lcom/squareup/okhttp/MediaType;->parse(Ljava/lang/String;)Lcom/squareup/okhttp/MediaType;

    move-result-object v5

    invoke-direct {p0}, Lanative/hackit2017/com/apiclient/Client;->buildPostArgs()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/squareup/okhttp/RequestBody;->create(Lcom/squareup/okhttp/MediaType;Ljava/lang/String;)Lcom/squareup/okhttp/RequestBody;

    move-result-object v2

    .line 62
    .local v2, "formBody":Lcom/squareup/okhttp/RequestBody;
    new-instance v5, Lcom/squareup/okhttp/Request$Builder;

    invoke-direct {v5}, Lcom/squareup/okhttp/Request$Builder;-><init>()V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p0, Lanative/hackit2017/com/apiclient/Client;->SERVER_API:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lanative/hackit2017/com/apiclient/Client;->method:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 63
    invoke-virtual {v5, v6}, Lcom/squareup/okhttp/Request$Builder;->url(Ljava/lang/String;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v5

    .line 64
    invoke-virtual {v5, v2}, Lcom/squareup/okhttp/Request$Builder;->post(Lcom/squareup/okhttp/RequestBody;)Lcom/squareup/okhttp/Request$Builder;

    move-result-object v5

    .line 65
    invoke-virtual {v5}, Lcom/squareup/okhttp/Request$Builder;->build()Lcom/squareup/okhttp/Request;

    move-result-object v3

    .line 68
    .local v3, "request":Lcom/squareup/okhttp/Request;
    :try_start_0
    invoke-virtual {v0, v3}, Lcom/squareup/okhttp/OkHttpClient;->newCall(Lcom/squareup/okhttp/Request;)Lcom/squareup/okhttp/Call;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/Call;->execute()Lcom/squareup/okhttp/Response;

    move-result-object v4

    .line 69
    .local v4, "response":Lcom/squareup/okhttp/Response;
    invoke-virtual {v4}, Lcom/squareup/okhttp/Response;->body()Lcom/squareup/okhttp/ResponseBody;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/ResponseBody;->string()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 74
    .end local v4    # "response":Lcom/squareup/okhttp/Response;
    :goto_0
    return-object v5

    .line 70
    :catch_0
    move-exception v1

    .line 71
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 74
    const/4 v5, 0x0

    goto :goto_0
.end method
