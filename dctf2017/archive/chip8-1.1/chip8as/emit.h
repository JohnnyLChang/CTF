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

#ifndef CHIP8AS_EMIT_H
#define CHIP8AS_EMIT_H

long emit_get_pc(void);
void emit_byte(int);
void emit_word(int);
void emit_open(const char *filename);
void emit_close(void);
void emit_rewind(void);
void emit_eoln(void);
void emit_error(const char *);
void emit_warning(const char *);
void emit_listing(int, const char *);
void emit_list_addr(int);
void emit_list_code(int);
void emit_storage(long, long);
void emit_title(const char *, const char *);

#endif /* CHIP8AS_EMIT_H */
