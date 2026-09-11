"""RISC OS Shell SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_shell.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def create() -> None:
    """Shell_Create (SWI &405C0). See PRM 3-328."""
    _ = external_call["Shell_Create", Int32]()
