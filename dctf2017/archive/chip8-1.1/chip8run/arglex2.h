/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 2012 Peter Miller
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CHIP8RUN_ARGLEX2_H
#define CHIP8RUN_ARGLEX2_H

#include <common/arglex.h>

enum
{
    arglex_token_automated_testing = arglex_token_MAX_1,
    arglex_token_background,
    arglex_token_border_color,
    arglex_token_border_width,
    arglex_token_debug,
    arglex_token_display,
    arglex_token_file,
    arglex_token_font,
    arglex_token_foreground,
    arglex_token_geometry,
    arglex_token_iconic,
    arglex_token_icon_geometry,
    arglex_token_name,
    arglex_token_resource,
    arglex_token_test_mode,
    arglex_token_title,
    arglex_token_MAX_2
};

void arglex2_init(int argc, char **argv);

#endif /* CHIP8RUN_ARGLEX2_H */
