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

TEST_SUBJECT="conditional assembly functionality"
. test_prelude

#
# test the conditional assembly functionality
#
cat > test.asm << 'fubar'
ld v1, 1
ifdef fred
 ld v2, 2
endif
ld v3, 3
ifndef fred
 ld v4, 4
endif
ld v5, 5

define nurk

ifdef fred
 ifdef nurk
  ld v6, 6
 else
  ld v7, 7
 endif
else
 ifdef nurk
  ld v8, 8
 else
  ld v9, 9
 endif
endif

ld v10, 10
exit 0
fubar
if test $? -ne 0 ; then no_result; fi

cat > test.ok << 'fubar'
Addr  Opcodes      Line Source Text
----- ---------    ---- --------------
200   6101         1    ld v1, 1
                   2    ifdef fred
                   3     ld v2, 2
                   4    endif
202   6303         5    ld v3, 3
                   6    ifndef fred
204   6404         7     ld v4, 4
                   8    endif
206   6505         9    ld v5, 5
                   10
                   11   define nurk
                   12
                   13   ifdef fred
                   14    ifdef nurk
                   15     ld v6, 6
                   16    else
                   17     ld v7, 7
                   18    endif
                   19   else
                   20    ifdef nurk
208   6808         21     ld v8, 8
                   22    else
                   23     ld v9, 9
                   24    endif
                   25   endif
                   26
20A   6A0A         27   ld v10, 10
20C   0010         28   exit 0
fubar
if test $? -ne 0 ; then no_result; fi

chip8as -l test.lst  test.asm test.chp
if test $? -ne 0 ; then fail; fi

sed '1,6d' < test.lst > test.list
if test $? -ne 0 ; then no_result; fi

diff -b test.ok test.list
if test $? -ne 0 ; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
