#name: Amiga hunk pc-relative targets in sections with the same name
#source: pcrel-same-name.s
#as: -m68020
#ld: -e entry
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
[0-9a-f]+ <entry>:
 +[0-9a-f]+:\t60ff 0000 [0-9a-f]+ \tbral [0-9a-f]+ <cold_alias>
 +[0-9a-f]+:\t60ff 0000 [0-9a-f]+ \tbral [0-9a-f]+ <cold_alias>
 +[0-9a-f]+:\t6100 [0-9a-f]+ +\tbsrw [0-9a-f]+ <cold_alias>
#...
[0-9a-f]+ <cold_alias>:
 +[0-9a-f]+:\t4e75           \trts
 +[0-9a-f]+:\t60ff ffff [0-9a-f]+ \tbral [0-9a-f]+ <normal_alias>
#pass
