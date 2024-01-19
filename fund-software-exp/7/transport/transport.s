*******************************
** データ転送
*******************************

.section .text
start:
    jsr     SEND            /* go to sub-routine*/
    stop    #0x2700
SEND:
    movem.l %a1-%a3, -(%a7) /* save registers */
    lea.l   DATA_2, %a1     /* specify data (DATA_1 or DATA_2) */
    
    lea.l   BF_START, %a2
    lea.l   BF_END, %a3
loop:
    move.w  (%a1)+, (%a2)+  /* copy data (a1→a2) and increment both pointers */
    cmpa.l  %a3, %a2
    bls     loop
    movem.l (%a7)+, %a1-%a3 /* restore registers */
    rts                     /* return from sub-routine */
    
.section .data
            .equ  BF_SIZE, 9                    /* buffer size */
DATA_1:     .dc.w 'a','b','c','d','e','f'       /* data (string) */
DATA_2:     .dc.w 1, 2, 3, 4, 5, 6, 7, 8, 9, 0  /* data (integer) */
BF_START:   .ds.w BF_SIZE - 1                   /* buffer start */
BF_END:     .ds.w 1                             /* buffer tail */

.end
