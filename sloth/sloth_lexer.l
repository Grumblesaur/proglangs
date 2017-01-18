%{
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

/* Data Codes */
#define IDENT 100
#define VALUE 101

/* Arithmetic operators */
#define PLUS  102
#define MINUS 103
#define SLASH 104
#define SPLAT 105

/* Comparison Operators */
#define LTHAN 106
#define GTHAN 107
#define LTEQL 108
#define GTEQL 109
#define EQUAL 110
#define NOTEQ 111

/* Logical Operators */
#define AND   112
#define OR    113
#define BANG  114

/* Structural Components */
#define SCOLN 115
#define SETEQ 116
#define OPPAR 117
#define CLPAR 118

/* Control Flow */
#define START 119
#define END   120
#define IF    121
#define THEN  122
#define ELSE  123
#define WHILE 124
#define DO    125

/* Input / Output */
#define PRINT 126
#define INPUT 127

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
