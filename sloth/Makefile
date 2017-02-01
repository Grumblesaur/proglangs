analyzer: lex.yy.c parser.tab.h tree.h
	gcc -o analyzer parser.tab.c lex.yy.c tree.c

parser.tab.h: parser.y tree.c
	bison -d parser.y

lex.yy.c: lexer.l codes.h parser.tab.h
	flex lexer.l

clean:
	rm analyzer lexer parser.tab.* lex.yy.c
