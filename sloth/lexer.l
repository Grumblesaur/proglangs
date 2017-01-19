%{
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include "codes.h"

%}

%option noyywrap

%%
"begin"         {return START;}
"end"           {return END;}
"if"            {return IF;}
"then"          {return THEN;}
"else"          {return ELSE;}
"while"         {return WHILE;}
"do"            {return DO;}
"print"         {return PRINT;}
"input"         {return INPUT;}

[a-zA-Z]+       {return IDENT;}
[0-9]*\.?[0-9]+ {return VALUE;}

"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return SPLAT;}
"/"             {return SLASH;}

"<"             {return LTHAN;}
">"             {return GTHAN;}
"<="            {return LTEQL;}
">="            {return GTEQL;}
"=="            {return EQUAL;}
"!="            {return NOTEQ;}
"&&"            {return AND;}
"||"            {return OR;}
"!"             {return BANG;}

";"             {return SCOLN;}
":="            {return SETEQ;}
"("             {return OPPAR;}
")"             {return CLPAR;}

"%".*           {/* comment -- do nothing */}
[ \t\n]+        {/* whitespace -- do nothing */}

%%

int main(int argc, char ** argv) {
	if (argc > 1) {
		struct stat buffer;
		if (stat(argv[1], &buffer) != -1) {
			stdin = fopen(argv[1], "r");
		} else {
			fprintf(stderr, "File '%s' not found.\n", argv[1]);
			exit(EXIT_FAILURE);
		}
	}
	
	int token;

	do {
		token = yylex();
		printf("%d\n", token);
	} while (token > 0);
	
	return 0;
}
