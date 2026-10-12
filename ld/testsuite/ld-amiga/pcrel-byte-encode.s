| Byte branches left to the linker whose final displacement is 0 or -1.
| Those values in the opcode select bra.w and bra.l, so the branch
| cannot be encoded and the link must fail.
	.text
	.space 12,0
	.globl encode_entry
encode_entry:
	bra.s next_insn
	.weak next_insn
next_insn:
	bra.s own_field+1
	.weak own_field
own_field = next_insn
	rts
