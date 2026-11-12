#name: Amiga pc-relative reference to an undefined weak symbol
#source: weak-undef-pcrel.s
#as: -m68020
#ld: -e f
#target: m68k-*-amigaos*
#error: .*pc-relative reference to the undefined weak symbol `g'.*
