.PHONY=all install run clean

CC=gcc

SRC=main.c

BINS ?= main

CFLAGS=
PREFIX ?= /usr/local


all: $(BINS)

$(BINS): $(SRC)
	$(CC) $(CFLAGS) -o $(BINS) $(SRC)


install: all
	install -D -t $(DESTDIR)$(PREFIX)/bin $(BINS)

run: clean $(BINS)
	./$(BINS)

clean:
	$(RM) $(BINS)
