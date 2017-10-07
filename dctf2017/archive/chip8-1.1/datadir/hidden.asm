;
;	Hidden
;	Copyright (C) 1991 David Winter
;
	.title	"Hidden version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
	jump	L1
;
	.byte	10
	.ascii	"Hidden version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
L1:
	load	i, L29
	load	v0, 0
	load	v1, 64
	save	v1
L2:
	load	i, L29
	load	v0, 0
	save	v0
	clear
	load	i, L33
	load	v0, 12
	load	v1, 8
	load	v2, 15
L3:
	draw	v0, v1, 15
	add	v0, 8
	add	i, v2
	skip.eq	v0, 52
	jump	L3
	load	v0, key
	clear
	load	i, L34
	load	v0, 19
	load	v1, 13
	load	v2, 4
L4:
	draw	v0, v1, 4
	add	v0, 8
	add	i, v2
	skip.eq	v0, 43
	jump	L4
	load	i, L27
	restore	vF
	load	i, L28
	save	vF
	load	v3, 64
	load	v6, 8
L5:
	rnd	v1, 15
	rnd	v2, 15
	load	i, L28
	add	i, v1
	restore	v0
	load	v4, v0
	load	i, L28
	add	i, v2
	restore	v0
	load	v5, v0
	load	v0, v4
	save	v0
	load	i, L28
	add	i, v1
	load	v0, v5
	save	v0
	add	v3, 255
	skip.eq	v3, 0
	jump	L5
	clear
	load	v0, 0
	load	v1, 0
	load	i, L32
L6:
	draw	v0, v1, 7
	add	v0, 8
	skip.eq	v0, 32
	jump	L6
	load	v0, 0
	add	v1, 8
	skip.eq	v1, 32
	jump	L6
	load	vC, 0
	load	vD, 0
	load	vE, 0
L7:
	load	i, L29
	restore	v0
	add	v0, 1
	save	v0
	call	L16
	load	vA, 16
	call	L11
	call	L18
	load	vA, v9
	load	v7, vD
	load	v8, vE
	call	L11
	call	L18
	call	L16
	load	i, L28
	add	i, v9
	restore	v0
	load	v1, v0
	load	i, L28
	add	i, vA
	restore	v0
	skip.eq	v0, v1
	jump	L10
	call	L20
	load	v0, 32
	call	L24
	call	L20
	load	v0, 0
	load	i, L28
	add	i, v9
	save	v0
	load	i, L28
	add	i, vA
	save	v0
	add	v6, 255
	skip.eq	v6, 0
	jump	L7
	load	i, L29
	restore	v1
	load	v2, v0
	sub	v0, v1
	skip.eq	vF, 0
	jump	L8
	load	v0, v2
	load	v1, v2
	save	v1
L8:
	clear
	load	i, L40
	load	v0, 16
	load	v1, 7
	load	v2, 14
L9:
	draw	v0, v1, 15
	add	v0, 8
	add	i, v2
	skip.eq	v0, 48
	jump	L9
	load	i, L29
	restore	v1
	load	v4, v1
	load	v3, v0
	load	v6, 9
	call	L26
	load	v6, 15
	load	v3, v4
	call	L26
	load	v0, key
	jump	L2
L10:
	call	L19
	load	v0, 128
	call	L24
	call	L19
	load	i, L28
	add	i, vA
	restore	v0
	add	v0, 255
	call	L23
	load	i, L30
	add	i, v0
	draw	v7, v8, 7
	load	i, L32
	draw	v7, v8, 7
	load	i, L28
	add	i, v9
	restore	v0
	add	v0, 255
	call	L23
	load	i, L30
	add	i, v0
	draw	vD, vE, 7
	load	i, L32
	draw	vD, vE, 7
	jump	L7
L11:
	load	i, L31
	draw	vD, vE, 7
	load	vB, key
	draw	vD, vE, 7
	skip.eq	vB, 4
	jump	L12
	skip.ne	vD, 0
	jump	L11
	add	vD, 248
	add	vC, 255
L12:
	skip.eq	vB, 6
	jump	L13
	skip.ne	vD, 24
	jump	L11
	add	vD, 8
	add	vC, 1
L13:
	skip.eq	vB, 2
	jump	L14
	skip.ne	vE, 0
	jump	L11
	add	vE, 248
	add	vC, 252
L14:
	skip.eq	vB, 8
	jump	L15
	skip.ne	vE, 24
	jump	L11
	add	vE, 8
	add	vC, 4
L15:
	skip.eq	vB, 5
	jump	L11
	load	i, L28
	add	i, vC
	restore	v0
	skip.ne	v0, 0
	jump	L11
	load	v9, vC
	skip.ne	v9, vA
	jump	L11
	add	v0, 255
	load	i, L32
	draw	vD, vE, 7
	load	i, L30
	call	L23
	add	i, v0
	draw	vD, vE, 7
	ret
L16:
	load	i, L35
	load	v0, 36
	load	v1, 10
	load	v2, 11
L17:
	draw	v0, v1, 11
	add	v0, 8
	add	i, v2
	skip.eq	v0, 60
	jump	L17
	ret
L18:
	load	v0, 52
	load	v1, 16
	load	i, L36
	draw	v0, v1, 5
	load	i, L37
	draw	v0, v1, 5
	ret
L19:
	load	i, L38
	jump	L21
L20:
	load	i, L39
L21:
	load	v0, 36
	load	v1, 13
	load	v2, 5
L22:
	draw	v0, v1, 5
	add	v0, 8
	add	i, v2
	skip.eq	v0, 60
	jump	L22
	ret
L23:
	load	v1, v0
	add	v1, v1
	add	v0, v0
	add	v0, v0
	add	v0, v0
	sub	v0, v1
	ret
L24:
	load	time, v0
L25:
	load	v0, time
	skip.eq	v0, 0
	jump	L25
	ret
L26:
	load	i, L28
	bcd	v3
	restore	v2
	load	v5, 35
	hex	v1
	draw	v5, v6, 5
	load	v5, 40
	hex	v2
	draw	v5, v6, 5
	ret
L27:
	.byte	0x01
	.byte	0x02
	.byte	0x03
	.byte	0x04
	.byte	0x08
	.byte	0x07
	.byte	0x06
	.byte	0x05
	.byte	0x05
	.byte	0x06
	.byte	0x07
	.byte	0x08
	.byte	0x04
	.byte	0x03
	.byte	0x02
	.byte	0x01
L28:
	.byte	0x01
	.byte	0x02
	.byte	0x03
	.byte	0x04
	.byte	0x08
	.byte	0x07
	.byte	0x06
	.byte	0x05
	.byte	0x05
	.byte	0x06
	.byte	0x07
	.byte	0x08
	.byte	0x04
	.byte	0x03
	.byte	0x02
	.byte	0x01
L29:
	.ds	0x2
L30:
	.pic	"******* ",
		"*** *** ",
		"**   ** ",
		"*     * ",
		"**   ** ",
		"*** *** ",
		"******* ",
		"******* ",
		"**   ** ",
		"**   ** ",
		"**   ** ",
		"******* ",
		"******* ",
		"**   ** ",
		"* * * * ",
		"*     * ",
		"* * * * ",
		"**   ** ",
		"******* ",
		"**   ** ",
		"*     * ",
		"*     * ",
		"*     * ",
		"**   ** ",
		"******* ",
		"* *** * ",
		"** * ** ",
		"*** *** ",
		"** * ** ",
		"* *** * ",
		"******* ",
		"*** *** ",
		"*** *** ",
		"*     * ",
		"*** *** ",
		"*** *** ",
		"******* ",
		"*     * ",
		"******* ",
		"*     * ",
		"******* ",
		"*     * ",
		"******* ",
		"* * * * ",
		"* * * * ",
		"* * * * ",
		"* * * * ",
		"* * * * "
L31:
	.pic	"******* ",
		"******* ",
		"******* ",
		"******* ",
		"******* ",
		"******* "
L32:
	.pic	"******* ",
		"* * * * ",
		"** * ** ",
		"* * * * ",
		"** * ** ",
		"* * * * ",
		"******* "
L33:
	.pic	"*   * **",
		"*   *   ",
		"*****   ",
		"*   *   ",
		"*   * **",
		"        ",
		"        ",
		"        ",
		"        ",
		"        ",
		"****    ",
		" *  *   ",
		" *  *   ",
		" *  *   ",
		"****  * ",
		"*** ****",
		"*    *  ",
		"*    *  ",
		"*    *  ",
		"*** ****",
		"        ",
		"    *   ",
		"    *   ",
		"    * * ",
		"        ",
		"*   * * ",
		"*   * * ",
		"* * * * ",
		"* * * * ",
		" * *  * ",
		"  ****  ",
		"*  *  * ",
		"*  *  * ",
		"*  *  * ",
		"  ****  ",
		"        ",
		"***   * ",
		"* *   **",
		"***   **",
		"        ",
		"*   * **",
		"**  *   ",
		"* * *   ",
		"*  **   ",
		"*   *   ",
		"***** * ",
		"*     **",
		"***   * ",
		"*     * ",
		"***** * ",
		"        ",
		"  * *   ",
		"* ***   ",
		"*  *    ",
		"        ",
		"*** ****",
		"*   *   ",
		"*   *** ",
		"*   *   ",
		"*   ****",
		"  *    *",
		"  *    *",
		"* *    *",
		" **     ",
		"  *    *",
		"        ",
		"        ",
		"        ",
		"        ",
		"        ",
		"* ****  ",
		"  *   * ",
		"  ****  ",
		"  * *   ",
		"* *  *  "
L34:
	.pic	"*   *  *",
		"*   * * ",
		"* * * **",
		" * *  * ",
		"*  * ***",
		" * *   *",
		"** *   *",
		" * *   *",
		"**      ",
		"        ",
		"        ",
		"   * * *"
L35:
	.pic	" ** * * ",
		"*   * * ",
		"*   *** ",
		"*   * * ",
		" ** * * ",
		"        ",
		" **  *  ",
		"*   * * ",
		"*   *** ",
		"*   * * ",
		" ** * * ",
		" *   *  ",
		"* * * * ",
		"* * * * ",
		"* * * * ",
		" *   *  ",
		"        ",
		"**  **  ",
		"* * * * ",
		"**  * * ",
		"* * * * ",
		"* * **  ",
		" ** *** ",
		"*   *   ",
		" *  **  ",
		"  * *   ",
		"**  *** ",
		"        "
L36:
	.pic	"     *  ",
		"    **  ",
		"     *  ",
		"     *  ",
		"    *** "
L37:
	.pic	"    **  ",
		"   *  * ",
		"     *  ",
		"    *   ",
		"   **** "
L38:
	.pic	" **   **",
		"*  * *  ",
		"*  * *  ",
		"*  * *  ",
		" **   **",
		"  ***   ",
		"* *  * *",
		"* ***   ",
		"* *     ",
		"  *    *",
		"***    *",
		"       *",
		"**     *",
		"  *     ",
		"**     *"
L39:
	.pic	"*   *  *",
		"*   * * ",
		" * *  * ",
		"  *   * ",
		"  *    *",
		"**  ****",
		"  * *   ",
		"  * ****",
		"  * *   ",
		"**  *   ",
		"      * ",
		"*     * ",
		"      * ",
		"        ",
		"      * "
L40:
	.pic	"********",
		"*       ",
		"*   ****",
		"*  *    ",
		"*   *** ",
		"*      *",
		"*  **** ",
		"*       ",
		"*  *   *",
		"*  *   *",
		"*  *****",
		"*  *   *",
		"*  *   *",
		"*       ",
		"********",
		"        ",
		"  ****  ",
		" *      ",
		" *      ",
		" *      ",
		"  ****  ",
		"        ",
		" *****  ",
		"   *    ",
		"   *    ",
		"   *    ",
		" *****  ",
		"        ",
		"********",
		"        ",
		"        ",
		"*       ",
		"        ",
		"*       ",
		"        ",
		"        ",
		"        ",
		"*       ",
		"        ",
		"*       ",
		"        ",
		"        ",
		"********",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"       *",
		"********"
