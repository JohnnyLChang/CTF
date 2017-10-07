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

TEST_SUBJECT="HP headers"
. test_prelude

#
# A simple binary with a HP header
#
echo begin 644 tmpB > tmpA
cat > tmpA << 'foobar'
begin 644 tmpB
M2%!(4#0X+4$L*G`$``I#;W!Y<FEG:'0@*$,I(#$Y.3@@4&5T97(@36EL;&5R
!"@``
`
end
foobar
if test $? -ne 0; then no_result; fi

# decode to get binary file
uudecode tmpA
if [ "$?" != "0" ]; then no_result; fi

# have the disassembler chew on it
chip8dis tmpB tmpC
if [ "$?" != "0" ]; then fail; fi

# assemble the disassembled source
# asking for an HP header
chip8as tmpC tmpD -hph
if [ "$?" != "0" ]; then fail; fi

# see if the original and the one we just built are the same
cmp tmpB tmpD
if [ "$?" != "0" ]; then fail; fi

#
# Only definite negatives are possible.
# The functionality exercised by this test appears to work,
# no other guarantees are made.
#
pass
