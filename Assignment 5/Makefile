flag = -w

all: a.out
	@echo "\nTest Cases Are Being Translated\n\n"
	./a.out < ass5_20CS10027_20CS30013_test1.c > output1.txt

	./a.out < ass5_20CS10027_20CS30013_test2.c > output2.txt

	./a.out < ass5_20CS10027_20CS30013_test3.c > output3.txt

	./a.out < ass5_20CS10027_20CS30013_test4.c > output4.txt

	./a.out < ass5_20CS10027_20CS30013_test5.c > output5.txt
	
	
	@echo "\nAll The Test Cases Have Been Successfully Translated !!\n"

a.out: lex.yy.o y.tab.o ass5_20CS10027_20CS30013_translator.o 
	g++ $(flag) lex.yy.o y.tab.o ass5_20CS10027_20CS30013_translator.o -ll


y.tab.o:	y.tab.c
	g++ $(flag) -c y.tab.c

lex.yy.o:	lex.yy.c
	g++ $(flag) -c lex.yy.c

lex.yy.c:	ass5_20CS10027_20CS30013.l y.tab.c
	flex ass5_20CS10027_20CS30013.l 

y.tab.c:	ass5_20CS10027_20CS30013.y
	yacc -dtv ass5_20CS10027_20CS30013.y 

ass5_20CS10027_20CS30013_translator.o: ass5_20CS10027_20CS30013_translator.h ass5_20CS10027_20CS30013_translator.cxx
	g++ $(flag) -c ass5_20CS10027_20CS30013_translator.cxx

clean:
	rm a.out y.tab.o lex.yy.o lex.yy.c y.tab.c y.tab.h y.output ass5_20CS10027_20CS30013_translator.o output*.txt
