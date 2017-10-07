#!/bin/sh
#
# chip8 - video game interpreter
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
echo "XLIBS = -lX11"
fmtgen_files=
aegis_files=
echo "all: chip8as chip8dis chip8run games"
echo
case $1 in
LIB=*)
    echo "LIB = -D'$1'"
    shift
    ;;
*)
    echo "LIB = -D'LIB=\"/usr/local/lib\"'"
    ;;
esac
for file in $*
do
    echo $file 1>&2
    case $file in

    as/*.c)
        basename=`basename $file .c`
        dep=`c_incl -Ias -Icommon $file | sed -e '/usr.include/d'`
        echo
        echo "as/$basename.o: $file" $dep
        echo "  $(CC) $(CFLAGS) -Ias -Icommon -I/usr/include -Ih -c" \
             "as/$basename.c"
        echo "  mv $basename.o as"
        as_files="$as_files as/$basename.o"
        ;;

    dis/*.c)
        basename=`basename $file .c`
        dep=`c_incl -Idis -Icommon $file | sed -e '/usr.include/d'`
        echo
        echo "dis/$basename.o: $file" $dep
        echo "  $(CC) $(CFLAGS) -Idis -Icommon -I/usr/include -Ih -c" \
             "dis/$basename.c"
        echo "  mv $basename.o dis"
        dis_files="$dis_files dis/$basename.o"
        ;;

    run/*.c)
        basename=`basename $file .c`
        dep=`c_incl -Irun -Icommon $file | sed -e '/usr.include/d'`
        echo
        echo "run/$basename.o: $file" $dep
        echo "  $(CC) $(CFLAGS) -Irun -Icommon -I/usr/include -Ih -c" \
             "run/$basename.c"
        echo "  mv $basename.o run"
        run_files="$run_files run/$basename.o"
        ;;

    common/*.c)
        basename=`basename $file .c`
        dep=`c_incl -Icommon $file | sed -e '/usr.include/d'`
        echo
        echo "common/$basename.o: $file" $dep
        echo "  $(CC) $(CFLAGS) -Icommon -I/usr/include -Ih -c " \
             "common/$basename.c"
        echo "  mv $basename.o common"
        common_files="$common_files common/$basename.o"
        ;;

    game/*.asm)
        basename=`basename $file .asm`
        echo
        echo "game/$basename.chp: $file chip8as"
        echo "  chip8as game/$basename.asm game/$basename.chp " \
             "-l game/$basename.list"
        game_files="$game_files game/$basename.chp"
        ;;

    *)
        ;;
    esac
done

echo
echo "chip8as: $as_files $common_files"
echo "  $(CC) -o chip8as $as_files $common_files"

echo
echo "chip8dis: $dis_files $common_files"
echo "  $(CC) -o chip8dis $dis_files $common_files"

echo
echo "chip8run: $run_files $common_files"
echo "  $(CC) -o chip8run $run_files $common_files \$(XLIBS)"

echo
echo "games: $game_files"
exit 0
