%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int yylex(void);
    int yyerror(char* s);
    extern int yylval;
    int debug=0;
    int line=0;
%}

newline [\n]

/* Rules Section*/
%%
[ \t]+ ;
\n {line++;}

"-"?[0-9]+ {return NUM;}

"def" {return DEF;}
"for" {return FOR;}
"in" {return IN;}
"if" {return IF;}
"else" {return ELSE;}
"return" {return RETURN;}

[a-zA-Z_][a-zA-Z0-9_]* {return ID;}

(","|"("|")"|"["|"]"|":") {return *yytext;}
("+"|"-"|"*"|"/"|"//"|"%"|"**") {return ARITHMETIC_OP;}
(">"|"<"|">="|"<="|"=="|"!=") {return RELATIONAL_OP;}
("+="|"-="|"*="|"/="|"=") {return ASSIGNMENT_OP;}
"~" {return *yytext;}
"@" {return *yytext;}

[^a-zA-Z0-9_]"[".*"]" {return LIST;}
("#"|"."|","|"("|")"|"'") {return *yytext;}

. {fprintf(stderr,"Unknown token found: [%s]\n", yytext);}
%%



