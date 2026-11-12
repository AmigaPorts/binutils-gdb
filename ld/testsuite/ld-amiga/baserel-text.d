#name: Amiga base-relative reference to a text symbol
#source: baserel-text.s
#as: -m68020
#ld: -m amiga_bss -e f
#target: m68k-*-amigaos*
#error: .*base-relative reference into section \.text, which is not in the data hunk.*
