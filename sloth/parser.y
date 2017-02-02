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

%type <node> program statements statement expression disjunction
%type <node> conjunction relation addend factor atom id

%%

program: statements {
		result = make_node(STMT, 0, "");
		attach_node(result, $1);
	}

statements: statement statements {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $1);
		attach_node($$, $2);
	} | statement {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $1);
	}

statement: IF expression THEN statement {
		$$ = make_node(IF, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
	} | IF expression THEN statement ELSE statement {
		$$ = make_node(IF, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
		attach_node($$, $6);
	} | id SETEQ expression SCOLN {
		$$ = make_node(SETEQ, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | WHILE expression DO statement {
		$$ = make_node(WHILE, 0, "");
		attach_node($$, $2);
		attach_node($$, $4);
	} | PRINT expression SCOLN {
		$$ = make_node(PRINT, 0, "");
		attach_node($$, $2);
	} | START statements END {
		$$ = make_node(STMT, 0, "");
		attach_node($$, $2);
	}

expression: expression OR disjunction {
		$$ = make_node(OR, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | disjunction {}

disjunction: disjunction AND conjunction {
		$$ = make_node(AND, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction {}

conjunction: conjunction LTHAN relation {
		$$ = make_node(LTHAN, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction GTHAN relation {
		$$ = make_node(GTHAN, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction LTEQL relation {
		$$ = make_node(LTEQL, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction GTEQL relation {
		$$ = make_node(GTEQL, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction EQUAL relation {
		$$ = make_node(EQUAL, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | conjunction NOTEQ relation {
		$$ = make_node(NOTEQ, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | relation {}

relation: relation PLUS addend {
		$$ = make_node(PLUS, 0 , "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | relation MINUS addend {
		$$ = make_node(MINUS, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | addend {}

addend: addend TIMES factor {
		$$ = make_node(TIMES, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | addend DIVIDE factor {
		$$ = make_node(DIVIDE, 0, "");
		attach_node($$, $1);
		attach_node($$, $3);
	} | factor {}

factor: NOT atom {
		$$ = make_node(NOT, 0, "");
		attach_node($$, $2);
	} | atom {}

atom: OPPAR expression CLPAR {
		$$ = make_node(OPPAR, 0, "");
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
	FILE * _stdin = stdin;
	stdin = fopen(argv[1], "r");
	yyparse();
	stdin = _stdin;
	print_tree(result, 0);
	return 0;
}
