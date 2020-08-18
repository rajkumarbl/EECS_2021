/***************************************
* EECS2031 – Lab *
* Filename: lab2c *
* Author: suyendan, yathoorshan*
* Email: s.yathu@hotmail.com*
* eecs_num: 213216437*
****************************************/

#include <stdio.h>

#define MAX_SIZE 20

/* function declarations/prototypes */
int length(char[]);
int indexOf(char[], char);

int main() {

   char helloArr []  = "hello";
   printf("\"%s\" contains %d input characters, but the size of it is %ld (bytes)\n", helloArr, length(helloArr), sizeof(helloArr));
   
   char word [MAX_SIZE];
   char c;
     
   printf("Enter a word and a character separated by blank>");
   scanf("%s %c",word, &c);   /* &word is wrong;  c is wrong */

   /********** Fill in your code below. **********/
   
printf("input word is \"%s\".contains %d input characters.index of %c in it is %d \n",word,length(word),c,indexOf(word,c));

return -1;
}

 

int length(char word[]){
	int i=0;

	while (word[i]!='\0')
		i++;


}



int indexOf(char word[], char c){

int i=0;

	while (word[i]!='\0'){
	i++;
	if(word[i]==c){return i;}
		
}

return -1;

		

}
