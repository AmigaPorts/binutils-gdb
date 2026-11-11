#name: Amiga hunk weak reference through ld -r
#source: weak-undef.s
#as: -m68020
#ld: -r
#nm: -n
#target: m68k-*-amigaos*

# The partial link keeps the references weak, one per referencing hunk.

 +w g
 +w g
0+ T main
