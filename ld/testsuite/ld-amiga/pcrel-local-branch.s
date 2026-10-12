| Preserve 67a99433: GAS itself must resolve relaxed local branches
| within one input section, using their ordinary PC base.
	.text
	.space 12,0
	.globl local_entry
local_entry:
	jra .Lforward
	nop
.Lbackward:
	nop
.Lforward:
	jra .Lbackward
	rts
