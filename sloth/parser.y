%{
#include <stdio.h>
#include "tree.h"
#define CHILDREN attach_node($$, $1); attach_node($$, $3);

int yywrap();
void yyerror(const char * str);
double result = 0;

%}

%error-verbose

%union {
	double value;
	char * var;
	struct Node * node;
}

%token <var> IDENT
%token <value> VALUE
%token PLUS MINUS DIVIDE TIMES
%token LTHAN GTHAN LTEQL GTEQL EQUAL NOTEQ
%token AND OR NOT
%token SCOLN SETEQ OPPAR CLPAR
%token START END IF THEN ELSE WHILE DO
%token PRINT INPUT

%type <node> program stmts stmt expr id orterm andterm compterm addterm
	factor notterm assignment while

%%

id: IDENT {}

program: stmts {}

stmts: stmt stmts {}
	| stmt {}

stmt: conditional {}
	| ifelse {}
	| assignment {}
	| while {}
	| print {}
	| sequence {}
	
conditional: IF expr THEN stmt {}

ifelse: IF expr THEN stmt ELSE stmt {}

assignment:
	IDENT SETEQ expr SCOLN {
		$$ = make_node(SETEQ, 0 "");
		attach_node($$, $1);
		attach_node($$, $3);
	}

while:
	WHILE expr DO stmt {
		$$ = make_node(WHILE);
		CHILDREN	
	}

print: PRINT expr SCOLN {}

sequence: START stmts END {}

expr:
	expr OR orterm {
		$$ = make_node(OR, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	}
	| orterm {}

orterm:
	orterm AND andterm {
		$$ = make_node(AND, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	}
	| andterm {}

andterm:
	andterm LTHAN compterm {}
	| andterm GTHAN compterm {}
	| andterm LTEQL compterm {}
	| andterm GTEQL compterm {}
	| andterm EQUAL compterm {}
	| andterm NOTEQ compterm {}
	| compterm {}

compterm:
	compterm PLUS addterm {}
	| compterm MINUS addterm {}
	| addterm {}

addterm:
	addterm TIMES factor {}
	| addterm DIVIDE factor {}
	| factor {}

factor:
	NOT notterm {}
	| notterm {}

notterm:
	IDENT {$$ = make_node(IDENT, 0, $1);}
	| VALUE {$$ = make_node(VALUE, $1, "");}
	| INPUT {$$ = make_node(INPUT, 0, "");}

%%

void yyerror(const char * str) {
	fprintf(stderr, "Bad syntax: '%s'\n", str);
}

int yywrap() {
	return 1;
}

int main(int argc, char * argv[]) {
	stdin = fopen(argv[1], "r");
	yyparse();
	printf("parse completed");
	return 0;
}
