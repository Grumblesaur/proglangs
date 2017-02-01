%{
#include <stdio.h>
#include "tree.h"

int yywrap();
void yyerror(const char * str);
struct Node * result;

%}

%error-verbose

%union {
	double value;
	char * var;
	struct Node * node;
}

%token <var> IDENT
%token <value> VALUE
%token PLUS MINUS 
%token DIVIDE TIMES
%token LTHAN GTHAN LTEQL GTEQL EQUAL NOTEQ
%token AND OR
%token NOT
%token SCOLN SETEQ OPPAR CLPAR
%token START END IF THEN ELSE WHILE DO
%token PRINT INPUT
%token STMT

%precedence THEN
%precedence ELSE

%type <node> program stmts stmt expr orterm andterm compterm addterm factor notterm id

%%

program: stmts {
		result = make_node(STMT, 0, "");
		attach_node(result, $1);
	}

stmts: stmt stmts {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $1);
		attach_node($$, $2);
	} | stmt {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $1);
	}

stmt: IF expr THEN stmt {
		$$ = make_node(IF, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
	} | IF expr THEN stmt ELSE stmt {
		$$ = make_node(IF, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
		attach_node($$, $6);
	} | id SETEQ expr SCOLN {
		$$ = make_node(SETEQ, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | WHILE expr DO stmt {
		$$ = make_node(WHILE, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
	} | PRINT expr SCOLN {
		$$ = make_node(PRINT, 0, "");
		attach_node($$, $2);
	} | START stmts END {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $2);
	}

expr: expr OR orterm {
		$$ = make_node(OR, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | orterm {}

orterm: orterm AND andterm {
		$$ = make_node(AND, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm {}

andterm: andterm LTHAN compterm {
		$$ = make_node(LTHAN, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm GTHAN compterm {
		$$ = make_node(GTHAN, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm LTEQL compterm {
		$$ = make_node(LTEQL, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm GTEQL compterm {
		$$ = make_node(GTEQL, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm EQUAL compterm {
		$$ = make_node(EQUAL, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | andterm NOTEQ compterm {
		$$ = make_node(NOTEQ, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | compterm {}

compterm: compterm PLUS addterm {
		$$ = make_node(PLUS, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | compterm MINUS addterm {
		$$ = make_node(MINUS, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | addterm {}

addterm: addterm TIMES factor {
		$$ = make_node(TIMES, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | addterm DIVIDE factor {
		$$ = make_node(DIVIDE, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | factor {}

factor: NOT notterm {
		$$ = make_node(NOT, 0, "");
		attach_node($$, $2);
	} | notterm {}

notterm: OPPAR expr CLPAR {
		
	} | VALUE {
		$$ = make_node(VALUE, $1, "");
	} | IDENT {
		$$ = make_node(IDENT, 0, $1);
	} | INPUT {
		$$ = make_node(INPUT, 0, "");
	}

id: IDENT {$$ = make_node(IDENT, 0, $1);}

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
	print_tree(result, 0);
	return 0;
}
