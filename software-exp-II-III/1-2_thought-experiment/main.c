#define N 1000

void task_1(void){
    while(1){
        P(0);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(0);

        P(1);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(1);
    }
}

void task_2(void){
    while(1){
        P(0);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(0);
    }
}

void task_3(void){
    while(1){
        P(0);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(0);
    }
}

void task_4(void){
    while(1){
        P(1);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(1);
    }
}

void task_5(void){
    while(1){
        P(1);
        for(int i = 0; i < N; i++) { /* loop for 1 sec */ }
        V(1);
    }
}

void task_6(void){
    while(1){
        for(int i = 0; i < N; i++) { /* loop for 4 sec */ }
    }
}