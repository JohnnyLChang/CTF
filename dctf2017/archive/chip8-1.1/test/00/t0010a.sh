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

TEST_SUBJECT="sub borrow"
. test_prelude

#
# test the sub borrow
#
cat > test.asm << 'fubar'

load v1, 1
load v2, 2
sub v1, v2
skip.eq vF, 1
exit 1
skip.eq v1, 0xFF
exit 1

load v1, 7
load v2, 7
sub v1, v2
skip.eq vF, 0
exit 1
skip.eq v1, 0
exit 1

load v1, 7
load v2, 2
sub v1, v2
skip.eq vF, 0
exit 1
skip.eq v1, 5
exit 1

exit 0
fubar
if test $? -ne 0 ; then no_result; fi

chip8as test.asm test.chp -l test.lst
if test $? -ne 0 ; then fail; fi

chip8run -at -tm -f test.chp
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
