/*
 * chip8 - video game interpreter
 * Copyright (C) 1990, 1998, 2012 Peter Miller
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
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 */

#ifndef CHIP8AS_COL_H
#define CHIP8AS_COL_H

void col_open(const char *);
void col_close(void);
int col_create(int, int);
void col_puts(int, const char *);
void col_printf(int, const char *, ...);
void col_eoln(void);
void col_bol(int);
void col_heading(int, const char *);
void col_title(const char *, const char *);
void col_eject(void);
void col_need(int);
void col_cancel_columns(void);

#endif /* CHIP8AS_COL_H */
