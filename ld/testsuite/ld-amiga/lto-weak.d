#name: Amiga weak undefined symbol of an LTO symbol table
#source: lto-weak.s
#as: -m68020
#ld: -r
#nm: -n
#target: m68k-*-amigaos*

# Without the plugin, the undefined symbols of an LTO symbol table are read
# from its records, and a weak one stays weak.

 +U s
 +w w
0+ T f
