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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * This file contains the functions for
 * assigning and referencing variables.
 */

#include <common/ac/assert.h>
#include <common/ac/stddef.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <libexplain/malloc.h>

#include <common/fstrcmp.h>

#include <chip8as/id.h>

typedef struct symbol_t symbol_t;
struct symbol_t
{
    string_t        *name;
    hash_t          hash;
    symbol_t        *next;
    void            *data;
};


static symbol_t **hash_table;
static hash_t   hash_modulus;
static hash_t   hash_mask;
static hash_t   hash_load;


/*
 * NAME
 *      id_initialize - start up symbol table
 *
 * SYNOPSIS
 *      void id_initialize(void);
 *
 * DESCRIPTION
 *      The id_initialize function is used to create the hash table.
 *
 * RETURNS
 *      void
 *
 * CAVEAT
 *      Assumes the str_initialize function has been called already.
 */

void
id_initialize(void)
{
    hash_t  j;

    hash_modulus = 1<<8; /* MUST be a power of 2 */
    hash_mask = hash_modulus - 1;
    hash_load = 0;
    hash_table =
        (symbol_t **)explain_malloc_or_die(hash_modulus * sizeof(symbol_t *));
    for (j = 0; j < hash_modulus; ++j)
        hash_table[j] = 0;
}


/*
 * NAME
 *      split - reduce symbol table load
 *
 * SYNOPSIS
 *      void split(void);
 *
 * DESCRIPTION
 *      The split function is used to split symbols in the bucket indicated by
 *      the split point.  The symbols are split between that bucket and the one
 *      after the current end of the table.
 *
 * RETURNS
 *      void
 *
 * CAVEAT
 *      It is only sensable to do this when the symbol table load exceeds some
 *      reasonable threshold.  A threshold of 80% is suggested.
 */

static void
split(void)
{
    hash_t          new_hash_modulus;
    hash_t          new_hash_mask;
    symbol_t        **new_hash_table;
    hash_t          j;

    /*
     * double the modulus
     *
     * This is subtle.  If we only increase the modulus by one, the
     * load always hovers around 80%, so we have to do a split for
     * every insert.  I.e. the malloc burden is O(n) for the lifetime
     * of the symbol table.  BUT if we double the modulus, the length of
     * time until the next split also doubles, making the probablity of
     * a split halve, and sigma(2**-n)=1, so the malloc burden becomes
     * O(1) for the lifetime of the symbol table.
     */
    new_hash_modulus = hash_modulus << 1;
    new_hash_mask = new_hash_modulus - 1;
    new_hash_table =
        explain_malloc_or_die(new_hash_modulus * sizeof(symbol_t *));

    /*
     * now redistribute the list elements
     *
     * It is important to preserve the order of the links because
     * they can be push-down stacks, and to simply add them to the
     * head of the list will reverse the order of the stack!
     */
    for (j = 0; j < hash_modulus; ++j)
    {
        symbol_t        *p;

        new_hash_table[j] = 0;
        new_hash_table[hash_modulus + j] = 0;
        p = hash_table[j];
        while (p)
        {
            symbol_t        *p2;
            hash_t          idx;
            symbol_t        **ipp;

            p2 = p;
            p = p2->next;
            p2->next = 0;

            idx = p2->name->str_hash & new_hash_mask;
            for (ipp = &new_hash_table[idx]; *ipp; ipp = &(*ipp)->next)
                ;
            *ipp = p2;
        }
    }

    /*
     * swap them over
     */
    free(hash_table);
    hash_table = new_hash_table;
    hash_modulus = new_hash_modulus;
    hash_mask = new_hash_mask;
}


/*
 * NAME
 *      id_search - search for a variable
 *
 * SYNOPSIS
 *      int id_search(string_t *name, void *data);
 *
 * DESCRIPTION
 *      Id_search is used to reference a variable.
 *
 *  RETURNS
 *      If the variable has been defined, the function returns a non-zero value
 *      and the value is returned through the 'value' pointer.
 *      If the variable has not been defined, it returns zero,
 *      and 'value' is unaltered.
 *
 * CAVEAT
 *      The value returned from this function, when returned, is allocated
 *      in dynamic memory (it is a copy of the value remembered by this module).
 *      It is the responsibility of the caller to free it when finished with,
 *      by a wl_free() call.
 */

void *
id_search(string_t *name)
{
    hash_t          myhash;
    hash_t          index;
    symbol_t        *p;

    myhash = name->str_hash;
    index = myhash & hash_mask;
    assert(index < hash_modulus);
    for (p = hash_table[index]; p; p = p->next)
    {
        if (str_equal(name, p->name))
            return p->data;
    }
    return 0;
}


void *
id_search_fuzzy(string_t *name, string_t **guess)
{
    string_t        *lhs;
    void            *best_data;
    double          best_weight;
    hash_t          index;

    lhs = str_downcase(name);
    best_weight = 0.6;
    best_data = 0;
    for (index = 0; index < hash_modulus; ++index)
    {
        symbol_t        *p;

        for (p = hash_table[index]; p; p = p->next)
        {
            string_t        *rhs;
            double          weight;

            rhs = str_downcase(p->name);
            weight = fstrcmp(lhs->str_text, rhs->str_text);
            if (weight > best_weight)
            {
                best_weight = weight;
                best_data = p->data;
                if (guess)
                    *guess = p->name;
            }
            str_free(rhs);
        }
    }
    str_free(lhs);
    return best_data;
}


/*
 *  NAME
 *      id_assign - assign a variable
 *
 *  SYNOPSIS
 *      void id_assign(string_t *name, void *data, int size);
 *
 *  DESCRIPTION
 *      Id_assign is used to assign a value to a given variable.
 *
 *  CAVEAT
 *      The name and value are copied by id_assign, so the user may
 *      modify or free them  at a later date without affecting the
 *      variable.
 *
 *      It is an error if the variable already exists.
 */

void
id_define(string_t *name, void *data)
{
    hash_t          myhash;
    hash_t          index;
    symbol_t        *p;

    myhash = name->str_hash;
    index = myhash & hash_mask;
    assert(index < hash_modulus);

#if 0 /* def DEBUG */
    for (p = hash_table[index]; p; p = p->next)
        if (str_equal(name, p->name))
            fatal("duplicate \"%s\" definition", name->str_text);
#endif

    p = (symbol_t *)explain_malloc_or_die(sizeof(symbol_t));
    memset(p, 0, sizeof(*p));
    p->name = str_copy(name);
    p->next = hash_table[index];
    p->hash = myhash;
    p->data = data;
    hash_table[index] = p;

    ++hash_load;
    if (hash_load * 5 >= hash_modulus * 4)
        split();
}


/*
 *  NAME
 *      id_delete - delete a variable
 *
 *  SYNOPSIS
 *      void id_delete(string_t *name);
 *
 *  DESCRIPTION
 *      Id_delete is used to delete variables.
 *
 *  CAVEAT
 *      No complaint is made if the variable does not exist,
 *      since the user wanted it to not exist.
 */

void
id_delete(string_t *name)
{
    hash_t          index;
    symbol_t        **idpp;

    index = name->str_hash & hash_mask;
    assert(index < hash_modulus);
    idpp = &hash_table[index];
    for (;;)
    {
        symbol_t        *p;

        p = *idpp;
        if (!p)
            break;
        if (str_equal(name, p->name))
        {
            str_free(p->name);
            *idpp = p->next;
            free(p);
            --hash_load;
            break;
        }
        idpp = &p->next;
    }
}


/*
 * NAME
 *      id_dump - dump id table
 *
 * SYNOPSIS
 *      void id_dump(void (*callback)(string_t *name, void *data, int size));
 *
 * DESCRIPTION
 *      The id_dump function is used to dump the contents of the id table.
 *      The callback function will be invoked for each id.
 *
 * RETURNS
 *      void
 *
 * CAVEATS
 *      The id's will be unsorted.
 */

void
id_dump(void (*callback)(string_t *, void *, void *), void *aux)
{
    size_t          j;
    symbol_t        *p;

    for (j = 0; j < hash_modulus; ++j)
        for (p = hash_table[j]; p; p = p->next)
            callback(p->name, p->data, aux);
}
