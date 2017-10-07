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

TEST_SUBJECT="high+low opcodes"
. test_prelude

#
# test the high+low opcodes
#
cat > test.asm << 'fubar'
low
high
fubar
if test $? -ne 0 ; then no_result; fi
cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   00FE         1    low
202   00FF         2    high
fubar
if test $? -ne 0 ; then no_result; fi

chip8as test.asm test.chp -l test.list
if test $? -ne 0 ; then fail; fi

sed '1,6d' < test.list > test.lst2
if test $? -ne 0 ; then no_result; fi

diff -b test.ok test.lst2
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
