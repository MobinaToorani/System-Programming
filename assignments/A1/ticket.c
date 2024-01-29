#include <stdio.h>
#include <string.h>

int main() {
    char val[10];
    int age;
    // get value day or night
    printf("Enter the time: ");
    scanf("%s", val);
    // get age
    printf("Enter the age: ");
    scanf("%d", &age);
    
    // check cases
    if (age < 4)
        printf("free\n");
    else {
        if (strcmp(val, "day") == 0)
            printf("$8\n");
        
        else if (strcmp(val, "night") == 0){
            if (age >= 4 && age <= 16)
                printf("$12\n");
            else if (age >= 17 && age <= 54)
                printf("$15\n");
            else
                printf("$13\n");
        }
    }
    return 0;
}