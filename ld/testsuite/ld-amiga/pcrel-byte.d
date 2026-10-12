#name: Amiga hunk deferred byte branches keep their PC base
#source: pcrel-byte.s
#as: -m68020
#ld: -e text_entry
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
[0-9a-f]+ <text_entry>:
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <other_alias>
 +[0-9a-f]+:\t61[0-9a-f]{2} +\tbsrs [0-9a-f]+ <cold_alias>
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <weak_before\+0x2>
 +[0-9a-f]+:\t61[0-9a-f]{2} +\tbsrs [0-9a-f]+ <weak_after\+0x2>
#...
[0-9a-f]+ <cold_entry>:
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <text_alias>
 +[0-9a-f]+:\t61[0-9a-f]{2} +\tbsrs [0-9a-f]+ <other_alias>
#...
[0-9a-f]+ <other_entry>:
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <cold_alias>
 +[0-9a-f]+:\t61[0-9a-f]{2} +\tbsrs [0-9a-f]+ <text_alias>
#pass
