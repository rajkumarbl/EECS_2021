/***************************************
* EECS2031 � Lab2 *
* Filename: Lab2a.c *
* Author:suyendran yathoorshan*
* Email:s.yathu@hotmail.com*
* eecs_num: 213216437 *
****************************************/

#include <stdio.h>


int isDigit(char c){


	
if (c>='0' && c<='9'){
	return 1;
}else return 0;
	

	
	
}


main() {



	int value;
	char data;
  while (value!=-10000){
   printf("enter an integer and character separated by blank  > ");
   scanf("%d %c",&value ,&data);

   	if (isDigit(data)==1){
   	   
   			int temp,sum;
  		        temp=data-'0';
  		        sum=value+temp;
   		printf("Input character %c represent a digit.sum of %d and %c is %d\n",data,value,data,sum);
   				} 

	if (isDigit(data)==0){
   
  	 	printf("Input character %c does not represent a digit.\n",data);
   				}
   
   	
   }
 
   
   
   

}


 
