#include <stdio.h>
char course_name[100];

char* getCourse(){
    return course_name;
}
void displayStudentProfile(char* first_name, char* last_name, char* course_namee){
    printf("First Name: %s, Last Name: %s, Course: %s\n",first_name, last_name, course_namee);
}