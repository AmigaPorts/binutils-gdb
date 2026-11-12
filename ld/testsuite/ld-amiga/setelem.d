#name: Amiga hunk set elements from stabs
#source: setelem.s
#ld: -e _start
#objdump: -r -s -j .data
#target: m68k-*-amigaos*

# ld builds the set as a count, the elements and a terminating zero, in
# .data.  An element in a section gets a relocation in a load file, so the
# list stays valid after LoadSeg; an absolute element does not.  The link
# must not print anything.

.*: +file format amiga

RELOCATION RECORDS FOR \[\.data\]:
OFFSET +TYPE +VALUE
0+4 RELOC32 +\.text

Contents of section \.data:
 0000 00000002 00000002 00000000 00000000  .*
