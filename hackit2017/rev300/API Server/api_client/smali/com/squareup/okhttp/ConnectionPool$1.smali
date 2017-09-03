.class Lcom/squareup/okhttp/ConnectionPool$1;
.super Ljava/lang/Object;
.source "ConnectionPool.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/ConnectionPool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/squareup/okhttp/ConnectionPool;


# direct methods
.method constructor <init>(Lcom/squareup/okhttp/ConnectionPool;)V
    .locals 0
    .param p1, "this$0"    # Lcom/squareup/okhttp/ConnectionPool;

    .prologue
    .line 91
    iput-object p1, p0, Lcom/squareup/okhttp/ConnectionPool$1;->this$0:Lcom/squareup/okhttp/ConnectionPool;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    .prologue
    const-wide/32 v8, 0xf4240

    .line 94
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/squareup/okhttp/ConnectionPool$1;->this$0:Lcom/squareup/okhttp/ConnectionPool;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Lcom/squareup/okhttp/ConnectionPool;->cleanup(J)J

    move-result-wide v2

    .line 95
    .local v2, "waitNanos":J
    const-wide/16 v4, -0x1

    cmp-long v4, v2, v4

    if-nez v4, :cond_1

    return-void

    .line 96
    :cond_1
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-lez v4, :cond_0

    .line 97
    div-long v0, v2, v8

    .line 98
    .local v0, "waitMillis":J
    mul-long v4, v0, v8

    sub-long/2addr v2, v4

    .line 99
    iget-object v5, p0, Lcom/squareup/okhttp/ConnectionPool$1;->this$0:Lcom/squareup/okhttp/ConnectionPool;

    monitor-enter v5

    .line 101
    :try_start_0
    iget-object v4, p0, Lcom/squareup/okhttp/ConnectionPool$1;->this$0:Lcom/squareup/okhttp/ConnectionPool;

    long-to-int v6, v2

    invoke-virtual {v4, v0, v1, v6}, Ljava/lang/Object;->wait(JI)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 104
    :goto_1
    :try_start_1
    monitor-exit v5

    goto :goto_0

    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v4

    .line 102
    :catch_0
    move-exception v4

    goto :goto_1
.end method
