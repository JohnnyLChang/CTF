;
;       space fight
;       Copyright (C) 1992 Carsten Soerensen
;
	.title  "spacefight version 1.0",
		"Copyright (C) 1992 Carsten Soerensen"
	.xref   on
;
	jump    L1
	.byte   10
	.ascii  "Space Fight 2091 version 1.0"
	.byte   10
	.ascii  "Copyright (C) 1992 Carsten Soerensen"
	.byte   10
	.align
L1:
	compatibility	; non-incrementing restore/save behaviour
	high
L2:
	clear
	call	L70
	call	L3
	jump	L2
L3:
	load	i, L103
	load	v0, 0
	save	v0
	load	v8, 0
L4:
	load	i, L87
	add	i, v8
	restore	v7
	load	i, L118
	add	i, v8
	save	v7
	add	v8, 8
	skip.eq	v8, 192
	jump	L4
	load	i, L103
	load	v0, 0
	load	v1, 3
	load	v2, 0
	save	v2
	call	L8
L5:
	load	i, L102
	restore	v0
	skip.ne	v0, 0
	jump	L6
	add	v0, 255
	save	v0
L6:
	call	L82
	call	L41
	call	L33
	call	L25
	call	L13
	load	i, L110
	restore	v4
	skip.eq	v0, 0
	jump	L7
	skip.eq	v1, 0
	jump	L7
	skip.eq	v2, 0
	jump	L7
	skip.eq	v3, 0
	jump	L7
	skip.eq	v4, 0
	jump	L7
	call	L10
	load	i, L103
	restore	v0
	add	v0, 32
	save	v0
	skip.ne	v0, 192
	ret
	call	L8
	jump	L5
L7:
	load	i, L104
	restore	v0
	skip.eq	v0, 0
	jump	L5
	ret
L8:
	call	L57
	load	i, L106
	load	v0, 56
	load	v1, 0
	load	v2, 0
	save	v2
	load	i, L108
	load	v0, 0
	load	v1, 0
	load	v2, 1
	load	v3, 1
	load	v4, 1
	load	v5, 1
	load	v6, 1
	load	v7, 5
	load	v8, 0
	load	v9, 0
	load	vA, 0
	load	vB, 0
	load	vC, 5
	save	vC
	load	i, L102
	load	v0, 255
	save	v0
	clear
	call	L51
	call	L49
	call	L54
	call	L46
	call	L44
	call	L55
	load	v5, 0
	jump	L30
L9:
	add	v3, 1
	skip.eq	v3, 5
	jump	L14
	load	v3, 0
	jump	L14
L10:
	load	i, L102
	restore	v0
	lsr	v0
	lsr	v0
	lsr	v0
	save	v0
	call	L68
	call	L51
	call	L49
	call	L54
	call	L46
	load	v0, 32
	load	v1, 25
	load	i, L89
	load	v2, 8
	load	v3, 0
L11:
	draw	v0, v1, 8
	add	v0, 8
	add	i, v2
	add	v3, 1
	skip.eq	v3, 8
	jump	L11
	call	L45
	call	L80
	call	L80
	load	i, L102
	restore	v0
	skip.ne	v0, 0
	ret
L12:
	call	L45
	call	L46
	load	i, L102
	restore	v0
	add	v0, 255
	save	v0
	load	i, L105
	restore	v0
	add	v0, 1
	save	v0
	call	L45
	call	L46
	load	v0, 1
	load	tone, v0
	call	L82
	load	i, L102
	restore	v0
	skip.eq	v0, 0
	jump	L12
	call	L80
	call	L80
	ret
L13:
	load	i, L114
	restore	v2
	skip.eq	v0, 0
	jump	L15
	add	v2, 255
	save	v2
	skip.eq	v2, 0
	ret
	load	i, L103
	restore	v0
	load	v2, 192
	sub	v2, v0
	lsr	v2
	lsr	v2
	lsr	v2
	lsr	v2
	lsr	v2
	load	v0, v2
	load	i, L115
	save	v0
	rnd	v3, 3
	rnd	v4, 1
	add	v3, v4
L14:
	load	i, L110
	add	i, v3
	restore	v0
	skip.ne	v0, 0
	jump	L9
	load	i, L86
	add	i, v3
	restore	v0
	load	v3, v0
	load	i, L108
	restore	v1
	add	v0, v3
	add	v0, 7
	add	v1, 25
	load	i, L114
	save	v2
	load	v0, 2
	load	tone, v0
	jump	L24
L15:
	call	L24
	add	v1, 4
	load	i, L114
	save	v1
	call	L24
	skip.ne	v1, 64
	jump	L20
	skip.ne	v1, 63
	jump	L20
	skip.ne	v1, 62
	jump	L20
	skip.ne	v1, 61
	jump	L20
	skip.ne	v1, 43
	jump	L18
	skip.ne	v1, 42
	jump	L18
	skip.ne	v1, 41
	jump	L18
	skip.ne	v1, 40
	jump	L18
	skip.ne	v1, 39
	jump	L18
	skip.ne	vF, 0
	ret
	load	v2, v0
	load	v3, v1
	load	i, L107
	restore	v1
	skip.ne	v0, 0
	jump	L16
	skip.eq	v0, v2
	jump	L16
	load	i, L105
	restore	v0
	add	v0, 1
	save	v0
	load	v0, 1
	load	tone, v0
	call	L38
	load	i, L107
	load	v0, 0
	load	v1, 0
	save	v1
	jump	L20
L16:
	load	vA, 0
L17:
	call	L22
	call	L21
	add	vA, 1
	skip.eq	vA, 5
	jump	L17
	call	L22
	jump	L20
L18:
	load	v2, v0
	load	v3, v0
	lsr	v2
	lsr	v2
	lsr	v2
	load	i, L103
	restore	v0
	load	i, L118
	add	i, v0
	add	i, v2
	restore	v0
	skip.ne	v0, 0
	ret
	restore	v0
	add	v0, 255
	load	v2, v0
	load	v0, 0
	save	v0
	skip.ne	v2, 0
	jump	L19
	load	v0, v2
	save	v0
	load	v2, 16
	add	i, v2
	load	v0, 0
	save	v0
	jump	L20
L19:
	load	v0, 248
	and	v0, v3
	load	v1, 44
	load	i, L100
	draw	v0, v1, 4
L20:
	call	L24
	load	i, L114
	load	v0, 0
	load	v1, 0
	save	v1
	ret
L21:
	load	v9, 1
	jump	L23
L22:
	load	v9, 255
	jump	L23
L23:
	call	L49
	load	v0, 1
	load	tone, v0
	load	i, L104
	restore	v0
	add	v0, v9
	save	v0
	call	L49
	jump	L81
L24:
	load	i, L114
	restore	v1
	load	i, L94
	draw	v0, v1, 3
	ret
L25:
	load	i, L111
	restore	v0
	add	v0, 255
	save	v0
	skip.eq	v0, 0
	ret
	load	v0, 5
	save	v0
	load	v5, 0
	call	L30
	call	L26
	load	v5, 1
	jump	L30
L26:
	load	i, L112
	restore	v1
	skip.ne	v0, 0
	jump	L29
	skip.ne	v0, 1
	jump	L27
	skip.ne	v0, 2
	jump	L28
	load	v0, 10
	load	tone, v0
	load	i, L109
	restore	v0
	skip.eq	v0, 12
	add	v0, 1
	save	v0
	add	v1, 1
	load	i, L113
	load	v0, v1
	save	v0
	skip.eq	v1, 4
	ret
	load	i, L112
	load	v0, 0
	load	v1, 0
	save	v1
	ret
L27:
	load	v0, 10
	load	tone, v0
	load	i, L109
	restore	v0
	skip.eq	v0, 12
	add	v0, 1
	save	v0
	add	v1, 1
	load	i, L113
	load	v0, v1
	save	v0
	skip.eq	v1, 4
	ret
	load	i, L112
	load	v0, 2
	load	v1, 0
	save	v1
	ret
L28:
	load	i, L108
	restore	v0
	add	v0, 252
	save	v0
	skip.eq	v0, 0
	ret
	load	i, L112
	load	v0, 3
	save	v0
	ret
L29:
	load	i, L108
	restore	v0
	add	v0, 4
	save	v0
	skip.eq	v0, 40
	ret
	load	i, L112
	load	v0, 1
	save	v0
	ret
L30:
	load	i, L108
	restore	v1
	load	v7, v1
	load	v6, v0
	add	v7, 9
	load	v8, 0
	load	i, L103
	restore	v0
	load	v9, v0
L31:
	load	i, L110
	add	i, v8
	restore	v0
	load	i, L91
	add	i, v9
	skip.eq	v0, 0
	xdraw	v6, v7
	skip.eq	vF, 0
	call	L32
	add	v6, 18
	add	v8, 1
	skip.eq	v8, 5
	jump	L31
	ret
L32:
	skip.ne	v5, 0
	ret
	xdraw	v6, v7
	load	i, L110
	add	i, v8
	load	v0, 0
	save	v0
	call	L46
	load	i, L105
	restore	v0
	add	v0, 2
	save	v0
	call	L46
	call	L38
	load	i, L107
	jump	L40
L33:
	load	i, L107
	restore	v1
	skip.ne	v0, 0
	ret
	skip.ne	v1, 44
	jump	L34
	skip.ne	v1, 45
	jump	L34
	skip.ne	v1, 46
	jump	L34
	skip.eq	v1, 47
	ret
L34:
	load	v2, v0
	load	v3, v0
	lsr	v2
	lsr	v2
	lsr	v2
	load	i, L103
	restore	v0
	load	i, L118
	add	i, v0
	add	i, v2
	restore	v0
	skip.ne	v0, 0
	ret
	restore	v0
	add	v0, 255
	load	v2, v0
	load	v0, 0
	save	v0
	skip.ne	v2, 0
	jump	L35
	load	v0, v2
	save	v0
	load	v2, 16
	add	i, v2
	load	v0, 0
	save	v0
	jump	L36
L35:
	load	v0, 248
	and	v0, v3
	load	v1, 44
	load	i, L100
	draw	v0, v1, 4
L36:
	call	L38
	load	i, L107
	jump	L40
L37:
	load	v0, 10
	skip.eq	v0, key
	ret
	load	i, L107
	restore	v0
	skip.eq	v0, 0
	ret
	load	i, L106
	restore	v0
	add	v0, 7
	load	i, L107
	load	v1, 46
	save	v1
	call	L38
	load	v0, 1
	load	tone, v0
	ret
L38:
	load	i, L107
	restore	v1
	load	i, L94
	skip.eq	v0, 0
	draw	v0, v1, 3
	ret
L39:
	call	L38
	load	i, L107
	restore	v1
	add	v1, 254
	skip.ne	v1, 8
	jump	L40
	skip.ne	v1, 9
	jump	L40
	save	v1
	call	L38
	skip.eq	v0, 0
	skip.ne	vF, 0
	ret
	load	v5, 0
	call	L30
	load	v5, 1
	call	L30
	ret
L40:
	load	v0, 0
	load	v1, 0
	save	v1
	ret
L41:
	call	L37
	call	L39
	load	v0, 3
	skip.ne	v0, key
	jump	L43
	load	v0, 12
	skip.ne	v0, key
	jump	L42
	ret
L42:
	load	i, L106
	restore	v0
	skip.ne	v0, 112
	ret
	call	L44
	add	v0, 1
	load	i, L106
	save	v0
	call	L44
	ret
L43:
	load	i, L106
	restore	v0
	skip.ne	v0, 0
	ret
	call	L44
	add	v0, 255
	load	i, L106
	save	v0
	call	L44
	ret
L44:
	load	i, L106
	restore	v0
	load	v1, 49
	load	i, L92
	xdraw	v0, v1
	ret
L45:
	load	i, L102
	restore	v0
	load	v3, 57
	load	v4, 34
	jump	L47
L46:
	load	i, L105
	restore	v0
	load	v3, 34
	load	v4, 3
L47:
	load	i, L116
	bcd	v0
	restore	v2
	hex	v0
	call	L48
	hex	v1
	call	L48
	hex	v2
L48:
	draw	v3, v4, 5
	add	v3, 5
	ret
L49:
	load	i, L104
	restore	v0
	skip.ne	v0, 0
	ret
	load	v1, 77
	load	v2, 1
	load	i, L93
L50:
	draw	v1, v2, 7
	add	v1, 8
	add	v0, 255
	skip.eq	v0, 0
	jump	L50
	ret
L51:
	load	v0, 101
	load	v1, 0
	load	i, L96
L52:
	load	v2, 8
	load	v3, 0
L53:
	draw	v0, v1, 8
	add	v0, 8
	add	i, v2
	add	v3, 1
	skip.eq	v3, 4
	jump	L53
	ret
L54:
	load	v0, 0
	load	v1, 0
	load	i, L95
	jump	L52
L55:
	load	v1, 0
	load	v2, 44
	load	v3, 0
	load	i, L103
	restore	v0
	load	v4, v0
L56:
	load	i, L119
	add	i, v4
	add	i, v3
	restore	v0
	load	i, L100
	skip.eq	v0, 0
	draw	v1, v2, 4
	add	v1, 8
	add	v3, 1
	skip.eq	v3, 16
	jump	L56
	ret
L57:
	call	L64
	call	L60
	call	L62
	call	L58
	call	L66
	ret
L58:
	call	L59
	call	L80
	call	L59
	call	L81
	call	L59
	call	L81
	call	L59
	call	L80
	call	L59
	call	L80
	call	L59
	jump	L80
L59:
	load	v0, 3
	load	tone, v0
	ret
L60:
	load	v0, 32
	load	v1, 12
	load	i, L98
	load	v2, 8
	load	v3, 0
L61:
	draw	v0, v1, 8
	add	v0, 8
	add	i, v2
	add	v3, 1
	skip.eq	v3, 8
	jump	L61
	ret
L62:
	load	v0, 48
	load	v1, 32
	load	i, L90
	load	v2, 8
	load	v3, 0
L63:
	draw	v0, v1, 8
	add	v0, 8
	add	i, v2
	add	v3, 1
	skip.eq	v3, 4
	jump	L63
	load	i, L103
	restore	v0
	lsr	v0
	lsr	v0
	lsr	v0
	lsr	v0
	lsr	v0
	add	v0, 1
	xhex	v0
	load	v0, 59
	load	v1, 41
	draw	v0, v1, 10
	ret
L64:
	load	v1, 0
L65:
	call	L82
	scleft
	add	v1, 1
	skip.eq	v1, 32
	jump	L65
	ret
L66:
	load	v1, 0
L67:
	call	L82
	scright
	add	v1, 1
	skip.eq	v1, 32
	jump	L67
	ret
L68:
	load	v1, 0
L69:
	call	L82
	scdown	4
	add	v1, 1
	skip.eq	v1, 16
	jump	L69
	ret
L70:
	load	i, L101
	load	v0, 100
	save	v0
	call	L74
	call	L51
	call	L49
	call	L54
	call	L46
	call	L76
L71:
	call	L82
	call	L78
	call	L72
	load	v0, 10
	skip.eq	v0, key
	jump	L71
	ret
L72:
	load	i, L101
	restore	v0
	add	v0, 255
	save	v0
	skip.eq	v0, 0
	ret
	load	v0, 100
	save	v0
	call	L74
	load	i, L97
	load	v0, 16
	load	v1, 24
	load	v2, 32
	load	v3, 0
L73:
	xdraw	v0, v1
	add	v0, 16
	add	i, v2
	add	v3, 1
	skip.eq	v3, 6
	jump	L73
	ret
L74:
	load	i, L88
	load	v0, 32
	load	v1, 24
	load	v2, 32
	load	v3, 0
L75:
	xdraw	v0, v1
	add	v0, 16
	add	i, v2
	add	v3, 1
	skip.eq	v3, 4
	jump	L75
	ret
L76:
	load	i, L117
	load	v0, 0
	save	v0
	load	v2, v0
	load	v4, 0
L77:
	call	L79
	add	v2, 1
	load	v0, v2
	add	v4, 1
	skip.eq	v4, 16
	jump	L77
	ret
L78:
	load	i, L117
	restore	v0
	load	v2, v0
	load	v4, v0
	call	L79
	load	i, L85
	lsl	v2
	add	i, v2
	rnd	v0, 127
	rnd	v1, 63
	save	v1
	load	i, L99
	draw	v0, v1, 1
	load	v3, 15
	add	v4, 1
	and	v4, v3
	load	v0, v4
	load	i, L117
	save	v0
	ret
L79:
	load	i, L85
	lsl	v0
	add	i, v0
	restore	v1
	load	i, L99
	draw	v0, v1, 1
	ret
L80:
	load	v0, 12
	jump	L83
L81:
	load	v0, 6
	jump	L83
L82:
	load	v0, 1
L83:
	load	time, v0
L84:
	load	v0, time
	skip.eq	v0, 0
	jump	L84
	ret
L85:
	.byte	0x0A
	.byte	0x11
	.ascii	"[""[)u8T"
	.byte	0x11
	.byte	0x0C
	.byte	0x09
	.ascii	"4"
	.byte	0x13
	.ascii	"x4&"
	.byte	0x04
	.byte	0x06
	.byte	0x1A
	.byte	0x0C
	.ascii	""" "
	.byte	0x0A
	.byte	0x00
	.byte	0x16
	.byte	0x06
	.byte	0x05
	.ascii	"?"
	.byte	0x07
	.byte	0x00
	.byte	0x1E
L86:
	.byte	0x00
	.byte	0x12
	.ascii	"$6H"
L87:
	.ds	0x26
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.ds	0xC
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.ds	0x9
	.byte	0x02
	.byte	0x02
	.byte	0x02
	.ds	0x4
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.ds	0x6
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.ds	0x4
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.ds	0x4
	.byte	0x05
	.byte	0x05
	.ds	0x3
	.byte	0x05
	.ds	0x2
	.byte	0x05
	.ds	0x3
	.byte	0x05
	.byte	0x05
	.ds	0x2
	.byte	0x01
	.byte	0x01
	.ds	0x3
	.byte	0x01
	.ds	0x2
	.byte	0x01
	.ds	0x3
	.byte	0x01
	.byte	0x01
	.byte	0x00
	.byte	0x0A
	.byte	0x0A
	.ds	0x2
	.byte	0x0A
	.byte	0x0A
	.ds	0x4
	.byte	0x0A
	.byte	0x0A
	.ds	0x2
	.byte	0x0A
	.byte	0x0A
	.byte	0x01
	.byte	0x01
	.ds	0x2
	.byte	0x01
	.byte	0x01
	.ds	0x4
	.byte	0x01
	.byte	0x01
	.ds	0x2
	.byte	0x01
	.byte	0x01
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x14
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01
	.byte	0x01

	.align
L88:
	.xpic	"  ****          ",
		" *****          ",
		"***             ",
		"**              ",
		"**  **   ***   *",
		"**  **  ***** **",
		"**  ** *** ** **",
		"**  ** **  ** **",
		"**  ** **  ** **",
		"****** ****** **",
		" *****  ***** **",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************",
		"                ",
		"                ",
		"                ",
		"                ",
		"****    ***     ",
		"*****  *****    ",
		" ***** **  **   ",
		" ** ** ******   ",
		" ** ** **       ",
		" ** ** ******   ",
		" ** **  *****   ",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************",
		"  ***           ",
		" *****          ",
		"*** **          ",
		"**  **          ",
		"**  ** **  **  *",
		"**  ** **  ** **",
		"**  ** **  ** **",
		"**  ** **  ** **",
		"**  ** **  ** **",
		"******  ****  **",
		" ****    **    *",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************",
		"             ***",
		"             ***",
		"             ** ",
		"             ** ",
		"**     ***  **  ",
		"***   ****  **  ",
		"  ** ***    *   ",
		"**** **     *   ",
		"     **         ",
		"**** **    **   ",
		"**** **    **   ",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************"
L89:
	.pic	"****** *",
		"****** *",
		"   *   *",
		"  **   *",
		"  **   *",
		"  **   *",
		"  **   *",
		"  **   *",
		"* *    *",
		"* **  **",
		"* ******",
		"* ******",
		"* **  **",
		"* **  **",
		"* **  **",
		"* **  **",
		"   ***  ",
		"  ****  ",
		" ***    ",
		" **     ",
		" ****   ",
		" **     ",
		" *****  ",
		"  ****  ",
		"    *** ",
		"   *****",
		"   ** **",
		"   **  *",
		"   *****",
		"   **  *",
		"   *****",
		"   *****",
		"    *** ",
		"   *****",
		"* *** **",
		"* **  **",
		"  **  **",
		"* **  **",
		"* ******",
		"   **** ",
		" **  ** ",
		" *** ** ",
		" ****** ",
		" ** *** ",
		" **  ** ",
		" **  ** ",
		" **  ** ",
		" **  ** ",
		"**  **  ",
		"**  **  ",
		"**  ** *",
		"**  ** *",
		"**  **  ",
		"*** **  ",
		" ***** *",
		"  **** *",
		" ***    ",
		"****  **",
		"*     **",
		"***     ",
		"****    ",
		"  **  **",
		"****  **",
		"***     "
L90:
	.pic	"**      ",
		"**     *",
		"**    **",
		"**    **",
		"**    **",
		"***   **",
		" **** **",
		"  ***  *",
		"*** **  ",
		"*** **  ",
		"*   **  ",
		"    **  ",
		"**  **  ",
		"    ****",
		"***  ***",
		"***   **",
		"**   ***",
		"**  ****",
		"** ***  ",
		"** **   ",
		"** **** ",
		"** **   ",
		"*  *****",
		"    ****",
		" **     ",
		" **     ",
		" **     ",
		" **     ",
		" **     ",
		" ***    ",
		"  ****  ",
		"   ***  "
L91:
	.xpic	"                ",
		"*  * ***** *  * ",
		"      ***       ",
		"       *        ",
		"    *******     ",
		"  ***********   ",
		" * * * * * * *  ",
		"* * * *** *** * ",
		"******** ** *** ",
		"* *** * * *** * ",
		" * * * * * * *  ",
		"  ***********   ",
		" *  *******  *  ",
		"                ",
		"*             * ",
		"                ",
		"      ****      ",
		"     **  **     ",
		"     *  * *     ",
		"      ****      ",
		"     *    *     ",
		"    * **  **    ",
		"   * *   * **   ",
		"   * *    * *   ",
		"   *     * **   ",
		"   *  * * * *   ",
		"    ** * * *    ",
		"   * ** * * *   ",
		"  *   ****   *  ",
		" ************** ",
		" *            * ",
		"                ",
		" *  * * * * * * ",
		"   * * * * *    ",
		" *  * * * * * * ",
		"** * * * * *  **",
		"***  *    *  ***",
		" ************** ",
		"  ***  **  ***  ",
		"    **    **    ",
		"     **  **     ",
		"     ******     ",
		"  **  ****  **  ",
		"  * * **** * *  ",
		"     ******     ",
		"      ****      ",
		"       **       ",
		"                ",
		"      ****      ",
		"     * * **     ",
		"     ** * *     ",
		"      ****      ",
		"   ** **** **   ",
		"  * ** * *** *  ",
		" * **** * *** * ",
		"* *  * * **  * *",
		"**   ** * *   **",
		"**   ******   **",
		"**  ** ** **  **",
		"** ** *  * ** **",
		" * * *    * * * ",
		"   **      **   ",
		"   **      **   ",
		"  **        **  ",
		"  **        **  ",
		" *  *      *  * ",
		"* *  *    *  * *",
		"*    *    *    *",
		" *  **    **  * ",
		"  **  *  *  **  ",
		"      *  *      ",
		"   **********   ",
		"  *     * * **  ",
		"  * *    * * *  ",
		"  *     * * **  ",
		"   **********   ",
		" ************** ",
		"*  *  *  *  *  *",
		"*  *  *  *  *  *",
		"*  *  *  *  *  *",
		"  ************  ",
		" *            * ",
		" * ** * ***** * ",
		" * *        * * ",
		" *    ***** * * ",
		" * *  *  *  * * ",
		" *   *****  * * ",
		" * *        * * ",
		" * ********** * ",
		" *            * ",
		"  ************  ",
		"    ********    ",
		"  ***      ***  ",
		" * * *    ** ** ",
		"* * **    * * **",
		"*****      *****"
L92:
	.xpic	"       *        ",
		"       *        ",
		"       *        ",
		"       *        ",
		"       *        ",
		"      ***       ",
		"      ***       ",
		"      ***       ",
		"     *****      ",
		"**   ** **   ** ",
		" ***** * *****  ",
		"  ***********   ",
		" *************  ",
		"**    ***    ** ",
		"       *        ",
		"                "
L93:
	.pic	"   *    ",
		"   *    ",
		"   *    ",
		"  * *   ",
		" *****  ",
		"** * ** ",
		"******* "
L94:
	.pic	"*       ",
		"*       ",
		"*       "
L95:
	.pic	"  ***   ",
		" ****  *",
		"**    **",
		"****  **",
		" **** **",
		"   ** **",
		"***** **",
		"****   *",
		"***   **",
		"***  ***",
		"*   *** ",
		"    **  ",
		"    **  ",
		"    **  ",
		"*** ****",
		"***  ***",
		"*   *** ",
		"** *****",
		"** ** **",
		"** **  *",
		"** *****",
		"** *****",
		"** ** **",
		"*  **  *",
		"    *** ",
		"   **** ",
		"* ***   ",
		"* **    ",
		"* ****  ",
		"  **    ",
		"* ***** ",
		"*  **** "
L96:
	.pic	"**    **",
		"**    **",
		"**    **",
		"**    **",
		"**    **",
		"***   **",
		" **** **",
		"  *** **",
		" **  ** ",
		" **  ** ",
		" **  ** ",
		" **  ** ",
		" **  ** ",
		" ****** ",
		"  ****  ",
		"   **   ",
		"  ***   ",
		" ****  *",
		"***   **",
		"**    **",
		"****   *",
		"**      ",
		"***** **",
		" **** **",
		"***     ",
		"***     ",
		"        ",
		"**      ",
		"***     ",
		" **     ",
		"***     ",
		"**      "
L97:
	.xpic	"  ****          ",
		" *****          ",
		"***             ",
		"**              ",
		"****   ****     ",
		" ****  *****   *",
		"   *** ** *** **",
		"    ** **  ** **",
		"    ** **  ** **",
		"****** ****** **",
		"*****  *****   *",
		"       **       ",
		"       **       ",
		"       **       ",
		"******    ******",
		"****************"

	.xpic	"                ",
		"                ",
		"                ",
		"                ",
		"***    ***  *** ",
		"****  **** *****",
		"* ** ***   **  *",
		"  ** **    *****",
		"  ** **    **   ",
		"**** ***** *****",
		"****  ****  ****",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************"

	.xpic	"    ****        ",
		"   *****        ",
		"  ***           ",
		"  **            ",
		"  ***** **   ***",
		"  ***** **  ****",
		"* **       *** *",
		"* **    ** **  *",
		"  **    ** **  *",
		"* **    ** *****",
		"* **    **  ****",
		"               *",
		"            ****",
		"            ****",
		"***********     ",
		"****************"

	.xpic	"  **     **     ",
		"  **     **     ",
		"  **     **     ",
		"  **     **     ",
		"  ****   ****   ",
		"* *****  ****   ",
		"* ** *** **     ",
		"* **  ** **     ",
		"* **  ** ***    ",
		"* **  **  ****  ",
		"* **  **   ***  ",
		"*               ",
		"*               ",
		"                ",
		" ***************",
		"****************"

	.xpic	"  ****    ****  ",
		" ******  ****** ",
		"***  ** ***  ** ",
		"**   ** **   ** ",
		"    *** **   ** ",
		"   ***  **   ** ",
		"  ***   **   ** ",
		" ***    **   ** ",
		"***     **   ** ",
		"******* ******* ",
		"*******  *****  ",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************"

	.xpic	"  ****  **   ***",
		" ****** **   ***",
		"***  ** **   ** ",
		"**   ** **   ** ",
		"**   ** **  **  ",
		"******* **  **  ",
		" ****** **  *   ",
		"     ** **  *   ",
		"     ** **      ",
		"******* ** **   ",
		"******  ** **   ",
		"                ",
		"                ",
		"                ",
		"****************",
		"****************"
L98:
	.pic	"  ****  ",
		" *****  ",
		"***    *",
		"**     *",
		"**  ** *",
		"**  ** *",
		"****** *",
		" *****  ",
		" *** ***",
		"**** ***",
		"**      ",
		"*      *",
		"***    *",
		"*      *",
		"****   *",
		"****   *",
		"***     ",
		"***     ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"****    ",
		"*****   ",
		"** *** *",
		"**  ** *",
		"****** *",
		"*****  *",
		"** *** *",
		"**  **  ",
		" ***   *",
		"****  **",
		"**   ***",
		"*    ** ",
		"***  ***",
		"*    ** ",
		"**** ** ",
		"**** ** ",
		"**   ***",
		"*** ****",
		" ** ** *",
		" ** **  ",
		"*** **  ",
		" ** **  ",
		" ** ****",
		" ** ****",
		"   **  *",
		"*  **  *",
		"** **  *",
		"** *****",
		"**  ****",
		"**   ** ",
		"**   ** ",
		"*    ** ",
		"*  **   ",
		"*  **   ",
		"*  **   ",
		"*  **   ",
		"   **   ",
		"        ",
		"   **   ",
		"   **   "
L99:
	.pic	"*       "
L100:
	.pic	"********",
		"* * * * ",
		" * * * *",
		"********"
L101:
	.byte	0x00
L102:
	.byte	0x00
L103:
	.byte	0x00
L104:
	.byte	0x00
L105:
	.byte	0x00
L106:
	.byte	0x00
L107:
	.ds	0x2
L108:
	.byte	0x00
L109:
	.byte	0x00
L110:
	.ds	0x5
L111:
	.byte	0x00
L112:
	.byte	0x00
L113:
	.byte	0x00
L114:
	.ds	0x2
L115:
	.byte	0x00
L116:
	.ds	0x3
L117:
	.byte	0x00
L118:
	.ds	0x10
L119:
	.ds	0xB0
