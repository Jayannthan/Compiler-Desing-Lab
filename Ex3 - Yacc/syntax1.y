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

%token NUM DTYPE EOS PPD IF WHILE FOR ELSE ID COMPARISON_OP ASSIGN_OP INDE_OP RSHIFT LSHIFT NOT OR AND ARITH_OP NEW THIS CLASS PUBLIC PRIVATE STATIC

%%
program:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

method_declaration:
    PUBLIC STATIC DTYPE ID '(' DTYPE ID ',' DTYPE ID ')' '{' statement_list '}' 
    | PUBLIC DTYPE ID '(' DTYPE ID ')' '{' statement_list '}' 
    | PUBLIC DTYPE ID '(' DTYPE ID ',' DTYPE ID ')' '{' statement_list '}' 
    | PUBLIC DTYPE ID '(' DTYPE ID ',' DTYPE ID ',' DTYPE ID ')' '{' statement_list '}' 
    ;

class_declaration:
    PUBLIC CLASS ID '{' statement_list '}'
    | CLASS ID '{' statement_list '}'
    | CLASS DTYPE ID '{' method_declaration '}' EOS
    ;

statement:
    declaration_statement
    | assignment_statement
    | comparison_statement
    | logical_statement
    | increment_decrement_statement
    | block_statement
    | selection_statement
    | iteration_statement
    | method_declaration
    | class_declaration
    ;

declaration_statement:
    DTYPE ID EOS
    |
    ;

assignment_statement:
    ID ASSIGN_OP expression EOS
    ;

comparison_statement:
    expression COMPARISON_OP expression EOS
    ;

logical_statement:
    expression OR expression EOS
    | expression AND expression EOS
    | NOT expression EOS
    ;

increment_decrement_statement:
    ID INDE_OP EOS
    ;

block_statement:
    '{' statement_list '}'
    ;

selection_statement:
    IF '(' expression ')' statement
    | IF '(' expression ')' statement ELSE statement
    ;

iteration_statement:
    WHILE '(' expression ')' statement
    | FOR '(' assignment_statement comparison_statement increment_decrement_statement ')' statement
    ;

expression:
    ID
    | NUM
    | NEW ID
    | THIS
    | expression ARITH_OP expression
    | '(' expression ')'
    ;

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