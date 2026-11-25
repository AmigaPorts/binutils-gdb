#name: Amiga strip keeps the bss of the data hunk out of the file
#source: strip-bss.s
#ld: -m amiga_bss -e _start
#objcopy_linked_file: --strip-all
#objdump: -b binary -s
#target: m68k-*-amigaos*

# The data hunk is 0x402 longs in the header and 2 in the file, as ld
# wrote it: the stripped file is the one ld -s writes.  objcopy used to
# fail with "is too large", as the hunk reaches past the end of the
# file, and with a smaller bss wrote it out as zeros.

.*: +file format binary

Contents of section \.data:
 0000 000003f3 00000000 00000002 00000000  .*
 0010 00000001 00000002 00000402 000003e9  .*
 0020 00000002 20390000 00004e75 000003ec  .*
 0030 00000001 00000001 00000002 00000000  .*
 0040 000003f2 000003ea 00000002 12345678  .*
 0050 00000000 000003ec 00000001 00000000  .*
 0060 00000004 00000000 000003f2           .*
