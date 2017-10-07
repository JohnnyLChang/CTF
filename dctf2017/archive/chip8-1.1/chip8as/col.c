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
#include <common/ac/ctype.h>
#include <common/ac/stdarg.h>
#include <common/ac/stddef.h>
#include <common/ac/stdio.h>
#include <common/ac/string.h>
#include <common/ac/time.h>
#include <libexplain/fclose.h>
#include <libexplain/ferror.h>
#include <libexplain/fflush.h>
#include <libexplain/fopen.h>
#include <libexplain/malloc.h>
#include <libexplain/putc.h>
#include <libexplain/strdup.h>

#include <common/trace.h>

#include <chip8as/col.h>


#define PRINTER_THRESHOLD 33


typedef struct col_ty col_ty;
struct col_ty
{
    int     icol;
    int     ocol;
    size_t  text_length_max;
    size_t  text_length;
    char    *text;
    char    *current;
    int     min;
    int     max;
    char    *heading;
    int     heading_required;
    char    *top_of_page_diverted;
};

static size_t   ncols;
static size_t   ncols_max;
static col_ty   **col;
static char     *filename;
static FILE     *fp;
static long     page_number;
static long     page_line;
static int      top_of_page;
static int      page_width;
static int      page_length;
static int      is_a_printer;
static char     *title1;
static char     *title2;
static time_t   page_time;
static int      tab_width;


/*
 * NAME
 *      col_open
 *
 * SYNOPSIS
 *      void col_open(char *pathname);
 *
 * DESCRIPTION
 *      The col_open function is used to
 *      open a file for outputting columnar data.
 *
 * ARGUMENTS
 *      pathname        - name of file to write,
 *                      pager is used if NULL pointer given.
 *
 * CAVEAT
 *      All other calls to col_ functions must be bracketed
 *      by col_open and col_close calls.
 */

void
col_open(const char *s)
{
    trace(("col_open(s = %08lX)\n{\n"/*}*/, s));
    trace_string((char *)s);
    assert(!filename);
    assert(!fp);
    assert(!ncols);
    if (s)
    {
        filename = explain_strdup_or_die(s);
        fp = explain_fopen_or_die(filename, "w");
    }
    else
    {
        fp = stdout;
        filename = explain_strdup_or_die("standard output");
    }
    page_number = 0;
    page_line = 0;
    top_of_page = 1;
    /* don't use the last column, many terminals are dumb */
    page_width = 79;
    page_length = 66;
    is_a_printer = (page_length > PRINTER_THRESHOLD);
    if (is_a_printer)
    {
        /* bottom margin, avoid the perforation */
        page_length -= 3;
    }
    else
    {
        /* leave the last line for the pager */
        page_length--;
    }
    time(&page_time);
    tab_width = 8;
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_close
 *
 * SYNOPSIS
 *      void col_close(void);
 *
 * DESCRIPTION
 *      The col_close function is used to
 *      terminate columnar output.
 *
 *      All dynamic memory consumed will be released.
 *
 * CAVEAT
 *      All other calls to col_ functions must be bracketed
 *      by col_open and col_close calls.
 */

void
col_close(void)
{
    size_t          j;
    col_ty          *cp;

    /*
     * free the memory consumed by the columns
     */
    trace(("col_close()\n{\n"/*}*/));
    if (ncols)
    {
        for (j = 0; j < ncols; ++j)
        {
            cp = col[j];

            if (cp->text_length_max)
                free(cp->text);
            if (cp->heading)
                free(cp->heading);
        }
        free(col);
        ncols = 0;
        col = 0;
    }
    if (title1)
    {
        free(title1);
        title1 = 0;
    }
    if (title2)
    {
        free(title2);
        title2 = 0;
    }

    /*
     * write the last of the output
     */
    explain_fflush_or_die(fp);

    /*
     * close the output
     */
    if (fp != stdout)
    {
        explain_fclose_or_die(fp);
        free(filename);
    }
    fp = 0;
    filename = 0;
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_create
 *
 * SYNOPSIS
 *      void col_create(void);
 *
 * DESCRIPTION
 *      The col_create function is used to
 *      specify a range of locations for an output column.
 *
 * ARGUMENTS
 *      min     - the left-hand edge of the column
 *      max     - the right-hand edge of the column, plus one
 *                zero means the rest of the line
 *
 * RETURNS
 *      int; a small non-negative integer, as a unique column identifier
 */

int
col_create(int min, int max)
{
    col_ty  *cp;

    trace(("col_create(min = %d, max = %d)\n{\n"/*}*/, min, max));
    if (!max)
    {
        max = page_width;
        if (max <= min)
            max = min + 8;
    }

    /*
     * try to get sensable behaviour out of narrow windows
     */
    if (max > page_width)
        page_width = max;

    assert(min < max);
    cp = (col_ty *)explain_malloc_or_die(sizeof(col_ty));
    if (ncols >= ncols_max)
    {
        size_t          new_ncols_max;
        size_t          nbytes;
        col_ty          **new_col;
        size_t          j;

        new_ncols_max = ncols_max ? ncols_max * 2 : 4;
        nbytes = new_ncols_max * sizeof(col_ty *);
        new_col = explain_malloc_or_die(nbytes);
        for (j = 0; j < ncols; ++j)
            new_col[j] = col[j];
        for (; j < new_ncols_max; ++j)
            new_col[j] = 0;
        if (col)
            free(col);
        col = new_col;
        ncols_max = new_ncols_max;
    }
    col[ncols++] = cp;

    cp->min = min;
    cp->max = max;
    cp->text_length_max = 0;
    cp->text_length = 0;
    cp->text = 0;
    cp->icol = 0;
    cp->ocol = 0;
    cp->heading = 0;
    cp->heading_required = 0;
    cp->top_of_page_diverted = 0;
    trace(("return %d;\n", ncols - 1));
    trace((/*{*/"}\n"));
    return (ncols - 1);
}


/*
 * NAME
 *      col_save_char
 *
 * SYNOPSIS
 *      void col_save_char(col_ty *cp, int c);
 *
 * DESCRIPTION
 *      The col_save_char function is used to
 *      append a character to the output buffered for a specified column.
 *
 * ARGUMENTS
 *      cp      - pointer to the column
 *      c       - the character to append
 */

static void
col_save_char(col_ty *cp, int c)
{
    if (cp->text_length >= cp->text_length_max)
    {
        size_t          new_text_length_max;
        char            *new_text;

        new_text_length_max = cp->text_length_max * 2 + 16;
        /*
         * always alloc one too large
         * so col_eoln can put NUL on the end.
         */
        new_text = explain_malloc_or_die(new_text_length_max + 1);
        memcpy(new_text, cp->text, cp->text_length);
        if (cp->text)
            free(cp->text);
        cp->text = new_text;
        cp->text_length_max = new_text_length_max;
    }
    cp->text[cp->text_length++] = c;
}


/*
 * NAME
 *      col_putchar
 *
 * SYNOPSIS
 *      void col_putchar(col_ty *cp, int c);
 *
 * DESCRIPTION
 *      The col_putchar function is used to
 *      append a character to the buffer stored for a specified column.
 *
 *      This function filters tab characters in order to expand them,
 *      and preserve the visual nature of 8-character spaces within a column,
 *      irrespective of the actual screen location of the column when output.
 *
 * ARGUMENTS
 *      cp      - pointer to the column
 *      c       - the character to append
 */

static void
col_putchar(col_ty *cp, int c)
{
    c = (unsigned char)c;
    switch (c)
    {
    case ' ':
        col_save_char(cp, c);
        cp->icol++;
        break;

    case '\t':
        /*
         * Internally, treat tabs as 8 characters wide.
         */
        for (;;)
        {
            col_save_char(cp, ' ');
            cp->icol++;
            if (!(cp->icol & 7))
                break;
        }
        break;

    case '\n':
        col_save_char(cp, c);
        cp->icol = 0;
        break;

    default:
        if (isprint(c))
        {
            col_save_char(cp, c);
            cp->icol++;
        }
        else
        {
            col_save_char(cp, '\\');
            col_save_char(cp, '0' + ((c >> 6) & 3));
            col_save_char(cp, '0' + ((c >> 3) & 7));
            col_save_char(cp, '0' + (c & 7));
            cp->icol += 4;
        }
        break;
    }
}


/*
 * NAME
 *      col_puts
 *
 * SYNOPSIS
 *      void col_puts(int cid, char *s);
 *
 * DESCRIPTION
 *      The col_puts function is used to append strings
 *      to columns for later output.
 *
 * ARGUMENTS
 *      cid     - column identifier
 *      s       - string to be appended
 *
 * CAVEAT
 *      This is the external user interface for placing characters in a column.
 */

void
col_puts(int cid, const char *s)
{
    col_ty          *cp;

    trace(("col_puts(cid = %d, s = %08lX)\n{\n"/*}*/, cid, s));
    assert(cid >= 0);
    assert((size_t)cid < ncols);
    cp = col[cid];
    while (*s)
        col_putchar(cp, *s++);
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_printf
 *
 * SYNOPSIS
 *      void col_printf(int cid, char *format, ...);
 *
 * DESCRIPTION
 *      The col_printf function is used to
 *      format strings for appending to columns for later output.
 *
 *      The format is that used by printf et al.
 *
 * ARGUMENTS
 *      cid     - column identifier
 *      format  - format string, a la printf
 *      ...     - additional arguments as required by the format
 *
 * CAVEAT
 *      This is the external user interface for placing characters in a column.
 */

void
col_printf(int cid, const char *s, ...)
{
    va_list         ap;
    char            buffer[1 << 12];

    trace(("col_printf(cid = %d, s = %08lX, ...)\n{\n"/*}*/, cid, s));
    va_start(ap, s);
    trace_string((char *)s);
    vsnprintf(buffer, sizeof(buffer), s, ap);
    va_end(ap);
    col_puts(cid, buffer);
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      top_of_page_mark
 *
 * SYNOPSIS
 *      void top_of_page_mark(void);
 *
 * DESCRIPTION
 *      The top_of_page_mark function is used to
 *      mark that the top of page has occurred,
 *      and that top-of-page processing should be performed
 *      when next there is output.
 */

static void
top_of_page_mark(void)
{
    size_t          j;
    col_ty          *cp;

    top_of_page = 1;
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        if (cp->heading)
            cp->heading_required = 1;
    }
}


#define INDENT 8

static int      in_col;
static int      out_col;

static void top_of_page_processing(void); /* forward */


/*
 * NAME
 *      col_emit_char
 *
 * SYNOPSIS
 *      void col_emit_char(int c);
 *
 * DESCRIPTION
 *      The col_emit_char function is used to
 *      emit on character to the output file or pager.
 *
 *      White space optimization is performed, raplacing
 *      sequences of blanks with horizontal tabs whenever possible.
 *
 *      This function is also responsible for tracking when end-of-page
 *      is reached and notifying that top-of-page processing is required.
 *
 * ARGUMENTS
 *      c       - character to emit
 */

static void
col_emit_char(int c)
{
    assert(fp);
    if (top_of_page)
        top_of_page_processing();
    switch (c)
    {
    case '\n':
        explain_putc_or_die('\n', fp);
#ifdef DEBUG
        explain_fflush_or_die(fp);
#endif
        in_col = 0;
        out_col = 0;
        page_line++;
        if (page_line >= page_length)
            top_of_page_mark();
        break;

    case ' ':
        ++in_col;
        break;

    case '\t':
        /*
         * Internally, treat tabs as 8 characters wide.
         * (This case should never be exersized.)
         */
        in_col = (in_col + 8) & ~7;
        break;

    default:
        if (tab_width)
        {
            while
            (
                out_col + 1 < in_col
            &&
                ((out_col / tab_width + 1) * tab_width) <= in_col
            )
            {
                explain_putc_or_die('\t', fp);
                out_col = (out_col / tab_width + 1) * tab_width;
            }
        }
        while (out_col < in_col)
        {
            explain_putc_or_die(' ', fp);
            ++out_col;
        }
        explain_putc_or_die(c, fp);
        in_col++;
        out_col++;
        break;
    }
    explain_ferror_or_die(fp);
}


/*
 * NAME
 *      col_emit_str
 *
 * SYNOPSIS
 *      void col_emit_str(char *s);
 *
 * DESCRIPTION
 *      The col_emit_str function is used to
 *      send a string through the col_emit_char function,
 *      one character at a time.
 *
 * ARGUMENTS
 *      s       - pointer to NUL terminated string
 *                to be sent.
 */

static void
col_emit_str(char *s)
{
    while (*s)
        col_emit_char(*s++);
}


/*
 * NAME
 *      col_eoln_sub
 *
 * SYNOPSIS
 *      void col_eoln_sub(void);
 *
 * DESCRIPTION
 *      The col_eoln_sub function is used to
 *      send the buffered contents of the columns to the
 *      output file or pager.
 *
 *      Columns are wrapped as needed, and thus may emit
 *      more than one line out output.
 *
 *      This function is also usd to emit the column headers.
 */

static void
col_eoln_sub(void)
{
    int             more;
    size_t          j;
    col_ty          *cp;

    trace(("col_eoln_sub()\n{\n"/*}*/));
    for (;;)
    {
        more = 0;
        for (j = 0; j < ncols; ++j)
        {
            int     width;
            char    *s;

            cp = col[j];
            if (!cp->current)
                continue;
            if (in_col > cp->min)
            {
                more = 1;
                break;
            }
            while (in_col < cp->min)
                col_emit_char(' ');
            width = cp->max - cp->min;
            for
            (
                s = cp->current;
                s < cp->current + width && *s && *s != '\n';
                ++s
            )
                ;
            if (!*s)
            {
                while (cp->current < s)
                    col_emit_char(*cp->current++);
                cp->current = 0;
                continue;
            }
            if (*s == '\n')
            {
                while (cp->current < s)
                    col_emit_char(*cp->current++);
                cp->current++;
                for
                (
                    s = cp->current;
                    isspace((unsigned char)*s);
                    ++s
                )
                    ;
                if (*s)
                    more = 1;
                else
                    cp->current = 0;
                continue;
            }

            /*
             * the line must be wrapped
             */
            if (*s && !isspace((unsigned char)*s))
            {
                while
                (
                    s > cp->current
                &&
                    !strchr("-_ /", s[-1])
                )
                    --s;
                if (s == cp->current)
                {
                    /*
                     * no nice place to break it
                     */
                    while (width > 0)
                    {
                        col_emit_char(*cp->current++);
                        --width;
                    }
                    more = 1;
                    continue;
                }
            }

            while (cp->current < s)
                col_emit_char(*cp->current++);
            while (isspace((unsigned char)*cp->current))
                cp->current++;
            if (*cp->current)
                more = 1;
            else
                cp->current = 0;
        }
        col_emit_char('\n');
        if (!more)
            break;
    }
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      top_of_page_processing
 *
 * SYNOPSIS
 *      void top_of_page_processing(void);
 *
 * DESCRIPTION
 *      The top_of_page_processing function is used to
 *      emit the various titles and headings required at the top of a page.
 *
 * ARGUMENTS
 *
 * RETURNS
 */

static void
top_of_page_processing(void)
{
    int     heading_required;
    size_t  j;
    col_ty  *cp;

    /*
     * setup
     */
    top_of_page = 0;
    page_number++;
    page_line = 0;

    /*
     * seek to next page
     * and emit top margin
     */
    if (is_a_printer)
    {
        if (page_number > 1)
            col_emit_char('\f');
        col_emit_char('\n');
        col_emit_char('\n');
    }
    col_emit_char('\n');

    /*
     * first line of titles
     */
    {
        char            tmp1[50];
        size_t          tmp2len;
        char            *tmp2;
        int             frac;
        char            *check;

        snprintf(tmp1, sizeof(tmp1), "Page %ld", page_number);
        tmp2len = page_width + 1;
        tmp2 = explain_malloc_or_die(tmp2len);
        frac = page_width - 2 - strlen(tmp1);
        if (!title1)
            title1 = explain_strdup_or_die("");
        snprintf(tmp2, tmp2len, "%-*.*s  %s", frac, frac, title1, tmp1);
        for (check = tmp2; *check; ++check)
            if (!isprint((unsigned char)*check))
                *check = ' ';
        col_emit_str(tmp2);
        col_emit_char('\n');
        free(tmp2);
    }

    /*
     * second line of titles
     */
    {
        char            tmp1[50];
        int             frac;
        size_t          tmp2len;
        char            *tmp2;
        char            *check;

        snprintf(tmp1, sizeof(tmp1), "%.24s", ctime(&page_time));
        frac = page_width - 2 - strlen(tmp1);
        if (!title2)
            title2 = explain_strdup_or_die("");
        tmp2len = page_width + 1;
        tmp2 = explain_malloc_or_die(tmp2len);
        snprintf(tmp2, tmp2len, "%-*.*s  %s", frac, frac, title2, tmp1);
        for (check = tmp2; *check; ++check)
            if (!isprint((unsigned char)*check))
                *check = ' ';
        col_emit_str(tmp2);
        col_emit_char('\n');
        free(tmp2);
    }

    /*
     * blank line between titles and columns
     */
    col_emit_char('\n');

    /*
     * in weird cases where the terminal is too narrow,
     * the headings can try to span pages.
     * If we are already top-of-page diverted, don't do it again.
     */
    heading_required = 0;
    for (j = 0; j < ncols; ++j)
    {
        if (col[j]->top_of_page_diverted)
            heading_required--;
    }
    if (heading_required < 0)
    {
        for (j = 0; j < ncols; ++j)
            col[j]->heading_required = 0;
        return;
    }

    /*
     * divert for headings
     */
    heading_required = 0;
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        assert(!cp->top_of_page_diverted);
        cp->top_of_page_diverted = cp->current;
        if (cp->heading && cp->heading_required)
        {
            heading_required++;
            cp->current = cp->heading;
        }
        else
            cp->current = 0;
        cp->heading_required = 0;
    }

    /*
     * do the headings as necessary
     */
    if (heading_required)
        col_eoln_sub();

    /*
     * undivert from headings
     */
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        cp->current = cp->top_of_page_diverted;
        cp->heading_required = 0;
        cp->top_of_page_diverted = 0;
    }
}


/*
 * NAME
 *      col_eoln
 *
 * SYNOPSIS
 *      void col_eoln(void);
 *
 * DESCRIPTION
 *      The col_eoln function is used to
 *      signal that an entire line of columns has been assembled
 *      and that it should be emitted to the output file or pager.
 *
 *      This is the interface used by clients of this subsystem.
 */

void
col_eoln(void)
{
    size_t  j;
    col_ty  *cp;
    int     heading_required;

    /*
     * terminate text fields
     */
    trace(("col_eoln()\n{\n"/*}*/));
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        if (cp->text_length && cp->text)
            cp->text[cp->text_length] = 0;
    }

    /*
     * do headings if required
     *
     * Top of page is not enough,
     * there could be mid-page changes of heading.
     */
    heading_required = 0;
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        if (cp->heading && cp->heading_required)
        {
            heading_required++;
            cp->current = cp->heading;
        }
        else
            cp->current = 0;
        cp->heading_required = 0;
    }
    if (heading_required)
        col_eoln_sub();

    /*
     * do the text body
     */
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        if (cp->text_length)
            cp->current = cp->text;
        else
            cp->current = 0;
    }
    col_eoln_sub();

    /*
     * clean up for next time
     */
    for (j = 0; j < ncols; ++j)
    {
        cp = col[j];
        cp->text_length = 0;
        cp->icol = 0;
        cp->ocol = 0;
    }
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_bol
 *
 * SYNOPSIS
 *      void col_bol(int cid);
 *
 * DESCRIPTION
 *      The col_bol function is used to
 *      ensure that the buffer accumulating a specified column
 *      is at the beginning of a line.
 *
 * ARGUMENTS
 *      cid     - column identifier
 */

void
col_bol(int cid)
{
    col_ty  *cp;

    trace(("col_bol(cid = %d)\n{\n"/*}*/, cid));
    assert(cid >= 0);
    assert((size_t)cid < ncols);
    cp = col[cid];
    if (cp->icol)
        col_putchar(cp, '\n');
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_heading
 *
 * SYNOPSIS
 *      void col_heading(int cid, char *s);
 *
 * DESCRIPTION
 *      The col_heading function is used to
 *      set the heading of a specified column
 *
 * ARGUMENTS
 *      cid     - column identifier
 *      s       - heading to be set
 */

void
col_heading(int cid, const char *s)
{
    col_ty          *cp;

    trace(("col_heading(cid = %d, s = %08lX)\n{\n"/*}*/, cid, s));
    assert(cid >= 0);
    assert((size_t)cid < ncols);
    cp = col[cid];
    if (cp->heading)
        free(cp->heading);
    if (s && *s)
    {
        /*
         * tthe heading_required flag is used
         * when a heading is created in the middle of a page,
         * and should be output at that time.
         */
        cp->heading = explain_strdup_or_die(s);
        cp->heading_required = 1;
    }
    else
    {
        cp->heading = 0;
        cp->heading_required = 0;
    }
    trace((/*{*/"}\n"));
}


void
col_cancel_columns(void)
{
    while (ncols > 0)
    {
        col_ty          *cp;

        cp = col[--ncols];
        if (cp->heading)
            free(cp->heading);
        cp->heading = 0;
        cp->heading_required = 0;
        if (cp->text)
            free(cp->text);
        cp->text = 0;
        cp->text_length = 0;
        cp->text_length_max = 0;
    }
}


/*
 * NAME
 *      col_title
 *
 * SYNOPSIS
 *      void col_title(char *s1, char *s2);
 *
 * DESCRIPTION
 *      The col_title function is used to
 *      set the two lines of page headings.
 *
 * ARGUMENTS
 *      s1      - first line of heading, NULL means blank
 *      s2      - second line of heading, NULL means blank
 */

void
col_title(const char *s1, const char *s2)
{
    trace(("col_title(s1 = %08lX, s2 = %08lX)\n{\n"/*}*/, s1, s2));
    if (s1)
    {
        trace_string((char *)s1);
        if (title1)
            free(title1);
        if (*s1)
            title1 = explain_strdup_or_die(s1);
        else
            title1 = 0;
    }

    if (s2)
    {
        trace_string((char *)s2);
        if (title2)
            free(title2);
        if (*s2)
            title2 = explain_strdup_or_die(s2);
        else
            title2 = 0;
    }
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_eject
 *
 * SYNOPSIS
 *      void col_eject(void);
 *
 * DESCRIPTION
 *      The col_eject function is used to move to the top of the next page,
 *      if we aren't there already.
 */

void
col_eject(void)
{
    trace(("col_eject()\n{\n"/*}*/));
    if (!top_of_page)
    {
        if (is_a_printer)
            top_of_page_mark();
        else
        {
            for (;;)
            {
                col_emit_char('\n');
                if (top_of_page)
                    break;
            }
        }
    }
    trace((/*{*/"}\n"));
}


/*
 * NAME
 *      col_need
 *
 * SYNOPSIS
 *      void col_need(int n);
 *
 * DESCRIPTION
 *      The col_need function is used to numinate that
 *      a number of lines is needed before the end of the page.
 *      If the lines are available, a blank line is emitted,
 *      otherwise a new page is thrown.
 *
 * ARGUMENTS
 *      n       - the number of lines,
 *                not counting the blank line.
 */

void
col_need(int n)
{
    trace(("col_need(n = %d)\n{\n"/*}*/, n));
    assert(n < page_length);
    if (page_line + n >= page_length)
        col_eject();
    else
        if (!top_of_page)
            col_eoln();
    trace((/*{*/"}\n"));
}
