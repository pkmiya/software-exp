#include "mtk_c.h"
#include <stdio.h>

void display_ready_queue() {
    TASK_ID_TYPE temp = ready;
    printf("Ready Queue: ");
    while (temp != NULLTASKID) {
        printf("%d ", temp);
        temp = task_tab[temp].next;
    }
    printf("\n");
}

void task1() {
    display_ready_queue();
    while(1) {
        P(0);
        printf("[task1]\n");
        display_ready_queue();
        printf("semaphore[0].count = %d\n semaphore[0].task_list = %d\n",
                semaphore[0].count, semaphore[0].task_list);
        printf("semaphore[1].count = %d\n semaphore[1].task_list = %d\n",
                semaphore[1].count, semaphore[1].task_list);
        printf("semaphore[2].count = %d\n semaphore[2].task_list = %d\n",
                semaphore[2].count, semaphore[2].task_list);
        V(0);
    }
}

void task2() {
    display_ready_queue();
    while(1) {
        P(0);
        printf("[task2]\n");
        display_ready_queue();
        printf("semaphore[0].count = %d\n semaphore[0].task_list = %d\n",
                semaphore[0].count, semaphore[0].task_list);
        printf("semaphore[1].count = %d\n semaphore[1].task_list = %d\n",
                semaphore[1].count, semaphore[1].task_list);
        printf("semaphore[2].count = %d\n semaphore[2].task_list = %d\n",
                semaphore[2].count, semaphore[2].task_list);
        V(0);
    }
}

void task3() {
    display_ready_queue();
    while(1) {
        P(1);
        printf("[task3]\n");
        display_ready_queue();
        printf("semaphore[0].count = %d\n semaphore[0].task_list = %d\n",
				semaphore[0].count, semaphore[0].task_list);
        printf("semaphore[1].count = %d\n semaphore[1].task_list = %d\n",
                semaphore[1].count, semaphore[1].task_list);
        printf("semaphore[2].count = %d\n semaphore[2].task_list = %d\n",
                semaphore[2].count, semaphore[2].task_list);
        V(1);
    }
}

void task4() {
    display_ready_queue();
    while(1) {
        P(1);
        printf("[task4]\n");
        display_ready_queue();
        printf("semaphore[0].count = %d\n semaphore[0].task_list = %d\n",
				semaphore[0].count, semaphore[0].task_list);
        printf("semaphore[1].count = %d\n semaphore[1].task_list = %d\n",
				semaphore[1].count, semaphore[1].task_list);
        printf("semaphore[2].count = %d\n semaphore[2].task_list = %d\n",
				semaphore[2].count, semaphore[2].task_list);
        V(1);
    }
}

void main(void) {
    // ハードウェア初期化
    init_kernel();

    // タスクの初期化と登録
    set_task(task1);
    set_task(task2);
    set_task(task3);
    set_task(task4);
    display_ready_queue();

    // マルチタスク処理の開始
    begin_sch();
}
