%{
#include <stdio.h>
#include "codes.h"

int yywrap();
void yyerror(const char * str);
double result = 0;

%}

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


/* grammar rules TODO */


%%


