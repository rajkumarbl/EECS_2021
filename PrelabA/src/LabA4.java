
public class LabA4
{
    public static void main(String[] args)
     {
     int x = Integer.parseInt(args[0]);
     
     System.out.println(Integer.toBinaryString(x));
     System.out.println();
     System.out.println("One shifts:");
     System.out.print(Integer.toBinaryString(x << 1) + " ");
     System.out.println(x << 1);
     System.out.print(Integer.toBinaryString(x >>> 1) + " ");
     System.out.println(x >>> 1);
     System.out.print(Integer.toBinaryString(x >> 1) + " ");
     System.out.println(x >> 1);

     System.out.println();
     
     System.out.println("Two shifts:");
     System.out.print(Integer.toBinaryString(x << 2) + " ");
     System.out.println(x << 2);
     System.out.print(Integer.toBinaryString(x >>> 2) + " ");
     System.out.println(x >>> 2);
     System.out.print(Integer.toBinaryString(x >> 2) + " ");
     System.out.println(x >> 2);
 }
}