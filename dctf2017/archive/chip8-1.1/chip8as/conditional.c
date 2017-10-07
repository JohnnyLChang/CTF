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

#include <common/config.h>
#include <libexplain/malloc.h>

#include <chip8as/conditional.h>
#include <chip8as/emit.h>
#include <chip8as/expr.h>
#include <chip8as/id.h>
#include <chip8as/lex.h>


typedef struct conditional_ty conditional_ty;
struct conditional_ty
{
    int             requested;
    int             seen_else;
    int             state;
    conditional_ty  *prev;
};

static conditional_ty *conditional;


static void
conditional_push(int ok)
{
    conditional_ty  *cp;

    cp = explain_malloc_or_die(sizeof(conditional_ty));
    cp->requested = ok;
    cp->seen_else = 0;
    cp->prev = conditional;
    cp->state = cp->requested && (!cp->prev || cp->prev->state);
    conditional = cp;
}


static void
conditional_else(void)
{
    conditional_ty  *cp;

    cp = conditional;
    if (!cp)
    {
        lex_error("``else'' outside condition");
        return;
    }
    if (cp->seen_else)
        lex_error("too many ``else'' directives");
    cp->state = !cp->requested && (!cp->prev || cp->prev->state);
    cp->seen_else = 1;
}


static void
conditional_pop(void)
{
    conditional_ty  *cp;

    if (!conditional)
    {
        lex_error("``endif'' outside conditional");
        return;
    }
    cp = conditional;
    conditional = cp->prev;
    free(cp);
}



void
conditional_parse(void)
{
    expr_t          *ep;

    switch (lex_token)
    {
    case lex_token_ifdef:
        conditional_lex();
        if (lex_token != lex_token_name)
        {
            name_expected:
            lex_error("name expected");
            eat_tokens_until_eoln:
            for (;;)
            {
                switch (lex_token)
                {
                case lex_token_eoln:
                    emit_eoln();
                    /* don't step over eoln token */
                    /* conditional_lex(); */
                    return;

                case lex_token_eof:
                    emit_eoln();
                    return;

                default:
                    break;
                }
                conditional_lex();
            }
        }
        ep = id_search(lex_value.lv_name);
        if (ep)
        {
            expr_bump_ref(ep);
            if (ep->type != type_conditional)
            {
                lex_error
                (
                    "name ``%s'' is not a suitable type",
                    lex_value.lv_name->str_text
                );
                ep = 0;
            }
        }
        conditional_push(!!ep);
        break;

    case lex_token_ifndef:
        conditional_lex();
        if (lex_token != lex_token_name)
            goto name_expected;
        ep = id_search(lex_value.lv_name);
        if (ep)
        {
            expr_bump_ref(ep);
            if (ep->type != type_conditional)
            {
                lex_error
                (
                    "name ``%s'' is not a suitable type",
                    lex_value.lv_name->str_text
                );
                ep = 0;
            }
        }
        conditional_push(!ep);
        break;

    case lex_token_define:
        conditional_lex();
        if (lex_token != lex_token_name)
            goto name_expected;
        if (conditional_ok())
        {
            ep = expr_new(type_conditional);
            expr_bump_def(ep);
            id_define(lex_value.lv_name, ep);
        }
        break;

    case lex_token_else:
        conditional_else();
        break;

    case lex_token_endif:
        conditional_pop();
        break;

    default:
        lex_error("directive not understood");
        goto eat_tokens_until_eoln;
    }

    conditional_lex();
    if (lex_token != lex_token_eoln)
    {
        lex_error("end-of-line expected");
        goto eat_tokens_until_eoln;
    }
    emit_eoln();
    /* don't step over eoln token */
    /* conditional_lex(); */
}


int
conditional_ok(void)
{
    return (!conditional || conditional->state);
}


void
conditional_eof_check(void)
{
    if (conditional)
        lex_error("unterminated condition");
}
