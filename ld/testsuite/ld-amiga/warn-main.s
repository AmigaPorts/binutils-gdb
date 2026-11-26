| Calls _f, which one archive member defines, and _g, which a member of
| another archive defines with a link warning.
	.text
	.globl	_start
_start:	jsr	_f
	jsr	_g
	rts
