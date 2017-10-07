;
;	Blitz
;	Copyright (C) David Winter
;
;
	.title	"Blitz version 1.0",
		"Copyright (C) David Winter"
	.xref	on
;
	jump	L1
	.byte	10
	.ascii	"Blitz version 1.0"
	.byte	10
	.ascii	"Copyright (C) David Winter"
	.byte	10
	.align
L1:
	load	i, L23
	load	v0, 4
	load	v1, 9
	load	v2, 14
	load	v7, 4
L2:
	draw	v0, v1, 14
	add	i, v2
	add	v0, 12
	skip.eq	v0, 64
	jump	L2
	load	v0, key
L3:
	clear
	call	L17
	load	v0, key
	clear
	load	vE, v7
	load	i, L21
L4:
	load	vB, 31
	rnd	vC, 31
	add	vC, vC
	draw	vC, vB, 2
	skip.eq	vF, 1
	jump	L5
	draw	vC, vB, 2
	jump	L4
L5:
	rnd	vA, 7
	add	vA, 1
L6:
	add	vB, 254
	draw	vC, vB, 2
	add	vA, 255
	skip.eq	vA, 0
	jump	L6
	add	vE, 255
	skip.eq	vE, 0
	jump	L4
	load	vB, 0
	load	vC, v7
	load	vD, 0
	load	vE, 0
L7:
	load	i, L20
	draw	vD, vE, 3
	skip.eq	vF, 0
	jump	L14
	skip.eq	vB, 0
	jump	L8
	load	v0, 5
	skip.eq	v0, key
	jump	L9
	load	vB, 1
	load	v8, vD
	add	v8, 2
	load	v9, vE
	add	v9, 3
L8:
	load	i, L21
	draw	v8, v9, 1
	load	v1, vF
L9:
	load	v0, 5
	load	time, v0
L10:
	load	v0, time
	skip.eq	v0, 0
	jump	L10
	skip.eq	vB, 1
	jump	L11
	load	i, L21
	skip.eq	v1, 1
	draw	v8, v9, 1
	add	v9, 1
	skip.eq	v9, 32
	jump	L11
	load	vB, 0
	skip.eq	v1, 0
	add	vC, 255
	skip.ne	vC, 0
	jump	L13
L11:
	load	i, L20
	draw	vD, vE, 3
	add	vD, 2
	skip.eq	vD, 64
	jump	L12
	load	vD, 0
	add	vE, 1
L12:
	jump	L7
L13:
	clear
	add	v7, 2
	jump	L3
L14:
	load	i, L20
	draw	vD, vE, 3
	load	v0, 20
	load	v1, 2
	load	v2, 11
	load	i, L22
L15:
	draw	v0, v1, 11
	add	i, v2
	add	v0, 8
	skip.eq	v0, 44
	jump	L15
L16:
	jump	L16
L17:
	load	v0, 10
	load	v1, 13
	load	v2, 5
	load	i, L19
L18:
	draw	v0, v1, 5
	add	i, v2
	add	v0, 8
	skip.eq	v0, 42
	jump	L18
	load	v0, v7
	add	v0, 254
	lsr	v0
	load	i, L24
	bcd	v0
	restore	v2
	load	v0, 45
	hex	v1
	load	v1, 13
	draw	v0, v1, 5
	add	v0, 5
	hex	v2
	draw	v0, v1, 5
	ret
L19:
	.pic	"*     **",
		"*     * ",
		"*     **",
		"*     * ",
		"***** **",
		"*** *   ",
		"    *   ",
		"*   *   ",
		"     * *",
		"***   * ",
		"* ***** ",
		"* *     ",
		"* ***   ",
		"  *     ",
		"  ***** ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*****   "
L20:
	.pic	"*       ",
		"*****   ",
		"******  "
L21:
	.pic	"**      ",
		"**      "
L22:
	.pic	"*****  *",
		"*      *",
		"** ** **",
		"**  * **",
		"***** **",
		"        ",
		"***** * ",
		"*   * * ",
		"*  ** * ",
		"*  **  *",
		"*****   ",
		"*** ****",
		"  * * * ",
		"*** *   ",
		"  * *  *",
		"  * *  *",
		"        ",
		" ** ****",
		" ** *   ",
		"  * *** ",
		" *  **  ",
		"*   ****",
		"* ***** ",
		"* *     ",
		"* ***   ",
		"* **    ",
		"* ***** ",
		"        ",
		"* ***** ",
		"  *   * ",
		"  ***** ",
		"  ** *  ",
		"* **  * "
L23:
	.byte	0xD8
	.byte	0xD8
	.byte	0x00
	.byte	0xC3
	.byte	0xC3
	.byte	0x00
	.byte	0xD8
	.byte	0xD8
	.byte	0x00
	.byte	0xC3
	.byte	0xC3
	.byte	0x00
	.byte	0xD8
	.byte	0xD8
	.byte	0xC0
	.byte	0xC0
	.byte	0x00
	.byte	0xC0
	.byte	0xC0
	.byte	0x00
	.byte	0xC0
	.byte	0xC0
	.byte	0x00
	.byte	0xC0
	.byte	0xC0
	.byte	0x00
	.byte	0xDB
	.byte	0xDB
	.byte	0xDB
	.byte	0xDB
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0xDB
	.byte	0xDB
	.byte	0xDB
	.byte	0xDB
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0xDB
	.byte	0xDB
	.byte	0x00
	.byte	0x03
	.byte	0x03
	.byte	0x00
	.byte	0x18
	.byte	0x18
	.byte	0x00
	.byte	0xC0
	.byte	0xC0
	.byte	0x00
	.byte	0xDB
	.byte	0xDB
L24:
	.ds	0x3
