#!/bin/sh
#
#	chip8 - X11 Chip8 interpreter
#	Copyright (C) 1998, 2012 Peter Miller
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program. If not, see
#	<http://www.gnu.org/licenses/>.
#
case $# in
2)
	;;
*)
	echo "Usage: $0 tmp-dir tarball" 1>&2
	exit 1
	;;
esac

tmp=$1
tarball=$2

mkdir -p $tmp/BUILD $tmp/BUILD_ROOT $tmp/RPMS/i386 \
	$tmp/SOURCES $tmp/SPECS $tmp/SRPMS

here=`pwd`/$tmp
cat > $tmp/rpmrc << fubar
builddir: $here/BUILD
buildroot: $here/BUILD_ROOT
rpmdir: $here/RPMS
sourcedir: $here/SOURCES
specdir: $here/SPECS
srcrpmdir: $here/SRPMS
fubar

rpm -ta --rcfile $tmp/rpmrc --verbose --verbose $2
test $? -eq 0 || exit 1

exit 0
