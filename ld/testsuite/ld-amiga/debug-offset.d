#name: Amiga hunk DWARF references are section offsets
#source: debug-offset.s
#ld: -amiga-debug-hunk -e _start
#objdump: -s -j .dwarf2
#target: m68k-*-amigaos*

# Each DWARF output section starts at address zero, so a reference into
# another one holds the offset within it: 4, in the third word of the
# merged .dwarf2, after the lengths of the empty .debug_frame and of
# .debug_info.

.*: +file format amiga

Contents of section \.dwarf2:
 0000 00000000 00000004 00000004 00000000  .*
#pass
