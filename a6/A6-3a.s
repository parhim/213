.pos 0x0
                 ld   $sb, r5		# initialize stack pointer 
                 inca r5		# r5 = deallocate/element before bottom of stack
                 gpc  $6, r6    	# r6 = return address              
                 j    0x300             # goto address 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000 	# &o        
.pos 0x200
                 ld   0x0(r5), r0       # r0 = y = c  
                 ld   0x4(r5), r1       # r1 = z = d  
                 ld   $0x100, r2        # r2 = 0x100   
                 ld   0x0(r2), r2       # r2 = &o  
                 ld   (r2, r1, 4), r3   # r3 = o[z]  
                 add  r3, r0            # r0 = o[z] + y  
                 st   r0, (r2, r1, 4)   # o[z] = o[z] + y  
                 j    0x0(r6)           # return to caller   
.pos 0x300
                 ld   $0xfffffff4, r0	# r0 = -12
                 add  r0, r5		# allocate space for main (frame)
                 st   r6, 0x8(r5)       # store return address on stack     
                 ld   $0x1, r0          # r0 = 1 = a  
                 st   r0, 0x0(r5)       # save value of a to stack   
                 ld   $0x2, r0          # r0 = 2 = b  
                 st   r0, 0x4(r5)       # save value of b to stack   
                 ld   $0xfffffff8, r0   # r0 = -8  
                 add  r0, r5            # allocate space   
                 ld   $0x3, r0          # r0 = 3 = c  
                 st   r0, 0x0(r5)       # save value of c to stack  
                 ld   $0x4, r0          # r0 = 4 = d  
                 st   r0, 0x4(r5)       # save value of d to stack   
                 gpc  $6, r6            # r6 = return address       
                 j    0x200		# goto 0x200
                 ld   $0x8, r0          # r0 = 8   
                 add  r0, r5            # deallocate   
                 ld   0x0(r5), r1       # r1 = w = 1  
                 ld   0x4(r5), r2       # r2 = x = 2  
                 ld   $0xfffffff8, r0   # r0 = -8  
                 add  r0, r5            # allocate space   
                 st   r1, 0x0(r5)       # y = w  
                 st   r2, 0x4(r5)       # z = x  
                 gpc  $6, r6            # r6 = return address      
                 j    0x200		# goto 0x200
                 ld   $0x8, r0          # r0 = 8   
                 add  r0, r5            # deallocate  
                 ld   0x8(r5), r6       # r6 = return address  
                 ld   $0xc, r0          # r0 = 12  
                 add  r0, r5            # deallocate   
                 j    0x0(r6)           # return to caller   
.pos 0x1000
o:               .long 0x00000000 	# o[0]         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
