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

#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <common/ac/time.h>
#include <libexplain/fclose.h>
#include <libexplain/malloc.h>
#include <libexplain/output.h>

#include <common/input.h>
#include <common/trace.h>

#include <chip8run/option.h>
#include <chip8run/machine.h>
#include <chip8run/shell.h>

#define HERTZ 60
#define INTERVAL (1000000/HERTZ)


/*
 * include the hexadecimal digit images
 */
#include <chip8run/hex5.h>
#include <chip8run/hex10.h>


machine_t *
machine_alloc(const char *fn)
{
    machine_t       *this;

    this = (machine_t *)explain_malloc_or_die(sizeof(machine_t));
    memset(this, 0, sizeof(*this));
    machine_load(this, fn);
    machine_reload(this);
    this->shell = 0;
    this->debug = option_get_debug();
    return this;
}


static void
interpret_scdown(machine_t *this, int dy)
{
    if (dy <= 0 || dy > 15)
        return;

    trace(("scdown %d\n", dy));
    memmove
    (
        &this->pixel[dy],
        &this->pixel[0],
        (MAX_HEIGHT - dy) * sizeof(this->pixel[0])
    );
    memset
    (
        &this->pixel[0],
        0,
        dy * sizeof(this->pixel[0])
    );
}


static void
interpret_scright(machine_t *this)
{
    int             x, y;

    trace(("scright\n"));
    for (y = 0; y < MAX_HEIGHT; ++y)
    {
        for (x = MAX_WIDTH - 1; x >= 4; --x)
            this->pixel[y][x] = this->pixel[y][x - 4];
        while (x-- > 0)
            this->pixel[y][x] = 0;
    }
}


static void
interpret_scleft(machine_t *this)
{
    int             x, y;
    int             x_hi;

    trace(("scleft\n"));
    if (this->pixel_mode)
        x_hi = MAX_WIDTH;
    else
        x_hi = MAX_WIDTH / 2;
    for (y = 0; y < MAX_HEIGHT; ++y)
    {
        for (x = 0; x < x_hi - 4; ++x)
            this->pixel[y][x] = this->pixel[y][x + 4];
        for (; x < x_hi; ++x)
            this->pixel[y][x] = 0;
    }
}


static void
check_i_ambiguous(machine_t *this)
{
    if (!this->i_ambiguous)
        return;
    this->i_ambiguous = 0;
    explain_output_warning("%03X: i-register ambiguous", this->pc - 2);
}


static void
interpret_draw(machine_t *this, int x, int y, int draw_lins)
{
    int             mx, my;
    int             pattern;
    int             draw_bits;
    int             x_hi, y_hi;

    if (this->pixel_mode)
    {
        x_hi = MAX_WIDTH;
        y_hi = MAX_HEIGHT;
    }
    else
    {
        x_hi = MAX_WIDTH / 2;
        y_hi = MAX_HEIGHT / 2;
    }
    x %= x_hi;
    y %= y_hi;

    /* don't draw past right edge */
    draw_bits = 8;
    if (x + 8 > x_hi)
        draw_bits = x_hi - x;

    /* don't draw past bottom edge */
    if (y + draw_lins > y_hi)
        draw_lins = y_hi - y;

    /*
     * update the this->pixel
     */
    check_i_ambiguous(this);
    this->v_reg[15] = 0;
    for (my = y; my < y + draw_lins; ++my)
    {
        pattern = this->memory[this->i_reg + my - y];
        for (mx = x; mx < x + draw_bits; ++mx)
        {
            if (pattern & (0x80 >> (mx - x)))
            {
                if (this->pixel[my][mx])
                    this->v_reg[15] = 1;
                this->pixel[my][mx] ^= 1;
            }
        }
    }
}


static void
interpret_xdraw(machine_t *this, int x, int y)
{
    int             mx, my;
    int             pattern;
    int             draw_lins, draw_bits;
    int             x_hi, y_hi;
    int             mpos;

    if (this->pixel_mode)
    {
        x_hi = MAX_WIDTH;
        y_hi = MAX_HEIGHT;
    }
    else
    {
        x_hi = MAX_WIDTH / 2;
        y_hi = MAX_HEIGHT / 2;
    }
    x %= x_hi;
    y %= y_hi;

    /* don't draw past right edge */
    draw_bits = 16;
    if (x + draw_bits > x_hi)
        draw_bits = x_hi - x;

    /* don't draw past bottom edge */
    draw_lins = 16;
    if (y + draw_lins > y_hi)
        draw_lins = y_hi - y;

    /*
     * update the this->pixel
     */
    check_i_ambiguous(this);
    this->v_reg[15] = 0;
    mpos = this->i_reg;
    for (my = y; my < y + draw_lins; ++my)
    {
        pattern =
            ((this->memory[mpos] & 0xFF) << 8) |
            (this->memory[mpos + 1] & 0xFF) ;
        mpos += 2;
        for (mx = x; mx < x + draw_bits; ++mx)
        {
            if (pattern & ((unsigned)0x8000 >> (mx - x)))
            {
                if (this->pixel[my][mx])
                    this->v_reg[15] = 1;
                this->pixel[my][mx] ^= 1;
            }
        }
    }
}


void
machine_step(machine_t *this, struct timeval *max_sleep, struct timeval *now)
{
    unsigned char   x, y, n, kk;
    unsigned        nnn;
    unsigned        opcode;
    int             tick_edge;

    if (this->halt)
        return;
    trace(("machine_step(this = %08lX)\n{\n", this));
    /* most opcodes have no delay */
    max_sleep->tv_sec = 0;
    max_sleep->tv_usec = 0;

    tick_edge =
        (
            now->tv_sec > this->next_tick.tv_sec
        ||
            (
                now->tv_sec == this->next_tick.tv_sec
            &&
                now->tv_usec > this->next_tick.tv_usec
            )
        );

    if (tick_edge)
    {
        /*
         * work out then the next tick happens
         */
        this->next_tick.tv_usec = INTERVAL * (now->tv_usec / INTERVAL + 1);
        this->next_tick.tv_sec = now->tv_sec;
        /*
         * tricky... the first two don't work
         * because 1000000-INTERVAL*HERTZ != 0
         * and you have to account for those missing microseconds
         *
         * if (this->next_tick.tv_usec >= 1000000)
         * if (this->next_tick.tv_usec >= INTERVAL*HERTZ)
         */
        if (this->next_tick.tv_usec > INTERVAL * (HERTZ - 1))
        {
            this->next_tick.tv_usec = 0;
            this->next_tick.tv_sec++;
        }

        /*
         * decriment counters
         */
        if (this->time)
            this->time--;
        if (this->tone)
            this->tone--;
    }
    if (this->pc < MEM_MIN || this->pc >= MEM_MAX || (this->pc & 1))
    {
        this->halt = halt_address_error;
        this->debug = 1;
        goto ret;
    }
    opcode = (this->memory[this->pc] << 8) | this->memory[this->pc + 1];
    this->pc += 2;
    x = (opcode & 0x0F00) >> 8;
    y = (opcode & 0x00F0) >> 4;
    n = opcode & 0x000F;
    kk = opcode & 0x00FF;
    nnn = opcode & 0x0FFF;

    switch ((opcode & 0xF000) >> 12)
    {
    case 0:
        switch (nnn)
        {
        case 0x0010:
        case 0x0011:
            /* exit */
            exit(nnn & 1);

        case 0x00C0: case 0x00C1: case 0x00C2: case 0x00C3:
        case 0x00C4: case 0x00C5: case 0x00C6: case 0x00C7:
        case 0x00C8: case 0x00C9: case 0x00CA: case 0x00CB:
        case 0x00CC: case 0x00CD: case 0x00CE: case 0x00CF:
            /* scdown */
            if (!tick_edge && !this->pixel_mode)
                goto not_tick_edge;
            interpret_scdown(this, n);
            goto update_the_screen;

        case 0x00E0:
            /* clear */
            memset(this->pixel, 0, sizeof(this->pixel));
            if (this->shell)
                shell_chip8_update(this->shell);
            goto ret;

        case 0x00EE:
            /* ret */
            if (this->stack_top == 0)
            {
                this->pc -= 2;
                this->debug = 1;
                this->halt = halt_stack_underflow;
                goto ret;
            }
            this->stack_top--;
            this->pc = this->stack[this->stack_top];
            goto ret;

        case 0x00FA:
            /* compatibility */
            this->compatibility_save_restore = 1;
            goto ret;

        case 0x00FB:
            /* scright */
            if (!tick_edge && !this->pixel_mode)
                goto not_tick_edge;
            interpret_scright(this);
            goto update_the_screen;

        case 0x00FC:
            /* scleft */
            if (!tick_edge && !this->pixel_mode)
                goto not_tick_edge;
            interpret_scleft(this);
            goto update_the_screen;

        case 0x00FD:
            /* exit */
            exit(0);

        case 0x00FE:
            /* low */
            this->pixel_mode = 0;

            trace(("update\n"));
            if (this->shell)
                shell_chip8_update(this->shell);

            /*
             * A totally trivial wait.
             * This tells this->shell to stop looping.
             */
            max_sleep->tv_usec = 1;
            goto ret;

        case 0x00FF:
            /* high */
            this->pixel_mode = 1;

            trace(("update\n"));
            if (this->shell)
                shell_chip8_update(this->shell);

            /*
             * A totally trivial wait.
             * This tells this->shell to stop looping.
             */
            max_sleep->tv_usec = 1;
            goto ret;
        }
        break;

    case 1:
        /* jump */
        if (nnn < MEM_MIN || (nnn & 1))
            break;
        this->pc = nnn;
        goto ret;

    case 2:
        /* call */
        if (nnn < MEM_MIN || (nnn & 1))
            break;
        if (this->stack_top >= STACK_SIZE)
        {
            this->pc -= 2;
            this->debug = 1;
            this->halt = halt_stack_overflow;
            goto ret;
        }
        this->stack[this->stack_top] = this->pc;
        this->stack_top++;
        this->pc = nnn;
        goto ret;

    case 3:
        /* skip.eq vX, KK */
        if (this->v_reg[x] == kk)
            this->pc += 2;
        goto ret;

    case 4:
        /* skip.ne vX, KK */
        if (this->v_reg[x] != kk)
            this->pc += 2;
        goto ret;

    case 5:
        /* skip.eq vX, vY */
        if (x == y)
            break;
        if (this->v_reg[x] == this->v_reg[y])
            this->pc += 2;
        goto ret;

    case 6:
        /* load vX, KK */
        this->v_reg[x] = kk;
        goto ret;

    case 7:
        /* add vX, KK */
        this->v_reg[x] += kk;
        goto ret;

    case 8:
        switch (n)
        {
            unsigned char v15;

        case 0:
            /* load vX, vY */
            this->v_reg[x] = this->v_reg[y];
            goto ret;

        case 1:
            /* or vX, vY */
            this->v_reg[x] |= this->v_reg[y];
            goto ret;

        case 2:
            /* and vX, vY */
            this->v_reg[x] &= this->v_reg[y];
            goto ret;

        case 3:
            /* xor vX, vY */
            this->v_reg[x] ^= this->v_reg[y];
            goto ret;

        case 4:
            /* add vX, vY */
            v15 = (this->v_reg[x] + this->v_reg[y]) >= 256;
            this->v_reg[x] += this->v_reg[y];
            this->v_reg[15] = v15;
            goto ret;

        case 5:
            /* sub vX, vY */
            v15 = (this->v_reg[x] - this->v_reg[y]) < 0;
            this->v_reg[x] -= this->v_reg[y];
            this->v_reg[15] = v15;
            goto ret;

        case 6:
            /* lsr vX */
            v15 = this->v_reg[x] & 1;
            this->v_reg[x] >>= 1;
            this->v_reg[15] = v15;
            goto ret;

        case 7:
            /* dif vX, vY */
            v15 = (this->v_reg[y] - this->v_reg[x]) < 0;
            this->v_reg[x] = this->v_reg[y] - this->v_reg[x];
            this->v_reg[15] = v15;
            goto ret;

        case 14:
            /* lsl vX */
            v15 = this->v_reg[x] >= 128;
            this->v_reg[x] <<= 1;
            this->v_reg[15] = v15;
            goto ret;
        }
        break;

    case 9:
        /* skip.ne vX, vY */
        if (this->v_reg[x] != this->v_reg[y])
            this->pc += 2;
        goto ret;

    case 10:
        /* load i, NNN */
        this->i_reg = nnn;
        this->i_ambiguous = 0;
        goto ret;

    case 11:
        /* jump nnn, v0 */
        nnn += this->v_reg[0];
        if (nnn < MEM_MIN || nnn >= MEM_MAX || (nnn & 1))
        {
            this->halt = halt_address_error;
            this->pc -= 2;
            this->debug = 1;
            goto ret;
        }
        this->pc = nnn;
        goto ret;

    case 12:
        /* rnd vX, KK */
        this->v_reg[x] = (rand() >> 7) & kk;
        goto ret;

    case 13:
        /*
         * drawing happens on a tick edge
         * in low-resolution mode
         *
         * Put delay at this end of opcode,
         * so can do work while we wait.
         * I.e. after drawing.
         */
        if (!tick_edge && !this->pixel_mode)
        {
            not_tick_edge:

            /*
             * back up and have another try later
             */
            this->pc -= 2;

            /*
             * work out how long it is until the next tick
             */
            max_sleep->tv_sec =
                this->next_tick.tv_sec - now->tv_sec;
            max_sleep->tv_usec =
                this->next_tick.tv_usec - now->tv_usec;
            if (max_sleep->tv_usec < 0)
            {
                max_sleep->tv_usec += 1000000;
                max_sleep->tv_sec--;
            }
            goto ret;
        }

        /* draw vX, vY, N */
        x = this->v_reg[x];
        y = this->v_reg[y];
        nnn = opcode & 15;
        if (nnn)
            interpret_draw(this, x, y, nnn);
        else
            interpret_xdraw(this, x, y);

        update_the_screen:
        trace(("update\n"));
        if (this->shell)
            shell_chip8_update(this->shell);

        /*
         * A totally trivial wait.
         * This tells this->shell to stop looping.
         */
        max_sleep->tv_usec = 1;
        goto ret;

    case 14:
        switch (kk)
        {
        case 0x9E:
            /* skip.eq vX, key */
            if (this->shell)
            {
                if (shell_test_key(this->shell, this->v_reg[x], 0, now))
                    this->pc += 2;
            }

            /*
             * A totally trivial wait.
             * This tells this->shell to stop looping.
             */
            max_sleep->tv_usec = 1;
            goto ret;

        case 0xA1:
            /* skip.ne vX, key */
            if (this->shell)
            {
                if (!shell_test_key(this->shell, this->v_reg[x], 0, now))
                    this->pc += 2;
            }

            /*
             * A totally trivial wait.
             * This tells this->shell to stop looping.
             */
            max_sleep->tv_usec = 1;
            goto ret;
        }
        break;

    case 15:
        switch (kk)
        {
        case 0x07:
            /* load vX, time */
            this->v_reg[x] = this->time;
            goto ret;

        case 0x0A:
            /* load vX, key */
            if (this->shell)
            {
                int     key;

                for (key = 0; key < 16; ++key)
                {
                    if (shell_test_key(this->shell, key, 1, now))
                    {
                        this->v_reg[x] = key;
                        goto ret;
                    }
                }
                this->pc -= 2;
                /*
                 * wait for a X event,
                 * one will herald a key happening
                 */
                max_sleep->tv_sec = 0;
                max_sleep->tv_usec = KEY_POLL_MS * 1000;
            }
            else
            {
                explain_output_error_and_die
                (
                    "automated testing mode, no keys available"
                );
            }
            goto ret;

        case 0x15:
            /* load time, vX */
            this->time = this->v_reg[x];
            goto ret;

        case 0x18:
            /* load tone, vX */
            this->tone = this->v_reg[x];
            goto ret;

        case 0x1E:
            /* add i, vX */
            check_i_ambiguous(this);
            this->i_reg += this->v_reg[x];
            if (this->i_reg >= MEM_MAX)
            {
                this->i_reg &= 0x0FFF;

                /* error if overflows */
                this->halt = halt_address_error;
                this->debug = 1;
                this->pc -= 2;
            }
            goto ret;

        case 0x29:
            /* hex vX */
            this->i_reg = 5 * (this->v_reg[x] & 15);
            this->i_ambiguous = 0;
            goto ret;

        case 0x30:
            /* xhex vX */
            this->i_reg = sizeof(hex5) + 10 * (this->v_reg[x] & 15);
            this->i_ambiguous = 0;
            goto ret;

        case 0x33:
            /* bcd vX */
            {
                int     d;

                check_i_ambiguous(this);
                d = this->v_reg[x];
                if (this->i_reg + 3 > MEM_MAX)
                {
                    this->halt = halt_address_error;
                    this->debug = 1;
                    this->pc -= 2;
                    goto ret;
                }
                this->memory[this->i_reg] = d / 100;
                this->memory[this->i_reg + 1] = (d / 10) % 10;
                this->memory[this->i_reg + 2] = d % 10;
                /* I does not change */
            }
            goto ret;

        case 0x55:
            {
                /* save vX */
                int     i;

                check_i_ambiguous(this);
                ++x;
                if (this->i_reg + x > MEM_MAX)
                {
                    this->halt = halt_address_error;
                    this->debug = 1;
                    this->pc -= 2;
                    goto ret;
                }
                for (i = 0; i < x; ++i)
                    this->memory[this->i_reg++] = this->v_reg[i];
                if (this->compatibility_save_restore)
                    this->i_reg -= x;
                this->i_ambiguous = 1;
            }
            goto ret;

        case 0x65:
            {
                /* restore vX */
                int     i;

                check_i_ambiguous(this);
                ++x;
                if (this->i_reg + x > MEM_MAX)
                {
                    this->halt = halt_address_error;
                    this->debug = 1;
                    this->pc -= 2;
                    goto ret;
                }
                for (i = 0; i < x; ++i)
                    this->v_reg[i] = this->memory[this->i_reg++];
                if (this->compatibility_save_restore)
                    this->i_reg -= x;
                this->i_ambiguous = 1;
            }
            goto ret;

        case 0x0075:
            {
                /* flags.save vX */
                int     i;

                for (i = 0; i <= x; ++i)
                    this->flag[i] = this->v_reg[i];
            }
            goto ret;

        case 0x0085:
            {
                /* flags.restore vX */
                int     i;

                for (i = 0; i <= x; ++i)
                    this->v_reg[i] = this->flag[i];
            }
            goto ret;
        }
        break;
    }

    /*
     * illegal instruction
     */
    this->halt = halt_illegal_instruction;
    this->pc -= 2;
    this->debug = 1;
ret:
    if (!this->shell && this->halt)
    {
        explain_output_error_and_die
        (
            "%03X: %s",
            this->pc,
            halt_name(this->halt)
        );
    }
    if (this->debug && option_get_test_mode())
        exit(1);
    trace(("}\n"));
}


void
machine_load(machine_t *this, const char *fn)
{
    input_t         *fp;
    int             c;
    int             pc;

    trace(("machine_load(this = %08lX, fn = %08lX)\n{\n", this, fn));
    trace_string(fn);

    fp = input_open(fn);

    memset(this->program, 0, sizeof(this->program));
    memcpy(this->program, hex5, sizeof(hex5));
    memcpy(this->program + sizeof(hex5), hex10, sizeof(hex10));

    pc = MEM_MIN;
    for (;;)
    {
        c = input_getc(fp);
        if (c < 0)
            break;
        if (pc >= MEM_MAX)
            explain_output_error_and_die("%s: program too large", fn);
        this->program[pc++] = c;
    }
    if (pc - MEM_MIN < 2)
        input_fatal(fp, "program too short");
    input_close(fp);
    this->program_length = pc - MEM_MIN;
    trace(("}\n"));
}


void
machine_reload(machine_t *this)
{
    /*
     * load the program into memory
     */
    trace(("machine_reload(this = %08lX)\n{\n", this));
    memcpy(this->memory, this->program, MEM_MAX);
    machine_reset(this);
    trace(("}\n"));
}


void
machine_reset(machine_t *this)
{
    int     c;

    trace(("machine_reset(this = %08lX)\n{\n", this));

    /*
     * clear the image
     */
    memset(this->pixel, 0, sizeof(this->pixel));

    /*
     * reset all registers
     */
    this->halt = 0;
    this->stack_top = 0;
    this->i_reg = 0; /* (rand() >> 3) & 0xFFF */
    this->i_ambiguous = 1;
    this->pc = MEM_MIN;
    this->time = 0;
    this->tone = 0;
    for (c = 0; c < 16; ++c)
        this->v_reg[c] = 0; /* rand() >> 7; */
    trace(("}\n"));
}


void
machine_disassemble(machine_t *this, char *buffer, size_t buffer_size)
{
    unsigned char   x, y, n, kk;
    unsigned        nnn;
    unsigned        opcode;
    const char      *buffer_end;

    trace(("machine_disassemble(this = %08lX)\n{\n", this));
    buffer_end = buffer + buffer_size;
    snprintf(buffer, buffer_size, "%03X: ", this->pc);
    buffer += strlen(buffer);
    if (this->pc < MEM_MIN || this->pc >= MEM_MAX || (this->pc & 1))
    {
        snprintf(buffer, buffer_end - buffer, "%s", "illegal address");
        goto ret;
    }
    opcode = (this->memory[this->pc] << 8) | this->memory[this->pc + 1];
    snprintf(buffer, buffer_end - buffer, "%04X ", opcode);
    buffer += strlen(buffer);
    x = (opcode & 0x0F00) >> 8;
    y = (opcode & 0x00F0) >> 4;
    n = opcode & 0x000F;
    kk = opcode & 0x00FF;
    nnn = opcode & 0x0FFF;

    switch ((opcode & 0xF000) >> 12)
    {
    case 0:
        switch (nnn)
        {
        case 0x0010:
        case 0x0011:
            /* exit */
            snprintf(buffer, buffer_end - buffer, "exit %d", (nnn & 1));
            goto ret;

        case 0x00C0: case 0x00C1: case 0x00C2: case 0x00C3:
        case 0x00C4: case 0x00C5: case 0x00C6: case 0x00C7:
        case 0x00C8: case 0x00C9: case 0x00CA: case 0x00CB:
        case 0x00CC: case 0x00CD: case 0x00CE: case 0x00CF:
            /* scdown */
            snprintf(buffer, buffer_end - buffer, "scdown %d", (nnn & 15));
            goto ret;

        case 0x00E0:
            /* clear */
            snprintf(buffer, buffer_end - buffer, "%s", "clear");
            goto ret;

        case 0x00EE:
            /* ret */
            snprintf(buffer, buffer_end - buffer, "%s", "ret");
            goto ret;

        case 0x00FA:
            /* compatibility */
            snprintf(buffer, buffer_end - buffer, "%s", "compatibility");
            goto ret;

        case 0x00FB:
            /* scright */
            snprintf(buffer, buffer_end - buffer, "%s", "scright");
            goto ret;

        case 0x00FC:
            /* scleft */
            snprintf(buffer, buffer_end - buffer, "%s", "scleft");
            goto ret;

        case 0x00FD:
            /* exit */
            snprintf(buffer, buffer_end - buffer, "%s", "exit");
            goto ret;

        case 0x00FE:
            /* low */
            snprintf(buffer, buffer_end - buffer, "%s", "low");
            goto ret;

        case 0x00FF:
            /* high */
            snprintf(buffer, buffer_end - buffer, "%s", "high");
            goto ret;
        }
        break;

    case 1:
        /* jump */
        snprintf(buffer, buffer_end - buffer, "jump 0x%03X", nnn);
        goto ret;

    case 2:
        /* call */
        snprintf(buffer, buffer_end - buffer, "call 0x%03X", nnn);
        goto ret;

    case 3:
        /* skip.eq vX, KK */
        snprintf(buffer, buffer_end - buffer, "skip.eq v%X, 0x%02X", x, kk);
        goto ret;

    case 4:
        /* skip.ne vX, KK */
        snprintf(buffer, buffer_end - buffer, "skip.ne v%X, 0x%02X", x, kk);
        goto ret;

    case 5:
        /* skip.eq vX, vY */
        snprintf(buffer, buffer_end - buffer, "skip.eq v%X, v%X", x, y);
        goto ret;

    case 6:
        /* load vX, KK */
        snprintf(buffer, buffer_end - buffer, "load v%X, 0x%02X", x, kk);
        goto ret;

    case 7:
        /* add vX, KK */
        snprintf(buffer, buffer_end - buffer, "add v%X, 0x%02X", x, kk);
        goto ret;

    case 8:
        switch (n)
        {
        case 0:
            /* load vX, vY */
            snprintf(buffer, buffer_end - buffer, "load v%X, v%X", x, y);
            goto ret;

        case 1:
            /* or vX, vY */
            snprintf(buffer, buffer_end - buffer, "or v%X, v%X", x, y);
            goto ret;

        case 2:
            /* and vX, vY */
            snprintf(buffer, buffer_end - buffer, "and v%X, v%X", x, y);
            goto ret;

        case 3:
            /* xor vX, vY */
            snprintf(buffer, buffer_end - buffer, "xor v%X, v%X", x, y);
            goto ret;

        case 4:
            /* add vX, vY */
            snprintf(buffer, buffer_end - buffer, "add v%X, v%X", x, y);
            goto ret;

        case 5:
            /* sub vX, vY */
            snprintf(buffer, buffer_end - buffer, "sub v%X, v%X", x, y);
            goto ret;

        case 6:
            /* lsr vX */
            snprintf(buffer, buffer_end - buffer, "lsr v%X", x);
            goto ret;

        case 7:
            /* dif vX, vY */
            snprintf(buffer, buffer_end - buffer, "dif v%X, v%X", x, y);
            goto ret;

        case 14:
            /* lsl vX */
            snprintf(buffer, buffer_end - buffer, "lsl v%X", x);
            goto ret;
        }
        break;

    case 9:
        /* skip.ne vX, vY */
        snprintf(buffer, buffer_end - buffer, "skip.ne v%X, v%X", x, y);
        goto ret;

    case 10:
        /* load i, NNN */
        snprintf(buffer, buffer_end - buffer, "load i, 0x%03X", nnn);
        goto ret;

    case 11:
        /* jump nnn, v0 */
        snprintf(buffer, buffer_end - buffer, "jump 0x%03X, v0", nnn);
        goto ret;

    case 12:
        /* rnd vX, KK */
        snprintf(buffer, buffer_end - buffer, "rnd v%X, 0x%02X", x, kk);
        goto ret;

    case 13:
        /* draw vX, vY, N */
        if (n)
            snprintf(buffer, buffer_end - buffer, "draw v%X, v%X, %d", x, y, n);
        else
            snprintf(buffer, buffer_end - buffer, "xdraw v%X, v%X", x, y);
        goto ret;

    case 14:
        switch (kk)
        {
        case 0x9E:
            /* skip.eq vX, key */
            snprintf(buffer, buffer_end - buffer, "skip.eq v%X, key", x);
            goto ret;

        case 0xA1:
            /* skip.ne vX, key */
            snprintf(buffer, buffer_end - buffer, "skip.ne v%X, key", x);
            goto ret;
        }
        break;

    case 15:
        switch (kk)
        {
        case 0x07:
            /* load vX, time */
            snprintf(buffer, buffer_end - buffer, "load v%X, time", x);
            goto ret;

        case 0x0A:
            /* load vX, key */
            snprintf(buffer, buffer_end - buffer, "load v%X, key", x);
            goto ret;

        case 0x15:
            /* load time, vX */
            snprintf(buffer, buffer_end - buffer, "load time, v%X", x);
            goto ret;

        case 0x18:
            /* load tone, vX */
            snprintf(buffer, buffer_end - buffer, "load tone, v%X", x);
            goto ret;

        case 0x1E:
            /* add i, vX */
            snprintf(buffer, buffer_end - buffer, "add i, v%X", x);
            goto ret;

        case 0x29:
            /* hex vX */
            snprintf(buffer, buffer_end - buffer, "hex v%X", x);
            goto ret;

        case 0x30:
            /* xhex vX */
            snprintf(buffer, buffer_end - buffer, "xhex v%X", x);
            goto ret;

        case 0x33:
            /* bcd vX */
            snprintf(buffer, buffer_end - buffer, "bcd v%X", x);
            goto ret;

        case 0x55:
            /* save vX */
            snprintf(buffer, buffer_end - buffer, "save v%X", x);
            goto ret;

        case 0x65:
            /* restore vX */
            snprintf(buffer, buffer_end - buffer, "restore v%X", x);
            goto ret;

        case 0x75:
            /* flags.save vX */
            snprintf(buffer, buffer_end - buffer, "flags.save v%X", x);
            goto ret;

        case 0x85:
            /* flags.restore vX */
            snprintf(buffer, buffer_end - buffer, "flags.restore v%X", x);
            goto ret;
        }
        break;
    }

    /*
     * illegal instruction
     */
    snprintf(buffer, buffer_end - buffer, "%s", "illegal instruction");
ret:
    trace(("}\n"));
}


void
machine_dump(machine_t *this)
{
    FILE            *fp;
    int             x, y;
    int             x_hi, y_hi;
    double          size;

    fp = fopen("chip8run.dump", "w");
    if (!fp)
        return;
    fprintf(fp, ".PS\n");

    if (this->pixel_mode)
    {
        x_hi = MAX_WIDTH;
        y_hi = MAX_HEIGHT;
        size = 0.025; /* inch */
    }
    else
    {
        x_hi = MAX_WIDTH / 2;
        y_hi = MAX_HEIGHT / 2;
        size = 0.050; /* inch */
    }
    fprintf(fp, "box at (%g,%g) wid %g ht %g thickness %g\n",
        (x_hi / 2 - 0.5) * size, (y_hi / 2 - 0.5) * size,
        x_hi * size, y_hi * size,
        /* (size / 8) inches * 72 points/inch */
        size * 9);
    for (y = 0; y < y_hi; ++y)
    {
        for (x = 0; x < x_hi; ++x)
        {
            if (!this->pixel[y][x])
                continue;
            fprintf(fp, "box at (%g,%g) wid %g ht %g fill 1\n",
                x * size, (y_hi - 1 - y) * size, size, size);
        }
    }
    fprintf(fp, ".PE\n");
    explain_fclose_or_die(fp);
}
