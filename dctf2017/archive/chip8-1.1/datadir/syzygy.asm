;
;	SYZYGY is (c) copyright 1990 by Roy Trevino (RTT)
;
;	Noncommercial distribution allowed, provided that this
;	copyright message is preserved, and any modified versions
;	are clearly marked as such.
;
;	SYZYGY, via CHIP-48, makes use of undocumented low-level features
;	of the HP48SX calculator, and may or may not cause loss of data,
;	excessive battery drainage, and/or damage to the calculator
;	hardware.  The Author takes no responsibility whatsoever for
;	any damage caused by the use of this program.
;
;	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
;	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;	PURPOSE.
;
; Minor changes 1998 Peter Miller
; to make it compaitible with my assembler.
;
		.title	"Syzygy version 0.1",
			"Copyright (C) 1990 Roy Trevino"
		.xref	on
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  Register usage (primary usage, may be others):
;
;    v0 - scratch
;    v1 - x position of head
;    v2 - y position of head
;    v3 - current direction of head
;    v4 - pointer to segment table entry for head
;    v5 - previous direction of head
;    v6 - x position of tail
;    v7 - y position of tail
;    v8 - direction of tail
;    v9 - pointer to segment table entry for tail
;    va - count of points being added to length
;    vb - x position of target
;    vc - y position of target
;    vd - flags if target is on or off
;    ve - random on time for target
;    vf - carry/borrow/collision detect
;
up		equ	#3		; (9) key for up
down		equ	#6		; (6) key for down
left		equ	#7		; (1) key for left
right		equ	#8		; (2) key for right

		jp	start
copyright:				; copyright notice
		.byte	10
		.ascii	"Syzygy version 0.1"
		.byte	10
		.ascii	"Copyright (C) 1990 Roy Trevino"
		.byte	10
		.align
start:
		call	drawbord
		call	drawtitle
waitkp1:
		ld	v0, #f		; wait for (+) (keep border)
		sknp	v0
		jp	starty
		ld	v0, #e		; wait for (-) (borderless)
		sknp	v0
		jp	startn
		jp	waitkp1
starty:
		call	drawtitle	; erase title (keep border)
		jp	initgame
startn:
		cls			; erase everything (borderless)
		jp	initgame
;
;  initialization routines
;
initgame:
;
;  initial head position near middle of screen
;
		rnd	v1, #1f		; x-pos = rnd(16, 47)
		add	v1, #10
		rnd	v2, #f		; y-pos = rnd(8, 23)
		add	v2, #8
		rnd	v3, #3		; direction = rnd(0, 3)
		ld	v5, v3		; last head direction
;
;  compute initial tail position
;
		ld	v6, v1		; start out same as head
		ld	v7, v2
		ld	v8, v3		; tail direction

		sne	v8, #0		; up
		add	v7, #1
		sne	v8, #1		; down
		add	v7, #ff
		sne	v8, #2		; left
		add	v6, #1
		sne	v8, #3		; right
		add	v6, #ff
;
;  draw initial syzygy, save initial segment to table
;
		ld	i, dot
		drw	v1, v2, #1	; draw head
		drw	v6, v7, #1	; draw tail

		ld	v4, #f0		; init ptr to head vector
		ld	v9, #f1		; init ptr to tail vector
					; Plus one, because it points
					; at the length, not the direction.

		ld	i, base		; save direction
		add	i, v4
		ld	v0, v3
		ld	[i], v0
		add	v4, #1		; increment head ptr
		ld	i, base		; save segment count
		add	i, v4
		ld	v0, #1
		ld	[i], v0

;
;  compute coordinates and value of first target
;    plus set up flag and time until target
;
		call	rndtarg


		ld	va, #0		; additional length

;
; initial addition to syzygy for test purposes
;
		add	va, #0
;
;  main loop begins here
;
loop:

chktarg:
		ld	v0, dt		; check if a target is due
		se	v0, #0
		jp	endtarg
		se	vd, #0
		jp	targoff

		ld	v0, #0		; draw target
		ld	f, v0
		drw	vb, vc, #5

		se	vf, #1		; if on body, erase immediately
		jp	targon
		drw	vb, vc, #5
		call	rndtarg		; set up new target
		ld	dt, v0		; no delay though
		jp	endtarg		; process at least one move

targon:
		ld	dt, ve		; set up on-time
		ld	vd, #1		; set flag to denote on
		ld	ve, #0		; number of points unless hit
		jp	endtarg

targoff:
		ld	v0, ve		; erase old target
		ld	f, v0
		drw	vb, vc, #5

		call	rndtarg		; set up new target
endtarg:


chkkeys:
		ld	v0, up		; check for user input
		sknp	v0
		ld	v3, #0		; new direction

		ld	v0, down
		sknp	v0
		ld	v3, #1

		ld	v0, left
		sknp	v0
		ld	v3, #2

		ld	v0, right
		sknp	v0
		ld	v3, #3
;
;  compute next head position
;
		sne	v3, #0		; up
		add	v2, #ff
		sne	v3, #1		; down
		add	v2, #1
		sne	v3, #2		; left
		add	v1, #ff
		sne	v3, #3		; right
		add	v1, #1
;
;  draw next head position
;
		ld	i, dot
		drw	v1, v2, #1
;
;  check for collision
;
chkcoll:
		se	vf, #1
		jp	chkhead
;
;  if collision is due to target, add points (else die)
;    this also means no doubling back on self
;
		se	vd, #1		; check if target is even on
		jp	endgame

		ld	v0, #3f		; mask off extra x and y bits
		and	v1, v0
		ld	v0, #1f
		and	v2, v0

		ld	v0, vb		; check if < target on left
		subn	v0, v1
		se	vf, #1
		jp	endgame

		ld	v0, vb		; check if > target on right
		add	v0, #3
		sub	v0, v1
		se	vf, #1
		jp	endgame

		ld	v0, vc		; check if < target on top
		subn	v0, v2
		se	vf, #1
		jp	endgame

		ld	v0, vc		; check if > target on bottom
		add	v0, #4
		sub	v0, v2
		se	vf, #1
		jp	endgame
;
;  if made it this far, add points, erase target, etc
;
		ld	v0, #4		; beep (actually, a "bip")
		ld	st, v0

		rnd	ve, #7		; award rnd(2, 9) points
		add	ve, #2		;
		add	va, ve		; add points

		ld	i, dot		; temporarily erase head
		drw	v1, v2, #1
		ld	v0, #0		; erase target
		ld	f, v0
		drw	vb, vc, #5
		ld	v0, ve		; draw points instead
		ld	f, v0
		drw	vb, vc, #5

		ld	v0, #30		; delay for a while
		ld	dt, v0
targwait:
		ld	v0, dt
		se	v0, #0
		jp	targwait

		ld	i, dot
		drw	v1, v2, #1	; redraw head
;
;  if direction changed, create a new segment record
;
chkhead:
		sne	v3, v5
		jp	conthead

		add	v4, #1		; new segment record
		ld	i, base
		add	i, v4
		ld	v0, v3		; save direction
		ld	[i], v0
		add	v4, #1		; point to counter
		ld	i, base		; initialize segment count to 0
		add	i, v4
		ld	v0, #0
		ld	[i], v0

		ld	v5, v3		; reset previous direction

conthead:
		ld	i, base		; simply add to current record
		add	i, v4
		ld	v0, [i]
		add	v0, #1		; increment head count
		ld	i, base
		add	i, v4
		ld	[i], v0
;
;  don't erase tail if adding points to length
;
chkpts:
		sne	va, #0
		jp	contpts		; if pts = 0, continue normally

		ld	v0, #c		; delay just a little to compensate
delhead:
		add	v0, #ff
		se	v0, #0
		jp	delhead

		add	va, #ff		; decrement and loop
		jp	loop

contpts:
;
;  erase last tail position
;
		ld	i, dot
		drw	v6, v7, #1

;
;  compute next tail position
;
		sne	v8, #0		; up
		add	v7, #ff
		sne	v8, #1		; down
		add	v7, #1
		sne	v8, #2		; left
		add	v6, #ff
		sne	v8, #3		; right
		add	v6, #1

chktail:
		ld	i, base		; get tail segment record
		add	i, v9
		ld	v0, [i]
		add	v0, #ff		; decrement tail count
		ld	i, base
		add	i, v9
		ld	[i], v0		; save
		se	v0, #0		; if zero, get new record
		jp	loop

		add	v9, #1		; new segment record
		ld	i, base		; get new direction
		add	i, v9
		ld	v0, [i]
		ld	v8, v0
		add	v9, #1		; point to new count
;
;  end of main loop
;
		jp	loop
;
;  endgame routines
;
endgame:
		ld	v0, #d		; beep
		ld	st, v0

		ld	v0, #b		; wait for (space) keypress
endkp:		skp	v0
		jp	endkp
;
;  finish up tail to count points: digits are in vd:vc:vb format
;  note that it is theoretically possible to get 64*32=2048 points,
;  while three digits will only hold 999.  Unlikely but possible.
;
		ld	vb, #1		; one's digit
		ld	vc, #0		; ten's digit
		ld	vd, #0		; hundred's digit

endtail:
;
;  increment score
;
		add	vb, #1
		se	vb, #a
		jp	endtailcont
		ld	vb, #0
		add	vc, #1
		se	vc, #a
		jp	endtailcont
		ld	vc, #0
		add	vd, #1
;
;  compute next tail position to add up score
;
endtailcont:
		ld	i, dot		; erase last tail position
		drw	v6, v7, #1

		sne	v8, #0		; up
		add	v7, #ff
		sne	v8, #1		; down
		add	v7, #1
		sne	v8, #2		; left
		add	v6, #ff
		sne	v8, #3		; right
		add	v6, #1

		ld	i, base		; get tail segment record
		add	i, v9
		ld	v0, [i]
		add	v0, #ff		; decrement tail count
		ld	[i], v0		; save
		se	v0, #0		; if zero, get new record
		jp	endtail

		sne	v9, v4		; done when pointers are equal
		jp	drawscore

		add	v9, #1		; new segment record
		ld	i, base		; get new direction
		add	i, v9
		ld	v0, [i]
		ld	v8, v0
		add	v9, #1		; point to new count
		jp	endtail
;
;  draw score
;
drawscore:
		cls
		ld	v6, #11		; draw border
		ld	v7, #9
		ld	v8, #2f
		ld	v9, #17
		ld	i, vbar
		drw	v6, v7, #e
		drw	v8, v7, #e
		add	v7, #ff
		ld	i, hbar
		drw	v6, v7, #1
		drw	v6, v9, #1
		add	v6, #8
		drw	v6, v7, #1
		drw	v6, v9, #1
		add	v6, #8
		drw	v6, v7, #1
		drw	v6, v9, #1
		add	v6, #8
		ld	i, hbar2
		drw	v6, v7, #1
		drw	v6, v9, #1

		ld	i, sc		; show score (not high score yet)
		ld	v6, #13
		ld	v7, #11
		call	showscore
;
;  figure out if it's the high score, save it if it is
;
checkhigh:
		ld	i, _high		; recover old high score into v3v2v1
		ld	v3, [i]

		sne	v3, vd		; if =, check next digit
		jp	conthigh1
		ld	v0, v3		; if borrow, it's a new high score!
		sub	v0, vd
		se	vf, #1
		jp	savehigh
		jp	drawhigh
conthigh1:
		sne	v2, vc		; etc. as above for other digits
		jp	conthigh2
		ld	v0, v2
		sub	v0, vc
		se	vf, #1
		jp	savehigh
		jp	drawhigh
conthigh2:
		ld	v0, v1
		sub	v0, vb
		se	vf, #0
		jp	drawhigh

savehigh:
		ld	i, _high
		ld	v3, vd		; save new high score
		ld	v2, vc
		ld	v1, vb
		ld	[i], v3
;
;  draw the high score
;
drawhigh:
		ld	i, _high
		ld	v3, [i]
		ld	v6, #13
		add	v7, #f9
		ld	vd, v3
		ld	vc, v2
		ld	vb, v1
		ld	i, hi
		call	showscore
;
;  random memory wasting stuff goes here
;
waitkp2:

		rnd	v1, #3f		; get random position
		rnd	v2, #1f

		ld	v0, #d		; check left
		sub	v0, v1
		se	vf, #0
		jp	drawrand

		ld	v0, #30		; check right
		subn	v0, v1
		se	vf, #0
		jp	drawrand

		ld	v0, #3		; check top
		sub	v0, v2
		se	vf, #0
		jp	drawrand

		ld	v0, #18		; check bottom
		subn	v0, v2
		se	vf, #0
		jp	drawrand
		jp	chkkp2

drawrand:
		rnd	v3, #0f		; draw random number
		ld	f, v3
		drw	v1, v2, #5

chkkp2:
		ld	v0, #f		; check for keypress
		sknp	v0
		jp	conty
		ld	v0, #e
		sknp	v0
		jp	contn
		jp	waitkp2

conty:		cls
		call	drawbord
		jp	initgame
contn:		cls
		jp	initgame
;
;  function showscore:
;    digits in vd:vc:vb, descriptor in i, initial coords in v6, v7
;
showscore:
		drw	v6, v7, #5
		ld	i, col
		add	v6, #2
		drw	v6, v7, #4
		ld	f, vd
		add	v6, #a
		drw	v6, v7, #5
		ld	f, vc
		add	v6, #5
		drw	v6, v7, #5
		ld	f, vb
		add	v6, #5
		drw	v6, v7, #5

		ret
;
;  function drawbord:
;    draw border, try to do it fast
;
drawbord:
horiz:
		ld	i, hbar
		ld	v1, #0		; left
		ld	v2, #0		; right
		ld	v6, #1f		; lower
horiz1:
		drw	v1, v2, #1	; draw x, 0
		drw	v1, v6, #1	; draw x, 31
		add	v1, #8
		se	v1, #40		; same as 0
		jp	horiz1

vert:
		ld	i, vbar
		ld	v2, #1
		ld	v5, #3f
		drw	v1, v2, #f
		drw	v5, v2, #f
		add	v2, #f
		drw	v1, v2, #f
		drw	v5, v2, #f

		ret
;
;  function drawtitle: draws game title
;
drawtitle:
		ld	v1, #c
		ld	v2, #7
		ld	i, s
		drw	v1, v2, #a
		ld	i, y
		add	v1, #6
		drw	v1, v2, #a
		ld	i, z
		add	v1, #6
		drw	v1, v2, #a
		ld	i, y
		add	v1, #6
		drw	v1, v2, #a
		ld	i, g
		add	v1, #6
		drw	v1, v2, #a
		ld	i, y
		add	v1, #6
		drw	v1, v2, #a

		ld	v1, #e
		ld	v2, #18
		ld	i, v
		drw	v1, v2, #3
		ld	i, vers
		add	v1, #8
		add	v2, #ff
		drw	v1, v2, #4
		add	v1, #9
		add	v2, #fe
		ld	i, _r
		drw	v1, v2, #6
		add	v1, #6
		add	v2, #1
		ld	i, tt
		drw	v1, v2, #5

		ret
;
;  function rndtarg:
;    returns coords as (vb, vc)
;    0 in vd
;    time until target in dt
;    on-time value ve
;
rndtarg:
;
; x-pos = rnd(1, 59)
;
		ld	vd, #c5		; -#3b (-59d)
rndx:		rnd	vb, #3f		; rnd (0, 63)
		ld	ve, vb
		add	ve, vd		; check if > 58
		sne	vf, #1
		jp	rndx		; try again if too big

		add	vb, #1
;
; y-pos = rnd(1, 26)
;

		ld	vd, #e6		; -#1a (-26d)
rndy:		rnd	vc, #1f
		ld	ve, vc
		add	ve, vd
		sne	vf, #1
		jp	rndy

		add	vc, #1

rndf:
		ld	vd, #0		; flag marking new target

rndd:
		rnd	ve, #3f		; random off delay (64 - 127)
		add	ve, #40
		ld	dt, ve
		rnd	ve, #3f		; random on delay (64 - 127)
		add	ve, #40
		ret

dot:		dw	#8000		; dot for syzygy
hbar:		dw	#ff00		; horizontal border segment
hbar2:		dw	#fe00
vbar:		dw	#8080		; vertical border segment
		dw	#8080
		dw	#8080
		dw	#8080
		dw	#8080
		dw	#8080
		dw	#8080
		dw	#8080
;
;  True memory wasting stuff goes here (but why not?)
;
s:		dw	#1f10		; s character
		dw	#1010
		dw	#1f01
		dw	#0101
		dw	#011f
y:		dw	#1111		; y character
		dw	#1111
		dw	#1f04
		dw	#0404
		dw	#0404
z:		dw	#1f01		; z character
		dw	#0202
		dw	#0404
		dw	#0808
		dw	#101f
g:		dw	#1f11		; g character
		dw	#1010
		dw	#1013
		dw	#1111
		dw	#111f
v:		dw	#0505		; v character for version
		dw	#0200
vers:		dw	#7151		; version number characters
		dw	#5175
_r:		dw	#0c12		; R character for signature
		dw	#1e14
		dw	#1209
tt:		dw	#143e		; tt characters for signature
		dw	#1515
		dw	#2a00
sc:		dw	#7744		; sc characters for score
		dw	#2414
		dw	#7700
hi:		dw	#5752		; hi character for high score
		dw	#7252
		dw	#5700
col:		dw	#0001		; : character for scores
		dw	#0001
_high:		dw	#0000		; high score storage
		dw	#0000

;
;  Start of a circular table to track each segment of the syzygy,
;  which consists of a direction and a length.
;
; The segment table has pairs
;	direction in the first byte
;	length in the second byte
;
;  The start of the table is at #800 instead of a label at the bottom
;  of the program (ie. base: end) because it seems to run faster
;  that way.
;
base:					; base of segment table
;		.ds	256
