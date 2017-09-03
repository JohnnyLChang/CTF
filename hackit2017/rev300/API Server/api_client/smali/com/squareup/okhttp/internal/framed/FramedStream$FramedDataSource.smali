.class final Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;
.super Ljava/lang/Object;
.source "FramedStream.java"

# interfaces
.implements Lokio/Source;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/internal/framed/FramedStream;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "FramedDataSource"
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private closed:Z

.field private finished:Z

.field private final maxByteCount:J

.field private final readBuffer:Lokio/Buffer;

.field private final receiveBuffer:Lokio/Buffer;

.field final synthetic this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 314
    const-class v0, Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedStream;J)V
    .locals 2
    .param p2, "maxByteCount"    # J

    .prologue
    .line 333
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 316
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->receiveBuffer:Lokio/Buffer;

    .line 319
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    .line 334
    iput-wide p2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->maxByteCount:J

    .line 335
    return-void
.end method

.method synthetic constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedStream;JLcom/squareup/okhttp/internal/framed/FramedStream$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream;
    .param p2, "x1"    # J
    .param p4, "x2"    # Lcom/squareup/okhttp/internal/framed/FramedStream$1;

    .prologue
    .line 314
    invoke-direct {p0, p1, p2, p3}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;-><init>(Lcom/squareup/okhttp/internal/framed/FramedStream;J)V

    return-void
.end method

.method static synthetic access$100(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;)Z
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;

    .prologue
    .line 314
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->finished:Z

    return v0
.end method

.method static synthetic access$102(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;
    .param p1, "x1"    # Z

    .prologue
    .line 314
    iput-boolean p1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->finished:Z

    return p1
.end method

.method static synthetic access$300(Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;)Z
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;

    .prologue
    .line 314
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->closed:Z

    return v0
.end method

.method private checkNotClosed()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 438
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->closed:Z

    if-eqz v0, :cond_0

    .line 439
    new-instance v0, Ljava/io/IOException;

    const-string v1, "stream closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 441
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$800(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/ErrorCode;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 442
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stream was reset: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$800(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/ErrorCode;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 444
    :cond_1
    return-void
.end method

.method private waitUntilReadable()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 374
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$700(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->enter()V

    .line 376
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->finished:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->closed:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$800(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/ErrorCode;

    move-result-object v0

    if-nez v0, :cond_0

    .line 377
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$900(Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 380
    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$700(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v1

    invoke-virtual {v1}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    throw v0

    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$700(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;->exitAndThrowIfTimedOut()V

    .line 382
    return-void
.end method


# virtual methods
.method public close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 429
    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v1

    .line 430
    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->closed:Z

    .line 431
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->clear()V

    .line 432
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 433
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 434
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$1000(Lcom/squareup/okhttp/internal/framed/FramedStream;)V

    .line 435
    return-void

    .line 433
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public read(Lokio/Buffer;J)J
    .locals 8
    .param p1, "sink"    # Lokio/Buffer;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v6, 0x0

    .line 339
    cmp-long v2, p2, v6

    if-gez v2, :cond_0

    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "byteCount < 0: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 342
    :cond_0
    iget-object v3, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v3

    .line 343
    :try_start_0
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->waitUntilReadable()V

    .line 344
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->checkNotClosed()V

    .line 345
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v2}, Lokio/Buffer;->size()J

    move-result-wide v4

    cmp-long v2, v4, v6

    if-nez v2, :cond_1

    const-wide/16 v0, -0x1

    monitor-exit v3

    .line 369
    :goto_0
    return-wide v0

    .line 348
    :cond_1
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    iget-object v4, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v4}, Lokio/Buffer;->size()J

    move-result-wide v4

    invoke-static {p2, p3, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    invoke-virtual {v2, p1, v4, v5}, Lokio/Buffer;->read(Lokio/Buffer;J)J

    move-result-wide v0

    .line 351
    .local v0, "read":J
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedStream;->unacknowledgedBytesRead:J

    add-long/2addr v4, v0

    iput-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedStream;->unacknowledgedBytesRead:J

    .line 352
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedStream;->unacknowledgedBytesRead:J

    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    .line 353
    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    iget-object v2, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->okHttpSettings:Lcom/squareup/okhttp/internal/framed/Settings;

    const/high16 v6, 0x10000

    invoke-virtual {v2, v6}, Lcom/squareup/okhttp/internal/framed/Settings;->getInitialWindowSize(I)I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-ltz v2, :cond_2

    .line 354
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    iget-object v4, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v4}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$600(Lcom/squareup/okhttp/internal/framed/FramedStream;)I

    move-result v4

    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    iget-wide v6, v5, Lcom/squareup/okhttp/internal/framed/FramedStream;->unacknowledgedBytesRead:J

    invoke-virtual {v2, v4, v6, v7}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->writeWindowUpdateLater(IJ)V

    .line 355
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    const-wide/16 v4, 0x0

    iput-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedStream;->unacknowledgedBytesRead:J

    .line 357
    :cond_2
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 360
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v3

    monitor-enter v3

    .line 361
    :try_start_1
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    iget-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->unacknowledgedBytesRead:J

    add-long/2addr v4, v0

    iput-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->unacknowledgedBytesRead:J

    .line 362
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    iget-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->unacknowledgedBytesRead:J

    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    .line 363
    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    iget-object v2, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->okHttpSettings:Lcom/squareup/okhttp/internal/framed/Settings;

    const/high16 v6, 0x10000

    invoke-virtual {v2, v6}, Lcom/squareup/okhttp/internal/framed/Settings;->getInitialWindowSize(I)I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    int-to-long v6, v2

    cmp-long v2, v4, v6

    if-ltz v2, :cond_3

    .line 364
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v5}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v5

    iget-wide v6, v5, Lcom/squareup/okhttp/internal/framed/FramedConnection;->unacknowledgedBytesRead:J

    invoke-virtual {v2, v4, v6, v7}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->writeWindowUpdateLater(IJ)V

    .line 365
    iget-object v2, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v2}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$500(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedConnection;

    move-result-object v2

    const-wide/16 v4, 0x0

    iput-wide v4, v2, Lcom/squareup/okhttp/internal/framed/FramedConnection;->unacknowledgedBytesRead:J

    .line 367
    :cond_3
    monitor-exit v3

    goto/16 :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2

    .line 357
    .end local v0    # "read":J
    :catchall_1
    move-exception v2

    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v2
.end method

.method receive(Lokio/BufferedSource;J)V
    .locals 12
    .param p1, "in"    # Lokio/BufferedSource;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 385
    sget-boolean v5, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->$assertionsDisabled:Z

    if-nez v5, :cond_2

    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v5}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    new-instance v5, Ljava/lang/AssertionError;

    invoke-direct {v5}, Ljava/lang/AssertionError;-><init>()V

    throw v5

    .line 411
    .local v0, "finished":Z
    .local v1, "flowControlError":Z
    .local v2, "read":J
    :cond_0
    sub-long/2addr p2, v2

    .line 414
    iget-object v6, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v6

    .line 415
    :try_start_0
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v5}, Lokio/Buffer;->size()J

    move-result-wide v8

    const-wide/16 v10, 0x0

    cmp-long v5, v8, v10

    if-nez v5, :cond_7

    const/4 v4, 0x1

    .line 416
    .local v4, "wasEmpty":Z
    :goto_0
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    iget-object v7, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->receiveBuffer:Lokio/Buffer;

    invoke-virtual {v5, v7}, Lokio/Buffer;->writeAll(Lokio/Source;)J

    .line 417
    if-eqz v4, :cond_1

    .line 418
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-virtual {v5}, Ljava/lang/Object;->notifyAll()V

    .line 420
    :cond_1
    monitor-exit v6
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 387
    .end local v0    # "finished":Z
    .end local v1    # "flowControlError":Z
    .end local v2    # "read":J
    .end local v4    # "wasEmpty":Z
    :cond_2
    const-wide/16 v6, 0x0

    cmp-long v5, p2, v6

    if-lez v5, :cond_3

    .line 390
    iget-object v6, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    monitor-enter v6

    .line 391
    :try_start_1
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->finished:Z

    .line 392
    .restart local v0    # "finished":Z
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v5}, Lokio/Buffer;->size()J

    move-result-wide v8

    add-long/2addr v8, p2

    iget-wide v10, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->maxByteCount:J

    cmp-long v5, v8, v10

    if-lez v5, :cond_4

    const/4 v1, 0x1

    .line 393
    .restart local v1    # "flowControlError":Z
    :goto_1
    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 396
    if-eqz v1, :cond_5

    .line 397
    invoke-interface {p1, p2, p3}, Lokio/BufferedSource;->skip(J)V

    .line 398
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    sget-object v6, Lcom/squareup/okhttp/internal/framed/ErrorCode;->FLOW_CONTROL_ERROR:Lcom/squareup/okhttp/internal/framed/ErrorCode;

    invoke-virtual {v5, v6}, Lcom/squareup/okhttp/internal/framed/FramedStream;->closeLater(Lcom/squareup/okhttp/internal/framed/ErrorCode;)V

    .line 422
    .end local v0    # "finished":Z
    .end local v1    # "flowControlError":Z
    :cond_3
    :goto_2
    return-void

    .line 392
    .restart local v0    # "finished":Z
    :cond_4
    const/4 v1, 0x0

    goto :goto_1

    .line 393
    .end local v0    # "finished":Z
    :catchall_0
    move-exception v5

    :try_start_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v5

    .line 403
    .restart local v0    # "finished":Z
    .restart local v1    # "flowControlError":Z
    :cond_5
    if-eqz v0, :cond_6

    .line 404
    invoke-interface {p1, p2, p3}, Lokio/BufferedSource;->skip(J)V

    goto :goto_2

    .line 409
    :cond_6
    iget-object v5, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->receiveBuffer:Lokio/Buffer;

    invoke-interface {p1, v5, p2, p3}, Lokio/BufferedSource;->read(Lokio/Buffer;J)J

    move-result-wide v2

    .line 410
    .restart local v2    # "read":J
    const-wide/16 v6, -0x1

    cmp-long v5, v2, v6

    if-nez v5, :cond_0

    new-instance v5, Ljava/io/EOFException;

    invoke-direct {v5}, Ljava/io/EOFException;-><init>()V

    throw v5

    .line 415
    :cond_7
    const/4 v4, 0x0

    goto :goto_0

    .line 420
    :catchall_1
    move-exception v5

    :try_start_3
    monitor-exit v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v5
.end method

.method public timeout()Lokio/Timeout;
    .locals 1

    .prologue
    .line 425
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedStream$FramedDataSource;->this$0:Lcom/squareup/okhttp/internal/framed/FramedStream;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->access$700(Lcom/squareup/okhttp/internal/framed/FramedStream;)Lcom/squareup/okhttp/internal/framed/FramedStream$StreamTimeout;

    move-result-object v0

    return-object v0
.end method
