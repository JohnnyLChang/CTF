#!/bin/sh
#
# chip8 - X11 Chip8 interpreter
# Copyright (C) 1990, 1998, 2012 Peter Miller
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

TEST_SUBJECT="jump opcodes"
. test_prelude

testit()
{
    # make sure the assembler understands it
    chip8as tmpA tmpB
    if [ "$?" != "0" ]; then fail; fi

    # make sure the disassembler understands it
    chip8dis tmpB tmpC
    if [ "$?" != "0" ]; then fail; fi
    chip8as tmpC tmpD
    if [ "$?" != "0" ]; then fail; fi

    # make sure the two binaries are the same
    cmp tmpB tmpD
    if [ "$?" != "0" ]; then fail; fi

    # make sure we know how to interpret it
    chip8run -at -tm -f tmpD
    if [ "$?" != "0" ]; then fail; fi
}

#
# test the
#       jump NNN
# opcode
#
cat > tmpA << 'end'
     jump    lbl
     exit    1
lbl: exit    0
end
if test $? -ne 0; then no_result; fi

testit

#
# test the
#       jump NNN, v0
# opcode
#
cat > tmpA << 'end'
      load    v0, lbl2 - lbl
      jump    lbl, v0
      exit    1
lbl:  exit    1
      exit    1
lbl2: exit    0
      exit    1
end
if test $? -ne 0; then no_result; fi

testit

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
