#name: Amiga base-relative reference to an undefined weak symbol
#source: weak-undef-baserel.s
#as: -m68020
#ld: -m amiga_bss -e f
#target: m68k-*-amigaos*
#error: .*base-relative reference to the undefined weak symbol `g'.*
