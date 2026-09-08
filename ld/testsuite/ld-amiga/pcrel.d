#name: Amiga hunk pc-relative branch targets
#source: pcrel-a.s
#source: pcrel-b.s
#as: -m68040
#ld: -e f
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

# bra.l to a strong or weak symbol defined earlier in the same object,
# with and without addend, and to a symbol from another object, must
# land on the symbol.

.*: +file format amiga
#...
[0-9a-f]+ <f>:
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <far>
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <far\+0x4>
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <weak>
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <weak\+0x4>
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <ext>
 +[0-9a-f]+:	60ff ffff [0-9a-f]+ 	bral [0-9a-f]+ <ext\+0x4>
[0-9a-f]+ <wloc>:
 +[0-9a-f]+:	4e75           	rts
 +[0-9a-f]+:	60ff ffff fffc 	bral [0-9a-f]+ <wloc>
#pass
