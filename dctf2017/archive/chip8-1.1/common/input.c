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

#include <common/ac/stdarg.h>
#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <libexplain/output.h>

#include <common/input/asc.h>
#include <common/input/binary.h>
#include <common/input/hp.h>
#include <common/input/private.h>
#include <common/input/unix.h>


input_t *
input_open(const char *filename)
{
    input_t         *ip;
    input_t         *ip2;

    ip = input_binary_open(filename);

    ip2 = input_unix_open(ip);
    if (ip2)
        ip = ip2;
    ip2 = input_asc_open(ip);
    if (ip2)
        ip = ip2;
    ip2 = input_hp_open(ip);
    if (ip2)
        ip = ip2;
    return ip;
}


int
input_getc(input_t *ip)
{
    return ip->method->read_char(ip);
}


int
input_read(input_t *ip, void *buffer, int length)
{
    return ip->method->read(ip, buffer, length);
}


void
input_close(input_t *ip)
{
    ip->method->close(ip);
    free(ip);
}


void
input_fatal(input_t *ip, const char *fmt, ...)
{
    const char      *filename;
    va_list         ap;
    char            buffer[2000];

    sva_init(ap, fmt);
    vsnprintf(buffer, sizeof(buffer), fmt, ap);
    va_end(ap);
    filename = input_filename(ip);
    explain_output_error_and_die("%s: %s", filename, buffer);
}
