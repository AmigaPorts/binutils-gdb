# AmigaOS 4 base-relative relocations, relative to .data in r2.
	.text
	lis 3, x@brel@ha
	addi 3, 3, x@brel@l
	lwz 4, (x+4)@brel@l(2)
	lis 5, (x+8)@brel@h

	.data
	.long (x+8)@brel

	.section .sdata,"aw"
x:	.long 0, 0, 0
