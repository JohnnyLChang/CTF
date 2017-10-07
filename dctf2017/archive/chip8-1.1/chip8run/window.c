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

#include <common/ac/string.h>
#include <common/ac/stdlib.h>
#include <sys/types.h>
#include <sys/time.h>
#include <libexplain/malloc.h>
#include <libexplain/output.h>

#include <common/trace.h>

#include <chip8run/ecks.h>
#include <chip8run/window.h>
#include <chip8run/tile.h>

static size_t   win_list_len;
static size_t   win_list_max;
static window_t **win_list;


window_t *
window_find(Window id)
{
    size_t          j;

    for (j = 0; j < win_list_len; ++j)
    {
        if (win_list[j]->id == id)
            return win_list[j];
    }
    return 0;
}


void
window_add(window_t *wp)
{
    if (win_list_len >= win_list_max)
    {
        size_t          new_win_list_max;
        size_t          nbytes;
        window_t        **new_win_list;
        size_t          j;

        new_win_list_max = win_list_max ? win_list_max * 2 : 4;
        nbytes = new_win_list_max * sizeof(window_t *);
        new_win_list = explain_malloc_or_die(nbytes);
        for (j = 0; j < win_list_len; ++j)
            new_win_list[j] = win_list[j];
        for (; j < new_win_list_max; ++j)
            new_win_list[j] = 0;
        if (win_list)
            free(win_list);
        win_list = new_win_list;
        win_list_max = new_win_list_max;
    }
    win_list[win_list_len++] = wp;
}


void
window_remove(window_t *wp)
{
    size_t          j;

    for (j = 0; j < win_list_len; ++j)
    {
        if (win_list[j] == wp)
        {
            win_list_len--;
            win_list[j] = win_list[win_list_len];
            return;
        }
    }
}


void
window_tickle(struct timeval *max_sleep, struct timeval *now)
{
    size_t          j;
    struct timeval  temp;

    trace(("window_tickle()\n{\n"/*}*/));
    tv_set(max_sleep, 60);
    for (j = 0; j < win_list_len; ++j)
    {
        window_t        *wp;

        wp = win_list[j];
        tv_set(&temp, 1000);
        wp->method->tickle(wp, &temp, now);

        /*
         * see if this one wants a short sleep
         */
        if (tv_cmp(&temp, max_sleep) < 0)
            *max_sleep = temp;
    }
    trace((/*{*/"}\n"));
}


void
win_std_info(window_t *this, const char *loose, const char *tight)
{
    char            loose_buf[100];
    char            tight_buf[100];
    char            *loose_ptr;
    char            *tight_ptr;
    unsigned long   color;
    int             num;
    const char      *res_str;

    trace(("win_std_info(this = %08lX)\n{\n"/*}*/, this));

    if (!gc)
    {
        gc =  XCreateGC(display, this->id, 0, 0);
        if (!gc)
            explain_output_error_and_die("no GC created");
    }

    /*
     * set up for resource shenanigens
     */
    if (loose)
    {
        strcpy(loose_buf, loose);
        strcat(loose_buf, ".");
        loose_ptr = loose_buf + strlen(loose_buf);
    }
    else
        loose_ptr = loose_buf;
    if (tight)
    {
        strcpy(tight_buf, tight);
        strcat(tight_buf, ".");
        tight_ptr = tight_buf + strlen(tight_buf);
    }
    else
        tight_ptr = tight_buf;

    /*
     * get the foreground
     */
    trace(("foreground\n"));
    strcpy(loose_ptr, "Foreground");
    strcpy(tight_ptr, "foreground");
    res_str = x_get_resource(loose_buf, tight_buf);
    if (!res_str)
        color = BlackPixel(display, screen);
    else
    {
        XColor  xcolor;

        if
        (
            !XParseColor
            (
                display,
                DefaultColormap(display, screen),
                res_str,
                &xcolor
            )
        )
        {
            explain_output_error_and_die
            (
                "foreground color \"%s\" invalid",
                res_str
            );
        }
        color = xcolor.pixel;
    }
    this->foreground = color;

    /*
     * get the background
     */
    trace(("background\n"));
    strcpy(loose_ptr, "Background");
    strcpy(tight_ptr, "background");
    res_str = x_get_resource(loose_buf, tight_buf);
    if (!res_str)
        color = WhitePixel(display, screen);
    else
    {
        XColor  xcolor;

        if
        (
            !XParseColor
            (
                display,
                DefaultColormap(display, screen),
                res_str,
                &xcolor
            )
        )
        {
            explain_output_error_and_die
            (
                "background color \"%s\" invalid",
                res_str
            );
        }
        color = xcolor.pixel;
    }
    XSetWindowBackground(display, this->id, color);
    this->background = color;

    /*
     * get the borderColor
     */
    trace(("borderColor\n"));
    strcpy(loose_ptr, "BorderColor");
    strcpy(tight_ptr, "borderColor");
    res_str = x_get_resource(loose_buf, tight_buf);
    if (!res_str)
        color = BlackPixel(display, screen);
    else
    {
        XColor  xcolor;

        if
        (
            !XParseColor
            (
                display,
                DefaultColormap(display, screen),
                res_str,
                &xcolor
            )
        )
        {
            explain_output_error_and_die
            (
                "borderColor color \"%s\" invalid",
                res_str
            );
        }
        color = xcolor.pixel;
    }
    XSetWindowBorder(display, this->id, color);

    /*
     * get the borderWidth
     */
    trace(("borderWidth\n"));
    strcpy(loose_ptr, "BorderWidth");
    strcpy(tight_ptr, "borderWidth");
    res_str = x_get_resource(loose_buf, tight_buf);
    if (!res_str)
        num = 1;
    else
    {
        num = atoi(res_str);
        if (num < 1)
        {
            explain_output_error_and_die("borderWidth \"%s\" invalid", res_str);
        }
    }
    if (num != 1)
        XSetWindowBorder(display, this->id, num);
    this->border_width = num;
    if (num != 1)
        XSetWindowBorderWidth(display, this->id, num);

    /*
     * get the font
     */
    trace(("font\n"));
    strcpy(loose_ptr, "Font");
    strcpy(tight_ptr, "font");
    res_str = x_get_resource(loose_buf, tight_buf);
    if (!res_str)
        res_str = "8x13bold";
    trace_string(res_str);
    this->font = XLoadQueryFont(display, res_str);
    if (!this->font)
        explain_output_error_and_die("font \"%s\" unavailable", res_str);

    for (num = 0; num < 5; ++num)
    {
        this->gray[num] =
            tile_cache_create
            (
                num,
                this->foreground,
                this->background
            );
    }
    trace((/*{*/"}\n"));
}


window_t *
window_new(void *vclass)
{
    window_t        *wp;
    window_class_t  *class;

    class = vclass;
    wp = (window_t *)explain_malloc_or_die(class->size);
    memset(wp, 0, class->size);
    wp->method = class;
    return wp;
}


void
window_nop_new(void *that, void *a, int b, int c, int d, int e, const char *f,
    const char *g, int h)
{
    (void)that;
    (void)a;
    (void)b;
    (void)c;
    (void)d;
    (void)e;
    (void)f;
    (void)g;
    (void)h;
}


void
window_nop_event(void *that, XEvent *a, struct timeval *b)
{
    (void)that;
    (void)a;
    (void)b;
}


void
window_nop_tickle(void *that, struct timeval *a, struct timeval *b)
{
    (void)that;
    (void)a;
    (void)b;
}


static void
window_class_free(void *this)
{
    free(this);
}


window_class_t window_class =
{
    sizeof(window_t),
    0,
    window_nop_new,
    window_nop_event,
    window_class_free,
    window_nop_tickle,
    window_geom,
};


void
window_geom(void *that, int x, int y, int dx, int dy)
{
    window_t *this;
    XWindowChanges  change;

    this = that;
    change.x = x - this->border_width;
    change.y = y - this->border_width;
    change.width = dx;
    change.height = dy;
    XConfigureWindow(display, this->id, CWX|CWY|CWWidth|CWHeight, &change);
}


void
tv_sub(struct timeval *result, struct timeval *left, struct timeval *right)
{
    result->tv_sec = left->tv_sec - right->tv_sec;
    result->tv_usec = left->tv_usec - right->tv_usec;
    if (result->tv_usec < 0)
    {
        result->tv_usec += 1000000;
        result->tv_sec--;
    }
}


int
tv_cmp(struct timeval *left, struct timeval *right)
{
    if (left->tv_sec < right->tv_sec)
        return -1;
    if (left->tv_sec > right->tv_sec)
        return 1;
    if (left->tv_usec < right->tv_usec)
        return -1;
    if (left->tv_usec > right->tv_usec)
        return 1;
    return 0;
}


void
tv_add_ms(struct timeval *result, struct timeval *left, int ms)
{
    result->tv_sec = left->tv_sec;
    result->tv_usec = left->tv_usec + ms * 1000;
    while (result->tv_usec >= 1000000)
    {
        result->tv_usec -= 1000000;
        result->tv_sec++;
    }
}


void
tv_set(struct timeval *result, int seconds)
{
    result->tv_sec = seconds;
    result->tv_usec = 0;
}
