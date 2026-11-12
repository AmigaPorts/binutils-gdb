#name: Amiga hunk ISA_C pc-relative jbra relaxation
#as: -march=isac -pcrel
#objdump: -d --architecture=m68k:isa-c
#target: m68k-*-amigaos*

.*: +file format amiga

Disassembly of section \.text:

0+ <start>:
 +0:	6000 010e      	braw 110 <near>
 +4:	66ff 0000 810a 	bnel 8110 <far>
 +a:	67ff 0000 8104 	beql 8110 <far>
#pass
