.section .text
start:
    moveq #5, %d1           /* d1 := 5 (arg = counter_end) */
    moveq #0, %d0           /* d0 := 1 (res) */
    moveq #1, %d2           /* d2 := k (counter_start) */

loop:
    /* calc k^k */
    move.l %d2, %d3
    move.l %d2, %d4
    muls %d3, %d4
    move.l %d4, %d5         /* d5 := k^k */
    add.l %d5, %d0

    addq #1, %d2

    /* eof? */
    cmpi #6, %d2            /* d2 > d1? */
    beq end_of_program
    bra loop

end_of_program:
    stop #0x2700
.end
