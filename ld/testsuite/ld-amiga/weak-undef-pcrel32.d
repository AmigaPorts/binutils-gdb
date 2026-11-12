#name: Amiga 32-bit pc-relative address of an undefined weak symbol
#source: weak-undef-pcrel32.s
#as: -m68020
#ld: -e f
#target: m68k-*-amigaos*
#error: .*pc-relative reference to the undefined weak symbol `g'.*
