.class public final Lcom/squareup/okhttp/HttpUrl;
.super Ljava/lang/Object;
.source "HttpUrl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/squareup/okhttp/HttpUrl$Builder;
    }
.end annotation


# static fields
.field static final FORM_ENCODE_SET:Ljava/lang/String; = " \"\':;<=>@[]^`{}|/\\?#&!$(),~"

.field static final FRAGMENT_ENCODE_SET:Ljava/lang/String; = ""

.field static final FRAGMENT_ENCODE_SET_URI:Ljava/lang/String; = " \"#<>\\^`{|}"

.field private static final HEX_DIGITS:[C

.field static final PASSWORD_ENCODE_SET:Ljava/lang/String; = " \"\':;<=>@[]^`{}|/\\?#"

.field static final PATH_SEGMENT_ENCODE_SET:Ljava/lang/String; = " \"<>^`{}|/\\?#"

.field static final PATH_SEGMENT_ENCODE_SET_URI:Ljava/lang/String; = "[]"

.field static final QUERY_COMPONENT_ENCODE_SET:Ljava/lang/String; = " \"\'<>#&="

.field static final QUERY_COMPONENT_ENCODE_SET_URI:Ljava/lang/String; = "\\^`{|}"

.field static final QUERY_ENCODE_SET:Ljava/lang/String; = " \"\'<>#"

.field static final USERNAME_ENCODE_SET:Ljava/lang/String; = " \"\':;<=>@[]^`{}|/\\?#"


# instance fields
.field private final fragment:Ljava/lang/String;

.field private final host:Ljava/lang/String;

.field private final password:Ljava/lang/String;

.field private final pathSegments:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final port:I

.field private final queryNamesAndValues:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final scheme:Ljava/lang/String;

.field private final url:Ljava/lang/String;

.field private final username:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 256
    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/squareup/okhttp/HttpUrl;->HEX_DIGITS:[C

    return-void

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method private constructor <init>(Lcom/squareup/okhttp/HttpUrl$Builder;)V
    .locals 4
    .param p1, "builder"    # Lcom/squareup/okhttp/HttpUrl$Builder;

    .prologue
    const/4 v1, 0x0

    const/4 v3, 0x0

    .line 304
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 305
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    .line 306
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    invoke-static {v0, v3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->username:Ljava/lang/String;

    .line 307
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    invoke-static {v0, v3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->password:Ljava/lang/String;

    .line 308
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->host:Ljava/lang/String;

    .line 309
    invoke-virtual {p1}, Lcom/squareup/okhttp/HttpUrl$Builder;->effectivePort()I

    move-result v0

    iput v0, p0, Lcom/squareup/okhttp/HttpUrl;->port:I

    .line 310
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-direct {p0, v0, v3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/util/List;Z)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->pathSegments:Ljava/util/List;

    .line 311
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    const/4 v2, 0x1

    .line 312
    invoke-direct {p0, v0, v2}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/util/List;Z)Ljava/util/List;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    .line 314
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 315
    invoke-static {v0, v3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v1

    :cond_0
    iput-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->fragment:Ljava/lang/String;

    .line 317
    invoke-virtual {p1}, Lcom/squareup/okhttp/HttpUrl$Builder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    .line 318
    return-void

    :cond_1
    move-object v0, v1

    .line 312
    goto :goto_0
.end method

.method synthetic constructor <init>(Lcom/squareup/okhttp/HttpUrl$Builder;Lcom/squareup/okhttp/HttpUrl$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/squareup/okhttp/HttpUrl$Builder;
    .param p2, "x1"    # Lcom/squareup/okhttp/HttpUrl$1;

    .prologue
    .line 255
    invoke-direct {p0, p1}, Lcom/squareup/okhttp/HttpUrl;-><init>(Lcom/squareup/okhttp/HttpUrl$Builder;)V

    return-void
.end method

.method static synthetic access$100(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/HttpUrl;

    .prologue
    .line 255
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Ljava/lang/String;IILjava/lang/String;)I
    .locals 1
    .param p0, "x0"    # Ljava/lang/String;
    .param p1, "x1"    # I
    .param p2, "x2"    # I
    .param p3, "x3"    # Ljava/lang/String;

    .prologue
    .line 255
    invoke-static {p0, p1, p2, p3}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$300(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/HttpUrl;

    .prologue
    .line 255
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->host:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$400(Lcom/squareup/okhttp/HttpUrl;)I
    .locals 1
    .param p0, "x0"    # Lcom/squareup/okhttp/HttpUrl;

    .prologue
    .line 255
    iget v0, p0, Lcom/squareup/okhttp/HttpUrl;->port:I

    return v0
.end method

.method static canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;
    .locals 9
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I
    .param p3, "encodeSet"    # Ljava/lang/String;
    .param p4, "alreadyEncoded"    # Z
    .param p5, "plusIsSpace"    # Z
    .param p6, "asciiOnly"    # Z

    .prologue
    .line 1551
    move v2, p1

    .local v2, "i":I
    :goto_0
    if-ge v2, p2, :cond_4

    .line 1552
    invoke-virtual {p0, v2}, Ljava/lang/String;->codePointAt(I)I

    move-result v8

    .line 1553
    .local v8, "codePoint":I
    const/16 v1, 0x20

    if-lt v8, v1, :cond_2

    const/16 v1, 0x7f

    if-eq v8, v1, :cond_2

    const/16 v1, 0x80

    if-lt v8, v1, :cond_0

    if-nez p6, :cond_2

    .line 1556
    :cond_0
    invoke-virtual {p3, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    const/4 v3, -0x1

    if-ne v1, v3, :cond_2

    const/16 v1, 0x25

    if-ne v8, v1, :cond_1

    if-eqz p4, :cond_2

    :cond_1
    const/16 v1, 0x2b

    if-ne v8, v1, :cond_3

    if-eqz p5, :cond_3

    .line 1560
    :cond_2
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    .line 1561
    .local v0, "out":Lokio/Buffer;
    invoke-virtual {v0, p0, p1, v2}, Lokio/Buffer;->writeUtf8(Ljava/lang/String;II)Lokio/Buffer;

    move-object v1, p0

    move v3, p2

    move-object v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    .line 1562
    invoke-static/range {v0 .. v7}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Lokio/Buffer;Ljava/lang/String;IILjava/lang/String;ZZZ)V

    .line 1563
    invoke-virtual {v0}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v1

    .line 1568
    .end local v0    # "out":Lokio/Buffer;
    .end local v8    # "codePoint":I
    :goto_1
    return-object v1

    .line 1551
    .restart local v8    # "codePoint":I
    :cond_3
    invoke-static {v8}, Ljava/lang/Character;->charCount(I)I

    move-result v1

    add-int/2addr v2, v1

    goto :goto_0

    .line 1568
    .end local v8    # "codePoint":I
    :cond_4
    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    goto :goto_1
.end method

.method static canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;
    .locals 7
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "encodeSet"    # Ljava/lang/String;
    .param p2, "alreadyEncoded"    # Z
    .param p3, "plusIsSpace"    # Z
    .param p4, "asciiOnly"    # Z

    .prologue
    .line 1608
    const/4 v1, 0x0

    .line 1609
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    move-object v0, p0

    move-object v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    .line 1608
    invoke-static/range {v0 .. v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static canonicalize(Lokio/Buffer;Ljava/lang/String;IILjava/lang/String;ZZZ)V
    .locals 7
    .param p0, "out"    # Lokio/Buffer;
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I
    .param p4, "encodeSet"    # Ljava/lang/String;
    .param p5, "alreadyEncoded"    # Z
    .param p6, "plusIsSpace"    # Z
    .param p7, "asciiOnly"    # Z

    .prologue
    const/16 v6, 0x25

    .line 1573
    const/4 v3, 0x0

    .line 1575
    .local v3, "utf8Buffer":Lokio/Buffer;
    move v2, p2

    .local v2, "i":I
    :goto_0
    if-ge v2, p3, :cond_8

    .line 1576
    invoke-virtual {p1, v2}, Ljava/lang/String;->codePointAt(I)I

    move-result v1

    .line 1577
    .local v1, "codePoint":I
    if-eqz p5, :cond_1

    const/16 v4, 0x9

    if-eq v1, v4, :cond_0

    const/16 v4, 0xa

    if-eq v1, v4, :cond_0

    const/16 v4, 0xc

    if-eq v1, v4, :cond_0

    const/16 v4, 0xd

    if-ne v1, v4, :cond_1

    .line 1575
    :cond_0
    :goto_1
    invoke-static {v1}, Ljava/lang/Character;->charCount(I)I

    move-result v4

    add-int/2addr v2, v4

    goto :goto_0

    .line 1580
    :cond_1
    const/16 v4, 0x2b

    if-ne v1, v4, :cond_3

    if-eqz p6, :cond_3

    .line 1582
    if-eqz p5, :cond_2

    const-string v4, "+"

    :goto_2
    invoke-virtual {p0, v4}, Lokio/Buffer;->writeUtf8(Ljava/lang/String;)Lokio/Buffer;

    goto :goto_1

    :cond_2
    const-string v4, "%2B"

    goto :goto_2

    .line 1583
    :cond_3
    const/16 v4, 0x20

    if-lt v1, v4, :cond_5

    const/16 v4, 0x7f

    if-eq v1, v4, :cond_5

    const/16 v4, 0x80

    if-lt v1, v4, :cond_4

    if-nez p7, :cond_5

    .line 1586
    :cond_4
    invoke-virtual {p4, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    const/4 v5, -0x1

    if-ne v4, v5, :cond_5

    if-ne v1, v6, :cond_7

    if-nez p5, :cond_7

    .line 1589
    :cond_5
    if-nez v3, :cond_6

    .line 1590
    new-instance v3, Lokio/Buffer;

    .end local v3    # "utf8Buffer":Lokio/Buffer;
    invoke-direct {v3}, Lokio/Buffer;-><init>()V

    .line 1592
    .restart local v3    # "utf8Buffer":Lokio/Buffer;
    :cond_6
    invoke-virtual {v3, v1}, Lokio/Buffer;->writeUtf8CodePoint(I)Lokio/Buffer;

    .line 1593
    :goto_3
    invoke-virtual {v3}, Lokio/Buffer;->exhausted()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1594
    invoke-virtual {v3}, Lokio/Buffer;->readByte()B

    move-result v4

    and-int/lit16 v0, v4, 0xff

    .line 1595
    .local v0, "b":I
    invoke-virtual {p0, v6}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 1596
    sget-object v4, Lcom/squareup/okhttp/HttpUrl;->HEX_DIGITS:[C

    shr-int/lit8 v5, v0, 0x4

    and-int/lit8 v5, v5, 0xf

    aget-char v4, v4, v5

    invoke-virtual {p0, v4}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 1597
    sget-object v4, Lcom/squareup/okhttp/HttpUrl;->HEX_DIGITS:[C

    and-int/lit8 v5, v0, 0xf

    aget-char v4, v4, v5

    invoke-virtual {p0, v4}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    goto :goto_3

    .line 1601
    .end local v0    # "b":I
    :cond_7
    invoke-virtual {p0, v1}, Lokio/Buffer;->writeUtf8CodePoint(I)Lokio/Buffer;

    goto :goto_1

    .line 1604
    .end local v1    # "codePoint":I
    :cond_8
    return-void
.end method

.method static decodeHexDigit(C)I
    .locals 1
    .param p0, "c"    # C

    .prologue
    .line 1527
    const/16 v0, 0x30

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    add-int/lit8 v0, p0, -0x30

    .line 1530
    :goto_0
    return v0

    .line 1528
    :cond_0
    const/16 v0, 0x61

    if-lt p0, v0, :cond_1

    const/16 v0, 0x66

    if-gt p0, v0, :cond_1

    add-int/lit8 v0, p0, -0x61

    add-int/lit8 v0, v0, 0xa

    goto :goto_0

    .line 1529
    :cond_1
    const/16 v0, 0x41

    if-lt p0, v0, :cond_2

    const/16 v0, 0x46

    if-gt p0, v0, :cond_2

    add-int/lit8 v0, p0, -0x41

    add-int/lit8 v0, v0, 0xa

    goto :goto_0

    .line 1530
    :cond_2
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public static defaultPort(Ljava/lang/String;)I
    .locals 1
    .param p0, "scheme"    # Ljava/lang/String;

    .prologue
    .line 408
    const-string v0, "http"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 409
    const/16 v0, 0x50

    .line 413
    :goto_0
    return v0

    .line 410
    :cond_0
    const-string v0, "https"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 411
    const/16 v0, 0x1bb

    goto :goto_0

    .line 413
    :cond_1
    const/4 v0, -0x1

    goto :goto_0
.end method

.method private static delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I
    .locals 3
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I
    .param p3, "delimiters"    # Ljava/lang/String;

    .prologue
    .line 1472
    move v0, p1

    .local v0, "i":I
    :goto_0
    if-ge v0, p2, :cond_1

    .line 1473
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-virtual {p3, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 1475
    .end local v0    # "i":I
    :goto_1
    return v0

    .line 1472
    .restart local v0    # "i":I
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, p2

    .line 1475
    goto :goto_1
.end method

.method public static get(Ljava/net/URI;)Lcom/squareup/okhttp/HttpUrl;
    .locals 1
    .param p0, "uri"    # Ljava/net/URI;

    .prologue
    .line 632
    invoke-virtual {p0}, Ljava/net/URI;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl;->parse(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;

    move-result-object v0

    return-object v0
.end method

.method public static get(Ljava/net/URL;)Lcom/squareup/okhttp/HttpUrl;
    .locals 1
    .param p0, "url"    # Ljava/net/URL;

    .prologue
    .line 605
    invoke-virtual {p0}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl;->parse(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;

    move-result-object v0

    return-object v0
.end method

.method static getChecked(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;
    .locals 5
    .param p0, "url"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/MalformedURLException;,
            Ljava/net/UnknownHostException;
        }
    .end annotation

    .prologue
    .line 616
    new-instance v0, Lcom/squareup/okhttp/HttpUrl$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;-><init>()V

    .line 617
    .local v0, "builder":Lcom/squareup/okhttp/HttpUrl$Builder;
    const/4 v2, 0x0

    invoke-virtual {v0, v2, p0}, Lcom/squareup/okhttp/HttpUrl$Builder;->parse(Lcom/squareup/okhttp/HttpUrl;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    move-result-object v1

    .line 618
    .local v1, "result":Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;
    sget-object v2, Lcom/squareup/okhttp/HttpUrl$1;->$SwitchMap$com$squareup$okhttp$HttpUrl$Builder$ParseResult:[I

    invoke-virtual {v1}, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 627
    new-instance v2, Ljava/net/MalformedURLException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid URL: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/MalformedURLException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 620
    :pswitch_0
    invoke-virtual {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->build()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v2

    return-object v2

    .line 622
    :pswitch_1
    new-instance v2, Ljava/net/UnknownHostException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid host: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/UnknownHostException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 618
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method static namesAndValuesToQueryString(Ljava/lang/StringBuilder;Ljava/util/List;)V
    .locals 5
    .param p0, "out"    # Ljava/lang/StringBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/StringBuilder;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 468
    .local p1, "namesAndValues":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "size":I
    :goto_0
    if-ge v0, v2, :cond_2

    .line 469
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 470
    .local v1, "name":Ljava/lang/String;
    add-int/lit8 v4, v0, 0x1

    invoke-interface {p1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 471
    .local v3, "value":Ljava/lang/String;
    if-lez v0, :cond_0

    const/16 v4, 0x26

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 472
    :cond_0
    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 473
    if-eqz v3, :cond_1

    .line 474
    const/16 v4, 0x3d

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 475
    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 468
    :cond_1
    add-int/lit8 v0, v0, 0x2

    goto :goto_0

    .line 478
    .end local v1    # "name":Ljava/lang/String;
    .end local v3    # "value":Ljava/lang/String;
    :cond_2
    return-void
.end method

.method public static parse(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;
    .locals 4
    .param p0, "url"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 595
    new-instance v0, Lcom/squareup/okhttp/HttpUrl$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;-><init>()V

    .line 596
    .local v0, "builder":Lcom/squareup/okhttp/HttpUrl$Builder;
    invoke-virtual {v0, v2, p0}, Lcom/squareup/okhttp/HttpUrl$Builder;->parse(Lcom/squareup/okhttp/HttpUrl;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    move-result-object v1

    .line 597
    .local v1, "result":Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;
    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->SUCCESS:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    if-ne v1, v3, :cond_0

    invoke-virtual {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->build()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v2

    :cond_0
    return-object v2
.end method

.method static pathSegmentsToString(Ljava/lang/StringBuilder;Ljava/util/List;)V
    .locals 3
    .param p0, "out"    # Ljava/lang/StringBuilder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/StringBuilder;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 432
    .local p1, "pathSegments":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    .local v1, "size":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 433
    const/16 v2, 0x2f

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 434
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 432
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 436
    :cond_0
    return-void
.end method

.method static percentDecode(Ljava/lang/String;IIZ)Ljava/lang/String;
    .locals 4
    .param p0, "encoded"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I
    .param p3, "plusIsSpace"    # Z

    .prologue
    .line 1491
    move v1, p1

    .local v1, "i":I
    :goto_0
    if-ge v1, p2, :cond_2

    .line 1492
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 1493
    .local v0, "c":C
    const/16 v3, 0x25

    if-eq v0, v3, :cond_0

    const/16 v3, 0x2b

    if-ne v0, v3, :cond_1

    if-eqz p3, :cond_1

    .line 1495
    :cond_0
    new-instance v2, Lokio/Buffer;

    invoke-direct {v2}, Lokio/Buffer;-><init>()V

    .line 1496
    .local v2, "out":Lokio/Buffer;
    invoke-virtual {v2, p0, p1, v1}, Lokio/Buffer;->writeUtf8(Ljava/lang/String;II)Lokio/Buffer;

    .line 1497
    invoke-static {v2, p0, v1, p2, p3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Lokio/Buffer;Ljava/lang/String;IIZ)V

    .line 1498
    invoke-virtual {v2}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v3

    .line 1503
    .end local v0    # "c":C
    .end local v2    # "out":Lokio/Buffer;
    :goto_1
    return-object v3

    .line 1491
    .restart local v0    # "c":C
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1503
    .end local v0    # "c":C
    :cond_2
    invoke-virtual {p0, p1, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    goto :goto_1
.end method

.method static percentDecode(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 2
    .param p0, "encoded"    # Ljava/lang/String;
    .param p1, "plusIsSpace"    # Z

    .prologue
    .line 1479
    const/4 v0, 0x0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {p0, v0, v1, p1}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;IIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private percentDecode(Ljava/util/List;Z)Ljava/util/List;
    .locals 4
    .param p2, "plusIsSpace"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;Z)",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1483
    .local p1, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 1484
    .local v0, "result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1485
    .local v1, "s":Ljava/lang/String;
    if-eqz v1, :cond_0

    invoke-static {v1, p2}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    :goto_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    goto :goto_1

    .line 1487
    .end local v1    # "s":Ljava/lang/String;
    :cond_1
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    return-object v2
.end method

.method static percentDecode(Lokio/Buffer;Ljava/lang/String;IIZ)V
    .locals 6
    .param p0, "out"    # Lokio/Buffer;
    .param p1, "encoded"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I
    .param p4, "plusIsSpace"    # Z

    .prologue
    const/4 v5, -0x1

    .line 1508
    move v3, p2

    .local v3, "i":I
    :goto_0
    if-ge v3, p3, :cond_2

    .line 1509
    invoke-virtual {p1, v3}, Ljava/lang/String;->codePointAt(I)I

    move-result v0

    .line 1510
    .local v0, "codePoint":I
    const/16 v4, 0x25

    if-ne v0, v4, :cond_0

    add-int/lit8 v4, v3, 0x2

    if-ge v4, p3, :cond_0

    .line 1511
    add-int/lit8 v4, v3, 0x1

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/squareup/okhttp/HttpUrl;->decodeHexDigit(C)I

    move-result v1

    .line 1512
    .local v1, "d1":I
    add-int/lit8 v4, v3, 0x2

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Lcom/squareup/okhttp/HttpUrl;->decodeHexDigit(C)I

    move-result v2

    .line 1513
    .local v2, "d2":I
    if-eq v1, v5, :cond_1

    if-eq v2, v5, :cond_1

    .line 1514
    shl-int/lit8 v4, v1, 0x4

    add-int/2addr v4, v2

    invoke-virtual {p0, v4}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 1515
    add-int/lit8 v3, v3, 0x2

    .line 1508
    .end local v1    # "d1":I
    .end local v2    # "d2":I
    :goto_1
    invoke-static {v0}, Ljava/lang/Character;->charCount(I)I

    move-result v4

    add-int/2addr v3, v4

    goto :goto_0

    .line 1518
    :cond_0
    const/16 v4, 0x2b

    if-ne v0, v4, :cond_1

    if-eqz p4, :cond_1

    .line 1519
    const/16 v4, 0x20

    invoke-virtual {p0, v4}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    goto :goto_1

    .line 1522
    :cond_1
    invoke-virtual {p0, v0}, Lokio/Buffer;->writeUtf8CodePoint(I)Lokio/Buffer;

    goto :goto_1

    .line 1524
    .end local v0    # "codePoint":I
    :cond_2
    return-void
.end method

.method static queryStringToNamesAndValues(Ljava/lang/String;)Ljava/util/List;
    .locals 6
    .param p0, "encodedQuery"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v5, -0x1

    .line 487
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 488
    .local v3, "result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v2, 0x0

    .local v2, "pos":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-gt v2, v4, :cond_3

    .line 489
    const/16 v4, 0x26

    invoke-virtual {p0, v4, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 490
    .local v0, "ampersandOffset":I
    if-ne v0, v5, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 492
    :cond_0
    const/16 v4, 0x3d

    invoke-virtual {p0, v4, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 493
    .local v1, "equalsOffset":I
    if-eq v1, v5, :cond_1

    if-le v1, v0, :cond_2

    .line 494
    :cond_1
    invoke-virtual {p0, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 495
    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 500
    :goto_1
    add-int/lit8 v2, v0, 0x1

    .line 501
    goto :goto_0

    .line 497
    :cond_2
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 498
    add-int/lit8 v4, v1, 0x1

    invoke-virtual {p0, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 502
    .end local v0    # "ampersandOffset":I
    .end local v1    # "equalsOffset":I
    :cond_3
    return-object v3
.end method


# virtual methods
.method public encodedFragment()Ljava/lang/String;
    .locals 3

    .prologue
    .line 559
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->fragment:Ljava/lang/String;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    .line 561
    :goto_0
    return-object v1

    .line 560
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v2, 0x23

    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    add-int/lit8 v0, v1, 0x1

    .line 561
    .local v0, "fragmentStart":I
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method public encodedPassword()Ljava/lang/String;
    .locals 5

    .prologue
    .line 369
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->password:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, ""

    .line 372
    :goto_0
    return-object v2

    .line 370
    :cond_0
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v3, 0x3a

    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, 0x3

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    add-int/lit8 v1, v2, 0x1

    .line 371
    .local v1, "passwordStart":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v3, 0x40

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 372
    .local v0, "passwordEnd":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method public encodedPath()Ljava/lang/String;
    .locals 5

    .prologue
    .line 426
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v3, 0x2f

    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, 0x3

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->indexOf(II)I

    move-result v1

    .line 427
    .local v1, "pathStart":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    const-string v4, "?#"

    invoke-static {v2, v1, v3, v4}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v0

    .line 428
    .local v0, "pathEnd":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public encodedPathSegments()Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 439
    iget-object v5, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v6, 0x2f

    iget-object v7, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, 0x3

    invoke-virtual {v5, v6, v7}, Ljava/lang/String;->indexOf(II)I

    move-result v2

    .line 440
    .local v2, "pathStart":I
    iget-object v5, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    iget-object v6, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    const-string v7, "?#"

    invoke-static {v5, v2, v6, v7}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v1

    .line 441
    .local v1, "pathEnd":I
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 442
    .local v3, "result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    move v0, v2

    .local v0, "i":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 443
    add-int/lit8 v0, v0, 0x1

    .line 444
    iget-object v5, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const-string v6, "/"

    invoke-static {v5, v0, v1, v6}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v4

    .line 445
    .local v4, "segmentEnd":I
    iget-object v5, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v5, v0, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 446
    move v0, v4

    .line 447
    goto :goto_0

    .line 448
    .end local v4    # "segmentEnd":I
    :cond_0
    return-object v3
.end method

.method public encodedQuery()Ljava/lang/String;
    .locals 6

    .prologue
    .line 461
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-nez v2, :cond_0

    const/4 v2, 0x0

    .line 464
    :goto_0
    return-object v2

    .line 462
    :cond_0
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    const/16 v3, 0x3f

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    add-int/lit8 v1, v2, 0x1

    .line 463
    .local v1, "queryStart":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    add-int/lit8 v3, v1, 0x1

    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    const-string v5, "#"

    invoke-static {v2, v3, v4, v5}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v0

    .line 464
    .local v0, "queryEnd":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method public encodedUsername()Ljava/lang/String;
    .locals 5

    .prologue
    .line 357
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->username:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, ""

    .line 360
    :goto_0
    return-object v2

    .line 358
    :cond_0
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v1, v2, 0x3

    .line 359
    .local v1, "usernameStart":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    const-string v4, ":@"

    invoke-static {v2, v1, v3, v4}, Lcom/squareup/okhttp/HttpUrl;->delimiterOffset(Ljava/lang/String;IILjava/lang/String;)I

    move-result v0

    .line 360
    .local v0, "usernameEnd":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v2, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 2
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    .line 636
    instance-of v0, p1, Lcom/squareup/okhttp/HttpUrl;

    if-eqz v0, :cond_0

    check-cast p1, Lcom/squareup/okhttp/HttpUrl;

    .end local p1    # "o":Ljava/lang/Object;
    iget-object v0, p1, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public fragment()Ljava/lang/String;
    .locals 1

    .prologue
    .line 565
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->fragment:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .prologue
    .line 640
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public host()Ljava/lang/String;
    .locals 1

    .prologue
    .line 391
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->host:Ljava/lang/String;

    return-object v0
.end method

.method public isHttps()Z
    .locals 2

    .prologue
    .line 352
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    const-string v1, "https"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public newBuilder()Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3

    .prologue
    .line 576
    new-instance v0, Lcom/squareup/okhttp/HttpUrl$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;-><init>()V

    .line 577
    .local v0, "result":Lcom/squareup/okhttp/HttpUrl$Builder;
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    iput-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    .line 578
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->encodedUsername()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 579
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->encodedPassword()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 580
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->host:Ljava/lang/String;

    iput-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    .line 582
    iget v1, p0, Lcom/squareup/okhttp/HttpUrl;->port:I

    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    invoke-static {v2}, Lcom/squareup/okhttp/HttpUrl;->defaultPort(Ljava/lang/String;)I

    move-result v2

    if-eq v1, v2, :cond_0

    iget v1, p0, Lcom/squareup/okhttp/HttpUrl;->port:I

    :goto_0
    iput v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 583
    iget-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 584
    iget-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->encodedPathSegments()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 585
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->encodedQuery()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQuery(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    .line 586
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->encodedFragment()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 587
    return-object v0

    .line 582
    :cond_0
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public password()Ljava/lang/String;
    .locals 1

    .prologue
    .line 377
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->password:Ljava/lang/String;

    return-object v0
.end method

.method public pathSegments()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 452
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->pathSegments:Ljava/util/List;

    return-object v0
.end method

.method public pathSize()I
    .locals 1

    .prologue
    .line 418
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->pathSegments:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public port()I
    .locals 1

    .prologue
    .line 400
    iget v0, p0, Lcom/squareup/okhttp/HttpUrl;->port:I

    return v0
.end method

.method public query()Ljava/lang/String;
    .locals 2

    .prologue
    .line 506
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    .line 509
    :goto_0
    return-object v1

    .line 507
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 508
    .local v0, "result":Ljava/lang/StringBuilder;
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-static {v0, v1}, Lcom/squareup/okhttp/HttpUrl;->namesAndValuesToQueryString(Ljava/lang/StringBuilder;Ljava/util/List;)V

    .line 509
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method public queryParameter(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 521
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-nez v3, :cond_1

    .line 527
    :cond_0
    :goto_0
    return-object v2

    .line 522
    :cond_1
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    .local v1, "size":I
    :goto_1
    if-ge v0, v1, :cond_0

    .line 523
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 524
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    add-int/lit8 v3, v0, 0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    goto :goto_0

    .line 522
    :cond_2
    add-int/lit8 v0, v0, 0x2

    goto :goto_1
.end method

.method public queryParameterName(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .prologue
    .line 551
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    mul-int/lit8 v1, p1, 0x2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public queryParameterNames()Ljava/util/Set;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 531
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-nez v3, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v3

    .line 536
    :goto_0
    return-object v3

    .line 532
    :cond_0
    new-instance v1, Ljava/util/LinkedHashSet;

    invoke-direct {v1}, Ljava/util/LinkedHashSet;-><init>()V

    .line 533
    .local v1, "result":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "size":I
    :goto_1
    if-ge v0, v2, :cond_1

    .line 534
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 533
    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    .line 536
    :cond_1
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v3

    goto :goto_0
.end method

.method public queryParameterValue(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .prologue
    .line 555
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    mul-int/lit8 v1, p1, 0x2

    add-int/lit8 v1, v1, 0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public queryParameterValues(Ljava/lang/String;)Ljava/util/List;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 540
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-nez v3, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v3

    .line 547
    :goto_0
    return-object v3

    .line 541
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 542
    .local v1, "result":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "size":I
    :goto_1
    if-ge v0, v2, :cond_2

    .line 543
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 544
    iget-object v3, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    add-int/lit8 v4, v0, 0x1

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 542
    :cond_1
    add-int/lit8 v0, v0, 0x2

    goto :goto_1

    .line 547
    :cond_2
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v3

    goto :goto_0
.end method

.method public querySize()I
    .locals 1

    .prologue
    .line 513
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->queryNamesAndValues:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public resolve(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl;
    .locals 3
    .param p1, "link"    # Ljava/lang/String;

    .prologue
    .line 570
    new-instance v0, Lcom/squareup/okhttp/HttpUrl$Builder;

    invoke-direct {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;-><init>()V

    .line 571
    .local v0, "builder":Lcom/squareup/okhttp/HttpUrl$Builder;
    invoke-virtual {v0, p0, p1}, Lcom/squareup/okhttp/HttpUrl$Builder;->parse(Lcom/squareup/okhttp/HttpUrl;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    move-result-object v1

    .line 572
    .local v1, "result":Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;
    sget-object v2, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->SUCCESS:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    if-ne v1, v2, :cond_0

    invoke-virtual {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->build()Lcom/squareup/okhttp/HttpUrl;

    move-result-object v2

    :goto_0
    return-object v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public scheme()Ljava/lang/String;
    .locals 1

    .prologue
    .line 348
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->scheme:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 644
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    return-object v0
.end method

.method public uri()Ljava/net/URI;
    .locals 5

    .prologue
    .line 339
    :try_start_0
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl;->newBuilder()Lcom/squareup/okhttp/HttpUrl$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/squareup/okhttp/HttpUrl$Builder;->reencodeForUri()Lcom/squareup/okhttp/HttpUrl$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/squareup/okhttp/HttpUrl$Builder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 340
    .local v1, "uri":Ljava/lang/String;
    new-instance v2, Ljava/net/URI;

    invoke-direct {v2, v1}, Ljava/net/URI;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 341
    .end local v1    # "uri":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 342
    .local v0, "e":Ljava/net/URISyntaxException;
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "not valid as a java.net.URI: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public url()Ljava/net/URL;
    .locals 3

    .prologue
    .line 323
    :try_start_0
    new-instance v1, Ljava/net/URL;

    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl;->url:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 324
    :catch_0
    move-exception v0

    .line 325
    .local v0, "e":Ljava/net/MalformedURLException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public username()Ljava/lang/String;
    .locals 1

    .prologue
    .line 364
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl;->username:Ljava/lang/String;

    return-object v0
.end method
