| References to a weak symbol that nothing defines: the linker resolves
| them to 0 and leaves no relocation behind.
	.text
	.globl	main
main:	move.l	#g,d0
	jeq	1f
	jsr	g
1:	rts
	.weak	g
	.data
	.long	g
