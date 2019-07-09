prefix=/usr/local
bindir=$(prefix)/bin

all: example checker

CFLAGS=-g

checker: confcheck.o
	$(CC) $(CFLAGS) -o confcheck confcheck.o -lconfig



install:
	install -c conf2struct $(DESTDIR)$(bindir)/conf2struct
	install -c confcheck $(DESTDIR)$(bindir)/confcheck

uninstall:
	rm -rf $(DESTDIR)$(bindir)/conf2struct $(DESTDIR)$(bindir)/confcheck
	
EG_OBJ=example.o parser.o argtable3.o
example: $(EG_OBJ)
	$(CC) $(CFLAGS) -o example $(EG_OBJ) -lconfig

example.c: eg_conf.cfg
	./conf2struct eg_conf.cfg


clean:
	rm -f *.o example.[ch] confcheck example
