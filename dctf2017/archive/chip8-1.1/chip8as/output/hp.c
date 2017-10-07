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

#include <common/ac/assert.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>

#include <chip8as/output/hp.h>
#include <chip8as/output/private.h>


typedef struct output_hp_t output_hp_t;
struct output_hp_t
{
    output_t        inherited;
    output_t        *fp;
    unsigned char   *data;
    size_t          maximum;
    size_t          length;
};


static void
output_hp_close(output_t *op)
{
    output_hp_t     *this;
    int             n;
    int             type;
    int             nibbles;
    char            header[13];

    /*
     * The header is 13 bytes long.
     * 8-byte constant string "HPHP48-A"
     * 2.5 bytes type, 0x02A2C for "string"
     * 2.5 bytes length
     */
    this = (output_hp_t *)op;
    memcpy(header, "HPHP48-A\0\0\0\0\0", 13);
    type = 0x02A2C;
    nibbles = 5 + 2 * this->length;
    for (n = 0; n < 5; ++n)
    {
        header[8 + n / 2] |= (type & 0xF) << ((n & 1) * 4);
        type >>= 4;
    }
    for (n = 5; n < 10; ++n)
    {
        header[8 + n / 2] |= (nibbles & 0xF) << ((n & 1) * 4);
        nibbles >>= 4;
    }
    output_write(this->fp, header, 13);

    /*
     * Send the data itself
     */
    output_write(this->fp, this->data, this->length);

    /*
     * close the output
     */
    output_close(this->fp);
    this->fp = 0;
    if (this->data)
        free(this->data);
    this->data = 0;
    this->maximum = 0;
    this->length = 0;
}


static void
output_hp_write(output_t *op, const void *buffer, int length)
{
    output_hp_t     *this;

    this = (output_hp_t *)op;
    assert(length >= 0);
    while (this->length + length > this->maximum)
    {
        size_t          new_maximum;
        unsigned char   *new_data;

        new_maximum = this->maximum ? this->maximum * 2 : 4;
        while (this->length + length > new_maximum)
            new_maximum *= 2;
        new_data = explain_malloc_or_die(new_maximum);
        memcpy(new_data, this->data, this->length);
        if (this->data)
            free(this->data);
        this->data = new_data;
        this->maximum = new_maximum;
    }
    memcpy(this->data + this->length, buffer, length);
    this->length += length;
}


static void
output_hp_putc(output_t *op, int c)
{
    output_hp_t     *this;

    this = (output_hp_t *)op;
    if (this->length >= this->maximum)
    {
        size_t          new_maximum;
        unsigned char   *new_data;

        new_maximum = this->maximum ? this->maximum * 2 : 4;
        new_data = explain_malloc_or_die(new_maximum);
        memcpy(new_data, this->data, new_maximum);
        if (this->data)
            free(this->data);
        this->data = new_data;
        this->maximum = new_maximum;
    }
    this->data[this->length++] = c;
}


static const char *
output_hp_filename(output_t *op)
{
    output_hp_t     *this;

    this = (output_hp_t *)op;
    return output_filename(this->fp);
}


static output_method_t method =
{
    "hp",
    sizeof(output_hp_t),
    output_hp_close,
    output_hp_write,
    output_hp_putc,
    0, /* executable */
    output_hp_filename,
};


output_t *
output_hp_open(output_t *fp)
{
    output_t        *op;
    output_hp_t     *this;

    op = output_new(&method);
    this = (output_hp_t *)op;
    this->fp = fp;
    this->data = 0;
    this->length = 0;
    this->maximum = 0;
    return op;
}
