;Paul Raines
;Georgia Institute of Technology, Atlanta Georgia, 30332
;uucp:	   ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!vapsppr
;Internet: vapsppr@prism.gatech.edu
;
;The source code in Chipper for ver 2.0 of H. Piper! follows
;below.	 There are some significant changes in some of the
;logic.	 For people having problems with getting the ASC
;version to run, try compiling this program and using its
;output.
;
;  H. Piper Game for the HP48SX
;  (c) Paul Raines
;
	.title	"H. Piper version 2.0",
		"Copyright (C) 1991 Paul Raines"
	.xref	on
;
;  Register usage:
;  V0:	Temporary data, may change during any call
;  V1:	Temporary data, may change during any call
;  V2:	Temporary data, may change during any call
;  V3:	Temporary data, may change during any call
;  V4:	Temporary data, may change during any call
;  V5:	Temporary data, may change during any call
;  V6:	Temporary data, may change during any call
;  V7:	Current Job Score (ones & tens)
;  V8:	Current Job Score (hundreds & up)
;  V9:	Current Box type
;  VA:	Box progression
;  VB:	Flow direction
;  VC:	Current Box pos
;  VD:	Paddle position
;  VE:	Speed Level
;  VF:	Flag register

;  NOTE: Box position is stored in one register such that
;			 #34h
;		  y pos --^^--- x pos on grid
;
;	 Two registers are used for the score in order to
;	 have a decimal number greater than 255.

; *************************
; START OF DEFINITIONS AREA
; *************************

F_UP		=	#00		; direction definitions
F_DOWN		=	#03
F_RIGHT		=	#06
F_LEFT		=	#05

B_NE		=	#1D		; pipe definitions
B_SW		=	#15
B_NW		=	#1E		; NOTE THAT
B_SE		=	#16		;
B_VERT		=	#01		;    B_SE xor F_UP   and #07 = F_RIGHT
B_HORZ		=	#02		;    B_SW xor F_UP   and #07 = F_LEFT
B_CROS		=	#03		;    B_NE xor F_LEFT and #07 = F_UP
B_ESTR		=	#07		;    ...
B_WSTR		=	#08		;    ...
B_NSTR		=	#09
B_SSTR		=	#0A

; Key definitions
;    ( 7 )  ->	#1    ( 8 )  ->	 #2    ( 9 )  ->  #3	( / )  ->  #C
;    ( 4 )  ->	#4    ( 5 )  ->	 #5    ( 6 )  ->  #6	( * )  ->  #D
;    ( 1 )  ->	#7    ( 2 )  ->	 #8    ( 3 )  ->  #9	( - )  ->  #E
;    ( 0 )  ->	#A    ( . )  ->	 #0    ( _ )  ->  #B	( + )  ->  #F

K_LEFT		=	#07
K_RIGHT		=	#08
K_UP		=	#03
K_DOWN		=	#06
K_FAST		=	#0F
K_PLACE		=	#01
K_UPLACE	=	#04

TYPERATE	=	#90		; repeat rate for holding down key

; ******************
; START OF CODE AREA
; ******************

		JP	FIRST

COPYRIGHT:	.byte	10
		.ascii	"H.Piper version 2.0"
		.byte	10
		.ascii	"Copyright (C) 1991 Paul Raines"
		.byte	10
		.align

FIRST:		high			; turn on extend mode
		LD	V3, R		; read incoming paused score and level
		LD	VE, V2		; starting level
		SNE	V3, #1		; if resuming paused game
		JP	RESUME
		LD	VE, #4E		; starting level
		LD	V0, 0		; Zero out total score
		LD	V1, 0		;   "	       "
RESUME:		LD	I, TSCORE	;  Set total score from flags
		LD	[I], V1		;  "	    "
		LD	VC, #FF		; signal for random starting placement
		LD	V0, 0
		LD	V1, 0
		LD	V2, 0
		LD	R, V2		; clear user flags

; *** SETUP SCREEN, DATA AREA, AND REGISTERS FOR GAME PLAY ***
START:		CLS
		LD	V0, #0B		; Fill grid array data
		LD	V1, #00		; area with unfilled
		LD	V2, 0		; unused grid sites
CLEARGRID:	LD	I, BOXINFO	;  "	    "
		ADD	I, V2		;  "	    "
		LD	[I], V1		;  "	    "
		ADD	V2, 2		;  "	    "
		SE	V2, 120		;  "	    "
		JP	CLEARGRID	;  "	    "
		LD	V0, #00		; Fill preview array data
		LD	V2, 0		; area with blank blocks
CLEARPREV:	LD	I, PBOXINFO	;  "	    "
		ADD	I, V2		;  "	    "
		LD	[I], V1		;  "	    "
		ADD	V2, 2		;  "	    "
		SE	V2, 6		;  "	    "
		JP	CLEARPREV	;  "	    "

		LD	I, TITLE	; Draw title "H. Piper!"
		LD	V0, 38
		LD	V1, 57
		LD	V3, 0
DRAWTITLE:	ADD	I, V3
		DRW	V0, V1, 5
		LD	V3, 5
		ADD	V0, 8
		SE	V0, 70
		JP	DRAWTITLE

		LD	I, HDSCORE	; Draw score and level heading
		LD	V0, 104
		LD	V1, 2
		DRW	V0, V1, 5
		ADD	V0, 8
		LD	V2, 5
		ADD	I, V2
		DRW	V0, V1, 5
		LD	I, HDLEVEL
		LD	V0, 104
		LD	V1, 42
		DRW	V0, V1, 5
		ADD	V0, 8
		LD	V2, 5
		ADD	I, V2
		DRW	V0, V1, 5

		LD	V1, VE		; draw needed score
		SHR	V1
		LD	V0, 100
		SUB	V0, V1		; determine needed score
		LD	I, TEMP
		bcd	V0		; write BCD of needed score
		LD	V2, [I]		; read BCD in three parts
		LD	V3, 90
		LD	V4, 57
		hex	V1		; point to sprite of tens digit
		DRW	V3, V4, 5	; draw it
		ADD	V3, 5
		hex	V2		; point to sprite of ones digit
		DRW	V3, V4, 5	; draw it

		LD	V0, VE		; store the current level in memory
		LD	I, LEVEL	;   in case some uses FAST key
		LD	[I], V0

		LD	I, HORZBOX	; draw top border
		LD	V0, 0
		LD	V1, 0
RDTOP:		DRW	V0, V1, 2
		ADD	V0, 8
		SE	V0, 96
		JP	RDTOP

		LD	V4, 2
RDPRV:		LD	I, PRV1BOX	; Draw preview boxes grids
		LD	V0, 0
		DRW	V0, V4, 12
		LD	I, PRV2BOX
		LD	V0, 8
		DRW	V0, V4, 12
		ADD	V4, 12
		SE	V4, 62
		JP	RDPRV

		LD	V7, 0
PREVAGAIN:	LD	V0, V7		; favor corners for first 4 preview boxes
		CALL	GETRANDBLK	; randomly get five new
		ADD	V7, 1		;    preview boxes
		SE	V7, 5
		JP	PREVAGAIN

		LD	V1, 50		; draw bottom border
		LD	V0, 16
		LD	I, FULLBOX
RDBBDR:		DRW	V0, V1, 6
		ADD	V0, 8
		SE	V0, 96
		JP	RDBBDR

		LD	V1, 0		; Draw right border
		LD	V0, 96
		LD	I, RBORDER
RDRBDR:		DRW	V0, V1, 2
		ADD	V1, 2
		SE	V1, 56
		JP	RDRBDR

		LD	VD, #34		; Draw initial paddles
		CALL	DRAWBPADL
		CALL	DRAWSPADL
		CALL	DRAWCRSHR

		LD	V1, 2		; Draw grid boxes
		LD	I, GRID
RDGRID1:	LD	V0, 16
RDGRID2:	DRW	V0, V1, 8
		ADD	V0, 8
		SE	V0, 96
		JP	RDGRID2
		ADD	V1, 8
		SE	V1, 50
		JP	RDGRID1

		SNE	VC, #FF		; get starting direction and box
		JP	RANDSTART	; if not first job, use last box
NOTCORNER:	SNE	VB, #00		;if last direction was down
		LD	V3, #6		;    make start direction up
		SNE	VB, #03		;if last direction was up
		LD	V3, #4		;    make start direction down
		SNE	VB, #06		;if last direction was right
		LD	V3, #2		;    make start direction left
		SNE	VB, #05		;if last direction was left
		LD	V3, #0		;    make start direction right
		JP	SETUP

RANDSTART:	RND	V3, 7		; Draw random starting box
		ADD	V3, 1
		RND	VC, #30
		ADD	VC, #10
		ADD	VC, V3		; get random placement
		RND	V3, 3
		SHL	V3

SETUP:		LD	I, RANDDIR
		ADD	I, V3		; get random direction of opening
		LD	V1, [I]
		LD	VB, V0		; starting flow direction
		LD	V2, V1
		LD	V9, V2		; starting box type
		LD	V0, VC
		CALL	DRAWBOX
		CALL	GETBOXTYPE	; prevent change of starting box

		LD	VA, 2		; set starting progression
		CALL	DRAWRANDB

		LD	V7, 0		; zero current job score
		LD	V8, 0
		CALL	WRITESCORE
		CALL	WRITELEVEL
		LD	V0, #FF		; maximum delay of progression
		LD	DT, V0		;    for beginning of game

; *** MAIN PROCEDURE FOR PLAYING GAME  ***
GAMELOOP:
		LD	V0, K_LEFT
		skip.ne	v0, key
		CALL	MOVELEFT	; move left if K_LEFT key pressed
		LD	V0, K_RIGHT
		skip.ne	v0, key
		CALL	MOVERIGHT	; move right
		LD	V0, K_UP
		skip.ne v0, key
		CALL	MOVEUP		; move up
		LD	V0, K_DOWN
		skip.ne v0, key
		CALL	MOVEDOWN	; move down
		LD	V0, K_PLACE
		skip.ne v0, key
		CALL	PLACEBOX	; place box
		LD	V0, K_UPLACE
		skip.ne v0, key
		CALL	UPLACEBOX	; place box and use block shown for new
		LD	V0, K_FAST
		skip.ne v0, key
		LD	VE, #02		; go fast
		LD	V0, DT
		SNE	V0, 0
		CALL	PROGRESS
		JP	GAMELOOP

; *****************************
; START OF SUBROUTINE CODE AREA
; *****************************

; Places next box on a grid site if allowed and updates preview boxes
; V1 - V5 modified
PLACEBOX:	LD	V0, #F		; don't favor corners
		CALL	GETRANDBLK	; get next box type (V2) and update preview
		LD	V0, VD		; get pos to draw box
		CALL	DRAWBOX		; draw box (V2) at desired box coord
		RET

; Places next box on a grid site if allowed and updates preview boxes
; V1 - V5 modified
UPLACEBOX:	CALL	NEWPREV		; get next box type (V2) and update preview
		LD	V0, VD		; get pos to draw box
		CALL	DRAWBOX		; draw box (V2) at desired box coord
		RET

; Takes paddle coord in VD and put x coord in V0, y coord in V1
; V0 := (out) paddle x coord
; V1 := (out) paddle y coord
; VD := bott coord
SPLITPOS:	LD	V0, VD
		LD	V1, #0F
		AND	V0, V1		; store x part in V0
		LD	V1, VD
		SUB	V1, V0		; store y part in V1
		RET

; The following 4 subroutines move the crosshair in the desired direction
; V0 := --- (m)
; V1 := --- (m)
; VD := paddle coord
MOVELEFT:	CALL	DRAWBPADL	;erase old paddle
		CALL	DRAWCRSHR
		CALL	SPLITPOS	; calculate new pos
		ADD	V0, #FF		;  "
		SNE	V0, #FF		;  "
		LD	V0, 0		;  "
		LD	VD, V1		; save new pos
		ADD	VD, V0
		CALL	DRAWBPADL	; draw new position
		CALL	DRAWCRSHR
		LD	V0, TYPERATE
		CALL	PAUSE
		RET

MOVERIGHT:	CALL	DRAWBPADL	;erase old paddle
		CALL	DRAWCRSHR
		CALL	SPLITPOS	; calculate new pos
		ADD	V0, #01		;  "
		SNE	V0, #0A		;  "
		LD	V0, 9		;  "
		LD	VD, V1		; save new pos
		ADD	VD, V0
		CALL	DRAWBPADL	; draw new position
		CALL	DRAWCRSHR
		LD	V0, TYPERATE
		CALL	PAUSE
;NORIGHT:    LD	   V0, K_RIGHT	  ; wait till key released
;	     SKNP  V0
;	     JP	   NORIGHT
		RET

MOVEUP:		CALL	DRAWSPADL	;erase old paddle
		CALL	DRAWCRSHR
		CALL	SPLITPOS	; calculate new pos
		ADD	V1, #F0		;  "
		SNE	V1, #F0		;  "
		LD	V1, 0		;  "
		LD	VD, V1		; save new pos
		ADD	VD, V0
		CALL	DRAWSPADL	; draw new position
		CALL	DRAWCRSHR
		LD	V0, TYPERATE
		CALL	PAUSE
		RET

MOVEDOWN:	CALL	DRAWSPADL	;erase old paddle
		CALL	DRAWCRSHR
		CALL	SPLITPOS	; calculate new pos
		ADD	V1, #10		;  "
		SNE	V1, #60		;  "
		LD	V1, #50		;  "
		LD	VD, V1		; save new pos
		ADD	VD, V0
		CALL	DRAWSPADL	; draw new position
		CALL	DRAWCRSHR
		LD	V0, TYPERATE
		CALL	PAUSE
		RET

; Draw bottom paddle
; V0 := --- (m)
; V1 := --- (m)
; VD := paddle coord
DRAWBPADL:	CALL	SPLITPOS	; get paddle position
		ADD	V0, #60
		CALL	BOXTOSCR
		LD	I, BOTTPADL	; draw it
		DRW	V0, V1, 4
		RET

; Draw side paddle
; V0 := --- (m)
; V1 := --- (m)
; VD := paddle coord
DRAWSPADL:	CALL	SPLITPOS
		LD	V0, V1
		ADD	V0, #0A
		CALL	BOXTOSCR
		LD	I, SIDEPADL
		DRW	V0, V1, 8
		RET

; Draw crosshair
; V0 := --- (m)
; V1 := --- (m)
; VD := paddle coord
DRAWCRSHR:	LD	V0, VD
		CALL	BOXTOSCR
		LD	I, CROSSHAIR
		DRW	V0, V1, 8
		RET

; All purpose pause subroutine
; V0 := (in) time to delay (m)
PAUSE:		ADD	V0, #FF
		SE	V0, 0
		JP	PAUSE
		RET

DRAWRANDB:	LD	I, RANDBLK
		ADD	I, VA
		LD	V0, [I]
		CALL	GETBITADDR
		LD	V0, 108
		LD	V1, 28
		DRW	V0, V1, 8
		RET

; Progress flow through current box
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m)
; V3 := --- (m)
; V9 := current box type
; VA := box progression so far
; VB := flow direction
; VC := current box pos

PROGRESS:	CALL	DRAWRANDB
		ADD	VA, 1

		LD	V0, V9		; Get box type
		LD	V1, #F0
		AND	V0, V1		; if box is a corner (type = #1X)
		SNE	V0, 0		;    then see if need to change direction
		JP	KEEPDIR
		SNE	VA, 4
		JP	CORNERPROG
		SNE	VA, 5
		JP	ENDPROG
KEEPDIR:	LD	V2, VA		; store progression in v2
		SE	VB, 0		; invert progression if moving up
		JP	NOINVERT	;     ^- you will see why below (y position)
		LD	V2, 8
		SUB	V2, VA
NOINVERT:	LD	V0, VB		; store flow direction in v0
		SHR	V0
		SHR	V0
		SE	V0, 0		; if flowing right left, skip to R_L_PROG
		JP	R_L_PROG
		SE	VB, 0		; if flowing down, subtract one from progression
		ADD	V2, #FF		;		      ^- graphical adjustment
		LD	V0, VC		; copy box coord to v0
		CALL	BOXTOSCR	; convert to screen coord, v0=x,v1=y
		ADD	V1, V2		; add progression to y coord for screen pos
		LD	I, VERTMOVE	; load address of vert moving flow
		DRW	V0, V1, 1	; draw vert moving flow
		SNE	VF, 0		; if collision took place
		JP	SKIPIT		;     check to make sure it
		SE	VA, 1		;    was only with crosshair
		JP	SKIPIT		;    so end of vertical flow
		LD	V9, #00		; else end the game
		JP	ENDGAME

CORNERPROG:	XOR	VB, V9		; CHECK THIS OUT! Those value assignments
		LD	V0, #07		;    for box and direction aren't arbitrary
		AND	VB, V0
		LD	V0, VC
		CALL	BOXTOSCR	; get box coord
		SE	V9, B_SE
		JP	FCASE2		; find proper bitmap to draw
		LD	I, SEFLOW	;   according to type of corner
		ADD	V1, 4
FCASE2:		SE	V9, B_NE
		JP	FCASE3
		LD	I, NEFLOW
		ADD	V1, 2
FCASE3:		SE	V9, B_SW
		JP	FCASE4
		LD	I, SWFLOW
		ADD	V1, 4
FCASE4:		SE	V9, B_NW
		JP	FENDCASE
		LD	I, NWFLOW
		ADD	V1, 2
FENDCASE:	DRW	V0, V1, 2	; draw bitmap
		JP	ENDPROG		; end of corner flow

R_L_PROG:	SE	VB, 5		; skip to right program if moving right
		JP	RIGHTPRG
		LD	V3, #80		; start with 10000000 bitmap graphic
LEFTPRG:	SNE	V2, 8		; iterate over progressions left
		JP	R_L_DRAW
		SHR	V3		; build proper sprite by shifting 1 digit right
		ADD	V2, 1		;    for each progression not obtained
		JP	LEFTPRG		; end of left flow
RIGHTPRG:	LD	V3, #01		; start with 00000001
RIGHTPRG2:	SNE	V2, 8		; iterate over progressions left
		JP	R_L_DRAW
		SHL	V3		; build proper sprite
		ADD	V2, 1
		JP	RIGHTPRG2	; end of right flow
R_L_DRAW:	LD	V1, V3
		LD	V0, V3
		LD	I, TEMP
		LD	[I], V1		; store built sprite doubled in memory
		LD	I, TEMP
		LD	V0, VC
		CALL	BOXTOSCR	; get position of box to progress flow
		ADD	V1, 3
		SE	V9, B_CROS	; "tunnel under" if a crossbar and on 4,5 progr
		JP	DRAWIT		;    else draw the progression
		SNE	VA, 4
		JP	NODRAW
		SE	VA, 5
DRAWIT:		DRW	V0, V1, 2	; write sprite to screen
NODRAW:		SNE	VF, 0		; if collision took place
		JP	SKIPIT		;     check to make sure it
		SE	VA, 1		;     was only with crosshair
		JP	SKIPIT		;     so end of horizontal flow
		LD	V9, #00		; else end the game
		JP	ENDGAME		;
SKIPIT:		SE	VA, 8		; if at end of progression through box
		JP	ENDPROG
		CALL	WRITESCORE
		LD	V0, 0
SCOREIT:	ADD	V7, 1		; earn 3 points for each box passed
		SE	V7, 100
		JP	SCOREIT2
		ADD	V8, 1
		LD	V7, 0
SCOREIT2:	ADD	V0, 1
		SE	V0, 3
		JP	SCOREIT
		CALL	WRITESCORE
		LD	VA, 0
		CALL	GETNEXTBOX	; get next box pos and type
ENDPROG:	LD	V0, VE		; resest timer for next progress check
		LD	V1, V8
		ADD	V1, V7
		SNE	V1, 0
		ADD	V0, #B0		; increase timer if only starting
		LD	DT, V0
		CALL	DRAWRANDB
		RET

; Wait until space key is pressed
; V0 := --- (m)
WAIT:		LD	V0, #B
WAIT2:		skip.eq v0, key		; wait till press space
		JP	WAIT2
WAIT3:		skip.ne v0, key
		JP	WAIT3		; wait till space key released
		RET

; Determine if game ends, tally score, and reset for next screen
; Changes everything
ENDGAME:	LD	V0, #3
		LD	ST, V0		; BEEP
		CALL	WAIT
		CLS
		LD	V2, 0
		LD	V3, 0
CHECKBONUS:	LD	I, BOXINFO	; iterate through box grid array
		ADD	I, V2		;    adding together field
		LD	V1, [I]		;    that has a 1 if flowed through
		ADD	V2, 2
		ADD	V3, V1
		SE	V2, 120
		JP	CHECKBONUS	; if every box flowed through
		SNE	V3, 60		;    then give a bonus 100 points
		ADD	V8, 1

		LD	I, TSCORE	; get old stored total score
		LD	V1, [I]
		ADD	V0, V7		; add new score to total
		LD	V3, 100
		SUB	V0, V3
		LD	V4, VF
		SE	V4, 0		; if over 100
		ADD	V1, 1		;     increment hundreds digit
		SE	V4, 1		; else
		ADD	V0, 100		;     put back to normal
		ADD	V1, V8
		LD	I, TSCORE	; save new total
		LD	[I], V1

		LD	V5, V0		; store tens & ones digit
		LD	V3, 40		; x coord to display total
		LD	V4, 40		; y coord to display total
		LD	I, SCORE	; STORE BCD
		bcd	V1		;     of hundreds score to  memory
		LD	V2, [I]		; read BCD
		xhex	v0		; point to sprite of ten thousands digit
		DRW	V3, V4, 10
		ADD	V3, 11
		xhex	v1		; point to sprite of thousands digit
		DRW	V3, V4, 10
		ADD	V3, 11
		xhex	v2		; point to sprite of hundreds digit
		DRW	V3, V4, 10
		LD	I, SCORE	; STORE BCD
		bcd	V5		;     of tens & ones score to memory
		LD	V2, [I]		; read BCD
		ADD	V3, 11
		xhex	v1		; point to sprite of tens digit
		DRW	V3, V4, 10
		ADD	V3, 11
		xhex	v2		; point to sprite of ones digit
		DRW	V3, V4, 10

		CALL	WRITESCORE	; write score of last job in corner
		LD	I, LEVEL
		LD	V0, [I]
		LD	VE, V0		; get stored level in case FAST used
		SNE	VE, #02		; don't go beyond level 10
		ADD	VE, #04
		ADD	VE, #FC		; make level harder

		SE	V8, 0
		JP	GOODSCORE	; check if score good enough to continue
		SHR	V0		; need 100 - (41 - 2 * LEVEL) pts
		LD	V1, 100		;     in order to continue
		SUB	V1, V0		;     LVL 1 -> 61
		SUB	V7, V1		;     LVL 2 -> 63
		SNE	VF, 0		;     LVL 3 -> 65, and so on
		JP	GAMEOVER	; if not, gameover
GOODSCORE:	CALL	DROPWAIT	; show the dripping graphic and wait
		SE	V0, #0		; if pause game key (.) not pressed
		JP	START		; go to next job
		LD	V3, #1		; signal flag that game is to continue
		JP	PAUSEGAME

GAMEOVER:	LD	I, HDOVER	; print 'OVER' on screen
		LD	V0, 42
		LD	V1, 24
		DRW	V0, V1, 5
		ADD	V0, 8
		LD	V2, 5
		ADD	I, V2
		DRW	V0, V1, 5
		CALL	DROPWAIT	; show the dripping graphic and wait
		LD	V3, #0		; signal that game not to be resumed
PAUSEGAME:	LD	I, TSCORE	; get old stored total score
		LD	V1, [I]
		LD	V2, VE
		LD	R, V3		; store total score in user flags
		LD	V0, #B
NOSPCPRESS:	skip.ne v0, key
		JP	NOSPCPRESS
		LD	V0, #0
NOPERPRESS:	skip.ne v0, key
		JP	NOPERPRESS
		exit			; exit game

; Wait with drop graphic
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m)
; V3 := --- (m)
; V4 := --- (m)
DROPWAIT:	LD	I, HORZBOX	; draw faucet type pipe
		LD	V3, 2
		LD	V4, 8
		DRW	V3, V4, 8
		LD	I, SWBOX
		LD	V3, 10
		DRW	V3, V4, 8
		LD	I, DROP		; draw drop and animate
DROPIT:		LD	V3, 14
		LD	V4, 16
		DRW	V3, V4, 7
DRAWDROP:	LD	V0, #25
		CALL	PAUSE
		LD	V0, #B
		skip.ne v0, key
		JP	ENDDROP
		LD	V0, #0
		skip.ne v0, key
		JP	ENDDROP
		DRW	V3, V4, 7
		ADD	V4, 2
		SNE	V4, 56
		JP	DROPIT
		DRW	V3, V4, 7
		JP	DRAWDROP
ENDDROP:	RET

; Get screen coord from box coord
;   V0 := (in) box coord, (out) screen x
;   V1 :=		  (out) screen y
BOXTOSCR:	LD	V1, V0
		LD	VF, #F0
		AND	V1, VF
		SHR	V1		; get y part of box coord
		LD	VF, #0F
		AND	V0, VF		; get x part of box coord
		SHL	V0		; multipy box coords by 8
		SHL	V0
		SHL	V0
		ADD	V0, 16		; add proper offsets to get screen coord
		ADD	V1, 2
		RET

; Get box coord from screen coord
;   V0 := (in) screen x, (out) box coord
;   V1 := (in) screen y, (m)
SCRTOBOX:	ADD	V0, #F0		; substr proper offsets
		ADD	V1, #FE
		SHR	V0		; divide screen coords by 8
		SHR	V0
		SHR	V0
		SHL	V1
		ADD	V0, V1		; put together into one register
		RET

; Get grid array addr from box coord
;   V0 := (in) box coord  (m)
;   V1 :=		  (m)
;   I  := addr
BOXTOADDR:	LD	I, BOXINFO	; set address to beginning of box array
		LD	V1, V0
		LD	VF, #0F
		AND	V1, VF
		SHL	V1
		ADD	I, V1		; add x offset (2 * box x)
		LD	VF, #F0
		AND	V0, VF
		SHR	V0
		LD	V1, V0
		SHR	V1
		SHR	V1
		ADD	V0, V1
		SHL	V0
		ADD	I, V0		; add y offset (20 * box y)
		RET

; Draws a box on the grid if possible. if not, penalize
;   V0 := box coord (m)
;   V1 :=   ---	    (m)
;   V2 := box type  (m)
;   V3 :=   ---	    (m)
;   V4 :=   ---	    (m)
;   V5 :=   ---	    (m)
DRAWBOX:	LD	V3, V0		; push box coord
		CALL	BOXTOADDR	; set I to array address
		LD	V1, [I]		; read in current box
		LD	V5, 0
		SE	V0, #0B		; if box already placed there,
		LD	V5, #FF		;     then penalty
		SNE	V1, 00		; if box full
		JP	DRAWBOX2
		LD	V1, #3		;   then disallow
		LD	ST, V1		;   and beep
		JP	SKIPDRAW
DRAWBOX2:	CALL	GETBITADDR	; get mask addr for current box
		LD	V0, V3		; pop box coord
		CALL	BOXTOSCR	; convert to scr coord
		DRW	V0, V1, 8	; erase current box
		LD	V0, V3		; pop box coord
		CALL	BOXTOADDR	; set I to array address
		LD	V1, 0
		LD	V0, V2
		LD	[I], V1		; write box type to array
		LD	V0, V2
		CALL	GETBITADDR	; get mask addr for box
		LD	V0, V3		; pop box coord
		CALL	BOXTOSCR	; get screen coord
		DRW	V0, V1, 8	; draw desired box
SKIPDRAW:	CALL	WRITESCORE
		ADD	V7, V5		; substract penalty
		SE	V7, #FF		; if V7 was not 0
		JP	NOADJUST	;     no adjustment needed
		SNE	V8, 0		; else if V8 is 0
		JP	ZEROOUT		;	   set job score to 0
		ADD	V8, #FF		;      else substract 100
		LD	V7, 99		;	    and add 99
		JP	NOADJUST
ZEROOUT:	LD	V7, 0
NOADJUST:	CALL	WRITESCORE
		RET

; Gets bitmap address for box type
; V0 := box type
; V1 := --- (m)
GETBITADDR:	LD	V1, #0F
		AND	V0, V1		; get offset to mask for box
		SHL	V0
		SHL	V0
		SHL	V0
		LD	I, ZEROBOX	; set I to mask address
		ADD	I, V0		; add offset
		RET


; Get box type from storage array and mark it as unchangable
; V0 := (m)
; V1 := (m)
; V3 := (in) box pos
; VC := (in) box pos
; V9 := (out) box type
GETBOXTYPE:	LD	V0, VC		; get array addr from box pos
		CALL	BOXTOADDR
		LD	V1, [I]		; read boxtype
		SNE	V0, #0B
		JP	ENDGAME
		LD	V9, V0
		LD	V0, VC
		CALL	BOXTOADDR	; prevent change of box
		LD	V0, V9
		LD	V1, #01
		LD	[I], V1
		RET

; Get box coord for next box depending on direction from last
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m)
; VB := direction of flow
; VC := (in) curr box coord, (out) next box coord
GETNEXTBOX:	LD	V3, #00
		SNE	VB, F_RIGHT
		LD	V3, #01		; if right, add one to x
		SNE	VB, F_DOWN
		LD	V3, #10		; if down, add one to y
		SNE	VB, F_UP
		LD	V3, #F0		; if up, substract 1 from y
		SNE	VB, F_LEFT
		LD	V3, #FF		; if left, subtract 1 from x
		LD	V1, VC
		ADD	V1, V3		; adjust
		LD	VF, #F0
		AND	V1, VF
		SNE	V1, #F0		; if gone off top
		JP	ENDGAME
		SNE	V1, #60		; if gone off bottom
		JP	ENDGAME
		LD	V1, VC
		ADD	V1, V3
		LD	VF, #0F
		AND	V1, VF
		SNE	V1, #0F		; if gone off left
		JP	ENDGAME
		SNE	V1, #0A		; if gone off right
		JP	ENDGAME
		ADD	VC, V3
		CALL	GETBOXTYPE
		RET

; Get a new preview box and update list
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m) , (out) box type dropped
; V3 := --- (m)
; V4 := --- (m)
; V5 := --- (m)
NEWPREV:	LD	V1, VA
		JP	GOTIT
GETRANDBLK:	RND	V1, 7		; randomly determine new box
		SHR	V0
		SHR	V0
		SNE	V0, 0		; if favoring corners (V0 = 0,1,2,3)
		SHR	V1		;   divide offset by 2
GOTIT:		LD	I, RANDBLK
		ADD	I, V1
		LD	V0, [I]
		LD	V5, V0		; store new box type in V5
		LD	V4, 3		; top preview box coord
		LD	V3, 0
NEXTPREV:	LD	I, PBOXINFO	; shift old box graphics down
		ADD	I, V3
		LD	V0, [I]
		LD	V2, V0
		CALL	GETBITADDR	; erase old box graphic
		LD	V0, 4
		DRW	V0, V4, 8
		LD	I, PBOXINFO
		ADD	I, V3
		LD	V0, V5
		LD	[I], V0
		CALL	GETBITADDR	; draw new box graphic
		LD	V0, 4
		DRW	V0, V4, 8
		ADD	V4, 12
		LD	V5, V2
		ADD	V3, 1
		SE	V3, 5
		JP	NEXTPREV
		RET

; Write the score to screen
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m)
; V3 := --- (m)
; V4 := --- (m)
; V7 := (in) score
WRITESCORE:	LD	V3, 105		; x pos
		LD	V4, 9		; y pos
		LD	I, SCORE	; write BCD
		bcd	V8		;     of hundred score to memory
		LD	V2, [I]		; read BCD
		hex	V2		; point to sprite of hundreds digit
		DRW	V3, V4, 5
		ADD	V3, 6
		LD	I, SCORE	; write BCD
		bcd	V7		;     of tens and ones score to memory
		LD	V2, [I]		; read BCD
		hex	V1		; point to sprite of tens digit
		DRW	V3, V4, 5
		ADD	V3, 6
		hex	V2		; point to sprite of ones digit
		DRW	V3, V4, 5
		RET

; Write the level to screen
; V0 := --- (m)
; V1 := --- (m)
; V2 := --- (m)
; V3 := --- (m)
; V4 := --- (m)
; VE := (in) level
WRITELEVEL:	LD	V0, VE		; convert speed to game level
		ADD	V0, #FE
		SHR	V0
		SHR	V0
		LD	V1, 20
		SUB	V1, V0
		LD	I, SCORE	; write BCD
		bcd	V1		;     of level to memory
		LD	V2, [I]		; read BCD
		xhex	v1		; point to sprite of tens digit
		LD	V3, 104
		LD	V4, 50
		DRW	V3, V4, 10
		ADD	V3, 11
		xhex	v2		; point to sprite of ones digit
		DRW	V3, V4, 10
		RET

; ******************
; START OF DATA AREA
; ******************

RBORDER:	DW	#F8F8

PRV1BOX:	DW	#C0C0, #C0C0, #C0C0, #C0C0, #C0C0, #C0FF

PRV2BOX:	DW	#0303, #0303, #0303, #0303, #0303, #03FF

LEVEL:		DW	#0000

ZEROBOX:	DW	#0000, #0000, #0000, #0000 ;0  blank box

VERTBOX:	DW	#C3C3, #C3C3, #C3C3, #C3C3 ;1  vertical pipe

HORZBOX:	DW	#FFFF, #0000, #0000, #FFFF ;2  horizontal pipe

CROSBOX:	DW	#C3C3, #0000, #0000, #C3C3 ;3  crossing pipes

FULLBOX:	DW	#FFFF, #FFFF, #FFFF, #FFFF ;4  full box

SWBOX:		DW	#FFFF, #0F07, #0303, #83C3 ;5  south to west pipe

SEBOX:		DW	#FFFF, #F0E0, #C0C0, #C1C3 ;6  south to east pipe

ESTRBOX:	DW	#FFFF, #C0C0, #C0C0, #FFFF ;7  east open start pipe

WSTRBOX:	DW	#FFFF, #0303, #0303, #FFFF ;8  west open start pipe

NSTRBOX:	DW	#C3C3, #C3C3, #C3C3, #FFFF ;9  north open start pipe

SSTRBOX:	DW	#FFFF, #C3C3, #C3C3, #C3C3 ;A  south open start pipe

GRID:		DW	#007E, #4242, #4242, #7E00 ;11 (B) empty grid site

TEMP:		DW	#0000, #0000, #0000, #0000 ;12 (C) temp memory area

NEBOX:		DW	#C3C1, #C0C0, #E0F0, #FFFF ;13 (D) north to east pipe

NWBOX:		DW	#C383, #0303, #070F, #FFFF ;14 (E) north to west pipe

CROSSHAIR:	DW	#0000, #183C, #3C18, #0000 ;15 (F)

SIDEPADL:	DW	#0010, #1070, #7010, #1000

BOTTPADL:	DW	#0018, #187E

VERTMOVE:	DW	#1800		; bitmap of vertical flow

SEFLOW:		DW	#0804
NEFLOW:		DW	#0408
SWFLOW:		DW	#1020
NWFLOW:		DW	#2010

RANDBLK:	DW	#1D15, #161E, #0102, #0303 ; used for random block select

RANDDIR:	DW	#0607, #0508, #0009, #030A ; used for random direction

PBOXINFO:	DW	#0000, #0000, #0000 ; preview box info

SCORE:		DW	#0000, #0000	; total score storage
TSCORE:		DW	#0000, #0000	; temp score area

TITLE:		DW	#A3A2, #E3A2, #AABB, #9293, #123A
TITLE2:		DW	#BBA2, #B322, #3A88, #8888, #4048
HDSCORE:	DW	#D992, #D252, #D93B, #AAB3, #AA2B
HDLEVEL:	DW	#9A92, #9A91, #D9B4, #A4B4, #2436
HDOVER:		DW	#EAAA, #AEA4, #E4EE, #8ACE, #89E9
DROP:		DW	#2020, #70F8, #F8F8, #7000

BOXINFO:	DW	#0B00, #0B00, #0B00, #0B00, #0B00 ; 60x2 array for
X1:		DW	#0B00, #0B00, #0B00, #0B00, #0B00 ; storage of grid
X2:		DW	#0B00, #0B00, #0B00, #0B00, #0B00 ; placements and
X3:		DW	#0B00, #0B00, #0B00, #0B00, #0B00 ; flow control
X4:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X5:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X6:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X7:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X8:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X9:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X10:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
X11:		DW	#0B00, #0B00, #0B00, #0B00, #0B00
