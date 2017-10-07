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

#ifndef COMMON_WORD_H
#define COMMON_WORD_H

#include <common/str.h>

typedef struct wlist wlist;
struct wlist
{
    size_t          wl_nwords;
    size_t          wl_nwords_max;
    string_t        **wl_word;
};

int wl_member(wlist *, string_t *);
string_t *wl2str(wlist *, int, int);
void str2wl(wlist *, string_t *);
void wl_append(wlist *, string_t *);
void wl_append_unique(wlist *, string_t *);
void wl_copy(wlist *, wlist *);
void wl_delete(wlist *, string_t *);
void wl_free(wlist *);
void wl_reconstruct(wlist *, string_t *, wlist *);
void wl_zero(wlist *);
void wl_sort(wlist *);

#endif /* COMMON_WORD_H */
