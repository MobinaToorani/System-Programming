#include <stdio.h>
#include <stdlib.h>

int main(){
    int int_input;
    int pascal[15][15];
    printf("Please enter a value for the Pascal triangle\n");
    scanf("%d", &int_input); 

    if (int_input >= 15 || int_input < 0){
        printf("Invalid input. Please enter a positive Integer less than 15.\n");
        exit(EXIT_FAILURE);
    }
    for (int i=1; i<=int_input; i++){
        pascal[i][1] = 1;
        pascal[i][i] = 1;
    }
    for (int i=3; i<=int_input; i++){
        for (int j=2;j<=i-1;j++){
            pascal[i][j] = pascal[i-1][j] + pascal[i-1][j-1];
        }
    }

    for (int i=1; i<=int_input; i++){
        for (int j=1; j<=i; j++){
            printf("%-4d ", pascal[i][j]);
        }
        printf("\n");
    }

    return 0;
}