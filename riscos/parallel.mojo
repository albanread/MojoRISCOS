"""RISC OS Parallel SWI bindings — generated from the PRM.

Bindings call C shims named exactly like their SWIs, generated
into rostrt/swis_parallel.c (see gen_riscos_pkg.py).
"""

from std.ffi import external_call

def hardware_address() -> None:
    """Parallel_HardwareAddress (SWI &42EC0). See PRM 2-489."""
    _ = external_call["Parallel_HardwareAddress", Int32]()
