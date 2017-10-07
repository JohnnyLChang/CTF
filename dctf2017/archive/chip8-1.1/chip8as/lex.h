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

#ifndef CHIP8AS_LEX_H
#define CHIP8AS_LEX_H

#include <common/str.h>

typedef enum lex_token_t lex_token_t;
enum lex_token_t
{
    lex_token_bit_and,
    lex_token_bit_not,
    lex_token_bit_or,
    lex_token_bit_xor,
    lex_token_colon,
    lex_token_comma,
    lex_token_define,
    lex_token_div,
    lex_token_dot,
    lex_token_else,
    lex_token_endif,
    lex_token_eof,
    lex_token_eoln,
    lex_token_equ,
    lex_token_ifdef,
    lex_token_ifndef,
    lex_token_include,
    lex_token_junk,
    lex_token_left_bracket,
    lex_token_left_paren,
    lex_token_minus,
    lex_token_mod,
    lex_token_mul,
    lex_token_name,
    lex_token_number,
    lex_token_plus,
    lex_token_right_bracket,
    lex_token_right_paren,
    lex_token_shift_left,
    lex_token_shift_right,
    lex_token_string
};

typedef struct lex_value_t lex_value_t;
struct lex_value_t
{
    string_t        *lv_name;
    long            lv_number;
};

extern  lex_token_t     lex_token;
extern  lex_value_t     lex_value;

void lex_open(const char *);
void lex_rewind(void);
void lex_close(void);
void lex(void);
void lex_error(const char *, ...);
void lex_warning(const char *, ...);

int lex_line_number(void);
void conditional_lex(void);

#endif /* CHIP8AS_LEX_H */
