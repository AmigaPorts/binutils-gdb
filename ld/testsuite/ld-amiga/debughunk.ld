OUTPUT_FORMAT("amiga")
OUTPUT_ARCH(m68k)
SECTIONS
{
  .text : { *(.text) }
  .dwarf : { *(.debug_info) }
  .data : { *(.data) }
}
