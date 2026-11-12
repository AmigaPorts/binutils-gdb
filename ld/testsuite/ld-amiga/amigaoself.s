| An ELF object from the m68k-amigaoself assembler, with absolute
| references from code to data and back.
	.text
	.globl	_start
_start:	move.l	#_var,%d0
	jsr	_f
	rts
_f:	rts
	.data
	.globl	_var
_var:	.long	_f
