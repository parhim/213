.pos 0x100
a1:                ld   $x, r1              # r1 = address of x
a2:                ld   $y, r2              # r2 = address of y
a3:                ld   $z, r3              # r3 = address of z
a4:                ld   $d, r4              # r4 = address of d[0]
a5:                ld   0x08(r1), r3        # r3 = z
a6:                ld   0x00(r1), r1        # r1 = x		 
a7:                ld   (r4, r3, 4), r5     # r5 = d[1]
a8:                ld   $c, r6              # r6 = address of c
a9:                ld   0x00(r6), r6        # r6 = c
a10:               ld   (r4, r6, 4), r7     # r7 = d[4]
a11:               st   r4, 0x04(r2)        # z = address of d[0]
a12:               st   r0, 0x00(r4)        # d[0] = 0
a13:               ld   $x, r1              # r1 = address of x
a14:               st   r7, (r1, r7, 4)     # j = r7
a15:               halt   
                 
.pos 0x2000
b16:               mov  r0, r7              # r7 = r0
b17:               add  r6, r5              # r5 = r5 + r6 (value of 5)
b18:               ld   $0xFFFFFFFF, r5     # r5 = -1
b19:               ld   $0x01, r7           # r7 = 1
b20:               add  r5, r7              # r7 = -1 + 1 = 0
b21:               and  r4, r2              # r2 = r2 & r4 (0x1000)
b22:               ld   $0x08, r3           # r3 = 0x08
b23:               and  r5, r3              # r3 = 0x08
b24:               inc  r0                  # r0 = r0+1 = 1
b25:               inc  r5                  # r5 = 0 
b26:               dec  r0                  # r0 = r0-1 = 0
b27:               dec  r5                  # r5 = -1
b28:               inca r0                  # r0 = r0+4 = 4
b29:               inca r5                  # r5 = 3
b30:               deca r0                  # r0 = r0-4 = 0
b31:               deca r5                  # r5 = -1
b32:               deca r5                  # r5 = -5
b33:               ld   $0xFFFFFFFF, r7     # r7 = -1
b34:               not  r7                  # ~r7 = 0
b35:               not  r7                  # ~r7 = -1
b36:               ld   $0x02, r0           # r0 = 2
b37:               not  r0                  # r0 = -3
b38:               ld   $0x01, r7           # r7 = 0x01
b39:               shl  $0x04, r7           # r7 = 1 << 4 = 16
b40:               shr  $0x04, r7           # r7 = 16 >> 4 = 1
b41:               nop        		    # nothing happens 
b42:               halt                     

.pos 0x1000
x:                 .long 0xffffffff         # x
y:                 .long 0x00eab783         # y
z:                 .long 0x00000001         # z
i:                 .long 0x00000000         # i
j:                 .long 0x00000000         # j

.pos 0x4000
a:                 .long 0x00110033         # a
b:                 .long 0x1113ffee         # b
c:                 .long 0x00000004         # c

.pos 0x7000
d:                 .long 0xffffffff         # d[0]
                   .long 0x00000001         # d[1]
                   .long 0x00000002         # d[2]
                   .long 0x00000003         # d[3]
                   .long 0x00000004         # d[4]
