"""RISC OS FPEmulator SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_fpemulator.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def version() -> Int32:
    """FPEmulator_Version (SWI &40480). See PRM 4-190."""
    return external_call["FPEmulator_Version", Int32]()
