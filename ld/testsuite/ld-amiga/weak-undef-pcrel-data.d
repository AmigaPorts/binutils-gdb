#name: Amiga pc-relative reference to an undefined weak symbol from data
#source: weak-undef-pcrel-data.s
#as: -m68020
#ld: -e f
#target: m68k-*-amigaos*
#error: .*pc-relative reference to the undefined weak symbol `g'.*
