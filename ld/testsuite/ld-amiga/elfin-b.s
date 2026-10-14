| Converted to ELF by objcopy, so it only refers to symbols of elfin-a.s:
| a hunk object refers to its own sections by hunk, which objcopy cannot
| turn into ELF section symbols.
	.text
	.globl	_elffn
_elffn:
	move.l	_hunkdata+4,d0
	jmp	_start

	.data
	.globl	_elfdata
_elfdata:
	.long	_hunkdata
	.long	_start
