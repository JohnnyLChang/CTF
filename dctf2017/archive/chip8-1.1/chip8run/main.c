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
#include <common/ac/time.h>
#include <libexplain/output.h>
#include <libexplain/program_name.h>

#include <common/help.h>
#include <common/libdir.h>
#include <common/str.h>
#include <common/trace.h>
#include <common/version.h>

#include <chip8run/arglex2.h>
#include <chip8run/autotest.h>
#include <chip8run/chip8.h>
#include <chip8run/ecks.h>
#include <chip8run/event.h>
#include <chip8run/option.h>


static void
usage(void)
{
    const char *progname = explain_program_name_get();
    fprintf(stderr, "usage: %s [ <option>... ] filename\n", progname);
    fprintf(stderr, "       %s -Help\n", progname);
    exit(1);
}


int
main(int argc, char **argv)
{
    string_t        *file_name;

    srand(time(0L));
    str_initialize();
    arglex2_init(argc, argv);
    x_initialize();
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

    case arglex_token_automated_testing:
        automated_testing();
        return 0;

    default:
        break;
    }
    file_name = 0;
    while (arglex_token != arglex_token_eoln)
    {
        switch (arglex_token)
        {
        default:
            usage();

        case arglex_token_iconic:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2(".iconStart", "true");
            break;

        case arglex_token_icon_geometry:
            switch (arglex())
            {
            case arglex_token_string:
            case arglex_token_option:
                break;

            default:
                usage();
            }
            x_resource2(".iconGeometry", arglex_value.alv_string);
            break;

        case arglex_token_geometry:
            switch (arglex())
            {
            case arglex_token_string:
            case arglex_token_option:
                break;

            default:
                usage();
            }
            x_resource2(".geometry", arglex_value.alv_string);
            break;

        case arglex_token_name:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2(".name", arglex_value.alv_string);
            break;

        case arglex_token_title:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2(".title", arglex_value.alv_string);
            break;

        case arglex_token_display:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2(".display", arglex_value.alv_string);
            break;

        case arglex_token_background:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2("*background", arglex_value.alv_string);
            break;

        case arglex_token_foreground:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2("*foreground", arglex_value.alv_string);
            break;

        case arglex_token_border_color:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2("*borderColor", arglex_value.alv_string);
            break;

        case arglex_token_border_width:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2(".borderWidth", arglex_value.alv_string);
            break;

        case arglex_token_font:
            if (arglex() != arglex_token_string)
                usage();
            x_resource2("*font", arglex_value.alv_string);
            break;

        case arglex_token_resource:
            if (arglex() != arglex_token_string)
                usage();
            x_resource1(arglex_value.alv_string);
            break;

        case arglex_token_string:
            if (file_name)
                explain_output_error_and_die("too many files named");
            file_name =
                str_format
                (
                    "%s/%s.chp",
                    library_directory(),
                    arglex_value.alv_string
                );
            break;

        case arglex_token_file:
            if (file_name)
                explain_output_error_and_die("too many files named");
            switch (arglex())
            {
            default:
                usage();

            case arglex_token_string:
                file_name = str_from_c(arglex_value.alv_string);
                break;

            case arglex_token_stdio:
                file_name = str_from_c("");
                break;
            }
            break;

        case arglex_token_trace:
            while (arglex() == arglex_token_string)
                trace_enable(arglex_value.alv_string);
            continue;

        case arglex_token_debug:
            option_set_debug();
            break;

        case arglex_token_test_mode:
            option_set_test_mode();
            break;
        }
        arglex();
    }
    if (!file_name)
        explain_output_error_and_die("no file named");

    trace(("main\n"));
    x_open();
    chip_initialize(file_name->str_text);
    event_loop();
    return 0;
}
