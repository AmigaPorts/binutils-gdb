| PC-relative references deferred to the Amiga hunk linker must keep the
| target's offset within its section in the reloc field, for strong and
| weak targets, explicit addends and undefined symbols alike.
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
