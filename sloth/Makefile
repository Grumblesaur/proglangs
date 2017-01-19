all: lexer

lex.yy.c: lexer.l codes.h
	flex lexer.l

lexer: lex.yy.c
	gcc lex.yy.c -o lexer
