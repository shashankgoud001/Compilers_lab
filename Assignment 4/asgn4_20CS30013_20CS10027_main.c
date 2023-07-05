#include <stdio.h>
extern int yyparse();
extern int yydebug;


int main(){
	yydebug=1;
	
	if(yyparse())
		printf("\n***\nParsing Failed\n***\n");
	else
		printf("\n***\nParsing Successful\n***\n");
	return 0;
}
