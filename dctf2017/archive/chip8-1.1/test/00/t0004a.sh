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

TEST_SUBJECT="load opcodes"
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

    # make sure know how to interpret it
    chip8run -at -tm -f tmpD
    if [ "$?" != "0" ]; then fail; fi
}

set -x
#
# test the
#       load vX, NN
# opcode
#
cat > tmpA << 'end'
        load    v0, 0
        skip.eq v0, 0
        exit    1

        load    v1, 3
        skip.eq v1, 3
        exit    1

        load    v2, 6
        skip.eq v2, 6
        exit    1

        load    v3, 9
        skip.eq v3, 9
        exit    1

        load    v14, -7
        skip.eq v14, -7
        exit    1

        exit    0
end
if test $? -ne 0; then no_result; fi

testit

#
# test the
#       load vX, vY
# opcode
#
cat > tmpA << 'end'
        load    v0, 0
        load    v1, 1
        load    v1, v0
        skip.eq v1, 0
        exit    1

        load    v1, 3
        load    vE, 0
        load    vE, v1
        skip.eq vE, 3
        exit    1

        load    v3, 6
        load    v12, 0
        load    vC, v3
        skip.eq v12, 6
        exit    1

        load    v3, 9
        load    vB, -100
        load    v11, v3
        skip.eq vB, 9
        exit    1

        load    v14, -7
        load    v9, 56
        load    v9, vE
        skip.eq v9, -7
        exit    1

        exit    0
end
if test $? -ne 0; then no_result; fi

testit

#
# test the
#       load i, NNN
# opcode
#
cat > tmpA << 'end'
        load    i, lbl
        restore v0
        skip.eq v0, 1
        exit    1
        restore v0
        skip.eq v0, 2
        exit    1
        restore v0
        skip.eq v0, 3
        exit    1
        restore v0
        skip.eq v0, 4
        exit    1
        restore v0
        skip.eq v0, 5
        exit    1

        exit    0

lbl:    .byte   1, 2, 3, 4, 5
end
if test $? -ne 0; then no_result; fi

testit

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
