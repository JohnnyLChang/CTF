.class public final Lcom/squareup/okhttp/HttpUrl$Builder;
.super Ljava/lang/Object;
.source "HttpUrl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/squareup/okhttp/HttpUrl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;
    }
.end annotation


# instance fields
.field encodedFragment:Ljava/lang/String;

.field encodedPassword:Ljava/lang/String;

.field final encodedPathSegments:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field encodedQueryNamesAndValues:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field encodedUsername:Ljava/lang/String;

.field host:Ljava/lang/String;

.field port:I

.field scheme:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 657
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 649
    const-string v0, ""

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 650
    const-string v0, ""

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 652
    const/4 v0, -0x1

    iput v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 653
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    .line 658
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 659
    return-void
.end method

.method private static canonicalizeHost(Ljava/lang/String;II)Ljava/lang/String;
    .locals 5
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    .line 1260
    const/4 v3, 0x0

    invoke-static {p0, p1, p2, v3}, Lcom/squareup/okhttp/HttpUrl;->percentDecode(Ljava/lang/String;IIZ)Ljava/lang/String;

    move-result-object v2

    .line 1263
    .local v2, "percentDecoded":Ljava/lang/String;
    const-string v3, "["

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1264
    const/4 v3, 0x1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    invoke-static {v2, v3, v4}, Lcom/squareup/okhttp/HttpUrl$Builder;->decodeIpv6(Ljava/lang/String;II)Ljava/net/InetAddress;

    move-result-object v1

    .line 1265
    .local v1, "inetAddress":Ljava/net/InetAddress;
    if-nez v1, :cond_0

    const/4 v3, 0x0

    .line 1271
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    :goto_0
    return-object v3

    .line 1266
    .restart local v1    # "inetAddress":Ljava/net/InetAddress;
    :cond_0
    invoke-virtual {v1}, Ljava/net/InetAddress;->getAddress()[B

    move-result-object v0

    .line 1267
    .local v0, "address":[B
    array-length v3, v0

    const/16 v4, 0x10

    if-ne v3, v4, :cond_1

    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->inet6AddressToAscii([B)Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 1268
    :cond_1
    new-instance v3, Ljava/lang/AssertionError;

    invoke-direct {v3}, Ljava/lang/AssertionError;-><init>()V

    throw v3

    .line 1271
    .end local v0    # "address":[B
    .end local v1    # "inetAddress":Ljava/net/InetAddress;
    :cond_2
    invoke-static {v2}, Lcom/squareup/okhttp/HttpUrl$Builder;->domainToAscii(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method private static containsInvalidHostnameAsciiCodes(Ljava/lang/String;)Z
    .locals 5
    .param p0, "hostnameAscii"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 1403
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v1, v3, :cond_2

    .line 1404
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 1408
    .local v0, "c":C
    const/16 v3, 0x1f

    if-le v0, v3, :cond_0

    const/16 v3, 0x7f

    if-lt v0, v3, :cond_1

    .line 1418
    .end local v0    # "c":C
    :cond_0
    :goto_1
    return v2

    .line 1414
    .restart local v0    # "c":C
    :cond_1
    const-string v3, " #%/:?@[\\]"

    invoke-virtual {v3, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    const/4 v4, -0x1

    if-ne v3, v4, :cond_0

    .line 1403
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1418
    .end local v0    # "c":C
    :cond_2
    const/4 v2, 0x0

    goto :goto_1
.end method

.method private static decodeIpv4Suffix(Ljava/lang/String;II[BI)Z
    .locals 10
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I
    .param p3, "address"    # [B
    .param p4, "addressOffset"    # I

    .prologue
    const/4 v7, 0x0

    .line 1348
    move v0, p4

    .line 1350
    .local v0, "b":I
    move v5, p1

    .local v5, "i":I
    move v1, v0

    .end local v0    # "b":I
    .local v1, "b":I
    :goto_0
    if-ge v5, p2, :cond_6

    .line 1351
    array-length v8, p3

    if-ne v1, v8, :cond_1

    .line 1377
    :cond_0
    :goto_1
    return v7

    .line 1354
    :cond_1
    if-eq v1, p4, :cond_2

    .line 1355
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v8

    const/16 v9, 0x2e

    if-ne v8, v9, :cond_0

    .line 1356
    add-int/lit8 v5, v5, 0x1

    .line 1360
    :cond_2
    const/4 v6, 0x0

    .line 1361
    .local v6, "value":I
    move v4, v5

    .line 1362
    .local v4, "groupOffset":I
    :goto_2
    if-ge v5, p2, :cond_3

    .line 1363
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 1364
    .local v2, "c":C
    const/16 v8, 0x30

    if-lt v2, v8, :cond_3

    const/16 v8, 0x39

    if-le v2, v8, :cond_4

    .line 1369
    .end local v2    # "c":C
    :cond_3
    sub-int v3, v5, v4

    .line 1370
    .local v3, "groupLength":I
    if-eqz v3, :cond_0

    .line 1373
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "b":I
    .restart local v0    # "b":I
    int-to-byte v8, v6

    aput-byte v8, p3, v1

    move v1, v0

    .line 1374
    .end local v0    # "b":I
    .restart local v1    # "b":I
    goto :goto_0

    .line 1365
    .end local v3    # "groupLength":I
    .restart local v2    # "c":C
    :cond_4
    if-nez v6, :cond_5

    if-ne v4, v5, :cond_0

    .line 1366
    :cond_5
    mul-int/lit8 v8, v6, 0xa

    add-int/2addr v8, v2

    add-int/lit8 v6, v8, -0x30

    .line 1367
    const/16 v8, 0xff

    if-gt v6, v8, :cond_0

    .line 1362
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 1376
    .end local v2    # "c":C
    .end local v4    # "groupOffset":I
    .end local v6    # "value":I
    :cond_6
    add-int/lit8 v8, p4, 0x4

    if-ne v1, v8, :cond_0

    .line 1377
    const/4 v7, 0x1

    goto :goto_1
.end method

.method private static decodeIpv6(Ljava/lang/String;II)Ljava/net/InetAddress;
    .locals 15
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    .line 1276
    const/16 v12, 0x10

    new-array v1, v12, [B

    .line 1277
    .local v1, "address":[B
    const/4 v2, 0x0

    .line 1278
    .local v2, "b":I
    const/4 v5, -0x1

    .line 1279
    .local v5, "compress":I
    const/4 v8, -0x1

    .line 1281
    .local v8, "groupOffset":I
    move/from16 v10, p1

    .local v10, "i":I
    :goto_0
    move/from16 v0, p2

    if-ge v10, v0, :cond_2

    .line 1282
    array-length v12, v1

    if-ne v2, v12, :cond_0

    const/4 v12, 0x0

    .line 1339
    :goto_1
    return-object v12

    .line 1285
    :cond_0
    add-int/lit8 v12, v10, 0x2

    move/from16 v0, p2

    if-gt v12, v0, :cond_3

    const-string v12, "::"

    const/4 v13, 0x0

    const/4 v14, 0x2

    invoke-virtual {p0, v10, v12, v13, v14}, Ljava/lang/String;->regionMatches(ILjava/lang/String;II)Z

    move-result v12

    if-eqz v12, :cond_3

    .line 1287
    const/4 v12, -0x1

    if-eq v5, v12, :cond_1

    const/4 v12, 0x0

    goto :goto_1

    .line 1288
    :cond_1
    add-int/lit8 v10, v10, 0x2

    .line 1289
    add-int/lit8 v2, v2, 0x2

    .line 1290
    move v5, v2

    .line 1291
    move/from16 v0, p2

    if-ne v10, v0, :cond_4

    .line 1332
    :cond_2
    :goto_2
    array-length v12, v1

    if-eq v2, v12, :cond_d

    .line 1333
    const/4 v12, -0x1

    if-ne v5, v12, :cond_c

    const/4 v12, 0x0

    goto :goto_1

    .line 1292
    :cond_3
    if-eqz v2, :cond_4

    .line 1294
    const-string v12, ":"

    const/4 v13, 0x0

    const/4 v14, 0x1

    invoke-virtual {p0, v10, v12, v13, v14}, Ljava/lang/String;->regionMatches(ILjava/lang/String;II)Z

    move-result v12

    if-eqz v12, :cond_7

    .line 1295
    add-int/lit8 v10, v10, 0x1

    .line 1307
    :cond_4
    const/4 v11, 0x0

    .line 1308
    .local v11, "value":I
    move v8, v10

    .line 1309
    :goto_3
    move/from16 v0, p2

    if-ge v10, v0, :cond_5

    .line 1310
    invoke-virtual {p0, v10}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 1311
    .local v4, "c":C
    invoke-static {v4}, Lcom/squareup/okhttp/HttpUrl;->decodeHexDigit(C)I

    move-result v9

    .line 1312
    .local v9, "hexDigit":I
    const/4 v12, -0x1

    if-ne v9, v12, :cond_a

    .line 1315
    .end local v4    # "c":C
    .end local v9    # "hexDigit":I
    :cond_5
    sub-int v7, v10, v8

    .line 1316
    .local v7, "groupLength":I
    if-eqz v7, :cond_6

    const/4 v12, 0x4

    if-le v7, v12, :cond_b

    :cond_6
    const/4 v12, 0x0

    goto :goto_1

    .line 1296
    .end local v7    # "groupLength":I
    .end local v11    # "value":I
    :cond_7
    const-string v12, "."

    const/4 v13, 0x0

    const/4 v14, 0x1

    invoke-virtual {p0, v10, v12, v13, v14}, Ljava/lang/String;->regionMatches(ILjava/lang/String;II)Z

    move-result v12

    if-eqz v12, :cond_9

    .line 1298
    add-int/lit8 v12, v2, -0x2

    move/from16 v0, p2

    invoke-static {p0, v8, v0, v1, v12}, Lcom/squareup/okhttp/HttpUrl$Builder;->decodeIpv4Suffix(Ljava/lang/String;II[BI)Z

    move-result v12

    if-nez v12, :cond_8

    const/4 v12, 0x0

    goto :goto_1

    .line 1299
    :cond_8
    add-int/lit8 v2, v2, 0x2

    .line 1300
    goto :goto_2

    .line 1302
    :cond_9
    const/4 v12, 0x0

    goto :goto_1

    .line 1313
    .restart local v4    # "c":C
    .restart local v9    # "hexDigit":I
    .restart local v11    # "value":I
    :cond_a
    shl-int/lit8 v12, v11, 0x4

    add-int v11, v12, v9

    .line 1309
    add-int/lit8 v10, v10, 0x1

    goto :goto_3

    .line 1319
    .end local v4    # "c":C
    .end local v9    # "hexDigit":I
    .restart local v7    # "groupLength":I
    :cond_b
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "b":I
    .local v3, "b":I
    ushr-int/lit8 v12, v11, 0x8

    and-int/lit16 v12, v12, 0xff

    int-to-byte v12, v12

    aput-byte v12, v1, v2

    .line 1320
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "b":I
    .restart local v2    # "b":I
    and-int/lit16 v12, v11, 0xff

    int-to-byte v12, v12

    aput-byte v12, v1, v3

    goto/16 :goto_0

    .line 1334
    .end local v7    # "groupLength":I
    .end local v11    # "value":I
    :cond_c
    array-length v12, v1

    sub-int v13, v2, v5

    sub-int/2addr v12, v13

    sub-int v13, v2, v5

    invoke-static {v1, v5, v1, v12, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1335
    array-length v12, v1

    sub-int/2addr v12, v2

    add-int/2addr v12, v5

    const/4 v13, 0x0

    invoke-static {v1, v5, v12, v13}, Ljava/util/Arrays;->fill([BIIB)V

    .line 1339
    :cond_d
    :try_start_0
    invoke-static {v1}, Ljava/net/InetAddress;->getByAddress([B)Ljava/net/InetAddress;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v12

    goto/16 :goto_1

    .line 1340
    :catch_0
    move-exception v6

    .line 1341
    .local v6, "e":Ljava/net/UnknownHostException;
    new-instance v12, Ljava/lang/AssertionError;

    invoke-direct {v12}, Ljava/lang/AssertionError;-><init>()V

    throw v12
.end method

.method private static domainToAscii(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "input"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 1388
    :try_start_0
    invoke-static {p0}, Ljava/net/IDN;->toASCII(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 1389
    .local v1, "result":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    move-object v1, v2

    .line 1398
    .end local v1    # "result":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v1

    .line 1392
    .restart local v1    # "result":Ljava/lang/String;
    :cond_1
    invoke-static {v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->containsInvalidHostnameAsciiCodes(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-eqz v3, :cond_0

    move-object v1, v2

    .line 1393
    goto :goto_0

    .line 1397
    .end local v1    # "result":Ljava/lang/String;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/IllegalArgumentException;
    move-object v1, v2

    .line 1398
    goto :goto_0
.end method

.method private static inet6AddressToAscii([B)Ljava/lang/String;
    .locals 12
    .param p0, "address"    # [B

    .prologue
    const/16 v11, 0x10

    const/16 v10, 0x3a

    .line 1423
    const/4 v5, -0x1

    .line 1424
    .local v5, "longestRunOffset":I
    const/4 v4, 0x0

    .line 1425
    .local v4, "longestRunLength":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v7, p0

    if-ge v3, v7, :cond_2

    .line 1426
    move v1, v3

    .line 1427
    .local v1, "currentRunOffset":I
    :goto_1
    if-ge v3, v11, :cond_0

    aget-byte v7, p0, v3

    if-nez v7, :cond_0

    add-int/lit8 v7, v3, 0x1

    aget-byte v7, p0, v7

    if-nez v7, :cond_0

    .line 1428
    add-int/lit8 v3, v3, 0x2

    goto :goto_1

    .line 1430
    :cond_0
    sub-int v0, v3, v1

    .line 1431
    .local v0, "currentRunLength":I
    if-le v0, v4, :cond_1

    .line 1432
    move v5, v1

    .line 1433
    move v4, v0

    .line 1425
    :cond_1
    add-int/lit8 v3, v3, 0x2

    goto :goto_0

    .line 1438
    .end local v0    # "currentRunLength":I
    .end local v1    # "currentRunOffset":I
    :cond_2
    new-instance v6, Lokio/Buffer;

    invoke-direct {v6}, Lokio/Buffer;-><init>()V

    .line 1439
    .local v6, "result":Lokio/Buffer;
    const/4 v3, 0x0

    :cond_3
    :goto_2
    array-length v7, p0

    if-ge v3, v7, :cond_6

    .line 1440
    if-ne v3, v5, :cond_4

    .line 1441
    invoke-virtual {v6, v10}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 1442
    add-int/2addr v3, v4

    .line 1443
    if-ne v3, v11, :cond_3

    invoke-virtual {v6, v10}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    goto :goto_2

    .line 1445
    :cond_4
    if-lez v3, :cond_5

    invoke-virtual {v6, v10}, Lokio/Buffer;->writeByte(I)Lokio/Buffer;

    .line 1446
    :cond_5
    aget-byte v7, p0, v3

    and-int/lit16 v7, v7, 0xff

    shl-int/lit8 v7, v7, 0x8

    add-int/lit8 v8, v3, 0x1

    aget-byte v8, p0, v8

    and-int/lit16 v8, v8, 0xff

    or-int v2, v7, v8

    .line 1447
    .local v2, "group":I
    int-to-long v8, v2

    invoke-virtual {v6, v8, v9}, Lokio/Buffer;->writeHexadecimalUnsignedLong(J)Lokio/Buffer;

    .line 1448
    add-int/lit8 v3, v3, 0x2

    .line 1449
    goto :goto_2

    .line 1451
    .end local v2    # "group":I
    :cond_6
    invoke-virtual {v6}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v7

    return-object v7
.end method

.method private isDot(Ljava/lang/String;)Z
    .locals 1
    .param p1, "input"    # Ljava/lang/String;

    .prologue
    .line 1125
    const-string v0, "."

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "%2e"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isDotDot(Ljava/lang/String;)Z
    .locals 1
    .param p1, "input"    # Ljava/lang/String;

    .prologue
    .line 1129
    const-string v0, ".."

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "%2e."

    .line 1130
    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, ".%2e"

    .line 1131
    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "%2e%2e"

    .line 1132
    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static parsePort(Ljava/lang/String;II)I
    .locals 11
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    const/4 v10, -0x1

    .line 1457
    :try_start_0
    const-string v3, ""

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    move-object v0, p0

    move v1, p1

    move v2, p2

    invoke-static/range {v0 .. v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v9

    .line 1458
    .local v9, "portString":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v8

    .line 1459
    .local v8, "i":I
    if-lez v8, :cond_0

    const v0, 0xffff

    if-gt v8, v0, :cond_0

    .line 1462
    .end local v8    # "i":I
    .end local v9    # "portString":Ljava/lang/String;
    :goto_0
    return v8

    .restart local v8    # "i":I
    .restart local v9    # "portString":Ljava/lang/String;
    :cond_0
    move v8, v10

    .line 1460
    goto :goto_0

    .line 1461
    .end local v8    # "i":I
    .end local v9    # "portString":Ljava/lang/String;
    :catch_0
    move-exception v7

    .local v7, "e":Ljava/lang/NumberFormatException;
    move v8, v10

    .line 1462
    goto :goto_0
.end method

.method private pop()V
    .locals 4

    .prologue
    .line 1146
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-interface {v1, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1149
    .local v0, "removed":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1150
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1154
    :goto_0
    return-void

    .line 1152
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v2, ""

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private static portColonOffset(Ljava/lang/String;II)I
    .locals 3
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    .line 1243
    move v0, p1

    .local v0, "i":I
    :goto_0
    if-ge v0, p2, :cond_2

    .line 1244
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 1243
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1246
    :cond_1
    :sswitch_0
    add-int/lit8 v0, v0, 0x1

    if-ge v0, p2, :cond_0

    .line 1247
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x5d

    if-ne v1, v2, :cond_1

    goto :goto_1

    :cond_2
    move v0, p2

    .line 1254
    .end local v0    # "i":I
    :sswitch_1
    return v0

    .line 1244
    :sswitch_data_0
    .sparse-switch
        0x3a -> :sswitch_1
        0x5b -> :sswitch_0
    .end sparse-switch
.end method

.method private push(Ljava/lang/String;IIZZ)V
    .locals 8
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I
    .param p4, "addTrailingSlash"    # Z
    .param p5, "alreadyEncoded"    # Z

    .prologue
    .line 1105
    const-string v3, " \"<>^`{}|/\\?#"

    const/4 v5, 0x0

    const/4 v6, 0x1

    move-object v0, p1

    move v1, p2

    move v2, p3

    move v4, p5

    invoke-static/range {v0 .. v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v7

    .line 1107
    .local v7, "segment":Ljava/lang/String;
    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDot(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1122
    :cond_0
    :goto_0
    return-void

    .line 1110
    :cond_1
    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDotDot(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1111
    invoke-direct {p0}, Lcom/squareup/okhttp/HttpUrl$Builder;->pop()V

    goto :goto_0

    .line 1114
    :cond_2
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1115
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1, v7}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 1119
    :goto_1
    if-eqz p4, :cond_0

    .line 1120
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1117
    :cond_3
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1
.end method

.method private removeAllCanonicalQueryParameters(Ljava/lang/String;)V
    .locals 3
    .param p1, "canonicalName"    # Ljava/lang/String;

    .prologue
    .line 843
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v0, v1, -0x2

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_0

    .line 844
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 845
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    add-int/lit8 v2, v0, 0x1

    invoke-interface {v1, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 846
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 847
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 848
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 853
    :cond_0
    return-void

    .line 843
    :cond_1
    add-int/lit8 v0, v0, -0x2

    goto :goto_0
.end method

.method private resolvePath(Ljava/lang/String;II)V
    .locals 8
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I

    .prologue
    const/4 v5, 0x1

    .line 1077
    if-ne p2, p3, :cond_1

    .line 1100
    :cond_0
    return-void

    .line 1081
    :cond_1
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v6

    .line 1082
    .local v6, "c":C
    const/16 v0, 0x2f

    if-eq v6, v0, :cond_2

    const/16 v0, 0x5c

    if-ne v6, v0, :cond_4

    .line 1084
    :cond_2
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 1085
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1086
    add-int/lit8 p2, p2, 0x1

    .line 1093
    :goto_0
    move v2, p2

    .local v2, "i":I
    :cond_3
    :goto_1
    if-ge v2, p3, :cond_0

    .line 1094
    const-string v0, "/\\"

    invoke-static {p1, v2, p3, v0}, Lcom/squareup/okhttp/HttpUrl;->access$200(Ljava/lang/String;IILjava/lang/String;)I

    move-result v3

    .line 1095
    .local v3, "pathSegmentDelimiterOffset":I
    if-ge v3, p3, :cond_5

    move v4, v5

    .local v4, "segmentHasTrailingSlash":Z
    :goto_2
    move-object v0, p0

    move-object v1, p1

    .line 1096
    invoke-direct/range {v0 .. v5}, Lcom/squareup/okhttp/HttpUrl$Builder;->push(Ljava/lang/String;IIZZ)V

    .line 1097
    move v2, v3

    .line 1098
    if-eqz v4, :cond_3

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1089
    .end local v2    # "i":I
    .end local v3    # "pathSegmentDelimiterOffset":I
    .end local v4    # "segmentHasTrailingSlash":Z
    :cond_4
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    const-string v7, ""

    invoke-interface {v0, v1, v7}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 1095
    .restart local v2    # "i":I
    .restart local v3    # "pathSegmentDelimiterOffset":I
    :cond_5
    const/4 v4, 0x0

    goto :goto_2
.end method

.method private static schemeDelimiterOffset(Ljava/lang/String;II)I
    .locals 10
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    const/16 v9, 0x7a

    const/16 v8, 0x61

    const/16 v7, 0x5a

    const/16 v6, 0x41

    const/4 v3, -0x1

    .line 1201
    sub-int v4, p2, p1

    const/4 v5, 0x2

    if-ge v4, v5, :cond_1

    move v2, v3

    .line 1223
    :cond_0
    :goto_0
    return v2

    .line 1203
    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 1204
    .local v1, "c0":C
    if-lt v1, v8, :cond_2

    if-le v1, v9, :cond_4

    :cond_2
    if-lt v1, v6, :cond_3

    if-le v1, v7, :cond_4

    :cond_3
    move v2, v3

    goto :goto_0

    .line 1206
    :cond_4
    add-int/lit8 v2, p1, 0x1

    .local v2, "i":I
    :goto_1
    if-ge v2, p2, :cond_a

    .line 1207
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 1209
    .local v0, "c":C
    if-lt v0, v8, :cond_5

    if-le v0, v9, :cond_8

    :cond_5
    if-lt v0, v6, :cond_6

    if-le v0, v7, :cond_8

    :cond_6
    const/16 v4, 0x30

    if-lt v0, v4, :cond_7

    const/16 v4, 0x39

    if-le v0, v4, :cond_8

    :cond_7
    const/16 v4, 0x2b

    if-eq v0, v4, :cond_8

    const/16 v4, 0x2d

    if-eq v0, v4, :cond_8

    const/16 v4, 0x2e

    if-ne v0, v4, :cond_9

    .line 1206
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1216
    :cond_9
    const/16 v4, 0x3a

    if-eq v0, v4, :cond_0

    move v2, v3

    .line 1219
    goto :goto_0

    .end local v0    # "c":C
    :cond_a
    move v2, v3

    .line 1223
    goto :goto_0
.end method

.method private skipLeadingAsciiWhitespace(Ljava/lang/String;II)I
    .locals 2
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I

    .prologue
    .line 1161
    move v0, p2

    .local v0, "i":I
    :goto_0
    if-ge v0, p3, :cond_0

    .line 1162
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 1173
    .end local v0    # "i":I
    :goto_1
    return v0

    .line 1161
    .restart local v0    # "i":I
    :sswitch_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    move v0, p3

    .line 1173
    goto :goto_1

    .line 1162
    :sswitch_data_0
    .sparse-switch
        0x9 -> :sswitch_0
        0xa -> :sswitch_0
        0xc -> :sswitch_0
        0xd -> :sswitch_0
        0x20 -> :sswitch_0
    .end sparse-switch
.end method

.method private skipTrailingAsciiWhitespace(Ljava/lang/String;II)I
    .locals 2
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "pos"    # I
    .param p3, "limit"    # I

    .prologue
    .line 1181
    add-int/lit8 v0, p3, -0x1

    .local v0, "i":I
    :goto_0
    if-lt v0, p2, :cond_0

    .line 1182
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 1190
    add-int/lit8 p2, v0, 0x1

    .line 1193
    .end local p2    # "pos":I
    :cond_0
    return p2

    .line 1181
    .restart local p2    # "pos":I
    :sswitch_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1182
    nop

    :sswitch_data_0
    .sparse-switch
        0x9 -> :sswitch_0
        0xa -> :sswitch_0
        0xc -> :sswitch_0
        0xd -> :sswitch_0
        0x20 -> :sswitch_0
    .end sparse-switch
.end method

.method private static slashCount(Ljava/lang/String;II)I
    .locals 3
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "pos"    # I
    .param p2, "limit"    # I

    .prologue
    .line 1228
    const/4 v1, 0x0

    .line 1229
    .local v1, "slashCount":I
    :goto_0
    if-ge p1, p2, :cond_1

    .line 1230
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 1231
    .local v0, "c":C
    const/16 v2, 0x5c

    if-eq v0, v2, :cond_0

    const/16 v2, 0x2f

    if-ne v0, v2, :cond_1

    .line 1232
    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 1233
    add-int/lit8 p1, p1, 0x1

    .line 1237
    goto :goto_0

    .line 1238
    .end local v0    # "c":C
    :cond_1
    return v1
.end method


# virtual methods
.method public addEncodedPathSegment(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 6
    .param p1, "encodedPathSegment"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 727
    if-nez p1, :cond_0

    .line 728
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedPathSegment == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 730
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v5, 0x1

    move-object v0, p0

    move-object v1, p1

    move v4, v2

    invoke-direct/range {v0 .. v5}, Lcom/squareup/okhttp/HttpUrl$Builder;->push(Ljava/lang/String;IIZZ)V

    .line 731
    return-object p0
.end method

.method public addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "encodedName"    # Ljava/lang/String;
    .param p2, "encodedValue"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 804
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedName == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 805
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 806
    :cond_1
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    const-string v1, " \"\'<>#&="

    .line 807
    invoke-static {p1, v1, v2, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v1

    .line 806
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 808
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-eqz p2, :cond_2

    const-string v0, " \"\'<>#&="

    .line 809
    invoke-static {p2, v0, v2, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    .line 808
    :goto_0
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 811
    return-object p0

    .line 809
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public addPathSegment(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 6
    .param p1, "pathSegment"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 721
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "pathSegment == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 722
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    move-object v0, p0

    move-object v1, p1

    move v4, v2

    move v5, v2

    invoke-direct/range {v0 .. v5}, Lcom/squareup/okhttp/HttpUrl$Builder;->push(Ljava/lang/String;IIZZ)V

    .line 723
    return-object p0
.end method

.method public addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 792
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 793
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 794
    :cond_1
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    const-string v1, " \"\'<>#&="

    .line 795
    invoke-static {p1, v1, v3, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v1

    .line 794
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 796
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-eqz p2, :cond_2

    const-string v0, " \"\'<>#&="

    .line 797
    invoke-static {p2, v0, v3, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    .line 796
    :goto_0
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 799
    return-object p0

    .line 797
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public build()Lcom/squareup/okhttp/HttpUrl;
    .locals 2

    .prologue
    .line 896
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "scheme == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 897
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    if-nez v0, :cond_1

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "host == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 898
    :cond_1
    new-instance v0, Lcom/squareup/okhttp/HttpUrl;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/squareup/okhttp/HttpUrl;-><init>(Lcom/squareup/okhttp/HttpUrl$Builder;Lcom/squareup/okhttp/HttpUrl$1;)V

    return-object v0
.end method

.method effectivePort()I
    .locals 2

    .prologue
    .line 717
    iget v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl;->defaultPort(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public encodedFragment(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "encodedFragment"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 863
    if-eqz p1, :cond_0

    const-string v0, ""

    const/4 v1, 0x1

    .line 864
    invoke-static {p1, v0, v1, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 866
    return-object p0

    .line 864
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public encodedPassword(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "encodedPassword"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 693
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedPassword == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 694
    :cond_0
    const-string v0, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v1, 0x0

    invoke-static {p1, v0, v2, v1, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 695
    return-object p0
.end method

.method public encodedPath(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "encodedPath"    # Ljava/lang/String;

    .prologue
    .line 767
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedPath == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 768
    :cond_0
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 769
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected encodedPath: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 771
    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-direct {p0, p1, v0, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->resolvePath(Ljava/lang/String;II)V

    .line 772
    return-object p0
.end method

.method public encodedQuery(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 2
    .param p1, "encodedQuery"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    .line 783
    if-eqz p1, :cond_0

    const-string v0, " \"\'<>#"

    .line 785
    invoke-static {p1, v0, v1, v1, v1}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    .line 784
    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl;->queryStringToNamesAndValues(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 787
    return-object p0

    .line 784
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public encodedUsername(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "encodedUsername"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 681
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedUsername == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 682
    :cond_0
    const-string v0, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v1, 0x0

    invoke-static {p1, v0, v2, v1, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 683
    return-object p0
.end method

.method public fragment(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 2
    .param p1, "fragment"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 856
    if-eqz p1, :cond_0

    const-string v0, ""

    .line 857
    invoke-static {p1, v0, v1, v1, v1}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 859
    return-object p0

    .line 857
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public host(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 4
    .param p1, "host"    # Ljava/lang/String;

    .prologue
    .line 703
    if-nez p1, :cond_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "host == null"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 704
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-static {p1, v1, v2}, Lcom/squareup/okhttp/HttpUrl$Builder;->canonicalizeHost(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    .line 705
    .local v0, "encoded":Ljava/lang/String;
    if-nez v0, :cond_1

    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unexpected host: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 706
    :cond_1
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    .line 707
    return-object p0
.end method

.method parse(Lcom/squareup/okhttp/HttpUrl;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;
    .locals 27
    .param p1, "base"    # Lcom/squareup/okhttp/HttpUrl;
    .param p2, "input"    # Ljava/lang/String;

    .prologue
    .line 954
    const/4 v3, 0x0

    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->length()I

    move-result v4

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1, v3, v4}, Lcom/squareup/okhttp/HttpUrl$Builder;->skipLeadingAsciiWhitespace(Ljava/lang/String;II)I

    move-result v5

    .line 955
    .local v5, "pos":I
    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->length()I

    move-result v3

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1, v5, v3}, Lcom/squareup/okhttp/HttpUrl$Builder;->skipTrailingAsciiWhitespace(Ljava/lang/String;II)I

    move-result v22

    .line 958
    .local v22, "limit":I
    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v5, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->schemeDelimiterOffset(Ljava/lang/String;II)I

    move-result v25

    .line 959
    .local v25, "schemeDelimiterOffset":I
    const/4 v3, -0x1

    move/from16 v0, v25

    if-eq v0, v3, :cond_3

    .line 960
    const/4 v4, 0x1

    const-string v6, "https:"

    const/4 v7, 0x0

    const/4 v8, 0x6

    move-object/from16 v3, p2

    invoke-virtual/range {v3 .. v8}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 961
    const-string v3, "https"

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    .line 962
    const-string v3, "https:"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v5, v3

    .line 976
    :goto_0
    const/16 v21, 0x0

    .line 977
    .local v21, "hasUsername":Z
    const/16 v20, 0x0

    .line 978
    .local v20, "hasPassword":Z
    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v5, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->slashCount(Ljava/lang/String;II)I

    move-result v26

    .line 979
    .local v26, "slashCount":I
    const/4 v3, 0x2

    move/from16 v0, v26

    if-ge v0, v3, :cond_0

    if-eqz p1, :cond_0

    invoke-static/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->access$100(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    .line 989
    :cond_0
    add-int v5, v5, v26

    .line 992
    :goto_1
    const-string v3, "@/\\?#"

    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v5, v1, v3}, Lcom/squareup/okhttp/HttpUrl;->access$200(Ljava/lang/String;IILjava/lang/String;)I

    move-result v19

    .line 993
    .local v19, "componentDelimiterOffset":I
    move/from16 v0, v19

    move/from16 v1, v22

    if-eq v0, v1, :cond_5

    .line 994
    move-object/from16 v0, p2

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v17

    .line 996
    .local v17, "c":I
    :goto_2
    sparse-switch v17, :sswitch_data_0

    goto :goto_1

    .line 1026
    :sswitch_0
    move-object/from16 v0, p2

    move/from16 v1, v19

    invoke-static {v0, v5, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->portColonOffset(Ljava/lang/String;II)I

    move-result v24

    .line 1027
    .local v24, "portColonOffset":I
    add-int/lit8 v3, v24, 0x1

    move/from16 v0, v19

    if-ge v3, v0, :cond_9

    .line 1028
    move-object/from16 v0, p2

    move/from16 v1, v24

    invoke-static {v0, v5, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->canonicalizeHost(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    .line 1029
    add-int/lit8 v3, v24, 0x1

    move-object/from16 v0, p2

    move/from16 v1, v19

    invoke-static {v0, v3, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->parsePort(Ljava/lang/String;II)I

    move-result v3

    move-object/from16 v0, p0

    iput v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 1030
    move-object/from16 v0, p0

    iget v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    const/4 v4, -0x1

    if-ne v3, v4, :cond_a

    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->INVALID_PORT:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    .line 1072
    .end local v17    # "c":I
    .end local v19    # "componentDelimiterOffset":I
    .end local v20    # "hasPassword":Z
    .end local v21    # "hasUsername":Z
    .end local v24    # "portColonOffset":I
    .end local v26    # "slashCount":I
    :goto_3
    return-object v3

    .line 963
    :cond_1
    const/4 v4, 0x1

    const-string v6, "http:"

    const/4 v7, 0x0

    const/4 v8, 0x5

    move-object/from16 v3, p2

    invoke-virtual/range {v3 .. v8}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 964
    const-string v3, "http"

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    .line 965
    const-string v3, "http:"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v5, v3

    goto/16 :goto_0

    .line 967
    :cond_2
    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->UNSUPPORTED_SCHEME:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    goto :goto_3

    .line 969
    :cond_3
    if-eqz p1, :cond_4

    .line 970
    invoke-static/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->access$100(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    goto/16 :goto_0

    .line 972
    :cond_4
    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->MISSING_SCHEME:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    goto :goto_3

    .line 994
    .restart local v19    # "componentDelimiterOffset":I
    .restart local v20    # "hasPassword":Z
    .restart local v21    # "hasUsername":Z
    .restart local v26    # "slashCount":I
    :cond_5
    const/16 v17, -0x1

    goto :goto_2

    .line 999
    .restart local v17    # "c":I
    :sswitch_1
    if-nez v20, :cond_8

    .line 1000
    const-string v3, ":"

    move-object/from16 v0, p2

    move/from16 v1, v19

    invoke-static {v0, v5, v1, v3}, Lcom/squareup/okhttp/HttpUrl;->access$200(Ljava/lang/String;IILjava/lang/String;)I

    move-result v6

    .line 1002
    .local v6, "passwordColonOffset":I
    const-string v7, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v8, 0x1

    const/4 v9, 0x0

    const/4 v10, 0x1

    move-object/from16 v4, p2

    invoke-static/range {v4 .. v10}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v18

    .line 1004
    .local v18, "canonicalUsername":Ljava/lang/String;
    if-eqz v21, :cond_6

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%40"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v18

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    .end local v18    # "canonicalUsername":Ljava/lang/String;
    :cond_6
    move-object/from16 v0, v18

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 1007
    move/from16 v0, v19

    if-eq v6, v0, :cond_7

    .line 1008
    const/16 v20, 0x1

    .line 1009
    add-int/lit8 v8, v6, 0x1

    const-string v10, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v11, 0x1

    const/4 v12, 0x0

    const/4 v13, 0x1

    move-object/from16 v7, p2

    move/from16 v9, v19

    invoke-static/range {v7 .. v13}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 1012
    :cond_7
    const/16 v21, 0x1

    .line 1017
    .end local v6    # "passwordColonOffset":I
    :goto_4
    add-int/lit8 v5, v19, 0x1

    .line 1018
    goto/16 :goto_1

    .line 1014
    :cond_8
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%40"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v10, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v11, 0x1

    const/4 v12, 0x0

    const/4 v13, 0x1

    move-object/from16 v7, p2

    move v8, v5

    move/from16 v9, v19

    invoke-static/range {v7 .. v13}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    goto :goto_4

    .line 1032
    .restart local v24    # "portColonOffset":I
    :cond_9
    move-object/from16 v0, p2

    move/from16 v1, v24

    invoke-static {v0, v5, v1}, Lcom/squareup/okhttp/HttpUrl$Builder;->canonicalizeHost(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    .line 1033
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    invoke-static {v3}, Lcom/squareup/okhttp/HttpUrl;->defaultPort(Ljava/lang/String;)I

    move-result v3

    move-object/from16 v0, p0

    iput v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 1035
    :cond_a
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    if-nez v3, :cond_b

    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->INVALID_HOST:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    goto/16 :goto_3

    .line 1036
    :cond_b
    move/from16 v5, v19

    .line 1054
    .end local v17    # "c":I
    .end local v19    # "componentDelimiterOffset":I
    .end local v24    # "portColonOffset":I
    :cond_c
    :goto_5
    const-string v3, "?#"

    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v5, v1, v3}, Lcom/squareup/okhttp/HttpUrl;->access$200(Ljava/lang/String;IILjava/lang/String;)I

    move-result v23

    .line 1055
    .local v23, "pathDelimiterOffset":I
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move/from16 v2, v23

    invoke-direct {v0, v1, v5, v2}, Lcom/squareup/okhttp/HttpUrl$Builder;->resolvePath(Ljava/lang/String;II)V

    .line 1056
    move/from16 v5, v23

    .line 1059
    move/from16 v0, v22

    if-ge v5, v0, :cond_d

    move-object/from16 v0, p2

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x3f

    if-ne v3, v4, :cond_d

    .line 1060
    const-string v3, "#"

    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v5, v1, v3}, Lcom/squareup/okhttp/HttpUrl;->access$200(Ljava/lang/String;IILjava/lang/String;)I

    move-result v9

    .line 1061
    .local v9, "queryDelimiterOffset":I
    add-int/lit8 v8, v5, 0x1

    const-string v10, " \"\'<>#"

    const/4 v11, 0x1

    const/4 v12, 0x1

    const/4 v13, 0x1

    move-object/from16 v7, p2

    invoke-static/range {v7 .. v13}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/squareup/okhttp/HttpUrl;->queryStringToNamesAndValues(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 1063
    move v5, v9

    .line 1067
    .end local v9    # "queryDelimiterOffset":I
    :cond_d
    move/from16 v0, v22

    if-ge v5, v0, :cond_e

    move-object/from16 v0, p2

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x23

    if-ne v3, v4, :cond_e

    .line 1068
    add-int/lit8 v11, v5, 0x1

    const-string v13, ""

    const/4 v14, 0x1

    const/4 v15, 0x0

    const/16 v16, 0x0

    move-object/from16 v10, p2

    move/from16 v12, v22

    invoke-static/range {v10 .. v16}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 1072
    :cond_e
    sget-object v3, Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;->SUCCESS:Lcom/squareup/okhttp/HttpUrl$Builder$ParseResult;

    goto/16 :goto_3

    .line 1042
    .end local v23    # "pathDelimiterOffset":I
    :cond_f
    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->encodedUsername()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 1043
    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->encodedPassword()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 1044
    invoke-static/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->access$300(Lcom/squareup/okhttp/HttpUrl;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    .line 1045
    invoke-static/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->access$400(Lcom/squareup/okhttp/HttpUrl;)I

    move-result v3

    move-object/from16 v0, p0

    iput v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 1046
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->clear()V

    .line 1047
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->encodedPathSegments()Ljava/util/List;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 1048
    move/from16 v0, v22

    if-eq v5, v0, :cond_10

    move-object/from16 v0, p2

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x23

    if-ne v3, v4, :cond_c

    .line 1049
    :cond_10
    invoke-virtual/range {p1 .. p1}, Lcom/squareup/okhttp/HttpUrl;->encodedQuery()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQuery(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    goto/16 :goto_5

    .line 996
    nop

    :sswitch_data_0
    .sparse-switch
        -0x1 -> :sswitch_0
        0x23 -> :sswitch_0
        0x2f -> :sswitch_0
        0x3f -> :sswitch_0
        0x40 -> :sswitch_1
        0x5c -> :sswitch_0
    .end sparse-switch
.end method

.method public password(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 687
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "password == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 688
    :cond_0
    const-string v0, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v1, 0x1

    invoke-static {p1, v0, v2, v2, v1}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    .line 689
    return-object p0
.end method

.method public port(I)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "port"    # I

    .prologue
    .line 711
    if-lez p1, :cond_0

    const v0, 0xffff

    if-le p1, v0, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected port: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 712
    :cond_1
    iput p1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->port:I

    .line 713
    return-object p0
.end method

.method public query(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "query"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 776
    if-eqz p1, :cond_0

    const-string v0, " \"\'<>#"

    const/4 v1, 0x0

    .line 777
    invoke-static {p1, v0, v1, v2, v2}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/squareup/okhttp/HttpUrl;->queryStringToNamesAndValues(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    .line 779
    return-object p0

    .line 777
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method reencodeForUri()Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 874
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v3

    .local v3, "size":I
    :goto_0
    if-ge v1, v3, :cond_0

    .line 875
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 876
    .local v2, "pathSegment":Ljava/lang/String;
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v5, "[]"

    .line 877
    invoke-static {v2, v5, v6, v7, v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v5

    .line 876
    invoke-interface {v4, v1, v5}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 874
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 879
    .end local v2    # "pathSegment":Ljava/lang/String;
    :cond_0
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-eqz v4, :cond_2

    .line 880
    const/4 v1, 0x0

    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v3

    :goto_1
    if-ge v1, v3, :cond_2

    .line 881
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 882
    .local v0, "component":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 883
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    const-string v5, "\\^`{|}"

    .line 884
    invoke-static {v0, v5, v6, v6, v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v5

    .line 883
    invoke-interface {v4, v1, v5}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 880
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 888
    .end local v0    # "component":Ljava/lang/String;
    :cond_2
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    if-eqz v4, :cond_3

    .line 889
    iget-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    const-string v5, " \"#<>\\^`{|}"

    invoke-static {v4, v5, v6, v7, v7}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    .line 892
    :cond_3
    return-object p0
.end method

.method public removeAllEncodedQueryParameters(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 2
    .param p1, "encodedName"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    .line 835
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedName == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 836
    :cond_0
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-nez v0, :cond_1

    .line 839
    :goto_0
    return-object p0

    .line 837
    :cond_1
    const-string v0, " \"\'<>#&="

    .line 838
    invoke-static {p1, v0, v1, v1, v1}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    .line 837
    invoke-direct {p0, v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->removeAllCanonicalQueryParameters(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public removeAllQueryParameters(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    .line 827
    if-nez p1, :cond_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "name == null"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 828
    :cond_0
    iget-object v1, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-nez v1, :cond_1

    .line 831
    :goto_0
    return-object p0

    .line 829
    :cond_1
    const-string v1, " \"\'<>#&="

    const/4 v2, 0x0

    invoke-static {p1, v1, v2, v3, v3}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    .line 830
    .local v0, "nameToRemove":Ljava/lang/String;
    invoke-direct {p0, v0}, Lcom/squareup/okhttp/HttpUrl$Builder;->removeAllCanonicalQueryParameters(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public removePathSegment(I)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 2
    .param p1, "index"    # I

    .prologue
    .line 759
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 760
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 761
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 763
    :cond_0
    return-object p0
.end method

.method public scheme(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "scheme"    # Ljava/lang/String;

    .prologue
    .line 662
    if-nez p1, :cond_0

    .line 663
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "scheme == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 664
    :cond_0
    const-string v0, "http"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 665
    const-string v0, "http"

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    .line 671
    :goto_0
    return-object p0

    .line 666
    :cond_1
    const-string v0, "https"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 667
    const-string v0, "https"

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    goto :goto_0

    .line 669
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected scheme: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setEncodedPathSegment(ILjava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 8
    .param p1, "index"    # I
    .param p2, "encodedPathSegment"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    const/4 v1, 0x0

    .line 746
    if-nez p2, :cond_0

    .line 747
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "encodedPathSegment == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 750
    :cond_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    const-string v3, " \"<>^`{}|/\\?#"

    move-object v0, p2

    move v5, v1

    move v6, v4

    .line 749
    invoke-static/range {v0 .. v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v7

    .line 751
    .local v7, "canonicalPathSegment":Ljava/lang/String;
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0, p1, v7}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 752
    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDot(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDotDot(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 753
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected path segment: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 755
    :cond_2
    return-object p0
.end method

.method public setEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 0
    .param p1, "encodedName"    # Ljava/lang/String;
    .param p2, "encodedValue"    # Ljava/lang/String;

    .prologue
    .line 821
    invoke-virtual {p0, p1}, Lcom/squareup/okhttp/HttpUrl$Builder;->removeAllEncodedQueryParameters(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    .line 822
    invoke-virtual {p0, p1, p2}, Lcom/squareup/okhttp/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    .line 823
    return-object p0
.end method

.method public setPathSegment(ILjava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 8
    .param p1, "index"    # I
    .param p2, "pathSegment"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 735
    if-nez p2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "pathSegment == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 737
    :cond_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    const-string v3, " \"<>^`{}|/\\?#"

    const/4 v6, 0x1

    move-object v0, p2

    move v4, v1

    move v5, v1

    .line 736
    invoke-static/range {v0 .. v6}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;IILjava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v7

    .line 738
    .local v7, "canonicalPathSegment":Ljava/lang/String;
    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDot(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0, v7}, Lcom/squareup/okhttp/HttpUrl$Builder;->isDotDot(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 739
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected path segment: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 741
    :cond_2
    iget-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-interface {v0, p1, v7}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 742
    return-object p0
.end method

.method public setQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 815
    invoke-virtual {p0, p1}, Lcom/squareup/okhttp/HttpUrl$Builder;->removeAllQueryParameters(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    .line 816
    invoke-virtual {p0, p1, p2}, Lcom/squareup/okhttp/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;

    .line 817
    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .prologue
    const/16 v4, 0x3a

    .line 902
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 903
    .local v1, "result":Ljava/lang/StringBuilder;
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 904
    const-string v2, "://"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 906
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_2

    .line 907
    :cond_0
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 908
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 909
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 910
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPassword:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 912
    :cond_1
    const/16 v2, 0x40

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 915
    :cond_2
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_6

    .line 917
    const/16 v2, 0x5b

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 918
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 919
    const/16 v2, 0x5d

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 924
    :goto_0
    invoke-virtual {p0}, Lcom/squareup/okhttp/HttpUrl$Builder;->effectivePort()I

    move-result v0

    .line 925
    .local v0, "effectivePort":I
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->scheme:Ljava/lang/String;

    invoke-static {v2}, Lcom/squareup/okhttp/HttpUrl;->defaultPort(Ljava/lang/String;)I

    move-result v2

    if-eq v0, v2, :cond_3

    .line 926
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 927
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 930
    :cond_3
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedPathSegments:Ljava/util/List;

    invoke-static {v1, v2}, Lcom/squareup/okhttp/HttpUrl;->pathSegmentsToString(Ljava/lang/StringBuilder;Ljava/util/List;)V

    .line 932
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    if-eqz v2, :cond_4

    .line 933
    const/16 v2, 0x3f

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 934
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedQueryNamesAndValues:Ljava/util/List;

    invoke-static {v1, v2}, Lcom/squareup/okhttp/HttpUrl;->namesAndValuesToQueryString(Ljava/lang/StringBuilder;Ljava/util/List;)V

    .line 937
    :cond_4
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    if-eqz v2, :cond_5

    .line 938
    const/16 v2, 0x23

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 939
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedFragment:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 942
    :cond_5
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 921
    .end local v0    # "effectivePort":I
    :cond_6
    iget-object v2, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->host:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method

.method public username(Ljava/lang/String;)Lcom/squareup/okhttp/HttpUrl$Builder;
    .locals 3
    .param p1, "username"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 675
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "username == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 676
    :cond_0
    const-string v0, " \"\':;<=>@[]^`{}|/\\?#"

    const/4 v1, 0x1

    invoke-static {p1, v0, v2, v2, v1}, Lcom/squareup/okhttp/HttpUrl;->canonicalize(Ljava/lang/String;Ljava/lang/String;ZZZ)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/squareup/okhttp/HttpUrl$Builder;->encodedUsername:Ljava/lang/String;

    .line 677
    return-object p0
.end method
