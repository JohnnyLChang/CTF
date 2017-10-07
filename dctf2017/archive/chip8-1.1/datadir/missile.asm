;
;	missile
;	Copyright (C) 1991 David Winter
;
;	You must shoot the 8 targets on the screen. Your shooter moves
;	a little bit faster each time you shoot. You have 12 missiles to
;	shoot all the targets, and you win 5 points per target shot.
;
	.title	"missile version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
;
	jump	L1
	.byte	10
	.ascii	"Missile version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
L1:
	load	vC, 12
	load	v0, 0
	load	v1, 0
	load	v5, 8
	load	v6, 10
	load	v7, 0
	load	vE, 1
	load	i, L12
L2:
	draw	v0, v1, 4
	add	v0, 8
	skip.eq	v0, 64
	jump	L2
	load	v0, 0
	load	v1, 28
	load	i, L13
	draw	v0, v1, 4
L3:
	load	i, L13
	draw	v0, v1, 4
	skip.eq	vE, 1
	jump	L4
	add	v0, 4
	skip.ne	v0, 56
	load	vE, 0
	jump	L5
L4:
	add	v0, 252
	skip.ne	v0, 0
	load	vE, 1
L5:
	draw	v0, v1, 4
	load	time, vC
L6:
	load	vB, time
	skip.eq	vB, 0
	jump	L6
	load	v2, 8
	skip.eq	v2, key
	jump	L9
	skip.eq	vC, 0
	add	vC, 254
	load	v3, 27
	load	v2, v0
	load	i, L13
	draw	v2, v3, 1
	load	v4, 0
L7:
	draw	v2, v3, 1
	add	v3, 255
	draw	v2, v3, 1
	skip.eq	vF, 0
	load	v4, 1
	skip.eq	v3, 3
	jump	L7
	draw	v2, v3, 1
	skip.eq	v4, 1
	jump	L8
	add	v7, 5
	add	v5, 255
	load	v2, v0
	load	v3, 0
	load	i, L12
	draw	v2, v3, 4
	skip.ne	v5, 0
	jump	L10
L8:
	add	v6, 255
	skip.eq	v6, 0
L9:
	jump	L3
L10:
	load	i, L14
	bcd	v7
	restore	v2
	load	v3, 27
	load	v4, 13
	hex	v1
	draw	v3, v4, 5
	add	v3, 5
	hex	v2
	draw	v3, v4, 5
L11:
	jump	L11
L12:
	.pic	"   *    ",
		"  ***   ",
		"  ***   "
L13:
	.pic	"   *    ",
		"  ***   ",
		" *****  ",
		"******* "
L14:
	.ds	0x3
