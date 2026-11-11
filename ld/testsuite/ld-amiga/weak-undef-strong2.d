#name: Amiga hunk strong then weak reference, undefined
#source: weak-archive-ref.s
#source: weak-undef.s
#as: -m68020
#ld: -e main
#target: m68k-*-amigaos*
#error: .*weak-archive-ref\.o.*undefined reference to `g'.*
