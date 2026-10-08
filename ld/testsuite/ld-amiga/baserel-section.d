#name: Amiga base-relative reference into a custom section placed in text
#source: baserel-section.s
#as: -m68020
#ld: --amiga-databss-together -e f -T baserel.ld
#target: m68k-*-amigaos*
#error: .*base-relative reference into section \.romver, which is not in the data hunk.*
