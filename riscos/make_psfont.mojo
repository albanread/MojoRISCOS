"""RISC OS MakePSFont SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_make_psfont.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def make_font() -> None:
    """MakePSFont_MakeFont (SWI &43440). See PRM 3-742."""
    _ = external_call["MakePSFont_MakeFont", Int32]()
