#name: Amiga hunk objects into an ELF output
#source: pcrel-a.s
#source: pcrel-b.s
#as: -m68040
#ld: -e f --oformat=elf32-m68k
#error: amigaos object linked into an output of a different format
#target: m68k-*-amigaos*

# The hunk reloc code reads amiga private data from the output bfd, so
# asking for another output format must be an error, not a crash.
