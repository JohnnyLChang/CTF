/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 1998, 2012 Peter Miller
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

#include <common/input/unix.h>
#include <common/input/private.h>


typedef struct input_unix_t input_unix_t;
struct input_unix_t
{
    input_t inherited;
    input_t *fp;
    int     skip;
};


static int
input_unix_getc(input_t *ip)
{
    input_unix_t    *this;

    this = (input_unix_t *)ip;
    return input_getc(this->fp);
}


static int
input_unix_read(input_t *ip, void *buffer, int length)
{
    input_unix_t    *this;

    this = (input_unix_t *)ip;
    return input_read(this->fp, buffer, length);
}


static void
input_unix_close(input_t *ip)
{
    input_unix_t    *this;

    this = (input_unix_t *)ip;
    input_close(this->fp);
    this->fp = 0;
}


static const char *
input_unix_filename(input_t *ip)
{
    input_unix_t    *this;

    this = (input_unix_t *)ip;
    return input_filename(this->fp);
}


static void
input_unix_seek(input_t *ip, int pos)
{
    input_unix_t    *this;

    this = (input_unix_t *)ip;
    input_seek(this->fp, this->skip + pos);
}


static input_method_t method =
{
    "unix",
    sizeof(input_unix_t),
    input_unix_getc,
    input_unix_read,
    input_unix_close,
    input_unix_filename,
    input_unix_seek,
};


input_t *
input_unix_open(input_t *fp)
{
    int             c;
    int             skip;
    input_t         *ip;
    input_unix_t    *this;

    skip = 0;
    c = input_getc(fp);
    if (c != '#')
    {
        barf:
        input_rewind(fp);
        return 0;
    }
    ++skip;

    c = input_getc(fp);
    if (c != '!')
        goto barf;
    ++skip;

    for (;;)
    {
        c = input_getc(fp);
        if (c < 0)
            goto barf;
        ++skip;
        if (c == '\n')
            break;
    }

    ip = input_new(&method);
    this = (input_unix_t *)ip;
    this->fp = fp;
    this->skip = skip;
    return ip;
}
