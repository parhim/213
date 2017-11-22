.pos 0x1000
code: 
		# v = s.x[i]; 
		ld $i, r0		  # r0 = address of i 
		ld $v, r1		  # r1 = address of v
                ld $s, r2		  # r2 = address of s 
                ld 0(r0), r0		  # r0 = i 
		ld (r2,r0,4), r3	  # r3 = s.x[i]
  		st r3, 0(r1)		  # v = s.x[i]

                # v = s.y[i]; 
		ld 8(r2), r4		  # r4 = s.y (Pointer)
		ld (r2,r0,4), r5	  # r5 = s.y[i]
                st r5, 0(r1)		  # v = s.y[i]
 
                # v = s.z->x[i]; 
                ld 12(r2),r4		  # r4 = s.z
		ld (r5,r0,4), r5	  # r5 = s.z->x[i]
                st r5, 0(r1)		  # v = s.z->x[i]
 
                halt


.pos 0x2000
static: 
i: 		.long 0x00000000	  # i 
v: 		.long 0x00000000	  # v
s: 		.long 0x00000000          # x[0]
		.long 0x00000000	  # x[1]
 		.long heap0		  # y
                .long heap1		  # z

.pos 0x3000
heap0: 
  		.long 0x00000000	  # s.y[0]
		.long 0x00000000	  # s.y[1]

heap1: 
		.long 0x00000000	  # s.z->x[0]
                .long 0x00000000	  # s.z->x[1]
                .long 0x00000000	  # s.z->y
                .long 0x00000000	  # s.z->z