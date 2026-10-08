/* The default script with one addition: the custom section .romver goes
   into the text hunk, as a ROM build does with its version string.  */
OUTPUT_FORMAT("amiga")
OUTPUT_ARCH(m68k)
SECTIONS
{
  .text :
  {
    *(.text)
    *(.text*)
    *(.rodata*)
    *(.romver)
  }
  .data :
  {
    *(.data)
    *(.data.*)
  }
  .bss :
  {
    *(.bss)
    *(.bss.*)
    *(COMMON)
  }
}
