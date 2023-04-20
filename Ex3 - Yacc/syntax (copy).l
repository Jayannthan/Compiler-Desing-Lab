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

%%
[ \t]+ ;
\n {line++;}
[0-9]+ { printf("%s is an integer\n", yytext);return NUM;}
("int"|"float"|"double"|"long"|"short"|"byte"|"char"|"boolean") {printf("%s is a data type\n", yytext);return DTYPE; }
"if" {printf("IF PART\n"); return IF;}
"while" {printf("WHILE LOOP\n"); return WHILE;}
"for" {printf("FOR LOOP\n"); return FOR; }
"else" {printf("ELSE PART\n"); return ELSE;}
[_a-zA-Z][a-zA-Z0-9_]* { printf("%s is an identifier\n", yytext);return ID; }
";" {printf("End of statement\n\n");return EOS;}
(">"|"<"|"<="|">="|"!="|"==") { printf("%s is comparison operator\n",yytext); return COMPARISON_OP; }
("+"|"-")?("=") { printf("%s is an assign op\n", yytext);return ASSIGN_OP; }
("++"|"--") { printf("%s is an incr-decr op\n", yytext);return INDE_OP; }
">>" { printf("rs operator\n"); return RSHIFT; }
"<<" {printf("ls operator\n"); return LSHIFT; }
"!" { printf("NOW operator\n"); return NOT; }
"||" {printf("OR operator\n"); return OR; }
"&&" {printf("AND operator\n"); return AND; }
"{" { printf("\n-----START_BLOCK-----\n"); return *yytext; }
"}" { printf("-----END_BLOCK-----\n\n"); return *yytext; }
("+"|"-"|"*"|"/"|"%"|"++"|"--") { printf("%s is an arith op\n", yytext);return ARITH_OP; }

"//".* ;
"/*".*"*/" ;

"." {printf("%s\n",yytext); return *yytext;} 
"," {printf("%s\n",yytext); return *yytext;}
"(" {printf("%s\n",yytext); return *yytext;}
")" {printf("%s\n",yytext); return *yytext;}
"[" {printf("%s\n",yytext); return *yytext;}
"]" {printf("%s\n",yytext); return *yytext;}
"{" {printf("%s\n",yytext); return *yytext;}
"}" {printf("%s\n",yytext); return *yytext;}

%%
