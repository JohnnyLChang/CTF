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
#include <common/ac/stdlib.h>
#include <libexplain/output.h>
#include <libexplain/program_name.h>

#include <common/arglex.h>
#include <chip8dis/dis.h>
#include <common/help.h>
#include <common/str.h>
#include <common/trace.h>
#include <common/version.h>


static void
usage(void)
{
    const char *progname = explain_program_name_get();
    fprintf(stderr, "usage: %s [ <option>... ][ <infile> [ <outfile> ]]\n",
        progname);
    fprintf(stderr, "       %s -Help\n", progname);
    exit(1);
}


int
main(int argc, char **argv)
{
    const char      *infile = 0;
    const char      *outfile = 0;

    str_initialize();
    arglex_init(argc, argv, (arglex_table_t *)0);
    switch (arglex())
    {
    case arglex_token_help:
        help(0, usage);
        return 0;

    case arglex_token_version:
        version(usage);
        return 0;

    case arglex_token_license:
        license(usage);
        return 0;

    default:
        break;
    }
    while (arglex_token != arglex_token_eoln)
    {
        switch (arglex_token)
        {
        default:
            usage();

        case arglex_token_string:
            if (!infile)
                infile = arglex_value.alv_string;
            else
                if (!outfile)
                    outfile = arglex_value.alv_string;
                else
                    explain_output_error_and_die("too many files named");
            break;

        case arglex_token_stdio:
            if (!infile)
                infile = "";
            else
                if (!outfile)
                    outfile = "";
                else
                    explain_output_error_and_die("too many files named");
            break;

        case arglex_token_trace:
            while (arglex() == arglex_token_string)
                trace_enable(arglex_value.alv_string);
            continue;
        }
        arglex();
    }
    if (infile && !*infile)
        infile = 0;
    if (outfile && !*outfile)
        outfile = 0;

    trace(("mark\n"));
    disassemble(infile, outfile);
    return 0;
}
