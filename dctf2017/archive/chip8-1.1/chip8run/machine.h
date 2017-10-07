/*
 * chip8 - video game interpreter
 * Copyright (C) 1990, 1998, 1999, 2012 Peter Miller
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

#ifndef CHIP8RUN_MACHINE_H
#define CHIP8RUN_MACHINE_H

#include <common/ac/stddef.h>
#include <common/ac/sys/types.h>

#define MAX_WIDTH 128
#define MAX_HEIGHT 64

#define MEM_MAX 0x1000
#define MEM_MIN 0x0200
#define STACK_SIZE 100

typedef enum halt_t halt_t;
enum halt_t
{
    halt_still_running,
    halt_stack_overflow,
    halt_stack_underflow,
    halt_illegal_instruction,
    halt_address_error,
};

const char *halt_name(halt_t);

typedef struct machine_t machine_t;
struct machine_t
{
    unsigned char   pixel[MAX_HEIGHT][MAX_WIDTH];
    int             pixel_mode;
    unsigned char   memory[MEM_MAX];
    unsigned char   program[MEM_MAX];
    unsigned char   v_reg[16];
    unsigned char   flag[16];
    unsigned char   time;
    unsigned char   tone;
    int             i_reg;
    int             stack[STACK_SIZE];
    int             stack_top;
    int             pc;
    halt_t          halt;
    int             program_length;
    int             debug;
    struct shell_t  *shell;
    struct timeval  next_tick;
    int             compatibility_save_restore;
    int             i_ambiguous;
};

machine_t *machine_alloc(const char *filename);

void machine_step(machine_t *mp, struct timeval *max_sleep,
    struct timeval *now);

void machine_load(machine_t *mp, const char *file_name);

void machine_reset(machine_t *mp);

void machine_reload(machine_t *mp);

/**
  * The machine_disassemble function is used to disassemble one
  * instruction at the current machine address.
  *
  * @param mp
  *     The virtual machine oif interest.
  * @param buffer
  *     The buffer into which to write the disassembled text.
  * @param buffer_size
  *     The size of the bufer to write into.
  */
void machine_disassemble(machine_t *mp, char *buffer, size_t buffer_size);

/**
  * The machine_dump function is used to make a screen image of the
  * chip8 machine state.  This is used to build the documentation for
  * the man pages for the games.
  *
  * Always written to a file called "chip8run.dump" in the current
  * directory.
  *
  * @param mp
  *     The virtual machine to dump.
  */
void machine_dump(machine_t *mp);

#endif /* CHIP8RUN_MACHINE_H */
