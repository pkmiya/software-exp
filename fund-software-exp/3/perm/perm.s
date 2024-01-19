/* perm.s 順列を求めるプログラム */

.section .text
start:
    moveq #10, %d1          /* d1 := n (1st arg)*/
    moveq #5, %d2           /* d2 := r (2nd arg)*/
    moveq #1, %d0           /* d0 := 1 (init res) */

loop:
    muls %d1, %d0           /* d0 *= d1 */
    subq #1, %d1            /* n -= 1 */

    cmpi #0, %d2            /* eof? */
    beq end_of_program
    
    subq #1, %d2            /* otherwise, r -= 1 & continue */
    bne loop

end_of_program:
    stop #0x2700
.end
