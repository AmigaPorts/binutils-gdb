| A 32-bit pc-relative reference to a weak symbol that nothing defines, from
| an instruction that is neither a bsr.l nor a bra.l.  It has no absolute
| form of the same size for the linker to use, so the linker must refuse it.
	.text
	.globl	f
f:	lea	(g,pc),a0
	rts
	.weak	g
