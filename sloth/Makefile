all: lexer

lex.yy.c: sloth_lexer.l
	flex sloth_lexer.l

lexer: lex.yy.c
	gcc lex.yy.c -o lexer
