;
;	merlin
;	Copyright (C) 1991 David Winter
;
	.title	"merlin version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
;
	jump	L1
	.byte	10
	.ascii	"Merlin version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
L1:
	call	L16
	load	i, L19
	load	v0, 16
	load	v1, 0
	call	L13
	load	i, L20
	load	v0, 11
	load	v1, 27
	call	L13
	load	v4, 4
L2:
	call	L15
	load	v5, 0
	load	v2, 40
	call	L11
L3:
	rnd	v2, 3
	load	v0, v2
	load	i, L22
	add	i, v5
	save	v0
	load	v0, 23
	load	v1, 8
	load	v3, 1
	and	v3, v2
	skip.eq	v3, 0
	add	v0, 10
	load	v3, 2
	and	v3, v2
	skip.eq	v3, 0
	add	v1, 10
	load	i, L18
	draw	v0, v1, 6
	load	v2, 20
	call	L11
	draw	v0, v1, 6
	load	v2, 5
	call	L11
	add	v5, 1
	skip.eq	v4, v5
	jump	L3
	load	v5, 0
L4:
	load	v0, 23
	load	v1, 8
	load	i, L18
	load	v3, key
	skip.eq	v3, 4		; top left
	jump	L5
	load	v3, 0
	jump	L8
L5:
	skip.eq	v3, 5		; top right
	jump	L6
	add	v0, 10
	load	v3, 1
	jump	L8
L6:
	skip.eq	v3, 7		; bottom left
	jump	L7
	add	v1, 10
	load	v3, 2
	jump	L8
L7:
	skip.eq	v3, 8		; bottom right
	jump	L4
	add	v0, 10
	add	v1, 10
	load	v3, 3
L8:
	draw	v0, v1, 6
	load	v2, 20
	call	L11
	draw	v0, v1, 6
	load	i, L22
	add	i, v5
	restore	v0
	add	v5, 1
	skip.eq	v0, v3
	jump	L9
	skip.eq	v5, v4
	jump	L4
	call	L15
	add	v4, 1
	jump	L2
L9:
	call	L16
	load	i, L21
	load	v0, 16
	load	v1, 14
	call	L13
L10:
	jump	L10
L11:
	load	time, v2
L12:
	load	v2, time
	skip.eq	v2, 0
	jump	L12
	ret
L13:
	load	v3, v0
	load	v2, 5
L14:
	draw	v0, v1, 5
	add	i, v2
	add	v0, 8
	load	v5, v3
	add	v5, 32
	skip.eq	v0, v5
	jump	L14
	ret
L15:
	load	i, L22
	load	v3, v4
	add	v3, 253
	bcd	v3
	restore	v2
	hex	v1
	load	v0, 43
	load	v3, 27
	draw	v0, v3, 5
	add	v0, 5
	hex	v2
	draw	v0, v3, 5
	ret
L16:
	load	i, L17
	load	v0, 23
	load	v1, 7
	draw	v0, v1, 8
	add	v0, 10
	draw	v0, v1, 8
	add	v1, 10
	draw	v0, v1, 8
	add	v0, 246
	draw	v0, v1, 8
	ret
L17:
	.pic	"********",
		"*      *",
		"*      *",
		"*      *",
		"*      *",
		"*      *",
		"*      *",
		"********"
L18:
	.pic	" ****** ",
		" ****** ",
		" ****** ",
		" ****** ",
		" ****** ",
		" ****** "
L19:
	.pic	"** ** **",
		"* * * * ",
		"*   * **",
		"**  * **",
		"**  * **",
		"*** ****",
		"    *   ",
		"*   ****",
		"    ** *",
		"*** **  ",
		"* *     ",
		"* *     ",
		"* **    ",
		"  **    ",
		"* ***** ",
		" * *****",
		" * *   *",
		" * *   *",
		"** **  *",
		"** **  *"
L20:
	.pic	"*     **",
		"*     * ",
		"*     **",
		"*     * ",
		"***** **",
		"*** *   ",
		"    *   ",
		"*   *   ",
		"     * *",
		"***   * ",
		"* ***** ",
		"* *     ",
		"* ***   ",
		"  *     ",
		"  ***** ",
		"*       ",
		"*       ",
		"*       ",
		"*       ",
		"*****   "
L21:
	.pic	"**** ***",
		"*    * *",
		"* ** ***",
		"*  * * *",
		"**** * *",
		" *** ** ",
		" * * *  ",
		" * * ** ",
		" * * *  ",
		" * * ** ",
		"  *** * ",
		"  * * * ",
		"  * * * ",
		"  * * * ",
		"  ***  *",
		"* ** ** ",
		"* *  * *",
		"* ** ** ",
		"* *  * *",
		"  ** * *"
L22:
	.byte	0x00
