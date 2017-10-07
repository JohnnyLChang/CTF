/*
 * chip8 - video game interpreter
 * Copyright (C) 1990, 1998, 2012 Peter Miller
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ARENA_H
#define ARENA_H

#include <chip8run/window.h>

typedef struct arena_class_t arena_class_t;
struct arena_class_t
{
    WINDOW_METHODS
};

typedef struct arena_t arena_t;
struct arena_t
{
    arena_class_t   *method;
    WINDOW_VARIABLES
    int             mode;
    int             mult;
    char            pixel[64][128];
};

extern arena_class_t arena_class;

struct machine_t;
void arena_update(void *, struct machine_t *);
void arena_new(void *, void *, int, int, int, int, const char *name,
    const char *title, int);
void arena_free(void *);

#endif /* ARENA_H */
