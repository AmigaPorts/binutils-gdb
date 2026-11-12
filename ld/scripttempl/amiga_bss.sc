cat <<EOF
OUTPUT_FORMAT("${OUTPUT_FORMAT}")
OUTPUT_ARCH(${ARCH})

${RELOCATING+${LIB_SEARCH_DIRS}}
${STACKZERO+${RELOCATING+${STACKZERO}}}
${SHLIB_PATH+${RELOCATING+${SHLIB_PATH}}}

SECTIONS
{
  ${RELOCATING+PROVIDE(___machtype = 0x0);}
  ${RELOCATING+. = ${TEXT_START_ADDR};}
  .text :
  {
    ${RELOCATING+__stext = .;}
    *(.text)
    *(.text.main)
    *(.text*)
    *(_*)
    *(.rodata*)
    *(.data.rel.ro*)
    *(.gnu.linkonce.t.*)
    *(.gnu.linkonce.r.*)
    *(.gcc_except_table*)
    ${RELOCATING+*(SORT_BY_NAME(.list___EH_FRAME*))}
    ${RELOCATING+*(SORT_BY_NAME(.list_*))}
    ${RELOCATING+*(.end_of_lists)}
    ${RELOCATING+___datadata_relocs = .;}
    ${RELOCATING+__etext = .;}
    ${PAD_TEXT+${RELOCATING+. = ${DATA_ALIGNMENT};}}
  }
  ${RELOCATING+___text_size = SIZEOF(.text);}
  ${RELOCATING+. = ${DATA_ALIGNMENT};}
  .data :
  {
    ${RELOCATING+__sdata = .;}
    *(.data)
    *(SORT_BY_NAME(.data.*))
    ${CONSTRUCTING+CONSTRUCTORS}    
    ${RELOCATING+*(SORT_BY_NAME(.dlist___EH_FRAME_OBJECT*))}
    ${RELOCATING+*(SORT_BY_NAME(.dlist_*))}
    ${RELOCATING+*(.end_of_dlists)}
    *(.data.__EH_FRAME_OBJECT__*)    
    *(.gnu.linkonce.d.*)
    ${RELOCATING+___a4_init = 0x7ffe;}
    ${RELOCATING+__edata = .;}
  }
  .bss :
  {
    ${RELOCATING+__bss_start = .;}
    ${RELOCATING+___a4_init2 = 0x7ffe;}
    *(.bss)
    *(.bss.*)
    *(COMMON)
    ${RELOCATING+__end = .;}
  }
  ${RELOCATING+___data_size = SIZEOF(.data) + SIZEOF(.bss);}
  ${RELOCATING+___bss_size = 0x0;}
  ${RELOCATING+___bss_init_size = SIZEOF(.bss);}
  .datachip :
  {
    *(.datachip)
  }
  .bsschip :
  {
    *(.bsschip)
  }
  
  /* 
   * Individual DWARF sections are collected here.
   * The BFD backend (amigaos.c) will merge them into a single .dwarf2
   * section with length prefixes for the AmigaOS debug format.
   * The order here must match the order expected by amiga_pack_dwarf_sections()
   * in amigaos.c
   */
  .debug_frame 0 : { *(.debug_frame) }
  .debug_info 0 : { *(.debug_info) *(.gnu.linkonce.wi.*) }
  .debug_abbrev 0 : { *(.debug_abbrev) }
  .debug_loclists 0 : { *(.debug_loclists) }
  .debug_aranges 0 : { *(.debug_aranges) }
  .debug_rnglists 0 : { *(.debug_rnglists) }
  .debug_line 0 : { *(.debug_line) *(.debug_line.*) }
  .debug_str 0 : { *(.debug_str) }
  .debug_line_str 0 : { *(.debug_line_str) }
  /* Additional DWARF sections for completeness */
  .debug_types 0 : { *(.debug_types) }
  .debug_macro 0 : { *(.debug_macro) }
  .debug_ranges 0 : { *(.debug_ranges) }
  .debug_addr 0 : { *(.debug_addr) }
  .debug_str_offsets 0 : { *(.debug_str_offsets) }
}
EOF