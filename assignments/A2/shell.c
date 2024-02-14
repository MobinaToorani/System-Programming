#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_LENGTH 1024

int main() {
    char input[MAX_LENGTH];
    char *arguments[MAX_LENGTH / 2];
    char *parsed;
    int status;
    pid_t pid;

    while (1) {
        fflush(stdout);
        printf("myshell> ");


        if (!fgets(input, MAX_LENGTH, stdin)) {
            fprintf(stderr, "Error reading input.\n");
            continue;
        }

        if ((parsed = strchr(input, '\n'))) {
            *parsed = '\0';
        }

        if (strcmp(input, "q") == 0) {
            break;
        }

        if (input[0] == '\0') {
            continue;
        }

        // printf("[Debug] Command to execute: '%s'\n", input); // Debug print
        
        pid = fork();
        if (pid == 0) {
            parsed = strtok(input, " ");
            int i = 0;
            while (parsed != NULL) {
                arguments[i++] = parsed;
                parsed = strtok(NULL, " ");
            }
            arguments[i] = NULL;

            execvp(arguments[0], arguments);
            perror("execvp error");
            exit(EXIT_FAILURE);
        } else if (pid < 0) {
            perror("fork error");
        } else {
            waitpid(pid, &status, 0);
            // printf("[Debug] Command executed\n"); // Debug print
        }     
    }
    fflush(stdout);
    return 0;
}