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

#ifndef COMMON_STR_H
#define COMMON_STR_H

#include <common/ac/stddef.h>

typedef unsigned long hash_t;

typedef struct string_t string_t;
struct string_t
{
    hash_t  str_hash;
    string_t *str_next;
    long    str_references;
    size_t  str_length;
    char    str_text[1];
};

extern string_t *str_slash;

void str_initialize(void);
string_t *str_from_c(const char *);
string_t *str_n_from_c(const char *, size_t);
string_t *str_copy(string_t *);
void str_free(string_t *);
string_t *str_catenate(string_t *, string_t *);
string_t *str_cat_three(string_t *, string_t *, string_t *);
int str_bool(string_t *);
string_t *str_upcase(string_t *);
string_t *str_downcase(string_t *);
void str_dump(void);
const char *str_repn(string_t *);
string_t *str_field(string_t *str, int sep, int fldnum);
void slow_to_fast(char **, string_t **, size_t);
string_t *str_format(const char *, ...);

#define str_equal(s1, s2) ((s1) == (s2))

#endif /* COMMON_STR_H */
