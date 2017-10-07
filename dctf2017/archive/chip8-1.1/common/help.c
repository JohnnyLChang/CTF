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

#include <common/ac/unistd.h>
#include <libexplain/execvp.h>
#include <libexplain/program_name.h>

#include <common/arglex.h>
#include <common/help.h>


void
help(const char *name, void (*usage)(void))
{
    int             argc;
    const char      *argv[3];

    if (usage && arglex() != arglex_token_eoln)
        usage();

    if (!name)
        name = explain_program_name_get();

    argc = 0;
    argv[argc++] = "man";
    argv[argc++] = name;
    argv[argc] = 0;
    explain_execvp_or_die(argv[0], (char **)argv);
}
