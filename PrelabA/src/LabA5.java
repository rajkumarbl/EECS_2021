
public class LabA5
{
    public static void main(String[] args)
    {
     int x = Integer.parseInt(args[0]);
     System.out.println(Integer.toBinaryString(x));
     int z = x << 21;
     z = z >>> 31;
     System.out.println(Integer.toBinaryString(z));
     int mask = 1024;
     int y = x & mask;
     y = y >> 10;
     System.out.println(Integer.toBinaryString(y));
 }
}