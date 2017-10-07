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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <common/ac/ctype.h>
#include <common/ac/stdio.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>
#include <libexplain/strdup.h>

#include <common/input/asc.h>
#include <common/input/private.h>


typedef struct input_asc_t input_asc_t;
struct input_asc_t
{
    input_t         inherited;
    char            *fn;
    unsigned char   *data;
    int             length;
    int             pos;
};


static int
input_asc_getc(input_t *ip)
{
    input_asc_t     *this;

    this = (input_asc_t *)ip;
    if (this->pos >= this->length)
        return -1;
    return this->data[this->pos++];
}


static int
input_asc_read(input_t *ip, void *buffer, int length)
{
    input_asc_t     *this;

    this = (input_asc_t *)ip;
    if (this->pos + length > this->length)
        length = this->length - this->pos;
    if (length <= 0)
        return 0;
    memcpy(buffer, this->data + this->pos, length);
    this->pos += length;
    return length;
}


static void
input_asc_close(input_t *ip)
{
    input_asc_t     *this;

    this = (input_asc_t *)ip;
    free(this->fn);
    this->fn = 0;
    free(this->data);
    this->data = 0;
    this->pos = 0;
    this->length = 0;
}


static const char *
input_asc_filename(input_t *ip)
{
    input_asc_t     *this;

    this = (input_asc_t *)ip;
    return this->fn;
}


static void
input_asc_seek(input_t *ip, int pos)
{
    input_asc_t     *this;

    this = (input_asc_t *)ip;
    this->pos = pos;
}


static input_method_t method =
{
    "asc",
    sizeof(input_asc_t),
    input_asc_getc,
    input_asc_read,
    input_asc_close,
    input_asc_filename,
    input_asc_seek,
};


static int
calculate_checksum(unsigned char *buffer, int length)
{
    int             result;
    int             j;

    result = 0;
    for (j = 0; j < length; ++j)
    {
        int     byte, nibble;

        byte = buffer[j];
        nibble = byte & 15;
        result = (result >> 4) ^ (((nibble ^ result) & 0xf) * 0x1081);
        nibble = byte >> 4;
        result = (result >> 4) ^ (((nibble ^ result) & 0xf) * 0x1081);
    }
    return (result & 0xFFFF);
}


static int
extract(unsigned char *buffer, int length)
{
    int             result;
    int             j, n;

    result = 0;
    for (j = 0; j < length; ++j)
    {
        n = buffer[j >> 1];
        if (j & 1)
            n >>= 4;
        else
            n &= 15;
        result |= (n << (4 * j));
    }
    return result;
}


static int
get_nybble(input_t *fp)
{
    int             c;

    for (;;)
    {
        c = input_getc(fp);
        switch (c)
        {
        default:
            input_fatal(fp, "format error");

        case '0': case '1': case '2': case '3': case '4':
        case '5': case '6': case '7': case '8': case '9':
            return (c - '0');

        case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
            return (c - 'A' + 10);

        case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
            return (c - 'a' + 10);

        case '"':
            return -1;

        case ' ':
        case '\t':
        case '\n':
        case '\r':
            break;
        }
    }
}


static int
get_byte(input_t *fp)
{
    int             n1, n2;

    n1 = get_nybble(fp);
    if (n1 < 0)
        return -1;
    n2 = get_nybble(fp);
    if (n2 < 0)
        input_fatal(fp, "odd number of nibbles not supported");
    return (n1 | (n2 << 4));
}


input_t *
input_asc_open(input_t *fp)
{
    static char     magic[] = "%%HP: T(3)A(R)F(.);\n\"";
    int             length;
    int             j;
    int             c;
    input_t         *ip;
    input_asc_t     *this;
    int             max;
    unsigned char   *data;
    int             csum_data, csum_give;

    for (j = 0; magic[j]; ++j)
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
            if (j >= 5)
                input_fatal(fp, "malformed ASC header");
            goto barf;
        }
    }

    /*
     * read the data from the file into a memory buffer
     */
    max = 8;
    data = explain_malloc_or_die(max);
    memcpy(data, "HPHP48-A", 8);
    length = 0;
    for (;;)
    {
        c = get_byte(fp);
        if (c < 0)
            break;
        if (length + 8 >= max)
        {
            size_t          new_max;
            unsigned char   *new_data;

            new_max = max ? max * 2 : 8;
            new_data = explain_malloc_or_die(new_max);
            memcpy(new_data, data, length + 8);
            if (data)
                free(data);
            data = new_data;
            max = new_max;
        }
        data[8 + length++] = c;
    }
    if (length < 2)
        input_fatal(fp, "not enough data");

    /*
     * make sure the checksums match
     */
    csum_data = calculate_checksum(data + 8, length - 2);
    csum_give = extract(data + 8 + length - 2, 4);
    if (csum_data != csum_give)
    {
        input_fatal
        (
            fp,
            "data checksum (%04X) does not match checksum in file (%04X)",
            csum_data,
            csum_give
        );
    }

    length += 6;

    ip = input_new(&method);
    this = (input_asc_t *)ip;
    this->fn = explain_strdup_or_die(input_filename(fp));
    input_close(fp);
    this->data = data;
    this->pos = 0;
    this->length = length;
    return ip;
}
