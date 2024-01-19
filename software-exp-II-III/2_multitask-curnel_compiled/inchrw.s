.include "equdefs.inc"
.global inbyte

.text
.even

inbyte:
	movem.l %a0/%d1-%d3, -(%sp)
	lea.l inbyte_BUF, %a0
inbyte_loop:
	move.l #SYSCALL_NUM_GETSTRING, %d0
	move.l #0,  %d1       | ch    = 0
	move.l %a0, %d2       | p    = #inbyte_BUF
	move.l #1, %d3        | size = 1
	trap #0
	
	cmpi.l #0, %d0
	beq inbyte_loop       | 失敗したら戻る
	move.b (%a0), %d0     | 一時保存→出力としてレジスタへ
	movem.l (%sp)+, %a0/%d1-%d3
	rts
	
.section .bss
.even

inbyte_BUF:
	.ds.b 1 /*一時的に保存する領域*/
	.even
