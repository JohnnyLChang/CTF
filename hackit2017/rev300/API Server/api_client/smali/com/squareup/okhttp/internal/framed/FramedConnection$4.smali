.class Lcom/squareup/okhttp/internal/framed/FramedConnection$4;
.super Lcom/squareup/okhttp/internal/NamedRunnable;
.source "FramedConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/squareup/okhttp/internal/framed/FramedConnection;->pushRequestLater(ILjava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

.field final synthetic val$requestHeaders:Ljava/util/List;

.field final synthetic val$streamId:I


# direct methods
.method varargs constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedConnection;Ljava/lang/String;[Ljava/lang/Object;ILjava/util/List;)V
    .locals 0
    .param p1, "this$0"    # Lcom/squareup/okhttp/internal/framed/FramedConnection;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 843
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    iput p4, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$streamId:I

    iput-object p5, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$requestHeaders:Ljava/util/List;

    invoke-direct {p0, p2, p3}, Lcom/squareup/okhttp/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 4

    .prologue
    .line 845
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->access$2700(Lcom/squareup/okhttp/internal/framed/FramedConnection;)Lcom/squareup/okhttp/internal/framed/PushObserver;

    move-result-object v1

    iget v2, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$streamId:I

    iget-object v3, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$requestHeaders:Ljava/util/List;

    invoke-interface {v1, v2, v3}, Lcom/squareup/okhttp/internal/framed/PushObserver;->onRequest(ILjava/util/List;)Z

    move-result v0

    .line 847
    .local v0, "cancel":Z
    if-eqz v0, :cond_0

    .line 848
    :try_start_0
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    iget-object v1, v1, Lcom/squareup/okhttp/internal/framed/FramedConnection;->frameWriter:Lcom/squareup/okhttp/internal/framed/FrameWriter;

    iget v2, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$streamId:I

    sget-object v3, Lcom/squareup/okhttp/internal/framed/ErrorCode;->CANCEL:Lcom/squareup/okhttp/internal/framed/ErrorCode;

    invoke-interface {v1, v2, v3}, Lcom/squareup/okhttp/internal/framed/FrameWriter;->rstStream(ILcom/squareup/okhttp/internal/framed/ErrorCode;)V

    .line 849
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    monitor-enter v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 850
    :try_start_1
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->access$2800(Lcom/squareup/okhttp/internal/framed/FramedConnection;)Ljava/util/Set;

    move-result-object v1

    iget v3, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$4;->val$streamId:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 851
    monitor-exit v2

    .line 855
    :cond_0
    :goto_0
    return-void

    .line 851
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 853
    :catch_0
    move-exception v1

    goto :goto_0
.end method
