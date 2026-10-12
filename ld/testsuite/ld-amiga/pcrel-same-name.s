| The hunk backend maps .text.unlikely to another section named .text.
| These are different input sections despite having the same BFD name.
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
