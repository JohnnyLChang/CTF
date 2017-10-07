; Path: funic!fuug!mcsun!uunet!olivea!samsung!noose.ecn.purdue.edu!author.ecn.purdue.edu!catto
; From: catto@author.ecn.purdue.edu (Erin S Catto)
; Newsgroups: comp.sys.handhelds
; Subject: Ant v1.0 Library for HP48sx
; Keywords: games chip schip
; Message-ID: <1991Aug2.011951.19907@noose.ecn.purdue.edu>
; Date: 2 Aug 91 01:19:51 GMT
; Sender: root@noose.ecn.purdue.edu (ECN System Management)
; Organization: Purdue University Engineering Computer Network
; Lines: 695
;
; This should eventually be posted on comp.sources.hp48, but I wanted
; to make it available to those who only have access to the HP BBS.
; --------------------------------------------------------------------
;
; Ant v1.0, "In Search of Coke"
; =============================
;
;    Rumours through the grape vine of the local ant community
;    indicate that there is a partially empty Coke can in Zoom's
;    room.  So far many brave ants have gone in search of the
;    mystic can, yet none have returned.  They are feared to be
;    dead.  It is your mission as Bink to find a safe path to the
;    Coke can so that others may follow.  Beware, however, for
;    Zoom has set many treacherous obsticles to block you and
;    booby traps to zap you.  Bink has only his cool nerves and
;    jumping ability (the only jumping ant in the world) to help
;    him on this journey.
;
;
; What is:  Ant v1.0 is a SCHIP v1.1 game contained in a library which
;	    includes SCHIP v1.1 and accessory programs written in System
;	    RPL.  SCHIP v1.1 is accessible to run other games, such as
;	    H. Piper and Joust.
;
; How:	    Ant v1.0 was programmed using the Chipper assembler.  The
;	    System RPL bits were written using Hewlett Packard's System
;	    RPL compiler.  Graphics and animation were developed on
;	    the HP48 using the graphics interface and User RPL.	 The
;	    final directory containing the programs and GROBs was con-
;	    verted into a library using HP's PC based program USRLIB.EXE.
;
; Install:  1)	Download the attached program to your HP48 using ASCII
;		file transfer.
;	    2)	Recall the string to the stack.
;	    3)	Execute ASC-> (a decoding program found on comp.sources.hp48)
;		You must have a RAM card to do this since the file is so
;		large.	I suggest obtaining UUDECODE for PCs from the HP
;		BBS, user.programs conference.
;	    4)	Type :n: x  (n is a RAM port, x is any # - just type 0)
;	    5)	Type STO
;	    6)	Turn the HP48 off then on.
;	    7)	The ANT Library attaches itself to the HOME directory.
;
; Play:	    Enter the library menu.  Enter the Ant library.  Execute INFO.
;	    Read the credits.  Press any key.  Read the key assignments.
;	    Press any key.  Press BEEP (actually BEeP) menu key to toggle
;	    the RPL music.  Press ANT to enter the title screen.  Press
;	    any key (except ATTN, will abort) to play the game.	 Use the
;	    key assignments noted in the INFO program.
;
; Using SCHIP:	Put your SCHIP program string into level one. Press SCHIP.
;		You may want to put the SCHIP command in your CST menu.
;
; Hints:    1)	Pressing the jump key and the right key simultaneously
;		will help clearing large obsticles.  Actually, press the
;		jump key slightly ahead of the right key.
;	    2)	Being of little mass, Bink can stop on a dime and change
;		course in mid-air at will.
;	    3)	This game has no randomization.	 Learn the terrain.
;
; Credits:  1)	Erik Bryntse:  SCHIP v1.1.
;	    2)	Christian Egeberg:  Chipper Assembler v1.12.
;	    3)	Andreas Gustafsson:  Original adaption of CHIP to the HP48
;	    4)	I take full credit for the design and development of
;		Ant v1.0.  The game theme is original as far as I know.
;
; Notice:   1)	I take no blame for worn calculator keys.
;	    2)	There are many tricks to getting around Ant v1.0.
;		Be aware of spoilers when posting to the net.
;	    3)	Surprisingly only about 3.2 kbytes out of the 11 kbytes
;		library are used by the SCHIP Ant game.	 About 2.2 kbytes
;		are taken by SCHIP.  It would not be unresonable for me
;		to release an abreviated version if requests are given.
;	    3)	Have fun and give me feedback.
;
;
;			      Be an Ant,
;
;			      Zoom
;			      catto@ecn.purdue.edu
;
	.title	"Ant version 1.0", "Copyright (C) 1991 Erin S Catto"
	.xref	on
;
	jump	main
	.byte	10
	.ascii	"Ant version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 Erin S Catto"
	.byte	10
	.align
main:
	high
	load	v0, 254
	load	v1, 0
	load	i, L79
	save	v1
	call	L4
	call	L17
	load	v5, 0
	load	vA, 1
	load	vB, 0
	load	vD, 0
	load	vE, 0
L2:
	call	L18
	skip.eq vF, 0
	jump	L20
	skip.ne v5, 253
	jump	L9
L3:
	skip.ne v7, 204
	call	L6
	skip.ne v1, 251
	jump	L36
	skip.ne v1, 252
	jump	L43
	skip.ne v1, 250
	jump	L49
	skip.ne v1, 249
	jump	L54
	load	v0, 2
	skip.eq v7, 204
	call	delay_60ths
	jump	L2
L4:
	load	vE, 0
L5:
	load	i, L75
	add	i, vE
	load	v0, 46
	save	v0
	add	v0, 9
	load	v1, 124
	load	i, L86
	draw	v1, v0, 4
	load	v0, 1
	call	L33
	load	v0, 2
	call	delay_60ths
	skip.eq vE, 31
	scleft
	add	vE, 1
	skip.eq vE, 32
	jump	L5
	load	v0, 4
	load	v1, 4
	load	i, L87
	draw	v0, v1
	ret
L6:
	skip.ne vB, 0
	call	L10
	add	vB, 255
	load	i, L80
	restore v1
	load	i, L75
	add	i, vE
	save	v0
	add	vE, 1
	load	v2, 31
	and	vE, v2
	skip.ne v1, 254
	jump	L7
	skip.ne v1, 255
	jump	L8
	add	v0, 9
	load	v2, 124
	load	i, L86
	add	i, vD
	draw	v2, v0, 4
	ret
L7:
	add	v0, 7
	load	v1, 124
	load	i, L89
	draw	v1, v0, 4
	ret
L8:
	load	v1, 0
	skip.ne vB, 2
	load	v1, 8
	skip.ne vB, 1
	load	v1, 16
	skip.ne vB, 0
	load	v1, 24
	load	i, L88
	add	i, v1
	load	v1, 124
	add	v0, 1
	draw	v1, v0, 8
	add	v0, 8
	load	i, L86
	add	i, vD
	draw	v1, v0, 4
	ret
L9:
	skip.ne v7, 204
	add	v3, 252
	load	i, L95
	draw	v3, v4
	skip.eq v3, 0
	add	v3, 252
	skip.eq v3, 0
	draw	v3, v4
	skip.ne v3, 0
	load	v5, 0
	jump	L3
L10:
	load	i, L79
	restore v1
	add	v0, 2
	skip.ne v0, 254
	call	L12
	save	v0
	load	i, L76
	skip.ne v1, 1
	load	i, L77
	add	i, v0
	restore v1
	load	i, L80
	save	v1
	load	v2, 240
	dif	v2, v1
	skip.ne vF, 0
	jump	L11
	skip.ne v1, 254
	jump	L13
	skip.ne v1, 255
	jump	L14
	skip.ne v1, 253
	jump	L15
	jump	L16
L11:
	load	vB, v1
	ret
L12:
	load	v1, 1
	load	v0, 0
	load	i, L79
	save	v1
	ret
L13:
	load	vB, 12
	ret
L14:
	load	vB, 4
	ret
L15:
	load	vB, 1
	load	v5, 253
	load	v4, v0
	add	v4, 249
	load	v0, 112
	load	i, L92
	draw	v0, v4
	load	v0, 4
	call	L33
	load	v3, 96
	load	i, L95
	draw	v3, v4
	load	v0, 2
	call	L33
	load	v0, 2
	call	delay_60ths
	load	v0, 1
	call	L33
	load	v0, 112
	load	i, L92
	draw	v0, v4
	ret
L16:
	load	vB, 1
	ret
L17:
	load	v6, 0
	load	v8, 46
	load	vC, 0
	load	i, L85
	draw	v6, v8
	ret
L18:
	load	v7, 0
	call	L27
	call	L22
	load	v2, vC
	load	v0, 12
	skip.ne v0, key
	call	do_right_key
	load	v0, 3
	skip.ne v0, key
	call	do_left_key
	load	v0, v6
	skip.eq v7, 204
	add	v6, v7
	load	v1, v8
	add	v8, v9
	load	i, L85
	add	i, v2
	draw	v0, v1
	skip.ne v7, 204
	scleft
	load	i, L85
	add	i, vC
	draw	v6, v8
	ret
L19:
	load	v7, 0
	call	L27
	call	L22
	load	v2, vC
	load	v0, 12
	skip.ne v0, key
	call	do_right_key
	skip.ne v7, 204
	load	v7, 4
	load	v0, 3
	skip.ne v0, key
	call	do_left_key
	load	v0, v6
	add	v6, v7
	load	v1, v8
	add	v8, v9
	load	i, L85
	add	i, v2
	draw	v0, v1
	load	i, L85
	add	i, vC
	draw	v6, v8
	ret
L20:
	load	v1, 0
L21:
	draw	v6, v8
	load	v0, 2
	call	L33
	load	v0, 2
	call	delay_60ths
	add	v1, 1
	skip.eq v1, 7
	jump	L21
	load	v0, 30			; wait 1/2 a second
	call	delay_60ths
	exit
L22:
	load	v0, 10
	skip.eq v0, key
	jump	L24
	skip.ne vA, 0
	ret
	skip.ne vA, 1
	call	L23
	load	vA, 2
	load	v9, 252
	load	i, L78
	restore v0
	skip.eq v8, v0
	ret
	load	vA, 0
	load	v9, 254
	ret
L23:
	load	v0, 2
	call	L33
	load	v0, v8
	add	v0, 236
	load	i, L78
	save	v0
	ret
L24:
	skip.ne vA, 2
	jump	L26
	load	v0, v6
	call	L28
	skip.ne v8, v0
	jump	L25
	load	v0, v6
	add	v0, 12
	call	L28
	skip.ne v8, v0
	jump	L25
	ret
L25:
	load	vA, 1
	ret
L26:
	load	vA, 0
	load	v9, 254
	ret
L27:
	skip.ne vA, 2
	ret
	load	v0, 4
	skip.ne v9, 254
	load	v0, 2
	load	v9, v0
	load	v0, v6
	call	L28
	skip.ne v8, v0
	load	v9, 0
	load	v0, v6
	add	v0, 12
	call	L28
	skip.ne v8, v0
	load	v9, 0
	skip.ne v9, 4
	load	vA, 0
	ret
L28:
	lsr	v0
	lsr	v0
	add	v0, vE
	load	v1, 31
	and	v0, v1
	load	i, L75
	add	i, v0
	restore v0
	load	v1, v0
	ret
do_right_key:
	load	v0, 0
	skip.ne vC, 0
	load	v0, 32
	load	vC, v0
	load	v0, v6
	add	v0, 16
	call	L28
	sub	v0, v8
	skip.ne vF, 0
	ret
	load	v7, 4
	skip.ne v6, 56
	load	v7, 204
	skip.ne v1, v8
	jump	L32
	ret
do_left_key:
	load	v0, 64
	skip.ne vC, 64
	load	v0, 96
	load	vC, v0
	skip.ne v6, 0
	ret
	load	v0, v6
	add	v0, 252
	call	L28
	sub	v0, v8
	skip.ne vF, 0
	ret
	load	v7, 252
	skip.ne v1, v8
	jump	L31
	ret
L31:
	load	v0, v6
	call	L28
	dif	v0, v8
	skip.ne vF, 0
	load	v9, 252
	ret
L32:
	load	v0, v6
	add	v0, 12
	call	L28
	dif	v0, v8
	skip.ne vF, 0
	load	v9, 252
	ret
L33:
	load	tone, v0
	lsl	v0
	jump	delay_60ths
delay_60ths:
	load	time, v0
L35:
	load	v0, time
	skip.eq v0, 0
	jump	L35
	ret
L36:
	call	L38
	call	L39
L37:
	call	L19
	skip.eq vF, 0
	jump	L20
	call	L40
	skip.ne v6, 112
	jump	L41
	jump	L37
L38:
	load	v0, 1
	call	L33
	load	i, L85
	add	i, vC
	draw	v6, v8
	add	v6, 252
	draw	v6, v8
	skip.eq v6, 0
	jump	L38
	ret
L39:
	load	v3, 9
	load	v4, 37
	load	v5, 4
	load	v0, 24
	load	i, L90
	draw	v0, v3
	add	v0, 20
	draw	v0, v4
	add	v0, 20
	draw	v0, v3
	add	v0, 20
	draw	v0, v4
	ret
L40:
	skip.ne v3, 9
	load	v5, 4
	skip.ne v3, 37
	load	v5, 252
	load	i, L90
	load	v0, 24
	load	v1, v3
	add	v3, v5
	draw	v0, v1
	draw	v0, v3
	load	v0, 64
	draw	v0, v1
	draw	v0, v3
	load	v0, 44
	load	v1, v4
	sub	v4, v5
	draw	v0, v1
	draw	v0, v4
	load	v0, 84
	draw	v0, v1
	draw	v0, v4
	ret
L41:
	add	vD, 4
L42:
	scleft
	load	i, L75
	add	i, vE
	load	v0, 42
	save	v0
	add	v0, 9
	load	v1, 124
	load	i, L86
	add	i, vD
	draw	v1, v0, 4
	load	v0, 1
	call	L33
	load	v0, 2
	call	delay_60ths
	add	vE, 1
	skip.ne vE, 32
	load	vE, 0
	add	v6, 252
	skip.eq v6, 0
	jump	L42
	jump	L2
L43:
	call	L38
	call	L45
L44:
	call	L46
	call	L19
	skip.eq vF, 0
	jump	L20
	skip.ne v6, 112
	jump	L41
	jump	L44
L45:
	load	v0, 112
	load	v1, 15
	load	v2, 254
	load	v3, 0
	load	i, L81
	save	v3
	load	i, L91
	draw	v0, v1
	ret
L46:
	load	i, L81
	restore v3
	load	v4, v2
	skip.ne v2, 2
	load	v4, 254
	skip.ne v2, 254
	load	v4, 2
	skip.ne v1, 17
	call	L47
	skip.ne v1, 33
	call	L48
	load	v2, v4
	load	v4, v3
	add	v3, 32
	skip.ne v3, 128
	load	v3, 0
	load	i, L91
	add	i, v4
	load	v4, v1
	add	v1, v2
	load	v5, v0
	add	v0, 252
	draw	v5, v4
	load	i, L91
	add	i, v3
	skip.eq v5, 0
	draw	v0, v1
	load	i, L81
	save	v3
	skip.eq v5, 0
	ret
	jump	L45
L47:
	load	v4, 4
	skip.ne v2, 252
	load	v4, 254
	ret
L48:
	load	v4, 252			; 4.2 second beep
	skip.ne v2, 4
	load	v4, 2			; 1/30 second beep
	skip.ne v4, 2
	load	tone, v4
	ret
L49:
	call	L51
L50:
	call	L52
	call	L19
	skip.eq vF, 0
	jump	L20
	skip.eq v6, 112
	jump	L50
	jump	L41
L51:
	load	v3, 112
	load	v4, 15
	load	v5, 0
	load	i, L96
	draw	v3, v4
	ret
L52:
	load	v0, v3
	add	v0, 12
	call	L28
	add	v1, 249
	skip.eq v4, v1
	call	L53
	load	v0, v3
	add	v3, 252
	load	i, L96
	add	i, v5
	add	v5, 32
	draw	v0, v1
	load	i, L96
	add	i, v5
	skip.eq v0, 0
	draw	v3, v4
	skip.eq v0, 0
	ret
	jump	L51
L53:
	load	v1, v4
	add	v4, 4
	load	v0, 2
	load	tone, v0
	ret
L54:
	call	L38
	call	L57
	load	vE, 0
	call	L58
L55:
	call	L66
	skip.eq vF, 0
	jump	L20
	skip.ne v6, 112
	jump	L74
	call	L56
	load	v0, 3
	call	delay_60ths
	jump	L55
L56:
	skip.ne vD, 0
	jump	L61
	skip.ne vD, 2
	jump	L62
	skip.ne vD, 4
	jump	L60
	skip.ne vD, 6
	jump	L59
	skip.ne vD, 8
	jump	L64
	jump	L65
L57:
	load	v3, 104
	load	v4, 39
	load	v5, 0
	load	i, L92
	draw	v3, v4
	ret
L58:
	load	vB, 0
	load	v5, 0
	load	i, L84
	add	i, vE
	restore v0
	load	vD, v0
	add	vE, 1
	skip.ne vE, 20
	load	vE, 0
	skip.ne vD, 8
	jump	L63
	ret
L59:
	load	v4, 39
	load	v2, v5
	add	v5, 32
	skip.ne v5, 64
	load	v5, 0
	load	v0, v3
	add	v3, 4
	load	i, L93
	add	i, v2
	skip.ne v0, 72
	load	i, L92
	draw	v0, v4
	load	i, L93
	add	i, v5
	skip.ne v3, 104
	load	i, L92
	draw	v3, v4
	skip.eq v3, 104
	ret
	jump	L58
L60:
	load	v4, 39
	load	v2, v5
	add	v5, 32
	skip.ne v5, 64
	load	v5, 0
	load	v0, v3
	add	v3, 252
	load	i, L94
	add	i, v2
	skip.ne v0, 104
	load	i, L92
	draw	v0, v4
	load	i, L94
	add	i, v5
	skip.ne v3, 72
	load	i, L92
	draw	v3, v4
	skip.eq v3, 72
	ret
	jump	L58
L61:
	load	i, L82
	add	i, vB
	restore v2
	load	i, L92
	add	i, v5
	draw	v3, v4
	load	i, L92
	add	i, v2
	draw	v0, v1
	load	v3, v0
	load	v4, v1
	load	v5, v2
	load	v0, 1
	skip.ne v5, 32
	call	L33
	add	vB, 3
	skip.eq vB, 30
	ret
	jump	L58
L62:
	load	i, L83
	add	i, vB
	restore v2
	load	i, L92
	add	i, v5
	draw	v3, v4
	load	i, L92
	add	i, v2
	draw	v0, v1
	load	v3, v0
	load	v4, v1
	load	v5, v2
	load	v0, 1
	skip.ne v5, 32
	call	L33
	add	vB, 3
	skip.eq vB, 30
	ret
	jump	L58
L63:
	load	v5, v3
	add	v5, 240
	load	i, L95
	draw	v5, v4
	load	v0, 1
	call	L33
	load	v0, 1
	call	L33
	ret
L64:
	load	v0, v5
	add	v5, 252
	load	i, L95
	draw	v0, v4
	skip.eq v0, 0
	draw	v5, v4
	skip.eq v0, 0
	ret
	jump	L58
L65:
	add	v5, 1
	skip.eq v5, 6
	ret
	jump	L58
L66:
	load	v7, 0
	call	L71
	call	L67
	load	v2, vC
	load	v0, 12
	skip.ne v0, key
	call	L72
	load	v0, 3
	skip.ne v0, key
	call	L73
	load	v0, v6
	add	v6, v7
	load	v1, v8
	add	v8, v9
	load	i, L85
	add	i, v2
	draw	v0, v1
	load	i, L85
	add	i, vC
	draw	v6, v8
	ret
L67:
	load	v0, 10
	skip.eq v0, key
	jump	L68
	skip.ne vA, 0
	ret
	load	v0, 2
	skip.ne vA, 1
	call	L33
	load	vA, 2
	load	v9, 252
	skip.eq v8, 26
	ret
	load	vA, 0
	load	v9, 254
	ret
L68:
	skip.ne vA, 2
	jump	L70
	skip.ne v8, 46
	jump	L69
	ret
L69:
	load	vA, 1
	ret
L70:
	load	vA, 0
	load	v9, 254
	ret
L71:
	skip.ne vA, 2
	ret
	load	v0, 4
	skip.ne v9, 254
	load	v0, 2
	load	v9, v0
	skip.ne v8, 46
	load	v9, 0
	skip.ne v9, 4
	load	vA, 0
	ret
L72:
	load	v0, 0
	skip.ne vC, 0
	load	v0, 32
	load	vC, v0
	load	v7, 4
	ret
L73:
	load	v0, 64
	skip.ne vC, 64
	load	v0, 96
	load	vC, v0
	skip.ne v6, 0
	ret
	load	v7, 252
	ret
L74:
	load	v0, 1
	flags.save	v0
	load	v0, 2
	call	L33
	call	delay_60ths
	load	v0, 4
	call	L33
	call	delay_60ths
	load	v0, 8
	call	L33
	load	v0, 30
	call	delay_60ths
	clear
	exit
L75:
	.ds	0x20
L76:
	.byte	0x2A
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x08
	.ascii	"."
	.byte	0xFE
	.byte	0x16
	.byte	0x08
	.byte	0x1A
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	"*"
	.byte	0x10
	.ascii	"*"
	.byte	0xFD
	.ascii	'"'
	.byte	0x03
	.ascii	'"'
	.byte	0xFF
	.ascii	'"'
	.byte	0x08
	.ascii	"&"
	.byte	0x10
	.ascii	"."
	.byte	0xFE
	.ascii	"&"
	.byte	0x04
	.ascii	"*"
	.byte	0x04
	.ascii	"*"
	.byte	0xFF
	.ascii	"*"
	.byte	0x06
	.ascii	"*"
	.byte	0xFF
	.ascii	"*"
	.byte	0x06
	.ascii	"&"
	.byte	0x0A
	.ascii	"&"
	.byte	0x06
	.ascii	"."
	.byte	0xFE
	.ascii	"&"
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.byte	0x1E
	.byte	0x03
	.byte	0x1E
	.byte	0xFD
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x08
	.byte	0x1A
	.byte	0xFF
	.ascii	"2"
	.byte	0xFE
	.ascii	"*"
	.byte	0x06
	.ascii	"*"
	.byte	0x1C
	.ascii	"&"
	.byte	0x04
	.ascii	"&"
	.byte	0xFC
	.byte	0x1E
	.byte	0x04
	.ascii	"."
	.byte	0xFE
	.byte	0x1A
	.byte	0x05
	.byte	0x16
	.byte	0x04
	.ascii	"."
	.byte	0xFE
	.ascii	"&"
	.byte	0x08
	.ascii	"&"
	.byte	0xFF
	.ascii	"&"
	.byte	0xFF
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x08
	.byte	0x16
	.byte	0xFD
	.ascii	"."
	.byte	0x0E
	.byte	0x16
	.byte	0x08
	.ascii	"."
	.byte	0xFE
	.byte	0x16
	.byte	0x04
	.ascii	"."
	.byte	0xFE
	.byte	0x16
	.byte	0x03
	.ascii	"."
	.byte	0xFE
	.byte	0x16
	.byte	0x04
	.byte	0x16
	.byte	0xFD
	.ascii	"."
	.byte	0xFE
	.ascii	"&"
	.byte	0x08
	.ascii	"."
	.byte	0x06
	.ascii	"*"
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x04
	.ascii	"2"
	.byte	0xFF
	.ascii	"2"
	.byte	0xFF
	.ascii	"2"
	.byte	0xFF
	.ascii	"2"
	.byte	0xFF
	.ascii	"."
	.byte	0x08
	.byte	0x1E
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	"*"
	.byte	0x04
	.ascii	"2"
	.byte	0xFE
	.ascii	"."
	.byte	0x04
	.ascii	"."
	.byte	0xFD
	.ascii	"*"
	.byte	0x04
	.byte	0x16
	.byte	0x03
	.ascii	"*"
	.byte	0x1C
	.ascii	"&"
	.byte	0x04
	.ascii	"&"
	.byte	0xFB
	.ascii	"2"
	.byte	0xFE
	.ascii	"*"
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x04
	.byte	0x1A
	.byte	0xFF
	.ascii	'"'
	.byte	0xFF
	.ascii	"*"
	.byte	0xFF
	.ascii	"&"
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.ascii	"2"
	.byte	0xFE
	.byte	0x16
	.byte	0x03
	.ascii	"2"
	.byte	0xFE
	.byte	0x1E
	.byte	0x03
	.ascii	"2"
	.byte	0xFE
	.byte	0x16
	.byte	0x03
	.byte	0x16
	.byte	0xFD
	.ascii	"2"
	.byte	0xFE
	.byte	0x1E
	.byte	0x03
	.ascii	"2"
	.byte	0xFE
	.byte	0x16
	.byte	0x03
	.ascii	"."
	.byte	0xFF
	.ascii	"."
	.byte	0xFF
	.ascii	"."
	.byte	0xFF
	.ascii	"."
	.byte	0x08
	.ascii	"*"
	.byte	0x04
	.byte	0x16
	.byte	0x06
	.ascii	"."
	.byte	0x04
	.ascii	"*"
	.byte	0x04
	.ascii	"&"
	.byte	0x04
	.ascii	'"'
	.byte	0x04
	.byte	0x1E
	.byte	0x04
	.byte	0x1A
	.byte	0x04
	.byte	0x16
	.byte	0x08
	.byte	0x16
	.byte	0xFA
	.ascii	"."
	.byte	0x04
	.ascii	"."
	.byte	0xFD
	.ascii	'"'
	.byte	0x03
	.byte	0x1E
	.byte	0x04
L77:
	.byte	0x2E
	.byte	0x02
	.ascii	"&"
	.byte	0x02
	.byte	0x16
	.byte	0x03
	.byte	0x1A
	.byte	0x02
	.ascii	"&"
	.byte	0x05
	.ascii	"&"
	.byte	0xFF
	.ascii	"."
	.byte	0x06
	.byte	0x1A
	.byte	0x03
	.byte	0x1E
	.byte	0x03
	.ascii	'"'
	.byte	0x06
	.ascii	"&"
	.byte	0x04
	.ascii	"&"
	.byte	0xFD
	.byte	0x16
	.byte	0x06
	.ascii	"2"
	.byte	0xFE
	.ascii	"2"
	.byte	0xFF
	.ascii	"."
	.byte	0x06
	.byte	0x1A
	.byte	0x03
	.byte	0x16
	.byte	0x03
	.byte	0x1E
	.byte	0x02
	.ascii	'"'
	.byte	0x02
	.ascii	"&"
	.byte	0x06
	.byte	0x1A
	.byte	0x04
	.byte	0x1E
	.byte	0x06
	.byte	0x1E
	.byte	0xFD
	.ascii	"2"
	.byte	0xFE
	.ascii	"&"
	.byte	0x04
	.byte	0x16
	.byte	0x03
	.ascii	'"'
	.byte	0x03
	.byte	0x1A
	.byte	0x05
	.byte	0x1A
	.byte	0xFF
	.byte	0x16
	.byte	0x03
	.byte	0x16
	.byte	0xFD
	.ascii	"."
	.byte	0x06
	.byte	0x1E
	.byte	0x02
	.byte	0x1A
	.byte	0x02
	.byte	0x16
	.byte	0x04
	.ascii	"2"
	.byte	0xFE
	.byte	0x1E
	.byte	0x04
	.byte	0x1E
	.byte	0xFD
	.ascii	"."
	.byte	0x08
	.ascii	"."
	.byte	0xFF
	.ascii	"*"
	.byte	0x06
	.byte	0x16
	.byte	0x04
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x01
	.byte	0x1A
	.byte	0x01
	.byte	0x16
	.byte	0x04
	.byte	0x1A
	.byte	0x04
	.byte	0x1A
	.byte	0xFD
	.byte	0x16
	.byte	0x04
	.ascii	"2"
	.byte	0xFE
	.ascii	"2"
	.byte	0xFF
	.ascii	"."
	.byte	0x05
	.ascii	"*"
	.byte	0x02
	.ascii	"&"
	.byte	0x03
	.ascii	'"'
	.byte	0x02
	.byte	0x1E
	.byte	0x03
	.byte	0x1A
	.byte	0x02
	.byte	0x16
	.byte	0x03
	.byte	0x1A
	.byte	0x02
	.byte	0x1E
	.byte	0xFF
	.ascii	"."
	.byte	0x06
	.ascii	'"'
	.byte	0x02
	.byte	0x16
	.byte	0x08
	.byte	0x16
	.byte	0xFD
	.ascii	"."
	.byte	0x06
	.byte	0x16
	.byte	0x03
	.ascii	"."
	.byte	0x06
	.byte	0x16
	.byte	0x03
	.ascii	"."
	.byte	0x06
	.byte	0x16
	.byte	0x03
	.ascii	"."
	.byte	0x06
	.byte	0x16
	.byte	0x03
	.byte	0x16
	.byte	0xFF
	.byte	0x16
	.byte	0x02
	.ascii	"."
	.byte	0x06
	.byte	0x16
	.byte	0x03
	.byte	0x1E
	.byte	0xFE
	.byte	0x1A
	.byte	0x05
	.byte	0x1E
	.byte	0x04
	.ascii	'"'
	.byte	0x03
	.ascii	"&"
	.byte	0x02
	.ascii	"*"
	.byte	0x01
	.ascii	"."
	.byte	0x05
	.ascii	"."
	.byte	0xFF
	.ascii	"*"
	.byte	0x04
	.ascii	"."
	.byte	0x04
	.ascii	"."
	.byte	0xFF
	.ascii	'"'
	.byte	0x04
	.ascii	"."
	.byte	0x05
	.ascii	"*"
	.byte	0xFF
	.ascii	"."
	.byte	0x06
	.ascii	"."
	.byte	0xFF
	.ascii	"."
	.byte	0x05
	.ascii	"."
	.byte	0xFF
	.ascii	"."
	.byte	0x05
	.ascii	"."
	.byte	0xFF
	.ascii	"*"
	.byte	0x04
	.ascii	"2"
	.byte	0xFE
	.ascii	"."
	.byte	0x03
	.ascii	"."
	.byte	0xFD
	.ascii	"."
	.byte	0xFF
	.byte	0x1A
	.byte	0x04
	.byte	0x1E
	.byte	0xFE
	.byte	0x1A
	.byte	0x04
	.ascii	'."".'
	.byte	0xF9
L78:
	.ds	0x2
L79:
	.byte	0xFE
	.byte	0x00
L80:
	.ds	0x2
L81:
	.ds	0x4
L82:
	.byte	0x68
	.ascii	"' d"
	.byte	0x1D
	.ascii	"@`"
	.byte	0x15
	.ascii	"`\"
	.byte	0x0F
	.byte	0x80
	.ascii	"X"
	.byte	0x11
	.byte	0xA0
	.ascii	"T"
	.byte	0x0F
	.byte	0xC0
	.ascii	"P"
	.byte	0x15
	.byte	0xE0
	.ascii	"L"
	.byte	0x1D
	.ascii	"@H' H'"
	.byte	0x00
L83:
	.byte	0x48
	.ascii	"' L"
	.byte	0x1D
	.ascii	"@P"
	.byte	0x15
	.byte	0xE0
	.ascii	"T"
	.byte	0x0F
	.byte	0xC0
	.ascii	"X"
	.byte	0x11
	.byte	0xA0
	.ascii	"\"
	.byte	0x0F
	.byte	0x80
	.ascii	"`"
	.byte	0x15
	.ascii	"`d"
	.byte	0x1D
	.ascii	"@h' h'"
	.byte	0x00
L84:
	.byte	0x00
	.byte	0x0A
	.byte	0x08
	.byte	0x06
	.byte	0x04
	.byte	0x08
	.byte	0x02
	.byte	0x0A
	.byte	0x08
	.byte	0x00
	.byte	0x06
	.byte	0x08
	.byte	0x0A
	.byte	0x00
	.byte	0x02
	.byte	0x08
	.byte	0x04
	.byte	0x02
	.byte	0x0A
	.byte	0x08

	.align
L85:
	.xpic	"           *   *",
		"            * * ",
		" ****       *** ",
		"** *** *** ** **",
		"* **************",
		"*********** *** ",
		" **** * ***     ",
		"* *  * * * *    ",
		"* *  * * * *    ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                "
	.xpic	"           *   *",
		"            * * ",
		" ****       *** ",
		"** *** *** ** **",
		"* **************",
		"*********** *** ",
		"  ***  *****    ",
		" * *  * * * *   ",
		" * *  * * * *   ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                "
	.xpic	"*   *           ",
		" * *            ",
		" ***       **** ",
		"** ** *** *** **",
		"************** *",
		" *** ***********",
		"     *** * **** ",
		"    * * * *  * *",
		"    * * * *  * *",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                "
	.xpic	"*   *           ",
		" * *            ",
		" ***       **** ",
		"** ** *** *** **",
		"************** *",
		" *** ***********",
		"    *****  ***  ",
		"   * * * *  * * ",
		"   * * * *  * * ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                "
L86:
	.pic	"****    ",
		"        ",
		"****    ",
		" * *    "

	.pic	"***     ",
		"* **    ",
		"***     ",
		"* **    "

	.pic	"****    ",
		"  *     ",
		"*       ",
		"****    "

	.pic	"****    ",
		"*  *    ",
		"*  *    ",
		"****    "
L87:
	.xpic	"        *       ",
		"        **      ",
		"        ***     ",
		"        ****    ",
		"*************   ",
		"**************  ",
		"*************** ",
		"****************",
		"*************** ",
		"**************  ",
		"*************   ",
		"        ****    ",
		"        ***     ",
		"        **      ",
		"        *       ",
		"                "
L88:
	.pic	"****    ",
		"*       ",
		"* **    ",
		"* *     ",
		"* **    ",
		"* *     ",
		"*       ",
		"*       "
	.pic	"****    ",
		"        ",
		"   *    ",
		"* *     ",
		"  **    ",
		"* *     ",
		"        ",
		"        "
	.pic	"****    ",
		"        ",
		"  *     ",
		"* *     ",
		"* *     ",
		"* *     ",
		"        ",
		"        "
	.pic	"****    ",
		"   *    ",
		"** *    ",
		"* **    ",
		"* **    ",
		"** *    ",
		"   *    ",
		"   *    "
L89:
	.pic	"  *     ",
		"  **    ",
		" ***    ",
		"****    "
L90:
	.xpic	"                ",
		"                ",
		"                ",
		"                ",
		"           *****",
		"          *    *",
		"          **   *",
		"        **     *",
		"      **  * ** *",
		" *****  *   ** *",
		"*     *        *",
		"****************",
		" ***************",
		"                ",
		"                ",
		"                "
L91:
	.xpic	"   **  ***      ",
		"  *  **   *     ",
		" *         *    ",
		"*           *   ",
		"*      *    *   ",
		" *      *   *   ",
		"  *      *   *  ",
		"  *      *    * ",
		" *       *    * ",
		"*       *     * ",
		"*             * ",
		" *          **  ",
		"  *      ***    ",
		"   *    *       ",
		"    ****        ",
		"                "

	.xpic	"                ",
		"       ****     ",
		"      *    *    ",
		"   ***     *    ",
		"  *         *   ",
		" *          *   ",
		"*     ***   *   ",
		"*    *   *   *  ",
		"*   *         * ",
		" *            * ",
		" *            * ",
		"*             * ",
		"*            *  ",
		" *    **    *   ",
		"  *  *  *  *    ",
		"   **    **     "

	.xpic	"                ",
		"        ****    ",
		"       *    *   ",
		"    ***      *  ",
		"  **          * ",
		" *             *",
		" *     *       *",
		" *    *       * ",
		" *    *      *  ",
		"  *   *      *  ",
		"   *   *      * ",
		"   *    *      *",
		"   *           *",
		"    *         * ",
		"     *   **  *  ",
		"      ***  **   "

	.xpic	"     **    **   ",
		"    *  *  *  *  ",
		"   *    **    * ",
		"  *            *",
		" *             *",
		" *            * ",
		" *            * ",
		" *         *   *",
		"  *   *   *    *",
		"   *   ***     *",
		"   *          * ",
		"   *         *  ",
		"    *     ***   ",
		"    *    *      ",
		"     ****       ",
		"                "
L92:
	.xpic	"       *****    ",
		"      *     *   ",
		"      * *   *   ",
		" *** **     *   ",
		"****  *     *   ",
		" * **  *****    ",
		" * * *   *      ",
		" * *  ****      ",
		" ***     **     ",
		"         * *    ",
		"         *  *   ",
		"        * *  *  ",
		"       *  *     ",
		"    * *    *    ",
		"     *      *   ",
		"           *    "

	.xpic	"                ",
		"                ",
		"      *****     ",
		"     *     *    ",
		"     * *   *    ",
		"    **     *    ",
		"     *     *    ",
		"  *** *****     ",
		" ****   *       ",
		"  * ******      ",
		"  * *   * *     ",
		"  * *   *  *    ",
		"  *** ***  *    ",
		"      * *       ",
		"      * ***     ",
		"     **   *     "

	.xpic	"       *****    ",
		"      *     *   ",
		"      * *   *   ",
		" *** **     *   ",
		"****  *     *   ",
		" * **  *****  * ",
		" * * *   *   *  ",
		" * *  *******   ",
		" ***     *      ",
		"         *      ",
		"         *      ",
		"        * *     ",
		"       *   *    ",
		"    * *     *   ",
		"     *       *  ",
		"            *   "

	.xpic	"             *  ",
		"            * * ",
		"           *   *",
		"  *       *     ",
		"* *      *  *  *",
		"  *       *   * ",
		"  *   *  *      ",
		"   * * **       ",
		"   **  **       ",
		" *    *  *      ",
		"******    *     ",
		" * *       *****",
		"* * *      *   *",
		"   * *     *    ",
		"    *      *    ",
		"          **    "

	.xpic	"                ",
		"                ",
		"     *          ",
		"      *       * ",
		" ****  *     * *",
		"*    * *    *   ",
		"*    * *   *    ",
		"*    ******     ",
		"* *  * *   *    ",
		"*    * *    *   ",
		" ****  *     *  ",
		"   *  *       * ",
		"     *       *  ",
		"   ******       ",
		"   **   *       ",
		"   ******       "

	.xpic	"   *            ",
		"  *       *     ",
		"   *     * *    ",
		"    *   *       ",
		"     * *        ",
		"      *         ",
		"      *         ",
		"      *     *** ",
		"   *******  * * ",
		"  *   *   * * * ",
		" *  *****  ** * ",
		"   *     *  ****",
		"   *     ** *** ",
		"   *   * *      ",
		"   *     *      ",
		"    *****       "

	.xpic	"           *    ",
		"       ******   ",
		"       *   **   ",
		"       ******   ",
		"  *       *     ",
		" *       *  *   ",
		"  *     *  **** ",
		"   *    * *    *",
		"    *   * *  * *",
		"     ******    *",
		"    *   * *    *",
		"   *    * *    *",
		"* *     *  **** ",
		" *       *      ",
		"          *     ",
		"                "

	.xpic	"   * *          ",
		"    ***   *     ",
		"   * *   * *    ",
		"  * ** **   *   ",
		" * * * *  *  *  ",
		"  *  *  *     * ",
		"      *  *   *  ",
		"       ** * *   ",
		"       **  *    ",
		"      *  *      ",
		"*    *    ***   ",
		"*****           ",
		"    *           ",
		"    *           ",
		"   **           "

L93:
	.xpic	"    *****       ",
		"   *     *      ",
		"   *   * *      ",
		"   *     ** *** ",
		"   *     *  ****",
		"    *****  ** * ",
		"      *   * * * ",
		"     *****  * * ",
		"    * *     *** ",
		"   *  *         ",
		"   *  *         ",
		"     * *        ",
		"    *   *       ",
		"   *     * *    ",
		"  *       *     ",
		"   *            "
	.xpic	"    *****       ",
		"   *     *      ",
		"   *   * *      ",
		"   *     ** *** ",
		"   *     *  ****",
		"    *****  ** * ",
		"      *   * * * ",
		"     *****  * * ",
		"     **     *** ",
		"     **         ",
		"      **        ",
		"      *         ",
		"      *         ",
		"     **         ",
		"    * *         ",
		"     ***        "
L94:
	.xpic	"       *****    ",
		"      *     *   ",
		"      * *   *   ",
		" *** **     *   ",
		"****  *     *   ",
		" * **  *****    ",
		" * * *   *      ",
		" * *  *****     ",
		" ***     * *    ",
		"         *  *   ",
		"         *  *   ",
		"        * *     ",
		"       *   *    ",
		"    * *     *   ",
		"     *       *  ",
		"            *   "
	.xpic	"       *****    ",
		"      *     *   ",
		"      * *   *   ",
		" *** **     *   ",
		"****  *     *   ",
		" * **  *****    ",
		" * * *   *      ",
		" * *  *****     ",
		" ***     **     ",
		"         **     ",
		"        **      ",
		"         *      ",
		"         *      ",
		"         **     ",
		"         * *    ",
		"        ***     "
L95:
	.xpic	"  ****          ",
		" ** * **        ",
		"** * * * *      ",
		"* * * * * * *   ",
		"** * * * * * * *",
		"* * * * * * *   ",
		"** * * * *      ",
		" ** * **        ",
		"  ****          ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                ",
		"                "
L96:
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *           *  ",
		" *  **   **  *  ",
		"*  **** ****  * ",
		"*  * ** * **  * ",
		"*   **   **   * ",
		"*             * ",
		"*             * ",
		" *    ***    *  ",
		" *   *   *   *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *      **   *  ",
		" *     ****  *  ",
		"*      ** *   * ",
		"*   **  **    * ",
		"*  ****       * ",
		"*  ** *    ** * ",
		"*   **    *   * ",
		" *       *   *  ",
		" *      *    *  ",
		"  *     *   *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *   **      *  ",
		" *  ****     *  ",
		"*   ** *   *  * ",
		"*    **   *   * ",
		"*         *   * ",
		"*    **   *   * ",
		"*   ****   *  * ",
		" *  ** *     *  ",
		" *   **      *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *     *   *   ",
		" *      *    *  ",
		" *  **   *   *  ",
		"*  ** *   *   * ",
		"*  ****    ** * ",
		"*   **        * ",
		"*      **     * ",
		"*     ** *    * ",
		" *    ****   *  ",
		" *     **    *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *   *   *   *  ",
		" *    ***    *  ",
		"*             * ",
		"*             * ",
		"*   **   **   * ",
		"*  ** * ** *  * ",
		"*  **** ****  * ",
		" *  **   **  *  ",
		" *           *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *   *     *   ",
		" *    *      *  ",
		" *   *   **  *  ",
		"*   *   * **  * ",
		"* **    ****  * ",
		"*        **   * ",
		"*     **      * ",
		"*    * **     * ",
		" *   ****    *  ",
		" *    **     *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *      **   *  ",
		" *     * **  *  ",
		"*  *   ****   * ",
		"*   *   **    * ",
		"*   *         * ",
		"*   *   **    * ",
		"*  *   * **   * ",
		" *     ****  *  ",
		" *      **   *  ",
		"  *         *   ",
		"   **     **    ",
		"     *****      "
	.xpic	"                ",
		"     *****      ",
		"   **     **    ",
		"  *         *   ",
		" *    **     *  ",
		" *   ****    *  ",
		"*    * **     * ",
		"*     **      * ",
		"*        **   * ",
		"* **    ****  * ",
		"*   *   * **  * ",
		" *   *   **  *  ",
		" *    *      *  ",
		"  *   *     *   ",
		"   **     **    ",
		"     *****      "
