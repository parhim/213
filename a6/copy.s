.pos 0x100
start:          ld   $stackBtm, r5       # sp = address of last word of stack
		inca r5
                gpc  $0x6, r6            # r6 = pc + 6
		j main 
                halt               


main:		j copy
copy:		deca r5
		st r6,(r5)
		ld $0x0,r0
		deca r5
		deca r5
		st r0,0x0(r5)		#dst0 = 0
		st r0,0x4(r5)		#dst1 = 0
		ld $0x0,r7		#r7 = 0 = i
check1:		ld $src,r1
		ld (r1,r7,4),r1		#r1 = src[i]
		beq r1, end_loop   	# if src[i]==0 goto end_loop
		st r1,(r5,r7,4)		# dst[i]=src[i]
		inc r7			#i++
		br check1
end_loop:	st r0,(r5,r7,4)		#dst[i]=0
		inca r5                 
                inca r5
		ld   (r5), r6      
                j    (r6)

		halt


.pos 0x1000
stackTop:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000       
                 .long 0x00000000   #dyn dst[0]       
                 .long 0x00000000   #dyn dst[1]  
stackBtm:        .long 0x00000000
src:		 .long 0x1
		 .long 0x2
		 .long 0x00001028
		 .long 0x0000ffff
		 .long 0xffff6001
		 .long 0x60026003
		 .long 0x60046005
		 .long 0x60066007
		 .long 0xf0000000







