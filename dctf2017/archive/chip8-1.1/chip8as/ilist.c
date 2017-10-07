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

#include <chip8as/ilist.h>


static void
ilist_constructor(ilist_t *ilp)
{
    ilp->list = 0;
    ilp->length = 0;
    ilp->maximum = 0;
}


ilist_t *
ilist_new(void)
{
    ilist_t         *ilp;

    ilp = explain_malloc_or_die(sizeof(ilist_t));
    ilist_constructor(ilp);
    return ilp;
}


static void
ilist_destructor(ilist_t *ilp)
{
    if (ilp->list)
        free(ilp->list);
    ilp->list = 0;
    ilp->length = 0;
    ilp->maximum = 0;
}


void
ilist_delete(ilist_t *ilp)
{
    ilist_destructor(ilp);
    free(ilp);
}


void
ilist_append(ilist_t *ilp, int i)
{
    size_t          j, k;

    if (ilp->length >= ilp->maximum)
    {
        size_t          nbytes;
        size_t          new_maximum;
        int             *new_list;

        new_maximum = ilp->maximum ? ilp->maximum * 2 : 4;
        nbytes = new_maximum * sizeof(ilp->list[0]);
        new_list = explain_malloc_or_die(nbytes);
        for (j = 0; j < ilp->length; ++j)
            new_list[j] = ilp->list[j];
        if (ilp->list)
            free(ilp->list);
        ilp->list = new_list;
        ilp->maximum = new_maximum;
    }
    for (j = 0; j < ilp->length; ++j)
    {
        int n = ilp->list[j];
        if (n == i)
            return;
        if (n >= i)
            break;
    }
    for (k = ilp->length; k > j; --k)
        ilp->list[k] = ilp->list[k - 1];
    ilp->list[j] = i;
    ilp->length++;
}
