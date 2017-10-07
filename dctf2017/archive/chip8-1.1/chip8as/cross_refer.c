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

#include <chip8as/col.h>
#include <chip8as/cross_refer.h>
#include <chip8as/expr.h>
#include <chip8as/id.h>
#include <chip8as/ilist.h>
#include <chip8as/option.h>
#include <common/word.h>


static void
xref_callback(string_t *name, void *data, void *aux)
{
    wlist           *wlp;

    (void)data;
    wlp = aux;
    wl_append(wlp, name);
}


void
cross_reference(void)
{
    wlist           wl;
    size_t          j;
    int             name_col;
    int             type_col;
    int             value_col;
    int             def_col;
    int             ref_col;

    /*
     * No cross reference if no listing.
     */
    if (!option_get_listfile())
        return;

    /*
     * extract the list of symbol name,
     * and then sort it
     */
    wl_zero(&wl);
    id_dump(xref_callback, &wl);
    wl_sort(&wl);

    /*
     * throw a new page
     */
    col_cancel_columns();
    col_eject();
    col_title(0, "Symbol Cross Reference");

    /*
     * churn out the listing
     */
    name_col = col_create(0, 15);
    col_heading(name_col, "Name\n------");
    type_col = col_create(16, 24);
    col_heading(type_col, "Type\n------");
    value_col = col_create(25, 31);
    col_heading(value_col, "Value\n------");
    def_col = col_create(32, 39);
    col_heading(def_col, "Defined\n-------");
    ref_col = col_create(40, 79);
    col_heading(ref_col, "References\n------------");
    for (j = 0; j < wl.wl_nwords; ++j)
    {
        string_t        *name;
        expr_t          *ep;

        name = wl.wl_word[j];
        ep = id_search(name);
        if (!ep)
            continue;
        if (ep->defined && !ep->defs)
            continue;
        col_printf(name_col, "%s", name->str_text);
        switch (ep->type)
        {
        case type_conditional:
            col_puts(type_col, "conditional");
            break;

        case type_absolute:
            col_puts(type_col, "absolute");
            col_printf(value_col, "%4X", ep->value);
            break;

        case type_bcd_reg:
        case type_font_reg:
        case type_i_indirect:
        case type_i_reg:
        case type_key:
        case type_r_reg:
        case type_time_reg:
        case type_tone_reg:
        case type_v_reg:
        case type_xfont_reg:
            col_puts(type_col, "register");
            break;

        case type_name:
            col_puts(type_col, "name");
            col_puts(type_col, ep->string->str_text);
            break;

        case type_opcode:
        case type_preprocess:
            col_puts(type_col, "opcode");
            break;

        case type_relative:
            col_puts(type_col, "relative");
            if (ep->defined)
                col_printf(value_col, "%4.3X", ep->value);
            break;

        case type_string:
            col_puts(type_col, "string");
            col_puts(type_col, ep->string->str_text);
            break;
        }
        if (ep->defs)
        {
            size_t          k;

            for (k = 0; k < ep->defs->length; ++k)
            {
                if (k)
                    col_puts(def_col, ", ");
                col_printf(def_col, "%d", ep->defs->list[k]);
            }
        }
        if (ep->refs)
        {
            size_t          k;

            for (k = 0; k < ep->refs->length; ++k)
            {
                if (k)
                    col_puts(ref_col, ", ");
                col_printf(ref_col, "%d", ep->refs->list[k]);
            }
        }
        col_eoln();
    }
    wl_free(&wl);
}
