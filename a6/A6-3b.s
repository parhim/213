.pos 0x100
start:
    ld $sb, r5		# initialize point to bottom of stack 
    inca    r5		# r5 = deallocate to position right above bottom 
    gpc $6, r6		# r6 = return address
    j main		# goto main 
    halt

f:
    deca r5		# allocate space 
    ld $0, r0		# r0 = a3 = 0 
    ld 4(r5), r1	# r1 = a1 = x[i]
    ld $0x80000000, r2	# r2 = 80000000
f_loop:
    beq r1, f_end	# goto f_end if a1 = 0
    mov r1, r3		# r3 = a2 = x[i]
    and r2, r3		# r3 = a2 = x[i] & 80000000
    beq r3, f_if1	# goto f_if1 if a2 == 0
    inc r0		# a3++
f_if1:
    shl $1, r1		# a1 = a1 *2
    br f_loop		# goto f_loop
f_end:
    inca r5		# deallocate
    j(r6)		# return to caller

main:
    deca r5		# allocate space
    deca r5		# allocate space 
    st r6, 4(r5)	# store return address on stack 
    ld $8, r4		# r4 = 8 = i
main_loop:
    beq r4, main_end	# goto main_end if r4 = i = 0
    dec r4		# i—-
    ld $x, r0		# r0 = &x
    ld (r0,r4,4), r0	# r0 = x[i]
    deca r5		# allocate space 
    st r0, (r5)		# a0 = x[i]
    gpc $6, r6		# r6 = return address 
    j f			# goto f 
    inca r5		# deallocate 
    ld $y, r1		# r1 = &y
    st r0, (r1,r4,4)	# y[i] = a3
    br main_loop	# goto main_loop
main_end:
    ld 4(r5), r6	# r6 = return address
    inca r5		# deallocate
    inca r5		# deallocate
    j (r6)		# return to caller

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

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

