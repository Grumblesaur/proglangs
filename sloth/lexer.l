%{
/*  James Murphy
	CPSC 401 / Programming Languages
	sloth interpreter / lexer file
*/

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include "parser.tab.h"

%}

%option noyywrap

%%
"begin"         {return START;}
"end"           {return END;  }
"if"            {return IF;   }
"then"          {return THEN; }
"else"          {return ELSE; }
"while"         {return WHILE;}
"do"            {return DO;   }
"print"         {return PRINT;}
"input"         {return INPUT;}

[a-zA-Z_]+[0-9]*[a-zA-Z_]*     {yylval.var = yytext; return IDENT;}
[0-9]*\.?[0-9]+ {yylval.value = atof(yytext); return VALUE;}

"+"             {return PLUS; }
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return DIVIDE;}

"<"             {return LTHAN;}
">"             {return GTHAN;}
"<="            {return LTEQL;}
">="            {return GTEQL;}
"=="            {return EQUAL;}
"!="            {return NOTEQ;}
"&&"            {return AND;  }
"||"            {return OR;   }
"!"             {return NOT;  }

";"             {return SCOLN;}
":="            {return SETEQ;}
"("             {return OPPAR;}
")"             {return CLPAR;}

"%".*           {/* comment -- do nothing */}
[ \t\n]+        {/* whitespace -- do nothing */}

%%
/*
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
*/
