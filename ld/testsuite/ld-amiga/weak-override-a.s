| A weak definition and references to it from the same object, absolute
| and pc-relative: a strong definition in another object must win.
	.text
	.globl	main
main:	jsr	f
	jbsr	f
	rts
	.weak	f
f:	moveq	#1,d0
	rts
	.data
	.long	f
