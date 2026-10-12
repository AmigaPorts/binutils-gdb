#name: Amiga hunk deferred byte branches with a zero field
#source: pcrel-byte-zero.s
#as: -m68020
#ld: -e zero_entry
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
[0-9a-f]+ <zero_entry>:
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <weak_target>
 +[0-9a-f]+:\t61[0-9a-f]{2} +\tbsrs [0-9a-f]+ <zero_alias>
 +[0-9a-f]+:\t60[0-9a-f]{2} +\tbras [0-9a-f]+ <zero_alias>
#pass
