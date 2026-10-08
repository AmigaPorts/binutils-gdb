| The same wrong reference as baserel-text.s, but the string is in a
| custom section that baserel.ld places in the text hunk, as the
| kicksmash32 ROM switcher does with its version string.  The input
| section is flagged as data, so only the output section tells.
	.text
	.globl	f
f:	pea	id+6:W(a4)
	rts
	.section .romver,"a"
	.globl	id
id:	.ascii	"$VER: test 1.0\0"
	.data
	.globl	var
var:	.long	0
