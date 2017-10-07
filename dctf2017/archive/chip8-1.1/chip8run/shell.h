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

#ifndef CHIP8RUN_SHELL_H
#define CHIP8RUN_SHELL_H

#include <chip8run/window.h>

typedef struct shell_class_t shell_class_t;
struct shell_class_t
{
    WINDOW_METHODS
};

typedef struct shell_t shell_t;
struct shell_t
{
    shell_class_t *method;
    WINDOW_VARIABLES
    struct button_t *key[16];
    struct button_t *quit;
    struct button_t *restart;
    struct button_t *step;
    struct button_t *run;
    struct button_t *reload;
    struct arena_t  *arena;
    struct machine_t *machine;
    struct debug_t *debug;
    int     single_stepping;
    int     unit;
    int     ex, ey;
};

extern shell_class_t shell_class;

void shell_new(shell_t *this, char *file_name);
int shell_test_key(shell_t *, int, int, struct timeval *);
void shell_chip8_update(shell_t *);

#endif /* CHIP8RUN_SHELL_H */
