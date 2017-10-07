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

#ifndef CHIP8RUN_BUTTON_H
#define CHIP8RUN_BUTTON_H

#include <chip8run/window.h>

typedef struct button_class_t button_class_t;
struct button_class_t
{
    WINDOW_METHODS
};

typedef struct button_t button_t;
struct button_t
{
    button_class_t *method;
    WINDOW_VARIABLES
    char    *name;
    char    *title;
    int     width;
    int     height;
    XCharStruct title_info;
    int     pressed;
    int     inside;
    int     key_pressed;
    struct timeval key_pressed_timeout;
    int     recently_polled;
    struct timeval recently_polled_timeout;
    int     cleared;
    int     latch;
    void    (*callback)(button_t *);
};

extern button_class_t button_class;

void button_new(void *, void *, int, int, int, int, const char *name,
    const char *title, int);
void button_free(void *);
struct timeval;
void button_event(void *, XEvent *, struct timeval *);
void button_key_pressed(button_t *, int, struct timeval *);
int button_test(button_t *this, int clear, struct timeval *now);
void button_tickle(void *this, struct timeval *max_sleep, struct timeval *now);

#endif /* CHIP8RUN_BUTTON_H */
