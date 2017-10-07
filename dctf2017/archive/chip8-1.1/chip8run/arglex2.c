/*
 * chip8 - X11 Chip8 interpreter
 * Copyright (C) 2012 Peter Miller
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

#include <chip8run/arglex2.h>


static arglex_table_t table[] =
{
    { "-Automated_Testing", arglex_token_automated_testing },
    { "-BackGround",        arglex_token_background        },
    { "-BorDer_color",      arglex_token_border_color      },
    { "-Border_Width",      arglex_token_border_width      },
    { "-DEbug",             arglex_token_debug             },
    { "-Display",           arglex_token_display           },
    { "-File",              arglex_token_file              },
    { "-FoNt",              arglex_token_font              },
    { "-ForeGround",        arglex_token_foreground        },
    { "-Geometry",          arglex_token_geometry          },
    { "-IConic",            arglex_token_iconic            },
    { "-Icon_Geometry",     arglex_token_icon_geometry     },
    { "-Name",              arglex_token_name              },
    { "-Test_Mode",         arglex_token_test_mode         },
    { "-Title",             arglex_token_title             },
    { "-XRM",               arglex_token_resource          },
    ARGLEX_END_MARKER
};


void
arglex2_init(int argc, char **argv)
{
    arglex_init(argc, argv, table);
}
