#name: Amiga hunk weak definition next to a local one overridden
#source: weak-override-local-a.s
#source: weak-override-b.s
#as: -m68020
#ld: -e main
#objdump: -dr --architecture=m68k:68020
#target: m68k-*-amigaos*

# The local definition of g keeps .text from being one-only, so the
# references to the weak f in it must reach the strong f in the other object.

.*: +file format amiga
#...
 +[0-9a-f]+:	4eb9 [0-9a-f]+ [0-9a-f]+ 	jsr [0-9a-f]+ <f>
#...
 +[0-9a-f]+:	61ff [0-9a-f]+ [0-9a-f]+ 	bsrl [0-9a-f]+ <f>
#...
[0-9a-f]+ <f>:
 +[0-9a-f]+:	7002           	moveq #2,d0
#pass
