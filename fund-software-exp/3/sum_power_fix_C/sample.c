// calc sum k=1 to 5 of k^k
// simulate like assembly 68000
#include<stdio.h>

int main(void){
    int d0 = 0; // ans
    int d1 = 1; // i_start
    int d2 = 5; // i_end
    int d3 = 1; // i

    int d4;     // j (const)
    int d5;     // j (var)
    int d6;     // j^j

    while(1){
        d4 = d3;
        d5 = d3;
        d6 = 1;
        while(1){
            d6 *= d4;
            d5 --;
            if(d5 != 0) continue;
            else break;
        }
        d0 += d6;

        d3++;
        if(d3 > d2) break;
        else continue;
    }

    printf("ans = %d\n", d0);

}