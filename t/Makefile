all: parser

CFLAGS=-g -DLIBPCRE -fprofile-arcs -ftest-coverage -Wall

OBJ=c2s.o parser.o argtable3.o
parser: c2s.c $(OBJ)
	gcc -o parser $(OBJ) -lconfig -lpcreposix -lgcov

c2s.c: $(SCHEMA)
	perl $(PERLOPTS) ../../conf2struct $(SCHEMA)


clean:
	rm -f *.o example.[ch] confcheck example
