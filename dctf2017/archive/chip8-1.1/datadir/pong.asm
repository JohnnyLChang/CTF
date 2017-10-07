;
; From: Paul Vervalin <vervalin@AUSTIN.LOCKHEED.COM>
; Newsgroups: comp.sys.handhelds
; Subject: PONG for HP48SX
; Keywords: games HP48SX
; Date: 13 Oct 90 01:52:28 GMT
; Organization: Lockheed Austin Div.
;
;
; Copyright (C) 1990 Paul Vervalin.
; Reproduced by permission.
;
;	OK folks here it is!  PONG for the HP48SX written in CHIP-48.
;	Some things you should know before you start playing are...
;	1)	This is my first attempt at programming in CHIP-48, so I
;		know there are probably a few things that could have been
;		done better.
;	2)	The game never ends.  It keeps score, but only up to 9 for
;		each player, then it will roll over to 0.  Sorry, its the
;		only way I could think of to do it.  So, you have to play
;		whoever gets to a number first, wins.
;	3)	It is kind of slow, but then there are two paddles and ball
;		moving around all at once.
;	4)	The player who got the last point gets the serve...
;	5)	Keys 1 and 4 keys (7 and 4 on the HP48) control the up and
;		down of the left player and the C and D keys (/ and * on
;		the HP) control the up and down of the right player.
;
;	I think that's about it, so have fun!
;
; About half of the code was in some way extracted from the BRIX
; program.  So, thanks to whoever wrote the original BRIX game.
;	BRIX is (C) Copyright 1990 Andreas Gustafsson
;		gson@niksula.hut.fi
;
;	Registers
;	---------
;	v0-v3	are scratch registers
;	v4	X coord. of score
;	v5	Y coord. of score
;	v6	X coord. of ball
;	v7	Y coord. of ball
;	v8	X direction of ball motion
;	v9	Y direction of ball motion
;	vA	X coord. of right player paddle
;	vB	Y coord. of right player paddle
;	vC	X coord. of left player paddle
;	vD	Y coord. of left player paddle
;	vE	Score
;	vF	collision detection
;
	.title	"Pong version 1.0",
		"Copyright (C) 1990 Paul Vervalin"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"Pong version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1990 Paul Vervalin"
	.byte	10
	.align
start:
	load	vA, 0x00	; set player A (left side) X coord.
	load	vB, 0x0C	; set player A Y coord.
	load	vC, 0x3F	; set player B (right side) X coord.
	load	vD, 0x0C	; set player B Y coord.
	load	v4, 0x1B	; set score X coord.
	load	v5, 0x00	; set score Y coord.
	load	i, paddle	; get address of paddle sprite
	draw	vA, vB, 6	; draw paddle at location vA vB 6 bytes
	draw	vC, vD, 6	; draw paddle at location vC vD 6 bytes
	load	vE, 0x00	; set score to 00
	call	score
	load	v6, 0x01	; set X coord. of ball to 01
	load	v8, 0x01	; set ball X direction to right
big_loop:
	load	v0, 0x80	; set v0=delay before ball launch
	load	time, v0	; set delay timer
dt_loop:
	load	v0, time	; read delay timer into v0
	skip.eq	v0, 0x00	; skip next instruction if v0=00
	jump	dt_loop
	rnd	v7, 0x17	; set Y coord. to rand # AND 17 (0-23)
	add	v7, 0x08	; so Y coord. is (8-31)
	load	v9, 0xFF	; set ball Y direction to up
	load	i, ball		; get address of ball sprite
	draw	v6, v7, 1	; draw ball at location v6 v7 1 byte
padl_loop:
	load	i, paddle	; get address of paddle sprite
	draw	vA, vB, 6	; draw paddle at location vA vB 6 bytes
	draw	vC, vD, 6	; draw paddle at location vC vD 6 bytes
	load	v0, 0x01	; set v0 to KEY 1
	skip.ne	v0, key		; skip next instruction if KEY in v0 is pressed
	add	vB, 0xFE	; subtract 2 from Y coord. of paddle A
	load	v0, 0x04	; set v0 to KEY 4
	skip.ne	v0, key		; skip next instruction if KEY in v0 is pressed
	add	vB, 0x02	; add 2 to Y coord. of paddle A
	load	v0, 0x1F	; set v0 to max Y coord.
	and	vB, v0		; AND vB with v0
	draw	vA, vB, 6	; draw paddle at location vA vB 6 bytes
	load	v0, 0x0C	; set v0 to KEY C
	skip.ne	v0, key		; skip next instruction if KEY in v0 is pressed
	add	vD, 0xFE	; subtract 2 from Y coord. of paddle B
	load	v0, 0x0D	; set v0 to KEY D
	skip.ne	v0, key		; skip next instruction if KEY in v0 is pressed
	add	vD, 0x02	; add 2 to Y coord. of paddle B
	load	v0, 0x1F	; set v0 to max Y coord.
	and	vD, v0		; AND vD with v0
	draw	vC, vD, 6	; draw paddle at location vC vD 6 bytes
	load	i, ball		; get address of ball sprite
	draw	v6, v7, 1	; draw ball at location v6 v7 1 byte
	add	v6, v8		; move ball in X direction
	add	v7, v9		; move ball in Y direction
	load	v0, 0x3F	; set v0 to max X location
	and	v6, v0		; AND v6 with v0
	load	v1, 0x1F	; set v1 to max Y location
	and	v7, v1		; AND v7 with v0
	skip.ne	v6, 0x00	; skip next instruction if ball not at left
	jump	leftside	; Leftside:  left side handler
	skip.ne	v6, 0x3F	; skip next instruction if ball not at right
	jump	rightside	; Rightside: right side handler
ball_loop:
	skip.ne	v7, 0x1F	; skip next instruction if ball not at bottom
	load	v9, 0xFF	; set Y direction to up
	skip.ne	v7, 0x00	; skip next instruction if ball not at top
	load	v9, 0x01	; set Y direction to down
	draw	v6, v7, 1	; draw ball at location v6 v7 1 byte
	jump	padl_loop
leftside:
	load	v8, 0x01	; set X direction to right
	load	v3, 0x01	; set v2 to 1 in case left misses ball
	load	v0, v7		; set v0 to v7 Y coord. of ball
	sub	v0, vB		; subtract position of paddle from ball
	jump	pad_coll
rightside:
	load	v8, 0xFF	; set X direction to left
	load	v3, 0x0A	; set v2 to 0A (10) in case right misses ball
	load	v0, v7		; set v0 to v7 Y coord. of ball
	sub	v0, vD		; subtract position of paddle from ball
pad_coll:
	skip.ne	vF, 0x01	; skip next instruction if ball not above paddle
	jump	ball_lost
	load	v1, 0x02	; set v1 to 02
	sub	v0, v1		; subtract v1 from v0
	skip.eq	vF, 0x01	; skip next instr. if ball not at top of paddle
	jump	ball_top
	sub	v0, v1		; subtract another 2 from v0
	skip.eq	vF, 0x01	; skip next instr. if ball not at middle of paddle
	jump	pad_hit		; Ball in middle of paddle
	sub	v0, v1		; subtract another 2 from v0
	skip.eq	vF, 0x01	; skip next instr. if ball not at bottom of paddle
	jump	ball_bot
ball_lost:
	load	v0, 0x20	; set lost ball beep delay
	load	tone, v0	; beep for lost ball
	call	score		; erase previous score
	add	vE, v3		; add 1 or 10 to score depending on v3
	call	score		; write new score
	load	v6, 0x3E	; set ball X coord. to right side
	skip.eq	v3, 0x01	; skip next instr. if right player got point
	load	v6, 0x01	; set ball X coord. to left side
	load	v8, 0xFF	; set direction to left
	skip.eq	v3, 0x01	; skip next instr. if right player got point
	load	v8, 0x01	; set direction to right
	jump	big_loop
ball_top:
	add	v9, 0xFF	; subtract 1 from v9, ball Y direction
	skip.ne	v9, 0xFE	; skip next instr. if v9 != FE (-2)
	load	v9, 0xFF	; set v9=FF (-1)
	jump	pad_hit
ball_bot:
	add	v9, 0x01	; add 1 to v9, ball Y direction
	skip.ne	v9, 0x02	; skip next instr. if v9 != 02
	load	v9, 0x01	; set v9=01
pad_hit:
	load	v0, 0x04	; set beep for paddle hit
	load	tone, v0	; sound beep
	jump	ball_loop
score:	load	i, scortmp	; get address of Score
	bcd	vE
	restore v2
	hex	v1
	load	v4, 0x1B
	load	v5, 0x00
	draw	v4, v5, 5
	add	v4, 0x05
	hex	v2
	draw	v4, v5, 5
	ret
paddle:	.pic	"|",
		"|",
		"|",
		"|",
		"|",
		"|"
ball:	.pic	"*",
		" "
scortmp:
	.ds	4
