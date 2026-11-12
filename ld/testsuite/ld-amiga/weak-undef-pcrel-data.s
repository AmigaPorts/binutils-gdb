| A 32-bit pc-relative reference to a weak symbol that nothing defines, from
| data whose two bytes before it look like the opcode of a bsr.l.  The linker
| must not take them for an instruction and rewrite them: it refuses the
| reference, as from any place that is not a bsr.l or bra.l.
	.text
	.globl	f
f:	rts
	.data
	.word	0x61ff
	.long	g-.
	.weak	g
