.class Lanative/hackit2017/com/apiclient/MainActivity$2;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lanative/hackit2017/com/apiclient/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lanative/hackit2017/com/apiclient/MainActivity;


# direct methods
.method constructor <init>(Lanative/hackit2017/com/apiclient/MainActivity;)V
    .locals 0
    .param p1, "this$0"    # Lanative/hackit2017/com/apiclient/MainActivity;

    .prologue
    .line 32
    iput-object p1, p0, Lanative/hackit2017/com/apiclient/MainActivity$2;->this$0:Lanative/hackit2017/com/apiclient/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 36
    invoke-static {}, Lanative/hackit2017/com/apiclient/Api;->getInfo()V

    .line 38
    return-void
.end method
