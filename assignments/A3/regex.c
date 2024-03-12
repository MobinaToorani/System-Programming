#include <stdio.h>
#include <stdlib.h>


int main() {
	char input_file[256];
	char output_file[256];
	char command[BUFSIZ];

	FILE *file;
	printf("Enter the name of the input file: ");
    scanf("%s", input_file);

	file = fopen(input_file, "r");
	if (file == 0){
		fprintf(stderr, "Error opening input file: No such file or directory\n");
		return 1;
	}

	fclose(file);

	printf("Enter the name of the output file for valid emails: ");
	scanf("%s", output_file);

	sprintf(command, "grep -P '^([a-zA-Z0-9_+]+([.-][a-zA-Z0-9_+]+)*)@[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$' %s > %s", 
             input_file, output_file);
	system(command);
	
	printf("Valid emails extracted and saved to %s\n", output_file);
	return 0;
}