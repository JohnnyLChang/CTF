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
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <common/ac/string.h>
#include <common/ac/stdio.h>
#include <common/ac/stdlib.h>
#include <common/ac/time.h>
#include <libexplain/gettimeofday.h>
#include <libexplain/output.h>
#include <libexplain/program_name.h>

#include <common/trace.h>

#include <chip8run/option.h>
#include <chip8run/arena.h>
#include <chip8run/button.h>
#include <chip8run/chip8.icon>
#include <chip8run/debug.h>
#include <chip8run/ecks.h>
#include <chip8run/machine.h>
#include <chip8run/shell.h>
#include <chip8run/window.h>

static char keypos[16][2] =
{
    { 3, 1, /* 0 */ },
    { 0, 0, /* 1 */ },
    { 0, 1, /* 2 */ },
    { 0, 2, /* 3 */ },
    { 1, 0, /* 4 */ },
    { 1, 1, /* 5 */ },
    { 1, 2, /* 6 */ },
    { 2, 0, /* 7 */ },
    { 2, 1, /* 8 */ },
    { 2, 2, /* 9 */ },
    { 3, 0, /* A */ },
    { 3, 2, /* B */ },
    { 0, 3, /* C */ },
    { 1, 3, /* D */ },
    { 2, 3, /* E */ },
    { 3, 3, /* F */ },
};

static void shell_event(void *, XEvent *, struct timeval *now);
static void shell_free(void *);
static void shell_tickle(void *this, struct timeval *max_sleep,
    struct timeval *now);

shell_class_t shell_class =
{
    sizeof(shell_t),        /* size of instance */
    &window_class,          /* base class */
    window_nop_new,
    shell_event,
    shell_free,
    shell_tickle,
    window_geom,
};


static void
quit_callback(button_t *button)
{
    /*
     * In test mode, if the user presses
     * the quit key, it is an error.
     */
    (void)button;
    if (option_get_test_mode())
        exit(1);
    exit(0);
}


static void
restart_callback(button_t *button)
{
    shell_t *this;

    this = (shell_t *)button->parent;
    if (!this->machine)
        return;
    machine_reset(this->machine);
    if (this->arena)
        arena_update(this->arena, this->machine);
    if (this->debug)
        debug_update(this->debug, this->machine);
}


static void
step_callback(button_t *button)
{
    shell_t *this;
    struct timeval now;
    struct timezone tz;
    struct timeval max_sleep;

    trace(("step_callback(button = %08lX)\n{\n"/*}*/, button));
    this = (shell_t *)button->parent;
    if (this->machine)
    {
        this->single_stepping = 1;
        this->machine->halt = 0;
        explain_gettimeofday_or_die(&now, &tz);
        tv_set(&max_sleep, 1000);
        machine_step(this->machine, &max_sleep, &now);
        debug_update(this->debug, this->machine);
    }
    trace((/*{*/"}\n"));
}


static void
run_callback(button_t *button)
{
    shell_t *this;

    trace(("run_callback(button = %08lX)\n{\n"/*}*/, button));
    this = (shell_t *)button->parent;
    if (this->machine)
    {
        this->single_stepping = 0;
        this->machine->halt = 0;
    }
    trace((/*{*/"}\n"));
}


static void
reload_callback(button_t *button)
{
    shell_t *this;

    trace(("reload_callback(button = %08lX)\n{\n"/*}*/, button));
    this = (shell_t *)button->parent;
    if (this->machine)
        machine_reload(this->machine);
    if (this->arena)
        arena_update(this->arena, this->machine);
    if (this->debug)
        debug_update(this->debug, this->machine);
    trace((/*{*/"}\n"));
}


void
shell_new(shell_t *this, char *file_name)
{
    XSizeHints      size_hints;
    XSizeHints      icon_size_hints;
    int             flags;
    int             x;
    int             y;
    unsigned        width;
    unsigned        height;
    const char      *res_str;
    XSetWindowAttributes attributes;
    Window  icon_window_id;
    Pixmap  icon_pixmap;
    XWMHints wmhints;
    int     j;
    button_t *wp;
    XClassHint class_hint;

    trace(("shell_new(this = %08lX)\n{\n"/*}*/, this));
    this->machine = machine_alloc(file_name);
    this->machine->shell = this;
    this->single_stepping = this->machine->debug;

    /*
     * determine window geometry
     */
    trace(("geometry\n"));
    memset(&size_hints, 0, sizeof(size_hints));
    res_str = x_get_resource("Geometry", "geometry");
    if (res_str)
    {
        flags = XParseGeometry(res_str, &x, &y, &width, &height);
        if (!flags)
            explain_output_error_and_die("bad \"%s\" geometry string", res_str);
    }
    else
        flags = 0;
    if (flags & WidthValue)
    {
        size_hints.width = width;
        size_hints.flags |= USSize;
    }
    else
        size_hints.width = DEFAULT_WIDTH;
    if (flags & HeightValue)
    {
        size_hints.height = height;
        size_hints.flags |= USSize;
    }
    else
        size_hints.height = DEFAULT_HEIGHT;
    if (flags & XValue)
    {
        if (flags & XNegative)
            size_hints.x = DisplayWidth(display, screen) + x - size_hints.width;
        else
            size_hints.x = x;
        size_hints.flags |= USPosition;
    }
    else
        size_hints.x = (DisplayWidth(display, screen) - size_hints.width) / 2;
    if (flags & YValue)
    {
        if (flags & YNegative)
        {
            size_hints.y =
                DisplayHeight(display, screen) + y - size_hints.height;
        }
        else
            size_hints.y = y;
        size_hints.flags |= USPosition;
    }
    else
        size_hints.y = (DisplayHeight(display, screen) - size_hints.height) / 2;
    if (!(size_hints.flags & USPosition))
    {
        if (option_get_test_mode())
            size_hints.flags |= USPosition;
        else
            size_hints.flags |= PPosition;
    }
    if (!(size_hints.flags & USSize))
        size_hints.flags |= PSize;
    size_hints.min_width = MIN_WIDTH;
    size_hints.min_height = MIN_HEIGHT;
    size_hints.flags |= PMinSize;

    /*
     * determine icon window geometry
     */
    trace(("iconGeometry\n"));
    memset(&icon_size_hints, 0, sizeof(icon_size_hints));
    res_str = x_get_resource("IconGeometry", "iconGeometry");
    if (res_str)
    {
        flags = XParseGeometry(res_str, &x, &y, &width, &height);
        if (!flags)
        {
            explain_output_error_and_die
            (
                "bad \"%s\" icon geometry string",
                res_str
            );
        }
    }
    else
        flags = 0;
    if ((flags & WidthValue) && width != icon_width)
        explain_output_error("icon width spec ignored");
    icon_size_hints.width = icon_width;
    if ((flags & HeightValue) && height != icon_height)
        explain_output_error_and_die("icon height spec ignored");
    icon_size_hints.height = icon_height;
    if (flags & XValue)
    {
        if (flags & XNegative)
        {
            icon_size_hints.x =
                DisplayWidth(display, screen) + x - icon_size_hints.width;
        }
        else
            icon_size_hints.x = x;
        icon_size_hints.flags |= USPosition;
    }
    if (flags & YValue)
    {
        if (flags & YNegative)
        {
            icon_size_hints.y =
                DisplayHeight(display, screen) + y - icon_size_hints.height;
        }
        else
            icon_size_hints.y = y;
        icon_size_hints.flags |= USPosition;
    }
    if (!(icon_size_hints.flags & USSize))
        icon_size_hints.flags |= PSize;
    icon_size_hints.min_width = icon_width;
    icon_size_hints.min_height = icon_height;
    icon_size_hints.flags |= PMinSize;
    icon_size_hints.max_width = icon_width;
    icon_size_hints.max_height = icon_height;
    icon_size_hints.flags |= PMaxSize;

    /*
     * create the window
     */
    trace(("CreateWindow\n"));
    this->id =
        XCreateWindow
        (
            display,
            DefaultRootWindow(display),
            size_hints.x,
            size_hints.y,
            size_hints.width,
            size_hints.height,
            1,      /* border width */
            DefaultDepth(display, screen), /* depth */
            InputOutput,    /* class */
            CopyFromParent, /* visual */
            0,
            &attributes
        );

    trace(("XSetNormalHints\n"));
    print_size_hints("size_hints", &size_hints);
    XSetNormalHints(display, this->id, &size_hints);

    /*
     * create icon window
     */
    trace(("icon pixmap\n"));
    trace((
        "XCreatePixmapFromBitmapData(display = %08lX, drawable = %d, "
        "data = %08lX, width = %d, height = %d, fg = %d, bg = %d, "
        "depth = %d)\n",
        display,
        DefaultRootWindow(display),
        icon_bits,
        icon_width,
        icon_height,
        BlackPixel(display, screen),
        WhitePixel(display, screen),
        DefaultDepth(display, screen)
        ));
    icon_pixmap =
        XCreatePixmapFromBitmapData
        (
            display,
            DefaultRootWindow(display),
            icon_bits,
            icon_width,
            icon_height,
            BlackPixel(display, screen),
            WhitePixel(display, screen),
            DefaultDepth(display, screen)
        );
    attributes.border_pixel = BlackPixel(display, screen);
    attributes.background_pixmap = icon_pixmap;
    trace(("create icon window\n"));
    icon_window_id =
        XCreateWindow
        (
            display,
            DefaultRootWindow(display),
            icon_size_hints.x,
            icon_size_hints.y,
            icon_size_hints.width,
            icon_size_hints.height,
            1,
            DefaultDepth(display, screen),
            InputOutput,
            CopyFromParent,
            (CWBorderPixel|CWBackPixmap),
            &attributes
        );

    trace(("icon size hints\n"));
    print_size_hints("icon_size_hints", &icon_size_hints);
    XSetNormalHints(display, icon_window_id, &icon_size_hints);

    /*
     * determine the window manager hints
     */
    trace(("window manager hints\n"));
    wmhints.flags = InputHint | StateHint | IconWindowHint;
    wmhints.input = True;
    if (x_get_resource_bool("StartIconic", "startIconic", 0))
        wmhints.initial_state = IconicState;
    else
        wmhints.initial_state = NormalState;
    wmhints.icon_window = icon_window_id;
    if (icon_size_hints.flags & USPosition)
    {
        wmhints.icon_x = icon_size_hints.x;
        wmhints.icon_y = icon_size_hints.y;
        wmhints.flags |= IconPositionHint;
    }
    XSetWMHints(display, this->id, &wmhints);
    res_str = x_get_resource("Title", "title");
    if (!res_str)
        res_str = file_name;
    XStoreName(display, this->id, res_str);
    XSetIconName(display, this->id, res_str);
    res_str = x_get_resource("Name", "name");
    if (!res_str)
        res_str = explain_program_name_get();
    class_hint.res_name = (char *)res_str;
    class_hint.res_class = CLASS_NAME;
    XSetClassHint(display, this->id, &class_hint);

    /*
     * get standard info
     */
    win_std_info((window_t *)this, (char *)NULL, (char *)NULL);
    XSelectInput
    (
        display,
        this->id,
        KeyPressMask | KeyReleaseMask | StructureNotifyMask
    );

    /*
     * create all the buttons
     */
    for (j = 0; j < 16; ++j)
    {
        char    name[10];
        char    title[10];

        snprintf(name, sizeof(name), "key_%x", j);
        snprintf(title, sizeof(title), "%X", j);
        wp = (button_t *)window_new(&button_class);
        button_new(wp, this, -10, -10, 1, 1, name, title, XC_hand2);
        this->key[j] = wp;
    }

    wp = (button_t *)window_new(&button_class);
    button_new(wp, this, -10, -10, 1, 1, "quit", "Quit", XC_pirate);
    wp->callback = quit_callback;
    this->quit = wp;

    wp = (button_t *)window_new(&button_class);
    button_new(wp, this, -10, -10, 1, 1, "restart", "Restart", XC_left_ptr);
    this->restart = wp;
    this->restart->callback = restart_callback;

    this->arena = (arena_t *)window_new(&arena_class);
    arena_new(this->arena, this, -10, -10, 1, 1, "arena", "arena", -1);

    if (this->single_stepping)
    {
        this->step = (button_t *)window_new(&button_class);
        button_new
        (
            this->step,
            this,
            -10,
            -10,
            1,
            1,
            "step",
            "Step",
            XC_left_ptr
        );
        this->step->callback = step_callback;

        this->run = (button_t *)window_new(&button_class);
        button_new(this->run, this, -10, -10, 1, 1, "go", "Go", XC_left_ptr);
        this->run->callback = run_callback;

        this->reload = (button_t *)window_new(&button_class);
        button_new
        (
            this->reload,
            this,
            -10,
            -10,
            1,
            1,
            "reload",
            "Load",
            XC_left_ptr
        );
        this->reload->callback = reload_callback;

        this->debug = (debug_t *)window_new(&debug_class);
        debug_new(this->debug, this, -10, -10, 1, 1, "debug", "Debug", -1);
        debug_update(this->debug, this->machine);
    }

    XMapWindow(display, this->id);
    window_add((window_t *)this);
    trace((/*{*/"}\n"));
}


void
shell_free(void *that)
{
    shell_t *this;
    int     j;

    this = that;
    trace(("shell_free(this = %08lX)\n{\n"/*}*/, this));
    for (j = 0; j < 16; ++j)
        button_free(this->key[j]);
    button_free(this->quit);
    button_free(this->restart);
    if (this->step)
        button_free(this->step);
    if (this->run)
        button_free(this->run);
    if (this->reload)
        button_free(this->reload);
    arena_free(this->arena);
    if (this->debug)
        debug_free(this->debug);
    if (this->machine)
        free(this->machine);
    XDestroyWindow(display, this->id);
    window_remove((window_t *)this);
    free(this);
    trace((/*{*/"}\n"));
}


static void
shell_event(void *that, XEvent *ep, struct timeval *now)
{
    shell_t *this;
    char    buffer[20];
    KeySym  keysym;
    XComposeStatus compose;
    button_t *button;

    this = that;
    trace(("shell_fevent(this = %08lX, ep = %08lX)\n{\n", this, ep));
    switch (ep->type)
    {
    case ConfigureNotify:
        {
            XConfigureEvent *cnep;
            int     unit;
            int     j;
            int     ex, ey;
            int     half;

            cnep = (XConfigureEvent *)ep;
            unit = (cnep->width - 4) / 64;
            j = (cnep->height - 4) / (this->debug ? 88 : 64);
            if (j < unit)
                unit = j;
            if (unit < 1)
                unit = 1;
            this->unit = unit;
            ex = (cnep->width - 64 * unit) / 2;
            ey = this->debug ? 2 * unit : (cnep->height - 64 * unit) / 2;
            this->ex = ex;
            this->ey = ey;
            half = ey + 34 * unit;
            for (j = 0; j < 16; ++j)
            {
                window_geom
                (
                    (window_t *)this->key[j],
                    ex + 8 * unit * keypos[j][1],
                    half + 8 * unit * keypos[j][0],
                    6 * unit,
                    6 * unit
                );
            }
            window_geom
            (
                (window_t *)this->quit,
                ex + 42 * unit,
                half,
                22 * unit,
                6 * unit
            );
            window_geom
            (
                (window_t *)this->restart,
                ex + 42 * unit,
                half + 8 * unit,
                22 * unit,
                6 * unit
            );
            window_geom
            (
                (window_t *)this->arena,
                ex, ey, 64 * unit, 32 * unit
            );
            if (this->debug)
            {
                half = ey + 66 * unit;
                window_geom
                (
                    (window_t *)this->step,
                    ex,
                    half,
                    20 * unit,
                    6 * unit
                );
                window_geom
                (
                    (window_t *)this->run,
                    ex + 22 * unit,
                    half,
                    20 * unit,
                    6 * unit
                );
                window_geom
                (
                    (window_t *)this->reload,
                    ex + 44 * unit,
                    half,
                    20 * unit,
                    6 * unit
                );
                half += 8 * unit;
                window_geom
                (
                    (window_t *)this->debug,
                    unit,
                    half,
                    cnep->width - 2 * unit,
                    cnep->height - unit - half
                );
            }
        }
        break;

    case KeyPress:
    case KeyRelease:
        trace(("send_event = %d;\n", ((XKeyEvent *)ep)->send_event));
        XLookupString((XKeyEvent *)ep, buffer, sizeof(buffer),
            &keysym, &compose);
        button = 0;
        switch (keysym)
        {
        case XK_Q:
        case XK_q:
            button = this->quit;
            break;

        case XK_r:
        case XK_R:
            button = this->restart;
            break;

        case XK_S:
        case XK_s:
            button = this->step;
            break;

        case XK_G:
        case XK_g:
            button = this->run;
            break;

        case XK_L:
        case XK_l:
            button = this->reload;
            break;

        case XK_0: case XK_1: case XK_2: case XK_3:
        case XK_4: case XK_5: case XK_6: case XK_7:
        case XK_8: case XK_9:
            button = this->key[keysym - XK_0];
            break;

        case XK_A: case XK_B: case XK_C: case XK_D:
        case XK_E: case XK_F:
            button = this->key[keysym - XK_A + 10];
            break;

        case XK_a: case XK_b: case XK_c: case XK_d:
        case XK_e: case XK_f:
            button = this->key[keysym - XK_a + 10];
            break;

        case XK_W:
        case XK_w:
            if (ep->type == KeyPress)
                machine_dump(this->machine);
            break;
        }
        if (button)
            button_key_pressed(button, (ep->type == KeyPress), now);
        break;

    case MappingNotify:
        XRefreshKeyboardMapping((XMappingEvent *)ep);
        break;
    }
    trace((/*{*/"}\n"));
}


static void
shell_chip8_update_debug(shell_t *this)
{
    if (!this->machine)
        return;
    trace(("shell_chip8_update_debug(this = %08lX)\n{\n"/*}*/, this));
    if (this->machine->debug && !this->debug)
    {
        XWindowChanges  change;

        this->single_stepping = 1;

        change.height = 2 * this->ey + 80 * this->unit;
        XConfigureWindow(display, this->id, CWHeight, &change);

        this->step = (button_t *)window_new(&button_class);
        button_new
        (
            this->step,
            this,
            -10,
            -10,
            1,
            1,
            "step",
            "Step",
            XC_left_ptr
        );
        this->step->callback = step_callback;

        this->run = (button_t *)window_new(&button_class);
        button_new(this->run, this, -10, -10, 1, 1, "go", "Go", XC_left_ptr);
        this->run->callback = run_callback;

        this->reload = (button_t *)window_new(&button_class);
        button_new
        (
            this->reload,
            this,
            -10,
            -10,
            1,
            1,
            "reload",
            "Load",
            XC_left_ptr
        );
        this->reload->callback = reload_callback;

        this->debug = (debug_t *)window_new(&debug_class);
        debug_new(this->debug, this, -10, -10, 1, 1, "debug", "Debug", -1);

    }
    if (this->debug)
        debug_update(this->debug, this->machine);
    trace((/*{*/"}\n"));
}


void
shell_chip8_update(shell_t *this)
{
    if (!this->machine)
        return;
    trace(("shell_chip8_update(this = %08lX)\n{\n"/*}*/, this));
    shell_chip8_update_debug(this);
    if (this->arena)
        arena_update(this->arena, this->machine);
    trace((/*{*/"}\n"));
}


int
shell_test_key(shell_t *this, int key, int clear, struct timeval *now)
{
    key &= 15;
    return button_test(this->key[key], clear, now);
}


static void
shell_tickle(void *that, struct timeval *max_sleep, struct timeval *now)
{
    shell_t         *this;
    int             n;

    this = that;
    if (this->single_stepping)
        return;
    if (!this->machine)
        return;
    if (this->machine->halt)
    {
        this->single_stepping = 1;
        return;
    }
    /*
     * Do a whole bunch of opcodes
     * until need to wait for some reason.
     *
     * This aviods system calls (select) which are deathly slow.
     */
    for (n = 0; n < 1000; ++n)
    {
        machine_step(this->machine, max_sleep, now);
        if
        (
            max_sleep->tv_sec
        ||
            max_sleep->tv_usec
        ||
            this->machine->halt
        )
            break;
    }
    shell_chip8_update_debug(this);
}
