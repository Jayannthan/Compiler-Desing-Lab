%{
	#include<stdio.h>
	int yylex(void);
	int yyerror();
	#include <fcntl.h>
	#include <unistd.h>
	#include "y.tab.h"
	int flag = 0;
	extern FILE * yyin;
	int error = 0;
	
%}

%token IMPORT CLASS ID PUBLIC STATIC
%token INT STRING VOID NUMBER
%token IF ELSE FOR RETURN LENGTH PRINT WHILE
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%
START: S{return 0;}
;

S: IMPORTS MCL
;

IMPORTS: IMPORTS IMPORT';'
	| IMPORT';'
;

MCL: MCL CL
	| CL
;

CL: CLASS ID BLOCK
	|PUBLIC CLASS ID BLOCK
;

BLOCK: '{' LINES '}'
	| LINE
;

LINES: LINES LINE
	| LINE
;

LINE: FN | ST
;

FN: T ID '(' PARAS ')' BLOCK
	| FAS FN
	| QL FN
;

PARAS: PARAS ',' PARA
	| PARA
;

PARA: T ID
	| T '['']' ID
	| ;
	
FAS: PUBLIC ;
	
QL: STATIC ;
	
ST: DL';'
	| AS';'
	| FORS
	| IFS
	| RT';'
	| PRINT';'
	| while_loop
;
while_loop: WHILE '(' EXP ')' BLOCK;

DL: T V
	| T '[' ']' V
;

V: V ',' AS
	| AS
;

AS: AS '=' EXP
	| EXP
;

EXP: E A EXP
	| E R EXP
	| E
	| E INC
	| '(' EXP ')'
	| FNC
	| E '.' ATT
	| ARR
;

FORS: FOR '(' FD ';' FC ';' FU ')' BLOCK
;

FD: DL
	| ;
	
FC: EXP
	| ;
	
FU: ID INC
	| ;
	
IFS: IF '(' EXP ')' BLOCK
	|IF '(' EXP ')' BLOCK ELSE BLOCK
;

FNC: ID '(' FP ')'
;

FP: EXP
	| FP ',' EXP
;

RT: RETURN EXP;

E: ID
	| NUMBER
	| ID '[' E ']'
;

ARR: '{' NUMS '}';

NUMS: NUMS ',' NUMBER
	| NUMBER
;
	
ATT: LENGTH;
	
INC: '+''+'
	| '-''-'
;

A: '+'
	| '-'
	| '*' 	
	| '/' 	
	| '%'
;

R: '<''=' 	
	| '<' 	
	| '>''=' 	
	| '>' 	
	| '!''='
;

T: INT
	| VOID
	| STRING
;

%%

int yyerror() {
    fprintf(stderr, "Syntax is NOT valid!\n");
    error = 1;
    return 0;

}
int yywrap() {
    return 1;

}
int main(int args, char * argv[]) {
    yyin = fopen(argv[1], "rt");
    if (!yyin) {
        printf("File not found!\n");
        return 0;
    }
    yyparse();

    if (!error) {
        printf("The input program has a valid syntax!\n");

    }
    return 0;

}
