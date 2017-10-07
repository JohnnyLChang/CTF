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

#include <common/ac/assert.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>
#include <libexplain/output.h>

#include <common/sizeof.h>

#include <chip8run/ecks.h>
#include <chip8run/tile.h>


typedef struct tile_cache_t tile_cache_t;
struct tile_cache_t
{
    Pixmap          pixmap;
    int             level;
    long            foreground;
    long            background;
    tile_cache_t    *next;
};

static tile_cache_t *tile_cache;


Pixmap
tile_cache_create(int level, long foreground, long background)
{
    tile_cache_t    *cp;

    static char bitmap[5][8] =
    {
        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },
        { 0x88, 0x22, 0x88, 0x22, 0x88, 0x22, 0x88, 0x22, },
        { 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, },
        { 0x77, 0xDD, 0x77, 0xDD, 0x77, 0xDD, 0x77, 0xDD, },
        { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, },
    };

    /*
     * see if we already have one
     */
    for (cp = tile_cache; cp; cp = cp->next)
    {
        if
        (
            cp->level == level
        &&
            cp->foreground == foreground
        &&
            cp->background == background
        )
            return cp->pixmap;
    }

    /*
     * make a new item and place it at the front of the list
     */
    assert(level >= 0);
    assert((size_t)level < SIZEOF(bitmap));
    cp = (tile_cache_t *)explain_malloc_or_die(sizeof(tile_cache_t));
    memset(cp, 0, sizeof(*cp));
    cp->level = level;
    cp->foreground = foreground;
    cp->background = background;
    cp->next = tile_cache;
    tile_cache = cp;

    /*
     * finally!  we get to make the pixmap
     */
    cp->pixmap =
        XCreatePixmapFromBitmapData
        (
            display,
            DefaultRootWindow(display),
            bitmap[level],
            8,
            8,
            foreground,
            background,
            DefaultDepth(display, screen)
        );
    if (!cp->pixmap)
        explain_output_error_and_die("didn't make pixmap");
    return cp->pixmap;
}
