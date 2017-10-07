/*
 *	chip8 - X11 Chip8 interpreter
 *	Copyright (C) 1998, 2012 Peter Miller
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program. If not, see
 *	<http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_AC_TIME_H
#define COMMON_AC_TIME_H

#include <common/config.h>

/*
 * Catch-22: Dec Alpha OSF/1: need to include time.h before sys/time.h
 * before time.h
 */
#ifdef __alpha__
#ifndef _CLOCK_ID_T
#define _CLOCK_ID_T
typedef int clockid_t;
#endif
#endif

#ifdef TIME_WITH_SYS_TIME
#include <sys/time.h>
#include <time.h>
#else
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#else
#include <time.h>
#endif
#endif

#endif /* COMMON_AC_TIME_H */
