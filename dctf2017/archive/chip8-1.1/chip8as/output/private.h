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

#ifndef CHIP8AS_OUTPUT_PRIVATE_H
#define CHIP8AS_OUTPUT_PRIVATE_H

#include <chip8as/output.h>

typedef struct output_method_t output_method_t;
struct output_method_t
{
    const char      *name;
    int             size;
    void            (*close)(output_t *);
    void            (*write)(output_t *, const void *, int);
    void            (*write_char)(output_t *, int);
    void            (*executable)(output_t *);
    const char      *(*filename)(output_t *);
};

/* typedef struct output_t output_t; */
struct output_t
{
    output_method_t *method;
};

output_t *output_new(output_method_t *);
void output_putc(output_t *, int);
void output_puts(output_t *, const char *);
void output_printf(output_t *, const char *, ...);
void output_executable(output_t *);
const char *output_filename(output_t *);

#endif /* CHIP8AS_OUTPUT_PRIVATE_H */
