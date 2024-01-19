.section .text
start:
    moveq #0, %d0           /* ans */
    moveq #1, %d1           /* i_start */
    moveq #5, %d2           /* i_end */
    moveq #1, %d3           /* i */

outer_loop:
    move.l %d3, %d4         /* d4 := j (const) */
    move.l %d3, %d5         /* d5 := j (var) */
    move.l #1, %d6          /* d6 := j^j */

inner_loop:
    muls %d4, %d6           /* d6 *= d4 */
    subq #1, %d5            /* j_var -- */
    bne inner_loop          /* inner continue? */

    add.l %d6, %d0          /* ans += j^j*/
    addq #1, %d3            /* i++ */

    /* loop end? */
    cmp %d2, %d3            /* i > i_end ? */
    bgt end_of_program      /* true, then EOF */
    bra outer_loop          /* false, then outer continue */

end_of_program:
    stop #0x2700

.end
