.class Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$2;
.super Lcom/squareup/okhttp/internal/NamedRunnable;
.source "FramedConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->settings(ZLcom/squareup/okhttp/internal/framed/Settings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;


# direct methods
.method varargs constructor <init>(Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "this$1"    # Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 733
    iput-object p1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$2;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    invoke-direct {p0, p2, p3}, Lcom/squareup/okhttp/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 2

    .prologue
    .line 735
    iget-object v0, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$2;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iget-object v0, v0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-static {v0}, Lcom/squareup/okhttp/internal/framed/FramedConnection;->access$2000(Lcom/squareup/okhttp/internal/framed/FramedConnection;)Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;

    move-result-object v0

    iget-object v1, p0, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader$2;->this$1:Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;

    iget-object v1, v1, Lcom/squareup/okhttp/internal/framed/FramedConnection$Reader;->this$0:Lcom/squareup/okhttp/internal/framed/FramedConnection;

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;->onSettings(Lcom/squareup/okhttp/internal/framed/FramedConnection;)V

    .line 736
    return-void
.end method
