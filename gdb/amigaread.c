/* Read AmigaHunk (Executable and Linking Format) object files for GDB.

   Copyright (C) 1991-2026 Free Software Foundation, Inc.

   Based on elfread.c written by Fred Fish at Cygnus Support.
   Adapted by Stefan "Bebbo" Franke

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include "defs.h"
#include "bfd.h"
#include "elf/common.h"
#include "elf/internal.h"
#include "symtab.h"
#include "symfile.h"
#include "objfiles.h"
#include "gdb_bfd.h"
#include "arch-utils.h"
#include "gdbtypes.h"
#include "dwarf2/public.h"

/* Debug macro - set to 0 to disable, 1 to enable */
#define DBG_ENABLED 0

#if DBG_ENABLED
#define DBG(fmt, ...) fprintf(stderr, "[amiga-gdb] " fmt "\n", ##__VA_ARGS__)
#else
#define DBG(fmt, ...)
#endif

/* The struct amigainfo is available only during AmigaHunk symbol table and
   psymtab reading.  It is destroyed at the completion of psymtab-reading.
   It's local to amiga_symfile_read.

   DWARF-only: aktuell leer, wird nur für die Signatur von
   amiga_read_minimal_symbols vorgehalten.  */

struct amigainfo
{
  /* intentionally empty for now */
};

/* Provide segment information for AmigaHunk files.

   AmigaHunk kennt keine ELF-Programmheader, GDB erwartet aber
   Segment-Informationen für die Adressabbildung.  Wir erzeugen daher
   künstliche "Segmente" aus den nicht-Debug-Sektionen.  */

static symfile_segment_data_up
amiga_symfile_segments (bfd *abfd)
{
  Elf_Internal_Phdr *phdrs = nullptr, **segments;
  int num_segments = 0;
  int num_sections = 0;
  asection *sect;
  int i, j;

  /* Zähle alle Sektionen und alle "echten" (nicht-Debug) Sektionen.  */
  for (sect = abfd->sections; sect != nullptr; sect = sect->next)
    {
      ++num_sections;
      if ((sect->flags & SEC_DEBUGGING) == 0)
        ++num_segments;
    }

  if (num_segments == 0)
    return nullptr;

  segments = XALLOCAVEC (Elf_Internal_Phdr *, num_segments);

  /* Erzeuge künstliche "Program Header" für jede nicht-Debug-Sektion.  */
  i = 0;
  for (sect = abfd->sections; sect != nullptr; sect = sect->next)
    {
      if ((sect->flags & SEC_DEBUGGING) != 0)
        continue;

      phdrs = segments[i] = XALLOCA (Elf_Internal_Phdr);
      phdrs->p_align  = 4;
      phdrs->p_memsz  = phdrs->p_filesz = sect->size;
      phdrs->p_flags  = SEC_ALLOC | SEC_DEBUGGING;
      phdrs->p_vaddr  = 0;
      phdrs->p_paddr  = 0;
      phdrs->p_offset = 0;
      phdrs->p_type   = PT_LOAD;

      /* VMA/LMA werden später von BFD/GDB passend gesetzt.  */
      sect->vma = sect->lma = 0;

      ++i;
    }

  symfile_segment_data_up data (new symfile_segment_data);
  data->segments.reserve (num_segments);

  for (i = 0; i < num_segments; ++i)
    data->segments.emplace_back (segments[i]->p_vaddr, segments[i]->p_memsz);

  /* segment_info: 1-basiert, 0 = kein Segment.  Wir mappen der Einfachheit
     halber die ersten drei nicht-Debug-Sektionen auf 1=text, 2=data, 3=bss.  */
  data->segment_info.resize (num_sections);

  i = 0;
  j = 0;
  for (sect = abfd->sections; sect != nullptr; sect = sect->next, ++i)
    {
      if ((sect->flags & SEC_DEBUGGING) == 0 && j < 3)
        data->segment_info[i] = ++j;
      else
        data->segment_info[i] = 1;
    }

  return data;
}

/* Helper: record a minimal symbol with section index handling similar to ELF.  */

static struct minimal_symbol *
record_minimal_symbol (minimal_symbol_reader &reader,
                       std::string_view name, bool copy_name,
                       unrelocated_addr address,
                       enum minimal_symbol_type ms_type,
                       asection *bfd_section, struct objfile *objfile)
{
  struct gdbarch *gdbarch = objfile->arch ();

  if (ms_type == mst_text || ms_type == mst_file_text
      || ms_type == mst_text_gnu_ifunc)
    address
      = unrelocated_addr (gdbarch_addr_bits_remove (gdbarch,
                                                    CORE_ADDR (address)));

  /* Wir setzen nur für allocierbare Sektionen einen Section-Index.  */
  int section_index = 0;
  if ((bfd_section_flags (bfd_section) & SEC_ALLOC) == SEC_ALLOC
      || bfd_section == bfd_abs_section_ptr)
    section_index = gdb_bfd_section_index (objfile->obfd.get (), bfd_section);

  return reader.record_full (name, copy_name, address, ms_type, section_index);
}

/* DWARF-only Minimal-Symbol-Leser für AmigaHunk.

   - keine STABS/ECOFF/CTF
   - nur reguläre BFD-Symbole aus .symtab/.dynsym
   - einfache Heuristik: CODE -> text, ALLOC+LOAD -> data, ALLOC+!LOAD -> bss
*/

#define ST_REGULAR   0
#define ST_DYNAMIC   1
#define ST_SYNTHETIC 2

static void
amiga_symtab_read (minimal_symbol_reader &reader,
                   struct objfile *objfile, int type,
                   long number_of_symbols, asymbol **symbol_table,
                   bool copy_names)
{
  struct gdbarch *gdbarch = objfile->arch ();
  asymbol *sym;
  long i;
  CORE_ADDR symaddr;
  enum minimal_symbol_type ms_type;
  const char *filesymname = "";
  int stripped = (bfd_get_symcount (objfile->obfd.get ()) == 0);

  for (i = 0; i < number_of_symbols; ++i)
    {
      sym = symbol_table[i];

      if (sym->name == nullptr || *sym->name == '\0')
        continue;

      /* Keine dynamischen Symbole in nicht-gestrippten Binaries doppelt.  */
      if (type == ST_DYNAMIC && !stripped)
        continue;

      if (sym->flags & BSF_FILE)
        {
          filesymname = objfile->intern (sym->name);
          continue;
        }

      if (sym->flags & BSF_SECTION_SYM)
        continue;

      if (!(sym->flags & (BSF_GLOBAL | BSF_LOCAL | BSF_WEAK | BSF_GNU_UNIQUE)))
        continue;

      if (sym->section == nullptr)
        continue;

      /* BFD-Symbole sind sektionrelativ.  */
      symaddr = sym->value; // + sym->section->vma; // + vma might be wrong

      if (sym->section == bfd_abs_section_ptr)
        {
          ms_type = mst_abs;
        }
      else if (sym->section->flags & SEC_CODE)
        {
          if (sym->flags & (BSF_GLOBAL | BSF_WEAK | BSF_GNU_UNIQUE))
            ms_type = mst_text;
          else
            ms_type = mst_file_text;
        }
      else if (sym->section->flags & SEC_ALLOC)
        {
          if (sym->section->flags & SEC_LOAD)
            {
              if (sym->flags & (BSF_GLOBAL | BSF_WEAK | BSF_GNU_UNIQUE))
                ms_type = mst_data;
              else
                ms_type = mst_file_data;
            }
          else
            {
              if (sym->flags & (BSF_GLOBAL | BSF_WEAK | BSF_GNU_UNIQUE))
                ms_type = mst_bss;
              else
                ms_type = mst_file_bss;
            }
        }
      else
        {
          /* Nicht zuordenbare Symbole ignorieren.  */
          continue;
        }

      struct minimal_symbol *msym
        = record_minimal_symbol (reader, sym->name, copy_names,
                                 unrelocated_addr (symaddr),
                                 ms_type, sym->section, objfile);

      if (msym != nullptr)
        msym->filename = filesymname;
    }

  (void) gdbarch; /* aktuell unbenutzt, aber für spätere Erweiterungen da.  */
}

/* Read minimal symbols for an AmigaHunk BFD.

   DWARF-only Variante:
   - keine STABS
   - keine CTF
   - keine ECOFF
   - nur reguläre BFD-Symbole aus .symtab/.dynsym
*/

static void
amiga_read_minimal_symbols (struct objfile *objfile,
                            symfile_add_flags symfile_flags,
                            struct amigainfo *ei)
{
  bfd *abfd = objfile->obfd.get ();
  (void) ei; /* derzeit unbenutzt, Signatur bleibt stabil.  */

  minimal_symbol_reader reader (objfile);

  long symcount = bfd_get_symcount (abfd);
  if (symcount <= 0)
    {
      reader.install ();
      return;
    }

  long size = symcount * sizeof (asymbol *);
  gdb::unique_xmalloc_ptr<asymbol *> syms
    ((asymbol **) xmalloc (size));

  long got = bfd_canonicalize_symtab (abfd, syms.get ());
  if (got <= 0)
    {
      reader.install ();
      return;
    }

  amiga_symtab_read (reader, objfile, ST_REGULAR,
                     got, syms.get (), true);

  reader.install ();
}

/* Helper: create a DWARF section from the .dwarf2 container. */

static asection *
amiga_make_dwarf_section (bfd *abfd,
                          const char *name,
                          const bfd_byte *base,
                          bfd_vma offset,
                          bfd_size_type size)
{
    DBG("amiga_make_dwarf_section: %s size=%ld offset=%ld",
        name, (long)size, (long)offset);

    if (size == 0)
      {
        DBG("  skipping zero-length section %s", name);
        return NULL;
      }

    asection *sec =
        bfd_make_section_anyway_with_flags (abfd, name,
                                            SEC_DEBUGGING
                                            | SEC_HAS_CONTENTS
                                            | SEC_READONLY
                                            | SEC_IN_MEMORY);
    if (!sec)
      {
        DBG("  ERROR: failed to create section %s", name);
        return NULL;
      }

    /* Immer bfd_alloc verwenden */
    bfd_byte *contents = (bfd_byte *) bfd_alloc (abfd, size);
    if (!contents)
      {
        DBG("  ERROR: failed to allocate %ld bytes for %s",
            (long)size, name);
        return NULL;
      }

    memcpy(contents, base + offset, size);
    bfd_set_section_size (sec, size);
    sec->contents = contents;
    sec->vma = 0;
    sec->lma = 0;

    DBG("  created section %s (size=%ld)", name, (long)size);
    return sec;
}

/* 
 * Aus der vom Linker erzeugten .dwarf2-Section echte .debug_*-Sections bauen.
 * 
 * Die Reihenfolge muss exakt der in amigaos.c (debug_names[]) und der
 * Linker-Script-Reihenfolge entsprechen.
 */
static bool
amiga_split_dwarf2_section (struct objfile *objfile)
{
  bfd *abfd = objfile->obfd.get ();
  const char *dname = ".dwarf2";

  asection *dsect = bfd_get_section_by_name (abfd, dname);
  if (!dsect)
    {
      DBG("amiga_split_dwarf2_section: no .dwarf2 section found");
      return false;
    }

  bfd_size_type total = bfd_section_size (dsect);
  DBG("amiga_split_dwarf2_section: .dwarf2 size=%ld", (long)total);

  if (total < 4)
    {
      DBG("  .dwarf2 too small (%ld), skipping", (long)total);
      return false;
    }

  /* Container einlesen */
  gdb::unique_xmalloc_ptr<bfd_byte> buf
    ((bfd_byte *) xmalloc (total));

  if (!bfd_get_section_contents (abfd, dsect, buf.get (), 0, total))
    {
      DBG("  ERROR: failed to read .dwarf2 section");
      return false;
    }

  /* 
   * Reihenfolge fix wie im Linker und in amigaos.c.
   * MUSS mit debug_names[] in amigaos.c übereinstimmen!
   */
  static const char *debug_names[] =
  {
    ".debug_frame",
    ".debug_info",
    ".debug_abbrev",
    ".debug_loclists",
    ".debug_aranges",
    ".debug_rnglists",
    ".debug_line",
    ".debug_str",
    ".debug_line_str",
    ".debug_types",
    ".debug_macro",
    ".debug_ranges",
    ".debug_addr",
    ".debug_str_offsets",
    NULL
  };

  bfd_size_type pos = 0;
  int section_count = 0;

  for (int i = 0; debug_names[i]; ++i)
    {
      if (pos + 4 > total)
        {
          DBG("  WARNING: reached end of .dwarf2 at section %s (pos=%ld, total=%ld)",
              debug_names[i], (long)pos, (long)total);
          break;
        }

      /* Länge lesen */
      bfd_size_type len = bfd_getb32 (buf.get () + pos);
      bfd_size_type payload = pos + 4;

      DBG("  section [%d]: %s len=%ld at pos=%ld",
          i, debug_names[i], (long)len, (long)pos);

      if (len > 0)
        {
          if (payload + len > total)
            {
              DBG("    WARNING: payload overflows .dwarf2 (payload+len=%ld, total=%ld)",
                  (long)(payload + len), (long)total);
              /* Try to recover: if we're near the end, use remaining data */
              if (payload < total)
                {
                  bfd_size_type remaining = total - payload;
                  DBG("    using remaining %ld bytes", (long)remaining);
                  len = remaining;
                }
              else
                {
                  break;
                }
            }

          /* Section erzeugen */
          asection *sec = amiga_make_dwarf_section (abfd,
                                                    debug_names[i],
                                                    buf.get (),
                                                    payload,
                                                    len);
          if (sec)
            section_count++;
        }
      else
        {
          DBG("    zero length, skipping");
        }

      /* Nächsten Block finden (4-byte aligned) */
      pos = payload + len;
      pos = (pos + 3) & ~ (bfd_size_type) 3;
    }

  DBG("amiga_split_dwarf2_section: created %d DWARF sections", section_count);

  /* Section-Offsets neu berechnen */
  objfile->section_offsets.resize
    (gdb_bfd_count_sections (objfile->obfd.get ()));

  return (section_count > 0);
}

/* Haupt-Einstieg: Symbole aus einem AmigaHunk-Objekt lesen.

   DWARF2-Debug-Information wird über den generischen DWARF2-Reader
   verarbeitet; AmigaHunk liefert nur noch DWARF2 (keine STABS/ECOFF/CTF).  */

static void
amiga_symfile_read (struct objfile *objfile, symfile_add_flags symfile_flags)
{
  struct amigainfo ei {};

  DBG("amiga_symfile_read: %s", objfile->original_name);

  /* Minimale Symbole (dynsym/symtab) lesen.  */
  amiga_read_minimal_symbols (objfile, symfile_flags, &ei);

  /* DWARF aus der vom Linker erzeugten .dwarf2-Section in echte .debug_*-Sections splitten. */
  if (amiga_split_dwarf2_section (objfile))
    {
      DBG("  initializing DWARF2");
      dwarf2_initialize_objfile (objfile);
    }
  else
    {
      DBG("  no DWARF2 found");
    }
}

static void
amiga_symfile_init(struct objfile *objfile) {
  DBG("amiga_symfile_init: %s", objfile->original_name);
}

/* Symfile-Callbacks für AmigaHunk.  */

static const struct sym_fns amiga_sym_fns =
{
  amiga_symfile_init,
  amiga_symfile_read,       /* sym_read */
  default_symfile_offsets,    /* sym_offsets (unused) */
  amiga_symfile_segments,   /* sym_segments */
  nullptr,                  /* sym_relocate (unused) */
  nullptr                   /* sym_read_linetable (unused) */
};

/* Registrierung beim Start.  */

extern const bfd_target amiga_vec;

INIT_GDB_FILE (amigaread)
{
  add_symtab_fns (bfd_target_amiga_flavour, &amiga_sym_fns);
}