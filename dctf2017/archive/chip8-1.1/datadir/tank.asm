;
; This is one of the original 1977 chip8 games.
; Author Unknown.
;
	.title	"Tank version 1.0",
		"Circa 1977"
	.xref	on
	jump	L8
	.byte	10
	.ascii	"Tank version 1.0"
	.byte	10
	.ascii	"Circa 1977"
	.byte	10
	.align
L1:
	add	v6, 251
	load	v0, 32
	sub	v0, v6
	skip.ne	vF, 0
	load	v6, 0
	jump	L26
	.byte	0x00
	.byte	0xFF
	.ds	0x2
L2:
	.byte	0x00
	.byte	0x01
	.byte	0x00
	.byte	0x0C
	.byte	0x0A
L3:
	.byte	0x00
	.byte	0x19
L4:
	.byte	0x02
	.byte	0x04
	.byte	0x06
	.byte	0x08
L5:
	.byte	0x02
	.byte	0x02
	.byte	0x03
	.ascii	","
	.byte	0x00
	.byte	0x0F
L6:
	.byte	0x00
	.byte	0x02
	.byte	0x05
	.ascii	"."
	.byte	0x08
	.byte	0x00
L7:
	.byte	0x00
	.byte	0x02
	.byte	0x05
	.ds	0x4
L8:
	load	vE, 0
	load	vD, 160
	load	vA, 2	; up
	load	v9, 6	; right
	load	v8, 4	; left
	load	v7, 8	; down
	load	v6, 25
	load	v4, 16
	load	v3, 12
	load	v2, 0
	load	v1, 6
	load	i, L2
	save	vA
L9:
	call	L33
	load	v0, 64
	load	time, v0
L10:
	load	v0, time
	skip.eq	v0, 0
	jump	L10
	call	L33
	call	L18
	call	L23
	load	i, L2
	restore	v5
	call	L14
L11:
	call	L15
	call	L16
	skip.eq	vF, 1
	call	L19
	skip.eq	vF, 1
	call	L16
	skip.eq	vF, 1
	call	L16
	skip.eq	vF, 1
	call	L12
	skip.ne	vF, 1
	jump	L24
	jump	L11
L12:
	load	i, L2
	restore	v5
	skip.ne	v6, 0
	skip.eq	v5, 0
	jump	L13
	jump	L27
L13:
	skip.ne	v7, key
	load	v2, 9
	skip.ne	v8, key
	load	v2, 4
	skip.ne	v9, key
	load	v2, 6
	skip.ne	vA, key
	load	v2, 1
	skip.ne	v2, 0
	ret
	call	L14
	load	v1, v2
	call	L29
	call	L30
	load	vC, 1
	load	v2, 0
	load	vF, 0
	load	i, L2
	save	v5
L14:
	load	i, L36
	skip.ne	v1, 1
	load	v0, L36up - L36
	skip.ne	v1, 4
	load	v0, L36le - L36
	skip.ne	v1, 6
	load	v0, L36ri - L36
	skip.ne	v1, 9
	load	v0, L36do - L36
	add	i, v0
	draw	v3, v4, 7
	ret
L15:
	load	v0, 5
	skip.eq	v0, key
	ret
	skip.ne	v5, 15
	ret
	load	v5, 15
	add	v6, 255
	load	i, L2
	save	v5
	add	v4, 3
	add	v3, 3
	call	L29
	call	L29
	call	L29
	load	i, L6
	save	v5
	load	i, L37
	draw	v3, v4, 1
	ret
L16:
	load	i, L6
	restore	v5
	skip.ne	v5, 0
	ret
	load	i, L37
	draw	v3, v4, 1
	call	L29
	load	vC, 2
	call	L31
	skip.ne	vB, 187
	jump	L18
	draw	v3, v4, 1
L17:
	load	i, L6
	save	v5
	ret
L18:
	load	v5, 0
	load	v0, 0
	load	i, L3
	save	v0
	jump	L17
L19:
	load	i, L5
	restore	v5
	skip.eq	v5, 15
	jump	L22
	load	i, L38
	draw	v3, v4, 5
	skip.eq	v2, 0
	jump	L20
	rnd	v1, 3
	load	i, L4
	add	i, v1
	restore	v0
	load	v1, v0
	rnd	v2, 15
	add	v2, 1
L20:
	call	L29
	load	i, L38
	load	vC, 3
	add	v2, 255
	load	vF, 0
	draw	v3, v4, 5
L21:
	load	i, L5
	save	v5
	ret
L22:
	rnd	v4, 7
	load	i, L39
	add	i, v4
	restore	v0
	load	v3, v0
	load	i, L40
	add	i, v4
	restore	v0
	load	v4, v0
	load	i, L38
	draw	v3, v4, 5
	load	v0, 32
	load	tone, v0
	load	v5, 15
	jump	L21
L23:
	load	v5, 0
	jump	L21
L24:
	skip.ne	vC, 1
	jump	L1
	skip.ne	vC, 2
	jump	L25
	load	i, L6
	restore	v5
	skip.ne	v5, 0
	jump	L1
	load	i, L37
	draw	v3, v4, 1
	load	vF, 0
	draw	v3, v4, 1
	skip.eq	vF, 1
	jump	L1
L25:
	add	vE, 10
L26:
	load	v0, 64
	load	tone, v0
	clear
	jump	L9
L27:
	clear
	call	L33
	load	v0, 96
	load	tone, v0
L28:
	jump	L28
	.ascii	"n"
	.byte	0x00
	.byte	0x13
	.byte	0x84
L29:
	skip.ne	v1, 1
	add	v4, 255
	skip.ne	v1, 4
	add	v3, 255
	skip.ne	v1, 6
	add	v3, 1
	skip.ne	v1, 9
	add	v4, 1
	ret
L30:
	skip.ne	v4, 0
	add	v4, 1
	skip.ne	v3, 0
	add	v3, 1
	skip.ne	v3, 56
	add	v3, 255
	skip.ne	v4, 24
	add	v4, 255
	ret
L31:
	load	vB, 0
	skip.ne	v4, 0
	jump	L32
	skip.ne	v3, 0
	jump	L32
	skip.ne	v3, 63
	jump	L32
	skip.ne	v4, 31
L32:
	load	vB, 187
	load	vF, 0
	ret
L33:
	load	v3, 8
	load	v4, 8
	load	i, L7
	bcd	vE
	restore	v2
	call	L34
	load	v3, 40
	load	i, L7
	bcd	v6
	restore	v2
	call	L35
	ret
L34:
	hex	v0
	draw	v3, v4, 5
	add	v3, 6
L35:
	hex	v1
	draw	v3, v4, 5
	add	v3, 6
	hex	v2
	draw	v3, v4, 5
	ret
	.byte	0x01
L36:
L36up:	.pic	"   *    ",
		" * * *  ",
		" *****  ",
		" ** **  ",
		" *****  ",
		" *****  ",
		" *   *  "
L36do:	.pic	" *   *  ",
		" *****  ",
		" *****  ",
		" ** **  ",
		" *****  ",
		" * * *  ",
		"   *    "
L36ri:	.pic	"        ",
		"******  ",
		" ****   ",
		" ** *** ",
		" ****   ",
		"******  ",
		"        "
L36le:	.pic	"        ",
		"  ******",
		"   **** ",
		" *** ** ",
		"   **** ",
		"  ******",
		"        "
L37:
	.pic	"*       "
L38:
	.pic	"* * *   ",
		" ***    ",
		"*****   ",
		" ***    ",
		"* * *   "
L39:
	.byte	0x0B
	.byte	0x1B
	.ascii	"(80 "
	.byte	0x10
	.byte	0x00
L40:
	.ds	0x3
	.byte	0x08
	.byte	0x1B
	.byte	0x1B
	.byte	0x1B
	.byte	0x18
	.byte	0x04
