;
;	maze
;	Copyright (C) 1991 David Winter
;
	.title	"maze version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"maze version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
start:
	load	v0, 0
	load	v1, 0
L1:
	load	i, L4
	rnd	v2, 1
	skip.eq	v2, 1
	load	i, L3
	draw	v0, v1, 4
	add	v0, 4
	skip.eq	v0, 64
	jump	L1
	load	v0, 0
	add	v1, 4
	skip.eq	v1, 32
	jump	L1
L2:
	load	vE, key
	cls
	jump	start
L3:
	.pic	"*       ",
		" *      ",
		"  *     ",
		"   *    "
L4:
	.pic	"  *     ",
		" *      ",
		"*       ",
		"   *    "
