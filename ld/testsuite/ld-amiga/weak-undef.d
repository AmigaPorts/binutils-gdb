#name: Amiga hunk undefined weak reference
#source: weak-undef.s
#as: -m68020
#ld: -e main
#objdump: -dr --architecture=m68k:68020
#target: m68k-*-amigaos*

# An undefined weak symbol is not an error: it is the address 0.

.*: +file format amiga
#...
0+ <.*>:
 +0:	203c 0000 0000 	movel #0,d0
 +6:	6706           	beqs .*
 +8:	4eb9 0000 0000 	jsr 0 .*
 +e:	4e75           	rts
#pass
