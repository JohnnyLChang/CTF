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

#include <common/ac/stdarg.h>
#include <common/ac/stdio.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>

#include <chip8as/output/private.h>


output_t *
output_new(output_method_t *mp)
{
    output_t        *op;

    op = explain_malloc_or_die(mp->size);
    op->method = mp;
    return op;
}


void
output_putc(output_t *op, int c)
{
    op->method->write_char(op, c);
}


void
output_executable(output_t *op)
{
    if (op->method->executable)
        op->method->executable(op);
}


void
output_puts(output_t *op, const char *s)
{
    output_write(op, s, strlen(s));
}


void
output_printf(output_t *op, const char *fmt, ...)
{
    va_list         ap;
    char            buffer[2000];

    va_start(ap, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, ap);
    va_end(ap);
    output_puts(op, buffer);
}


const char *
output_filename(output_t *op)
{
    return op->method->filename(op);
}
