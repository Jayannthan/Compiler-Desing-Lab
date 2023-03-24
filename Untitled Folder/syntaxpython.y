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

%token INT FLOAT STRING ID TRUE FALSE AND OR NOT IF ELIF ELSE WHILE FOR IN RANGE DEF RETURN CLASS NONE IMPORT FROM AS GLOBAL NONLOCAL BREAK CONTINUE TRY EXCEPT FINALLY RAISE WITH YIELD ASSERT DEL PASS EOS

%%

program : statement EOS programPrime
        ;

programPrime:   program
            |
            ;

statement: assignment
        | declaration
        | conditional
        | looping
        | expr  {printf("Expression found!\n");}
        ;

assignment  : ID ASSIGN_OP expr {printf("Assignment statement found!\n");};

declaration : DTYPE ID ASSIGN_OP expr { printf("Declaration with assignment found!\n");}
            | DTYPE ID {printf("Declaration found!\n");}
            ;

conditional: IF expr ':' statement EOS optional ELIF expr ':' statement EOS optional else_block
            | IF expr ':' statement EOS optional else_block
            ;

else_block  : ELSE ':' statement EOS {printf("IF with else!\n");}
            |
            ;

looping : WHILE expr ':' statement EOS loop_optional
        | FOR ID IN expr ':' statement EOS loop_optional
        ;

loop_optional   : PASS EOS {printf("Loop statement found!\n");}
                | statement EOS
                | loop_optional
                ;

expr    : expr '+' expr 
        | expr '-' expr 
        | expr '*' expr 
        | expr '/' expr 
        | expr '**' expr 
        | expr AND expr 
        | expr OR expr 
        | NOT expr 
        | '(' expr ')' 
        | expr '<' expr 
        | expr '>' expr 
        | expr '<=' expr 
        | expr '>=' expr 
        | expr '==' expr 
        | expr '!=' expr 
        | ID
        | INT
        | FLOAT
        | STRING
        | TRUE
        | FALSE
        | NONE
        | list
        | tuple
        | dict
        | function_call
        | indexing
        | slicing
        | membership
        | attributes
        | yield_statement
        | lambda_expr
        | generator_expr
        ;

list    : '[' [expr_list] ']' ;
tuple   : '(' [expr_list] ')' ;
dict    : '{' [key_value_list] '}' ;

expr_list: expr [',' expr]* ;
key_value_list: expr ':' expr [',' key_value_list]* ;

function_call   : ID '(' [arg_list] ')' ;
arg_list        : [expr_list] [',' [kwargs | expr_list]] [',' [kwargs]] ;
kwargs          : ID '=' expr ;

indexing    : ID '[' expr ']' ;
slicing     : ID '[' [expr] ':' [expr] [':' [expr]] ']' ;
membership  : expr IN ID ;

attributes : ID '.' ID ;
yield_statement : YIELD [expr] ;
lambda_expr : 'lambda' [parameter_list] ':' expr ;
generator_expr : '(' expr [comp_for] ')' ;
comp_for : 'for' expr 'in' expr [comp_iter] ;
comp_iter: comp_for | comp_if ;
comp_if : 'if' expr [comp_iter] ;

parameter_list : ID [',' ID]* [',' '*' ID] [',' '**' ID] ;
%%

