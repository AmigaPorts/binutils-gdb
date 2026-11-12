#name: m68k-amigaoself ELF object into a hunk load file
#source: amigaoself.s
#ld: -m amiga -e _start
#objdump: -h -r
#target: m68k-*-amigaoself*

# The amiga emulation links ELF objects into a load file, with a hunk
# relocation for each absolute reference.

.*: +file format amiga

Sections:
Idx Name +Size +VMA +LMA +File off +Algn
 +0 \.text +0+10 .*
 +CONTENTS, ALLOC, LOAD, RELOC, CODE
 +1 \.data +0+4 .*
 +CONTENTS, ALLOC, LOAD, RELOC, DATA

RELOCATION RECORDS FOR \[\.text\]:
OFFSET +TYPE +VALUE
0+2 RELOC32 +\.data

RELOCATION RECORDS FOR \[\.data\]:
OFFSET +TYPE +VALUE
0+0 RELOC32 +\.text
#pass
