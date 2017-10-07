/*
 *	chip8 - video game interpreter
 *	Copyright (C) 1990, 1998, 2012 Peter Miller
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

#ifndef CHIP8RUN_DEBUG_H
#define CHIP8RUN_DEBUG_H

#include <chip8run/window.h>

typedef struct debug_class_t debug_class_t;
struct debug_class_t
{
	WINDOW_METHODS
};

typedef struct debug_t debug_t;
struct debug_t
{
	debug_class_t *method;
	WINDOW_VARIABLES
	char	text[4][80];
};

extern debug_class_t debug_class;

struct machine_t;
void debug_update(void *, struct machine_t *);
void debug_new(void *, void *, int, int, int, int, const char *name,
    const char *title, int);
void debug_free(void *);

#endif /* CHIP8RUN_DEBUG_H */
