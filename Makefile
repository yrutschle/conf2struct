prefix=/usr/local
bindir=$(prefix)/bin

all: example checker

CFLAGS=-g

checker: confcheck.o
	gcc -o confcheck confcheck.o -lconfig


install: all
	install -c conf2struct $(bindir)/conf2struct
	install -c confcheck $(bindir)/confcheck

uninstall:
	rm -rf $(bindir)/conf2struct $(bindir)/confcheck
	
EG_OBJ=example.o parser.o argtable3.o
example: $(EG_OBJ)
	gcc -o example $(EG_OBJ) -lconfig

example.c: eg_conf.cfg
	./conf2struct eg_conf.cfg


clean:
	rm -f *.o example.[ch] confcheck example
