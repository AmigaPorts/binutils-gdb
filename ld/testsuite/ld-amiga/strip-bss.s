| A data hunk with the bss after it, as -fbaserel links it: four
| kilobytes in memory, eight bytes in the file.  A relocation in the
| code hunk and one in the data hunk.
	.text
	.globl	_start
_start:	move.l	var,d0
	rts
	.data
	.globl	var
var:	.long	0x12345678
	.long	_start
	.bss
	.globl	buf
buf:	.skip	4096
