/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 1998, 2012 Peter Miller
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 */

#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <libexplain/fclose.h>
#include <libexplain/fopen.h>
#include <libexplain/fread.h>
#include <libexplain/fseek.h>
#include <libexplain/getc.h>
#include <libexplain/strdup.h>

#include <common/input/binary.h>
#include <common/input/private.h>


typedef struct input_binary_t input_binary_t;
struct input_binary_t
{
    input_t inherited;
    FILE    *fp;
    char    *fn;
};


static int
input_binary_getc(input_t *ip)
{
    input_binary_t  *this;
    int             c;

    this = (input_binary_t *)ip;
    c = explain_getc_or_die(this->fp);
    if (c == EOF)
    {
        return -1;
    }
    return c;
}


static int
input_binary_read(input_t *ip, void *buffer, int length)
{
    input_binary_t  *this;
    int             n;

    this = (input_binary_t *)ip;
    n = explain_fread_or_die(buffer, 1, length, this->fp);
    return n;
}


static void
input_binary_close(input_t *ip)
{
    input_binary_t  *this;

    this = (input_binary_t *)ip;
    if (this->fp != stdin)
        explain_fclose_or_die(this->fp);
    this->fp = 0;
    free(this->fn);
    this->fn = 0;
}


static const char *
input_binary_filename(input_t *ip)
{
    input_binary_t  *this;

    this = (input_binary_t *)ip;
    return this->fn;
}


static void
input_binary_seek(input_t *ip, int pos)
{
    input_binary_t  *this;

    this = (input_binary_t *)ip;
    explain_fseek_or_die(this->fp, pos, SEEK_SET);
}


static input_method_t method =
{
    "binary",
    sizeof(input_binary_t),
    input_binary_getc,
    input_binary_read,
    input_binary_close,
    input_binary_filename,
    input_binary_seek,
};


input_t *
input_binary_open(const char *filename)
{
    FILE            *fp;
    input_t         *ip;
    input_binary_t  *this;

    if (filename && *filename)
    {
        fp = explain_fopen_or_die(filename, "r");
    }
    else
    {
        fp = stdin;
        filename = "standard input";
    }

    ip = input_new(&method);
    this = (input_binary_t *)ip;
    this->fp = fp;
    this->fn = explain_strdup_or_die(filename);
    return ip;
}
