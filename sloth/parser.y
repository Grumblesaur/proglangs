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
%token NOT

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

stmts: stmt stmts {}
	| stmt {}

stmt: conditional {}
	| ifelse {}
	| assignment {}
	| while {}
	| print {}
	| sequence {}
	
conditional: IF predicate THEN stmt {}

ifelse: IF predicate THEN stmt ELSE stmt {}

assignment: IDENT SETEQ predicate SCOLN {}

while: WHILE predicate DO stmt {}

print: PRINT predicate SCOLN {}

sequence: START stmts END

predicate: expr AND expr {}
	| expr OR expr {}
	| expr

expr: comp {}
	| addsub {}
	| term {}
	| factor {}

comp: term LTHAN term {}
	| term GTHAN term {}
	| term LTEQL term {}
	| term GTEQL term {}
	| term EQUAL term {}
	| term NOTEQ term {}

addsub: term PLUS term {}
	| term MINUS term {}

term: inverse {}
	| factor TIMES factor {}
	| factor DIVIDE factor {}
	| factor

inverse: NOT factor {}

factor: IDENT {}
	| VALUE {}
	| OPPAR expr CLPAR {}

%%

void yyerror(const char * str) {
	fprintf(stderr, "Bad syntax: '%s'\n", str);
}

int yywrap() {
	return 1;
}

int main() {
	yyparse();
	printf("parse completed");
	return 0;
}
