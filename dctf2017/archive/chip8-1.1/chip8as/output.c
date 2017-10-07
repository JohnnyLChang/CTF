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

#include <common/ac/stdlib.h>

#include <chip8as/option.h>
#include <chip8as/output/asc.h>
#include <chip8as/output/c.h>
#include <chip8as/output/hp.h>
#include <chip8as/output/private.h>
#include <chip8as/output/raw.h>
#include <chip8as/output/unix.h>


output_t *
output_open(const char *filename)
{
    output_t        *op;

    op = output_raw_open(filename);
    if (option_get_unix_header())
        op = output_unix_open(op);
    if (option_get_asc_format())
        op = output_asc_open(op);
    if (option_get_hp_header() || option_get_asc_format())
        op = output_hp_open(op);
    if (option_get_c_format())
        op = output_c_open(op);
    return op;
}


void
output_write(output_t *op, const void *buffer, int length)
{
    if (op->method->write)
        op->method->write(op, buffer, length);
    else
    {
        const unsigned char *bp;

        bp = buffer;
        while (length-- > 0)
            output_putc(op, *bp++);
    }
}


void
output_close(output_t *op)
{
    op->method->close(op);
    free(op);
}
