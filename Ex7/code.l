%{
#include<stdio.h> 
#include<stdlib.h> 
#include "y.tab.h" 
void yyerror(char*);
extern YYSTYPE yylval;
 
%}


digit	[0-9]
letter	[a-zA-Z]
identifier (_|{letter})(_|{digit}|{letter})* relop(<)|(>)|(<=)|(>=)|(==)|(!=) arithop(\+)|(\-)|(\*)|(\/)
space(\ )


%%
	if	{yylval.string=strdup(yytext);return ifStmt;} goto {yylval.string=strdup(yytext);return gotoStmt;}
	L{digit}	{yylval.string=strdup(yytext);return label;} t{digit} {yylval.string=strdup(yytext);return tempVar;}
	{identifier}       {yylval.string=strdup(yytext);return identifier;}
	{digit}+	{/*printf("%s\n",yytext);*/yylval.string=strdup(yytext);return number;}
	\:	{return *yytext;}
	\n	{return *yytext;}
	{relop}	{yylval.string=strdup(yytext);return relop;}
	{arithop} {yylval.string=strdup(yytext);return arithop;}
	=	{return *yytext;}
	{space}	{return *yytext;}
%%
