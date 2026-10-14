#name: Amiga hunk output from ELF objects with --gc-sections
#source: elfin-a.s
#source: elfin-b.s RUN_OBJCOPY
#objcopy_objects: -O elf32-m68k
#ld: -e _start --gc-sections
#warning: --gc-sections is not supported with ELF input, keeping all sections
#objdump: -r
#target: m68k-*-amigaos*

# The section collector only knows amiga and a.out input; with an ELF
# object it keeps everything instead of crashing.

#...
RELOCATION RECORDS FOR \[\.text\]:
OFFSET +TYPE +VALUE
0+2 RELOC32 +\.text
0+18 RELOC32 +\.text
0+8 RELOC32 +\.data
0+12 RELOC32 +\.data
#pass
