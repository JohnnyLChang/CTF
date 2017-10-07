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

TEST_SUBJECT="asc format"
. test_prelude

#
# test the asc format
#
cat > first.chp << 'fubar'
%%HP: T(3)A(R)F(.);
"C2A209000000013E05"
fubar
if test $? -ne 0 ; then no_result; fi

cat > first.asm << 'fubar'
        exit    0
fubar
if test $? -ne 0 ; then no_result; fi

chip8dis first.chp second.asm
if test $? -ne 0 ; then fail; fi

cat > first.asm << 'fubar'
        exit    0
fubar
if test $? -ne 0 ; then no_result; fi

diff -b first.asm second.asm
if test $? -ne 0 ; then fail; fi

chip8as second.asm second.chp -asc
if test $? -ne 0 ; then fail; fi

diff -b first.chp second.chp
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
