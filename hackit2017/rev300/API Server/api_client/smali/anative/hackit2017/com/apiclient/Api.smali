.class public Lanative/hackit2017/com/apiclient/Api;
.super Ljava/lang/Object;
.source "Api.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInfo()V
    .locals 2

    .prologue
    .line 37
    new-instance v0, Lanative/hackit2017/com/apiclient/Api$2;

    invoke-direct {v0}, Lanative/hackit2017/com/apiclient/Api$2;-><init>()V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    .line 52
    invoke-virtual {v0, v1}, Lanative/hackit2017/com/apiclient/Api$2;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 54
    return-void
.end method

.method public static register(Ljava/lang/String;)V
    .locals 2
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 13
    new-instance v0, Lanative/hackit2017/com/apiclient/Api$1;

    invoke-direct {v0, p0}, Lanative/hackit2017/com/apiclient/Api$1;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    .line 29
    invoke-virtual {v0, v1}, Lanative/hackit2017/com/apiclient/Api$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 31
    return-void
.end method
