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

#include <common/ac/stdio.h>
#include <common/ac/sys/stat.h>
#include <common/ac/stdlib.h>
#include <libexplain/fchmod.h>
#include <libexplain/fclose.h>
#include <libexplain/fflush.h>
#include <libexplain/fopen.h>
#include <libexplain/fwrite.h>
#include <libexplain/putc.h>
#include <libexplain/strdup.h>

#include <chip8as/output/raw.h>
#include <chip8as/output/private.h>


typedef struct output_raw_t output_raw_t;
struct output_raw_t
{
    output_t        inherited;
    FILE            *fp;
    char            *fn;
};


static void
output_raw_close(output_t *op)
{
    output_raw_t    *this;

    this = (output_raw_t *)op;
    explain_fflush_or_die(this->fp);
    if (this->fp != stdout)
        explain_fclose_or_die(this->fp);
    this->fp = 0;
    free(this->fn);
    this->fn = 0;
}


static void
output_raw_write(output_t *op, const void *buffer, int length)
{
    output_raw_t    *this;

    this = (output_raw_t *)op;
    explain_fwrite_or_die(buffer, 1, length, this->fp);
}


static void
output_raw_putc(output_t *op, int c)
{
    output_raw_t    *this;

    this = (output_raw_t *)op;
    explain_putc_or_die((unsigned char)c, this->fp);
}


static void
output_raw_executable(output_t *op)
{
    output_raw_t    *this;
    int             um;
    int             mode;

    this = (output_raw_t *)op;
    um = umask(022) & ~0500;
    umask(um);
    mode = 0777 & ~um;
    explain_fchmod_or_die(fileno(this->fp), mode);
}


static const char *
output_raw_filename(output_t *op)
{
    output_raw_t    *this;

    this = (output_raw_t *)op;
    return this->fn;
}


static output_method_t method =
{
    "binary",
    sizeof(output_raw_t),
    output_raw_close,
    output_raw_write,
    output_raw_putc,
    output_raw_executable,
    output_raw_filename,
};


output_t *
output_raw_open(const char *filename)
{
    FILE            *fp;
    output_t        *op;
    output_raw_t    *this;

    if (filename && *filename)
    {
        fp = explain_fopen_or_die(filename, "w");
    }
    else
    {
        fp = stdout;
        filename = "standard output";
    }

    op = output_new(&method);
    this = (output_raw_t *)op;
    this->fp = fp;
    this->fn = explain_strdup_or_die(filename);
    return op;
}
