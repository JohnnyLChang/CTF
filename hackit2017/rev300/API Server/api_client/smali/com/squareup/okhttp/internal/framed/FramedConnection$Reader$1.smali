.class Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;
.super Lcom/squareup/okhttp/internal/NamedRunnable;
.source "FramedConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->headers(ZZIILjava/util/List;Lcom/squareup/okhttp/internal/framed/HeadersMode;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

.field final synthetic val$newStream:Lcom/squareup/okhttp/internal/framed/FramedStream;


# direct methods
.method varargs constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;Ljava/lang/String;[Ljava/lang/Object;Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    .locals 0
    .param p1, "this$1"    # Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 672
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iput-object p4, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->val$newStream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-direct {p0, p2, p3}, Lcom/squareup/okhttp/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 5

    .prologue
    .line 675
    :try_start_0
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iget-object v1, v1, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->access$2000(Lcom/squareup/okhttp/internal/framed/FramedConnection;)Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;

    move-result-object v1

    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->val$newStream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v1, v2}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;->onStream(Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 683
    :goto_0
    return-void

    .line 676
    :catch_0
    move-exception v0

    .line 677
    .local v0, "e":Ljava/io/IOException;
    sget-object v1, Lcom/squareup/okhttp/internal/Internal;->logger:Ljava/util/logging/Logger;

    sget-object v2, Ljava/util/logging/Level;->INFO:Ljava/util/logging/Level;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "FramedConnection.Listener failure for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iget-object v4, v4, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-static {v4}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedConnection;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3, v0}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 679
    :try_start_1
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$1;->val$newStream:Lcom/squareup/okhttp/internal/framed/FramedStream;

    sget-object v2, Lcom/squareup/okhttp/internal/framed/ErrorCode;->PROTOCOL_ERROR:Lcom/squareup/okhttp/internal/framed/ErrorCode;

    invoke-virtual {v1, v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->close(Lcom/squareup/okhttp/internal/framed/ErrorCode;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 680
    :catch_1
    move-exception v1

    goto :goto_0
.end method
