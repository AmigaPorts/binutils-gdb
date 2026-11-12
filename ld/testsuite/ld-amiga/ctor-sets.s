| Set elements in the a.out stabs format, as old constructor macros emit
| them: a function (N_SETT) and a priority (N_SETA) in one list, a data
| address (N_SETD) in another.  The elements are not at the start of
| their sections, so a wrong section offset shows in the lists.
	.text
	.globl	_start
_start:	rts
	.space	6
_f:	rts
	.data
	.long	0x11111111
_d:	.long	0x22222222
	.stabs	"___INIT_LIST__",22,0,0,_f
	.stabs	"___INIT_LIST__",20,0,0,5
	.stabs	"___DATA_LIST__",24,0,0,_d
