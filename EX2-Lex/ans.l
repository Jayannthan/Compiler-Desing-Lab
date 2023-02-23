%{
#include<stdio.h>
#include<string.h>
%}

digit [0-9]
letter [a-zA-Z]
id ({letter}|"_")({letter}|{digit})*
arithop ["+""-""*"\/"%"]
logicop (\&\&|\|\||\!)
relop [<>!]
bitwise "|"|"&"|"^"|"~"|"<<"|">>"
commentstart  "/*"
commentend  "*/"
assnop "="
datatype ("char"|"double"|"int"|"float"|"long"|"short"|"signed"|"unsigned"|"void")
keyword ("auto"|"break"|"case"|"const"|"continue"|"default"|"do"|"else"|"enum"|"extern"|"for"|"goto"|"if"|"register"|"return"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"void"|"volatile"|"while")
funcstart ("printf"|"scanf"|"getch"|"clrscr"|"main")
%x COMMENT
spl [";","(",")","{","}",","]


%%
#.*>           printf("Preprocessor Directive --> %s\n", yytext);
{keyword}       printf("Keyword --> %s\n", yytext); 
{datatype}       printf("datatype --> %s\n", yytext); 
{funcstart}.* printf("function call --> %s\n", yytext); 

"/*"            { BEGIN(COMMENT); printf("Multiline comment --> %s\n", yytext);}
<COMMENT>"*/"   { BEGIN(INITIAL); printf("%s\n", yytext); }



"//"(.*)$      printf("Singleline Comment --> %s\n", yytext);
{digit}+      printf("Number --> %s\n", yytext);
{id}          printf("Identifier --> %s\n", yytext);
{bitwise}          printf("bitwise operator --> %s\n", yytext);
{arithop} printf("Arithmetic operator --> %s\n", yytext);
{arithop}{assnop} printf("Arithmetic assignment operator --> %s\n", yytext);
{relop}       printf("Relational operator --> %s\n", yytext);
{assnop} printf("assignment operator --> %s\n", yytext);
{relop}{assnop}       printf("Relational assignment operator --> %s\n", yytext);
{assnop}{assnop}       printf("Relational operator --> %s\n", yytext);
{logicop}       printf("Logical operator --> %s\n", yytext);
{spl}			printf("Spl char --> %s\n", yytext);
" " { } ;           /* skip whitespace */
"\n" { } ;             /* skip newlines */
"\t" { } ;             /* skip tabs */

%%

int yywrap(void){}

int main(int argc, char* argv[]) {
    FILE *file;

    if (argc < 2) {
        fprintf(stderr, "Usage --> %s file\n", argv[0]);
        return 1;
    }

    file = fopen(argv[1], "r");
    if (file == NULL) {
        fprintf(stderr, "Error --> Unable to open file %s\n", argv[1]);
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);
    return 0;
}
