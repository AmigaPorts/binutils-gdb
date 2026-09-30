#name: Amiga hunk one-only sections of different size
#source: oneonly-a.s
#source: oneonly-b.s
#as: -m68040
#ld: -e f
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

# Two objects each define the one-only section .text.inl, with bodies of
# different length.  The first copy is kept, the second is discarded, and
# ld says nothing about it: any output here fails the test.

.*: +file format amiga
#...
[0-9a-f]+ <f>:
 +[0-9a-f]+:	4eb9 [0-9a-f]{4} [0-9a-f]{4} 	jsr [0-9a-f]+ <inl>
 +[0-9a-f]+:	4e75           	rts
[0-9a-f]+ <inl>:
 +[0-9a-f]+:	4e71           	nop
 +[0-9a-f]+:	4e71           	nop
 +[0-9a-f]+:	4e71           	nop
 +[0-9a-f]+:	4e75           	rts
#pass
