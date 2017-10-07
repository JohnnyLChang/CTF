;
;	race
;	Copyright (C) 1991 David Winter
;
	.title	"race version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"race version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
start:
	high
	load	v5, 60
	load	v6, 45
	load	v7, 60
	load	v3, v5
	load	v4, v6
	load	i, L9
	xdraw	v3, v4
L1:
	load	i, L9
	xdraw	v3, v4
	scdown	3
	xdraw	v5, v6
	skip.eq	vF, 0
	jump	L2
	load	v0, v7
	call	L7
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
	call	L5
	rnd	v0, 3
	skip.ne	v0, 0
	call	L6
	jump	L1
L2:
	jump	L2
right:
	add	v5, 1
	skip.ne	v5, 110
	load	v5, 109
	ret
left:
	add	v5, -1
	skip.ne	v5, -1
	load	v5, 0
	ret
L5:
	add	v7, 1
	skip.ne	v7, 90
	load	v7, 89
	ret
L6:
	add	v7, -1
	skip.ne	v7, -1
	load	v7, 0
	ret
L7:
	load	v1, 0
	load	i, L8
	draw	v0, v1, 3
	add	v0, 25
	draw	v0, v1, 3
	ret
L8:
	.pic	"* *     ",
		" *      ",
		"* *     "
	.byte	0x00
L9:
	.byte	0x30
	.byte	0x0C
	.byte	0x3F
	.byte	0xFC
	.byte	0x32
	.byte	0x4C
	.byte	0x02
	.byte	0x40
	.byte	0x04
	.byte	0x20
	.byte	0x04
	.byte	0x20
	.byte	0x04
	.byte	0x20
	.byte	0x04
	.byte	0x20
	.byte	0xF4
	.byte	0x2F
	.byte	0xF4
	.byte	0x2F
	.byte	0xFD
	.byte	0xBF
	.byte	0xF6
	.byte	0x6F
	.byte	0xF6
	.byte	0x6F
	.byte	0x06
	.byte	0x60
	.byte	0x3F
	.byte	0xFC
	.byte	0x7F
	.byte	0xFE
