. ${srcdir}/emulparams/elf32ppccommon.sh
. ${srcdir}/emulparams/plt_unwind.sh

TEMPLATE_NAME=elf
EXTRA_EM_FILE=ppc32elf
SCRIPT_NAME=elf
OUTPUT_FORMAT="elf32-powerpc-amigaos"
MAXPAGESIZE="CONSTANT (MAXPAGESIZE)"
COMMONPAGESIZE="CONSTANT (COMMONPAGESIZE)"
DATA_SEGMENT_ALIGN="ALIGN(${SEGMENT_SIZE})"
ALIGNMENT=16
ARCH=powerpc
MACHINE=
GENERATE_SHLIB_SCRIPT=yes
TEXT_START_ADDR=0x01000000
SHLIB_TEXT_START_ADDR=0x10000000
unset WRITABLE_RODATA
DATA_START_SYMBOLS="_DATA_BASE_ = .;"
SDATA_START_SYMBOLS="_SDA_BASE_ = . + 0x8000;"
DATA_GOT=
SDATA_GOT=
TEXT_PLT=yes
# elf.library fills in .plt, which takes no space in the file, when it
# loads the program.  Put it at the end of the code, where a section
# without contents can go, on pages of its own.
PLT_AFTER_TEXT=" "
SEPARATE_GOTPLT=0
unset BSS_PLT
unset DATA_PLT
GOT=".got          ${RELOCATING-0} : SPECIAL { *(.got) }"
PLT=". = ALIGN(4096);
  .plt          ${RELOCATING-0} :  { *(.plt) }
  . = ALIGN(4096);"
# GOTPLT="${PLT}"
OTHER_TEXT_SECTIONS="*(.glink)"
ENABLE_INITFINI_ARRAY=no
DYNAMIC_LINK=false
