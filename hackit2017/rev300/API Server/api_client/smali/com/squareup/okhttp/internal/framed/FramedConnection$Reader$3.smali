.class Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$3;
.super Lcom/squareup/okhttp/internal/NamedRunnable;
.source "FramedConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->ackSettingsLater(Lcom/squareup/okhttp/internal/framed/Settings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

.field final synthetic val$peerSettings:Lcom/squareup/okhttp/internal/framed/Settings;


# direct methods
.method varargs constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;Ljava/lang/String;[Ljava/lang/Object;Lcom/squareup/okhttp/internal/framed/Settings;)V
    .locals 0
    .param p1, "this$1"    # Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 749
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$3;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iput-object p4, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$3;->val$peerSettings:Lcom/squareup/okhttp/internal/framed/Settings;

    invoke-direct {p0, p2, p3}, Lcom/squareup/okhttp/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 2

    .prologue
    .line 752
    :try_start_0
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$3;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iget-object v0, v0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    iget-object v0, v0, Lcom/squareup/okhttp/internal/framed/FramedConnection;->frameWriter:Lcom/squareup/okhttp/internal/framed/FrameWriter;

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$3;->val$peerSettings:Lcom/squareup/okhttp/internal/framed/Settings;

    invoke-interface {v0, v1}, Lcom/squareup/okhttp/internal/framed/FrameWriter;->ackSettings(Lcom/squareup/okhttp/internal/framed/Settings;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 755
    :goto_0
    return-void

    .line 753
    :catch_0
    move-exception v0

    goto :goto_0
.end method
