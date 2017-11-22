import static java.lang.System.out;

public class Endianness {

  public static int bigEndianValue (Byte[] mem) {
    long a = 0;
    int count = (mem.length-1)*2;
    for (Byte b:mem){
      int d = b & 0xff;
      switch (count) {
            case 6: a += d * 16 * 16 * 16 * 16 * 16 * 16;
                break;
            case 4: a += d * 16 * 16 * 16 * 16;
                break;    
            case 2: a += d * 16 *16;
                    break;
            case 0: a += d * 1;
                    break;
                default:break;
            }
            count -= 2;

        }

    if (a > (1<<31) - 1) {
            double neg = -(1<<32 - a);
            return (int) neg;
        } else
            return (int) a;
  }
  
  public static int littleEndianValue (Byte[] mem) {
    int length = mem.length;
        Byte[] reversed = new Byte[length];
        for (int i=0; i < mem.length; i++)
            reversed[length - 1 - i] = mem[i];

        return bigEndianValue(reversed);
  }
  
  public static void main (String[] args) {
    Byte mem[] = new Byte[4];
    try {
      for (int i=0; i<4; i++)
        mem [i] = Integer.valueOf (args[i], 16) .byteValue();
    } catch (Exception e) {
      out.printf ("usage: java Endianness n0 n1 n2 n3\n");
      out.printf ("where: n0..n3 are byte values in memory at addresses 0..3 respectively, in hex (no 0x).\n");
      return;
    }
  
    int bi = bigEndianValue    (mem);
    int li = littleEndianValue (mem);
    
    out.printf ("Memory Contents\n");
    out.printf ("  Addr   Value\n");
    for (int i=0; i<4; i++)
      out.printf ("  %3d:   0x%-5x\n", i, mem[i]);
    out.printf ("The big    endian integer value at address 0 is %d\n", bi);
    out.printf ("The little endian integer value at address 0 is %d\n", li);
  }


}