#include <stdio.h>

int i = 0;
int j = 0;
int k = 0;
int fin = 0;


int foo(int a, int b, int c){
	switch(a){
		case 10: return b+c;
		case 12: return b-c;
		case 14: if (b > c) {return 1} else return 0;
		case 16: if (c > b) {return 1} else return 0;
		case 18: if (b = c) {return 1} else return 0;
		default: return 0;
			
	}


int main(){
	fin = foo(i,j,k);
}