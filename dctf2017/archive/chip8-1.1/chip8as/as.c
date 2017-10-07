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

#include <common/ac/string.h>
#include <libexplain/malloc.h>

#include <common/sizeof.h>
#include <common/str.h>
#include <common/trace.h>

#include <chip8as/as.h>
#include <chip8as/cross_refer.h>
#include <chip8as/emit.h>
#include <chip8as/expr.h>
#include <chip8as/id.h>
#include <chip8as/lex.h>

#define PAIR(a, b) (((a) << 8) | (b))

static  int     xref_on;


static void
address_check(long addr)
{
    if (addr < 0x0200 || addr >= 0x1000)
        lex_error("address 0x%03X out of range", addr);
}


static void
byte_check(long value)
{
    if (value < -128 || value >= 256)
        lex_error("value %d out of range", value);
}


static void
parse_line(void)
{
    string_t        *name;
    string_t        *name2;
    expr_t          *opcode_symbol;
    size_t          argc;
    static size_t   argc_max;
    static expr_t   **argv;

    trace(("parse_line()\n{\n"/*}*/));
    argc = 0;
    if (argc_max == 0)
    {
        argc_max = 4;
        argv = explain_malloc_or_die(argc_max * sizeof(argv[0]));
    }
    if (lex_token == lex_token_name)
    {
        name = lex_value.lv_name;
        lex();
        switch (lex_token)
        {
        case lex_token_equ:
            lex();
            argv[0] = expr();
            if (!argv[0])
                break;
            argv[1] = id_search(name);
            if (argv[1])
            {
                if
                (
                    argv[0]->type != argv[1]->type
                ||
                    argv[0]->value != argv[1]->value
                )
                    lex_error("symbol \"%s\" changed value", name->str_text);
            }
            else
            {
                if (argv[0]->defined)
                {
                    expr_t  *ep;

                    ep = expr_clone(argv[0]);
                    expr_bump_def(ep);
                    id_define(name, ep);
                }
            }
            str_free(name);
            switch (argv[0]->type)
            {
            default:
                /* don't list register numbers, etc */
                break;

            case type_relative:
                emit_list_addr(argv[0]->value);
                address_check(argv[0]->value);
                break;

            case type_absolute:
                emit_list_code(argv[0]->value);
                break;
            }
            expr_delete(argv[0]);
            goto done;

        case lex_token_colon:
            lex();
            argv[0] = expr_new(type_relative);
            argv[0]->value = emit_get_pc();
            argv[0]->defined = 1;

            argv[1] = id_search(name);
            if (argv[1])
            {
                if
                (
                    argv[0]->type != argv[1]->type
                ||
                    argv[0]->value != argv[1]->value
                )
                    lex_error("label \"%s\" changed value", name->str_text);
            }
            else
            {
                expr_t  *ep;

                ep = expr_clone(argv[0]);
                expr_bump_def(ep);
                id_define(name, ep);
            }
            emit_list_addr(argv[0]->value);
            address_check(argv[0]->value);
            expr_delete(argv[0]);
            break;

        default:
            goto have_name;
        }
    }

    switch (lex_token)
    {
    default:
        lex_error("opcode expected");
        goto bomb;

    case lex_token_eoln:
        break;

    case lex_token_name:
        name = lex_value.lv_name;
        lex();
have_name:
        /*
         * Look for pre-processing pseudo-ops here,
         * because we collect their arguments differently.
         */
        name2 = str_downcase(name);
        opcode_symbol = id_search(name2);
        if (!opcode_symbol)
        {
            string_t        *guess;

            opcode_symbol = id_search_fuzzy(name2, &guess);
            if
            (
                opcode_symbol
            &&
                opcode_symbol->type != type_opcode
            &&
                opcode_symbol->type != type_preprocess
            )
                opcode_symbol = 0;
            if (opcode_symbol)
            {
                lex_error
                (
              "opcode ``%s'' unknown, closest is the ``%s'' opcode",
                    name->str_text,
                    guess->str_text
                );
            }
        }
        str_free(name2);

        if (opcode_symbol && opcode_symbol->type == type_preprocess)
        {
            if (lex_token != lex_token_eof && lex_token != lex_token_eoln)
            {
                for (;;)
                {
                    if (argc >= argc_max)
                    {
                        size_t new_argc_max;
                        size_t nbytes;
                        expr_t **new_argv;
                        size_t j;

                        new_argc_max = argc_max ? argc_max * 2 : 4;
                        nbytes = new_argc_max * sizeof(argv[0]);
                        new_argv = explain_malloc_or_die(nbytes);
                        for (j = 0; j < argc; ++j)
                            new_argv[j] = argv[j];
                        for (; j < new_argc_max; ++j)
                            new_argv[j] = 0;
                        if (argv)
                            free(argv);
                        argv = new_argv;
                        argc_max = new_argc_max;
                    }
                    argv[argc] = name_or_string();
                    if (!argv[argc])
                        goto bomb;
                    ++argc;
                    if (lex_token != lex_token_comma)
                        break;
                    lex();
                    if (lex_token == lex_token_eoln)
                        lex();
                }
            }
            opcode_symbol->func(argc, argv);
            goto op_done;
        }

        if (lex_token != lex_token_eof && lex_token != lex_token_eoln)
        {
            for (;;)
            {
                if (argc >= argc_max)
                {
                    size_t          new_argc_max;
                    size_t          nbytes;
                    expr_t          **new_argv;
                    size_t          j;

                    new_argc_max = argc_max ? argc_max * 2 : 4;
                    nbytes = new_argc_max * sizeof(argv[0]);
                    new_argv = explain_malloc_or_die(nbytes);
                    for (j = 0; j < argc; ++j)
                        new_argv[j] = argv[j];
                    for (; j < new_argc_max; ++j)
                        new_argv[j] = 0;
                    if (argv)
                        free(argv);
                    argv = new_argv;
                    argc_max = new_argc_max;
                }
                argv[argc] = expr();
                if (!argv[argc])
                    goto bomb;
                ++argc;
                if (lex_token != lex_token_comma)
                    break;
                lex();
                if (lex_token == lex_token_eoln)
                    lex();
            }
        }
        if (opcode_symbol && opcode_symbol->type == type_opcode)
            opcode_symbol->func(argc, argv);
        else
            lex_error("unknown \"%s\" opcode", name->str_text);
        op_done:
        while (argc-- > 0)
            expr_delete(argv[argc]);
        break;
    }
done:
    if (lex_token != lex_token_eoln && lex_token != lex_token_eof)
    {
        lex_error("end-of-line expected");
bomb:
        for (;;)
        {
            lex();
            if (lex_token == lex_token_eof)
                break;
            if (lex_token == lex_token_eoln)
                break;
            if (lex_token == lex_token_name || lex_token == lex_token_string)
                str_free(lex_value.lv_name);
        }
    }
    emit_eoln();
    lex();
    trace((/*{*/"}\n"));
}


static void
assemble_clear(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode clear: takes no arguments");
    emit_word(0x00E0);
}


static void
assemble_ret(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode ret: takes no arguments");
    emit_word(0x00EE);
}


static void
assemble_jump(int argc, expr_t **argv)
{
    if (argc != 1 && argc != 2)
        lex_error("opcode jump: takes 1 or 2 arguments");
    if (argc < 1)
        return;

    if (argc == 1)
    {
        if (argv[0]->type != type_relative)
        {
            lex_error("opcode jump: invalid type");
            return;
        }
        address_check(argv[0]->value);
        emit_word(0x1000 | (argv[0]->value & 0xFFF));
    }
    else
    {
        if
        (
            argv[0]->type != type_relative
        ||
            argv[1]->type != type_v_reg
        ||
            argv[1]->value != 0
        )
            lex_error("opcode jump: incompatible types");
        else
            address_check(argv[0]->value);
        emit_word(0xB000 | (argv[0]->value & 0xFFF));
    }
}


static void
assemble_call(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode call: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_relative)
        lex_error("opcode call: invalid type");
    address_check(argv[0]->value);
    emit_word(0x2000 | (argv[0]->value & 0xFFF));
}


static void
assemble_load(int argc, expr_t **argv)
{
    int             n;

    if (argc != 2)
        lex_error("opcode load: takes 2 arguments");
    if (argc < 2)
        return;

    switch (PAIR(argv[0]->type, argv[1]->type))
    {
    default:
        lex_error("opcode load: incompatible types");
        emit_word(0);
        break;

    case PAIR(type_v_reg, type_absolute):
        emit_word(0x6000 | (argv[0]->value << 8) | (argv[1]->value & 0xFF));
        byte_check(argv[0]->value);
        break;

    case PAIR(type_bcd_reg, type_v_reg):
        n = argv[1]->value;
        lex_warning
        (
            "the form ``bcd v%X'' is preferred over ``ld b, v%X'' for clarity",
            n,
            n
        );
        emit_word(0xF033 | (n << 8));
        break;

    case PAIR(type_font_reg, type_v_reg):
        n = argv[1]->value;
        lex_warning
        (
         "the form ``hex v%X'' is preferred over ``ld f, v%X'' for clarity",
            n,
            n
        );
        emit_word(0xF029 | (n << 8));
        break;

    case PAIR(type_xfont_reg, type_v_reg):
        n = argv[1]->value;
        lex_warning
        (
       "the form ``xhex v%X'' is preferred over ``ld hf, v%X'' for clarity",
            n,
            n
        );
        emit_word(0xF030 | (n << 8));
        break;

    case PAIR(type_v_reg, type_v_reg):
        emit_word(0x8000 | (argv[0]->value << 8) | (argv[1]->value << 4));
        break;

    case PAIR(type_v_reg, type_key):
        emit_word(0xF00A | (argv[0]->value << 8));
        break;

    case PAIR(type_v_reg, type_time_reg):
        emit_word(0xF007 | (argv[0]->value << 8));
        break;

    case PAIR(type_time_reg, type_v_reg):
        emit_word(0xF015 | (argv[1]->value << 8));
        break;

    case PAIR(type_tone_reg, type_v_reg):
        emit_word(0xF018 | (argv[1]->value << 8));
        break;

    case PAIR(type_i_reg, type_relative):
        emit_word(0xA000 | (argv[1]->value & 0xFFF));
        address_check(argv[1]->value);
        break;

    case PAIR(type_i_indirect, type_v_reg):
        /* save */
        emit_word(0xF055 | (argv[1]->value << 8));
        break;

    case PAIR(type_v_reg, type_i_indirect):
        /* restore */
        emit_word(0xF065 | (argv[0]->value << 8));
        break;

    case PAIR(type_r_reg, type_v_reg):
        /* flags.save */
        if (argv[1]->value >= 8)
        {
            lex_error("opcode flags.save: only flags 0..7 may be saved");
        }
        emit_word(0xF075 | (argv[1]->value << 8));
        break;

    case PAIR(type_v_reg, type_r_reg):
        /* flags.restore */
        if (argv[0]->value >= 8)
        {
            lex_error("opcode flags.restore: only flags 0..7 may be restored");
        }
        emit_word(0xF085 | (argv[0]->value << 8));
        break;
    }
}


static void
assemble_skip_eq(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode skip.eq: takes 2 arguments");
    if (argc < 2)
        return;

    switch (PAIR(argv[0]->type, argv[1]->type))
    {
    default:
        lex_error("opcode skip.eq: incompatible types");
        emit_word(0);
        break;

    case PAIR(type_v_reg, type_absolute):
        emit_word(0x3000 | (argv[0]->value << 8) | (argv[1]->value & 0xFF));
        byte_check(argv[1]->value);
        break;

    case PAIR(type_v_reg, type_v_reg):
        emit_word(0x5000 | (argv[0]->value << 8) | (argv[1]->value << 4));
        break;

    case PAIR(type_v_reg, type_key):
        emit_word(0xE09E | (argv[0]->value << 8));
        break;
    }
}


static void
assemble_skp(int argc, expr_t **argv)
{
    int             n;

    if (argc != 1)
        lex_error("opcode skp: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
    {
        lex_error("opcode skp: incompatible type");
        emit_word(0);
        return;
    }
    n = argv[0]->value;
    lex_warning
    (
      "the form ``skip.eq v%X, key'' is preferred over ``skp v%X'' for clarity",
        n,
        n
    );
    emit_word(0xE09E | (n << 8));
}


static void
assemble_skip_ne(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode skip.ne: takes 2 arguments");
    if (argc < 2)
        return;

    switch (PAIR(argv[0]->type, argv[1]->type))
    {
    default:
        lex_error("opcode skip.ne: incompatible types");
        emit_word(0);
        break;

    case PAIR(type_v_reg, type_absolute):
        emit_word(0x4000 | (argv[0]->value << 8) | (argv[1]->value & 0xFF));
        byte_check(argv[1]->value);
        break;

    case PAIR(type_v_reg, type_v_reg):
        emit_word(0x9000 | (argv[0]->value << 8) | (argv[1]->value << 4));
        break;

    case PAIR(type_v_reg, type_key):
        emit_word(0xE0A1 | (argv[0]->value << 8));
        break;
    }
}


static void
assemble_sknp(int argc, expr_t **argv)
{
    int             n;

    if (argc != 1)
        lex_error("opcode sknp: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
    {
        lex_error("opcode sknp: incompatible type");
        emit_word(0);
        return;
    }
    n = argv[0]->value;
    lex_warning
    (
     "the form ``skip.ne v%X, key'' is preferred over ``sknp v%X'' for clarity",
        n,
        n
    );
    emit_word(0xE0A1 | (n << 8));
}


static void
assemble_add(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode add: takes 2 arguments");
    if (argc < 2)
        return;

    switch (PAIR(argv[0]->type, argv[1]->type))
    {
    default:
        lex_error("opcode add: incompatible types");
        emit_word(0);
        break;

    case PAIR(type_v_reg, type_absolute):
        emit_word(0x7000 | (argv[0]->value << 8) | (argv[1]->value & 0xFF));
        byte_check(argv[1]->value);
        break;

    case PAIR(type_v_reg, type_v_reg):
        emit_word(0x8004 | (argv[0]->value << 8) | (argv[1]->value << 4));
        break;

    case PAIR(type_i_reg, type_v_reg):
        emit_word(0xF01E | (argv[1]->value << 8));
        break;
    }
}


static void
assemble_or(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode or: takes 2 arguments");
    if (argc < 2)
        return;

    if (argv[0]->type != type_v_reg || argv[1]->type != type_v_reg)
        lex_error("opcode or: incompatible types");
    emit_word(0x8001 | (argv[0]->value << 8) | (argv[1]->value << 4));
}


static void
assemble_and(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode and: takes 2 arguments");
    if (argc < 2)
        return;

    if (argv[0]->type != type_v_reg || argv[1]->type != type_v_reg)
        lex_error("opcode and: incompatible types");
    emit_word(0x8002 | (argv[0]->value << 8) | (argv[1]->value << 4));
}


static void
assemble_xor(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode xor: takes 2 arguments");
    if (argc < 2)
        return;

    if (argv[0]->type != type_v_reg || argv[1]->type != type_v_reg)
        lex_error("opcode xor: incompatible types");
    emit_word(0x8003 | (argv[0]->value << 8) | (argv[1]->value << 4));
}


static void
assemble_sub(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode sub: takes 2 arguments");
    if (argc < 2)
        return;

    switch (PAIR(argv[0]->type, argv[1]->type))
    {
    default:
        lex_error("opcode sub: incompatible types");
        emit_word(0);
        break;

    case PAIR(type_v_reg, type_absolute):
        emit_word(0x7000 | (argv[0]->value << 8) | (-argv[1]->value & 0xFF));
        byte_check(argv[1]->value);
        break;

    case PAIR(type_v_reg, type_v_reg):
        emit_word(0x8005 | (argv[0]->value << 8) | (argv[1]->value << 4));
        break;
    }
}


static void
assemble_lsr(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode lsr: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode lsr: invalid type");
    emit_word(0x8006 | (argv[0]->value << 8));
}


static void
assemble_dif(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode dif: takes 2 arguments");
    if (argc < 2)
        return;

    if (argv[0]->type != type_v_reg || argv[1]->type != type_v_reg)
        lex_error("opcode dif: incompatible types");
    emit_word(0x8007 | (argv[0]->value << 8) | (argv[1]->value << 4));
}


static void
assemble_lsl(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode lsl: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode lsl: invalid type");
    emit_word(0x800E | (argv[0]->value << 8));
}


static void
assemble_rnd(int argc, expr_t **argv)
{
    if (argc != 2)
        lex_error("opcode dif: takes 2 arguments");
    if (argc < 2)
        return;

    if (argv[0]->type != type_v_reg || argv[1]->type != type_absolute)
        lex_error("opcode rnd: incompatible types");
    else
        byte_check(argv[1]->value);
    emit_word(0xC000 | (argv[0]->value << 8) | (argv[1]->value & 0xFF));
}


static void
assemble_draw(int argc, expr_t **argv)
{
    int             n;

    if (argc != 3 && argc != 2)
        lex_error("opcode draw: takes 3 arguments");
    if (argc < 2)
        return;

    if
    (
        argv[0]->type != type_v_reg
    ||
        argv[1]->type != type_v_reg
    ||
        (argc >= 3 && argv[2]->type != type_absolute)
    )
    {
        lex_error("opcode draw: incompatible types");
        emit_word(0);
        return;
    }

    if (argc < 3)
        n = 0; /* xdraw */
    else
    {
        n = argv[2]->value;
        if (n < 1 || n >= 16)
        {
            lex_error("opcode draw: byte count (%d) out of range", n);
            return;
        }
    }
    emit_word(0xD000 | (argv[0]->value << 8) | (argv[1]->value << 4) | n);
}


static void
assemble_hex(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode hex: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode hex: invalid type");
    emit_word(0xF029 | (argv[0]->value << 8));
}


static void
assemble_xhex(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode xhex: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode xhex: invalid type");
    emit_word(0xF030 | (argv[0]->value << 8));
}


static void
assemble_bcd(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode bcd: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode bcd: invalid type");
    emit_word(0xF033 | (argv[0]->value << 8));
}


static void
assemble_save(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode save: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode save: invalid type");
    emit_word(0xF055 | (argv[0]->value << 8));
}


static void
assemble_restore(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode restore: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode restore: invalid type");
    emit_word(0xF065 | (argv[0]->value << 8));
}


static void
assemble_flags_save(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode flags.save: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode flags.save: invalid type");
    if (argv[0]->type == type_v_reg && argv[0]->value >= 8)
        lex_error("opcode flags.save: only flags 0..7 may be saved");
    emit_word(0xF075 | (argv[0]->value << 8));
}


static void
assemble_flags_restore(int argc, expr_t **argv)
{
    if (argc != 1)
        lex_error("opcode flags.restore: takes 1 argument");
    if (argc < 1)
        return;

    if (argv[0]->type != type_v_reg)
        lex_error("opcode flags.restore: invalid type");
    if (argv[0]->type == type_v_reg && argv[0]->value >= 8)
        lex_error("opcode flags.save: only flags 0..7 may be restored");
    emit_word(0xF085 | (argv[0]->value << 8));
}


static void
assemble_align(int argc, expr_t **argv)
{
    if (argc >= 2)
        lex_error("opcode .align: takes 0 or 1 arguments");
    if (argc < 1)
    {
        argv[0] = expr_new(type_absolute);
        argv[0]->value = 2;
        argv[0]->defined = 1;
    }

    if (argv[0]->type != type_absolute)
    {
        lex_error("opcode .align: invalid type");
        return;
    }
    if (!argv[0]->defined)
    {
        lex_error("opcode .align: value must be defined");
        return;
    }
    if (argv[0]->value < 2)
    {
        lex_error("opcode .align: value must be >= 2");
        return;
    }
    while (emit_get_pc() % argv[0]->value)
        emit_byte(0);
}


static void
assemble_ascii(int argc, expr_t **argv)
{
    int             j, k;
    int             c;

    if (argc < 1)
        lex_error("opcode .ascii: takes at least 1 argument");
    if (argc < 1)
        return;

    for (j = 0; j < argc; ++j)
    {
        if (argv[j]->type != type_string)
        {
            lex_error("opcode .ascii: arg %d: invalid type", j);
            return;
        }
    }
    for (j = 0; j < argc; ++j)
    {
        for (k = 0; ; ++k)
        {
            c = argv[j]->string->str_text[k];
            if (!c)
                break;
            emit_byte(c);
        }
    }
}


static void
assemble_byte(int argc, expr_t **argv)
{
    int             j;

    if (argc < 1)
        lex_error("opcode .byte: takes at least 1 argument");
    if (argc < 1)
        return;

    for (j = 0; j < argc; ++j)
    {
        if (argv[j]->type != type_absolute)
        {
            lex_error("opcode .byte: arg %d: invalid type", j);
            return;
        }
    }
    for (j = 0; j < argc; ++j)
    {
        emit_byte(argv[j]->value);
        byte_check(argv[j]->value);
    }
}


static void
assemble_word(int argc, expr_t **argv)
{
    int             j;

    if (argc < 1)
        lex_error("opcode .word: takes at least 1 argument");
    if (argc < 1)
        return;

    for (j = 0; j < argc; ++j)
    {
        if (argv[j]->type != type_absolute)
        {
            lex_error("opcode .word: arg %d: invalid type", j);
            return;
        }
    }
    for (j = 0; j < argc; ++j)
        emit_word(argv[j]->value);
}


static void
assemble_pic(int argc, expr_t **argv)
{
    size_t          x;
    int             y;
    size_t          width;

    if (argc < 1)
        lex_error("opcode .pic: takes at least 1 argument");
    if (argc < 1)
        return;

    for (y = 0; y < argc; ++y)
    {
        if (argv[y]->type != type_string)
        {
            lex_error("opcode .pic: arg %d: invalid type", y);
            return;
        }
        if (strpbrk(argv[y]->string->str_text, "\t\f\r\n\b"))
            lex_error("opcode .pic: arg %d: may only use spaces", y);
    }
    width = argv[0]->string->str_length;
    for (y = 1; y < argc; ++y)
    {
        if (argv[y]->string->str_length != width)
        {
            lex_error
            (
                "opcode .pic: all picture scan lines must be the same length"
            );
            return;
        }
    }
    for (x = 0; x < width; x += 8)
    {
        for (y = 0; y < argc; ++y)
        {
            int     byte;
            int     bit;

            byte = 0;
            for (bit = 0; bit < 8; bit++)
            {
                if
                (
                    x + bit < width && argv[y]->string->str_text[x + bit] != ' '
                )
                {
                    byte |= 0x80 >> bit;
                }
            }
            emit_byte(byte);
        }
    }
}


static string_t *
blank(int n)
{
    static char     *buffer;
    static int      max;

    if (n > max)
    {
        if (buffer)
            free(buffer);
        max = n;
        buffer = explain_malloc_or_die(max);
        memset(buffer, ' ', n);
    }
    return str_n_from_c(buffer, n);
}


static void
assemble_xpic(int argc, expr_t **argv)
{
    size_t          x;
    int             y;
    size_t          width;

    if (argc < 1)
        lex_error("opcode .xpic: takes at least 1 argument");
    if (argc < 1)
        return;

    for (y = 0; y < argc; ++y)
    {
        if (argv[y]->type != type_string)
        {
            lex_error("opcode .xpic: arg %d: invalid type", y);
            return;
        }
        if (strpbrk(argv[y]->string->str_text, "\t\f\r\n\b"))
            lex_error("opcode .xpic: arg %d: may only use spaces", y);
    }
    width = argv[0]->string->str_length;
    for (y = 1; y < argc; ++y)
    {
        if (argv[y]->string->str_length != width)
        {
            lex_error
            (
                "opcode .xpic: all picture scan lines must be the same length"
            );
            return;
        }
    }
    while (argc % 16)
    {
        argv[argc] = expr_new(type_string);
        argv[argc]->string = blank(width);
        ++argc;
    }
    for (x = 0; x < width; x += 16)
    {
        for (y = 0; y < argc; ++y)
        {
            int     byte;
            int     bit;

            byte = 0;
            for (bit = 0; bit < 16; bit++)
            {
                if
                (
                    x + bit < width && argv[y]->string->str_text[x + bit] != ' '
                )
                {
                    byte |= ((unsigned)0x8000 >> bit);
                }
            }
            emit_word(byte);
        }
    }
}


static void
assemble_ds(int argc, expr_t **argv)
{
    int             nbytes;

    if (argc != 1 && argc != 2)
        lex_error("opcode .ds: takes 1 or 2 arguments");
    if (argc < 1)
        return;

    if (argc == 1)
    {
        argv[1] = expr_new(type_absolute);
        argv[1]->value = 0;
        argc = 2;
    }
    if (argv[0]->type != type_absolute || argv[1]->type != type_absolute)
    {
        lex_error("opcode .ds: invalid type");
        return;
    }

    nbytes = argv[0]->value;
    if (nbytes < 0 || nbytes > 0x1000)
    {
        lex_error("opcode .ds: too much storage");
        nbytes = 1;
    }
    emit_storage(nbytes, argv[1]->value);
    byte_check(argv[1]->value);
}


static void
assemble_exit(int argc, expr_t **argv)
{
    if (argc >= 2)
        lex_error("opcode exit: takes 1 argument");

    if (argc == 0)
    {
        emit_word(0x00FD);
        return;
    }

    if (argv[0]->type != type_absolute)
    {
        lex_error("opcode exit: invalid type");
        return;
    }

    if (argv[0]->value < 0 || argv[0]->value > 1)
    {
        lex_error("opcode exit: value out of range");
        argv[0]->value = 1;
    }
    emit_word(0x0010 + argv[0]->value);
}


static void
assemble_low(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode low: takes no arguments");
    emit_word(0x00FE);
}


static void
assemble_high(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode high: takes no arguments");
    emit_word(0x00FF);
}


static void
assemble_scdown(int argc, expr_t **argv)
{
    int             n;

    if (argc != 1)
        lex_error("opcode scdown: takes one argument");
    if (argc < 1)
        return;
    if (argv[0]->type != type_absolute)
    {
        lex_error("opcode scdown: invalid type");
        return;
    }
    n = argv[0]->value;
    if (n < 1 || n > 15)
        lex_error("opcode scdown: scroll size (%d) out of range", n);
    n &= 15;
    emit_word(0x00C0 | n);
}


static void
assemble_compatibility(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode compatibility: takes no arguments");
    emit_word(0x00FA);
}


static void
assemble_scright(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode scright: takes no arguments");
    emit_word(0x00FB);
}


static void
assemble_scleft(int argc, expr_t **argv)
{
    (void)argv;
    if (argc != 0)
        lex_error("opcode scleft: takes no arguments");
    emit_word(0x00FC);
}


static void
parse(void)
{
    trace(("parse()\n{\n"/*}*/));
    lex();
    while (lex_token != lex_token_eof)
        parse_line();
    trace((/*{*/"}\n"));
}


static void
opcode_init(void)
{
    typedef struct table_t table_t;
    struct table_t
    {
        const char      *name;
        void            (*func)(int, expr_t **);
    };
    static const table_t table[] =
    {
        { ".align",     assemble_align,         },
        { ".ascii",     assemble_ascii,         },
        { ".byte",      assemble_byte,          },
        { ".ds",        assemble_ds,            },
        { ".pic",       assemble_pic,           },
        { ".word",      assemble_word,          },
        { ".xpic",      assemble_xpic,          },
        { "add",        assemble_add,           },
        { "and",        assemble_and,           },
        { "bcd",        assemble_bcd,           },
        { "call",       assemble_call,          },
        { "clear",      assemble_clear,         },
        { "cls",        assemble_clear,         },
        { "compatibility", assemble_compatibility, },
        { "da",         assemble_ascii,         },
        { "db",         assemble_byte,          },
        { "dif",        assemble_dif,           },
        { "draw",       assemble_draw,          },
        { "drw",        assemble_draw,          },
        { "dw",         assemble_word,          },
        { "exit",       assemble_exit,          },
        { "flags.restore", assemble_flags_restore, },
        { "flags.save", assemble_flags_save,    },
        { "font",       assemble_hex,           },
        { "hex",        assemble_hex,           },
        { "high",       assemble_high,          },
        { "jmp",        assemble_jump,          },
        { "jp",         assemble_jump,          },
        { "jsr",        assemble_call,          },
        { "jump",       assemble_jump,          },
        { "ld",         assemble_load,          },
        { "ldr",        assemble_restore,       },
        { "load",       assemble_load,          },
        { "low",        assemble_low,           },
        { "lsl",        assemble_lsl,           },
        { "lsr",        assemble_lsr,           },
        { "mov",        assemble_load,          },
        { "or",         assemble_or,            },
        { "rand",       assemble_rnd,           },
        { "restore",    assemble_restore,       },
        { "ret",        assemble_ret,           },
        { "rnd",        assemble_rnd,           },
        { "rsb",        assemble_dif,           },
        { "rts",        assemble_ret,           },
        { "save",       assemble_save,          },
        { "scd",        assemble_scdown,        },
        { "scdown",     assemble_scdown,        },
        { "scleft",     assemble_scleft,        },
        { "scright",    assemble_scright,       },
        { "se",         assemble_skip_eq,       },
        { "shl",        assemble_lsl,           },
        { "show",       assemble_draw,          },
        { "shr",        assemble_lsr,           },
        { "skeq",       assemble_skip_eq,       },
        { "skip.eq",    assemble_skip_eq,       },
        { "skip.ne",    assemble_skip_ne,       },
        { "skne",       assemble_skip_ne,       },
        { "sknp",       assemble_sknp,          },
        { "skp",        assemble_skp,           },
        { "skpr",       assemble_skp,           },
        { "skup",       assemble_sknp,          },
        { "sne",        assemble_skip_ne,       },
        { "sprite",     assemble_draw,          },
        { "str",        assemble_save,          },
        { "sub",        assemble_sub,           },
        { "subn",       assemble_dif,           },
        { "xdraw",      assemble_draw,          },
        { "xfont",      assemble_xhex,          },
        { "xhex",       assemble_xhex,          },
        { "xor",        assemble_xor,           },
        { "xsprite",    assemble_draw,          },
    };

    const table_t *tp;

    for (tp = table; tp < ENDOF(table); ++tp)
    {
        string_t        *s;
        expr_t          *ep;

        s = str_from_c(tp->name);
        ep = expr_new(type_opcode);
        ep->func = tp->func;
        ep->defined = 1;
        id_define(s, ep);
        str_free(s);
    }
}


static void
assemble_align2(int argc, expr_t **argv)
{
    (void)argc;
    (void)argv;
    lex_warning("pseudo-op ``align'' not yet implemented");
}


static void
assemble_include(int argc, expr_t **argv)
{
    (void)argc;
    (void)argv;
    lex_error("pseudo-op ``include'' not yet implemented");
}


static void
assemble_option(int argc, expr_t **argv)
{
    (void)argc;
    (void)argv;
    lex_warning("pseudo-op ``option'' ignored");
}


static void
assemble_title(int argc, expr_t **argv)
{
    if (argc != 1 && argc != 2)
        lex_error("the .title pseudo-op takes two arguments");
    if (argc < 1)
        return;
    if (argc < 2)
        emit_title(argv[0]->string->str_text, 0);
    else
        emit_title(argv[0]->string->str_text, argv[1]->string->str_text);
}


static void
assemble_used(int argc, expr_t **argv)
{
    (void)argc;
    (void)argv;
    lex_warning("pseudo-op ``used'' ignored");
}


static void
assemble_xref(int argc, expr_t **argv)
{
    static string_t *on;
    static string_t *off;
    string_t        *arg;

    if (argc != 1)
        lex_error("the xref pseudo-op takes one argument");
    if (argc < 1)
        return;
    if (argv[0]->type != type_name)
    {
        lex_error("xref type error");
        return;
    }
    if (!on)
        on = str_from_c("on");
    if (!off)
        off = str_from_c("off");
    arg = str_downcase(argv[0]->string);
    if (str_equal(on, arg))
        xref_on = 1;
    else if (str_equal(off, arg))
        xref_on = 0;
    else
        lex_error("xref argument must be ``on'' or ``off''");
    str_free(arg);
}


static void
opcode_init2(void)
{
    typedef struct table_t table_t;
    struct table_t
    {
        const char      *name;
        void            (*func)(int, expr_t **);
    };
    static const table_t table[] =
    {
        { "align",      assemble_align2,        },
        { "include",    assemble_include,       },
        { "option",     assemble_option,        },
        { ".title",     assemble_title,         },
        { "used",       assemble_used,          },
        { "xref",       assemble_xref,          },
        { ".xref",      assemble_xref,          },
    };

    const table_t   *tp;

    for (tp = table; tp < ENDOF(table); ++tp)
    {
        string_t        *name;
        expr_t          *ep;

        name = str_from_c(tp->name);
        ep = expr_new(type_preprocess);
        ep->func = tp->func;
        ep->defined = 1;
        id_define(name, ep);
        str_free(name);
    }
}


static void
opcode_init3(void)
{
    typedef struct table_t table_t;
    struct table_t
    {
        const char      *name;
        type_t          type;
        int             value;
    };

    static const table_t table[] =
    {
        { "b",          type_bcd_reg,   0,      },
        { "dt",         type_time_reg,  0,      },
        { "f",          type_font_reg,  0,      },
        { "i",          type_i_reg,     0,      },
        { "key",        type_key,       0,      },
        { "lf",         type_font_reg,  0,      },
        { "hf",         type_xfont_reg, 0,      },
        { "r",          type_r_reg,     0,      },
        { "st",         type_tone_reg,  0,      },
        { "time",       type_time_reg,  0,      },
        { "tone",       type_tone_reg,  0,      },

        { "r0",         type_v_reg,     0,      },
        { "r1",         type_v_reg,     1,      },
        { "r10",        type_v_reg,     10,     },
        { "r11",        type_v_reg,     11,     },
        { "r12",        type_v_reg,     12,     },
        { "r13",        type_v_reg,     13,     },
        { "r14",        type_v_reg,     14,     },
        { "r15",        type_v_reg,     15,     },
        { "r2",         type_v_reg,     2,      },
        { "r3",         type_v_reg,     3,      },
        { "r4",         type_v_reg,     4,      },
        { "r5",         type_v_reg,     5,      },
        { "r6",         type_v_reg,     6,      },
        { "r7",         type_v_reg,     7,      },
        { "r8",         type_v_reg,     8,      },
        { "r9",         type_v_reg,     9,      },
        { "ra",         type_v_reg,     10,     },
        { "rb",         type_v_reg,     11,     },
        { "rc",         type_v_reg,     12,     },
        { "rd",         type_v_reg,     13,     },
        { "re",         type_v_reg,     14,     },
        { "rf",         type_v_reg,     15,     },

        { "v0",         type_v_reg,     0,      },
        { "v1",         type_v_reg,     1,      },
        { "v10",        type_v_reg,     10,     },
        { "v11",        type_v_reg,     11,     },
        { "v12",        type_v_reg,     12,     },
        { "v13",        type_v_reg,     13,     },
        { "v14",        type_v_reg,     14,     },
        { "v15",        type_v_reg,     15,     },
        { "v2",         type_v_reg,     2,      },
        { "v3",         type_v_reg,     3,      },
        { "v4",         type_v_reg,     4,      },
        { "v5",         type_v_reg,     5,      },
        { "v6",         type_v_reg,     6,      },
        { "v7",         type_v_reg,     7,      },
        { "v8",         type_v_reg,     8,      },
        { "v9",         type_v_reg,     9,      },
        { "va",         type_v_reg,     10,     },
        { "vb",         type_v_reg,     11,     },
        { "vc",         type_v_reg,     12,     },
        { "vd",         type_v_reg,     13,     },
        { "ve",         type_v_reg,     14,     },
        { "vf",         type_v_reg,     15,     },
    };

    const table_t   *tp;

    for (tp = table; tp < ENDOF(table); ++tp)
    {
        string_t        *name;
        expr_t          *ep;

        name = str_from_c(tp->name);
        ep = expr_new(tp->type);
        ep->value = tp->value;
        ep->defined = 1;
        id_define(name, ep);
        str_free(name);
    }
}


void
assemble(const char *infile, const char *outfile)
{
    opcode_init();
    opcode_init2();
    opcode_init3();
    lex_open(infile);
    emit_open(outfile);
    pass = 1;
    parse();
    lex_rewind();
    emit_rewind();
    pass = 2;
    parse();
    if (xref_on)
        cross_reference();
    lex_close();
    emit_close();
}
