;
; U-BOAT v1.0
; Copyright (C) 1994 Michael Kemper
;
                .title  "UBoat version 1.0",
			"Copyright (C) 1994 Michael Kemper"
                .xref   on
;
;  BASED ON AN OLD APPLE ][ GAME THAT I USED TO PLAY.
;  I BELIEVE IT WENT BY THE NAME 'DEPTH CHARGE' AND
;  I DON'T KNOW WHO WROTE IT
;
;  HP48 VERSION STARTED 7/13/94 MDK
;  8/8/94 RELEASED AS VERSION 1.0
; -----------------------------------------------------

;
; INITIAL GAME SPECS:
;    * SHIP MOVES INITIALLY AT A VELOCITY OF 1, USING THE 1, 2, & 3 KEYS
;         THE SHIP CAN BE SPED UP OR SLOWED DOWN
;    * THE '-' KEY DROPS CHARGES
;    * UP TO 4 CHARGES CAN BE IN THE WATER AT ANY ONE TIME
;    * UP TO 6 SUBS WILL BE VISIBLE AT ANY ONE TIME AT 3 VELOCITIES 0, 1, OR 2
;    * THE DEEPER THE SUB THE HIGHER THE POINT VALUES
;

; KEYS:
;         '1' - SET SHIP SPEED TO FULL STOP
;         '2' - SET SHIP SPEED TO AHEAD HALF
;         '3' - SET SHIP SPEED TO AHEAD FULL
;         '-' - DROP DEPTH CHARGE
;         '/' - EXIT GAME

; REGISTER USAGE
;
;  V0 - GENERAL PURPOSE
;  V1 - GENERAL PURPOSE
;  V2 - GENERAL PURPOSE
;  V3 - GENERAL PURPOSE
;  V4 - GENERAL PURPOSE
;  V5 - GENERAL PURPOSE
;  V6 - GENERAL PURPOSE
;  V7 - GENERAL PURPOSE
;  V8 - GAME TIMER (LOW ROLLOVER TIMER)
;  V9 - GAME OVER FLAG
;  VA - X POSITION OF SHIP
;  VB - SHIP SPEED
;  VC - INDEX/GENERAL PURPOSE
;  VD - INDEX/GENERAL PURPOSE
;  VE - KEY PRESSED FLAG
;  VF - RESERVED FOR CARRY/BORROW/COLLISION DETECT

                OPTION  SCHIP11

STOPKEY         =       #07             ; ALL STOP
MEDKEY          =       #08             ; ALL AHEAD HALF
FASTKEY         =       #09             ; ALL AHEAD FULL
DNKEY           =       #0E             ; DROP CHARGE
EXKEY           =       #0C             ; EXIT

MAXSUBS         =       #06
MAXCHRGS        =       #04
MAXDATA         =       #2E             ; NUMBER OF DATA BYTES TO BE ZEROED

                JP      START

		.byte	10
		.ascii	"U-Boat version 1.0"
		.byte	10
		.ascii	"Copyright (C) 1994 Michael Kemper"
		.byte	10
		.align
SCORESTR:
                DA      'SCORE'
                DB      #00

HIGHSTR:
                DA      'HIGH'
                DB      #00

GAMEOVER:
                DA      'GAME[OVER'
                DB      #00

AGAINTXT:
                DA      'PRESS[^[PLAY\[_[EXIT'
                DB      #00

INTRO1:
                DA      '[COPYRIGHT[^]]`'
                DB      #00

INTRO2:
                DA      'MICHAEL[KEMPER'
                DB      #00

PCTTXT:
                DA      'DROPS[[HITS[[[[[PCT'
                DB      #00

;ALIGN ON
                .align

START:
                HIGH                    ; SET DISPLAY TO HIGH RES MODE
                CALL    INTRO
                CALL    WIPESCREEN
WARMSTART:
                CALL    PLAYGAME

                LD      V1, #0B         ; X COORD
                LD      V2, #31         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
STARTLOOP1:
                LD      I, AGAINTXT
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      STARTLOOP1

STARTLOOP2:
                LD      V0, MEDKEY
                SKNP    V0
                JP      EXITGAME

                LD      V0, STOPKEY
                SKNP    V0
                JP      WARMSTART

                JP      STARTLOOP2
EXITGAME:
                LOW                     ; RETURN DISPLAY TO LOW RES MODE
                EXIT


; -----------------
; SUBROUTINE INTRO
; -----------------


INTRO:
                CLS
                LD      V1, #00         ; SHIP LOCATION, AND PATTERN INDEX
ILOOP1:
                LD      I, INTROPATTERN
                ADD     I, V1
                LD      V0, [I]
                LD      V3, V0          ; V3 = PATTERN

                LD      V4, #01
                LD      V5, #00
ILOOP2:
                LD      V0, V3
                AND     V0, V4
                SE      V0, #00
                CALL    DRAWDOT
                SHL     V4
                ADD     V5, #01
                SE      V5, #08
                JP      ILOOP2

                ADD     V1, #01
                SE      V1, #23
                JP      ILOOP1
; COPYRIGHT MCMXCIV
                LD      V1, #10         ; X COORD
                LD      V2, #20         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
ILOOP3:
                LD      I, INTRO1
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      ILOOP3

                LD      V1, #10         ; X COORD
                LD      V2, #29         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
ILOOP4:
                LD      I, INTRO2
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      ILOOP4

                CALL    DELAY3
                CALL    DELAY3
                CALL    DELAY3
                RET

DRAWDOT:
                LD      I, CHARG        ; I --> CHARGE SPRITE
                LD      V6, V1
                ADD     V6, V1
                ADD     V6, V1
                ADD     V6, #10
                LD      V7, V5
                ADD     V7, V5
                ADD     V7, V5
                DRW     V6, V7, #02
                RET


; --------------------
; SUBROUTINE PLAYGAME
; --------------------

PLAYGAME:
                CLS                     ; CLEAR DISPLAY
                LD      VA, #00         ; INITIAL SHIP X COORD
                LD      VB, #01         ; INITIAL SHIP SPEED = 1
                LD      VE, #00         ; CLEAR KEYPRESSED KEY

                LD      I, GAMETIMER
                LD      V0, #30
                LD      [I], V0         ; INITIAL GAME TIMER = 48*16
                LD      V8, #0F
                LD      V9, #00

                CALL    INITSTUFF
                CALL    INITSCRN
MAINLOOP:
                CALL    CHECKKEYS
                CALL    MOVESHIP
                CALL    DOSUBS
                CALL    MOVECHARGES
                CALL    DOGAMETIMER

                SE      V9, #00         ; IS GAME OVER FLAG SET?
                JP      MLEXIT          ; YES...LEAVE MAIN LOOP

                LD      V0, EXKEY       ; CHECK IF EXIT KEY PRESSED
                SKP     V0
                JP      MAINLOOP

MLEXIT:
                CALL    ENDGAME
                RET


; -----------------------
; SUBROUTINE ENDGAME
; -----------------------

ENDGAME:
                CALL    DRAWGAMEOVER
                CALL    DELAY3
                CALL    WIPESCREEN
                CALL    CHECKHIGH
                CALL    DRAWENDBOX
                RET

; (V1, V2) = (X,Y)
; SCRATCHPAD = NUMBER TO PRINT
DRAWSCRATCH:
                LD      V3, #00
SCRATLOOP:
                LD      I, SCRATCHPAD
                ADD     I, V3
                LD      V0, [I]
                hex	V0
                DRW     V1, V2, #05
                ADD     V1, #05
                ADD     V3, #01
                SE      V3, #03
                JP      SCRATLOOP
                RET


; -------------------
; SUBROUTINE CALCPCT
; -------------------

CALCPCT:
                LD      V0, #00
                LD      I, HITPCT
                LD      [I], V0         ; INITIALIZE HIT PCT TO 0
                LD      I, CHIT
                LD      V0, [I]
                SNE     V0, #00
                RET                     ; ABORT IF HITS = 0
                LD      I, CDROP
                LD      V0, [I]
                SNE     V0, #00
                RET                     ; ABORT IF DROPS = 0

                LD      I, CHIT
                LD      V1, [I]         ; V0, V1 = CHIT
                LD      V5, #00
                LD      V2, #00
                LD      V3, #00
MULTLOOP:
                LD      V4, #00         ; CLEAR CARRY STORAGE
                ADD     V2, V0          ; ADD LSBYTE
                SE      VF, #00
                LD      V4, #01         ; SAVE CARRY
                ADD     V3, V1          ; ADD MSBYTE
                ADD     V3, V4          ; ADD CARRY
                ADD     V5, #01
                SE      V5, #64         ; DO 100 TIMES
                JP      MULTLOOP

                LD      I, CDROP
                LD      V1, [I]         ; V0, V1 = CDROP...V2, V3 = CHIT * 100
                LD      V5, #00
DIVLOOP:
                LD      V4, #01
                SUB     V2, V0          ; SUB LSBYTE
                SE      VF, #00
                LD      V4, #00         ; SAVE BORROW
                SUB     V3, V1          ; SUB MSBYTE
                SNE     VF, #00
                JP      DIVDONE
                SUB     V3, V4          ; SUB BORROW
                SNE     VF, #00
                JP      DIVDONE
                ADD     V5, #01         ; ADD 1 TO DIV NUMBER
                JP      DIVLOOP
DIVDONE:
                LD      V0, V5
                LD      I, HITPCT
                LD      [I], V0
                RET


; ---------------------
; SUBROUTINE CHECKHIGH
; ---------------------
CHECKHIGH:
                LD      V2, #00
CHLOOP:
                LD      I, SCORE
                ADD     I, V2
                LD      V0, [I]
                LD      V1, V0          ; V1 = SCORE DIGIT

                LD      I, HSCOR
                ADD     I, V2
                LD      V0, [I]         ; V0 = HIGH DIGIT

                SUB     V0, V1          ; V0 = HIGH DIGIT - SCORE DIGIT
                SNE     VF, #00         ; WAS SCORE > HIGH
                JP      NEWHIGH         ; YES...NEW HIGH SCORE

                SE      V0, #00
                RET

                ADD     V2, #01
                SE      V2, #05
                JP      CHLOOP
                RET

NEWHIGH:
                LD      I, SCORE
                LD      V4, [I]         ; LOAD V0-V4 WITH SCORE
                LD      I, HSCOR
                LD      [I], V4         ; SAVE IN HIGH SCORE
                RET

DRAWENDBOX:
                LD      V1, #01         ; X COORD
                LD      V2, #01         ; Y COORD
                LD      V3, #1B         ; WIDTH
                LD      V4, #0D         ; HEIGHT
                CALL    DRAWBORDER

                LD      V1, #20         ; X COORD
                LD      V2, #0C         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
EGLOOP1:
                LD      I, SCORESTR
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      EGLOOP1

                LD      V1, #44
                LD      V2, #0D
                CALL    DRAWSCORE

                LD      V1, #25         ; X COORD
                LD      V2, #14         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
EGLOOP2:
                LD      I, HIGHSTR
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      EGLOOP2

                LD      V1, #44
                LD      V2, #15
                CALL    DRAWHIGH

; DRAW STATS
                LD      V1, #0B         ; X COORD
                LD      V2, #20         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
EGLOOP3:
                LD      I, PCTTXT
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      EGLOOP3

                LD      I, CDROP
                LD      V0, [I]         ; GET NUMBER OF CHARGES DROPPED
                LD      I, SCRATCHPAD
                LD      B, V0           ; UNPACK IT INTO SCRATCHPAD
                LD      V1, #10         ; V1 = X
                LD      V2, #29         ; V2 = Y
                CALL    DRAWSCRATCH     ; DISPLAY # CHARGES DROPPED

                LD      I, CHIT
                LD      V0, [I]         ; GET NUMBER OF SUBS HIT
                LD      I, SCRATCHPAD
                LD      B, V0           ; UNPACK IT INTO SCRATCHPAD
                LD      V1, #32         ; V1 = X
                LD      V2, #29         ; V2 = Y
                CALL    DRAWSCRATCH     ; DISPLAY # SUBS HIT

                CALL    CALCPCT
                LD      I, HITPCT
                LD      V0, [I]
                LD      I, SCRATCHPAD
                LD      B, V0
                LD      V1, #60
                LD      V2, #29
                CALL    DRAWSCRATCH
                RET


; -----------------------------------------------------
; SUBROUTINE DRAWLOOP
;
;    INPUT: V1 = X, V2 = Y, V3 = INDEX, V5 = DONE FLAG,
;           I POINTS TO TEXT CHAR
;   OUTPUT: V5
; CORRUPTS: V0, V4, VF, I
; -----------------------------------------------------

DRAWLOOP:
                ADD     I, V3
                LD      V0, [I]
                SNE     V0, #00
                JP      DLDONE
                LD      V4, #41
                SUB     V0, V4          ; ADJUST INDEX ... A = 0, B = 1, ETC.
                SHL     V0
                SHL     V0
                SHL     V0              ; MULTIPLY BY 8
                LD      I, ALPHABET
                ADD     I, V0           ; I POINTS TO ALPHA SPRITE
                DRW     V1, V2, #07     ; DRAW CHARACTER
                ADD     V1, #05         ; ADJUST X COORD FOR NEXT CHAR
                ADD     V3, #01         ; INC INDEX
                RET
DLDONE:
                LD      V5, #FF
                RET


; ------------------------
; SUBROUTINE DRAWGAMEOVER
; ------------------------

DRAWGAMEOVER:
                LD      V1, #26         ; X COORD
                LD      V2, #00         ; Y COORD
                LD      V3, #00         ; INDEX
                LD      V5, #00         ; DONE FLAG
DGOLOOP1:
                LD      I, GAMEOVER
                CALL    DELAY2
                CALL    DRAWLOOP
                SNE     V5, #00
                JP      DGOLOOP1
                RET


; ----------------------------------------------------
; SUBROUTINE: DRAWBORDER
;
;    INPUT: V1 = X, V2 = Y, V3 = WIDTH, V4 = HEIGHT
;   OUTPUT:
; CORRUPTS: V0, V1, V2, V3, V4, V5, V6, VC, VD, VF, I
; ----------------------------------------------------

DRAWBORDER:                             ; V1 = X, V2 = Y
                LD      V5, V1
                ADD     V5, V3          ; V5 = X + WIDTH
                LD      V6, V2
                ADD     V6, V4          ; V6 = Y + HEIGHT

                LD      I, BORD1
                LD      VC, V1
                LD      VD, V2
                CALL    DRAWPEICE       ; DRAW UPPER LEFT CORNER

                LD      I, BORD2
                LD      VC, V5
                LD      VD, V2
                CALL    DRAWPEICE       ; DRAW UPPER RIGHT CORNER

                LD      I, BORD3
                LD      VC, V1
                LD      VD, V6
                CALL    DRAWPEICE       ; DRAW LOWER LEFT CORNER

                LD      I, BORD1
                LD      VC, V5
                LD      VD, V6
                CALL    DRAWPEICE       ; DRAW LOWER RIGHT CORNER

                LD      V7, #01
                SUB     V4, V7
DBLOOP1:
                LD      I, BORD3
                LD      VC, V1
                LD      VD, V4
                ADD     VD, V2
                CALL    DRAWPEICE       ; DRAW LEFT EDGE

                LD      I, BORD2
                LD      VC, V5
                LD      VD, V4
                ADD     VD, V2
                CALL    DRAWPEICE       ; DRAW RIGHT EDGE

                SUB     V4, V7
                SE      V4, #00
                JP      DBLOOP1

                SUB     V3, V7
DBLOOP2:
                LD      I, BORD2
                LD      VC, V3
                ADD     VC, V1
                LD      VD, V2
                CALL    DRAWPEICE       ; DRAW TOP EDGE

                LD      I, BORD3
                LD      VC, V3
                ADD     VC, V1
                LD      VD, V6          ; DRAW BOTTOM EDGE
                CALL    DRAWPEICE

                SUB     V3, V7
                SE      V3, #00
                JP      DBLOOP2

                RET

DRAWPEICE:
                SHL     VC
                SHL     VC
                SHL     VD
                SHL     VD
                DRW     VC, VD, #04
                RET


; ------------------------------
; SUBROUTINE: WIPESCREEN
;
;    INPUT:
;   OUTPUT:
; CORRUPTS: V0, V3, VF
; ------------------------------

WIPESCREEN:
                LD      V3, #00
WSLOOP:
                ADD     V3, #01
                SCD     #01
                CALL    DELAY0
                SE      V3, #40
                JP      WSLOOP


; ------------------------------
; SUBROUTINE: DOGAMETIMER
;
;    INPUT: V8
;   OUTPUT: V8, V9
; CORRUPTS: V0, V1, I, VF
; ------------------------------

DOGAMETIMER:
                LD      V1, #01
                SUB     V8, V1          ; DEC LOW GAME TIMER
                SE      V8, #00
                RET                     ; IF NON-ZERO RETURN

                LD      V8, #0F         ; RESET LOW GAME TIMER
                LD      I, GAMETIMER
                LD      V0, [I]
                SUB     V0, V1          ; DEC HIGH GAME TIMER
                LD      [I], V0
                SNE     V0, #00
                LD      V9, #FF         ; SET FLAG INDICATING GAME OVER
                SNE     V0, #0C
                CALL    WARNBUZZER
                RET

WARNBUZZER:
                LD      V0, #10
                LD      ST, V0

                LD      V0, #1A
                LD      V1, #00
                LD      I, HOURGLASS
                DRW     V0, V1, #05
                RET


; -----------------------------
; SUBROUTINE: DOSUBS
;
;    INPUT:
;   OUTPUT:
; CORRUPTS: NEARLY EVERYTHING
; -----------------------------

DOSUBS:
                LD      VC, #00         ; INIT INDEX
DSLOOP:
                LD      I, SUBF
                ADD     I, VC
                LD      V0, [I]         ; V0 = SUB ACTIVE FLAG
                SNE     V0, #00         ; IF SUB NOT ACTIVE THEN SPAWN HIM
                CALL    SPAWNSUB

; MOVE SUB
                LD      V2, VC
                CALL    DRAWSUB         ; ERASE SUB
                                        ; MOVE SUB
                LD      I, SUBX
                ADD     I, VC
                LD      V0, [I]
                LD      V1, V0          ; V1 = SUB X COORD

                LD      I, SUBSP
                ADD     I, VC
                LD      V0, [I]         ; V0 = SUB SPEED
                SUBN    V0, V1
                SNE     V0, #01         ; WRAP AROUND IF SUB HITS LEFT BORDER
                LD      V0, #7A         ;
                SNE     V0, #00         ;
                LD      V0, #7A         ;
                LD      I, SUBX
                ADD     I, VC
                LD      [I], V0

                LD      V2, VC
                CALL    DRAWSUB         ; REDRAW SUB

                ADD     VC, #01
                SE      VC, MAXSUBS
                JP      DSLOOP          ; LOOP FOR ALL SUBS
                RET

SPAWNSUB:
                RND     V0, #2F
                LD      V1, #0D
                ADD     V0, V1          ; V0 = RAND NUM 13-60 FOR Y COORD
                LD      I, SUBY
                ADD     I, VC
                LD      [I], V0         ; STORE RAND DEPTH IN Y COORD

                LD      I, SUBX
                ADD     I, VC
                RND     V0, #7A
                LD      [I], V0         ; STORE RAND(123) IN X COORD

                LD      I, SUBF
                ADD     I, VC
                LD      V0, #FF
                LD      [I], V0         ; SET SUB ACTIVE FLAG

                LD      I, SUBSP
                ADD     I, VC
                RND     V0, #03
                SNE     V0, #03
                LD      V0, #01
                LD      [I], V0         ; SET SPEED = 0, 1 OR 2

                LD      V2, VC
                CALL    DRAWSUB
                RET


; ----------------------------------------------
; SUBROUTINE DRAWSUB
;
;    INPUT: V2 = SUB # TO DRAW (0, 1, 2, OR 3)
;   OUTPUT: VF = COLLISION
; CORRUPTS: I, V0, V1, VF
; ----------------------------------------------

DRAWSUB:
                LD      I, SUBX
                ADD     I, V2
                LD      V0, [I]
                LD      V1, V0          ; V1 = X COORD OF SUB V2
                LD      I, SUBY
                ADD     I, V2
                LD      V0, [I]         ; V0 = Y COORD OF SUB V2
                LD      I, SUBPX
                DRW     V1, V0, #04     ; DRAW SUB V2 AT (V0, V1)
                RET


; ---------------------
; SUBROUTINE MOVESHIP
;
;    INPUT:
;   OUTPUT:
; CORRUPTS: V0, VB, I
; ---------------------

MOVESHIP:
                LD      V0, #06
                LD      I, SHIP
                DRW     VA, V0, #04     ; ERASE OLD SHIP
                ADD     VA, VB          ; MOVE SHIP
                SNE     VA, #7E         ; WRAP AROUND IF SHIPX = 126 OR 127
                LD      VA, #00         ;
                SNE     VA, #7F         ;
                LD      VA, #00         ;
                DRW     VA, V0, #04     ; DRAW NEW SHIP
                RET


; ---------------------
; SUBROUTINE INITSTUFF
; ---------------------

INITSTUFF:
                LD      V1, #00
                LD      V0, #00
ISLOOP:
                LD      I, SCORE
                ADD     I, V1
                LD      [I], V0
                ADD     V1, #01
                SE      V1, MAXDATA
                JP      ISLOOP
                RET


; ----------------------
; SUBROUTINE INITSCREEN
; ----------------------

INITSCRN:
                CALL    DRAWSHIP
                LD      V1, #00
                LD      V2, #00
                CALL    DRAWSCORE
                LD      V1, #68
                LD      V2, #00
                CALL    DRAWHIGH
                LD      I, HLINE        ; DRAW HORIZ LINE ACROSS TOP OF SCREEN
                LD      V1, #0A
                LD      V0, #00
ILOOP:
                DRW     V0, V1, #02
                ADD     V0, #08
                SE      V0, #80
                JP      ILOOP
                RET

DRAWSHIP:
                LD      V0, #06
                LD      I, SHIP
                DRW     VA, V0, #04
                RET

CHECKKEYS:
                LD      V0, DNKEY       ; IMPLEMENT ONE SHOT FOR DOWN KEY
                SKP     V0
                LD      VE, #00         ; IF KEY IS UP RESET FOR THE NEXT PRESS

                SNE     VE, #00
                CALL    CHKDROP

                LD      V0, STOPKEY     ; CHECK STOP KEY PRESSED
                SKNP    V0
                LD      VB, #00         ; IF SO...SET SPEED = 0

                LD      V0, MEDKEY      ; CHECK MED KEY PRESSED
                SKNP    V0
                LD      VB, #01         ; IF SO...SET SPEED = 1

                LD      V0, FASTKEY     ; CHECK FAST KEY PRESSED
                SKNP    V0
                LD      VB, #02         ; IF SO...SET SPEED = 2

                RET

CHKDROP:
                LD      V0, DNKEY       ; DROP CHARGE IF DOWN KEY PRESSED
                SKNP    V0
                JP      DROPCHARGE
                RET


DROPCHARGE:
                LD      VE, #FF         ; SET FLAG INDICATING DROP KEY PRESSED
                LD      V3, #00         ; INIT INDEX
DCLOOP1:
                LD      I, CHRGF
                ADD     I, V3
                LD      V0, [I]
                SE      V0, #00         ; IS ACTIVE FLAG SET?
                JP      TRYNEXT         ; YES...TRY NEXT SLOT

                LD      V0, #FF
                LD      [I], V0         ; SET FLAG TO INDICATE ACTIVE
                LD      I, CHRGX
                ADD     I, V3
                LD      V0, VA
                LD      [I], V0         ; SET X POS AT SHIP'S X POS
                LD      I, CHRGY
                ADD     I, V3
                LD      V0, #0B
                LD      [I], V0         ; SET Y POS TO JUST BELOW WATER LINE

                LD      I, CDROP
                LD      V0, [I]
                ADD     V0, #01
                LD      [I], V0         ; ADD 1 TO THE NUMBER OF CHARGES DROPPED

                LD      V2, V3
                CALL    DRAWCHARGE      ; DRAW CHARGE AT INITIAL POSITION

                JP      DCEXIT          ; EXIT SINCE WE FOUND A FREE SLOT

TRYNEXT:
                ADD     V3, #01
                SE      V3, MAXCHRGS    ; LOOP FOR ALL POSSIBLE SLOTS
                JP      DCLOOP1

DCEXIT:
                RET


; -----------------------------
; SUBROUTINE MOVECHARGES
; INPUT:
; OUTPUT:
; CORRUPTS: V0-V7, VC, VF, I
; -----------------------------

MOVECHARGES:
                LD      VC, #00
MCLOOP:
                LD      I, CHRGF
                ADD     I, VC
                LD      V0, [I]         ; V0 = CHARGE ACTIVE FLAG
                SE      V0, #00
                CALL    MOVEIT          ; IF ACTIVE MOVE IT, VC=INDEX

                ADD     VC,#01          ; INC INDEX
                SE      VC, MAXCHRGS    ; LOOP FOR ALL POSSIBLE CHARGES
                JP      MCLOOP
                RET

; VC = CHARGE OFFSET
MOVEIT:
                LD      V2, VC
                CALL    DRAWCHARGE      ; ERASE OLD DEPTH CHARGE
                LD      I, CHRGY
                ADD     I, VC
                LD      V0, [I]         ; V0 = Y COORD
                ADD     V0, #01         ; MOVE CHARGE DOWN 1 PIXEL
                LD      [I], V0         ; STORE NEW Y COORD
                SE      V0, #3E         ; DID CHARGE HIT BOTTOM?
                JP      MOVEJUMP1       ; NO...GO AHEAD AND REDRAW IT

                LD      V0, #00         ; YES...
                LD      I, CHRGF
                ADD     I, VC
                LD      [I], V0         ;    CLEAR ACTIVE FLAG
                RET

MOVEJUMP1:
                LD      V2, VC
                CALL    DRAWCHARGE      ; DRAW CHARGE IN NEW POSITION
                SNE     VF, #00         ; DID CHARGE SPRITE HIT SOMETHING?
                RET                     ; NO...RETURN
                                        ; YES...FIGURE WHICH SUB WAS HIT
                CALL    DRAWCHARGE      ; ERASE CHARGE
                LD      V0, #00
                LD      I, CHRGF
                ADD     I, VC
                LD      [I], V0         ; CLEAR CHARGE ACTIVE FLAG

                CALL    KILLSUB

                LD      V5, VD
                CALL    ADDSCORE
                RET


; -----------------------------------------------------
; SUBROUTINE: KILLSUB - DETERMINE WHICH SUB WAS HIT
;    INPUT: VC = CHARGE # THAT HIT SUB
;   OUTPUT: VD = POINTS TO ADD TO SCORE
; CORRUPTS: V0, V2, V5, V6, V7, VF, I
; -----------------------------------------------------

KILLSUB:
                LD      V7, #00         ; USE V7 FOR SUB INDEX
KSLOOP1:
                LD      V2, V7          ; V2 = SUB # TO ERASE
                LD      I, SUBF
                ADD     I, V7
                LD      V0, [I]         ; V0 = SUB ACTIVE FLAG
                SE      V0, #00         ; IS SUB ACTIVE?
                CALL    DRAWSUB         ; YES...ERASE SUB
                ADD     V7, #01
                SE      V7, MAXSUBS
                JP      KSLOOP1         ; LOOP FOR ALL SUBS

                LD      V7, #00
KSLOOP2:
                LD      I, SUBF
                ADD     I, V7
                LD      V0, [I]         ; V0 = SUB ACTIVE FLAG
                SE      V0, #00         ; IS SUB ACTIVE?
                CALL    CHECKSUB        ; YES...CHECK TO SEE IF THAT WAS THE SUB HIT
                ADD     V7, #01
                SE      V7, MAXSUBS
                JP      KSLOOP2
                RET

CHECKSUB:
                LD      V2, V7
                CALL    DRAWSUB         ; DRAW THE SUB THAT MIGHT HAVE BEEN HIT
                LD      V2, VC
                CALL    DRAWCHARGE      ; DRAW THE CHARGE THAT HIT IT
                SE      VF, #00         ; COLLISION FLAG SET?
                JP      FOUNDIT         ; YES...THAT'S OUR SUB
                LD      V2, VC
                CALL    DRAWCHARGE      ; ERASE CHARGE
                RET


FOUNDIT:
                LD      I, CHIT
                LD      V0, [I]
                ADD     V0, #01         ; ADD 1 TO THE NUMBER OF SUBS HIT
                LD      [I], V0

                LD      I, SUBY
                ADD     I, V7
                LD      V0, [I]
                LD      VD, V0
                LD      I, SUBSP
                ADD     I, V7
                LD      V0, [I]
                SNE     V0, #01
                CALL    TIMES2
                SNE     V0, #02
                CALL    TIMES3

                LD      V2, V7
                CALL    DRAWSUB         ; ERASE HIT SUB
                LD      V2, VC
                CALL    DRAWCHARGE      ; ERASE CHARGE
                CALL    SUBEXPLODE      ; DRAW EXPLOSION

                LD      I, SUBF
                ADD     I, V7
                LD      V0, #00
                LD      [I], V0         ; FLAG SUB AS INACTIVE
                RET

; V7 = SUB TO BLOW UP
SUBEXPLODE:
                LD      I, SUBX
                ADD     I, V7
                LD      V0, [I]
                LD      V5, V0          ; V5 = X POSITION
                LD      V0, #04
                SUB     V5, V0          ; ADJUST FOR 16x16 SPRITE

                LD      I, SUBY
                ADD     I, V7
                LD      V0, [I]
                LD      V6, V0          ; V6 = Y POSITION
                LD      V0, #05
                SUB     V6, V0          ; ADJUST FOR 16x16 SPRITE

                LD      V0, #02
                LD      ST, V0
                LD      I, EXP1
                DRW     V5, V6
                CALL    DELAY1

                LD      V0, #01
                LD      ST, V0
                LD      I, EXP2
                DRW     V5, V6
                CALL    DELAY1

                LD      V0, #02
                LD      ST, V0
                LD      I, EXP3
                DRW     V5, V6
                CALL    DELAY1
                RET

TIMES2:
                LD      V0, VD
                ADD     VD, V0
                RET

TIMES3:
                LD      V0, VD
                ADD     VD, V0
                ADD     VD, V0
                RET


; -------------------------------------------------
; SUBROUTINE DRAWCHARGE
;
;    INPUT: V2 = CHARGE # TO DRAW
;   OUTPUT: VF = COLLISION
; CORRUPTS: I, V0, V1, VF
; -------------------------------------------------

DRAWCHARGE:
                LD      I, CHRGX
                ADD     I, V2
                LD      V0, [I]
                LD      V1, V0          ; V1 = X
                LD      I, CHRGY
                ADD     I, V2
                LD      V0, [I]         ; V0 = Y
                LD      I, CHARG        ; I --> SPRITE
                DRW     V1, V0, #02
                RET


; ---------------------------------------------
; SUBROUTINE ADDSCORE
;
;    INPUT: V5 = POINTS TO ADD
;   OUTPUT:
; CORRUPTS: V0, V1, V2, V3, V4, V5, VF, I
; ---------------------------------------------

ADDSCORE:
                LD      V1, #00
                LD      V2, #00
                CALL    DRAWSCORE       ; ERASE OLD SCORE
                LD      I, SCORE
                LD      V4, [I]         ; GET SCORE, V0 = MSDIGIT, V4 = LSDIGIT
                LD      VD, #01
ASLOOP:
                CALL    INC1            ; INC SCORE BY 1 POINT
                SUB     V5, VD          ; DEC POINTS TO ADD BY 1
                SE      V5, #00
                JP      ASLOOP          ; LOOP UNTIL ALL POINTS HAVE BEEN ADDED

                LD      I, SCORE
                LD      [I], V4         ; STORE SCORE
                LD      V1, #00
                LD      V2, #00
                CALL    DRAWSCORE       ; DISPLAY NEW SCORE
                RET

INC1:
                ADD     V4, #01
                SE      V4, #0A
                RET
                LD      V4, #00
; INC10:
                ADD     V3, #01
                SE      V3, #0A
                RET
                LD      V3, #00
; INC100:
                ADD     V2, #01
                SE      V2, #0A
                RET
                LD      V2, #00
; INC1000:
                ADD     V1, #01
                SE      V1, #0A
                RET
                LD      V1, #00
; INC10000:
                ADD     V0, #01
                SE      V0, #0A
                RET
                LD      V0, #00
                RET


; --------------------------------------------
; SUBROUTINE DRAWSCORE
;
;    INPUT: (V1, V2) = SCORE (X, Y) POSITION
;   OUTPUT:
; CORRUPTS: V0, V1, V2, V3, VF, I
; --------------------------------------------

DRAWSCORE:
                LD      V3, #00
SCORELOOP:
                LD      I, SCORE
                ADD     I, V3
                LD      V0, [I]
                hex	V0
                DRW     V1, V2, #05
                LD      V0, #04
                ADD     I, V0
                ADD     V1, #05
                ADD     V3, #01
                SE      V3, #5
                JP      SCORELOOP
                RET


; --------------------------------------------
; SUBROUTINE DRAWHIGH
;
;    INPUT: (V1, V2) = HIGH (X, Y) POSITION
;   OUTPUT:
; CORRUPTS: V0, V1, V2, V3, VF, I
; --------------------------------------------

DRAWHIGH:
                LD      V3, #00
HIGHLOOP:
                LD      I, HSCOR
                ADD     I, V3
                LD      V0, [I]
                hex	V0
                DRW     V1, V2, #05
                LD      V0, #04
                ADD     I, V0
                ADD     V1, #05
                ADD     V3, #01
                SE      V3, #5
                JP      HIGHLOOP
                RET


; -------------------------
; SUBROUTINE DELAY
;
;    INPUT:
;   OUTPUT:
; CORRUPTS:   V0, VF
; -------------------------

DELAY0:
                LD      V0, #02
                LD      DT, V0
DL:             LD      V0, DT
                SE      V0, #00
                JP      DL
                RET

DELAY1:
                LD      V0, #04
                LD      DT, V0
DL1:            LD      V0, DT
                SE      V0, #00
                JP      DL1
                RET

DELAY2:
                LD      V0, #08
                LD      DT, V0
DL2:            LD      V0, DT
                SE      V0, #00
                JP      DL2
                RET

DELAY3:
                LD      V0, #40
                LD      DT, V0
DL3:            LD      V0, DT
                SE      V0, #00
                JP      DL3
                RET


; ----------------
;  DEFINE SPRITES
; ----------------

SHIP:           DW      #041C           ; SPRITE FOR SHIP
                DW      #FFFE

SUBPX:          DW      #0030           ; SPRITE FOR SUB
                DW      #FDFE

HLINE:          DW      #FF00           ; HORIZONTAL LINE

CHARG:          DW      #C0C0           ; SPRITE FOR CHARGE

HOURGLASS:                              ; SPRITE FOR HOURGLASS
                DW      #3F12
                DW      #0C1E
                DW      #3F00

EXP1:           DW      #0000           ; SUB EXPLOSION (FRAME 1)
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0180
                DW      #0180
                DW      #0FF0
                DW      #0FF0
                DW      #0180
                DW      #0180
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0000

EXP2:           DW      #0000           ; SUB EXPLOSION (FRAME 2)
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0240
                DW      #03C0
                DW      #1FF8
                DW      #0FF0
                DW      #0FF0
                DW      #1FF8
                DW      #03C0
                DW      #0240
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0000

EXP3:           DW      #0000           ; SUB EXPLOSION (FRAME 3)
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0240
                DW      #0240
                DW      #1E78
                DW      #0000
                DW      #0000
                DW      #1E78
                DW      #0240
                DW      #0240
                DW      #0000
                DW      #0000
                DW      #0000
                DW      #0000

ALPHABET:
                DW      #0609           ; A
                DW      #090F
                DW      #0909
                DW      #0900

                DW      #0E09           ; B
                DW      #090E
                DW      #0909
                DW      #0E00

                DW      #0609           ; C
                DW      #0808
                DW      #0809
                DW      #0600

                DW      #0E09           ; D
                DW      #0909
                DW      #0909
                DW      #0E00

                DW      #0F08           ; E
                DW      #080E
                DW      #0808
                DW      #0F00

                DW      #0F08           ; F
                DW      #080E
                DW      #0808
                DW      #0800

                DW      #0609           ; G
                DW      #080B
                DW      #0909
                DW      #0700

                DW      #0909           ; H
                DW      #090F
                DW      #0909
                DW      #0900

                DW      #0702           ; I
                DW      #0202
                DW      #0202
                DW      #0700

                DW      #0701           ; J
                DW      #0101
                DW      #0109
                DW      #0600

                DW      #0909           ; K
                DW      #0A0C
                DW      #0A09
                DW      #0900

                DW      #0808           ; L
                DW      #0808
                DW      #0808
                DW      #0F00

                DW      #090F           ; M
                DW      #0F09
                DW      #0909
                DW      #0900

                DW      #090D           ; N
                DW      #0D0B
                DW      #0B09
                DW      #0900

                DW      #0609           ; O
                DW      #0909
                DW      #0909
                DW      #0600

                DW      #0E09           ; P
                DW      #090E
                DW      #0808
                DW      #0800

                DW      #0609           ; Q
                DW      #0909
                DW      #090B
                DW      #0600

                DW      #0E09           ; R
                DW      #090E
                DW      #0909
                DW      #0900

                DW      #0609           ; S
                DW      #0806
                DW      #0109
                DW      #0600

                DW      #0E04           ; T
                DW      #0404
                DW      #0404
                DW      #0400

                DW      #0909           ; U
                DW      #0909
                DW      #0909
                DW      #0600

                DW      #0909           ; V
                DW      #0909
                DW      #0A0C
                DW      #0800

                DW      #0909           ; W
                DW      #0909
                DW      #0F0F
                DW      #0900

                DW      #0909           ; X
                DW      #0906
                DW      #0909
                DW      #0900

                DW      #0909           ; Y
                DW      #0907
                DW      #0101
                DW      #0E00

                DW      #0F01           ; Z
                DW      #0204
                DW      #0808
                DW      #0F00

                DW      #0000           ; SPACE [
                DW      #0000
                DW      #0000
                DW      #0000

                DW      #0000           ; COMMA \
                DW      #0000
                DW      #0602
                DW      #0400

                DW      #0609           ; 9 a ]
                DW      #0907
                DW      #0109
                DW      #0600
;NUMBERS:
                .pic    "      * ",	; 1 ^
			"     ** ",
			"      * ",
			"      * ",
			"      * ",
			"      * ",
			"      * ",
			"        "

		.pic	"     ** ",	; 2 _
			"    *  *",
			"       *",
			"      * ",
			"     *  ",
			"    *   ",
			"    ****",
			"        "

                .pic	"       *",	; 4 `
			"      **",
			"     * *",
			"    *  *",
			"    ****",
			"       *",
			"       *",
			"        "


; ------------------------------------
;  DEFINE VARIABLE & CONSTANT STORAGE
; ------------------------------------

HSCOR:          DW      #0000           ; HIGH SCORE
                DW      #0000
                DW      #0000

SCORE:          DW      #0000           ; PLAYER SCORE
                DW      #0000
                DW      #0000

CHRGX:          DW      #0000           ; DEPTH CHARGE X POSITION
                DW      #0000

CHRGY:          DW      #0000           ; DEPTH CHARGE Y POSITION
                DW      #0000

CHRGF:          DW      #0000           ; DEPTH CHARGE ACTIVE FLAGS
                DW      #0000

SUBX:           DW      #0000           ; SUB X POSITION
                DW      #0000
                DW      #0000

SUBY:           DW      #0000           ; SUB Y POSITION
                DW      #0000
                DW      #0000

SUBSP:          DW      #0000           ; SUB SPEED  (0, 1, OR 2)
                DW      #0000
                DW      #0000

SUBF:           DW      #0000           ; SUB ACTIVE FLAG
                DW      #0000
                DW      #0000

CDROP:          DW      #0000           ; # CHARGES DROPPED

CHIT:           DW      #0000           ; # CHARGES THAT HIT

HITPCT:         DW      #0000

BORD1:          DW      #0A0D           ; BORDER PIECE 1
                DW      #0E0F           ;   UPPER LEFT, AND LOWER RIGHT CORNERS

BORD2:          DW      #0A05           ; BORDER PIECE 2
                DW      #0A05           ;   TOP, RIGHT, AND UPPER RIGHT CORNER

BORD3:          DW      #0F0F           ; BORDER PIECE 3
                DW      #0F0F           ;   LEFT, BOTTOM, AND LOWER LEFT CORNER

GAMETIMER:
                DB      #00             ; GAME TIMER

                .align
SCRATCHPAD:
                DW      #0000
                DW      #0000

INTROPATTERN:
                DW      #7E80
                DW      #8080
                DW      #807E
                DW      #0010
                DW      #1010
                DW      #1000
                DW      #FE92
                DW      #9292
                DW      #6C00
                DW      #7C82
                DW      #8282
                DW      #7C00
                DW      #F824
                DW      #2224
                DW      #F800
                DW      #0202
                DW      #FE02
                DW      #0200
