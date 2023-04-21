%{
	#include <stdio.h>
	#include <ctype.h>
	#include "y.tab.h"
	extern int yylval;
	int yylex();
%}

identifier ([a-zA-Z][0-9])+|[a-zA-Z]+

%%

[\n\t\ ]+  { }

^import\ java\.[^;]* { printf("%s is an IMPORT\n", yytext);return IMPORT;}

class { printf("%s is an CLASS\n", yytext);return CLASS;}

public { printf("%s is an PUBLIC\n", yytext);return PUBLIC;}

static { printf("%s is an class\n", yytext);return STATIC;}

int|float|char|String|double { printf("%s is an DTYPE\n", yytext);return INT;}

void { printf("%s is an VOID\n", yytext);return VOID;}

String { printf("%s is an STRING\n", yytext);return STRING;}

if { printf("%s is an IF\n", yytext);return IF;}

else { printf("%s is an ELSE\n", yytext);return ELSE;}

for { printf("%s is an FOR\n", yytext);return FOR;}

while { printf("%s is an WHILE\n", yytext);return WHILE;}

return { printf("%s is an RETURN\n", yytext);return RETURN;}

length { printf("%s is an LENGTH\n", yytext);return LENGTH;}

System\.out\.print(ln)?\([^)]*\) { printf("%s is an PRINT\n", yytext);return PRINT;}

[0-9]+ { printf("%s is an NUMBER\n", yytext);return NUMBER;}

{identifier} { printf("%s is an ID\n", yytext);return ID;}

. { return yytext[0];} 

%%
