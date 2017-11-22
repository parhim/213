.pos 0x100
                 ld   $0x0, r0           # r0 = temp_i = 0
                 ld   $0x0, r1           # r1 = temp_s = 0
                 ld   $0xfffffffe, r2    # r2 = -2
		 ld   $2, r4		 # r4 = 2

loop:            mov r0, r3              # r3 = temp_i
                 add r2, r3              # r3 = temp_i-2
                 beq r3, test_bgt        # if temp_i=0 goto test_bgt
                 inc r1     		 # temp_s = temp_s + 1
	    	 gpc $6, r6		 # r6 = return address
  		 j   side      		 # goto side
                 inc r0                  # temp_i++
                 br  loop                # goto loop

side:		 add  r4, r1		  # r1 = temp_s + 2
		 j 0(r6)		  # goto caller 

test_bgt:        inc r0			  # temp_i++
                 mov r0, r3		  # r3 = temp_i 
		 add r2, r3		  # r3 = temp_i -2
		 bgt  r3, end_loop        # if temp_i>0 goto end_loop

end_loop:        ld   $s, r5              # r5 = address of s
                 st   r1, 0x0(r5)         # s = temp_s
                 st   r0, 0x4(r5)         # i = temp_i
                 halt                     
.pos 0x1000
s:               .long 0x00000000         # s
i:               .long 0x00000000         # i

