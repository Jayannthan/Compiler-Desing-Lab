#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main()
{
	FILE *input_file;
	FILE *output_file;
	char line[100];
	int label_count = 0;

	// Open the input and output files
	input_file = fopen("input.txt", "r");
	output_file = fopen("output.txt", "w");

	// Loop through each line in the input file
	while (fgets(line, 100, input_file))
	{
		char op[10], arg1[10], arg2[10], result[10];
		sscanf(line, "%[^=]=%[^,],%[^=]=%[^,],%[^=]=%s", result, arg1, result, arg2, result, result);

		// Generate assembly code based on the operation
		if (strcmp(arg1, "0") == 0)
		{
			fprintf(output_file, "MOV R0,#%s\n", arg1);
		}
		if (strcmp(op, "if") == 0)
		{
			fprintf(output_file, "L%d: CMP R%d, #%s\n", ++label_count, atoi(arg1) + 1, arg2);
			fprintf(output_file, "JLE L%d\n", ++label_count);
		}
		else if (strcmp(op, "goto") == 0)
		{
			fprintf(output_file, "JMP L%s\n", arg1);
		}
		else if (strcmp(op, "+") == 0)
		{
			fprintf(output_file, "ADD R0,R%d\n", atoi(arg1) + 1);
		}
		else if (strcmp(op, "=") == 0)
		{
			fprintf(output_file, "MOV R%d,#%s\n", atoi(result) + 1, arg1);
		}
		else if (strcmp(op, "<=") == 0)
		{
			fprintf(output_file, "CMP R%d,#%s\n", atoi(arg1) + 1, arg2);
		}
		else if (strcmp(op, "+") == 0)
		{
			fprintf(output_file, "ADD R%d,#%s\n", atoi(arg1) + 1, arg2);
		}
		else
		{
			printf("Error: Unsupported operation '%s'\n", op);
			return 1;
		}
	}

	// Close the input and output files
	fclose(input_file);
	fclose(output_file);

	return 0;
}
