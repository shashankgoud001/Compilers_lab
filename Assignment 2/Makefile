result: main.o libass2_20CS30013.a
	gcc main.o -L. -lass2_20CS30013


libass2_20CS30013.a: ass2_20CS30013.o
	ar -rcs libass2_20CS30013.a ass2_20CS30013.o

main.o: main.c myl.h
	gcc -Wall -c main.c


ass2_20CS30013.o: ass2_20CS30013.c myl.h
	gcc -Wall -c ass2_20CS30013.c

clean:
	rm *.out *.o *.a