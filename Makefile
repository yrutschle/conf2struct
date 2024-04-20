prefix=/usr/local
bindir=$(prefix)/bin

CFLAGS=-g -DLIBCONFIG

all: example confcheck

confcheck: confcheck.o
	$(CC) $(CFLAGS) -o confcheck confcheck.o -lconfig

install: conf2struct confcheck
	mkdir -p $(DESTDIR)/$(bindir)
	install -c -m 755 conf2struct $(DESTDIR)$(bindir)/conf2struct
	install -c -m 755 confcheck $(DESTDIR)$(bindir)/confcheck

uninstall:
	rm -rf $(DESTDIR)$(bindir)/conf2struct $(DESTDIR)$(bindir)/confcheck
	
EG_OBJ=example.o parser.o argtable3.o
example: $(EG_OBJ)
	$(CC) $(CFLAGS) -o example $(EG_OBJ) -lconfig

example.c: eg_conf.cfg
	./conf2struct eg_conf.cfg

parser.o: example.c

clean:
	rm -f *.o example.[ch] confcheck example
