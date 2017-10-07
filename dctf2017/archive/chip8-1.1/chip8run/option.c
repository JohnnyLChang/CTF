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

#include <common/str.h>

#include <chip8run/option.h>

static int debug;


void
option_set_debug(void)
{
    debug++;
}


int
option_get_debug(void)
{
    return debug;
}


static int test_mode;


void
option_set_test_mode(void)
{
    test_mode++;
}


int
option_get_test_mode(void)
{
    return test_mode;
}
