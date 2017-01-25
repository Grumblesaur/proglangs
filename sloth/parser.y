%{
#include <stdio.h>
#include "tree.h"

int yywrap();
void yyerror(const char * str);
double result = 0;

%}

%define parse.error verbose
%define parse.lac full

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

stmts: stmt SCOLN stmts {}
	| %empty
	;

stmt: assignment {}
	| output {}
	| conditional {}
	| loop {}

sequence: START stmts END;

output: PRINT expr SCOLN

assignment: IDENT SETEQ expr {};

conditional: IF expr THEN option {}
	| IF expr THEN option ELSE option

option: stmt
	| sequence

loop: WHILE expr DO START stmt END {}

expr: expr PLUS term {}
	| expr MINUS term {}
	| term {}
	| INPUT {}

term: term TIMES factor {}
	| term DIVIDE factor {}
	| factor {}

factor: VALUE {}
	| OPPAR expr CLPAR {}

%%

void yyerror(const char * str) {
	fprintf(stderr, "Bad syntax: '%s'\n", str);
}

int main() {
	yyparse();
}
