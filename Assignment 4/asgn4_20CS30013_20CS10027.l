%{
#include <stdio.h>
#include "y.tab.h"
extern void yyerror(const char *);
%}
%option noyywrap
%option yylineno

PUNCTUATOR			"["|"]"|"."|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"("|")"|"{"|"}"|"%"|","|"<"|">"|"^"|"|"|"="|"?"|":"|";"|"#"
IDENTIFIER			[_A-Za-z][_A-Za-z0-9]*
ESCAPE_SEQUENCE		"\\n"|"\\r"|"\\\\"|"\\a"|"\\v"|"\\\""|"\\?"|"\\b"|"\\f"|"\\t"|"\\\'"
DIGIT		 		[0-9]
DIGIT_SEQUNENCE     {DIGIT}+
NON_ZERO            [1-9]
INTEGER_CONST       {NON_ZERO}{DIGIT}*|"0"

EXPONENT_PART                       [eE]([+-]?){DIGIT_SEQUNENCE}
FRACTIONAL_CONSTANT                 {DIGIT_SEQUNENCE}?\.{DIGIT_SEQUNENCE}|{DIGIT_SEQUNENCE}\.
FLOATING_CONSTANT                      {FRACTIONAL_CONSTANT}({EXPONENT_PART}?)|{DIGIT_SEQUNENCE}{EXPONENT_PART}
ENUMERATION_CONST                   {IDENTIFIER}

S_CHAR				[^"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE		{S_CHAR}+
STRING_LITERAL		\"{S_CHAR_SEQUENCE}?\"


C_CHAR				[^'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE		{C_CHAR}+
CHARACTER_CONST		\'{C_CHAR_SEQUENCE}\'



SINGLELINE_COMMENT  \/\/.*	
MULTILINE_COMMENT	\/\*([^*]|\*+[^*\/])*\*\/

WS 					[ \t\n]

%%
"++"			{ return INCREMENT; }
"--"			{ return DECREMENT; }
"=="			{ return EQUIVALENTTO; }
"->"			{ return ARROW; }
"<<"			{ return LEFT_SHIFT; }
">>"			{ return RIGHT_SHIFT; }
"&&"			{ return AND; }
"||"			{ return OR; }
"<="			{ return LESSTHANOREQUALTO; }
">="			{ return GREATERTHANOREQUALTO; }
"!="			{ return NOTEQUALTO; }
"*="			{ return MULTIPLYASSIGN; }
"..."			{ return ELLIPSIS; }
"/="			{ return DIVIDEASSIGN; }
"%="			{ return MODULOASSIGN; }
"+="			{ return ADDASSIGN; }
"<<="			{ return LEFT_SHIFT_ASSIGN; }
">>="			{ return RIGHT_SHIFT_ASSIGN; }
"-="			{ return SUBTRACTASSIGN; }
"&="			{ return ANDASSIGN; }
"^="			{ return XORASSIGN; }
"|="			{ return ORASSIGN; }
"auto"      {return AUTO;}
"enum"      {return ENUM;}
"restrict"  {return RESTRICT;}
"unsigned"  {return UNSIGNED;}
"break"     {return BREAK;}
"extern"    {return EXTERN;}
"return"    {return RETURN;}
"void"      {return VOID;}
"case"      {return CASE;}
"float"     {return FLOAT;}
"short"     {return SHORT;}
"volatile"  {return VOLATILE;}
"char"      {return CHAR;}
"for"       {return FOR;}
"signed"    {return SIGNED;}
"while"     {return WHILE;}
"const"     {return CONST;}
"goto"      {return GOTO;}
"sizeof"    {return SIZEOF;}
"_Bool"     {return _BOOL;}
"continue"  {return CONTINUE;}
"if"        {return IF;}
"static"    {return STATIC;}
"_Complex"  {return _COMPLEX;}
"default"   {return DEFAULT;}
"inline"    {return INLINE;}
"struct"    {return STRUCT;}
"_Imaginary" {return _IMAGINARY;}
"do"        {return DO;}
"int"       {return INT;}
"switch"    {return SWITCH;}
"double"    {return DOUBLE;}
"long"      {return LONG;}
"typedef"   {return TYPEDEF;}
"else"      {return ELSE;}
"register"  {return REGISTER;}
"union"     {return UNION;}
{IDENTIFIER}		{return IDENTIFIER;}
{INTEGER_CONST}		{return INTEGER_CONSTANT;} 
{FLOATING_CONSTANT}	{return FLOATING_CONSTANT;}
{CHARACTER_CONST}	{return CHARACTER_CONSTANT;}
{STRING_LITERAL}	{return STRING_LITERAL;}
{PUNCTUATOR}		{return yytext[0];}
{SINGLELINE_COMMENT}    {}
{MULTILINE_COMMENT}	{}
{WS}				{}
%%