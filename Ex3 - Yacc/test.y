%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int i = 0;
int a = 5;

%}

%token PUBLIC CLASS STATIC VOID MAIN STRING ARGS INT WHILE IF ELSE PRINTLN PLUS MINUS LT ASSIGN LBRACE RBRACE LPAREN RPAREN SEMICOLON

%%

program: PUBLIC CLASS IDENTIFIER LBRACE method RBRACE
| /* empty */
;

method: STATIC VOID MAIN LPAREN STRING LBRACKET RBRACKET IDENTIFIER RPAREN LBRACE statement RBRACE
;

statement: WHILE LPAREN expression RPAREN LBRACE statement RBRACE
| IF LPAREN expression RPAREN LBRACE statement RBRACE ELSE LBRACE statement RBRACE
| assignment SEMICOLON
| PRINTLN LPAREN expression RPAREN SEMICOLON
;

expression: IDENTIFIER LT IDENTIFIER
| IDENTIFIER ASSIGN INT
| IDENTIFIER PLUS IDENTIFIER
| IDENTIFIER MINUS INT
;

assignment: IDENTIFIER ASSIGN expression
;

%%

int main() {
yyparse();
printf("The final value of i is %d\n", i);
return 0;
}

void yyerror(const char *s) {
fprintf(stderr, "%s\n", s);
exit(1);
}