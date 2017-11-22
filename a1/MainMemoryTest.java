package arch.sm213.machine.student;


import static org.junit.Assert.*;
public class MainMemoryTest {

    private MainMemory memory = new MainMemory(4);
    @org.junit.Test
    public void isAccessAligned() throws Exception {

        //// since memory is 8, the only time it's aligned is when the address is divisible by 8
        assertTrue(memory.isAccessAligned(16,memory.length()));//divisible
        assertFalse(memory.isAccessAligned(5,memory.length()));//not divisible
    }

    @org.junit.Test
    public void bytesToInteger() throws Exception {
        byte b00 = 0x00;
        byte b01 = 0x01;
        byte b7F = 0x7f;
        byte b80 = (byte) 0x80;
        byte bFF = (byte) 0xff;
        byte bCC = (byte) 0xcc;


        assertEquals(0,memory.bytesToInteger(b00,b00,b00,b00));//zero
        assertEquals(-2147483648,memory.bytesToInteger(b80,b00,b00,b00));//most negative
        assertEquals(2147483647,memory.bytesToInteger(b7F,bFF,bFF,bFF));//most positive
        assertEquals(-1,memory.bytesToInteger(bFF,bFF,bFF,bFF));//max hex
        assertEquals(33541248,memory.bytesToInteger(b01,bFF,bCC,b80));//random big
        assertEquals(1,memory.bytesToInteger(b00,b00,b00,b01));//just one


    }

    @org.junit.Test
    public void integerToBytes() throws Exception {
        byte b00 = 0x00;
        byte b7F = 0x7f;
        byte b80 = (byte) 0x80;
        byte bFF = (byte) 0xff;

        byte[] randBig = new byte[]{0x3f,(byte) 0xf6,(byte) 0xca,(byte)0xbb};//3F F6 CA BB

        assertEquals((byte) 0x9e,memory.integerToBytes(343454)[3]);//negative byte case
        assertEquals(b7F,memory.integerToBytes(2147483647)[0]);//most positive number
        assertEquals(bFF,memory.integerToBytes(2147483647)[1]);///////
        assertEquals(b80,memory.integerToBytes(-2147483648)[0]);//most negative number
        assertEquals(b00,memory.integerToBytes(-2147483648)[1]);//////
        assertArrayEquals(randBig,memory.integerToBytes(1073138363));//random large number
        assertEquals(bFF,memory.integerToBytes(-1)[0]);//checks for max hex value
    }


    @org.junit.Test
    public void set() throws Exception {
        try {memory.set(0, new byte[]{0x0,0x0,0x0,0x1});
        } catch (Exception e) {fail();}
        try {memory.set(0, new byte[] { 0xa, 0xa, 0xa, 0xa, 0xa,0xa });
        } catch (Exception e) {}//byte array bigger than memory
        try {memory.set(1, new byte[]{0xc,0xa,0xa,0xb});
        } catch (Exception e) {}//invalid address
        try {memory.set(-1, new byte[]{0x0,0x3,0x3,0x3});
        } catch (Exception e) {}//invalid address
        try {memory.set(4,new byte[]{(byte) 0x87,(byte) 0x65,(byte) 0x43,(byte) 0x21});
        } catch (Exception e) {}//address too big
        memory.set(0,new byte[]{(byte) 0x00,(byte) 0x01,(byte) 0xe1,(byte) 0xa1});//123297 in decimal
        assertArrayEquals(memory.integerToBytes(123297),memory.get(0,4));
    }



    @org.junit.Test
    public void get() throws Exception {
        memory.set(0,new byte[]{(byte) 0xcd,(byte) 0x2e,(byte) 0x11,(byte) 0xa1});
        assertArrayEquals(new byte[]{(byte) 0xcd,(byte) 0x2e,(byte) 0x11,(byte) 0xa1},memory.get(0,4));
        try {memory.get(0,4);
        } catch (Exception e) {fail();}
        try {memory.get(1,1);
        } catch (Exception e) {fail();}
        try {memory.get(0,8);
        } catch (Exception e) {}//byte array longer than memory
        try {memory.get(-2,5);
        } catch (Exception e) {}

    }

}