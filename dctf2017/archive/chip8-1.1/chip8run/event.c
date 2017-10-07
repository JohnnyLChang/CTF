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

#include <common/config.h>
#include <sys/types.h>
#include <sys/time.h>
#include <libexplain/gettimeofday.h>

#include <chip8run/ecks.h>
#include <chip8run/event.h>
#include <chip8run/window.h>
#include <common/trace.h>

#ifdef DEBUG

static const char *name[] =
{
    "event 0",
    "event 1",
    "KeyPress",
    "KeyRelease",
    "ButtonPress",
    "ButtonRelease",
    "MotionNotify",
    "EnterNotify",
    "LeaveNotify",
    "FocusIn",
    "FocusOut",
    "KeymapNotify",
    "Expose",
    "GraphicsExpose",
    "NoExpose",
    "VisibilityNotify",
    "CreateNotify",
    "DestroyNotify",
    "UnmapNotify",
    "MapNotify",
    "MapRequest",
    "ReparentNotify",
    "ConfigureNotify",
    "ConfigureRequest",
    "GravityNotify",
    "ResizeRequest",
    "CirculateNotify",
    "CirculateRequest",
    "PropertyNotify",
    "SelectionClear",
    "SelectionRequest",
    "SelectionNotify",
    "ColormapNotify",
    "ClientMessage",
    "MappingNotify",
};

#endif /* DEBUG */


void
event_loop(void)
{
    for (;;)
    {
        XEvent          event;
        window_t        *wp;
        struct timeval  max_sleep;
        struct timeval  now;

        trace(("mark\n"));
        explain_gettimeofday_or_die(&now, 0);
        while (XPending(display))
        {
            XNextEvent(display, &event);
            trace(("event.type == %s\n", name[event.type]));
            wp = window_find(event.xany.window);
            if (wp)
                wp->method->event(wp, &event, &now);
        }
        window_tickle(&max_sleep, &now);

        if (max_sleep.tv_sec || max_sleep.tv_usec)
        {
            fd_set  rmask;

            trace(("mark %d.%06d\n", max_sleep.tv_sec, max_sleep.tv_usec));
            FD_ZERO(&rmask);
            FD_SET(ConnectionNumber(display), &rmask);
            select(FD_SETSIZE, &rmask, 0, 0, &max_sleep);
        }
    }
}
