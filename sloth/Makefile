parser: lex.yy.c parser.tab.c tree.o
	gcc -o parser parser.tab.c lex.yy.c tree.o

parser.tab.h: parser.tab.c
parser.tab.c: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

tree.o: tree.c tree.h
	gcc -c tree.c

clean:
	rm parser parser.tab.* lex.yy.c
