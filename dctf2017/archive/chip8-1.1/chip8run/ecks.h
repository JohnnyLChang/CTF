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

#ifndef CHIP8RUN_ECKS_H
#define CHIP8RUN_ECKS_H

#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xresource.h>
#include <X11/cursorfont.h>
#include <X11/keysym.h>

#define MIN_WIDTH (8 + 64)
#define MIN_HEIGHT (8 + 64)
#define DEFAULT_WIDTH (8 + 64 * 4)
#define DEFAULT_HEIGHT (8 + 64 * 4)

extern  char    CLASS_NAME[];
extern  Display *display;
extern  int     screen;
extern  GC      gc;

void x_initialize(void);
void x_open(void);
char *x_get_resource(const char *loose, const char *tight);
int x_get_resource_bool(const char *loose, const char *tight, int dflt);
void x_resource1(const char *);
void x_resource2(const char *name, const char *value);
void print_size_hints(const char *, XSizeHints *);

#endif /* CHIP8RUN_ECKS_H */
