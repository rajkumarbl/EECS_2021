public class LabA6 
{
    public static void main(String[] args) 
{
      int x = Integer.parseInt(args[0]);
      System.out.println(Integer.toBinaryString(x) + "\t(x)");

      // set   the #10 bit
      x |= 1 << 10;
      
      System.out.println(Integer.toBinaryString(x) + "\t(bit #10 set)");
      // clear the #11 bit
      x &= ~(1 << 11);
      
      System.out.println(Integer.toBinaryString(x) + "\t(bit #11 cleared)");
  }
}