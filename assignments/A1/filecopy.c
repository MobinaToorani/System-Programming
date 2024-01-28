#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    if (argc != 3)
        printf("Insufficient parameters passed.\n");
    else {
        // open the input file with read only and output file with write only
        FILE *in_file = fopen(argv[1], "r");
        FILE *out_file = fopen(argv[2], "w");
        char ch;// in_file[20], out_file[20];
        // check if fopen() worked, returns 0 if failed
        if (in_file == 0){
            printf("Could not open input file\n");
            exit(EXIT_FAILURE);
        }
        if (out_file == 0){
            printf("Could not open output file\n");
            fclose(in_file);
            exit(EXIT_FAILURE);
        }
        while ((ch = fgetc(in_file)) != EOF){
            fputc(ch, out_file); 
        }
        printf("The contents of file %s have been successfully copied into the %s file.\n",argv[1], argv[2]);
        fclose(in_file);
        fclose(out_file);
    }
    return 0;
}