%{
#include <string.h>
#include <stdio.h>
extern int yylex();
extern int yylineno;
void yyerror(char *s);
%}

%union {
    char* charval;
    char* strval;
    int intval;
    float floatval;
}

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%token AUTO ENUM RESTRICT UNSIGNED BREAK EXTERN RETURN VOID CASE FLOAT SHORT VOLATILE CHAR FOR SIGNED WHILE CONST GOTO SIZEOF _BOOL CONTINUE IF STATIC _COMPLEX DEFAULT INLINE STRUCT _IMAGINARY DO INT SWITCH DOUBLE LONG TYPEDEF ELSE REGISTER UNION

%token <charval> CHARACTER_CONSTANT
%token <strval> IDENTIFIER
%token <strval> STRING_LITERAL
%token <intval> INTEGER_CONSTANT
%token <floatval> FLOATING_CONSTANT

%token INCREMENT DECREMENT EQUIVALENTTO ARROW LEFT_SHIFT RIGHT_SHIFT LESSTHANOREQUALTO GREATERTHANOREQUALTO NOTEQUALTO MULTIPLYASSIGN ELLIPSIS DIVIDEASSIGN MODULOASSIGN ADDASSIGN LEFT_SHIFT_ASSIGN RIGHT_SHIFT_ASSIGN SUBTRACTASSIGN INVALID_TOKEN AND OR ANDASSIGN XORASSIGN ORASSIGN 

%start translation_unit

%%

// 1.Expressions

primary_expression: IDENTIFIER
                        {
                            printf("IDENTIFIER\n");
                        }

                |   CHARACTER_CONSTANT
                        {
                            printf("CHARACTER_CONSTANT\n");
                        }

                |   INTEGER_CONSTANT
                        {
                            printf("INTEGER_CONSTANT\n");
                        }

                |   FLOATING_CONSTANT
                        {
                            printf("FLOATING_CONSTANT\n");
                        }

                |   STRING_LITERAL
                        {
                            printf("STRING_LITERAL\n");
                        }

                |   '(' expression ')'
                ;

postfix_expression: primary_expression
                |   postfix_expression '[' expression ']'
                |   postfix_expression '(' argument_expression_list_optional ')'
                |   postfix_expression '.' IDENTIFIER
                |   postfix_expression ARROW IDENTIFIER
                |   postfix_expression INCREMENT
                |   postfix_expression DECREMENT
                |   '(' type_name ')' '{' initializer_list '}'
                |   '(' type_name ')' '{' initializer_list ',' '}'
                ;
argument_expression_list_optional: argument_expression_list
                |   
                ;
argument_expression_list: assignment_expression
                |   argument_expression_list ',' assignment_expression
                ;
unary_expression:   postfix_expression
                |   INCREMENT unary_expression
                |   DECREMENT unary_expression
                |   unary_operator cast_expression
                |   SIZEOF unary_expression
                |   SIZEOF '(' type_name ')'
                ;
unary_operator:     '&'
                |   '*'
                |   '+'
                |   '-'
                |   '~'
                |   '!'
                ;
cast_expression:    unary_expression
                |   '(' type_name ')' cast_expression
                ;
multiplicative_expression: cast_expression
                |   multiplicative_expression '*' cast_expression
                |   multiplicative_expression '/' cast_expression
                |   multiplicative_expression '%' cast_expression
                ;
additive_expression:    multiplicative_expression
                |   additive_expression '+' multiplicative_expression
                |   additive_expression '-' multiplicative_expression
                ;
shift_expression:   additive_expression
                |   shift_expression LEFT_SHIFT additive_expression
                |   shift_expression RIGHT_SHIFT additive_expression
                ;
relational_expression:  shift_expression
                |   relational_expression '<' shift_expression
                |   relational_expression '>' shift_expression
                |   relational_expression LESSTHANOREQUALTO shift_expression
                | relational_expression GREATERTHANOREQUALTO shift_expression
                ;
equality_expression:    relational_expression
                |   equality_expression EQUIVALENTTO relational_expression
                |   equality_expression NOTEQUALTO relational_expression
                ;
AND_expression:  equality_expression
                |   AND_expression '&' equality_expression
                ;
exclusive_OR_expression:    AND_expression
                |   exclusive_OR_expression '^' AND_expression
                ;
inclusive_OR_expression:    exclusive_OR_expression
                |   inclusive_OR_expression '|' exclusive_OR_expression
                ;
logical_AND_expression: inclusive_OR_expression
                |   logical_AND_expression AND inclusive_OR_expression
logical_OR_expression:  logical_AND_expression
                |   logical_OR_expression OR logical_AND_expression
                ;
conditional_expression: logical_OR_expression
                |   logical_OR_expression '?' expression ':' conditional_expression
                ;
assignment_expression_optional: assignment_expression
                |
                ;
assignment_expression:  conditional_expression
                |   unary_expression assignment_operator assignment_expression
                ;
assignment_operator:    '='
                |   MULTIPLYASSIGN
                |   DIVIDEASSIGN
                |   MODULOASSIGN
                |   ADDASSIGN
                |   SUBTRACTASSIGN
                |   LEFT_SHIFT_ASSIGN
                |   RIGHT_SHIFT_ASSIGN
                |   ANDASSIGN
                |   XORASSIGN
                |   ORASSIGN
                ;
expression_optional: expression
                |
                ;    
expression: assignment_expression
                |   expression ',' assignment_expression
                ;
constant_expression: conditional_expression
                ;

// 2. Declarations

declaration:    declaration_specifiers init_declarator_list_optional ';'
                ;
declaration_specifiers_optional: declaration_specifiers
                |
                ;
declaration_specifiers: storage_class_specifier declaration_specifiers_optional
                |   type_specifier declaration_specifiers_optional
                |   type_qualifier declaration_specifiers_optional
                |   function_specifier declaration_specifiers_optional
                ;
init_declarator_list_optional: init_declarator_list
                |
                ;
init_declarator_list:   init_declarator
                |   init_declarator_list ',' init_declarator
                ;
init_declarator:    declarator 
                |   declarator '=' initializer
                ;
storage_class_specifier:    EXTERN
                |   STATIC
                |   AUTO
                |   REGISTER
                ;
type_specifier: VOID
                |   CHAR
                |   SHORT
                |   INT
                |   LONG
                |   FLOAT
                |   DOUBLE
                |   SIGNED
                |   UNSIGNED
                |   _BOOL
                |   _COMPLEX
                |   _IMAGINARY
                |   enum_specifier
                ;
specifier_qualifier_list_optional:  specifier_qualifier_list
                |
                ;
specifier_qualifier_list:   type_specifier specifier_qualifier_list_optional
                |   type_qualifier specifier_qualifier_list_optional
                ;
enum_specifier: ENUM '{' enumerator_list '}'
                |   ENUM '{' enumerator_list ',' '}'
                |   ENUM IDENTIFIER '{' enumerator_list '}'
                |   ENUM IDENTIFIER '{' enumerator_list ',' '}'                   
                |   ENUM IDENTIFIER
                ;
enumerator_list: enumerator
                |   enumerator_list ',' enumerator
                ;
enumerator: IDENTIFIER
                |   IDENTIFIER '=' constant_expression
                ;

type_qualifier: CONST
                |   RESTRICT
                |   VOLATILE
                ;
function_specifier: INLINE
                ;
declarator: pointer_optional direct_declarator
                ;
direct_declarator:  IDENTIFIER
                |   '(' declarator ')'
                |   direct_declarator '[' type_qualifier_list_optional assignment_expression_optional ']'
                |   direct_declarator '[' STATIC type_qualifier_list_optional assignment_expression ']'
                |   direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
                |   direct_declarator '[' type_qualifier_list_optional '*' ']'
                |   direct_declarator '(' parameter_type_list ')'
                |   direct_declarator '(' identifier_list_optional ')'
                ;
pointer_optional: pointer
                |
                ;
pointer:    '*' type_qualifier_list_optional
                |   '*' type_qualifier_list_optional pointer
                ;
type_qualifier_list_optional: type_qualifier_list
                |
                ;
type_qualifier_list:    type_qualifier
                | type_qualifier_list type_qualifier
                ;
parameter_type_list:    parameter_list
                |   parameter_list ',' ELLIPSIS
                ;
parameter_list: parameter_declaration
                |   parameter_list ',' parameter_declaration
                ;
parameter_declaration: declaration_specifiers declarator
                |   declaration_specifiers
                ;
identifier_list_optional:   identifier_list
                |
                ;
identifier_list: IDENTIFIER
                | identifier_list ',' IDENTIFIER
                ;
type_name:  specifier_qualifier_list
                ;
initializer:    assignment_expression
                |   '{' initializer_list '}'
                | '{' initializer_list ',' '}'
                ;

initializer_list:   designation_optional initializer
                |   initializer_list ',' designation_optional initializer
                ;
designation_optional:   designation
                |
                ;
designation:    designator_list '='
                ;
designator_list:    designator
                |   designator_list designator
                ;      
designator: '[' constant_expression ']'
                |   '.' IDENTIFIER
                ;

// 3. Statements

statement:  labeled_statement
                    {
                        printf("labeled_statement\n");
                    }
                |   compound_statement
                    {
                        printf("compound_statement\n");
                    }
                |   expression_statement
                    {
                        printf("expression_statement\n");
                    }
                |   selection_statement
                    {
                        printf("selection_statement\n");
                    }
                |   iteration_statement
                    {
                        printf("iteration_statement\n");
                    }
                |   jump_statement
                    {
                        printf("jump_statement\n");
                    }
                ;
labeled_statement:  IDENTIFIER ':' statement
                    {
                        printf("IDENTIFIER ':' statement\n");
                    }
                |   CASE constant_expression ':' statement
                    {
                        printf("CASE constant_expression ':' statement\n");
                    }
                |   DEFAULT ':' statement
                    {
                        printf("DEFAULT ':' statement\n");
                    }
                ;
compound_statement: '{' '}'
                |   '{' block_item_list '}'
                ;

block_item_list:    block_item
                |   block_item_list block_item
                ;
block_item: declaration 
                    {
                        printf("declaration\n");
                    }
                |   statement
                    {
                        printf("statement\n");
                    }
                ;
                
expression_statement:   expression_optional ';'
                ;
selection_statement:    IF '(' expression ')' statement %prec LOWER_THAN_ELSE ;
                |   IF '(' expression ')' statement ELSE statement
                |   SWITCH '(' expression ')' statement
                ;
iteration_statement:    WHILE '(' expression ')' statement
                |   DO statement WHILE '(' expression ')' ';'
                |   FOR '(' expression_optional ';' expression_optional ';' expression_optional ')' statement
                |   FOR '(' declaration expression_optional ';' expression_optional ')' statement
                ;
jump_statement: GOTO IDENTIFIER ';'
                |   CONTINUE ';'
                |   BREAK ';'
                |   RETURN expression_optional ';'
                ;

// 4. External Definitions

translation_unit:   external_declaration
                    {
                            printf("external_declaration\n");
                    }
                |   translation_unit external_declaration
                    {
                            printf("translation_unit external_declaration\n");
                    }
                ;
external_declaration:   function_definition
                    {
                            printf("function_definition\n");
                    }
                |   declaration
                    {
                            printf("declaration\n");
                    }
                ;
function_definition:    declaration_specifiers declarator declaration_list_optional compound_statement
                        {
                            printf("declaration_specifiers declarator declaration_list_optional compound_statement");
                        }
                ;
declaration_list_optional:  declaration_list
                |
                ;
declaration_list:   declaration
                        {
                            printf("declaration\n");
                        }
                |   declaration_list declaration
                        {
                            printf("declaration_list declaration\n");
                        }
                ;

%%

void yyerror(char *s){
    printf("In line number %d, found ERROR : %s\n",yylineno,s);
}