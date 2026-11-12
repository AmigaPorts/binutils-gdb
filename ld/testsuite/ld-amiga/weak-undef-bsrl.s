| A bsr.l and a bra.l to a weak symbol that nothing defines.  No
| displacement from the pc reaches the address 0, but the absolute forms of
| the two instructions do: the linker makes them a jsr and a jmp to 0, and
| leaves no relocation behind.
	.text
	.globl	f
f:	bsr.l	g
	bra.l	g
	.weak	g
