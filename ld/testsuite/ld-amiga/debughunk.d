#name: Amiga hunk debug section between loadable sections
#source: debughunk.s
#as: -m68040
#ld: -T $srcdir/$subdir/debughunk.ld
#objdump: -h -r
#target: m68k-*-amigaos*

# A non-alloc output section is written as HUNK_DEBUG, which LoadSeg does
# not number: it must stay out of the HUNK_HEADER table and the hunk after
# it must be relocated as hunk 1, not 2.  With a wrong table or hunk number
# the file does not even read back.

.*: +file format amiga
#...
 +0 \.text +0+8 .*
 +CONTENTS, ALLOC, LOAD, RELOC, CODE
 +1 \.dwarf2 +0+10 .*
 +CONTENTS, ALLOC, DEBUGGING
 +2 \.data +0+4 .*
 +CONTENTS, ALLOC, LOAD, DATA
RELOCATION RECORDS FOR \[\.text\]:
#...
0+2 RELOC32 +\.data
#pass
