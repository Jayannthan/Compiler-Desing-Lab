
%{
 #include <stdio.h>
 #include <stdlib.h>
    #include <fcntl.h>
    #include <unistd.h>
    int yylex(void);
    extern FILE* yyin;
    #include "y.tab.h"
    int error = 0;
    extern int line;
%}

%token DEF FOR IN IF ELSE RETURN ARITHMETIC_OP RELATIONAL_OP ASSIGNMENT_OP ID NUM LIST

%%
long_stmt: statement long_stmt
         | statement
         ;

statement: DEF ID '(' expr ')' ':' '~' long_stmt '@'
        | FOR ID IN ID '(' expr ')' ':' '~' long_stmt '@'
        | cond_stmt
        | RETURN ID 
        | assign_statement
;

cond_stmt: IF expr ':' '~' long_stmt '@' ELSE ':' '~' long_stmt '@'
         | IF expr ':' '~' long_stmt '@'
;

assign_statement: assign_statement ASSIGNMENT_OP expr
                | expr
;

expr: expr ARITHMETIC_OP expr 
    | expr RELATIONAL_OP expr 
    | expr ',' expr
    | ID '(' expr ')' 
    | ID 
    | NUM 
    | ID '[' ID ']' 
    | LIST
;

%%

int yyerror(){
    fprintf(stderr, "Syntax is NOT valid!\nError at line: %d\n", line);
    error = 1;
    return 0;
}

int yywrap(){
    return 1;
}

int main(int argc, char** argv){
    yyin = fopen(argv[1], "rt");
    if(!yyin)
    {
        printf("File not found!\n");
        return 0;
    }
    yyparse();
    if(!error){
        printf("The input program has a valid syntax!\n");
    }
    return 0;
}

