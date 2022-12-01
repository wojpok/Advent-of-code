#include <stdio.h>
#include <stdlib.h>

#define BUFS 128

int main() {

    int current_sum = 0;

    int tops[3] = {0, 0, 0};

    char* buf = NULL;
    size_t len = 0;
    int code;

    while ((code = getline(&buf, &len, stdin)) != -1) {
       
       if(code == 1) { //newline
            for(int i = 0; i < 3; i++) {
                if(current_sum > tops[i]) {
                    int t = tops[i];
                    tops[i] = current_sum;
                    current_sum = t;
                }
            }
            current_sum = 0;
            continue;
       }

        int num = atoi(buf);
        current_sum += num;
    }

    printf("Highest: %d\n", tops[0]);
    printf("Sum of 3 best: %d\n", tops[0] + tops[1] + tops[2]);
}