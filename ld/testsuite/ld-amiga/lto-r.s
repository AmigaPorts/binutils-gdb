| What GCC emits with -flto for a translation unit with no symbols: an
| empty LTO symbol table, and other LTO sections with contents.
	.section .gnu.lto_.symtab.0
	.section .gnu.lto_.opts
	.long	0x11111111, 0x22222222
