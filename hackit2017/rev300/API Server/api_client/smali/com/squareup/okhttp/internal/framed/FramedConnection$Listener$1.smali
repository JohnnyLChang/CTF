.class final Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener$1;
.super Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;
.source "FramedConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 916
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/framed/FramedConnection$Listener;-><init>()V

    return-void
.end method


# virtual methods
.method public onStream(Lcom/squareup/okhttp/internal/framed/FramedStream;)V
    .locals 1
    .param p1, "stream"    # Lcom/squareup/okhttp/internal/framed/FramedStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 918
    sget-object v0, Lcom/squareup/okhttp/internal/framed/ErrorCode;->REFUSED_STREAM:Lcom/squareup/okhttp/internal/framed/ErrorCode;

    invoke-virtual {p1, v0}, Lcom/squareup/okhttp/internal/framed/FramedStream;->close(Lcom/squareup/okhttp/internal/framed/ErrorCode;)V

    .line 919
    return-void
.end method
