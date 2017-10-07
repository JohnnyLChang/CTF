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

#ifndef CHIP8RUN_WINDOW_H
#define CHIP8RUN_WINDOW_H

#include <X11/X.h>
#include <X11/Xlib.h>

struct timeval; /* existence */

#define KEY_POLL_MS 500

#define WINDOW_METHODS \
    long size;                              \
    void *base_class;                       \
    void (*new)(void *, void *, int, int, int, int, const char *name, \
                const char *title, int);  \
    void (*event)(void *, XEvent *, struct timeval *); \
    void (*free)(void *); \
    void (*tickle)(void *, struct timeval *, struct timeval *); \
    void (*geom)(void *, int, int, int, int);

typedef struct window_class_t window_class_t;
struct window_class_t
{
    WINDOW_METHODS
};

extern window_class_t window_class;

#define WINDOW_VARIABLES \
    window_t *parent;       \
    Window  id;             \
    int     foreground;     \
    int     background;     \
    int     border_width;   \
    Pixmap  gray[5];        \
    XFontStruct *font;


typedef struct window_t window_t;
struct window_t
{
    window_class_t *method;
    WINDOW_VARIABLES
};

struct timeval;

window_t *window_find(Window id);
void window_tickle(struct timeval *max_sleep, struct timeval *now);
void window_add(window_t *);
void window_remove(window_t *);
void win_std_info(window_t *, const char *loose, const char *tight);
window_t *window_new(void *class);

/* default methods */
void window_nop_new(void *, void *, int, int, int, int, const char *name,
    const char *title, int);
void window_nop_event(void *, XEvent *, struct timeval *);
void window_nop_free(void *);
void window_nop_tickle(void *, struct timeval *, struct timeval *);
void window_geom(void *, int, int, int, int);

void tv_sub(struct timeval *, struct timeval *, struct timeval *);
int tv_cmp(struct timeval *, struct timeval *);
void tv_add_ms(struct timeval *, struct timeval *, int);
void tv_set(struct timeval *result, int seconds);

#endif /* CHIP8RUN_WINDOW_H */
