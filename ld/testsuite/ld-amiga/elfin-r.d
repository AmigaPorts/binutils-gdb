#name: Amiga relocatable hunk output from hunk and ELF objects
#source: elfin-a.s
#source: elfin-b.s RUN_OBJCOPY
#objcopy_objects: -O elf32-m68k
#ld: -r
#objdump: -r
#target: m68k-*-amigaos*

# A partial link keeps the ELF object's relocs, as amiga ones, for the
# final link.

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
