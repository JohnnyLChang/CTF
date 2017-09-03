.class public final Lcom/squareup/okhttp/ConnectionPool;
.super Ljava/lang/Object;
.source "ConnectionPool.java"


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static final DEFAULT_KEEP_ALIVE_DURATION_MS:J = 0x493e0L

.field private static final systemDefault:Lcom/squareup/okhttp/ConnectionPool;


# instance fields
.field private cleanupRunnable:Ljava/lang/Runnable;

.field private final connections:Ljava/util/Deque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Deque",
            "<",
            "Lcom/squareup/okhttp/internal/io/RealConnection;",
            ">;"
        }
    .end annotation
.end field

.field private final executor:Ljava/util/concurrent/Executor;

.field private final keepAliveDurationNs:J

.field private final maxIdleConnections:I

.field final routeDatabase:Lcom/squareup/okhttp/internal/RouteDatabase;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 58
    const-class v5, Lcom/squareup/okhttp/ConnectionPool;

    invoke-virtual {v5}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v5

    if-nez v5, :cond_0

    const/4 v5, 0x1

    :goto_0
    sput-boolean v5, Lcom/squareup/okhttp/ConnectionPool;->$assertionsDisabled:Z

    .line 64
    const-string v5, "http.keepAlive"

    invoke-static {v5}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 65
    .local v0, "keepAlive":Ljava/lang/String;
    const-string v5, "http.keepAliveDuration"

    invoke-static {v5}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 66
    .local v1, "keepAliveDuration":Ljava/lang/String;
    const-string v5, "http.maxConnections"

    invoke-static {v5}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 67
    .local v4, "maxIdleConnections":Ljava/lang/String;
    if-eqz v1, :cond_1

    .line 68
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    .line 70
    .local v2, "keepAliveDurationMs":J
    :goto_1
    if-eqz v0, :cond_2

    invoke-static {v0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 71
    new-instance v5, Lcom/squareup/okhttp/ConnectionPool;

    invoke-direct {v5, v6, v2, v3}, Lcom/squareup/okhttp/ConnectionPool;-><init>(IJ)V

    sput-object v5, Lcom/squareup/okhttp/ConnectionPool;->systemDefault:Lcom/squareup/okhttp/ConnectionPool;

    .line 77
    :goto_2
    return-void

    .end local v0    # "keepAlive":Ljava/lang/String;
    .end local v1    # "keepAliveDuration":Ljava/lang/String;
    .end local v2    # "keepAliveDurationMs":J
    .end local v4    # "maxIdleConnections":Ljava/lang/String;
    :cond_0
    move v5, v6

    .line 58
    goto :goto_0

    .line 68
    .restart local v0    # "keepAlive":Ljava/lang/String;
    .restart local v1    # "keepAliveDuration":Ljava/lang/String;
    .restart local v4    # "maxIdleConnections":Ljava/lang/String;
    :cond_1
    const-wide/32 v2, 0x493e0

    goto :goto_1

    .line 72
    .restart local v2    # "keepAliveDurationMs":J
    :cond_2
    if-eqz v4, :cond_3

    .line 73
    new-instance v5, Lcom/squareup/okhttp/ConnectionPool;

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v6

    invoke-direct {v5, v6, v2, v3}, Lcom/squareup/okhttp/ConnectionPool;-><init>(IJ)V

    sput-object v5, Lcom/squareup/okhttp/ConnectionPool;->systemDefault:Lcom/squareup/okhttp/ConnectionPool;

    goto :goto_2

    .line 75
    :cond_3
    new-instance v5, Lcom/squareup/okhttp/ConnectionPool;

    const/4 v6, 0x5

    invoke-direct {v5, v6, v2, v3}, Lcom/squareup/okhttp/ConnectionPool;-><init>(IJ)V

    sput-object v5, Lcom/squareup/okhttp/ConnectionPool;->systemDefault:Lcom/squareup/okhttp/ConnectionPool;

    goto :goto_2
.end method

.method public constructor <init>(IJ)V
    .locals 2
    .param p1, "maxIdleConnections"    # I
    .param p2, "keepAliveDurationMs"    # J

    .prologue
    .line 114
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/squareup/okhttp/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    .line 115
    return-void
.end method

.method public constructor <init>(IJLjava/util/concurrent/TimeUnit;)V
    .locals 10
    .param p1, "maxIdleConnections"    # I
    .param p2, "keepAliveDuration"    # J
    .param p4, "timeUnit"    # Ljava/util/concurrent/TimeUnit;

    .prologue
    const/4 v3, 0x1

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 84
    new-instance v1, Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 v2, 0x0

    const-wide/16 v4, 0x3c

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v7}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    const-string v0, "OkHttp ConnectionPool"

    .line 86
    invoke-static {v0, v3}, Lcom/squareup/okhttp/internal/Util;->threadFactory(Ljava/lang/String;Z)Ljava/util/concurrent/ThreadFactory;

    move-result-object v8

    invoke-direct/range {v1 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    iput-object v1, p0, Lcom/squareup/okhttp/ConnectionPool;->executor:Ljava/util/concurrent/Executor;

    .line 91
    new-instance v0, Lcom/squareup/okhttp/ConnectionPool$1;

    invoke-direct {v0, p0}, Lcom/squareup/okhttp/ConnectionPool$1;-><init>(Lcom/squareup/okhttp/ConnectionPool;)V

    iput-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->cleanupRunnable:Ljava/lang/Runnable;

    .line 110
    new-instance v0, Ljava/util/ArrayDeque;

    invoke-direct {v0}, Ljava/util/ArrayDeque;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    .line 111
    new-instance v0, Lcom/squareup/okhttp/internal/RouteDatabase;

    invoke-direct {v0}, Lcom/squareup/okhttp/internal/RouteDatabase;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->routeDatabase:Lcom/squareup/okhttp/internal/RouteDatabase;

    .line 118
    iput p1, p0, Lcom/squareup/okhttp/ConnectionPool;->maxIdleConnections:I

    .line 119
    invoke-virtual {p4, p2, p3}, Ljava/util/concurrent/TimeUnit;->toNanos(J)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/squareup/okhttp/ConnectionPool;->keepAliveDurationNs:J

    .line 122
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-gtz v0, :cond_0

    .line 123
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "keepAliveDuration <= 0: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 125
    :cond_0
    return-void
.end method

.method public static getDefault()Lcom/squareup/okhttp/ConnectionPool;
    .locals 1

    .prologue
    .line 128
    sget-object v0, Lcom/squareup/okhttp/ConnectionPool;->systemDefault:Lcom/squareup/okhttp/ConnectionPool;

    return-object v0
.end method

.method private pruneAndGetAllocationCount(Lcom/squareup/okhttp/internal/io/RealConnection;J)I
    .locals 6
    .param p1, "connection"    # Lcom/squareup/okhttp/internal/io/RealConnection;
    .param p2, "now"    # J

    .prologue
    .line 295
    iget-object v2, p1, Lcom/squareup/okhttp/internal/io/RealConnection;->allocations:Ljava/util/List;

    .line 296
    .local v2, "references":Ljava/util/List;, "Ljava/util/List<Ljava/lang/ref/Reference<Lcom/squareup/okhttp/internal/http/StreamAllocation;>;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_2

    .line 297
    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/Reference;

    .line 299
    .local v1, "reference":Ljava/lang/ref/Reference;, "Ljava/lang/ref/Reference<Lcom/squareup/okhttp/internal/http/StreamAllocation;>;"
    invoke-virtual {v1}, Ljava/lang/ref/Reference;->get()Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 300
    add-int/lit8 v0, v0, 0x1

    .line 301
    goto :goto_0

    .line 305
    :cond_1
    sget-object v3, Lcom/squareup/okhttp/internal/Internal;->logger:Ljava/util/logging/Logger;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "A connection to "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Lcom/squareup/okhttp/internal/io/RealConnection;->getRoute()Lcom/squareup/okhttp/Route;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/Route;->getAddress()Lcom/squareup/okhttp/Address;

    move-result-object v5

    invoke-virtual {v5}, Lcom/squareup/okhttp/Address;->url()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " was leaked. Did you forget to close a response body?"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 307
    invoke-interface {v2, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 308
    const/4 v3, 0x1

    iput-boolean v3, p1, Lcom/squareup/okhttp/internal/io/RealConnection;->noNewStreams:Z

    .line 311
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 312
    iget-wide v4, p0, Lcom/squareup/okhttp/ConnectionPool;->keepAliveDurationNs:J

    sub-long v4, p2, v4

    iput-wide v4, p1, Lcom/squareup/okhttp/internal/io/RealConnection;->idleAtNanos:J

    .line 313
    const/4 v3, 0x0

    .line 317
    .end local v1    # "reference":Ljava/lang/ref/Reference;, "Ljava/lang/ref/Reference<Lcom/squareup/okhttp/internal/http/StreamAllocation;>;"
    :goto_1
    return v3

    :cond_2
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    goto :goto_1
.end method


# virtual methods
.method cleanup(J)J
    .locals 13
    .param p1, "now"    # J

    .prologue
    .line 236
    const/4 v3, 0x0

    .line 237
    .local v3, "inUseConnectionCount":I
    const/4 v2, 0x0

    .line 238
    .local v2, "idleConnectionCount":I
    const/4 v6, 0x0

    .line 239
    .local v6, "longestIdleConnection":Lcom/squareup/okhttp/internal/io/RealConnection;
    const-wide/high16 v8, -0x8000000000000000L

    .line 242
    .local v8, "longestIdleDurationNs":J
    monitor-enter p0

    .line 243
    :try_start_0
    iget-object v7, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v7}, Ljava/util/Deque;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_2

    .line 244
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 247
    .local v0, "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    invoke-direct {p0, v0, p1, p2}, Lcom/squareup/okhttp/ConnectionPool;->pruneAndGetAllocationCount(Lcom/squareup/okhttp/internal/io/RealConnection;J)I

    move-result v7

    if-lez v7, :cond_1

    .line 248
    add-int/lit8 v3, v3, 0x1

    .line 249
    goto :goto_0

    .line 252
    :cond_1
    add-int/lit8 v2, v2, 0x1

    .line 255
    iget-wide v10, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->idleAtNanos:J

    sub-long v4, p1, v10

    .line 256
    .local v4, "idleDurationNs":J
    cmp-long v7, v4, v8

    if-lez v7, :cond_0

    .line 257
    move-wide v8, v4

    .line 258
    move-object v6, v0

    goto :goto_0

    .line 262
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    .end local v4    # "idleDurationNs":J
    :cond_2
    iget-wide v10, p0, Lcom/squareup/okhttp/ConnectionPool;->keepAliveDurationNs:J

    cmp-long v7, v8, v10

    if-gez v7, :cond_3

    iget v7, p0, Lcom/squareup/okhttp/ConnectionPool;->maxIdleConnections:I

    if-le v2, v7, :cond_4

    .line 266
    :cond_3
    iget-object v7, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v7, v6}, Ljava/util/Deque;->remove(Ljava/lang/Object;)Z

    .line 280
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 282
    invoke-virtual {v6}, Lcom/squareup/okhttp/internal/io/RealConnection;->getSocket()Ljava/net/Socket;

    move-result-object v7

    invoke-static {v7}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    .line 285
    const-wide/16 v10, 0x0

    :goto_1
    return-wide v10

    .line 268
    :cond_4
    if-lez v2, :cond_5

    .line 270
    :try_start_1
    iget-wide v10, p0, Lcom/squareup/okhttp/ConnectionPool;->keepAliveDurationNs:J

    sub-long/2addr v10, v8

    monitor-exit p0

    goto :goto_1

    .line 280
    .end local v1    # "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :catchall_0
    move-exception v7

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v7

    .line 272
    .restart local v1    # "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :cond_5
    if-lez v3, :cond_6

    .line 274
    :try_start_2
    iget-wide v10, p0, Lcom/squareup/okhttp/ConnectionPool;->keepAliveDurationNs:J

    monitor-exit p0

    goto :goto_1

    .line 278
    :cond_6
    const-wide/16 v10, -0x1

    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1
.end method

.method connectionBecameIdle(Lcom/squareup/okhttp/internal/io/RealConnection;)Z
    .locals 1
    .param p1, "connection"    # Lcom/squareup/okhttp/internal/io/RealConnection;

    .prologue
    .line 199
    sget-boolean v0, Lcom/squareup/okhttp/ConnectionPool;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 200
    :cond_0
    iget-boolean v0, p1, Lcom/squareup/okhttp/internal/io/RealConnection;->noNewStreams:Z

    if-nez v0, :cond_1

    iget v0, p0, Lcom/squareup/okhttp/ConnectionPool;->maxIdleConnections:I

    if-nez v0, :cond_2

    .line 201
    :cond_1
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v0, p1}, Ljava/util/Deque;->remove(Ljava/lang/Object;)Z

    .line 202
    const/4 v0, 0x1

    .line 205
    :goto_0
    return v0

    .line 204
    :cond_2
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    .line 205
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public evictAll()V
    .locals 5

    .prologue
    .line 211
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 212
    .local v1, "evictedConnections":Ljava/util/List;, "Ljava/util/List<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    monitor-enter p0

    .line 213
    :try_start_0
    iget-object v3, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v3}, Ljava/util/Deque;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 214
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 215
    .local v0, "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    iget-object v3, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->allocations:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 216
    const/4 v3, 0x1

    iput-boolean v3, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->noNewStreams:Z

    .line 217
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 218
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    .line 221
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    .end local v2    # "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :catchall_0
    move-exception v3

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    .restart local v2    # "i":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/squareup/okhttp/internal/io/RealConnection;>;"
    :cond_1
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 223
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 224
    .restart local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/io/RealConnection;->getSocket()Ljava/net/Socket;

    move-result-object v4

    invoke-static {v4}, Lcom/squareup/okhttp/internal/Util;->closeQuietly(Ljava/net/Socket;)V

    goto :goto_1

    .line 226
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    :cond_2
    return-void
.end method

.method get(Lcom/squareup/okhttp/Address;Lcom/squareup/okhttp/internal/http/StreamAllocation;)Lcom/squareup/okhttp/internal/io/RealConnection;
    .locals 4
    .param p1, "address"    # Lcom/squareup/okhttp/Address;
    .param p2, "streamAllocation"    # Lcom/squareup/okhttp/internal/http/StreamAllocation;

    .prologue
    .line 172
    sget-boolean v1, Lcom/squareup/okhttp/ConnectionPool;->$assertionsDisabled:Z

    if-nez v1, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1

    .line 173
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v1}, Ljava/util/Deque;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 176
    .local v0, "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    iget-object v2, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->allocations:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/io/RealConnection;->allocationLimit()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 177
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/io/RealConnection;->getRoute()Lcom/squareup/okhttp/Route;

    move-result-object v2

    iget-object v2, v2, Lcom/squareup/okhttp/Route;->address:Lcom/squareup/okhttp/Address;

    invoke-virtual {p1, v2}, Lcom/squareup/okhttp/Address;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-boolean v2, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->noNewStreams:Z

    if-nez v2, :cond_1

    .line 179
    invoke-virtual {p2, v0}, Lcom/squareup/okhttp/internal/http/StreamAllocation;->acquire(Lcom/squareup/okhttp/internal/io/RealConnection;)V

    .line 183
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    :goto_0
    return-object v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public declared-synchronized getConnectionCount()I
    .locals 1

    .prologue
    .line 147
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->size()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getHttpConnectionCount()I
    .locals 2

    .prologue
    .line 167
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->size()I

    move-result v0

    invoke-virtual {p0}, Lcom/squareup/okhttp/ConnectionPool;->getMultiplexedConnectionCount()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    sub-int/2addr v0, v1

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getIdleConnectionCount()I
    .locals 4

    .prologue
    .line 133
    monitor-enter p0

    const/4 v1, 0x0

    .line 134
    .local v1, "total":I
    :try_start_0
    iget-object v2, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v2}, Ljava/util/Deque;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 135
    .local v0, "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    iget-object v3, v0, Lcom/squareup/okhttp/internal/io/RealConnection;->allocations:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v3

    if-eqz v3, :cond_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 137
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    :cond_1
    monitor-exit p0

    return v1

    .line 133
    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2
.end method

.method public declared-synchronized getMultiplexedConnectionCount()I
    .locals 4

    .prologue
    .line 158
    monitor-enter p0

    const/4 v1, 0x0

    .line 159
    .local v1, "total":I
    :try_start_0
    iget-object v2, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v2}, Ljava/util/Deque;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/squareup/okhttp/internal/io/RealConnection;

    .line 160
    .local v0, "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    invoke-virtual {v0}, Lcom/squareup/okhttp/internal/io/RealConnection;->isMultiplexed()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v3

    if-eqz v3, :cond_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 162
    .end local v0    # "connection":Lcom/squareup/okhttp/internal/io/RealConnection;
    :cond_1
    monitor-exit p0

    return v1

    .line 158
    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2
.end method

.method public declared-synchronized getSpdyConnectionCount()I
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 153
    monitor-enter p0

    :try_start_0
    invoke-virtual {p0}, Lcom/squareup/okhttp/ConnectionPool;->getMultiplexedConnectionCount()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method put(Lcom/squareup/okhttp/internal/io/RealConnection;)V
    .locals 2
    .param p1, "connection"    # Lcom/squareup/okhttp/internal/io/RealConnection;

    .prologue
    .line 187
    sget-boolean v0, Lcom/squareup/okhttp/ConnectionPool;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 188
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 189
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->executor:Ljava/util/concurrent/Executor;

    iget-object v1, p0, Lcom/squareup/okhttp/ConnectionPool;->cleanupRunnable:Ljava/lang/Runnable;

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 191
    :cond_1
    iget-object v0, p0, Lcom/squareup/okhttp/ConnectionPool;->connections:Ljava/util/Deque;

    invoke-interface {v0, p1}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    .line 192
    return-void
.end method

.method setCleanupRunnableForTest(Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "cleanupRunnable"    # Ljava/lang/Runnable;

    .prologue
    .line 321
    iput-object p1, p0, Lcom/squareup/okhttp/ConnectionPool;->cleanupRunnable:Ljava/lang/Runnable;

    .line 322
    return-void
.end method
