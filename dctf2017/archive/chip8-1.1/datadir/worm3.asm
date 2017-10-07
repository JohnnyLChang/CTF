;
;	worm3
;	Copyright (C) 1991 Unknown
;
; Lightly edited so that it does not assume the value of the I register
; after ``save'' and ``restore'' opcodes.  Peter Miller, 1998.
;
	.title	"worm3 version 1.0",
		"Copyright (C) 1991 Unknown"
	.xref	on
	jump	L4
;
	.byte	10
	.ascii	"worm3 version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 Unknown"
	.byte	10
	.align
L1:
	.byte	0x57
	.byte	0x6F
	.byte	0x72
	.ascii	"m"
L2:
	.byte	0x00
	.byte	0x52
	.ascii	"B92"
L3:
	.byte	0		; v0
	.byte	0		; v1
	.byte	0		; v2
	.byte	0x3E		; v3
	.byte	0x05		; v4
	.byte	0x00		; v5
	.byte	0x2B		; v6
	.ascii	"|"		; v7
	.byte	0		; v8
	.byte	0		; v9
	.byte	0x06		; vA
	.byte	0x1E		; vB
	.byte	0x01		; vC
	.byte	0x00		; vD
	.byte	0x04		; vE
L4:
	high
	clear
	load	i, L3
	restore	vE
L5:
	load	i, L31
	add	i, v1
	save	v0
	add	v1, 1
	skip.eq	v1, 0
	jump	L5
	load	i, L25
	draw	vA, vB, 3
L6:
	draw	v4, v2, 1
	draw	v4, v3, 1
	add	v4, 3
	skip.eq	v4, 122
	jump	L6
	load	i, L30
	load	v3, 4
L7:
	draw	v3, v2, 9
	draw	v4, v2, 9
	add	v2, 9
	skip.eq	v2, 63
	jump	L7
	load	i, L2
	restore	v0
	load	i, L1
	bcd	v0
	load	v3, 46
	call	L16
	load	i, L1
	bcd	v5
	call	L15
	call	L21
L8:
	load	i, L29
	draw	v7, v6, 1
	add	v6, 254
	skip.eq	v6, 17
	jump	L8
L9:
	load	v3, 6
	load	time, v3
	load	i, L31
	add	i, v8
	restore	v0
	load	v4, v0
	load	v0, vA
	load	i, L31
	add	i, v8
	save	v0
	load	i, L32
	add	i, v8
	restore	v0
	load	v1, v0
	load	v0, vB
	load	i, L32
	add	i, v8
	save	v0
	load	i, L26
	skip.eq	v4, 0
	draw	v4, v1, 3
	load	i, L24
	add	i, v9
	restore	v1
	load	i, L27
	draw	vA, vB, 2
	add	vA, v0
	add	vB, v1
	load	i, L25
	draw	vA, vB, 3
	skip.eq	vF, 0
	jump	L17
	rnd	v0, 15
	skip.ne	v0, 0
	call	L20
L10:
	add	v8, 1
	skip.ne	v8, vE
	load	v8, 0
L11:
	load	v1, 8
	skip.eq	v1, key
	load	v6, 0
	skip.eq	v1, key
	jump	L12
	skip.eq	v6, 0
	jump	L12
	add	v9, 2
	load	v6, 6
	and	v9, v6
L12:
	load	v1, 9
	skip.eq	v1, key
	load	v7, 0
	skip.eq	v1, key
	jump	L13
	skip.eq	v7, 0
	jump	L13
	add	v9, 254
	load	v7, 6
	and	v9, v7
L13:
	load	v3, time
	skip.eq	v3, 0
	jump	L11
	jump	L9
L14:
	call	L15
	load	i, L1
	bcd	v5
L15:
	load	v3, 0
L16:
	load	v4, 124
	load	i, L1
	restore	v2
	hex	v0
	draw	v4, v3, 5
	add	v3, 6
	hex	v1
	draw	v4, v3, 5
	add	v3, 6
	hex	v2
	draw	v4, v3, 5
	ret
L17:
	call	L23
	load	i, L25
	draw	vA, vB, 3
	draw	vA, vB, 3
	skip.eq	vF, 0
	jump	L18
	load	v4, 2
	load	tone, v4
	add	v5, 1
	call	L14
	jump	L10
L18:
	load	v4, 10
	load	tone, v4
	draw	vA, vB, 3
	sub	vA, v0
	sub	vB, v1
	load	i, L27
	draw	vA, vB, 2
	load	i, L2
	restore	v0
	load	i, L2
	sub	v0, v5
	load	v0, v5
	skip.ne	vF, 0
	save	v0
L19:
	jump	L19
L20:
	add	vE, 1
	ret
L21:
	load	i, L28
L22:
	rnd	vC, 124
	add	vC, 2
	rnd	vD, 60
	add	vD, 2
	draw	vC, vD, 7
	skip.ne	vF, 0
	ret
L23:
	load	i, L28
	draw	vC, vD, 7
	jump	L22
L24:
	.byte	0x04
	.ds	0x2
	.byte	0xFC
	.byte	0xFC
	.ds	0x2
	.byte	0x04
L25:
	.pic	"***     ",
		"***     "
L26:
	.byte	0xE0
	.byte	0xA0
	.byte	0xE0
L27:
	.pic	"        ",
		" *      "
L28:
	.pic	"  ***   ",
		" *****  ",
		"** **** ",
		"******* ",
		"******* ",
		" *****  ",
		"  ***   "
L29:
	.pic	"****    "
L30:
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
	.byte	0x80
L31:
	.ds	0x100
L32:
	.byte	0x00
