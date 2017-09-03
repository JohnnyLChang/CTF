.class final Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;
.super Ljava/lang/Object;
.source "FramedStream.java"

# interfaces
.implements Lokio/Sink;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/internal/framed/FramedStream;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x10
    name = "FramedDataSink"
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static final EMIT_BUFFER_SIZE:J = 0x4000L


# instance fields
.field private closed:Z

.field private finished:Z

.field private final sendBuffer:Lokio/Buffer;

.field final synthetic this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 470
    const-class v0, Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    .locals 1
    .param p1, "this$0"    # Lcom/squareup/okhttp/internal/framed/FramedStream;

    .prologue
    .line 470
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 477
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    return-void
.end method

.method static synthetic access$200(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;)Z
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;

    .prologue
    .line 470
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->finished:Z

    return v0
.end method

.method static synthetic access$202(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;
    .param p1, "x1"    # Z

    .prologue
    .line 470
    iput-boolean p1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->finished:Z

    return p1
.end method

.method static synthetic access$400(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;)Z
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;

    .prologue
    .line 470
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->closed:Z

    return v0
.end method

.method private emitDataFrame(Z)V
    .locals 8
    .param p1, "outFinished"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 501
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v1

    .line 502
    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->enter()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 504
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v2, v0, Lcom/squareup/okhttp/internal/framed/FramedStream;->bytesLeftInWriteWindow:J

    const-wide/16 v6, 0x0

    cmp-long v0, v2, v6

    if-gtz v0, :cond_0

    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->finished:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->closed:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$800(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/ErrorCode;

    move-result-object v0

    if-nez v0, :cond_0

    .line 505
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$900(Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 508
    :catchall_0
    move-exception v0

    :try_start_2
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v2

    invoke-virtual {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    throw v0

    .line 514
    :catchall_1
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v0

    .line 508
    :cond_0
    :try_start_3
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    .line 511
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1200(Lcom/squareup/okhttp/internal/framed/FramedStream;)V

    .line 512
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v2, v0, Lcom/squareup/okhttp/internal/framed/FramedStream;->bytesLeftInWriteWindow:J

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v6

    invoke-static {v2, v3, v6, v7}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    .line 513
    .local v4, "toWrite":J
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v2, v0, Lcom/squareup/okhttp/internal/framed/FramedStream;->bytesLeftInWriteWindow:J

    sub-long/2addr v2, v4

    iput-wide v2, v0, Lcom/squareup/okhttp/internal/framed/FramedStream;->bytesLeftInWriteWindow:J

    .line 514
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 516
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->enter()V

    .line 518
    :try_start_4
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$600(Lcom/squareup/okhttp/internal/framed/FramedStream;)I

    move-result v1

    if-eqz p1, :cond_1

    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v2}, Lokio/Buffer;->size()J

    move-result-wide v2

    cmp-long v2, v4, v2

    if-nez v2, :cond_1

    const/4 v2, 0x1

    :goto_1
    iget-object v3, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual/range {v0 .. v5}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->writeData(IZLokio/Buffer;J)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 520
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    .line 522
    return-void

    .line 518
    :cond_1
    const/4 v2, 0x0

    goto :goto_1

    .line 520
    :catchall_2
    move-exception v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v4, 0x0

    const/4 v2, 0x1

    .line 540
    sget-boolean v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 541
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v1

    .line 542
    :try_start_0
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->closed:Z

    if-eqz v0, :cond_1

    monitor-exit v1

    .line 560
    :goto_0
    return-void

    .line 543
    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 544
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-object v0, v0, Lcom/squareup/okhttp/internal/framed/FramedStream;->sink:Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;

    iget-boolean v0, v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->finished:Z

    if-nez v0, :cond_3

    .line 546
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v0

    cmp-long v0, v0, v4

    if-lez v0, :cond_2

    .line 547
    :goto_1
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v0

    cmp-long v0, v0, v4

    if-lez v0, :cond_3

    .line 548
    invoke-direct {p0, v2}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->emitDataFrame(Z)V

    goto :goto_1

    .line 543
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 552
    :cond_2
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$600(Lcom/squareup/okhttp/internal/framed/FramedStream;)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual/range {v0 .. v5}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->writeData(IZLokio/Buffer;J)V

    .line 555
    :cond_3
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v1

    .line 556
    const/4 v0, 0x1

    :try_start_2
    iput-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->closed:Z

    .line 557
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 558
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->flush()V

    .line 559
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1000(Lcom/squareup/okhttp/internal/framed/FramedStream;)V

    goto :goto_0

    .line 557
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0
.end method

.method public flush()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 525
    sget-boolean v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 526
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v1

    .line 527
    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1200(Lcom/squareup/okhttp/internal/framed/FramedStream;)V

    .line 528
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 529
    :goto_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    .line 530
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->emitDataFrame(Z)V

    .line 531
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->flush()V

    goto :goto_0

    .line 528
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 533
    :cond_1
    return-void
.end method

.method public timeout()Lokio/Timeout;
    .locals 1

    .prologue
    .line 536
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1100(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    return-object v0
.end method

.method public write(Lokio/Buffer;J)V
    .locals 4
    .param p1, "source"    # Lokio/Buffer;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 488
    sget-boolean v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 489
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0, p1, p2, p3}, Lokio/Buffer;->write(Lokio/Buffer;J)V

    .line 490
    :goto_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->sendBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v0

    const-wide/16 v2, 0x4000

    cmp-long v0, v0, v2

    if-ltz v0, :cond_1

    .line 491
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSink;->emitDataFrame(Z)V

    goto :goto_0

    .line 493
    :cond_1
    return-void
.end method
