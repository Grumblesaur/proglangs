parser: lex.yy.o parser.tab.o tree.o
	g++ -o parser lex.yy.o parser.tab.o tree.o

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

parser.tab.o: parser.tab.c tree.o
	gcc -c parser.tab.c

parser.tab.h: parser.tab.c
parser.tab.c: parser.y
	bison -d parser.y

tree.o: tree.h tree.c
	gcc -c tree.c

clean:
	rm lex.yy.c parser.tab.h parser *.o
