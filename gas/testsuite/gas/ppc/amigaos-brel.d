#objdump: -r -s -j .text -j .data
#name: AmigaOS base-relative relocations

.*:     file format elf32-powerpc-amigaos

RELOCATION RECORDS FOR \[\.text\]:
OFFSET   TYPE              VALUE
0+02 R_PPC_AMIGAOS_BREL_HA  \.sdata
0+06 R_PPC_AMIGAOS_BREL_LO  \.sdata
0+0a R_PPC_AMIGAOS_BREL_LO  \.sdata\+0x0+04
0+0e R_PPC_AMIGAOS_BREL_HI  \.sdata\+0x0+08


RELOCATION RECORDS FOR \[\.data\]:
OFFSET   TYPE              VALUE
0+00 R_PPC_AMIGAOS_BREL  \.sdata\+0x0+08


Contents of section \.text:
 0000 3c600000 38630000 80820000 3ca00000  .*
Contents of section \.data:
 0000 00000000                             .*
