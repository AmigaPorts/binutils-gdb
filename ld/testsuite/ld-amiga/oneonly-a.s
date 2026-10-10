| A one-only section, as gcc emits for an inline function: a section of
| its own whose only symbol is a weak definition.  This copy is the larger
| one, as an -O0 build of the function would be, and like a recursive
| function it calls itself; oneonly-b.s has the same
| section with a shorter body, as a library built at -O2 would.  The
| linker must keep this first copy and drop the second without a word.
	.text
	.space	8, 0x4e
	.globl	f
f:	jsr	inl
	rts
	.section .text.inl,"ax"
	.weak	inl
inl:	nop
	nop
	jsr	inl
	rts
