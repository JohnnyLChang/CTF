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

#include <common/config.h>
#include <libexplain/malloc.h>

#include <common/input/private.h>


input_t *
input_new(input_method_t *mp)
{
    input_t         *ip;

    ip = explain_malloc_or_die(mp->size);
    ip->method = mp;
    return ip;
}


const char *
input_filename(input_t *ip)
{
    return ip->method->filename(ip);
}


void
input_rewind(input_t *ip)
{
    input_seek(ip, 0);
}


void
input_seek(input_t *ip, int pos)
{
    return ip->method->seek(ip, pos);
}
