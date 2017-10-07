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
 *
 *
 * This format is used on HP48 calculators as a file transfer format,
 * similar in purpose to uuencode.
 */

#include <common/config.h>
#include <libexplain/output.h>

#include <chip8as/output/asc.h>
#include <chip8as/output/private.h>


typedef struct output_asc_t output_asc_t;
struct output_asc_t
{
    output_t        inherited;
    output_t        *fp;
    int             column;
    int             checksum;
    const char      *confirm;
};


static void
emit_nybble(output_asc_t *this, int n)
{
    /*
     * emit the nibble
     */
    n &= 15;
    output_putc(this->fp, "0123456789ABCDEF"[n]);
    this->column++;
    if (this->column >= 64)
    {
        output_putc(this->fp, '\n');
        this->column = 0;
    }

    /*
     * include the nibble in the checksum
     */
    this->checksum =
        (this->checksum >> 4) ^ (((n ^ this->checksum) & 0xf) * 0x1081);
}


static void
emit_byte(output_asc_t *this, int n)
{
    emit_nybble(this, n);
    emit_nybble(this, n >> 4);
}


static void
emit_word(output_asc_t *this, int n)
{
    emit_byte(this, n);
    emit_byte(this, n >> 8);
}


static void
output_asc_close(output_t *op)
{
    output_asc_t    *this;

    this = (output_asc_t *)op;
    emit_word(this, this->checksum);
    output_puts(this->fp, "\"\n");
    output_close(this->fp);
    this->fp = 0;
}


static void
output_asc_putc(output_t *op, int c)
{
    output_asc_t    *this;

    this = (output_asc_t *)op;
    if (this->confirm)
    {
        if (c != this->confirm[0])
        {
            explain_output_error_and_die
            (
                "%s: can only use ASC format with HP format",
                output_filename(this->fp)
            );
        }
        this->confirm++;
        if (!this->confirm[0])
            this->confirm = 0;
    }
    else
        emit_byte(this, c);
}


static const char *
output_asc_filename(output_t *op)
{
    output_asc_t    *this;

    this = (output_asc_t *)op;
    return output_filename(this->fp);
}


static output_method_t method =
{
    "asc",
    sizeof(output_asc_t),
    output_asc_close,
    0, /* write */
    output_asc_putc,
    0, /* executable */
    output_asc_filename,
};


output_t *
output_asc_open(output_t *fp)
{
    output_t        *op;
    output_asc_t    *this;

    output_puts(fp, "%%HP: T(3)A(R)F(.);\n\"");

    op = output_new(&method);
    this = (output_asc_t *)op;
    this->fp = fp;
    this->column = 0;
    this->checksum = 0;
    this->confirm = "HPHP48-A";
    return op;
}
