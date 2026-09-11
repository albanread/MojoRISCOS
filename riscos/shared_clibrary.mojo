"""RISC OS SharedCLibrary SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_shared_clibrary.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def lib_init_apcs_a() -> None:
    """SharedCLibrary_LibInitAPCS_A (SWI &80680). See PRM 4-262."""
    _ = external_call["SharedCLibrary_LibInitAPCS_A", Int32]()

def lib_init_apcs_r() -> None:
    """SharedCLibrary_LibInitAPCS_R (SWI &80681). See PRM 4-264."""
    _ = external_call["SharedCLibrary_LibInitAPCS_R", Int32]()
