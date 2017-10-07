#!/bin/sh
#
# chip8 - X11 Chip8 interpreter
# Copyright (C) 1998, 2012 Peter Miller
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

TEST_SUBJECT="scleft opcode"
. test_prelude

#
# test the scleft opcode
#
cat > test.asm << 'fubar'
        load    i, L1
        load    v0, 7
        load    v1, 1
        draw    v0, v1, 1
        scleft
        load    v0, 3
        draw    v0, v1, 1
        skip.ne vF, 1
        exit    0
        exit    1
L1:
        .byte   0x80
fubar
if test $? -ne 0 ; then fail; fi

cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   A214         1            load    i, L1
202   6007         2            load    v0, 7
204   6101         3            load    v1, 1
206   D011         4            draw    v0, v1, 1
208   00FC         5            scleft
20A   6003         6            load    v0, 3
20C   D011         7            draw    v0, v1, 1
20E   4F01         8            skip.ne vF, 1
210   0010         9            exit    0
212   0011         10           exit    1
214                11   L1:
214   80           12           .byte   0x80
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
