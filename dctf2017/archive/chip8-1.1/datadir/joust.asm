;
; From: catto@vivaldi.ecn.purdue.edu (Erin S Catto)
; Subject: Joust 2.0 Source
; Date: 29 May 91 03:02:16 GMT
;
                .title  "Joust version 2.0",
			"Copyright (C) 1991 Erin S Catto"
                .xref   on
;
; Here is the source for Joust v2.0 written in Chipper syntax
;---------------------------------------------------------------------
;--------------
;Register Usage
;--------------
;
;V0	=	Sprite X coordinate (player, crows and eggs)
;V1	=	Sprite Y coordinate
;V2	=	Sprite X delta
;V3	=	Sprite Y delta
;V4	=	Current right/left flag (moves pointer)
;V5	=	Old right/left flag
;V6	=	Player's X coordinate, for collision checking, player dead flag
;V7	=	Player's Y coordinate, for collision checking
;V8	=	Mode of play flag
;V9	=	# players left
;VA	=	Sprite scope flag
;VB	=	# crows, by level
;VC	=	level
;VD	=	scratch
;VE	=	scratch
;VF	=	collision, greater/less than flag
;
;Many items are stored, see bottom of source code

;Constants
;---------
TRUE            =       1               ;used to denote a test with vf
FALSE           =       0

SCOREDELTA      =       1

SPRTHEIGHT      =       8               ;height of sprite (player/crow)
SPRTWIDTH       =       8               ;width of sprite

NONE            =       0               ;Sprite scoping values (VA)
ONECROW         =       1
TWOCROWS        =       2
ONECROW1EGG     =       3
TWOEGGS         =       4
ONEEGG          =       5

GUYDEAD         =       #DD             ;flag, V6

MODE1           =       0               ;levels 1-3
MODE2           =       1               ;levels 4-7
MODE3           =       2               ;levels 8-99

KEYUP           =       #A
KEYRGT          =       #C
KEYLFT          =       3

PAD1TOP         =       28              ;geometry of islands
PAD1BOT         =       32
PAD1RGT         =       16
PAD1LFT         =       112

PAD2TOP         =       16
PAD2BOT         =       20
PAD2RGT         =       80
PAD2LFT         =       48

PAD3TOP         =       40
PAD3BOT         =       44
PAD3RGT         =       80
PAD3LFT         =       48

ROOF            =       0
FLOOR           =       60

BONUSLIMIT      =       110             ;bonus round time limit

                JP      BRAG

		.byte	10
                .ascii	"Joust version 2.0"
		.byte	10
		.ascii	"Copyright (C) 1991 Erin S Catto"
		.byte	10
		.align

BRAG:           high                    ;turn on extended
                CALL    NAME            ;title screen

REPLAY:         LD      V0, 0           ;zero score storage
                LD      I, SCORE
                LD      [I], V0
                LD      V8, MODE1
                LD      V9, 3           ;three players
                LD      VC, 0

NEWLEVEL:       LD      VD, 15
                CALL    DELAY
                CLS
                LD      VA, TWOCROWS
                ADD     VC, 1
                LD      VD, 7
                AND     VD, VC
                SNE     VD, 7           ;every 7 levels is the bonus round
                JP      BONUS
                LD      VD, 7
                SUB     VD, VC
                SNE     VF, FALSE       ;7 - n < 0 -> vf=0
                JP      STALL           ;past level 8 freeze #crows
                SNE     VC, 4
                LD      V8, MODE2
                LD      VB, VC          ;levels 1-6, #crows=level + 1
                ADD     VB, 1
RSTALL:         CALL    RAY1            ;draw rays
                LD      VE, 27          ;y coordinate of level number
                LD      VD, 9
                SUB     VD, VC
                SE      VF, TRUE        ;check if level > 9
                JP      TWODIGIT        ;draw two digit level
                xhex    vC              ;10 byte font for VC
                LD      VD, 60
                DRW     VD, VE, 10
                CALL    RAY2            ;erase rays
                JP      RESUME

STALL:          LD      VB, 8           ;past level 7, #crows=8
                LD      V8, MODE3       ;fast mode
                JP      RSTALL

TWODIGIT:       LD      I, LEVEL        ;two digit level number
                bcd     VC              ;load bcd of vc into LEVEL data space
                LD      V2, [I]         ;read back bcd
                LD      VD, 55
                xhex    v1
                DRW     VD, VE, 10
                LD      VD, 65
                xhex    v2
                DRW     VD, VE, 10
                CALL    RAY2
                JP      RESUME

RESUME:         CALL    SCREEN
                CALL    INITGUY
                CALL    INITCROW1
                SE      VB, 0           ;sometimes only one crow left
                CALL    INITCROW2
                LD      VD, 15          ;delay argument
                CALL    DELAY

MAIN:           CALL    MOVEGUY
                SNE     V6, GUYDEAD
                JP      DIE
                SNE     VA, NONE
                JP      NEWLEVEL
                CALL    MOVEOTHERS      ;handles all non-player sprites
                SE      V8, MODE1
                CALL    WAVE
                LD      VD, 5
                SNE     V8, MODE1
                CALL    DELAY
                LD      VD, 3
                SNE     V8, MODE2
                CALL    DELAY
                JP      MAIN

DELAY:          LD      DT, VD
DLP:            LD      VD, DT
                SE      VD, 0
                JP      DLP
                RET

MOVEGUY:        LD      I, GUYSAVE      ;retrieve player registers
                LD      V5, [I]
                CALL    GODOWN
                LD      V2, 0           ;start with delta x = 0
                LD      VD, KEYUP
                skip.ne VD, key
                CALL    GOUP
                LD      VD, KEYLFT
                skip.ne VD, key
                CALL    GOLEFT
                LD      VD, KEYRGT
                skip.ne VD, key
                CALL    GORIGHT
                CALL    DRAWGUY
                SNE     V6, GUYDEAD
                RET
                SNE     VF, 1
                CALL    COLLISION       ;global collision routine
                RET

MOVEOTHERS:     SNE     VA, ONECROW
                JP      MOVECROW1
                SNE     VA, TWOCROWS
                JP      MOVECROWS
                SNE     VA, ONECROW1EGG
                JP      MOVECROW1EGG1
                SNE     VA, TWOEGGS
                JP      MOVEEGGS
                SNE     VA, ONEEGG
                JP      MOVEEGG1

MOVECROWS:      CALL    MOVECROW1
                CALL    MOVECROW2
                RET

MOVECROW1:      LD      I, CROW1SAVE
                LD      V5, [I]
                RND     VD, 3
                SNE     VD, 0
                CALL    GORANDOM        ;random motion
                CALL    ATTACK          ;within range, crow will attack
                CALL    DRAWCROW1
                SNE     VF, TRUE        ;collision?
                JP      CROW1COLL
                RET

ATTACK:         LD      VD, V6          ;this routine finds the absolute
                SUB     VD, V0          ;distance between player and crow
                SE      VF, TRUE        ;and compares this with a minimum
                SUBN    VD, VF          ;attacking distance
                LD      VE, 20
                SUB     VE, VD
                SE      VF, TRUE
                RET
                LD      VD, V7
                SUB     VD,V1
                SE      VF, TRUE
                SUBN    VD, VF
                LD      VE, 12
                SUB     VE, VD
                SE      VF, TRUE
                RET
                LD      VD, V6          ;this part steers the crow towards
                SUB     VD, V0          ;the player
                SE      VF, TRUE
                CALL    GOLEFT
                SE      VF, FALSE
                CALL    GORIGHT
                LD      VD, V7
                SUB     VD, V1
                SE      VF, FALSE
                CALL    GODOWN
                SE      VF, TRUE
                CALL    GOUP
                SNE     V1, V7
                CALL    GOUP
                RET

MOVECROW2:      LD      I, CROW2SAVE
                LD      V5, [I]
                RND     VD, 2
                SNE     VD, 0
                CALL    GORANDOM
                CALL    DRAWCROW2
                SNE     VF, TRUE
                JP      CROW2COLL       ;collision routine for crows only
                RET


MOVECROW1EGG1:  CALL    MOVECROW1
                CALL    MOVEEGG1
                RET

MOVEEGGS:       CALL    MOVEEGG2
                CALL    MOVEEGG1
                RET

MOVEEGG1:       LD      I, EGG1SAVE
                LD      V4, [I]
                SNE     V4, 2           ;v4 flags if egg is on the floor
                JP      FADE1           ;count down for egg removal
                LD      V2, 0
                CALL    HOPCHECK        ;egg will hop on pads
                CALL    DRAWEGG
                LD      I, EGG1SAVE
                LD      [I], V4
                RET

FADE1:          ADD     V2, 1           ;V2 becomes the count down to remove
                SNE     V2, 8           ;the egg
                JP      BYEEGG1
                LD      I, EGG1SAVE
                LD      [I], V4
                RET

BYEEGG1:        LD      I, EGG
                DRW     V0, V1, 4
                SNE     VA, TWOEGGS     ;take care of sprite scope
                JP      SHIFTEGG
                SNE     VA, ONECROW1EGG
                JP      MAKECROW2
                LD      VA, NONE
                RET

SHIFTEGG:       LD      I, EGG2SAVE     ;we have egg2 only if egg1 is present
                LD      V4, [I]
                LD      I, EGG1SAVE
                LD      [I], V4
                SNE     VB, 0
                LD      VA, ONEEGG
                SNE     VB, 0
                RET
                CALL    INITCROW1
                LD      VA, ONECROW1EGG
                RET

MAKECROW2:      SNE     VB, 0
                LD      VA, ONECROW
                SNE     VB, 0
                RET
                CALL    INITCROW2
                LD      VA, TWOCROWS
                RET

MOVEEGG2:       LD      I, EGG2SAVE
                LD      V4, [I]
                SNE     V4, 2
                JP      FADE2
                LD      V2, 0
                CALL    HOPCHECK
                CALL    DRAWEGG
                LD      I, EGG2SAVE
                LD      [I], V4
                RET

FADE2:          ADD     V2, 1
                SNE     V2, 8
                JP      BYEEGG2
                LD      I, EGG2SAVE
                LD      [I], V4
                RET

BYEEGG2:        LD      I, EGG
                DRW     V0, V1, 4
                SNE     VB, 0
                JP      BB2
                CALL    INITCROW1
                LD      VA, ONECROW1EGG
                RET
BB2:            LD      VA, ONEEGG
                RET

HOPCHECK:       SNE     V1, PAD1TOP - 4
                JP      HOP1
                SNE     V1, PAD2TOP - 4
                JP      HOP23
                SNE     V1, PAD3TOP - 4
                JP      HOP23
                LD      V3, 1
                RET

HOP1:           CALL    PAD1H
                SE      V3, 0
                RET
                LD      VD, 1
                LD      ST, VD
                LD      V3, -3
                SNE     V4, 0
                LD      V2, #FE
                SNE     V4, 1
                LD      V2, #2
                RET

HOP23:          CALL    PAD23H
                SE      V3, 0
                RET
                LD      VD, 1
                LD      ST, VD
                LD      V3, -3
                SNE     V4, 0
                LD      V2, #FE
                SNE     V4, 1
                LD      V2, #2
                RET

DRAWEGG:        LD      VD, V0
                LD      VE, V1
                ADD     V0, V2
                ADD     V1, V3
                LD      I, EGG
                DRW     VD, VE, 4
                DRW     V0, V1, 4
                SNE     V1, 56
                LD      V4, 2
                RET

DRAWGUY:        CALL    CHECKVERT
                CALL    CHECKHORZ
TITLEGUY:       LD      VD, V0
                LD      VE, V1
                ADD     V0, V2
                ADD     V1, V3
                LD      I, GUY
                ADD     I, V5
                LD      V5, 127
                AND     V0, V5
                LD      V5, V4
                LD      V6, V0
                LD      V7, V1
                DRW     VD, VE, 8
                LD      I, GUY
                ADD     I, V4
                DRW     V0, V1, 8
                SNE     V1, 56
                LD      V6, GUYDEAD
                LD      I, GUYSAVE
                LD      [I], V5
                RET

DRAWCROW1:      CALL    DRAWCROW
                LD      I, CROW1SAVE
                LD      [I], V5
                RET

DRAWCROW2:      CALL    DRAWCROW
                LD      I, CROW2SAVE
                LD      [I], V5
                RET

DRAWCROW:       CALL    CHECKVERT
                CALL    CHECKHORZ
                SNE     V1, 52
                CALL    GOUP
TITLECROW:      LD      VD, V0
                LD      VE, V1
                ADD     V0, V2
                ADD     V1, V3
                LD      I, CROW
                ADD     I, V5
                LD      V5, 127
                AND     V0, V5
                LD      V5, V4
                DRW     VD, VE, 8
                LD      I, CROW
                ADD     I, V4
                DRW     V0, V1, 8
                RET

GOLEFT:         LD      V4, 8
                LD      V2, -4
                RET

GORIGHT:        LD      V4, 0
                LD      V2, 4
                RET

GOUP:           LD      V3, -2
                RET

GODOWN:         LD      V3, 2
                RET

GORANDOM:       RND     VD, 1
                SNE     VD, 1
                LD      ST, VD
                SNE     VD, 0
                CALL    GOLEFT
                SNE     VD, 1
                CALL    GORIGHT
                RND     VD, 1
                SNE     VD, 0
                CALL    GODOWN
                SNE     VD, 1
                CALL    GOUP
                RET

WAVE:           RND     VD, 3
                SE      VD, 0
                RET
                LD      I, SPLASHSAVE
                LD      V1, [I]
                LD      VD, 59
                LD      I, SPLASHXOR
                DRW     V0, VD, 5
                ADD     V0, V1
                SNE     V0, 8
                CALL    SPLASHRGT
                SNE     V0, 112
                CALL    SPLASHLFT
                LD      I, SPLASHSAVE
                LD      [I], V1
                RET

SPLASHRGT:      LD      V0, 16
                LD      V1,  8
                RET

SPLASHLFT:      LD      V0, 104
                LD      V1, #F8
                RET

CROW1COLL:      CALL    CROWCOLL
                SNE     VF, FALSE
                JP      KILLCROW1
                RET

CROW2COLL:      CALL    CROWCOLL
                SNE     VF, FALSE
                JP      KILLCROW2
                RET

CROWCOLL:       LD      VD, V6
                SUB     VD, V0
                SNE     VF, FALSE
                SUB     VF, VD
                LD      VE, SPRTWIDTH
                SUB     VD, VE
                SNE     VF, TRUE
                RET
                LD      VD, V7
                SUB     VD, V1
                SNE     VF, FALSE
                SUB     VF, VD
                LD      VE, SPRTHEIGHT
                SUB     VD, VE
                RET

COLLISION:      SNE     VA, TWOCROWS
                JP      COLLCC
                SNE     VA, ONECROW
                JP      KILLCROW1
                SNE     VA, TWOEGGS
                JP      EATEGGS
                SNE     VA, ONEEGG
                JP      EATEGG1
                JP      COLLCB

EATEGGS:        LD      I, EGG1SAVE
                LD      V4, [I]
                CALL    COLX
                SE      VF, TRUE
                JP      EATEGG2
                CALL    COLY
                SE      VF, TRUE
                JP      EATEGG2
                JP      EATEGG1

EATEGG1:        CALL    SCOREINC
                CALL    SHORT
                CALL    QUICK
                LD      I, EGG1SAVE
                LD      V4, [I]
                JP      BYEEGG1

EATEGG2:        CALL    SCOREINC
                CALL    SHORT
                CALL    QUICK
                LD      I, EGG2SAVE
                LD      V4, [I]
                JP      BYEEGG2

COLLCB:         LD      I, CROW1SAVE
                LD      V5, [I]
                CALL    COLX
                SE      VF, TRUE
                JP      EATEGG1
                CALL    COLY
                SE      VF, TRUE
                JP      EATEGG1
                JP      KILLCROW1

COLLCC:         LD      I, CROW1SAVE
                LD      V5, [I]
                CALL    COLX
                SE      VF, TRUE
                JP      KILLCROW2
                CALL    COLY
                SE      VF, TRUE
                JP      KILLCROW2
                JP      KILLCROW1

COLX:           LD      VD, V6
                SUB     VD, V0
                SE      VF, TRUE
                SUBN    VD, VF
                LD      VE, SPRTWIDTH
                SUB     VE, VD
                RET

COLY:           LD      VD, V7
                SUB     VD, V1
                SE      VF, TRUE
                SUBN    VD, VF
                LD      VE, SPRTHEIGHT
                SUB     VE, VD
                RET

KILLCROW1:      LD      I, CROW1SAVE
                LD      V5, [I]
                SNE     V7, V1
                JP      BUMP1
                LD      VD, V7
                SUB     VD, V1
                SE      VF, FALSE
                JP      DIEGUY
                CALL    QUICK
                CALL    SHORT
                LD      I, CROW
                ADD     I, V5
                DRW     V0, V1, 8
                SNE     VA, ONECROW1EGG
                JP      MAKEEGG2
                SNE     VA, TWOCROWS
                JP      SHIFTCROW
                SNE     VA, ONECROW
                LD      VA, ONEEGG
                CALL    INITEGG1
                RET

MAKEEGG2:       LD      VA, TWOEGGS
                CALL    INITEGG2
                RET

SHIFTCROW:      CALL    INITEGG1
                LD      I, CROW2SAVE
                LD      V5, [I]
                LD      I, CROW1SAVE
                LD      [I], V5
                LD      VA, ONECROW1EGG
                RET

KILLCROW2:      LD      I, CROW2SAVE
                LD      V5, [I]
                SNE     V7, V1
                JP      BUMP2
                LD      VD, V7
                SUB     VD, V1
                SE      VF, FALSE
                JP      DIEGUY
                CALL    QUICK
                CALL    SHORT
                LD      I, CROW
                ADD     I, V5
                DRW     V0, V1, 8
                LD      VA, ONECROW1EGG
                CALL    INITEGG1
                RET

DIEGUY:         LD      V6, GUYDEAD
                RET

INITCROW2:      CALL    ADDCROW
                LD      I, CROW2SAVE
                LD      [I], V5
                RET

INITCROW1:      CALL    ADDCROW
                LD      I, CROW1SAVE
                LD      [I], V5
                RET

ADDCROW:        CALL    RANDINIT        ;random crow placement
                ADD     VB, #FF         ;decrement # of crows
                CALL    GOUP            ;crow starts going up
                RND     VD, 1           ;random right or left
                SE      VD, 1
                CALL    GOLEFT
                SE      VD, 0
                CALL    GORIGHT
                LD      I, CROW         ;crow sprite
                ADD     I, V4
                DRW     V0, V1, 8
                LD      V5, V4
                RET

RANDINIT:       RND     VD, 3
                SNE     VD, 0
                JP      STARTPAD1
                SNE     VD, 1
                JP      STARTPAD2
                SNE     VD, 2
                JP      STARTPAD3
STARTPAD4:      LD      V0, 120
                LD      V1, FLOOR - SPRTHEIGHT
                RET
STARTPAD3:      LD      V0, 64
                LD      V1, PAD3TOP - SPRTHEIGHT
                RET
STARTPAD2:      LD      V0, 64
                LD      V1, PAD2TOP - SPRTHEIGHT
                RET
STARTPAD1:      LD      V0, 8
                LD      V1, PAD1TOP - SPRTHEIGHT
                RET

INITEGG:        ADD     V1, 8           ;v1 is dead crow y coordinate
                LD      VD, 55          ;check the floor
                SUB     VD, V1          ;so the egg won't fall thru
                SNE     VF, FALSE
                LD      V1, 55
                RND     V4, 1
                LD      I, EGG
                DRW     V0, V1, 4
                RET

INITEGG1:       CALL    INITEGG
                LD      I, EGG1SAVE
                LD      [I], V4
                RET

INITEGG2:       CALL    INITEGG
                LD      I, EGG2SAVE
                LD      [I], V4
                RET

BUMP1:          CALL    BUMPTEST
                SE      VF, FALSE
                JP      BUMP1RIGHT
                CALL    GORIGHT
                CALL    DRAWCROW1
                CALL    DRAWCROW1
                JP      BUMPGUYLEFT
BUMP1RIGHT:     CALL    GOLEFT
                CALL    DRAWCROW1
                CALL    DRAWCROW1
                JP      BUMPGUYRIGHT

BUMP2:          CALL    BUMPTEST
                SE      VF, FALSE
                JP      BUMP2RIGHT
                CALL    GORIGHT
                CALL    DRAWCROW2
                CALL    DRAWCROW2
                JP      BUMPGUYLEFT
BUMP2RIGHT:     CALL    GOLEFT
                CALL    DRAWCROW2
                CALL    DRAWCROW2
                JP      BUMPGUYRIGHT

BUMPTEST:       LD      VD, 3
                LD      ST, VD
                LD      VD, V6
                SUB     VD, V0
                RET

BUMPGUYRIGHT:   LD      I, GUYSAVE
                LD      V5, [I]
                CALL    GORIGHT
                CALL    DRAWGUY
                CALL    DRAWGUY
                RET

BUMPGUYLEFT:    LD      I, GUYSAVE
                LD      V5 , [I]
                CALL    GOLEFT
                CALL    DRAWGUY
                CALL    DRAWGUY
                RET

DIE:            CALL    SHORT
                CALL    QUICK
                CALL    LONG
                LD      VD, 10
                CALL    DELAY
                ADD     V9, #FF
                SNE     V9, #0
                JP      FINI
                SNE     VA, ONECROW
                ADD     VB, 1
                SNE     VA, ONECROW1EGG
                ADD     VB, 1
                SNE     VA, TWOCROWS
                ADD     VB, 2
                LD      VA, TWOCROWS
                SNE     VB, 0
                JP      NEWLEVEL
                LD      VA, TWOCROWS
                SNE     VB, 1
                LD      VA, ONECROW
                JP      RESUME

FINI:           CALL    BYE
                CLS
                CALL    SCOREDRW
                CALL    FINITE          ;flying birds
                JP      REPLAY

BYE:            LD      VD, 12          ;plays ending tune
                LD      ST, VD
                LD      VD, #18
                CALL    DELAY
                CALL    SHORT
                CALL    SHORT
                CALL    LONG
                CALL    LONG
                LD      VD, 32
                CALL    DELAY
                CALL    LONG
                CALL    LONG
                LD      VD, 32
                CALL    DELAY
                RET

QUICK:          LD      VD, 2
                LD      ST, VD
                LD      VD, 5
                CALL    DELAY
                RET

SHORT:          LD      VD, 4
                LD      ST, VD
                LD      VD, 10
                CALL    DELAY
                RET

LONG:           LD      VD, 8
                LD      ST, VD
                LD      VD, 20
                CALL    DELAY
                RET

SCOREINC:       LD      I, SCORE
                LD      V0, [I]
                ADD     V0, SCOREDELTA
                LD      [I], V0
                RET

SCOREDRW:       LD      I, SCORE
                LD      V0, [I]
                bcd     V0
                LD      V2, [I]
                LD      VE, 27
                LD      VD, 49
                xhex    v0              ;10 BYTE FONT FOR V0
                DRW     VD, VE, 10
                ADD     VD, 10
                xhex    v1              ;10 BYTE FONT FOR V1
                DRW     VD, VE, 10
                ADD     VD, 10
                xhex    v2              ;10 BYTE FONT FOR V2
                DRW     VD, VE, 10
                RET


RAY1:           LD      V3, 0
                LD      V4, 0
                LD      V5, 124
                LD      V6, 62

RAY2:           LD      I, DOT
CONV:		DRW	V3, V4, 3
                DRW     V3, V6, 3
                DRW     V5, V4, 3
                DRW     V5, V6, 3
                ADD     V3, 4
                ADD     V4, 2
                ADD     V5, #FC
                ADD     V6, #FE
                LD      VD, 4
                CALL    DELAY
                SNE     V3, 64
                RET
                SNE     V3, 128
                RET
                JP      CONV

INITGUY:        LD      V4, 0
                LD      V5, 0
                LD      V0, PAD1LFT
                LD      V1, PAD1TOP - 8
                LD      I, GUY
                DRW     V0, V1, 8
                LD      I, GUYSAVE
                LD      [I], V5
                RET

CHECKVERT:      SNE     V1, ROOF
                JP      CHECKROOF
                SNE     V1, FLOOR - SPRTHEIGHT
                JP      CHECKFLOOR

                LD      VD, 2
                SE      V3, VD
                JP      STOPUP

                SNE     V1, PAD1TOP - SPRTHEIGHT
                JP      PAD1H
                SNE     V1, PAD2TOP - SPRTHEIGHT
                JP      PAD23H
                SNE     V1, PAD3TOP - SPRTHEIGHT
                JP      PAD23H
                RET

STOPUP:         SNE     V1, PAD1BOT
                JP      PAD1H
                SNE     V1, PAD2BOT
                JP      PAD23H
                SNE     V1, PAD3BOT
                JP      PAD23H
                RET

PAD1H:          LD      VD, PAD1RGT
                SUBN    VD, V0
                SE      VF, TRUE
                JP      YHOLD
                LD      VD, PAD1LFT - SPRTWIDTH
                SUB     VD, V0
                SE      VF, TRUE
                JP      YHOLD
                RET

PAD23H:         LD      VD, PAD2LFT - SPRTWIDTH+1
                SUBN    VD, V0
                SE      VF, TRUE
                RET
                LD      VD, PAD2RGT
                SUBN    VD, V0
                SE      VF, TRUE
                JP      YHOLD
                RET

CHECKROOF:      LD      VD, -2
                SNE     V3, VD
                CALL    GODOWN
                RET

CHECKFLOOR:     LD      VD, 2
                SE      V3, VD
                RET
                SNE     V8, MODE1
                JP      YHOLD
                SE      V8, MODE1
                JP      PAD1H
                RET

YHOLD:          LD      V3, 0
                RET

CHECKHORZ:      SNE     V2, 0
                RET
                LD      VD, 4
                SE      V2, VD
                JP      STAYLEFT

                SNE     V0, PAD1LFT - SPRTWIDTH
                JP      PAD1V
                SNE     V0, PAD2LFT - SPRTWIDTH
                JP      PAD23V
                RET

STAYLEFT:       SNE     V0, PAD1RGT
                JP      PAD1V
                SNE     V0, PAD2RGT
                JP      PAD23V
                RET

PAD1V:          LD      VD, PAD1TOP - SPRTHEIGHT - 3
                SUBN    VD, V1
                SE      VF, TRUE
                RET
                LD      VD, PAD1BOT + 1
                SUBN    VD, V1
                SE      VF, TRUE
                JP      XHOLD
                RET

PAD23V:         LD      VD, 28
                SUB     VD, V1
                SNE     VF, FALSE
                JP      PAD3V

PAD2V:          LD      VD, PAD2TOP - SPRTHEIGHT - 3
                SUBN    VD, V1
                SE      VF, TRUE
                RET
                LD      VD, PAD2BOT + 1
                SUBN    VD, V1
                SE      VF, TRUE
                JP      XHOLD
                RET

PAD3V:          LD      VD, PAD3TOP - SPRTHEIGHT - 3
                SUBN    VD, V1
                SE      VF, TRUE
                RET
                LD      VD, PAD3BOT + 1
                SUBN    VD, V1
                SE      VF, TRUE
                JP      XHOLD
                RET

XHOLD:          LD      V2, 0
                RET

SCREEN:         CLS
                LD      VD, 0
                LD      VE, 60
                LD      I, SOLIDPAD
                DRW     VD, VE, 4
                LD      VD, 8
                DRW     VD, VE, 4
                LD      I, CENTERPAD
                LD      VD, 16
                SNE     V8, MODE1
                CALL    FLOOR1
                SE      V8, MODE1
                CALL    FLOOR2
                LD      I, CENTERPAD
                LD      VE, PAD1TOP
                LD      VD, PAD1LFT + 8
                DRW     VD, VE, 4
                LD      VD, PAD1RGT - 16
                DRW     VD, VE, 4
                LD      VD, PAD2LFT + 8
                LD      VE, PAD2TOP
                DRW     VD, VE, 4
                LD      VD, PAD2LFT + 16
                DRW     VD, VE, 4
                LD      VE, PAD3TOP
                DRW     VD, VE, 4
                LD      VD, PAD3LFT + 8
                DRW     VD, VE, 4
                LD      I, RIGHTPAD
                LD      VD, PAD3RGT - 8
                DRW     VD, VE, 4
                LD      VE, PAD2TOP
                DRW     VD, VE, 4
                LD      VD, PAD1RGT - 8
                LD      VE, PAD1TOP
                DRW     VD, VE, 4
                LD      I, LEFTPAD
                LD      VD, PAD1LFT
                DRW     VD, VE, 4
                LD      VE, PAD3TOP
                LD      VD, PAD3LFT
                DRW     VD, VE, 4
                LD      VE, PAD2TOP
                DRW     VD, VE, 4
                CALL    PLAYSLEFT
                RET

FLOOR1:         DRW     VD, VE, 4
                ADD     VD, 8
                SE      VD, 128
                JP      FLOOR1
                RET

FLOOR2:         LD      VD, 112
                DRW     VD, VE, 4
                LD      VD, 120
                DRW     VD, VE, 4
                LD      VD, 16
                LD      I, SPLASH
                LD      VE, 59
                IWLP:   DRW  VD, VE, 5
                ADD     VD, 8
                SE      VD, 112
                JP      IWLP
                LD      V0, 104
                LD      V1, #F8
                LD      I, SPLASHSAVE
                LD      [I], V1
                RET

PLAYSLEFT:      SNE     V9, 1
                RET
                LD      VD, 1
                LD      VE, 61
                LD      I, DOT
                DRW     VD, VE, 3
                ADD     VD, 4
                SE      V9, 2
                DRW     VD, VE, 3
                ADD     VD, 4
                LD      V6, 3
                SUB     V6, V9
                SNE     VF, FALSE
                DRW     VD, VE, 3
                RET

NAME:           LD      I, TITLE
                LD      VD, 36
                LD      VE, 24
                DRW     VD, VE
                LD      V0, 32
                ADD     I, V0
                ADD     VD, 16
                DRW     VD, VE
                ADD     I, V0
                ADD     VD, 16
                DRW     VD, VE
                ADD     I, V0
                ADD     VD, 16
                DRW     VD, VE

FINITE:         LD      V8, 0
                LD      VB, 1
                LD      VA, 0
                CALL    INITCROW1
                CALL    INITGUY
                CALL    GORIGHT
                LD      I, GUYSAVE
                LD      [I], V5

TLP:            LD      VD, 10
                CALL    DELAY
                LD      I, GUYSAVE
                LD      V5, [I]
                CALL    TSUB
                CALL    TITLEGUY
                LD      I, GUYSAVE
                LD      [I], V5
                LD      I, CROW1SAVE
                LD      V5, [I]
                CALL    TSUB
                CALL    TITLECROW
                LD      I, CROW1SAVE
                LD      [I], V5
                LD      VD, KEYUP
                skip.eq VD, key
                JP      TLP
                RET

TSUB:           RND     VD, 15
                SNE     VD, FALSE
                CALL    GORANDOM
                SNE     V1, 2
                LD      V3, 2
                SNE     V1, 54
                LD      V3, -2
                RET

BONUS:          CALL    SCREEN
                CALL    INITGUY
                LD      I, EGG
                LD      VE, PAD2TOP - 4
                LD      VD, PAD2LFT + 2
                DRW     VD, VE, 4
                ADD     VD, 12
                DRW     VD, VE, 4
                ADD     VD, 12
                DRW     VD, VE, 4
                LD      VE, PAD3TOP - 4
                LD      VD, PAD3LFT + 2
                DRW     VD, VE, 4
                ADD     VD, 12
                DRW     VD, VE, 4
                ADD     VD, 12
                DRW     VD, VE, 4
                LD      VE, PAD1TOP - 4
                LD      VD, PAD1RGT - 6
                DRW     VD, VE, 4
                LD      VE, FLOOR - 4
                DRW     VD, VE, 4
                LD      VD, PAD1LFT + 2
                DRW     VD, VE, 4
                LD      V6, 0
                LD      V7, 0

;--------------------------
;Bonus Round Register Usage
;--------------------------
;v0 = guy x
;v1 = guy y
;v2 = guy delta x
;v3 = guy delta y
;v4 = current right/left flag
;v5 = old right/left flag

BONUSMAIN:      ADD     V7, 1
                SNE     V7, BONUSLIMIT
                JP      NEWLEVEL
                LD      VD, 1
                LD      ST, VD
                LD      VD, 3
                CALL    DELAY
                LD      I, GUYSAVE
                LD      V5, [I]
                CALL    GODOWN
                LD      V2, 0
                LD      VD, KEYUP
                skip.ne VD, key
                CALL    GOUP
                LD      VD, KEYLFT
                skip.ne VD, key
                CALL    GOLEFT
                LD      VD, KEYRGT
                skip.ne VD, key
                CALL    GORIGHT
                CALL    CHECKVERT
                CALL    CHECKHORZ
                LD      VD, V0
                LD      VE, V1
                ADD     V0, V2
                ADD     V1, V3
                LD      I, GUY
                ADD     I, V5
                LD      V5, 127
                AND     V0, V5
                LD      V5, V4
                DRW     VD, VE, 8
                LD      I, GUY
                ADD     I, V4
                DRW     V0, V1, 8
                SNE     V1, 56
                JP      BONUSDIE
                LD      I, GUYSAVE
                LD      [I], V5
                SNE     VF, TRUE
                CALL    BONUSCHECK
                SNE     V6, 9
                JP      BIGBONUS
                JP      BONUSMAIN

BONUSCHECK:     LD      VE, FLOOR - 8
                SNE     V1, VE
                JP      FLOORBONUS
                LD      VE, PAD1TOP - 8
                SNE     V1, VE
                JP      PAD1BONUS
                LD      VE, PAD2TOP - 8
                SNE     V1, VE
                JP      PAD23BONUS
                LD      VE, PAD3TOP - 8
                SNE     V1, VE
                JP      PAD23BONUS
                RET

FLOORBONUS:     LD      VD, PAD1LFT + 4
                SNE     V0, VD
                JP      BONUSEGG
                LD      VD, PAD1RGT - 4
                SNE     V0, VD
                JP      BONUSEGG
                RET

PAD1BONUS:      LD      VD, PAD1RGT - 4
                SNE     V0, VD
                JP      BONUSEGG
                RET

PAD23BONUS:     LD      VD, PAD2LFT + 4
                SNE     V0, VD
                JP      BONUSEGG
                ADD     VD, 12
                SNE     V0, VD
                JP      BONUSEGG
                ADD     VD, 12
                SNE     V0, VD
                JP      BONUSEGG
                RET

BONUSEGG:       ADD     VD, #FE
                ADD     VE, 4
                LD      I, EGG
                DRW     VD, VE, 4
                CALL    SHORT
                CALL    QUICK
                ADD     V6, 1
                LD      I, SCORE
                LD      V0, [I]
                ADD     V0, SCOREDELTA
                LD      [I], V0
                RET

BONUSDIE:       LD      VD, 8
                LD      ST, VD
                LD      VD, 20
                CALL    DELAY
                ADD     V9, #FF
                SNE     V9, #0
                JP      FINI
                JP      NEWLEVEL

BIGBONUS:       LD      I, SCORE
                LD      V0, [I]
                ADD     V0, 8
                LD      [I], V0
                ADD     V9, 1
                CALL    LONG
                CALL    SHORT
                CALL    LONG
                JP      NEWLEVEL

SCORE:          DB      #0, #0, #0

DOT:            DB      $01000000, $11100000, $01000000

GUY:            DB      $00000110, $00001111, $00001100, $00001100
                DB      $00000110, $11111111, $01111111, $00011110

                DB      $01100000, $11110000, $00110000, $00110000
                DB      $01100000, $11111111, $11111110, $01111000

CROW:           DB      $00001110, $00001111, $00001100, $00001100
                DB      $11111110, $01111111, $00011111, $00001110

                DB      $01110000, $11110000, $00110000, $00110000
                DB      $01111111, $11111110, $11111000, $01110000

GUYSAVE:        DB      0, 0, 0, 0, 0, 0

CROW1SAVE:      DB      0, 0, 0, 0, 0, 0

CROW2SAVE:      DB      0, 0, 0, 0, 0, 0

EGG1SAVE:       DB      0, 0, 0, 0, 0
EGG2SAVE:       DB      0, 0, 0, 0, 0

RIGHTPAD:       DB      $11111111, $10111010, $11101000, $10000000
LEFTPAD:        DB      $11111111, $01101101, $00011011, $00000010
CENTERPAD:      DB      $11111111, $11101110, $10111011, $10110110
SOLIDPAD:       DB      $11111111, $11111111, $11111111, $11111111

LEVEL:          DB      0, 0, 0         ;used for twodigit level

SPLASH:         DB      $00000110, $00011100, $00101000, $01011100, $11111110
SPLASHXOR:      DB      $01100110, $00100100, $00111100, $01100110, $00000000

SPLASHSAVE:     DB      0, 0            ;right/left flag and x position

EGG:            DB      $01100000,
                $11110000,
                $11110000,
                $01100000

TITLE:          DB      $00000000, $11000000
                DB      $00000000, $11000000
                DB      $00000000, $11000000
                DB      $00000000, $11000000
                DB      $00000000, $11000000
                DB      $00000000, $11000000
                DB      $00000000, $11000011
                DB      $00000000, $11000111
                DB      $00000000, $11001100
                DB      $00000000, $11001100
                DB      $11000000, $11001100
                DB      $11000000, $11001100
                DB      $11000000, $11001100
                DB      $11000000, $11001100
                DB      $01111111, $10000111
                DB      $00111111, $00000011

                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $11110000, $11000000
                DB      $11111000, $11000000
                DB      $00001100, $11000000
                DB      $00001100, $11000000
                DB      $00001100, $11000000
                DB      $00001100, $11000000
                DB      $00001100, $11000000
                DB      $00001100, $11000000
                DB      $11111000, $01111111
                DB      $11110000, $00111111

                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $11000011, $11111100
                DB      $11000111, $11111100
                DB      $11001100, $00000000
                DB      $11001100, $00000000
                DB      $11000111, $11110000
                DB      $11000011, $11111000
                DB      $11000000, $00001100
                DB      $11000000, $00001100
                DB      $11001111, $11111000
                DB      $11001111, $11110000


                DB      $00000000, $00000000
                DB      $00000000, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $11111100, $00000000
                DB      $11111100, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $00110000, $00000000
                DB      $00110011, $00000000
                DB      $00110011, $00000000
                DB      $00011110, $00000000
                DB      $00001100, $00000000
