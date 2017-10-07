#!/bin/sh
#
#       chip8 - X11 Chip8 interpreter
#       Copyright (C) 1998, 2012 Peter Miller
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program. If not, see
#       <http://www.gnu.org/licenses/>.
#

TEST_SUBJECT="xdraw opcode"
. test_prelude

#
# test the xdraw opcode
#
cat > test.asm << 'fubar'
        load    i, L1
        load    v0, 0
        load    v1, 0
        xdraw   v0, v1
        load    i, L2
        draw    v0, v1, 3
        skip.ne vF, 1
        exit    0
        exit    1
L1:
        .byte   0x40
        .byte   0x00
        .byte   0x20
        .byte   0x00
        .byte   0xE0
        .ds     0x1B
L2:
        .pic    " *      ",
                "  *     ",
                "***     "
fubar
if test $? -ne 0 ; then fail; fi

cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   A212         1            load    i, L1
202   6000         2            load    v0, 0
204   6100         3            load    v1, 0
206   D010         4            xdraw   v0, v1
208   A232         5            load    i, L2
20A   D013         6            draw    v0, v1, 3
20C   4F01         7            skip.ne vF, 1
20E   0010         8            exit    0
210   0011         9            exit    1
212                10   L1:
212   40           11           .byte   0x40
213   00           12           .byte   0x00
214   20           13           .byte   0x20
215   00           14           .byte   0x00
216   E0           15           .byte   0xE0
217   (1B) 00      16           .ds     0x1B
232                17   L2:
232   40 20 E0     18           .pic    " *      ",
                   19                   "  *     ",
                   20                   "***     "
fubar
if test $? -ne 0 ; then fail; fi

chip8as test.asm test.chp -l test.lst
if test $? -ne 0 ; then fail; fi

sed '1,6d' < test.lst > test.lst2
if test $? -ne 0 ; then no_result; fi

diff -b test.ok test.lst2
if test $? -ne 0 ; then fail; fi

chip8dis test.chp > test.out
if test $? -ne 0 ; then fail; fi

diff -b test.asm test.out
if test $? -ne 0 ; then fail; fi

chip8run -at -tm -f test.chp
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
