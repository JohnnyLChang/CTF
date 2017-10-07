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

#include <common/trace.h>

#include <chip8as/col.h>
#include <chip8as/emit.h>
#include <chip8as/lex.h>
#include <chip8as/option.h>
#include <chip8as/output.h>

#define MEM_MIN 0x0200
#define MEM_MAX 0x1000

static const char *filename;
static char     memory[MEM_MAX];
static char     *pc;
static int      addr_col;
static int      code_col;
static int      linum_col;
static int      source_col;
static int      have_addr;
static int      listing;
static int      pass;


void
emit_open(const char *s)
{
    trace(("emit_open(s = %08lX)\n{\n"/*}*/, s));
    trace_string(s);
    filename = s;
    pc = memory + MEM_MIN;

    s = option_get_listfile();
    if (s)
    {
        listing = 1;
        col_open(s);
        addr_col = col_create(0, 5);
        col_heading(addr_col, "Addr\n-----");
        code_col = col_create(6, 18);
        col_heading(code_col, "Opcodes\n---------");
        linum_col = col_create(19, 24);
        col_heading(linum_col, "Line\n----");
        source_col = col_create(24, 79);
        col_heading(source_col, "Source Text\n--------------");
    }
    trace((/*{*/"}\n"));
}


void
emit_rewind(void)
{
    trace(("emit_rewind()\n{\n"/*}*/));
    pass = 2;
    pc = memory + MEM_MIN;
    trace((/*{*/"}\n"));
}


void
emit_close(void)
{
    output_t        *op;
    long            size;

    trace(("emit_close()\n{\n"/*}*/));
    size = (pc - memory) - MEM_MIN;
    while (size > 0 && memory[size + MEM_MIN - 1] == 0)
        --size;
    op = output_open(filename);
    output_write(op, memory + MEM_MIN, size);
    output_close(op);
    if (listing)
        col_close();
    trace((/*{*/"}\n"));
}


static int
prog_too_big(int n)
{
    static int winged;
    if (pc + n - memory <= 0x1000)
        return 0;
    if (pass == 2 && !winged)
    {
        winged = 1;
        lex_error("program too large");
    }
    return 1;
}


void
emit_byte(int n)
{
    trace(("emit_byte(n = 0x%02X)\n{\n"/*}*/, (unsigned char)n));
    if (pass == 2 && listing)
    {
        if (!have_addr)
        {
            col_printf(addr_col, "%03X", pc - memory);
            have_addr = 1;
        }
        col_printf(code_col, "%02X ", (unsigned char)n);
    }
    if (!prog_too_big(1))
        *pc = n;
    pc++;
    trace((/*{*/"}\n"));
}


void
emit_word(int n)
{
    trace(("emit_word(n = 0x%04X)\n{\n"/*}*/, (unsigned short)n));
    if ((pc - memory) & 1)
    {
        lex_error("opcode at odd address");
        emit_byte(0);
    }
    if (pass == 2 && listing)
    {
        if (!have_addr)
        {
            col_printf(addr_col, "%03X", pc - memory);
            have_addr = 1;
        }
        col_printf(code_col, "%04X ", (unsigned short)n);
    }
    if (!prog_too_big(2))
    {
        pc[0] = n >> 8;
        pc[1] = n;
    }
    pc += 2;
    trace((/*{*/"}\n"));
}


void
emit_eoln(void)
{
    trace(("emit_eoln()\n{\n"/*}*/));
    if (pass == 2 && listing)
    {
        col_eoln();
        have_addr = 0;
    }
    trace((/*{*/"}\n"));
}


long
emit_get_pc(void)
{
    return (pc - memory);
}


void
emit_listing(int linum, const char *line)
{
    if (pass == 2 && listing)
    {
        col_bol(linum_col);
        col_printf(linum_col, "%d", linum);
        col_bol(source_col);
        col_printf(source_col, "%s", line);
    }
}


void
emit_error(const char *s)
{
    if (pass == 2 && listing)
    {
        col_bol(source_col);
        col_printf(source_col, "Error: %s", s);
    }
}


void
emit_warning(const char *s)
{
    if (pass == 2 && listing)
    {
        col_bol(source_col);
        col_printf(source_col, "Warning: %s", s);
    }
}


void
emit_list_addr(int n)
{
    if (pass ==2 && listing)
    {
        col_bol(addr_col);
        col_printf(addr_col, "%03X", n);
        have_addr = 1;
    }
}


void
emit_list_code(int n)
{
    if (pass == 2 && listing)
    {
        col_bol(code_col);
        col_printf(code_col, "%04X", n);
    }
}


void
emit_storage(long size, long value)
{
    if (pass == 2 && listing)
    {
        if (!have_addr)
        {
            col_printf(addr_col, "%03X", pc - memory);
            have_addr = 1;
        }
        if (size != 1)
            col_printf(code_col, "(%X) ", (unsigned short)size);
        col_printf(code_col, "%02X ", (unsigned char)value);
    }
    if (!prog_too_big(size))
    {
        int     j;

        for (j = 0; j < size; ++j)
            pc[j] = value;
    }
    pc += size;
}


void
emit_title(const char *s1, const char *s2)
{
    col_title(s1, s2);
}
