
public class LabA8 
{
    public static void main(String[] args)
   {
    int x = Integer.parseInt(args[0]);
    System.out.println(Integer.toBinaryString(x));

     int z = 1 + ~x;
     System.out.println(z);
     System.out.println(Integer.toBinaryString(z));
    }
  }
