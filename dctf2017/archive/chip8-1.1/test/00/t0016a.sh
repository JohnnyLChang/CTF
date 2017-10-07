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

TEST_SUBJECT="xhex opcode"
. test_prelude

#
# test the xhex opcode
#
cat > test.asm << 'fubar'
        load    v8, 0
        xhex    v8
        load    v0, 0
        load    v1, 0
        draw    v0, v1, 10
        exit    0
fubar
if test $? -ne 0 ; then fail; fi

cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   6800         1            load    v8, 0
202   F830         2            xhex    v8
204   6000         3            load    v0, 0
206   6100         4            load    v1, 0
208   D01A         5            draw    v0, v1, 10
20A   0010         6            exit    0
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
