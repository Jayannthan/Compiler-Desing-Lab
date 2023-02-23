#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Symbol Table
struct symbol_table
{
	char name[100], type[100], value[100];
	int bytes, address;
};

// Checking if the string is an operator
int isop(char str[])
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
void lex_op(int op)
{
	if (op == 1)
	{
		printf(" - Arithmetic operator\n");
	}
	else if (op == 2)
	{
		printf(" - Arithmetic assignment operator\n");
	}
	else if (op == 3)
	{
		printf(" - Logical operator\n");
	}
	else if (op == 4)
	{
		printf(" - Relational operator\n");
	}
	else if (op == 5)
	{
		printf(" - Bitwise operator\n");
	}
	else if (op == 6)
	{
		printf(" - Unary operator\n");
	}
	else if (op == 7)
	{
		printf(" - Assignment operator\n");
	}
	else if (op == 8)
	{
		printf(" - Special character\n");
	}
}

// Checking if the string is a keyword
int iskey(char str[])
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
int isdatatype(char str[])
{
	if (!strcmp(str, "char") || !strcmp(str, "double") || !strcmp(str, "float") || !strcmp(str, "int") || !strcmp(str, "long") || !strcmp(str, "short") || !strcmp(str, "signed") || !strcmp(str, "unsigned") || !strcmp(str, "void"))
	{
		return 1;
	}
	return 0;
}

int isfunc(char str[])
{
	if (!strcmp(str, "printf") || !strcmp(str, "scanf") || !strcmp(str, "getch") || !strcmp(str, "clrscr") || !strcmp(str, "main"))
	{
		return 1;
	}
	return 0;
}

// Checking if the sybmol is in the symbol table
int in_symbol_table(struct symbol_table st[], int st_size, char str[])
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

int no_of_bytes(char str[])
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

int main()
{
	// Reading the file and storing in input buffer
	FILE *f = fopen("1.c", "r+");

	char ch;
	char lex_analyse[100], var[100], str[100], str1[100], str2[100], ipbuf[1024], datatype[100], cur_var[100], assigned_val[100];
	int s = 0, address_ptr = 2000;

	struct symbol_table st[100];
	int st_size = 0;

	while (!feof(f))
	{
		fscanf(f, "%c", &ch);
		ipbuf[s] = ch;
		s++;
	}
	ipbuf[s] = '\0';

	// Reading characters from input buffer and checking
	printf("TOKENS\n");
	int k = 0;
	while (k < s)
	{
		int j = 0;
		if (ipbuf[k] == '/' && ipbuf[k + 1] == '/')
		{
			while (ipbuf[k] != '\n')
			{
				lex_analyse[j] = ipbuf[k];
				j++;
				k++;
			}
			lex_analyse[j] = '\0';
			printf("%s - Single line comment\n", lex_analyse);
		}
		else if (ipbuf[k] == '/' && ipbuf[k + 1] == '*')
		{
			lex_analyse[0] = '/';
			lex_analyse[1] = '*';
			j = 2;
			k += 2;
			while (ipbuf[k] != '*' && ipbuf[k + 1] != '/')
			{
				lex_analyse[j] = ipbuf[k];
				j++;
				k++;
			}
			lex_analyse[j] = '*';
			lex_analyse[j + 1] = '/';
			lex_analyse[j + 2] = '\0';
			j += 2;
			k += 2;
			printf("%s - Multiline comment\n", lex_analyse);
		}
		else if (ipbuf[k] == '#')
		{
			while (ipbuf[k] != '\n')
			{
				lex_analyse[j] = ipbuf[k];
				j++;
				k++;
			}
			lex_analyse[j] = '\0';
			printf("%s - Preprocessor directive\n", lex_analyse);
		}
		else if (ipbuf[k] == '\n' || ipbuf[k] == ' ')
		{
			k++;
			continue;
		}
		else
		{
			str1[0] = ipbuf[k];
			str1[1] = '\0';
			int op1, op2;
			if ((op1 = isop(str1)))
			{
				str2[0] = ipbuf[k];
				str2[1] = ipbuf[k + 1];
				str2[2] = '\0';
				if ((op2 = isop(str2)))
				{
					printf("%s", str2);
					lex_op(op2);
					k += 2;
				}
				else
				{
					printf("%s", str1);
					lex_op(op1);
					k++;
					if (op1 == 7) // Assignment operator
					{
						str[0] = ipbuf[k];
						str[1] = '\0';
						int ind = 0, k_ind = k;
						while (strcmp(str, ",") && strcmp(str, ";") && ipbuf[k_ind] != '\n')
						{
							assigned_val[ind] = ipbuf[k_ind];
							ind++;
							k_ind++;
							str[0] = ipbuf[k_ind];
							str[1] = '\0';
						}
						assigned_val[ind] = '\0';
						int pos = in_symbol_table(st, st_size, var);
						strcpy(st[pos].value, assigned_val);
					}
				}
			}
			else
			{
				int s = 0;
				str[0] = ipbuf[k];
				str[1] = '\0';
				while (!isop(str) && ipbuf[k] != ' ' && ipbuf[k] != '\n')
				{
					var[s] = ipbuf[k];
					s++;
					k++;
					str[0] = ipbuf[k];
					str[1] = '\0';
				}
				var[s] = '\0';
				if (iskey(var))
				{
					printf("%s - Keyword\n", var);
					if (isdatatype(var))
					{
						strcpy(datatype, var);
					}
				}
				else if (isfunc(var))
				{
					while (ipbuf[k] != ';' && ipbuf[k] != '\n')
					{
						var[s] = ipbuf[k];
						s++;
						k++;
					}
					var[s] = '\0';
					printf("%s - Function call\n", var);
				}
				else
				{
					if (atoi(var))
					{
						printf("%s - Number\n", var);
					}
					else
					{
						int s_ind = 0;
						if (var[s_ind] == '"')
						{
							s_ind++;
							while (var[s_ind] != '"')
							{
								s_ind++;
							}
						}
						else
						{
							printf("%s - Identifier\n", var);
							strcpy(cur_var, var);
							if (in_symbol_table(st, st_size, var) == -1)
							{
								strcpy(st[st_size].name, var);
								strcpy(st[st_size].type, datatype);
								st[st_size].bytes = no_of_bytes(datatype);
								st[st_size].address = address_ptr;
								address_ptr += st[st_size].bytes;
								if (!strcmp(var, "double") || !strcmp(var, "float"))
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
	}

	printf("\nSYMBOL TABLE\nIdentifier Name\t\tType\tNo. of Bytes\tAddress\t\tValue\n");
	for (int i = 0; i < st_size; i++)
	{
		// if (strstr(st[i].name, "return"))
		// {
		// 	continue;
		// }
		printf("%s\t\t\t\t\t%s\t\t%d\t\t\t\t%d\t\t%s\n", st[i].name, st[i].type, st[i].bytes, st[i].address, st[i].value);
	}
}
