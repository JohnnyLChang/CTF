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

#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <common/ac/string.h>
#include <common/ac/unistd.h>
#include <libexplain/output.h>
#include <libexplain/program_name.h>

#include <common/sizeof.h>
#include <common/trace.h>

#include <chip8run/option.h>
#include <chip8run/ecks.h>

char            CLASS_NAME[] = "Chip8";
Display         *display;
int             screen;
GC              gc;

static  XrmDatabase     command_line_db;
static  XrmDatabase     application_defaults_db;
static  XrmDatabase     server_db;
static  XrmDatabase     host_specific_db;
static  XrmDatabase     resource_db;


void
x_initialize(void)
{
    XrmInitialize();
}


void
x_resource1(const char *line)
{
    XrmPutLineResource(&command_line_db, line);
}


static void
x_put_resource2(XrmDatabase *db, const char *name, const char *value)
{
    XrmBinding      binding[100];
    XrmQuark        quark[100];
    XrmBinding      *binding_p;
    XrmQuark        *quark_p;
    const char      *progname;

    /*
     * turn program name into binding and quark list
     */
    progname = explain_program_name_get();
    XrmStringToBindingQuarkList(progname, binding, quark);

    /*
     * advance past the program name
     */
    for
    (
        binding_p = binding, quark_p = quark;
        *quark_p != NULLQUARK;
        binding_p++, quark_p++
    )
        ;

    /*
     * turn the option specifier into bindings and quark list
     */
    XrmStringToBindingQuarkList(name, binding_p, quark_p);

    /*
     * stash the value
     */
    XrmQPutStringResource(db, binding, quark, value);
}


void
x_resource2(const char *name, const char *value)
{
    x_put_resource2(&command_line_db, name, value);
}


static char *
get_res(XrmDatabase *db, const char *loose, const char *tight)
{
    char            loose_all[1000];
    char            tight_all[1000];
    static char     buffer[1000];
    XrmValue        value;
    char            *str_type[20];
    char            *result;

    trace(("get_res(loose = %08lX, tight = %08lX)\n{\n", loose, tight));

    strcpy(tight_all, explain_program_name_get());
    strcat(tight_all, ".");
    strcat(tight_all, tight);

    strcpy(loose_all, CLASS_NAME);
    strcat(loose_all, ".");
    strcat(loose_all, loose);

    trace_string(loose_all);
    trace_string(tight_all);

    if (!XrmGetResource(*db, tight_all, loose_all, str_type, &value))
        result = 0;
    else
    {
        strncpy(buffer, (char *)value.addr, (int)value.size);
        result = buffer;
    }
    trace_string(result);
    trace(("}\n"));
    return result;
}


char *
x_get_resource(const char *loose, const char *tight)
{
    char    *result;

    trace(("x_get_resource(loose = %08lX, tight = %08lX)\n{\n", loose, tight));
    trace_string(loose);
    trace_string(tight);
    result = get_res(&resource_db, loose, tight);
    trace_string(result);
    trace((/*{*/"}\n"));
    return result;
}


static void
downcase(char *s)
{
    while (*s)
    {
        if (*s >= 'A' && *s <= 'Z')
            *s += 'a' - 'A';
        ++s;
    }
}


int
x_get_resource_bool(const char *loose, const char *tight, int dflt)
{
    typedef struct table_t table_t;
    struct table_t
    {
        const char      *name;
        int             value;
    };

    static const table_t table[] =
    {
        { "on",         1,      },
        { "off",        0,      },
        { "true",       1,      },
        { "false",      0,      },
        { "yes",        1,      },
        { "no",         0,      },
    };

    char            *res_str;
    const table_t   *tp;

    res_str = x_get_resource(loose, tight);
    if (!res_str)
        return dflt;
    downcase(res_str);
    for (tp = table; tp < ENDOF(table); ++tp)
    {
        if (!strcmp(tp->name, res_str))
            return tp->value;
    }
    /* no idea what they mean */
    explain_output_error("boolean value \"%s\" unintelligible", res_str);
    return dflt;
}


static char *
home_dir(void)
{
    char    *result;

    result = getenv("HOME");
    if (!result)
        explain_output_error_and_die("no HOME environment variable");
    return result;
}


void
x_open(void)
{
    char    *display_name;
    char    path[1000];
    char    *env;

    trace(("x_open()\n{\n"/*}*/));
    display_name = get_res(&command_line_db, "Display", "display");
    trace_string(display_name);
    display = XOpenDisplay(display_name);
    if (!display)
    {
        explain_output_error_and_die
        (
            "can't open \"%s\" display",
            XDisplayName(display_name)
        );
    }
    trace(("display = %08lX;\n", display));
    screen = DefaultScreen(display);
    trace(("screen = %d;\n", screen));
    /* XSynchronize(display, True); */

    /*
     * get the application defaults file
     */
    strcpy(path, "/usr/lib/X11/app-defaults/");
    strcpy(path, CLASS_NAME);
    application_defaults_db = XrmGetFileDatabase(path);
    trace(("have appl dflt\n"));

    /*
     * get the server defaults
     */
#ifdef XLIB_ILLEGAL_ACCESS
    if (display->xdefaults)
        server_db = XrmGetStringDatabase(display->xdefaults);
    else
#endif
    {
        strcpy(path, home_dir());
        strcat(path, "/.Xdefaults");
        server_db = XrmGetFileDatabase(path);
    }
    trace(("have server db\n"));

    /*
     * get the host specific environment
     */
    env = getenv("XENVIRONMENT");
    if (env)
        host_specific_db = XrmGetFileDatabase(env);
    else
    {
        int len;

        strcpy(path, home_dir());
        strcat(path, "/.Xdefaults-");
        len = strlen(path);
        gethostname(path + len, sizeof(path) - len);
        host_specific_db = XrmGetFileDatabase(path);
    }
    trace(("have host db\n"));

    /*
     * the order of merging dictates the priority of the various databases
     */
    XrmMergeDatabases(application_defaults_db, &resource_db);
    XrmMergeDatabases(server_db, &resource_db);
    XrmMergeDatabases(host_specific_db, &resource_db);
    XrmMergeDatabases(command_line_db, &resource_db);
    trace((/*{*/"}\n"));
}


void
print_size_hints(const char *name, XSizeHints *value)
{
    trace(("%s =\n{\n"/*}*/, name));
    trace(("flags = 0x%04lX;\n", value->flags));
    (void)name;
    if (value->flags & (USPosition | PPosition))
    {
        trace(("x = %d;\n", value->x));
        trace(("y = %d;\n", value->y));
    }
    if (value->flags & (USSize | PSize))
    {
        trace(("width = %d;\n", value->width));
        trace(("height = %d;\n", value->height));
    }
    if (value->flags & PMinSize)
    {
        trace(("min_width = %d;\n", value->min_width));
        trace(("min_height = %d;\n", value->min_height));
    }
    if (value->flags & PMaxSize)
    {
        trace(("max_width = %d;\n", value->max_width));
        trace(("max_height = %d;\n", value->max_height));
    }
    trace((/*{*/"};\n"));
}
