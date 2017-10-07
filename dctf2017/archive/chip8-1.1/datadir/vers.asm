;
;	vers version 1.0
;	Copyright (C) 1991 JMN
;
; Register Usage:
;	v0 -	snake 1 x
;	v1 -	snake 1 y
;	v2 -	snake 1 direction
;	v3 -	snake 1 score
;	v4 -	snake 2 x
;	v5 -	snake 2 y
;	v6 -	snake 2 direction
;	v7 -	snake 2 score
;	v8 -	general counter
;	vF -	flags and collisions
;
	.title	"Vers version 1.0",
		"Copyright (C) 1991 JMN"
	.xref	on
	jump	L3
	.byte	10
	.ascii	"Vers version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 JMN"
	.byte	10
	.align
L1:
	.pic	"*       ",
		"*       "
L2:
	.pic	"********",
		"      * "
L3:
	load	v3, 0
	load	v7, 0
L4:
	clear
	load	i, L2
	load	v0, 0
	load	v1, 0
L5:
	draw	v0, v1, 1
	add	v1, 255
	draw	v0, v1, 1
	add	v1, 1
	add	v0, 8
	skip.eq	v0, 64
	jump	L5
	add	v1, 1
	load	i, L1
L6:
	draw	v0, v1, 2
	add	v0, 255
	draw	v0, v1, 2
	add	v0, 1
	add	v1, 2
	skip.eq	v1, 31
	jump	L6
;
; set the initial snake head positions
; and draw them
;
	load	v0, 8
	load	v1, 16
	load	v2, 4
	load	v4, 55
	load	v5, 15
	load	v6, 2
	draw	v0, v1, 1
	draw	v4, v5, 1
L7:
;
; read the keyboard, and remember the snake directions
;
	load	v8, 1
	skip.ne	v8, key
	load	v2, 2
	load	v8, 2
	skip.ne	v8, key
	load	v2, 4
	load	v8, 7
	skip.ne	v8, key
	load	v2, 1
	load	v8, 10
	skip.ne	v8, key
	load	v2, 3
	load	v8, 11
	skip.ne	v8, key
	load	v6, 2
	load	v8, 15
	skip.ne	v8, key
	load	v6, 4
	load	v8, 12
	skip.ne	v8, key
	load	v6, 1
	load	v8, 13
	skip.ne	v8, key
	load	v6, 3
;
; act on the snake directions
;
	skip.ne	v2, 1
	add	v1, 255
	skip.ne	v2, 2
	add	v0, 255
	skip.ne	v2, 3
	add	v1, 1
	skip.ne	v2, 4
	add	v0, 1
	skip.ne	v6, 1
	add	v5, 255
	skip.ne	v6, 2
	add	v4, 255
	skip.ne	v6, 3
	add	v5, 1
	skip.ne	v6, 4
	add	v4, 1
;
; draw the new snake heads
; (we never un-draw their tails)
;
	draw	v0, v1, 1
	skip.eq	vF, 0
	jump	L8
	draw	v4, v5, 1
	skip.eq	vF, 0
	jump	L9
	jump	L7
L8:
;
; snake 1 bumped into something
;
	add	v7, 1
	jump	L10
L9:
;
; snake 2 bumped into something
;
	add	v3, 1
L10:
;
; this round is over
;	delay for a little while
;	(The delay timer would be better for this.  - PM)
;
	load	v8, 0
L11:
	add	v8, 1
	skip.eq	v8, 0
	jump	L11
;
; clear the screen and display the scores
;
	clear
	load	v0, 8
	load	v1, 4
	hex	v3
	draw	v0, v1, 5
	load	v0, 52
	hex	v7
	draw	v0, v1, 5
;
; delay for a little while
; so they can read the scores
; (The delay timer would be better for this.  - PM)
;
	load	v8, 0
L12:
	add	v8, 1
	skip.eq	v8, 0
	jump	L12
;
; First to 8, wins
;
	skip.ne	v3, 8
	jump	L13
	skip.ne	v7, 8
	jump	L13
	jump	L4
L13:
	jump	L13
