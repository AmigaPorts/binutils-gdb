| The LTO symbol table of an object that refers to two symbols it does not
| define, s strongly and w weakly.  A record is the name, the comdat name,
| the kind, the visibility, a 64-bit size and a 32-bit slot.
	.text
	.globl	f
f:	rts
	.section .gnu.lto_.symtab.0
	.asciz	"s"
	.asciz	""
	.byte	2, 0
	.long	0, 0, 0
	.asciz	"w"
	.asciz	""
	.byte	3, 0
	.long	0, 0, 0
