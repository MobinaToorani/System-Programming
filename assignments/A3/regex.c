#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char inputFile[260]; // Buffer size for the file name
    char outputFile[260]; // Buffer for the output file name

    // Prompt user input for the email file
    printf("Please input the file containing email addresses: ");
    if (scanf("%259s", inputFile) != 1) {
        fprintf(stderr, "Error reading input file name.\n");
        return EXIT_FAILURE;
    }

    // Prompt for the output file name
    printf("Enter the name of the output file for valid emails: ");
    scanf("%259s", outputFile);

    // Construct the grep command to filter valid email patterns
    char grepCmd[1024];
    snprintf(grepCmd, sizeof(grepCmd),
         "grep -P '^([a-zA-Z0-9_+]+([.-][a-zA-Z0-9_+]+)*)@[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$' %s > %s",
         inputFile, outputFile);

    // Execute the command to filter emails
    if (system(grepCmd) == -1) {
        perror("Failed to execute grep command");
        return EXIT_FAILURE;
    } else {
        printf("Filtered valid emails are saved in %s\n", outputFile);
    }

    return EXIT_SUCCESS;
}
