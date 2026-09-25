| A relocation from .text to .data, with a DWARF section that the
| linker script places between the two as an output section of its own.
	.text
	.globl	_start
_start:	move.l	#var,%d0
	rts
	.section .debug_info
	.long	0x11111111, 0x11111111, 0x11111111, 0x11111111
	.data
	.globl	var
var:	.long	0x22222222
