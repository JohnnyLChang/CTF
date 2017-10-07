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
#include <libexplain/strdup.h>

#include <common/trace.h>

#include <chip8run/button.h>
#include <chip8run/ecks.h>
#include <chip8run/window.h>


button_class_t button_class =
{
    sizeof(button_t),
    &window_class,
    button_new,
    button_event,
    button_free,
    button_tickle,
    window_geom,
};


void
button_new(void *that, void *parent, int x, int y, int dx, int dy,
    const char *name, const char *title, int cursor_number)
{
    button_t *this;
    XSetWindowAttributes attributes;
    int     direction;
    int     ascent;
    int     descent;
    Cursor  cursor;

    this = that;
    trace(("button_new(this = %08lX)\n{\n"/*}*/, this));
    this->parent = parent;
    this->width = dx;
    this->height = dy;

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
    win_std_info((window_t *)this, "Button", name);
    this->name = explain_strdup_or_die(name);
    this->title = explain_strdup_or_die(title);
    XTextExtents(this->font, this->title, strlen(this->title), &direction,
        &ascent, &descent, &this->title_info);

    XSelectInput(display, this->id, ExposureMask | ButtonPressMask |
        ButtonReleaseMask | EnterWindowMask | LeaveWindowMask |
        StructureNotifyMask);
    window_add((window_t *)this);
    XMapWindow(display, this->id);

    cursor = XCreateFontCursor(display, cursor_number);
    XDefineCursor(display, this->id, cursor);

    trace((/*{*/"}\n"));
}


void
button_free(void *that)
{
    button_t *this;

    this = that;
    trace(("button_free(this = %08lX)\n{\n"/*}*/, this));
    free(this->name);
    free(this->title);
    XDestroyWindow(display, this->id);
    window_remove((window_t *)this);
    free(this);
    trace((/*{*/"}\n"));
}


static void
button_draw(button_t *this)
{
    int     invert;
    int     disabled;
    XGCValues values;
    int     level;

    trace(("button_draw(this = %08lX)\n{\n"/*}*/, this));
    invert = (this->pressed && this->inside) || this->key_pressed;
    disabled = !(this->recently_polled || this->callback);
    values.foreground = this->foreground;
    values.background = this->background;
    values.font = this->font->fid;
    values.fill_style = FillTiled;
    if (!invert)
    {
        if (!disabled)
            /* white */
            level = 0;
        else
            /* light gray */
            level = 1;
    }
    else
    {
        if (!disabled)
            /* black */
            level = 4;
        else
            /* dark gray */
            level = 3;
    }
    values.tile = this->gray[level];
    XChangeGC
    (
        display,
        gc,
        GCForeground | GCBackground | GCFillStyle | GCTile | GCFont,
        &values
    );
    XFillRectangle
    (
        display,
        this->id,
        gc,
        1,
        1,
        this->width - 2,
        this->height - 2
    );
    values.tile = this->gray[invert ? 0 : 4];
    XChangeGC(display, gc, GCTile, &values);
    XDrawString
    (
        display,
        this->id,
        gc,
        (this->width - this->title_info.width) / 2,
        (this->height + this->title_info.ascent) / 2,
        this->title,
        strlen(this->title)
    );
    values.tile = this->gray[this->inside ? 4 : 0];
    XChangeGC(display, gc, GCTile, &values);
    XDrawRectangle
    (
        display,
        this->id,
        gc,
        0,
        0,
        this->width - 1,
        this->height - 1
    );
    trace((/*{*/"}\n"));
}


static void
button_pressed(button_t *this, int pressed)
{
    trace(("button_pressed(this = %08lX, pressed = %d)\n{\n", this, pressed));
    if (this->pressed != pressed)
    {
        this->pressed = pressed;
        button_draw(this);
        if (!pressed && this->inside && this->callback)
            this->callback(this);
        if (!pressed)
            this->cleared = 0;
        if (pressed)
            this->latch = 1;
    }
    trace((/*{*/"}\n"));
}


static void
button_inside(button_t *this, int inside)
{
    trace(("button_inside(this = %08lX)\n{\n"/*}*/, this));
    if (this->inside != inside)
    {
        this->inside = inside;
        button_draw(this);
    }
    trace((/*{*/"}\n"));
}


void
button_event(void *that, XEvent *ep, struct timeval *now)
{
    button_t        *this;

    (void)now;
    this = that;
    trace(("button_event(this = %08lX, ep = %08lX)\n{\n"/*}*/, this, ep));
    trace_string(this->name);
    switch (ep->type)
    {
    case Expose:
        button_draw(this);
        break;

    case ConfigureNotify:
        {
            XConfigureEvent *cnep;

            cnep = (XConfigureEvent *)ep;
            this->width = cnep->width;
            this->height = cnep->height;
            XClearArea(display, this->id, 0, 0, 0, 0, True);
        }
        break;

    case ButtonPress:
        button_pressed(this, 1);
        break;

    case ButtonRelease:
        button_pressed(this, 0);
        break;

    case EnterNotify:
        button_inside(this, 1);
        break;

    case LeaveNotify:
        button_inside(this, 0);
        break;
    }
    trace((/*{*/"}\n"));
}


int
button_test(button_t *this, int clear, struct timeval *now)
{
    int     foo;
    int     result;

    foo = this->recently_polled;
    result = this->latch;
    tv_add_ms(&this->recently_polled_timeout, now, 2*KEY_POLL_MS);
    this->recently_polled = 1;
    if (clear)
        this->cleared = 1;
    this->latch = 0;
    if (!foo)
        button_draw(this);
    return result;
}


void
button_key_pressed(button_t *this, int key_pressed, struct timeval *now)
{
    trace(("button_key_pressed(this = %08lX, key_pressed = %d)\n{\n",
        this, key_pressed));
    if (key_pressed)
    {
        if (!this->key_pressed)
        {
            this->key_pressed = 1;
            button_draw(this);
            if (this->callback)
                this->callback(this);
        }
        tv_add_ms(&this->key_pressed_timeout, now, 1000);
        this->latch = 1;
    }
    else
    {
        if (this->key_pressed)
            tv_add_ms(&this->key_pressed_timeout, now, 100);
    }
    trace((/*{*/"}\n"));
}


void
button_tickle(void *that, struct timeval *max_sleep, struct timeval *now)
{
    button_t        *this;
    int             redraw = 0;
    struct timeval  s1;
    struct timeval  s2;

    /*
     * timeout the key_pressed flag
     */
    this = that;
    tv_set(&s1, 10000);
    if (this->key_pressed)
    {
        if (tv_cmp(&this->key_pressed_timeout, now) <= 0)
        {
            this->key_pressed = 0;
            this->cleared = 0;
            redraw = 1;
        }
        else
            tv_sub(&s1, &this->key_pressed_timeout, now);
    }

    /*
     * timeout the recently polled flag
     */
    tv_set(&s2, 10000);
    if (this->recently_polled)
    {
        if (tv_cmp(&this->recently_polled_timeout, now) <= 0)
        {
            this->recently_polled = 0;
            this->cleared = 0;
            this->latch = 0;
            redraw = 1;
        }
        else
            tv_sub(&s2, &this->recently_polled_timeout, now);
    }

    /*
     * redraw the button if necessary
     */
    if (redraw)
        button_draw(this);

    /*
     * use the shortest sleep
     */
    if (tv_cmp(&s1, &s2) <= 0)
        *max_sleep = s1;
    else
        *max_sleep = s2;
}
