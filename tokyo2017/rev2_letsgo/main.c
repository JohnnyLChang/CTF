// local variable allocation has failed, the output may be wrong!
void __usercall main_Xerei4oreeshex6zien0(string password@<rsi:rdi>, string table@<rcx:rdx>, __int64 passworda, __int64 password_8, uint8 *tablea, __int64 table_8)
{
  unsigned __int64 v6; // r8@2
  __int64 v7; // rax@2
  uint8 *v8; // rcx@2
  unsigned __int64 v9; // rdx@2 OVERLAPPED
  __int64 v10; // rbx@2
  __int64 v11; // rsi@2
  runtime__type_0 *v12; // rdi@3
  signed __int64 v13; // rcx@6 OVERLAPPED
  char v14; // bl@6
  string v15; // di@8
  __int64 v16; // rax@12
  _BYTE *v17; // rax@12
  bool v18; // zf@12
  _BYTE *v19; // rcx@12
  _BYTE *v20; // rax@12
  _BYTE *v21; // rax@12
  _BYTE *v22; // rax@12
  _BYTE *v23; // rax@12
  runtime_eface_0 v24; // rdx@12
  unsigned __int64 v25; // rdx@12
  unsigned __int64 v26; // rdx@12
  __int64 v27; // rdx@12
  unsigned __int64 v28; // r8@12
  string *v29; // rax@12
  __int64 v30; // rcx@14
  __int64 v31; // rax@14
  __int64 v32; // rcx@14 OVERLAPPED
  __int64 v33; // rdx@14 OVERLAPPED
  char match; // bl@14
  __int64 v35; // rdx@16 OVERLAPPED
  void *v36; // rcx@17
  runtime_eface_0 v37; // rdx@17
  interface____0 encobj; // rdx@17
  bool v39; // r8@17
  unsigned __int64 v40; // rdx@20
  unsigned __int64 v41; // rdx@22
  runtime_eface_0 v42; // rdx@13
  unsigned __int64 v43; // rdx@13
  unsigned __int64 v44; // rdx@23
  __int64 *v45; // [sp+0h] [bp-260h]@12
  __uint8 _r2; // [sp+10h] [bp-250h]@2
  __uint8 encoded; // [sp+28h] [bp-238h]@2
  unsigned __int64 v48; // [sp+40h] [bp-220h]@2
  runtime_slice_0 _r3; // [sp+48h] [bp-218h]@2
  __int64 passEncoded_len; // [sp+60h] [bp-200h]@2
  __int64 pass_len; // [sp+68h] [bp-1F8h]@2
  __int64 pass_cap; // [sp+70h] [bp-1F0h]@2
  __int64 offset; // [sp+78h] [bp-1E8h]@2
  __int64 i; // [sp+80h] [bp-1E0h]@2
  __int64 i_7; // [sp+88h] [bp-1D8h]@15
  char v56; // [sp+90h] [bp-1D0h]@1
  __int64 v57; // [sp+93h] [bp-1CDh]@2
  __uint8 v58; // [sp+A0h] [bp-1C0h]@2
  uint8 *pass_ptr; // [sp+C0h] [bp-1A0h]@2
  uint8 *v60; // [sp+C8h] [bp-198h]@17
  uint8 *v61; // [sp+D0h] [bp-190h]@17
  __int64 v62; // [sp+D8h] [bp-188h]@15
  string *_input; // [sp+E0h] [bp-180h]@12
  const char *v64; // [sp+E8h] [bp-178h]@23
  __int64 v65; // [sp+F0h] [bp-170h]@23
  __interface___ v66; // [sp+F8h] [bp-168h]@22
  __int64 v67; // [sp+110h] [bp-150h]@22
  __interface___ v68; // [sp+118h] [bp-148h]@20
  __int64 v69; // [sp+130h] [bp-130h]@20
  __interface___ e; // [sp+138h] [bp-128h]@13
  __int64 v71; // [sp+150h] [bp-110h]@13
  __interface___ v72; // [sp+158h] [bp-108h]@12
  string *v73; // [sp+170h] [bp-F0h]@12
  const char *v74; // [sp+178h] [bp-E8h]@12
  __int64 v75; // [sp+180h] [bp-E0h]@12
  char a[40]; // [sp+188h] [bp-D8h]@2
  __int64 v77; // [sp+1B0h] [bp-B0h]@16
  __int64 v78; // [sp+1B8h] [bp-A8h]@16
  __int64 v79; // [sp+1C0h] [bp-A0h]@16
  _BYTE *v80; // [sp+1C8h] [bp-98h]@12
  __int64 v81; // [sp+1D0h] [bp-90h]@12
  __int64 v82; // [sp+1D8h] [bp-88h]@12
  _BYTE *v83; // [sp+1E0h] [bp-80h]@12
  __int64 v84; // [sp+1E8h] [bp-78h]@12
  __int64 v85; // [sp+1F0h] [bp-70h]@12
  _BYTE *v86; // [sp+1F8h] [bp-68h]@12
  __int64 v87; // [sp+200h] [bp-60h]@12
  __int64 v88; // [sp+208h] [bp-58h]@12
  _BYTE *v89; // [sp+210h] [bp-50h]@12
  __int64 v90; // [sp+218h] [bp-48h]@12
  __int64 v91; // [sp+220h] [bp-40h]@12
  _BYTE *v92; // [sp+228h] [bp-38h]@12
  __int64 v93; // [sp+230h] [bp-30h]@12
  __int64 v94; // [sp+238h] [bp-28h]@12
  _BYTE *v95; // [sp+240h] [bp-20h]@12
  __int64 v96; // [sp+248h] [bp-18h]@12
  __int64 v97; // [sp+250h] [bp-10h]@12
  __int64 v98; // [sp+258h] [bp-8h]@12

  while ( (unsigned __int64)&v56 <= *(_QWORD *)(*MK_FP(__FS__, -8LL) + 16LL) )
    runtime_morestack_noctxt();
  *(_OWORD *)&a[16] = 0LL;
  *(_OWORD *)&a[24] = 0LL;
  v57 = *(_QWORD *)main_statictmp_71;
  *(__int64 *)((char *)&v57 + 5) = *(_QWORD *)&main_statictmp_71[5];
  _r2.array = (uint8 *)&v58;
  _r2.len = passworda;
  _r2.cap = password_8;
  runtime_stringtoslicebyte(
    (uint8 (*)[32])password.str,
    (string)__PAIR__((unsigned __int64)table.str, password.len),
    _r2);
  pass_ptr = encoded.array;
  pass_cap = encoded.cap;
  pass_len = encoded.len;
  _r2 = encoded;
  encoded.array = tablea;
  encoded.len = table_8;
  main_StrangeEncoding(password, v6, _r2, encoded);
  v7 = encoded.cap;
  v8 = (uint8 *)_r3.array;
  v9 = v48;
  v10 = -(signed __int64)(v48 - 13);
  offset = -(signed __int64)(v48 - 13);
  v11 = 0LL;
  i = 0LL;
  passEncoded_len = v48;
  if ( ((v48 - 13) & 0x8000000000000000LL) != 0LL )
  {
    do
    {
      v12 = (runtime__type_0 *)(v9 + 1);
      if ( (signed __int64)(v9 + 1) > (signed __int64)v8 )
      {
        _r2.array = (uint8 *)&newTable;
        _r2.len = v7;
        _r2.cap = v9;
        encoded.array = v8;
        encoded.len = v9 + 1;
        runtime_growslice(v12, (runtime_slice_0)_r2, v11, (runtime_slice_0)encoded);
        v7 = encoded.cap;
        v12 = (runtime__type_0 *)(v48 + 1);
        v10 = offset;
        v11 = i;
        v8 = (uint8 *)_r3.array;
        v9 = passEncoded_len;
      }
      *(_BYTE *)(v7 + v9) = 0;
      ++v11;
      v9 = (unsigned __int64)v12;
      i = v11;
      passEncoded_len = (__int64)v12;
    }
    while ( v11 < v10 );
  }
  v13 = 0LL;
  v14 = 1;
  do
  {
    if ( v13 >= v9 )
      runtime_panicindex();
    v15.len = *(_BYTE *)(v7 + v13);
    v15.str = (uint8 *)*((_BYTE *)&v57 + v13);
    if ( LOBYTE(v15.len) != LOBYTE(v15.str) )
      v14 = 0;
    ++v13;
  }
  while ( v13 < 13 );
  if ( v14 )
  {
    _r2.array = (uint8 *)&stru_4A2A40;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v16 = _r2.len;
    _input = (string *)_r2.len;
    *(_QWORD *)_r2.len = 0LL;
    *(_QWORD *)(v16 + 8) = 0LL;
    v15.str = (uint8 *)&_r2 + 392;
    v45 = &v98;
    sub_44D652(v15.str);
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v17 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_79;
    v18 = ((unsigned __int8)v17 & *v17) == 0;
    v80 = v17;
    v81 = 8LL;
    v82 = 8LL;
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v19 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_82;
    v18 = (main_statictmp_82[0] & *v19) == 0;
    v83 = v19;
    v84 = 8LL;
    v85 = 8LL;
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v20 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_85;
    v18 = ((unsigned __int8)v20 & *v20) == 0;
    v86 = v20;
    v87 = 8LL;
    v88 = 8LL;
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v21 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_88;
    v18 = ((unsigned __int8)v21 & *v21) == 0;
    v89 = v21;
    v90 = 8LL;
    v91 = 8LL;
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v22 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_91;
    v18 = ((unsigned __int8)v22 & *v22) == 0;
    v92 = v22;
    v93 = 8LL;
    v94 = 8LL;
    _r2.array = (uint8 *)&unk_4A7AA0;
    runtime_newobject((runtime__type_0 *)v15.str, (void *)v15.len);
    v23 = (_BYTE *)_r2.len;
    *(_QWORD *)_r2.len = *(_QWORD *)main_statictmp_94;
    v18 = ((unsigned __int8)v23 & *v23) == 0;
    v95 = v23;
    v96 = 8LL;
    v97 = 8LL;
    v74 = aInputFlag;
    v75 = 12LL;
    *(_QWORD *)a = 0LL;
    *(_QWORD *)&a[8] = 0LL;
    _r2.array = (uint8 *)&stru_4A2A40;
    v24.data = &v74;
    _r2.len = (__int64)&v74;
    runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, v24);
    *(_QWORD *)a = _r2.cap;
    *(_QWORD *)&a[8] = encoded.array;
    _r2.array = (uint8 *)a;
    _r2.len = 1LL;
    _r2.cap = 1LL;
    fmt_Print((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v25, v15.len));
    v72.cap = (__int64)&unk_49FCE0;
    v73 = _input;
    _r2.array = (uint8 *)&v72.cap;
    _r2.len = 1LL;
    _r2.cap = 1LL;
    fmt_Scan((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v26, v15.len));
    v29 = _input;
    if ( _input->len != 48 )
    {
      e.cap = (__int64)aFailed___;
      v71 = 12LL;
      v72.array = 0LL;
      v72.len = 0LL;
      v42.data = &stru_4A2A40;
      _r2.array = (uint8 *)&stru_4A2A40;
      v42._type = (runtime__type_0 *)&e.cap;
      _r2.len = (__int64)&e.cap;
      runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, v42);
      v72.array = (interface____0 *)_r2.cap;
      v72.len = (__int64)encoded.array;
      _r2.array = (uint8 *)&v72;
      _r2.len = 1LL;
      _r2.cap = 1LL;
      fmt_Println((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v43, v15.len));
      _r2.array = (uint8 *)1;
      os_Exit((__int64)v15.str);
      v29 = _input;
    }
    v30 = v29->len;
    _r2.array = v29->str;
    _r2.len = v30;
    _r2.cap = 8LL;
    encoded.array = 0LL;
    encoded.len = 0LL;
    main_iep4thiequai1athieSe(v15, v27, (string)__PAIR__(v28, v30), (__string)_r2);
    v31 = v48;
    _r3.cap = v48;
    v32 = encoded.cap;
    v33 = 0LL;
    match = 1;
    while ( 1 )
    {
      i_7 = v33;
      v62 = v32;
      BYTE7(_r3.len) = match;
      if ( v33 >= v31 )
        break;
      v15.len = *(_QWORD *)(v32 + 8);
      v15.str = *(uint8 **)v32;
      _r2.array = 0LL;
      _r2.len = (__int64)v15.str;
      _r2.cap = v15.len;
      runtime_stringtoslicebyte((uint8 (*)[32])v15.str, (string)__PAIR__(v33, v15.len), _r2);
      *(__uint8 *)&a[16] = encoded;
      _r2.array = (uint8 *)&a[16];
      _r2.len = (__int64)pass_ptr;
      _r2.cap = pass_len;
      encoded.array = (uint8 *)pass_cap;
      encode_flag_and_check((__uint8 *)v15.str, _r2);
      v35 = *(_QWORD *)&a[32];
      v77 = *(_QWORD *)&a[16];
      v78 = *(_QWORD *)&a[24];
      v79 = *(_QWORD *)&a[32];
      if ( (unsigned __int64)i_7 >= 6 )
        runtime_panicindex();
      _r2.len = (__int64)&(&v80)[24 * i_7];
      v36 = &unk_4A1940;
      _r2.array = (uint8 *)&unk_4A1940;
      runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, *(runtime_eface_0 *)&v35);
      v61 = (uint8 *)_r2.cap;
      v37.data = encoded.array;
      v60 = encoded.array;
      v37._type = (runtime__type_0 *)&unk_4A1940;
      _r2.array = (uint8 *)&unk_4A1940;
      _r2.len = (__int64)&v77;
      runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, v37);
      encobj.data = encoded.array;
      _r2.array = v61;
      _r2.len = (__int64)v60;
      reflect.DeepEqual((interface____0)v15, encobj, v39);
      v32 = v62 + 16;
      v15.len = i_7;
      v33 = i_7 + 1;
      match = encoded.len & BYTE7(_r3.len);
      v31 = _r3.cap;
    }
    if ( match )
    {
      v68.cap = (__int64)aYouGotAFlag;
      v69 = 15LL;
      e.array = 0LL;
      e.len = 0LL;
      _r2.array = (uint8 *)&stru_4A2A40;
      _r2.len = (__int64)&v68.cap;
      runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, *(runtime_eface_0 *)&v33);
      e.array = (interface____0 *)_r2.cap;
      e.len = (__int64)encoded.array;
      _r2.array = (uint8 *)&e;
      _r2.len = 1LL;
      _r2.cap = 1LL;
      fmt_Println((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v40, v15.len));
    }
    else
    {
      v66.cap = (__int64)aFailed___;
      v67 = 12LL;
      v68.array = 0LL;
      v68.len = 0LL;
      _r2.array = (uint8 *)&stru_4A2A40;
      _r2.len = (__int64)&v66.cap;
      runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, *(runtime_eface_0 *)&v33);
      v68.array = (interface____0 *)_r2.cap;
      v68.len = (__int64)encoded.array;
      _r2.array = (uint8 *)&v68;
      _r2.len = 1LL;
      _r2.cap = 1LL;
      fmt_Println((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v41, v15.len));
    }
  }
  else
  {
    v64 = aFailed___;
    v65 = 12LL;
    v66.array = 0LL;
    v66.len = 0LL;
    runtime_convT2E((runtime__type_0 *)v15.str, (void *)v15.len, *(runtime_eface_0 *)&v9);
    v66.array = (interface____0 *)_r2.cap;
    v66.len = (__int64)encoded.array;
    _r2.array = (uint8 *)&v66;
    _r2.len = 1LL;
    _r2.cap = 1LL;
    fmt_Println((__interface___)_r2, (__int64)v15.str, (error_0)__PAIR__(v44, v15.len));
  }
}