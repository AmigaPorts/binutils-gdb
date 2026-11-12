#name: Amiga hunk DWARF references are section offsets (amiga_bss)
#source: debug-offset.s
#ld: -m amiga_bss -amiga-debug-hunk -e _start
#objdump: -s -j .dwarf2
#target: m68k-*-amigaos*

# As debug-offset, with the script of -fbaserel, -resident and -shared links.

.*: +file format amiga

Contents of section \.dwarf2:
 0000 00000000 00000004 00000004 00000000  .*
#pass
