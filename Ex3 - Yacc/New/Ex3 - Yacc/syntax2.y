%{
    #include <stdlib.h>
    #include <stdio.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    /*extern int debug;*/
    extern int line;
%}

%token PPD NUM VOID ID EOS DTYPE LSHIFT RSHIFT NOT AND OR ARITH_OP INDE_OP ASSIGN_OP COMPARISON_OP IF ELSE WHILE FOR THIS CLASS PUBLIC PRIVATE

%%
program: statement program | statement;
statement : PPD
    | assgn_statement EOS
    | cond_statement
    | loop_block
    | '{' program '}'
    | declaration EOS;

loop_block  : for_loop | while_loop;

for_loop    : FOR '(' assign EOS pred EOS inde ')' statement

while_loop  : WHILE '(' expr ')' statement;

assign  : declaration | assgn_statement; 

declaration : DTYPE variable;

variable: variable ',' assgn_statement 
    | assgn_statement 
    | ID
    ;

cond_statement  : IF '(' expr ')' statement ELSE statement 
    | IF '(' expr ')' statement 
    ; 


assgn_statement: assgn_statement ASSIGN_OP expr
| ID;

expr    : expr ARITH_OP expr
        | expr AND expr 
        | expr OR expr 
        | NOT expr 
        | '(' expr ')' 
        | expr LSHIFT expr 
        | expr RSHIFT expr 
        | NUM
        | NUM '.' NUM 
        | ID
        | pred
        | inde
        ;

pred    : expr COMPARISON_OP expr;

inde    : expr INDE_OP;

%%

int yyerror(){
    fprintf(stderr, "syntax is NOT valid!Error at line %d\n", line);
    error = 1;
    return 0;
}

int yywrap(){
    return 1;
}

int main(int argc, char **argv){
    /*yydebug = 1;*/
    if(argc != 2){
        fprintf(stderr, "Enter file name as argument!\n");
        return 1;
    }
    yyin = fopen(argv[1], "rt");
    if (!yyin){
        fprintf(stderr, "File not found!\n");
        return 2;
    }
    yyparse();
    if(!error){
        printf("Valid syntax!\n");
    }
    return 0;
}