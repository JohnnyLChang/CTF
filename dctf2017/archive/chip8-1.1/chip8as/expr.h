/*
 * chip8 - X11 Chip8 interpreter
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

#ifndef CHIP8AS_EXPR_H
#define CHIP8AS_EXPR_H

typedef enum type_t type_t;
enum type_t
{
    type_absolute,
    type_bcd_reg,
    type_conditional,
    type_font_reg,
    type_i_indirect,
    type_i_reg,
    type_key,
    type_name,
    type_opcode,
    type_preprocess,
    type_r_reg,
    type_relative,
    type_string,
    type_time_reg,
    type_tone_reg,
    type_v_reg,
    type_xfont_reg
};

typedef struct expr_t expr_t;
struct expr_t
{
    long            reference_count;
    type_t          type;
    long            value;  /* only for type_absolute, type_relative */
    int             defined; /* only for type_relative */
    struct string_t *string; /* only for type_string, type_name */
    void            (*func)(int, expr_t **);
    int             used;
    struct ilist_t  *defs;
    struct ilist_t  *refs;
};

extern int pass;

expr_t *expr_new(type_t);
void expr_delete(expr_t *);
expr_t *expr_copy(expr_t *);
expr_t *expr_clone(expr_t *);
expr_t *expr(void);
expr_t *name_or_string(void);

void expr_bump_def(expr_t *);
void expr_bump_ref(expr_t *);

#endif /* CHIP8AS_EXPR_H */
