#name: Amiga hunk pc-relative reloc fields
#as: -m68040
#objdump: -dr --architecture=m68k:68020 -j .text.f
#target: m68k-*-amigaos*

# A deferred pc-relative reloc keeps the target's offset within its
# section (plus any addend) in the field; the linker subtracts the PC.
# The offset is the same one an absolute reloc to the symbol carries.
# A weak target in a section that also has a strong definition is
# resolved by name, so a strong definition elsewhere can override it,
# and the field holds only the addend, as for an undefined symbol.

.*: +file format amiga

Disassembly of section \.text\.f:

0+ <f>:
 +0:	60ff 0000 0100 	bral .*
			2: RELRELOC32	\.text
 +6:	60ff 0000 0104 	bral .*
			8: RELRELOC32	\.text
 +c:	4eb9 0000 0100 	jsr .*
			e: RELOC32	\.text
 +12:	60ff 0000 0000 	bral .*
			14: RELRELOC32	weak
 +18:	60ff 0000 0004 	bral .*
			1a: RELRELOC32	weak
 +1e:	4eb9 0000 0000 	jsr .*
			20: RELOC32	weak
 +24:	60ff 0000 0000 	bral .*
			26: RELRELOC32	ext
 +2a:	60ff 0000 0004 	bral .*
			2c: RELRELOC32	ext
#...
0+40 <wloc>:
 +40:	4e75           	rts
 +42:	60ff 0000 0000 	bral .*
			44: RELRELOC32	wloc
#pass
