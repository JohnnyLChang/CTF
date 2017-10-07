;
;	tictac
;	Copyright (C) 1991 David Winter
;
	.title	"tictac version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
	compatibility
	jump	L1
	.byte	10
	.ascii	"tictac version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
L1:
	load	vB, 0
	load	vC, 0
L2:
	load	v0, vB
	load	v1, vC
	load	i, L27
	save	v1
	load	i, L25
	restore	vF
	load	i, L24
	save	vF
	load	i, L27
	restore	v1
	load	vB, v0
	load	vC, v1
	clear
	load	vE, 1
	load	v0, 19
	load	v1, 3
	load	i, L20
L3:
	draw	v0, v1, 1
	add	v0, 8
	skip.eq	v0, 43
	jump	L3
	load	v0, 19
	add	v1, 8
	skip.eq	v1, 35
	jump	L3
	load	v0, 19
	load	v1, 3
	load	i, L21
L4:
	draw	v0, v1, 15
	add	v0, 8
	skip.eq	v0, 51
	jump	L4
	load	v0, 19
	add	v1, 15
L5:
	draw	v0, v1, 10
	add	v0, 8
	skip.eq	v0, 51
	jump	L5
	call	L17
L6:
	load	v0, key
	load	v1, v0
	load	i, L24
	add	i, v0
	restore	v0
	skip.ne	v0, 0
	jump	L9
	call	L7
	jump	L6
L7:
	load	v0, 16
	load	tone, v0
	load	time, v0
L8:
	load	v0, time
	skip.eq	v0, 0
	jump	L8
	ret
L9:
	load	v0, 2
	xor	vE, v0
	load	v0, vE
	save	v0
	load	i, L26
	load	v0, v1
	add	v0, 255
	add	v0, v0
	add	i, v0
	restore	v1
	load	i, L22
	skip.eq	vE, 3
	load	i, L23
	draw	v0, v1, 5
	call	L11
	skip.eq	vA, 0
	jump	L2
	load	i, L24
	load	v1, 0
	load	v2, 0
	load	v3, 1
L10:
	restore	v0
	skip.eq	v0, 0
	add	v1, 1
	add	i, v3
	add	v2, 1
	skip.eq	v2, 16
	jump	L10
	skip.eq	v1, 16
	jump	L6
	jump	L2
L11:
	load	vA, 0
	load	i, L24
	load	v0, 1
	add	i, v0
	restore	v8
	load	v9, 0
	add	v9, v0
	call	L12
	add	v9, v1
	call	L12
	add	v9, v2
	call	L13
	load	v9, 0
	add	v9, v3
	call	L12
	add	v9, v4
	call	L12
	add	v9, v5
	call	L13
	load	v9, 0
	add	v9, v6
	call	L12
	add	v9, v7
	call	L12
	add	v9, v8
	call	L13
	load	v9, 0
	add	v9, v6
	call	L12
	add	v9, v3
	call	L12
	add	v9, v0
	call	L13
	load	v9, 0
	add	v9, v7
	call	L12
	add	v9, v4
	call	L12
	add	v9, v1
	call	L13
	load	v9, 0
	add	v9, v8
	call	L12
	add	v9, v5
	call	L12
	add	v9, v2
	call	L13
	load	v9, 0
	add	v9, v8
	call	L12
	add	v9, v4
	call	L12
	add	v9, v0
	call	L13
	load	v9, 0
	add	v9, v6
	call	L12
	add	v9, v4
	call	L12
	add	v9, v2
	call	L13
	ret
L12:
	lsl	v9
	lsl	v9
	ret
L13:
	skip.ne	v9, 21
	jump	L14
	skip.ne	v9, 63
	jump	L15
	ret
L14:
	call	L17
	add	vB, 1
	jump	L16
L15:
	call	L17
	add	vC, 1
L16:
	call	L17
	load	vA, 1
	load	v0, key
	ret
L17:
	load	v3, 5
	load	v4, 10
	load	i, L23
	draw	v3, v4, 5
	load	v3, 2
	add	v4, 6
	load	i, L27
	bcd	vB
	call	L18
	load	v3, 50
	load	v4, 10
	load	i, L22
	draw	v3, v4, 5
	load	v3, 47
	add	v4, 6
	load	i, L27
	bcd	vC
L18:
	restore	v2
	hex	v0
	call	L19
	hex	v1
	call	L19
	hex	v2
L19:
	draw	v3, v4, 5
	add	v3, 5
	ret
L20:
	.pic	" *******"
L21:
	.pic	"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       "
L22:
	.pic	"   ***  ",
		"  *   * ",
		"  *   * ",
		"  *   * ",
		"   ***  "
L23:
	.pic	"  *   * ",
		"   * *  ",
		"    *   ",
		"   * *  ",
		"  *   * "
L24:
	.byte	0x01
	.ds	0x9
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
L25:
	.byte	0x01
	.ds	0x9
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
L26:
	.byte	0x13
	.byte	0x05
	.byte	0x1B
	.byte	0x05
	.ascii	"#"
	.byte	0x05
	.byte	0x13
	.byte	0x0D
	.byte	0x1B
	.byte	0x0D
	.ascii	"#"
	.byte	0x0D
	.byte	0x13
	.byte	0x15
	.byte	0x1B
	.byte	0x15
	.ascii	"#"
	.byte	0x15
L27:
	.ds	0x3
