
public class LabA7 
{
    public static void main(String[] args)
 {
        int x = Integer.parseInt(args[0]);
        System.out.println(Integer.toBinaryString(x));

        int y = x << 21;
        y = y >>> 31; // get bit #10 of x

        int z = x << 11;
        z = z >>> 31; // get bit #20 of x

        if (y == 1 && z == 0) {        // if bit #10 is 1 and bit #20 is 0
            x |= (1 << 20);            // set bit #20
            x &= ~(1 << 10);           // clear bit #10
        } else if (y == 0 && z == 1) { // if bit #20 is 1 and bit #10 is 0
            x |= (1 << 10);            // set bit #10th
            x &= ~(1 << 20);           // clear bit #20
        }

        System.out.println(Integer.toBinaryString(x));
    }
}