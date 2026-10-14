	.text
	.globl	_start
_start:
	jsr	_elffn
	move.l	_elfdata,d1
	rts

	.data
	.globl	_hunkdata
_hunkdata:
	.long	1
	.long	2
