
public class LabA3
{
	   public static void main (String[] args)
       {
         int x = Integer.parseInt(args[0]);
         int y = Integer.parseInt(args[1]);
        System.out.printf("x\t %s\n", Integer.toBinaryString(x));
        System.out.printf("x & y\t %d\t %s\n", x&y, Integer.toBinaryString(x&y));
        System.out.printf("x | y\t %d\t %s\n", x|y, Integer.toBinaryString(x|y));
        System.out.printf("x ^ y\t %d\t %s\n", x^y, Integer.toBinaryString(x^y));
       System.out.printf("~x\t %d\t %s\n", ~x, Integer.toBinaryString(~x));
    }
}
