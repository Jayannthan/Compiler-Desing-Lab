%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int yylex(void);
    int yyerror(char* s);
    extern int yylval;
    int debug=0;
    int line=0;
%}

%%

"public" { return PUBLIC; }
"class" { return CLASS; }
"static" { return STATIC; }
"void" { return VOID; }
"main" { return MAIN; }
"String" { return STRING; }
"args" { return ARGS; }
"int" { return INT; }
"while" { return WHILE; }
"if" { return IF; }
"else" { return ELSE; }
"System.out.println" { return PRINTLN; }
"+" { return PLUS; }
"-" { return MINUS; }
"<" { return LT; }
"=" { return ASSIGN; }
"{" { return LBRACE; }
"}" { return RBRACE; }
"(" { return LPAREN; }
")" { return RPAREN; }
";" { return SEMICOLON; }
" " { /* ignore whitespace / }
\n { / ignore newlines */ }
. {
  char msg[25];
  sprintf(msg,"Unknown token found: <%s>\n", yytext);
  yyerror(msg);
}
%%
