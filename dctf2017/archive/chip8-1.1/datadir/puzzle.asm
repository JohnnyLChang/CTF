;
; From: Roger Ivie <SLSW2@cc.usu.edu>
; Newsgroups: comp.sys.handhelds
; Subject: PUZZLE for CHIP8
; Date: 20 Sep 90 01:35:42 GMT
;
;
; Copyright (C) 1990 Roger Ivie.
; Reproduced by permission.
;
; Here is the infamous 15 puzzle for CHIP8. The puzzle,
; as you doubtless recall, has 15 squares numbered 1 through 15 (in this case,
; 1 through F) and one hole. You can move the hole about and must put the
; pieces in order.
;
; When you first run puzzle, it comes up solved. Thereafter, pressing ENTER
; causes the puzzle to have 32 random moves made, effectively randomizing the
; puzzle. If 32's not enough for you, just press ENTER again.
;
; You enter moves by using the 4x4 keypad area used by CHIP8. The key's
; position in that 4x4 matrix corresponds to the square in that position of
; the puzzle matrix. Pushing a key causes the hole to migrate to that
; position. The migration is performed in the order up, down, left, right;
; it is not necessary to limit your moves to those rows and columns containing
; the hole; you can request that the hole move to any position.
;
; The program does not check to see if you've solved the puzzle, and therefore
; nothing special happens when you do except for the warm, fuzzy feeling that
; you have beaten it.
;
; It's really simple and I wrote it mainly to familiarize myself with
; CHIP8.
;
; Enjoy.
;
	.title	"Puzzle version 1.0",
		"Copyright (C) 1990 Roger Ivie"
	.xref	on
	jump	beginning
;
	.byte	10
	.ascii	"Puzzle version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1990 Roger Ivie"
	.byte	10
	.align
beginning:
;
; Register usage:
;
; V0 - Used to grab things from memory
; V1 - Current piece to be displayed
; V2 - X coordinate where it is to be displayed
; V3 - Y coordinate where it is to be displayed
; V4 - General work; new hole position for swap_hole
; V5 - General work
; VC - Number of random moves to insert into the puzzle
; VD - Desired position of the hole
; VE - Current position of the hole

		CLS
START:
		LD	VC, 0		; Number of moves to randomize
		SKNE	VC, 0		; If first start, will skip
		LD	VE, 0x0F	; Hole position when first started
		LD	I, START + 1	; Plug the number of moves to randomize
		LD	V0, 32
		LD	[I], V0
		CLS			; Clear the screen
LOOP:
		CALL	GET_MOVE
		CALL	MOVE_UP
		CALL	MOVE_DOWN
		CALL	MOVE_LEFT
		CALL	MOVE_RIGHT
		JUMP	LOOP

		.byte	13, 10
		.ascii	"Puzzle version 1.0"
		.byte	13, 10
		.ascii	"Copyright (C) 1990 Roger Ivie"
		.byte	13, 10
		.align

;------------------

XSTART		EQU	23		; Horizontal position of board
YSTART		EQU	4		; Vertical position of board
XOFF		EQU	5		; Horizontal offset to next piece
YOFF		EQU	6		; Vertical offset to next piece

DISPLAY:

; State 1: Initialize everything to be about the first piece on the board
; and go to state 2.

DISPLAY_1:
		LD	V1, 0
		LD	V2, XSTART
		LD	V3, YSTART

; State 2: If all pieces have been displayed, exit. Otherwise, go to state 3.

DISPLAY_2:
		SKNE	V1, 0x10
		RET

; State 3: Get the next piece to be displayed. If it's the hole (and therefore
; shouldn't be displayed), go to state 5. Otherwise go to state 4.

DISPLAY_3:
		LD	I, BOARD
		ADD	I, V1
		LD	V0, [I]
		SKNE	V0, 0
		JUMP	DISPLAY_5

; State 4: Display the current piece and go to state 5.

DISPLAY_4:
		hex	V0
		SHOW	V2, V3, 5

; State 5: Advance the piece pointer and the horizontal position of the
; display to the next piece. If the new piece is the first in a new row,
; go to state 6. Otherwise go to state 2.

DISPLAY_5:
		ADD	V1, 1
		ADD	V2, XOFF
		LD	V4, 3
		AND	V4, V1
		SKEQ	V4, 0
		JUMP	DISPLAY_2

; State 6: The piece is the first of a new row. Reinitialize the horizontal
; position to the first of the row and advance the vertical position to the
; next row. Go to state 2.

DISPLAY_6:
		LD	V2, XSTART	; Start at beginning of next row.
		ADD	V3, YOFF
		JUMP	DISPLAY_2

;-------

MOVE_RIGHT:

; State 1: Check to see if the desired hole position and the current hole
; position are in the same column. If so, exit. Otherwise, go to state 2.

MOVE_RIGHT_1:
		LD	V4, 3		; Get horizontal position of hole
		AND	V4, VE
		LD	V5, 3		; Get horizontal position of new hole
		AND	V5, VD
		SKNE	V4, V5
		RET

; State 2: If the hole cannot be moved any farther right, exit. Otherwise
; go to state 3.

MOVE_RIGHT_2:
		SKNE	V4, 3
		RET

; State 3: Move the hole right one position and go back to state 1.

MOVE_RIGHT_3:
		LD	V4, 1
		ADD	V4, VE
		CALL	SWAP_HOLE
		JUMP	MOVE_RIGHT_1

;-------

MOVE_LEFT:

; State 1: Check to see if the desired hole position and the current hole
; position are in the same column. If so, exit. Otherwise, go to state 2.

MOVE_LEFT_1:
		LD	V4, 3		; Get horizontal position of hole
		AND	V4, VE
		LD	V5, 3		; Get horizontal position of new hole
		AND	V5, VD
		SKNE	V4, V5
		RET

; State 2: If the hole cannot be moved any farther left, exit. Otherwise
; go to state 3.

MOVE_LEFT_2:
		SKNE	V4, 0
		RET

; State 3: Move the hole left one position and go back to state 1.

MOVE_LEFT_3:
		LD	V4, -1
		ADD	V4, VE
		CALL	SWAP_HOLE
		JUMP	MOVE_LEFT_1

;-------

MOVE_UP:

; State 1: Check to see if the desired hole position and the current hole
; position are in the same row. If so, exit. Otherwise, go to state 2.

MOVE_UP_1:
		LD	V4, 0x0C	; Get vertical position of hole
		AND	V4, VE
		LD	V5, 0x0C	; Get vertical position of new hole
		AND	V5, VD
		SKNE	V4, V5
		RET

; State 2: If the hole cannot be moved any farther up, exit. Otherwise
; go to state 3.

MOVE_UP_2:
		SKNE	V4, 0
		RET

; State 3: Move the hole up one position and go back to state 1.

MOVE_UP_3:
		LD	V4, -4		; Up = left 4
		ADD	V4, VE
		CALL	SWAP_HOLE
		JUMP	MOVE_UP_1

;-------

MOVE_DOWN:

; State 1: Check to see if the desired hole position and the current hole
; position are in the same row. If so, exit. Otherwise, go to state 2.

MOVE_DOWN_1:
		LD	V4, 0x0C	; Get vertical position of hole
		AND	V4, VE
		LD	V5, 0x0C	; Get vertical position of new hole
		AND	V5, VD
		SKNE	V4, V5
		RET

; State 2: If the hole cannot be moved any farther down, exit. Otherwise
; go to state 3.

MOVE_DOWN_2:
		SKNE	V4, 0x0C
		RET

; State 3: Move the hole down one position and go back to state 1.

MOVE_DOWN_3:
		LD	V4, 4		; Down = right 4
		ADD	V4, VE
		CALL	SWAP_HOLE
		JUMP	MOVE_DOWN_1

;-------

SWAP_HOLE:
		LD	I, BOARD	; Get the piece at the new hole position
		ADD	I, V4
		LD	V0, [I]
		LD	I, BOARD	; Put it at the old hole position
		ADD	I, VE
		LD	[I], V0
		LD	V0, 0		; Put a hole...
		LD	I, BOARD	; ...at the new hole position
		ADD	I, V4
		LD	[I], V0
		LD	VE, V4		; Move the hole marker to the new position
		RET

;-------

GET_MOVE:

; State 1: Check to see if there are any more random moves to select. If so,
; go to state 5. Otherwise go to state 2.
GET_MOVE_1:
		SKEQ	VC, 0
		JUMP	GET_MOVE_5

; State 2: Prompt for and obtain a keystroke: display the board, wait for
; a keystroke, and then erase the board. Go to state 4.

GET_MOVE_2:
		CALL	DISPLAY
		CALL	MYKEY
		CLS

; State 3: <deleted>

; State 4: Translate the keystroke to the new hole position and exit.

GET_MOVE_4:
		LD	I, KEYTABLE
		ADD	I, VD
		LD	V0, [I]
		LD	VD, V0
		RET

; State 5: Decrement the count of random moves remaining, select a random
; hole position, and exit.

GET_MOVE_5:
		ADD	VC, -1
		RAND	VD, 0x0F
		RET

;-------

MYKEY:

; State 1: Continuously scan the keyboard until a key is pressed. When a
; key is pressed, go to state 2.

MYKEY_1:
		LD	VD, KEY

; State 2: Wait for the key to be released. When it is, exit.

MYKEY_2:
		skip.ne VD, key
		JUMP	MYKEY_2
		RET

;-------

; The puzzle board

BOARD:
		DB	 1,  2,  3,  4
		DB	 5,  6,  7,  8
		DB	 9, 10, 11, 12
		DB	13, 14, 15,  0

; Translation table from key number to hole position

KEYTABLE:
		DB	13,  0,  1,  2
		DB	 4,  5,  6,  8
		DB	 9, 10, 12, 14
		DB	 3,  7, 11, 15
