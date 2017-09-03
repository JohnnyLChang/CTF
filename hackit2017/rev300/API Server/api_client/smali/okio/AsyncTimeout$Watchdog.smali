.class final Lokio/AsyncTimeout$Watchdog;
.super Ljava/lang/Thread;
.source "AsyncTimeout.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lokio/AsyncTimeout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Watchdog"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 279
    const-string v0, "Okio Watchdog"

    invoke-direct {p0, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    .line 280
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lokio/AsyncTimeout$Watchdog;->setDaemon(Z)V

    .line 281
    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 286
    :cond_0
    :goto_0
    :try_start_0
    invoke-static {}, Lokio/AsyncTimeout;->access$000()Lokio/AsyncTimeout;

    move-result-object v0

    .line 289
    .local v0, "timedOut":Lokio/AsyncTimeout;
    if-eqz v0, :cond_0

    .line 292
    invoke-virtual {v0}, Lokio/AsyncTimeout;->timedOut()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 293
    .end local v0    # "timedOut":Lokio/AsyncTimeout;
    :catch_0
    move-exception v1

    goto :goto_0
.end method
