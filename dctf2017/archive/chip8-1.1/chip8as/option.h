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

#ifndef CHIP8_OPTION_H
#define CHIP8_OPTION_H

void option_set_listfile(const char *);
const char *option_get_listfile(void);
void option_set_hp_header(void);
int option_get_hp_header(void);
void option_set_unix_header(void);
int option_get_unix_header(void);
void option_set_c_format(void);
int option_get_c_format(void);
void option_set_raw_format(void);
int option_get_raw_format(void);
void option_set_asc_format(void);
int option_get_asc_format(void);

#endif /* CHIP8_OPTION_H */
