| A base-relative (a4) reference to a symbol that is not in the data hunk.
| gcc 16.2-rc14 emitted this for "const char id[]" with an offset: the
| string lives in the text segment, a4 points into data, and the linker
| worked out the displacement as if id were data, so the program read a
| wrong address and nothing was reported.  The linker must refuse it.
	.text
	.globl	f
f:	pea	id+6:W(a4)
	rts
	.globl	id
id:	.ascii	"$VER: test 1.0\0"
	.data
	.globl	var
var:	.long	0
