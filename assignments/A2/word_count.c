#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 1024

int count_words(const char *line) {
    int words = 0;
    const char *p = line;
    while (*p) {
        while (*p == ' ' || *p == '\t' || *p == '\n')
            ++p;
        if (*p)
            ++words;
        while (*p && *p != ' ' && *p != '\t' && *p != '\n')
            ++p;
    }
    return words;
}

int main() {
    char file_name[256];
    char line[MAX_LINE_LENGTH];
    char in_user;
    int lines, words;
    float average;

    printf("This program counts the number of lines and words of a file\n");
    while (1) {
        printf("Enter f for entering file name, q to quit: ");
        scanf(" %c", &in_user); 

        if (in_user == 'q') // Exit condition
            break;

        if (in_user == 'f') { // File processing condition
            printf("Enter file name: ");
            scanf("%s", file_name); 

            FILE *file = fopen(file_name, "r");

            if (file == NULL) {
                printf("%s cannot be opened\n\n", file_name);
                continue;
            }

            lines = words = 0;
            printf("Content of %s:\n\n", file_name); 
            while (fgets(line, MAX_LINE_LENGTH, file)) {
                printf("%s", line); 
                if (line[strlen(line) - 1] != '\n') {
                    printf("\n"); // Ensure each line ends with a newline
                }
                ++lines;
                words += count_words(line);
            }
            fclose(file);

            if (lines > 0) {
                average = (float)words / lines;
            } else {
                average = 0.0f;
            }

            printf("\nNumber of lines of %s: %d\n", file_name, lines);
            printf("Number of words of %s: %d\n", file_name, words);
            printf("Average number of words per line of %s: %.2f\n", file_name, average);
        } else {
            printf("Invalid command.\n\n"); 
        }
    }

    printf("Good bye\n");
    return 0;
}
