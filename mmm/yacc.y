%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    extern int line;
    int yylex(void);
    void yyerror(char *);
%}

%token INT DTYPE IF WHILE FOR ELSE DO SWITCH CASE DEFAULT
%token BREAK CONTINUE RETURN THIS SUPER TRY CATCH FINALLY
%token THROW THROWS NEW BOOLEAN ID EOS COMPARSION_OP ASSIGN_OP
%token RSHIFT LSHIFT NOT OR AND STRING

%%

program :
    /* empty */
    | program statement EOS
    ;

statement :
    expression
    | selection_statement
    | iteration_statement
    | jump_statement
    ;

expression :
    assignment_expression
    | expression COMPARSION_OP expression
    | expression OR expression
    | expression AND expression
    | NOT expression
    ;

assignment_expression :
    logical_OR_expression
    | unary_expression ASSIGN_OP assignment_expression
    ;

logical_OR_expression :
    logical_AND_expression
    | logical_OR_expression OR logical_AND_expression
    ;

logical_AND_expression :
    inclusive_OR_expression
    | logical_AND_expression AND inclusive_OR_expression
    ;

inclusive_OR_expression :
    exclusive_OR_expression
    | inclusive_OR_expression "|" exclusive_OR_expression
    ;

exclusive_OR_expression :
    AND_expression
    | exclusive_OR_expression "^" AND_expression
    ;

AND_expression :
    equality_expression
    | AND_expression "&" equality_expression
    ;

equality_expression :
    relational_expression
    | equality_expression "==" relational_expression
    | equality_expression "!=" relational_expression
    ;

relational_expression :
    shift_expression
    | relational_expression "<" shift_expression
    | relational_expression ">" shift_expression
    | relational_expression "<=" shift_expression
    | relational_expression ">=" shift_expression
    ;

shift_expression :
    additive_expression
    | shift_expression LSHIFT additive_expression
    | shift_expression RSHIFT additive_expression
    ;

additive_expression :
    multiplicative_expression
    | additive_expression "+" multiplicative_expression
    | additive_expression "-" multiplicative_expression
    ;

multiplicative_expression :
    unary_expression
    | multiplicative_expression "*" unary_expression
    | multiplicative_expression "/" unary_expression
    | multiplicative_expression "%" unary_expression
    ;

unary_expression :
    postfix_expression
    | "+" unary_expression
    | "-" unary_expression
    | NOT unary_expression
    ;

postfix_expression :
    primary_expression
    | postfix_expression "." ID
    | postfix_expression "(" argument_list ")"
    | postfix_expression "[" expression "]"
    | ID "(" argument_list ")"
    | ID "[" expression "]"
    ;

primary_expression :
    constant
    | ID
    | STRING
    | "(" expression ")"
    ;

constant :
    INT
    | BOOLEAN
    ;

argument_list :
    /* empty */
    | assignment_expression
    | argument_list "," assignment_expression
    ;

selection_statement :
    IF "(" expression ")" statement
    | IF "(" expression ")" statement ELSE statement
    ;

iteration_statement :
    WHILE "(" expression ")" statement
    | DO statement WHILE "(" expression ")" EOS
    | FOR "(" expression EOS expression EOS expression ")" statement
    ;

jump_statement :
    BREAK EOS
    | CONTINUE EOS
    | RETURN EOS
    | RETURN expression EOS
    | THROW expression EOS
    ;

%%
void yyerror(char *s) {
    fprintf(stderr, "Error at line %d: %s\n", line, s);
}

int main() {
    yyparse();
    return 0;
}

