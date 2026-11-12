| A 16-bit pc-relative call to a weak symbol that nothing defines.  The
| symbol is the address 0, which no displacement from the pc of relocatable
| code can reach, and a bsr.w has no room for an absolute address.  So the
| linker must refuse it rather than leave the displacement gas wrote, which
| made a bsr.w *+2 that ran into the next instruction.
	.text
	.globl	f
f:	bsr.w	g
	rts
	.weak	g
