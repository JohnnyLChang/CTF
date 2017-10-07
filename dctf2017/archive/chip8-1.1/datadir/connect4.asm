;
;	Copyright (C) David Winter
;
	.title	"Connect4 version 1.0",
		"Copyright (C) David Winter"
	.xref	on
;
	jump	start
	.byte	10
	.ascii	"Connect4 version 1.0"
	.byte	10
	.ascii	"Copyright (C) David Winter"
	.byte	10
	.align
start:
	load	i, initial_column_pos
	restore	v6
	load	i, column_position
	save	v6
;
	load	v9, 0		; track solid/hollow state
	load	v8, 1
	load	vB, 0
	load	vD, 15		; cursor X
	load	vE, 31		; cursor Y
;
; draw the playing area
;
	load	i, edges
	load	v0, 13
	load	v1, 50
	load	v2, 0
outline:
	draw	v0, v2, 15
	draw	v1, v2, 15
	add	v2, 15
	skip.eq	v2, 30
	jump	outline
	draw	v0, v2, 1
	draw	v1, v2, 1
	add	v2, 1
	load	v0, 10
	load	i, cursor
	draw	v0, v2, 1
	draw	v1, v2, 1
;
; This is the main loop.
;
; Draw the cursor, and wait for a key, and then un-draw the cursor.
; Then deal with the key.
;
main_loop:
	load	i, cursor	; draw the cursor
	draw	vD, vE, 1
	load	vC, key		; wait for a key
	draw	vD, vE, 1	; un-draw the cursor
	skip.ne	vC, 5
	jump	place_piece
	skip.eq	vC, 4
	jump	not_left
;
; move cursor left
; wrap it to the right if necessary
;
	add	vB, -1
	add	vD, -5
	skip.eq	vD, 10
	jump	main_loop
	load	vB, 6
	load	vD, 45
	jump	main_loop
not_left:
	skip.eq	vC, 6		; do nothing if we don't like the key
	jump	main_loop
;
; move cursor right
; wrap it left if necessary
;
	add	vB, 1
	add	vD, 5
	skip.eq	vD, 50
	jump	main_loop
	load	vB, 0
	load	vD, 15
	jump	main_loop
;
; Place a piece in the playing area
;
place_piece:
	load	i, column_position
	add	i, vB		; 0..5, depending on (cursor) X
	restore	v0		; this moves i-reg
	skip.ne	v0, -5
	jump	main_loop
	load	vA, v0		; Y pos for dot
	add	v0, -5
	load	i, column_position
	add	i, vB		; 0..5, depending on (cursor) X
	save	v0
;
; we alternate drawing solid and hollow dots
;
	xor	v9, v8		; invert lsb (v8 == 1)
	load	i, solid_dot
	skip.eq	v9, 0
	load	i, hollow_dot
	draw	vD, vA, 4	; cursor-X, dot-Y
	jump	main_loop
cursor:
	.pic	"****    "
solid_dot:
	.pic	" **     ",
		"****    ",
		"****    ",
		" **     "
hollow_dot:
	.pic	" **     ",
		"*  *    ",
		"*  *    ",
		" **     "
edges:
	.pic	"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*       "
; This is the initial column heights
initial_column_pos:
	.ds	7, 5 * 5
; This is loaded fron the initial state
column_position:
	.ds	7, 5 * 5
