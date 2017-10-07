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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_INPUT_PRIVATE_H
#define COMMON_INPUT_PRIVATE_H

#include <common/input.h>

typedef struct input_method_t input_method_t;
struct input_method_t
{
    const char      *name;
    int             size;
    int             (*read_char)(input_t *);
    int             (*read)(input_t *, void *, int);
    void            (*close)(input_t *);
    const char      *(*filename)(input_t *);
    void            (*seek)(input_t *, int);
};

/* typedef struct input_t input_t; */
struct input_t
{
    input_method_t  *method;
};

input_t *input_new(input_method_t *);
const char *input_filename(input_t *);
void input_rewind(input_t *);
void input_seek(input_t *, int);

#endif /* COMMON_INPUT_PRIVATE_H */
