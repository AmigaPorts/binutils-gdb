| A weak definition next to a local one and no global: the local symbol is
| written as a non-weak definition, so the section is not one-only, and
| the references to the weak symbol must still be resolved by name.
	.text
g:	jsr	f
	jbsr	f
	rts
	.weak	f
f:	moveq	#1,d0
	rts
	.section .text.main,"ax"
	.globl	main
main:	jsr	g
	rts
