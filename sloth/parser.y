%{
#include <stdio.h>
#include "tree.h"

int yywrap();
void yyerror(const char * str);
double result = 0;

%}

%error-verbose

%union {
	double value;
}

%token IDENT
%token <value> VALUE

%token PLUS
%token MINUS
%token DIVIDE
%token TIMES

%token LTHAN
%token GTHAN
%token LTEQL
%token GTEQL
%token EQUAL
%token NOTEQ

%token AND
%token OR
%token BANG

%token SCOLN
%token SETEQ
%token OPPAR
%token CLPAR

%token START
%token END
%token IF
%token THEN
%token ELSE
%token WHILE
%token DO

%token PRINT
%token INPUT

%%

program: stmts {}
	|
	;

stmt: stmt + stmts {}
stmts: stmt + stmts {}
	|
	;

expr: expr PLUS term {}
	| expr MINUS term {}
	| term {}

term: term TIMES factor {}
	| term DIVIDE factor {}
	| factor {}

factor: VALUE {}
	| OPPAR expr CLPAR {}

loop: WHILE expr DO START stmt END {}

if-stmt: IF expr THEN stmt
	| IF expr THEN stmt ELSE stmt


%%


