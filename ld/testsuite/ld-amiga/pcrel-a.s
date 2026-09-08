| Branches whose displacement the hunk linker resolves: to a strong and a
| weak symbol earlier in the same object, with and without addend, and
| to an undefined symbol defined in another object.
	.text
	.space	0x100, 0x4e
	.globl	far
far:	rts
	.space	6, 0x4e
	.weak	weak
weak:	rts
	.space	6, 0x4e
	.section .text.f,"ax"
	.globl	f
f:	jra	far
	jra	far+4
	jra	weak
	jra	weak+4
	jra	ext
	jra	ext+4
	.weak	wloc
wloc:	rts
	jra	wloc
	rts
