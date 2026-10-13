#name: Amiga hunk deferred pc-relative addressing modes keep their PC base
#source: pcrel-index.s
#as: -m68020
#ld: -e text_entry
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
[0-9a-f]+ <text_entry>:
 +[0-9a-f]+:\t41fb [0-9a-f]{4} +\tlea %pc@\([0-9a-f]+ <other_alias>,d0:w\),a0
 +[0-9a-f]+:\t203b 1920 [0-9a-f]{4} \tmovel %pc@\([0-9a-f]+ <cold_alias>,d1:l\),d0
 +[0-9a-f]+:\t41fb 0130 [0-9a-f]{4} \tlea %pc@\([0-9a-f]+ <weak_before\+0x2>,d0:w\),a0
 +[0-9a-f]+:\t[0-9a-f]{4} *
 +[0-9a-f]+:\t41fb 0170 [0-9a-f]{4} \tlea %pc@\([0-9a-f]+ <weak_after\+0x2>\),a0
 +[0-9a-f]+:\t[0-9a-f]{4} *
 +[0-9a-f]+:\t203b 10[0-9a-f]{2} +\tmovel %pc@\([0-9a-f]+ <weak_after>,d1:w\),d0
#...
[0-9a-f]+ <cold_entry>:
 +[0-9a-f]+:\t41fb 00[0-9a-f]{2} +\tlea %pc@\([0-9a-f]+ <text_alias>,d0:w\),a0
 +[0-9a-f]+:\t203b 1930 [0-9a-f]{4} \tmovel %pc@\([0-9a-f]+ <other_alias>,d1:l\),d0
#...
[0-9a-f]+ <other_entry>:
 +[0-9a-f]+:\t41fb 0170 [0-9a-f]{4} \tlea %pc@\([0-9a-f]+ <cold_alias>\),a0
 +[0-9a-f]+:\t[0-9a-f]{4} *
 +[0-9a-f]+:\t203b 1120 [0-9a-f]{4} \tmovel %pc@\([0-9a-f]+ <text_alias>,d1:w\),d0
#pass
