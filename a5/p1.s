.pos 0x1000
    ld $s, r0      # r0 = struct *S s; 
    ld (r0), r0    # r0 = *s; 
    ld (r0), r1    # r1 = s->d1;
    ld 4(r0), r2   # r2 = s->d2; 
    ld 4(r1), r3   # r3 = s->d1->b
    st r3, (r2)    # s->d2->a = s->d1->b
    ld 4(r2), r3   # r3 = s->d2->b
    st r3, (r1)    # s->d1->a = s->d2->b
    halt                     

.pos 0x2000
s:  .long d0
# END OF STATIC ALLOCATION

# DYNAMICALLY ALLOCATED HEAP SNAPSHOT
# (malloc'ed and dynamically initialized in c version)
d0: .long d1     #s.d1
    .long d2     #s.d2
d1: .long 1
    .long 2
d2: .long 3
    .long 4
