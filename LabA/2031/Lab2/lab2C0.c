#include <stdio.h>

#define SIZE 20

int main () {

 int a=0;
 while (a < 100){
   printf("hello %d\n", a);
   if (a==8)
     break;
   a++;
 }

 int k[SIZE]={3,5};

 int i=0;
 for (i=0; i< SIZE; i++)  
   printf("[%d]: %d\n", i, k[i]);


 char msg[]="Hello world";
 printf("%d (bytes)\n", sizeof(msg));
int x=sizeof(msg);

int z;
for(z=0;z<x;z++){
 printf("MSG %d %c \n", msg[z],msg[z]);

}

  

 

return 0;
}

