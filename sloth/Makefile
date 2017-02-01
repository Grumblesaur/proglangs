analyzer: lex.yy.c parser.tab.h
	gcc -o analyzer parser.tab.c lex.yy.c

parser.tab.h: parser.y tree.c
	bison -d parser.y

lex.yy.c: lexer.l codes.h parser.tab.h
	flex lexer.l

lexer: lex.yy.c
	gcc lex.yy.c -o lexer
clean:
	rm analyzer lexer parser.tab.* lex.yy.c
