#include <stdio.h>

int x[8] = {1, 2, 3, -1, -2, 0, 184, 340057058};
int y[8] = {0, 0, 0, 0, 0, 0, 0, 0};

int foo (int a1) {
    int a3 = 0;
    while (a1 != 0) {
        int a2 = a1 & 0x80000000;
        if (a2 != 0){
            a3++;
        }
        a1 = a1 * 2;
    }
    return a3;
}


int main() {
    int i = 8;
    while (i != 0) {
        i--;
        int a0 = x[i];
        y[i] = foo(a0);
    }
    for (int i = 0; i < 8; i++)
        printf("%d\n", x[i]);
    for (int i = 0; i < 8; i++)
        printf("%d\n", y[i]);
}
