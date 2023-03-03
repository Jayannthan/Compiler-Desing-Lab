%{
#include<stdio.h>
#include<string.h>
%}


struct SymbolTableEntry {
    char* name;
    char* type;
    int size;
    char* value;
};

int symbolTableSize = 0;
struct SymbolTableEntry symbolTable[100];

digit [0-9]
letter [a-zA-Z]
id ({letter}|"_")({letter}|{digit})*
arithop ["+""-""*"\/"%"]
logicop (\&\&|\|\||\!)
relop [<>!]=?
bitwise "|"|"&"|"^"|"~"|"<<"|">>"
commentstart  "/*"
commentend  "*/"
assnop "="
datatype ("boolean"|"byte"|"short"|"int"|"long"|"float"|"double"|"char"|"String"|"void")
keyword ("abstract"|"assert"|"boolean"|"break"|"byte"|"case"|"catch"|"char"|"class"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extends"|"final"|"finally"|"float"|"for"|"if"|"implements"|"import"|"instanceof"|"int"|"interface"|"long"|"native"|"new"|"package"|"private"|"protected"|"public"|"return"|"short"|"static"|"strictfp"|"super"|"switch"|"synchronized"|"this"|"throw"|"throws"|"transient"|"try"|"void"|"volatile"|"while")
funcstart ("System.out.println"|"System.out.print"|"Math."|"String."|"Integer."|"Double."|"Float."|"Boolean."|"Character.")
%x COMMENT
spl [";""(",")""{""}"","]

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
