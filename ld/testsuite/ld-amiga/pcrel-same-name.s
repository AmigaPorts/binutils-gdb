| The hunk backend maps .text.unlikely to another section named .text.
| These are different input sections despite having the same BFD name,
| whether the target is reached through a local label or a global symbol,
| and with a 32-bit or a 16-bit displacement.
	.text
	.space 12,0
	.globl normal_alias
normal_alias:
.Lnormal:
	rts
	.section .text.unlikely
	.space 64,0
	.globl cold_alias
cold_alias:
.Lcold:
	rts
	bra.l .Lnormal
	.text
	.globl entry
entry:
	bra.l .Lcold
	bra.l cold_alias
	bsr.w cold_alias
