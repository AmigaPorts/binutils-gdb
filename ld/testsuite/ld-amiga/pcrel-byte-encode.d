#name: Amiga hunk byte branch displacements 0 and -1 are rejected
#source: pcrel-byte-encode.s
#as: -m68020
#ld: -e encode_entry
#error: .*byte branch displacement 0 cannot be encoded.*byte branch displacement -1 cannot be encoded.*
#target: m68k-*-amigaos*
