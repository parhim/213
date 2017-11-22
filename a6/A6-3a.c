#include <stdio.h>

int m[10];
int* o = m;


void help(int y, int z) {
    o[z] = o[z] + y;
}

int main() {
    int w = 1;
    int x = 2;
    help(3, 4);
    help(w, x);
    for (int i=0; i<10; i++){
        printf("%d\n",o[i]);
    }
}
