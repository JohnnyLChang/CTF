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

#include <common/ac/ctype.h>
#include <common/ac/stdio.h>
#include <libexplain/fclose.h>
#include <libexplain/fopen.h>
#include <libexplain/putc.h>

#include <common/input.h>
#include <common/sizeof.h>

#include <chip8dis/dis.h>

typedef struct memory_t memory_t;
struct memory_t
{
    unsigned char   value;
    char            processed;
    char            reachable;
    char            is_data;
    short           label;
    int             pic_size;
    int             xpic_size;
};

static memory_t memory[0x1000];
static memory_t *lomem;
static memory_t *himem;


static void
slurp(const char *fn)
{
    input_t         *fp;
    int             c;
    memory_t        *pc;

    lomem = &memory[0x200];
    pc = lomem;
    himem = ENDOF(memory);

    /*
     * read the file in
     */
    fp = input_open(fn);

    /*
     * read in the data
     */
    for (;;)
    {
        c = input_getc(fp);
        if (c < 0)
            break;
        if (pc >= himem)
            input_fatal(fp, "program too large");
        pc->value = c;
        pc++;
    }
    if (pc < lomem + 2)
        input_fatal(fp, "program too small");
    input_close(fp);
    himem = pc;
    lomem->reachable = 1;
}


static void
analyze(void)
{
    memory_t        *pc;
    unsigned char   x, y, n, kk;
    unsigned        nnn;
    unsigned        opcode;

    for (;;)
    {
        /*
         * find an unprocessed reachable opcode
         */
        for (pc = lomem; pc < himem; ++pc)
            if (!pc->processed && pc->reachable)
                break;
        if (pc >= himem)
            break;
        pc[0].processed = 1;

#if 0
        /*
         * Odd addresses can't be code.
         * They also should not be reachable.
         */
        if ((pc - memory) & 1)
        {
            pc[0].is_data = 1;
            continue;
        }
#endif

        /*
         * see if it is a legal opcode
         */
        pc[1].processed = 1;
        opcode = (pc[0].value << 8) + pc[1].value;
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
                continue;

            case 0x00C0: case 0x00C1: case 0x00C2: case 0x00C3:
            case 0x00C4: case 0x00C5: case 0x00C6: case 0x00C7:
            case 0x00C8: case 0x00C9: case 0x00CA: case 0x00CB:
            case 0x00CC: case 0x00CD: case 0x00CE: case 0x00CF:
                /* scdown */
                goto normal;

            case 0x00E0:
                /* clear */
normal:
                pc[2].reachable = 1;
                continue;

            case 0x00EE:
                /* ret */
                continue;

            case 0x00FB:
                /* scright */
                goto normal;

            case 0x00FC:
                /* scleft */
                goto normal;

            case 0x00FD:
                /* exit */
                continue;

            case 0x00FE:
                /* low */
                goto normal;

            case 0x00FF:
                /* high */
                goto normal;
            }
            break;

        case 1:
            /* jump */
            if (nnn < 0x200
#if 0
                || (nnn & 1)
#endif
            )
                break;
            pc = &memory[nnn];
            pc->reachable = 1;
            pc->label = -1;

            pc += 2;
            if (pc >= himem)
                himem = pc;
            continue;

        case 2:
            /* call */
            if (nnn < 0x200
#if 0
                || (nnn & 1)
#endif
            )
                break;
            pc[2].reachable = 1;
            pc = &memory[nnn];
            pc->reachable = 1;
            pc->label = -1;

            pc += 2;
            if (pc >= himem)
                himem = pc;
            continue;

        case 3:
            /* skip.eq vX, KK */
skip:
            pc[2].reachable = 1;
            pc[4].reachable = 1;
            continue;

        case 4:
            /* skip.ne vX, KK */
            goto skip;

        case 5:
            /* skip.eq vX, vY */
            if (x != y)
                goto skip;
            pc[4].reachable = 1;
            continue;

        case 6:
            /* load vX, KK */
            goto normal;

        case 7:
            /* add vX, KK */
            goto normal;

        case 8:
            switch (n)
            {
            case 0:
                /* load vX, vY */
                goto normal;

            case 1:
                /* or vX, vY */
                goto normal;

            case 2:
                /* and vX, vY */
                goto normal;

            case 3:
                /* xor vX, vY */
                goto normal;

            case 4:
                /* add vX, vY */
                goto normal;

            case 5:
                /* sub vX, vY */
                goto normal;

            case 6:
                /* lsr vX */
                goto normal;

            case 7:
                /* dif vX, vY */
                goto normal;

            case 14:
                /* lsl vX */
                goto normal;
            }
            break;

        case 9:
            /* skip.ne vX, vY */
            if (x != y)
                goto skip;
            goto normal;

        case 10:
            /* load i, NNN */
            pc[2].reachable = 1;

            /*
             * Often a bcd or draw opcode follows,
             * telling us the length.
             */
            opcode = (pc[2].value << 8) + pc[3].value;
            pc = &memory[nnn];
            if ((opcode & 0xF0FF) == 0xF033)
                n = 3; /* bcd */
            else if ((opcode & 0xF00F) == 0xD000)
            {
                n = 32; /* xdraw */
                pc->xpic_size = 32;
            }
            else if ((opcode & 0xF000) == 0xD000)
            {
                n = opcode & 15; /* draw */
                pc->pic_size = n;
            }
            else
                n = 1;

            pc->label = -1;
            while (n-- > 0)
            {
                pc->is_data = 1;

                ++pc;
                if (pc > himem)
                    himem = pc;
            }
            continue;

        case 11:
            /* jump nnn, v0 */
#if 0
            if (nnn & 1)
                break;
#endif
            memory[nnn].label = -1;
            continue;

        case 12:
            /* rnd vX, KK */
            goto normal;

        case 13:
            /* draw vX, vY, N */
            goto normal;

        case 14:
            switch (kk)
            {
            case 0x9E:
                /* skip.eq vX, key */
                goto skip;

            case 0xA1:
                /* skip.ne vX, key */
                goto skip;
            }
            break;

        case 15:
            switch (kk)
            {
            case 0x07:
                /* load vX, time */
                goto normal;

            case 0x0A:
                /* load vX, key */
                goto normal;

            case 0x15:
                /* load time, vX */
                goto normal;

            case 0x18:
                /* load tone, vX */
                goto normal;

            case 0x1E:
                /* add i, vX */
                goto normal;

            case 0x29:
                /* hex vX */
                goto normal;

            case 0x30:
                /* xhex vX */
                goto normal;

            case 0x33:
                /* bcd vX */
                goto normal;

            case 0x55:
                /* save vX */
                goto normal;

            case 0x65:
                /* restore vX */
                goto normal;

            case 0x75:
                /* flags.save vX */
                goto normal;

            case 0x85:
                /* flags.restore vX */
                goto normal;
            }
            break;
        }

        /*
         * illegal instruction
         */
        pc[0].is_data = 1;
        pc[1].is_data = 1;
    }

    nnn = 0;
    for (pc = lomem; pc < himem; pc++)
        if (pc->label)
            pc->label = ++nnn;
}


static char *
label_name(int n)
{
    memory_t *pc;
    static char buffer[10];

    pc = &memory[n];
    if (pc->label > 0)
        snprintf(buffer, sizeof(buffer), "L%d", pc->label);
    else
        snprintf(buffer, sizeof(buffer), "M%03X", n);
    return buffer;
}


static void
draw_pic_row(FILE *fp, const char *caption, int n)
{
    int             bit;

    fputs(caption, fp);
    for (bit = 0x80; bit; bit >>= 1)
    {
        int             c;

        c = (n & bit) ? '*' : ' ';
        explain_putc_or_die(c, fp);
    }
}


static void
draw_xpic_row(FILE *fp, const char *caption, memory_t *p)
{
    draw_pic_row(fp, caption, p[0].value);
    draw_pic_row(fp, "", p[1].value);
}


static void
spew(const char *fn)
{
    memory_t        *pc;
    unsigned char   x, y, n, kk;
    unsigned        nnn;
    unsigned        opcode;
    FILE            *fp;

    if (fn)
    {
        fp = explain_fopen_or_die(fn, "w");
    }
    else
    {
        fp = stdout;
        fn = "(stdout)";
    }

    pc = lomem;
    while (pc < himem)
    {
        if (pc->label)
            fprintf(fp, "%s:\n", label_name(pc - memory));
        fprintf(fp, "\t");
        if (!pc->is_data && pc->reachable)
        {
            opcode = (pc[0].value << 8) | pc[1].value;
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
                    fprintf(fp, "exit\t%d", (nnn & 1));
                    break;

                case 0x00C0: case 0x00C1: case 0x00C2:
                case 0x00C3: case 0x00C4: case 0x00C5:
                case 0x00C6: case 0x00C7: case 0x00C8:
                case 0x00C9: case 0x00CA: case 0x00CB:
                case 0x00CC: case 0x00CD: case 0x00CE:
                case 0x00CF:
                    /* scdown */
                    fprintf(fp, "scdown\t%d", n);
                    break;

                case 0x00E0:
                    /* clear */
                    fprintf(fp, "clear");
                    break;

                case 0x00EE:
                    /* ret */
                    fprintf(fp, "ret");
                    break;

                case 0x00FB:
                    /* scright */
                    fprintf(fp, "scright");
                    break;

                case 0x00FC:
                    /* scleft */
                    fprintf(fp, "scleft");
                    break;

                case 0x00FD:
                    /* exit */
                    fprintf(fp, "exit");
                    break;

                case 0x00FE:
                    /* low */
                    fprintf(fp, "low");
                    break;

                case 0x00FF:
                    /* high */
                    fprintf(fp, "high");
                    break;
                }
                break;

            case 1:
                /* jump */
                fprintf(fp, "jump\t%s", label_name(nnn));
                break;

            case 2:
                /* call */
                fprintf(fp, "call\t%s", label_name(nnn));
                break;

            case 3:
                /* skip.eq vX, KK */
                if (kk & 128)
                    kk -= 256;
                fprintf(fp, "skip.eq\tv%X, %d", x, kk);
                break;

            case 4:
                /* skip.ne vX, KK */
                if (kk & 128)
                    kk -= 256;
                fprintf(fp, "skip.ne\tv%X, %d", x, kk);
                break;

            case 5:
                /* skip.eq vX, vY */
                fprintf(fp, "skip.eq\tv%X, v%X", x, y);
                break;

            case 6:
                /* load vX, KK */
                if (kk & 128)
                    kk -= 256;
                fprintf(fp, "load\tv%X, %d", x, kk);
                break;

            case 7:
                /* add vX, KK */
                if (kk & 128)
                    kk -= 256;
                fprintf(fp, "add\tv%X, %d", x, kk);
                break;

            case 8:
                switch (n)
                {
                case 0:
                    /* load vX, vY */
                    fprintf(fp, "load\tv%X, v%X", x, y);
                    break;

                case 1:
                    /* or vX, vY */
                    fprintf(fp, "or\tv%X, v%X", x, y);
                    break;

                case 2:
                    /* and vX, vY */
                    fprintf(fp, "and\tv%X, v%X", x, y);
                    break;

                case 3:
                    /* xor vX, vY */
                    fprintf(fp, "xor\tv%X, v%X", x, y);
                    break;

                case 4:
                    /* add vX, vY */
                    fprintf(fp, "add\tv%X, v%X", x, y);
                    break;

                case 5:
                    /* sub vX, vY */
                    fprintf(fp, "sub\tv%X, v%X", x, y);
                    break;

                case 6:
                    /* lsr vX */
                    fprintf(fp, "lsr\tv%X", x);
                    break;

                case 7:
                    /* dif vX, vY */
                    fprintf(fp, "dif\tv%X, v%X", x, y);
                    break;

                case 14:
                    /* lsl vX */
                    fprintf(fp, "lsl\tv%X", x);
                    break;
                }
                break;

            case 9:
                /* skip.ne vX, vY */
                fprintf(fp, "skip.ne\tv%X, v%X", x, y);
                break;

            case 10:
                /* load i, NNN */
                fprintf(fp, "load\ti, %s", label_name(nnn));
                break;

            case 11:
                /* jump nnn, v0 */
                fprintf(fp, "jump\t%s, v0", label_name(nnn));
                break;

            case 12:
                /* rnd vX, KK */
                fprintf(fp, "rnd\tv%X, %d", x, kk);
                break;

            case 13:
                /* draw vX, vY, N */
                if (n)
                    fprintf(fp, "draw\tv%X, v%X, %d", x, y, n);
                else
                    fprintf(fp, "xdraw\tv%X, v%X", x, y);
                break;


            case 14:
                switch (kk)
                {
                case 0x9E:
                    /* skip.eq vX, key */
                    fprintf(fp, "skip.eq\tv%X, key", x);
                    break;

                case 0xA1:
                    /* skip.ne vX, key */
                    fprintf(fp, "skip.ne\tv%X, key", x);
                    break;
                }
                break;

            case 15:
                switch (opcode & 255)
                {
                case 0x07:
                    /* load vX, time */
                    fprintf(fp, "load\tv%X, time", x);
                    break;

                case 0x0A:
                    /* load vX, key */
                    fprintf(fp, "load\tv%X, key", x);
                    break;

                case 0x15:
                    /* load time, vX */
                    fprintf(fp, "load\ttime, v%X", x);
                    break;

                case 0x18:
                    /* load tone, vX */
                    fprintf(fp, "load\ttone, v%X", x);
                    break;

                case 0x1E:
                    /* add i, vX */
                    fprintf(fp, "add\ti, v%X", x);
                    break;

                case 0x29:
                    /* hex vX */
                    fprintf(fp, "hex\tv%X", x);
                    break;

                case 0x30:
                    /* xhex vX */
                    fprintf(fp, "xhex\tv%X", x);
                    break;

                case 0x33:
                    /* bcd vX */
                    fprintf(fp, "bcd\tv%X", x);
                    break;

                case 0x55:
                    /* save vX */
                    fprintf(fp, "save\tv%X", x);
                    break;

                case 0x65:
                    /* restore vX */
                    fprintf(fp, "restore\tv%X", x);
                    break;

                case 0x75:
                    /* flags.save vX */
                    fprintf(fp, "flags.save\tv%X", x);
                    break;

                case 0x85:
                    /* flags.restore vX */
                    fprintf(fp, "flags.restore\tv%X", x);
                    break;
                }
                break;
            }
            fprintf(fp, "\n");
            if (pc[1].label)
            {
                /* either self-modifying code or a boo-boo */
                fprintf(fp, "%s\t.equ\t. - 1\n",
                    label_name(pc + 1 - memory));
            }
            pc += 2;
        }
        else if (!pc->is_data && !pc->reachable && isprint(pc->value))
        {
            int     j;

            fprintf(fp, ".ascii\t\"");
            if (pc->value == '"')
                explain_putc_or_die('"', fp);
            explain_putc_or_die(pc->value, fp);
            for (j = 1; pc + j < himem; ++j)
            {
                memory_t *p = pc + j;
                if (p->reachable || p->is_data || p->label)
                    break;
                if (!isprint(p->value))
                    break;
                if (p->value == '"')
                    explain_putc_or_die('"', fp);
                explain_putc_or_die(p->value, fp);
            }
            fprintf(fp, "\"\n");
            pc += j;
        }
        else if (pc->is_data && !pc->reachable && pc->xpic_size)
        {
            int     j;

            draw_xpic_row(fp, ".xpic\t\"", pc);
            for (j = 2; pc + j < himem && !pc[j].label; j += 2)
            {
                memory_t *p = pc + j;
                if (p->reachable || p->label)
                    break;
                draw_xpic_row(fp, "\",\n\t\t\"", p);
            }
            fprintf(fp, "\"\n");
            pc += j;
        }
        else if (pc->is_data && !pc->reachable && pc->pic_size)
        {
            int     j;

            draw_pic_row(fp, ".pic\t\"", pc->value);
            for (j = 1; pc + j < himem && !pc[j].label; ++j)
            {
                memory_t *p = pc + j;
                if (p->reachable || p->label)
                    break;
                draw_pic_row(fp, "\",\n\t\t\"", p->value);
            }
            fprintf(fp, "\"\n");
            pc += j;
        }
        else
        {
            int     j;

            for (j = 0; pc + j < himem; ++j)
            {
                memory_t *p = pc + j;
                if (!p->reachable && !p->is_data)
                    p->is_data = 1;
                if (!p->is_data || p->value != 0)
                    break;
                if (j && p->label)
                    break;
            }
            if (j <= 1)
            {
                fprintf(fp, ".byte\t0x%02X\n", pc->value);
                ++pc;
            }
            else
            {
                fprintf(fp, ".ds\t0x%X\n", j);
                pc += j;
            }
        }
    }
    explain_fclose_or_die(fp);
}


void
disassemble(const char *infile, const char *outfile)
{
    slurp(infile);
    analyze();
    spew(outfile);
}
