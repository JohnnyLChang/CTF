dnl!
dnl! chip8 - X11 Chip8 interpreter
dnl! Copyright (C) 1998, 2012 Peter Miller
dnl!
dnl! This program is free software; you can redistribute it and/or
dnl! modify it under the terms of the GNU General Public License as
dnl! published by the Free Software Foundation; either version 2 of the
dnl! License, or (at your option) any later version.
dnl!
dnl! This program is distributed in the hope that it will be useful,
dnl! but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl! General Public License for more details.
dnl!
dnl! You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
dnl!
AC_INIT(install-sh)
AC_CONFIG_HEADER(common/config.h)
AC_USE_SYSTEM_EXTENSIONS
AC_SYS_LARGEFILE
AC_PROG_CC
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_YACC
AC_PROG_RANLIB
AC_AIX
AC_MINIX
AC_ISC_POSIX
AC_PATH_XTRA
AC_HAVE_LIBRARY(m)
AC_CHECK_PROGS(GROFF, groff)
AC_CHECK_PROGS(SOELIM, roffpp gsoelim soelim)
AC_CHECK_PROGS(AR, ar)

AC_CHECK_LIB(explain, explain_open_or_die)

AC_CHECK_HEADERS(fcntl.h limits.h memory.h stddef.h stdlib.h string.h unistd.h)
AC_HEADER_DIRENT
AC_TYPE_SIGNAL
AC_TYPE_SIZE_T
AC_HEADER_TIME
AC_C_CONST
AC_SYS_LONG_FILE_NAMES
AC_CHECK_FUNCS(strcasecmp strerror strsignal)

dnl!
dnl! Test to find a Bourne shell which understands functions
dnl!
AC_MSG_CHECKING([for a Bourne shell which understands functions])
if test "z$SH" = "z"; then
    if test -f /bin/sh5; then
        SH=/bin/sh5
    else
        SH=/bin/sh
    fi
fi
AC_SUBST(SH)
AC_DEFINE_UNQUOTED(CONF_SHELL, ["$SH"],
[Set this to be the absolute path of a Bourne shell
which understands functions.])
AC_MSG_RESULT($SH)

dnl
dnl Evaluate some of the variables, to remove ${prefix} references.
dnl This way, they can be used in C programs and Roff input.
dnl Make sure that chip8 is mentioned in the libdir and datadir paths;
dnl add it if it is not already there.
dnl
test "x$prefix" = xNONE && prefix="${ac_default_prefix-/usr/local}"
test "x$exec_prefix" = xNONE && exec_prefix="$prefix"
eval "bindir=$bindir"
eval "datadir=$datadir"
eval "libdir=$libdir"
eval "mandir=$mandir"
eval "sharedstatedir=$sharedstatedir"
case "$libdir" in
*/chip8/* | */chip8 )
	;;
*)
	libdir="${libdir}/chip8"
	;;
esac
case "$sharedstatedir" in
*/chip8/* | */chip8 )
	;;
*)
	sharedstatedir="${sharedstatedir}/chip8"
	;;
esac

AH_TOP([/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 2012 Peter Miller
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_CONFIG_H
#define COMMON_CONFIG_H
])

AH_BOTTOM([
#if 0
/*
 * There is more to do, but we need to insulate it from config.status,
 * because it screws up the #undef lines.  They are all implications of
 * the above information, so there is no need for you to edit the file,
 * if you are configuring Chip8 manually.
 */
#include <common/config.messy.h>
#endif

#endif /* COMMON_CONFIG_H */])

AC_OUTPUT(Makefile etc/libdir.so etc/libdir-h)
