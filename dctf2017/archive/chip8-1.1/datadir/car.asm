;
;	the ``car'' game
;	Copyright (C) 1994 K.v.Sengbusch
;
; 	24/4-'94
;
	.title	"Car version 1.00",
		"Copyright (C) 1994 K.v.Sengbusch"
	.xref	on
;
	jump	main
	.byte	10
	.ascii	"Car version 1.00"
	.byte	10
	.ascii	"Copyright (C) 1994 K.v.Sengbusch"
	.byte	10
	.align
main:
	high
	load	v5, 50
	load	v6, 50
	load	v7, 40
	load	v3, v5
	load	v4, v6
	load	v2, 100
	load	v9, 0
	load	vA, 1
	load	vB, 0
L2:
	scdown	1
	call	L10
	load	v0, 1
	sub	v2, v0
	load	v0, 40
	skip.eq	v2, v0
	jump	L2
	load	i, car_image
	draw	v3, v4, 8
L3:
	load	i, car_image
	draw	v3, v4, 8
	scdown	1
	draw	v5, v6, 8
	skip.eq	vF, 0
	jump	game_over
	call	L10
	load	v0, 1
	skip.eq	v2, 0
	sub	v2, v0
	call	L11
	load	v3, v5
	load	v4, v6
	load	v0, 7
	skip.ne	v0, key
	call	left
	load	v0, 8
	skip.ne	v0, key
	call	right
	rnd	v0, 3
	skip.ne	v0, 0
	call	L8
	rnd	v0, 3
	skip.ne	v0, 0
	call	L9
	jump	L3
game_over:
	load	v0, vB
	add	v0, 3
	lsr	v0
	lsr	v0
	xhex	v0
	load	v0, v7
	add	v0, 17
	load	v1, 27
	draw	v0, v1, 10
hang:
	jump	hang
right:
	add	v5, 1
	skip.ne	v5, 110
	load	v5, 109
	ret
left:
	load	v0, 1
	sub	v5, v0
	skip.ne	v5, -1
	load	v5, 0
	ret
L8:
	add	v7, 1
	skip.ne	v7, 70
	load	v7, 69
	ret
L9:
	load	v0, 1
	sub	v7, v0
	skip.ne	v7, 20
	load	v7, 21
	ret
L10:
	load	v0, v9
	load	v1, 45
	sub	v1, v0
	load	v8, v1
	load	v1, 0
	load	v0, v7
	load	i, L13
	draw	v0, v1, 1
	add	v0, v8
	load	v1, 0
	draw	v0, v1, 1
	add	vA, 1
	skip.ne	vA, 4
	load	vA, 1
	skip.ne	vA, 1
	load	i, L14
	skip.ne	vA, 2
	load	i, L15
	skip.ne	vA, 3
	load	i, L16
	load	v1, 0
	load	v0, 0
	draw	v0, v1, 1
	load	v0, 8
	draw	v0, v1, 1
	load	v0, 112
	draw	v0, v1, 1
	load	v0, 120
	draw	v0, v1, 1
	ret
L11:
	skip.eq	v2, 0
	ret
	rnd	v0, 15
	add	v0, v7
	add	v0, 8
	load	v1, 0
	load	i, car_image
	load	v2, 45
	skip.ne	vB, 30
	call	L12
	skip.eq	vB, 33
	draw	v0, v1, 8
	add	vB, 1
	load	v0, v9
	sub	v2, v0
	skip.eq	v9, 11
	add	v9, 1
	ret
L12:
	add	vB, 3
	load	i, L17
	load	v0, v7
	add	v0, 5
	draw	v0, v1, 1
	add	v0, 8
	draw	v0, v1, 1
	add	v0, 8
	draw	v0, v1, 1
	add	v0, 8
	load	i, L18
	draw	v0, v1, 1
	load	v2, 100
	ret
L13:
	.pic	"*   *   ",
		"        "
L14:
	.byte	0x88
	.byte	0x00
L15:
	.byte	0x55
	.byte	0x00
L16:
	.byte	0x22
	.byte	0x00
L17:
	.byte	0xFF
	.byte	0x00
L18:
	.pic	"*****   ",
		"        "
car_image:
	.pic	"** ** **",
		"********",
		"** ** **",
		"   **   ",
		"  *  *  ",
		"***  ***",
		"***  ***",
		"** ** **"
