;
; UFO
;
; Author Unknown
;
; ``As far as I know, the only original CHIP8 game is UFO, dated 1977.''
; David Winter <winter@worldnet.net>
;
	.title	"UFO version 1.0",
		"Author Unknown 1977"
	.xref	on
;
	.byte	10
	.ascii	"UFO version 1.0"
	.byte	10
	.ascii	"Author Unknown 1977"
	.byte	10
	.align
start:
	load	i, L12
	load	v9, 56
	load	vA, 8
	draw	v9, vA, 3
	load	i, L13
	load	vB, 0
	load	vC, 3
	draw	vB, vC, 3
	load	i, L15
	load	v4, 29
	load	v5, 31
	draw	v4, v5, 1
	load	v7, 0
	load	v8, 15
	call	L9
L1:
	call	L10
	skip.ne	v8, 0x00
L2:
	jump	L2
	load	v4, 30
	load	v5, 28
	load	i, L14
	draw	v4, v5, 3
	load	vE, 0
L3:
	load	v6, 128
	load	vD, 4
	skip.ne	vD, key
	load	v6, 255
	load	vD, 5
	skip.ne	vD, key
	load	v6, 0
	load	vD, 6
	skip.ne	vD, key
	load	v6, 1
	skip.eq	v6, 0x80
	call	L16
L4:
	load	i, L13
	draw	vB, vC, 3
	rnd	vD, 0x01
	add	vB, vD
	draw	vB, vC, 3
	skip.eq	vF, 0x00
	jump	L7
	load	i, L12
	draw	v9, vA, 3
	rnd	vD, 0x01
	skip.eq	vD, 0x00
	load	vD, 255
	add	v9, 254
	draw	v9, vA, 3
	skip.eq	vF, 0x00
	jump	L6
	skip.ne	vE, 0x00
	jump	L3
	load	i, L14
	draw	v4, v5, 3
	skip.ne	v5, 0x00
	jump	L5
	add	v5, 255
	add	v4, v6
	draw	v4, v5, 3
	skip.eq	vF, 0x01
	jump	L4
	load	vD, 8
	and	vD, v5
	skip.ne	vD, 0x08
	jump	L6
	jump	L7
L5:
	call	L10
	add	v8, 255
	jump	L1
L6:
	call	L9
	add	v7, 5
	jump	L8
L7:
	call	L9
	add	v7, 15
L8:
	call	L9
	load	vD, 3
	load	tone, vD
	load	i, L14
	draw	v4, v5, 3
	jump	L5
L9:
	load	i, L17
	bcd	v7
	load	v3, 0
	call	L11
	ret
L10:
	load	i, L17
	bcd	v8
	load	v3, 50
	call	L11
	ret
L11:
	load	vD, 27
	restore	v2
	hex	v0
	draw	v3, vD, 5
	add	v3, 5
	hex	v1
	draw	v3, vD, 5
	add	v3, 5
	hex	v2
	draw	v3, vD, 5
	ret
	.byte	0x01
L12:
	.byte	0x7C
	.byte	0xFE
	.byte	0x7C
L13:
	.byte	0x60
	.byte	0xF0
	.byte	0x60
L14:
	.byte	0x40
	.byte	0xE0
	.byte	0xA0
L15:
	.byte	0xF8
	.byte	0xD4
L16:
	load	vE, 1
	load	vD, 16
	load	tone, vD
	ret
	.ds	0x18
L17:
	.byte	0x00
