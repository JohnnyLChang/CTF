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

#include <common/ac/stddef.h>
#include <common/ac/string.h>
#include <common/ac/ctype.h>
#include <libexplain/output.h>

#include <common/arglex.h>
#include <common/sizeof.h>
#include <common/trace.h>
#include <common/word.h>

static arglex_table_t table[] =
{
    { "-",                  arglex_token_stdio,             },
    { "-Help",              arglex_token_help,              },
    { "-LICense",           arglex_token_license,           },
    { "-Trace",             arglex_token_trace,             },
    { "-Version",           arglex_token_version,           },
    ARGLEX_END_MARKER
};

static int      argc;
static char     **argv;
arglex_value_t  arglex_value;
int             arglex_token;
static const arglex_table_t *utable;


void
arglex_init(int ac, char **av, const arglex_table_t *tp)
{
    explain_option_hanging_indent_set(4);

    argc = ac-1;
    argv = av+1;
    utable = tp;
}


int
argcmp(const char *formal, const char *actual)
{
    char    fc;
    char    ac;
    int     result;

    trace(("argcmp(formal = \"%s\", actual = \"%s\")\n{\n", formal, actual));
    for (;;)
    {
        trace_string(formal);
        trace_string(actual);
        ac = *actual++;
        if (isupper(ac))
            ac = tolower(ac);
        fc = *formal++;
        switch (fc)
        {
        case 0:
            result = !ac;
            goto ret;

        case '_':
            if (ac == '-')
                break;
            /* fall through... */

        case 'a': case 'b': case 'c': case 'd': case 'e':
        case 'f': case 'g': case 'h': case 'i': case 'j':
        case 'k': case 'l': case 'm': case 'n': case 'o':
        case 'p': case 'q': case 'r': case 's': case 't':
        case 'u': case 'v': case 'w': case 'x': case 'y':
        case 'z':
            /*
             * optional characters
             */
#if 0
            if (ac == fc)
                break;
#else
            if (ac == fc && argcmp(formal, actual))
            {
                result = 1;
                goto ret;
            }
#endif
            /*
             * skip forward to next
             * mandatory character, or after '_'
             */
            while (islower(*formal))
                ++formal;
            if (*formal == '_')
            {
                ++formal;
                if (ac == '_' || ac == '-')
                    ++actual;
            }
            --actual;
            break;

        case 'A': case 'B': case 'C': case 'D': case 'E':
        case 'F': case 'G': case 'H': case 'I': case 'J':
        case 'K': case 'L': case 'M': case 'N': case 'O':
        case 'P': case 'Q': case 'R': case 'S': case 'T':
        case 'U': case 'V': case 'W': case 'X': case 'Y':
        case 'Z':
            fc = tolower(fc);
            /* fall through... */

        default:
            /*
             * mandatory characters
             */
            if (fc != ac)
            {
                result = 0;
                goto ret;
            }
            break;
        }
    }
ret:
    trace(("return %d;\n}\n", result));
    return result;
}


static int
is_a_number(const char *s)
{
    long    n;
    int     sign;

    n = 0;
    if (*s == '-')
    {
        ++s;
        sign = -1;
    }
    else
        sign = 1;
    switch (*s)
    {
    case '0':
        if ((s[1] == 'x' || s[1] == 'X') && s[2])
        {
            s += 2;
            for (;;)
            {
                switch (*s)
                {
                case '0': case '1': case '2': case '3':
                case '4': case '5': case '6': case '7':
                case '8': case '9':
                    n = n * 16 + *s++ - '0';
                    continue;

                case 'A': case 'B': case 'C':
                case 'D': case 'E': case 'F':
                    n = n * 16 + *s++ - 'A' + 10;
                    continue;

                case 'a': case 'b': case 'c':
                case 'd': case 'e': case 'f':
                    n = n * 16 + *s++ - 'a' + 10;
                    continue;
                }
                break;
            }
        }
        else
        {
            for (;;)
            {
                switch (*s)
                {
                case '0': case '1': case '2': case '3':
                case '4': case '5': case '6': case '7':
                    n = n * 8 + *s++ - '0';
                    continue;
                }
                break;
            }
        }
        break;

    case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
        for (;;)
        {
            switch (*s)
            {
            case '0': case '1': case '2': case '3':
            case '4': case '5': case '6': case '7':
            case '8': case '9':
                n = n * 10 + *s++ - '0';
                continue;
            }
            break;
        }
        break;

    default:
        return 0;
    }
    if (*s)
        return 0;
    arglex_value.alv_number = n * sign;
    return 1;
}


int
arglex(void)
{
    const arglex_table_t *tp;
    int             j;
    const arglex_table_t *hit[SIZEOF(table)];
    int             nhit;

    trace(("arglex()\n{\n"));
    if (argc <= 0)
    {
        arglex_token = arglex_token_eoln;
        arglex_value.alv_string = "";
        goto ret;
    }
    arglex_value.alv_string = argv[0];
    argc--;
    argv++;

    if (is_a_number(arglex_value.alv_string))
    {
        arglex_token = arglex_token_number;
        goto ret;
    }

    nhit = 0;
    for (tp = table; tp->name; tp++)
    {
        if (argcmp(tp->name, arglex_value.alv_string))
            hit[nhit++] = tp;
    }
    if (utable)
    {
        for (tp = utable; tp->name; tp++)
        {
            if (argcmp(tp->name, arglex_value.alv_string))
                hit[nhit++] = tp;
        }
    }
    switch (nhit)
    {
    case 0:
        break;

    case 1:
        arglex_token = hit[0]->token;
        goto ret;

    default:
        {
            string_t        *s1;
            string_t        *s2;

            s1 = str_from_c(hit[0]->name);
            for (j = 1; j < nhit; ++j)
            {
                s2 = str_format("%s, %s", s1->str_text, hit[j]->name);
                str_free(s1);
                s1 = s2;
            }
            explain_output_error_and_die
            (
                "option \"%s\" ambiguous (%s)",
                arglex_value.alv_string,
                s1->str_text
            );
        }
    }

    /* not found in the table */
    if (arglex_value.alv_string[0] == '-')
        arglex_token = arglex_token_option;
    else
        arglex_token = arglex_token_string;

ret:
    trace(("return %d; /* \"%s\" */\n}\n", arglex_token,
        arglex_value.alv_string));
    return arglex_token;
}
