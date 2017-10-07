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

#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <sys/types.h>
#include <sys/time.h>

#include <common/trace.h>

#include <chip8run/window.h>
#include <chip8run/arena.h>
#include <chip8run/ecks.h>
#include <chip8run/machine.h>


static void arena_event(void *, XEvent *, struct timeval *);

arena_class_t arena_class =
{
    sizeof(arena_t),
    &window_class,
    arena_new,
    arena_event,
    arena_free,
    window_nop_tickle,
    window_geom,
};


void
arena_new(void *that, void *parent, int x, int y, int dx, int dy,
    const char *name, const char *title, int cursor_num)
{
    arena_t         *this;
    Cursor          cursor;
    XSetWindowAttributes attributes;
    int             mx, my;

    (void)name;
    (void)title;
    this = that;
    trace(("arena_new(this = %08lX)\n{\n"/*}*/, this));
    this->parent = parent;
    mx = dx / 128;
    my = dy / 64;
    this->mult = (mx < my ? mx : my);
    if (this->mult < 1)
        this->mult = 1;
    this->mode = 0;
    this->mult *= 2;
    dx = this->mult * 64;
    dy = this->mult * 32;

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
    win_std_info((window_t *)this, "Arena", "arena");

    XSelectInput(display, this->id, ExposureMask | StructureNotifyMask);
    window_add((window_t *)this);
    XMapWindow(display, this->id);

    if (cursor_num < 0)
        cursor_num = XC_gumby;
    cursor = XCreateFontCursor(display, cursor_num);
    XDefineCursor(display, this->id, cursor);

    trace((/*{*/"}\n"));
}


void
arena_free(void *that)
{
    arena_t         *this;

    this = that;
    trace(("arena_free(this = %08lX)\n{\n"/*}*/, this));
    XDestroyWindow(display, this->id);
    window_remove((window_t *)this);
    free(this);
    trace((/*{*/"}\n"));
}


void
arena_event(void *that, XEvent *ep, struct timeval *now)
{
    arena_t         *this;

    (void)now;
    this = that;
    trace(("arena_event(this = %08lX, ep = %08lX)\n{\n"/*}*/, this, ep));
    switch (ep->type)
    {
    case Expose:
        {
            XRectangle *r;
            int     mode;
            int     mult;
            int     mult2;
            int     x, y;
            int     x_hi, y_hi;
            XRectangle rect[64*128];

            mode = this->mode;
            if (!mode)
            {
                x_hi = 64;
                y_hi = 32;
                mult = this->mult;
            }
            else
            {
                x_hi = 128;
                y_hi = 64;
                mult = this->mult / 2;
            }
            mult2 = mult - (mult > 4);
            r = rect;
            for (y = 0; y < y_hi; ++y)
            {
                for (x = 0; x < x_hi; ++x)
                {
                    if (this->pixel[y][x])
                    {
                        r->x = x * mult;
                        r->y = y * mult;
                        r->width = mult2;
                        r->height = mult2;
                        ++r;
                    }
                }
            }
            if (r > rect)
            {
                XGCValues       values;

                values.foreground = this->foreground;
                values.background = this->background;
                values.fill_style = FillSolid;
                XChangeGC
                (
                    display,
                    gc,
                    GCForeground | GCBackground | GCFillStyle,
                    &values
                );
                XFillRectangles(display, this->id, gc, rect, r - rect);
            }
        }
        break;

    case ConfigureNotify:
        {
            XConfigureEvent *cnep;
            int     mx, my;

            cnep = (XConfigureEvent *)ep;
            mx = cnep->width / 128;
            my = cnep->height / 64;
            this->mult = mx < my ? mx : my;
            if (this->mult < 1)
                this->mult = 1;
            this->mult *= 2;
            XClearArea(display, this->id, 0, 0, 0, 0, True);
        }
        break;
    }
    trace((/*{*/"}\n"));
}


void
arena_update(void *that, machine_t *machine)
{
    arena_t         *this;
    XRectangle      *r;
    int             mode;
    int             mult;
    int             mult2;
    int             x, y;
    int             x_hi, y_hi;
    XRectangle      rect[64*128];

    this = that;
    trace(("arena_update(this = %08lX, machine = %08lX)\n{\n"/*}*/,
        this, machine));
    if (machine->pixel_mode != this->mode)
    {
        XGCValues       values;

        values.foreground = this->background;
        values.background = this->foreground;
        values.fill_style = FillSolid;
        XChangeGC
        (
            display,
            gc,
            GCForeground | GCBackground | GCFillStyle,
            &values
        );

        r = rect;
        r->x = 0;
        r->y = 0;
        r->width = 64 * this->mult;
        r->height = 32 * this->mult;
        XFillRectangles(display, this->id, gc, r, 1);

        memset(this->pixel, 0, sizeof(this->pixel));
        this->mode = machine->pixel_mode;
    }

    mode = this->mode;
    if (!mode)
    {
        x_hi = 64;
        y_hi = 32;
        mult = this->mult;
    }
    else
    {
        x_hi = 128;
        y_hi = 64;
        mult = this->mult / 2;
    }
    mult2 = mult - (mult > 4);
    r = rect;
    for (y = 0; y < y_hi; ++y)
    {
        for (x = 0; x < x_hi; ++x)
        {
            if (machine->pixel[y][x] && !this->pixel[y][x])
            {
                r->x = x * mult;
                r->y = y * mult;
                r->width = mult2;
                r->height = mult2;
                ++r;
                this->pixel[y][x] = 1;
                trace(("turn (x = %d, y = %d) on\n", x, y));
            }
        }
    }
    if (r > rect)
    {
        XGCValues       values;

        values.foreground = this->foreground;
        values.background = this->background;
        values.fill_style = FillSolid;
        XChangeGC
        (
            display,
            gc,
            GCForeground | GCBackground | GCFillStyle,
            &values
        );
        XFillRectangles(display, this->id, gc, rect, r - rect);
    }
    r = rect;
    for (y = 0; y < y_hi; ++y)
    {
        for (x = 0; x < x_hi; ++x)
        {
            if (!machine->pixel[y][x] && this->pixel[y][x])
            {
                r->x = x * mult;
                r->y = y * mult;
                r->width = mult;
                r->height = mult;
                ++r;
                this->pixel[y][x] = 0;
                trace(("turn (x = %d, y = %d) off\n", x, y));
            }
        }
    }
    if (r > rect)
    {
        XGCValues       values;

        values.foreground = this->background;
        values.background = this->foreground;
        values.fill_style = FillSolid;
        XChangeGC
        (
            display,
            gc,
            GCForeground | GCBackground | GCFillStyle,
            &values
        );
        XFillRectangles(display, this->id, gc, rect, r - rect);
    }
    trace((/*{*/"}\n"));
}
