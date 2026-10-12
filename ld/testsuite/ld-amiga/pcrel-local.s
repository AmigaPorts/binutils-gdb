| Local targets at nonzero offsets in another input section.  GAS folds
| each local symbol into section + offset; that offset must survive the
| hunk object writer and the final (or relocatable) link.
	.section .text.before,"ax"
	.space 12,0
	.globl before_alias
before_alias:
.Lbefore:
	moveq #17,d0
	rts
	.section .text.caller,"ax"
	.space 12,0
	.globl caller
caller:
	bra.l .Lbefore
	bra.l .Lbefore+2
	bsr.l .Lafter
	bra.l .Lafter+2
	rts
	.section .text.after,"ax"
	.space 64,0
	.globl after_alias
after_alias:
.Lafter:
	moveq #23,d0
	rts
