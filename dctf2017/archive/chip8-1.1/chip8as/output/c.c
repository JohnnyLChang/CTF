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

#include <common/ac/string.h>

#include <chip8as/output/c.h>
#include <chip8as/output/private.h>


typedef struct output_c_t output_c_t;
struct output_c_t
{
    output_t        inherited;
    output_t        *fp;
    int             column;
};


static void
output_c_close(output_t *op)
{
    output_c_t      *this;

    this = (output_c_t *)op;
    if (this->column)
    {
        output_putc(this->fp, '\n');
        this->column = 0;
    }
    output_puts(this->fp, "};\n");
    output_close(this->fp);
    this->fp = 0;
}


static void
output_c_putc(output_t *op, int c)
{
    output_c_t      *this;

    this = (output_c_t *)op;
    output_putc(this->fp, (this->column ? ' ' : '\t'));
    output_printf(this->fp, "0x%02X,", (unsigned char)c);
    this->column++;
    if (this->column >= 8)
    {
        output_putc(this->fp, '\n');
        this->column = 0;
    }
}


static const char *
output_c_filename(output_t *op)
{
    output_c_t      *this;

    this = (output_c_t *)op;
    return output_filename(this->fp);
}


static output_method_t method =
{
    "c",
    sizeof(output_c_t),
    output_c_close,
    0, /* write */
    output_c_putc,
    0, /* executable */
    output_c_filename,
};


output_t *
output_c_open(output_t *fp)
{
    const char      *filename;
    const char      *name;
    const char      *name_end;
    output_t        *op;
    output_c_t      *this;

    /*
     * figure out the name of the C variable
     */
    filename = output_filename(fp);
    name = strrchr(filename, '/');
    if (name)
        ++name;
    else
        name = filename;
    name_end = strrchr(name, '.');
    if (!name_end)
        name_end = name + strlen(name);

    output_puts(fp, "static unsigned char ");
    output_write(fp, name, name_end - name);
    output_puts(fp, "[] =\n{\n");

    op = output_new(&method);
    this = (output_c_t *)op;
    this->fp = fp;
    this->column = 0;
    return op;
}
