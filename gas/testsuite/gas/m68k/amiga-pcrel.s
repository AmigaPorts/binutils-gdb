| PC-relative references deferred to the Amiga hunk linker must keep the
| target's offset within its section plus any addend in the reloc field.
| References to undefined symbols, and to weak symbols whose section also
| has a strong definition, are resolved by name and keep only the addend.
	.text
	.space	0x100, 0x4e
	.globl	far
far:	rts
	.weak	weak
weak:	rts
	.section .text.f,"ax"
	.globl	f
f:	jra	far
	jra	far+4
	jsr	far
	jra	weak
	jra	weak+4
	jsr	weak
	jra	ext
	jra	ext+4
	.space	0x10, 0x4e
	.weak	wloc
wloc:	rts
	jra	wloc
	rts
