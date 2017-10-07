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

#include <common/ac/assert.h>
#include <common/ac/stdio.h>
#include <common/ac/string.h>
#include <common/ac/stdarg.h>
#include <libexplain/fclose.h>
#include <libexplain/fopen.h>
#include <libexplain/getc.h>
#include <libexplain/output.h>

#include <common/debug.h>
#include <common/sizeof.h>
#include <common/trace.h>

#include <chip8as/conditional.h>
#include <chip8as/emit.h>
#include <chip8as/lex.h>
#include <chip8as/option.h>


lex_token_t     lex_token;
lex_value_t     lex_value;
static const char *filename;
static FILE     *fp;
static int      line_number;
static int      pass;
static int      errcount;
static int      tellerr;


void
lex_open(const char *s)
{
    filename = s;
    fp = explain_fopen_or_die(s, "r");
    line_number = 0;
    pass = 1;
}


void
lex_rewind(void)
{
    const char      *listfile;

    ++pass;
    rewind(fp);
    line_number = 0;
    listfile = option_get_listfile();
    tellerr = (!listfile || *listfile);
}


void
lex_close(void)
{
    if (errcount)
    {
        explain_output_error_and_die
        (
            "%s: found %d fatal error%s",
            filename,
            errcount,
            (errcount == 1 ? "" : "s")
        );
    }
    explain_fclose_or_die(fp);
    fp = 0;
}


void
lex_error(const char *s, ...)
{
    char    buffer[1000];
    va_list ap;

    va_start(ap, s);
    vsnprintf(buffer, sizeof(buffer), s, ap);
    if (pass == 2)
    {
        if (tellerr)
            explain_output_error("%s: %d: %s", filename, line_number, buffer);
        emit_error(buffer);
        ++errcount;
    }
}


void
lex_warning(const char *s, ...)
{
    char    buffer[1000];
    va_list ap;

    va_start(ap, s);
    vsnprintf(buffer, sizeof(buffer), s, ap);
    if (pass == 2)
    {
        if (tellerr)
        {
            explain_output_error
            (
                "%s: %d: warning: %s",
                filename,
                line_number,
                buffer
            );
        }
        emit_warning(buffer);
    }
}


#ifdef DEBUG

static const char *
lex_token_repn(lex_token_t n)
{
    static char buffer[10];

    switch (n)
    {
    case lex_token_bit_and: return "lex_token_bit_and";
    case lex_token_bit_not: return "lex_token_bit_not";
    case lex_token_bit_or:  return "lex_token_bit_or";
    case lex_token_bit_xor: return "lex_token_bit_xor";
    case lex_token_colon:   return "lex_token_colon";
    case lex_token_comma:   return "lex_token_comma";
    case lex_token_define:  return "lex_token_define";
    case lex_token_div:     return "lex_token_div";
    case lex_token_dot:     return "lex_token_dot";
    case lex_token_else:    return "lex_token_else";
    case lex_token_endif:   return "lex_token_endif";
    case lex_token_eof:     return "lex_token_eof";
    case lex_token_eoln:    return "lex_token_eoln";
    case lex_token_equ:     return "lex_token_equ";
    case lex_token_ifdef:   return "lex_token_ifdef";
    case lex_token_ifndef:  return "lex_token_ifndef";
    case lex_token_include: return "lex_token_include";
    case lex_token_junk:    return "lex_token_junk";
    case lex_token_left_bracket:    return "lex_token_left_bracket";
    case lex_token_left_paren:      return "lex_token_left_paren";
    case lex_token_minus:   return "lex_token_minus";
    case lex_token_mod:     return "lex_token_mod";
    case lex_token_mul:     return "lex_token_mul";
    case lex_token_name:    return "lex_token_name";
    case lex_token_number:  return "lex_token_number";
    case lex_token_plus:    return "lex_token_plus";
    case lex_token_right_bracket:   return "lex_token_right_bracket";
    case lex_token_right_paren:     return "lex_token_right_paren";
    case lex_token_shift_left:      return "lex_token_shift_left";
    case lex_token_shift_right:     return "lex_token_shift_right";
    case lex_token_string:  return "lex_token_string";
    }
    snprintf(buffer, sizeof(buffer), "%d", n);
    return buffer;
}

#endif /* DEBUG */

static  char    line[2000];
static  char    *line_ptr;


static int
read_one_line(char *buffer, int length)
{
    int             pos;
    int             c;

    length -= 2;
    pos = 0;
    for (;;)
    {
        c = explain_getc_or_die(fp);
        if (c == EOF)
        {
            if (pos == 0)
                return 0;
            break;
        }
        if (c == '\r')
        {
            c = explain_getc_or_die(fp);
            if (c == '\n')
                break;
            if (c != EOF)
                ungetc(c, fp);
            break;
        }
        if (c == '\n')
            break;
        if (pos < length)
            buffer[pos++] = c;
    }
    buffer[pos++] = '\n';
    buffer[pos] = 0;
    return 1;
}


static int
lex_getc(void)
{
    if (!line_ptr || !*line_ptr)
    {
        if (!read_one_line(line, sizeof(line)))
        {
            line_ptr = 0;
            return EOF;
        }
        trace(("line %d\n", line_number));
        line_number++;
        line_ptr = line;
        emit_listing(line_number, line);
    }
    return (unsigned char)*line_ptr++;
}


static void
lex_getc_undo(void)
{
    if (line_ptr)
    {
        assert(line_ptr > line);
        --line_ptr;
    }
}


static void
reserved(char *name)
{
    typedef struct table_t table_t;
    struct table_t
    {
        const char      *name;
        lex_token_t     token;
        long            value;
    };

    static const table_t table[] =
    {
        { "%",          lex_token_mod,          0,      },
        { "&",          lex_token_bit_and,      0,      },
        { "(",          lex_token_left_paren,   0,      },
        { ")",          lex_token_right_paren,  0,      },
        { "*",          lex_token_mul,          0,      },
        { "+",          lex_token_plus,         0,      },
        { ",",          lex_token_comma,        0,      },
        { "-",          lex_token_minus,        0,      },
        { ".",          lex_token_dot,          0,      },
        { ".equ",       lex_token_equ,          0,      },
        { "/",          lex_token_div,          0,      },
        { ":",          lex_token_colon,        0,      },
        { "<<",         lex_token_shift_left,   0,      },
        { "=",          lex_token_equ,          0,      },
        { ">>",         lex_token_shift_left,   0,      },
        { "[",          lex_token_left_bracket, 0,      },
        { "]",          lex_token_right_bracket, 0,     },
        { "^",          lex_token_bit_xor,      0,      },
        { "define",     lex_token_define,       0,      },
        { "else",       lex_token_else,         0,      },
        { "endif",      lex_token_endif,        0,      },
        { "equ",        lex_token_equ,          0,      },
        { "ifdef",      lex_token_ifdef,        0,      },
        { "ifndef",     lex_token_ifndef,       0,      },
        { "include",    lex_token_include,      0,      },
        { "|",          lex_token_bit_or,       0,      },
        { "~",          lex_token_bit_not,      0,      },
    };

    int             min;
    int             mid;
    int             max;
    const table_t   *tp;
    int             cmp;

    min = 0;
    max = SIZEOF(table) - 1;
    while (min <= max)
    {
        mid = (min + max) / 2;
        tp = &table[mid];
        cmp = strcasecmp(name, tp->name);
        if (!cmp)
        {
            lex_token = tp->token;
            lex_value.lv_number = tp->value;
            return;
        }
        if (cmp < 0)
            max = mid - 1;
        else
            min = mid + 1;
    }
    lex_token = lex_token_junk;
}


static void
lex_inner(void)
{
    int     c;
    char    buffer[sizeof(line)];
    char    *cp;
    int     term;

    trace(("lex()\n{\n"/*}*/));
    for (;;)
    {
        c = lex_getc();
        switch (c)
        {
        case EOF:
            lex_token = lex_token_eof;
            goto ret;

        default:
            buffer[0] = c;
            buffer[1] = 0;
symbols:
            reserved(buffer);
            if (lex_token == lex_token_name)
                lex_token = lex_token_junk;
            goto ret;

        case ' ':
        case '\t':
        case '\f':
            break;

        case '\n':
            lex_token = lex_token_eoln;
            goto ret;

        case ';':
            /* comment */
            for (;;)
            {
                c = lex_getc();
                switch (c)
                {
                case EOF:
                    lex_token = lex_token_eof;
                    goto ret;

                case '\n':
                    lex_token = lex_token_eoln;
                    goto ret;
                }
            }

        case '<':
            buffer[0] = c;
            c = lex_getc();
            if (c == '<' || c == '>')
            {
                buffer[1] = c;
                buffer[2] = 0;
            }
            else
            {
                lex_getc_undo();
                buffer[1] = 0;
            }
            goto symbols;

        case '>':
            buffer[0] = c;
            c = lex_getc();
            if (c == '>')
            {
                buffer[1] = c;
                buffer[2] = 0;
            }
            else
            {
                lex_getc_undo();
                buffer[1] = 0;
            }
            goto symbols;

        case '$':
            /* binary constant */
            lex_token = lex_token_number;
            lex_value.lv_number = 0;
            c = lex_getc();
            switch (c)
            {
            default:
                lex_getc_undo();
                lex_error("incomplete binary number");
                goto ret;

            case '0':
            case '.':
            case '1':
                break;
            }
            for (;;)
            {
                if (c == '.')
                    c = '0';
                lex_value.lv_number = lex_value.lv_number * 2 + c - '0';
                c = lex_getc();
                switch (c)
                {
                case '0':
                case '.':
                case '1':
                    break;

                default:
                    lex_getc_undo();
                    goto ret;
                }
            }

        case '#':
            /* hexadecimal constant */
            lex_token = lex_token_number;
            lex_value.lv_number = 0;
            goto hexadecimal;

        case '0':
            lex_token = lex_token_number;
            lex_value.lv_number = 0;
            c = lex_getc();
            switch (c)
            {
            case 'x':
            case 'X':
                /* hexadecimal */
                hexadecimal:
                c = lex_getc();
                switch (c)
                {
                case '0': case '1': case '2': case '3':
                case '4': case '5': case '6': case '7':
                case '8': case '9': case 'A': case 'B':
                case 'C': case 'D': case 'E': case 'F':
                case 'a': case 'b': case 'c': case 'd':
                case 'e': case 'f':
                    break;

                default:
                    lex_getc_undo();
                    lex_error("incomplete hexadecimal number");
                    goto ret;
                }
                for (;;)
                {
                    switch (c)
                    {
                    case '0': case '1': case '2': case '3':
                    case '4': case '5': case '6': case '7':
                    case '8': case '9':
                        lex_value.lv_number =
                            lex_value.lv_number * 16 + c - '0';
                        break;

                    case 'A': case 'B': case 'C':
                    case 'D': case 'E': case 'F':
                        lex_value.lv_number =
                            lex_value.lv_number * 16 + c - 'A' + 10;
                        break;

                    case 'a': case 'b': case 'c':
                    case 'd': case 'e': case 'f':
                        lex_value.lv_number =
                            lex_value.lv_number * 16 + c - 'a' + 10;
                        break;

                    default:
                        lex_getc_undo();
                        goto ret;
                    }
                    c = lex_getc();
                }
                break;

            case 'b':
            case 'B':
                /* binary */
                c = lex_getc();
                switch (c)
                {
                case '0':
                case '1':
                    break;

                default:
                    lex_getc_undo();
                    lex_error("incomplete binary number");
                    goto ret;
                }
                for (;;)
                {
                    switch (c)
                    {
                    case '0':
                    case '1':
                        lex_value.lv_number = lex_value.lv_number * 2 + c - '0';
                        break;

                    default:
                        lex_getc_undo();
                        goto ret;
                    }
                    c = lex_getc();
                }
                break;

            default:
                /* octal */
                for (;;)
                {
                    switch (c)
                    {
                    case '0': case '1': case '2': case '3':
                    case '4': case '5': case '6': case '7':
                        break;

                    default:
                        lex_getc_undo();
                        goto ret;
                    }
                    lex_value.lv_number = lex_value.lv_number * 8 + c - '0';
                    c = lex_getc();
                }
                break;
            }
            break;

        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            /* decimal */
            lex_token = lex_token_number;
            lex_value.lv_number = 0;
            for (;;)
            {
                lex_value.lv_number = lex_value.lv_number * 10 + c - '0';
                c = lex_getc();
                switch (c)
                {
                case '0': case '1': case '2': case '3':
                case '4': case '5': case '6': case '7':
                case '8': case '9':
                    break;

                default:
                    lex_getc_undo();
                    goto ret;
                }
            }

        case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
        case 'G': case 'H': case 'I': case 'J': case 'K': case 'L':
        case 'M': case 'N': case 'O': case 'P': case 'Q': case 'R':
        case 'S': case 'T': case 'U': case 'V': case 'W': case 'X':
        case 'Y': case 'Z': case '_':
        case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
        case 'g': case 'h': case 'i': case 'j': case 'k': case 'l':
        case 'm': case 'n': case 'o': case 'p': case 'q': case 'r':
        case 's': case 't': case 'u': case 'v': case 'w': case 'x':
        case 'y': case 'z': case '.':
            cp = buffer;
            for (;;)
            {
                *cp++ = c;
                c = lex_getc();
                switch (c)
                {
                case 'A': case 'B': case 'C': case 'D':
                case 'E': case 'F': case 'G': case 'H':
                case 'I': case 'J': case 'K': case 'L':
                case 'M': case 'N': case 'O': case 'P':
                case 'Q': case 'R': case 'S': case 'T':
                case 'U': case 'V': case 'W': case 'X':
                case 'Y': case 'Z': case '_':
                case 'a': case 'b': case 'c': case 'd':
                case 'e': case 'f': case 'g': case 'h':
                case 'i': case 'j': case 'k': case 'l':
                case 'm': case 'n': case 'o': case 'p':
                case 'q': case 'r': case 's': case 't':
                case 'u': case 'v': case 'w': case 'x':
                case 'y': case 'z': case '.':
                case '0': case '1': case '2': case '3':
                case '4': case '5': case '6': case '7':
                case '8': case '9':
                    break;

                default:
                    *cp = 0;
                    lex_getc_undo();
                    reserved(buffer);
                    lex_token = lex_token_name;
                    lex_value.lv_name = str_from_c(buffer);
                    goto ret;
                }
            }
            break;

        case '"':
        case '\'':
            term = c;
            cp = buffer;
            for (;;)
            {
                c = lex_getc();
                if (c == term)
                {
                    c = lex_getc();
                    if (c != term)
                    {
                        lex_getc_undo();
                        break;
                    }
                    *cp++ = term;
                    continue;
                }
                if (c == EOF || c == '\n')
                {
                    lex_error("unterminated string");
                    break;
                }
                *cp++ = c;
            }
            *cp = 0;
            lex_token = lex_token_string;
            lex_value.lv_name = str_from_c(buffer);
            goto ret;
        }
    }
ret:
    trace(("lex_token = %s;\n", lex_token_repn(lex_token)));
    trace((/*{*/"}\n"));
}


void
conditional_lex(void)
{
    lex_inner();
}


void
lex(void)
{
    for (;;)
    {
        lex_inner();
        switch (lex_token)
        {
        case lex_token_eof:
            conditional_eof_check();
            return;

        default:
            break;

        case lex_token_name:
            reserved(lex_value.lv_name->str_text);
            if (lex_token == lex_token_junk)
            {
                lex_token = lex_token_name;
                break;
            }
            str_free(lex_value.lv_name);
            switch (lex_token)
            {
            case lex_token_define:
            case lex_token_else:
            case lex_token_endif:
            case lex_token_ifdef:
            case lex_token_ifndef:
            case lex_token_include:
                conditional_parse();
                continue;

            default:
                break;
            }
            break;
        }
        if (conditional_ok())
            return;
    }
}


int
lex_line_number(void)
{
    return line_number;
}
