#name: Amiga hunk weak then strong reference, undefined
#source: weak-undef.s
#source: weak-archive-ref.s
#as: -m68020
#ld: -e main
#target: m68k-*-amigaos*
#error: .*weak-undef\.o.*undefined reference to `g'.*

# The strong reference of the second object makes g a plain undefined
# symbol, for the weak references of the first one too.
