#name: Amiga hunk output from hunk and ELF objects
#source: elfin-a.s
#source: elfin-b.s RUN_OBJCOPY
#objcopy_objects: -O elf32-m68k
#ld: -e _start
#objdump: -r
#target: m68k-*-amigaos*

# Absolute references in an ELF object must reach the loader as hunk
# relocs, like those of a hunk object, instead of being resolved to
# link-time offsets: elfin-b.o's code at .text+0x10 and its data at
# .data+0x8.

#...
RELOCATION RECORDS FOR \[\.text\]:
OFFSET +TYPE +VALUE
0+2 RELOC32 +\.text
0+18 RELOC32 +\.text
0+8 RELOC32 +\.data
0+12 RELOC32 +\.data

RELOCATION RECORDS FOR \[\.data\]:
OFFSET +TYPE +VALUE
0+c RELOC32 +\.text
0+8 RELOC32 +\.data
#pass
