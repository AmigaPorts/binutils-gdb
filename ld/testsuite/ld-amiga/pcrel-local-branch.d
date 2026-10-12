#name: Amiga hunk relaxed local branches keep their PC base
#source: pcrel-local-branch.s
#as: -m68020
#ld: -e local_entry
#objdump: -d --architecture=m68k:68020
#target: m68k-*-amigaos*

.*: +file format amiga
#...
0+c <local_entry>:
 +c:\t6004           \tbras 12 <local_entry\+0x6>
 +e:\t4e71           \tnop
 +10:\t4e71           \tnop
 +12:\t60fc           \tbras 10 <local_entry\+0x4>
 +14:\t4e75           \trts
#pass
