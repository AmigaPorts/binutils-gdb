| PC-relative effective addresses whose fixup is left to the linker:
| d8(pc,Xn), (bd.w,pc,Xn), (bd.l,pc,Xn) and (bd.l,pc), to a local label
| in another named section, to a local label in a distinct section with
| the same name (.text.unlikely maps to .text), and to a weak symbol in
| the same section.  The PC base is the first extension word, 1 byte
| before an 8-bit displacement and 2 bytes before a base displacement.
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
	lea (.Lother.b,pc,d0.w),a0
	move.l (.Lcold.w,pc,d1.l),d0
	lea (weak_before+2,pc,d0.w),a0
	lea (weak_after+2,pc),a0
	move.l (weak_after.b,pc,d1.w),d0
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
	lea (.Ltext.b,pc,d0.w),a0
	move.l (.Lother,pc,d1.l),d0
	rts
	.section .text.other,"ax"
	.space 12,0
	.globl other_alias
other_alias:
.Lother:
	rts
	.globl other_entry
other_entry:
	lea (.Lcold,pc),a0
	move.l (.Ltext.w,pc,d1.w),d0
	rts
