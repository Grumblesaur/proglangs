sloth: lex.yy.o parser.tab.o tree.o sloth.o
	g++ lex.yy.o parser.tab.o tree.o sloth.o -o sloth

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

parser.tab.o: parser.tab.c tree.o
	gcc -c parser.tab.c

parser.tab.h: parser.tab.c
parser.tab.c: parser.y
	bison -d parser.y

sloth.o: sloth.cpp sloth.h tree.o
	g++ -c sloth.cpp

tree.o: tree.c tree.h
	gcc -c tree.c

clean:
	rm lex.yy.c parser.tab.h parser.tab.c *.o sloth
