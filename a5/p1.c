#include <stdio.h>
#include <stdlib.h>

struct S {
struct D* d1; 
struct D* d2; 
};

struct D {
int a; 
int b; 
};

struct S* s; 

void main (int argc, char* argv[]) { 
s = malloc(sizeof(struct S)); 
s->d1 = malloc(sizeof(struct D)); 
s->d2 = malloc(sizeof(struct D)); 
s->d1->a = atoi(argv[1]); 
s->d1->b = atoi(argv[2]); 
s->d2->a = atoi(argv[3]); 
s->d2->b = atoi(argv[4]);
s->d2->a = s->d1->b; 
s->d1->a = s->d2->b;

printf("%d\n", s->d1->a); 
printf("%d\n", s->d1->b);
printf("%d\n", s->d2->a);
printf("%d\n", s->d2->b);
}
