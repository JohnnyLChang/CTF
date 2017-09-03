.class final Lanative/hackit2017/com/apiclient/Api$1;
.super Landroid/os/AsyncTask;
.source "Api.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lanative/hackit2017/com/apiclient/Api;->register(Ljava/lang/String;)V
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


# instance fields
.field final synthetic val$name:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 13
    iput-object p1, p0, Lanative/hackit2017/com/apiclient/Api$1;->val$name:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 13
    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lanative/hackit2017/com/apiclient/Api$1;->doInBackground([Ljava/lang/Void;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/String;
    .locals 3
    .param p1, "voids"    # [Ljava/lang/Void;

    .prologue
    .line 17
    new-instance v0, Lanative/hackit2017/com/apiclient/Client;

    const-string v1, "register"

    invoke-direct {v0, v1}, Lanative/hackit2017/com/apiclient/Client;-><init>(Ljava/lang/String;)V

    const-string v1, "name"

    iget-object v2, p0, Lanative/hackit2017/com/apiclient/Api$1;->val$name:Ljava/lang/String;

    .line 18
    invoke-virtual {v0, v1, v2}, Lanative/hackit2017/com/apiclient/Client;->addPost(Ljava/lang/String;Ljava/lang/String;)Lanative/hackit2017/com/apiclient/Client;

    move-result-object v0

    .line 19
    invoke-virtual {v0}, Lanative/hackit2017/com/apiclient/Client;->send()Ljava/lang/String;

    move-result-object v0

    .line 17
    return-object v0
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 13
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lanative/hackit2017/com/apiclient/Api$1;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/String;)V
    .locals 2
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 25
    const-string v0, "personal_key="

    const-string v1, ""

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanative/hackit2017/com/apiclient/MainActivity;->regKey:Ljava/lang/String;

    .line 26
    const-string v0, "ServerAPI"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 27
    const-string v0, "personal_key"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "ok"

    :goto_0
    invoke-static {v0}, Lanative/hackit2017/com/apiclient/MainActivity;->toast(Ljava/lang/String;)V

    .line 28
    return-void

    .line 27
    :cond_0
    const-string v0, "no"

    goto :goto_0
.end method
