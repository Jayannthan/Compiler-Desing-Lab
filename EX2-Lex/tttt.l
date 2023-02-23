/*lex program to count number of words*/
%{
#include<stdio.h>
#include<string.h>
int i = 0;
%}


%%
([a-zA-Z0-9])* {i++;} 

"\n" {printf("%d\n", i); i = 0;}
%%

int yywrap(void){}

int main()
{
  // The function that starts the analysis
  yylex();

  return 0;
}

; {datatype}	printf("datatype: %s\n", yytext); 
/* {arithop}       printf("Arithmetic operator: %s\n", yytext);*/
/*<COMMENT>.      { printf("%s", yytext); }*/
<COMMENT>"*/"   { BEGIN(INITIAL); printf("%s\n", yytext); }
