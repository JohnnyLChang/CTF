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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <common/ac/ctype.h>
#include <common/ac/stdio.h>

#include <common/input/hp.h>
#include <common/input/private.h>


typedef struct input_hp_t input_hp_t;
struct input_hp_t
{
    input_t inherited;
    input_t *fp;
    int     length;
    int     pos;
};


static int
input_hp_getc(input_t *ip)
{
    input_hp_t      *this;
    int             c;

    this = (input_hp_t *)ip;
    if (this->pos >= this->length)
        return -1;
    c = input_getc(this->fp);
    if (c < 0)
    {
        input_fatal
        (
            this->fp,
            "file shorter (%d) than internal length (%d)",
            this->pos,
            this->length
        );
    }
    this->pos++;
    return c;
}


static int
input_hp_read(input_t *ip, void *p, int length)
{
    input_hp_t      *this;
    unsigned char   *buffer;
    int             j, c;

    this = (input_hp_t *)ip;
    buffer = p;
    for (j = 0; j < length; ++j)
    {
        c = input_getc(this->fp);
        if (c < 0)
            break;
        *buffer++ = c;
    }
    return j;
}


static void
input_hp_close(input_t *ip)
{
    input_hp_t      *this;

    this = (input_hp_t *)ip;
    input_close(this->fp);
    this->fp = 0;
    this->pos = 0;
    this->length = 0;
}


static const char *
input_hp_filename(input_t *ip)
{
    input_hp_t      *this;

    this = (input_hp_t *)ip;
    return input_filename(this->fp);
}


static void
input_hp_seek(input_t *ip, int pos)
{
    input_hp_t      *this;

    this = (input_hp_t *)ip;
    input_seek(this->fp, 13 + pos);
    this->pos = pos;
}


static input_method_t method =
{
    "hp",
    sizeof(input_hp_t),
    input_hp_getc,
    input_hp_read,
    input_hp_close,
    input_hp_filename,
    input_hp_seek,
};


static int
extract(unsigned char *buffer, int offset, int length)
{
    int             result;
    int             j, n;

    result = 0;
    for (j = 0; j < length; ++j)
    {
        n = offset + j;
        if (n & 1)
            n = buffer[n >> 1] >> 4;
        else
            n = buffer[n >> 1] & 15;
        result |= (n << (4 * j));
    }
    return result;
}


input_t *
input_hp_open(input_t *fp)
{
    static char     magic[7] = "HPHP48-";
    int             type;
    int             length;
    int             j;
    int             c;
    unsigned char   buffer[5];
    input_t         *ip;
    input_hp_t      *this;

    for (j = 0; j < 7; ++j)
    {
        c = input_getc(fp);
        if (c < 0)
        {
            barf:
            input_rewind(fp);
            return 0;
        }
        if (c != magic[j])
        {
            if (j >= 2)
                input_fatal(fp, "malformed HP header");
            goto barf;
        }
    }
    c = input_getc(fp);
    if (c < 0 || !isupper(c))
        goto barf;

    if (input_read(fp, buffer, 5) != 5)
        goto barf;
    type = extract(buffer, 0, 5);
    if (type != 0x02A2C)
        input_fatal(fp, "type 0x%05X not supported", type);
    length = extract(buffer, 5, 5);
    length -= 5;
    if (length < 0 || (length & 1))
        input_fatal(fp, "length %d not supported", length);
    length >>= 1;

    ip = input_new(&method);
    this = (input_hp_t *)ip;
    this->fp = fp;
    this->pos = 0;
    this->length = length;
    return ip;
}
