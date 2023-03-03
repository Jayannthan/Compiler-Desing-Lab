% {
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
	  % }

	digit[0 - 9] letter[a - zA - Z] id({letter} | "_")({letter} | {digit}) *

	/* Define a structure to store identifier attributes */
	struct symtab
{
	char name;
	char *type;
	int size;
	char *value;
};

/* Declare the symbol table as an array of symtab structures */
struct symtab symbolTable[100];
int symbolTableSize = 0;

% %

	{id}
{
	/* Check if identifier is already in symbol table */
	int i;
	for (i = 0; i < symbolTableSize; i++)
	{
		if (strcmp(symbolTable[i].name, yytext) == 0)
		{
			printf("Symbol Table Entry --> name: %s, type: %s, size: %d, value: %s\n",
				   symbolTable[i].name, symbolTable[i].type, symbolTable[i].size, symbolTable[i].value);
			return;
		}
	}
	/* If identifier is not in symbol table, add it */
	symbolTable[symbolTableSize].name = strdup(yytext);
	symbolTable[symbolTableSize].type = NULL; // Prompt the user to enter the type
	printf("Enter type for identifier '%s': ", yytext);
	scanf("%s", symbolTable[symbolTableSize].type);

	printf("Enter size for identifier '%s': ", yytext);
	scanf("%d", &symbolTable[symbolTableSize].size);

	symbolTable[symbolTableSize].value = NULL; // Prompt the user to enter the value
	printf("Enter value for identifier '%s': ", yytext);
	scanf("%s", symbolTable[symbolTableSize].value);

	symbolTableSize++;

	printf("Added identifier '%s' to symbol table.\n", yytext);
}
" " {}; /* skip whitespace /
"\n" { } ; / skip newlines /
"\t" { } ; / skip tabs */

% %

	int yywrap(void)
{
}

int main(int argc, char *argv[])
{
	FILE *file;
	if (argc < 2)
	{
		fprintf(stderr, "Usage --> %s file\n", argv[0]);
		return 1;
	}

	file = fopen(argv[1], "r");
	if (file == NULL)
	{
		fprintf(stderr, "Error --> Unable to open file %s\n", argv[1]);
		return 1;
	}

	yyin = file;
	yylex();

	fclose(file);

	/* Print the symbol table */
	printf("\nSymbol Table:\n");
	int i;
	for (i = 0; i < symbolTableSize; i++)
	{
		printf("name: %s, type: %s, size: %d, value: %s\n",
			   symbolTable[i].name, symbolTable[i].type, symbolTable[i].size, symbolTable[i].value);
	}

	/* Free dynamically allocated memory */
	for (i = 0; i < symbolTableSize; i++)
	{
		free(symbolTable[i].name);
		free(symbolTable[i].type);
		free(symbolTable[i].value);
	}

	return 0;
