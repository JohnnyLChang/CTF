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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMON_ARGLEX_H
#define COMMON_ARGLEX_H

enum
{
    arglex_token_eoln,
    arglex_token_help,
    arglex_token_license,
    arglex_token_number,
    arglex_token_option,
    arglex_token_stdio,
    arglex_token_string,
    arglex_token_trace,
    arglex_token_version,
    arglex_token_MAX_1
};

typedef struct arglex_value_t arglex_value_t;
struct arglex_value_t
{
    const char      *alv_string;
    long            alv_number;
};

typedef struct arglex_table_t arglex_table_t;
struct arglex_table_t
{
    const char      *name;
    int             token;
};

#define ARGLEX_END_MARKER { 0, 0 }

extern int      arglex_token;
extern arglex_value_t arglex_value;

void arglex_init(int, char **, const arglex_table_t *);
int arglex(void);
int argcmp(const char *formal, const char *actual);

#endif /* COMMON_ARGLEX_H */
