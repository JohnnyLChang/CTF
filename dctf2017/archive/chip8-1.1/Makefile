#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
#    W   W    A    RRRR   N   N   III  N   N  III  N   N   GGG
#    W   W   A A   R   R  NN  N    I   NN  N   I   NN  N  G   G
#    W   W  A   A  RRRR   N N N    I   N N N   I   N N N  G
#    W W W  AAAAA  R R    N  NN    I   N  NN   I   N  NN  G  GG
#    W W W  A   A  R  R   N   N    I   N   N   I   N   N  G   G
#     W W   A   A  R   R  N   N   III  N   N  III  N   N   GGG
#
# Warning: DO NOT send patches which fix this file. IT IS NOT the original
# source file. This file is GENERATED from the Aegis repository file manifest.
# If you find a bug in this file, it could well be an Aegis bug.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#

#
# Makefile.  Generated from Makefile.in by configure.
#
# The configure script generates 2 files:
# 1. This Makefile
# 2. common/config.h
# If you change this Makefile, you may also need to change these files. To see
# what is configured by the configure script, search for @ in the Makefile.in
# file.
#
# If you wish to reconfigure the installations directories it is RECOMMENDED
# that you re-run the configure script.
#
# Use "./configure --help" for a list of options.
#

#
# directory containing the source
#
srcdir = .


#
# the name of the install program to use
#
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_DIR = /usr/bin/install -c -m 0755 -d
INSTALL_SCRIPT = ${INSTALL}

#
# The name of the C compiler to use.
#
CC = gcc

#
# The C compiler flags to use.
#
CFLAGS = -g -O2 

#
# The C preprocessor flags to use.
#
CPPFLAGS = 

#
# The linker flags to use
#
LDFLAGS = 

#
# prefix for installation path
#
prefix = /usr/local
exec_prefix = /usr/local

#
# Where to put the executables.
#
# On a network, this would only be shared between machines of identical
# cpu-hw-os flavour. It can be read-only.
#
# The $(DESTDIR) is for packaging.
#
bindir = $(DESTDIR)/usr/local/bin

#
# Where to put the manuals.
#
# On a network, this would be shared between all machines on the network. It can
# be read-only.
#
# The $(DESTDIR) is for packaging.
#
mandir = $(DESTDIR)${prefix}/share/man

#
# Where to put the non-executable package data.
#
# On a network, this would be shared between all machines on the network. It can
# be read-only.
#
# The $(DESTDIR) is for packaging.
#
datadir = $(DESTDIR)${prefix}/share

# define this to silence ./configure warning
datarootdir = $(DESTDIR)${prefix}/share

#
# extra libraries required for your system
#
LIBS =  -lSM -lICE -lexplain -lm    -lX11

#
# shell to use to run tests and commands
#
SH = /bin/sh

#
# The program to use to construct static libraries.
#
AR = ar

#
# The program to use to place symbol indexes within static libraries.
#
RANLIB = ranlib

#
# Set GROFF to the name of the roff command on your system, usually "groff" or
# "troff" or "nroff".
#
GROFF = groff

#
# Set SOELIM to the name of the roff proprocessor command on your system,
# usually "soelim" or "gsoelim".
#
SOELIM = soelim

# ---------------------------------------------------------
# You should not need to change anything below this line.

#
# The default target
#
the-default-target: all

chip8as/as.o: chip8as/as.c chip8as/as.h chip8as/cross_refer.h chip8as/emit.h \
		chip8as/expr.h chip8as/id.h chip8as/lex.h common/ac/stddef.h \
		common/ac/string.h common/debug.h common/sizeof.h common/str.h \
		common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/as.c
	mv as.o $@

chip8as/col.o: chip8as/col.c chip8as/col.h common/ac/assert.h \
		common/ac/ctype.h common/ac/stdarg.h common/ac/stddef.h \
		common/ac/stdio.h common/ac/string.h common/ac/time.h \
		common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/col.c
	mv col.o $@

chip8as/conditional.o: chip8as/conditional.c chip8as/conditional.h \
		chip8as/emit.h chip8as/expr.h chip8as/id.h chip8as/lex.h \
		common/ac/stddef.h common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/conditional.c
	mv conditional.o $@

chip8as/cross_refer.o: chip8as/col.h chip8as/cross_refer.c \
		chip8as/cross_refer.h chip8as/expr.h chip8as/id.h \
		chip8as/ilist.h chip8as/option.h common/ac/stddef.h \
		common/str.h common/word.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/cross_refer.c
	mv cross_refer.o $@

chip8as/emit.o: chip8as/col.h chip8as/emit.c chip8as/emit.h chip8as/lex.h \
		chip8as/option.h chip8as/output.h common/ac/stddef.h \
		common/debug.h common/str.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/emit.c
	mv emit.o $@

chip8as/expr.o: chip8as/emit.h chip8as/expr.c chip8as/expr.h chip8as/id.h \
		chip8as/ilist.h chip8as/lex.h common/ac/stddef.h \
		common/ac/stdlib.h common/ac/string.h common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/expr.c
	mv expr.o $@

chip8as/id.o: chip8as/id.c chip8as/id.h common/ac/assert.h common/ac/stddef.h \
		common/ac/stdlib.h common/ac/string.h common/debug.h \
		common/fstrcmp.h common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/id.c
	mv id.o $@

chip8as/ilist.o: chip8as/ilist.c chip8as/ilist.h common/ac/stddef.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/ilist.c
	mv ilist.o $@

chip8as/lex.o: chip8as/conditional.h chip8as/emit.h chip8as/lex.c \
		chip8as/lex.h chip8as/option.h common/ac/assert.h \
		common/ac/stdarg.h common/ac/stddef.h common/ac/stdio.h \
		common/ac/string.h common/debug.h common/sizeof.h common/str.h \
		common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/lex.c
	mv lex.o $@

chip8as/main.o: chip8as/as.h chip8as/id.h chip8as/main.c chip8as/option.h \
		common/ac/stddef.h common/ac/stdio.h common/ac/stdlib.h \
		common/arglex.h common/debug.h common/help.h common/str.h \
		common/trace.h common/version.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/main.c
	mv main.o $@

chip8as/option.o: chip8as/option.c chip8as/option.h common/ac/stddef.h \
		common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/option.c
	mv option.o $@

chip8as/output.o: chip8as/option.h chip8as/output.c chip8as/output.h \
		chip8as/output/asc.h chip8as/output/c.h chip8as/output/hp.h \
		chip8as/output/private.h chip8as/output/raw.h \
		chip8as/output/unix.h common/ac/stdlib.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output.c
	mv output.o $@

chip8as/output/asc.o: chip8as/output.h chip8as/output/asc.c \
		chip8as/output/asc.h chip8as/output/private.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/asc.c
	mv asc.o $@

chip8as/output/c.o: chip8as/output.h chip8as/output/c.c chip8as/output/c.h \
		chip8as/output/private.h common/ac/string.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/c.c
	mv c.o $@

chip8as/output/hp.o: chip8as/output.h chip8as/output/hp.c chip8as/output/hp.h \
		chip8as/output/private.h common/ac/assert.h common/ac/stdlib.h \
		common/ac/string.h common/debug.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/hp.c
	mv hp.o $@

chip8as/output/private.o: chip8as/output.h chip8as/output/private.c \
		chip8as/output/private.h common/ac/stdarg.h common/ac/stdio.h \
		common/ac/string.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/private.c
	mv private.o $@

chip8as/output/raw.o: chip8as/output.h chip8as/output/private.h \
		chip8as/output/raw.c chip8as/output/raw.h common/ac/stdio.h \
		common/ac/stdlib.h common/ac/sys/stat.h common/ac/sys/types.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/raw.c
	mv raw.o $@

chip8as/output/unix.o: chip8as/output.h chip8as/output/private.h \
		chip8as/output/unix.c chip8as/output/unix.h common/libdir.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8as/output/unix.c
	mv unix.o $@

chip8dis/dis.o: chip8dis/dis.c chip8dis/dis.h common/ac/ctype.h \
		common/ac/stdio.h common/input.h common/sizeof.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8dis/dis.c
	mv dis.o $@

chip8dis/main.o: chip8dis/dis.h chip8dis/main.c common/ac/stddef.h \
		common/ac/stdio.h common/ac/stdlib.h common/arglex.h \
		common/debug.h common/help.h common/str.h common/trace.h \
		common/version.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8dis/main.c
	mv main.o $@

chip8run/arena.o: chip8run/arena.c chip8run/arena.h chip8run/ecks.h \
		chip8run/machine.h chip8run/window.h common/ac/stddef.h \
		common/ac/stdlib.h common/ac/string.h common/ac/sys/types.h \
		common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/arena.c
	mv arena.o $@

chip8run/arglex2.o: chip8run/arglex2.c chip8run/arglex2.h common/arglex.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/arglex2.c
	mv arglex2.o $@

chip8run/autotest.o: chip8run/arglex2.h chip8run/autotest.c \
		chip8run/autotest.h chip8run/machine.h chip8run/option.h \
		common/ac/stddef.h common/ac/stdio.h common/ac/stdlib.h \
		common/ac/sys/types.h common/arglex.h common/debug.h \
		common/libdir.h common/str.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/autotest.c
	mv autotest.o $@

chip8run/button.o: chip8run/button.c chip8run/button.h chip8run/ecks.h \
		chip8run/window.h common/ac/stddef.h common/ac/stdlib.h \
		common/ac/string.h common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/button.c
	mv button.o $@

chip8run/chip8.o: chip8run/chip8.c chip8run/chip8.h chip8run/shell.h \
		chip8run/window.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/chip8.c
	mv chip8.o $@

chip8run/debug.o: chip8run/debug.c chip8run/debug.h chip8run/ecks.h \
		chip8run/machine.h chip8run/window.h common/ac/stddef.h \
		common/ac/stdio.h common/ac/stdlib.h common/ac/string.h \
		common/ac/sys/types.h common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/debug.c
	mv debug.o $@

chip8run/ecks.o: chip8run/ecks.c chip8run/ecks.h chip8run/option.h \
		common/ac/stddef.h common/ac/stdio.h common/ac/stdlib.h \
		common/ac/string.h common/ac/sys/types.h common/ac/unistd.h \
		common/debug.h common/sizeof.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/ecks.c
	mv ecks.o $@

chip8run/event.o: chip8run/ecks.h chip8run/event.c chip8run/event.h \
		chip8run/window.h common/ac/stddef.h common/debug.h \
		common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/event.c
	mv event.o $@

chip8run/machine.o: chip8run/hex10.h chip8run/hex5.h chip8run/machine.c \
		chip8run/machine.h chip8run/option.h chip8run/shell.h \
		chip8run/window.h common/ac/stddef.h common/ac/stdio.h \
		common/ac/stdlib.h common/ac/string.h common/ac/sys/types.h \
		common/ac/time.h common/debug.h common/input.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/machine.c
	mv machine.o $@

chip8run/main.o: chip8run/arglex2.h chip8run/autotest.h chip8run/chip8.h \
		chip8run/ecks.h chip8run/event.h chip8run/main.c \
		chip8run/option.h common/ac/stddef.h common/ac/stdio.h \
		common/ac/stdlib.h common/ac/time.h common/arglex.h \
		common/debug.h common/help.h common/libdir.h common/str.h \
		common/trace.h common/version.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/main.c
	mv main.o $@

chip8run/option.o: chip8run/option.c chip8run/option.h common/ac/stddef.h \
		common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/option.c
	mv option.o $@

chip8run/shell.o: chip8run/arena.h chip8run/button.h chip8run/chip8.icon \
		chip8run/debug.h chip8run/ecks.h chip8run/machine.h \
		chip8run/option.h chip8run/shell.c chip8run/shell.h \
		chip8run/window.h common/ac/stddef.h common/ac/stdio.h \
		common/ac/stdlib.h common/ac/string.h common/ac/sys/types.h \
		common/ac/time.h common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/shell.c
	mv shell.o $@

chip8run/tile.o: chip8run/ecks.h chip8run/tile.c chip8run/tile.h \
		common/ac/assert.h common/ac/string.h common/debug.h \
		common/sizeof.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/tile.c
	mv tile.o $@

chip8run/window.o: chip8run/ecks.h chip8run/tile.h chip8run/window.c \
		chip8run/window.h common/ac/stddef.h common/ac/stdlib.h \
		common/ac/string.h common/debug.h common/trace.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c chip8run/window.c
	mv window.o $@

common/ac/string.o: common/ac/stdio.h common/ac/string.c common/ac/string.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/ac/string.c
	mv string.o $@

common/arglex.o: common/ac/ctype.h common/ac/stddef.h common/ac/string.h \
		common/arglex.c common/arglex.h common/debug.h common/sizeof.h \
		common/str.h common/trace.h common/word.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/arglex.c
	mv arglex.o $@

common/fstrcmp.o: common/ac/assert.h common/ac/ctype.h common/ac/stdlib.h \
		common/ac/string.h common/debug.h common/fstrcmp.c \
		common/fstrcmp.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/fstrcmp.c
	mv fstrcmp.o $@

common/help.o: common/ac/sys/types.h common/ac/unistd.h common/arglex.h \
		common/help.c common/help.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/help.c
	mv help.o $@

common/input.o: common/ac/stdarg.h common/ac/stdio.h common/ac/stdlib.h \
		common/input.c common/input.h common/input/asc.h \
		common/input/binary.h common/input/hp.h common/input/private.h \
		common/input/unix.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input.c
	mv input.o $@

common/input/asc.o: common/ac/ctype.h common/ac/stdio.h common/ac/string.h \
		common/input.h common/input/asc.c common/input/asc.h \
		common/input/private.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input/asc.c
	mv asc.o $@

common/input/binary.o: common/ac/stdio.h common/ac/stdlib.h common/input.h \
		common/input/binary.c common/input/binary.h \
		common/input/private.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input/binary.c
	mv binary.o $@

common/input/hp.o: common/ac/ctype.h common/ac/stdio.h common/input.h \
		common/input/hp.c common/input/hp.h common/input/private.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input/hp.c
	mv hp.o $@

common/input/private.o: common/input.h common/input/private.c \
		common/input/private.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input/private.c
	mv private.o $@

common/input/unix.o: common/ac/stdio.h common/input.h common/input/private.h \
		common/input/unix.c common/input/unix.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/input/unix.c
	mv unix.o $@

common/libdir.o: common/libdir.c common/libdir.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/libdir.c
	mv libdir.o $@

common/str.o: common/ac/assert.h common/ac/ctype.h common/ac/stdarg.h \
		common/ac/stddef.h common/ac/stdio.h common/ac/stdlib.h \
		common/ac/string.h common/debug.h common/str.c common/str.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/str.c
	mv str.o $@

common/trace.o: common/ac/stdarg.h common/ac/stddef.h common/ac/stdio.h \
		common/ac/string.h common/debug.h common/str.h common/trace.c \
		common/trace.h common/word.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/trace.c
	mv trace.o $@

common/versio_stamp.o: common/patchlevel.h common/versio_stamp.c \
		common/versio_stamp.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/versio_stamp.c
	mv versio_stamp.o $@

common/version.o: common/ac/stdio.h common/arglex.h common/help.h \
		common/versio_stamp.h common/version.c common/version.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/version.c
	mv version.o $@

common/word.o: common/ac/stddef.h common/ac/stdlib.h common/ac/string.h \
		common/ac/time.h common/str.h common/word.c common/word.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -I. -c common/word.c
	mv word.o $@

$(datadir)/chip8/15puzzle.asm: .mkdir.__datadir__chip8 datadir/15puzzle.asm
	$(INSTALL_DATA) datadir/15puzzle.asm $@

$(datadir)/chip8/15puzzle.chp: .mkdir.__datadir__chip8 datadir/15puzzle.chp
	$(INSTALL_DATA) datadir/15puzzle.chp $@

$(datadir)/chip8/alien.asm: .mkdir.__datadir__chip8 datadir/alien.asm
	$(INSTALL_DATA) datadir/alien.asm $@

$(datadir)/chip8/alien.chp: .mkdir.__datadir__chip8 datadir/alien.chp
	$(INSTALL_DATA) datadir/alien.chp $@

$(datadir)/chip8/ant.asm: .mkdir.__datadir__chip8 datadir/ant.asm
	$(INSTALL_DATA) datadir/ant.asm $@

$(datadir)/chip8/ant.chp: .mkdir.__datadir__chip8 datadir/ant.chp
	$(INSTALL_DATA) datadir/ant.chp $@

$(datadir)/chip8/blinky.asm: .mkdir.__datadir__chip8 datadir/blinky.asm
	$(INSTALL_DATA) datadir/blinky.asm $@

$(datadir)/chip8/blinky.chp: .mkdir.__datadir__chip8 datadir/blinky.chp
	$(INSTALL_DATA) datadir/blinky.chp $@

$(datadir)/chip8/blitz.asm: .mkdir.__datadir__chip8 datadir/blitz.asm
	$(INSTALL_DATA) datadir/blitz.asm $@

$(datadir)/chip8/blitz.chp: .mkdir.__datadir__chip8 datadir/blitz.chp
	$(INSTALL_DATA) datadir/blitz.chp $@

$(datadir)/chip8/brix.asm: .mkdir.__datadir__chip8 datadir/brix.asm
	$(INSTALL_DATA) datadir/brix.asm $@

$(datadir)/chip8/brix.chp: .mkdir.__datadir__chip8 datadir/brix.chp
	$(INSTALL_DATA) datadir/brix.chp $@

$(datadir)/chip8/car.asm: .mkdir.__datadir__chip8 datadir/car.asm
	$(INSTALL_DATA) datadir/car.asm $@

$(datadir)/chip8/car.chp: .mkdir.__datadir__chip8 datadir/car.chp
	$(INSTALL_DATA) datadir/car.chp $@

$(datadir)/chip8/connect4.asm: .mkdir.__datadir__chip8 datadir/connect4.asm
	$(INSTALL_DATA) datadir/connect4.asm $@

$(datadir)/chip8/connect4.chp: .mkdir.__datadir__chip8 datadir/connect4.chp
	$(INSTALL_DATA) datadir/connect4.chp $@

$(datadir)/chip8/field.asm: .mkdir.__datadir__chip8 datadir/field.asm
	$(INSTALL_DATA) datadir/field.asm $@

$(datadir)/chip8/field.chp: .mkdir.__datadir__chip8 datadir/field.chp
	$(INSTALL_DATA) datadir/field.chp $@

$(datadir)/chip8/guess.asm: .mkdir.__datadir__chip8 datadir/guess.asm
	$(INSTALL_DATA) datadir/guess.asm $@

$(datadir)/chip8/guess.chp: .mkdir.__datadir__chip8 datadir/guess.chp
	$(INSTALL_DATA) datadir/guess.chp $@

$(datadir)/chip8/hidden.asm: .mkdir.__datadir__chip8 datadir/hidden.asm
	$(INSTALL_DATA) datadir/hidden.asm $@

$(datadir)/chip8/hidden.chp: .mkdir.__datadir__chip8 datadir/hidden.chp
	$(INSTALL_DATA) datadir/hidden.chp $@

$(datadir)/chip8/hpiper.asm: .mkdir.__datadir__chip8 datadir/hpiper.asm
	$(INSTALL_DATA) datadir/hpiper.asm $@

$(datadir)/chip8/hpiper.chp: .mkdir.__datadir__chip8 datadir/hpiper.chp
	$(INSTALL_DATA) datadir/hpiper.chp $@

$(datadir)/chip8/invaders.asm: .mkdir.__datadir__chip8 datadir/invaders.asm
	$(INSTALL_DATA) datadir/invaders.asm $@

$(datadir)/chip8/invaders.chp: .mkdir.__datadir__chip8 datadir/invaders.chp
	$(INSTALL_DATA) datadir/invaders.chp $@

$(datadir)/chip8/joust.asm: .mkdir.__datadir__chip8 datadir/joust.asm
	$(INSTALL_DATA) datadir/joust.asm $@

$(datadir)/chip8/joust.chp: .mkdir.__datadir__chip8 datadir/joust.chp
	$(INSTALL_DATA) datadir/joust.chp $@

$(datadir)/chip8/kaleid.asm: .mkdir.__datadir__chip8 datadir/kaleid.asm
	$(INSTALL_DATA) datadir/kaleid.asm $@

$(datadir)/chip8/kaleid.chp: .mkdir.__datadir__chip8 datadir/kaleid.chp
	$(INSTALL_DATA) datadir/kaleid.chp $@

$(datadir)/chip8/maze.asm: .mkdir.__datadir__chip8 datadir/maze.asm
	$(INSTALL_DATA) datadir/maze.asm $@

$(datadir)/chip8/maze.chp: .mkdir.__datadir__chip8 datadir/maze.chp
	$(INSTALL_DATA) datadir/maze.chp $@

$(datadir)/chip8/merlin.asm: .mkdir.__datadir__chip8 datadir/merlin.asm
	$(INSTALL_DATA) datadir/merlin.asm $@

$(datadir)/chip8/merlin.chp: .mkdir.__datadir__chip8 datadir/merlin.chp
	$(INSTALL_DATA) datadir/merlin.chp $@

$(datadir)/chip8/missile.asm: .mkdir.__datadir__chip8 datadir/missile.asm
	$(INSTALL_DATA) datadir/missile.asm $@

$(datadir)/chip8/missile.chp: .mkdir.__datadir__chip8 datadir/missile.chp
	$(INSTALL_DATA) datadir/missile.chp $@

$(datadir)/chip8/pong.asm: .mkdir.__datadir__chip8 datadir/pong.asm
	$(INSTALL_DATA) datadir/pong.asm $@

$(datadir)/chip8/pong.chp: .mkdir.__datadir__chip8 datadir/pong.chp
	$(INSTALL_DATA) datadir/pong.chp $@

$(datadir)/chip8/puzzle.asm: .mkdir.__datadir__chip8 datadir/puzzle.asm
	$(INSTALL_DATA) datadir/puzzle.asm $@

$(datadir)/chip8/puzzle.chp: .mkdir.__datadir__chip8 datadir/puzzle.chp
	$(INSTALL_DATA) datadir/puzzle.chp $@

$(datadir)/chip8/race.asm: .mkdir.__datadir__chip8 datadir/race.asm
	$(INSTALL_DATA) datadir/race.asm $@

$(datadir)/chip8/race.chp: .mkdir.__datadir__chip8 datadir/race.chp
	$(INSTALL_DATA) datadir/race.chp $@

$(datadir)/chip8/snake.asm: .mkdir.__datadir__chip8 datadir/snake.asm
	$(INSTALL_DATA) datadir/snake.asm $@

$(datadir)/chip8/snake.chp: .mkdir.__datadir__chip8 datadir/snake.chp
	$(INSTALL_DATA) datadir/snake.chp $@

$(datadir)/chip8/spacefight.asm: .mkdir.__datadir__chip8 datadir/spacefight.asm
	$(INSTALL_DATA) datadir/spacefight.asm $@

$(datadir)/chip8/spacefight.chp: .mkdir.__datadir__chip8 datadir/spacefight.chp
	$(INSTALL_DATA) datadir/spacefight.chp $@

$(datadir)/chip8/syzygy.asm: .mkdir.__datadir__chip8 datadir/syzygy.asm
	$(INSTALL_DATA) datadir/syzygy.asm $@

$(datadir)/chip8/syzygy.chp: .mkdir.__datadir__chip8 datadir/syzygy.chp
	$(INSTALL_DATA) datadir/syzygy.chp $@

$(datadir)/chip8/tank.asm: .mkdir.__datadir__chip8 datadir/tank.asm
	$(INSTALL_DATA) datadir/tank.asm $@

$(datadir)/chip8/tank.chp: .mkdir.__datadir__chip8 datadir/tank.chp
	$(INSTALL_DATA) datadir/tank.chp $@

$(datadir)/chip8/tetris.asm: .mkdir.__datadir__chip8 datadir/tetris.asm
	$(INSTALL_DATA) datadir/tetris.asm $@

$(datadir)/chip8/tetris.chp: .mkdir.__datadir__chip8 datadir/tetris.chp
	$(INSTALL_DATA) datadir/tetris.chp $@

$(datadir)/chip8/tictac.asm: .mkdir.__datadir__chip8 datadir/tictac.asm
	$(INSTALL_DATA) datadir/tictac.asm $@

$(datadir)/chip8/tictac.chp: .mkdir.__datadir__chip8 datadir/tictac.chp
	$(INSTALL_DATA) datadir/tictac.chp $@

$(datadir)/chip8/uboat.asm: .mkdir.__datadir__chip8 datadir/uboat.asm
	$(INSTALL_DATA) datadir/uboat.asm $@

$(datadir)/chip8/uboat.chp: .mkdir.__datadir__chip8 datadir/uboat.chp
	$(INSTALL_DATA) datadir/uboat.chp $@

$(datadir)/chip8/ufo.asm: .mkdir.__datadir__chip8 datadir/ufo.asm
	$(INSTALL_DATA) datadir/ufo.asm $@

$(datadir)/chip8/ufo.chp: .mkdir.__datadir__chip8 datadir/ufo.chp
	$(INSTALL_DATA) datadir/ufo.chp $@

$(datadir)/chip8/vbrix.asm: .mkdir.__datadir__chip8 datadir/vbrix.asm
	$(INSTALL_DATA) datadir/vbrix.asm $@

$(datadir)/chip8/vbrix.chp: .mkdir.__datadir__chip8 datadir/vbrix.chp
	$(INSTALL_DATA) datadir/vbrix.chp $@

$(datadir)/chip8/vers.asm: .mkdir.__datadir__chip8 datadir/vers.asm
	$(INSTALL_DATA) datadir/vers.asm $@

$(datadir)/chip8/vers.chp: .mkdir.__datadir__chip8 datadir/vers.chp
	$(INSTALL_DATA) datadir/vers.chp $@

$(datadir)/chip8/wipeoff.asm: .mkdir.__datadir__chip8 datadir/wipeoff.asm
	$(INSTALL_DATA) datadir/wipeoff.asm $@

$(datadir)/chip8/wipeoff.chp: .mkdir.__datadir__chip8 datadir/wipeoff.chp
	$(INSTALL_DATA) datadir/wipeoff.chp $@

$(datadir)/chip8/worm3.asm: .mkdir.__datadir__chip8 datadir/worm3.asm
	$(INSTALL_DATA) datadir/worm3.asm $@

$(datadir)/chip8/worm3.chp: .mkdir.__datadir__chip8 datadir/worm3.chp
	$(INSTALL_DATA) datadir/worm3.chp $@

etc/BUILDING.ps: etc/BUILDING.man etc/version.so
	$(GROFF) -Tps -s -I. -t -man etc/BUILDING.man > $@

$(datarootdir)/doc/chip8/BUILDING.ps: .mkdir.__datarootdir__doc_chip8 \
		etc/BUILDING.ps
	$(INSTALL_DATA) etc/BUILDING.ps $@

etc/Howto.conf: config.status etc/Howto.conf.in
	CONFIG_FILES=$@:etc/Howto.conf.in CONFIG_HEADERS= $(SH) config.status

etc/README.ps: etc/README.man etc/ref-games.so etc/version.so
	$(GROFF) -Tps -s -I. -t -man etc/README.man > $@

$(datarootdir)/doc/chip8/README.ps: .mkdir.__datarootdir__doc_chip8 \
		etc/README.ps
	$(INSTALL_DATA) etc/README.ps $@

etc/icon.png: etc/icon.png.uue
	uudecode -o $@ etc/icon.png.uue

etc/libdir-h: config.status etc/libdir-h.in
	CONFIG_FILES=$@:etc/libdir-h.in CONFIG_HEADERS= $(SH) config.status

etc/libdir.so: config.status etc/libdir.so.in
	CONFIG_FILES=$@:etc/libdir.so.in CONFIG_HEADERS= $(SH) config.status

etc/reference.ps: etc/BUILDING.man etc/README.man etc/ref-games.so \
		etc/ref-index.so etc/ref-parts.so etc/ref-toc.so \
		etc/reference.man etc/version.so man/man1/chip8-license.1 \
		man/man1/chip8as.1 man/man1/chip8dis.1 man/man1/chip8run.1 \
		man/man1/z_copyright.so man/man1/z_exit.so man/man5/chip8as.5 \
		man/man5/chip8run.5 man/man7/15puzzle.7 man/man7/alien.7 \
		man/man7/ant.7 man/man7/blinky.7 man/man7/blitz.7 \
		man/man7/brix.7 man/man7/car.7 man/man7/connect4.7 \
		man/man7/field.7 man/man7/guess.7 man/man7/hidden.7 \
		man/man7/hpiper.7 man/man7/invaders.7 man/man7/joust.7 \
		man/man7/kaleid.7 man/man7/maze.7 man/man7/merlin.7 \
		man/man7/missile.7 man/man7/pong.7 man/man7/puzzle.7 \
		man/man7/race.7 man/man7/snake.7 man/man7/spacefight.7 \
		man/man7/syzygy.7 man/man7/tank.7 man/man7/tetris.7 \
		man/man7/tictac.7 man/man7/uboat.7 man/man7/ufo.7 \
		man/man7/vbrix.7 man/man7/vers.7 man/man7/wipeoff.7 \
		man/man7/worm3.7
	$(GROFF) -Tps -s -I. -t -man etc/reference.man > $@

$(datarootdir)/doc/chip8/reference.ps: .mkdir.__datarootdir__doc_chip8 \
		etc/reference.ps
	$(INSTALL_DATA) etc/reference.ps $@

man/cat1/chip8-license.1: man/man1/chip8-license.1
	@mkdir -p man/cat1
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man \
		man/man1/chip8-license.1 > $@

$(mandir)/man1/chip8-license.1: .mkdir.__mandir__man1 man/man1/chip8-license.1
	sed '/^[.]XX ./d' < man/man1/chip8-license.1 > \
		man/man1/chip8-license.1.tmp
	$(INSTALL_DATA) man/man1/chip8-license.1.tmp $@
	@rm -f man/man1/chip8-license.1.tmp

man/cat1/chip8as.1: etc/version.so man/man1/chip8as.1 man/man1/z_copyright.so \
		man/man1/z_exit.so
	@mkdir -p man/cat1
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man1/chip8as.1 > \
		$@

$(mandir)/man1/chip8as.1: .mkdir.__mandir__man1 etc/version.so \
		man/man1/chip8as.1 man/man1/z_copyright.so man/man1/z_exit.so
	$(SOELIM) -I. man/man1/chip8as.1 | sed '/^[.]XX ./d' > \
		man/man1/chip8as.1.tmp
	$(INSTALL_DATA) man/man1/chip8as.1.tmp $@
	@rm -f man/man1/chip8as.1.tmp

man/cat1/chip8dis.1: etc/version.so man/man1/chip8dis.1 \
		man/man1/z_copyright.so man/man1/z_exit.so
	@mkdir -p man/cat1
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man1/chip8dis.1 \
		> $@

$(mandir)/man1/chip8dis.1: .mkdir.__mandir__man1 etc/version.so \
		man/man1/chip8dis.1 man/man1/z_copyright.so man/man1/z_exit.so
	$(SOELIM) -I. man/man1/chip8dis.1 | sed '/^[.]XX ./d' > \
		man/man1/chip8dis.1.tmp
	$(INSTALL_DATA) man/man1/chip8dis.1.tmp $@
	@rm -f man/man1/chip8dis.1.tmp

man/cat1/chip8run.1: etc/version.so man/man1/chip8run.1 \
		man/man1/z_copyright.so man/man1/z_exit.so
	@mkdir -p man/cat1
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man1/chip8run.1 \
		> $@

$(mandir)/man1/chip8run.1: .mkdir.__mandir__man1 etc/version.so \
		man/man1/chip8run.1 man/man1/z_copyright.so man/man1/z_exit.so
	$(SOELIM) -I. man/man1/chip8run.1 | sed '/^[.]XX ./d' > \
		man/man1/chip8run.1.tmp
	$(INSTALL_DATA) man/man1/chip8run.1.tmp $@
	@rm -f man/man1/chip8run.1.tmp

man/cat5/chip8as.5: etc/version.so man/man1/z_copyright.so man/man5/chip8as.5
	@mkdir -p man/cat5
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man5/chip8as.5 > \
		$@

$(mandir)/man5/chip8as.5: .mkdir.__mandir__man5 etc/version.so \
		man/man1/z_copyright.so man/man5/chip8as.5
	$(SOELIM) -I. man/man5/chip8as.5 | sed '/^[.]XX ./d' > \
		man/man5/chip8as.5.tmp
	$(INSTALL_DATA) man/man5/chip8as.5.tmp $@
	@rm -f man/man5/chip8as.5.tmp

man/cat5/chip8run.5: etc/version.so man/man1/z_copyright.so man/man5/chip8run.5
	@mkdir -p man/cat5
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man5/chip8run.5 \
		> $@

$(mandir)/man5/chip8run.5: .mkdir.__mandir__man5 etc/version.so \
		man/man1/z_copyright.so man/man5/chip8run.5
	$(SOELIM) -I. man/man5/chip8run.5 | sed '/^[.]XX ./d' > \
		man/man5/chip8run.5.tmp
	$(INSTALL_DATA) man/man5/chip8run.5.tmp $@
	@rm -f man/man5/chip8run.5.tmp

man/cat7/15puzzle.7: man/man7/15puzzle.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/15puzzle.7 \
		> $@

$(mandir)/man7/15puzzle.7: .mkdir.__mandir__man7 man/man7/15puzzle.7
	sed '/^[.]XX ./d' < man/man7/15puzzle.7 > man/man7/15puzzle.7.tmp
	$(INSTALL_DATA) man/man7/15puzzle.7.tmp $@
	@rm -f man/man7/15puzzle.7.tmp

man/cat7/alien.7: man/man7/alien.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/alien.7 > $@

$(mandir)/man7/alien.7: .mkdir.__mandir__man7 man/man7/alien.7
	sed '/^[.]XX ./d' < man/man7/alien.7 > man/man7/alien.7.tmp
	$(INSTALL_DATA) man/man7/alien.7.tmp $@
	@rm -f man/man7/alien.7.tmp

man/cat7/ant.7: man/man7/ant.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/ant.7 > $@

$(mandir)/man7/ant.7: .mkdir.__mandir__man7 man/man7/ant.7
	sed '/^[.]XX ./d' < man/man7/ant.7 > man/man7/ant.7.tmp
	$(INSTALL_DATA) man/man7/ant.7.tmp $@
	@rm -f man/man7/ant.7.tmp

man/cat7/blinky.7: man/man7/blinky.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/blinky.7 > $@

$(mandir)/man7/blinky.7: .mkdir.__mandir__man7 man/man7/blinky.7
	sed '/^[.]XX ./d' < man/man7/blinky.7 > man/man7/blinky.7.tmp
	$(INSTALL_DATA) man/man7/blinky.7.tmp $@
	@rm -f man/man7/blinky.7.tmp

man/cat7/blitz.7: man/man7/blitz.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/blitz.7 > $@

$(mandir)/man7/blitz.7: .mkdir.__mandir__man7 man/man7/blitz.7
	sed '/^[.]XX ./d' < man/man7/blitz.7 > man/man7/blitz.7.tmp
	$(INSTALL_DATA) man/man7/blitz.7.tmp $@
	@rm -f man/man7/blitz.7.tmp

man/cat7/brix.7: man/man7/brix.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/brix.7 > $@

$(mandir)/man7/brix.7: .mkdir.__mandir__man7 man/man7/brix.7
	sed '/^[.]XX ./d' < man/man7/brix.7 > man/man7/brix.7.tmp
	$(INSTALL_DATA) man/man7/brix.7.tmp $@
	@rm -f man/man7/brix.7.tmp

man/cat7/car.7: man/man7/car.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/car.7 > $@

$(mandir)/man7/car.7: .mkdir.__mandir__man7 man/man7/car.7
	sed '/^[.]XX ./d' < man/man7/car.7 > man/man7/car.7.tmp
	$(INSTALL_DATA) man/man7/car.7.tmp $@
	@rm -f man/man7/car.7.tmp

man/cat7/connect4.7: man/man7/connect4.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/connect4.7 \
		> $@

$(mandir)/man7/connect4.7: .mkdir.__mandir__man7 man/man7/connect4.7
	sed '/^[.]XX ./d' < man/man7/connect4.7 > man/man7/connect4.7.tmp
	$(INSTALL_DATA) man/man7/connect4.7.tmp $@
	@rm -f man/man7/connect4.7.tmp

man/cat7/field.7: man/man7/field.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/field.7 > $@

$(mandir)/man7/field.7: .mkdir.__mandir__man7 man/man7/field.7
	sed '/^[.]XX ./d' < man/man7/field.7 > man/man7/field.7.tmp
	$(INSTALL_DATA) man/man7/field.7.tmp $@
	@rm -f man/man7/field.7.tmp

man/cat7/guess.7: man/man7/guess.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/guess.7 > $@

$(mandir)/man7/guess.7: .mkdir.__mandir__man7 man/man7/guess.7
	sed '/^[.]XX ./d' < man/man7/guess.7 > man/man7/guess.7.tmp
	$(INSTALL_DATA) man/man7/guess.7.tmp $@
	@rm -f man/man7/guess.7.tmp

man/cat7/hidden.7: man/man7/hidden.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/hidden.7 > $@

$(mandir)/man7/hidden.7: .mkdir.__mandir__man7 man/man7/hidden.7
	sed '/^[.]XX ./d' < man/man7/hidden.7 > man/man7/hidden.7.tmp
	$(INSTALL_DATA) man/man7/hidden.7.tmp $@
	@rm -f man/man7/hidden.7.tmp

man/cat7/hpiper.7: man/man7/hpiper.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/hpiper.7 > $@

$(mandir)/man7/hpiper.7: .mkdir.__mandir__man7 man/man7/hpiper.7
	sed '/^[.]XX ./d' < man/man7/hpiper.7 > man/man7/hpiper.7.tmp
	$(INSTALL_DATA) man/man7/hpiper.7.tmp $@
	@rm -f man/man7/hpiper.7.tmp

man/cat7/invaders.7: man/man7/invaders.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/invaders.7 \
		> $@

$(mandir)/man7/invaders.7: .mkdir.__mandir__man7 man/man7/invaders.7
	sed '/^[.]XX ./d' < man/man7/invaders.7 > man/man7/invaders.7.tmp
	$(INSTALL_DATA) man/man7/invaders.7.tmp $@
	@rm -f man/man7/invaders.7.tmp

man/cat7/joust.7: man/man7/joust.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/joust.7 > $@

$(mandir)/man7/joust.7: .mkdir.__mandir__man7 man/man7/joust.7
	sed '/^[.]XX ./d' < man/man7/joust.7 > man/man7/joust.7.tmp
	$(INSTALL_DATA) man/man7/joust.7.tmp $@
	@rm -f man/man7/joust.7.tmp

man/cat7/kaleid.7: man/man7/kaleid.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/kaleid.7 > $@

$(mandir)/man7/kaleid.7: .mkdir.__mandir__man7 man/man7/kaleid.7
	sed '/^[.]XX ./d' < man/man7/kaleid.7 > man/man7/kaleid.7.tmp
	$(INSTALL_DATA) man/man7/kaleid.7.tmp $@
	@rm -f man/man7/kaleid.7.tmp

man/cat7/maze.7: man/man7/maze.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/maze.7 > $@

$(mandir)/man7/maze.7: .mkdir.__mandir__man7 man/man7/maze.7
	sed '/^[.]XX ./d' < man/man7/maze.7 > man/man7/maze.7.tmp
	$(INSTALL_DATA) man/man7/maze.7.tmp $@
	@rm -f man/man7/maze.7.tmp

man/cat7/merlin.7: man/man7/merlin.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/merlin.7 > $@

$(mandir)/man7/merlin.7: .mkdir.__mandir__man7 man/man7/merlin.7
	sed '/^[.]XX ./d' < man/man7/merlin.7 > man/man7/merlin.7.tmp
	$(INSTALL_DATA) man/man7/merlin.7.tmp $@
	@rm -f man/man7/merlin.7.tmp

man/cat7/missile.7: man/man7/missile.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/missile.7 > \
		$@

$(mandir)/man7/missile.7: .mkdir.__mandir__man7 man/man7/missile.7
	sed '/^[.]XX ./d' < man/man7/missile.7 > man/man7/missile.7.tmp
	$(INSTALL_DATA) man/man7/missile.7.tmp $@
	@rm -f man/man7/missile.7.tmp

man/cat7/pong.7: man/man7/pong.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/pong.7 > $@

$(mandir)/man7/pong.7: .mkdir.__mandir__man7 man/man7/pong.7
	sed '/^[.]XX ./d' < man/man7/pong.7 > man/man7/pong.7.tmp
	$(INSTALL_DATA) man/man7/pong.7.tmp $@
	@rm -f man/man7/pong.7.tmp

man/cat7/puzzle.7: man/man7/puzzle.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/puzzle.7 > $@

$(mandir)/man7/puzzle.7: .mkdir.__mandir__man7 man/man7/puzzle.7
	sed '/^[.]XX ./d' < man/man7/puzzle.7 > man/man7/puzzle.7.tmp
	$(INSTALL_DATA) man/man7/puzzle.7.tmp $@
	@rm -f man/man7/puzzle.7.tmp

man/cat7/race.7: man/man7/race.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/race.7 > $@

$(mandir)/man7/race.7: .mkdir.__mandir__man7 man/man7/race.7
	sed '/^[.]XX ./d' < man/man7/race.7 > man/man7/race.7.tmp
	$(INSTALL_DATA) man/man7/race.7.tmp $@
	@rm -f man/man7/race.7.tmp

man/cat7/snake.7: etc/version.so man/man1/z_copyright.so man/man7/snake.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/snake.7 > $@

$(mandir)/man7/snake.7: .mkdir.__mandir__man7 etc/version.so \
		man/man1/z_copyright.so man/man7/snake.7
	$(SOELIM) -I. man/man7/snake.7 | sed '/^[.]XX ./d' > \
		man/man7/snake.7.tmp
	$(INSTALL_DATA) man/man7/snake.7.tmp $@
	@rm -f man/man7/snake.7.tmp

man/cat7/spacefight.7: man/man7/spacefight.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man \
		man/man7/spacefight.7 > $@

$(mandir)/man7/spacefight.7: .mkdir.__mandir__man7 man/man7/spacefight.7
	sed '/^[.]XX ./d' < man/man7/spacefight.7 > man/man7/spacefight.7.tmp
	$(INSTALL_DATA) man/man7/spacefight.7.tmp $@
	@rm -f man/man7/spacefight.7.tmp

man/cat7/syzygy.7: man/man7/syzygy.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/syzygy.7 > $@

$(mandir)/man7/syzygy.7: .mkdir.__mandir__man7 man/man7/syzygy.7
	sed '/^[.]XX ./d' < man/man7/syzygy.7 > man/man7/syzygy.7.tmp
	$(INSTALL_DATA) man/man7/syzygy.7.tmp $@
	@rm -f man/man7/syzygy.7.tmp

man/cat7/tank.7: man/man7/tank.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/tank.7 > $@

$(mandir)/man7/tank.7: .mkdir.__mandir__man7 man/man7/tank.7
	sed '/^[.]XX ./d' < man/man7/tank.7 > man/man7/tank.7.tmp
	$(INSTALL_DATA) man/man7/tank.7.tmp $@
	@rm -f man/man7/tank.7.tmp

man/cat7/tetris.7: man/man7/tetris.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/tetris.7 > $@

$(mandir)/man7/tetris.7: .mkdir.__mandir__man7 man/man7/tetris.7
	sed '/^[.]XX ./d' < man/man7/tetris.7 > man/man7/tetris.7.tmp
	$(INSTALL_DATA) man/man7/tetris.7.tmp $@
	@rm -f man/man7/tetris.7.tmp

man/cat7/tictac.7: man/man7/tictac.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/tictac.7 > $@

$(mandir)/man7/tictac.7: .mkdir.__mandir__man7 man/man7/tictac.7
	sed '/^[.]XX ./d' < man/man7/tictac.7 > man/man7/tictac.7.tmp
	$(INSTALL_DATA) man/man7/tictac.7.tmp $@
	@rm -f man/man7/tictac.7.tmp

man/cat7/uboat.7: man/man7/uboat.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/uboat.7 > $@

$(mandir)/man7/uboat.7: .mkdir.__mandir__man7 man/man7/uboat.7
	sed '/^[.]XX ./d' < man/man7/uboat.7 > man/man7/uboat.7.tmp
	$(INSTALL_DATA) man/man7/uboat.7.tmp $@
	@rm -f man/man7/uboat.7.tmp

man/cat7/ufo.7: man/man7/ufo.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/ufo.7 > $@

$(mandir)/man7/ufo.7: .mkdir.__mandir__man7 man/man7/ufo.7
	sed '/^[.]XX ./d' < man/man7/ufo.7 > man/man7/ufo.7.tmp
	$(INSTALL_DATA) man/man7/ufo.7.tmp $@
	@rm -f man/man7/ufo.7.tmp

man/cat7/vbrix.7: man/man7/vbrix.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/vbrix.7 > $@

$(mandir)/man7/vbrix.7: .mkdir.__mandir__man7 man/man7/vbrix.7
	sed '/^[.]XX ./d' < man/man7/vbrix.7 > man/man7/vbrix.7.tmp
	$(INSTALL_DATA) man/man7/vbrix.7.tmp $@
	@rm -f man/man7/vbrix.7.tmp

man/cat7/vers.7: man/man7/vers.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/vers.7 > $@

$(mandir)/man7/vers.7: .mkdir.__mandir__man7 man/man7/vers.7
	sed '/^[.]XX ./d' < man/man7/vers.7 > man/man7/vers.7.tmp
	$(INSTALL_DATA) man/man7/vers.7.tmp $@
	@rm -f man/man7/vers.7.tmp

man/cat7/wipeoff.7: man/man7/wipeoff.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/wipeoff.7 > \
		$@

$(mandir)/man7/wipeoff.7: .mkdir.__mandir__man7 man/man7/wipeoff.7
	sed '/^[.]XX ./d' < man/man7/wipeoff.7 > man/man7/wipeoff.7.tmp
	$(INSTALL_DATA) man/man7/wipeoff.7.tmp $@
	@rm -f man/man7/wipeoff.7.tmp

man/cat7/worm3.7: man/man7/worm3.7
	@mkdir -p man/cat7
	GROFF_NO_SGR=-c $(GROFF) -I. -Tascii -P-h -t -man man/man7/worm3.7 > $@

$(mandir)/man7/worm3.7: .mkdir.__mandir__man7 man/man7/worm3.7
	sed '/^[.]XX ./d' < man/man7/worm3.7 > man/man7/worm3.7.tmp
	$(INSTALL_DATA) man/man7/worm3.7.tmp $@
	@rm -f man/man7/worm3.7.tmp

bin/test_prelude: .bin script/test_prelude.sh
	cp script/test_prelude.sh $@
	chmod a+rx $@

$(bindir)/test_prelude: .mkdir.__bindir_ bin/test_prelude
	$(INSTALL_SCRIPT) bin/test_prelude $@

t0001a: all-bin test/00/t0001a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0001a.sh

t0002a: all-bin test/00/t0002a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0002a.sh

t0003a: all-bin test/00/t0003a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0003a.sh

t0004a: all-bin test/00/t0004a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0004a.sh

t0005a: all-bin test/00/t0005a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0005a.sh

t0006a: all-bin test/00/t0006a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0006a.sh

t0007a: all-bin test/00/t0007a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0007a.sh

t0008a: all-bin test/00/t0008a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0008a.sh

t0009a: all-bin test/00/t0009a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0009a.sh

t0010a: all-bin test/00/t0010a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0010a.sh

t0011a: all-bin test/00/t0011a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0011a.sh

t0012a: all-bin test/00/t0012a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0012a.sh

t0013a: all-bin test/00/t0013a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0013a.sh

t0014a: all-bin test/00/t0014a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0014a.sh

t0015a: all-bin test/00/t0015a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0015a.sh

t0016a: all-bin test/00/t0016a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0016a.sh

t0017a: all-bin test/00/t0017a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0017a.sh

t0018a: all-bin test/00/t0018a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0018a.sh

t0019a: all-bin test/00/t0019a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0019a.sh

t0020a: all-bin test/00/t0020a.sh
	PATH=`pwd`/bin:$$PATH $(SH) test/00/t0020a.sh

#
# The common/libcommon.a library.
#
common_obj = common/ac/string.o common/arglex.o common/fstrcmp.o common/help.o \
		common/input.o common/input/asc.o common/input/binary.o \
		common/input/hp.o common/input/private.o common/input/unix.o \
		common/libdir.o common/str.o common/trace.o \
		common/versio_stamp.o common/version.o common/word.o

common/libcommon.a: $(common_obj)
	rm -f $@
	$(AR) qc $@ $(common_obj)
	$(RANLIB) $@

.mkdir.__bindir_:
	-$(INSTALL_DIR) $(bindir)
	@-test -d $(bindir) && touch $@
	@sleep 1

.mkdir.__datadir_:
	-$(INSTALL_DIR) $(datadir)
	@-test -d $(datadir) && touch $@
	@sleep 1

.mkdir.__datadir__chip8: .mkdir.__datadir_
	-$(INSTALL_DIR) $(datadir)/chip8
	@-test -d $(datadir)/chip8 && touch $@
	@sleep 1

.mkdir.__datarootdir_:
	-$(INSTALL_DIR) $(datarootdir)
	@-test -d $(datarootdir) && touch $@
	@sleep 1

.mkdir.__datarootdir__doc: .mkdir.__datarootdir_
	-$(INSTALL_DIR) $(datarootdir)/doc
	@-test -d $(datarootdir)/doc && touch $@
	@sleep 1

.mkdir.__datarootdir__doc_chip8: .mkdir.__datarootdir__doc
	-$(INSTALL_DIR) $(datarootdir)/doc/chip8
	@-test -d $(datarootdir)/doc/chip8 && touch $@
	@sleep 1

.mkdir.__mandir_:
	-$(INSTALL_DIR) $(mandir)
	@-test -d $(mandir) && touch $@
	@sleep 1

.mkdir.__mandir__man1: .mkdir.__mandir_
	-$(INSTALL_DIR) $(mandir)/man1
	@-test -d $(mandir)/man1 && touch $@
	@sleep 1

.mkdir.__mandir__man5: .mkdir.__mandir_
	-$(INSTALL_DIR) $(mandir)/man5
	@-test -d $(mandir)/man5 && touch $@
	@sleep 1

.mkdir.__mandir__man7: .mkdir.__mandir_
	-$(INSTALL_DIR) $(mandir)/man7
	@-test -d $(mandir)/man7 && touch $@
	@sleep 1

#
# The chip8as program.
#
chip8as_obj = chip8as/as.o chip8as/col.o chip8as/conditional.o \
		chip8as/cross_refer.o chip8as/emit.o chip8as/expr.o \
		chip8as/id.o chip8as/ilist.o chip8as/lex.o chip8as/main.o \
		chip8as/option.o chip8as/output.o chip8as/output/asc.o \
		chip8as/output/c.o chip8as/output/hp.o \
		chip8as/output/private.o chip8as/output/raw.o \
		chip8as/output/unix.o

bin/chip8as: $(chip8as_obj) .bin common/libcommon.a
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(chip8as_obj) common/libcommon.a \
		$(LDFLAGS) $(LIBS)

$(bindir)/chip8as: .mkdir.__bindir_ bin/chip8as
	$(INSTALL_PROGRAM) bin/chip8as $@

#
# The chip8dis program.
#
chip8dis_obj = chip8dis/dis.o chip8dis/main.o

bin/chip8dis: $(chip8dis_obj) .bin common/libcommon.a
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(chip8dis_obj) common/libcommon.a \
		$(LDFLAGS) $(LIBS)

$(bindir)/chip8dis: .mkdir.__bindir_ bin/chip8dis
	$(INSTALL_PROGRAM) bin/chip8dis $@

#
# The chip8run program.
#
chip8run_obj = chip8run/arena.o chip8run/arglex2.o chip8run/autotest.o \
		chip8run/button.o chip8run/chip8.o chip8run/debug.o \
		chip8run/ecks.o chip8run/event.o chip8run/machine.o \
		chip8run/main.o chip8run/option.o chip8run/shell.o \
		chip8run/tile.o chip8run/window.o

bin/chip8run: $(chip8run_obj) .bin common/libcommon.a
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(chip8run_obj) common/libcommon.a \
		$(LDFLAGS) $(LIBS)

$(bindir)/chip8run: .mkdir.__bindir_ bin/chip8run
	$(INSTALL_PROGRAM) bin/chip8run $@

all: all-bin all-doc

all-bin: bin/chip8as bin/chip8dis bin/chip8run bin/test_prelude

all-doc: etc/BUILDING.ps etc/README.ps etc/reference.ps \
		man/cat1/chip8-license.1 man/cat1/chip8as.1 \
		man/cat1/chip8dis.1 man/cat1/chip8run.1 man/cat5/chip8as.5 \
		man/cat5/chip8run.5 man/cat7/15puzzle.7 man/cat7/alien.7 \
		man/cat7/ant.7 man/cat7/blinky.7 man/cat7/blitz.7 \
		man/cat7/brix.7 man/cat7/car.7 man/cat7/connect4.7 \
		man/cat7/field.7 man/cat7/guess.7 man/cat7/hidden.7 \
		man/cat7/hpiper.7 man/cat7/invaders.7 man/cat7/joust.7 \
		man/cat7/kaleid.7 man/cat7/maze.7 man/cat7/merlin.7 \
		man/cat7/missile.7 man/cat7/pong.7 man/cat7/puzzle.7 \
		man/cat7/race.7 man/cat7/snake.7 man/cat7/spacefight.7 \
		man/cat7/syzygy.7 man/cat7/tank.7 man/cat7/tetris.7 \
		man/cat7/tictac.7 man/cat7/uboat.7 man/cat7/ufo.7 \
		man/cat7/vbrix.7 man/cat7/vers.7 man/cat7/wipeoff.7 \
		man/cat7/worm3.7

.bin:
	-mkdir bin
	-chmod 0755 bin
	@-test -d bin && touch $@
	@sleep 1

check: sure

test_files = t0001a t0002a t0003a t0004a t0005a t0006a t0007a t0008a t0009a \
		t0010a t0011a t0012a t0013a t0014a t0015a t0016a t0017a t0018a \
		t0019a t0020a

sure: $(test_files)
	@echo Passed All Tests

clean: clean-bin clean-doc clean-misc clean-obj

clean-bin:
	rm -f bin/chip8as bin/chip8dis bin/chip8run bin/test_prelude

clean-doc:
	rm -f etc/BUILDING.ps etc/README.ps etc/reference.ps
	rm -f man/cat1/chip8-license.1 man/cat1/chip8as.1 man/cat1/chip8dis.1
	rm -f man/cat1/chip8run.1 man/cat5/chip8as.5 man/cat5/chip8run.5
	rm -f man/cat7/15puzzle.7 man/cat7/alien.7 man/cat7/ant.7
	rm -f man/cat7/blinky.7 man/cat7/blitz.7 man/cat7/brix.7 man/cat7/car.7
	rm -f man/cat7/connect4.7 man/cat7/field.7 man/cat7/guess.7
	rm -f man/cat7/hidden.7 man/cat7/hpiper.7 man/cat7/invaders.7
	rm -f man/cat7/joust.7 man/cat7/kaleid.7 man/cat7/maze.7
	rm -f man/cat7/merlin.7 man/cat7/missile.7 man/cat7/pong.7
	rm -f man/cat7/puzzle.7 man/cat7/race.7 man/cat7/snake.7
	rm -f man/cat7/spacefight.7 man/cat7/syzygy.7 man/cat7/tank.7
	rm -f man/cat7/tetris.7 man/cat7/tictac.7 man/cat7/uboat.7
	rm -f man/cat7/ufo.7 man/cat7/vbrix.7 man/cat7/vers.7 man/cat7/wipeoff.7
	rm -f man/cat7/worm3.7

clean-misc:
	rm -f .bin .mkdir.__bindir_ .mkdir.__datadir_ .mkdir.__datadir__chip8
	rm -f .mkdir.__datarootdir_ .mkdir.__datarootdir__doc
	rm -f .mkdir.__datarootdir__doc_chip8 .mkdir.__mandir_
	rm -f .mkdir.__mandir__man1 .mkdir.__mandir__man5 .mkdir.__mandir__man7
	rm -f core etc/BUILDING.ps etc/README.ps etc/icon.png etc/reference.ps

clean-obj:
	rm -f chip8as/as.o chip8as/col.o chip8as/conditional.o
	rm -f chip8as/cross_refer.o chip8as/emit.o chip8as/expr.o chip8as/id.o
	rm -f chip8as/ilist.o chip8as/lex.o chip8as/main.o chip8as/option.o
	rm -f chip8as/output.o chip8as/output/asc.o chip8as/output/c.o
	rm -f chip8as/output/hp.o chip8as/output/private.o chip8as/output/raw.o
	rm -f chip8as/output/unix.o chip8dis/dis.o chip8dis/main.o
	rm -f chip8run/arena.o chip8run/arglex2.o chip8run/autotest.o
	rm -f chip8run/button.o chip8run/chip8.o chip8run/debug.o
	rm -f chip8run/ecks.o chip8run/event.o chip8run/machine.o
	rm -f chip8run/main.o chip8run/option.o chip8run/shell.o chip8run/tile.o
	rm -f chip8run/window.o common/ac/string.o common/arglex.o
	rm -f common/fstrcmp.o common/help.o common/input.o common/input/asc.o
	rm -f common/input/binary.o common/input/hp.o common/input/private.o
	rm -f common/input/unix.o common/libcommon.a common/libdir.o
	rm -f common/str.o common/trace.o common/versio_stamp.o common/version.o
	rm -f common/word.o

distclean: clean distclean-directories distclean-files

distclean-files:
	rm -f Makefile common/config.h config.cache config.log config.status
	rm -f etc/Howto.conf etc/libdir-h etc/libdir.so

distclean-directories:
	rm -rf bin

install: install-bin install-datadir install-doc install-man

install-bin: $(bindir)/chip8as $(bindir)/chip8dis $(bindir)/chip8run \
		$(bindir)/test_prelude

install-datadir: $(datadir)/chip8/15puzzle.asm $(datadir)/chip8/15puzzle.chp \
		$(datadir)/chip8/alien.asm $(datadir)/chip8/alien.chp \
		$(datadir)/chip8/ant.asm $(datadir)/chip8/ant.chp \
		$(datadir)/chip8/blinky.asm $(datadir)/chip8/blinky.chp \
		$(datadir)/chip8/blitz.asm $(datadir)/chip8/blitz.chp \
		$(datadir)/chip8/brix.asm $(datadir)/chip8/brix.chp \
		$(datadir)/chip8/car.asm $(datadir)/chip8/car.chp \
		$(datadir)/chip8/connect4.asm $(datadir)/chip8/connect4.chp \
		$(datadir)/chip8/field.asm $(datadir)/chip8/field.chp \
		$(datadir)/chip8/guess.asm $(datadir)/chip8/guess.chp \
		$(datadir)/chip8/hidden.asm $(datadir)/chip8/hidden.chp \
		$(datadir)/chip8/hpiper.asm $(datadir)/chip8/hpiper.chp \
		$(datadir)/chip8/invaders.asm $(datadir)/chip8/invaders.chp \
		$(datadir)/chip8/joust.asm $(datadir)/chip8/joust.chp \
		$(datadir)/chip8/kaleid.asm $(datadir)/chip8/kaleid.chp \
		$(datadir)/chip8/maze.asm $(datadir)/chip8/maze.chp \
		$(datadir)/chip8/merlin.asm $(datadir)/chip8/merlin.chp \
		$(datadir)/chip8/missile.asm $(datadir)/chip8/missile.chp \
		$(datadir)/chip8/pong.asm $(datadir)/chip8/pong.chp \
		$(datadir)/chip8/puzzle.asm $(datadir)/chip8/puzzle.chp \
		$(datadir)/chip8/race.asm $(datadir)/chip8/race.chp \
		$(datadir)/chip8/snake.asm $(datadir)/chip8/snake.chp \
		$(datadir)/chip8/spacefight.asm \
		$(datadir)/chip8/spacefight.chp $(datadir)/chip8/syzygy.asm \
		$(datadir)/chip8/syzygy.chp $(datadir)/chip8/tank.asm \
		$(datadir)/chip8/tank.chp $(datadir)/chip8/tetris.asm \
		$(datadir)/chip8/tetris.chp $(datadir)/chip8/tictac.asm \
		$(datadir)/chip8/tictac.chp $(datadir)/chip8/uboat.asm \
		$(datadir)/chip8/uboat.chp $(datadir)/chip8/ufo.asm \
		$(datadir)/chip8/ufo.chp $(datadir)/chip8/vbrix.asm \
		$(datadir)/chip8/vbrix.chp $(datadir)/chip8/vers.asm \
		$(datadir)/chip8/vers.chp $(datadir)/chip8/wipeoff.asm \
		$(datadir)/chip8/wipeoff.chp $(datadir)/chip8/worm3.asm \
		$(datadir)/chip8/worm3.chp

install-doc: $(datarootdir)/doc/chip8/BUILDING.ps \
		$(datarootdir)/doc/chip8/README.ps \
		$(datarootdir)/doc/chip8/reference.ps

install-man: $(mandir)/man1/chip8-license.1 $(mandir)/man1/chip8as.1 \
		$(mandir)/man1/chip8dis.1 $(mandir)/man1/chip8run.1 \
		$(mandir)/man5/chip8as.5 $(mandir)/man5/chip8run.5 \
		$(mandir)/man7/15puzzle.7 $(mandir)/man7/alien.7 \
		$(mandir)/man7/ant.7 $(mandir)/man7/blinky.7 \
		$(mandir)/man7/blitz.7 $(mandir)/man7/brix.7 \
		$(mandir)/man7/car.7 $(mandir)/man7/connect4.7 \
		$(mandir)/man7/field.7 $(mandir)/man7/guess.7 \
		$(mandir)/man7/hidden.7 $(mandir)/man7/hpiper.7 \
		$(mandir)/man7/invaders.7 $(mandir)/man7/joust.7 \
		$(mandir)/man7/kaleid.7 $(mandir)/man7/maze.7 \
		$(mandir)/man7/merlin.7 $(mandir)/man7/missile.7 \
		$(mandir)/man7/pong.7 $(mandir)/man7/puzzle.7 \
		$(mandir)/man7/race.7 $(mandir)/man7/snake.7 \
		$(mandir)/man7/spacefight.7 $(mandir)/man7/syzygy.7 \
		$(mandir)/man7/tank.7 $(mandir)/man7/tetris.7 \
		$(mandir)/man7/tictac.7 $(mandir)/man7/uboat.7 \
		$(mandir)/man7/ufo.7 $(mandir)/man7/vbrix.7 \
		$(mandir)/man7/vers.7 $(mandir)/man7/wipeoff.7 \
		$(mandir)/man7/worm3.7

uninstall:
	rm -f $(bindir)/chip8as $(bindir)/chip8dis $(bindir)/chip8run
	rm -f $(bindir)/test_prelude $(datadir)/chip8/15puzzle.asm
	rm -f $(datadir)/chip8/15puzzle.chp $(datadir)/chip8/alien.asm
	rm -f $(datadir)/chip8/alien.chp $(datadir)/chip8/ant.asm
	rm -f $(datadir)/chip8/ant.chp $(datadir)/chip8/blinky.asm
	rm -f $(datadir)/chip8/blinky.chp $(datadir)/chip8/blitz.asm
	rm -f $(datadir)/chip8/blitz.chp $(datadir)/chip8/brix.asm
	rm -f $(datadir)/chip8/brix.chp $(datadir)/chip8/car.asm
	rm -f $(datadir)/chip8/car.chp $(datadir)/chip8/connect4.asm
	rm -f $(datadir)/chip8/connect4.chp $(datadir)/chip8/field.asm
	rm -f $(datadir)/chip8/field.chp $(datadir)/chip8/guess.asm
	rm -f $(datadir)/chip8/guess.chp $(datadir)/chip8/hidden.asm
	rm -f $(datadir)/chip8/hidden.chp $(datadir)/chip8/hpiper.asm
	rm -f $(datadir)/chip8/hpiper.chp $(datadir)/chip8/invaders.asm
	rm -f $(datadir)/chip8/invaders.chp $(datadir)/chip8/joust.asm
	rm -f $(datadir)/chip8/joust.chp $(datadir)/chip8/kaleid.asm
	rm -f $(datadir)/chip8/kaleid.chp $(datadir)/chip8/maze.asm
	rm -f $(datadir)/chip8/maze.chp $(datadir)/chip8/merlin.asm
	rm -f $(datadir)/chip8/merlin.chp $(datadir)/chip8/missile.asm
	rm -f $(datadir)/chip8/missile.chp $(datadir)/chip8/pong.asm
	rm -f $(datadir)/chip8/pong.chp $(datadir)/chip8/puzzle.asm
	rm -f $(datadir)/chip8/puzzle.chp $(datadir)/chip8/race.asm
	rm -f $(datadir)/chip8/race.chp $(datadir)/chip8/snake.asm
	rm -f $(datadir)/chip8/snake.chp $(datadir)/chip8/spacefight.asm
	rm -f $(datadir)/chip8/spacefight.chp $(datadir)/chip8/syzygy.asm
	rm -f $(datadir)/chip8/syzygy.chp $(datadir)/chip8/tank.asm
	rm -f $(datadir)/chip8/tank.chp $(datadir)/chip8/tetris.asm
	rm -f $(datadir)/chip8/tetris.chp $(datadir)/chip8/tictac.asm
	rm -f $(datadir)/chip8/tictac.chp $(datadir)/chip8/uboat.asm
	rm -f $(datadir)/chip8/uboat.chp $(datadir)/chip8/ufo.asm
	rm -f $(datadir)/chip8/ufo.chp $(datadir)/chip8/vbrix.asm
	rm -f $(datadir)/chip8/vbrix.chp $(datadir)/chip8/vers.asm
	rm -f $(datadir)/chip8/vers.chp $(datadir)/chip8/wipeoff.asm
	rm -f $(datadir)/chip8/wipeoff.chp $(datadir)/chip8/worm3.asm
	rm -f $(datadir)/chip8/worm3.chp $(datarootdir)/doc/chip8/BUILDING.ps
	rm -f $(datarootdir)/doc/chip8/README.ps
	rm -f $(datarootdir)/doc/chip8/reference.ps
	rm -f $(mandir)/man1/chip8-license.1 $(mandir)/man1/chip8as.1
	rm -f $(mandir)/man1/chip8dis.1 $(mandir)/man1/chip8run.1
	rm -f $(mandir)/man5/chip8as.5 $(mandir)/man5/chip8run.5
	rm -f $(mandir)/man7/15puzzle.7 $(mandir)/man7/alien.7
	rm -f $(mandir)/man7/ant.7 $(mandir)/man7/blinky.7
	rm -f $(mandir)/man7/blitz.7 $(mandir)/man7/brix.7 $(mandir)/man7/car.7
	rm -f $(mandir)/man7/connect4.7 $(mandir)/man7/field.7
	rm -f $(mandir)/man7/guess.7 $(mandir)/man7/hidden.7
	rm -f $(mandir)/man7/hpiper.7 $(mandir)/man7/invaders.7
	rm -f $(mandir)/man7/joust.7 $(mandir)/man7/kaleid.7
	rm -f $(mandir)/man7/maze.7 $(mandir)/man7/merlin.7
	rm -f $(mandir)/man7/missile.7 $(mandir)/man7/pong.7
	rm -f $(mandir)/man7/puzzle.7 $(mandir)/man7/race.7
	rm -f $(mandir)/man7/snake.7 $(mandir)/man7/spacefight.7
	rm -f $(mandir)/man7/syzygy.7 $(mandir)/man7/tank.7
	rm -f $(mandir)/man7/tetris.7 $(mandir)/man7/tictac.7
	rm -f $(mandir)/man7/uboat.7 $(mandir)/man7/ufo.7 $(mandir)/man7/vbrix.7
	rm -f $(mandir)/man7/vers.7 $(mandir)/man7/wipeoff.7
	rm -f $(mandir)/man7/worm3.7

.PHONY: all all-bin all-doc check clean clean-bin clean-doc distclean \
		distclean-directories distclean-files install install-bin \
		install-datadir install-mandir sure t0001a t0002a t0003a \
		t0004a t0005a t0006a t0007a t0008a t0009a t0010a t0011a t0012a \
		t0013a t0014a t0015a t0016a t0017a t0018a t0019a t0020a \
		the-default-target

# vim: set ts=8 sw=8 noet :
