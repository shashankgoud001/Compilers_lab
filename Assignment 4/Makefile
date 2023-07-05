CC = gcc
LEX = flex
YACC = yacc -dtv
OBJECT_FILES = y.tab.o lex.yy.o asgn4_20CS30013_20CS10027_main.o
LEX_FILE = asgn4_20CS30013_20CS10027.l
BISON_FILE = asgn4_20CS30013_20CS10027.y
TEST_FILE = asgn4_20CS30013_20CS10027_test.c
TARGET = a.out
MAIN_FILE = asgn4_20CS30013_20CS10027_main.c
FLAG = -c
DISABLE_WARNINGS = -w

test: $(TARGET) $(TEST_FILE)
	./$(TARGET) < $(TEST_FILE) > output.txt

$(TARGET): $(OBJECT_FILES)
	$(CC) $(DISABLE_WARNINGS) $(OBJECT_FILES) -ll

y.tab.o: y.tab.c
	$(CC) $(DISABLE_WARNINGS) $(FLAG) y.tab.c

y.tab.c y.tab.h y.output: $(BISON_FILE)
	$(YACC) $(BISON_FILE)

lex.yy.o: lex.yy.c
	$(CC) $(DISABLE_WARNINGS) $(FLAG) lex.yy.c

lex.yy.c: $(LEX_FILE) y.tab.h
	$(LEX) $(LEX_FILE)


clean:
	rm -f *.*.c $(OBJECT_FILES) *.output y.tab.h $(TARGET) *.txt