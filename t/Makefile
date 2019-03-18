all: parser

CFLAGS=-g

OBJ=c2s.o parser.o argtable3.o
parser: c2s.c $(OBJ)
	gcc -o parser $(OBJ) -lconfig

c2s.c: $(SCHEMA)
	perl $(PERLOPTS) ../../conf2struct $(SCHEMA)


clean:
	rm -f *.o example.[ch] confcheck example
