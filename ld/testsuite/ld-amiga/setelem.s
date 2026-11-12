	.text
	.globl	_start
_start:
	rts
_f:
	rts

	| A constructor list entry in the a.out set format: a function
	| (N_SETT) and its priority (N_SETA).
	.stabs	"___INIT_LIST__",22,0,0,_f
	.stabs	"___INIT_LIST__",20,0,0,0
