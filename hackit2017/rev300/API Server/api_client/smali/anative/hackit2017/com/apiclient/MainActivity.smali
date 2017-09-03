.class public Lanative/hackit2017/com/apiclient/MainActivity;
.super Landroid/support/v7/app/AppCompatActivity;
.source "MainActivity.java"


# static fields
.field public static INSTANCE:Lanative/hackit2017/com/apiclient/MainActivity;

.field public static regKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 12
    sput-object v0, Lanative/hackit2017/com/apiclient/MainActivity;->INSTANCE:Lanative/hackit2017/com/apiclient/MainActivity;

    .line 13
    sput-object v0, Lanative/hackit2017/com/apiclient/MainActivity;->regKey:Ljava/lang/String;

    .line 53
    const-string v0, "signatures"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 54
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 10
    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method public static native signature([B)[B
.end method

.method public static toast(Ljava/lang/String;)V
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 48
    sget-object v0, Lanative/hackit2017/com/apiclient/MainActivity;->INSTANCE:Lanative/hackit2017/com/apiclient/MainActivity;

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 49
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 17
    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 18
    const v0, 0x7f04001b

    invoke-virtual {p0, v0}, Lanative/hackit2017/com/apiclient/MainActivity;->setContentView(I)V

    .line 19
    sput-object p0, Lanative/hackit2017/com/apiclient/MainActivity;->INSTANCE:Lanative/hackit2017/com/apiclient/MainActivity;

    .line 23
    const v0, 0x7f0b005e

    invoke-virtual {p0, v0}, Lanative/hackit2017/com/apiclient/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lanative/hackit2017/com/apiclient/MainActivity$1;

    invoke-direct {v1, p0}, Lanative/hackit2017/com/apiclient/MainActivity$1;-><init>(Lanative/hackit2017/com/apiclient/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    const v0, 0x7f0b0060

    invoke-virtual {p0, v0}, Lanative/hackit2017/com/apiclient/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lanative/hackit2017/com/apiclient/MainActivity$2;

    invoke-direct {v1, p0}, Lanative/hackit2017/com/apiclient/MainActivity$2;-><init>(Lanative/hackit2017/com/apiclient/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 40
    return-void
.end method
