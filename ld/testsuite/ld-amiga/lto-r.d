#name: Amiga LTO sections through a partial link
#source: lto-r.s
#as: -m68040
#ld: -r
#objdump: -h -s
#target: m68k-*-amigaos*

# lto-plugin claims only objects with a .gnu.lto_.symtab section, so an
# empty one must be kept.  The "LTO1" header of each LTO hunk is not part
# of the section: the partial link writes it once, not around the old one.

.*: +file format amiga
#...
 +[0-9]+ \.gnu\.lto_\.symtab\.0 +0+ .*
 +CONTENTS, DEBUGGING
 +[0-9]+ \.gnu\.lto_\.opts +0+8 .*
 +CONTENTS, DEBUGGING
Contents of section \.gnu\.lto_\.opts:
 0000 11111111 22222222 +.*
#pass
