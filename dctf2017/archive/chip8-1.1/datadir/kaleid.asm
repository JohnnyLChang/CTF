;
;	chip8 - X11 Chip8 interpreter
;	Copyright (C) 1998, 2012 Peter Miller
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
	.title	"kaleid version 1.0",
		"Copyright (C) 1991 David Winter"
	.xref	on
	jump	L1
;
	.byte	10
	.ascii	"Kaleid version 1.0"
	.byte	10
	.ascii	"Copyright (C) 1991 David Winter"
	.byte	10
	.align
L1:
	load	v0, 0
	load	v3, 128
	load	v1, 31
	load	v2, 15
L2:
	call	L5
	load	i, L1
	add	i, v3
	load	v0, key
	save	v0
	skip.ne	v0, 0
	jump	L3
	add	v3, 1
	skip.eq	v3, 0
	jump	L2
L3:
	load	v3, 128
L4:
	load	i, L1
	add	i, v3
	restore	v0
	skip.ne	v0, 0
	jump	L3
	add	v3, 1
	skip.ne	v3, 0
	jump	L3
	call	L5
	jump	L4
L5:
	skip.ne	v0, 2
	add	v2, 255
	skip.ne	v0, 4
	add	v1, 255
	skip.ne	v0, 6
	add	v1, 1
	skip.ne	v0, 8
	add	v2, 1
	load	i, L6
	load	vA, 224
	and	vA, v1
	load	vB, 31
	and	v1, vB
	skip.eq	vA, 0
	add	v2, 1
	load	vA, 240
	and	vA, v2
	load	vB, 15
	and	v2, vB
	skip.eq	vA, 0
	add	v1, 1
	load	vB, 31
	and	v1, vB
	draw	v1, v2, 1
	load	vA, v1
	load	vB, 31
	sub	vB, v2
	draw	vA, vB, 1
	load	vA, 63
	sub	vA, v1
	draw	vA, vB, 1
	load	vB, v2
	draw	vA, vB, 1
	ret
L6:
	.pic	"*"
