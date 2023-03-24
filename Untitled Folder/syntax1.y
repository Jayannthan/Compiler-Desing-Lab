%{
#include <stdlib.h>
#include <stdio.h>
int yylex(void);
extern FILE* yyin;
#include "y.tab.h"
int error = 0;
/extern int debug;/
extern int line;
%}

%token INT DOUBLE CHAR BOOL STRING VOID IF ELSE FOR WHILE DO SWITCH CASE DEFAULT BREAK CONTINUE RETURN
%token <sval> ID
%token <ival> INT_LITERAL
%token <fval> FLOAT_LITERAL
%token <cval> CHAR_LITERAL
%token <bval> BOOL_LITERAL
%token <strval> STRING_LITERAL
%token SEMICOLON COLON COMMA DOT LPAREN RPAREN LBRACE RBRACE LSQUARE RSQUARE
%token PLUS MINUS MULTIPLY DIVIDE MODULO
%token ASSIGN_PLUS ASSIGN_MINUS ASSIGN_MULTIPLY ASSIGN_DIVIDE ASSIGN_MODULO
%token ASSIGN EQUAL NOT_EQUAL GREATER LESSER GREATER_EQUAL LESSER_EQUAL
%token AND OR NOT
%token INCREMENT DECREMENT

%left OR
%left AND
%left EQUAL NOT_EQUAL
%left GREATER LESSER GREATER_EQUAL LESSER_EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%left NOT

%{
// Function prototypes
void yyerror(char *);
int yylex(void);

// Global variables
int line_no = 1;

%}

%%
program: block
| error { printf("Invalid syntax at line %d\n", line_no); error = 1; }
;

block: LBRACE statement_list RBRACE
;

statement_list: statement SEMICOLON statement_list
|
;

statement: declaration
| assignment
| conditional
| loop
| method_call
| break_statement
| continue_statement
| return_statement
;

declaration: datatype variable_declaration
;

variable_declaration: ID ASSIGN expression
| ID
| ID LSQUARE INT_LITERAL RSQUARE ASSIGN LBRACE array_literal RBRACE
;

datatype: INT
| DOUBLE
| CHAR
| BOOL
| STRING
| VOID
;

assignment: variable ASSIGN expression
| variable ASSIGN_PLUS expression
| variable ASSIGN_MINUS expression
| variable ASSIGN_MULTIPLY expression
| variable ASSIGN_DIVIDE expression
| variable ASSIGN_MODULO expression
;

variable: ID
| ID LSQUARE expression RSQUARE
;

conditional: IF LPAREN expression RPAREN block ELSE block
| IF LPAREN expression RPAREN block
;

loop: WHILE LPAREN expression RPAREN block
| DO block WHILE LPAREN expression RPAREN SEMICOLON
| FOR LPAREN for_init for_condition for_update RPAREN block
| FOR LPAREN for_init for_condition RPAREN block
;

for_init: expression SEMICOLON
| variable_declaration expression SEMICOLON
| SEMICOLON
;

for_condition: expression SEMICOLON
| SEMICOLON
;

for_update: expression
| variable ASSIGN expression
;

method_call: ID LPAREN argument_list RPAREN
| ID DOT ID LPAREN argument_list RPAREN
;

argument_list: expression COMMA argument_list
| expression
|
;

array_literal: expression COMMA array_literal
| expression
;

break_statement: BREAK SEMICOLON
;

continue_statement: CONTINUE SEMICOLON
;

return_statement:
