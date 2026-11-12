| A pc-relative reference from the code hunk into the data hunk, which
| LoadSeg may place anywhere: no displacement can reach it.
	.text
	.globl	_start
_start:	lea	_var(%pc),%a0
	rts
	.data
	.globl	_var
_var:	.long	1
