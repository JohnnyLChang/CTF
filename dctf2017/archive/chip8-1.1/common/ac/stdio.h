/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 1998, 2012 Peter Miller
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_AC_STDIO_H
#define COMMON_AC_STDIO_H

#include <common/config.h>

/*
 * Need to define _POSIX_SOURCE on Linux, in order to get the fdopen,
 * fileno, popen and pclose function prototypes.
 */
#ifdef __linux__
#ifndef _POSIX_SOURCE
#define _POSIX_SOURCE
#endif
#endif

#include <stdio.h>

#endif /* COMMON_AC_STDIO_H */
