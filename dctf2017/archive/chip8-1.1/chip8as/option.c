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

#include <common/config.h>
#include <libexplain/output.h>

#include <common/str.h>

#include <chip8as/option.h>


static const char *listfile;

void
option_set_listfile(const char *s)
{
    listfile = s;
}


const char *
option_get_listfile(void)
{
    return listfile;
}


static void
too_many_headers(void)
{
    explain_output_error_and_die
    (
        "you may only specify one output format option"
    );
}


static int hp_header;
static int unix_header;
static int c_format;
static int raw_format;
static int asc_format;


void
option_set_hp_header(void)
{
    if (hp_header || raw_format)
        too_many_headers();
    hp_header = 1;
}


int
option_get_hp_header(void)
{
    return (hp_header || asc_format);
}


void
option_set_unix_header(void)
{
    if (unix_header || raw_format)
        too_many_headers();
    unix_header = 1;
}


int
option_get_unix_header(void)
{
    return
        (unix_header || !(raw_format || c_format || hp_header || asc_format));
}


void
option_set_c_format(void)
{
    if (c_format || raw_format)
        too_many_headers();
    c_format = 1;
}


int
option_get_c_format(void)
{
    return (c_format != 0);
}


void
option_set_raw_format(void)
{
    if (raw_format || unix_header || hp_header || c_format || asc_format)
        too_many_headers();
    raw_format = 1;
}


int
option_get_raw_format(void)
{
    return (raw_format != 0);
}


void
option_set_asc_format(void)
{
    if (raw_format || asc_format)
        too_many_headers();
    asc_format = 1;
}


int
option_get_asc_format(void)
{
    return (asc_format != 0);
}
