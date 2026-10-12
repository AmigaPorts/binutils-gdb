#name: Amiga hunk local pc-relative targets at nonzero section offsets
#source: pcrel-local.s
#as: -m68020
#ld: -e caller
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
[0-9a-f]+ <caller>:
 +[0-9a-f]+:\t60ff ffff [0-9a-f]+ \tbral [0-9a-f]+ <before_alias>
 +[0-9a-f]+:\t60ff ffff [0-9a-f]+ \tbral [0-9a-f]+ <before_alias\+0x2>
 +[0-9a-f]+:\t61ff 0000 [0-9a-f]+ \tbsrl [0-9a-f]+ <after_alias>
 +[0-9a-f]+:\t60ff 0000 [0-9a-f]+ \tbral [0-9a-f]+ <after_alias\+0x2>
#pass
