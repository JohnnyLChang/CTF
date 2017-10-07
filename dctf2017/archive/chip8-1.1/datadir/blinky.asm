;  (S)Chip-48 Blinky V2.00 by Christian Egeberg 7/11-'90 .. 18/8-'91
;  EMail at egeberg@solan.unit.no
;
		.title	"Blinky version 2.0",
			"Copyright (C) 1991 Christian Egeberg"
		.xref	on
;
;  Register usage:
;  V0:	Temporary data, may change during any call
;  V1:	Temporary data, may change during any call
;  V2:	Temporary data, may change during most calls
;  V3:	Temporary data, may change during most calls
;  V4:	Temporary data, may change during some calls
;  V5:	Temporary data, may change during some calls
;  V6:	Pill and score counter
;  V7:	Life and sprite direction register
;  V8:	Blinky X screen coordinate
;  V9:	Blinky Y screen coordinate
;  VA:	Packlett X screen coordinate
;  VB:	Packlett Y screen coordinate
;  VC:	Heward X screen coordinate
;  VD:	Heward Y screen coordinate
;  VE:	Temporary constant and flag storage
;  VF:	Flag register

;  DEFINE/UNDEF SUPER in line below to toggle between versions

		DEFINE	SUPER
		OPTION	BINARY		; Let's compile this for non-HP computers...
;		OPTION HPASC

		IFDEF	SUPER
		OPTION	SCHIP10
		ELSE
		OPTION	CHIP48
		ENDIF

MASKNIBB	=	$1111
MASKBYTE	=	$11111111

DOWNKEY		=	#6
RIGHTKEY	=	#8
LEFTKEY		=	#7
UPKEY		=	#3
PRESSKEY	=	#F
LEVELKEY	=	#1

PILLNUM		=	231
SUPERNUM	=	4

PILLTIME	=	5
SUPERTIME	=	255
CLSWAIT		=	63
EYEWAIT		=	3

PILLADD		=	1
SUPERADD	=	4
HEWARDADD	=	25
PACKLETTADD	=	50
SCREENADD	=	100

MASKLIFE	=	$01000000
MASKHUNT	=	$10000000
MASKCODE	=	$11
DOWNCODE	=	$11
RIGHTCODE	=	$10
LEFTCODE	=	$01
UPCODE		=	$00

BLINKYCODE	=	DOWNCODE
PACKLETTCODE	=	LEFTCODE
HEWARDCODE	=	RIGHTCODE
STARTCODE	=	(HEWARDCODE << 4) | (PACKLETTCODE << 2) | BLINKYCODE

STARTLEVEL	=	$101

		IFDEF	SUPER

SCREENHIGH	=	64
SCREENWIDE	=	128
SPRITEHIGH	=	8
SPRITEWIDE	=	16
SPRITEJUMP	=	4

BLINKYX		=	52
BLINKYY		=	24
PACKLETTX	=	112
PACKLETTY	=	0
HEWARDX		=	4
HEWARDY		=	52

GATELEFT	=	0
GATERIGHT	=	116

SCXPOS		=	36
SCYPOS		=	32
HIXPOS		=	36
HIYPOS		=	20
EYEX1		=	0
EYEX2		=	96
EYEY1		=	1
EYEY2		=	45

		ELSE

SCREENHIGH	=	32
SCREENWIDE	=	64
SPRITEHIGH	=	4
SPRITEWIDE	=	8
SPRITEJUMP	=	2

BLINKYX		=	26
BLINKYY		=	12
PACKLETTX	=	56
PACKLETTY	=	0
HEWARDX		=	2
HEWARDY		=	26

GATELEFT	=	0
GATERIGHT	=	58

SCXPOS		=	17
SCYPOS		=	16
HIXPOS		=	17
HIYPOS		=	10
EYEX1		=	0
EYEX2		=	48
EYEY1		=	0
EYEY2		=	22

		ENDIF

		JP	START

COPYRIGHT:	.byte	10
		.ascii	"Blinky version 2.0"
		.byte	10
		.ascii	"Copyright (C) 1991 Christian Egeberg"
		.byte	10
		.align
		USED	COPYRIGHT

START:		IFDEF	SUPER
		HIGH
		ENDIF
		XOR	V0, V0
		XOR	V1, V1
		LD	I, SCORE
		LD	[I], V1
		LD	V0, STARTLEVEL
		LD	I, LEVEL
		LD	[I], V0
		XOR	V7, V7
REINIT:		XOR	V6, V6
		CALL	COPYMAZE
		CLS
		CALL	DRAWMAZE
RESTART:	LD	VE, MASKLIFE
		AND	V7, VE
		LD	VE, STARTCODE
		OR	V7, VE
		LD	V8, BLINKYX
		LD	V9, BLINKYY
		LD	VA, PACKLETTX
		LD	VB, PACKLETTY
		LD	VC, HEWARDX
		LD	VD, HEWARDY
		CALL	DRAWBLINKY
		LD	I, GHOST
		DRW	VA, VB, SPRITEHIGH
		DRW	VC, VD, SPRITEHIGH
GAMELOOP:	CALL	MOVEBLINKY
		SE	VE, 0
		JP	ENCOUNTER
SPLITUP:	LD	I, LEVEL
		LD	V0, [I]
		LD	V5, V0
		RND	V4, MASKBYTE
		AND	V4, V5
		CALL	MOVEPACKLETT
		RND	V4, MASKBYTE
		AND	V4, V5
		CALL	MOVEHEWARD
		LD	V0, LEVELKEY
		SKNP	V0
		CALL	NEXTLEVEL
		SE	V6, PILLADD * PILLNUM + SUPERADD * SUPERNUM
		JP	GAMELOOP
		LD	VE, V6
		CALL	ADDSCORE
		LD	VE, SCREENADD
		CALL	ADDSCORE
		CALL	NEXTLEVEL
		JP	REINIT
ENCOUNTER:	LD	V0, DT
		SNE	V0, 0
		JP	GOTCHA
		LD	V0, V8
		SHR	V0
		IFDEF	SUPER
		SHR	V0
		ENDIF
		LD	V1, VA
		SHR	V1
		IFDEF	SUPER
		SHR	V1
		ENDIF
		SUB	V0, V1
		SNE	V0, 0
		JP	HITPACKLETT1
		SNE	V0, 1
		JP	HITPACKLETT1
		SNE	V0, -1 & MASKBYTE
		JP	HITPACKLETT1
		JP	OOPSHEWARD
HITPACKLETT1:	LD	V0, V9
		SHR	V0
		IFDEF	SUPER
		SHR	V0
		ENDIF
		LD	V1, VB
		SHR	V1
		IFDEF	SUPER
		SHR	V1
		ENDIF
		SUB	V0, V1
		SNE	V0, 0
		JP	HITPACKLETT2
		SNE	V0, 1
		JP	HITPACKLETT2
		SNE	V0, -1 & MASKBYTE
		JP	HITPACKLETT2
		JP	OOPSHEWARD
HITPACKLETT2:	LD	I, GHOST
		DRW	VA, VB, SPRITEHIGH
		LD	VA, PACKLETTX
		LD	VB, PACKLETTY
		DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		LD	VE, PACKLETTCODE << 2
		OR	V7, VE
		LD	VE, PACKLETTADD
		CALL	ADDSCORE
OOPSHEWARD:	LD	V0, V8
		SHR	V0
		IFDEF	SUPER
		SHR	V0
		ENDIF
		LD	V1, VC
		SHR	V1
		IFDEF	SUPER
		SHR	V1
		ENDIF
		SUB	V0, V1
		SNE	V0, 0
		JP	HITHEWARD1
		SNE	V0, 1
		JP	HITHEWARD1
		SNE	V0, -1 & MASKBYTE
		JP	HITHEWARD1
		JP	SPLITUP
HITHEWARD1:	LD	V0, V9
		SHR	V0
		IFDEF	SUPER
		SHR	V0
		ENDIF
		LD	V1, VD
		SHR	V1
		IFDEF	SUPER
		SHR	V1
		ENDIF
		SUB	V0, V1
		SNE	V0, 0
		JP	HITHEWARD2
		SNE	V0, 1
		JP	HITHEWARD2
		SNE	V0, -1 & MASKBYTE
		JP	HITHEWARD2
		JP	SPLITUP
HITHEWARD2:	LD	I, GHOST
		DRW	VC, VD, SPRITEHIGH
		LD	VC, HEWARDX
		LD	VD, HEWARDY
		DRW	VC, VD, SPRITEHIGH
		LD	VE, ~( MASKCODE << 4 ) & MASKBYTE
		AND	V7, VE
		LD	VE, HEWARDCODE << 4
		OR	V7, VE
		LD	VE, HEWARDADD
		CALL	ADDSCORE
		JP	SPLITUP
GOTCHA:		LD	V0, CLSWAIT
		CALL	WAITKEY
		CALL	DRAWBLINKY
		LD	I, GHOST
		DRW	VA, VB, SPRITEHIGH
		DRW	VC, VD, SPRITEHIGH
		LD	VE, MASKLIFE
		XOR	V7, VE
		LD	V0, V7
		AND	V0, VE
		SE	V0, 0
		JP	RESTART
		LD	VE, V6
		CALL	ADDSCORE
		CALL	NEWHIGH
		CLS
		LD	V6, HIXPOS
		LD	V7, HIYPOS
		LD	I, HIGHSCORE
		CALL	PRINTDEC
		LD	V6, SCXPOS
		LD	V7, SCYPOS
		LD	I, SCORE
		CALL	PRINTDEC
		LD	V4, EYEX1
		LD	V5, EYEX1 + SPRITEWIDE
		LD	V6, EYEY1
		LD	V7, PRESSKEY
EYEX1LOOP:	LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		LD	V0, EYEWAIT
		CALL	WAITKEY
		SE	VE, 0
		JP	EYEPRESS
		LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		ADD	V4, SPRITEJUMP
		ADD	V5, SPRITEJUMP
		SE	V4, EYEX2
		JP	EYEX1LOOP
EYEY1LOOP:	LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		LD	V0, EYEWAIT
		CALL	WAITKEY
		SE	VE, 0
		JP	EYEPRESS
		LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		ADD	V6, SPRITEJUMP
		SE	V6, EYEY2
		JP	EYEY1LOOP
EYEX2LOOP:	LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		LD	V0, EYEWAIT
		CALL	WAITKEY
		SE	VE, 0
		JP	EYEPRESS
		LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		ADD	V4, -SPRITEJUMP & MASKBYTE
		ADD	V5, -SPRITEJUMP & MASKBYTE
		SE	V4, EYEX1
		JP	EYEX2LOOP
EYEY2LOOP:	LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		LD	V0, EYEWAIT
		CALL	WAITKEY
		SE	VE, 0
		JP	EYEPRESS
		LD	I, EYELEFT
		IFDEF	SUPER
		DRW	V4, V6
		ELSE
		DRW	V4, V6, 9
		ENDIF
		LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		ADD	V6, -SPRITEJUMP & MASKBYTE
		SE	V6, EYEY1
		JP	EYEY2LOOP
		JP	EYEX1LOOP
EYEPRESS:	LD	I, EYERIGHT
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		LD	I, EYEBLINK
		IFDEF	SUPER
		DRW	V5, V6
		ELSE
		DRW	V5, V6, 9
		ENDIF
		JP	START

;  MOVEBLINKY
;  ->:	Nothing
;  <-:	VE:  Collision flag
;  <>:	V0, V1, V2, V3, V4, V5, V6, V7, V8, V9, VE, VF, I

MOVEBLINKY:	LD	V3, V7
		LD	VE, MASKCODE
		AND	V3, VE
		LD	V4, V8
		LD	V5, V9
		LD	VE, DOWNKEY
		SKNP	VE
		JP	BLINKYDOWN
		LD	VE, UPKEY
		SKNP	VE
		JP	BLINKYUP
		LD	VE, RIGHTKEY
		SKNP	VE
		JP	BLINKYRIGHT
		LD	VE, LEFTKEY
		SKNP	VE
		JP	BLINKYLEFT
NOKEY:		SNE	V3, DOWNCODE
		ADD	V5, SPRITEJUMP
		SNE	V3, UPCODE
		ADD	V5, -SPRITEJUMP & MASKBYTE
		SNE	V3, RIGHTCODE
		ADD	V4, SPRITEJUMP
		SNE	V3, LEFTCODE
		ADD	V4, -SPRITEJUMP & MASKBYTE
		LD	V0, V4
		LD	V1, V5
		CALL	SPRITMAZE
		LD	V2, V0
		LD	VE, GRAPHEDGE
		AND	V0, VE
DONEKEY:	SE	V0, 0
		JP	STOPBLINKY
		LD	VE, GRAPHSPEC
		LD	V0, V2
		AND	V2, VE
		SNE	V2, PL
		JP	EATPILL
		SNE	V2, SP
		JP	EATSUPER
		SNE	V2, GW
		JP	GATEWAY
DONEEAT:	CALL	DRAWBLINKY
		LD	VE, ~MASKCODE & MASKBYTE
		AND	V7, VE
		OR	V7, V3
		LD	V8, V4
		LD	V9, V5
		JP	DRAWBLINKY
BLINKYDOWN:	LD	V0, V4
		LD	V1, V5
		ADD	V1, SPRITEJUMP
		CALL	SPRITMAZE
		LD	V2, V0
		LD	VE, GRAPHEDGE
		AND	V0, VE
		SE	V0, 0
		JP	NOKEY
		LD	V3, DOWNCODE
		ADD	V5, SPRITEJUMP
		JP	DONEKEY
BLINKYUP:	LD	V0, V4
		LD	V1, V5
		ADD	V1, -SPRITEJUMP & MASKBYTE
		CALL	SPRITMAZE
		LD	V2, V0
		LD	VE, GRAPHEDGE
		AND	V0, VE
		SE	V0, 0
		JP	NOKEY
		LD	V3, UPCODE
		ADD	V5, -SPRITEJUMP & MASKBYTE
		JP	DONEKEY
BLINKYRIGHT:	LD	V0, V4
		LD	V1, V5
		ADD	V0, SPRITEJUMP
		CALL	SPRITMAZE
		LD	V2, V0
		LD	VE, GRAPHEDGE
		AND	V0, VE
		SE	V0, 0
		JP	NOKEY
		LD	V3, RIGHTCODE
		ADD	V4, SPRITEJUMP
		JP	DONEKEY
BLINKYLEFT:	LD	V0, V4
		LD	V1, V5
		ADD	V0, -SPRITEJUMP & MASKBYTE
		CALL	SPRITMAZE
		LD	V2, V0
		LD	VE, GRAPHEDGE
		AND	V0, VE
		SE	V0, 0
		JP	NOKEY
		LD	V3, LEFTCODE
		ADD	V4, -SPRITEJUMP & MASKBYTE
		JP	DONEKEY
STOPBLINKY:	CALL	DRAWBLINKY
		DRW	V8, V9, SPRITEHIGH
		LD	VE, VF
		RET
EATPILL:	LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		OR	V0, V3
		LD	[I], V0
		LD	I, PILL
		DRW	V4, V5, SPRITEHIGH
		ADD	V6, PILLADD
		LD	V1, PILLTIME
		LD	V0, DT
		SNE	V0, 0
		LD	ST, V1
		JP	DONEEAT
EATSUPER:	LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		OR	V0, V3
		LD	[I], V0
		LD	I, _SUPER
		DRW	V4, V5, SPRITEHIGH
		ADD	V6, SUPERADD
		LD	V0, VA
		LD	V1, VB
		CALL	SPRITMAZE
		LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		SE	V0, 0
		JP	SKIPPACKLETT
		LD	VE, MASKCODE << 2
		XOR	V7, VE
SKIPPACKLETT:	LD	V0, VC
		LD	V1, VD
		CALL	SPRITMAZE
		LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		SE	V0, 0
		JP	SKIPHEWARD
		LD	VE, MASKCODE << 4
		XOR	V7, VE
SKIPHEWARD:	LD	V0, SUPERTIME
		LD	ST, V0
		LD	DT, V0
		JP	DONEEAT
GATEWAY:	SNE	V3, LEFTCODE
		LD	V4, GATERIGHT
		SNE	V3, RIGHTCODE
		LD	V4, GATELEFT
		JP	DONEEAT

;  MOVEPACKLETT
;  ->:	V4:  Force random move if nonzero value
;  <-:	Nothing
;  <>:	V0, V1, V2, V3, V7, VA, VB, VE, VF, I

MOVEPACKLETT:	LD	V2, V7
		LD	V3, V7
		LD	VE, MASKCODE << 2
		AND	V2, VE
		LD	V0, VA
		LD	V1, VB
		CALL	SPRITMAZE
		LD	I, GHOST
		LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		SE	V0, 0
		JP	LOOKPACKLETT
TURNPACKLETT:	DRW	VA, VB, SPRITEHIGH
		SNE	V2, DOWNCODE << 2
		ADD	VB, SPRITEJUMP
		SNE	V2, UPCODE << 2
		ADD	VB, -SPRITEJUMP & MASKBYTE
		SNE	V2, RIGHTCODE << 2
		ADD	VA, SPRITEJUMP
		SNE	V2, LEFTCODE << 2
		ADD	VA, -SPRITEJUMP & MASKBYTE
		DRW	VA, VB, SPRITEHIGH
		RET
LOOKPACKLETT:	LD	VE, MASKHUNT
		LD	V1, DT
		SE	V1, 0
		JP	RANDPACKLETT
		SE	V4, 0
		JP	RANDPACKLETT
		LD	V1, V0
		SHL	V3
		SE	VF, 0
		JP	HORISPACKLETT
		LD	V3, V9
		SUB	V3, VB
		SNE	VF, 0
		JP	PACKLETTLU
		SE	V3, 0
		JP	PACKLETTLD
		XOR	V7, VE
		LD	V3, V8
		SUB	V3, VA
		SNE	VF, 0
		JP	PACKLETTLL
		SE	V3, 0
		JP	PACKLETTLR
		XOR	V7, VE
		JP	RANDPACKLETT
HORISPACKLETT:	LD	V3, V8
		SUB	V3, VA
		SNE	VF, 0
		JP	PACKLETTLL
		SE	V3, 0
		JP	PACKLETTLR
		XOR	V7, VE
		LD	V3, V9
		SUB	V3, VB
		SNE	VF, 0
		JP	PACKLETTLU
		SE	V3, 0
		JP	PACKLETTLD
		XOR	V7, VE
		JP	RANDPACKLETT
PACKLETTLD:	LD	V3, MD
		AND	V1, V3
		SNE	V1, 0
		JP	RANDPACKLETT
		DRW	VA, VB, SPRITEHIGH
		ADD	VB, SPRITEJUMP
		DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		LD	V2, DOWNCODE << 2
		OR	V7, V2
		RET
PACKLETTLU:	LD	V3, MU
		AND	V1, V3
		SNE	V1, 0
		JP	RANDPACKLETT
		DRW	VA, VB, SPRITEHIGH
		ADD	VB, -SPRITEJUMP & MASKBYTE
		DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		LD	V2, UPCODE << 2
		OR	V7, V2
		RET
PACKLETTLR:	LD	V3, MR
		AND	V1, V3
		SNE	V1, 0
		JP	RANDPACKLETT
		DRW	VA, VB, SPRITEHIGH
		ADD	VA, SPRITEJUMP
		DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		LD	V2, RIGHTCODE << 2
		OR	V7, V2
		RET
PACKLETTLL:	LD	V3, ML
		AND	V1, V3
		SNE	V1, 0
		JP	RANDPACKLETT
		DRW	VA, VB, SPRITEHIGH
		ADD	VA, -SPRITEJUMP & MASKBYTE
		DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		LD	V2, LEFTCODE << 2
		OR	V7, V2
		RET
RANDPACKLETT:	RND	V1, ~MASKNIBB & MASKBYTE
		AND	V0, V1
		SE	V0, 0
		JP	SETPACKLETT
PACKLETTERR:	LD	VE, MASKCODE << 2
		XOR	V7, VE
		XOR	V2, VE
		JP	TURNPACKLETT
SETPACKLETT:	DRW	VA, VB, SPRITEHIGH
		SHL	V0
		SNE	VF, 0
		JP	PACKLETTRD
		LD	V2, LEFTCODE << 2
		ADD	VA, -SPRITEJUMP & MASKBYTE
		JP	PACKLETTSET
PACKLETTRD:	SHL	V0
		SNE	VF, 0
		JP	PACKLETTRR
		LD	V2, DOWNCODE << 2
		ADD	VB, SPRITEJUMP
		JP	PACKLETTSET
PACKLETTRR:	SHL	V0
		SNE	VF, 0
		JP	PACKLETTRU
		LD	V2, RIGHTCODE << 2
		ADD	VA, SPRITEJUMP
		JP	PACKLETTSET
PACKLETTRU:	SHL	V0
		SNE	VF, 0
		JP	PACKLETTERR
		LD	V2, UPCODE << 2
		ADD	VB, -SPRITEJUMP & MASKBYTE
PACKLETTSET:	DRW	VA, VB, SPRITEHIGH
		LD	VE, ~( MASKCODE << 2 ) & MASKBYTE
		AND	V7, VE
		OR	V7, V2
		RET

;  MOVEHEWARD
;  ->:	V4:  Force random move if nonzero value
;  <-:	Nothing
;  <>:	V0, V1, V2, V3, V7, VC, VD, VE, VF, I

MOVEHEWARD:	LD	V2, V7
		LD	V3, V7
		LD	VE, MASKCODE << 4
		AND	V2, VE
		LD	V0, VC
		LD	V1, VD
		CALL	SPRITMAZE
		LD	I, GHOST
		LD	VE, ~MASKNIBB & MASKBYTE
		AND	V0, VE
		SE	V0, 0
		JP	LOOKHEWARD
TURNHEWARD:	DRW	VC, VD, SPRITEHIGH
		SNE	V2, DOWNCODE << 4
		ADD	VD, SPRITEJUMP
		SNE	V2, UPCODE << 4
		ADD	VD, -SPRITEJUMP & MASKBYTE
		SNE	V2, RIGHTCODE << 4
		ADD	VC, SPRITEJUMP
		SNE	V2, LEFTCODE << 4
		ADD	VC, -SPRITEJUMP & MASKBYTE
		DRW	VC, VD, SPRITEHIGH
		RET
LOOKHEWARD:	LD	VE, MASKHUNT
		LD	V1, DT
		SE	V1, 0
		JP	RANDHEWARD
		SE	V4, 0
		JP	RANDHEWARD
		LD	V1, V0
		SHL	V3
		SNE	VF, 0
		JP	HORISHEWARD
		LD	V3, V9
		SUB	V3, VD
		SNE	VF, 0
		JP	HEWARDLU
		SE	V3, 0
		JP	HEWARDLD
		XOR	V7, VE
		LD	V3, V8
		SUB	V3, VC
		SNE	VF, 0
		JP	HEWARDLL
		SE	V3, 0
		JP	HEWARDLR
		XOR	V7, VE
		JP	RANDHEWARD
HORISHEWARD:	LD	V3, V8
		SUB	V3, VC
		SNE	VF, 0
		JP	HEWARDLL
		SE	V3, 0
		JP	HEWARDLR
		XOR	V7, VE
		LD	V3, V9
		SUB	V3, VD
		SNE	VF, 0
		JP	HEWARDLU
		SE	V3, 0
		JP	HEWARDLD
		XOR	V7, VE
		JP	RANDHEWARD
HEWARDLD:	LD	V3, MD
		AND	V1, V3
		SNE	V1, 0
		JP	RANDHEWARD
		DRW	VC, VD, SPRITEHIGH
		ADD	VD, SPRITEJUMP
		DRW	VC, VD, SPRITEHIGH
		XOR	V7, VE
		LD	VE, ~( MASKCODE << 4 ) & MASKBYTE
		AND	V7, VE
		LD	V2, DOWNCODE << 4
		OR	V7, V2
		RET
HEWARDLU:	LD	V3, MU
		AND	V1, V3
		SNE	V1, 0
		JP	RANDHEWARD
		DRW	VC, VD, SPRITEHIGH
		ADD	VD, -SPRITEJUMP & MASKBYTE
		DRW	VC, VD, SPRITEHIGH
		XOR	V7, VE
		LD	VE, ~( MASKCODE << 4 ) & MASKBYTE
		AND	V7, VE
		LD	V2, UPCODE << 4
		OR	V7, V2
		RET
HEWARDLR:	LD	V3, MR
		AND	V1, V3
		SNE	V1, 0
		JP	RANDHEWARD
		DRW	VC, VD, SPRITEHIGH
		ADD	VC, SPRITEJUMP
		DRW	VC, VD, SPRITEHIGH
		XOR	V7, VE
		LD	VE, ~( MASKCODE << 4 ) & MASKBYTE
		AND	V7, VE
		LD	V2, RIGHTCODE << 4
		OR	V7, V2
		RET
HEWARDLL:	LD	V3, ML
		AND	V1, V3
		SNE	V1, 0
		JP	RANDHEWARD
		DRW	VC, VD, SPRITEHIGH
		ADD	VC, -SPRITEJUMP & MASKBYTE
		DRW	VC, VD, SPRITEHIGH
		XOR	V7, VE
		LD	VE, ~( MASKCODE << 4 ) & MASKBYTE
		AND	V7, VE
		LD	V2, LEFTCODE << 4
		OR	V7, V2
		RET
RANDHEWARD:	RND	V1, ~MASKNIBB & MASKBYTE
		AND	V0, V1
		SE	V0, 0
		JP	SETHEWARD
HEWARDERR:	XOR	V7, VE
		LD	VE, MASKCODE << 4
		XOR	V7, VE
		XOR	V2, VE
		JP	TURNHEWARD
SETHEWARD:	DRW	VC, VD, SPRITEHIGH
		SHL	V0
		SNE	VF, 0
		JP	HEWARDRD
		LD	V2, (LEFTCODE << 4) | MASKHUNT
		ADD	VC, -SPRITEJUMP & MASKBYTE
		JP	HEWARDSET
HEWARDRD:	SHL	V0
		SNE	VF, 0
		JP	HEWARDRR
		LD	V2, DOWNCODE << 4
		ADD	VD, SPRITEJUMP
		JP	HEWARDSET
HEWARDRR:	SHL	V0
		SNE	VF, 0
		JP	HEWARDRU
		LD	V2, (RIGHTCODE << 4) | MASKHUNT
		ADD	VC, SPRITEJUMP
		JP	HEWARDSET
HEWARDRU:	SHL	V0
		SNE	VF, 0
		JP	HEWARDERR
		LD	V2, UPCODE << 4
		ADD	VD, -SPRITEJUMP & MASKBYTE
HEWARDSET:	DRW	VC, VD, SPRITEHIGH
		LD	VE, ~( (MASKCODE << 4) | MASKHUNT ) & MASKBYTE
		AND	V7, VE
		OR	V7, V2
		RET

;  DRAWBLINKY
;  ->  V7:  Sprite direction register
;  ->  V8:  Blinky X screen coordinate
;  ->  V9:  Blinky Y screen coordinate
;  <-  VE:  Collision flag
;  <-  I:  Blinky sprite pointer
;  <>  V0, V1, VE, VF, I

DRAWBLINKY:	LD	V0, V7
		LD	VE, MASKCODE
		AND	V0, VE
		SHL	V0
		LD	V1, V8
		ADD	V1, V9
		LD	VE, SPRITEJUMP
		AND	V1, VE
		SNE	V1, 0
		ADD	V0, 1
		SHL	V0
		SHL	V0
		IFDEF	SUPER
		SHL	V0
		ENDIF
		LD	I, SPRITES
		ADD	I, V0
		DRW	V8, V9, SPRITEHIGH
		LD	VE, VF
		RET

;  COPYMAZE
;  ->  Nothing
;  <-  Nothing
;  <>  V0, V1, V2, V3, VE, VF, I

COPYMAZE:	LD	VE, 0
COPYLOOP:	LD	I, MAZE
		ADD	I, VE
		ADD	I, VE
		ADD	I, VE
		ADD	I, VE
		LD	V3, [I]
		LD	I, BUFFER
		ADD	I, VE
		ADD	I, VE
		ADD	I, VE
		ADD	I, VE
		LD	[I], V3
		ADD	VE, 1
		SE	VE, (MAZEEND - MAZE) / 4
		JP	COPYLOOP
		RET

;  DRAWMAZE
;  ->  Nothing
;  <-  Nothing
;  <>  V0, V1, V2, V3, VE, VF, I

DRAWMAZE:	XOR	V2, V2
		XOR	V3, V3
		LD	VE, 15
DRAWLOOP:	LD	V0, V2
		LD	V1, V3
		CALL	GRAPHMAZE
		AND	V0, VE
		SHL	V0
		IFDEF	SUPER
		SHL	V0
		ENDIF
		LD	I, GRAPHS
		ADD	I, V0
		DRW	V2, V3, SPRITEJUMP
		ADD	V2, SPRITEJUMP
		SE	V2, SCREENWIDE
		JP	DRAWLOOP
		XOR	V2, V2
		ADD	V3, SPRITEJUMP
		SNE	V3, SCREENHIGH
		RET
		JP	DRAWLOOP

;  SPRITMAZE,  GRAPHMAZE
;  ->  V0:  X coordinate
;  ->  V1:  Y coordinate
;  <-  V0:  Maze data byte
;  <-  I:  Maze data pointer
;  <>  V0, V1, VF, I

SPRITMAZE:	ADD	V0, SPRITEJUMP
		ADD	V1, SPRITEJUMP
GRAPHMAZE:	SHR	V0
		IFDEF	SUPER
		SHR	V0
		ENDIF
		SHR	V1
		IFDEF	SUPER
		SHR	V1
		ENDIF
		SHL	V1
		SHL	V1
		SHL	V1
		SHL	V1
		LD	I, BUFFER
		ADD	I, V1
		ADD	I, V1
		ADD	I, V0
		LD	V0, [I]
		RET

;  NEXTLEVEL
;  ->  Nothing
;  <-  Nothing
;  <>  V0, VF, I

NEXTLEVEL:	LD	I, LEVEL
		LD	V0, [I]
		SHR	V0
		LD	[I], V0
		LD	V0, LEVELKEY
LOOPLEVEL:	SKNP	V0
		JP	LOOPLEVEL
		RET

;  PRINTDEC
;  ->  V6:  Print X coordinate
;  ->  V7:  Print Y coordinate
;  ->  I:  16 bit value pointer
;  <-  Nothing
;  <>  V0, V1, V2, V3, V4, V5, V6, V7, VE, VF, I

PRINTDEC:	LD	V1, [I]
		LD	VE, 1
		XOR	V4, V4
		LD	V2, V0
		LD	V3, V1
LOOPTENG:	LD	V5, 10000 % 256
		SUB	V3, V5
		SNE	VF, 0
		SUB	V2, VE
		SNE	VF, 0
		JP	SKIPTENG
		LD	V5, 10000 / 256
		SUB	V2, V5
		SNE	VF, 0
		JP	SKIPTENG
		LD	V0, V2
		LD	V1, V3
		ADD	V4, VE
		JP	LOOPTENG
SKIPTENG:	IFDEF	SUPER
		xhex	V4
		DRW	V6, V7, 10
		ELSE
		hex	V4
		DRW	V6, V7, 5
		ENDIF
		ADD	V6, SPRITEWIDE - SPRITEJUMP
		XOR	V4, V4
		LD	V2, V0
		LD	V3, V1
LOOPTHOUS:	LD	V5, 1000 % 256
		SUB	V3, V5
		SNE	VF, 0
		SUB	V2, VE
		SNE	VF, 0
		JP	SKIPTHOUS
		LD	V5, 1000 / 256
		SUB	V2, V5
		SNE	VF, 0
		JP	SKIPTHOUS
		LD	V0, V2
		LD	V1, V3
		ADD	V4, VE
		JP	LOOPTHOUS
SKIPTHOUS:	IFDEF	SUPER
		LD	HF, V4
		DRW	V6, V7, 10
		ELSE
		LD	F, V4
		DRW	V6, V7, 5
		ENDIF
		ADD	V6, SPRITEWIDE - SPRITEJUMP
		XOR	V4, V4
		LD	V2, V0
		LD	V3, V1
LOOPHUNDR:	LD	V5, 100
		SUB	V3, V5
		SNE	VF, 0
		SUB	V2, VE
		SNE	VF, 0
		JP	SKIPHUNDR
		LD	V0, V2
		LD	V1, V3
		ADD	V4, VE
		JP	LOOPHUNDR
SKIPHUNDR:	IFDEF	SUPER
		LD	HF, V4
		DRW	V6, V7, 10
		ELSE
		LD	F, V4
		DRW	V6, V7, 5
		ENDIF
		ADD	V6, SPRITEWIDE - SPRITEJUMP
		XOR	V4, V4
		LD	V2, V0
		LD	V3, V1
LOOPTEN:	LD	V5, 10
		SUB	V3, V5
		SNE	VF, 0
		JP	SKIPTEN
		LD	V1, V3
		ADD	V4, VE
		JP	LOOPTEN
SKIPTEN:	IFDEF	SUPER
		LD	HF, V4
		DRW	V6, V7, 10
		ELSE
		LD	F, V4
		DRW	V6, V7, 5
		ENDIF
		ADD	V6, SPRITEWIDE - SPRITEJUMP
		IFDEF	SUPER
		LD	HF, V1
		DRW	V6, V7, 10
		ELSE
		LD	F, V1
		DRW	V6, V7, 5
		ENDIF
		RET

;  ADDSCORE
;  ->  VE:  Score count to add
;  <-  Nothing
;  <>  V0, V1, VE, VF, I

ADDSCORE:	LD	I, SCORE
		LD	V1, [I]
		ADD	V1, VE
		SE	VF, 0
		ADD	V0, 1
		LD	I, SCORE
		LD	[I], V1
		RET

;  NEWHIGH
;  ->  Nothing
;  <-  Nothing
;  <>  V0, V1, V2, V3, VE, VF, I

NEWHIGH:	LD	I, SCORE
		LD	V3, [I]
		LD	VE, V0
		SUB	VE, V2
		SNE	VF, 0
		RET
		SE	VE, 0
		JP	STOREHIGH
		LD	VE, V1
		SUB	VE, V3
		SNE	VF, 0
		RET
STOREHIGH:	LD	I, HIGHSCORE
		LD	[I], V1
		RET

;  WAITKEY
;  ->  V0:  Waitcount
;  <-  VE:  Keypressed
;  <>  V0, V1, V2, V3, VE, VF

WAITKEY:	XOR	VE, VE
		LD	V2, PRESSKEY
		LD	V3, -1 & MASKBYTE
		LD	V1, 16
LOOPKEY:	SKNP	V2
		JP	HITKEY
		ADD	V1, V3
		SE	V1, 0
		JP	LOOPKEY
		LD	V1, 16
		ADD	V0, V3
		SE	V0, 0
		JP	LOOPKEY
		RET
HITKEY:		LD	VE, 1
		RET

SCORE:		DW	0
HIGHSCORE:	DW	0

LEVEL:		DB	STARTLEVEL

		ALIGN	OFF
		USED	ON

SPRITES		=	.

		IFDEF	SUPER

UP:		DB	$........
		DB	$..1...1.
		DB	$.11...11
		DB	$.11...11
		DB	$.111.111
		DB	$.1111111
		DB	$..11111.
		DB	$...111..

		DB	$........
		DB	$...111..
		DB	$...1111.
		DB	$.1.111.1
		DB	$.1.111.1
		DB	$.11.1111
		DB	$..11111.
		DB	$...111..

LEFT:		DB	$........
		DB	$..1111..
		DB	$.111111.
		DB	$....1111
		DB	$.....111
		DB	$....1111
		DB	$.111111.
		DB	$..1111..

		DB	$........
		DB	$...111..
		DB	$..1..11.
		DB	$.1111111
		DB	$.1111111
		DB	$.1111.11
		DB	$.....11.
		DB	$...111..

RIGHT:		DB	$........
		DB	$...1111.
		DB	$..111111
		DB	$.1111...
		DB	$.111....
		DB	$.1111...
		DB	$..111111
		DB	$...1111.

		DB	$........
		DB	$...111..
		DB	$..11..1.
		DB	$.1111111
		DB	$.1111111
		DB	$.11.1111
		DB	$..11....
		DB	$...111..

DOWN:		DB	$........
		DB	$...111..
		DB	$..11111.
		DB	$.1111111
		DB	$.111.111
		DB	$.11...11
		DB	$.11...11
		DB	$..1...1.

		DB	$........
		DB	$...111..
		DB	$..11111.
		DB	$.11.1111
		DB	$.1.111.1
		DB	$.1.111.1
		DB	$...1111.
		DB	$...111..

GHOST:		DB	$........
		DB	$...111..
		DB	$..11111.
		DB	$.1..1..1
		DB	$.111.111
		DB	$.1111111
		DB	$.11...11
		DB	$.1111111

PILL:		DB	$........
		DB	$........
		DB	$........
		DB	$........
		DB	$....1...
		DB	$........
		DB	$........
		DB	$........

		_SUPER: DB	  $........
		DB	$........
		DB	$........
		DB	$........
		DB	$....1...
		DB	$....1...
		DB	$........
		DB	$........

		ELSE

UP:		DB	$........
		DB	$.1.1....
		DB	$.111....
		DB	$..1.....

		DB	$........
		DB	$.1.1....
		DB	$.111....
		DB	$..1.....

LEFT:		DB	$........
		DB	$.11.....
		DB	$..11....
		DB	$.11.....

		DB	$........
		DB	$.11.....
		DB	$..11....
		DB	$.11.....

RIGHT:		DB	$........
		DB	$..11....
		DB	$.11.....
		DB	$..11....

		DB	$........
		DB	$..11....
		DB	$.11.....
		DB	$..11....

DOWN:		DB	$........
		DB	$..1.....
		DB	$.111....
		DB	$.1.1....

		DB	$........
		DB	$..1.....
		DB	$.111....
		DB	$.1.1....

GHOST:		DB	$........
		DB	$..1.....
		DB	$.111....
		DB	$.111....

PILL:		DB	$........
		DB	$........
		DB	$..1.....
		DB	$........

		_SUPER: DB	  $........
		DB	$........
		DB	$........
		DB	$........

		ENDIF

GRAPHS		=	.

;  $0000  Trail up
;  $0001  Trail left
;  $0010  Trail right
;  $0011  Trail down
;  $0100  Empty space
;  $0101  Ordinary pill
;  $0110  Super pill
;  $0111  Gateway
;  $1000  Horisontal egde
;  $1001  Invisible horisontal edge
;  $1010  Vertical edge
;  $1011  Invisible vertical edge
;  $1100  Upper left corner
;  $1101  Upper right corner
;  $1110  Lower left corner
;  $1111  Lower right corner

GRAPHEDGE	=	$1000
GRAPHSPEC	=	$0111
ES		=	$0100
PL		=	$0101
SP		=	$0110
GW		=	$0111
LR		=	$1000
ILR		=	$1001
UD		=	$1010
IUD		=	$1011
UL		=	$1100
UR		=	$1101
DL		=	$1110
DR		=	$1111
MU		=	$00010000
MR		=	$00100000
MUR		=	$00110000
MD		=	$01000000
MDU		=	$01010000
MDR		=	$01100000
MDUR		=	$01110000
ML		=	$10000000
MUL		=	$10010000
MRL		=	$10100000
MURL		=	$10110000
MDL		=	$11000000
MDUL		=	$11010000
MDRL		=	$11100000
MDURL		=	$11110000

		IFDEF	SUPER

		DB	$........
		DB	$........
		DB	$........
		DB	$........

		DB	$........
		DB	$........
		DB	$........
		DB	$........

		DB	$........
		DB	$........
		DB	$........
		DB	$........

		DB	$........
		DB	$........
		DB	$........
		DB	$........

EMPTY:		DB	$........
		DB	$........
		DB	$........
		DB	$........

PILLGR:		DB	$1.......
		DB	$........
		DB	$........
		DB	$........

SUPERGR:	DB	$1.......
		DB	$1.......
		DB	$........
		DB	$........

GATEGR:		DB	$........
		DB	$........
		DB	$........
		DB	$........

HORIS:		DB	$1111....
		DB	$........
		DB	$........
		DB	$........

INVHORIS:	DB	$........
		DB	$........
		DB	$........
		DB	$........

VERT:		DB	$1.......
		DB	$1.......
		DB	$1.......
		DB	$1.......

INVVERT:	DB	$........
		DB	$........
		DB	$........
		DB	$........

UPLEFT:		DB	$1111....
		DB	$1.......
		DB	$1.......
		DB	$1.......

UPRIGHT:	DB	$1.......
		DB	$1.......
		DB	$1.......
		DB	$1.......

DOWNLEFT:	DB	$1111....
		DB	$........
		DB	$........
		DB	$........

DOWNRIGHT:	DB	$1.......
		DB	$........
		DB	$........
		DB	$........

		ELSE

		DB	$........
		DB	$........

		DB	$........
		DB	$........

		DB	$........
		DB	$........

		DB	$........
		DB	$........

EMPTY:		DB	$........
		DB	$........

PILLGR:		DB	$1.......
		DB	$........

SUPERGR:	DB	$........
		DB	$........

GATEGR:		DB	$........
		DB	$........

HORIS:		DB	$11......
		DB	$........

INVHORIS:	DB	$........
		DB	$........

VERT:		DB	$1.......
		DB	$1.......

INVVERT:	DB	$........
		DB	$........

UPLEFT:		DB	$11......
		DB	$1.......

UPRIGHT:	DB	$1.......
		DB	$1.......

DOWNLEFT:	DB	$11......
		DB	$........

DOWNRIGHT:	DB	$1.......
		DB	$........

		ENDIF

MAZE		=	.

;  ##################################################################
;  #------------------------------- ------------------------------- #
;  #|				  | |			      O	  | #
;  #| ? . . . . ? . . ? . . . . ? | | ? . . . . ? . . ? . . .OOO? | #
;  #|				  | |			     OOO  | #
;  #| . ------- . --- . ------- . --- . ------- . --- . ------- . | #
;  #|	|	  | |	      |		|	  | |	      |	  | #
;  #| . | ? x . ? | | ? . . ? | ? . . ? | ? . . ? | | ? . x ? | . | #
;  #|	|	  | |	      |		|	  | |	      |	  | #
;  #| . | . --------------- . ----------- . --------------- . | . | #
;  #|		      |				|		  | #
;  #| ? . ? . . . . ? | ? . ? . ? . . ? . ? . ? | ? . . . . ? . ? | #
;  #|		      |				|		  | #
;  #| . ----------- . | . ----- . --- . ----- . | . ----------- . | #
;  #|	|	  |	  |	O	    |	    |	      |	  | #
;  #| . | ? . . ? | ? ? ? | ? .O?O. . ? . ? | ? ? ? | ? . . ? | . | #
;  #		  |	  |    O O	    |	    |		    #
;  #+ ? . ? --- . --- . --- . ----------- . --- . --- . --- ? . ? + #
;  #			      |		|			    #
;  #| . | ? . . ? . . ? . . ? ----- ----- ? . . ? . . ? . . ? | . | #
;  #|	|			  | |			      |	  | #
;  #| . ------- . --------- ? . ? | | ? . ? --------- . ------- . | #
;  #|	      |	  |	  |	  | |	    |	    |	|	  | #
;  #| ? . x ? | . ------------- . --- . ------------- . | ? x . ? | #
;  #|	      |						|	  | #
;  #| . --- . | ? . . . . ? . . ? . . ? . . ? . . . . ? | . --- . | #
;  #|	| |   |						|   | |	  | #
;  #| . --- . ----------- . --- . --- . --- . ----------- . --- . | #
;  #|	O		    | |		| |			  | #
;  #| ?OOO. ? . . . . . . ? | | ? . . ? | | ? . . . . . . ? . . ? | #
;  #|  OOO		    | |		| |			  | #
;  #------------------------- ----------- ------------------------- #
;  #								    #
;  ##################################################################

		DB	UL, LR, LR, LR, LR, LR, LR, LR
		DB	LR, LR, LR, LR, LR, LR, LR, UR
		DB	UL, LR, LR, LR, LR, LR, LR, LR
		DB	LR, LR, LR, LR, LR, LR, LR, UR

		DB	UD, MDR | PL, PL, PL, PL, PL, MDRL | PL, PL
		DB	PL, MDRL | PL, PL, PL, PL, PL, MDL | PL, UD
		DB	UD, MDR | PL, PL, PL, PL, PL, MDRL | PL, PL
		DB	PL, MDRL | PL, PL, PL, PL, PL, MDL | PL, UD

		DB	UD, PL, UL, LR, LR, DR, PL, UL
		DB	UR, PL, LR, LR, LR, UR, PL, DL
		DB	DR, PL, UL, LR, LR, DR, PL, UL
		DB	UR, PL, LR, LR, LR, UR, PL, UD

		DB	UD, PL, UD, MDR | PL, SP, PL, MUL | PL, UD
		DB	UD, MUR | PL, PL, PL, MDL | PL, UD
		DB	MUR | PL, PL, PL, MUL | PL
		DB	UD, MDR | PL, PL, PL, MUL | PL, UD
		DB	UD, MUR | PL, PL, SP, MDL | PL, UD, PL, UD

		DB	UD, PL, DR, PL, LR, LR, LR, LR
		DB	LR, UL, LR, DR, PL, LR, LR, LR
		DB	LR, LR, DR, PL, LR, LR, UL, LR
		DB	LR, LR, LR, DR, PL, DR, PL, UD

		DB	UD, MDUR | PL, PL, MURL | PL, PL, PL, PL, PL
		DB	MDL | PL, UD, MDR | PL, PL, MURL | PL, PL
		DB	MDRL | PL, PL, PL, MDRL | PL
		DB	PL, MURL | PL, PL, MDL | PL, UD, MDR | PL
		DB	PL, PL, PL, PL, MURL | PL, PL, MDUL | PL, UD

		DB	UD, PL, UL, LR, LR, LR, LR, UR
		DB	PL, DR, PL, UL, LR, DR, PL, LR
		DB	DR, PL, LR, LR, UR, PL, DR, PL
		DB	UL, LR, LR, LR, LR, UR, PL, UD

		DB	DR, PL, DR, MDR | PL, PL, PL, MDL | PL, UD
		DB	MUR | PL, MDRL | PL, MUL | PL, UD, MDR | PL
		DB	PL, MURL, PL, PL, MURL | PL, PL
		DB	MDL | PL, UD, MUR | PL, MDRL | PL, MUL | PL
		DB	UD, MDR | PL, PL, PL, MDL | PL, DR, PL, DR

		DB	GW, MDUR | ES, PL, MDUL | PL, LR, DR, PL, DL
		DB	DR, PL, LR, DR, PL, UL, LR, LR
		DB	LR, LR, UR, PL, LR, DR, PL, LR
		DB	DR, PL, LR, DR, MDUR | PL, PL, MDUL | ES, GW

		DB	UD, PL, UD, MUR | PL, PL, PL, MDURL | PL, PL
		DB	PL, MURL | PL, PL, PL, MDUL | PL, LR, LR, UR
		DB	UL, LR, DR, MDUR | PL, PL, PL, MURL | PL, PL
		DB	PL, MDURL | PL, PL, PL, MUL | PL, UD, PL, UD

		DB	UD, PL, LR, LR, LR, UR, PL, UL
		DB	LR, LR, LR, UR, MUR | PL, PL, MDL | PL, UD
		DB	UD, MDR | PL, PL, MUL | PL, UL, LR, LR, LR
		DB	UR, PL, UL, LR, LR, DR, PL, UD

		DB	UD, MDUR | PL, PL, SP, MDL | PL, UD, PL, LR
		DB	LR, LR, LR, LR, LR, DR, PL, LR
		DB	DR, PL, LR, LR, LR, LR, LR, LR
		DB	DR, PL, UD, MDR | PL, SP, PL, MDUL | PL, UD

		DB	UD, PL, UL, UR, PL, UD, MUR | PL, PL
		DB	PL, PL, PL, MDRL | PL, PL, PL, MDURL | PL, PL
		DB	PL, MDURL | PL, PL, PL, MDRL | PL, PL, PL, PL
		DB	PL, MUL | PL, UD, PL, UL, UR, PL, UD

		DB	UD, PL, LR, DR, PL, LR, LR, LR
		DB	LR, LR, DR, PL, UL, UR, PL, LR
		DB	DR, PL, UL, UR, PL, LR, LR, LR
		DB	LR, LR, DR, PL, LR, DR, PL, UD

		DB	UD, MUR | PL, PL, PL, MURL | PL, PL, PL, PL
		DB	PL, PL, PL, MUL | PL, UD, UD, MUR | PL, PL
		DB	PL, MUL | PL, UD, UD, MUR | PL, PL, PL, PL
		DB	PL, PL, PL, MURL | PL, PL, PL, MUL | PL, UD

		DB	LR, LR, LR, LR, LR, LR, LR, LR
		DB	LR, LR, LR, LR, DR, LR, LR, LR
		DB	LR, LR, DR, LR, LR, LR, LR, LR
		DB	LR, LR, LR, LR, LR, LR, LR, DR

MAZEEND:

		.align
EYES:

		IFDEF	SUPER

EYELEFT:	DW	$.......1111.....
		DW	$......1....1....
		DW	$.....1..11..1...
		DW	$....1..1111..1..
		DW	$....1.111111.1..
		DW	$....1.111.11.1..
		DW	$....1..1111..1.1
		DW	$.....1..11..1..1
		DW	$......1....1..11
		DW	$.......1111..111
		DW	$.............111
		DW	$.......11.....11
		DW	$......111111....
		DW	$.......111111111
		DW	$........11111111
		DW	$..........111111

EYERIGHT:	DW	$....1111........
		DW	$...1....1.......
		DW	$..1..11..1......
		DW	$.1..1111..1.....
		DW	$.1.111111.1.....
		DW	$.1.111.11.1.....
		DW	$.1..1111..1.....
		DW	$..1..11..1......
		DW	$1..1....1.......
		DW	$11..1111........
		DW	$11..............
		DW	$1.....11........
		DW	$...111111.......
		DW	$11111111........
		DW	$1111111.........
		DW	$11111...........

EYEBLINK:	DW	$....1111........
		DW	$...111111.......
		DW	$..11111111......
		DW	$.1111111111.....
		DW	$.1111111111.....
		DW	$.1.11111111.....
		DW	$.1...111111.....
		DW	$..1.....11......
		DW	$1..1....1.......
		DW	$11..1111........
		DW	$11......1.......
		DW	$1.....1111......
		DW	$...111111.......
		DW	$11111111........
		DW	$1111111.........
		DW	$11111...........

		ELSE

EYELEFT:	DB	$..1111..
		DB	$.1....1.
		DB	$1..11..1
		DB	$1..11..1
		DB	$.1....1.
		DB	$..1111..
		DB	$.......1
		DB	$...1....
		DB	$....1111

EYERIGHT:	DB	$.1111...
		DB	$1....1..
		DB	$..11..1.
		DB	$..11..1.
		DB	$1....1..
		DB	$.1111...
		DB	$........
		DB	$...1....
		DB	$111.....

EYEBLINK:	DB	$.1111...
		DB	$111111..
		DB	$1111111.
		DB	$1111111.
		DB	$1....1..
		DB	$.1111...
		DB	$........
		DB	$...1....
		DB	$111.....

		ENDIF

		USED	OFF
		ALIGN	ON

BUFFER		=	.
