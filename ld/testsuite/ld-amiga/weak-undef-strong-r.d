#name: Amiga hunk weak and strong reference through ld -r
#source: weak-undef.s
#source: weak-archive-ref.s
#as: -m68020
#ld: -r
#nm: -n
#target: m68k-*-amigaos*

# The partial link must not write the strong reference out as a weak one.

 +U g
 +U g
0+ T main
0+10 T h
