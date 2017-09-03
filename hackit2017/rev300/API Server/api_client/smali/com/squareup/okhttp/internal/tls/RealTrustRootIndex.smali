.class public final Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;
.super Ljava/lang/Object;
.source "RealTrustRootIndex.java"

# interfaces
.implements Lcom/squareup/okhttp/internal/tls/TrustRootIndex;


# instance fields
.field private final subjectToCaCerts:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljavax/security/auth/x500/X500Principal;",
            "Ljava/util/List",
            "<",
            "Ljava/security/cert/X509Certificate;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method public varargs constructor <init>([Ljava/security/cert/X509Certificate;)V
    .locals 6
    .param p1, "caCerts"    # [Ljava/security/cert/X509Certificate;

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    new-instance v3, Ljava/util/LinkedHashMap;

    invoke-direct {v3}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v3, p0, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;->subjectToCaCerts:Ljava/util/Map;

    .line 31
    array-length v4, p1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v4, :cond_1

    aget-object v0, p1, v3

    .line 32
    .local v0, "caCert":Ljava/security/cert/X509Certificate;
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getSubjectX500Principal()Ljavax/security/auth/x500/X500Principal;

    move-result-object v1

    .line 33
    .local v1, "subject":Ljavax/security/auth/x500/X500Principal;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;->subjectToCaCerts:Ljava/util/Map;

    invoke-interface {v5, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    .line 34
    .local v2, "subjectCaCerts":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/X509Certificate;>;"
    if-nez v2, :cond_0

    .line 35
    new-instance v2, Ljava/util/ArrayList;

    .end local v2    # "subjectCaCerts":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/X509Certificate;>;"
    const/4 v5, 0x1

    invoke-direct {v2, v5}, Ljava/util/ArrayList;-><init>(I)V

    .line 36
    .restart local v2    # "subjectCaCerts":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/X509Certificate;>;"
    iget-object v5, p0, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;->subjectToCaCerts:Ljava/util/Map;

    invoke-interface {v5, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 38
    :cond_0
    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 31
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 40
    .end local v0    # "caCert":Ljava/security/cert/X509Certificate;
    .end local v1    # "subject":Ljavax/security/auth/x500/X500Principal;
    .end local v2    # "subjectCaCerts":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/X509Certificate;>;"
    :cond_1
    return-void
.end method


# virtual methods
.method public findByIssuerAndSignature(Ljava/security/cert/X509Certificate;)Ljava/security/cert/X509Certificate;
    .locals 7
    .param p1, "cert"    # Ljava/security/cert/X509Certificate;

    .prologue
    const/4 v4, 0x0

    .line 43
    invoke-virtual {p1}, Ljava/security/cert/X509Certificate;->getIssuerX500Principal()Ljavax/security/auth/x500/X500Principal;

    move-result-object v1

    .line 44
    .local v1, "issuer":Ljavax/security/auth/x500/X500Principal;
    iget-object v5, p0, Lcom/squareup/okhttp/internal/tls/RealTrustRootIndex;->subjectToCaCerts:Ljava/util/Map;

    invoke-interface {v5, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    .line 45
    .local v3, "subjectCaCerts":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/X509Certificate;>;"
    if-nez v3, :cond_0

    move-object v0, v4

    .line 56
    :goto_0
    return-object v0

    .line 47
    :cond_0
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/security/cert/X509Certificate;

    .line 48
    .local v0, "caCert":Ljava/security/cert/X509Certificate;
    invoke-virtual {v0}, Ljava/security/cert/X509Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v2

    .line 50
    .local v2, "publicKey":Ljava/security/PublicKey;
    :try_start_0
    invoke-virtual {p1, v2}, Ljava/security/cert/X509Certificate;->verify(Ljava/security/PublicKey;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 52
    :catch_0
    move-exception v6

    goto :goto_1

    .end local v0    # "caCert":Ljava/security/cert/X509Certificate;
    .end local v2    # "publicKey":Ljava/security/PublicKey;
    :cond_1
    move-object v0, v4

    .line 56
    goto :goto_0
.end method
