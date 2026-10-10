#name: Amiga hunk weak definition overridden by a strong one
#source: weak-override-a.s
#source: weak-override-b.s
#as: -m68020
#ld: -e main
#objdump: -dr --architecture=m68k:68020
#target: m68k-*-amigaos*

# References to a weak symbol defined in the same object must be resolved
# by name, so they reach the strong definition from the other object.

.*: +file format amiga
#...
0+ <.*>:
 +0:	4eb9 [0-9a-f]+ [0-9a-f]+ 	jsr [0-9a-f]+ <f>
#...
 +[0-9a-f]+:	61ff [0-9a-f]+ [0-9a-f]+ 	bsrl [0-9a-f]+ <f>
#...
[0-9a-f]+ <f>:
 +[0-9a-f]+:	7002           	moveq #2,d0
#pass
