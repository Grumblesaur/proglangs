sloth: lex.yy.o parser.tab.o tree.o sloth.o
	g++ -o sloth lex.yy.o parser.tab.o tree.o sloth.o

parser: lex.yy.o parser.tab.o tree.o
	g++ -o parser lex.yy.o parser.tab.o tree.o

sloth.o: sloth.cpp sloth.h
	g++ -c sloth.cpp

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

parser.tab.o: parser.tab.c parser.tab.h tree.o
	gcc -c parser.tab.c

parser.tab.h: parser.tab.c
parser.tab.c: parser.y
	bison -d parser.y

tree.o: tree.h tree.c
	gcc -c tree.c

clean:
	rm lex.yy.c parser.tab.c parser *.o
