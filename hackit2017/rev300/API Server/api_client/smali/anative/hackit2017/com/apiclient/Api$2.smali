.class final Lanative/hackit2017/com/apiclient/Api$2;
.super Landroid/os/AsyncTask;
.source "Api.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lanative/hackit2017/com/apiclient/Api;->getInfo()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 37
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 37
    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lanative/hackit2017/com/apiclient/Api$2;->doInBackground([Ljava/lang/Void;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/String;
    .locals 3
    .param p1, "voids"    # [Ljava/lang/Void;

    .prologue
    .line 41
    new-instance v0, Lanative/hackit2017/com/apiclient/Client;

    const-string v1, "info"

    invoke-direct {v0, v1}, Lanative/hackit2017/com/apiclient/Client;-><init>(Ljava/lang/String;)V

    const-string v1, "personal_key"

    sget-object v2, Lanative/hackit2017/com/apiclient/MainActivity;->regKey:Ljava/lang/String;

    .line 42
    invoke-virtual {v0, v1, v2}, Lanative/hackit2017/com/apiclient/Client;->addPost(Ljava/lang/String;Ljava/lang/String;)Lanative/hackit2017/com/apiclient/Client;

    move-result-object v0

    .line 43
    invoke-virtual {v0}, Lanative/hackit2017/com/apiclient/Client;->send()Ljava/lang/String;

    move-result-object v0

    .line 41
    return-object v0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 37
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lanative/hackit2017/com/apiclient/Api$2;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/String;)V
    .locals 1
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 49
    const-string v0, "ServerAPI"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    const-string v0, "login_admin"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "ok"

    :goto_0
    invoke-static {v0}, Lanative/hackit2017/com/apiclient/MainActivity;->toast(Ljava/lang/String;)V

    .line 51
    return-void

    .line 50
    :cond_0
    const-string v0, "no"

    goto :goto_0
.end method
