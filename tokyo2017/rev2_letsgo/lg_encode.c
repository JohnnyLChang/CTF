void __usercall main_f1151e71905f3d94b49b0(__uint8 *text@<rdi>, __uint8 key)
{
  char v2; // cl@3
  unsigned __int64 v3; // rsi@3
  unsigned __int64 i; // rdi@4
  char v5; // cl@6
  __int64 v6; // r8@6
  unsigned __int64 v7; // r9@6
  signed __int64 v8; // rdi@6
  unsigned __int64 v9; // r10@6
  unsigned __int64 v10; // rdi@6
  char v11; // cl@7
  __int64 *v12; // [sp+0h] [bp-118h]@2
  char v13[128]; // [sp+10h] [bp-108h]@2
  char v14; // [sp+90h] [bp-88h]@1
  __int64 v15; // [sp+110h] [bp-8h]@2

  while ( (unsigned __int64)&v14 <= *(_QWORD *)(*MK_FP(__FS__, -8LL) + 16LL) )
    runtime_morestack_noctxt();
  v12 = &v15;
  sub_44D930(v13, main_statictmp_20);
  if ( !*((_QWORD *)key.array + 1) )
    runtime_panicindex();
  v2 = **(_BYTE **)key.array;
  v3 = 0LL;
  do
  {
    i = 0LL;
    do
    {
      if ( i >= key.cap )
        runtime_panicindex();
      v5 = v13[(unsigned __int8)(*(_BYTE *)(key.len + v4) + v2)];
      key1 = *(_QWORD *)key.array;
      key2 = *((_QWORD *)key.array + 1);
      v9 = i + 1; 
      v10 = v9 & 7;
      v11 = *(_BYTE *)(key1 + v10) + v5;
      v2 = __ROL1__(v11, 1);
      *(_BYTE *)(key1 + v10) = v2;
      i = v9;
    }
    while ( v9 < 8 );
    ++v3;
  }
  while ( v3 < 0x20 );
}




0x4b
https://www.google.com.tw/search?client=ubuntu&hs=A9x&channel=fs&dcr=0&biw=1546&bih=786&q=www.facebook.com&oq=www.fa&gs_l=psy-ab.1.0.0l4.26255556.26256456.0.26258216.6.6.0.0.0.0.171.529.4j2.6.0.foo%2Cnso-ehuqi%3D1%2Cnso-ehuui%3D1%2Cewh%3D0%2Cnso-mplt%3D2%2Cnso-enksa%3D0%2Cnso-enfk%3D1%2Cnso-usnt%3D1%2Cnso-qnt-npqp%3D0-1701%2Cnso-qnt-npdq%3D0-54%2Cnso-qnt-npt%3D0-1%2Cnso-qnt-ndc%3D300%2Ccspa-dspm-nm-mnp%3D0-05%2Ccspa-dspm-nm-mxp%3D0-125%2Cnso-unt-npqp%3D0-17%2Cnso-unt-npdq%3D0-54%2Cnso-unt-npt%3D0-0602%2Cnso-unt-ndc%3D300%2Ccspa-uipm-nm-mnp%3D0-007525%2Ccspa-uipm-nm-mxp%3D0-052675%2Ccfro%3D1...0...1.1.64.psy-ab..0.6.526...0i131k1.z703E58_6Wc
TWCTF{KEY_TW:)

0xe39cf4f04f9e5092

0x fe a0 bc 37 0d ae 37 b6

input flag
  
gdb-peda$ x/6gx 0xc420070480
0xc420070480:	0xe39cf4f04f9e5092	0x0000000000000000
0xc420070490:	0x0000000000000000	0x0000000000000000
0xc4200704a0:	0x0000000000000000	0x0000000000000000

target flag

gdb-peda$ x/6gx 0xc4200703c8
GO
Killed  
Killed  

0xc4200703c8:	0x48fd9fdd395cfe4a	0x6256406259613652
0xc4200703d8:	0x0000003d3d47546f	0x6256406259613652
0xc4200703e8:	0x0000003d3d47546f	0x000000c420074540

0xc42000a860 --> 0xc4200144c8 --> 0x48fd9fdd395cfe4a
0xc42000a8a0 --> 0xc420014500 --> 0x555ed4725bde6cf0
0xc4200823e0 --> 0xc4200842b8 --> 0x0b492d5de09fa160
0xc42000a920 --> 0xc420014510 --> 0x9c326531f39e320e
0xc42000a960 --> 0xc420014518 --> 0x5eecc9092cef233d
0xc42000a9a0 --> 0xc420014520 --> 0x10b4e73f5fd73945

0x54 = T
0x4B = K

T + K = 0x9f

0000| 0xc42003fbf0 --> 0xc56f6bf27b777c63 
0008| 0xc42003fbf8 --> 0x76abd7fe2b670130 
0016| 0xc42003fc00 --> 0xf04759fa7dc982ca 
0024| 0xc42003fc08 --> 0xc072a49cafa2d4ad 
0032| 0xc42003fc10 --> 0xccf73f362693fdb7 
0040| 0xc42003fc18 --> 0x1531d871f1e5a534 
0048| 0xc42003fc20 --> 0x9a059618c323c704 
0056| 0xc42003fc28 --> 0x75b227ebe2801207 