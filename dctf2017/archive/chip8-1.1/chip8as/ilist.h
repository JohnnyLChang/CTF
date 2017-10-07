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

#ifndef CHIP8AS_ILIST_H
#define CHIP8AS_ILIST_H

#include <common/ac/stddef.h>

typedef struct ilist_t ilist_t;
struct ilist_t
{
    int     *list;
    size_t  length;
    size_t  maximum;
};

ilist_t *ilist_new(void);
void ilist_delete(ilist_t *);
void ilist_append(ilist_t *, int);

#endif /* CHIP8AS_ILIST_H */
