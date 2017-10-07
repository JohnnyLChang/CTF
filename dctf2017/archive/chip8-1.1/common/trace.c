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
#include <common/ac/stdarg.h>
#include <common/ac/string.h>
#include <common/ac/stddef.h>
#include <libexplain/fflush.h>
#include <libexplain/fputs.h>
#include <libexplain/program_name.h>

#include <common/trace.h>
#include <common/word.h>

#define INDENT 2
#define BUFLEN 1000

static string_t *file_name;
static int      line_number;
static wlist    file_name_list;


static string_t *
base_name(const char *file)
{
    const char      *cp1;
    const char      *cp2;

    cp1 = strrchr(file, '/');
    if (cp1)
        ++cp1;
    else
        cp1 = file;
    cp2 = strrchr(cp1, '.');
    if (!cp2)
        cp2 = cp1 + strlen(cp1);
    if (cp2 > cp1 + 6)
        return str_n_from_c(cp1, 6);
    return str_n_from_c(cp1, cp2 - cp1);
}


int
trace_pretest(const char *file)
{
    string_t        *s;

    s = base_name(file);
    return wl_member(&file_name_list, s);
}


void
trace_where(const char *file, int line)
{
    string_t        *s;

    /*
     * take new name first, because will probably be same as last
     * thus saving a free and a malloc (which are slow)
     */
    s = base_name(file);
    if (file_name)
        str_free(file_name);
    file_name = s;
    line_number = line;
}


static void
trace_putchar(int c)
{
    static int      depth;
    static char     buffer[BUFLEN];
    static char     *cp;
    static int      in_col;
    static int      out_col;
    char            *buffer_end;

    buffer_end = buffer + sizeof(buffer);
    if (!cp)
    {
        snprintf(buffer, sizeof(buffer), "%s", explain_program_name_get());
        cp = buffer + strlen(buffer);
        if (cp > buffer + 6)
            cp = buffer + 6;
        *cp++ = ':';
        *cp++ = '\t';
        snprintf(cp, buffer_end - cp, "%s", file_name->str_text);
        cp += strlen(cp);
        *cp++ = ':';
        *cp++ = '\t';
        snprintf(cp, buffer_end - cp, "%d:\t", line_number);
        cp += strlen(cp);
        in_col = 0;
        out_col = 0;
    }
    switch (c)
    {
    case '\n':
        *cp++ = '\n';
        *cp = 0;
        explain_fflush_or_die(stdout);
        explain_fputs_or_die(buffer, stderr);
        explain_fflush_or_die(stderr);
        cp = 0;
        break;

    case ' ':
        if (out_col)
            ++in_col;
        break;

    case '\t':
        if (out_col)
            in_col = (in_col/INDENT + 1) * INDENT;
        break;

    case /*{*/'}':
    case /*(*/')':
    case /*[*/']':
        if (depth > 0)
        --depth;
        /* fall through */

    default:
        if (!out_col && c != '#')
            in_col += INDENT * depth;
        while (((out_col + 8) & -8) <= in_col && out_col + 1 < in_col)
        {
            *cp++ = '\t';
            out_col = (out_col + 8) & -8;
        }
        while (out_col < in_col)
        {
            *cp++ = ' ';
            ++out_col;
        }
        if (c == '{'/*}*/ || c == '('/*)*/ || c == '['/*]*/)
            ++depth;
        *cp++ = c;
        in_col++;
        out_col++;
        if (out_col >= 79-24)
            trace_putchar('\n');
        break;
    }
}


void
trace_printf(const char *s, ...)
{
    char            buffer[BUFLEN];
    va_list         ap;

    va_start(ap, s);
    vsnprintf(buffer, sizeof(buffer), s, ap);
    for (s = buffer; *s; ++s)
        trace_putchar(*s);
}


void
trace_enable(const char *file)
{
    string_t        *s;

#ifdef DEBUG
    trace_pretest_result = 2;
#endif
    s = base_name(file);
    wl_append_unique(&file_name_list, s);
    str_free(s);
}


void
trace_char_real(char *name, char *vp)
{
    trace_printf("%s = '", name);
    if (*vp < ' ' || *vp > '~' || strchr("(){}[]", *vp))
    {
        char    *s;

        s = strchr("\bb\nn\tt\rr\ff", *vp);
        if (s)
        {
            trace_putchar('\\');
            trace_putchar(s[1]);
        }
        else
            trace_printf("\\%03o", (unsigned char)*vp);
    }
    else
    {
        if (strchr("'\\", *vp))
            trace_putchar('\\');
        trace_putchar(*vp);
    }
    trace_printf("'; /* 0x%02X, %d */\n", (unsigned char)*vp, *vp);
}


void
trace_char_unsigned_real(char *name, unsigned char *vp)
{
    trace_printf("%s = '", name);
    if (*vp < ' ' || *vp > '~' || strchr("(){}[]", *vp))
    {
        char    *s;

        s = strchr("\bb\nn\tt\rr\ff", *vp);
        if (s)
        {
            trace_putchar('\\');
            trace_putchar(s[1]);
        }
        else
            trace_printf("\\%03o", *vp);
    }
    else
    {
        if (strchr("'\\", *vp))
            trace_putchar('\\');
        trace_putchar(*vp);
    }
    trace_printf("'; /* 0x%02X, %d */\n", *vp, *vp);
}


void
trace_int_real(char *name, int *vp)
{
    trace_printf("%s = %d;\n", name, *vp);
}


void
trace_int_unsigned_real(char *name, unsigned int *vp)
{
    trace_printf("%s = %u;\n", name, *vp);
}


void
trace_long_real(char *name, long *vp)
{
    trace_printf("%s = %ld;\n", name, *vp);
}


void
trace_long_unsigned_real(char *name, unsigned long *vp)
{
    trace_printf("%s = %lu;\n", name, *vp);
}


void
trace_pointer_real(char *name, void *vptrptr)
{
    void            **ptr_ptr = vptrptr;
    void            *ptr;

    ptr = *ptr_ptr;
    if (!ptr)
        trace_printf("%s = NULL;\n", name);
    else
        trace_printf("%s = 0x%08lX;\n", name, ptr);
}


void
trace_short_real(char *name, short *vp)
{
    trace_printf("%s = %hd;\n", name, *vp);
}


void
trace_short_unsigned_real(char *name, unsigned short *vp)
{
    trace_printf("%s = %hu;\n", name, *vp);
}


void
trace_string_real(const char *name, const char *vp)
{
    const char      *s;
    long            count;

    trace_printf("%s = ", name);
    if (!vp)
    {
        trace_printf("NULL;\n");
        return;
    }
    trace_printf("\"");
    count = 0;
    for (s = vp; *s; ++s)
    {
        switch (*s)
        {
        case '('/*)*/:
        case '['/*]*/:
        case '{'/*}*/:
            ++count;
            break;

        case /*(*/')':
        case /*[*/']':
        case /*{*/'}':
            --count;
            break;
        }
    }
    if (count > 0)
        count = -count;
    else
        count = 0;
    for (s = vp; *s; ++s)
    {
        int     c;

        c = *s;
        if (c < ' ' || c > '~')
        {
            char    *cp;

            cp = strchr("\bb\ff\nn\rr\tt", c);
            if (cp)
                trace_printf("\\%c", cp[1]);
            else
            {
                escape:
                trace_printf("\\%03o", (unsigned char)c);
            }
        }
        else
        {
            switch (c)
            {
            case '('/*)*/:
            case '['/*]*/:
            case '{'/*}*/:
                ++count;
                if (count <= 0)
                    goto escape;
                break;

            case /*(*/')':
            case /*[*/']':
            case /*{*/'}':
                --count;
                if (count < 0)
                    goto escape;
                break;

            case '\\':
            case '"':
                trace_printf("\\");
                break;
            }
            trace_printf("%c", c);
        }
    }
    trace_printf("\";\n");
}
