** ある配列を用いて順列の総和を求める
** min_task.s
** sum[k=1, 12]{P(7,x[k])}
** x = [7, 5, 3, 2, 6, 4, 5, 1, 5, 1, 6, 7]

.section .text
start:
    lea     x,  %a1         /* a1 := *p (pointer) */
    moveq   #0, %d0         /* d0 := 0 (init ans)*/
    moveq   #n, %d1         /* d1 := n = 7 (const) */
    moveq   #LENGTH, %d2    /* d2 := 12 (i := i_start) */

loop:
    jsr     p_calc          /*  */
    add.l   %d3,%d0         /* ans += perm */
    adda.w  #2, %a1         /* p++ */
    subq    #1, %d2         /* i-- */
    cmp.w   #0, %d2         /* i == 0? */
    bne     loop

end:
    stop    #0x2700

p_calc:
    movem.l %a1/%d0-%d2, -(%a7) /* save registers */
    moveq   #LENGTH, %d0    /* d0 := j_start (ex. ans) */
    moveq   #1, %d3         /* d3 := 1 (init perm res) */
    move.w  (%a1), %d2      /* d2 := x[j] (ex. i) */
                            /* d1 := n = 7 (var. ex. const)*/

loop_p:
    mulu    %d1, %d3        /* perm *= x[j] */
    subq    #1,  %d1        /* n-- */
    subq    #1,  %d2        /* x[j]-- */
    cmp     #0,  %d2        /* x[j] == 0? */
    bne     loop_p

end_of_p_calc:
    movem.l (%a7)+, %a1/%d0-%d2 /* restore registers */
    rts

.section .data
    .equ LENGTH, 12
    .equ n,      7
    x:   dc.w    7, 5, 3, 2, 6, 4, 5, 1, 5, 1, 6, 7
