# stest - filter file list by property
# See LICENSE file for copyright and license details.

# stest version
VERSION = 4.9

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\"
CFLAGS   = -std=c99 -pedantic -Wall -Os $(CPPFLAGS)

# compiler and linker
CC = cc

SRC = stest.c
OBJ = $(SRC:.c=.o)

all: stest

options:
	@echo stest build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) -c $(CFLAGS) $<

stest: stest.o
	$(CC) -o $@ stest.o

clean:
	rm -f stest $(OBJ)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/stest $(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all options clean install uninstall
