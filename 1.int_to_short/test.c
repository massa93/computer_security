#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
int i;
unsigned short s;

i = atoi(argv[1]);// parse size from string
printf("%d\n",i);
if (i == 0) { // file size check
printf("Invalid PDF size: value must be > 0\n");
return -1;
}
s = i; // e.g., extract some info from the file
printf("%d\n",s);
if (s == 0) { //security check :-)
printf("Access GRANTED!\n");
}
//system("pause");
}
