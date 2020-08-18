//          Name: Rajkumar Balakrishnan Lakshmi
//   Std. Number: 213141197
//           Lab: 01
public class Laba 
{
	    public static void main(String[] args)
	     {
	     
	        int input=  Integer.parseInt(args[0]);
	        
	        int x=input<<28;
	            x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<24;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<20;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<16;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<12;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<8;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<4;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x));
	        
	        x=input<<0;
	        x=x>>>28;
	        System.out.println(Integer.toHexString(x)); 
	        
      }
}