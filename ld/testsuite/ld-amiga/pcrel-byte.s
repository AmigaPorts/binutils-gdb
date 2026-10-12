| Byte branches whose fixup is left to the linker, forward and backward:
| to a local label in another named section, to a local label in a
| distinct section with the same name (.text.unlikely maps to .text), and
| to a weak symbol in the same section.  The field must keep the -1 PC
| base of an 8-bit displacement.
	.text
	.space 12,0
	.globl text_alias
text_alias:
.Ltext:
	rts
	.weak weak_before
weak_before:
	nop
	rts
	.globl text_entry
text_entry:
	bra.s .Lother
	bsr.s .Lcold
	bra.s weak_before+2
	bsr.s weak_after+2
	rts
	.weak weak_after
weak_after:
	nop
	rts
	.section .text.unlikely
	.space 12,0
	.globl cold_alias
cold_alias:
.Lcold:
	rts
	.globl cold_entry
cold_entry:
	bra.s .Ltext
	bsr.s .Lother
	rts
	.section .text.other,"ax"
	.space 12,0
	.globl other_alias
other_alias:
.Lother:
	rts
	.globl other_entry
other_entry:
	bra.s .Lcold
	bsr.s .Ltext
	rts
