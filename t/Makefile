all: parser

CFLAGS=-g -fprofile-arcs -ftest-coverage -Wall

ifeq ($(strip $(NOLIBCONFIG)),)
    LDFLAGS+=-lconfig
    CFLAGS+=-DLIBCONFIG
endif

OBJ=c2s.o parser.o argtable3.o
parser: c2s.c $(OBJ)
	gcc -o parser $(OBJ) $(LDFLAGS) -lgcov

c2s.c: $(SCHEMA)
	perl $(PERLOPTS) ../../conf2struct $(SCHEMA)


clean:
	rm -f *.o example.[ch] confcheck example
