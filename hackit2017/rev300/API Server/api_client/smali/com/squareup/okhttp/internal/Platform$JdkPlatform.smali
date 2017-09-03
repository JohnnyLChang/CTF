.class Lcom/squareup/okhttp/internal/Platform$JdkPlatform;
.super Lcom/squareup/okhttp/internal/Platform;
.source "Platform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/internal/Platform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "JdkPlatform"
.end annotation


# instance fields
.field private final sslContextClass:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 336
    .local p1, "sslContextClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-direct {p0}, Lcom/squareup/okhttp/internal/Platform;-><init>()V

    .line 337
    iput-object p1, p0, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;->sslContextClass:Ljava/lang/Class;

    .line 338
    return-void
.end method


# virtual methods
.method public trustManager(Ljavax/net/ssl/SSLSocketFactory;)Ljavax/net/ssl/X509TrustManager;
    .locals 3
    .param p1, "sslSocketFactory"    # Ljavax/net/ssl/SSLSocketFactory;

    .prologue
    .line 341
    iget-object v1, p0, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;->sslContextClass:Ljava/lang/Class;

    const-string v2, "context"

    invoke-static {p1, v1, v2}, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;->readFieldOrNull(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 342
    .local v0, "context":Ljava/lang/Object;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    .line 343
    :goto_0
    return-object v1

    :cond_0
    const-class v1, Ljavax/net/ssl/X509TrustManager;

    const-string v2, "trustManager"

    invoke-static {v0, v1, v2}, Lcom/squareup/okhttp/internal/Platform$JdkPlatform;->readFieldOrNull(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljavax/net/ssl/X509TrustManager;

    goto :goto_0
.end method
