;
	.title	"Puzzle 15",
		"Author Unknown"
	xref	on
;
	jump	main
	.byte	10
	.ascii	"Puzzle 15"
	.byte	10
	.ascii	"Author Unknown"
	.byte	10
	.align
main:
	clear
	load	vC, 0
L1	.equ	. - 1
	skip.ne	vC, 0
	load	vE, 15
	load	i, L1
	load	v0, 32
	save	v0
	clear
L2:
	call	L11
	call	L8
	call	L9
	call	L7
	call	L6
	jump	L2
L3:
	load	v1, 0
	load	v2, 23
	load	v3, 4
L4:
	skip.ne	v1, 16
	ret
	load	i, L15
	add	i, v1
	restore	v0
	skip.ne	v0, 0
	jump	L5
	hex	v0
	draw	v2, v3, 5
L5:
	add	v1, 1
	add	v2, 5
	load	v4, 3
	and	v4, v1
	skip.eq	v4, 0
	jump	L4
	load	v2, 23
	add	v3, 6
	jump	L4
L6:
	load	v4, 3
	and	v4, vE
	load	v5, 3
	and	v5, vD
	skip.ne	v4, v5
	ret
	skip.ne	v4, 3
	ret
	load	v4, 1
	add	v4, vE
	call	L10
	jump	L6
L7:
	load	v4, 3
	and	v4, vE
	load	v5, 3
	and	v5, vD
	skip.ne	v4, v5
	ret
	skip.ne	v4, 0
	ret
	load	v4, 255
	add	v4, vE
	call	L10
	jump	L7
L8:
	load	v4, 12
	and	v4, vE
	load	v5, 12
	and	v5, vD
	skip.ne	v4, v5
	ret
	skip.ne	v4, 0
	ret
	load	v4, 252
	add	v4, vE
	call	L10
	jump	L8
L9:
	load	v4, 12
	and	v4, vE
	load	v5, 12
	and	v5, vD
	skip.ne	v4, v5
	ret
	skip.ne	v4, 12
	ret
	load	v4, 4
	add	v4, vE
	call	L10
	jump	L9
L10:
	load	i, L15
	add	i, v4
	restore	v0
	load	i, L15
	add	i, vE
	save	v0
	load	v0, 0
	load	i, L15
	add	i, v4
	save	v0
	load	vE, v4
	ret
L11:
	skip.eq	vC, 0
	jump	L12
	call	L3
	call	L13
	call	L3
	load	i, L16
	add	i, vD
	restore	v0
	load	vD, v0
	ret
L12:
	add	vC, 255
	rnd	vD, 15
	ret
L13:
	add	vD, 1
	load	v0, 15
	and	vD, v0
	skip.eq	vD, key
	jump	L13
L14:
	skip.ne	vD, key
	jump	L14
	ret
L15:
	.byte	0x01
	.byte	0x02
	.byte	0x03
	.byte	0x04
	.byte	0x05
	.byte	0x06
	.byte	0x07
	.byte	0x08
	.byte	0x09
	.byte	0x0A
	.byte	0x0B
	.byte	0x0C
	.byte	0x0D
	.byte	0x0E
	.byte	0x0F
	.byte	0x00
L16:
	.byte	0x0D
	.byte	0x00
	.byte	0x01
	.byte	0x02
	.byte	0x04
	.byte	0x05
	.byte	0x06
	.byte	0x08
	.byte	0x09
	.byte	0x0A
	.byte	0x0C
	.byte	0x0E
	.byte	0x03
	.byte	0x07
	.byte	0x0B
	.byte	0x0F
	.byte	0x84
	.byte	0xE4
	.ascii	""""
	.byte	0xA6
	.byte	0x12
	.ascii	"vd"
	.byte	0x0C
	.byte	0x84
	.byte	0xE2
	.ascii	"e"
	.byte	0x0C
	.byte	0x85
	.byte	0xD2
	.byte	0x94
	.ascii	"P"
	.byte	0x00
	.byte	0xEE
	.ascii	"D"
	.byte	0x0C
	.byte	0x00
	.byte	0xEE
	.ascii	"d"
	.byte	0x04
	.byte	0x84
	.byte	0xE4
	.ascii	""""
	.byte	0xA6
	.byte	0x12
	.byte	0x8E
	.byte	0xA2
	.byte	0xE8
	.byte	0xF4
	.byte	0x1E
	.byte	0xF0
	.ascii	"e"
	.byte	0xA2
	.byte	0xE8
	.byte	0xFE
	.byte	0x1E
	.byte	0xF0
	.ascii	"U`"
	.byte	0x00
	.byte	0xA2
	.byte	0xE8
	.byte	0xF4
	.byte	0x1E
	.byte	0xF0
	.ascii	"U"
	.byte	0x8E
	.ascii	"@"
	.byte	0x00
	.byte	0xEE
	.ascii	"<"
	.byte	0x00
	.byte	0x12
	.byte	0xD2
	.ascii	""""
	.byte	0x1C
	.ascii	""""
	.byte	0xD8
	.ascii	""""
	.byte	0x1C
	.byte	0xA2
	.byte	0xF8
	.byte	0xFD
	.byte	0x1E
	.byte	0xF0
	.ascii	"e"
	.byte	0x8D
	.ds	0x2
	.byte	0xEE
	.ascii	"|"
	.byte	0xFF
	.byte	0xCD
	.byte	0x0F
	.byte	0x00
	.byte	0xEE
	.ascii	"}"
	.byte	0x01
	.ascii	"`"
	.byte	0x0F
	.byte	0x8D
	.byte	0x02
	.byte	0xED
	.byte	0x9E
	.byte	0x12
	.byte	0xD8
	.byte	0xED
	.byte	0xA1
	.byte	0x12
	.byte	0xE2
	.byte	0x00
	.byte	0xEE
	.byte	0x01
	.byte	0x02
	.byte	0x03
	.byte	0x04
	.byte	0x05
	.byte	0x06
	.byte	0x07
	.byte	0x08
	.byte	0x09
	.byte	0x0A
	.byte	0x0B
	.byte	0x0C
	.byte	0x0D
	.byte	0x0E
	.byte	0x0F
	.byte	0x00
	.byte	0x0D
	.byte	0x00
	.byte	0x01
	.byte	0x02
	.byte	0x04
	.byte	0x05
	.byte	0x06
	.byte	0x08
