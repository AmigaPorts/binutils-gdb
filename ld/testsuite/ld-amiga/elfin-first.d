#name: Amiga hunk output with an ELF object first in the text hunk
#source: elfin-b.s RUN_OBJCOPY
#source: elfin-a.s
#objcopy_objects: -O elf32-m68k
#ld: -e _start
#objdump: -s -j .text -j .data
#target: m68k-*-amigaos*

# The first text section seeds the long jump pass, which must take an ELF
# section's size as it is rather than lose its contents.

#...
Contents of section \.text:
 0000 20390000 000c4ef9 0000000c 4eb90000 .*
 0010 00002239 00000000 4e750000 .*
Contents of section \.data:
 0000 00000008 0000000c 00000001 00000002 .*
