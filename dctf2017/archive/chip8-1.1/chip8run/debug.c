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

#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <sys/types.h>
#include <sys/time.h>

#include <common/trace.h>

#include <chip8run/window.h>
#include <chip8run/debug.h>
#include <chip8run/ecks.h>
#include <chip8run/machine.h>

static void debug_event(void *, XEvent *, struct timeval *);

debug_class_t debug_class =
{
    sizeof(debug_t),
    &window_class,
    debug_new,
    debug_event,
    debug_free,
    window_nop_tickle,
    window_geom,
};


void
debug_new(void *that, void *parent, int x, int y, int dx, int dy,
    const char *name, const char *title, int cursor_num)
{
    Cursor  cursor;
    debug_t *this;
    XSetWindowAttributes attributes;

    (void)name;
    (void)title;
    this = that;
    trace(("debug_new(this = %08lX)\n{\n"/*}*/, this));
    this->parent = parent;

    /*
     * create the window
     */
    trace(("CreateWindow\n"));
    this->id =
        XCreateWindow
        (
            display,
            ((window_t *)parent)->id,
            x,
            y,
            dx,
            dy,
            1,      /* border width */
            DefaultDepth(display, screen), /* depth */
            InputOutput,    /* class */
            CopyFromParent, /* visual */
            0,
            &attributes
        );

    /*
     * get standard info
     */
    win_std_info((window_t *)this, "Debug", "debug");

    XSelectInput(display, this->id, ExposureMask | StructureNotifyMask);
    window_add((window_t *)this);
    XMapWindow(display, this->id);

    if (cursor_num < 0)
        cursor_num = XC_gobbler;
    cursor = XCreateFontCursor(display, cursor_num);
    XDefineCursor(display, this->id, cursor);

    trace((/*{*/"}\n"));
}


void
debug_free(void *that)
{
    debug_t *this;

    this = that;
    trace(("debug_free(this = %08lX)\n{\n"/*}*/, this));
    XDestroyWindow(display, this->id);
    window_remove((window_t *)this);
    free(this);
    trace((/*{*/"}\n"));
}


void
debug_event(void *that, XEvent *ep, struct timeval *now)
{
    debug_t *this;

    (void)now;
    this = that;
    trace(("debug_event(this = %08lX, ep = %08lX)\n{\n"/*}*/, this, ep));
    switch (ep->type)
    {
    case Expose:
        {
            int     j;
            XGCValues values;

            values.foreground = this->foreground;
            values.background = this->background;
            values.font = this->font->fid;
            values.fill_style = FillSolid;
            XChangeGC
            (
                display,
                gc,
                GCForeground | GCBackground | GCFont | GCFillStyle,
                &values
            );
            for (j = 0; j < 4; ++j)
            {
                XDrawString
                (
                    display,
                    this->id,
                    gc,
                    2,
                    (
                        2
                    +
                        this->font->ascent
                    +
                        j * (this->font->ascent + this->font->descent)
                    ),
                    this->text[j],
                    strlen(this->text[j])
                );
            }
            XSync(display, 0);
        }
        break;

    case ConfigureNotify:
        break;
    }
    trace((/*{*/"}\n"));
}


void
debug_update(void *that, machine_t *machine)
{
    debug_t *this;
    int     j;
    char    *cp;
    char    *ep;

    this = that;
    XClearArea(display, this->id, 0, 0, 0, 0, True);

    snprintf
    (
        this->text[0],
        sizeof(this->text[0]),
        "%s",
        "v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 vA vB vC vD vE vF   i"
    );
    snprintf
    (
        this->text[1],
        sizeof(this->text[1]),
        "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X %02X "
            "%02X %02X %02X %03X",
        machine->v_reg[0],
        machine->v_reg[1],
        machine->v_reg[2],
        machine->v_reg[3],
        machine->v_reg[4],
        machine->v_reg[5],
        machine->v_reg[6],
        machine->v_reg[7],
        machine->v_reg[8],
        machine->v_reg[9],
        machine->v_reg[10],
        machine->v_reg[11],
        machine->v_reg[12],
        machine->v_reg[13],
        machine->v_reg[14],
        machine->v_reg[15],
        machine->i_reg
    );

    machine_disassemble(machine, this->text[2], sizeof(this->text[2]));

    /*
     * show memory pointed to by "i"
     */
    cp = this->text[3];
    ep = cp + sizeof(this->text[3]);
    snprintf(cp, ep - cp, "%03X:", machine->i_reg);
    for (j = 0; j < 16; ++j)
    {
        cp += strlen(cp);
        snprintf
        (
            cp,
            ep - cp,
            " %02X",
            machine->memory[(machine->i_reg + j) & 0xFFF]
        );
    }
}
