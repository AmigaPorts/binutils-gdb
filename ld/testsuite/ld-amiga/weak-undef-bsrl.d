#name: Amiga bsr.l and bra.l to an undefined weak symbol
#source: weak-undef-bsrl.s
#as: -m68020
#ld: -e f
#objdump: -dr --architecture=m68k:68020
#target: m68k-*-amigaos*

# The two become a jsr and a jmp to the absolute address 0, without a
# relocation.

.*: +file format amiga
#...
0+ <.*>:
 +0:	4eb9 0000 0000 	jsr 0 .*
 +6:	4ef9 0000 0000 	jmp 0 .*
#pass
