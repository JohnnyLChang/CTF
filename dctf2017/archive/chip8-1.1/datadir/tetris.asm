;
; Tetris
;
; Author Unknown
;
	.title	"Tetris",
		"Author Unknown"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"Tetris"
	.byte	10
	.ascii	"Author Unknown"
	.byte	10
	.align
start:
	load	i, L11
	call	L28
	call	L12
L1:
	add	v0, 1
	draw	v0, v1, 1
	skip.eq	v0, 0x25
	jump	L1
L2:
	add	v1, 255
	draw	v0, v1, 1
	load	v0, 26
	draw	v0, v1, 1
	load	v0, 37
	skip.eq	v1, 0x00
	jump	L2
L3:
	rnd	v4, 0x70
	skip.ne	v4, 0x70
	jump	L3
	rnd	v3, 0x03
	load	v0, 30
	load	v1, 3
	call	L7
L4:
	load	time, v5
	draw	v0, v1, 4
	skip.eq	vF, 0x01
	jump	L5
	draw	v0, v1, 4
	add	v1, 255
	draw	v0, v1, 4
	call	L16
	jump	L3
L5:
	skip.ne	v7, key
	call	L8
	skip.ne	v8, key
	call	L9
	skip.ne	v9, key
	call	L10
	skip.eq	v2, key
	jump	L6
	load	v6, 0
	load	time, v6
L6:
	load	v6, time
	skip.eq	v6, 0x00
	jump	L5
	draw	v0, v1, 4
	add	v1, 1
	jump	L4
L7:
	load	i, L13
	add	i, v4
	load	v6, 0
	skip.ne	v3, 0x01
	load	v6, 4
	skip.ne	v3, 0x02
	load	v6, 8
	skip.ne	v3, 0x03
	load	v6, 12
	add	i, v6
	ret
L8:
	draw	v0, v1, 4
	add	v0, 255
	call	L14
	skip.eq	vF, 0x01
	ret
	draw	v0, v1, 4
	add	v0, 1
	call	L14
	ret
L9:
	draw	v0, v1, 4
	add	v0, 1
	call	L14
	skip.eq	vF, 0x01
	ret
	draw	v0, v1, 4
	add	v0, 255
	call	L14
	ret
L10:
	draw	v0, v1, 4
	add	v3, 1
	skip.ne	v3, 0x04
	load	v3, 0
	call	L7
	call	L14
	skip.eq	vF, 0x01
	ret
	draw	v0, v1, 4
	add	v3, 255
	skip.ne	v3, 0xFF
	load	v3, 3
	call	L7
	call	L14
	ret
L11:
	.byte	0x80
	.byte	0x00
L12:
	load	v7, 5
	load	v8, 6
	load	v9, 4
	load	v1, 31
	load	v5, 16
	load	v2, 7
	ret
L13:
	.byte	0x40
	.byte	0xE0
	.ds	0x2
	.byte	0x40
	.byte	0xC0
	.byte	0x40
	.ds	0x2
	.byte	0xE0
	.byte	0x40
	.byte	0x00
	.byte	0x40
	.byte	0x60
	.byte	0x40
	.byte	0x00
	.byte	0x40
	.byte	0x40
	.byte	0x60
	.byte	0x00
	.byte	0x20
	.byte	0xE0
	.ds	0x2
	.byte	0xC0
	.byte	0x40
	.byte	0x40
	.ds	0x2
	.byte	0xE0
	.byte	0x80
	.byte	0x00
	.byte	0x40
	.byte	0x40
	.byte	0xC0
	.ds	0x2
	.byte	0xE0
	.byte	0x20
	.byte	0x00
	.byte	0x60
	.byte	0x40
	.byte	0x40
	.byte	0x00
	.byte	0x80
	.byte	0xE0
	.ds	0x2
	.byte	0x40
	.byte	0xC0
	.byte	0x80
	.byte	0x00
	.byte	0xC0
	.byte	0x60
	.ds	0x2
	.byte	0x40
	.byte	0xC0
	.byte	0x80
	.byte	0x00
	.byte	0xC0
	.byte	0x60
	.ds	0x2
	.byte	0x80
	.byte	0xC0
	.byte	0x40
	.ds	0x2
	.byte	0x60
	.byte	0xC0
	.byte	0x00
	.byte	0x80
	.byte	0xC0
	.byte	0x40
	.ds	0x2
	.byte	0x60
	.byte	0xC0
	.byte	0x00
	.byte	0xC0
	.byte	0xC0
	.ds	0x2
	.byte	0xC0
	.byte	0xC0
	.ds	0x2
	.byte	0xC0
	.byte	0xC0
	.ds	0x2
	.byte	0xC0
	.byte	0xC0
	.ds	0x2
	.byte	0x40
	.byte	0x40
	.byte	0x40
	.byte	0x40
	.byte	0x00
	.byte	0xF0
	.ds	0x2
	.byte	0x40
	.byte	0x40
	.byte	0x40
	.byte	0x40
	.byte	0x00
	.byte	0xF0
	.ds	0x2
L14:
	draw	v0, v1, 4
	load	v6, 53
L15:
	add	v6, 255
	skip.eq	v6, 0x00
	jump	L15
	ret
L16:
	load	i, L11
	load	vC, v1
	skip.eq	vC, 0x1E
	add	vC, 1
	skip.eq	vC, 0x1E
	add	vC, 1
	skip.eq	vC, 0x1E
	add	vC, 1
L17:
	call	L18
	skip.ne	vB, 0x0A
	call	L20
	skip.ne	v1, vC
	ret
	add	v1, 1
	jump	L17
L18:
	load	v0, 27
	load	vB, 0
L19:
	draw	v0, v1, 1
	skip.eq	vF, 0x00
	add	vB, 1
	draw	v0, v1, 1
	add	v0, 1
	skip.eq	v0, 0x25
	jump	L19
	ret
L20:
	load	v0, 27
L21:
	draw	v0, v1, 1
	add	v0, 1
	skip.eq	v0, 0x25
	jump	L21
	load	vE, v1
	load	vD, vE
	add	vE, 255
L22:
	load	v0, 27
	load	vB, 0
L23:
	draw	v0, vE, 1
	skip.eq	vF, 0x00
	jump	L24
	draw	v0, vE, 1
	jump	L25
L24:
	draw	v0, vD, 1
	add	vB, 1
L25:
	add	v0, 1
	skip.eq	v0, 0x25
	jump	L23
	skip.ne	vB, 0x00
	jump	L26
	add	vD, 255
	add	vE, 255
	skip.eq	vD, 0x01
	jump	L22
L26:
	call	L27
	skip.eq	vF, 0x01
	call	L27
	add	vA, 1
	call	L27
	load	v0, vA
	load	vD, 7
	and	v0, vD
	skip.ne	v0, 0x04
	add	v5, 254
	skip.ne	v5, 0x02
	load	v5, 4
	ret
L27:
	load	i, L29
	save	v2
	load	i, L30
	bcd	vA
	restore	v2
	hex	v0
	load	vD, 50
	load	vE, 0
	draw	vD, vE, 5
	add	vD, 5
	hex	v1
	draw	vD, vE, 5
	add	vD, 5
	hex	v2
	draw	vD, vE, 5
	load	i, L29
	restore	v2
	load	i, L11
	ret
L28:
	load	vA, 0
	load	v0, 25
	ret
	.byte	0x37
	.byte	0x23
	.ds	0x312
L29:
	.ds	0x104
L30:
	.byte	0x00
