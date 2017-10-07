;
;	snake - a game of skill, for chip8
;	Copyright (C) 1990, 1998, 2012 Peter Miller
;
;	This program is free software; you can redistribute it and/or modify
;	it under the terms of the GNU General Public License as published by
;	the Free Software Foundation; either version 2 of the License, or
;	(at your option) any later version.
;
;	This program is distributed in the hope that it will be useful,
;	but WITHOUT ANY WARRANTY; without even the implied warranty of
;	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;	GNU General Public License for more details.
;
;	You should have received a copy of the GNU General Public License
;	along with this program. If not, see
;	<http://www.gnu.org/licenses/>.
;
	.title	"Snake",
		"Copyright (C) 1998, 2012 Peter Miller"
	.xref	on
	jump	start
;
	.byte	10
	.ascii	"Snake"
	.byte	10
	.ascii	"Copyright (C) 1998, 2012 Peter Miller"
	.byte	10
	.align
start:
;
x	.equ	v14		; snake head position
y	.equ	v13
lvl	.equ	v12		; maze level
dir	.equ	v11
snake_length .equ v10
ax	.equ	v9		; apple position
ay	.equ	v8
dead	.equ	v7
snake_head .equ	v6
snake_tail .equ	v5

;
; draw the intro screen
; and wait for the user to press any key
;
	call	draw_intro_screen
	load	v0, key

;
; Start playing.
;
new_game:
	call	init_lives_left
	call	snake_init_zero
	load	lvl, 0		; starts on easiest level

	call	poll_keyboard_init
	call	zero_score
;
; Start a new level.
;
new_level:
	call	find_level_pointer
	call	draw_level
	call	init_snake
	call	place_apple
	load	x, 32
	load	y, 30
	load	dir, 0		; starts out heading straight up
	load	dead, 0

play_loop:
	call	move_snake
	skip.eq	dead, 0
	jump	leave_play_loop
	call	twinkle_apple
	call	poll_keyboard
	call	dir_delta
	add	x, v0
	add	y, v1
	jump	play_loop

;
; the snake ran into something
; or escaped
;
leave_play_loop:
	skip.ne	dead, 2
	jump	game_win
	skip.ne	dead, 3
	jump	game_over
	skip.eq	y, 2
	jump	new_level
	add	lvl, 1
	skip.ne	lvl, 5
	load	lvl, 0
	jump	new_level

game_win:
	call	show_game_win
	load	v0, key
	jump	new_game

game_over:
	call	show_game_over
	load	v0, key
	jump	new_game

dir_delta:
	load	v0, 3
	and	v0, dir
	add	v0, v0
	load	v1, v0
	add	v1, v1
	add	v0, v1
	jump	dir_delta_table, v0
dir_delta_table:
	load	v0, 0
	load	v1, -1
	ret
	load	v0, -1
	load	v1, 0
	ret
	load	v0, 0
	load	v1, 1
	ret
	load	v0, 1
	load	v1, 0
	ret

find_level_pointer:
	load	v0, lvl
	add	v0, v0
	add	v0, v0
	jump	find_level_pointer_goto, v0
find_level_pointer_goto:
	load	i, level_zero
	ret
	load	i, level_one
	ret
	load	i, level_two
	ret
	load	i, level_three
	ret
	load	i, level_four
	ret

snake_init_zero:
	load	snake_length, 8	; snake starts out 8 long (none visable)
	load	snake_tail, 0
	load	snake_head, snake_length
	ret

;
; set the snake ring buffer
;	whole buffer is set to (0, 0)
;
; trashes:
;	v0, v1, v2, i
;
init_snake:
	load	i, snake
	add	i, snake_tail
	add	i, snake_tail
	load	v0, 0
	load	v1, 0
	load	v2, snake_tail
init_snake_loop:
	save	v1
	add	v2, 1
	skip.ne	v2, snake_head
	ret
	skip.ne	v2, 0
	load	i, snake
	jump	init_snake_loop

;
; passed:
;	new snake position in (x, y)
;
move_snake:
	; see if would hit the apple
	skip.eq	x, ax
	jump	move_snake_no_apple
	skip.eq	y, ay
	jump	move_snake_no_apple

	; snake eats apple
	rnd	v2, 7
	add	v2, 3
	call	add_score
	call	grow_snake
	skip.ne	dead, 2
	ret
	call	place_apple
	jump	move_snake_remember

move_snake_no_apple:
	load	i, dot		; draw new head
	draw	x, y, 1
	skip.eq	v15, 1
	jump	not_dead_yet
	load	dead, 1
	call	dec_apples_this_level
	jump	use_one_life

not_dead_yet:
	skip.ne	y, 2
	load	dead, 1

move_snake_remember:
	load	i, snake	; remember where it is
	add	i, snake_head
	add	i, snake_head
	load	v0, x
	load	v1, y
	save	v1
	add	snake_head, 1	; advance head index
	load	i, snake	; get old tail pos
	add	i, snake_tail
	add	i, snake_tail
	restore	v1
	skip.ne	v0, 0
	jump	move_snake_blank
	load	i, dot		; rub out tail (if it was there)
	draw	v0, v1, 1
	load	i, snake	; clear old tail pos
	add	i, snake_tail
	add	i, snake_tail
	load	v0, 0
	load	v1, 0
	save	v1
	jump	move_snake_fix_tail
move_snake_blank:
	load	i, blank	; draw nothing
	draw	v0, v1, 1	; for same speed
move_snake_fix_tail:
	add	snake_tail, 1	; advance tail index
	ret

;
; passed:
;	v2 - length to grow
;
; trashes:
;	i, v0, v1, v2, v3
;
grow_snake:
	add	snake_length, v2
	skip.eq	v15, 0
	jump	game_over_death
	sub	snake_tail, v2
	load	i, snake
	add	i, snake_tail
	add	i, snake_tail
	load	v0, 0
	load	v1, 0
	load	v3, snake_tail
grow_snake_tail:
	save	v1
	add	v2, -1
	add	v3, 1
	skip.ne	v3, 0
	load	i, snake
	skip.ne	v2, 0
	jump	grow_snake_tail
	ret
game_over_death:
	load	dead, 2
	sub	snake_length, v2
	ret

snake:
	.ds	512
blank:
	.byte	0x00
dot:
	.byte	0x80

twinkle_apple:
	load	i, dot
	skip.ne	ax, 0
	load	i, blank
	draw	ax, ay, 1
	draw	ax, ay, 1
	ret

dec_apples_this_level:
	load	i, apples_this_level
	restore	v0
	add	v0, -1
	load	i, apples_this_level
	save	v0
	ret

place_apple:
	load	i, apples_this_level
	restore	v0
	add	v0, 1
	skip.ne	v0, 6
	jump	place_apple_make_exit
	load	i, apples_this_level
	save	v0
	;
	rnd	ax, 63
	load	v0, 62
	dif	v0, ax
	skip.ne	vF, 0
	jump	place_apple
	add	ax, 1
place_apple_y:
	rnd	ay, 31
	load	v0, 24
	dif	v0, ay
	skip.ne	vF, 0
	jump	place_apple_y
	add	ay, 7

	load	i, dot
	draw	ax, ay, 1
	skip.ne	vF, 0
	ret
	draw	ax, ay, 1
	jump	place_apple
place_apple_make_exit:
	load	v0, 32
	load	v1, 2
	load	i, dot
	draw	v0, v1, 1
	load	i, apples_this_level
	load	v0, 0
	save	v0
	load	ax, 0
	load	ay, 0
	ret
;
; draw a level
;	levels are assumed to be 64x26
;	drawn at scan line 6 down
;
; passed:
;	i - points to level pic
;
; trashes:
;	v0, x, y, v15, i
;
draw_level:
	clear
	load	x, 0
draw_level_loop:
	load	y, 2
	draw	x, y, 15
	load	v0, 15
	add	i, v0
	add	y, v0
	draw	x, y, 15
	add	i, v0
	add	x, 8
	skip.eq	x, 64
	jump	draw_level_loop
	call	clear_level_score
	call	update_level_score
	jump	show_lives
;
; draw the intro screen
;
; trashes:
;	v0, x, y, v15, i
;
draw_intro_screen:
	clear
	load	x, 0
	load	i, intro_screen
draw_intro_screen_loop:
	load	y, 0
	draw	x, y, 11
	load	v0, 11
	add	i, v0
	add	y, v0
	draw	x, y, 11
	add	i, v0
	add	y, v0
	draw	x, y, 10
	load	v0, 10
	add	i, v0
	add	x, 8
	skip.eq	x, 64
	jump	draw_intro_screen_loop
	ret
intro_screen:
.pic	"        *******                             **                  ",
	"      **       **                           **                  ",
	"     *           *                          **                  ",
	"    *     *****   *                         **                  ",
	"   *     *     *   *                        **                  ",
	"   *    *       *  *  ** ****      **** **  **   **   ****      ",
	"   *   *        *  *  ********    ********  **  **   ******     ",
	"   *   *         * *  ***    **  **    ***  ** **   **    **    ",
	"   *   *          *   **     **  **     **  ****    **    **    ",
	"   *   *              **     **  **     **  ***     ********    ",
	"    *   *             **     **  **     **  ****    **          ",
	"    *    *            **     **  **    ***  ** **   **          ",
	"     *    *           **     **   ********  **  ***  ******     ",
	"      *    **         **     **    **** **  **   **   ****      ",
	" *     *     **                                                 ",
	"  **    **     **                                               ",
	" *  *     **     *                      ***        *            ",
	"    *       **    *                     *  *       *            ",
	"   *          *    *                    *  *  **  ***  **  * ** ",
	"   *           *   *                    ***  *  *  *  *  * **   ",
	"  ****          *   *                   *    ****  *  **** *    ",
	" *    *         *   *      ***  *   *   *    *     *  *    *    ",
	"*      *        *   *      *  *  * *    *     ***   *  *** *    ",
	"* *  * *        *   *      ***    *                             ",
	"*      *        *   *      *  *   *                             ",
	" *      **     *    *      ***    *     *   *    *  *           ",
	" *        *****     *                   ** ** *  *  *           ",
	"  *                 *                   * * *    *  *   **  * **",
	"   *               *                    *   * *  *  *  *  * **  ",
	"    **             *                    *   * *  *  *  **** *   ",
	"      **         **                     *   * *  *  *  *    *   ",
	"        *********                       *   *  *  *  *  *** *   "
level_zero:
.pic	"*************************************************               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               **1234*1234*1234",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"****************************************************************"
level_one:
.pic	"*************************************************               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               **1234*1234*1234",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*           ****************************************           *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"****************************************************************"
level_two:
.pic	"*************************************************               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               **1234*1234*1234",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*       ************************************************       *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*       ************************************************       *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"****************************************************************"
level_three:
.pic	"*************************************************               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               **1234*1234*1234",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*       ************************************************       *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*                               *                              *",
	"*       ************************************************       *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"****************************************************************"
level_four:
.pic	"*************************************************               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               *               ",
	"*                                               **1234*1234*1234",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*       ***********************   **********************       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       *                                              *       *",
	"*       ************************************************       *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"*                                                              *",
	"****************************************************************"
	.align

poll_keyboard_init:
;	load	v0, 0
;	load	i, poll_keyboard_hit
;	save	v0
	ret

poll_keyboard:
;	load	i, poll_keyboard_hit
;	restore	v0
;	skip.ne	v0, 0
;	jump	poll_keyboard_new
;	skip.eq	v0, key
;	call	poll_keyboard_init
;	ret
;
;poll_keyboard_new:
	load	v0, 4
	skip.eq	v0, key
	jump	poll_keyboard_more
	; key 4 pressed
	add	dir, 1
poll_keyboard_store:
;	load	i, poll_keyboard_hit
;	save	v0
	ret
poll_keyboard_more:
	load	v0, 6
	skip.eq	v0, key
	ret
	; key 6 pressed
	add	dir, -1
	jump	poll_keyboard_store
poll_keyboard_hit:
	.ds	1
	.align

;
; point i at the difference between 2 decimal digits
;
; Passed:
;	v0 - new digit (10 == blank)
;	v1 - old digit (10 == blank)
;
; Trashes:
;	v0, v1, i
;
digit_xor:
	load	i, digit_xor_save10
	save	v9
	load	i, digit_xor_table
	add	i, v1
	add	i, v1
	add	i, v1
	add	i, v1
	add	i, v1
	restore	v4
	load	v5, v0
	load	v6, v1
	load	v7, v2
	load	v8, v3
	load	v9, v4
	load	i, digit_xor_save10
	restore	v0
	load	i, digit_xor_table
	add	i, v0
	add	i, v0
	add	i, v0
	add	i, v0
	add	i, v0
	restore	v4
	xor	v0, v5
	xor	v1, v6
	xor	v2, v7
	xor	v3, v8
	xor	v4, v9
	load	i, digit_xor_image
	save	v4
	load	i, digit_xor_save10
	restore	v9
	; i is now pointing at digit_xor_image
	ret

digit_xor_save10:
	.ds 10
digit_xor_image:	; order of these two is important, see code
	.ds 5
digit_xor_table:
	.byte	0xF0, 0x90, 0x90, 0x90, 0xF0
	.byte	0x20, 0x60, 0x20, 0x20, 0x70
	.byte	0xF0, 0x10, 0xF0, 0x80, 0xF0
	.byte	0xF0, 0x10, 0xF0, 0x10, 0xF0
	.byte	0x90, 0x90, 0xF0, 0x10, 0x10
	.byte	0xF0, 0x80, 0xF0, 0x10, 0xF0
	.byte	0xF0, 0x80, 0xF0, 0x90, 0xF0
	.byte	0xF0, 0x10, 0x20, 0x40, 0x40
	.byte	0xF0, 0x90, 0xF0, 0x90, 0xF0
	.byte	0xF0, 0x90, 0xF0, 0x10, 0xF0
	.byte	0x00, 0x00, 0x00, 0x00, 0x00
	.align

clear_level_score:
	load	i, level_score
	load	v0, 10
	save	v0
	save	v0
	save	v0
	ret

level_score:
	.ds	3
level_score_new:
	.ds	3
numeric_score:
	.ds	1
apples_this_level:
	.ds	1

;
; update the score indicator on the screen
;
; Trashes:
;	v0, v1, i
;
update_level_score:
	load	i, numeric_score	; convert the numeric score to a string
	restore	v0
	load	i, level_score_new
	bcd	v0
	restore	v0			; blank leading zeros
	skip.eq	v0, 0
	jump	update_level_score_2
	load	v0, 10
	load	i, level_score_new
	save	v0
	restore	v0
	skip.eq	v0, 0
	jump	update_level_score_2
	load	v0, 10
	load	i, level_score_new + 1
	save	v0
update_level_score_2:
	load	i, level_score	; update 100s digit
	restore	v0
	load	v1, v0
	load	i, level_score_new
	restore v0
	skip.ne	v0, v1
	jump	update_level_score_3
	load	i, level_score
	save	v0
	call	digit_xor
	load	v0, 50
	load	v1, 0
	draw	v0, v1, 5
update_level_score_3:
	load	i, level_score + 1	; update 10s digit
	restore	v0
	load	v1, v0
	load	i, level_score_new + 1
	restore v0
	skip.ne	v0, v1
	jump	update_level_score_4
	load	i, level_score + 1
	save	v0
	call	digit_xor
	load	v0, 55
	load	v1, 0
	draw	v0, v1, 5
update_level_score_4:
	load	i, level_score + 2	; update 1s digit
	restore	v0
	load	v1, v0
	load	i, level_score_new + 2
	restore v0
	skip.ne	v0, v1
	ret
	load	i, level_score + 2
	save	v0
	call	digit_xor
	load	v0, 60
	load	v1, 0
	draw	v0, v1, 5
	ret

zero_score:
	load	v0, 0
	load	i, numeric_score
	save	v0
	load	i, apples_this_level
	save	v0
	ret

add_score:
	load	i, numeric_score
	restore	v0
	add	v0, v2
	load	i, numeric_score
	save	v0
	call	update_level_score
	ret

game_win_image:
.pic	"**     **     *       *  * ",
	"**     **    *        *  * ",
	"**    ***    *        *  * ",
	" **   * **   *        *  * ",
	" **   * **  *   ***   *  * ",
	" **  *  **  *  *   *  *  * ",
	"  ** *   ** *  *****  *  * ",
	"  ** *   ** *  *      *  * ",
	"  ***    ***   *   *  *  * ",
	"   **     **    ***    *  *",
	"                           ",
	"******                     ",
	"**  ***                    ",
	"**   **                    ",
	"**   **                    ",
	"**   **  ***  * **   ***   ",
	"**   ** *   * **  * *   *  ",
	"**   ** *   * *   * *****  ",
	"**   ** *   * *   * *      ",
	"**  *** *   * *   * *   *  ",
	"******   ***  *   *  ***   "
	.align

show_game_win:
	load	i, game_win_image
	jump	show_game_over_foo

face_image:
.pic	"  *** * * *      *   * * *******   ",		; 35 wide
	"  **** *            * * * ******   ",		; 32 high
	" ***        *    * *   * *******   ",
	" **** *  *     *    * *  * ******  ",
	"*** * *           * * * * *******  ",
	"*****  *           * * ** * *****  ",
	"***  *   *  *     * **** ********  ",
	"**** * *       * *** * *** * ****  ",
	"*** * *         ** ** *  ********* ",
	"**** * * *     * * * *  * *   ***  ",
	" ******** *    * ******* * ***** * ",
	" **** * *** *   *   ** ** *    ** *",
	" **** * ** *   * ******  * ** ***  ",
	"  * * *******  * *      *    * *** ",
	"  *******  * * *  * *  * * ** ** * ",
	"  *** ** * **  * *  * *   *  * *** ",
	"  * ** * * *  * *          * * ** *",
	"  **  * * * *   * *          ** ***",
	"  ** * *   *  * *        * ** ***  ",
	"   * *     *      *         * *****",
	"   *  *    *   ** *        * ** ** ",
	"   **       ** * *    *     * ***  ",
	"   * *     * ** *** *    * * ** *  ",
	"   **      ********** **   * ****  ",
	"   * *   *** * ******** ** *** **  ",
	"   ** * ** ****** * * **** * ****  ",
	"    ** ** *** * ******* ****** **  ",
	"    *** ****** *      **** * ****  ",
	"    ** **** * * **** * * ****** *  ",
	"    ****** *** *** * * **********  ",
	"     ** ** ***** *** ************  ",
	"     ******* * ***** * * ********  "
	.align

game_over_image:
.pic	" *****                     ",		; 27 wide
	"**   **                    ",		; 21 high
	"**                         ",
	"**                         ",
	"**      ****  *** **   *** ",
	"**  ***     * *  *  * *   *",
	"**   **  **** *  *  * *****",
	"**   ** *   * *  *  * *    ",
	"**   ** *   * *  *  * *   *",
	" *****   ***  *  *  *  *** ",
	"                           ",
	" *****                     ",
	"**   **                    ",
	"**   **                    ",
	"**   **                    ",
	"**   ** *   *  ***  * **   ",
	"**   ** *   * *   * **  *  ",
	"**   ** *   * ***** *      ",
	"**   **  * *  *     *      ",
	"**   **  * *  *   * *      ",
	" *****    *    ***  *      "
	.align

show_game_over:
	load	i, game_over_image
show_game_over_foo:
	clear
	load	x, 0
show_game_over_loop:
	load	y, 4
	draw	x, y, 11
	load	v0, 11
	add	y, v0
	add	i, v0
	draw	x, y, 10
	load	v0, 10
	add	y, v0
	add	i, v0
	add	x, 8
	skip.eq	x, 32
	jump	show_game_over_loop

	; draw the author's smiling face
	load	i, face_image
	load	x, 29
show_game_over_face_loop:
	load	y, 0
	draw	x, y, 11
	load	v0, 11
	add	y, v0
	add	i, v0
	draw	x, y, 11
	add	y, v0
	add	i, v0
	draw	x, y, 10
	load	v0, 10
	add	i, v0
	add	x, 8
	skip.eq	x, 69
	jump	show_game_over_face_loop
	ret

show_lives:
	load	i, lives_left
	restore	v0
	load	v2, v0
	add	v2, v2
	load	i, dot
	load	v0, 0
	load	v1, 0
show_lives_loop:
	skip.ne	v0, v2
	ret
	draw	v0, v1, 1
	add	v0, 2
	jump	show_lives_loop
init_lives_left:
	load	i, lives_left
	load	v0, 4
	save	v0
	ret
use_one_life:
	load	i, lives_left
	restore	v0
	add	v0, -1
	load	i, lives_left
	save	v0
	skip.eq	v0, -1
	ret
	load	v0, 0
	load	i, lives_left
	save	v0
	load	dead, 3
	ret
lives_left:
	.ds	1
	.align
