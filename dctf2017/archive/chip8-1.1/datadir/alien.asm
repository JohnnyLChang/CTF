;
;	Alien
;	Copyright (C) Jonas Lindstedt
;
	.title	"Alien version 1.0", "Copyright (C) Jonas Lindstedt"
	.xref	on
;
	jump	L1
	.byte	10
	.ascii	"Alien version 1.0"
	.byte	10
	.ascii	"Copyright (C) Jonas Lindstedt"
	.byte	10
	.align
L1:
	high
	jump	L11
L2:
	load	v4, 1
	load	i, L51
	load	vB, 0
	load	vC, 59
L3:
	draw	vB, vC, 4
	add	vB, 8
	skip.eq	vB, 128
	jump	L3
	load	v8, 60
	load	i, L49
	load	v9, 53
	draw	v8, v9, 6
	load	v3, 0
L4:
	skip.ne	v3, 0
	jump	L5
	load	i, L50
	draw	v2, v3, 2
	load	v3, 0
L5:
	load	vC, v4
	add	vC, 255
	load	vB, 3
	and	vC, vB
	load	vB, 0
L6:
	skip.ne	vC, 0
	jump	L7
	add	vB, 5
	add	vC, 255
	jump	L6
L7:
	load	v1, 0
L8:
	load	i, L48
	add	i, vB
	restore	v0
	load	i, L54
	add	i, v1
	save	v0
	add	v1, 1
	add	vB, 1
	skip.eq	v1, 6
	jump	L8
	load	vD, 8
	load	vE, 5
	load	v6, 0
	load	vA, 1
	load	i, L54
	load	v0, vD
L9:
	draw	v0, vE, 5
	add	v0, 20
	skip.eq	v0, 108
	jump	L9
	call	L24
L10:
	call	L35
	call	L18
	call	L28
	skip.ne	vF, 66
	jump	L4
	call	L38
	skip.eq	v4, 99
	jump	L10
L11:
	clear
	load	i, L46
	load	vD, 40
	load	vE, 10
	load	vC, 10
L12:
	draw	vD, vE, 10
	add	vD, 8
	add	i, vC
	skip.eq	vD, 88
	jump	L12
	load	i, L47
	load	vD, 52
	load	vE, 25
	load	vC, 5
L13:
	draw	vD, vE, 5
	add	vD, 8
	add	i, vC
	skip.eq	vD, 76
	jump	L13
	load	vD, 45
	load	vE, 40
	load	vC, 5
L14:
	draw	vD, vE, 5
	add	vD, 8
	add	i, vC
	skip.eq	vD, 69
	jump	L14
	load	i, L53
	restore	v0
	load	i, L56
	bcd	v0
	load	vC, 0
L15:
	load	i, L56
	add	i, vC
	restore	v0
	hex	v0
	draw	vD, vE, 5
	add	vD, 5
	add	vC, 1
	skip.eq	vC, 3
	jump	L15
	load	vC, 10
L16:
	skip.eq	vC, key
	jump	L16
	load	i, L52
	load	v0, 0
	load	v1, 0
	save	v1
	load	vC, 54
L17:
	scdown	1
	add	vC, 255
	skip.eq	vC, 0
	jump	L17
	jump	L2
L18:
	skip.eq	v3, 0
	jump	L22
	rnd	vC, 15
	skip.eq	vC, 0
	jump	L21
	rnd	vC, 7
	add	vC, 1
	lsr	vC
	load	i, L55
	add	i, vC
	restore	v0
	skip.ne	v0, 0
	jump	L21
	load	v2, vD
	load	v3, vE
	add	v3, 5
L19:
	skip.ne	vC, 0
	jump	L20
	add	v2, 20
	add	vC, 255
	jump	L19
L20:
	load	i, L50
	draw	v2, v3, 2
	skip.eq	vF, 0
	jump	L23
L21:
	ret
L22:
	load	i, L50
	draw	v2, v3, 2
	add	v3, 1
	skip.eq	v3, 58
	jump	L20
	load	v3, 0
	ret
L23:
	load	vC, 53
	load	vB, v3
	sub	vB, vC
	skip.eq	vF, 0
	load	v4, 99
	ret
L24:
	load	v0, v4
	add	v0, 1
	lsr	v0
	load	vC, 0
L25:
	load	i, L55
	add	i, vC
	save	v0
	add	vC, 1
	skip.eq	vC, 5
	jump	L25
	load	i, L56
	bcd	v4
	call	L27
	load	vC, 120
	load	time, vC
L26:
	load	vC, time
	skip.eq	vC, 0
	jump	L26
	call	L27
	ret
L27:
	load	i, L57
	restore	v0
	xhex	v0
	load	vC, 55
	load	vB, 27
	draw	vC, vB, 10
	load	i, L58
	restore	v0
	xhex	v0
	load	vC, 65
	draw	vC, vB, 10
	ret
L28:
	skip.ne	v6, 0
	jump	L33
	load	i, L50
	draw	v5, v6, 2
	add	v6, 255
	skip.ne	v6, 0
	jump	L33
	draw	v5, v6, 2
	skip.ne	vF, 0
	jump	L33
	load	vC, vE
	add	vC, 5
	sub	vC, v6
	skip.ne	vF, 0
	jump	L34
	draw	v5, v6, 2
	add	v5, 251
	load	v6, 0
	load	vC, vD
	load	v0, 0
L29:
	load	vB, vC
	sub	vB, v5
	skip.eq	vF, 0
	jump	L30
	add	vC, 20
	add	v0, 1
	jump	L29
L30:
	load	i, L55
	add	i, v0
	restore	v0
	add	v0, 255
	save	v0
	load	i, L54
	skip.ne	v0, 0
	draw	vC, vE, 5
	load	vC, 10
	load	tone, vC
	load	i, L52
	restore	v0
	load	vC, 255
	xor	v0, vC
	save	v0
	skip.eq	v0, 0
	jump	L31
	load	i, L53
	restore	v0
	add	v0, 1
	save	v0
L31:
	load	vC, 0
	load	vB, 0
L32:
	load	i, L55
	add	i, vC
	restore	v0
	skip.eq	v0, 0
	add	vB, 1
	add	vC, 1
	skip.eq	vC, 5
	jump	L32
	skip.eq	vB, 0
	jump	L33
	add	v4, 1
	load	vF, 66
L33:
	ret
L34:
	load	i, L50
	draw	v2, v3, 2
	draw	v5, v6, 2
	load	v3, 0
	load	v6, 0
	ret
L35:
	load	vB, 0
	load	vC, 3
	skip.ne	vC, key
	load	vB, 255
	load	vC, 12
	skip.ne	vC, key
	load	vB, 1
	skip.ne	vB, 0
	jump	L36
	skip.ne	v8, 1
	load	vB, 1
	skip.ne	v8, 120
	load	vB, 255
	load	i, L49
	load	v9, 53
	draw	v8, v9, 6
	add	v8, vB
	draw	v8, v9, 6
L36:
	load	vC, 10
	skip.eq	vC, key
	jump	L37
	skip.eq	v6, 0
	jump	L37
	load	v5, v8
	load	v6, 53
	load	i, L50
	draw	v5, v6, 2
L37:
	ret
L38:
	load	v0, time
	skip.eq	v0, 0
	jump	L42
	load	v0, 10
	load	time, v0
	load	v7, 0
	skip.eq	vD, 33
	jump	L39
	load	vA, 255
	jump	L40
L39:
	skip.eq	vD, 7
	jump	L41
	load	vA, 1
L40:
	load	v7, 1
L41:
	call	L43
L42:
	ret
L43:
	load	vB, vD
	load	vC, 0
L44:
	load	v9, vB
	load	v1, vE
	load	i, L55
	add	i, vC
	restore	v0
	skip.ne	v0, 0
	jump	L45
	load	i, L54
	draw	v9, v1, 5
	add	v9, vA
	add	v1, v7
	draw	v9, v1, 5
L45:
	add	vC, 1
	add	vB, 20
	skip.eq	vC, 5
	jump	L44
	add	vD, vA
	add	vE, v7
	skip.ne	vE, 48
	load	v4, 99
	ret
L46:
	.pic	"  ****     *****     ******  ******** ***  *****",
		"    **      **         **     **   **  **    ** ",
		"   ****     **         **     **       ***   ** ",
		"   ****     **         **     ** **    ****  ** ",
		"  **  **    **         **     *****    ****  ** ",
		"  **  **    **         **     ** **    ** ** ** ",
		"  ******    **         **     **       **  **** ",
		" **    **   **         **     **       **  **** ",
		" **    **   **   **    **     **   **  **   *** ",
		"****  **** ********  ******  ******** *****  ** "
L47:
	.pic	"***  *  *    ****   *   ",
		"*  * *  *       *   *   ",
		"***  ****       *   *   ",
		"*  *    *       *   *   ",
		"**** ****    **** * ****"

	.pic	" **  **  *  **  ***     ",
		"*   *   * * * * *   *   ",
		" *  *   * * **  **      ",
		"  * *   * * * * *   *   ",
		"**   **  *  * * ***     "

L48:
	.pic	"        "
	.pic	"        "
	.pic	"   **   "
	.pic	"********"
	.pic	"  ****  "

	.pic	"        "
	.pic	"   **   "
	.pic	"  ****  "
	.pic	"********"
	.pic	"*      *"

	.pic	" *    * "
	.pic	"  ****  "
	.pic	"  ****  "
	.pic	"  ****  "
	.pic	" *    * "

	.pic	"  ****  "
	.pic	" * ** * "
	.pic	" * ** * "
	.pic	" ****** "
	.pic	" ****** "

	.pic	"        "
	.pic	"        "
	.pic	"  *  *  "
	.pic	"  ****  "
	.pic	"  *  *  "

	.align
L49:
	.pic	"        "
	.pic	"   **   "
	.pic	"   **   "
	.pic	"  ****  "
	.pic	" ****** "
	.pic	"********"
L50:
	.pic	"   **   ",
		"   **   "
L51:
	.pic	"********"
	.pic	"  *   * "
	.pic	" * * * *"
	.pic	"*  **  *"
L52:
	.byte	0x00
L53:
	.byte	0x00
L54:
	.pic	"        ",
		"        ",
		"        ",
		"        ",
		"        "
	.byte	0x00
L55:
	.ds	0x6
L56:
	.byte	0x00
L57:
	.byte	0x00
L58:
	.ds	0x2
