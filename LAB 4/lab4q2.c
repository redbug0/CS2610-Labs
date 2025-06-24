#include <stdio.h>

extern int reverse(char* strr);
extern char result[];
int main(){
    char strr[] = "Helloqwe";
    printf("input_string: %s\n", strr);
    int l = reverse(strr);
    printf("reverse_string: %s, length = %d\n", result, l);
}
