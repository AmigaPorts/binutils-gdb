#name: Amiga pc-relative reference into another hunk
#source: pcrel-hunk.s
#ld: -e _start
#target: m68k-*-amigaos*
#error: .*pcrel-hunk\.o\(\.text\): relocation "\.data\+0x0 \(type RELRELOC32\)" goes out of range
