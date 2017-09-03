CC = gcc
CFLAGS = -Wall -W -O3 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

GOAL = findaes
OBJ  = main.o aes.o

all: $(GOAL)

cross: CC = i386-mingw32-gcc
cross: STRIP= i386-mingw32-strip
cross: EXT = .exe
cross: $(GOAL).exe

findaes.exe: $(OBJ)
	$(CC) $(CFLAGS) -o findaes.exe $(OBJ)
	$(STRIP) findaes.exe

findaes: $(OBJ)
	$(CC) $(CFLAGS) -o findaes $(OBJ)

nice:
	rm -f *~

clean: nice
	rm -f $(GOAL) $(GOAL).exe $(OBJ)

DESTDIR = $(GOAL)-1.2

package: clean cross
	rm -rf $(DESTDIR) $(DESTDIR).zip
	mkdir $(DESTDIR)
	cp main.c aes.c aes.h Makefile findaes.exe $(DESTDIR)
	zip -r9 $(DESTDIR).zip $(DESTDIR)
	rm -rf $(DESTDIR)
