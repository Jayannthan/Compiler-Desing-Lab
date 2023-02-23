%{
#include <stdio.h>
%}

digit [0-9]
letter [a-zA-Z]
id {letter}({letter}|{digit})*

%%

{digit}+      printf("Number: %s\n", yytext);
{id}          printf("Identifier: %s\n", yytext);
"+"           printf("Plus\n");
"-"           printf("Minus\n");
"*"           printf("Multiply\n");
"/"           printf("Divide\n");
"("           printf("Left Parenthesis\n");
")"           printf("Right Parenthesis\n");
"="           printf("Assignment\n");
";"           printf("Semicolon\n");
" "           /* skip whitespace */
\n            /* skip newlines */

%%

int main(void) {
    yylex();
    return 0;
}

%{
#include<stdio.h>
int keyword_count = 0, identifier_count = 0, constant_count = 0;
%}

%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { keyword_count++; printf("Keyword: %s\n", yytext); }

[_a-zA-Z][_a-zA-Z0-9]* { identifier_count++; printf("Identifier: %s\n", yytext); }

[0-9]+ { constant_count++; printf("Constant: %s\n", yytext); }

[ \t] ;

\n ;

. ;

%%

int main() {
    yylex();
    printf("Keyword count: %d\n", keyword_count);
    printf("Identifier count: %d\n", identifier_count);
    printf("Constant count: %d\n", constant_count);
    return 0;
}
