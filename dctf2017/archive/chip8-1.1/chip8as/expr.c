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

#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>

#include <common/str.h>

#include <chip8as/emit.h>
#include <chip8as/expr.h>
#include <chip8as/id.h>
#include <chip8as/ilist.h>
#include <chip8as/lex.h>


#define PAIR(a, b) (((a) << 8) | (b))

int pass;


expr_t *
expr_new(type_t type)
{
    expr_t          *ep;

    ep = explain_malloc_or_die(sizeof(expr_t));
    memset(ep, 0, sizeof(*ep));
    ep->reference_count = 1;
    ep->type = type;
    return ep;
}


void
expr_delete(expr_t *ep)
{
    ep->reference_count--;
    if (ep->reference_count > 0)
        return;
    switch (ep->type)
    {
    case type_string:
    case type_name:
        str_free(ep->string);
        break;

    default:
        break;
    }
    free(ep);
}


expr_t *
expr_copy(expr_t *ep)
{
    ep->reference_count++;
    return ep;
}


expr_t *
expr_clone(expr_t *ep)
{
    expr_t          *ep2;

    ep2 = expr_new(ep->type);
    *ep2 = *ep;
    ep2->reference_count = 1;
    switch (ep->type)
    {
    case type_string:
    case type_name:
        ep2->string = str_copy(ep->string);
        break;

    default:
        break;
    }
    return ep2;
}


expr_t *
name_or_string(void)
{
    expr_t          *ep;

    switch (lex_token)
    {
    default:
        lex_error("expression required");
        return 0;

    case lex_token_name:
        ep = expr_new(type_name);
        ep->string = lex_value.lv_name;
        ep->defined = 1;
        lex();
        break;

    case lex_token_left_paren:
        lex();
        ep = name_or_string();
        if (!ep)
            return 0;
        if (lex_token != lex_token_right_paren)
        {
            expr_delete(ep);
            lex_error("')' expected");
            return 0;
        }
        lex();
        break;

    case lex_token_number:
        ep = expr_new(type_absolute);
        ep->value = lex_value.lv_number;
        ep->defined = 1;
        lex();
        break;

    case lex_token_string:
        ep = expr_new(type_string);
        ep->string = lex_value.lv_name;
        ep->defined = 1;
        lex();
        break;
    }
    return ep;
}


static expr_t *
look_for_a_register(string_t *name)
{
    string_t        *name2;
    expr_t          *ep;

    name2 = str_downcase(name);
    ep = id_search(name2);
    str_free(name2);
    if (!ep)
        return 0;
    switch (ep->type)
    {
    case type_bcd_reg:
    case type_font_reg:
    case type_i_reg:
    case type_key:
    case type_r_reg:
    case type_time_reg:
    case type_tone_reg:
    case type_v_reg:
    case type_xfont_reg:
        return ep;

    default:
        return 0;
    }
}


static expr_t *
expr3(void)
{
    expr_t          *ep;
    expr_t          *rhs;

    switch (lex_token)
    {
    default:
        lex_error("expression required");
        return 0;

    case lex_token_name:
        ep = id_search(lex_value.lv_name);
        if (!ep)
            ep = look_for_a_register(lex_value.lv_name);
        if (ep)
        {
            ep = expr_copy(ep);
            expr_bump_ref(ep);
        }
        else
        {
            if (pass == 2)
            {
                string_t        *guess;

                ep = id_search_fuzzy(lex_value.lv_name, &guess);
                if (ep)
                {
                    lex_error
                    (
             "label \"%s\" undefined, closest is the \"%s\" symbol",
                        lex_value.lv_name->str_text,
                        guess->str_text
                    );
                    ep = expr_copy(ep);
                }
                else
                {
                    lex_error("label \"%s\" undefined",
                        lex_value.lv_name->str_text);
                    ep = expr_new(type_relative);
                    ep->value = 0;
                    ep->defined = 0;
                }
            }
            else
            {
                ep = expr_new(type_relative);
                ep->value = 0;
                ep->defined = 0;
            }
        }
        str_free(lex_value.lv_name);
        lex();
        break;

    case lex_token_minus:
        lex();
        rhs = expr3();
        if (!rhs)
            return 0;
        ep = expr_new(type_absolute);
        ep->value = 0;
        ep->defined = 1;
        if (rhs->type != type_absolute)
            lex_error("operator '-': invalid type");
        else
            ep->value = -rhs->value;
        expr_delete(rhs);
        break;

    case lex_token_bit_not:
        lex();
        rhs = expr3();
        if (!rhs)
            return 0;
        ep = expr_new(type_absolute);
        ep->value = 0;
        ep->defined = 1;
        if (rhs->type != type_absolute)
            lex_error("operator '~': invalid type");
        else
            ep->value = ~rhs->value;
        expr_delete(rhs);
        break;

    case lex_token_left_bracket:
        lex();
        rhs = expr();
        if (!rhs)
            return 0;
        if (rhs->type != type_i_reg)
        {
            lex_error
            (
              "indirection is only supported for the ``i'' register"
            );
        }
        expr_delete(rhs);
        if (lex_token != lex_token_right_bracket)
        {
            lex_error("``]'' expected");
            return 0;
        }
        lex();
        ep = expr_new(type_i_indirect);
        ep->value = 0;
        ep->defined = 1;
        break;

    case lex_token_left_paren:
        lex();
        ep = expr();
        if (!ep)
            return 0;
        if (lex_token != lex_token_right_paren)
        {
            expr_delete(ep);
            lex_error("')' expected");
            return 0;
        }
        lex();
        break;

    case lex_token_number:
        ep = expr_new(type_absolute);
        ep->value = lex_value.lv_number;
        ep->defined = 1;
        lex();
        break;

    case lex_token_dot:
        ep = expr_new(type_relative);
        ep->value = emit_get_pc();
        ep->defined = 1;
        lex();
        break;

    case lex_token_string:
        ep = expr_new(type_string);
        ep->string = lex_value.lv_name;
        ep->defined = 1;
        lex();
        break;
    }
    return ep;
}


static expr_t *
expr2(void)
{
    expr_t          *ep;
    expr_t          *rhs;

    ep = expr3();
    if (!ep)
        return 0;
    for (;;)
    {
        switch (lex_token)
        {
        default:
            return ep;

        case lex_token_mul:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '*': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                val = ep->value * rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            expr_delete(rhs);
            break;

        case lex_token_div:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '/': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                if (!rhs->value)
                {
                    if (pass == 2)
                        lex_error("division by zero");
                    val = 0;
                }
                else
                    val = ep->value / rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            expr_delete(rhs);
            break;

        case lex_token_mod:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '%': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                if (!rhs->value)
                {
                    if (pass == 2)
                        lex_error("modulo by zero");
                    val = 0;
                }
                else
                    val = ep->value % rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            expr_delete(rhs);
            break;

        case lex_token_bit_and:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '&': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                val = ep->value & rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            break;

        case lex_token_shift_left:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '<<': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                val = ep->value << rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            expr_delete(rhs);
            break;

        case lex_token_shift_right:
            lex();
            rhs = expr3();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '>>': incompatible types");
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = 0;
                ep->defined = 1;
            }
            else
            {
                int             val;
                int             def;

                val = ep->value >> rhs->value;
                def = ep->defined && rhs->defined;
                expr_delete(ep);
                ep = expr_new(type_absolute);
                ep->value = val;
                ep->defined = def;
            }
            expr_delete(rhs);
            break;
        }
    }
}


expr_t *
expr(void)
{
    expr_t          *ep;
    expr_t          *rhs;
    type_t          type;
    int             val;
    int             def;

    ep = expr2();
    if (!ep)
        return 0;
    for (;;)
    {
        switch (lex_token)
        {
        case lex_token_plus:
            lex();
            rhs = expr2();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            def = ep->defined && rhs->defined;
            switch (PAIR(ep->type, rhs->type))
            {
            default:
                lex_error("operator '+': incompatible types");
                expr_delete(ep);
                type = type_absolute;
                val = 0;
                def = 1;
                break;

            case PAIR(type_absolute, type_absolute):
                type = type_absolute;
                val = ep->value + rhs->value;
                break;

            case PAIR(type_relative, type_absolute):
                type = type_relative;
                val = ep->value + rhs->value;
                break;

            case PAIR(type_absolute, type_relative):
                type = type_relative;
                val = ep->value + rhs->value;
                break;
            }
            expr_delete(ep);
            expr_delete(rhs);
            ep = expr_new(type);
            ep->value = val;
            ep->defined = def;
            continue;

        case lex_token_minus:
            lex();
            rhs = expr2();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            def = ep->defined && rhs->defined;
            switch (PAIR(ep->type, rhs->type))
            {
            default:
                lex_error("operator '-': incompatible types");
                type = type_absolute;
                val = 0;
                def = 1;
                break;

            case PAIR(type_absolute, type_absolute):
                type = type_absolute;
                val = ep->value - rhs->value;
                break;

            case PAIR(type_relative, type_absolute):
                type = type_relative;
                val = ep->value - rhs->value;
                break;

            case PAIR(type_relative, type_relative):
                type = type_absolute;
                val = ep->value - rhs->value;
                break;
            }
            expr_delete(ep);
            expr_delete(rhs);
            ep = expr_new(type);
            ep->value = val;
            ep->defined = def;
            continue;

        case lex_token_bit_or:
            lex();
            rhs = expr2();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '|': incompatible types");
                val = 0;
                def = 1;
            }
            else
            {
                val = ep->value | rhs->value;
                def = ep->defined && rhs->defined;
            }
            expr_delete(ep);
            expr_delete(rhs);
            ep = expr_new(type_absolute);
            ep->value = val;
            ep->defined = def;
            continue;

        case lex_token_bit_xor:
            lex();
            rhs = expr2();
            if (!rhs)
            {
                expr_delete(ep);
                return 0;
            }
            if (ep->type != type_absolute || rhs->type != type_absolute)
            {
                lex_error("operator '^': incompatible types");
                val = 0;
                def = 1;
            }
            else
            {
                val = ep->value ^ rhs->value;
                def = ep->defined && rhs->defined;
            }
            expr_delete(ep);
            expr_delete(rhs);
            ep = expr_new(type_absolute);
            ep->value = val;
            ep->defined = def;
            continue;

        default:
            break;
        }
        break;
    }
    return ep;
}


void
expr_bump_def(expr_t *ep)
{
    int     lino;

    lino = lex_line_number();
    if (!ep->defs)
        ep->defs = ilist_new();
    ilist_append(ep->defs, lino);
}


void
expr_bump_ref(expr_t *ep)
{
    int     lino;

    lino = lex_line_number();
    if (!ep->refs)
        ep->refs = ilist_new();
    ilist_append(ep->refs, lino);
}
