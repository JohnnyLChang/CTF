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
 *
 *
 * string manipulation functions
 *
 * A literal pool is maintained.  Each string has a reference count.  The
 * string stays in the literal pool for as long as it hash a positive
 * reference count.  To determine if a string is already in the literal pool,
 * linear dynamic hashing is used to guarantee an O(1) search.  Making all equal
 * strings the same item in the literal pool means that string equality is
 * a pointer test, and thus very fast.
 */

#include <common/ac/assert.h>
#include <common/ac/stdarg.h>
#include <common/ac/stddef.h>
#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <common/ac/ctype.h>
#include <libexplain/malloc.h>
#include <libexplain/output.h>

#include <common/str.h>


#define TRACING_MODULE TRACING_MODULE_STRINGS

string_t        *str_true;
string_t        *str_false;
string_t        *str_slash;

static string_t **hash_table;
static hash_t   hash_modulus;
static hash_t   hash_mask;
static hash_t   hash_load;
static int      changed;

#define MAX_HASH_LEN 20


/*
 *  NAME
 *      hash_generate - hash string to number
 *
 *  SYNOPSIS
 *      hash_t hash_generate(char *s, size_t n);
 *
 *  DESCRIPTION
 *      The hash_generate function is used to make a number from a string.
 *
 *  RETURNS
 *      hash_t - the magic number
 *
 *  CAVEAT
 *      Only the last MAX_HASH_LEN characters are used.
 *      It is important that hash_t be unsigned (int or long).
 */

static hash_t
hash_generate(const char *s, size_t n)
{
    hash_t retval;

    if (n > MAX_HASH_LEN)
    {
        s += n - MAX_HASH_LEN;
        n = MAX_HASH_LEN;
    }

    retval = 0;
    while (n > 0)
    {
        retval = (retval + (retval << 1)) ^ *s++;
        --n;
    }
    return retval;
}


/*
 *  NAME
 *      str_initialize - start up string table
 *
 *  SYNOPSIS
 *      void str_initialize(void);
 *
 *  DESCRIPTION
 *      The str_initialize function is used to create the hash table and
 *      initialize it to empty.
 *
 *  RETURNS
 *      void
 *
 *  CAVEAT
 *      This function must be called before any other defined in this file.
 */

void
str_initialize(void)
{
    hash_t          j;

    hash_modulus = 1 << 8; /* MUST be a power of 2 */
    hash_mask = hash_modulus - 1;
    hash_load = 0;
    hash_table =
        (string_t **)explain_malloc_or_die(hash_modulus * sizeof(string_t *));
    for (j = 0; j < hash_modulus; ++j)
        hash_table[j] = 0;

    str_true = str_from_c("1");
    str_false = str_from_c("");
    str_slash = str_from_c("/");
}


/*
 *  NAME
 *      split - reduce table loading
 *
 *  SYNOPSIS
 *      void split(void);
 *
 *  DESCRIPTION
 *      The split function is used to reduce the load factor on the hash table.
 *
 *  RETURNS
 *      void
 *
 *  CAVEAT
 *      A load factor of about 80% is suggested.
 */

static void
split(void)
{
    string_t        **new_hash_table;
    hash_t          new_hash_modulus;
    hash_t          new_hash_mask;
    hash_t          j;

    /*
     * double the modulus
     *
     * This is subtle.  If we only increase the modulus by one, the
     * load always hovers around 80%, so we have to do a split for
     * every insert.  I.e. the malloc burden is O(n) for the lifetime of
     * the program.  BUT if we double the modulus, the length of time
     * until the next split also doubles, making the probablity of a
     * split halve, and sigma(2**-n)=1, so the malloc burden becomes O(1)
     * for the lifetime of the program.
     */
    new_hash_modulus = hash_modulus << 1;
    new_hash_mask = new_hash_modulus - 1;
    new_hash_table =
        explain_malloc_or_die(new_hash_modulus * sizeof(string_t *));

    /*
     * now redistribute the list elements
     */
    for (j = 0; j < hash_modulus; ++j)
    {
        string_t        *p;

        p = hash_table[j];
        new_hash_table[j] = 0;
        new_hash_table[hash_modulus + j] = 0;
        while (p)
        {
            string_t        *p2;
            hash_t          idx;

            p2 = p;
            p = p->str_next;

            idx = p2->str_hash & new_hash_mask;
            p2->str_next = new_hash_table[idx];
            new_hash_table[idx] = p2;
        }
    }

    /*
     * swap it over
     */
    free(hash_table);
    hash_table = new_hash_table;
    hash_modulus = new_hash_modulus;
    hash_mask = new_hash_mask;
}


/*
 *  NAME
 *      str_from_c - make string from C string
 *
 *  SYNOPSIS
 *      string_t *str_from_c(char*);
 *
 *  DESCRIPTION
 *      The str_from_c function is used to make a string from a null terminated
 *      C string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_from_c(const char *s)
{
    return str_n_from_c(s, strlen(s));
}


/*
 *  NAME
 *      str_n_from_c - make string
 *
 *  SYNOPSIS
 *      string_t *str_n_from_c(char *s, size_t n);
 *
 *  DESCRIPTION
 *      The str_n_from_c function is used to make a string from an array of
 *      characters.  No null terminator is assumed.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_n_from_c(const char *s, size_t length)
{
    hash_t          hash;
    hash_t          index;
    string_t        *p;

    hash = hash_generate(s, length);

    index = hash & hash_mask;
    assert(index < hash_modulus);

    for (p = hash_table[index]; p; p = p->str_next)
    {
        if
        (
            p->str_hash == hash
        &&
            p->str_length == length
        &&
            0 == memcmp(p->str_text, s, length)
        )
        {
            p->str_references++;
            return p;
        }
    }

    p = (string_t *)explain_malloc_or_die(sizeof(string_t) + length);
    p->str_hash = hash;
    p->str_length = length;
    p->str_references = 1;
    p->str_next = hash_table[index];
    hash_table[index] = p;
    memcpy(p->str_text, s, length);
    p->str_text[length] = 0;

    ++hash_load;
    if (hash_load * 10 > hash_modulus * 8)
        split();
    ++changed;
    return p;
}


/*
 *  NAME
 *      str_copy - make a copy of a string
 *
 *  SYNOPSIS
 *      string_t *str_copy(string_t *s);
 *
 *  DESCRIPTION
 *      The str_copy function is used to make a copy of a string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_copy(string_t *s)
{
    s->str_references++;
    return s;
}


/*
 *  NAME
 *      str_free - release a string
 *
 *  SYNOPSIS
 *      void str_free(string_t *s);
 *
 *  DESCRIPTION
 *      The str_free function is used to indicate that a string hash been
 *      finished with.
 *
 *  RETURNS
 *      void
 *
 *  CAVEAT
 *      This is the only way to release strings DO NOT use the free function.
 */

void
str_free(string_t *s)
{
    hash_t          index;
    string_t        **spp;

    if (!s)
        return;
    if (s->str_references > 1)
    {
        s->str_references--;
        return;
    }
    assert(s->str_references == 1);
    ++changed;

    /*
     *  find the hash bucket it was in,
     *  and remove it
     */
    index = s->str_hash & hash_mask;
    assert(index < hash_modulus);
    for (spp = &hash_table[index]; *spp; spp = &(*spp)->str_next)
    {
        if (*spp == s)
        {
            *spp = s->str_next;
            free(s);
            --hash_load;
            return;
        }
    }
    /* should never reach here! */
    explain_output_error_and_die("attempted to free non-existent string (bug)");
}


/*
 *  NAME
 *      str_catenate - join two strings
 *
 *  SYNOPSIS
 *      string_t *str_catenate(string_t *, string_t *);
 *
 *  DESCRIPTION
 *      The str_catenate function is used to concatenate two strings to form a
 *      new string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_catenate(string_t *s1, string_t *s2)
{
    static char     *tmp;
    static size_t   tmplen;
    string_t        *s;
    size_t          length;

    length = s1->str_length + s2->str_length;
    if (tmp && length > tmplen)
    {
        free(tmp);
        tmp = 0;
        tmplen = 0;
    }
    if (!tmp)
    {
        tmplen = length;
        if (tmplen < 16)
            tmplen = 16;
        tmp = explain_malloc_or_die(tmplen);
    }
    memcpy(tmp, s1->str_text, s1->str_length);
    memcpy(tmp + s1->str_length, s2->str_text, s2->str_length);
    s = str_n_from_c(tmp, length);
    return s;
}


/*
 *  NAME
 *      str_cat_three - join three strings
 *
 *  SYNOPSIS
 *      string_t *str_cat_three(string_t *, string_t *, string_t *);
 *
 *  DESCRIPTION
 *      The str_cat_three function is used to concatenate three strings to form
 *      a new string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_cat_three(string_t *s1, string_t *s2, string_t *s3)
{
    static char     *tmp;
    static size_t   tmplen;
    string_t        *s;
    size_t          length;

    length = s1->str_length + s2->str_length + s3->str_length;
    if (tmp && length > tmplen)
    {
        free(tmp);
        tmp = 0;
        tmplen = 0;
    }
    if (!tmp)
    {
        tmplen = length;
        if (tmplen < 16)
            tmplen = 16;
        tmp = explain_malloc_or_die(tmplen);
    }
    memcpy(tmp, s1->str_text, s1->str_length);
    memcpy(tmp + s1->str_length, s2->str_text, s2->str_length);
    memcpy(tmp + s1->str_length + s2->str_length, s3->str_text, s3->str_length);
    s = str_n_from_c(tmp, length);
    return s;
}


/*
 *  NAME
 *      str_equal - test equality of strings
 *
 *  SYNOPSIS
 *      int str_equal(string_t *, string_t *);
 *
 *  DESCRIPTION
 *      The str_equal function is used to test if two strings are equal.
 *
 *  RETURNS
 *      int; zero if the strings are not equal, nonzero if the strings are
 *      equal.
 *
 *  CAVEAT
 *      This function is implemented as a macro in strings.h
 */

#ifndef str_equal

int
str_equal(string_t *s1, string_t *s2)
{
    return (s1 == s2);
}

#endif


/*
 *  NAME
 *      str_upcase - upcase a string
 *
 *  SYNOPSIS
 *      string_t *str_upcase(string_t *);
 *
 *  DESCRIPTION
 *      The str_upcase function is used to form a string which is an upper case
 *      form of the supplied string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_upcase(string_t *s)
{
    static char     *tmp;
    static size_t   tmplen;
    string_t        *retval;
    char            *cp1;
    char            *cp2;

    if (tmp && tmplen < s->str_length)
    {
        free(tmp);
        tmp = 0;
        tmplen = 0;
    }
    if (!tmp)
    {
        tmplen = s->str_length;
        if (tmplen < 16)
            tmplen = 16;
        tmp = explain_malloc_or_die(tmplen);
    }
    for (cp1 = s->str_text, cp2 = tmp; *cp1; ++cp1, ++cp2)
    {
        int c;

        c = *cp1;
        if (c >= 'a' && c <= 'z')
            c += 'A' - 'a';
        *cp2 = c;
    }
    retval = str_n_from_c(tmp, s->str_length);
    return retval;
}


/*
 *  NAME
 *      str_downcase - lowercase string
 *
 *  SYNOPSIS
 *      string_t *str_downcase(string_t *);
 *
 *  DESCRIPTION
 *      The str_downcase function is used to form a string which is a lowercase
 *      form of the supplied string.
 *
 *  RETURNS
 *      string_t* - a pointer to a string in dynamic memory.  Use str_free when
 *      finished with.
 *
 *  CAVEAT
 *      The contents of the structure pointed to MUST NOT be altered.
 */

string_t *
str_downcase(string_t *s)
{
    static char     *tmp;
    static size_t   tmplen;
    string_t        *retval;
    char            *cp1;
    char            *cp2;

    if (tmp && tmplen < s->str_length)
    {
        free(tmp);
        tmp = 0;
        tmplen = 0;
    }
    if (!tmp)
    {
        tmplen = s->str_length;
        if (tmplen < 16)
            tmplen = 16;
        tmp = explain_malloc_or_die(tmplen);
    }
    for (cp1 = s->str_text, cp2 = tmp; *cp1; ++cp1, ++cp2)
    {
        int c;

        c = *cp1;
        if (c >= 'A' && c <= 'Z')
            c += 'a' - 'A';
        *cp2 = c;
    }
    retval = str_n_from_c(tmp, s->str_length);
    return retval;
}


/*
 *  NAME
 *      str_bool - get boolean value
 *
 *  SYNOPSIS
 *      int str_bool(string_t *s);
 *
 *  DESCRIPTION
 *      The str_bool function is used to determine the boolean value of the
 *      given string.  A "false" result is if the string is empty or
 *      0 or blank, and "true" otherwise.
 *
 *  RETURNS
 *      int: zero to indicate a "false" result, nonzero to indicate a "true"
 *      result.
 */

int
str_bool(string_t *s)
{
    char *cp;

    cp = s->str_text;
    while (*cp)
    {
        if (*cp != ' ' && *cp != '0')
            return 1;
        ++cp;
    }
    return 0;
}


/*
 *  NAME
 *      str_field - extract a field from a string
 *
 *  SYNOPSIS
 *      string_t *str_field(string_t *, char separator, int field_number);
 *
 *  DESCRIPTION
 *      The str_field functipon is used to erxtract a field from a string.
 *      Fields of the string are separated by ``separator'' characters.
 *      Fields are numbered from 0.
 *
 *  RETURNS
 *      Asking for a field off the end of the string will result in a null
 *      pointer return.  The null string is considered to have one empty field.
 */

string_t *
str_field(string_t *s, int sep, int fldnum)
{
    char *cp;
    char *ep;

    cp = s->str_text;
    while (fldnum > 0)
    {
        ep = strchr(cp, sep);
        if (!ep)
            return 0;
        cp = ep + 1;
        --fldnum;
    }
    ep = strchr(cp, sep);
    if (ep)
        return str_n_from_c(cp, ep - cp);
    return str_from_c(cp);
}


void
slow_to_fast(char **in, string_t **out, size_t length)
{
    size_t j;

    if (out[0])
        return;
    for (j = 0; j < length; ++j)
        out[j] = str_from_c(in[j]);
}


#ifdef DEBUG

const char *
str_repn(string_t *s)
{
    static char buffer[1 << 12];

    if (!s)
        return "NULL";
    snprintf
        (buffer,
        sizeof(buffer),
        "%08lX->{str_hash = %08lX; str_refs = %ld; str_length = %ld, "
        "str_text = \"%s\"; }",
        (long)s,
        s->str_hash, s->str_references, (long)s->str_length, s->str_text);
    return buffer;
}

#endif


string_t *
str_format(const char *fmt, ...)
{
    va_list         ap;
    size_t          length;
    static size_t   tmplen;
    static char     *tmp;
    int             width;
    int             prec;
    int             c;
    const char      *s;

    /*
     * determine the string length
     */
    va_start(ap, fmt);
    length = 0;
    s = fmt;
    while (*s)
    {
        c = *s++;
        if (c != '%')
        {
            ++length;
            continue;
        }
        c = *s++;
        width = 0;
        switch (c)
        {
        case '*':
            width = va_arg(ap, int);
            c = *s++;
            break;

        default:
            if (!isdigit(c))
                break;
            for (;;)
            {
                width = width * 10 + c - '0';
                c = *s++;
                if (!isdigit(c))
                    break;
            }
            break;
        }
        prec = 0;
        if (c == '.')
        {
            c = *s++;
            while (isdigit(c))
            {
                prec = prec * 10 + c - '0';
                c = *s++;
            }
        }
        switch (c)
        {
        default:
            explain_output_error_and_die
            (
                "in format string \"%s\", illegal specifier '%c'",
                fmt,
                c
            );

        case 'd':
            {
                int a;
                char num[50];

                a = va_arg(ap, int);
                if (width < 1)
                    width = 1;
                if (prec < 1)
                    prec = 1;
                snprintf(num, sizeof(num), "%*.*d", width, prec, a);
                length += strlen(num);
            }
            break;

        case 's':
            {
                char *a;
                size_t len;

                a = va_arg(ap, char *);
                len = strlen(a);
                if (prec && (int)len > prec)
                    len = prec;
                if ((int)len < width)
                    len = width;
                length += len;
            }
            break;

        case 'S':
            {
                string_t *a;
                size_t len;

                a = va_arg(ap, string_t *);
                len = a->str_length;
                if (prec && (int)len > prec)
                    len = prec;
                if ((int)len < width)
                    len = width;
                length += len;
            }
            break;
        }
    }
    va_end(ap);

    /*
     * allocate dynamic space to put it in
     */
    if (tmp && length > tmplen)
    {
        free(tmp);
        tmp = 0;
        tmplen = 0;
    }
    if (!tmp)
    {
        tmplen = length;
        if (tmplen < 64)
            tmplen = 64;
        tmp = explain_malloc_or_die(tmplen);
    }

    /*
     * build the formatted string
     */
    va_start(ap, fmt);
    length = 0;
    s = fmt;
    while (*s)
    {
        c = *s++;
        if (c != '%')
        {
            tmp[length++] = c;
            continue;
        }
        c = *s++;
        width = 0;
        switch (c)
        {
        case '*':
            width = va_arg(ap, int);
            c = *s++;
            break;

        default:
            if (!isdigit(c))
                break;
            for (;;)
            {
                width = width * 10 + c - '0';
                c = *s++;
                if (!isdigit(c))
                    break;
            }
            break;
        }
        prec = 0;
        if (c == '.')
        {
            c = *s++;
            while (isdigit(c))
            {
                prec = prec * 10 + c - '0';
                c = *s++;
            }
        }
        switch (c)
        {
        default:
            explain_output_error_and_die
            (
                "in format string \"%s\", illegal specifier '%c'",
                fmt,
                c
            );

        case 'd':
            {
                int a;
                char num[50];
                int len;

                a = va_arg(ap, int);
                if (width < 1)
                    width = 1;
                if (prec < 1)
                    prec = 1;
                snprintf(num, sizeof(num), "%*.*d", width, prec, a);
                len = strlen(num);
                memcpy(tmp + length, num, len);
                length += len;
            }
            break;

        case 's':
            {
                char *a;
                int len;

                a = va_arg(ap, char *);
                len = strlen(a);
                if (prec && len > prec)
                    len = prec;
                while (len < width)
                {
                    tmp[length++] = ' ';
                    width--;
                }
                memcpy(tmp + length, a, len);
                length += len;
            }
            break;

        case 'S':
            {
                string_t *a;
                int len;

                a = va_arg(ap, string_t *);
                len = a->str_length;
                if (prec && len > prec)
                    len = prec;
                while (len < width)
                {
                    tmp[length++] = ' ';
                    --width;
                }
                memcpy(tmp + length, a->str_text, len);
                length += len;
            }
            break;
        }
    }
    va_end(ap);

    /*
     * make the string
     */
    assert(length <= tmplen);
    return str_n_from_c(tmp, length);
}
