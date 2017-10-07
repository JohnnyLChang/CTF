;
; Wipe Off
;
; Author unknown
;
	.title	"Wipe Off version 1.0",
		"Author Unknowwn"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"Wipe Off version 1.0"
	.byte	10
	.ascii	"Author Unknowwn"
	.byte	10
	.align
start:
	load	i, L11
	load	vA, 7
	load	v1, 0
L1:
	load	vB, 8
	load	v0, 0
L2:
	draw	v0, v1, 1
	add	v0, 8
	add	vB, 255
	skip.eq	vB, 0x00
	jump	L2
	add	v1, 4
	add	vA, 255
	skip.eq	vA, 0x00
	jump	L1
	load	v6, 0
	load	v7, 16
	load	i, L12
	load	v0, 32
	load	v1, 30
	draw	v0, v1, 1
L3:
	load	v3, 29
	load	v2, 63
	and	v2, v0
	add	v7, 255
	skip.ne	v7, 0x00
	jump	L8
	load	vF, key
L4:
	load	i, L10
	draw	v2, v3, 1
	load	v5, 255
	rnd	v4, 0x01
	skip.eq	v4, 0x01
	load	v4, 255
L5:
	load	i, L12
	load	vC, 0
	load	vE, 4
	skip.ne	vE, key
	load	vC, 255
	load	vE, 6
	skip.ne	vE, key
	load	vC, 1
	draw	v0, v1, 1
	add	v0, vC
	draw	v0, v1, 1
	skip.ne	vF, 0x01
	jump	L6
	skip.ne	v2, 0x00
	load	v4, 1
	skip.ne	v2, 0x3F
	load	v4, 255
	skip.ne	v3, 0x00
	load	v5, 1
	skip.ne	v3, 0x1F
	jump	L7
	load	i, L10
	draw	v2, v3, 1
	add	v2, v4
	add	v3, v5
	draw	v2, v3, 1
	skip.eq	vF, 0x01
	jump	L5
	skip.ne	v3, 0x1E
	jump	L6
	load	vA, 2
	load	tone, vA
	add	v6, 1
	skip.ne	v6, 0x70
	jump	L8
	draw	v2, v3, 1
	rnd	v4, 0x01
	skip.eq	v4, 0x01
	load	v4, 255
	rnd	v5, 0x01
	skip.eq	v5, 0x01
	load	v5, 255
	jump	L5
L6:
	load	vA, 3
	load	tone, vA
	load	i, L10
	draw	v2, v3, 1
	add	v3, 255
	jump	L4
L7:
	load	i, L10
	draw	v2, v3, 1
	jump	L3
L8:
	load	i, L12
	draw	v0, v1, 1
	load	i, L13
	bcd	v6
	restore	v2
	load	v3, 24
	load	v4, 27
	hex	v0
	draw	v3, v4, 5
	add	v3, 5
	hex	v1
	draw	v3, v4, 5
	add	v3, 5
	hex	v2
	draw	v3, v4, 5
L9:
	jump	L9
	.byte	0x01
L10:
	.byte	0x80
L11:
	.byte	0x44
L12:
	.byte	0xFF
	.ds	0x22
L13:
	.byte	0x00
