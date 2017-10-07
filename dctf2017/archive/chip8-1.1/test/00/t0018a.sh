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

TEST_SUBJECT="exit opcode"
. test_prelude

#
# test the exit opcode
#
cat > test.asm << 'fubar'
        exit
        .ascii  "Copyright (C) 1812 Tchaikovsky"
fubar
if test $? -ne 0 ; then no_result; fi

cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   00FD         1            exit
202   43 6F 70 79  2            .ascii  "Copyright (C) 1812 Tchaikovsky"
      72 69 67 68
      74 20 28 43
      29 20 31 38
      31 32 20 54
      63 68 61 69
      6B 6F 76 73
      6B 79
fubar
if test $? -ne 0 ; then no_result; fi

chip8as test.asm test.chp -l test.lst
if test $? -ne 0 ; then fail; fi

sed '1,6d' < test.lst > test.lst2
if test $? -ne 0 ; then no_result; fi

diff -b test.ok test.lst2
if test $? -ne 0 ; then fail; fi

chip8dis test.chp disout
if test $? -ne 0 ; then fail; fi

diff -b test.asm disout
if test $? -ne 0 ; then fail; fi

chip8run -at -tm -f test.chp
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
