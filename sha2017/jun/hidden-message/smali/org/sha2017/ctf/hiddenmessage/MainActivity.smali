.class public Lorg/sha2017/ctf/hiddenmessage/MainActivity;
.super Landroid/support/v7/app/AppCompatActivity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Landroid/support/v7/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 10
    invoke-super {p0, p1}, Landroid/support/v7/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 11
    const v1, 0x7f04001b

    invoke-virtual {p0, v1}, Lorg/sha2017/ctf/hiddenmessage/MainActivity;->setContentView(I)V

    .line 13
    const-string v0, "The hidden message can be found in strings.xml"

    .line 14
    .local v0, "hidden":Ljava/lang/String;
    return-void
.end method
