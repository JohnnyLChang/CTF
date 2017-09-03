.class Lanative/hackit2017/com/apiclient/MainActivity$1;
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
    .line 23
    iput-object p1, p0, Lanative/hackit2017/com/apiclient/MainActivity$1;->this$0:Lanative/hackit2017/com/apiclient/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 27
    iget-object v0, p0, Lanative/hackit2017/com/apiclient/MainActivity$1;->this$0:Lanative/hackit2017/com/apiclient/MainActivity;

    const v1, 0x7f0b005f

    invoke-virtual {v0, v1}, Lanative/hackit2017/com/apiclient/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanative/hackit2017/com/apiclient/Api;->register(Ljava/lang/String;)V

    .line 29
    return-void
.end method
