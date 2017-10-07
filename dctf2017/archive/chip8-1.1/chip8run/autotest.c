/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 2012 Peter Miller
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
#include <libexplain/gettimeofday.h>

#include <common/debug.h>
#include <common/libdir.h>
#include <common/str.h>
#include <common/trace.h>

#include <chip8run/arglex2.h>
#include <chip8run/autotest.h>
#include <chip8run/option.h>
#include <chip8run/machine.h>


static void
usage(void)
{
    const char *prog = explain_program_name_get();
    fprintf(stderr, "Usage: %s -auto-test <filename>\n", prog);
    exit(1);
}


void
automated_testing(void)
{
    string_t        *filename;

    arglex();
    filename = 0;
    while (arglex_token != arglex_token_eoln)
    {
        switch (arglex_token)
        {
        default:
            usage();

        case arglex_token_string:
            if (filename)
                explain_output_error_and_die("too many files named");
            filename =
                str_format
                (
                    "%s/%s.chp",
                    library_directory(),
                    arglex_value.alv_string
                );
            break;

        case arglex_token_file:
            if (filename)
                explain_output_error_and_die("too many files named");
            switch (arglex())
            {
            default:
                usage();

            case arglex_token_string:
                filename = str_from_c(arglex_value.alv_string);
                break;

            case arglex_token_stdio:
                filename = str_from_c("");
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
    if (!filename)
        explain_output_error_and_die("no file named");

    trace(("auto test\n"));
    machine_t *mp = machine_alloc(filename->str_text);
    for (;;)
    {
        struct timeval  max_sleep;
        struct timeval  now;

#ifdef DEBUG
        {
            char buffer[1000];
            machine_disassemble(mp, buffer, sizeof(buffer));
            printf("%s\n", buffer);
            fflush(stdout);
        }
#endif

        now = mp->next_tick;
        explain_gettimeofday_or_die(&now, 0);
        machine_step(mp, &max_sleep, &now);
        if (mp->halt)
        {
            explain_output_error_and_die
            (
                "test failure: %s",
                halt_name(mp->halt)
            );
        }
    }
}


const char *
halt_name(halt_t x)
{
    static char buffer[10];
    switch (x)
    {
    case halt_still_running:
        return "halt_still_running";

    case halt_stack_overflow:
        return "halt_stack_overflow";

    case halt_stack_underflow:
        return "halt_stack_underflow";

    case halt_illegal_instruction:
        return "halt_illegal_instruction";

    case halt_address_error:
        return "halt_address_error";
    }
    snprintf(buffer, sizeof(buffer), "%d", x);
    return buffer;
}
