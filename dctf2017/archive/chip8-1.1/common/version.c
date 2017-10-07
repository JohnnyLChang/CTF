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

#include <common/ac/stdio.h>
#include <libexplain/program_name.h>

#include <common/arglex.h>
#include <common/help.h>
#include <common/versio_stamp.h>
#include <common/version.h>


void
version(void (*usage)(void))
{
    const char      *progname;

    if (usage && arglex() != arglex_token_eoln)
        usage();
    progname = explain_program_name_get();
    printf("%s version %s\n", progname, version_stamp());
    printf("Copyright (C) %s Peter Miller;\n", copyright_years());
    printf("\n");
    printf("The %s program comes with ABSOLUTELY NO WARRANTY;\n", progname);
    printf("for details use the '%s -LICense' command.\n", progname);
    printf("The %s program is free software, and you are\n", progname);
    printf("welcome to redistribute it under certain conditions;\n");
    printf("for details use the '%s -LICense' command.\n", progname);
}


void
license(void (*usage)(void))
{
    help("chip8lic", usage);
}
