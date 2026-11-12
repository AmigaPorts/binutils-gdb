| A DWARF reference to a string at offset 4 of .debug_line_str, after code
| and data that move the location counter.
	.text
	.globl	_start
_start:	rts
	.data
	.long	1
	.section .debug_line_str
.Lstr0:	.asciz	"abc"
.Lstr1:	.asciz	"name"
	.section .debug_info
	.long	.Lstr1
