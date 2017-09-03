.class public final Lcom/squareup/okhttp/internal/DiskLruCache$Editor;
.super Ljava/lang/Object;
.source "DiskLruCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/internal/DiskLruCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "Editor"
.end annotation


# instance fields
.field private committed:Z

.field private final entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

.field private hasErrors:Z

.field final synthetic this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

.field private final written:[Z


# direct methods
.method private constructor <init>(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)V
    .locals 1
    .param p1, "this$0"    # Lcom/squareup/okhttp/internal/DiskLruCache;
    .param p2, "entry"    # Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    .prologue
    .line 832
    iput-object p1, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 833
    iput-object p2, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    .line 834
    invoke-static {p2}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$800(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->written:[Z

    .line 835
    return-void

    .line 834
    :cond_0
    invoke-static {p1}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2300(Lcom/squareup/okhttp/internal/DiskLruCache;)I

    move-result v0

    new-array v0, v0, [Z

    goto :goto_0
.end method

.method synthetic constructor <init>(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Entry;Lcom/squareup/okhttp/internal/DiskLruCache$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/squareup/okhttp/internal/DiskLruCache;
    .param p2, "x1"    # Lcom/squareup/okhttp/internal/DiskLruCache$Entry;
    .param p3, "x2"    # Lcom/squareup/okhttp/internal/DiskLruCache$1;

    .prologue
    .line 826
    invoke-direct {p0, p1, p2}, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;-><init>(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)V

    return-void
.end method

.method static synthetic access$1700(Lcom/squareup/okhttp/internal/DiskLruCache$Editor;)Lcom/squareup/okhttp/internal/DiskLruCache$Entry;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/DiskLruCache$Editor;

    .prologue
    .line 826
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    return-object v0
.end method

.method static synthetic access$1800(Lcom/squareup/okhttp/internal/DiskLruCache$Editor;)[Z
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/DiskLruCache$Editor;

    .prologue
    .line 826
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->written:[Z

    return-object v0
.end method

.method static synthetic access$1902(Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/squareup/okhttp/internal/DiskLruCache$Editor;
    .param p1, "x1"    # Z

    .prologue
    .line 826
    iput-boolean p1, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->hasErrors:Z

    return p1
.end method


# virtual methods
.method public abort()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 910
    iget-object v1, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    monitor-enter v1

    .line 911
    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    const/4 v2, 0x0

    invoke-static {v0, p0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2600(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Z)V

    .line 912
    monitor-exit v1

    .line 913
    return-void

    .line 912
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public abortUnlessCommitted()V
    .locals 3

    .prologue
    .line 916
    iget-object v1, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    monitor-enter v1

    .line 917
    :try_start_0
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->committed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    .line 919
    :try_start_1
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    const/4 v2, 0x0

    invoke-static {v0, p0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2600(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Z)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 923
    :cond_0
    :goto_0
    :try_start_2
    monitor-exit v1

    .line 924
    return-void

    .line 923
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 920
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public commit()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 894
    iget-object v1, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    monitor-enter v1

    .line 895
    :try_start_0
    iget-boolean v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->hasErrors:Z

    if-eqz v0, :cond_0

    .line 896
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    const/4 v2, 0x0

    invoke-static {v0, p0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2600(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Z)V

    .line 897
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    iget-object v2, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2700(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Z

    .line 901
    :goto_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->committed:Z

    .line 902
    monitor-exit v1

    .line 903
    return-void

    .line 899
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    const/4 v2, 0x1

    invoke-static {v0, p0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2600(Lcom/squareup/okhttp/internal/DiskLruCache;Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Z)V

    goto :goto_0

    .line 902
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public newSink(I)Lokio/Sink;
    .locals 6
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 865
    iget-object v4, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    monitor-enter v4

    .line 866
    :try_start_0
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$900(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Lcom/squareup/okhttp/internal/DiskLruCache$Editor;

    move-result-object v3

    if-eq v3, p0, :cond_0

    .line 867
    new-instance v3, Ljava/lang/IllegalStateException;

    invoke-direct {v3}, Ljava/lang/IllegalStateException;-><init>()V

    throw v3

    .line 886
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3

    .line 869
    :cond_0
    :try_start_1
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$800(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 870
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->written:[Z

    const/4 v5, 0x1

    aput-boolean v5, v3, p1

    .line 872
    :cond_1
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$1400(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)[Ljava/io/File;

    move-result-object v3

    aget-object v0, v3, p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 875
    .local v0, "dirtyFile":Ljava/io/File;
    :try_start_2
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2400(Lcom/squareup/okhttp/internal/DiskLruCache;)Lcom/squareup/okhttp/internal/io/FileSystem;

    move-result-object v3

    invoke-interface {v3, v0}, Lcom/squareup/okhttp/internal/io/FileSystem;->sink(Ljava/io/File;)Lokio/Sink;
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v2

    .line 879
    .local v2, "sink":Lokio/Sink;
    :try_start_3
    new-instance v3, Lcom/squareup/okhttp/internal/DiskLruCache$Editor$1;

    invoke-direct {v3, p0, v2}, Lcom/squareup/okhttp/internal/DiskLruCache$Editor$1;-><init>(Lcom/squareup/okhttp/internal/DiskLruCache$Editor;Lokio/Sink;)V

    monitor-exit v4

    .end local v2    # "sink":Lokio/Sink;
    :goto_0
    return-object v3

    .line 876
    :catch_0
    move-exception v1

    .line 877
    .local v1, "e":Ljava/io/FileNotFoundException;
    invoke-static {}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2500()Lokio/Sink;

    move-result-object v3

    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method

.method public newSource(I)Lokio/Source;
    .locals 5
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 842
    iget-object v2, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    monitor-enter v2

    .line 843
    :try_start_0
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$900(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Lcom/squareup/okhttp/internal/DiskLruCache$Editor;

    move-result-object v3

    if-eq v3, p0, :cond_0

    .line 844
    new-instance v1, Ljava/lang/IllegalStateException;

    invoke-direct {v1}, Ljava/lang/IllegalStateException;-><init>()V

    throw v1

    .line 854
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 846
    :cond_0
    :try_start_1
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$800(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 847
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 852
    :goto_0
    return-object v1

    .line 850
    :cond_1
    :try_start_2
    iget-object v3, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->this$0:Lcom/squareup/okhttp/internal/DiskLruCache;

    invoke-static {v3}, Lcom/squareup/okhttp/internal/DiskLruCache;->access$2400(Lcom/squareup/okhttp/internal/DiskLruCache;)Lcom/squareup/okhttp/internal/io/FileSystem;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/internal/DiskLruCache$Editor;->entry:Lcom/squareup/okhttp/internal/DiskLruCache$Entry;

    invoke-static {v4}, Lcom/squareup/okhttp/internal/DiskLruCache$Entry;->access$1300(Lcom/squareup/okhttp/internal/DiskLruCache$Entry;)[Ljava/io/File;

    move-result-object v4

    aget-object v4, v4, p1

    invoke-interface {v3, v4}, Lcom/squareup/okhttp/internal/io/FileSystem;->source(Ljava/io/File;)Lokio/Source;
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v1

    :try_start_3
    monitor-exit v2

    goto :goto_0

    .line 851
    :catch_0
    move-exception v0

    .line 852
    .local v0, "e":Ljava/io/FileNotFoundException;
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method
