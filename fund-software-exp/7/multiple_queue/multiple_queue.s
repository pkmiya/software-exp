*******************************
** 複数キューの実装
*******************************

* INSTRUCTION
* 1. SELECT QUEUE AND ITS MODE
*     Set values of d0 and d1 in your debugger
*     d0: select mode  (0: Wait for input, 1:Enque, 2:Deque, 3:Stop)
*     d1: select queue (0:Que0, 1:Que1, 2:Que2, 3:Que3)
* 2. SET BREAK POINT
*     In line 37, set break point in your code editor
*     The target process is in the first line of Que_Select subroutine
* 3. RUN PROGRAM
*     You'll see the result in DATA_SET in Memory Viewer

.section .text

Start:
    /* head address of each queue */
    .equ Que0, 0x00000600
    .equ Que1, Que0 + 0x0000010c
    .equ Que2, Que1 + 0x0000010c
    .equ Que3, Que2 + 0x0000010c

    /* flag: offset of each queue */
    .equ PUT_PTR,  0
    .equ GET_PTR,  4
    .equ PUT_FLG,  8
    .equ GET_FLG,  9
    .equ INIT_FLG, 10
    .equ BF_START, 11
    .equ BF_END,   267

    jsr Init_Q

Que_Select:
    cmp.w   #0, %d1     /* SET BREAK POINT HERE */
    beq     Q0_init
    cmp.w   #1, %d1
    beq     Q1_init
    cmp.w   #2, %d1
    beq     Q2_init
    cmp.w   #3, %d1
    beq     Q3_init
    bra     Que_Select

Q0_init:
    movea.l #Que0, %a1
    cmp.b   #0x00, INIT_FLG(%a1)
    bne     Next
    jsr     Init_Q
    bra     Next

Q1_init:
    movea.l #Que1, %a1
    cmp.b   #0x00, INIT_FLG(%a1)
    bne     Next
    jsr     Init_Q
    bra     Next

Q2_init:
    movea.l #Que2, %a1
    cmp.b   #0x00, INIT_FLG(%a1)
    bne     Next
    jsr     Init_Q
    bra     Next

Q3_init:
    movea.l #Que3, %a1
    cmp.b   #0x00, INIT_FLG(%a1)
    bne     Next
    jsr     Init_Q

Next:
    bra Select

/* MODE SELECT */
Select:
    cmp.w   #1, %d0
    beq     Enque
    cmp.w   #2, %d0
    beq     Deque
    cmp.w   #3, %d0
    beq     End_program
    bra     Select

Enque:
    lea.l   DATA, %a0
    adda.l  %d1, %a0
    jsr     QueueIn
    move.l  #0, %d0
    bra     Que_Select

Deque:
    lea.l   DATA_SET, %a0
    jsr     QueueOut
    move.l  #0, %d0
    bra     Que_Select

End_program:
    stop #0x2700

/* INIT_Q, QueueIn, QueueOut */
Init_Q:
    move.l  #BF_START, %a2
    add.l   %a1, %a2
    move.l  %a2, PUT_PTR(%a1)       /* init enque pointer */
    move.l  %a2, GET_PTR(%a1)       /* init deque pointer */
    move.b  #0xff, PUT_FLG(%a1)     /* init enque flag */
    move.b  #0x00, GET_FLG(%a1)     /* init deque flag */
    move.b  #0xff, INIT_FLG(%a1)    /* toggle init flag */
    rts

QueueIn:
    movem.l %a0-%a3/%d0-%d1, -(%sp)
    jsr     PUT_BUF
    movem.l (%sp)+, %a0-%a3/%d0-%d1
    rts

QueueOut:
    movem.l %a0-%a3/%d0-%d1, -(%sp)
    jsr     GET_BUF
    movem.l (%sp)+, %a0-%a3/%d0-%d1
    rts

/* PUT_BUF, GET_BUF */
PUT_BUF:
    move.b  PUT_FLG(%a1), %d0
    movea.l %a1, %a2            /* transport tail address */
    cmp.b   #0x00, %d0
    beq     PUT_BUF_Finish
    movea.l PUT_PTR(%a1), %a3
    move.b  (%a0), (%a3)+
    add.l   #BF_END, %a2
    cmpa.l  %a2, %a3            /* check tail address */
    bls     PUT_BUF_STEP1
    movea.l %a1, %a3            /* transport tail address */
    add.l   #BF_START, %a3

PUT_BUF_STEP1:
    move.l  %a3, PUT_PTR(%a1)
    cmpa.l  GET_PTR(%a1), %a3
    bne     PUT_BUF_STEP2
    move.b  #0x00, PUT_FLG(%a1)

PUT_BUF_STEP2:
    move.b  #0xff, GET_FLG(%a1)

PUT_BUF_Finish:
    rts

GET_BUF:
    move.b  GET_FLG(%a1), %d0
    movea.l %a1, %a2            /* transport tail address */
    cmp.b   #0x00, %d0
    beq     GET_BUF_Finish
    movea.l GET_PTR(%a1), %a3
    move.b  (%a3)+, (%a0)
    add.l   #BF_END, %a2
    cmpa.l  %a2, %a3            /* check tail address */
    bls     GET_BUF_STEP1
    movea.l %a1, %a3            /* transport tail address */
    add.l   #BF_START, %a3

GET_BUF_STEP1:
    move.l  %a3, GET_PTR(%a1)
    cmpa.l  PUT_PTR(%a1), %a3
    bne     GET_BUF_STEP2
    move.b  #0x00, GET_FLG(%a1)

GET_BUF_STEP2:
    move.b  #0xff, PUT_FLG(%a1)

GET_BUF_Finish:
    rts

.section  .data
DATA:     .ascii "ABCD"
DATA_SET: .ds.b  1
.end
