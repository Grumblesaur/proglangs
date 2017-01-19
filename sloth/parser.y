%{
#include <stdio.h>
#include "codes.h"

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
%token SLASH
%token SPLAT

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

stmt: expr SCOLN {result = $1; return 0;}
	| expr 

expr: expr PLUS term {$$ = $1 + $3;}
	| expr MINUS term {$$ + $1 - $3;}
	| term {$$ = $1;}

term: term SPLAT factor {$$ = $1 * $3;}
	| term SLASH factor {$$ = $1 / $3;}
	| factor {$$ = $1;}

factor: VALUE {$$ = $1;}
	| OPPAR expr CLPAR {$$ = $2;}

loop: WHILE expr DO BEGIN stmt END

if-stmt: IF expr THEN stmt
	| IF expr THEN stmt ELSE stmt


%%


