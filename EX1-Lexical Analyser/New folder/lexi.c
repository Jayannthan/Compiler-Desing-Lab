#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Symbol Table
struct symbol_table
{
	char name[100], type[100], value[100];
	int bytes, address;
};

struct symbol_table st[100];

int isPreProcDir(char inputBuffer[1024], int currIndex)
{
	char preprocdir[100];
	int j = 0;
	while (inputBuffer[currIndex] != '>')
	{
		preprocdir[j] = inputBuffer[currIndex];
		j++;
		currIndex++;
	}
	preprocdir[j] = inputBuffer[currIndex];
	preprocdir[++j] = '\0';

	printf("%s \t-->\t Preprocessor directive\n", preprocdir);
	return currIndex;
}

int isSingleLineComment(char inputBuffer[1024], int currIndex)
{
	int j = 0;
	char linecomment[100];
	while (inputBuffer[currIndex] != '\n')
	{
		linecomment[j] = inputBuffer[currIndex];
		j++;
		currIndex++;
	}
	linecomment[j] = '\0';
	printf("%s \t-->\t Single line comment\n", linecomment);
	return currIndex;
}

int isMultiLineComment(char inputBuffer[1024], int currIndex)
{
	char linecomment[100];
	int j = 0;

	while (!(inputBuffer[currIndex] == '*' && inputBuffer[currIndex + 1] == '/'))
	{
		linecomment[j] = inputBuffer[currIndex];
		j++;
		currIndex++;
	}
	linecomment[j] = '*';
	linecomment[j + 1] = '/';
	linecomment[j + 2] = '\0';
	j += 2;
	currIndex += 2;
	printf("%s \t-->\t Multiline comment\n", linecomment);
	return currIndex;
}

// Checking if the string is an operator
int isOperand(char str[])
{
	if (!strcmp(str, "+") || !strcmp(str, "-") || !strcmp(str, "*") || !strcmp(str, "/") || !strcmp(str, "%"))
	{
		return 1;
	}
	else if (!strcmp(str, "+=") || !strcmp(str, "-=") || !strcmp(str, "*=") || !strcmp(str, "/=") || !strcmp(str, "%="))
	{
		return 2;
	}
	else if (!strcmp(str, "&&") || !strcmp(str, "||") || !strcmp(str, "!"))
	{
		return 3;
	}
	else if (!strcmp(str, "<") || !strcmp(str, "<=") || !strcmp(str, ">") || !strcmp(str, ">=") || !strcmp(str, "==") || !strcmp(str, "!="))
	{
		return 4;
	}
	else if (!strcmp(str, "^") || !strcmp(str, "&") || !strcmp(str, "|") || !strcmp(str, "<<") || !strcmp(str, ">>"))
	{
		return 5;
	}
	else if (!strcmp(str, "++") || !strcmp(str, "--"))
	{
		return 6;
	}
	else if (!strcmp(str, "="))
	{
		return 7;
	}
	else if (!strcmp(str, ";") || !strcmp(str, ",") || !strcmp(str, ".") || !strcmp(str, "[") || !strcmp(str, "]") || !strcmp(str, "(") || !strcmp(str, ")") || !strcmp(str, "{") || !strcmp(str, "}"))
	{
		return 8;
	}
	else
		return 0;
}

// Printing the type of operator based on the type number
void operater_output(int op)
{
	if (op == 1)
	{
		printf(" \t-->\t Arithmetic operator\n");
	}
	else if (op == 2)
	{
		printf(" \t-->\t Arithmetic and assignment operator\n");
	}
	else if (op == 3)
	{
		printf(" \t-->\t Logical operator\n");
	}
	else if (op == 4)
	{
		printf(" \t-->\t Relational operator\n");
	}
	else if (op == 5)
	{
		printf(" \t-->\t Bitwise operator\n");
	}
	else if (op == 6)
	{
		printf(" \t-->\t Unary operator\n");
	}
	else if (op == 7)
	{
		printf(" \t-->\t Assignment operator\n");
	}
	else if (op == 8)
	{
		printf(" \t-->\t Special character\n");
	}
}

// Checking if the string is a keyword
int isKeyword(char str[])
{
	char keywords[][100] = {"auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else", "enum", "extern", "float", "for", "goto", "if", "int", "long", "register", "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"};

	for (int i = 0; i < 32; i++)
	{
		if (!strcmp(str, keywords[i]))
		{
			return 1;
		}
	}
	return 0;
}

// Checking if the string is a datatype (used to store in the symbol table)
int isDataType(char str[])
{
	if (!strcmp(str, "char") || !strcmp(str, "double") || !strcmp(str, "float") || !strcmp(str, "int") || !strcmp(str, "long") || !strcmp(str, "short") || !strcmp(str, "signed") || !strcmp(str, "unsigned") || !strcmp(str, "void"))
	{
		return 1;
	}
	return 0;
}

int isFunction(char str[])
{
	if (!strcmp(str, "printf") || !strcmp(str, "scanf") || !strcmp(str, "getch") || !strcmp(str, "clrscr") || !strcmp(str, "main"))
	{
		return 1;
	}
	return 0;
}

// Checking if the sybmol is in the symbol table
int checkSymTable(struct symbol_table st[], int st_size, char str[])
{

	for (int i = 0; i <= st_size; i++)
	{
		if (!strcmp(st[i].name, str))
		{
			return i;
		}
	}
	return -1;
}

int returnVarSize(char str[])
{
	if (!strcmp(str, "char"))
	{
		return 1;
	}
	else if (!strcmp(str, "double"))
	{
		return 8;
	}
	else if (!strcmp(str, "float"))
	{
		return 4;
	}
	else if (!strcmp(str, "int"))
	{
		return 4;
	}
	else if (!strcmp(str, "long"))
	{
		return 8;
	}
	else if (!strcmp(str, "short"))
	{
		return 2;
	}
	else if (!strcmp(str, "signed"))
	{
		return 4;
	}
	else if (!strcmp(str, "unsigned"))
	{
		return 4;
	}
	return 0;
}

int isComment(char inputBuffer[1024], int currIndex)
{
	int j = 0;
	char linecomment[100];
	while (inputBuffer[currIndex] != '\n')
	{
		linecomment[j] = inputBuffer[currIndex];
		j++;
		currIndex++;
	}
	linecomment[j] = '\0';
	printf("%s \t-->\t Single line comment\n", linecomment);
	return currIndex;
}

int main()
{
	FILE *f = fopen("4.c", "r+");

	char ch;
	char variable[100], str[100], inputBuffer[1024], datatype[100], cur_var[100], assigned_val[100];
	int fileIndex = 0, address_ptr = 2000;

	int st_size = 0;

	while (!feof(f))
	{
		fscanf(f, "%c", &ch);
		inputBuffer[fileIndex] = ch;
		fileIndex++;
	}
	inputBuffer[fileIndex] = '\0';

	// printf("ipubf %s", inputBuffer);
	// Reading characters from input buffer and checking
	int g = 0;
	printf("\n------------------------TOKENS------------------------\n\n");
	int currIndex = 0;
	while (currIndex < fileIndex)
	{
		if (g == 0)
		{
			g++;
			printf("%d.  ", g);
		}

		int j = 0;
		if (inputBuffer[currIndex] == '#')
		{
			currIndex = isPreProcDir(inputBuffer, currIndex);
			currIndex++;
		}

		else if (inputBuffer[currIndex] == '/' && inputBuffer[currIndex + 1] == '/')
		{
			currIndex = isSingleLineComment(inputBuffer, currIndex);
		}

		else if (inputBuffer[currIndex] == '/' && inputBuffer[currIndex + 1] == '*')
		{
			currIndex = isMultiLineComment(inputBuffer, currIndex);
		}

		else if (inputBuffer[currIndex] == '\n' || inputBuffer[currIndex] == ' ' || inputBuffer[currIndex] == '\t')
		{
			currIndex++;
			continue;
		}

		else
		{
			char operand1[5], operand2[5];
			operand1[0] = inputBuffer[currIndex];
			operand1[1] = '\0';
			int op1, op2;
			if (op1 = isOperand(operand1))
			{
				operand2[0] = inputBuffer[currIndex];
				operand2[1] = inputBuffer[currIndex + 1];
				operand2[2] = '\0';
				if (op2 = isOperand(operand2))
				{
					printf("%s", operand2);
					operater_output(op2);
					currIndex += 2;
				}
				else
				{
					printf("%s", operand1);
					operater_output(op1);
					currIndex++;
					if (op1 == 7) // Assignment operator
					{
						str[0] = inputBuffer[currIndex];
						str[1] = '\0';
						int ind = 0, k_ind = currIndex;
						while (strcmp(str, ",") && strcmp(str, ";") && inputBuffer[k_ind] != '\n')
						{
							assigned_val[ind] = inputBuffer[k_ind];
							ind++;
							k_ind++;
							str[0] = inputBuffer[k_ind];
							str[1] = '\0';
						}
						assigned_val[ind] = '\0';

						int pos = checkSymTable(st, st_size, variable);
						strcpy(st[pos].value, assigned_val);
					}
				}
			}
			else
			{
				int fileIndex = 0;
				str[0] = inputBuffer[currIndex];
				str[1] = '\0';
				while (!isOperand(str) && inputBuffer[currIndex] != ' ' && inputBuffer[currIndex] != '\n')
				{
					variable[fileIndex] = inputBuffer[currIndex];
					fileIndex++;
					currIndex++;
					str[0] = inputBuffer[currIndex];
					str[1] = '\0';
				}
				variable[fileIndex] = '\0';
				if (isKeyword(variable))
				{
					printf("%s \t-->\t Keyword\n", variable);
					if (isDataType(variable))
					{
						strcpy(datatype, variable);
					}
				}
				else if (isFunction(variable))
				{
					while (inputBuffer[currIndex] != ';' && inputBuffer[currIndex] != '\n')
					{
						variable[fileIndex] = inputBuffer[currIndex];
						fileIndex++;
						currIndex++;
					}
					variable[fileIndex] = '\0';
					printf("%s \t-->\t Function call\n", variable);
				}
				else
				{
					if (atoi(variable))
					{
						printf("%s \t-->\t Number\n", variable);
					}
					else
					{
						int s_ind = 0;
						if (variable[s_ind] == '"')
						{
							s_ind++;
							while (variable[s_ind] != '"')
							{
								s_ind++;
							}
						}
						else
						{
							printf("%s \t-->\t Identifier\n", variable);
							strcpy(cur_var, variable);
							if (checkSymTable(st, st_size, variable) == -1)
							{
								strcpy(st[st_size].name, variable);
								strcpy(st[st_size].type, datatype);
								st[st_size].bytes = returnVarSize(datatype);
								st[st_size].address = address_ptr;
								address_ptr += st[st_size].bytes;
								if (!strcmp(variable, "double") || !strcmp(variable, "float"))
								{
									strcpy(st[st_size].value, "0.0");
								}
								else
								{
									strcpy(st[st_size].value, "0");
								}
								st_size++;
							}
						}
					}
				}
			}
		}
		g++;
		printf("\n%d.  ", g);
	}
	printf("\n------------------------------------------------------\n\n");
	printf("\n------------------------------SYMBOL TABLE--------------------------------\n");

	printf("\nIdentifier\tType\t\tBytes\t\tAddress\t\tValue\n");
	for (int i = 0; i < st_size; i++)
	{
		if (strcmp(st[i].name, "0") == 0)
		{
			continue;
		}
		printf("%s\t\t%s\t\t%d\t\t%d\t\t%s\n", st[i].name, st[i].type, st[i].bytes, st[i].address, st[i].value);
	}
	printf("\n--------------------------------------------------------------------------\n\n");
	return 0;
}
