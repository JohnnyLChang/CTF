;
;	Guess
;	Copyright (C) 1991 David Winter
;
; Think to a number between 1 and 63. CHIP8 shows you several boards
; and you have to tell if you see your number in them. Press 5 if so,
; or another key if not. CHIP8 gives you the number...
;
	.title	"Guess version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
;
	jump	start
	.byte	10
	.ascii	"Guess version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
start:
	load	vE, 1
L1:
	clear
	load	vD, 1
	load	vA, 1
	load	vB, 1
L2:
	load	vC, vD
	and	vC, vE
	skip.ne	vC, 0
	jump	L3
	load	v8, vD
	call	L5
	skip.eq	vA, 64
	jump	L3
	load	vA, 1
	add	vB, 6
	skip.eq	vC, 63
L3:
	add	vD, 1
	skip.eq	vD, 63
	jump	L2
	load	v0, key
	skip.ne	v0, 5
	add	v9, vE
	add	vE, vE
	skip.eq	vE, 64
	jump	L1
	load	vA, 28
	load	vB, 13
	load	v8, v9
	clear
	call	L5
L4:
	jump	L4
L5:
	load	i, L8
	bcd	v8
	restore	v2
	call	L6
	draw	vA, vB, 5
	add	vA, 4
	load	v1, v2
	call	L6
	draw	vA, vB, 5
	add	vA, 5
	ret
L6:
	load	v3, v1
	add	v3, v3
	add	v3, v3
	add	v3, v1
	load	i, L7
	add	i, v3
	ret
L7:
	.pic	"***     ",
		"* *     ",
		"* *     ",
		"* *     ",
		"***     "

	.pic	" *      ",
		" *      ",
		" *      ",
		" *      ",
		" *      "

	.pic	"***     ",
		"  *     ",
		"***     ",
		"*       ",
		"***     "

	.pic	"***     ",
		"  *     ",
		"***     ",
		"  *     ",
		"***     "

	.pic	"* *     ",
		"* *     ",
		"***     ",
		"  *     ",
		"  *     "

	.pic	"***     ",
		"*       ",
		"***     ",
		"  *     ",
		"***     "

	.pic	"***     ",
		"*       ",
		"***     ",
		"* *     ",
		"***     "

	.pic	"***     ",
		"  *     ",
		"  *     ",
		"  *     ",
		"  *     "

	.pic	"***     ",
		"* *     ",
		"***     ",
		"* *     ",
		"***     "

	.pic	"***     ",
		"* *     ",
		"***     ",
		"  *     ",
		"***     "
L8:
	.ds	0x3
