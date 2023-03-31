%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include "y.tab.h"
    int debug=0;
    int line=0;
%}
%%

[ \t]+ ;
\n {line++;}
[0-9]+ { if(debug)printf("%s is an integer\n", yytext);return INT;}
("int"|"float"|"double"|"byte"|"short"|"long"|"char"|"boolean") {if(debug)printf("%s is a data type\n", yytext);return DTYPE; }
"if" {return IF;}
"while" {return WHILE;}
"for" {return FOR;}
"else" {return ELSE;}
"do" {return DO;}
"switch" {return SWITCH;}
"case" {return CASE;}
"default" {return DEFAULT;}
"break" {return BREAK;}
"continue" {return CONTINUE;}
"return" {return RETURN;}
"this" {return THIS;}
"super" {return SUPER;}
"try" {return TRY;}
"catch" {return CATCH;}
"finally" {return FINALLY;}
"throw" {return THROW;}
"throws" {return THROWS;}
"new" {return NEW;}
"true"|"false" {if(debug)printf("%s is a boolean value\n", yytext);return BOOLEAN;}
[_a-zA-Z][a-zA-Z0-9_]* { if(debug)printf("%s is an identifier\n", yytext);return ID; }
";" {if(debug)printf("End of statement\n");return EOS;}
(">"|"<"|"<="|">="|"!="|"==") { return COMPARSION_OP; }
("+"|"-")?("=") { if(debug)printf("%s is an assign op\n", yytext);return ASSIGN_OP; }
">>" { return RSHIFT; }
"<<" {return LSHIFT; }
"!" { return NOT; }
"{" { return *yytext; }
"}" { return *yytext; }
"||" {return OR; }
"&&" {return AND; }
[+\-^*/%(),.:?] {return *yytext;}
"\""([^\\\"]|\\.)*\"" { if(debug)printf("%s is a string\n", yytext);return STRING; }
. {
  fprintf(stderr,"Unknown token found: <%s>\n", yytext);
}
%%

int main(){
	yyin=fopen("Quicksort.java","r");
	return 0;
}
