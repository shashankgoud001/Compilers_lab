flag = -w
tinyc: y.tab.o lex.yy.o ass6_20CS30013_20CS10027_translator.o ass6_20CS30013_20CS10027_target_translator.o 
	@g++ $(flag) -g ass6_20CS30013_20CS10027_translator.o ass6_20CS30013_20CS10027_target_translator.o lex.yy.o y.tab.o -ll -o tinyc
	@./tinyc < ass6_20CS30013_20CS10027_test1.c
	@./tinyc < ass6_20CS30013_20CS10027_test2.c 
	@./tinyc < ass6_20CS30013_20CS10027_test3.c
	@./tinyc < ass6_20CS30013_20CS10027_test4.c
	@./tinyc < ass6_20CS30013_20CS10027_test5.c
	@echo " make run to execute all the test files at once"
lex.yy.c: ass6_20CS30013_20CS10027.l
	@flex $(flag) ass6_20CS30013_20CS10027.l
y.tab.c: ass6_20CS30013_20CS10027.y
	@yacc -dtv ass6_20CS30013_20CS10027.y
ass6_20CS30013_20CS10027_target_translator.o: ass6_20CS30013_20CS10027_target_translator.cxx
	@g++ $(flag) -g -c ass6_20CS30013_20CS10027_target_translator.cxx
ass6_20CS30013_20CS10027_translator.o: ass6_20CS30013_20CS10027_translator.cxx
	@g++ $(flag) -g -c ass6_20CS30013_20CS10027_translator.cxx
lex.yy.o: lex.yy.c
	@g++ $(flag) -g -c lex.yy.c
y.tab.o:    y.tab.c
	@g++ $(flag) -g -DYYDEBUG -c y.tab.c
libAsgn6_20CS30013_20CS10027.a: Asgn6_20CS30013_20CS10027.o
	@ar -rcs libAsgn6_20CS30013_20CS10027.a Asgn6_20CS30013_20CS10027.o

Asgn6_20CS30013_20CS10027.o: Asgn6_20CS30013_20CS10027.c myl.h
	@gcc $(flag) -Wall  -c Asgn6_20CS30013_20CS10027.c
clean:
	@rm ass6_20CS30013_20CS10027_test1.s ass6_20CS30013_20CS10027_test2.s ass6_20CS30013_20CS10027_test3.s ass6_20CS30013_20CS10027_test4.s ass6_20CS30013_20CS10027_test5.s test1 test2 test3 test4 test5 lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass6_20CS30013_20CS10027_translator.o ass6_20CS30013_20CS10027_target_translator.o ass6_20CS30013_20CS10027_test1.o ass6_20CS30013_20CS10027_test2.o ass6_20CS30013_20CS10027_test3.o ass6_20CS30013_20CS10027_test4.o ass6_20CS30013_20CS10027_test5.o libAsgn6_20CS30013_20CS10027.a Asgn6_20CS30013_20CS10027.o ass6_20CS30013_20CS10027_quad1.out ass6_20CS30013_20CS10027_quad2.out ass6_20CS30013_20CS10027_quad3.out ass6_20CS30013_20CS10027_quad4.out ass6_20CS30013_20CS10027_quad5.out tinyc


test1:libAsgn6_20CS30013_20CS10027.a
	@gcc $(flag) ass6_20CS30013_20CS10027_test1.s -L. -lAsgn6_20CS30013_20CS10027 -no-pie -o test1

test2:
	@gcc $(flag) ass6_20CS30013_20CS10027_test2.s -L. -lAsgn6_20CS30013_20CS10027 -no-pie -o test2

test3:
	@gcc $(flag) ass6_20CS30013_20CS10027_test3.s -L. -lAsgn6_20CS30013_20CS10027 -no-pie -o test3

test4:
	@gcc $(flag) ass6_20CS30013_20CS10027_test4.s -L. -lAsgn6_20CS30013_20CS10027 -no-pie -o test4

test5:
	@gcc $(flag) ass6_20CS30013_20CS10027_test5.s -L. -lAsgn6_20CS30013_20CS10027 -no-pie -o test5




output: output.o libAsgn6_20CS30013_20CS10027.a
	@gcc $(flag) -g  output.o -o output -L. -lAsgn6_20CS30013_20CS10027
output.o: output.s myl.h
	@gcc $(flag) -g -Wall -c output.s

run: 
		
	@./tinyc < ass6_20CS30013_20CS10027_test1.c > ass6_20CS30013_20CS10027_quad1.out
	
	@mv output.s ass6_20CS30013_20CS10027_test1.s
	
	@make test1
	
	@./tinyc < ass6_20CS30013_20CS10027_test2.c > ass6_20CS30013_20CS10027_quad2.out

	@mv output.s ass6_20CS30013_20CS10027_test2.s
	
	@make test2

	@./tinyc < ass6_20CS30013_20CS10027_test3.c > ass6_20CS30013_20CS10027_quad3.out

	@mv output.s ass6_20CS30013_20CS10027_test3.s

	@make test3

	@./tinyc < ass6_20CS30013_20CS10027_test4.c > ass6_20CS30013_20CS10027_quad4.out
	
	@mv output.s ass6_20CS30013_20CS10027_test4.s

	@make test4

	@./tinyc < ass6_20CS30013_20CS10027_test5.c > ass6_20CS30013_20CS10027_quad5.out
	
	@mv output.s ass6_20CS30013_20CS10027_test5.s

	@make test5
	@echo ""
	@echo "Commands for Test Cases"
	@echo "Test Case 1 : Calculate Force    				Command : ./test1"
	@echo "Test Case 2 : Convert decimal number to binary   Command : ./test2"
	@echo "Test Case 3 : Largest sum contiguous subarray    Command : ./test3"
	@echo "Test Case 4 : Longest Common Subsequence 		Command : ./test4"
	@echo "Test Case 5 : Merge Sort            				Command : ./test5"
