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
    ${RELOCATING+__edata = .;}
  }
  ${RELOCATING+___data_size = SIZEOF(.data);}
  .bss :
  {
    ${RELOCATING+__bss_start = .;}
    *(.bss)
    *(.bss.*)
    *(COMMON)
    ${RELOCATING+__end = .;}
  }
  ${RELOCATING+___bss_size = SIZEOF(.bss);}
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
  .debug_frame 0 :
  {
    ${RELOCATING+__debug_frame_start = .;}
    *(.debug_frame)
    ${RELOCATING+__debug_frame_end = .;}
  }
  .debug_info 0 :
  {
    ${RELOCATING+__debug_info_start = .;}
    *(.debug_info)
    *(.gnu.linkonce.wi.*)
    ${RELOCATING+__debug_info_end = .;}
  }
  .debug_abbrev 0 :
  {
    ${RELOCATING+__debug_abbrev_start = .;}
    *(.debug_abbrev)
    ${RELOCATING+__debug_abbrev_end = .;}
  }
  .debug_loclists 0 :
  {
    ${RELOCATING+__debug_loclists_start = .;}
    *(.debug_loclists)
    ${RELOCATING+__debug_loclists_end = .;}
  }
  .debug_aranges 0 :
  {
    ${RELOCATING+__debug_aranges_start = .;}
    *(.debug_aranges)
    ${RELOCATING+__debug_aranges_end = .;}
  }
  .debug_rnglists 0 :
  {
    ${RELOCATING+__debug_rnglists_start = .;}
    *(.debug_rnglists)
    ${RELOCATING+__debug_rnglists_end = .;}
  }
  .debug_line 0 :
  {
    ${RELOCATING+__debug_line_start = .;}
    *(.debug_line)
    *(.debug_line.*)
    ${RELOCATING+__debug_line_end = .;}
  }
  .debug_str 0 :
  {
    ${RELOCATING+__debug_str_start = .;}
    *(.debug_str)
    ${RELOCATING+__debug_str_end = .;}
  }
  .debug_line_str 0 :
  {
    ${RELOCATING+__debug_line_str_start = .;}
    *(.debug_line_str)
    ${RELOCATING+__debug_line_str_end = .;}
  }
  /* Additional DWARF sections for completeness */
  .debug_types 0 :
  {
    ${RELOCATING+__debug_types_start = .;}
    *(.debug_types)
    ${RELOCATING+__debug_types_end = .;}
  }
  .debug_macro 0 :
  {
    ${RELOCATING+__debug_macro_start = .;}
    *(.debug_macro)
    ${RELOCATING+__debug_macro_end = .;}
  }
  .debug_ranges 0 :
  {
    ${RELOCATING+__debug_ranges_start = .;}
    *(.debug_ranges)
    ${RELOCATING+__debug_ranges_end = .;}
  }
  .debug_addr 0 :
  {
    ${RELOCATING+__debug_addr_start = .;}
    *(.debug_addr)
    ${RELOCATING+__debug_addr_end = .;}
  }
  .debug_str_offsets 0 :
  {
    ${RELOCATING+__debug_str_offsets_start = .;}
    *(.debug_str_offsets)
    ${RELOCATING+__debug_str_offsets_end = .;}
  }
}
EOF