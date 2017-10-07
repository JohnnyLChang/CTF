; From: Andreas Gustafsson <gson@niksula.hut.fi>
; Newsgroups: comp.archives
; Subject: CHIP48 - A CHIP-8 interpreter for the HP48SX (version 2.20)
; Keywords: HP48SX CHIP-8
; Date: 10 Sep 90 23:29:21 GMT
; Organization: Helsinki University of Technology, FINLAND
;
; Not particularly exciting, but I had to include something to show how
; the interpreter is used.  Uuencode, download to HP48SX using Kermit,
; and run with BRIX CHIP.  Play by pressing the keys 4 and 6.
;
;	BRIX is Copyright (C) 1990 Andreas Gustafsson
;
;	Noncommercial distribution allowed, provided that this
;	copyright message is preserved, and any modified versions
;	are clearly marked as such.
;
;	BRIX makes use of undocumented low-level features of
;	the HP48SX calculator, and may or may not cause loss of data,
;	excessive battery drainage, and/or damage to the calculator
;	hardware.  The Author takes no responsibility whatsoever for
;	any damage caused by the use of this program.
;
;	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
;	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;	PURPOSE.
;
; --------------------------------------------------------------------------
;
; Comments and minor modifications
; Copyright (C) 1998, 2012 Peter Miller
;
;	v5 = the score
;	v6 = ball x
;	v7 = ball y
;	v8 = ball dx
;	v9 = ball dy
;	vC = paddle x
;	vD = paddle y
;	vE = number of lives
;
	.title	"Brix version 1.0",
		"Copyright (C) 1990 Andreas Gustafsson"
	.xref	on
	jump	start

	.byte	10
	.ascii	"Brix version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1990 Andreas Gustafsson"
	.byte	10
	.align
start:
	load	vE, 0x05
	load	v5, 0x00
;
; draw the array of bricks
;
	load	vB, 0x06
array_y_loop:
	load	vA, 0x00
array_x_loop:
	load	i, brick
	draw	vA, vB, 1
	add	vA, 0x04
	skip.eq	vA, 0x40
	jump	array_x_loop
	add	vB, 0x02
	skip.eq	vB, 0x12
	jump	array_y_loop
;
; draw the initial paddle
;
	load	vC, 0x20
	load	vD, 0x1F
	load	i, paddle
	draw	vC, vD, 1
;
; draw the initial score
;
	call	update_the_score
;
; draw the number of extra lives
;
	load	v0, 0x00
	load	v1, 0x00
	load	i, lives
	draw	v0, v1, 1
	add	v0, 0x08
	load	i, ball
	draw	v0, v1, 1
;
; wait 64/60 seconds
; then serve the ball
;
serve:
	load	v0, 0x40
	load	time, v0
one_second_loop:
	load	v0, time
	skip.eq	v0, 0x00
	jump	one_second_loop
;
; initial ball position and direction
; draw the initial ball
;
	rnd	v6, 0x0F
	load	v7, 0x1E
	load	v8, 1
	load	v9, -1
	load	i, ball
	draw	v6, v7, 1
;
; undraw the paddle
; see if we need to move it
; then draw it again
;
main_loop:
	load	i, paddle
	draw	vC, vD, 1
	load	v0, 4
	skip.ne	v0, key
	add	vC, -2
	load	v0, 6
	skip.ne	v0, key
	add	vC, 2
	load	v0, 0x3F
	and	vC, v0
	draw	vC, vD, 1
;
; undraw the ball
;
	load	i, ball
	draw	v6, v7, 1
;
; update ball position
; bounce as appropriate
;
	add	v6, v8
	add	v7, v9
	load	v0, 0x3F
	and	v6, v0
	load	v1, 0x1F
	and	v7, v1
	skip.ne	v7, 0x1F	; jump if hit bottom
	jump	hit_the_bottom
	skip.ne	v6, 0		; bounce if hit left
	load	v8, 1
	skip.ne	v6, 0x3F	; bounce if hit right
	load	v8, -1
	skip.ne	v7, 0		; bounce if hit top
	load	v9, 1
;
; draw the ball in the new position
;
	draw	v6, v7, 1
	skip.eq	vF, 1		; loop if nothing hit
	jump	main_loop
	skip.ne	v7, 0x1F
	jump	hit_the_bottom
;
; ignore hits in rows 0 to 5
;
	load	v0, 5
	sub	v0, v7
	skip.ne	vF, 0
	jump	main_loop
;
; beep to say hit a ball
;
	load	v0, 1		; 1/60 second
	load	tone, v0
;
; erase the brick (this will also turn the ball pixel back on)
;
	load	v0, v6
	load	v1, 0xFC
	and	v0, v1
	load	i, brick
	draw	v0, v7, 1
;
; negate ball dy
;
	load	v0, (1 ^ -1)		;0xFE
	xor	v9, v0
;
; Crank the score by one
; If all the bricks are gone, spin wait forever.
; Otherwise, return to the main loop.
;
	call	update_the_score
	add	v5, 1
	call	update_the_score
	skip.ne	v5, 0x60
	jump	spin_wait
	jump	main_loop

;
; Hitting the bottom has a varity of possibilities.  You could miss the
; paddle, or you could bounce off the paddle in 3 different ways.
;
hit_the_bottom:
	load	v9, -1		; ball dy
	load	v0, v6
	sub	v0, vC
	skip.eq	vF, 0		; jump if left of paddle
	jump	missed_the_paddle
	load	v1, 2
	sub	v0, v1
	skip.eq	vF, 0		; jump if lhs of paddle
	jump	paddle_lhs
	sub	v0, v1
	skip.eq	vF, 0		; jump if middle of paddle
	jump	paddle_mid
	sub	v0, v1
	skip.eq	vF, 0		; jump if rhs of paddle
	jump	paddle_rhs	; (fall through if right of paddle)

missed_the_paddle:
	load	v0, 0x20	; 32/60 second beep if miss paddle
	load	tone, v0
	load	i, ball
	add	vE, -1		; one less life
	load	v0, vE
	add	v0, v0
	load	v1, 0
	draw	v0, v1, 1	; erase life spot
	skip.eq	vE, 0		; serve another ball if any lives left
	jump	serve		; (fall through if none left)

;
; spin forever
;
spin_wait:
	jump	spin_wait

paddle_lhs:
	add	v8, -1
	skip.ne	v8, -2
	load	v8, -1
	jump	paddle_mid
paddle_rhs:
	add	v8, 1
	skip.ne	v8, 2
	load	v8, 1
paddle_mid:
	load	v0, 4		; 4/60 second beep when hit paddle
	load	tone, v0
	load	v9, -1		; ball dy
	load	i, ball
	draw	v6, v7, 1
	jump	main_loop
;
; update the score
;
update_the_score:
	load	i, score_buffer
	bcd	v5
	restore	v2
	hex	v1
	load	v3, 0x37
	load	v4, 0
	draw	v3, v4, 5
	add	v3, 0x05
	hex	v2
	draw	v3, v4, 5
	ret

	.align
brick:	.pic	"***"

	.align
ball:	.pic	"*"

	.align
paddle:	.pic	"******"

	.align
lives:	.pic	"* * * *"

	.align
score_buffer:
	.ds	3
