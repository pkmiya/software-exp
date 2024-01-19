.include "equdefs.inc"
.global outbyte

.text
.even

outbyte:
	movem.l %d0-%d3/%a1, -(%sp)

outbyte_loop:

	movea.l	%sp, %a1
	move.l	#27,   %d2	/*4xレジスタ5個+PC分4*/
	adda.l	%d2,   %a1
	move.b	(%a1), outbyte_BUF

	move.l 	#SYSCALL_NUM_PUTSTRING,%D0
	move.l 	#0,     %d1 | ch = ch
	move.l 	#outbyte_BUF,  %d2 | p  = #BUF
	move.l 	#1,    %d3 | size = 1
	trap #0

	cmpi.l 	#0, %d0
	beq 	outbyte_loop
	movem.l (%sp)+, %d0-%d3/%a1
	rts
	
.section .bss
.even

outbyte_BUF:
	.ds.b 1
	.even
