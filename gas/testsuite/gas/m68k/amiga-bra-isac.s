| ColdFire ISA_C has a long bcc but no long bra: with -pcrel, a jbra that
| does not fit in a word becomes a bne.l/beq.l pair.
	.text
start:	jbra	near
	jbra	far
	.space	0x100, 0x4e
near:	.space	0x8000, 0x4e
far:	rts
