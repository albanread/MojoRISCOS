"""RISC OS DrawFile SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_draw_file.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def declare_fonts() -> None:
    """DrawFile_DeclareFonts (SWI &45542). See PRM 5a-530."""
    _ = external_call["DrawFile_DeclareFonts", Int32]()
