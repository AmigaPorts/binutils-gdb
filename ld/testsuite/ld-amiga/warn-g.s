| _g with a link warning, as BSD's __warn_references writes it: an N_WARNING
| stab with the message, then one naming the symbol.
	.stabs	"_g is deprecated",30,0,0,0
	.stabs	"_g",1,0,0,0
	.text
	.globl	_g
_g:	moveq	#2,%d0
	rts
