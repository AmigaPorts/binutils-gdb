| A base-relative (a4) reference to a weak symbol that nothing defines.
| No displacement from a4 gives the address 0, so the linker must refuse it
| rather than let the program take data for the missing symbol.
	.text
	.globl	f
f:	pea	g:W(a4)
	rts
	.weak	g
	.data
	.globl	var
var:	.long	0
