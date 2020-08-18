/***************************************
* EECS2031 � Lab1 *
* Filename: Lab2b.c *
* Author:suyendran yathoorshan*
* Email:s.yathu@hotmail.com*
* eecs_num: 213216437 *
****************************************/

#include <stdio.h>



int main(){

  int c = getchar();

  while( c != EOF)
  {
  	  
  	 if((c>='A')&& (c<='Z')){
  	c=c+'a'-'A';
  	}  

  	  
  	  
    putchar(c);
    
   
    c =  getchar();  /* read again */
  }

  return 0;

}
