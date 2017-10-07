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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <libexplain/output.h>
#include <libexplain/program_name.h>

#include <common/arglex.h>
#include <common/help.h>
#include <common/str.h>
#include <common/trace.h>
#include <common/version.h>

#include <chip8as/as.h>
#include <chip8as/id.h>
#include <chip8as/option.h>


enum
{
    arglex_token_ascii_format = arglex_token_MAX_1,
    arglex_token_c_format,
    arglex_token_hp_header,
    arglex_token_listing,
    arglex_token_raw_format,
    arglex_token_unix_header,
    arglex_token_MAX_2
};

static const arglex_table_t table[] =
{
    { "-ASCii_format", arglex_token_ascii_format, },
    { "-C_Format", arglex_token_c_format, },
    { "-Raw_Format", arglex_token_raw_format, },
    { "-Listing", arglex_token_listing, },
    { "-Hewlett_Packard_Header", arglex_token_hp_header, },
    { "-Unix_Header", arglex_token_unix_header, },
    ARGLEX_END_MARKER
};


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
    id_initialize();
    arglex_init(argc, argv, table);
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
            explain_output_error
            (
                "misplaced \"%s\" command line argument",
                arglex_value.alv_string
            );
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

        case arglex_token_listing:
            switch (arglex())
            {
            default:
                usage();

            case arglex_token_string:
                option_set_listfile(arglex_value.alv_string);
                break;

            case arglex_token_stdio:
                option_set_listfile("");
                break;
            }
            break;

        case arglex_token_hp_header:
            option_set_hp_header();
            break;

        case arglex_token_unix_header:
            option_set_unix_header();
            break;

        case arglex_token_c_format:
            option_set_c_format();
            break;

        case arglex_token_raw_format:
            option_set_raw_format();
            break;

        case arglex_token_ascii_format:
            option_set_asc_format();
            break;
        }
        arglex();
    }
    if (infile && !*infile)
        infile = 0;
    if (outfile && !*outfile)
        outfile = 0;

    trace(("mark\n"));
    assemble(infile, outfile);
    return 0;
}
