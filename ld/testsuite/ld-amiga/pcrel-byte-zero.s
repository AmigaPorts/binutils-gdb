| Byte branches left to the linker whose in-place field is 0 or -1: to a
| weak symbol with no addend and to a local label at offset 0 of another
| section.  Only the linked displacement selects the branch size, so the
| assembler must not reject them.
	.text
	.space 12,0
	.globl zero_entry
zero_entry:
	bra.s weak_target
	bsr.s .Lzero
	bra.s .Lzero
	rts
	.space 12,0
	.weak weak_target
weak_target:
	rts
	.section .text.zero,"ax"
	.globl zero_alias
zero_alias:
.Lzero:
	rts
